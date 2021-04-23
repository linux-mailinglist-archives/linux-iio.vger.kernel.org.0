Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BA6368E01
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 09:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhDWHhf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Apr 2021 03:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWHhe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Apr 2021 03:37:34 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4359C061574
        for <linux-iio@vger.kernel.org>; Fri, 23 Apr 2021 00:36:58 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m6-20020a17090a8586b02901507e1acf0fso791462pjn.3
        for <linux-iio@vger.kernel.org>; Fri, 23 Apr 2021 00:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZltiECUl09bVhAizpUQhtS6At97ly6rd0hwGiYcnJw=;
        b=OCW67Jwew/1gdLoTdVjdTMVJHYEHRWoNta+NG2d/6y3wgvBP8Fry6PXwFzqwUtrXnT
         8bljL6Y/jZKEl+K7K64K6I+vATQQuT3zgQHAWKcrKIIk4Z7Btt5Fkii0mV4akydcML6j
         qW+7zdNAwmUt5kRwvm8SjORlPJ94Oy94KQ9lggqOMTsHgS71bS0wobArZcpzMj12EOYr
         lQFn4HPDRd1S95awmmy8cmuJQi8+k2xV1lAQuHGRULX/gwH/OP1+VFp7IMhuC1Xs1bSn
         ESykEdXMcdmSF52HU3nbxm5UDVwjaG1WWZKlkIlXbu56J5jOe1C3TYfSUbLDXE/mH5d9
         dKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZltiECUl09bVhAizpUQhtS6At97ly6rd0hwGiYcnJw=;
        b=TMtDQFtfs0B2i3D81StOtjDi1XSgD0h0uvZ0iW/GaPfi9LCACs76BVeIU54gl7fGNU
         Go8A+70V2O1Y5ZsNloFpiHksFw/MQ3WMBAft8V5glOCl+n5s9eJDjHu7yfexMkWNWVsP
         IVyO8SM6H36qoC7e4YF4Ic19Tk9vbQodsXhtaXzUqbCbYZkKsElFIvfEEkTKv9F+re6X
         SyrRTWmbY72G+d7c7TCYyZfZ6bEB+o43eO1qggPLuw7HHS4Hn4TzjD2XX4OdogqWSdn8
         ZEFitWhfq1fmkVRv53Y+6S0MFCOPt5/SAcou3k0otErZytQr1i4whK7SVjklkX0jdzRM
         +e9Q==
X-Gm-Message-State: AOAM532DFNcL/dPeMthxZvVHQk+Q6BAB03z5YP2n7B4whTKprqeHEk3I
        aG39POSmmJRceOTtOnEy+yTZgcFmVuMat8xNt60=
X-Google-Smtp-Source: ABdhPJzdGl0qaj4O9x0ZF2Rb79voK9siuSPgHYeYl4YaMJXzJ413BbyBuG6d2HfZbdXnByh6EOcMOpITsWE5V6VxTYk=
X-Received: by 2002:a17:90a:2807:: with SMTP id e7mr3011485pjd.181.1619163418172;
 Fri, 23 Apr 2021 00:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210422101911.135630-1-nuno.sa@analog.com> <20210422101911.135630-9-nuno.sa@analog.com>
In-Reply-To: <20210422101911.135630-9-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 23 Apr 2021 10:36:47 +0300
Message-ID: <CA+U=Dso9F6K-xC+-GJ8Ux=XCOstEfaePMV5_aP=gvip91x2wKw@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] iio: adis16475: do not directly change spi 'max_speed_hz'
To:     Nuno Sa <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 22, 2021 at 1:17 PM Nuno Sa <nuno.sa@analog.com> wrote:
>
> With commit 65f2f661e71d ("iio: adis: add burst_max_speed_hz variable"), we
> just need to define 'burst_max_speed_hz' and the adis core will take
> care of setting up the spi transfers for burst mode. Hence, we fix
> a potential race with the spi core where we could be left with an
> invalid 'max_speed_hz'.
>

This looks more elegant.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>


> Fixes: fff7352bf7a3c ("iio: imu: Add support for adis16475")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis16475.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index 51b76444db0b..5654c0c15426 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -645,7 +645,8 @@ static int adis16475_enable_irq(struct adis *adis, bool enable)
>         .timeouts = (_timeouts),                                        \
>         .burst_reg_cmd = ADIS16475_REG_GLOB_CMD,                        \
>         .burst_len = ADIS16475_BURST_MAX_DATA,                          \
> -       .burst_max_len = ADIS16475_BURST32_MAX_DATA                     \
> +       .burst_max_len = ADIS16475_BURST32_MAX_DATA,                    \
> +       .burst_max_speed_hz = ADIS16475_BURST_MAX_SPEED                 \
>  }
>
>  static const struct adis16475_sync adis16475_sync_mode[] = {
> @@ -1062,15 +1063,11 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
>         bool valid;
>         /* offset until the first element after gyro and accel */
>         const u8 offset = st->burst32 ? 13 : 7;
> -       const u32 cached_spi_speed_hz = adis->spi->max_speed_hz;
> -
> -       adis->spi->max_speed_hz = ADIS16475_BURST_MAX_SPEED;
>
>         ret = spi_sync(adis->spi, &adis->msg);
>         if (ret)
>                 goto check_burst32;
>
> -       adis->spi->max_speed_hz = cached_spi_speed_hz;
>         buffer = adis->buffer;
>
>         crc = be16_to_cpu(buffer[offset + 2]);
> --
> 2.31.1
>
