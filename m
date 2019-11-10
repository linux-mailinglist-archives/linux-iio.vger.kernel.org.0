Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94161F69EB
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 16:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfKJPya (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 10:54:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfKJPy3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 10:54:29 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F96C2077C;
        Sun, 10 Nov 2019 15:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573401268;
        bh=9f+F2pDHhZuvV3Ptr3aVhnnxpBR09tVWNZZnfBV8oR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rpM6KPFBbSFEwlmP7PyDbYWIkY/o0J8QlxMy2O8hGL0Tu+2CvalYP+LNAY6yOzb4F
         +Cnxj2FAucokbL5ljrwWdeG/PygttDJ85mCvbdPvbRdBviCYFw2ESdFd/Db9/J2qC2
         8BEpGNr7OjZlUteMBhBd4AXeAWIwvCjEeZ95PFrk=
Date:   Sun, 10 Nov 2019 15:54:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <paulmck@linux.ibm.com>, <mchehab+samsung@kernel.org>,
        <linus.walleij@linaro.org>, <nicolas.ferre@microchip.com>,
        <biabeniamin@outlook.com>, Paul Cercueil <paul.cercueil@analog.com>
Subject: Re: [PATCH v3 2/4] iio: adc: ad7091r5: Add scale and external VREF
 support
Message-ID: <20191110155422.7d8306e9@archlinux>
In-Reply-To: <20191107150759.5937-2-beniamin.bia@analog.com>
References: <20191107150759.5937-1-beniamin.bia@analog.com>
        <20191107150759.5937-2-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 Nov 2019 17:07:57 +0200
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

A suggestion inline for how to simplify the code a little by only
registering the regulator disable if we actually have a regulator.

Thanks,

Jonathan

> ---
> Changes in v3:
> -type cast from void* in remove function removed
> -error checking for devm_add_action_or_reset
> 
>  drivers/iio/adc/ad7091r-base.c | 41 ++++++++++++++++++++++++++++++++++
>  drivers/iio/adc/ad7091r-base.h |  1 +
>  drivers/iio/adc/ad7091r5.c     |  5 +++++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index 2ebc40dfd927..abb0d9c2ea9c 100644
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
> +	struct regulator *reg;
>  	const struct ad7091r_chip_info *chip_info;
>  	enum ad7091r_mode mode;
>  	struct mutex lock;
> @@ -142,6 +144,21 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
>  		ret = IIO_VAL_INT;
>  		break;
>  
> +	case IIO_CHAN_INFO_SCALE:
> +		if (st->reg) {
> +			ret = regulator_get_voltage(st->reg);
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
> @@ -184,6 +201,14 @@ static irqreturn_t ad7091r_event_handler(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> +static void ad7091r_remove(void *data)
> +{
> +	struct ad7091r_state *st = data;
> +
> +	if (st->reg)
> +		regulator_disable(st->reg);
> +}
> +
>  int ad7091r_probe(struct device *dev, const char *name,
>  		const struct ad7091r_chip_info *chip_info,
>  		struct regmap *map, int irq)
> @@ -217,6 +242,22 @@ int ad7091r_probe(struct device *dev, const char *name,
>  			return ret;
>  	}
>  
> +	st->reg = devm_regulator_get_optional(dev, "vref");
> +	if (IS_ERR(st->reg)) {
> +		if (PTR_ERR(st->reg) == EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		st->reg = NULL;
> +	} else {
> +		ret = regulator_enable(st->reg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, ad7091r_remove, st);
> +	if (ret)
> +		return ret;
> +
This is more complex than it needs to be...

	st->reg = devm_regulator_get_optional(dev, "vref");
	if (IS_ERR(st->reg)) {
		if (PTR_ERR(st->reg) == EPROBE_DEFER)
			return -EPROBE_DEFER;

		st->reg = NULL;
	} else {
		ret = regulator_enable(st->reg);
		if (ret)
			return ret;
		ret = devm_add_action_or_reset(dec, ad7091r_dis_reg, st);
		if (ret)
			return ret;
	}

with
static void ad7091r_dis_reg(void *data)
{
	struct ad7091r_state *st = data;

	regulator_disable(st->reg);
}

That way the disable is only registered if we actually have a reg
and hence we don't need to check if we do.

Also, give it a more specific name than reg.   Chances are someone
will add the main power supply control sometime in the future.


>  	/* Use command mode by default to convert only desired channels*/
>  	ret = ad7091r_set_mode(st, AD7091R_MODE_COMMAND);
>  	if (ret)
> diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> index 5f1147735953..76b76968d071 100644
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
> index f7b3326032e8..73d18ddfd2c9 100644
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
> @@ -58,11 +61,13 @@ static const struct iio_chan_spec ad7091r5_channels_noirq[] = {
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

