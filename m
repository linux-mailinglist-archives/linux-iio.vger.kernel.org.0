Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A935B31B0EF
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 16:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhBNPYm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 10:24:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhBNPYl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 10:24:41 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 699B564E56;
        Sun, 14 Feb 2021 15:23:57 +0000 (UTC)
Date:   Sun, 14 Feb 2021 15:23:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Subject: Re: [PATCH v2 1/3] iio: core: Add mmap interface infrastructure
Message-ID: <20210214152353.2cad803b@archlinux>
In-Reply-To: <CA+U=Dsoq9XF2ACEyLAYapDdwZ2dDyfK5iPS-SGhP2Uf5R9uCdw@mail.gmail.com>
References: <20210212101143.18993-1-alexandru.ardelean@analog.com>
        <20210212101143.18993-2-alexandru.ardelean@analog.com>
        <CA+U=Dsoq9XF2ACEyLAYapDdwZ2dDyfK5iPS-SGhP2Uf5R9uCdw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Feb 2021 12:21:37 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Fri, Feb 12, 2021 at 12:12 PM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
> > From: Lars-Peter Clausen <lars@metafoo.de>
> >
> > Add the necessary infrastructure to the IIO core to support an mmap based
> > interface to access the capture data.
> >
> > The advantage of the mmap based interface compared to the read() based
> > interface is that it avoids an extra copy of the data between kernel and
> > userspace. This is particular useful for high-speed devices which produce
> > several megabytes or even gigabytes of data per second.
> >
> > The data for the mmap interface is managed at the granularity of so called
> > blocks. A block is a contiguous region of memory (at the moment both
> > physically and virtually contiguous). Reducing the granularity from byte
> > level to block level is done to reduce the userspace-kernelspace
> > synchronization overhead since performing syscalls for each byte at a
> > data-rate of a few megabytes is not feasible.
> >
> > This of course leads to a slightly increased latency. For this reason an
> > application can choose the size of the blocks as well as how many blocks it
> > allocates. E.g. two blocks would be a traditional double buffering scheme.
> > But using a higher number might be necessary to avoid underflow/overflow
> > situations in the presence of scheduling latencies.
> >
> > A block can either be owned by kernel space or userspace. When owned by
> > userspace it save to access the data in the block and process it. When
> > owned by kernel space the block can be in one of 3 states.
> >
> > It can be in the incoming queue where all blocks submitted from userspace
> > are placed and are waiting to be processed by the kernel driver.
> >
> > It can be currently being processed by the kernel driver, this means it is
> > actively placing capturing data in it (usually using DMA).
> >
> > Or it can be in the outgoing queue where all blocks that have been
> > processed by the kernel are placed. Userspace can dequeue the blocks as
> > necessary.
> >
> > As part of the interface 5 new IOCTLs to manage the blocks and exchange
> > them between userspace and kernelspace. The IOCTLs can be accessed through
> > a open file descriptor to a IIO device.
> >
> > IIO_BUFFER_BLOCK_ALLOC_IOCTL(struct iio_buffer_block_alloc_req *):
> >  Allocates new blocks. Can be called multiple times if necessary. A newly
> >  allocated block is initially owned by userspace.
> >
> > IIO_BUFFER_BLOCK_FREE_IOCTL(void):
> >  Frees all previously allocated blocks. If the backing memory of a block is
> >  still in use by a kernel driver (i.e. active DMA transfer) it will be
> >  freed once the kernel driver has released it.
> >
> > IIO_BUFFER_BLOCK_QUERY_IOCTL(struct iio_buffer_block *):
> >  Queries information about a block. The id of the block about which
> >  information is to be queried needs to be set by userspace.
> >
> > IIO_BUFFER_BLOCK_ENQUEUE_IOCTL(struct iio_buffer_block *):
> >  Places a block on the incoming queue. This transfers ownership of the
> >  block from userspace to kernelspace. Userspace must populate the id field
> >  of the block to indicate which block to enqueue.
> >
> > IIO_BUFFER_BLOCK_DEQUEUE_IOCTL(struct iio_buffer_block *):
> >  Removes the first block from the outgoing queue. This transfers ownership
> >  of the block from kernelspace to userspace. Kernelspace will populate all
> >  fields of the block. If the queue is empty and the file descriptor is set
> >  to blocking the IOCTL will block until a new block is available on the
> >  outgoing queue.
> >
> > To access the data stored in a block by userspace the block must be mapped
> > to the process's memory. This is done by calling mmap() on the IIO device
> > file descriptor. Each block has a unique offset assigned to it which should
> > be passed to the mmap interface. E.g.
> >
> >   mmap(0, block.size, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
> >        block.offset);
> >
> > A typical workflow for the new interface is:
> >
> >   BLOCK_ALLOC
> >
> >   foreach block
> >      BLOCK_QUERY block
> >          mmap block.data.offset
> >          BLOCK_ENQUEUE block
> >
> >   enable buffer
> >
> >   while !done
> >         BLOCK_DEQUEUE block
> >         process data
> >         BLOCK_ENQUEUE block
> >
> >   disable buffer
> >
> >   BLOCK_FREE
> >
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
...


> > diff --git a/include/uapi/linux/iio/buffer.h b/include/uapi/linux/iio/buffer.h
> > index 13939032b3f6..70ad3aea01ea 100644
> > --- a/include/uapi/linux/iio/buffer.h
> > +++ b/include/uapi/linux/iio/buffer.h
> > @@ -5,6 +5,32 @@
> >  #ifndef _UAPI_IIO_BUFFER_H_
> >  #define _UAPI_IIO_BUFFER_H_
> >
> > +struct iio_buffer_block_alloc_req {
> > +       __u32 type;
> > +       __u32 size;
> > +       __u32 count;
> > +       __u32 id;
> > +};
> > +
> > +#define IIO_BUFFER_BLOCK_FLAG_TIMESTAMP_VALID  (1 << 0)  
> 
> @Lars
> On a recent round of review I did, I noticed that this flag exists and
> isn't set/used anywhere yet.
> The only issue with this is that IIO_BUFFER_BLOCK_FLAG_CYCLIC is now at BIT(1).
> 
> This doesn't look used anywhere, neither in libiio.
> Which would mean maybe making IIO_BUFFER_BLOCK_FLAG_CYCLIC  BIT(0)

It's fine to burn a bit if it makes life a bit easier for you in updating
libiio.  Jut add it as 'reserved'.

Jonathan

> 
> 
> 
> > +
> > +struct iio_buffer_block {
> > +       __u32 id;
> > +       __u32 size;
> > +       __u32 bytes_used;
> > +       __u32 type;
> > +       __u32 flags;
> > +       union {
> > +               __u32 offset;
> > +       } data;
> > +       __u64 timestamp;
> > +};
> > +
> >  #define IIO_BUFFER_GET_FD_IOCTL                        _IOWR('i', 0x91, int)
> > +#define IIO_BUFFER_BLOCK_ALLOC_IOCTL           _IOWR('i', 0x92, struct iio_buffer_block_alloc_req)
> > +#define IIO_BUFFER_BLOCK_FREE_IOCTL            _IO('i',   0x93)
> > +#define IIO_BUFFER_BLOCK_QUERY_IOCTL           _IOWR('i', 0x93, struct iio_buffer_block)
> > +#define IIO_BUFFER_BLOCK_ENQUEUE_IOCTL         _IOWR('i', 0x94, struct iio_buffer_block)
> > +#define IIO_BUFFER_BLOCK_DEQUEUE_IOCTL         _IOWR('i', 0x95, struct iio_buffer_block)
> >
> >  #endif /* _UAPI_IIO_BUFFER_H_ */
> > --
> > 2.17.1
> >  

