Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377C236C088
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 10:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbhD0IHx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 04:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhD0IHv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 04:07:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65B9C061574
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 01:07:07 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t2-20020a17090a0242b0290155433387beso963237pje.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 01:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JT8lqbyhx1rFHLEKQrBhS6sVutIzuvFqM5LePVE8j/Y=;
        b=GNgcAzJftzOZNc/xAwM5camzhyMQ31/Fuxcpa+LWe9Nugud1y1ySFiVbrx5qB13sBC
         z74OmsKPPksMva8c2l3rB/6wS1IYPJF1vw4YZ7ddLvLtg3sDFY/GDvUs9rcgVsod+Vms
         LyJc0zJ5dcrvnttOLwvTls4Q3CN6pCDqmvDN5TOne8zr5RYVzoSBAvJ3J0Buvdkn3lq/
         naqnsbsJpRYH5ns+AOzSmuVia4agrZCY/qsvbo4p52xOBAQzF6OfGK/qMbW9inJ3Jo02
         CbbDpu2ys46ufX0rPJ8mMlEQLU3GVd3bMpuckrKc3k4Pe7a1E7miArmRW0ymLtPxCL21
         C0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JT8lqbyhx1rFHLEKQrBhS6sVutIzuvFqM5LePVE8j/Y=;
        b=ecMgwXja3VQUY0dDcZDtEg3T5K+NOdZQsdo5UkCOEZExtGOfbsOqWNjBtZ/r5kS3rK
         b36MROq79S0yc1MyeVnThpFlp7NfLC4lsmmHnB5KrtmJVO6isewSObuBifKS0yZ942DV
         s8202xrOkr37piIsGKnqQmIudzDIXc18WFGQax147cFYiLjFaoCzT2VAtBds4tK99d83
         zmnpumtiRuwDT6vZ/fQb9ou+GMStBj/pX5FokXG5VBPDrphVGC0ndGoflzVnbxTI8r2j
         b38vuWfddPz9rZDwzVqVwnA/gYEhOTRJzZNwgw/6Rpo1u/6BNt+KTy2FFKEo2Dt1rJXp
         xcVw==
X-Gm-Message-State: AOAM530kuSUCOfY37/3S1Lx6A81iFU2EpkR/ZDjm7KHr7CAXbp6+Y1Nv
        ApIqY5T8DMPHci1Qj7yecYLPYUAwkQG3o+mH0xQ=
X-Google-Smtp-Source: ABdhPJxAfpy2qJI/S8EEYl+SqDXVxqnyAhBo1WCOiAHJe3bDQcjqdZPTd4HKH+Yi5k2KHsaXhSLs+Mg9Q9f+oxLhhHk=
X-Received: by 2002:a17:90a:1b0b:: with SMTP id q11mr19426533pjq.181.1619510827472;
 Tue, 27 Apr 2021 01:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210426174911.397061-1-jic23@kernel.org> <20210426174911.397061-8-jic23@kernel.org>
In-Reply-To: <20210426174911.397061-8-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 27 Apr 2021 11:06:56 +0300
Message-ID: <CA+U=DsoT=2tW0BHpOFbkm3CGTkiFyQf9sfkB0YVoeWV7pE4=gQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] iio: core: move @chrdev from struct iio_dev to struct iio_dev_opaque
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 26, 2021 at 8:50 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> No reason for this to be exposed to the drivers, so lets move it to the
> opaque structure.

Even though this looks straightforward, I am paranoid about it.
Mostly because of all the chardev juggling that I tried.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/industrialio-core.c | 20 +++++++++++---------
>  include/linux/iio/iio-opaque.h  |  2 ++
>  include/linux/iio/iio.h         |  2 --
>  3 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index f3b38d69b7e1..6fbe29f0b1de 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1715,8 +1715,9 @@ EXPORT_SYMBOL_GPL(devm_iio_device_alloc);
>   **/
>  static int iio_chrdev_open(struct inode *inode, struct file *filp)
>  {
> -       struct iio_dev *indio_dev = container_of(inode->i_cdev,
> -                                               struct iio_dev, chrdev);
> +       struct iio_dev_opaque *iio_dev_opaque =
> +               container_of(inode->i_cdev, struct iio_dev_opaque, chrdev);
> +       struct iio_dev *indio_dev = &iio_dev_opaque->indio_dev;
>         struct iio_dev_buffer_pair *ib;
>
>         if (test_and_set_bit(IIO_BUSY_BIT_POS, &indio_dev->flags))
> @@ -1749,8 +1750,9 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
>  static int iio_chrdev_release(struct inode *inode, struct file *filp)
>  {
>         struct iio_dev_buffer_pair *ib = filp->private_data;
> -       struct iio_dev *indio_dev = container_of(inode->i_cdev,
> -                                               struct iio_dev, chrdev);
> +       struct iio_dev_opaque *iio_dev_opaque =
> +               container_of(inode->i_cdev, struct iio_dev_opaque, chrdev);
> +       struct iio_dev *indio_dev = &iio_dev_opaque->indio_dev;
>         kfree(ib);
>         clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
>         iio_device_put(indio_dev);
> @@ -1901,19 +1903,19 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>                 indio_dev->setup_ops = &noop_ring_setup_ops;
>
>         if (iio_dev_opaque->attached_buffers_cnt)
> -               cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> +               cdev_init(&iio_dev_opaque->chrdev, &iio_buffer_fileops);
>         else if (iio_dev_opaque->event_interface)
> -               cdev_init(&indio_dev->chrdev, &iio_event_fileops);
> +               cdev_init(&iio_dev_opaque->chrdev, &iio_event_fileops);
>
>         if (iio_dev_opaque->attached_buffers_cnt || iio_dev_opaque->event_interface) {
>                 indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), iio_dev_opaque->id);
> -               indio_dev->chrdev.owner = this_mod;
> +               iio_dev_opaque->chrdev.owner = this_mod;
>         }
>
>         /* assign device groups now; they should be all registered now */
>         indio_dev->dev.groups = iio_dev_opaque->groups;
>
> -       ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
> +       ret = cdev_device_add(&iio_dev_opaque->chrdev, &indio_dev->dev);
>         if (ret < 0)
>                 goto error_unreg_eventset;
>
> @@ -1940,7 +1942,7 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>         struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>         struct iio_ioctl_handler *h, *t;
>
> -       cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
> +       cdev_device_del(&iio_dev_opaque->chrdev, &indio_dev->dev);
>
>         mutex_lock(&iio_dev_opaque->info_exist_lock);
>
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index 538b4b5ef1a9..2f8ef5d15a66 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -24,6 +24,7 @@
>   * @legacy_scan_el_group:      attribute group for legacy scan elements attribute group
>   * @legacy_buffer_group:       attribute group for legacy buffer attributes group
>   * @scan_index_timestamp:      cache of the index to the timestamp
> + * @chrdev:                    associated character device
>   * @debugfs_dentry:            device specific debugfs dentry
>   * @cached_reg_addr:           cached register address for debugfs reads
>   * @read_buf:                  read buffer to be used for the initial reg read
> @@ -49,6 +50,7 @@ struct iio_dev_opaque {
>         struct attribute_group          legacy_buffer_group;
>
>         unsigned int                    scan_index_timestamp;
> +       struct cdev                     chrdev;
>
>  #if defined(CONFIG_DEBUG_FS)
>         struct dentry                   *debugfs_dentry;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index a12bbd8b1e74..586e2dc4fbf3 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -512,7 +512,6 @@ struct iio_buffer_setup_ops {
>   * @clock_id:          [INTERN] timestamping clock posix identifier
>   * @setup_ops:         [DRIVER] callbacks to call before and after buffer
>   *                     enable/disable
> - * @chrdev:            [INTERN] associated character device
>   * @flags:             [INTERN] file ops related flags including busy flag.
>   * @priv:              [DRIVER] reference to driver's private information
>   *                     **MUST** be accessed **ONLY** via iio_priv() helper
> @@ -542,7 +541,6 @@ struct iio_dev {
>         const struct iio_info           *info;
>         clockid_t                       clock_id;
>         const struct iio_buffer_setup_ops       *setup_ops;
> -       struct cdev                     chrdev;
>
>         unsigned long                   flags;
>         void                            *priv;
> --
> 2.31.1
>
