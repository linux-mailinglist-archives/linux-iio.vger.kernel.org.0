Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5096036C084
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 10:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhD0IFo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 04:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhD0IFo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 04:05:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32697C061574
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 01:05:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p17so2559344pjz.3
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 01:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JMgoFL/OH3t6niCHegSPpDzaCtzg95RA3eWHGMcVsWA=;
        b=H0MrT1NT9Ug9xPpooNAi+S7sAGgVxqsMXICfCN5fWgyesrImSEJ5upV1byzUQrAfyV
         owz5s1nFG7GYtw4jp8xXKh0ZZ4o0PF0tToNkNS6uBBtBYbuGAnP6VZysXtWGVJPugjJk
         eNs0zOmE9EdLwVcfaV2Oa/jIvaiRDD0alg1MDE9tDyXHJv6bJHY3ufXTHmJOJl8UaaO3
         jVTGZ+JfbCXOnCtfLcdClVpRMd1roR2lXODqwYv1FSdHH4z7QnA+09MokVFyg5+x/Lbl
         ILx53R0ppboIbfbosLvHzSaZfZep9t6hqE6YijIV3ZNS1ONk27AX7FvrGCraJjv6Izf2
         tEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JMgoFL/OH3t6niCHegSPpDzaCtzg95RA3eWHGMcVsWA=;
        b=BMVJVHSATK5H5iBgArXM9TWjxx684n0CZjnCfMGs7H5oq7S0NJ/01wadM/r/2YYxYd
         AGaam2Q3V6kTYipBByH0fHLsF7PJQoAqfmi6E/Gxv2MoSTkyV4mgG8W6OlzvBpJ8ndSc
         RYDjOAL2f5A/f+HPcdazmFsqJBhgJ/16MOlUnFGfzIseww1gLFqiOwpTieOCUvOOPMR5
         6/jnhqDUH0AkkQXy0GCPcBE4ruHHivNK24EdXH4SKCCPfbs7DjZZUr7f5I6Xexodp/ZV
         ADyKSPT6C/GMQ/lNEC2G9+jOtFANIqK168qgc/T33agz+K+p0fvivm6gTN5k77RzVAYa
         Q3Mg==
X-Gm-Message-State: AOAM530nwcYMI0RGDidAJhMePEswEeKxZvR3ALlUXMGvV5NHrD4Dunaj
        U4vv225eFvKAUcFKiCUT06RtQnGSdvBcjpWaVig=
X-Google-Smtp-Source: ABdhPJwIEyhfkaoOiJVzaLZXh9TPXyMTZxsxKDbDbh55UO5a8MO+NK1lEqwnkn0cIiTzvlD5bJNHEDeCsdEY2NIkbsg=
X-Received: by 2002:a17:90a:1b0b:: with SMTP id q11mr19418604pjq.181.1619510699483;
 Tue, 27 Apr 2021 01:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210426174911.397061-1-jic23@kernel.org> <20210426174911.397061-7-jic23@kernel.org>
In-Reply-To: <20210426174911.397061-7-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 27 Apr 2021 11:04:48 +0300
Message-ID: <CA+U=DsqRrR7ro73FWfYiDByXvXUKg_tywhf0vCx08OSSKfu3kw@mail.gmail.com>
Subject: Re: [PATCH 6/9] iio: core: move @info_exist_lock to struct iio_dev_opaque
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
> This lock is only of interest to the IIO core, so make it only
> visible there.

This was on my list at some point, but I deferred it because it was
overlapping with the IIO buffer stuff.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/industrialio-buffer.c |  5 ++--
>  drivers/iio/industrialio-core.c   | 10 +++----
>  drivers/iio/inkern.c              | 46 +++++++++++++++++++------------
>  include/linux/iio/iio-opaque.h    |  2 ++
>  include/linux/iio/iio.h           |  2 --
>  5 files changed, 38 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 9ecb3c58d94c..10923b40c76d 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1150,12 +1150,13 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>                        struct iio_buffer *insert_buffer,
>                        struct iio_buffer *remove_buffer)
>  {
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>         int ret;
>
>         if (insert_buffer == remove_buffer)
>                 return 0;
>
> -       mutex_lock(&indio_dev->info_exist_lock);
> +       mutex_lock(&iio_dev_opaque->info_exist_lock);
>         mutex_lock(&indio_dev->mlock);
>
>         if (insert_buffer && iio_buffer_is_active(insert_buffer))
> @@ -1178,7 +1179,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>
>  out_unlock:
>         mutex_unlock(&indio_dev->mlock);
> -       mutex_unlock(&indio_dev->info_exist_lock);
> +       mutex_unlock(&iio_dev_opaque->info_exist_lock);
>
>         return ret;
>  }
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 8c38f1f6e075..f3b38d69b7e1 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1642,7 +1642,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
>         device_initialize(&indio_dev->dev);
>         iio_device_set_drvdata(indio_dev, (void *)indio_dev);
>         mutex_init(&indio_dev->mlock);
> -       mutex_init(&indio_dev->info_exist_lock);
> +       mutex_init(&iio_dev_opaque->info_exist_lock);
>         INIT_LIST_HEAD(&iio_dev_opaque->channel_attr_list);
>
>         iio_dev_opaque->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
> @@ -1779,7 +1779,7 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>         struct iio_ioctl_handler *h;
>         int ret = -ENODEV;
>
> -       mutex_lock(&indio_dev->info_exist_lock);
> +       mutex_lock(&iio_dev_opaque->info_exist_lock);
>
>         /**
>          * The NULL check here is required to prevent crashing when a device
> @@ -1800,7 +1800,7 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>                 ret = -EINVAL;
>
>  out_unlock:
> -       mutex_unlock(&indio_dev->info_exist_lock);
> +       mutex_unlock(&iio_dev_opaque->info_exist_lock);
>
>         return ret;
>  }
> @@ -1942,7 +1942,7 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>
>         cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
>
> -       mutex_lock(&indio_dev->info_exist_lock);
> +       mutex_lock(&iio_dev_opaque->info_exist_lock);
>
>         iio_device_unregister_debugfs(indio_dev);
>
> @@ -1956,7 +1956,7 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>         iio_device_wakeup_eventset(indio_dev);
>         iio_buffer_wakeup_poll(indio_dev);
>
> -       mutex_unlock(&indio_dev->info_exist_lock);
> +       mutex_unlock(&iio_dev_opaque->info_exist_lock);
>
>         iio_buffers_free_sysfs_and_mask(indio_dev);
>  }
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 5aa740cea661..391a3380a1d1 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -10,6 +10,7 @@
>  #include <linux/of.h>
>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/iio-opaque.h>
>  #include "iio_core.h"
>  #include <linux/iio/machine.h>
>  #include <linux/iio/driver.h>
> @@ -538,9 +539,10 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
>
>  int iio_read_channel_raw(struct iio_channel *chan, int *val)
>  {
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
>         int ret;
>
> -       mutex_lock(&chan->indio_dev->info_exist_lock);
> +       mutex_lock(&iio_dev_opaque->info_exist_lock);
>         if (chan->indio_dev->info == NULL) {
>                 ret = -ENODEV;
>                 goto err_unlock;
> @@ -548,7 +550,7 @@ int iio_read_channel_raw(struct iio_channel *chan, int *val)
>
>         ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
>  err_unlock:
> -       mutex_unlock(&chan->indio_dev->info_exist_lock);
> +       mutex_unlock(&iio_dev_opaque->info_exist_lock);
>
>         return ret;
>  }
> @@ -556,9 +558,10 @@ EXPORT_SYMBOL_GPL(iio_read_channel_raw);
>
>  int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
>  {
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
>         int ret;
>
> -       mutex_lock(&chan->indio_dev->info_exist_lock);
> +       mutex_lock(&iio_dev_opaque->info_exist_lock);
>         if (chan->indio_dev->info == NULL) {
>                 ret = -ENODEV;
>                 goto err_unlock;
> @@ -566,7 +569,7 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
>
>         ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_AVERAGE_RAW);
>  err_unlock:
> -       mutex_unlock(&chan->indio_dev->info_exist_lock);
> +       mutex_unlock(&iio_dev_opaque->info_exist_lock);
>
>         return ret;
>  }
> @@ -631,9 +634,10 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>  int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
>         int *processed, unsigned int scale)
>  {
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
>         int ret;
>
> -       mutex_lock(&chan->indio_dev->info_exist_lock);
> +       mutex_lock(&iio_dev_opaque->info_exist_lock);
>         if (chan->indio_dev->info == NULL) {
>                 ret = -ENODEV;
>                 goto err_unlock;
> @@ -642,7 +646,7 @@ int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
>         ret = iio_convert_raw_to_processed_unlocked(chan, raw, processed,
>                                                         scale);
>  err_unlock:
> -       mutex_unlock(&chan->indio_dev->info_exist_lock);
> +       mutex_unlock(&iio_dev_opaque->info_exist_lock);
>
>         return ret;
>  }
> @@ -651,9 +655,10 @@ EXPORT_SYMBOL_GPL(iio_convert_raw_to_processed);
>  int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
>                                enum iio_chan_info_enum attribute)
>  {
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
>         int ret;
>
> -       mutex_lock(&chan->indio_dev->info_exist_lock);
> +       mutex_lock(&iio_dev_opaque->info_exist_lock);
>         if (chan->indio_dev->info == NULL) {
>                 ret = -ENODEV;
>                 goto err_unlock;
> @@ -661,7 +666,7 @@ int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
>
>         ret = iio_channel_read(chan, val, val2, attribute);
>  err_unlock:
> -       mutex_unlock(&chan->indio_dev->info_exist_lock);
> +       mutex_unlock(&iio_dev_opaque->info_exist_lock);
>
>         return ret;
>  }
> @@ -676,9 +681,10 @@ EXPORT_SYMBOL_GPL(iio_read_channel_offset);
>  int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
>                                      unsigned int scale)
>  {
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
>         int ret;
>
> -       mutex_lock(&chan->indio_dev->info_exist_lock);
> +       mutex_lock(&iio_dev_opaque->info_exist_lock);
>         if (chan->indio_dev->info == NULL) {
>                 ret = -ENODEV;
>                 goto err_unlock;
> @@ -699,7 +705,7 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
>         }
>
>  err_unlock:
> -       mutex_unlock(&chan->indio_dev->info_exist_lock);
> +       mutex_unlock(&iio_dev_opaque->info_exist_lock);
>
>         return ret;
>  }
> @@ -733,9 +739,10 @@ int iio_read_avail_channel_attribute(struct iio_channel *chan,
>                                      const int **vals, int *type, int *length,
>                                      enum iio_chan_info_enum attribute)
>  {
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
>         int ret;
>
> -       mutex_lock(&chan->indio_dev->info_exist_lock);
> +       mutex_lock(&iio_dev_opaque->info_exist_lock);
>         if (!chan->indio_dev->info) {
>                 ret = -ENODEV;
>                 goto err_unlock;
> @@ -743,7 +750,7 @@ int iio_read_avail_channel_attribute(struct iio_channel *chan,
>
>         ret = iio_channel_read_avail(chan, vals, type, length, attribute);
>  err_unlock:
> -       mutex_unlock(&chan->indio_dev->info_exist_lock);
> +       mutex_unlock(&iio_dev_opaque->info_exist_lock);
>
>         return ret;
>  }
> @@ -815,10 +822,11 @@ static int iio_channel_read_max(struct iio_channel *chan,
>
>  int iio_read_max_channel_raw(struct iio_channel *chan, int *val)
>  {
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
>         int ret;
>         int type;
>
> -       mutex_lock(&chan->indio_dev->info_exist_lock);
> +       mutex_lock(&iio_dev_opaque->info_exist_lock);
>         if (!chan->indio_dev->info) {
>                 ret = -ENODEV;
>                 goto err_unlock;
> @@ -826,7 +834,7 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val)
>
>         ret = iio_channel_read_max(chan, val, NULL, &type, IIO_CHAN_INFO_RAW);
>  err_unlock:
> -       mutex_unlock(&chan->indio_dev->info_exist_lock);
> +       mutex_unlock(&iio_dev_opaque->info_exist_lock);
>
>         return ret;
>  }
> @@ -834,10 +842,11 @@ EXPORT_SYMBOL_GPL(iio_read_max_channel_raw);
>
>  int iio_get_channel_type(struct iio_channel *chan, enum iio_chan_type *type)
>  {
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
>         int ret = 0;
>         /* Need to verify underlying driver has not gone away */
>
> -       mutex_lock(&chan->indio_dev->info_exist_lock);
> +       mutex_lock(&iio_dev_opaque->info_exist_lock);
>         if (chan->indio_dev->info == NULL) {
>                 ret = -ENODEV;
>                 goto err_unlock;
> @@ -845,7 +854,7 @@ int iio_get_channel_type(struct iio_channel *chan, enum iio_chan_type *type)
>
>         *type = chan->channel->type;
>  err_unlock:
> -       mutex_unlock(&chan->indio_dev->info_exist_lock);
> +       mutex_unlock(&iio_dev_opaque->info_exist_lock);
>
>         return ret;
>  }
> @@ -861,9 +870,10 @@ static int iio_channel_write(struct iio_channel *chan, int val, int val2,
>  int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
>                                 enum iio_chan_info_enum attribute)
>  {
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
>         int ret;
>
> -       mutex_lock(&chan->indio_dev->info_exist_lock);
> +       mutex_lock(&iio_dev_opaque->info_exist_lock);
>         if (chan->indio_dev->info == NULL) {
>                 ret = -ENODEV;
>                 goto err_unlock;
> @@ -871,7 +881,7 @@ int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
>
>         ret = iio_channel_write(chan, val, val2, attribute);
>  err_unlock:
> -       mutex_unlock(&chan->indio_dev->info_exist_lock);
> +       mutex_unlock(&iio_dev_opaque->info_exist_lock);
>
>         return ret;
>  }
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index 02038fb2d291..538b4b5ef1a9 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -8,6 +8,7 @@
>   * @indio_dev:                 public industrial I/O device information
>   * @id:                        used to identify device internally
>   * @driver_module:             used to make it harder to undercut users
> + * @info_exist_lock:           lock to prevent use during removal
>   * @trig_readonly:             mark the current trigger immutable
>   * @event_interface:           event chrdevs associated with interrupt lines
>   * @attached_buffers:          array of buffers statically attached by the driver
> @@ -32,6 +33,7 @@ struct iio_dev_opaque {
>         struct iio_dev                  indio_dev;
>         int                             id;
>         struct module                   *driver_module;
> +       struct mutex                    info_exist_lock;
>         bool                            trig_readonly;
>         struct iio_event_interface      *event_interface;
>         struct iio_buffer               **attached_buffers;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index cbc9e9ece0a6..a12bbd8b1e74 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -510,7 +510,6 @@ struct iio_buffer_setup_ops {
>   * @label:              [DRIVER] unique name to identify which device this is
>   * @info:              [DRIVER] callbacks and constant info from driver
>   * @clock_id:          [INTERN] timestamping clock posix identifier
> - * @info_exist_lock:   [INTERN] lock to prevent use during removal
>   * @setup_ops:         [DRIVER] callbacks to call before and after buffer
>   *                     enable/disable
>   * @chrdev:            [INTERN] associated character device
> @@ -542,7 +541,6 @@ struct iio_dev {
>         const char                      *label;
>         const struct iio_info           *info;
>         clockid_t                       clock_id;
> -       struct mutex                    info_exist_lock;
>         const struct iio_buffer_setup_ops       *setup_ops;
>         struct cdev                     chrdev;
>
> --
> 2.31.1
>
