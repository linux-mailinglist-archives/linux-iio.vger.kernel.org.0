Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B773C35B0
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 19:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhGJRDe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jul 2021 13:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhGJRDe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Jul 2021 13:03:34 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C01476135B;
        Sat, 10 Jul 2021 17:00:45 +0000 (UTC)
Date:   Sat, 10 Jul 2021 18:03:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 3/4] iio: adc: ad7949: add support for internal vref
Message-ID: <20210710180317.79889b53@jic23-huawei>
In-Reply-To: <20210709155856.1732245-4-liambeguin@gmail.com>
References: <20210709155856.1732245-1-liambeguin@gmail.com>
        <20210709155856.1732245-4-liambeguin@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  9 Jul 2021 11:58:55 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> Add support for selecting a custom reference voltage from the
> devicetree. If an external source is used, a vref regulator should be
> defined in the devicetree.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/adc/ad7949.c | 94 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 80 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index 770112ac820f..a20fd81a0830 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -31,6 +31,7 @@
>  #define AD7949_CFG_VAL_BW_FULL			1
>  #define AD7949_CFG_VAL_BW_QUARTER		0
>  #define AD7949_CFG_BIT_REF		GENMASK(5, 3)
> +#define AD7949_CFG_VAL_REF_EXTERNAL		BIT(1)
>  #define AD7949_CFG_BIT_SEQ		GENMASK(2, 1)
>  #define AD7949_CFG_BIT_RBN		BIT(0)
>  
> @@ -40,6 +41,33 @@ enum {
>  	ID_AD7689,
>  };
>  
> +/**
> + * enum ad7949_ref - Reference selection
> + *
> + * AD7949_REF_INT_2500:     Internal reference and temperature sensor enabled.
> + *                          Vref=2.5V, buffered output
> + * AD7949_REF_INT_4096:     Internal reference and temperature sensor enabled.
> + *                          Vref=4.096V, buffered output
> + * AD7949_REF_EXT_TEMP:     Use external reference, temperature sensor enabled.
> + *                          Internal buffer disabled
> + * AD7949_REF_EXT_TEMP_BUF: Use external reference, internal buffer and
> + *                          temperature sensor enabled.
> + * AD7949_REF_RSRV_4:       Do not use
> + * AD7949_REF_RSRV_5:       Do not use
> + * AD7949_REF_EXT:          Use external reference, internal buffer and
> + *                          temperature sensor disabled.
> + * AD7949_REF_EXT_BUF:      Use external reference, internal buffer enabled.
> + *                          Internal reference and temperature sensor disabled.
> + */
> +enum ad7949_ref {
> +	AD7949_REF_INT_2500 = 0,

For case where you have gaps like this, an ENUM is probably not appropriate.
I'd just used defines.

> +	AD7949_REF_INT_4096,
> +	AD7949_REF_EXT_TEMP,
> +	AD7949_REF_EXT_TEMP_BUF,
> +	AD7949_REF_EXT = 6,
> +	AD7949_REF_EXT_BUF,
> +};
> +
>  struct ad7949_adc_spec {
>  	u8 num_channels;
>  	u8 resolution;
> @@ -55,6 +83,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
>   * struct ad7949_adc_chip - AD ADC chip
>   * @lock: protects write sequences
>   * @vref: regulator generating Vref
> + * @refsel: reference selection
>   * @indio_dev: reference to iio structure
>   * @spi: reference to spi structure
>   * @resolution: resolution of the chip
> @@ -66,6 +95,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
>  struct ad7949_adc_chip {
>  	struct mutex lock;
>  	struct regulator *vref;
> +	enum ad7949_ref refsel;
>  	struct iio_dev *indio_dev;
>  	struct spi_device *spi;
>  	u8 resolution;
> @@ -243,12 +273,28 @@ static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = regulator_get_voltage(ad7949_adc->vref);
> -		if (ret < 0)
> -			return ret;
> +		switch (ad7949_adc->refsel) {
> +		case AD7949_REF_INT_2500:
> +			*val = 2500;
> +			break;
> +		case AD7949_REF_INT_4096:
> +			*val = 4096;
> +			break;
> +		case AD7949_REF_EXT_TEMP:
> +		case AD7949_REF_EXT_TEMP_BUF:
> +		case AD7949_REF_EXT:
> +		case AD7949_REF_EXT_BUF:
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
> @@ -287,7 +333,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
>  		FIELD_PREP(AD7949_CFG_BIT_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
>  		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc->current_channel) |
>  		FIELD_PREP(AD7949_CFG_BIT_BW, AD7949_CFG_VAL_BW_FULL) |
> -		FIELD_PREP(AD7949_CFG_BIT_REF, AD7949_REF_EXT_BUF) |
> +		FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_adc->refsel) |
>  		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
>  		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
>  
> @@ -306,6 +352,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
>  static int ad7949_spi_probe(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
> +	struct device_node *np = dev->of_node;
>  	const struct ad7949_adc_spec *spec;
>  	struct ad7949_adc_chip *ad7949_adc;
>  	struct iio_dev *indio_dev;
> @@ -332,16 +379,35 @@ static int ad7949_spi_probe(struct spi_device *spi)
>  	ad7949_adc->resolution = spec->resolution;
>  	ad7949_set_bits_per_word(ad7949_adc);
>  
> -	ad7949_adc->vref = devm_regulator_get(dev, "vref");
> -	if (IS_ERR(ad7949_adc->vref)) {
> -		dev_err(dev, "fail to request regulator\n");
> -		return PTR_ERR(ad7949_adc->vref);
> +	/* Set default devicetree parameters */
> +	ad7949_adc->refsel = AD7949_REF_EXT_BUF;
> +	of_property_read_u32(np, "adi,reference-select", &ad7949_adc->refsel);

Check for errors.  Not being present is fine, but other errors may not be.


> +	switch (ad7949_adc->refsel) {
> +	case AD7949_REF_INT_2500:
> +	case AD7949_REF_INT_4096:
> +	case AD7949_REF_EXT_TEMP:
> +	case AD7949_REF_EXT_TEMP_BUF:
> +	case AD7949_REF_EXT:
> +	case AD7949_REF_EXT_BUF:
> +		break;
> +	default:
> +		dev_err(dev, "invalid adi,reference-select value (%d)\n",
> +			ad7949_adc->refsel);
> +		return -EINVAL;
>  	}
>  
> -	ret = regulator_enable(ad7949_adc->vref);
> -	if (ret < 0) {
> -		dev_err(dev, "fail to enable regulator\n");
> -		return ret;
> +	if (ad7949_adc->refsel & AD7949_CFG_VAL_REF_EXTERNAL) {
> +		ad7949_adc->vref = devm_regulator_get(dev, "vref");
> +		if (IS_ERR(ad7949_adc->vref)) {
> +			dev_err(dev, "fail to request regulator\n");
> +			return PTR_ERR(ad7949_adc->vref);
> +		}
> +
> +		ret = regulator_enable(ad7949_adc->vref);

Shouldn't be calling regulator_disable unless you enabled it...

> +		if (ret < 0) {
> +			dev_err(dev, "fail to enable regulator\n");
> +			return ret;
> +		}
>  	}
>  
>  	mutex_init(&ad7949_adc->lock);

