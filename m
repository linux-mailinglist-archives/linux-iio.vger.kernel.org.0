Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B8E326E82
	for <lists+linux-iio@lfdr.de>; Sat, 27 Feb 2021 18:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhB0Rzx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Feb 2021 12:55:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:57144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230235AbhB0Rxm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Feb 2021 12:53:42 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5226964E46;
        Sat, 27 Feb 2021 17:53:00 +0000 (UTC)
Date:   Sat, 27 Feb 2021 17:52:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>
Subject: Re: [PATCH v4 0/6] iio: core: Add mmap interface infrastructure
Message-ID: <20210227175256.021b8542@archlinux>
In-Reply-To: <20210218131045.1a34d0a1@archlinux>
References: <20210217073638.21681-1-alexandru.ardelean@analog.com>
        <20210218131045.1a34d0a1@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Feb 2021 13:10:45 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 17 Feb 2021 09:36:32 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> 
> Dropped v3 and applied v4 to the togreg branch of iio.git and pushed
> it out as testing for the autobuilders to poke at it and see what
> else they can find :)
> 
> Jonathan

Following an off list discussion, I've dropped this series for now as more
time is needed to consider if the approach is the right way to go.

Jonathan

> 
> 
> > Changelog v3 -> v4:
> > * https://lore.kernel.org/linux-iio/20210215143234.3248-5-alexandru.ardelean@analog.com/T/
> > * added patch 'iio: buffer-dma: reduce the type of block.size to u32'
> >   - resolves error on 64 bit archs; 32 bit block size should be enough
> > * in patch 'iio: buffer-dma: Add mmap support'
> >   - added 'linux/types.h' include in uapi buffer.h header; an error
> >     shows up when building with 'make allmodconfig'
> > * in patch 'tools: iio: add example for high-speed buffer support'
> >   - calling ioctl(BOCK_FREE) only if use_high_speed is true
> > 
> > Changelog v2 -> v3:
> > * https://lore.kernel.org/linux-iio/20210212101143.18993-1-alexandru.ardelean@analog.com/T/#u
> > * added 'Documentation: iio: add doc for high-speed buffer API'
> > * add 'iio: buffer-dma: split iio_dma_buffer_fileio_free() function'
> > * patch 'iio: buffer-dma: Add mmap support'
> >    - unwind free on error path in iio_dma_buffer_alloc_blocks()
> >    - removed double mm.h include
> > * patch 'tools: iio: add example for high-speed buffer support'
> >    - call IIO_BUFFER_BLOCK_FREE_IOCTL on the error path of the
> >      enable_high_speed() function
> > 
> > Changelog v1 -> v2:
> > * https://lore.kernel.org/linux-iio/20210211123353.78963-1-alexandru.ardelean@analog.com/T/#t
> > * removed IIO_BUFFER_BLOCK_FLAG_CYCLIC flag; will be added in a later
> >   patch
> > * removed extra line in tools/iio/iio_generic_buffer.c
> > * patch 'iio: core: Add mmap interface infrastructure'
> >   added docstrings for new hooks (alloc_blocks, mmap, etc)
> > 
> > This is basically Lars' work adapted from branch:
> >   https://github.com/larsclausen/linux/commits/iio-high-speed-5.10
> > [hopefully i got the stuff correctly from that branch]
> > 
> > What is different, is that this one is adapted on top of the multibuffer
> > support (currently at v5) discussed here:
> >   https://lore.kernel.org/linux-iio/20210211122452.78106-1-alexandru.ardelean@analog.com/T/#t
> > 
> > Also, adapted an example for high-speed/mmap support in
> > 'tools/iio/iio_generic_buffer.c'
> > 
> > The example is adapted from libiio:
> >   https://github.com/analogdevicesinc/libiio/blob/master/local.c#L51
> > but will all the ioctl()s organized after the one that are reserved
> > (hopefully) for IIO
> > 
> > Tested that mmap() works.
> > Moved (artifically) valid buffer0 as buffer2 and the operation still
> > works.
> > 
> > Alexandru Ardelean (4):
> >   Documentation: iio: add doc for high-speed buffer API
> >   iio: buffer-dma: split iio_dma_buffer_fileio_free() function
> >   iio: buffer-dma: reduce the type of block.size to u32
> >   tools: iio: add example for high-speed buffer support
> > 
> > Lars-Peter Clausen (2):
> >   iio: core: Add mmap interface infrastructure
> >   iio: buffer-dma: Add mmap support
> > 
> >  Documentation/iio/iio_high_speed_buffers.rst  | 100 ++++++
> >  Documentation/iio/index.rst                   |   2 +
> >  drivers/iio/buffer/industrialio-buffer-dma.c  | 324 ++++++++++++++++--
> >  .../buffer/industrialio-buffer-dmaengine.c    |  28 +-
> >  drivers/iio/industrialio-buffer.c             | 158 +++++++++
> >  include/linux/iio/buffer-dma.h                |  27 +-
> >  include/linux/iio/buffer_impl.h               |  23 ++
> >  include/uapi/linux/iio/buffer.h               |  51 +++
> >  tools/iio/iio_generic_buffer.c                | 185 +++++++++-
> >  9 files changed, 847 insertions(+), 51 deletions(-)
> >  create mode 100644 Documentation/iio/iio_high_speed_buffers.rst
> >   
> 

