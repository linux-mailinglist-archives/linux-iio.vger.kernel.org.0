Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B045636C07B
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 10:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhD0IDA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 04:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhD0IC6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 04:02:58 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A480C061574
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 01:02:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gq23-20020a17090b1057b0290151869af68bso6661540pjb.4
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 01:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xcr/dvssiR1peLMOYlIhB5qNdm03USu5jxpBduxexKE=;
        b=tUIE35WCoEb21rV7Agnsovzs9Gf4lEGkT38mtWny4eC/JiMJIJeuKIdeX7eDviOpgB
         TyHpRKi0uCR5dCbb4kts08M1ddMTsT072wy3r481uuJi0jOuEUHOYBb8gOETnLRXD/UJ
         4I7PgtGhe/ZCMJFyyzOLO9NZooLrMGCOIiSnKwsmk3HP6lZaQEkfwoCV9Tm+GfRfFX/7
         gyyAHjarS3xAGhhcpKRj1aU0Dnyeox5/MYhN5MabeyU9ZNz0Mk+pJjFBYEtbgrIVQbvz
         /nZuognwkQf0J08gd/MI/FdqCRxtYyTqH6uxWjbfq+6Wc6dZn2UNptjY3LVRkoLPflG0
         spzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xcr/dvssiR1peLMOYlIhB5qNdm03USu5jxpBduxexKE=;
        b=fFc5auZZw9iyu0qvjHev9ZmkRNMANfSLL1iGY/0zk+rAbNk7PDlQ3xZil3IIq7IvfB
         PYt/sFqnUOGCAGm/TfKTDKMh7vXP/NfFqIfTdyhKtTr7IPAGzUt0vCL6IAyEpfHW4Gim
         +M7Z9fJJW2m8XBYso+lPOl3ATB4suM4ljfk/qn9jhTob69j1XSAO8SQMqxOaNy2MMc4k
         ewW2VZtgKKrrE+0UrWDoB7BkIBFNMRJiibc6vvpJBeNDIpQX3WffCej+WbLu8HCnSMpZ
         icQ7i3n0FznWZsTJ+hZjNiGANxwrTbn2uWJPuiRPAKck/LTlv8y+KcoWW+jMRIbfvS/r
         ehrg==
X-Gm-Message-State: AOAM532nz7j5yoOfi2VYNr/Dg0/PscYcQOjBriYPaZ3jCJNTVBRbw2jW
        XszFD3N6MAepB8O5zWWibktEGLNXNLLv9i2xAIE=
X-Google-Smtp-Source: ABdhPJx7cGUSBXdhsqX/WMAwWRMdoVAPsTMM75ft90lb7KgtB6FwxpzJECbZf2QcehAph137ZirjbJ4cZyaLvFOMYhE=
X-Received: by 2002:a17:90b:1995:: with SMTP id mv21mr3703019pjb.19.1619510533480;
 Tue, 27 Apr 2021 01:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210426174911.397061-1-jic23@kernel.org> <20210426174911.397061-10-jic23@kernel.org>
In-Reply-To: <20210426174911.397061-10-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 27 Apr 2021 11:02:02 +0300
Message-ID: <CA+U=DsrsFhH65HkdNSTFLXF3-rbpEYkZ5MvoXDmuSeniHampXA@mail.gmail.com>
Subject: Re: [PATCH 9/9] iio: core: move @clock_id from struct iio_dev to
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
> There is already an acessor function used to access it, making this
> move straight forward.

Right now the iio_device_get_clock() helper is only being used in the
Chrome EC core sensor driver.
Maybe later if that can be reworked without this helper, then it could
be made private to IIO core.
Though, chances are some other driver may come along later and ask for
it to be public again.

Anyway.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/industrialio-core.c | 14 +++++++++++++-
>  include/linux/iio/iio-opaque.h  |  2 ++
>  include/linux/iio/iio.h         | 12 +-----------
>  3 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 4a4c02fea152..efb4cf91c9e4 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -271,13 +271,25 @@ int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
>                 mutex_unlock(&indio_dev->mlock);
>                 return -EBUSY;
>         }
> -       indio_dev->clock_id = clock_id;
> +       iio_dev_opaque->clock_id = clock_id;
>         mutex_unlock(&indio_dev->mlock);
>
>         return 0;
>  }
>  EXPORT_SYMBOL(iio_device_set_clock);
>
> +/**
> + * iio_device_get_clock() - Retrieve current timestamping clock for the device
> + * @indio_dev: IIO device structure containing the device
> + */
> +clockid_t iio_device_get_clock(const struct iio_dev *indio_dev)
> +{
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +
> +       return iio_dev_opaque->clock_id;
> +}
> +EXPORT_SYMBOL(iio_device_get_clock);
> +
>  /**
>   * iio_get_time_ns() - utility function to get a time stamp for events etc
>   * @indio_dev: device
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index d7c3036861ac..c9504e9da571 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -24,6 +24,7 @@
>   * @legacy_scan_el_group:      attribute group for legacy scan elements attribute group
>   * @legacy_buffer_group:       attribute group for legacy buffer attributes group
>   * @scan_index_timestamp:      cache of the index to the timestamp
> + * @clock_id:                  timestamping clock posix identifier
>   * @chrdev:                    associated character device
>   * @flags:                     file ops related flags including busy flag.
>   * @debugfs_dentry:            device specific debugfs dentry
> @@ -51,6 +52,7 @@ struct iio_dev_opaque {
>         struct attribute_group          legacy_buffer_group;
>
>         unsigned int                    scan_index_timestamp;
> +       clockid_t                       clock_id;
>         struct cdev                     chrdev;
>         unsigned long                   flags;
>
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index ed0537015eee..5606a3f4c4cb 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -509,7 +509,6 @@ struct iio_buffer_setup_ops {
>   * @name:              [DRIVER] name of the device.
>   * @label:              [DRIVER] unique name to identify which device this is
>   * @info:              [DRIVER] callbacks and constant info from driver
> - * @clock_id:          [INTERN] timestamping clock posix identifier
>   * @setup_ops:         [DRIVER] callbacks to call before and after buffer
>   *                     enable/disable
>   * @priv:              [DRIVER] reference to driver's private information
> @@ -538,7 +537,6 @@ struct iio_dev {
>         const char                      *name;
>         const char                      *label;
>         const struct iio_info           *info;
> -       clockid_t                       clock_id;
>         const struct iio_buffer_setup_ops       *setup_ops;
>
>         void                            *priv;
> @@ -589,15 +587,7 @@ static inline void iio_device_put(struct iio_dev *indio_dev)
>                 put_device(&indio_dev->dev);
>  }
>
> -/**
> - * iio_device_get_clock() - Retrieve current timestamping clock for the device
> - * @indio_dev: IIO device structure containing the device
> - */
> -static inline clockid_t iio_device_get_clock(const struct iio_dev *indio_dev)
> -{
> -       return indio_dev->clock_id;
> -}
> -
> +clockid_t iio_device_get_clock(const struct iio_dev *indio_dev);
>  int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id);
>
>  /**
> --
> 2.31.1
>
