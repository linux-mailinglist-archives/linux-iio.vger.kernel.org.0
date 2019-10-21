Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC0A0DF08D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 16:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfJUOy7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 10:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfJUOy6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Oct 2019 10:54:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12E1520656;
        Mon, 21 Oct 2019 14:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571669697;
        bh=Ae8OHG6lZmDDwOM3SPPGHZv5YZXmtKO6eyJM3Lg9gCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yVdUxHn0ayRtWCZgG2r4z6BF9YxO67CgUU/O5YziuEIz/2b4fLTzjX4STw//Gb9gZ
         dowPKbMZQWZHC6ohCe9xAjDoYFk9qMuAhGAI9WmWVU6bqgDPiVtDwNedmIU/nqX99b
         rhYuCZ5XiFF3N1gxV8wRDkuenIuMGMjWP0cJZqlY=
Date:   Mon, 21 Oct 2019 15:54:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <paulmck@linux.ibm.com>,
        <mchehab+samsung@kernel.org>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <biabeniamin@outlook.com>,
        Paul Cercueil <paul.cercueil@analog.com>
Subject: Re: [PATCH 2/4] iio: adc: ad7091r5: Add scale and external VREF
 support
Message-ID: <20191021155450.0ac9d380@archlinux>
In-Reply-To: <20191021170608.26412-2-beniamin.bia@analog.com>
References: <20191021170608.26412-1-beniamin.bia@analog.com>
        <20191021170608.26412-2-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Oct 2019 20:06:06 +0300
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
My only comment on this one is that you could use devm_add_action_or_reset
to deal with the regulator clean up.

> ---
>  drivers/iio/adc/ad7091r-base.c | 42 +++++++++++++++++++++++++++++++++-
>  drivers/iio/adc/ad7091r-base.h |  1 +
>  drivers/iio/adc/ad7091r5.c     |  5 ++++
>  3 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index 140413329754..d416f0912531 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -14,6 +14,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  
>  #define AD7091R_REG_RESULT  0
>  #define AD7091R_REG_CHANNEL 1
> @@ -42,6 +43,7 @@ enum ad7091r_mode {
>  struct ad7091r_state {
>  	struct device *dev;
>  	struct regmap *map;
> +	struct regulator *reg;
>  	const struct ad7091r_chip_info *chip_info;
>  	enum ad7091r_mode mode;
>  };
> @@ -139,6 +141,21 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
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
> @@ -215,6 +232,18 @@ int ad7091r_probe(struct device *dev, const char *name,
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

I would use devm_add_action_or_reset with appropriate wrapper
around disabling the regulator. That will get rid of the
need to manually deal with errors or remove path.

> +	}
> +
>  	/* Use command mode by default */
>  	ret = ad7091r_set_mode(st, AD7091R_MODE_COMMAND);
>  	if (ret < 0)
> @@ -222,18 +251,29 @@ int ad7091r_probe(struct device *dev, const char *name,
>  
>  	ret = iio_device_register(iio_dev);
>  	if (ret)
> -		return ret;
> +		goto err_disable_reg;
>  
>  	dev_dbg(dev, "Probed\n");
>  	return 0;
> +
> +err_disable_reg:
> +	if (st->reg)
> +		regulator_disable(st->reg);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(ad7091r_probe);
>  
>  int ad7091r_remove(struct device *dev)
>  {
>  	struct iio_dev *iio_dev = dev_get_drvdata(dev);
> +	struct ad7091r_state *st = iio_priv(iio_dev);
>  
>  	iio_device_unregister(iio_dev);
> +
> +	if (st->reg)
> +		regulator_disable(st->reg);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(ad7091r_remove);
> diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> index 7a29f86ea82b..cec4fb75fecc 100644
> --- a/drivers/iio/adc/ad7091r-base.h
> +++ b/drivers/iio/adc/ad7091r-base.h
> @@ -18,6 +18,7 @@ struct ad7091r_state;
>  struct ad7091r_chip_info {
>  	unsigned int num_channels;
>  	const struct iio_chan_spec *channels;
> +	unsigned int vref_mV;
>  };
>  
>  extern const struct regmap_config ad7091r_regmap_config;
> diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
> index 1ba838c58c31..65bcd8bb692a 100644
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

