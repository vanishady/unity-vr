import numpy as np
import torch
from torch.utils.data import TensorDataset

def generate_approach_sequence(seq_len=10):
    """
    Player towards danger point. 
    Input: vector of distances (decreasing) -> len 10
    Output: vector of parameters -> len 6
    """
    start = np.random.uniform(0.6, 1.0)
    end = np.random.uniform(0.0, 0.4)
    distance = np.linspace(start, end, seq_len) # one vector of distances e.g. [0.8, 0.7, 0.6, ..., 0.1]

    # Tensione crescente 
    proximity_score = 1 - distance
    tension = (0.7 * proximity_score).clip(0, 1)

    target_seq = np.stack([
        tension,                                                # timbre
        tension * 0.9 + np.random.normal(0, 0.01, seq_len),     # dissonance
        tension * 0.8 + np.random.normal(0, 0.01, seq_len),     # unison
        tension * 0.7 + np.random.normal(0, 0.01, seq_len),     # reverb_depth
        tension * 0.6 + np.random.normal(0, 0.01, seq_len),     # cutoff
        tension * 1.0 + np.random.normal(0, 0.01, seq_len),     # intensity
    ], axis=1).clip(0, 1)

    return distance.astype(np.float32), target_seq.astype(np.float32)


def generate_retreat_sequence(seq_len=10):
    """
    Player getting away from danger point. 
    Input: vector of distances (increasing) -> len 10
    Output: vector of parameters -> len 6
    """
    start = np.random.uniform(0.0, 0.4)
    end = np.random.uniform(0.6, 1.0)
    distance = np.linspace(start, end, seq_len)

    # Tensione DECRESCENTE (massima all'inizio, si rilassa)
    proximity_score = 1 - distance
    tension = (0.7 * proximity_score).clip(0, 1)

    target_seq = np.stack([
        tension,
        tension * 0.9 + np.random.normal(0, 0.01, seq_len),
        tension * 0.8 + np.random.normal(0, 0.01, seq_len),
        tension * 0.7 + np.random.normal(0, 0.01, seq_len),
        tension * 0.6 + np.random.normal(0, 0.01, seq_len),
        tension * 1.0 + np.random.normal(0, 0.01, seq_len),
    ], axis=1).clip(0, 1)

    return distance.astype(np.float32), target_seq.astype(np.float32)


def create_dataset(num_samples=1000, seq_len=10):
    """
    Genera un dataset bilanciato: metà sequenze di avvicinamento, metà di allontanamento.
    """
    inputs, targets = [], []

    for _ in range(num_samples // 2):
        x_inputs, x_targets = generate_approach_sequence(seq_len)
        y_inputs, y_targets = generate_retreat_sequence(seq_len)
        inputs.extend([x_inputs, y_inputs])
        targets.extend([x_targets, y_targets])

    inputs = torch.tensor(inputs).unsqueeze(-1)    # [N, 10] → [N, 10, 1]
    targets = torch.tensor(targets)                # [N, 10, 6]
    return TensorDataset(inputs, targets)

if __name__ == "__main__":
    dataset = create_dataset(num_samples=10000, seq_len=10)
    torch.save(dataset, "osc_control_dataset.pt")
    print("Dataset bilanciato salvato come 'osc_control_dataset.pt")
