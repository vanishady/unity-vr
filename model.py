import torch
import torch.nn as nn

class OscControlRNN(nn.Module):
    """
        Input shape: [10, 1]
        Output shape: [10, 6]
    """
    def __init__(self, input_size=1, hidden_size=64, output_size=6, num_layers=1):
        super(OscControlRNN, self).__init__()
        self.hidden_size = hidden_size
        self.num_layers = num_layers
        self.rnn = nn.GRU(input_size, hidden_size, num_layers, batch_first=True)
        self.fc1 = nn.Linear(hidden_size, 64)
        self.fc2 = nn.Linear(64, 32)
        self.fc3 = nn.Linear(32, output_size)
        self.relu = nn.ReLU()
        self.sigmoid = nn.Sigmoid()

    def forward(self, x, h=None):
        if h is None:
            h = torch.zeros(self.num_layers, x.size(0), self.hidden_size).to(x.device)
        out, h = self.rnn(x, h)
        out = self.relu(self.fc1(out))
        out = self.relu(self.fc2(out))
        out = self.sigmoid(self.fc3(out))
        return out, h
