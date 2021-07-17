Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7213CC4D9
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 19:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhGQRfO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 13:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233128AbhGQRfN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 13:35:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15DF860FE9;
        Sat, 17 Jul 2021 17:32:13 +0000 (UTC)
Date:   Sat, 17 Jul 2021 18:34:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v3 3/4] iio: adc: ad7949: add support for internal vref
Message-ID: <20210717183437.4d183037@jic23-huawei>
In-Reply-To: <20210713043425.3321230-4-liambeguin@gmail.com>
References: <20210713043425.3321230-1-liambeguin@gmail.com>
        <20210713043425.3321230-4-liambeguin@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 13 Jul 2021 00:34:24 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> Add support for selecting a custom reference voltage from the
> devicetree. If an external source is used, a vref regulator should be
> defined in the devicetree.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>

Hi Liam,

A few minor things inline.

Jonathan

> ---
>  drivers/iio/adc/ad7949.c | 133 +++++++++++++++++++++++++++++++++------
>  1 file changed, 115 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index 65f78751225b..8b78da7ead36 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -36,7 +36,11 @@
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
> @@ -61,6 +65,14 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
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
> @@ -78,6 +90,7 @@ struct ad7949_adc_chip {
>  	struct regulator *vref;
>  	struct iio_dev *indio_dev;
>  	struct spi_device *spi;
> +	struct ad7949_channel *channels;
>  	u8 resolution;
>  	u8 bits_per_word;
>  	u16 cfg;
> @@ -138,6 +151,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>  	int i;
>  	u8 buf8[2];
>  	struct spi_message msg;
> +	struct ad7949_channel ad7949_chan = ad7949_adc->channels[channel];

Better to use a pointer rather than copying the data.

>  	struct spi_transfer tx[] = {
>  		{
>  			.rx_buf = &ad7949_adc->buffer,
> @@ -154,8 +168,9 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>  	 */
>  	for (i = 0; i < 2; i++) {
>  		ret = ad7949_spi_write_cfg(ad7949_adc,
> -					   FIELD_PREP(AD7949_CFG_BIT_INX, channel),
> -					   AD7949_CFG_BIT_INX);
> +					   FIELD_PREP(AD7949_CFG_BIT_INX, channel) |
> +					   FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_chan.refsel),
> +					   AD7949_CFG_BIT_INX | AD7949_CFG_BIT_REF);
>  		if (ret)
>  			return ret;
>  		if (channel == ad7949_adc->current_channel)
> @@ -225,6 +240,7 @@ static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
>  			   int *val, int *val2, long mask)
>  {
>  	struct ad7949_adc_chip *ad7949_adc = iio_priv(indio_dev);
> +	struct ad7949_channel ad7949_chan = ad7949_adc->channels[chan->channel];
>  	int ret;
>  
>  	if (!val)
> @@ -242,12 +258,26 @@ static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = regulator_get_voltage(ad7949_adc->vref);
> -		if (ret < 0)
> -			return ret;
> +		switch (ad7949_chan.refsel) {
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
> @@ -286,7 +316,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
>  		FIELD_PREP(AD7949_CFG_BIT_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
>  		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc->current_channel) |
>  		FIELD_PREP(AD7949_CFG_BIT_BW_FULL, 1) |
> -		FIELD_PREP(AD7949_CFG_BIT_REF, AD7949_CFG_VAL_REF_EXT_BUF) |
> +		FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_adc->channels[0].refsel) |
>  		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
>  		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
>  
> @@ -302,14 +332,24 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
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
> +	struct device_node *child;
>  	struct iio_dev *indio_dev;
> +	int mode;
> +	u32 tmp;
>  	int ret;
> +	int i;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*ad7949_adc));
>  	if (!indio_dev) {
> @@ -343,16 +383,75 @@ static int ad7949_spi_probe(struct spi_device *spi)
>  		return -EINVAL;
>  	}
>  
> -	ad7949_adc->vref = devm_regulator_get(dev, "vref");
> +	/* Setup external voltage ref, buffered? */
> +	ad7949_adc->vref = devm_regulator_get(dev, "vrefin");
>  	if (IS_ERR(ad7949_adc->vref)) {
> -		dev_err(dev, "fail to request regulator\n");
> -		return PTR_ERR(ad7949_adc->vref);
> +		/* unbuffered? */
> +		ad7949_adc->vref = devm_regulator_get(dev, "vref");
> +		if (IS_ERR(ad7949_adc->vref)) {
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
> +	if (mode > AD7949_CFG_VAL_REF_INT_4096) {

Range checks on enum values are always rather messy.  So
better to explicitly match the cases that matter.

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
> +	for (i = 0; i < spec->num_channels; i++) {
> +		ad7949_adc->channels[i].refsel = mode;

Kernel style is no brackets when only one item in a block.

> +	}
> +
> +	/* Read channel specific information form the devicetree */
> +	for_each_child_of_node(dev->of_node, child) {
> +		ret = of_property_read_u32(child, "reg", &i);
> +		if (ret) {
> +			dev_err(dev, "missing reg property in child: %s\n",
> +				child->full_name);
> +			of_node_put(child);
> +			return ret;
> +		}
> +
> +		ad7949_chan = &ad7949_adc->channels[i];
> +
> +		ret = of_property_read_u32(child, "adi,internal-ref-mv", &tmp);

Preference for generic device firmware properties not of_* specific ones.

I think there is nothing stopping this driver being probed from ACPI via PRP0001
before this change.  Note you'll also need fwnode_for_each_child_node() above.

> +		if (ret < 0 && ret != -EINVAL) {
> +			of_node_put(child);
> +			return ret;
> +		}
> +
> +		switch (tmp) {
> +		case 2500:
> +			ad7949_chan->refsel = AD7949_CFG_VAL_REF_INT_2500;
> +			break;
> +		case 4096:
> +			ad7949_chan->refsel = AD7949_CFG_VAL_REF_INT_4096;
> +			break;
> +		default:
> +			dev_err(dev, "unsupported internal voltage reference\n");
> +			of_node_put(child);
> +			return -EINVAL;
> +		}
>  	}
>  
>  	mutex_init(&ad7949_adc->lock);
> @@ -373,7 +472,6 @@ static int ad7949_spi_probe(struct spi_device *spi)
>  
>  err:
>  	mutex_destroy(&ad7949_adc->lock);
> -	regulator_disable(ad7949_adc->vref);
>  
>  	return ret;
>  }
> @@ -385,7 +483,6 @@ static int ad7949_spi_remove(struct spi_device *spi)
>  
>  	iio_device_unregister(indio_dev);
>  	mutex_destroy(&ad7949_adc->lock);
> -	regulator_disable(ad7949_adc->vref);

Given mutex_destroy is mostly pointless (and definitely is here) that
leaves us with just iio_device_register().   Hence if you could do
a follow up patch finishing conversion of this to entirely devm managed
that would be a nice addition to this series (or separate patch is fine as well).

>  
>  	return 0;
>  }

