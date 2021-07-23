Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC793D3C7B
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 17:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhGWO5L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 10:57:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3469 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbhGWO5K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 10:57:10 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GWY7J5y0Fz6H7LF;
        Fri, 23 Jul 2021 23:26:04 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 17:37:42 +0200
Received: from localhost (10.210.170.238) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 23 Jul
 2021 16:37:40 +0100
Date:   Fri, 23 Jul 2021 16:37:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [v2 5/8] iio: adc: aspeed: Add func to set sampling rate.
Message-ID: <20210723163717.000066fa@Huawei.com>
In-Reply-To: <20210723081621.29477-6-billy_tsai@aspeedtech.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
        <20210723081621.29477-6-billy_tsai@aspeedtech.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.238]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Jul 2021 16:16:18 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> Add the function to set the sampling rate and keep the sampling period
> for a driver used to wait the lastest value.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
A few follow on comments from suggestion in early patch, but otherwise this
looks good to me.

Jonathan

> ---
>  drivers/iio/adc/aspeed_adc.c | 48 +++++++++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 84f079195375..bb6100228cae 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -55,6 +55,12 @@
>  
>  #define ASPEED_ADC_INIT_POLLING_TIME	500
>  #define ASPEED_ADC_INIT_TIMEOUT		500000
> +/*
> + * When the sampling rate is too high, the ADC may not have enough charging
> + * time, resulting in a low voltage value. Thus, default use slow sampling
> + * rate for most user case.
> + */
> +#define ASPEED_ADC_DEF_SAMPLING_RATE	65000
>  
>  enum aspeed_adc_version {
>  	aspeed_adc_ast2400,
> @@ -77,6 +83,7 @@ struct aspeed_adc_data {
>  	struct clk_hw		*clk_scaler;
>  	struct reset_control	*rst;
>  	int			vref;
> +	u32			sample_period_ns;
>  };
>  
>  #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
> @@ -108,6 +115,26 @@ static const struct iio_chan_spec aspeed_adc_iio_channels[] = {
>  	ASPEED_CHAN(15, 0x2E),
>  };
>  
> +static int aspeed_adc_set_sampling_rate(struct iio_dev *indio_dev, u32 rate)
> +{
> +	struct aspeed_adc_data *data = iio_priv(indio_dev);
> +	const struct aspeed_adc_model_data *model_data =
> +		of_device_get_match_data(data->dev);

As in previous patch, this would be cleaner if there was a cached copy of
the model_data pointer in data rather than looking it up each time.

> +
> +	if (rate < model_data->min_sampling_rate ||
> +	    rate > model_data->max_sampling_rate)
> +		return -EINVAL;
> +	/* Each sampling needs 12 clocks to covert.*/
> +	clk_set_rate(data->clk_scaler->clk, rate * ASPEED_CLOCKS_PER_SAMPLE);
> +
> +	rate = clk_get_rate(data->clk_scaler->clk);
> +	data->sample_period_ns = DIV_ROUND_UP_ULL(
> +		(u64)NSEC_PER_SEC * ASPEED_CLOCKS_PER_SAMPLE, rate);
> +	dev_dbg(data->dev, "Adc clock = %d sample period = %d ns", rate,
> +		data->sample_period_ns);

blank line here.

> +	return 0;
> +}
> +
>  static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
>  			       struct iio_chan_spec const *chan,
>  			       int *val, int *val2, long mask)
> @@ -138,19 +165,9 @@ static int aspeed_adc_write_raw(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *chan,
>  				int val, int val2, long mask)
>  {
> -	struct aspeed_adc_data *data = iio_priv(indio_dev);
> -	const struct aspeed_adc_model_data *model_data =
> -			of_device_get_match_data(data->dev);
> -
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		if (val < model_data->min_sampling_rate ||
> -			val > model_data->max_sampling_rate)
> -			return -EINVAL;
> -
> -		clk_set_rate(data->clk_scaler->clk,
> -				val * ASPEED_CLOCKS_PER_SAMPLE);
> -		return 0;
> +		return aspeed_adc_set_sampling_rate(indio_dev, val);
>  
>  	case IIO_CHAN_INFO_SCALE:
>  	case IIO_CHAN_INFO_RAW:
> @@ -302,6 +319,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  		goto reset_error;
>  	}
>  	reset_control_deassert(data->rst);
> +	ret = clk_prepare_enable(data->clk_scaler->clk);
> +	if (ret)
> +		goto clk_enable_error;
> +	aspeed_adc_set_sampling_rate(indio_dev, ASPEED_ADC_DEF_SAMPLING_RATE);
>  
>  	ret = aspeed_adc_vref_config(pdev);
>  	if (ret)
> @@ -327,9 +348,6 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  			goto poll_timeout_error;
>  	}
>  
> -	ret = clk_prepare_enable(data->clk_scaler->clk);
> -	if (ret)
> -		goto clk_enable_error;
>  	adc_engine_control_reg_val =
>  		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
>  	/* Start all channels in normal mode. */
> @@ -354,8 +372,8 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  iio_register_error:
>  	writel(ASPEED_ADC_OPERATION_MODE_POWER_DOWN,
>  		data->base + ASPEED_REG_ENGINE_CONTROL);
> -	clk_disable_unprepare(data->clk_scaler->clk);
>  vref_config_error:
> +	clk_disable_unprepare(data->clk_scaler->clk);
>  clk_enable_error:
>  poll_timeout_error:
>  	reset_control_assert(data->rst);

