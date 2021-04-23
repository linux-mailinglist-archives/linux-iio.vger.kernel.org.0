Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17983368E02
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 09:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhDWHii (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Apr 2021 03:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWHih (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Apr 2021 03:38:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5A6C061574
        for <linux-iio@vger.kernel.org>; Fri, 23 Apr 2021 00:38:01 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id em21-20020a17090b0155b029014e204a81e6so4054126pjb.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Apr 2021 00:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XzjygatTKds0yUBo2P8s8+BBc+efJF8FiKuSyIcTytQ=;
        b=uTTCp7EUIRiDEf/91hxalVKD8G6iF1lE5zl9GyOudZAO4OurgnmIqBGX99lS7LbDUT
         RJ1hkReKjm32uT14+VQzWqjr6hfnHTPY5A0u3oaqkHLm7nh20n7y7rhinuu5viLvOY41
         manPZ3PVCT+Y5vUw8hH0OP3b2ciJmW+L2YJzQw+ixrH7jahzA3P0WEpmR5SBAha9udGE
         m94y9/PFGomKhMZKT1d39+OB3vbfCtCS/OFZn1DYyCAq+4CTjm7yYBdZ/VwyPstXpudi
         +RLNLofCBRRx2INCHGeFdT02dskXLU7GzpKmU7Y6EofWRCX/PZNpfqN18ACldbhNbuiz
         J/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzjygatTKds0yUBo2P8s8+BBc+efJF8FiKuSyIcTytQ=;
        b=I50/wcEchLlxBeMVh+C71VT2t3KJmRGrAD6NntM/A21W6EnwqymwSsn5RLamkBFhZX
         gfW3YDt+r2o043pVbNJgnLCy1M5vnn6iAtH+ea4cnmw1yRVQ+wFj0t/OPU7UjANh4tcj
         +uSjm3UAkHCiTEH78Y49GYz7kn3jpiPt+Jn0qhVPD7qSJf8KYk5meQl7aLv1lUzVvdcU
         tyxAp5dzpwMeOGHVgjIgaXYjSMPfP9BNjVKbw/tpDjWCW/2T9aKLMCK+hOlLE+/pHEdL
         8sDgOiyViNHQvRwT1nRIlPMOjymS6D4Cpv13T5T/SmmyspcwORofvArP+frEdSsd0I8M
         Zm/w==
X-Gm-Message-State: AOAM532wmsOqEkFbqsDBq6Xx0kW0AXhHNwwK3tWs2Z40cW3iQPXZUiW7
        dvbrpV3Ehd+8XXdS+O1LaXnhMqY0BKOLRxBL1Ms=
X-Google-Smtp-Source: ABdhPJwBmadzhayZ7BDqdfr643jMp/gxJ0uosygIwmU/qLprHDPZ599V2bJhVhl8ixI5fqAH2ZtI+dQlS+aYQ38flQo=
X-Received: by 2002:a17:90a:2807:: with SMTP id e7mr3015554pjd.181.1619163481312;
 Fri, 23 Apr 2021 00:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210422101911.135630-1-nuno.sa@analog.com> <20210422101911.135630-10-nuno.sa@analog.com>
In-Reply-To: <20210422101911.135630-10-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 23 Apr 2021 10:37:50 +0300
Message-ID: <CA+U=DsrC=mYsUcSQLr0Db-32UXkRnGPZiNJx1vEEBj+PwNNOJQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] iio: adis16400: do not directly change spi 'max_speed_hz'
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
> a potential race with the spi core where we could be left witn an
> invalid 'max_speed_hz'.
>

This looks even more elegant than the previous.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>


> Fixes: 5eda3550a3cc1 ("staging:iio:adis16400: Preallocate transfer message")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis16400.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index b2f92b55b910..cb8d3ffab6fc 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -641,25 +641,13 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
>         struct iio_dev *indio_dev = pf->indio_dev;
>         struct adis16400_state *st = iio_priv(indio_dev);
>         struct adis *adis = &st->adis;
> -       u32 old_speed_hz = st->adis.spi->max_speed_hz;
>         void *buffer;
>         int ret;
>
> -       if (!(st->variant->flags & ADIS16400_NO_BURST) &&
> -               st->adis.spi->max_speed_hz > ADIS16400_SPI_BURST) {
> -               st->adis.spi->max_speed_hz = ADIS16400_SPI_BURST;
> -               spi_setup(st->adis.spi);
> -       }
> -
>         ret = spi_sync(adis->spi, &adis->msg);
>         if (ret)
>                 dev_err(&adis->spi->dev, "Failed to read data: %d\n", ret);
>
> -       if (!(st->variant->flags & ADIS16400_NO_BURST)) {
> -               st->adis.spi->max_speed_hz = old_speed_hz;
> -               spi_setup(st->adis.spi);
> -       }
> -
>         if (st->variant->flags & ADIS16400_BURST_DIAG_STAT)
>                 buffer = adis->buffer + sizeof(u16);
>         else
> @@ -965,7 +953,8 @@ static const char * const adis16400_status_error_msgs[] = {
>                 BIT(ADIS16400_DIAG_STAT_POWER_LOW),                     \
>         .timeouts = (_timeouts),                                        \
>         .burst_reg_cmd = ADIS16400_GLOB_CMD,                            \
> -       .burst_len = (_burst_len)                                       \
> +       .burst_len = (_burst_len),                                      \
> +       .burst_max_speed_hz = ADIS16400_SPI_BURST                       \
>  }
>
>  static const struct adis_timeout adis16300_timeouts = {
> --
> 2.31.1
>
