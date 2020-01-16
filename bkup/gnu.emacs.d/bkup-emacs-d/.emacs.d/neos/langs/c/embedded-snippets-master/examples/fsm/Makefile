#
# Copyright (c) 2013 Francesco Balducci
#
# This file is part of embedded-snippets.
#
#    embedded-snippets is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    embedded-snippets is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with embedded-snippets.  If not, see <http://www.gnu.org/licenses/>.
#

ES_ROOT = ../../

CFLAGS += -I$(ES_ROOT)include/fsm/

fsm_test: fsm_test.o $(ES_ROOT)src/fsm/fsm.o

fsm_test.o: $(ES_ROOT)include/fsm/fsm.h

$(ES_ROOT)src/fsm/fsm.o: $(ES_ROOT)include/fsm/fsm.h

clean:
	rm -rf $(ES_ROOT)src/fsm/fsm.o fsm_test.o fsm_test

