Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1919382545
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 09:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhEQH0I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 03:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhEQH0I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 03:26:08 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437D0C061573
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:24:52 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id s15so2632454vsi.4
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LREjrWvYIHGfm6by36A9p3jiYX2RQPXm1/k93mOgsT8=;
        b=FJPyTyjHliVyyXuS2q7XK50kYkl8TVCfnV/hc14E7PTcbBt99AjwM90yX4UnpQTc6J
         6ZtWSWSXOBiwtwFt/HM8V1GUeJg3kBdmTGj1KkPE22UMGCJhVOpVP2BgdIFYNl4dCcua
         WFhB6GFzywu+0u67GZEhXcrsmXXMcOulNv5dJtdmlGavZy/kjmI88J4eso/ghkItQukV
         +6TriBwyPhhJVdI65tS3GI3WCVb/HqrEBwYhnPcCyBuBcWu2oe7L6FHXMsVujxbznvdC
         u03EE4dmZprTZyPgPMuD/0IQFpuKvO2S9sf9IxHzh/CpDUwBCyKnBF0nPKUdFBaIIA73
         TEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LREjrWvYIHGfm6by36A9p3jiYX2RQPXm1/k93mOgsT8=;
        b=VR9A0G+uyDkOtA1ROKkuv8zSg12JFVhhMglDnZCq406I/7cZ2cNziJgMP79Yx9aJ1o
         /1Wcjdv1eW3M5ZtPRe9v5UNooUxM6xqUElV6tTVqEL0lY8+w8McCaO58YFBY8+vcFOp5
         C/069s9xR3bcqquMvfH1hIYLXHPnf2wLI7y+anPNFcy2YIqanynP8KiaxxIlgaOkYa7r
         B1aLxJdwozoIDHJLiqofjbqrdSnVmdzml9rK9jdl5KnA/5+w3VNvjudlHQqbqiUb1/G7
         D2PNG3dSlDfTYHMH3Povh3Du+tLV6m8VA0oCKRr1fTifRKXJePRTobMTwQbqUHK8rszc
         XKtQ==
X-Gm-Message-State: AOAM532+AzOFVZFi3LIlLDIOe7giYazXkrwHFdBNN1zvRGxApQI8RAss
        tCDKVVZV+F3fRPAaiCPD7wwu7uuCfFaX2cG7L4tMD9Q9wpQbgY0WwoU=
X-Google-Smtp-Source: ABdhPJycQTgfVGWSlaZRkz+15PuFwQ9c8lacZFOw/S3vJSussReJapyx/0gkkohysuGqtkmwJkya7MpJ+q2jjbGVM6k=
X-Received: by 2002:a67:7d85:: with SMTP id y127mr5495616vsc.43.1621236291461;
 Mon, 17 May 2021 00:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210516172520.1398835-1-jic23@kernel.org> <20210516172520.1398835-5-jic23@kernel.org>
In-Reply-To: <20210516172520.1398835-5-jic23@kernel.org>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 17 May 2021 10:24:40 +0300
Message-ID: <CAASAkoZsMtshXJ-J4tcWQL-aPct6M0_cvTsiAwMHGtzBHufCGA@mail.gmail.com>
Subject: Re: [PATCH 4/8] iio: adc: max1118: Avoid jumping back and forth
 between spi and iio structures
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 May 2021 at 20:26, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Changing from passing the spi structure into various functions to
> passing struct iio_dev avoids use of spi_get_drvdata and lets us
> stop setting that at all.  Previous code was unnecessarily complex.
>

Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/max1118.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
> index 4dfbed63ad7f..8cec9d949083 100644
> --- a/drivers/iio/adc/max1118.c
> +++ b/drivers/iio/adc/max1118.c
> @@ -66,9 +66,8 @@ static const struct iio_chan_spec max1118_channels[] = {
>         IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
>
> -static int max1118_read(struct spi_device *spi, int channel)
> +static int max1118_read(struct iio_dev *indio_dev, int channel)
>  {
> -       struct iio_dev *indio_dev = spi_get_drvdata(spi);
>         struct max1118 *adc = iio_priv(indio_dev);
>         struct spi_transfer xfers[] = {
>                 /*
> @@ -103,9 +102,9 @@ static int max1118_read(struct spi_device *spi, int channel)
>         int ret;
>
>         if (channel == 0)
> -               ret = spi_sync_transfer(spi, xfers + 1, 2);
> +               ret = spi_sync_transfer(adc->spi, xfers + 1, 2);
>         else
> -               ret = spi_sync_transfer(spi, xfers, 3);
> +               ret = spi_sync_transfer(adc->spi, xfers, 3);
>
>         if (ret)
>                 return ret;
> @@ -113,11 +112,10 @@ static int max1118_read(struct spi_device *spi, int channel)
>         return adc->data;
>  }
>
> -static int max1118_get_vref_mV(struct spi_device *spi)
> +static int max1118_get_vref_mV(struct iio_dev *indio_dev)
>  {
> -       struct iio_dev *indio_dev = spi_get_drvdata(spi);
>         struct max1118 *adc = iio_priv(indio_dev);
> -       const struct spi_device_id *id = spi_get_device_id(spi);
> +       const struct spi_device_id *id = spi_get_device_id(adc->spi);
>         int vref_uV;
>
>         switch (id->driver_data) {
> @@ -144,14 +142,14 @@ static int max1118_read_raw(struct iio_dev *indio_dev,
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW:
>                 mutex_lock(&adc->lock);
> -               *val = max1118_read(adc->spi, chan->channel);
> +               *val = max1118_read(indio_dev, chan->channel);
>                 mutex_unlock(&adc->lock);
>                 if (*val < 0)
>                         return *val;
>
>                 return IIO_VAL_INT;
>         case IIO_CHAN_INFO_SCALE:
> -               *val = max1118_get_vref_mV(adc->spi);
> +               *val = max1118_get_vref_mV(indio_dev);
>                 if (*val < 0)
>                         return *val;
>                 *val2 = 8;
> @@ -180,7 +178,7 @@ static irqreturn_t max1118_trigger_handler(int irq, void *p)
>                         indio_dev->masklength) {
>                 const struct iio_chan_spec *scan_chan =
>                                 &indio_dev->channels[scan_index];
> -               int ret = max1118_read(adc->spi, scan_chan->channel);
> +               int ret = max1118_read(indio_dev, scan_chan->channel);
>
>                 if (ret < 0) {
>                         dev_warn(&adc->spi->dev,
> @@ -238,8 +236,6 @@ static int max1118_probe(struct spi_device *spi)
>
>         }
>
> -       spi_set_drvdata(spi, indio_dev);
> -
>         indio_dev->name = spi_get_device_id(spi)->name;
>         indio_dev->info = &max1118_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -252,7 +248,7 @@ static int max1118_probe(struct spi_device *spi)
>          * a conversion has been completed, the MAX1117/MAX1118/MAX1119 will go
>          * into AutoShutdown mode until the next conversion is initiated.
>          */
> -       max1118_read(spi, 0);
> +       max1118_read(indio_dev, 0);
>
>         ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
>                                               max1118_trigger_handler, NULL);
> --
> 2.31.1
>
