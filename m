Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CC331D154
	for <lists+linux-iio@lfdr.de>; Tue, 16 Feb 2021 21:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhBPUBM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 16 Feb 2021 15:01:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhBPUBL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Feb 2021 15:01:11 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94BEA614A7;
        Tue, 16 Feb 2021 20:00:29 +0000 (UTC)
Date:   Tue, 16 Feb 2021 20:00:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>
Subject: Re: [PATCH v3 0/5] iio: core: Add mmap interface infrastructure
Message-ID: <20210216200023.6e4dcde9@archlinux>
In-Reply-To: <20210215143234.3248-1-alexandru.ardelean@analog.com>
References: <20210215143234.3248-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Feb 2021 16:32:29 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:


Hi Alex,

I'm a little nervous about adding the userspace interface used in this
series, but it seems reasonable and as you say below, is close to what
Analog have been using for years.

So I've applied it to the togreg branch of iio.git and pushed out as
testing as normal.   I'm not going to push that out as anything I can't
rebase for at least a few weeks, so if anyone else wants to take a look
that would be great.  

One slight tweak was needed. I forced it with min_t(size_t,...
as it should always be at least as bit as __u32 so should be fine.

  CHECK   drivers/iio/industrialio-core.c
In file included from ./include/linux/kernel.h:14,
                 from ./include/asm-generic/bug.h:20,
                 from ./arch/x86/include/asm/bug.h:93,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/mmdebug.h:5,
                 from ./include/linux/gfp.h:5,
                 from ./include/linux/slab.h:15,
                 from drivers/iio/buffer/industrialio-buffer-dmaengine.c:7:
drivers/iio/buffer/industrialio-buffer-dmaengine.c: In function ‘iio_dmaengine_buffer_submit_block’:
./include/linux/minmax.h:18:28: warning: comparison of distinct pointer types lacks a cast
   18 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1))) 
      |                            ^~
./include/linux/minmax.h:32:4: note: in expansion of macro ‘__typecheck’
   32 |   (__typecheck(x, y) && __no_side_effects(x, y))
      |    ^~~~~~~~~~~
./include/linux/minmax.h:42:24: note: in expansion of macro ‘__safe_cmp’
   42 |  __builtin_choose_expr(__safe_cmp(x, y), \
      |                        ^~~~~~~~~~
./include/linux/minmax.h:51:19: note: in expansion of macro ‘__careful_cmp’
   51 | #define min(x, y) __careful_cmp(x, y, <)
      |                   ^~~~~~~~~~~~~
drivers/iio/buffer/industrialio-buffer-dmaengine.c:69:28: note: in expansion of macro ‘min’
   69 |  block->block.bytes_used = min(block->block.size,
      |                            ^~~
  CHECK   drivers/iio/buffer/industrialio-buffer-dmaengine.c
  CHECK   drivers/iio/industrialio-buffer.c
drivers/iio/buffer/industrialio-buffer-dmaengine.c:69:35: error: incompatible types in comparison expression (different type sizes):
drivers/iio/buffer/industrialio-buffer-dmaengine.c:69:35:    unsigned int *
drivers/iio/buffer/industrialio-buffer-dmaengine.c:69:35:    unsigned long *

Thanks,

Jonathan
 

> Changelog v2 -> v3:
> * https://lore.kernel.org/linux-iio/20210212101143.18993-1-alexandru.ardelean@analog.com/T/#u
> * added 'Documentation: iio: add doc for high-speed buffer API'
> * add 'iio: buffer-dma: split iio_dma_buffer_fileio_free() function'
> * patch 'iio: buffer-dma: Add mmap support'
>    - unwind free on error path in iio_dma_buffer_alloc_blocks()
>    - removed double mm.h include
> * patch 'tools: iio: add example for high-speed buffer support'
>    - call IIO_BUFFER_BLOCK_FREE_IOCTL on the error path of the
>      enable_high_speed() function
> 
> Changelog v1 -> v2:
> * https://lore.kernel.org/linux-iio/20210211123353.78963-1-alexandru.ardelean@analog.com/T/#t
> * removed IIO_BUFFER_BLOCK_FLAG_CYCLIC flag; will be added in a later
>   patch
> * removed extra line in tools/iio/iio_generic_buffer.c
> * patch 'iio: core: Add mmap interface infrastructure'
>   added docstrings for new hooks (alloc_blocks, mmap, etc)
> 
> This is basically Lars' work adapted from branch:
>   https://github.com/larsclausen/linux/commits/iio-high-speed-5.10
> [hopefully i got the stuff correctly from that branch]
> 
> What is different, is that this one is adapted on top of the multibuffer
> support (currently at v5) discussed here:
>   https://lore.kernel.org/linux-iio/20210211122452.78106-1-alexandru.ardelean@analog.com/T/#t
> 
> Also, adapted an example for high-speed/mmap support in
> 'tools/iio/iio_generic_buffer.c'
> 
> The example is adapted from libiio:
>   https://github.com/analogdevicesinc/libiio/blob/master/local.c#L51
> but will all the ioctl()s organized after the one that are reserved
> (hopefully) for IIO
> 
> Tested that mmap() works.
> Moved (artifically) valid buffer0 as buffer2 and the operation still
> works.
> 
> Alexandru Ardelean (3):
>   Documentation: iio: add doc for high-speed buffer API
>   iio: buffer-dma: split iio_dma_buffer_fileio_free() function
>   tools: iio: add example for high-speed buffer support
> 
> Lars-Peter Clausen (2):
>   iio: core: Add mmap interface infrastructure
>   iio: buffer-dma: Add mmap support
> 
>  Documentation/iio/iio_high_speed_buffers.rst  | 100 ++++++
>  Documentation/iio/index.rst                   |   2 +
>  drivers/iio/buffer/industrialio-buffer-dma.c  | 324 ++++++++++++++++--
>  .../buffer/industrialio-buffer-dmaengine.c    |  22 +-
>  drivers/iio/industrialio-buffer.c             | 158 +++++++++
>  include/linux/iio/buffer-dma.h                |  27 +-
>  include/linux/iio/buffer_impl.h               |  23 ++
>  include/uapi/linux/iio/buffer.h               |  49 +++
>  tools/iio/iio_generic_buffer.c                | 184 +++++++++-
>  9 files changed, 841 insertions(+), 48 deletions(-)
>  create mode 100644 Documentation/iio/iio_high_speed_buffers.rst
> 

