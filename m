Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D568F2B2EC1
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 18:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgKNRIK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 12:08:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgKNRIK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 12:08:10 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD4E620A8B;
        Sat, 14 Nov 2020 17:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605373689;
        bh=puzhUToLDbdpksV1BzQR0Pcr47PJlhL2dijZOGeUQ2A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gIUwa2JCisk6Q54IYK8Zx8KRR4Gc94YqGM8ocguLMaA4o5/vXuMK5IKvsXDDY2WxU
         Oa4oBTYOouBIvQIR+wdSDE0cxcg+/N5l1WvhxnHQpHosSKeUTJlIXMg3fEXCDq4VEk
         4wcvkDcxYuJFLrWl9bJ1t4Ltu0Ry3NBb4mgitFk0=
Date:   Sat, 14 Nov 2020 17:08:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] iio: adc: at91_adc: merge at91_adc_probe_dt back in
 at91_adc_probe
Message-ID: <20201114170804.4b51c84b@archlinux>
In-Reply-To: <20201113212650.507680-6-alexandre.belloni@bootlin.com>
References: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
        <20201113212650.507680-6-alexandre.belloni@bootlin.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Nov 2020 22:26:46 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> at91_adc_probe_dt is now small enough to be merged back in at91_adc_probe.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Minor largely unrelated suggestion inline as we are touching this code.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c | 118 +++++++++++++++----------------------
>  1 file changed, 49 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 83539422b704..9f05eb722f5e 100644
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

of_device_get match_data  - obviously an unrelated change but trivial enough
I'd just slip it in this patch (unless you have it a later one!)

That returns a void * so no need for the cast.

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
> @@ -1091,7 +1072,6 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	if (IS_ERR(st->reg_base))
>  		return PTR_ERR(st->reg_base);
>  
> -
Stray change that shouldn't be in this patch ideally but not that important.

>  	/*
>  	 * Disable all IRQs before setting up the handler
>  	 */

