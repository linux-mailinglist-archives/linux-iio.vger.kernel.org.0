Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D177C2B2EB4
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 17:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgKNQ7O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 11:59:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgKNQ7O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 11:59:14 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02B282225E;
        Sat, 14 Nov 2020 16:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605373153;
        bh=cjB+drbINAJdUmcp4UvHY8mJSzoyPE2AwWWa5myoEeY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aRuNMlKXSC9ytHYg7gvF7eXVcI76DiuCFVrLTmN9pwcfAyNYvVHn86t8ReHhuchCE
         BQvOpXbdx7sV9Ko85CCE+Xa9sQhlhInFifVXXZkAs9KddvGAM7j0AS5w2siq0UiYvW
         W6+sqoPG3LuMlyg0N5btjJdtiWlncK1rFwf/7vIE=
Date:   Sat, 14 Nov 2020 16:59:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] iio: adc: at91_adc: rework resolution selection
Message-ID: <20201114165908.1fdf1b82@archlinux>
In-Reply-To: <20201113212650.507680-3-alexandre.belloni@bootlin.com>
References: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
        <20201113212650.507680-3-alexandre.belloni@bootlin.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Nov 2020 22:26:43 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Move the possible resolution values back to the driver. This removes the
> atmel,adc-res and atmel,adc-res-names properties, leaving only
> atmel,adc-use-res. As atmel,adc-res-names had to contain "lowres" and
> "highres", those where already the only allowed values for
> atmel,adc-use-res.
> 
> Also introduce a new compatible string for the sama5d3 as this is the only
> one with a different resolution. Also it doesn't event have the LOWRES

even?

> bit.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Looks good otherwise.  

> ---
>  .../devicetree/bindings/iio/adc/at91_adc.txt  | 13 +--
>  drivers/iio/adc/at91_adc.c                    | 97 ++++++++-----------
>  2 files changed, 44 insertions(+), 66 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/at91_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91_adc.txt
> index f65b04fb7962..da393ac5c05f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/at91_adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/at91_adc.txt
> @@ -2,7 +2,7 @@
>  
>  Required properties:
>    - compatible: Should be "atmel,<chip>-adc"
> -    <chip> can be "at91sam9260", "at91sam9g45" or "at91sam9x5"
> +    <chip> can be "at91sam9260", "at91sam9g45", "at91sam9x5" or "sama5d3"
>    - reg: Should contain ADC registers location and length
>    - interrupts: Should contain the IRQ line for the ADC
>    - clock-names: tuple listing input clock names.
> @@ -13,17 +13,12 @@ Required properties:
>    - atmel,adc-startup-time: Startup Time of the ADC in microseconds as
>      defined in the datasheet
>    - atmel,adc-vref: Reference voltage in millivolts for the conversions
> -  - atmel,adc-res: List of resolutions in bits supported by the ADC. List size
> -		   must be two at least.
> -  - atmel,adc-res-names: Contains one identifier string for each resolution
> -			 in atmel,adc-res property. "lowres" and "highres"
> -			 identifiers are required.
>  
>  Optional properties:
>    - atmel,adc-use-external-triggers: Boolean to enable the external triggers
> -  - atmel,adc-use-res: String corresponding to an identifier from
> -		       atmel,adc-res-names property. If not specified, the highest
> -		       resolution will be used.
> +  - atmel,adc-use-res: String selecting the resolution, can be "lowres" or
> +		       "highres". If not specified, the highest resolution will
> +		       be used.
>    - atmel,adc-sleep-mode: Boolean to enable sleep mode when no conversion
>    - atmel,adc-sample-hold-time: Sample and Hold Time in microseconds
>    - atmel,adc-ts-wires: Number of touchscreen wires. Should be 4 or 5. If this
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 62bd35af8b13..0d67c812ef3d 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -204,6 +204,9 @@ struct at91_adc_caps {
>  	u32 (*calc_startup_ticks)(u32 startup_time, u32 adc_clk_khz);
>  
>  	u8	num_channels;
> +
> +	u8	low_res_bits;
> +	u8	high_res_bits;
>  	struct at91_adc_reg_desc registers;
>  };
>  
> @@ -229,7 +232,6 @@ struct at91_adc_state {
>  	bool			use_external;
>  	u32			vref_mv;
>  	u32			res;		/* resolution used for convertions */
> -	bool			low_res;	/* the resolution corresponds to the lowest one */
>  	wait_queue_head_t	wq_data_avail;
>  	struct at91_adc_caps	*caps;
>  
> @@ -754,58 +756,6 @@ static int at91_adc_read_raw(struct iio_dev *idev,
>  	return -EINVAL;
>  }
>  
> -static int at91_adc_of_get_resolution(struct iio_dev *idev,
> -				      struct platform_device *pdev)
> -{
> -	struct at91_adc_state *st = iio_priv(idev);
> -	struct device_node *np = pdev->dev.of_node;
> -	int count, i, ret = 0;
> -	char *res_name, *s;
> -	u32 *resolutions;
> -
> -	count = of_property_count_strings(np, "atmel,adc-res-names");
> -	if (count < 2) {
> -		dev_err(&idev->dev, "You must specified at least two resolution names for "
> -				    "adc-res-names property in the DT\n");
> -		return count;
> -	}
> -
> -	resolutions = kmalloc_array(count, sizeof(*resolutions), GFP_KERNEL);
> -	if (!resolutions)
> -		return -ENOMEM;
> -
> -	if (of_property_read_u32_array(np, "atmel,adc-res", resolutions, count)) {
> -		dev_err(&idev->dev, "Missing adc-res property in the DT.\n");
> -		ret = -ENODEV;
> -		goto ret;
> -	}
> -
> -	if (of_property_read_string(np, "atmel,adc-use-res", (const char **)&res_name))
> -		res_name = "highres";
> -
> -	for (i = 0; i < count; i++) {
> -		if (of_property_read_string_index(np, "atmel,adc-res-names", i, (const char **)&s))
> -			continue;
> -
> -		if (strcmp(res_name, s))
> -			continue;
> -
> -		st->res = resolutions[i];
> -		if (!strcmp(res_name, "lowres"))
> -			st->low_res = true;
> -		else
> -			st->low_res = false;
> -
> -		dev_info(&idev->dev, "Resolution used: %u bits\n", st->res);
> -		goto ret;
> -	}
> -
> -	dev_err(&idev->dev, "There is no resolution for %s\n", res_name);
> -
> -ret:
> -	kfree(resolutions);
> -	return ret;
> -}
>  
>  static u32 calc_startup_ticks_9260(u32 startup_time, u32 adc_clk_khz)
>  {
> @@ -891,6 +841,7 @@ static int at91_adc_probe_dt(struct iio_dev *idev,
>  	struct device_node *trig_node;
>  	int i = 0, ret;
>  	u32 prop;
> +	char *s;
>  
>  	st->caps = (struct at91_adc_caps *)
>  		of_match_device(at91_adc_dt_ids, &pdev->dev)->data;
> @@ -924,9 +875,13 @@ static int at91_adc_probe_dt(struct iio_dev *idev,
>  	}
>  	st->vref_mv = prop;
>  
> -	ret = at91_adc_of_get_resolution(idev, pdev);
> -	if (ret)
> -		goto error_ret;
> +	st->res = st->caps->high_res_bits;
> +	if (st->caps->low_res_bits &&
> +	    !of_property_read_string(node, "atmel,adc-use-res", (const char **)&s)
> +	    && !strcmp(s, "lowres"))
> +		st->res = st->caps->low_res_bits;
> +
> +	dev_info(&idev->dev, "Resolution used: %u bits\n", st->res);
>  
>  	st->registers = &st->caps->registers;
>  	st->num_channels = st->caps->num_channels;
> @@ -1248,7 +1203,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	reg = AT91_ADC_PRESCAL_(prsc) & st->registers->mr_prescal_mask;
>  	reg |= AT91_ADC_STARTUP_(ticks) & st->registers->mr_startup_mask;
> -	if (st->low_res)
> +	if (st->res == st->caps->low_res_bits)
>  		reg |= AT91_ADC_LOWRES;
>  	if (st->sleep_mode)
>  		reg |= AT91_ADC_SLEEP;
> @@ -1363,6 +1318,8 @@ static SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend, at91_adc_resume);
>  static struct at91_adc_caps at91sam9260_caps = {
>  	.calc_startup_ticks = calc_startup_ticks_9260,
>  	.num_channels = 4,
> +	.low_res_bits = 8,
> +	.high_res_bits = 10,
>  	.registers = {
>  		.channel_base = AT91_ADC_CHR(0),
>  		.drdy_mask = AT91_ADC_DRDY,
> @@ -1377,6 +1334,8 @@ static struct at91_adc_caps at91sam9rl_caps = {
>  	.has_ts = true,
>  	.calc_startup_ticks = calc_startup_ticks_9260,	/* same as 9260 */
>  	.num_channels = 6,
> +	.low_res_bits = 8,
> +	.high_res_bits = 10,
>  	.registers = {
>  		.channel_base = AT91_ADC_CHR(0),
>  		.drdy_mask = AT91_ADC_DRDY,
> @@ -1391,6 +1350,8 @@ static struct at91_adc_caps at91sam9g45_caps = {
>  	.has_ts = true,
>  	.calc_startup_ticks = calc_startup_ticks_9260,	/* same as 9260 */
>  	.num_channels = 8,
> +	.low_res_bits = 8,
> +	.high_res_bits = 10,
>  	.registers = {
>  		.channel_base = AT91_ADC_CHR(0),
>  		.drdy_mask = AT91_ADC_DRDY,
> @@ -1408,6 +1369,8 @@ static struct at91_adc_caps at91sam9x5_caps = {
>  	.ts_pen_detect_sensitivity = 2,
>  	.calc_startup_ticks = calc_startup_ticks_9x5,
>  	.num_channels = 12,
> +	.low_res_bits = 8,
> +	.high_res_bits = 10,
>  	.registers = {
>  		.channel_base = AT91_ADC_CDR0_9X5,
>  		.drdy_mask = AT91_ADC_SR_DRDY_9X5,
> @@ -1419,11 +1382,31 @@ static struct at91_adc_caps at91sam9x5_caps = {
>  	},
>  };
>  
> +static struct at91_adc_caps sama5d3_caps = {
> +	.has_ts = true,
> +	.has_tsmr = true,
> +	.ts_filter_average = 3,
> +	.ts_pen_detect_sensitivity = 2,
> +	.calc_startup_ticks = calc_startup_ticks_9x5,
> +	.num_channels = 12,
> +	.low_res_bits = 0,
> +	.high_res_bits = 12,
> +	.registers = {
> +		.channel_base = AT91_ADC_CDR0_9X5,
> +		.drdy_mask = AT91_ADC_SR_DRDY_9X5,
> +		.status_register = AT91_ADC_SR_9X5,
> +		.trigger_register = AT91_ADC_TRGR_9X5,
> +		.mr_prescal_mask = AT91_ADC_PRESCAL_9G45,
> +		.mr_startup_mask = AT91_ADC_STARTUP_9X5,
> +	},
> +};
> +
>  static const struct of_device_id at91_adc_dt_ids[] = {
>  	{ .compatible = "atmel,at91sam9260-adc", .data = &at91sam9260_caps },
>  	{ .compatible = "atmel,at91sam9rl-adc", .data = &at91sam9rl_caps },
>  	{ .compatible = "atmel,at91sam9g45-adc", .data = &at91sam9g45_caps },
>  	{ .compatible = "atmel,at91sam9x5-adc", .data = &at91sam9x5_caps },
> +	{ .compatible = "atmel,sama5d3-adc", .data = &sama5d3_caps },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, at91_adc_dt_ids);

