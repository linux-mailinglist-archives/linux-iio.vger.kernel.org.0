Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112203DC66E
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhGaO5N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 10:57:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233035AbhGaO5M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Jul 2021 10:57:12 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD46C60EBC;
        Sat, 31 Jul 2021 14:57:02 +0000 (UTC)
Date:   Sat, 31 Jul 2021 15:59:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v4 3/5] iio: adc: ad7949: add support for internal vref
Message-ID: <20210731155941.0423c4c5@jic23-huawei>
In-Reply-To: <20210727232906.980769-4-liambeguin@gmail.com>
References: <20210727232906.980769-1-liambeguin@gmail.com>
        <20210727232906.980769-4-liambeguin@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Jul 2021 19:29:04 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> Add support for selecting a custom reference voltage from the
> devicetree. If an external source is used, a vref regulator should be
> defined in the devicetree.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>

I didn't do a great job reviewing earlier versions of this series. Sorry about
that. As a result some comments inline.

Jonathan

> ---
>  drivers/iio/adc/ad7949.c | 132 +++++++++++++++++++++++++++++++++------
>  1 file changed, 114 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index f1702c54c8be..eaea8f5e87d8 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -35,7 +35,11 @@
>  
>  /* REF: reference/buffer selection */
>  #define AD7949_CFG_BIT_REF		GENMASK(5, 3)
> -#define AD7949_CFG_VAL_REF_EXT_BUF		7
> +#define AD7949_CFG_VAL_REF_EXT_TEMP_BUF		3
> +#define AD7949_CFG_VAL_REF_EXT_TEMP		2
> +#define AD7949_CFG_VAL_REF_INT_4096		1
> +#define AD7949_CFG_VAL_REF_INT_2500		0
> +#define AD7949_CFG_VAL_REF_EXTERNAL		BIT(1)
>  
>  /* SEQ: channel sequencer. Allows for scanning channels */
>  #define AD7949_CFG_BIT_SEQ		GENMASK(2, 1)
> @@ -60,6 +64,14 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
>  	[ID_AD7689] = { .num_channels = 8, .resolution = 16 },
>  };
>  
> +/**
> + * struct ad7949_channel - ADC Channel parameters
> + * @refsel: reference selection
> + */
> +struct ad7949_channel {
> +	u32 refsel;
> +};
> +
>  /**
>   * struct ad7949_adc_chip - AD ADC chip
>   * @lock: protects write sequences
> @@ -77,6 +89,7 @@ struct ad7949_adc_chip {
>  	struct regulator *vref;
>  	struct iio_dev *indio_dev;
>  	struct spi_device *spi;
> +	struct ad7949_channel *channels;
>  	u8 resolution;
>  	u8 bits_per_word;
>  	u16 cfg;
> @@ -133,6 +146,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>  	int ret;
>  	int i;
>  	struct spi_message msg;
> +	struct ad7949_channel *ad7949_chan = &ad7949_adc->channels[channel];
>  	struct spi_transfer tx[] = {
>  		{
>  			.rx_buf = &ad7949_adc->buffer,
> @@ -149,8 +163,9 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>  	 */
>  	for (i = 0; i < 2; i++) {
>  		ret = ad7949_spi_write_cfg(ad7949_adc,
> -					   FIELD_PREP(AD7949_CFG_BIT_INX, channel),
> -					   AD7949_CFG_BIT_INX);
> +					   FIELD_PREP(AD7949_CFG_BIT_INX, channel) |
> +					   FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_chan->refsel),
> +					   AD7949_CFG_BIT_INX | AD7949_CFG_BIT_REF);
>  		if (ret)
>  			return ret;
>  		if (channel == ad7949_adc->current_channel)
> @@ -219,6 +234,7 @@ static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
>  			   int *val, int *val2, long mask)
>  {
>  	struct ad7949_adc_chip *ad7949_adc = iio_priv(indio_dev);
> +	struct ad7949_channel *ad7949_chan = &ad7949_adc->channels[chan->channel];
>  	int ret;
>  
>  	if (!val)
> @@ -236,12 +252,26 @@ static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = regulator_get_voltage(ad7949_adc->vref);
> -		if (ret < 0)
> -			return ret;
> +		switch (ad7949_chan->refsel) {
> +		case AD7949_CFG_VAL_REF_INT_2500:
> +			*val = 2500;
> +			break;
> +		case AD7949_CFG_VAL_REF_INT_4096:
> +			*val = 4096;
> +			break;
> +		case AD7949_CFG_VAL_REF_EXT_TEMP:
> +		case AD7949_CFG_VAL_REF_EXT_TEMP_BUF:
> +			ret = regulator_get_voltage(ad7949_adc->vref);
> +			if (ret < 0)
> +				return ret;
> +
> +			/* convert value back to mV */
> +			*val = ret / 1000;
> +			break;
> +		}
>  
> -		*val = ret / 5000;
> -		return IIO_VAL_INT;
> +		*val2 = (1 << ad7949_adc->resolution) - 1;
> +		return IIO_VAL_FRACTIONAL;
>  	}
>  
>  	return -EINVAL;
> @@ -280,7 +310,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
>  		FIELD_PREP(AD7949_CFG_BIT_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
>  		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc->current_channel) |
>  		FIELD_PREP(AD7949_CFG_BIT_BW_FULL, 1) |
> -		FIELD_PREP(AD7949_CFG_BIT_REF, AD7949_CFG_VAL_REF_EXT_BUF) |
> +		FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_adc->channels[0].refsel) |
>  		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
>  		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
>  
> @@ -296,14 +326,24 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
>  	return ret;
>  }
>  
> +static void ad7949_disable_reg(void *reg)
> +{
> +	regulator_disable(reg);
> +}
> +
>  static int ad7949_spi_probe(struct spi_device *spi)
>  {
>  	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
>  	struct device *dev = &spi->dev;
>  	const struct ad7949_adc_spec *spec;
>  	struct ad7949_adc_chip *ad7949_adc;
> +	struct ad7949_channel *ad7949_chan;
> +	struct fwnode_handle *child;
>  	struct iio_dev *indio_dev;
> +	int mode;
> +	u32 tmp;
>  	int ret;
> +	int i;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*ad7949_adc));
>  	if (!indio_dev) {
> @@ -337,16 +377,74 @@ static int ad7949_spi_probe(struct spi_device *spi)
>  		return -EINVAL;
>  	}
>  
> -	ad7949_adc->vref = devm_regulator_get(dev, "vref");
> +	/* Setup external voltage ref, buffered? */
> +	ad7949_adc->vref = devm_regulator_get(dev, "vrefin");

Needs to be the optional form as otherwise we may get a stub regulator
and not fail here as we should.

>  	if (IS_ERR(ad7949_adc->vref)) {

Need to check the error code for -ENODEV (IIRC) which is the only error
to indicate it is not present.  If we get -EDEFER for example then we want
to fail the probe here as we know we should have the regulator later, once its
own driver has loaded.

> -		dev_err(dev, "fail to request regulator\n");
> -		return PTR_ERR(ad7949_adc->vref);
> +		/* unbuffered? */
> +		ad7949_adc->vref = devm_regulator_get(dev, "vref");

devm_regulator_get_optional() again to avoid stub regulators.

> +		if (IS_ERR(ad7949_adc->vref)) {

As above, need to check specifically for the code that reflects it not
being specified rather than any error.  Only if it is not specified
do we want to be ignore the error and use the internal regulator.

> +			/* Internal then */
> +			mode = AD7949_CFG_VAL_REF_INT_4096;
> +		}
> +		mode = AD7949_CFG_VAL_REF_EXT_TEMP;
>  	}
> +	mode = AD7949_CFG_VAL_REF_EXT_TEMP_BUF;
>  
> -	ret = regulator_enable(ad7949_adc->vref);
> -	if (ret < 0) {
> -		dev_err(dev, "fail to enable regulator\n");
> -		return ret;
> +	if (mode & AD7949_CFG_VAL_REF_EXTERNAL) {
> +		ret = regulator_enable(ad7949_adc->vref);
> +		if (ret < 0) {
> +			dev_err(dev, "fail to enable regulator\n");
> +			return ret;
> +		}
> +
> +		ret = devm_add_action_or_reset(dev, ad7949_disable_reg,
> +					       ad7949_adc->vref);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ad7949_adc->channels = devm_kcalloc(dev, spec->num_channels,
> +					    sizeof(*ad7949_adc->channels),
> +					    GFP_KERNEL);
> +	if (!ad7949_adc->channels) {
> +		dev_err(dev, "unable to allocate ADC channels\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Initialize all channel structures */
> +	for (i = 0; i < spec->num_channels; i++)
> +		ad7949_adc->channels[i].refsel = mode;
> +
> +	/* Read channel specific information form the devicetree */
> +	device_for_each_child_node(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &i);
> +		if (ret) {
> +			dev_err(dev, "missing reg property in %pfw\n", child);
> +			fwnode_handle_put(child);
> +			return ret;
> +		}
> +
> +		ad7949_chan = &ad7949_adc->channels[i];
> +
> +		ret = fwnode_property_read_u32(child, "adi,internal-ref-microvolt", &tmp);
> +		if (ret < 0 && ret != -EINVAL) {
> +			dev_err(dev, "invalid internal reference in %pfw\n", child);
> +			fwnode_handle_put(child);
> +			return ret;
> +		}
> +
> +		switch (tmp) {
> +		case 2500000:
> +			ad7949_chan->refsel = AD7949_CFG_VAL_REF_INT_2500;
> +			break;
> +		case 4096000:
> +			ad7949_chan->refsel = AD7949_CFG_VAL_REF_INT_4096;
> +			break;
> +		default:
> +			dev_err(dev, "unsupported internal voltage reference\n");
> +			fwnode_handle_put(child);
> +			return -EINVAL;
> +		}
>  	}
>  
>  	mutex_init(&ad7949_adc->lock);
> @@ -367,7 +465,6 @@ static int ad7949_spi_probe(struct spi_device *spi)
>  
>  err:
>  	mutex_destroy(&ad7949_adc->lock);
> -	regulator_disable(ad7949_adc->vref);
>  
>  	return ret;
>  }
> @@ -379,7 +476,6 @@ static int ad7949_spi_remove(struct spi_device *spi)
>  
>  	iio_device_unregister(indio_dev);
>  	mutex_destroy(&ad7949_adc->lock);
> -	regulator_disable(ad7949_adc->vref);
>  
>  	return 0;
>  }

