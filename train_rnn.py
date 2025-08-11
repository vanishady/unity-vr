import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import DataLoader, random_split
from model import OscControlRNN

# Config
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
batch_size = 32
learning_rate = 0.001
num_epochs = 20
dataset_path = "osc_control_dataset.pt"

# Carica dataset salvato
full_dataset = torch.load(dataset_path)
N = len(full_dataset)
train_size = int(0.8 * N)
val_size = int(0.1 * N)
test_size = N - train_size - val_size

train_dataset, val_dataset, test_dataset = random_split(full_dataset, [train_size, val_size, test_size])

train_loader = DataLoader(train_dataset, batch_size=batch_size, shuffle=True)
val_loader   = DataLoader(val_dataset, batch_size=batch_size)
test_loader  = DataLoader(test_dataset, batch_size=batch_size)

# Inizializza modello
model = OscControlRNN(input_size=1).to(device)
criterion = nn.MSELoss()
optimizer = optim.Adam(model.parameters(), lr=learning_rate)

# Training loop
for epoch in range(num_epochs):
    model.train()
    train_loss = 0.0
    for x_batch, y_batch in train_loader:
        x_batch = x_batch.to(device)
        y_batch = y_batch.to(device)

        optimizer.zero_grad()
        output, _ = model(x_batch)
        loss = criterion(output, y_batch)
        loss.backward()
        optimizer.step()
        train_loss += loss.item()

    # Validation
    model.eval()
    val_loss = 0.0
    with torch.no_grad():
        for x_val, y_val in val_loader:
            x_val = x_val.to(device)
            y_val = y_val.to(device)
            output, _ = model(x_val)
            loss = criterion(output, y_val)
            val_loss += loss.item()

    print(f"Epoch {epoch+1}/{num_epochs} | Train Loss: {train_loss/len(train_loader):.4f} | Val Loss: {val_loss/len(val_loader):.4f}")

# Valutazione finale sul test set
model.eval()
test_loss = 0.0
with torch.no_grad():
    for x_test, y_test in test_loader:
        x_test = x_test.to(device)
        y_test = y_test.to(device)
        output, _ = model(x_test)
        loss = criterion(output, y_test)
        test_loss += loss.item()

print(f"\n Test Loss finale: {test_loss / len(test_loader):.4f}")

# Salvataggio modello
torch.save(model.state_dict(), "osc_control_rnn.pth")
print("Modello salvato in 'osc_control_rnn.pth'")
