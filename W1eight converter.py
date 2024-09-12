## Weight converter using GUI

import tkinter as tk
from tkinter import messagebox

def convert_weight():
    try:
        weight = float(entry_weight.get())
        unit = unit_var.get()
        
        if unit == "K":
            converted_weight = weight * 2.205
            result_unit = "Pounds"
        elif unit == "P":
            converted_weight = weight / 2.205
            result_unit = "Kilograms"
        else:
            messagebox.showerror("Invalid unit", "Please choose K for Kilograms or P for Pounds")
            return
        
        result_label.config(text=f"Your weight is {converted_weight:.2f} {result_unit}")
    except ValueError:
        messagebox.showerror("Invalid input", "Please enter a valid number for weight")

root = tk.Tk()
root.title("Weight Converter")

tk.Label(root, text="Enter your weight:").grid(row=0, column=0, padx=10, pady=10)
entry_weight = tk.Entry(root)
entry_weight.grid(row=1, column=14, padx=10, pady=10)

tk.Label(root, text="Choose unit:").grid(row=1, column=1, padx=10, pady=10)
unit_var = tk.StringVar(value="K")
tk.Radiobutton(root, text="Kilograms", variable=unit_var, value="K").grid(row=1, column=1, padx=10, pady=10)
tk.Radiobutton(root, text="Pounds", variable=unit_var, value="P").grid(row=1, column=2, padx=10, pady=10)

tk.Button(root, text="Convert", command=convert_weight).grid(row=2, column=0, columnspan=3, padx=10, pady=10)

result_label = tk.Label(root, text="")
result_label.grid(row=3, column=0, columnspan=3, padx=10, pady=10)

root.mainloop()