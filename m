Return-Path: <linux-iio+bounces-6300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A6C90986E
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 15:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 840CDB21A4B
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23901482C1;
	Sat, 15 Jun 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/CIoDBl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC904776A;
	Sat, 15 Jun 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718457036; cv=none; b=QR5FMA6JR0nlEUanZuArCNdGX5FJGXW65+Roeue4Z5+mOg16tVIp1A5MReJ5linr5WY6MF/BXPtYsxral2a+Qi4X0eBX0PAsfOcv5PXszQFa7rIduB/Obzq+PfTEaO6DNIdUtQWzJIpWU4os1RryHqObX3A6turGD8G6CsVB8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718457036; c=relaxed/simple;
	bh=fPaBSiC+FfjvdojmHzmqX87WQOwfI9Omhv+LvzZyPU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMM+BtDFbBhQm49vBl9InYSidknNxHwTa5L1ozHLDGK6dQz7NifxyHGqrTGiEjl2rIGIKAgMno2yVIQNEmTSOGBDRdkzp/Sojll8dLBl3Qd6LN+iZzzwWnNamDU9NaMw8yMAdaJN//aq1+oRTrzp6ITgP3nKEGiggbj9DtbOFMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/CIoDBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FADC116B1;
	Sat, 15 Jun 2024 13:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718457036;
	bh=fPaBSiC+FfjvdojmHzmqX87WQOwfI9Omhv+LvzZyPU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G/CIoDBl2iBPr+J5BMWJ5lvkRaNeHpY5vtk0fNmIaPAyk3GnmnHnWlSb3o6EagA+B
	 xM3J+ayNhBq1ZpjZMGI5924UbZrRiJBhtDGfJ+pTe3NRgR+OsIzXM+k/dXSzJo/lCe
	 r78NB23QkwtBZKnBAcLJJ9Mge7PtDWLAP6YA4WXmtiPBliLoQ4QmNOaWWOEFsGy1kZ
	 E9GwxmSCuLgoG0ih529qnoIoAn1PIxowc/b750joTijJM2qND5NOSjrwbZgbHNZ9O3
	 trP0UnihF1cXRF9+Cy49jF1ZAdBVYbvUkgl3cFmB5GvZ+iHYSH1fmSGwcQlhT1oLwl
	 BL7ugfixgOGFw==
Date: Sat, 15 Jun 2024 14:10:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: Re: [PATCH 2/3] iio: adc: ad4695: Add driver for AD4695 and similar
 ADCs
Message-ID: <20240615141027.2ae05af3@jic23-huawei>
In-Reply-To: <20240612-iio-adc-ad4695-v1-2-6a4ed251fc86@baylibre.com>
References: <20240612-iio-adc-ad4695-v1-0-6a4ed251fc86@baylibre.com>
	<20240612-iio-adc-ad4695-v1-2-6a4ed251fc86@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 14:20:41 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This is a new driver for Analog Devices Inc. AD4695 and similar ADCs.
> The initial driver supports initializing the chip including configuring
> all possible LDO and reference voltage sources as well as any possible
> voltage input channel wiring configuration.
> 
> Only the 4-wire SPI wiring mode where the CNV pin is tied to the CS pin
> is supported at this time. And reading sample data from the ADC can only
> be done in direct mode for now.
> 
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Hi Ramona / David,

Comments inline.  Big stuff is going to be around the binding so
I've not commented much on that as it'll probably change in v2.

other stuff all minor.

Jonathan


>  
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 37ac689a0209..5c4d79d4f939 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
>  obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
>  obj-$(CONFIG_AD4130) += ad4130.o
> +obj-$(CONFIG_AD4695) += ad4695.o
>  obj-$(CONFIG_AD7091R) += ad7091r-base.o
>  obj-$(CONFIG_AD7091R5) += ad7091r5.o
>  obj-$(CONFIG_AD7091R8) += ad7091r8.o
> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> new file mode 100644
> index 000000000000..6e5a87817c86
> --- /dev/null
> +++ b/drivers/iio/adc/ad4695.c
> @@ -0,0 +1,804 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SPI ADC driver for Analog Devices Inc. AD4695 and similar chips
> + *
> + * https://www.analog.com/en/products/ad4695.html
> + * https://www.analog.com/en/products/ad4696.html
> + * https://www.analog.com/en/products/ad4697.html
> + * https://www.analog.com/en/products/ad4698.html
> + *
> + * Copyright 2024 Analog Devices Inc.
> + * Copyright 2024 BayLibre, SAS
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/compiler.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +
> +/* AD4695 registers */
> +#define AD4695_REG_SPI_CONFIG_A			0x0000
A nice way to handle register and field definitions is to use a few
spaces to make the difference visible.

#define AD4695_REG_SPI_CONFIG_A			0x0000
#define   AD4695_SPI_CONFIG_A_SW_RST_MSB

> +#define AD4695_REG_SPI_CONFIG_B			0x0001
> +#define AD4695_REG_DEVICE_TYPE			0x0003
> +#define AD4695_REG_SCRATCH_PAD			0x000A
> +#define AD4695_REG_VENDOR_L			0x000C
> +#define AD4695_REG_VENDOR_H			0x000D
> +#define AD4695_REG_LOOP_MODE			0x000E
> +#define AD4695_REG_SPI_CONFIG_C			0x0010
> +#define AD4695_REG_SPI_STATUS			0x0011
> +#define AD4695_REG_STATUS			0x0014
> +#define AD4695_REG_ALERT_STATUS1		0x0015
> +#define AD4695_REG_ALERT_STATUS2		0x0016
> +#define AD4695_REG_CLAMP_STATUS			0x001A
> +#define AD4695_REG_SETUP			0x0020
> +#define AD4695_REG_REF_CTRL			0x0021
> +#define AD4695_REG_SEQ_CTRL			0x0022
> +#define AD4695_REG_AC_CTRL			0x0023
> +#define AD4695_REG_STD_SEQ_CONFIG		0x0024
> +#define AD4695_REG_GPIO_CTRL			0x0026
> +#define AD4695_REG_GP_MODE			0x0027
> +#define AD4695_REG_TEMP_CTRL			0x0029
> +#define AD4695_REG_CONFIG_IN(n)			(0x0030 | (n))
> +#define AD4695_REG_UPPER_IN(n)			(0x0040 | (2 * (n)))
> +#define AD4695_REG_LOWER_IN(n)			(0x0060 | (2 * (n)))
> +#define AD4695_REG_HYST_IN(n)			(0x0080 | (2 * (n)))
> +#define AD4695_REG_OFFSET_IN(n)			(0x00A0 | (2 * (n)))
> +#define AD4695_REG_GAIN_IN(n)			(0x00C0 | (2 * (n)))
> +#define AD4695_REG_AS_SLOT(n)			(0x0100 | (n))
> +#define AD4695_REG_MAX				0x017F
> +
> +/* Conversion mode commands */
> +#define AD4695_CMD_EXIT_CNV_MODE		0x0A
> +#define AD4695_CMD_TEMP_CHAN			0x0F
> +#define AD4695_CMD_VOLTAGE_CHAN(n)		(0x10 | (n))
> +
> +/* SPI_CONFIG_A */
> +#define AD4695_SW_RST_MSB		BIT(7)
> +#define AD4695_SW_RST_LSB		BIT(0)
Do these have separate usecases? Looks a bit like a magic value to me used
to trigger a reset. If so just use one define with both bits set.

> +
> +/* SPI_CONFIG_B */
> +#define AD4695_INST_MODE_MASK		BIT(7)
I'm very keen on field defintions including the register so it's immediately
obvious you at least got a plausible one. That does sometime make it useful
to abreviate register names more.  Also good to keep these next to the
register address. Using a bit of white space can help to differentiate register
fields from the register address.


#define AD4695_SPI_CONFB_INST_MODE_MASK

> +#define AD4695_INST_MODE(x)		FIELD_PREP(AD4695_INST_MODE_MASK, (x))

I'd just call FIELD_PREP inline.  It's a few more characters but it makes
it immediately obvious this is filling the field rather than getting it which
you can't tell from the short version.

Same for all the other cases of this.  Masks + values the field can take
(where there is more than 0 or 1) should be enough.




> +
> +enum ad4695_instr_mode {
> +	AD4695_INST_MODE_STREAM,
> +	AD4695_INST_MODE_SINGLE,
> +};
> +
> +/* Setup */
> +#define AD4695_LDO_EN_MASK		BIT(4)
> +#define AD4695_LDO_EN(x)		FIELD_PREP(AD4695_LDO_EN_MASK, (((x) ? 1 : 0)))
> +#define AD4695_SPI_MODE_MASK		BIT(2)
> +#define AD4695_SPI_MODE(x)		FIELD_PREP(AD4695_SPI_MODE_MASK, (x))
> +#define AD4695_SPI_CYC_CTRL_MASK	BIT(1)
> +#define AD4695_SPI_CYC_CTRL(x)		FIELD_PREP(AD4695_SPI_CYC_CTRL_MASK, (x))
> +
> +/* REF_CTRL */
> +#define AD4695_OV_MODE_MASK		BIT(7)
> +#define AD4695_OV_MODE(x)		FIELD_PREP(AD4695_OV_MODE_MASK, (x))
> +#define AD4695_VREF_SET_MASK		GENMASK(4, 2)
> +#define AD4695_VREF_SET(x)		FIELD_PREP(AD4695_VREF_SET_MASK, (x))
> +#define AD4695_REFHIZ_EN_MASK		BIT(1)
> +#define AD4695_REFHIZ_EN(x)		FIELD_PREP(AD4695_REFHIZ_EN_MASK, (((x) ? 1 : 0)))
> +#define AD4695_REFBUF_EN_MASK		BIT(0)
> +#define AD4695_REFBUF_EN(x)		FIELD_PREP(AD4695_REFBUF_EN_MASK, (((x) ? 1 : 0)))
> +
> +enum ad4695_ov_mode {
> +	AD4695_OV_MODE_REDUCE_CURRENT,
> +	AD4695_OV_MODE_DO_NOT_REDUCE_CURRENT,
> +};
> +
> +/* SEQ_CTRL */
> +#define AD4695_STD_SEQ_EN_MASK		BIT(7)
> +#define AD4695_STD_SEQ_EN(x)		FIELD_PREP(AD4695_STD_SEQ_EN_MASK, (((x) ? 1 : 0)))
> +#define AD4695_NUM_SLOTS_AS_MASK	GENMASK(6, 0)
> +#define AD4695_NUM_SLOTS_AS(x)		FIELD_PREP(AD4695_NUM_SLOTS_AS_MASK, (x))
> +
> +/* CONFIG_INn */
> +#define AD4695_IN_MODE_MASK		BIT(6)
> +#define AD4695_IN_MODE(x)		FIELD_PREP(AD4695_IN_MODE_MASK, (((x) ? 1 : 0)))
> +#define AD4695_IN_PAIR_MASK		GENMASK(5, 4)
> +#define AD4695_IN_PAIR(x)		FIELD_PREP(AD4695_IN_PAIR_MASK, (x))
> +#define AD4695_AINHIGHZ_EN_MASK		BIT(3)
> +#define AD4695_AINHIGHZ_EN(x)		FIELD_PREP(AD4695_AINHIGHZ_EN_MASK, (((x) ? 1 : 0)))
> +
> +enum ad4695_in_pair {
> +	AD4695_WITH_REFGND,
> +	AD4695_WITH_COM,
> +	AD4695_EVEN_ODD,
> +};
> +
> +/* AS_SLOTn */
> +#define AD4695_SLOT_INX_MASK		GENMASK(3, 0)
> +#define AD4695_SLOT_INX(x)		FIELD_PREP(AD4695_SLOT_INX_MASK, (x))




> +/* register convenience functions */

Drop 'code structure' comments.  The bit rot badly as code evolves
and the reader ought to be able to figure out the structure from
the code.

> +
> +static int ad4695_soft_reset(struct ad4695_state *st)
> +{
> +	int ret;
> +
> +	ret = regmap_set_bits(st->regmap, AD4695_REG_SPI_CONFIG_A,
> +			      AD4695_SW_RST_MSB | AD4695_SW_RST_LSB);
> +	if (ret)
> +		return ret;
> +
> +	/* datasheet says we have to wait before communicating again */
> +	msleep(AD4695_T_WAKEUP_SW_MS);
> +
> +	return 0;
> +}
> +
> +static int ad4695_set_instr_mode(struct ad4695_state *st,
> +				 enum ad4695_instr_mode mode)
> +{
> +	return regmap_update_bits(st->regmap, AD4695_REG_SPI_CONFIG_B,
> +				  AD4695_INST_MODE_MASK, AD4695_INST_MODE(mode));

So far this wrapper isn't adding anything over just calling the
regmap_update_bits directly.  So I'd get rid of the wrapper

> +}
> +
> +static int ad4695_set_ldo_en(struct ad4695_state *st, bool enable)
> +{
> +	return regmap_update_bits(st->regmap, AD4695_REG_SETUP,
> +				  AD4695_LDO_EN_MASK, AD4695_LDO_EN(enable));

As above. This is pretty self explanatory as a regmap call so why wrap it?

> +}
> +
> +/**
> + * ad4695_set_single_cycle_mode - Set the device in single cycle mode
> + * @st: The AD4695 state
> + * @channel: The first channel to read
> + *
> + * As per the datasheet, to enable single cycle mode, we need to set
> + * STD_SEQ_EN=0, NUM_SLOTS_AS=0 and CYC_CTRL=1 (Table 15). Setting SPI_MODE=1
> + * triggers the first conversion using the channel in AS_SLOT0.
> + *
> + * Context: can sleep, must be called with iio_device_claim_direct held
> + * Return: 0 on success, a negative error code on failure
> + */
> +static int ad4695_set_single_cycle_mode(struct ad4695_state *st,
> +					unsigned int channel)
> +{
> +	int ret;

This sort of wrapper of more complex behaviour makes sense - particularly
as it provides somewhere for documentation. So keep this one.
> +
> +	ret = regmap_clear_bits(st->regmap, AD4695_REG_SEQ_CTRL,
> +				AD4695_STD_SEQ_EN_MASK | AD4695_NUM_SLOTS_AS_MASK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4695_REG_AS_SLOT(0),
> +			   AD4695_SLOT_INX(channel));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_set_bits(st->regmap, AD4695_REG_SETUP,
> +			       AD4695_SPI_MODE_MASK | AD4695_SPI_CYC_CTRL_MASK);
> +}

> +
> +static int ad4695_set_refhiz_en(struct ad4695_state *st, bool enable)
> +{
> +	return regmap_update_bits(st->regmap, AD4695_REG_REF_CTRL,
> +				  AD4695_REFHIZ_EN_MASK, AD4695_REFHIZ_EN(enable));

These wrappers don't add that much in my opinion. I'd drop them
and just call the regmap functions directly.

> +}
> +
> +static int ad4695_set_refbuf_en(struct ad4695_state *st, bool enable)
> +{
> +	return regmap_update_bits(st->regmap, AD4695_REG_REF_CTRL,
> +				  AD4695_REFBUF_EN_MASK, AD4695_REFBUF_EN(enable));
> +}
> +
> +static int ad4695_write_chn_cfg(struct ad4695_state *st,
> +				struct ad4695_channel_config *cfg)
> +{
> +	u32 mask = 0, val = 0;
> +
> +	mask |= AD4695_IN_MODE_MASK;
> +	val |= AD4695_IN_MODE(cfg->bipolar);
> +
> +	mask |= AD4695_IN_PAIR_MASK;
> +	val |= AD4695_IN_PAIR(cfg->pin_pairing);
> +
> +	mask |= AD4695_AINHIGHZ_EN_MASK;
> +	val |= AD4695_AINHIGHZ_EN(cfg->highz_en);
> +
> +	return regmap_update_bits(st->regmap, AD4695_REG_CONFIG_IN(cfg->channel),
> +				  mask, val);
> +}
> +

> +
> +/* IIO implementation */

Drop that comment. It is highly likely to be come untrue over time as
code gets moved around and brings little benefit.


> +
> +static int ad4695_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +				     unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad4695_state *st = iio_priv(indio_dev);
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {

Bit odd given you don't support anything else yet, but I guess future proofing
is fine.

> +		if (readval)
> +			return regmap_read(st->regmap, reg, readval);
> +
> +		return regmap_write(st->regmap, reg, writeval);
> +	}
> +
> +	unreachable();
> +}
> +
> +static const struct iio_info ad4695_info = {
> +	.read_raw = &ad4695_read_raw,
> +	.debugfs_reg_access = &ad4695_debugfs_reg_access,
> +};
> +
> +static int ad4695_parse_channel_cfg(struct iio_dev *indio_dev)
> +{
> +	struct device *dev = indio_dev->dev.parent;
> +	struct ad4695_state *st = iio_priv(indio_dev);
> +	struct iio_chan_spec *iio_chan_arr;
> +	struct ad4695_channel_config *chan_cfg_arr;
> +	unsigned int channel, chan_idx = 0;

Trivial:
Use a separate line for the one that gets initialised

> +	int ret;
> +
...

> +static int ad4695_probe(struct spi_device *spi)
> +{

...


> +	ret = ad4695_parse_channel_cfg(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4695_set_instr_mode(st, AD4695_INST_MODE_SINGLE);

I comment on these above. So far I'm not seeing an advantage to the wrappers.
Maybe they will gain locking or something later but for now they aren't
justified.

> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->chip_info->name;
> +	indio_dev->info = &ad4695_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

