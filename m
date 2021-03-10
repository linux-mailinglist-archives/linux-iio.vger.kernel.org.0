Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195263336EB
	for <lists+linux-iio@lfdr.de>; Wed, 10 Mar 2021 09:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhCJIGT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Mar 2021 03:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhCJIGK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Mar 2021 03:06:10 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FD5C06174A
        for <linux-iio@vger.kernel.org>; Wed, 10 Mar 2021 00:06:10 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id h18so14764709ils.2
        for <linux-iio@vger.kernel.org>; Wed, 10 Mar 2021 00:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kj4vGU4wjVI8DcW+rTwjlUAeB2iWQEDbFg6/GM3LgUk=;
        b=N+7xZooQD1/F/YMK6/TdG1aLknZYxW3Xh4BVGnDKOPLfXdcbKZn2A8D9f5I8lCiSwD
         gE/1wOJLibHirfRr5ujowNSIlj6LRO+iHwxFEHlAfYHig59RfANEbqneQKfdh3hqq2NC
         d/pCNH7Ze/BMRr/ottFeQr0qujuUiqR5iD0rDeeoy8MBqU2CVM0eZrVh5g56WY5UBj6D
         D55eIVHF6ZGtmdZB4Jc2J4OafEvs2vNZf+m6MK5HKCcD7pYIvGn5S9x7vLY9sJfQeMkY
         of5uxsDv/GcrXlPLcFzlEQJVcmJ5xU+p5oBEa9EHb9aiy4A3BnqlDwmC+TycOo7Ja+9W
         o7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kj4vGU4wjVI8DcW+rTwjlUAeB2iWQEDbFg6/GM3LgUk=;
        b=hzkoPL2nUH+AGUu9MXWHT5wRYr11Lt5HAJAOfNal25/rYi2apsyr2ogdlvirBmIR/U
         0KzAkXz/j8PKok6v2dzjZ4wv4RRF7L/8U3F/FrmtCtwxygeSoJ7ZU/HdzrHvKdhYrhgU
         3KXgfhnwassA4o0rs/8s5ybOHXndNTTKtNyth8EotDQtgYpC+kx05myZrC6kemsCgh8e
         SXSApHbTNPv45zVkFb0gDcvlswWVmVsIQeW1q6VHJG2zUhWSDWNQoFbZS8X6Mk4BKgsR
         AYEZeGtv98pr028YcN3+/aEONtWtjzY56txeN2d/PjpK88bEejrD0XhLBBcg8I3TvfeG
         Q2fw==
X-Gm-Message-State: AOAM533ko6YJgX9aoYbenPNJtgDWGgStNvyNpPnX4tv5CDpp0bS44wCP
        bFoOVMINPCEetccf5P/Prnhp73WmCLXzH5VUcAM=
X-Google-Smtp-Source: ABdhPJyowrT+g05S1UJojKXjpYs5AL4rGr0c6xyBcddB7MBCjMiZR6lyIsjdsBuB8l4gWBgv3LAO1uElm+fTr9tisco=
X-Received: by 2002:a05:6e02:1be1:: with SMTP id y1mr1769937ilv.101.1615363569885;
 Wed, 10 Mar 2021 00:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20210309193620.2176163-1-gwendal@chromium.org> <20210309193620.2176163-2-gwendal@chromium.org>
In-Reply-To: <20210309193620.2176163-2-gwendal@chromium.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 10 Mar 2021 10:05:58 +0200
Message-ID: <CA+U=Dsouu_HLB-sZhn-GGNDQedw4UD8576ZSLz6ohqKSmXFEsQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] iio: set default trig->dev.parent
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 9, 2021 at 9:36 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> When allocated with [devm_]iio_trigger_alloc(), set trig device parent to
> the device the trigger is allocated for by default.
>
> It can always be reassigned in the probe routine.
>
> Change iio_trigger_alloc() API to add the device pointer to be coherent
> with devm_iio_trigger_alloc, using similar interface to
> iio_device_alloc().

Some trigger parents are being removed in this patch, vs being removed
in a separate patch [as done in other drivers].
My only note is that this should be a bit more consistent.
i.e. All parents removed in this patch, or all parents removed in
separate patches; right now, it's a mix of both

Maybe it's a good idea to squash the removal of all parent assignments
in this patch to see easier when they get moved as parameters of
{devm_}iio_trigger_alloc().
There aren't too many assignments of parents to triggers to make a
single patch be difficult to review;

>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes in v4:
> - Allow lines to be greater than 80 characters.
> - Improve alignment.
>
> Changes in v3:
> - xilinx-xadc-core.c is not using iio_trigger_alloc anymore.
> - use parent as argumnet to be consistent with iio_device_alloc().
>
>  drivers/iio/accel/bma180.c                    |  3 +-
>  drivers/iio/adc/ad_sigma_delta.c              |  6 ++--
>  drivers/iio/adc/at91_adc.c                    |  3 +-
>  .../common/hid-sensors/hid-sensor-trigger.c   |  4 +--
>  .../common/st_sensors/st_sensors_trigger.c    |  4 +--
>  drivers/iio/gyro/itg3200_buffer.c             |  3 +-
>  drivers/iio/industrialio-trigger.c            | 34 +++++++++++--------
>  drivers/iio/trigger/iio-trig-hrtimer.c        |  2 +-
>  drivers/iio/trigger/iio-trig-interrupt.c      |  2 +-
>  drivers/iio/trigger/iio-trig-loop.c           |  2 +-
>  drivers/iio/trigger/iio-trig-sysfs.c          |  3 +-
>  include/linux/iio/iio.h                       |  2 +-
>  include/linux/iio/trigger.h                   |  3 +-
>  13 files changed, 37 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 71f85a3e525b2..b8a7469cdae41 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -1044,7 +1044,7 @@ static int bma180_probe(struct i2c_client *client,
>         indio_dev->info = &bma180_info;
>
>         if (client->irq > 0) {
> -               data->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
> +               data->trig = iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
>                         indio_dev->id);
>                 if (!data->trig) {
>                         ret = -ENOMEM;
> @@ -1059,7 +1059,6 @@ static int bma180_probe(struct i2c_client *client,
>                         goto err_trigger_free;
>                 }
>
> -               data->trig->dev.parent = dev;
>                 data->trig->ops = &bma180_trigger_ops;
>                 iio_trigger_set_drvdata(data->trig, indio_dev);
>                 indio_dev->trig = iio_trigger_get(data->trig);
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 3a6f239d4acca..9289812c0a946 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -475,8 +475,9 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
>         struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
>         int ret;
>
> -       sigma_delta->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
> -                                               indio_dev->id);
> +       sigma_delta->trig = iio_trigger_alloc(&sigma_delta->spi->dev,
> +                                             "%s-dev%d", indio_dev->name,
> +                                             indio_dev->id);
>         if (sigma_delta->trig == NULL) {
>                 ret = -ENOMEM;
>                 goto error_ret;
> @@ -496,7 +497,6 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
>                 sigma_delta->irq_dis = true;
>                 disable_irq_nosync(sigma_delta->spi->irq);
>         }
> -       sigma_delta->trig->dev.parent = &sigma_delta->spi->dev;
>         iio_trigger_set_drvdata(sigma_delta->trig, sigma_delta);
>
>         ret = iio_trigger_register(sigma_delta->trig);
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 70750abb5dead..0b5f0c91d0d73 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -625,12 +625,11 @@ static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *idev,
>         struct iio_trigger *trig;
>         int ret;
>
> -       trig = iio_trigger_alloc("%s-dev%d-%s", idev->name,
> +       trig = iio_trigger_alloc(idev->dev.parent, "%s-dev%d-%s", idev->name,
>                                  idev->id, trigger->name);
>         if (trig == NULL)
>                 return NULL;
>
> -       trig->dev.parent = idev->dev.parent;
>         iio_trigger_set_drvdata(trig, idev);
>         trig->ops = &at91_adc_trigger_ops;
>
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 064c32bec9c7b..95ddccb44f1c8 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -255,14 +255,14 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
>                 return ret;
>         }
>
> -       trig = iio_trigger_alloc("%s-dev%d", name, indio_dev->id);
> +       trig = iio_trigger_alloc(indio_dev->dev.parent,
> +                                "%s-dev%d", name, indio_dev->id);
>         if (trig == NULL) {
>                 dev_err(&indio_dev->dev, "Trigger Allocate Failed\n");
>                 ret = -ENOMEM;
>                 goto error_triggered_buffer_cleanup;
>         }
>
> -       trig->dev.parent = indio_dev->dev.parent;
>         iio_trigger_set_drvdata(trig, attrb);
>         trig->ops = &hid_sensor_trigger_ops;
>         ret = iio_trigger_register(trig);
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 2dbd2646e44e9..0b511665dee5f 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -123,7 +123,8 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>         unsigned long irq_trig;
>         int err;
>
> -       sdata->trig = iio_trigger_alloc("%s-trigger", indio_dev->name);
> +       sdata->trig = iio_trigger_alloc(sdata->dev, "%s-trigger",
> +                                       indio_dev->name);
>         if (sdata->trig == NULL) {
>                 dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n");
>                 return -ENOMEM;
> @@ -131,7 +132,6 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>
>         iio_trigger_set_drvdata(sdata->trig, indio_dev);
>         sdata->trig->ops = trigger_ops;
> -       sdata->trig->dev.parent = sdata->dev;
>
>         irq_trig = irqd_get_trigger_type(irq_get_irq_data(sdata->irq));
>         /*
> diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
> index 1c3c1bd53374a..af0aaa146f0ce 100644
> --- a/drivers/iio/gyro/itg3200_buffer.c
> +++ b/drivers/iio/gyro/itg3200_buffer.c
> @@ -113,7 +113,7 @@ int itg3200_probe_trigger(struct iio_dev *indio_dev)
>         int ret;
>         struct itg3200 *st = iio_priv(indio_dev);
>
> -       st->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
> +       st->trig = iio_trigger_alloc(&st->i2c->dev, "%s-dev%d", indio_dev->name,
>                                      indio_dev->id);
>         if (!st->trig)
>                 return -ENOMEM;
> @@ -127,7 +127,6 @@ int itg3200_probe_trigger(struct iio_dev *indio_dev)
>                 goto error_free_trig;
>
>
> -       st->trig->dev.parent = &st->i2c->dev;
>         st->trig->ops = &itg3200_trigger_ops;
>         iio_trigger_set_drvdata(st->trig, indio_dev);
>         ret = iio_trigger_register(st->trig);
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index ea3c9859b2589..0eba9bd9fa360 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -514,8 +514,10 @@ static void iio_trig_subirqunmask(struct irq_data *d)
>         trig->subirqs[d->irq - trig->subirq_base].enabled = true;
>  }
>
> -static __printf(1, 0)
> -struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
> +static __printf(2, 0)
> +struct iio_trigger *viio_trigger_alloc(struct device *parent,
> +                                      const char *fmt,
> +                                      va_list vargs)
>  {
>         struct iio_trigger *trig;
>         int i;
> @@ -524,6 +526,7 @@ struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
>         if (!trig)
>                 return NULL;
>
> +       trig->dev.parent = parent;
>         trig->dev.type = &iio_trig_type;
>         trig->dev.bus = &iio_bus_type;
>         device_initialize(&trig->dev);
> @@ -559,13 +562,23 @@ struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
>         return NULL;
>  }
>
> -struct iio_trigger *iio_trigger_alloc(const char *fmt, ...)
> +/**
> + * iio_trigger_alloc - Allocate a trigger
> + * @parent:            Device to allocate iio_trigger for
> + * @fmt:               trigger name format. If it includes format
> + *                     specifiers, the additional arguments following
> + *                     format are formatted and inserted in the resulting
> + *                     string replacing their respective specifiers.
> + * RETURNS:
> + * Pointer to allocated iio_trigger on success, NULL on failure.
> + */
> +struct iio_trigger *iio_trigger_alloc(struct device *parent, const char *fmt, ...)
>  {
>         struct iio_trigger *trig;
>         va_list vargs;
>
>         va_start(vargs, fmt);
> -       trig = viio_trigger_alloc(fmt, vargs);
> +       trig = viio_trigger_alloc(parent, fmt, vargs);
>         va_end(vargs);
>
>         return trig;
> @@ -586,20 +599,13 @@ static void devm_iio_trigger_release(struct device *dev, void *res)
>
>  /**
>   * devm_iio_trigger_alloc - Resource-managed iio_trigger_alloc()
> - * @dev:               Device to allocate iio_trigger for
> - * @fmt:               trigger name format. If it includes format
> - *                     specifiers, the additional arguments following
> - *                     format are formatted and inserted in the resulting
> - *                     string replacing their respective specifiers.
> - *
>   * Managed iio_trigger_alloc.  iio_trigger allocated with this function is
>   * automatically freed on driver detach.
>   *
>   * RETURNS:
>   * Pointer to allocated iio_trigger on success, NULL on failure.
>   */
> -struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
> -                                               const char *fmt, ...)
> +struct iio_trigger *devm_iio_trigger_alloc(struct device *parent, const char *fmt, ...)
>  {
>         struct iio_trigger **ptr, *trig;
>         va_list vargs;
> @@ -611,11 +617,11 @@ struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
>
>         /* use raw alloc_dr for kmalloc caller tracing */
>         va_start(vargs, fmt);
> -       trig = viio_trigger_alloc(fmt, vargs);
> +       trig = viio_trigger_alloc(parent, fmt, vargs);
>         va_end(vargs);
>         if (trig) {
>                 *ptr = trig;
> -               devres_add(dev, ptr);
> +               devres_add(parent, ptr);
>         } else {
>                 devres_free(ptr);
>         }
> diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
> index 410de837d0417..22940f86003fc 100644
> --- a/drivers/iio/trigger/iio-trig-hrtimer.c
> +++ b/drivers/iio/trigger/iio-trig-hrtimer.c
> @@ -122,7 +122,7 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char *name)
>         if (!trig_info)
>                 return ERR_PTR(-ENOMEM);
>
> -       trig_info->swt.trigger = iio_trigger_alloc("%s", name);
> +       trig_info->swt.trigger = iio_trigger_alloc(NULL, "%s", name);
>         if (!trig_info->swt.trigger) {
>                 ret = -ENOMEM;
>                 goto err_free_trig_info;
> diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
> index 94a487caf4214..f746c460bf2a5 100644
> --- a/drivers/iio/trigger/iio-trig-interrupt.c
> +++ b/drivers/iio/trigger/iio-trig-interrupt.c
> @@ -45,7 +45,7 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>
>         irq = irq_res->start;
>
> -       trig = iio_trigger_alloc("irqtrig%d", irq);
> +       trig = iio_trigger_alloc(NULL, "irqtrig%d", irq);
>         if (!trig) {
>                 ret = -ENOMEM;
>                 goto error_ret;
> diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
> index 4a00668e32583..96ec06bbe546a 100644
> --- a/drivers/iio/trigger/iio-trig-loop.c
> +++ b/drivers/iio/trigger/iio-trig-loop.c
> @@ -84,7 +84,7 @@ static struct iio_sw_trigger *iio_trig_loop_probe(const char *name)
>         if (!trig_info)
>                 return ERR_PTR(-ENOMEM);
>
> -       trig_info->swt.trigger = iio_trigger_alloc("%s", name);
> +       trig_info->swt.trigger = iio_trigger_alloc(NULL, "%s", name);
>         if (!trig_info->swt.trigger) {
>                 ret = -ENOMEM;
>                 goto err_free_trig_info;
> diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
> index 0f6b512a5c37b..e9adfff45b39b 100644
> --- a/drivers/iio/trigger/iio-trig-sysfs.c
> +++ b/drivers/iio/trigger/iio-trig-sysfs.c
> @@ -149,7 +149,7 @@ static int iio_sysfs_trigger_probe(int id)
>                 goto out1;
>         }
>         t->id = id;
> -       t->trig = iio_trigger_alloc("sysfstrig%d", id);
> +       t->trig = iio_trigger_alloc(&iio_sysfs_trig_dev, "sysfstrig%d", id);
>         if (!t->trig) {
>                 ret = -ENOMEM;
>                 goto free_t;
> @@ -157,7 +157,6 @@ static int iio_sysfs_trigger_probe(int id)
>
>         t->trig->dev.groups = iio_sysfs_trigger_attr_groups;
>         t->trig->ops = &iio_sysfs_trigger_ops;
> -       t->trig->dev.parent = &iio_sysfs_trig_dev;
>         iio_trigger_set_drvdata(t->trig, t);
>
>         t->work = IRQ_WORK_INIT_HARD(iio_sysfs_trigger_work);
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index e4a9822e64950..5ca4b1d33e153 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -698,7 +698,7 @@ static inline void *iio_priv(const struct iio_dev *indio_dev)
>  void iio_device_free(struct iio_dev *indio_dev);
>  struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv);
>  __printf(2, 3)
> -struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
> +struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
>                                            const char *fmt, ...);
>  /**
>   * iio_buffer_enabled() - helper function to test if the buffer is enabled
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index 055890b6ffcf0..096f68dd2e0ca 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -161,7 +161,8 @@ void iio_trigger_poll_chained(struct iio_trigger *trig);
>
>  irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private);
>
> -__printf(1, 2) struct iio_trigger *iio_trigger_alloc(const char *fmt, ...);
> +__printf(2, 3)
> +struct iio_trigger *iio_trigger_alloc(struct device *parent, const char *fmt, ...);
>  void iio_trigger_free(struct iio_trigger *trig);
>
>  /**
> --
> 2.30.1.766.gb4fecdf3b7-goog
>
