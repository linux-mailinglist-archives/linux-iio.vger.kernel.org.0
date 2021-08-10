Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53763E85D8
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 00:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhHJWDG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Aug 2021 18:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbhHJWDF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Aug 2021 18:03:05 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ADCC061765
        for <linux-iio@vger.kernel.org>; Tue, 10 Aug 2021 15:02:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so6478425pjs.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Aug 2021 15:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+KTQvQSFM9CkLc31S+Cz0hPqm5Jw/CFOP+cTOZWoi1Y=;
        b=0HsEPiyuDQX/HmODv8nkUe+EOxP9GYLVzOzXrC5oQln7eSAcQLCrFa89pEMlgpuV6H
         CWaROeZhq7cwDdRs/jFzxHAzTn74bYTgsPajI+sKZ7GMnxg5TIHyzI4JDVcIe43Q7vny
         nD29AHJnjmapIUMzFCFnrkB5tGaQ+5GtsBxErUlAcdYI8kdedL0YFjLW2E8pdZESB9+9
         bzKJLxojPWsM6f7go1AkQ28yIqqCsRSAOZL030JNIsK6yl5EOoqD5fPmCKU/iksjItwK
         rWDd8PhLa8uDAvjhNOE+en0QAd/87TrPUDFd+Gr2eoEYs4KdWh0lRiau1/F/HKtOSaDZ
         4dPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+KTQvQSFM9CkLc31S+Cz0hPqm5Jw/CFOP+cTOZWoi1Y=;
        b=XmVB746Fy6XJggMBvx/iaAZVCH6vZw4XtHGN4pP2CC8t07a7KBiQjvsPFDagj2mB4V
         gPatqAP0TCCps9HJARQcldw16AbsGBF/hUE/7hUhYkzGErz9qfnjs2z/k6cuQHpoDvMI
         DTIP8ns0pywspOW9dN0ppoGU+iTE1Dt55G+bI94rH4x9d+ruuwXZhIWgQiZo6IWMpMT3
         kBFD3ANX2LoKEPddshkNYtHzuRbx1TkYBAbndNVX6I7nQXcoHicqRRX3pTW2DPbVSsBg
         ET3ZkNtNt3ZWSFbwMvOMJEGKR2YX965szVmqA/MA6vrauq3m1VecxxGs2Dx3+1pkKyeX
         kc3A==
X-Gm-Message-State: AOAM533qWaS0iXJs/+PrY0wOn93KHZVzlacPcnvKQSygfdlESFuJK8bU
        kqCuIRNSU4X4ZDITBQSFGJyFBXar1T56Lg==
X-Google-Smtp-Source: ABdhPJw6DN96KJCPGASjXZS4uXBbwaNZHBqdEJiHAcDNQPIpWmOblQB9A/kh1XHltF1mlivhbMWAkA==
X-Received: by 2002:a17:90b:4d82:: with SMTP id oj2mr7232715pjb.192.1628632962883;
        Tue, 10 Aug 2021 15:02:42 -0700 (PDT)
Received: from x1 ([174.127.163.79])
        by smtp.gmail.com with ESMTPSA id k25sm24523141pfa.213.2021.08.10.15.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 15:02:42 -0700 (PDT)
Date:   Tue, 10 Aug 2021 15:02:40 -0700
From:   Drew Fustini <drew@pdp7.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, =Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/1] iio: ltc2983: fix device probe
Message-ID: <20210810220240.GA2813710@x1>
References: <20210810145653.295397-1-nuno.sa@analog.com>
 <20210810145653.295397-2-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210810145653.295397-2-nuno.sa@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 10, 2021 at 04:56:53PM +0200, Nuno Sá wrote:
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
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/iio/temperature/ltc2983.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index 3b5ba26d7d86..c6c4877bdcff 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -89,6 +89,8 @@
>  
>  #define	LTC2983_STATUS_START_MASK	BIT(7)
>  #define	LTC2983_STATUS_START(x)		FIELD_PREP(LTC2983_STATUS_START_MASK, x)
> +#define        LTC2983_STATUS_UP_MASK	GENMASK(7, 6)
> +#define        LTC2983_STATUS_UP(reg)	FIELD_GET(LTC2983_STATUS_UP_MASK, reg)
>  
>  #define	LTC2983_STATUS_CHAN_SEL_MASK	GENMASK(4, 0)
>  #define	LTC2983_STATUS_CHAN_SEL(x) \
> @@ -1362,13 +1364,21 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
>  
>  static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
>  {
> -	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0;
> +	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status = 0;
>  	int ret;
> -	unsigned long time;
> +	unsigned long time = 10;
>  
>  	/* make sure the device is up */
> -	time = wait_for_completion_timeout(&st->completion,
> -					    msecs_to_jiffies(250));
> +	do {
> +		ret = regmap_read(st->regmap, LTC2983_STATUS_REG, &status);
> +		if (ret)
> +			return ret;
> +		/* start bit (7) is 0 and done bit (6) is 1 */
> +		if (LTC2983_STATUS_UP(status) == 1)
> +			break;
> +
> +		msleep(25);
> +	} while (--time);
>  
>  	if (!time) {
>  		dev_err(&st->spi->dev, "Device startup timed out\n");
> @@ -1492,10 +1502,11 @@ static int ltc2983_probe(struct spi_device *spi)
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
> @@ -1503,10 +1514,6 @@ static int ltc2983_probe(struct spi_device *spi)
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

I have tested this on my custom Zynq-7000 board and the probe completes
okay. The read of LTC2983_STATUS_REG returns 0x40 on the first attempt
which is good. I am also able to read channels through sysfs. I have not
tried suspend and resume as that is not configured on this system.

Reviewed-by: Drew Fustini <drew@pdp7.com>
Tested-by: Drew Fustini <drew@pdp7.com>

Thanks for fixing,
Drew
