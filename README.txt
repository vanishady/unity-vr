generate_dataset.py ->  genera dataset fittizio
			osc_control_dataset.pt

model.py
train_rnn.py	    ->  train del modello
			osc_control_rnn.pth

generate_params.py  ->  genera sequenza di input fittizia
			predict control parameters 
			send predicted parameters to sc (supercollider/listener.scd)


Come runnare il progetto:
assicurati di aver già runnato generate_dataset.py e avere osc_control_dataset.pt
assicurati di aver già runnato train_rnn.py e avere osc_control_rnn.pth

avvia python generate_params.py
avvia supercollider listener.sc 
avvia unity 