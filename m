Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B6D25D87B
	for <lists+linux-iio@lfdr.de>; Fri,  4 Sep 2020 14:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgIDMTu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Sep 2020 08:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgIDMTp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Sep 2020 08:19:45 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72D9C061245
        for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2020 05:19:44 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so1055737plk.13
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2020 05:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFnSEevYkQc0tFunYgelzfDZg1sxKpepl+YSSDIKMa8=;
        b=RQ5QcgFL58+sx6o44uDN4u0E/3C0ILtC3Zqk7hMpOja9/ogdM6+KbR/i0mSvuLxiSl
         j5m3wVP2wpZG9m8ORy8e5gc9g8AGFAjqz1b5Fx0nL2wzd0K7Y4AcsHVKJWGQ2U01huDf
         23e+zW/czfWh8ofLFdwSKiDMi9c6HYVI9oOZyEcp0DiGBf3iSOC4HQz6OvuTHJ7oAgjg
         j86ynShIjyKKrXV/57PcuH6K4psvoJwxLyuV0LvCOUcQfpxYkkZSeJx7hiKBkXwB+pG5
         R6CK55e/Ib+Y21AE67EDFLFVmASDzXKS9AskRfDblATgRypim6pq/H1tJwhqOuHyKbjJ
         hNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFnSEevYkQc0tFunYgelzfDZg1sxKpepl+YSSDIKMa8=;
        b=KbXDqQWIgfHZ1hX2SFJPmTpFGeL79d/QotXyUqbeJDVco8bv0zv4baN30fz1Nc/ZZM
         yWvK3UpR30eVayeRXSUoYFbZcPDzF/q7NdAFEWuE6ZsgJkHo3q0Z/C+GJw4u+Sk+vLE7
         IvAnIM9qmHbwAgOaiNnR8lXCjk9ZoBHSVTH4Cup8lw9p4m63LtS7v/NKt+PbR7PlfpN7
         scK6Em3TvufPLXo4iOdac4RSsCqaQOC4dUZEUsCFp857daZ6wApTlAh3D+oVk3ddZ+65
         J+b7i3zynZadQ1kU+KU+CfvDE5yP7a6sD1nbxib9vwFJetclQSZEszyuJGa4/JSO1YaO
         HCXg==
X-Gm-Message-State: AOAM530KYhax+I0nTyEQ3kjPDc7WHXZfbCV5wmiYojnkksnpdqQ5i2CQ
        r11epBpG8grSsOgQHkLksfoynK2iUB5j/H/rCgRwLuxlwxo=
X-Google-Smtp-Source: ABdhPJzZMX4MRsQPRxpmX8i/evHUKmePuZgktXXDCDGBI3eUlhkVanW8XZy7T4955pbLzaNMaNnfUfnbeJ1vgcxWWuA=
X-Received: by 2002:a17:90a:2ac6:: with SMTP id i6mr5089612pjg.181.1599221984268;
 Fri, 04 Sep 2020 05:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200904120726.199640-1-cmo@melexis.com>
In-Reply-To: <20200904120726.199640-1-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Sep 2020 15:19:27 +0300
Message-ID: <CAHp75VeiR1qQkBhA0XQ2_6aVAFHfQTWGcr+NeRhFNoCEiMK9kg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: temperature: mlx90632: Interface to change object
 ambient temperature
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 4, 2020 at 3:08 PM Crt Mori <cmo@melexis.com> wrote:
>
> Since object temperature might be different than the sensor temperature
> the infrared sensors should provide an interface to inject ambient
> temperature. This was in past done via write to ambient temperature
> interface (in_temp_ambient_raw), but I think most people did not know
> about it. This solution introduces a new iio type of the CALIBAMBIENT
> which is hopefully more descriptive and more explicit about the purpose
> and capabilities of the sensors.

I'm fine, but one really picky comment below. I don't think a new
version is needed till Jonathan will ask for it.

> Signed-off-by: Crt Mori <cmo@melexis.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/iio/industrialio-core.c    | 1 +
>  drivers/iio/temperature/mlx90632.c | 8 +++++++-
>  include/linux/iio/types.h          | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 606d5e61c575..941011502f4d 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -165,6 +165,7 @@ static const char * const iio_chan_info_postfix[] = {
>         [IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
>         [IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
>         [IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
> +       [IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
>  };
>
>  #if defined(CONFIG_DEBUG_FS)
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 94bca2b2866a..8e60d401b703 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -761,6 +761,9 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
>                         *val2 = data->emissivity * 1000;
>                 }
>                 return IIO_VAL_INT_PLUS_MICRO;

Blank line is missed here.

> +       case IIO_CHAN_INFO_CALIBAMBIENT:
> +               *val = data->object_ambient_temperature;
> +               return IIO_VAL_INT;
>
>         default:
>                 return -EINVAL;
> @@ -781,6 +784,9 @@ static int mlx90632_write_raw(struct iio_dev *indio_dev,
>                         return -EINVAL;
>                 data->emissivity = val * 1000 + val2 / 1000;
>                 return 0;
> +       case IIO_CHAN_INFO_CALIBAMBIENT:
> +               data->object_ambient_temperature = val;
> +               return 0;
>         default:
>                 return -EINVAL;
>         }
> @@ -798,7 +804,7 @@ static const struct iio_chan_spec mlx90632_channels[] = {
>                 .modified = 1,
>                 .channel2 = IIO_MOD_TEMP_OBJECT,
>                 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> -                       BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
> +                       BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) | BIT(IIO_CHAN_INFO_CALIBAMBIENT),
>         },
>  };
>
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index e6fd3645963c..1e3ed6f55bca 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -59,6 +59,7 @@ enum iio_chan_info_enum {
>         IIO_CHAN_INFO_CALIBEMISSIVITY,
>         IIO_CHAN_INFO_OVERSAMPLING_RATIO,
>         IIO_CHAN_INFO_THERMOCOUPLE_TYPE,
> +       IIO_CHAN_INFO_CALIBAMBIENT,
>  };
>
>  #endif /* _IIO_TYPES_H_ */
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
