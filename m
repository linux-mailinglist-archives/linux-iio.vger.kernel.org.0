Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB1A14049
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2019 16:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfEEOjs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 May 2019 10:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbfEEOjs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 May 2019 10:39:48 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EAF0208C0;
        Sun,  5 May 2019 14:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557067186;
        bh=hnnvMQwDDKOtZmZp6Tp1ClrJzK135DFiTn0Rt6cx8mM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G046fBE7YdZ9hyP/GO1J4yKP2rGT8E7kWNAJwrAdL3SSoXXho4rTp9n+Q8uxYnLg1
         KscIpns1X4xCiHNaK3IXp3I63sbVE0E7i2osbpSlQX9PQknaXUFzXZgeS6yeqZxPvA
         mvIxcqwYb2C8QBmHTGIIUf8Z6AqusCk2rkiSQ02g=
Date:   Sun, 5 May 2019 15:39:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Adam Michaelis <adam.michaelis@rockwellcollins.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        michael.hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        charles-antoine.couret@essensium.com, devicetree@vger.kernel.org,
        brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com
Subject: Re: [PATCH v2 1/6] iio: ad7949: Support internal Vref
Message-ID: <20190505153940.2699d07f@archlinux>
In-Reply-To: <1556813672-49861-1-git-send-email-adam.michaelis@rockwellcollins.com>
References: <1556813672-49861-1-git-send-email-adam.michaelis@rockwellcollins.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 May 2019 11:14:27 -0500
Adam Michaelis <adam.michaelis@rockwellcollins.com> wrote:

> Adding configurable (via device tree) options to select either an external
> reference voltage (default, original implementation) or one of the two
> internal reference voltages provided by the AD7949 part family.
> 
> Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
Hi Adam,

Clearly the comments I made on the DT patch will follow through to changes
in here.

A few minor comments below.

Jonathan
> ---
> 	V2: Add some defines to reduce use of magic numbers.
> ---
>  drivers/iio/adc/ad7949.c | 135 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 108 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index ac0ffff6c5ae..afc1361af5fb 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -11,12 +11,27 @@
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
> -
> -#define AD7949_MASK_CHANNEL_SEL		GENMASK(9, 7)
> -#define AD7949_MASK_TOTAL		GENMASK(13, 0)
> -#define AD7949_OFFSET_CHANNEL_SEL	7
> -#define AD7949_CFG_READ_BACK		0x1
> -#define AD7949_CFG_REG_SIZE_BITS	14
> +#include <linux/of.h>
> +
> +#define AD7949_CFG_REG_SIZE_BITS           14
> +#define AD7949_CFG_MASK_TOTAL              GENMASK(13, 0)
> +#define AD7949_CFG_OVERWRITE_SHIFT         13
> +#define AD7949_CFG_CHAN_CFG_UNIPOLAR_GND   0x7
> +#define AD7949_CFG_CHAN_CFG_MASK           GENMASK(12, 10)
> +#define AD7949_CFG_CHAN_CFG_SHIFT          10
> +#define AD7949_CFG_CHAN_SEL_MASK           GENMASK(9, 7)
> +#define AD7949_CFG_CHAN_SEL_SHIFT          7
> +#define AD7949_CFG_BW_FULL                 1
> +#define AD7949_CFG_BW_SHIFT                6
> +#define AD7949_CFG_BW_MASK                 GENMASK(6, 6)
> +#define AD7949_CFG_REF_SEL_MASK            GENMASK(5, 3)
> +#define AD7949_CFG_REF_SEL_SHIFT           3
> +#define AD7949_CFG_SEQ_DISABLED            0x0
> +#define AD7949_CFG_SEQ_SHIFT               1
> +#define AD7949_CFG_SEQ_MASK                GENMASK(2, 1)
Where possible use the FIELD_PREP and FIELD_GET macros
to avoid needing to define both a _SHIFT and a _MASK.

IIRC the mask needs to be a compile time constant, but I think that
is always true with these.

> +#define AD7949_CFG_READBACK_EN             0
> +#define AD7949_CFG_READBACK_DIS            1
> +#define AD7949_CFG_READBACK_MASK           GENMASK(0, 0)
>  
>  enum {
>  	ID_AD7949 = 0,
> @@ -24,6 +39,18 @@ enum {
>  	ID_AD7689,
>  };
>  
> +enum ad7949_ref_sel {
> +	AD7949_REF_2V5 = 0, /* 2.5V internal ref + temp sensor */
> +	AD7949_REF_4V0, /* 4.096V internal ref + temp sensor */
> +	AD7949_REF_EXT_TEMP, /* External ref + temp sensor, no buffer */
> +	AD7949_REF_EXT_TEMP_BUF, /* External ref + temp sensor + buffer */
> +	AD7949_REF_RSRV_4,
> +	AD7949_REF_RSRV_5,
> +	AD7949_REF_EXT, /* External ref, no temp, no buffer */
> +	AD7949_REF_EXT_BUF, /* External ref + buffer, no temp */
> +	AD7949_REF_MAX,
> +};
> +
>  struct ad7949_adc_spec {
>  	u8 num_channels;
>  	u8 resolution;
> @@ -41,6 +68,7 @@ struct ad7949_adc_spec {
>   * @vref: regulator generating Vref
>   * @iio_dev: reference to iio structure
>   * @spi: reference to spi structure
> + * @ref_sel: selected reference voltage source
>   * @resolution: resolution of the chip
>   * @cfg: copy of the configuration register
>   * @current_channel: current channel in use
> @@ -51,6 +79,7 @@ struct ad7949_adc_chip {
>  	struct regulator *vref;
>  	struct iio_dev *indio_dev;
>  	struct spi_device *spi;
> +	enum ad7949_ref_sel ref_sel;
>  	u8 resolution;
>  	u16 cfg;
>  	unsigned int current_channel;
> @@ -59,7 +88,7 @@ struct ad7949_adc_chip {
>  
>  static bool ad7949_spi_cfg_is_read_back(struct ad7949_adc_chip *ad7949_adc)
>  {
> -	if (!(ad7949_adc->cfg & AD7949_CFG_READ_BACK))
> +	if (!(ad7949_adc->cfg & AD7949_CFG_READBACK_MASK))
>  		return true;
>  
>  	return false;
> @@ -91,7 +120,7 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
>  	};
>  
>  	ad7949_adc->cfg = (val & mask) | (ad7949_adc->cfg & ~mask);
> -	ad7949_adc->buffer = ad7949_adc->cfg << shift;
> +	ad7949_adc->buffer = (ad7949_adc->cfg & AD7949_CFG_MASK_TOTAL) << shift;
>  	spi_message_init_with_transfers(&msg, tx, 1);
>  	ret = spi_sync(ad7949_adc->spi, &msg);
>  
> @@ -119,8 +148,8 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>  	};
>  
>  	ret = ad7949_spi_write_cfg(ad7949_adc,
> -				   channel << AD7949_OFFSET_CHANNEL_SEL,
> -				   AD7949_MASK_CHANNEL_SEL);
> +				   channel << AD7949_CFG_CHAN_SEL_SHIFT,
> +				   AD7949_CFG_CHAN_SEL_MASK);
>  	if (ret)
>  		return ret;
>  
> @@ -187,11 +216,20 @@ static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = regulator_get_voltage(ad7949_adc->vref);
> -		if (ret < 0)
> -			return ret;
> +		if (ad7949_adc->vref) {
> +			ret = regulator_get_voltage(ad7949_adc->vref);
> +			if (ret < 0)
> +				return ret;
> +
> +			*val = ret / 5000;
> +		} else if (ad7949_adc->ref_sel == AD7949_REF_2V5) {
> +			*val = 2500;
> +		} else if (ad7949_adc->ref_sel == AD7949_REF_4V0) {
> +			*val = 4096;
> +		} else {
> +			return -EINVAL;
> +		}
>  
> -		*val = ret / 5000;
>  		return IIO_VAL_INT;
>  	}
>  
> @@ -209,7 +247,7 @@ static int ad7949_spi_reg_access(struct iio_dev *indio_dev,
>  		*readval = ad7949_adc->cfg;
>  	else
>  		ret = ad7949_spi_write_cfg(ad7949_adc,
> -			writeval & AD7949_MASK_TOTAL, AD7949_MASK_TOTAL);
> +			writeval & AD7949_CFG_MASK_TOTAL, AD7949_CFG_MASK_TOTAL);
>  
>  	return ret;
>  }
> @@ -223,10 +261,33 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
>  {
>  	int ret;
>  	int val;
> +	u16 adc_config = 0;
>  
> -	/* Sequencer disabled, CFG readback disabled, IN0 as default channel */
>  	ad7949_adc->current_channel = 0;
> -	ret = ad7949_spi_write_cfg(ad7949_adc, 0x3C79, AD7949_MASK_TOTAL);
> +	ad7949_adc->cfg = 0;
> +
> +	/*
> +	 * 14-bit configuration register (pg 12 of AD7949 Datasheet):
> +	 * | 13  | 12 - 10 | 9 - 7 | 6  | 5 -3 | 2 - 1 | 0  |
> +	 * | CFG | INCC    | INx   | BW | REF  | SEQ   | RB |
> +	 */
Given this is now all opaque (as it should be) the comment isn't really
very useful any more so I'd drop it.

> +	adc_config = 1 << AD7949_CFG_OVERWRITE_SHIFT;
> +	adc_config |=
> +		(AD7949_CFG_CHAN_CFG_UNIPOLAR_GND << AD7949_CFG_CHAN_CFG_SHIFT)
> +			& AD7949_CFG_CHAN_CFG_MASK;
> +	adc_config |= (ad7949_adc->current_channel << AD7949_CFG_CHAN_SEL_SHIFT)
> +			& AD7949_CFG_CHAN_SEL_MASK;
> +	adc_config |= (AD7949_CFG_BW_FULL << AD7949_CFG_BW_SHIFT) &
> +			AD7949_CFG_BW_MASK;
> +	adc_config |= (ad7949_adc->ref_sel << AD7949_CFG_REF_SEL_SHIFT) &
> +			AD7949_CFG_REF_SEL_MASK;
> +	adc_config |= (AD7949_CFG_SEQ_DISABLED << AD7949_CFG_SEQ_SHIFT) &
> +			AD7949_CFG_SEQ_MASK;

Perhaps could used FIELD_PREP to do this in a cleaner fashion.

> +	adc_config |= AD7949_CFG_READBACK_DIS;
> +
> +	ret = ad7949_spi_write_cfg(ad7949_adc,
> +			adc_config,
> +			AD7949_CFG_MASK_TOTAL);
>  
>  	/*
>  	 * Do two dummy conversions to apply the first configuration setting.
> @@ -245,6 +306,7 @@ static int ad7949_spi_probe(struct spi_device *spi)
>  	struct ad7949_adc_chip *ad7949_adc;
>  	struct iio_dev *indio_dev;
>  	int ret;
> +	u32 temp;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*ad7949_adc));
>  	if (!indio_dev) {
> @@ -263,21 +325,38 @@ static int ad7949_spi_probe(struct spi_device *spi)
>  	ad7949_adc = iio_priv(indio_dev);
>  	ad7949_adc->indio_dev = indio_dev;
>  	ad7949_adc->spi = spi;
> +	ad7949_adc->vref = NULL;
>  
>  	spec = &ad7949_adc_spec[spi_get_device_id(spi)->driver_data];
>  	indio_dev->num_channels = spec->num_channels;
>  	ad7949_adc->resolution = spec->resolution;
>  
> -	ad7949_adc->vref = devm_regulator_get(dev, "vref");
> -	if (IS_ERR(ad7949_adc->vref)) {
> -		dev_err(dev, "fail to request regulator\n");
> -		return PTR_ERR(ad7949_adc->vref);
> +	ret = of_property_read_u32(ad7949_adc->indio_dev->dev.of_node,
> +			"adi,reference-select",
> +			&temp);
> +	if ((ret == 0) && (temp < AD7949_REF_MAX) &&
> +			(temp != AD7949_REF_RSRV_4) &&
> +			(temp != AD7949_REF_RSRV_5)) {
> +		ad7949_adc->ref_sel = (enum ad7949_ref_sel)temp;
> +	} else {
> +		ad7949_adc->ref_sel = AD7949_REF_EXT_BUF;
> +		dev_warn(dev, "using external Vref by default\n");
>  	}
>  
> -	ret = regulator_enable(ad7949_adc->vref);
> -	if (ret < 0) {
> -		dev_err(dev, "fail to enable regulator\n");
> -		return ret;
> +	/* Check whether using external Vref */
> +	if ((ad7949_adc->ref_sel != AD7949_REF_2V5) &&
> +			(ad7949_adc->ref_sel != AD7949_REF_4V0)) {
> +		ad7949_adc->vref = devm_regulator_get(dev, "vref");
> +		if (IS_ERR(ad7949_adc->vref)) {
> +			dev_err(dev, "fail to request regulator\n");
> +			return PTR_ERR(ad7949_adc->vref);
> +		}
> +
> +		ret = regulator_enable(ad7949_adc->vref);
> +		if (ret < 0) {
> +			dev_err(dev, "fail to enable regulator\n");
> +			return ret;
> +		}
>  	}
>  
>  	mutex_init(&ad7949_adc->lock);
> @@ -298,7 +377,8 @@ static int ad7949_spi_probe(struct spi_device *spi)
>  
>  err:
>  	mutex_destroy(&ad7949_adc->lock);
> -	regulator_disable(ad7949_adc->vref);
> +	if (ad7949_adc->vref)
> +		regulator_disable(ad7949_adc->vref);
>  
>  	return ret;
>  }
> @@ -310,7 +390,8 @@ static int ad7949_spi_remove(struct spi_device *spi)
>  
>  	iio_device_unregister(indio_dev);
>  	mutex_destroy(&ad7949_adc->lock);
> -	regulator_disable(ad7949_adc->vref);
> +	if (ad7949_adc->vref)
> +		regulator_disable(ad7949_adc->vref);
>  
>  	return 0;
>  }

