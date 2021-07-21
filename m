Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020EA3D1605
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 20:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbhGURfX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 21 Jul 2021 13:35:23 -0400
Received: from aposti.net ([89.234.176.197]:48358 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231158AbhGURfW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jul 2021 13:35:22 -0400
Date:   Wed, 21 Jul 2021 19:15:47 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/6] iio/adc: ingenic: add JZ4760 support to the sadc
 driver
To:     citral23 <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu
Message-Id: <BEXLWQ.Q6JDGD8HI0S31@crapouillou.net>
In-Reply-To: <20210721105317.36742-4-cbranchereau@gmail.com>
References: <20210721105317.36742-1-cbranchereau@gmail.com>
        <20210721105317.36742-4-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Christophe,

Le mer., juil. 21 2021 at 12:53:14 +0200, citral23 
<cbranchereau@gmail.com> a écrit :
> Signed-off-by: citral23 <cbranchereau@gmail.com>
> ---
>  drivers/iio/adc/ingenic-adc.c | 64 
> +++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/iio/adc/ingenic-adc.c 
> b/drivers/iio/adc/ingenic-adc.c
> index 40f2d8c2cf72..285e7aa8e37a 100644
> --- a/drivers/iio/adc/ingenic-adc.c
> +++ b/drivers/iio/adc/ingenic-adc.c
> @@ -71,6 +71,7 @@
>  #define JZ4725B_ADC_BATTERY_HIGH_VREF_BITS	10
>  #define JZ4740_ADC_BATTERY_HIGH_VREF		(7500 * 0.986)
>  #define JZ4740_ADC_BATTERY_HIGH_VREF_BITS	12
> +#define JZ4760_ADC_BATTERY_VREF			2500
>  #define JZ4770_ADC_BATTERY_VREF			1200
>  #define JZ4770_ADC_BATTERY_VREF_BITS		12
> 
> @@ -295,6 +296,10 @@ static const int 
> jz4740_adc_battery_scale_avail[] = {
>  	JZ_ADC_BATTERY_LOW_VREF, JZ_ADC_BATTERY_LOW_VREF_BITS,
>  };
> 
> +static const int jz4760_adc_battery_scale_avail[] = {
> +	JZ4760_ADC_BATTERY_VREF, JZ4770_ADC_BATTERY_VREF_BITS,
> +};
> +
>  static const int jz4770_adc_battery_raw_avail[] = {
>  	0, 1, (1 << JZ4770_ADC_BATTERY_VREF_BITS) - 1,
>  };
> @@ -339,6 +344,8 @@ static int jz4725b_adc_init_clk_div(struct device 
> *dev, struct ingenic_adc *adc)
>  	return 0;
>  }
> 
> +
> +

Unrelated cosmetic change - remove it.

>  static int jz4770_adc_init_clk_div(struct device *dev, struct 
> ingenic_adc *adc)
>  {
>  	struct clk *parent_clk;
> @@ -400,6 +407,47 @@ static const struct iio_chan_spec 
> jz4740_channels[] = {
>  	},
>  };
> 
> +static const struct iio_chan_spec jz4760_channels[] = {
> +	{
> +		.extend_name = "aux0",
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.indexed = 1,
> +		.channel = INGENIC_ADC_AUX0,
> +		.scan_index = -1,
> +	},
> +	{
> +		.extend_name = "aux",
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.indexed = 1,
> +		.channel = INGENIC_ADC_AUX,
> +		.scan_index = -1,
> +	},

A couple of things. First, ".extend_name" is deprecated now... But 
since the driver used it before, I suppose it doesn't make sense to use 
labels just for this SoC (as we can't remove .extend_name for other 
SoCs because of ABI). So I suppose it works here, but maybe Jonathan 
disagrees.

Also, you should probably use "aux1" as the channel's name instead of 
"aux", independently of the macro name you used in the .channel field.

> +	{
> +		.extend_name = "battery",
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW) |
> +						BIT(IIO_CHAN_INFO_SCALE),
> +		.indexed = 1,
> +		.channel = INGENIC_ADC_BATTERY,
> +		.scan_index = -1,
> +	},

Swap the battery channel at the end, no? First the three AUX then the 
battery channel?

The rest looks pretty good to me.

Cheers,
-Paul

> +	{
> +		.extend_name = "aux2",
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.indexed = 1,
> +		.channel = INGENIC_ADC_AUX2,
> +		.scan_index = -1,
> +	},
> +};
> +
>  static const struct iio_chan_spec jz4770_channels[] = {
>  	{
>  		.type = IIO_VOLTAGE,
> @@ -526,6 +574,20 @@ static const struct ingenic_adc_soc_data 
> jz4740_adc_soc_data = {
>  	.init_clk_div = NULL, /* no ADCLK register on JZ4740 */
>  };
> 
> +static const struct ingenic_adc_soc_data jz4760_adc_soc_data = {
> +	.battery_high_vref = JZ4760_ADC_BATTERY_VREF,
> +	.battery_high_vref_bits = JZ4770_ADC_BATTERY_VREF_BITS,
> +	.battery_raw_avail = jz4770_adc_battery_raw_avail,
> +	.battery_raw_avail_size = ARRAY_SIZE(jz4770_adc_battery_raw_avail),
> +	.battery_scale_avail = jz4760_adc_battery_scale_avail,
> +	.battery_scale_avail_size = 
> ARRAY_SIZE(jz4760_adc_battery_scale_avail),
> +	.battery_vref_mode = false,
> +	.has_aux_md = true,
> +	.channels = jz4760_channels,
> +	.num_channels = ARRAY_SIZE(jz4760_channels),
> +	.init_clk_div = jz4770_adc_init_clk_div,
> +};
> +
>  static const struct ingenic_adc_soc_data jz4770_adc_soc_data = {
>  	.battery_high_vref = JZ4770_ADC_BATTERY_VREF,
>  	.battery_high_vref_bits = JZ4770_ADC_BATTERY_VREF_BITS,
> @@ -621,6 +683,7 @@ static int ingenic_adc_read_raw(struct iio_dev 
> *iio_dev,
>  		return ingenic_adc_read_chan_info_raw(iio_dev, chan, val);
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->channel) {
> +		case INGENIC_ADC_AUX0:
>  		case INGENIC_ADC_AUX:
>  		case INGENIC_ADC_AUX2:
>  			*val = JZ_ADC_AUX_VREF;
> @@ -832,6 +895,7 @@ static int ingenic_adc_probe(struct 
> platform_device *pdev)
>  static const struct of_device_id ingenic_adc_of_match[] = {
>  	{ .compatible = "ingenic,jz4725b-adc", .data = 
> &jz4725b_adc_soc_data, },
>  	{ .compatible = "ingenic,jz4740-adc", .data = &jz4740_adc_soc_data, 
> },
> +	{ .compatible = "ingenic,jz4760-adc", .data = &jz4760_adc_soc_data, 
> },
>  	{ .compatible = "ingenic,jz4770-adc", .data = &jz4770_adc_soc_data, 
> },
>  	{ },
>  };
> --
> 2.30.2
> 


