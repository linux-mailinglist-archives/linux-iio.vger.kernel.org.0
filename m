Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B293D1559
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 19:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbhGURFn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 21 Jul 2021 13:05:43 -0400
Received: from aposti.net ([89.234.176.197]:46128 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbhGURFl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jul 2021 13:05:41 -0400
Date:   Wed, 21 Jul 2021 18:46:03 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/6] iio/adc: ingenic: rename has_aux2 to has_aux_md
To:     citral23 <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu
Message-Id: <R0WLWQ.W9AI9L33KSD33@crapouillou.net>
In-Reply-To: <20210721105317.36742-2-cbranchereau@gmail.com>
References: <20210721105317.36742-1-cbranchereau@gmail.com>
        <20210721105317.36742-2-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Christophe,

Le mer., juil. 21 2021 at 12:53:12 +0200, citral23 
<cbranchereau@gmail.com> a écrit :
> The purpose of this property is to set the AUX_MD bits if true, no to 
> describe the hardware.
> Rename it to a more appropriate name.

You could add that this change is needed to support the JZ4760 which 
has three AUX channels.

> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/iio/adc/ingenic-adc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ingenic-adc.c 
> b/drivers/iio/adc/ingenic-adc.c
> index 34c03a264f74..40f2d8c2cf72 100644
> --- a/drivers/iio/adc/ingenic-adc.c
> +++ b/drivers/iio/adc/ingenic-adc.c
> @@ -92,7 +92,7 @@ struct ingenic_adc_soc_data {
>  	const int *battery_scale_avail;
>  	size_t battery_scale_avail_size;
>  	unsigned int battery_vref_mode: 1;
> -	unsigned int has_aux2: 1;
> +	unsigned int has_aux_md: 1;
>  	const struct iio_chan_spec *channels;
>  	unsigned int num_channels;
>  	int (*init_clk_div)(struct device *dev, struct ingenic_adc *adc);
> @@ -506,7 +506,7 @@ static const struct ingenic_adc_soc_data 
> jz4725b_adc_soc_data = {
>  	.battery_scale_avail = jz4725b_adc_battery_scale_avail,
>  	.battery_scale_avail_size = 
> ARRAY_SIZE(jz4725b_adc_battery_scale_avail),
>  	.battery_vref_mode = true,
> -	.has_aux2 = false,
> +	.has_aux_md = false,
>  	.channels = jz4740_channels,
>  	.num_channels = ARRAY_SIZE(jz4740_channels),
>  	.init_clk_div = jz4725b_adc_init_clk_div,
> @@ -520,7 +520,7 @@ static const struct ingenic_adc_soc_data 
> jz4740_adc_soc_data = {
>  	.battery_scale_avail = jz4740_adc_battery_scale_avail,
>  	.battery_scale_avail_size = 
> ARRAY_SIZE(jz4740_adc_battery_scale_avail),
>  	.battery_vref_mode = true,
> -	.has_aux2 = false,
> +	.has_aux_md = false,
>  	.channels = jz4740_channels,
>  	.num_channels = ARRAY_SIZE(jz4740_channels),
>  	.init_clk_div = NULL, /* no ADCLK register on JZ4740 */
> @@ -534,7 +534,7 @@ static const struct ingenic_adc_soc_data 
> jz4770_adc_soc_data = {
>  	.battery_scale_avail = jz4770_adc_battery_scale_avail,
>  	.battery_scale_avail_size = 
> ARRAY_SIZE(jz4770_adc_battery_scale_avail),
>  	.battery_vref_mode = false,
> -	.has_aux2 = true,
> +	.has_aux_md = true,
>  	.channels = jz4770_channels,
>  	.num_channels = ARRAY_SIZE(jz4770_channels),
>  	.init_clk_div = jz4770_adc_init_clk_div,
> @@ -581,7 +581,7 @@ static int ingenic_adc_read_chan_info_raw(struct 
> iio_dev *iio_dev,
> 
>  	/* We cannot sample AUX/AUX2 in parallel. */
>  	mutex_lock(&adc->aux_lock);
> -	if (adc->soc_data->has_aux2 && engine == 0) {
> +	if (adc->soc_data->has_aux_md && engine == 0) {
>  		bit = BIT(chan->channel == INGENIC_ADC_AUX2);
>  		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_AUX_MD, bit);
>  	}
> --
> 2.30.2
> 


