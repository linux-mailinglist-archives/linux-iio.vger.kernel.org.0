Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED1C476B1A
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 08:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhLPHia (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 02:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbhLPHi3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 02:38:29 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C94C061574
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 23:38:29 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z9-20020a17090a7b8900b001b13558eadaso16404pjc.4
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 23:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qmzsfYTBmdjXmdx56Uhls8/jMqQtIoYCs82OtPBJwmY=;
        b=lDfrKPKMVCu3tN6a4I4Qf3uYqmMdYYLQcHrBSBYWKvSgCfjj91n6zB9ODb8h2YfIuu
         0l5E2ky8PIUnfChXuhKkAn6TCTBIjmlVE/bIiTQ8IuniVLEG3Ky6C5nThooY65/Ne3uL
         G+a8nZ2Xf5PrLhYAKpsG5Wp5YxilNj19hkteZjkx5QXLr6m68J+LHlzlwSCQO+m7prZq
         t+2ifa3VS1N5ghiVUwXXhQe+ZbhxPMNJqP694YsA1VVqqGZBRAtIdVLsAb1wQ7wfkCjV
         53sLNYykoc2gyjalH9hcpJCJHu9xBLXXfHD8OweEYDB0BJoi8i83cQ5ssLWUTKLpc0H9
         ZsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmzsfYTBmdjXmdx56Uhls8/jMqQtIoYCs82OtPBJwmY=;
        b=RnPiCBjAoEVzi+8YcpXovxmBzue1YypgGwKBFIZQZvZ3rtEKbcrjvgOMGr4x3K3VJ7
         lnBXkKamYhXU4nVksnDVuMkVgr2LIEKZ0Lt+P50nHdM1CUvkrFBXbhIrP42s4ogMdaWE
         HuTeM2GRjkDHD7oKOsUgSALGsGdcBHcf5c8q+vD9P3pgPu2vxjuJ6/H3Q3HsWuLPYkgv
         0Vg89iTu+fSTOUu73frT5+lGh8qZDF2RFEvZYfSt2JFQ2okm+siRkMvogNxsOZmOg9uf
         Xagvjv21k/Ssl311VFKVxnpBdu/hs+Y9cWUzj1z6Vj46dd9SbYhd+3cmrngTVZUTbcNA
         pekA==
X-Gm-Message-State: AOAM531dmatpM3IZTzDZVy1MYjYqRtABuM8IsmMB2+tYTyDSPh7RUpJQ
        BZOoS3mPL+qyIJJJd/us6QxOGTOPj14jKYGgqlFdRbFqnMmF4Q==
X-Google-Smtp-Source: ABdhPJwsMxDConyoZJ7BxpmNLX+z7jNFpIdJGgpQd8yFJreAIeh5+RaHW77GJ5x3qa3U/WmNUlD21CaBuYXwKA0+Ve0=
X-Received: by 2002:a17:90a:3d42:: with SMTP id o2mr4569239pjf.150.1639640308866;
 Wed, 15 Dec 2021 23:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20211215151344.163036-1-miquel.raynal@bootlin.com> <20211215151344.163036-7-miquel.raynal@bootlin.com>
In-Reply-To: <20211215151344.163036-7-miquel.raynal@bootlin.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 16 Dec 2021 09:38:17 +0200
Message-ID: <CA+U=DsrD6pqpYs=D_YtkwJntcUCjUJi8qS49Dg5nLTC9yqvWZA@mail.gmail.com>
Subject: Re: [PATCH 06/10] iio: core: Hide read accesses to iio_dev->currentmode
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 15, 2021 at 10:04 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> In order to later move this variable within the opaque structure, let's
> create a helper for accessing it in read-only mode. This helper will be
> exposed and kept accessible for the few drivers that could need it. The
> write access to this variable however should be fully reserved to the
> core so in a second step we will add another helper, not exported to the
> device drivers.

The naming needs a bit of discussion.
I would have gone for iio_dev_get_current_mode() or something like that.

And I would probably not use this helper inside the IIO core stuff
(i.e. drivers/iio/industrialio-*.c files)
Mostly because [if now used only in IIO core] it makes the
"indio_dev->currentmode" assignment and access easier to trace.

There's also the change that accessing "indio_dev->currentmode"
becomes a function-symbol which has rules at link-time and may add
some new jmp/ret instructions.
But It doesn't look like this is used in any fast-paths, so it's not
an issue as much.

>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/iio/accel/bmc150-accel-core.c |  4 ++--
>  drivers/iio/adc/at91-sama5d2_adc.c    |  4 ++--
>  drivers/iio/industrialio-buffer.c     |  6 +++---
>  drivers/iio/industrialio-core.c       | 11 +++++++++++
>  drivers/iio/industrialio-trigger.c    |  2 +-
>  include/linux/iio/iio.h               |  9 ++++++---
>  6 files changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index b0678c351e82..0a191463d462 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -1525,7 +1525,7 @@ static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
>         struct bmc150_accel_data *data = iio_priv(indio_dev);
>         int ret = 0;
>
> -       if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
> +       if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
>                 return 0;
>
>         mutex_lock(&data->mutex);
> @@ -1557,7 +1557,7 @@ static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
>  {
>         struct bmc150_accel_data *data = iio_priv(indio_dev);
>
> -       if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
> +       if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
>                 return 0;
>
>         mutex_lock(&data->mutex);
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 4c922ef634f8..2b7f6371950e 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1117,7 +1117,7 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
>                 return at91_adc_configure_touch(st, true);
>
>         /* if we are not in triggered mode, we cannot enable the buffer. */
> -       if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
> +       if (!(iio_get_internal_mode(indio_dev) & INDIO_ALL_TRIGGERED_MODES))
>                 return -EINVAL;
>
>         /* we continue with the triggered buffer */
> @@ -1159,7 +1159,7 @@ static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
>                 return at91_adc_configure_touch(st, false);
>
>         /* if we are not in triggered mode, nothing to do here */
> -       if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
> +       if (!(iio_get_internal_mode(indio_dev) & INDIO_ALL_TRIGGERED_MODES))
>                 return -EINVAL;
>
>         /*
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index e180728914c0..f4dbab7c44fa 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1101,7 +1101,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>                         goto err_disable_buffers;
>         }
>
> -       if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +       if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED) {
>                 ret = iio_trigger_attach_poll_func(indio_dev->trig,
>                                                    indio_dev->pollfunc);
>                 if (ret)
> @@ -1120,7 +1120,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>         return 0;
>
>  err_detach_pollfunc:
> -       if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +       if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED) {
>                 iio_trigger_detach_poll_func(indio_dev->trig,
>                                              indio_dev->pollfunc);
>         }
> @@ -1162,7 +1162,7 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
>                         ret = ret2;
>         }
>
> -       if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +       if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED) {
>                 iio_trigger_detach_poll_func(indio_dev->trig,
>                                              indio_dev->pollfunc);
>         }
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 463a63d5bf56..a1d6e30d034a 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -2057,6 +2057,17 @@ void iio_device_release_direct_mode(struct iio_dev *indio_dev)
>  }
>  EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
>
> +/**
> + * iio_get_internal_mode() - helper function providing read-only access to the
> + *                          opaque @currentmode variable
> + * @indio_dev:         IIO device structure for device
> + **/
> +int iio_get_internal_mode(struct iio_dev *indio_dev)
> +{
> +       return indio_dev->currentmode;
> +}
> +EXPORT_SYMBOL_GPL(iio_get_internal_mode);
> +
>  subsys_initcall(iio_init);
>  module_exit(iio_exit);
>
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index b23caa2f2aa1..71b07d6111d6 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -411,7 +411,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
>         int ret;
>
>         mutex_lock(&indio_dev->mlock);
> -       if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +       if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED) {
>                 mutex_unlock(&indio_dev->mlock);
>                 return -EBUSY;
>         }
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 0312da2e83f8..dcab17f44552 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -677,15 +677,18 @@ struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv);
>  __printf(2, 3)
>  struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
>                                            const char *fmt, ...);
> +
> +int iio_get_internal_mode(struct iio_dev *indio_dev);
> +
>  /**
>   * iio_buffer_enabled() - helper function to test if the buffer is enabled
>   * @indio_dev:         IIO device structure for device
>   **/
>  static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
>  {
> -       return indio_dev->currentmode
> -               & (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
> -                  INDIO_BUFFER_SOFTWARE);
> +       return iio_get_internal_mode(indio_dev) &
> +               (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
> +                INDIO_BUFFER_SOFTWARE);
>  }
>
>  /**
> --
> 2.27.0
>
