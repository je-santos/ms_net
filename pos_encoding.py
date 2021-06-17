import numpy as np
import matplotlib.pyplot as plt


def positional_encoding(max_position, d_model, min_freq=1e-4):
    position = np.arange(max_position)
    freqs = min_freq ** (2 * (np.arange(d_model) // 2) / d_model)
    pos_enc = position.reshape(-1, 1) * freqs.reshape(1, -1)
    pos_enc[:, ::2] = np.cos(pos_enc[:, ::2])
    pos_enc[:, 1::2] = np.sin(pos_enc[:, 1::2])
    return pos_enc


def n_dim_pos_enc(max_position, d_model, dims, min_freq=1e-4):
    if d_model % (len(dims) * 2) != 0:
        raise ValueError(
            "Cannot use sin/cos positional encoding with "
            "odd dimension (got dim={:d})".format(d_model)
        )

    d_model = 64 * 2
    dims = [10, 10]
    pos_enc_n = np.zeros((d_model, *dims))
    d_model = d_model // len(dims)

    pos_enc = []
    for i, dim_size in enumerate(dims):
        position = np.arange(dim_size)
        freqs = min_freq ** (2 * (np.arange(d_model) // 2) / d_model)
        pos_enc_1D = position.reshape(-1, 1) * freqs.reshape(1, -1)
        pos_enc_1D[:, ::2] = np.cos(pos_enc_1D[:, ::2])
        pos_enc_1D[:, 1::2] = np.sin(pos_enc_1D[:, 1::2])
        pos_enc.append(pos_enc_1D)

    for i, enc in enumerate(pos_enc):
        pos_enc_n[(d_model * 2) * i : (d_model * 2) * (i + 1) :, :] = np.repeat(
            pos_enc[i], dims[i], axis=0
        ).reshape(d_model * 2, *dims)

    # pos_enc = np.concatenate(pos_enc, axis=1)


# test with 2 dims
# max_position = 100


### Plotting ####
d_model = 128
max_pos = 256
mat = positional_encoding(max_pos, d_model)
plt.pcolormesh(mat, cmap="copper")
plt.xlabel("Depth")
plt.xlim((0, d_model))
plt.ylabel("Position")
plt.title("PE matrix heat map")
plt.colorbar()
plt.show()
