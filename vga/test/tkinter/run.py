from pathlib import Path
import ctypes

from io import BytesIO

import numpy as np
from PIL import Image, ImageTk
from tkinter import Tk, Label

from utils import dlopen, dlclose, enc_args, FUNCTYPE


root = Tk()
root.title("[DBHI/vboard] VGA screen")
panel = Label(root, bd=0)
panel.pack()


def save_screenshot(img, width, height, id):
    print("  Python save_screenshot:", img, width, height, id)
    image = Image.fromarray(np.ctypeslib.as_array(img, shape=(height, width)))
    image.mode = 'RGBA'

    # TODO: passing 'image' to panel.image should be possible without writting to an intermediate buffer
    buf = BytesIO()
    image.save(buf, format="PNG")

    pimg = ImageTk.PhotoImage(Image.open(buf))
    panel.configure(image=pimg)
    panel.image = pimg
    root.update()


def sim_cleanup():
    print("  Python sim_cleanup!")


def run_sim():
    C_SAVE_SCREENSHOT = FUNCTYPE(
        None,
        ctypes.POINTER(ctypes.c_int),
        ctypes.c_uint,
        ctypes.c_uint,
        ctypes.c_int
    )(save_screenshot)

    C_SIM_CLEANUP = FUNCTYPE(
        None
    )(sim_cleanup)

    # TODO pass argv to GHDL
    C_ARGS = enc_args([str(Path(__file__))])

    CAUXDLL = dlopen("./caux.so")

    print("> pymain")
    print(CAUXDLL.py_main(len(C_ARGS), C_ARGS, C_SAVE_SCREENSHOT, C_SIM_CLEANUP))

    dlclose(CAUXDLL)


root.after(0, run_sim)
root.mainloop()
