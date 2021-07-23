Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928CA3D3CA9
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 17:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbhGWPEK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 11:04:10 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3470 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbhGWPEJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 11:04:09 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GWYLQ2xgwz6G8Gv;
        Fri, 23 Jul 2021 23:35:42 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 17:44:40 +0200
Received: from localhost (10.210.170.238) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 23 Jul
 2021 16:44:39 +0100
Date:   Fri, 23 Jul 2021 16:44:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [v2 6/8] iio: adc: aspeed: Add compensation phase.
Message-ID: <20210723164413.00003de8@Huawei.com>
In-Reply-To: <20210723081621.29477-7-billy_tsai@aspeedtech.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
        <20210723081621.29477-7-billy_tsai@aspeedtech.com>
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

On Fri, 23 Jul 2021 16:16:19 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> This patch adds a compensation phase to improve the accurate of adc

ADC

> measurement. This is the builtin function though input half of the

built-in 

> reference voltage to get the adc offset.

ADC

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/iio/adc/aspeed_adc.c | 52 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index bb6100228cae..0153b28b83b7 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -61,6 +61,7 @@
>   * rate for most user case.
>   */
>  #define ASPEED_ADC_DEF_SAMPLING_RATE	65000
> +#define ASPEED_ADC_MAX_RAW_DATA		GENMASK(9, 0)
>  
>  enum aspeed_adc_version {
>  	aspeed_adc_ast2400,
> @@ -84,6 +85,7 @@ struct aspeed_adc_data {
>  	struct reset_control	*rst;
>  	int			vref;
>  	u32			sample_period_ns;
> +	int			cv;
>  };
>  
>  #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
> @@ -115,6 +117,48 @@ static const struct iio_chan_spec aspeed_adc_iio_channels[] = {
>  	ASPEED_CHAN(15, 0x2E),
>  };
>  
> +static int aspeed_adc_compensation(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);

Same comment as previous patches.  pdev doesn't seem to be the best thing
to pass into these functions.

> +	struct aspeed_adc_data *data = iio_priv(indio_dev);
> +	u32 index, adc_raw = 0;
> +	u32 adc_engine_control_reg_val =
> +		readl(data->base + ASPEED_REG_ENGINE_CONTROL);

blank line here. In this case I would suggest

	u32 adc_engine_control_reg_val;

	adc_engine_control_reg_val = readl(...)
	
	adc_engine_control_reg_val |= ...

Whilst we are hear, I'd normally also expect to see a mask to ensure that
we have no stray bits set.  In this particular case MODE_NORMAL is the mask
but the reviewer shoudn't need to check that!

> +	adc_engine_control_reg_val |=
> +		(ASPEED_ADC_OPERATION_MODE_NORMAL | ASPEED_ADC_ENGINE_ENABLE);
> +
> +	/*
> +	 * Enable compensating sensing:
> +	 * After that, the input voltage of adc will force to half of the reference

"ADC" in all places it appears in comments.

> +	 * voltage. So the expected reading raw data will become half of the max
> +	 * value. We can get compensating value = 0x200 - adc read raw value.
> +	 * It is recommended to average at least 10 samples to get a final CV.
> +	 */
> +	writel(adc_engine_control_reg_val | ASPEED_ADC_CTRL_COMPENSATION |
> +		       ASPEED_ADC_CTRL_CHANNEL_ENABLE(0),
> +	       data->base + ASPEED_REG_ENGINE_CONTROL);
> +	/*
> +	 * After enable compensating sensing mode need to wait some time for adc stable
> +	 * Experiment result is 1ms.
> +	 */
> +	mdelay(1);
> +
> +	for (index = 0; index < 16; index++) {
> +		/*
> +		 * Waiting for the sampling period ensures that the value acquired
> +		 * is fresh each time.
> +		 */
> +		ndelay(data->sample_period_ns);
> +		adc_raw += readw(data->base + aspeed_adc_iio_channels[0].address);
> +	}
> +	adc_raw >>= 4;
> +	data->cv = BIT(ASPEED_RESOLUTION_BITS - 1) - adc_raw;
> +	writel(adc_engine_control_reg_val,
> +	       data->base + ASPEED_REG_ENGINE_CONTROL);
> +	dev_dbg(data->dev, "compensating value = %d\n", data->cv);

Blank line here.

> +	return 0;
> +}
> +
>  static int aspeed_adc_set_sampling_rate(struct iio_dev *indio_dev, u32 rate)
>  {
>  	struct aspeed_adc_data *data = iio_priv(indio_dev);
> @@ -143,7 +187,11 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		*val = readw(data->base + chan->address);
> +		*val = readw(data->base + chan->address) + data->cv;

We would normally express this as IIO_CHAN_INFO_OFFSET, thus allowing
userspace to see and apply the compensation offset.  It could also modify
it if necessary (perhaps some long term drift effect or temperature effect
might mean userspace has more info than the kernel).

> +		if (*val < 0)
> +			*val = 0;
> +		else if (*val >= ASPEED_ADC_MAX_RAW_DATA)
> +			*val = ASPEED_ADC_MAX_RAW_DATA;

Why clamp the value like this? I'm not sure I follow the logic. Is it
because some userspace might rely on the existing range?

>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> @@ -347,7 +395,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  		if (ret)
>  			goto poll_timeout_error;
>  	}
> -
Keep the blank line.

> +	aspeed_adc_compensation(pdev);
>  	adc_engine_control_reg_val =
>  		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
>  	/* Start all channels in normal mode. */

