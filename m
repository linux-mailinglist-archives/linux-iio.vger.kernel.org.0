Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42822DC90A
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 23:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgLPWjE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Dec 2020 17:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgLPWjE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 17:39:04 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3336C061794
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 14:38:23 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id r4so13798152pls.11
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 14:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2UhysU/zF3PMB2bIYUF35IUTesNxnegKVj52fKzUzFA=;
        b=r8dYmP7+PIfEk8agfp4NvMLogAQRAc/wD3N8N9adTUmJSYWlhFlbIKSYMeon+V7Zqu
         KhMDx2IVCBx8LKYiYciNzN6wzMjvUabF8vy/E3qCDdhEGiJIcPTKBsC8LgLYVC7+H/6R
         sfq0jO7sIjcz9za2HrrEd7yU/jO4myhxdhwPo7MkT7YZzXhcZ7ARNoOKEacW4wnJ6dAS
         A2wgqYr/qklkmYlCM7KMaO1pt8+b9x7TKlp22dbVNtvoyaDh9tjegcIGdjOyvAUm0M+2
         PrHnukzVeN7NekwKwirzrIwx+6KX/n2fVylenJUH9D9Y0DtG4YOW77iMImoN53xLrIKc
         GxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UhysU/zF3PMB2bIYUF35IUTesNxnegKVj52fKzUzFA=;
        b=ceVTsdJEgxq6fhsCcTwWVYhV+ukyOPgYQ4hFz/edbPxQexB43hxRiza1GeEW+y44q/
         n9K1T2VdRhq8GQ+jiafEa2e+kKoNhHpIgXzZHae/5am3+ksuptqmS7abbhsNROJcCQ62
         53PplCbY2kNPmsBTyVLYt/rMwy0hBkbBLwuQneCTxQMOvjkM4TSvMwitsHlLkwIpnlP2
         YNiVbOEV/MXl+H1Hyjxsp7ko+g2+1gvRrYVyFgJYtE3JWM515EKHfsJLdhisfubcmyNZ
         DQYXoyEHBI3kGS5U42KjI3KuUaOdLC3nbGi4i6S4YUyM1qWeY77a7SkhA3nGtiKsDVqU
         T19g==
X-Gm-Message-State: AOAM531xjUAgytGjokiAaW8DQfOsna1iiB+2kBYEJCsxnj05+Or+A7Xc
        RTcsheavWlblgwaGHtQN5jyvMTNh/ATD5kRDdYqK4BgLVXBRVw==
X-Google-Smtp-Source: ABdhPJyGQswlciCvJ0aG21HDB66ZJl1FIeCA/Wt1eFGKsS+Ac0PnJQkEyFpH5HnWZ3SjgMAGHeWfXEU/G3nt8t+JuLM=
X-Received: by 2002:a17:90a:c592:: with SMTP id l18mr4948980pjt.228.1608158303297;
 Wed, 16 Dec 2020 14:38:23 -0800 (PST)
MIME-Version: 1.0
References: <20201216214107.774969-1-gwendal@chromium.org> <20201216214107.774969-4-gwendal@chromium.org>
In-Reply-To: <20201216214107.774969-4-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 17 Dec 2020 00:38:06 +0200
Message-ID: <CAHp75Vfn=KtzN7zpm+pRES3L6R9k77GhHUFkxjrHcV67Vwx7kA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] iio: acpi_als: Add trigger support
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 16, 2020 at 11:41 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> As some firmware does not notify on illuminance changes, add a
> trigger to be able to query light via software (sysfs-trigger or
> hrtrigger).
> Add a hardware trigger set as the default trigger to maintain backward
> compatibility.
>
> Check iio_info reports the sensor as buffer capable:
>   iio:device0: acpi-als (buffer capable)
>
> To test, check we can get data on demand on an Intel based chromebook:
>
>   IIO_DEV="iio:device0"
>   echo 1 > iio_sysfs_trigger/add_trigger
>   cat trigger2/name > ${IIO_DEV}/trigger/current_trigger
>   for i in ${IIO_DEV}/scan_elements/*_en ${IIO_DEV}/buffer/enable ; do
>     echo 1 > $i
>   done
>   od -x /dev/${IIO_DEV} &
>   echo 1 > trigger2/trigger_now

Few nitpicks below. After addressing, take my
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
assuming that backward compatibility has been tested as well.

> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  Changes in v4:
>  Added comments when pf->timestamp is 0 and valid. Fix spelling.
>  Changes in v5:
>  Improve commit message readability, add note about backward
>  compatibility.
>  Remove unneeded include file.
>
>  drivers/iio/light/acpi-als.c | 89 ++++++++++++++++++++++++++----------
>  1 file changed, 66 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index fd20808d4a119..80fe0da51fad3 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -16,11 +16,14 @@
>  #include <linux/module.h>
>  #include <linux/acpi.h>
>  #include <linux/err.h>
> +#include <linux/irq.h>
>  #include <linux/mutex.h>
>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> -#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>
>  #define ACPI_ALS_CLASS                 "als"
>  #define ACPI_ALS_DEVICE_NAME           "acpi-als"
> @@ -59,6 +62,7 @@ static const struct iio_chan_spec acpi_als_channels[] = {
>  struct acpi_als {
>         struct acpi_device      *device;
>         struct mutex            lock;
> +       struct iio_trigger      *trig;
>
>         s32 evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE / sizeof(s32)]  __aligned(8);
>  };
> @@ -102,33 +106,20 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
>  {
>         struct iio_dev *indio_dev = acpi_driver_data(device);
>         struct acpi_als *als = iio_priv(indio_dev);
> -       s32 *buffer = als->evt_buffer;
> -       s64 time_ns = iio_get_time_ns(indio_dev);
> -       s32 val;
> -       int ret;
>
> -       mutex_lock(&als->lock);
> -
> -       memset(buffer, 0, ACPI_ALS_EVT_BUFFER_SIZE);
> +       if (!iio_buffer_enabled(indio_dev) ||
> +           !iio_trigger_using_own(indio_dev))

I guess it can be located on one line.

I hope those functions have no side effects. In that case you may
invert logic (save 2 characters)

       if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev))

> +               return;
>
>         switch (event) {
>         case ACPI_ALS_NOTIFY_ILLUMINANCE:
> -               ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
> -               if (ret < 0)
> -                       goto out;
> -               *buffer++ = val;
> +               iio_trigger_poll_chained(als->trig);
>                 break;
>         default:
>                 /* Unhandled event */
>                 dev_dbg(&device->dev, "Unhandled ACPI ALS event (%08x)!\n",
>                         event);
> -               goto out;
>         }
> -
> -       iio_push_to_buffers_with_timestamp(indio_dev, als->evt_buffer, time_ns);
> -
> -out:
> -       mutex_unlock(&als->lock);
>  }
>
>  static int acpi_als_read_raw(struct iio_dev *indio_dev,
> @@ -159,12 +150,47 @@ static const struct iio_info acpi_als_info = {
>         .read_raw               = acpi_als_read_raw,
>  };
>
> +static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf = p;
> +       struct iio_dev *indio_dev = pf->indio_dev;
> +       struct acpi_als *als = iio_priv(indio_dev);
> +       s32 *buffer = als->evt_buffer;
> +       s32 val;
> +       int ret;
> +
> +       mutex_lock(&als->lock);
> +
> +       ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
> +       if (ret < 0)
> +               goto out;
> +       *buffer = val;
> +
> +       /*
> +        * When coming from own trigger via polls, set polling function timestamp
> +        * here.
> +        * Given ACPI notifier is already in a thread and call function directly,
> +        * there is no need to set the timestamp in the notify function.

Continue the second sentence of the previous line. No need to have it
in a separate paragraph.

> +        *
> +        * If the timestamp was actually 0, the timestamp is set one more time.
> +        */
> +       if (!pf->timestamp)
> +               pf->timestamp = iio_get_time_ns(indio_dev);
> +
> +       iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
> +out:
> +       mutex_unlock(&als->lock);
> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;
> +}
> +
>  static int acpi_als_add(struct acpi_device *device)
>  {
>         struct device *dev = &device->dev;
>         struct iio_dev *indio_dev;
> -       struct iio_buffer *buffer;
>         struct acpi_als *als;
> +       int ret;
>
>         indio_dev = devm_iio_device_alloc(dev, sizeof(*als));
>         if (!indio_dev)
> @@ -178,15 +204,32 @@ static int acpi_als_add(struct acpi_device *device)
>
>         indio_dev->name = ACPI_ALS_DEVICE_NAME;
>         indio_dev->info = &acpi_als_info;
> -       indio_dev->modes = INDIO_BUFFER_SOFTWARE;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = acpi_als_channels;
>         indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
>
> -       buffer = devm_iio_kfifo_allocate(dev);
> -       if (!buffer)
> +       als->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +                                          indio_dev->name,
> +                                          indio_dev->id);
> +       if (!als->trig)
>                 return -ENOMEM;
>
> -       iio_device_attach_buffer(indio_dev, buffer);
> +       iio_trigger_set_drvdata(als->trig, indio_dev);
> +       ret = devm_iio_trigger_register(dev, als->trig);
> +       if (ret)
> +               return ret;
> +       /*
> +        * Set hardware trigger by default to let events flow when
> +        * BIOS support notification.
> +        */
> +       indio_dev->trig = iio_trigger_get(als->trig);
> +
> +       ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +                                             iio_pollfunc_store_time,
> +                                             acpi_als_trigger_handler,
> +                                             NULL);
> +       if (ret)
> +               return ret;
>
>         return devm_iio_device_register(dev, indio_dev);
>  }
> --
> 2.29.2.729.g45daf8777d-goog
>


-- 
With Best Regards,
Andy Shevchenko
