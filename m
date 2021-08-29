Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851233FACB1
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 17:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbhH2PhK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 11:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39063 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235245AbhH2PhJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 11:37:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1810260F3A;
        Sun, 29 Aug 2021 15:36:11 +0000 (UTC)
Date:   Sun, 29 Aug 2021 16:39:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     <lars@metafoo.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <p.zabel@pengutronix.de>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [RESEND v4 13/15] iio: adc: aspeed: Add compensation phase.
Message-ID: <20210829163923.107f4027@jic23-huawei>
In-Reply-To: <202108250006.17P066YP096721@twspam01.aspeedtech.com>
References: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
        <202108250006.17P066YP096721@twspam01.aspeedtech.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Aug 2021 17:12:41 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> This patch adds a compensation phase to improve the accurate of ADC

accuracy of the ADC measurement.

> measurement. This is the built-in function though input half of the
> reference voltage to get the ADC offset.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
This looks like fairly standard calibration which is good to have.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/aspeed_adc.c | 54 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 4d979dd7fe88..20caf28dff18 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -95,6 +95,7 @@ struct aspeed_adc_data {
>  	struct reset_control	*rst;
>  	int			vref;
>  	u32			sample_period_ns;
> +	int			cv;
>  };
>  
>  #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
> @@ -104,7 +105,8 @@ struct aspeed_adc_data {
>  	.address = (_data_reg_addr),				\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> -				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
> +				BIT(IIO_CHAN_INFO_OFFSET),	\
>  }
>  
>  static const struct iio_chan_spec aspeed_adc_iio_channels[] = {
> @@ -126,6 +128,51 @@ static const struct iio_chan_spec aspeed_adc_iio_channels[] = {
>  	ASPEED_CHAN(15, 0x2E),
>  };
>  
> +static int aspeed_adc_compensation(struct iio_dev *indio_dev)
> +{
> +	struct aspeed_adc_data *data = iio_priv(indio_dev);
> +	u32 index, adc_raw = 0;
> +	u32 adc_engine_control_reg_val;
> +
> +	adc_engine_control_reg_val =
> +		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
> +	adc_engine_control_reg_val &= ~ASPEED_ADC_OP_MODE;
> +	adc_engine_control_reg_val |=
> +		(FIELD_PREP(ASPEED_ADC_OP_MODE, ASPEED_ADC_OP_MODE_NORMAL) |
> +		 ASPEED_ADC_ENGINE_ENABLE);
> +	/*
> +	 * Enable compensating sensing:
> +	 * After that, the input voltage of ADC will force to half of the reference
> +	 * voltage. So the expected reading raw data will become half of the max
> +	 * value. We can get compensating value = 0x200 - ADC read raw value.
> +	 * It is recommended to average at least 10 samples to get a final CV.
> +	 */
> +	writel(adc_engine_control_reg_val | ASPEED_ADC_CTRL_COMPENSATION |
> +		       ASPEED_ADC_CTRL_CHANNEL_ENABLE(0),
> +	       data->base + ASPEED_REG_ENGINE_CONTROL);
> +	/*
> +	 * After enable compensating sensing mode need to wait some time for ADC stable
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
> +	dev_dbg(data->dev, "Compensating value = %d\n", data->cv);
> +
> +	return 0;
> +}
> +
>  static int aspeed_adc_set_sampling_rate(struct iio_dev *indio_dev, u32 rate)
>  {
>  	struct aspeed_adc_data *data = iio_priv(indio_dev);
> @@ -155,6 +202,10 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
>  		*val = readw(data->base + chan->address);
>  		return IIO_VAL_INT;
>  
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = data->cv;
> +		return IIO_VAL_INT;
> +
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = data->vref;
>  		*val2 = ASPEED_RESOLUTION_BITS;
> @@ -444,6 +495,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> +	aspeed_adc_compensation(indio_dev);
>  	/* Start all channels in normal mode. */
>  	adc_engine_control_reg_val =
>  		readl(data->base + ASPEED_REG_ENGINE_CONTROL);

