Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E0E36D2A4
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 08:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhD1G5F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 02:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1G5E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Apr 2021 02:57:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3303C061574
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 23:56:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t13so6193018pji.4
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 23:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K1SmWM8zbaNmD/GXtCtDS3XZWmxfIIBYSa/P7oGNuQc=;
        b=P5meEWDgXKx1cFgx4bYANKjv5IYoGc1GByRUlx6lC+5Wfzv05/KG/X5EVlew+5aSmb
         EKCTMKtK6AkVu4o0bt+Mg1SZ6Y7/k7IZYQqPwt89dPz3LqWUGmkf5+9fJfO5kcGCxnS7
         8oBV1MsiEjogihTu3/iS/DppDIKtXhE57X2bj3TI2wZWYfQ74d0kuSzOGFS1Vu/ahtIP
         zIDQXvbnkOCJ09Vg7d8S5ZrgSq/2fSr4TNQh/hbCtJThiCxxsYHUdXHAe4qlpe42YlHF
         Jgo2WPme+zCcddgpKlFR90nF2cmFXHEXqcjFgfwhwCXROVe9MrZA/yjVI71kSyrzBl6w
         KHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1SmWM8zbaNmD/GXtCtDS3XZWmxfIIBYSa/P7oGNuQc=;
        b=fU207gCof13gts74db4nqqZO+fAytw63pBLJs2G0TzBFxpIxSg6wJd9vOOMA607G/D
         7pOPJC0Ma9EgojMezHSkB6ruSxqE52DBU4r/eMX2CymMtHuXr5XBrPtZVeUIvf3G110e
         pZ2+k8gyQksFarN/c4MUJ7la1VdDmfI7oVoJc7ZVDbAHQQJafbcQMwyHpuhrkf+ZOxZj
         aFjxz/UKPFIXG5BNhwhF4x4E8wxq0Ip2cAhkY03BVpYC1poi8pfMW4kBc9/ZXRC+arMQ
         kh+DVFtNEy44SmE6ltuTN9zgwdtYm5R39hpIZ/jGfNE7ZytgaUgjV7aMfFOF5hHpQX8W
         MqUQ==
X-Gm-Message-State: AOAM5322H+0bpISxs5lwKaQgao0ebHtWSwbb5FkEOhzahAKVd15txSlX
        lntN6cjyLGTAhTpXA/gn5QA9jQTP3/qrc/fF3oY=
X-Google-Smtp-Source: ABdhPJwiOu+pd0KB1j0fb97O3HWOi85ZqgPwPU8TjBOEGARCoGWm0kJh/NG6C/2vlUoEnVJAXZx2zL7FmzFGmm6zkHY=
X-Received: by 2002:a17:90b:1995:: with SMTP id mv21mr2486346pjb.19.1619592962492;
 Tue, 27 Apr 2021 23:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210426174911.397061-1-jic23@kernel.org> <20210426174911.397061-4-jic23@kernel.org>
In-Reply-To: <20210426174911.397061-4-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 28 Apr 2021 09:55:51 +0300
Message-ID: <CA+U=DsoWacU=LeVbAPDxLLE6WJY9ek=+9YJCgQymwZ1pF5Cauw@mail.gmail.com>
Subject: Re: [PATCH 3/9] iio: core: move @driver_module from struct iio_dev to
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
> Continuing move to hide internal elements from drivers, move this structure
> element over.  It's only accessed from iio core files so this one was
> straight forward and no accessor functions are needed.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/industrialio-core.c    | 2 +-
>  drivers/iio/industrialio-trigger.c | 9 ++++++---
>  include/linux/iio/iio-opaque.h     | 2 ++
>  include/linux/iio/iio.h            | 3 ---
>  4 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index c16b8f344c93..8c38f1f6e075 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1859,7 +1859,7 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>         if (!indio_dev->info)
>                 return -EINVAL;
>
> -       indio_dev->driver_module = this_mod;
> +       iio_dev_opaque->driver_module = this_mod;
>         /* If the calling driver did not initialize of_node, do it here */
>         if (!indio_dev->dev.of_node && indio_dev->dev.parent)
>                 indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 3236647b2c37..b489eeeb0004 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -13,6 +13,7 @@
>  #include <linux/slab.h>
>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/iio-opaque.h>
>  #include <linux/iio/trigger.h>
>  #include "iio_core.h"
>  #include "iio_core_trigger.h"
> @@ -240,12 +241,13 @@ static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
>  int iio_trigger_attach_poll_func(struct iio_trigger *trig,
>                                  struct iio_poll_func *pf)
>  {
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(pf->indio_dev);
>         bool notinuse =
>                 bitmap_empty(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
>         int ret = 0;
>
>         /* Prevent the module from being removed whilst attached to a trigger */
> -       __module_get(pf->indio_dev->driver_module);
> +       __module_get(iio_dev_opaque->driver_module);
>
>         /* Get irq number */
>         pf->irq = iio_trigger_get_irq(trig);
> @@ -284,13 +286,14 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
>  out_put_irq:
>         iio_trigger_put_irq(trig, pf->irq);
>  out_put_module:
> -       module_put(pf->indio_dev->driver_module);
> +       module_put(iio_dev_opaque->driver_module);
>         return ret;
>  }
>
>  int iio_trigger_detach_poll_func(struct iio_trigger *trig,
>                                  struct iio_poll_func *pf)
>  {
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(pf->indio_dev);
>         bool no_other_users =
>                 bitmap_weight(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER) == 1;
>         int ret = 0;
> @@ -304,7 +307,7 @@ int iio_trigger_detach_poll_func(struct iio_trigger *trig,
>                 trig->attached_own_device = false;
>         iio_trigger_put_irq(trig, pf->irq);
>         free_irq(pf->irq, pf);
> -       module_put(pf->indio_dev->driver_module);
> +       module_put(iio_dev_opaque->driver_module);
>
>         return ret;
>  }
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index f876e3aede2c..96dd265103d0 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -7,6 +7,7 @@
>   * struct iio_dev_opaque - industrial I/O device opaque information
>   * @indio_dev:                 public industrial I/O device information
>   * @id:                        used to identify device internally
> + * @driver_module:             used to make it harder to undercut users
>   * @event_interface:           event chrdevs associated with interrupt lines
>   * @attached_buffers:          array of buffers statically attached by the driver
>   * @attached_buffers_cnt:      number of buffers in the array of statically attached buffers
> @@ -28,6 +29,7 @@
>  struct iio_dev_opaque {
>         struct iio_dev                  indio_dev;
>         int                             id;
> +       struct module                   *driver_module;
>         struct iio_event_interface      *event_interface;
>         struct iio_buffer               **attached_buffers;
>         unsigned int                    attached_buffers_cnt;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 569861d5887a..9e8e1358a032 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -488,7 +488,6 @@ struct iio_buffer_setup_ops {
>
>  /**
>   * struct iio_dev - industrial I/O device
> - * @driver_module:     [INTERN] used to make it harder to undercut users
>   * @modes:             [DRIVER] operating modes supported by device
>   * @currentmode:       [DRIVER] current operating mode
>   * @dev:               [DRIVER] device structure, should be assigned a parent
> @@ -522,8 +521,6 @@ struct iio_buffer_setup_ops {
>   *                     **MUST** be accessed **ONLY** via iio_priv() helper
>   */
>  struct iio_dev {
> -       struct module                   *driver_module;
> -
>         int                             modes;
>         int                             currentmode;
>         struct device                   dev;
> --
> 2.31.1
>
