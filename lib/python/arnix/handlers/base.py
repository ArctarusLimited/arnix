from arnix.machine import Machine

class BaseHandler():
    def run(self, machine: Machine):
        raise NotImplementedError()
