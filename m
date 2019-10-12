Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23139D51B4
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 20:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfJLSod (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 14:44:33 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41962 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbfJLSod (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2019 14:44:33 -0400
Received: by mail-oi1-f193.google.com with SMTP id w65so10691650oiw.8
        for <linux-iio@vger.kernel.org>; Sat, 12 Oct 2019 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tt7EwK0Ub05bYLQcTiSuwkmJDE/NFbm7qXnc4dJJNYc=;
        b=iSJyreRxKiKXWLf9IM46ccwUxLb3tfVcWV5KufPfHxSv6l49GI0OZoJ10mchXpXEoe
         hJEP2bYlvsG//5j/BOjMZhfAiRQXtZ3mHQQ+R+pXeJE63NIUBh9entfIjgHn8prmgcCG
         zByjOVlTPCV1kAunsfAm8+dwbC/cL+x1vne/f432AxEZC12p2dvrt4RAKX8f8Edat2oe
         Yb4yi+6SNpT0rNbSILElHIP77u+ITAI7D5DdvPGcIgLRFWmFhmJFTxKT/9sIai061uTx
         hdcyXyczTsW6MTW9OYdVedo+6Lzpdw5yRS6mtDxwfDz5ydMH4qoVKyyIDVkHbJ1JnKW1
         mAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tt7EwK0Ub05bYLQcTiSuwkmJDE/NFbm7qXnc4dJJNYc=;
        b=Y+C+BqFpTB4sGbPcBlmjB9LPPmgrg32wBpOApZAoqT1tiOw8fpuxo/K9FOvY9cxAwv
         dScKaxxYY/ciorAJnjNKClbdF5Fwj2mucDiZqgi+kJR3/VDOV5bfnpR3rQLdX3I+G4RF
         nQb4EJi4F5MKTNedlSGaMzOSbDl0ebn3BEGpTtpuuom0APgTBjkRRRaJqk1WJTu0EKkq
         PGMPYPBYgtNCG1UrsCoZTKhK5RhvFA4wJfKIiSnW9lbaxdOJGWFmL6RJKOSVZovU1Hqb
         HHTlxOuC0aBHOlCky9QU1HMaGfMtUbd7SYlKVpE3rSVJ5J+xvZlVDXoz4224I7Nx7ZYa
         /QPQ==
X-Gm-Message-State: APjAAAV+dR78TXotn5Fznb24+LV5wfQYptIyMd+uh67ZlmxXJCX9UuQ0
        vOj2MBf5E0WmSLwkiAK32JnsuW5d+ERLbmn7hLmojQ==
X-Google-Smtp-Source: APXvYqztFgRYweMlTqW1WULS88/8rbPWheT+71FQkjwWdUFy1jn6UCtm2P5CTQuWh0WshLLbJtDaIdqNxlHLhEUj+xI=
X-Received: by 2002:a05:6808:155:: with SMTP id h21mr17135074oie.117.1570905872612;
 Sat, 12 Oct 2019 11:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191012162808.1196470-1-jic23@kernel.org>
In-Reply-To: <20191012162808.1196470-1-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sat, 12 Oct 2019 21:44:21 +0300
Message-ID: <CA+U=DspSueLQjD9bkW63xEJ8+fpE8M=H0hK=M-m0Oab5f-O8Rg@mail.gmail.com>
Subject: Re: [RFC] iio: adis: Fix build warnings due to disagreement on
 whether ret can be > 0
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 12, 2019 at 7:32 PM <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> I added a check to the inline functions in the header that provide
> the specific sized versions of __adis_read_reg_* to check if
> they were returning 0 before setting the value.   This was
> needed to solve a 0-day report which I was unable to replicate.
>
> Unfortunately it caused some build warnings because the drivers
> check for ret is not negative before using the value, leaving the
> positive range where flow continues, but the value is unset.
>
> This is one of several possible fixes, hence the RFC.
>

I'll take a closer look at this patch on Monday.
But I'll also want to look at the whole series again for ADIS.

It looks to me that the rework (though it looked credible at review),
did expose some subtleties that the compiler complains about.
I'll probably use this issue as a test-bed for the CI improvements
I'll do on our end.

Thanks
Alex

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/gyro/adis16136.c | 4 ++--
>  drivers/iio/imu/adis.c       | 2 +-
>  drivers/iio/imu/adis16480.c  | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
> index 2d2c48f0b996..223c42ef6f86 100644
> --- a/drivers/iio/gyro/adis16136.c
> +++ b/drivers/iio/gyro/adis16136.c
> @@ -191,7 +191,7 @@ static int __adis16136_get_freq(struct adis16136 *adis16136, unsigned int *freq)
>         int ret;
>
>         ret = __adis_read_reg_16(&adis16136->adis, ADIS16136_REG_SMPL_PRD, &t);
> -       if (ret < 0)
> +       if (ret)
>                 return ret;
>
>         *freq = 32768 / (t + 1);
> @@ -288,7 +288,7 @@ static int adis16136_get_filter(struct iio_dev *indio_dev, int *val)
>
>         ret = __adis_read_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT,
>                                  &val16);
> -       if (ret < 0)
> +       if (ret)
>                 goto err_unlock;
>
>         ret = __adis16136_get_freq(adis16136, &freq);
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 5e28464ea05b..6ee54996609a 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -289,7 +289,7 @@ int __adis_check_status(struct adis *adis)
>         int i;
>
>         ret = __adis_read_reg_16(adis, adis->data->diag_stat_reg, &status);
> -       if (ret < 0)
> +       if (ret)
>                 return ret;
>
>         status &= adis->data->status_error_mask;
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 01dae50e985b..ed3e52651003 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -564,7 +564,7 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
>         mutex_lock(slock);
>
>         ret = __adis_read_reg_16(&st->adis, reg, &val);
> -       if (ret < 0)
> +       if (ret)
>                 goto out_unlock;
>
>         if (freq == 0) {
> @@ -944,7 +944,7 @@ static int adis16480_enable_irq(struct adis *adis, bool enable)
>         int ret;
>
>         ret = __adis_read_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, &val);
> -       if (ret < 0)
> +       if (ret)
>                 return ret;
>
>         val &= ~ADIS16480_DRDY_EN_MSK;
> --
> 2.23.0
>
