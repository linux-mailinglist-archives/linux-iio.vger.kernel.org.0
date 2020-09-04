Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF62525D820
	for <lists+linux-iio@lfdr.de>; Fri,  4 Sep 2020 13:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgIDL4j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Sep 2020 07:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIDL4h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Sep 2020 07:56:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC280C061244
        for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2020 04:56:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d22so4479745pfn.5
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2020 04:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XeNgvDdY4GJMb0rKfRs9ZLtZ92UmM9VFbgLEUNOUOQQ=;
        b=GrTCe1BE0DHr0mOkXeQ5yhTPrWgqxOwzQ5ofUwhcJiizZeta1ZvIzrGNZxje+hosCg
         ZezV6VuT0PiO+frraudmI5Pdgp/5uuRyYu/XXPmADZqtIahmENAteU/4NMmv+Hml/5IF
         DNOTzN18dfbTcIHRE4xLsYyIeMdg2atUouO0iMzaiP4x/83kwPwm+kgu/VblLXc+oa+O
         bsn/E4tHaQ1mAK8m029VGRS1uQ+VWJZRJmw1djc6S/kpMfjXXmLrhlI/65EvPW5USW6d
         Tr0DUtkL6SDaxqhyFvng56PsR+fCOLAD30NBZ7ET6AWmpkDJPqsr4g+X+YAMDr0cGrAe
         XkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XeNgvDdY4GJMb0rKfRs9ZLtZ92UmM9VFbgLEUNOUOQQ=;
        b=JMVntalsA+MMzqiLc3utxxl9YDr9m7J6GbiX8AHYV9q0JRm/BS9t6E2LStQmQ5PVwf
         Lq8OmMYb4Oe2m13ZeWfUs8ynq1aDGa6r7eZpZJhLFqmTix1N0Dkt2k+G94hicUirLUsJ
         Hthip1AFpczA6zugeKP2vZH7o+IUPfhnpH6ru4yL9QVioxjmkn/yAS9cNlhgTrRE2pSj
         ZUZMoT+7vwwvhNXwnBloDRezytmcY6Ev5dPiQusQPZaY/SeXEM3vaPnZwFPpttRhZHpb
         vdLCDVaWCgwl9mfFSUSWvopGpujUwwbX5N1JTbfnbFPNM/BLI8RcaWHMkvzG81l3r1oh
         OhKg==
X-Gm-Message-State: AOAM532plZF7+6Jc3IddyFkFR4rfORjgSvNv6k5av5BDxldZZWN7QnwT
        K1WlMilM507JdAValhpWJD9M0YXNU7jaNhD5Kj0=
X-Google-Smtp-Source: ABdhPJz9RSXKyNmc1u76a781Y6L8DDUe9OT/Cp19MXf1i24ky6TygyHZ1YZMDhR57E7ZkphuUG0iu5qkRp+QDA4aikE=
X-Received: by 2002:aa7:942a:: with SMTP id y10mr2664371pfo.68.1599220596221;
 Fri, 04 Sep 2020 04:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200904094347.188834-1-cmo@melexis.com>
In-Reply-To: <20200904094347.188834-1-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Sep 2020 14:56:19 +0300
Message-ID: <CAHp75VefTnaRTjVO+6T9JFofY8m2_hWO+mSxFw-u0+muXJjbZg@mail.gmail.com>
Subject: Re: [PATCH] iio: temperature: mlx90632: Interface to change object
 ambient temperature
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 4, 2020 at 12:45 PM Crt Mori <cmo@melexis.com> wrote:
>
> Since object temperature might be different than the sensor temperature
> the infra red sensors should provide an interface to inject ambient

infrared

> temperature. This was in past done via write to ambient temperature
> interface (in_temp_ambient_raw), but I think most people did not know
> about it. This solution introduces a new iio type of the CALIBAMBIENT
> which is hopefully more descriptive and more explicit about the purpose
> and capabilities of the sensors.

After addressing above and below, FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>  drivers/iio/industrialio-core.c    |  2 ++
>  drivers/iio/temperature/mlx90632.c | 10 ++++++++--
>  include/linux/iio/types.h          |  1 +
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 606d5e61c575..754597f087d1 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -165,6 +165,8 @@ static const char * const iio_chan_info_postfix[] = {
>         [IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
>         [IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
>         [IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
> +       [IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",

> +

Unrelated.

>  };
>
>  #if defined(CONFIG_DEBUG_FS)
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 94bca2b2866a..67bf9f000122 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -761,7 +761,9 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
>                         *val2 = data->emissivity * 1000;
>                 }
>                 return IIO_VAL_INT_PLUS_MICRO;

> -

Unrelated...

> +       case IIO_CHAN_INFO_CALIBAMBIENT:
> +               *val = data->object_ambient_temperature;
> +               return IIO_VAL_INT;

...and thus missed the blank line here.

>         default:
>                 return -EINVAL;
>         }
> @@ -781,6 +783,9 @@ static int mlx90632_write_raw(struct iio_dev *indio_dev,
>                         return -EINVAL;
>                 data->emissivity = val * 1000 + val2 / 1000;
>                 return 0;
> +       case IIO_CHAN_INFO_CALIBAMBIENT:
> +               data->object_ambient_temperature = val;
> +               return 0;
>         default:
>                 return -EINVAL;
>         }
> @@ -798,7 +803,8 @@ static const struct iio_chan_spec mlx90632_channels[] = {
>                 .modified = 1,
>                 .channel2 = IIO_MOD_TEMP_OBJECT,
>                 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |

> -                       BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
> +                       BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |

> +                       BIT(IIO_CHAN_INFO_CALIBAMBIENT),

You can squeeze it in between to reduce churn in this change.

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
