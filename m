Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9BF1D9EFC
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 20:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgESSPk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 14:15:40 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726447AbgESSPk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 May 2020 14:15:40 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 578699F2B73643D873E3;
        Tue, 19 May 2020 19:15:39 +0100 (IST)
Received: from localhost (10.47.86.149) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 19 May
 2020 19:15:38 +0100
Date:   Tue, 19 May 2020 19:15:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Artur Rojek <contact@artur-rojek.eu>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Ezequiel Garcia" <ezequiel@vanguardiasur.com.ar>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/7] IIO: Ingenic JZ47xx: Error check clk_enable
 calls.
Message-ID: <20200519191511.00007c78@Huawei.com>
In-Reply-To: <20200517194904.34758-2-contact@artur-rojek.eu>
References: <20200517194904.34758-1-contact@artur-rojek.eu>
        <20200517194904.34758-2-contact@artur-rojek.eu>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.149]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 May 2020 21:48:59 +0200
Artur Rojek <contact@artur-rojek.eu> wrote:

> Introduce error checks for the clk_enable calls used in this driver.
> As part of the changes, move clk_enable/clk_disable calls out of
> ingenic_adc_set_config and into respective logic of its callers.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>

One trivial thing inline.

> ---
> 
>  Changes:
> 
>  v6: new patch
> 
>  v7: no change
> 
>  drivers/iio/adc/ingenic-adc.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
> index 39c0a609fc94..6c3bbba7c44b 100644
> --- a/drivers/iio/adc/ingenic-adc.c
> +++ b/drivers/iio/adc/ingenic-adc.c
> @@ -73,7 +73,6 @@ static void ingenic_adc_set_config(struct ingenic_adc *adc,
>  {
>  	uint32_t cfg;
>  
> -	clk_enable(adc->clk);
>  	mutex_lock(&adc->lock);
>  
>  	cfg = readl(adc->base + JZ_ADC_REG_CFG) & ~mask;
> @@ -81,7 +80,6 @@ static void ingenic_adc_set_config(struct ingenic_adc *adc,
>  	writel(cfg, adc->base + JZ_ADC_REG_CFG);
>  
>  	mutex_unlock(&adc->lock);
> -	clk_disable(adc->clk);
>  }
>  
>  static void ingenic_adc_enable(struct ingenic_adc *adc,
> @@ -124,6 +122,8 @@ static int ingenic_adc_write_raw(struct iio_dev *iio_dev,
>  				 long m)
>  {
>  	struct ingenic_adc *adc = iio_priv(iio_dev);
> +	struct device *dev = iio_dev->dev.parent;
> +	int ret;
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_SCALE:
> @@ -131,6 +131,14 @@ static int ingenic_adc_write_raw(struct iio_dev *iio_dev,
>  		case INGENIC_ADC_BATTERY:
>  			if (!adc->soc_data->battery_vref_mode)
>  				return -EINVAL;
> +
> +			ret = clk_enable(adc->clk);
> +			if (ret) {
> +				dev_err(dev, "Failed to enable clock: %d\n",
> +					ret);
> +				return ret;
> +			}
> +
>  			if (val > JZ_ADC_BATTERY_LOW_VREF) {
>  				ingenic_adc_set_config(adc,
>  						       JZ_ADC_REG_CFG_BAT_MD,
> @@ -142,6 +150,9 @@ static int ingenic_adc_write_raw(struct iio_dev *iio_dev,
>  						       JZ_ADC_REG_CFG_BAT_MD);
>  				adc->low_vref_mode = true;
>  			}
> +
> +			clk_disable(adc->clk);
> +
>  			return 0;
>  		default:
>  			return -EINVAL;
> @@ -317,6 +328,13 @@ static int ingenic_adc_read_chan_info_raw(struct ingenic_adc *adc,
>  					  int *val)
>  {
>  	int bit, ret, engine = (chan->channel == INGENIC_ADC_BATTERY);
> +	struct device *dev = iio_priv_to_dev(adc)->dev.parent;
> +
> +	ret = clk_enable(adc->clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable clock: %d\n", ret);
> +		return ret;
> +	}

It almost certainly doesn't matter, but if we are going to move the clk enable
outside the lock, we should do the same with the disable.

>  
>  	/* We cannot sample AUX/AUX2 in parallel. */
>  	mutex_lock(&adc->aux_lock);
> @@ -325,7 +343,6 @@ static int ingenic_adc_read_chan_info_raw(struct ingenic_adc *adc,
>  		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_AUX_MD, bit);
>  	}
>  
> -	clk_enable(adc->clk);
>  	ret = ingenic_adc_capture(adc, engine);
>  	if (ret)
>  		goto out;


