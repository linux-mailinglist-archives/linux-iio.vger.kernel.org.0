Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316403D1661
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 20:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbhGURsA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 21 Jul 2021 13:48:00 -0400
Received: from aposti.net ([89.234.176.197]:49002 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239078AbhGURsA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jul 2021 13:48:00 -0400
Date:   Wed, 21 Jul 2021 19:28:18 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 5/6] iio/adc: ingenic: modify
To:     citral23 <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu
Message-Id: <6ZXLWQ.5R931M3PVWBF2@crapouillou.net>
In-Reply-To: <20210721105317.36742-6-cbranchereau@gmail.com>
References: <20210721105317.36742-1-cbranchereau@gmail.com>
        <20210721105317.36742-6-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Christophe,

Le mer., juil. 21 2021 at 12:53:16 +0200, citral23 
<cbranchereau@gmail.com> a écrit :
> The current code does not allow to set MD to 0 to sample AUX0, fix it 
> for the JZ4760(B).

Well, then this should be merged with patch 3, because that means 
JZ4760 support does not work without it.

Also, concise commit messages are good, but "modify" is a bit too 
concise ;)

Cheers,
-Paul

> Signed-off-by: citral23 <cbranchereau@gmail.com>
> ---
>  drivers/iio/adc/ingenic-adc.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ingenic-adc.c 
> b/drivers/iio/adc/ingenic-adc.c
> index 618150475421..1edaae439a32 100644
> --- a/drivers/iio/adc/ingenic-adc.c
> +++ b/drivers/iio/adc/ingenic-adc.c
> @@ -632,7 +632,7 @@ static int ingenic_adc_read_chan_info_raw(struct 
> iio_dev *iio_dev,
>  					  struct iio_chan_spec const *chan,
>  					  int *val)
>  {
> -	int bit, ret, engine = (chan->channel == INGENIC_ADC_BATTERY);
> +	int cmd, ret, engine = (chan->channel == INGENIC_ADC_BATTERY);
>  	struct ingenic_adc *adc = iio_priv(iio_dev);
> 
>  	ret = clk_enable(adc->clk);
> @@ -642,11 +642,22 @@ static int 
> ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
>  		return ret;
>  	}
> 
> -	/* We cannot sample AUX/AUX2 in parallel. */
> +	/* We cannot sample the aux channels in parallel. */
>  	mutex_lock(&adc->aux_lock);
>  	if (adc->soc_data->has_aux_md && engine == 0) {
> -		bit = BIT(chan->channel == INGENIC_ADC_AUX2);
> -		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_AUX_MD, bit);
> +		switch (chan->channel) {
> +		case INGENIC_ADC_AUX0:
> +			cmd = 0;
> +			break;
> +		case INGENIC_ADC_AUX:
> +			cmd = 1;
> +			break;
> +		case INGENIC_ADC_AUX2:
> +			cmd = 2;
> +			break;
> +		}
> +
> +		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_AUX_MD, cmd);
>  	}
> 
>  	ret = ingenic_adc_capture(adc, engine);
> @@ -654,6 +665,7 @@ static int ingenic_adc_read_chan_info_raw(struct 
> iio_dev *iio_dev,
>  		goto out;
> 
>  	switch (chan->channel) {
> +	case INGENIC_ADC_AUX0:
>  	case INGENIC_ADC_AUX:
>  	case INGENIC_ADC_AUX2:
>  		*val = readw(adc->base + JZ_ADC_REG_ADSDAT);
> --
> 2.30.2
> 


