Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBA736C08F
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 10:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbhD0IIK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 04:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbhD0III (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 04:08:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAE2C061574
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 01:07:25 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h11so1181360pfn.0
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 01:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDOToIY5hsKyRt7oOXROnDg+mLriF+/m7D3nKk2Q+UM=;
        b=r+WVef3Fq9tWMC20lID/Oir9NqCg+XZ8fMjKhR5U5UD1dzuyrN5ny1ZVwQiyvGbPwH
         wgItNoK9+nnLDsI4ZnbX1NYpIR9z6Cq5f/UbV6PY49f6KHS5byOHgVmmyS5wzQqeKixU
         jNdwfccMEjFRkwEtqfyN0bl6cpR3mEb0gkRU06OLZorTD8gEjo61i+mYeF+qOyhisO1F
         y0TVidnYaaQZTM0JTyDCjT7d2PUrauYfeGCNUEvM0+5ISxd2A/gtjPOh8BPp8BjcV4Tn
         qR5PfpEGIA3uXokzlAKwBoprC4/XXPQD2fz4bcYIoHhLrv8FJIQJ3VBCILMDQ19BASM3
         +V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDOToIY5hsKyRt7oOXROnDg+mLriF+/m7D3nKk2Q+UM=;
        b=qFcOY7sZ9WtJxa0fg6NUHwxpUod9KDBt/NMieEtsKOxZQT516jUphKDE3ztAh+RP48
         JNe4amyUWHQoSvIYzXa5HTapagvIzaxtM4hN63Rnn1NZ0qMCvHGcVlmHiGYLgTyp4l+1
         dS1fdhC6rHTp6mSJvRzGAsIEtzXcRd3tpHODTMHInJIULvP8I2DTMbr3YCcJa/h7T0QJ
         9JdWjd563q4eCeGfu8b1jZpB/fAahCMNZ+VmOOZX9XppwHWzR6prLPJEVuOZiGc1wbuE
         y4t0pCMm12xP+L6CKuKmaw+NFOkZDtZAJ2yv9hgCrT0RjieyygVAnhh75y9RmgiikeMd
         zYtg==
X-Gm-Message-State: AOAM530ri2DL/vM3j2xlCOgM668wwwO5KDd/Orz2A2rJLoe2lAy4TLG2
        uYLFHf5chXx/e2RyFkfznr7FbWr5XpKbvljZpCY=
X-Google-Smtp-Source: ABdhPJysAO3VH7d8C7puZnD9hOUn7Ky1LQI77mNiRHQ6VNTjLVduWv6cZWD5FJcfyoYsNjZLC5PEs+vTSreTptcFvfo=
X-Received: by 2002:a62:3486:0:b029:24c:34c0:3c7a with SMTP id
 b128-20020a6234860000b029024c34c03c7amr21474028pfa.36.1619510844763; Tue, 27
 Apr 2021 01:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210426174911.397061-1-jic23@kernel.org> <20210426174911.397061-9-jic23@kernel.org>
In-Reply-To: <20210426174911.397061-9-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 27 Apr 2021 11:07:13 +0300
Message-ID: <CA+U=Dsq5eFonKFbrQTKLRD4L2WSa7sH=6xgxrb2QkO+_sbuJpA@mail.gmail.com>
Subject: Re: [PATCH 8/9] iio: core: move @flags from struct iio_dev to struct iio_dev_opaque
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
> No reason any driver should ever need access to this field, so hide it.
>


Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>


> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/industrialio-core.c | 6 +++---
>  include/linux/iio/iio-opaque.h  | 2 ++
>  include/linux/iio/iio.h         | 2 --
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 6fbe29f0b1de..4a4c02fea152 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1720,7 +1720,7 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
>         struct iio_dev *indio_dev = &iio_dev_opaque->indio_dev;
>         struct iio_dev_buffer_pair *ib;
>
> -       if (test_and_set_bit(IIO_BUSY_BIT_POS, &indio_dev->flags))
> +       if (test_and_set_bit(IIO_BUSY_BIT_POS, &iio_dev_opaque->flags))
>                 return -EBUSY;
>
>         iio_device_get(indio_dev);
> @@ -1728,7 +1728,7 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
>         ib = kmalloc(sizeof(*ib), GFP_KERNEL);
>         if (!ib) {
>                 iio_device_put(indio_dev);
> -               clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
> +               clear_bit(IIO_BUSY_BIT_POS, &iio_dev_opaque->flags);
>                 return -ENOMEM;
>         }
>
> @@ -1754,7 +1754,7 @@ static int iio_chrdev_release(struct inode *inode, struct file *filp)
>                 container_of(inode->i_cdev, struct iio_dev_opaque, chrdev);
>         struct iio_dev *indio_dev = &iio_dev_opaque->indio_dev;
>         kfree(ib);
> -       clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
> +       clear_bit(IIO_BUSY_BIT_POS, &iio_dev_opaque->flags);
>         iio_device_put(indio_dev);
>
>         return 0;
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index 2f8ef5d15a66..d7c3036861ac 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -25,6 +25,7 @@
>   * @legacy_buffer_group:       attribute group for legacy buffer attributes group
>   * @scan_index_timestamp:      cache of the index to the timestamp
>   * @chrdev:                    associated character device
> + * @flags:                     file ops related flags including busy flag.
>   * @debugfs_dentry:            device specific debugfs dentry
>   * @cached_reg_addr:           cached register address for debugfs reads
>   * @read_buf:                  read buffer to be used for the initial reg read
> @@ -51,6 +52,7 @@ struct iio_dev_opaque {
>
>         unsigned int                    scan_index_timestamp;
>         struct cdev                     chrdev;
> +       unsigned long                   flags;
>
>  #if defined(CONFIG_DEBUG_FS)
>         struct dentry                   *debugfs_dentry;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 586e2dc4fbf3..ed0537015eee 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -512,7 +512,6 @@ struct iio_buffer_setup_ops {
>   * @clock_id:          [INTERN] timestamping clock posix identifier
>   * @setup_ops:         [DRIVER] callbacks to call before and after buffer
>   *                     enable/disable
> - * @flags:             [INTERN] file ops related flags including busy flag.
>   * @priv:              [DRIVER] reference to driver's private information
>   *                     **MUST** be accessed **ONLY** via iio_priv() helper
>   */
> @@ -542,7 +541,6 @@ struct iio_dev {
>         clockid_t                       clock_id;
>         const struct iio_buffer_setup_ops       *setup_ops;
>
> -       unsigned long                   flags;
>         void                            *priv;
>  };
>
> --
> 2.31.1
>
