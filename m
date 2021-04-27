Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BB836C07F
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 10:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhD0IEC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 04:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhD0IEB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 04:04:01 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F75CC061574
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 01:03:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id lp8so404527pjb.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 01:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5s23WhGhGu7PYhb37njhkBFV52eNxO04MnKCADrPVkM=;
        b=Vor6rDeYlIX4hT0MpXacujU8JySj7Loo9FD5ZIrYJyPIB5hPig3lcZUxdihcN88r1w
         6LnbhmGgrPw7pLfvxG93ahPP5HiXWY0RvtRqtBXhTubUPDo6Bh6zQlCknvVeqPBAFaut
         xvRpdxWDflNF3FQXE522fNYmJazniiUsbY4k4MhQiFbDInkqfl2NaCdUD0Gx2qfQc7lx
         2D0CqYb8/WqBWxNWBzwLsv2NbbylGcobiT3BFCM7RiXPzhiPtJPGJhBIb+jiYqt/l3T/
         Gh3gdak49rBSll/4ZAEu71QIg/a/h2jO8KMbu7e8NhnG4pBUYcTVQ+nxJDxfJnXDM5Ii
         fZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5s23WhGhGu7PYhb37njhkBFV52eNxO04MnKCADrPVkM=;
        b=DLhyna1RnQkwXGjsvV/osDypy4xZGCQRlbN82YHAJXxfy85wtk5eGnwKh6v859JhZX
         JYCaouc8fgMcJS/dKUm8bhyirYQfL5MfBv+f+OJRcsi1rnY66lXzpGVN1Nm2Jt7Z1GpS
         qbYvX9p3hxbdUu83oE4pMpRUjIKgshWJQ7XIYqcPQRL/svAn96Ujt+W2zWboigP6tRD0
         2dX9cH8qJNm0Hl7ZdyVagC0e/zI95RRJfzez2SaD3rZ5ExJDMoEMG5jAmn0rRdoBPQ+8
         ufCYxGrUboWKsNtCO+NyjH95cHfE6UWfPoYe4leC+vK45gZAb9/7Fxo1AOJFTMbyN7qv
         KpYg==
X-Gm-Message-State: AOAM5321L9TkqlpOjP5DxREZYFjwXkZsRmTLklkO+fgcxUKGq8P1IGyc
        VPZ44vK3tKk8xNU4S/+k95AOpmq5jGDVdJdWOwCklFe1WAEPjt8h
X-Google-Smtp-Source: ABdhPJznkjKZabw9z6Rre7a/JCaGi22fhvk1oYcSDI74P0mqawZAmMhpliD7VHwfoWKAqvWghr7kPJ1tnmymgViXVdI=
X-Received: by 2002:a17:90a:ae10:: with SMTP id t16mr26637490pjq.86.1619510597909;
 Tue, 27 Apr 2021 01:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210426174911.397061-1-jic23@kernel.org> <20210426174911.397061-5-jic23@kernel.org>
In-Reply-To: <20210426174911.397061-5-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 27 Apr 2021 11:03:06 +0300
Message-ID: <CA+U=Dsro4QKn1sGBwryDgpuNVuLKLYx7SzsM1q-+mUBrsqaY1w@mail.gmail.com>
Subject: Re: [PATCH 4/9] iio: core: move @trig_readonly from struct iio_dev to
 struct iio_dev_opaque
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
> This is only set via the iio_trig_set_immutable() call and later used
> by the IIO core so there is no benefit in drivers being able to access
> it.


Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>


>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/industrialio-trigger.c | 10 +++++++---
>  include/linux/iio/iio-opaque.h     |  2 ++
>  include/linux/iio/iio.h            |  2 --
>  3 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index b489eeeb0004..b23caa2f2aa1 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -117,14 +117,17 @@ EXPORT_SYMBOL(iio_trigger_unregister);
>
>  int iio_trigger_set_immutable(struct iio_dev *indio_dev, struct iio_trigger *trig)
>  {
> +       struct iio_dev_opaque *iio_dev_opaque;
> +
>         if (!indio_dev || !trig)
>                 return -EINVAL;
>
> +       iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>         mutex_lock(&indio_dev->mlock);
> -       WARN_ON(indio_dev->trig_readonly);
> +       WARN_ON(iio_dev_opaque->trig_readonly);
>
>         indio_dev->trig = iio_trigger_get(trig);
> -       indio_dev->trig_readonly = true;
> +       iio_dev_opaque->trig_readonly = true;
>         mutex_unlock(&indio_dev->mlock);
>
>         return 0;
> @@ -402,6 +405,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
>                                          size_t len)
>  {
>         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>         struct iio_trigger *oldtrig = indio_dev->trig;
>         struct iio_trigger *trig;
>         int ret;
> @@ -411,7 +415,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
>                 mutex_unlock(&indio_dev->mlock);
>                 return -EBUSY;
>         }
> -       if (indio_dev->trig_readonly) {
> +       if (iio_dev_opaque->trig_readonly) {
>                 mutex_unlock(&indio_dev->mlock);
>                 return -EPERM;
>         }
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index 96dd265103d0..10aa97239117 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -8,6 +8,7 @@
>   * @indio_dev:                 public industrial I/O device information
>   * @id:                        used to identify device internally
>   * @driver_module:             used to make it harder to undercut users
> + * @trig_readonly:             mark the current trigger immutable
>   * @event_interface:           event chrdevs associated with interrupt lines
>   * @attached_buffers:          array of buffers statically attached by the driver
>   * @attached_buffers_cnt:      number of buffers in the array of statically attached buffers
> @@ -30,6 +31,7 @@ struct iio_dev_opaque {
>         struct iio_dev                  indio_dev;
>         int                             id;
>         struct module                   *driver_module;
> +       bool                            trig_readonly;
>         struct iio_event_interface      *event_interface;
>         struct iio_buffer               **attached_buffers;
>         unsigned int                    attached_buffers_cnt;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 9e8e1358a032..672f141f74c5 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -503,7 +503,6 @@ struct iio_buffer_setup_ops {
>   * @scan_timestamp:    [INTERN] set if any buffers have requested timestamp
>   * @scan_index_timestamp:[INTERN] cache of the index to the timestamp
>   * @trig:              [INTERN] current device trigger (buffer modes)
> - * @trig_readonly:     [INTERN] mark the current trigger immutable
>   * @pollfunc:          [DRIVER] function run on trigger being received
>   * @pollfunc_event:    [DRIVER] function run on events trigger being received
>   * @channels:          [DRIVER] channel specification structure table
> @@ -535,7 +534,6 @@ struct iio_dev {
>         bool                            scan_timestamp;
>         unsigned                        scan_index_timestamp;
>         struct iio_trigger              *trig;
> -       bool                            trig_readonly;
>         struct iio_poll_func            *pollfunc;
>         struct iio_poll_func            *pollfunc_event;
>
> --
> 2.31.1
>
