Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892DB319C9A
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 11:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhBLKYA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 05:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhBLKXs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 05:23:48 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78346C061574;
        Fri, 12 Feb 2021 02:21:49 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n14so8779373iog.3;
        Fri, 12 Feb 2021 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+ZEDxX2smPSNwzdhlABTYoXci1h+cLPxm9kmOiroTE=;
        b=ih9wK4aqMsR9V3ZwDmEcs6HeJd862FhUTxUFKjyzqRO1r3cEFu3EjNucUe/OdaMk49
         nE0fmoWIMIq0Nrgoe9vjXvrk67Zw/aiSLD27JSq3UmI1icB1xNiMvULBhrpm9XB/MGl3
         fhEtANP4KZLBWxADfr4qTWLErBWDoP9Y8f40pKuHtuOhOnfenJQaB6n8ljKpRkSoRV08
         PjlMInUBNx8qmU9Oup2zV4TKW3GJ4P/j9+1PoUVUBLl0VRKJH+xTuxjeECPwKWr5q3Lg
         3OSFasd/sqnGiPTwDLgRukiC5BkmvmKV4e1/39lYPz3Pg1E6dAxRBZu/5KAEbnAHwBk4
         Hytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+ZEDxX2smPSNwzdhlABTYoXci1h+cLPxm9kmOiroTE=;
        b=CZuGXAf/+H8PfxEN3WQEvWB1BHLjRb2osNqV5LrDYCgqrwcWQDz9oN5VHrTx7a248X
         Qt6PlclB1+BjyG9dt1mE+0B75Si9wb4hgs9v+/AHS36k/ERGaq1MT0yXFxAqrY8Z1+UQ
         mNpso1wESEL9fbOvHtRztYfGV97i0Ve8d9m9+mXsNLP1lTYYApzjxveGjccb2Bn2Skez
         OxE+OeFSKyNejhds6OyT2tg36bBqwWLVHGVrKYLOZwFZzciMznY+JoR+C2sVVCjg798d
         wcJGzdBbgIf/yKEM7jznTe3D9gWycgSbPgVB/S2v1lO1NG8081hM5q77SD9VhaVC/Rnx
         o0wA==
X-Gm-Message-State: AOAM531Yp6EcDZmm3K3FrWOnWKDbBLNXqdHErizjk7+eRoJXXKGhjIke
        cOwSz7ITLbOFyse+sV2k+favdsyszr6EJ5C7g8E=
X-Google-Smtp-Source: ABdhPJxY3WXjDLz1GvUHtil+ulV1KXNDjt3TF0Tz1zEuY9a8R7nPoXYufaWpC4invh4TNlRXGUjCLrW5l0BZ1jYwMGA=
X-Received: by 2002:a6b:f714:: with SMTP id k20mr1615275iog.70.1613125308780;
 Fri, 12 Feb 2021 02:21:48 -0800 (PST)
MIME-Version: 1.0
References: <20210212101143.18993-1-alexandru.ardelean@analog.com> <20210212101143.18993-2-alexandru.ardelean@analog.com>
In-Reply-To: <20210212101143.18993-2-alexandru.ardelean@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 12 Feb 2021 12:21:37 +0200
Message-ID: <CA+U=Dsoq9XF2ACEyLAYapDdwZ2dDyfK5iPS-SGhP2Uf5R9uCdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iio: core: Add mmap interface infrastructure
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 12, 2021 at 12:12 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> From: Lars-Peter Clausen <lars@metafoo.de>
>
> Add the necessary infrastructure to the IIO core to support an mmap based
> interface to access the capture data.
>
> The advantage of the mmap based interface compared to the read() based
> interface is that it avoids an extra copy of the data between kernel and
> userspace. This is particular useful for high-speed devices which produce
> several megabytes or even gigabytes of data per second.
>
> The data for the mmap interface is managed at the granularity of so called
> blocks. A block is a contiguous region of memory (at the moment both
> physically and virtually contiguous). Reducing the granularity from byte
> level to block level is done to reduce the userspace-kernelspace
> synchronization overhead since performing syscalls for each byte at a
> data-rate of a few megabytes is not feasible.
>
> This of course leads to a slightly increased latency. For this reason an
> application can choose the size of the blocks as well as how many blocks it
> allocates. E.g. two blocks would be a traditional double buffering scheme.
> But using a higher number might be necessary to avoid underflow/overflow
> situations in the presence of scheduling latencies.
>
> A block can either be owned by kernel space or userspace. When owned by
> userspace it save to access the data in the block and process it. When
> owned by kernel space the block can be in one of 3 states.
>
> It can be in the incoming queue where all blocks submitted from userspace
> are placed and are waiting to be processed by the kernel driver.
>
> It can be currently being processed by the kernel driver, this means it is
> actively placing capturing data in it (usually using DMA).
>
> Or it can be in the outgoing queue where all blocks that have been
> processed by the kernel are placed. Userspace can dequeue the blocks as
> necessary.
>
> As part of the interface 5 new IOCTLs to manage the blocks and exchange
> them between userspace and kernelspace. The IOCTLs can be accessed through
> a open file descriptor to a IIO device.
>
> IIO_BUFFER_BLOCK_ALLOC_IOCTL(struct iio_buffer_block_alloc_req *):
>  Allocates new blocks. Can be called multiple times if necessary. A newly
>  allocated block is initially owned by userspace.
>
> IIO_BUFFER_BLOCK_FREE_IOCTL(void):
>  Frees all previously allocated blocks. If the backing memory of a block is
>  still in use by a kernel driver (i.e. active DMA transfer) it will be
>  freed once the kernel driver has released it.
>
> IIO_BUFFER_BLOCK_QUERY_IOCTL(struct iio_buffer_block *):
>  Queries information about a block. The id of the block about which
>  information is to be queried needs to be set by userspace.
>
> IIO_BUFFER_BLOCK_ENQUEUE_IOCTL(struct iio_buffer_block *):
>  Places a block on the incoming queue. This transfers ownership of the
>  block from userspace to kernelspace. Userspace must populate the id field
>  of the block to indicate which block to enqueue.
>
> IIO_BUFFER_BLOCK_DEQUEUE_IOCTL(struct iio_buffer_block *):
>  Removes the first block from the outgoing queue. This transfers ownership
>  of the block from kernelspace to userspace. Kernelspace will populate all
>  fields of the block. If the queue is empty and the file descriptor is set
>  to blocking the IOCTL will block until a new block is available on the
>  outgoing queue.
>
> To access the data stored in a block by userspace the block must be mapped
> to the process's memory. This is done by calling mmap() on the IIO device
> file descriptor. Each block has a unique offset assigned to it which should
> be passed to the mmap interface. E.g.
>
>   mmap(0, block.size, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
>        block.offset);
>
> A typical workflow for the new interface is:
>
>   BLOCK_ALLOC
>
>   foreach block
>      BLOCK_QUERY block
>          mmap block.data.offset
>          BLOCK_ENQUEUE block
>
>   enable buffer
>
>   while !done
>         BLOCK_DEQUEUE block
>         process data
>         BLOCK_ENQUEUE block
>
>   disable buffer
>
>   BLOCK_FREE
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/industrialio-buffer.c | 157 ++++++++++++++++++++++++++++++
>  include/linux/iio/buffer-dma.h    |   5 -
>  include/linux/iio/buffer_impl.h   |  23 +++++
>  include/uapi/linux/iio/buffer.h   |  26 +++++
>  4 files changed, 206 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 3aa6702a5811..50228df0b09f 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -16,6 +16,7 @@
>  #include <linux/fs.h>
>  #include <linux/cdev.h>
>  #include <linux/slab.h>
> +#include <linux/mm.h>
>  #include <linux/poll.h>
>  #include <linux/sched/signal.h>
>
> @@ -1370,6 +1371,12 @@ static void iio_buffer_unregister_legacy_sysfs_groups(struct iio_dev *indio_dev)
>         kfree(iio_dev_opaque->legacy_scan_el_group.attrs);
>  }
>
> +static void iio_buffer_free_blocks(struct iio_buffer *buffer)
> +{
> +       if (buffer->access->free_blocks)
> +               buffer->access->free_blocks(buffer);
> +}
> +
>  static int iio_buffer_chrdev_release(struct inode *inode, struct file *filep)
>  {
>         struct iio_dev_buffer_pair *ib = filep->private_data;
> @@ -1378,18 +1385,24 @@ static int iio_buffer_chrdev_release(struct inode *inode, struct file *filep)
>
>         wake_up(&buffer->pollq);
>         clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
> +       iio_buffer_free_blocks(buffer);
>         iio_device_put(indio_dev);
>         kfree(ib);
>
>         return 0;
>  }
>
> +static long iio_buffer_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
> +static int iio_buffer_mmap(struct file *filep, struct vm_area_struct *vma);
> +
>  static const struct file_operations iio_buffer_chrdev_fileops = {
>         .owner = THIS_MODULE,
>         .llseek = noop_llseek,
>         .read = iio_buffer_read,
>         .poll = iio_buffer_poll,
> +       .unlocked_ioctl = iio_buffer_ioctl,
>         .compat_ioctl = compat_ptr_ioctl,
> +       .mmap = iio_buffer_mmap,
>         .release = iio_buffer_chrdev_release,
>  };
>
> @@ -1762,6 +1775,150 @@ void iio_buffer_put(struct iio_buffer *buffer)
>  }
>  EXPORT_SYMBOL_GPL(iio_buffer_put);
>
> +static int iio_buffer_query_block(struct iio_buffer *buffer,
> +                                 struct iio_buffer_block __user *user_block)
> +{
> +       struct iio_buffer_block block;
> +       int ret;
> +
> +       if (!buffer->access->query_block)
> +               return -ENOSYS;
> +
> +       if (copy_from_user(&block, user_block, sizeof(block)))
> +               return -EFAULT;
> +
> +       ret = buffer->access->query_block(buffer, &block);
> +       if (ret)
> +               return ret;
> +
> +       if (copy_to_user(user_block, &block, sizeof(block)))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
> +static int iio_buffer_dequeue_block(struct iio_dev *indio_dev,
> +                                   struct iio_buffer *buffer,
> +                                   struct iio_buffer_block __user *user_block,
> +                                   bool non_blocking)
> +{
> +       struct iio_buffer_block block;
> +       int ret;
> +
> +       if (!buffer->access->dequeue_block)
> +               return -ENOSYS;
> +
> +       do {
> +               if (!iio_buffer_data_available(buffer)) {
> +                       if (non_blocking)
> +                               return -EAGAIN;
> +
> +                       ret = wait_event_interruptible(buffer->pollq,
> +                                       iio_buffer_data_available(buffer) ||
> +                                       indio_dev->info == NULL);
> +                       if (ret)
> +                               return ret;
> +                       if (indio_dev->info == NULL)
> +                               return -ENODEV;
> +               }
> +
> +               ret = buffer->access->dequeue_block(buffer, &block);
> +               if (ret == -EAGAIN && non_blocking)
> +                       ret = 0;
> +       } while (ret);
> +
> +       if (ret)
> +               return ret;
> +
> +       if (copy_to_user(user_block, &block, sizeof(block)))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
> +static int iio_buffer_enqueue_block(struct iio_buffer *buffer,
> +                                  struct iio_buffer_block __user *user_block)
> +{
> +       struct iio_buffer_block block;
> +
> +       if (!buffer->access->enqueue_block)
> +               return -ENOSYS;
> +
> +       if (copy_from_user(&block, user_block, sizeof(block)))
> +               return -EFAULT;
> +
> +       return buffer->access->enqueue_block(buffer, &block);
> +}
> +
> +static int iio_buffer_alloc_blocks(struct iio_buffer *buffer,
> +                                  struct iio_buffer_block_alloc_req __user *user_req)
> +{
> +       struct iio_buffer_block_alloc_req req;
> +       int ret;
> +
> +       if (!buffer->access->alloc_blocks)
> +               return -ENOSYS;
> +
> +       if (copy_from_user(&req, user_req, sizeof(req)))
> +               return -EFAULT;
> +
> +       ret = buffer->access->alloc_blocks(buffer, &req);
> +       if (ret)
> +               return ret;
> +
> +       if (copy_to_user(user_req, &req, sizeof(req)))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
> +static long iio_buffer_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> +{
> +       bool non_blocking = filep->f_flags & O_NONBLOCK;
> +       struct iio_dev_buffer_pair *ib = filep->private_data;
> +       struct iio_dev *indio_dev = ib->indio_dev;
> +       struct iio_buffer *buffer = ib->buffer;
> +
> +       if (!buffer || !buffer->access)
> +               return -ENODEV;
> +
> +       switch (cmd) {
> +       case IIO_BUFFER_BLOCK_ALLOC_IOCTL:
> +               return iio_buffer_alloc_blocks(buffer,
> +                       (struct iio_buffer_block_alloc_req __user *)arg);
> +       case IIO_BUFFER_BLOCK_FREE_IOCTL:
> +               iio_buffer_free_blocks(buffer);
> +               return 0;
> +       case IIO_BUFFER_BLOCK_QUERY_IOCTL:
> +               return iio_buffer_query_block(buffer,
> +                       (struct iio_buffer_block __user *)arg);
> +       case IIO_BUFFER_BLOCK_ENQUEUE_IOCTL:
> +               return iio_buffer_enqueue_block(buffer,
> +                       (struct iio_buffer_block __user *)arg);
> +       case IIO_BUFFER_BLOCK_DEQUEUE_IOCTL:
> +               return iio_buffer_dequeue_block(indio_dev, buffer,
> +                       (struct iio_buffer_block __user *)arg, non_blocking);
> +       }
> +       return -EINVAL;
> +}
> +
> +static int iio_buffer_mmap(struct file *filep, struct vm_area_struct *vma)
> +{
> +       struct iio_dev_buffer_pair *ib = filep->private_data;
> +       struct iio_buffer *buffer = ib->buffer;
> +
> +       if (!buffer->access || !buffer->access->mmap)
> +               return -ENODEV;
> +
> +       if (!(vma->vm_flags & VM_SHARED))
> +               return -EINVAL;
> +
> +       if (!(vma->vm_flags & VM_READ))
> +               return -EINVAL;
> +
> +       return buffer->access->mmap(buffer, vma);
> +}
> +
>  /**
>   * iio_device_attach_buffer - Attach a buffer to a IIO device
>   * @indio_dev: The device the buffer should be attached to
> diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
> index ff15c61bf319..6564bdcdac66 100644
> --- a/include/linux/iio/buffer-dma.h
> +++ b/include/linux/iio/buffer-dma.h
> @@ -17,11 +17,6 @@ struct iio_dma_buffer_queue;
>  struct iio_dma_buffer_ops;
>  struct device;
>
> -struct iio_buffer_block {
> -       u32 size;
> -       u32 bytes_used;
> -};
> -
>  /**
>   * enum iio_block_state - State of a struct iio_dma_buffer_block
>   * @IIO_BLOCK_STATE_DEQUEUED: Block is not queued
> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> index 245b32918ae1..1d57dc7ccb4f 100644
> --- a/include/linux/iio/buffer_impl.h
> +++ b/include/linux/iio/buffer_impl.h
> @@ -34,6 +34,18 @@ struct iio_buffer;
>   *                      device stops sampling. Calles are balanced with @enable.
>   * @release:           called when the last reference to the buffer is dropped,
>   *                     should free all resources allocated by the buffer.
> + * @alloc_blocks:      called from userspace via ioctl to allocate blocks
> + *                     that will be used via the mmap interface.
> + * @free_blocks:       called from userspace via ioctl to free all blocks
> + *                     allocated for this buffer.
> + * @enqueue_block:     called from userspace via ioctl to queue this block
> + *                     to this buffer. Requires a valid block id.
> + * @dequeue_block:     called from userspace via ioctl to dequeue this block
> + *                     from this buffer. Requires a valid block id.
> + * @query_block:       called from userspace via ioctl to query the attributes
> + *                     of this block. Requires a valid block id.
> + * @mmap:              mmap hook for this buffer. Userspace mmap() calls will
> + *                     get routed to this.
>   * @modes:             Supported operating modes by this buffer type
>   * @flags:             A bitmask combination of INDIO_BUFFER_FLAG_*
>   *
> @@ -60,6 +72,17 @@ struct iio_buffer_access_funcs {
>
>         void (*release)(struct iio_buffer *buffer);
>
> +       int (*alloc_blocks)(struct iio_buffer *buffer,
> +                           struct iio_buffer_block_alloc_req *req);
> +       int (*free_blocks)(struct iio_buffer *buffer);
> +       int (*enqueue_block)(struct iio_buffer *buffer,
> +                            struct iio_buffer_block *block);
> +       int (*dequeue_block)(struct iio_buffer *buffer,
> +                            struct iio_buffer_block *block);
> +       int (*query_block)(struct iio_buffer *buffer,
> +                          struct iio_buffer_block *block);
> +       int (*mmap)(struct iio_buffer *buffer,  struct vm_area_struct *vma);
> +
>         unsigned int modes;
>         unsigned int flags;
>  };
> diff --git a/include/uapi/linux/iio/buffer.h b/include/uapi/linux/iio/buffer.h
> index 13939032b3f6..70ad3aea01ea 100644
> --- a/include/uapi/linux/iio/buffer.h
> +++ b/include/uapi/linux/iio/buffer.h
> @@ -5,6 +5,32 @@
>  #ifndef _UAPI_IIO_BUFFER_H_
>  #define _UAPI_IIO_BUFFER_H_
>
> +struct iio_buffer_block_alloc_req {
> +       __u32 type;
> +       __u32 size;
> +       __u32 count;
> +       __u32 id;
> +};
> +
> +#define IIO_BUFFER_BLOCK_FLAG_TIMESTAMP_VALID  (1 << 0)

@Lars
On a recent round of review I did, I noticed that this flag exists and
isn't set/used anywhere yet.
The only issue with this is that IIO_BUFFER_BLOCK_FLAG_CYCLIC is now at BIT(1).

This doesn't look used anywhere, neither in libiio.
Which would mean maybe making IIO_BUFFER_BLOCK_FLAG_CYCLIC  BIT(0)



> +
> +struct iio_buffer_block {
> +       __u32 id;
> +       __u32 size;
> +       __u32 bytes_used;
> +       __u32 type;
> +       __u32 flags;
> +       union {
> +               __u32 offset;
> +       } data;
> +       __u64 timestamp;
> +};
> +
>  #define IIO_BUFFER_GET_FD_IOCTL                        _IOWR('i', 0x91, int)
> +#define IIO_BUFFER_BLOCK_ALLOC_IOCTL           _IOWR('i', 0x92, struct iio_buffer_block_alloc_req)
> +#define IIO_BUFFER_BLOCK_FREE_IOCTL            _IO('i',   0x93)
> +#define IIO_BUFFER_BLOCK_QUERY_IOCTL           _IOWR('i', 0x93, struct iio_buffer_block)
> +#define IIO_BUFFER_BLOCK_ENQUEUE_IOCTL         _IOWR('i', 0x94, struct iio_buffer_block)
> +#define IIO_BUFFER_BLOCK_DEQUEUE_IOCTL         _IOWR('i', 0x95, struct iio_buffer_block)
>
>  #endif /* _UAPI_IIO_BUFFER_H_ */
> --
> 2.17.1
>
