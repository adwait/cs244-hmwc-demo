

from pycaliper.per import *
from pycaliper.verif.jgverifier import JGVerifier1TraceBMC
from pycaliper.pycmanager import setup_all, PYCArgs

class simple_state_machine(SpecModule):

    def __init__(self):
        super().__init__()
        self.current_state = Logic(2)
        self.next_state = Logic(2)
        self.reset = Logic(1)

    @unroll(4)
    def cyclic_spec(self, i: int):
        self.pycassume(~self.reset)

        if i == 0:
            self.pycassume(self.current_state == Const(0, 2))
        elif i == 1:
            self.pycassert(self.current_state == Const(1, 2))



if __name__ == "__main__":
    # Create an instance of the simple_state_machine class
    sm = simple_state_machine()

    is_conn, pyconfig, tmgr = setup_all(PYCArgs(
        jgcpath="config.json"
    ))

    verifier = JGVerifier1TraceBMC()
    res = verifier.verify(sm.instantiate(), pyconfig, "cyclic_spec")
    for i, r in enumerate(res):
        print(f"Step {i}: {r}")


        


