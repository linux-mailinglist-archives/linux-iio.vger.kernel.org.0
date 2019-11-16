Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B90BFF43E
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 18:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfKPRME (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 12:12:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727568AbfKPRME (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 12:12:04 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9D2D21844;
        Sat, 16 Nov 2019 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573924323;
        bh=5b8Ufx8oh2X8ebi2bINVkqFdvDAre3XapyO1yYnh2U8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uMv8ocVa6IgjukUFeuqTxhGF9Ccgo/LBglKZ7E/vgc6OCIkMde0FvTd3rbOig+ZIF
         2qQFMheldVNhbswTwOiJ4WOHgsGr+8rDUzsmdL87owaQu712IotaB8KajK+959YcVF
         haIyfaahHy9zuutFDkWfQ6+WLkmhd8O9lo3zJpR0=
Date:   Sat, 16 Nov 2019 17:06:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>,
        Paul Cercueil <paul.cercueil@analog.com>
Subject: Re: [PATCH v5 2/4] iio: adc: ad7091r5: Add scale and external VREF
 support
Message-ID: <20191116170619.72710b94@archlinux>
In-Reply-To: <20191115135723.12219-2-beniamin.bia@analog.com>
References: <20191115135723.12219-1-beniamin.bia@analog.com>
        <20191115135723.12219-2-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Nov 2019 15:57:21 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> From: Paul Cercueil <paul.cercueil@analog.com>
> 
> The scale can now be obtained with the "in_voltage_scale" file.
> By default, the scale returned corresponds to the internal VREF of 2.5V.
> 
> It is possible to use an external VREF (through the REFIN/REFOUT pin of
> the chip), by passing a regulator to the driver. The scale will then be
> calculated according to the voltage reported by the regulator.
> 
> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
> Co-developed-by: Beniamin Bia <beniamin.bia@analog.com>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>

Doesn't build.  However I've fixed it up and applied
to the togreg branch of iio.git pushed out as testing so the
build bots can run more tests.

Please check the result.

Jonathan

> ---
> Changes in v5:
> -check if error is -eprobe instead of eprobe
> -one bracket aligned
> 
>  drivers/iio/adc/ad7091r-base.c | 38 ++++++++++++++++++++++++++++++++++
>  drivers/iio/adc/ad7091r-base.h |  1 +
>  drivers/iio/adc/ad7091r5.c     |  5 +++++
>  3 files changed, 44 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index 854de7c654c2..58fcf1ff8c76 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -11,6 +11,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include "ad7091r-base.h"
>  
> @@ -42,6 +43,7 @@ enum ad7091r_mode {
>  struct ad7091r_state {
>  	struct device *dev;
>  	struct regmap *map;
> +	struct regulator *vref;
>  	const struct ad7091r_chip_info *chip_info;
>  	enum ad7091r_mode mode;
>  	struct mutex lock; /*lock to prevent concurent reads */
> @@ -141,6 +143,21 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
>  		ret = IIO_VAL_INT;
>  		break;
>  
> +	case IIO_CHAN_INFO_SCALE:
> +		if (st->vref) {
> +			ret = regulator_get_voltage(st->vref);
> +			if (ret < 0)
> +				goto unlock;
> +
> +			*val = ret / 1000;
> +		} else {
> +			*val = st->chip_info->vref_mV;
> +		}
> +
> +		*val2 = chan->scan_type.realbits;
> +		ret = IIO_VAL_FRACTIONAL_LOG2;
> +		break;
> +
>  	default:
>  		ret = -EINVAL;
>  		break;
> @@ -183,6 +200,13 @@ static irqreturn_t ad7091r_event_handler(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> +static void ad7091r_remove(void *data)
> +{
> +	struct ad7091r_state *st = data;
> +
> +	regulator_disable(st->vref);
> +}
> +
>  int ad7091r_probe(struct device *dev, const char *name,
>  		const struct ad7091r_chip_info *chip_info,
>  		struct regmap *map, int irq)
> @@ -216,6 +240,20 @@ int ad7091r_probe(struct device *dev, const char *name,
>  			return ret;
>  	}
>  
> +	st->vref = devm_regulator_get_optional(dev, "vref");
> +	if (IS_ERR(st->vref)) {
> +		if (PTR_ERR(st->reg) == -EPROBE_DEFER)

I'm going to optimistically hope this was a last minute edit and
you have tested this driver thoroughly.

st->vref?

> +			return -EPROBE_DEFER;
> +		st->vref = NULL;
> +	} else {
> +		ret = regulator_enable(st->vref);
> +		if (ret)
> +			return ret;
> +		ret = devm_add_action_or_reset(dev, ad7091r_remove, st);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/* Use command mode by default to convert only desired channels*/
>  	ret = ad7091r_set_mode(st, AD7091R_MODE_COMMAND);
>  	if (ret)
> diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> index b0b4fe01a681..509748aef9b1 100644
> --- a/drivers/iio/adc/ad7091r-base.h
> +++ b/drivers/iio/adc/ad7091r-base.h
> @@ -14,6 +14,7 @@ struct ad7091r_state;
>  struct ad7091r_chip_info {
>  	unsigned int num_channels;
>  	const struct iio_chan_spec *channels;
> +	unsigned int vref_mV;
>  };
>  
>  extern const struct regmap_config ad7091r_regmap_config;
> diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
> index 30ff0108a6ed..9665679c3ea6 100644
> --- a/drivers/iio/adc/ad7091r5.c
> +++ b/drivers/iio/adc/ad7091r5.c
> @@ -35,10 +35,13 @@ static const struct iio_event_spec ad7091r5_events[] = {
>  #define AD7091R_CHANNEL(idx, bits, ev, num_ev) { \
>  	.type = IIO_VOLTAGE, \
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
>  	.indexed = 1, \
>  	.channel = idx, \
>  	.event_spec = ev, \
>  	.num_event_specs = num_ev, \
> +	.scan_type.storagebits = 16, \
> +	.scan_type.realbits = bits, \
>  }
>  static const struct iio_chan_spec ad7091r5_channels_irq[] = {
>  	AD7091R_CHANNEL(0, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
> @@ -57,11 +60,13 @@ static const struct iio_chan_spec ad7091r5_channels_noirq[] = {
>  static const struct ad7091r_chip_info ad7091r5_chip_info_irq = {
>  	.channels = ad7091r5_channels_irq,
>  	.num_channels = ARRAY_SIZE(ad7091r5_channels_irq),
> +	.vref_mV = 2500,
>  };
>  
>  static const struct ad7091r_chip_info ad7091r5_chip_info_noirq = {
>  	.channels = ad7091r5_channels_noirq,
>  	.num_channels = ARRAY_SIZE(ad7091r5_channels_noirq),
> +	.vref_mV = 2500,
>  };
>  
>  static int ad7091r5_i2c_probe(struct i2c_client *i2c,

