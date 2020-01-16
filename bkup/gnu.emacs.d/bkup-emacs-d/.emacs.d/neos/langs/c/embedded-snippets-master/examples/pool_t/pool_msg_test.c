/*
 * Copyright (c) 2013 Francesco Balducci
 *
 * This file is part of embedded-snippets.
 *
 *    embedded-snippets is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU Lesser General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    embedded-snippets is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU Lesser General Public License for more details.
 *
 *    You should have received a copy of the GNU Lesser General Public License
 *    along with embedded-snippets.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <stdio.h>

#include "pool_msg.h"

#define N_MSGS 10

int main(void) {
    struct pool_msg *p;
    struct msg *m;
    
    p = pool_msg_alloc(N_MSGS);

    do
    {
        int ret;
        m = pool_msg_reserve(p);
        printf("m = %p\n", m);
        m = pool_msg_reserve(p);
        printf("m = %p\n", m);
        ret = pool_msg_release(p, m);
        printf("release: %d\n", ret);
    } while(m != NULL);

    pool_msg_free(p);

	return 0;
}

