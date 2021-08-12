Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886A53E9BD2
	for <lists+linux-iio@lfdr.de>; Thu, 12 Aug 2021 03:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhHLBJw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 21:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbhHLBJv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 21:09:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92B3C061765
        for <linux-iio@vger.kernel.org>; Wed, 11 Aug 2021 18:09:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so8082133pjb.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Aug 2021 18:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vzwWCcLNrMVAS+dhQsifOPm0FnB7mFz+w114qodWM00=;
        b=oPAKTLuOH+vbcq8cZL0mSZrmJnI8wgATbh41eka63GA7Q9KBIyO4kSjBZ9cYgfy/VR
         JppOsNgsSDwYHfPZuyv9G1IuKQyPSWGbcG4UCxD64XnCsOExZzC7BpA4nN4CnhtSr0f2
         cE8oLkQ5BpErRweZxLC4qetYk4LcAO/YGf8UHLzG1reXUMsTNLKA6bglKsz6ysszTTOh
         dcD/W5AeyVnRVfleZ/sil1d6im7LEHDQtQbqrDDccgTGcAh7R3jQpVJNF0N1zkPICAdL
         /2jf39agEp4P7nQa6aee4S/x7sd1N0oVoUX6ztm8AagqVvFyxChp3C6iRHiOrdj9XmLq
         zxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vzwWCcLNrMVAS+dhQsifOPm0FnB7mFz+w114qodWM00=;
        b=oQZ5XaabfOfAw/PD5+RKlHqFCm66h/Vte+zGupwCHXrMlf1qukYPw9gjUgotp/R6e1
         vvxDO4TuUtx+s3zFyf87MOaZushwO8IQM8BOhLmpAd5UtnmOAQgt0pYtoT1mh0rA/Ukn
         STM8DVCeUNcakwgckmG35PfpdSGy0MOJqhjbqhNVjQXspM8MFYw6oiJwXkFu0IJaPuoq
         7erkMsFN5pXxNd3n/fbN6VUDym3f0uedPPVCV5e/YOIjgIVo7bm//2uDYfQV4YIsHME0
         CBNptDv0pYJXry2QgIYKqIYDuiyhmNidU+xUotRGqZe6CCNCKQnyaGDfhLGIOoM2X5R7
         2yhw==
X-Gm-Message-State: AOAM531UCoE3kKxRgn68YaWNAV3YCGWfJHbwtz+0Cve8eKhiCplzpeJ3
        JnpvtQumCSR8xV5qQ8wzt+iXxg==
X-Google-Smtp-Source: ABdhPJxkbhJe/6Sf2qIUQFuhiM3xknmzvsTLvJw26SV4jLNolQOfzPG7TnEy3xweMa7cHLlrd8riIA==
X-Received: by 2002:a17:90b:3604:: with SMTP id ml4mr13411575pjb.82.1628730566369;
        Wed, 11 Aug 2021 18:09:26 -0700 (PDT)
Received: from x1 ([174.127.163.79])
        by smtp.gmail.com with ESMTPSA id u20sm864186pgm.4.2021.08.11.18.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 18:09:25 -0700 (PDT)
Date:   Wed, 11 Aug 2021 18:09:24 -0700
From:   Drew Fustini <drew@pdp7.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/1] iio: ltc2983: fix device probe
Message-ID: <20210812010924.GA3061491@x1>
References: <20210811133220.190264-1-nuno.sa@analog.com>
 <20210811133220.190264-2-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210811133220.190264-2-nuno.sa@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 11, 2021 at 03:32:20PM +0200, Nuno Sá wrote:
> There is no reason to assume that the irq rising edge (indicating that
> the device start up phase is done) will happen after we request the irq.
> If the device is already up by the time we request it, the call to
> 'wait_for_completion_timeout()' will timeout and we will fail the device
> probe even though there's nothing wrong.
> 
> This patch fixes it by just polling the status register until we get the
> indication that the device is up and running. As a side effect of this
> fix, requesting the irq is also moved to after the setup function.
> 
> Fixes: f110f3188e563 ("iio: temperature: Add support for LTC2983")
> Reported-by: Drew Fustini <drew@pdp7.com>
> Reviewed-by: Drew Fustini <drew@pdp7.com>
> Tested-by: Drew Fustini <drew@pdp7.com>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/iio/temperature/ltc2983.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index 3b5ba26d7d86..657eb8cb4be4 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -89,6 +89,8 @@
>  
>  #define	LTC2983_STATUS_START_MASK	BIT(7)
>  #define	LTC2983_STATUS_START(x)		FIELD_PREP(LTC2983_STATUS_START_MASK, x)
> +#define	LTC2983_STATUS_UP_MASK		GENMASK(7, 6)
> +#define	LTC2983_STATUS_UP(reg)		FIELD_GET(LTC2983_STATUS_UP_MASK, reg)
>  
>  #define	LTC2983_STATUS_CHAN_SEL_MASK	GENMASK(4, 0)
>  #define	LTC2983_STATUS_CHAN_SEL(x) \
> @@ -1362,17 +1364,16 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
>  
>  static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
>  {
> -	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0;
> +	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status = 0;
>  	int ret;
> -	unsigned long time;
> -
> -	/* make sure the device is up */
> -	time = wait_for_completion_timeout(&st->completion,
> -					    msecs_to_jiffies(250));
>  
> -	if (!time) {
> +	/* make sure the device is up: start bit (7) is 0 and done bit (6) is 1 */
> +	ret = regmap_read_poll_timeout(st->regmap, LTC2983_STATUS_REG, status,
> +				       LTC2983_STATUS_UP(status) == 1, 25000,
> +				       25000 * 10);
> +	if (ret) {
>  		dev_err(&st->spi->dev, "Device startup timed out\n");
> -		return -ETIMEDOUT;
> +		return ret;
>  	}
>  
>  	st->iio_chan = devm_kzalloc(&st->spi->dev,
> @@ -1492,10 +1493,11 @@ static int ltc2983_probe(struct spi_device *spi)
>  	ret = ltc2983_parse_dt(st);
>  	if (ret)
>  		return ret;
> -	/*
> -	 * let's request the irq now so it is used to sync the device
> -	 * startup in ltc2983_setup()
> -	 */
> +
> +	ret = ltc2983_setup(st, true);
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_request_irq(&spi->dev, spi->irq, ltc2983_irq_handler,
>  			       IRQF_TRIGGER_RISING, name, st);
>  	if (ret) {
> @@ -1503,10 +1505,6 @@ static int ltc2983_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> -	ret = ltc2983_setup(st, true);
> -	if (ret)
> -		return ret;
> -
>  	indio_dev->name = name;
>  	indio_dev->num_channels = st->iio_channels;
>  	indio_dev->channels = st->iio_chan;
> -- 
> 2.32.0
> 

I tested this version on my Zynq-7000 board and it works well too.

Thanks,
Drew
