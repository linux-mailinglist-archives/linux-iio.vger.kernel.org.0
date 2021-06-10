Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E563A2CD2
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 15:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhFJNX6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 09:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhFJNX5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 09:23:57 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CD7C061574
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 06:21:47 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so3824536pjq.3
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 06:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1XJFBMeXVeHZ7AKL1UreYF1aa8QOuuBTKiXp7Ri7OM=;
        b=Qucg8/3R8AQjpHcNktnrKokRzoAQ6gtwX8P0IdzfcdfuXTTiBXvcCLHZlGafEJA8/T
         l3Q8p/0kKJ3o9FwUEKM61nZ/VbNzgjxu5prD2eqlQiA83Fu+fMTUFeGV5u1+O/+NxcVJ
         EqjtKwXGJjDN6XgeU1mH+N54PdpcZeqqv3OKehi855S43Zx34BQgv6E6wsevCXHLxTMX
         9njdLex1BQl2wFKY8u++SoeoIDYvKUiKzr2GkFmYvyJNVRUGspaZHyR6nIj9Q4h+pkId
         5V25pxkbyQ4uunIWXaZSGDFP70Yjv8OcmjdKmyXCrf1sCEnieXfs2KJ91rLZf9DbtKMC
         SxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1XJFBMeXVeHZ7AKL1UreYF1aa8QOuuBTKiXp7Ri7OM=;
        b=ESB2kgBJMkkLXZnO9SpvcvjJbtv1+ufqL0rW4Nyt1sFBSFw/m3iGKZrJauiKRRGPZT
         VDVIkDR8jzbm8ikpaSh7FzHhyr8XIMr53As6JRAcJL7mh9hgl3MxJco80Gu8qplihp33
         q6WHplssOEz5KFHZGE8iB20LxEvlaK8RAMSmuCL5SNZKCj3AVyKcG4ZTh9UvXHGYELcL
         NAoyP7gwv5MRh6OUsGz+1yY5DveE9OdC5FLU734iuBAgD8iirYAMoU/CB9zynNRMZkPL
         tOjBaxs/23THbm6bYyBqv5UZIxQxavxx83a6Z1OgoSpRCVsBr0VFqdweIuMXUO9F8ten
         y4ng==
X-Gm-Message-State: AOAM530au4iqPmx4hOPVi77nCH94/GbIqjNysLma8sPp2dnYtagxTCL9
        jFU6IyJIJjKPsUQ4wGkfBgz5ijfais2ohbScc1w=
X-Google-Smtp-Source: ABdhPJxbVh+iKQtw5pA90bMwEvuYwJ/ALDEULmTKgHzlxjdWBW8kIINlRCDXu+pL/NcpgQEt/VzKS13DwKU4ufuCtAA=
X-Received: by 2002:a17:90b:818:: with SMTP id bk24mr3411784pjb.228.1623331306740;
 Thu, 10 Jun 2021 06:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210610125358.2096497-1-mkl@pengutronix.de> <20210610125358.2096497-4-mkl@pengutronix.de>
In-Reply-To: <20210610125358.2096497-4-mkl@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jun 2021 16:21:30 +0300
Message-ID: <CAHp75Ve=bp=iHKeHmSb8MzfMt=tP+gsgG0GTwxhQV_ej_+BqPA@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: ltr501: ltr501_read_ps(): add missing endianness conversion
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Oliver Lang <Oliver.Lang@gossenmetrawatt.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 3:55 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> From: Oliver Lang <Oliver.Lang@gossenmetrawatt.com>
>
> The PS ADC Channel data is spread over 2 registers in little-endian
> form. This patch adds the missing endianness conversion.
>
> Fixes: 2690be905123 ("iio: Add Lite-On ltr501 ambient light / proximity sensor driver")
> Signed-off-by: Oliver Lang <Oliver.Lang@gossenmetrawatt.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/iio/light/ltr501.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 79898b72fe73..0e3f97ef3cdd 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -407,20 +407,16 @@ static int ltr501_read_als(const struct ltr501_data *data, __le16 buf[2])
>                                 buf, 2 * sizeof(__le16));
>  }
>
> -static int ltr501_read_ps(const struct ltr501_data *data)
> +static int ltr501_read_ps(const struct ltr501_data *data, __le16 *buf)
>  {
> -       int ret, status;
> +       int ret;
>
>         ret = ltr501_drdy(data, LTR501_STATUS_PS_RDY);
>         if (ret < 0)
>                 return ret;
>
> -       ret = regmap_bulk_read(data->regmap, LTR501_PS_DATA,
> -                              &status, 2);
> -       if (ret < 0)
> -               return ret;
> -
> -       return status;
> +       return regmap_bulk_read(data->regmap, LTR501_PS_DATA,
> +                               buf, sizeof(__le16));

This is slightly weird since we pass a pointer to a buffer of one
element (buffer can be longer, but here it's always one element is in
use). The original code is better (initially). Also making caller to
do endiannes conversion each time is not good. What I suggest is to
leave the caller as is and change here only the followng

int status ==> __le16 status;

       ret = regmap_bulk_read(data->regmap, LTR501_PS_DATA, &status,
sizeof(status));

...

return le16_to_cpu(status);

>  }
>
>  static int ltr501_read_intr_prst(const struct ltr501_data *data,
> @@ -668,11 +664,11 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
>                         break;
>                 case IIO_PROXIMITY:
>                         mutex_lock(&data->lock_ps);
> -                       ret = ltr501_read_ps(data);
> +                       ret = ltr501_read_ps(data, buf);
>                         mutex_unlock(&data->lock_ps);
>                         if (ret < 0)
>                                 break;
> -                       *val = ret & LTR501_PS_DATA_MASK;
> +                       *val = le16_to_cpu(buf[0]) & LTR501_PS_DATA_MASK;
>                         ret = IIO_VAL_INT;
>                         break;
>                 default:
> --
> 2.30.2
>
>


-- 
With Best Regards,
Andy Shevchenko
