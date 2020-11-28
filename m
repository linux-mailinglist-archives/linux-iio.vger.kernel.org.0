Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1123F2C752D
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbgK1Vt1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731638AbgK1Syn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 13:54:43 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC60A246A5;
        Sat, 28 Nov 2020 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606576889;
        bh=PCExNiiq4fod27qjBrU5G0fxl6mD7Tnj2BkBlUMMkX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=THVq7GSb96d+mD5yk9ekV9dWY1FRMcJcEOS0Kn9T9rjbpRP4BeFSEWjEsXsOxVYg7
         5DOqeAWeI+7QGg7JlphsJNRvUkOnVcK3ooXvHkVkrwMLRKWzmx1BGhcoaJFCM9XGoF
         JhOGCf4vHUrsHlf7vCSeQTMP9JizTApG1X325GoI=
Date:   Sat, 28 Nov 2020 15:21:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/11] iio: adc: at91_adc: merge at91_adc_probe_dt
 back in at91_adc_probe
Message-ID: <20201128152124.24d88b36@archlinux>
In-Reply-To: <20201117140656.1235055-8-alexandre.belloni@bootlin.com>
References: <20201117140656.1235055-1-alexandre.belloni@bootlin.com>
        <20201117140656.1235055-8-alexandre.belloni@bootlin.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 15:06:52 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> at91_adc_probe_dt is now small enough to be merged back in at91_adc_probe.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>
This proved a little more interesting to apply, but I think that is just
down to Alexandru having already made the match_data related change.

Please check I got it right!

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c | 117 ++++++++++++++++---------------------
>  1 file changed, 49 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 83539422b704..347464844263 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -833,70 +833,6 @@ static int at91_adc_probe_dt_ts(struct device_node *node,
>  	}
>  }
>  
> -static int at91_adc_probe_dt(struct iio_dev *idev,
> -			     struct platform_device *pdev)
> -{
> -	struct at91_adc_state *st = iio_priv(idev);
> -	struct device_node *node = pdev->dev.of_node;
> -	int ret;
> -	u32 prop;
> -	char *s;
> -
> -	st->caps = (struct at91_adc_caps *)
> -		of_match_device(at91_adc_dt_ids, &pdev->dev)->data;
> -
> -	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
> -
> -	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop)) {
> -		dev_err(&idev->dev, "Missing adc-channels-used property in the DT.\n");
> -		ret = -EINVAL;
> -		goto error_ret;
> -	}
> -	st->channels_mask = prop;
> -
> -	st->sleep_mode = of_property_read_bool(node, "atmel,adc-sleep-mode");
> -
> -	if (of_property_read_u32(node, "atmel,adc-startup-time", &prop)) {
> -		dev_err(&idev->dev, "Missing adc-startup-time property in the DT.\n");
> -		ret = -EINVAL;
> -		goto error_ret;
> -	}
> -	st->startup_time = prop;
> -
> -	prop = 0;
> -	of_property_read_u32(node, "atmel,adc-sample-hold-time", &prop);
> -	st->sample_hold_time = prop;
> -
> -	if (of_property_read_u32(node, "atmel,adc-vref", &prop)) {
> -		dev_err(&idev->dev, "Missing adc-vref property in the DT.\n");
> -		ret = -EINVAL;
> -		goto error_ret;
> -	}
> -	st->vref_mv = prop;
> -
> -	st->res = st->caps->high_res_bits;
> -	if (st->caps->low_res_bits &&
> -	    !of_property_read_string(node, "atmel,adc-use-res", (const char **)&s)
> -	    && !strcmp(s, "lowres"))
> -		st->res = st->caps->low_res_bits;
> -
> -	dev_info(&idev->dev, "Resolution used: %u bits\n", st->res);
> -
> -	st->registers = &st->caps->registers;
> -	st->num_channels = st->caps->num_channels;
> -
> -	/* Check if touchscreen is supported. */
> -	if (st->caps->has_ts)
> -		return at91_adc_probe_dt_ts(node, st, &idev->dev);
> -	else
> -		dev_info(&idev->dev, "not support touchscreen in the adc compatible string.\n");
> -
> -	return 0;
> -
> -error_ret:
> -	return ret;
> -}
> -
>  static const struct iio_info at91_adc_info = {
>  	.read_raw = &at91_adc_read_raw,
>  };
> @@ -1062,10 +998,12 @@ static void at91_ts_unregister(struct at91_adc_state *st)
>  static int at91_adc_probe(struct platform_device *pdev)
>  {
>  	unsigned int prsc, mstrclk, ticks, adc_clk, adc_clk_khz, shtim;
> +	struct device_node *node = pdev->dev.of_node;
>  	int ret;
>  	struct iio_dev *idev;
>  	struct at91_adc_state *st;
> -	u32 reg;
> +	u32 reg, prop;
> +	char *s;
>  
>  	idev = devm_iio_device_alloc(&pdev->dev, sizeof(struct at91_adc_state));
>  	if (!idev)
> @@ -1073,9 +1011,52 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	st = iio_priv(idev);
>  
> -	ret = at91_adc_probe_dt(idev, pdev);
> -	if (ret)
> -		return ret;
> +	st->caps = (struct at91_adc_caps *)
> +		of_match_device(at91_adc_dt_ids, &pdev->dev)->data;
> +
> +	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
> +
> +	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop)) {
> +		dev_err(&idev->dev, "Missing adc-channels-used property in the DT.\n");
> +		return -EINVAL;
> +	}
> +	st->channels_mask = prop;
> +
> +	st->sleep_mode = of_property_read_bool(node, "atmel,adc-sleep-mode");
> +
> +	if (of_property_read_u32(node, "atmel,adc-startup-time", &prop)) {
> +		dev_err(&idev->dev, "Missing adc-startup-time property in the DT.\n");
> +		return -EINVAL;
> +	}
> +	st->startup_time = prop;
> +
> +	prop = 0;
> +	of_property_read_u32(node, "atmel,adc-sample-hold-time", &prop);
> +	st->sample_hold_time = prop;
> +
> +	if (of_property_read_u32(node, "atmel,adc-vref", &prop)) {
> +		dev_err(&idev->dev, "Missing adc-vref property in the DT.\n");
> +		return -EINVAL;
> +	}
> +	st->vref_mv = prop;
> +
> +	st->res = st->caps->high_res_bits;
> +	if (st->caps->low_res_bits &&
> +	    !of_property_read_string(node, "atmel,adc-use-res", (const char **)&s)
> +	    && !strcmp(s, "lowres"))
> +		st->res = st->caps->low_res_bits;
> +
> +	dev_info(&idev->dev, "Resolution used: %u bits\n", st->res);
> +
> +	st->registers = &st->caps->registers;
> +	st->num_channels = st->caps->num_channels;
> +
> +	/* Check if touchscreen is supported. */
> +	if (st->caps->has_ts) {
> +		ret = at91_adc_probe_dt_ts(node, st, &idev->dev);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	platform_set_drvdata(pdev, idev);
>  

