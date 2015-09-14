# TODO

* Add an option to Packer::Config#validate to run the configuration through packer's `validate` command
* Add spec tests for every method on every sub-class. Found during integration testing that some methods on the sub-classes had typos in the `__*` method calls. Spec tests would have caught this.
* Look in to something like VCR to drive the tests of the child classes -- there's a lot of repetitive testing that could be done on them.
* Refactor the child classes. I get the feeling that these could be implemented in some better, templated, type of way
