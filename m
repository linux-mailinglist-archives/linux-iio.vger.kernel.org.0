Return-Path: <linux-iio+bounces-14574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5951DA1C39C
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 14:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4328B1886805
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 13:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6232080F0;
	Sat, 25 Jan 2025 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN7Fz/P4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD21E50B;
	Sat, 25 Jan 2025 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737811500; cv=none; b=V/wow2q9e0KFunKRId1qx84Gj136GcAFdw3pehljivoQd+KEab1RAUA/r9FPA6M9LEH8ixjP8nTK570R27CPt3B5EljiJRp9qJ5sLqwmzC/eOcAL9uoFOGZL5uz9qccVkLBQKRwSzWphO4stRNJ3H6L+sYwbP5tfkHa8Vn5V84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737811500; c=relaxed/simple;
	bh=MU0T5PtgWFF0rStF+vdR2w7ZqjR1UcSyhjlMCFo0Gp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKT7QDLrE3QKCT9ht2DgHRlxR2obuQiOs44yAy1FZvKfvgaMZR+rOtv8KHK3Mylef7u9MUMq/QMKTeFcR9iZFykCno5XWJjVSV0SeuYv6GvqDB39QbAcbD46H6B7DAPZD7C/DCHA2mB45Ao062FczIaGyaZv7UEAIBUkb9iuL8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN7Fz/P4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79F5C4CED6;
	Sat, 25 Jan 2025 13:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737811499;
	bh=MU0T5PtgWFF0rStF+vdR2w7ZqjR1UcSyhjlMCFo0Gp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hN7Fz/P4MRU48yW7zXCFsvyWR7MA0IAH3H5rNNPthTdL7AuP1T18CpAE5d08Zohit
	 To6G3yKYsNHkOunqRuxjiyzVIZazQN9GfCF/owqUBGZPKFNep8UUZI9fD3mLvd4i74
	 Al8WQbzyObTwIHMeN3WcGYrr2EZ9vFQdSod2o7WYbep9yLRh1De4E/naS9gIUEE2UT
	 N2LYj8AM14WnBcX7fKKssdQK9VSzuT0Kq3JjQ6YFDRPaUKDR0GSxsOi5W56EHdVe7L
	 SSKNlgxZ8mMNkZKr4o+F1PtTDWA92kuomML74n3Y0D2KMEnLWZo7Ji06CiAGxtUK/w
	 L6ro5YYovFS7w==
Date: Sat, 25 Jan 2025 13:24:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: amplifiers: add ADA4255 driver
Message-ID: <20250125132449.44743fbb@jic23-huawei>
In-Reply-To: <20250120105429.183004-2-demonsingur@gmail.com>
References: <20250120105429.183004-1-demonsingur@gmail.com>
	<20250120105429.183004-2-demonsingur@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jan 2025 12:54:25 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> The ADA4255 is a  precision programmable gain instrumentation amplifier
> (PGIA) with integrated bipolar charge pumps.

Good to shout a bit about this including a gpio chip.

> 
> With its integrated charge pumps, the ADA4255 internally produces the
> high voltage bipolar supplies needed to achieve a wide input voltage
> range (38V typical with VDDCP = 5V) without lowering input impedance.
> 
> The charge pump topology of the ADA4255 allows channels to be isolated
> with only low voltage components, reducing complexity, size, and
> implementation time in industrial and process control systems.
> 
> Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>

A few comments inline, but all superficial stuff. Looks like
a nice driver to me

Jonathan

> diff --git a/drivers/iio/amplifiers/ada4255.c b/drivers/iio/amplifiers/ada4255.c
> new file mode 100644
> index 0000000000000..8d25ffa7baa6c
> --- /dev/null
> +++ b/drivers/iio/amplifiers/ada4255.c
> @@ -0,0 +1,937 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2022 Analog Devices, Inc.

That date wants a -2025 given you will be changing this
in response to review anyway.

> + * Author: Cosmin Tanislav <cosmin.tanislav@analog.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/iio.h>

> +
> +#define ADA4255_NAME				"ada4255"

Just use the string inline.  These generic 'driver name' defines
are unhelpful to reading the code in comparison with the string
in the place it's used.

> +
> +#define ada4255_from_clk_hw(hw) \
> +	container_of(hw, struct ada4255_state, int_clk_hw)
> +
> +struct ada4255_chip_info {
> +	const char			*name;
> +	bool				has_charge_pump;
> +};
> +
> +struct ada4255_state {
> +	struct spi_device		*spi;
only used to get to the dev.  So either have a struct device pointer
here or just get that from the regmap where needed.

> +	struct regmap			*regmap;
> +	struct clk			*mclk;
> +	const struct ada4255_chip_info	*chip_info;
> +
> +	/*
> +	 * Synchronize consecutive regmap operations.

Be more specific as regmap has it's own locks.
Perhaps a read modify write section that needs to
be locked around?

> +	 */
> +	struct mutex			lock;
> +	struct gpio_chip		gc;
> +	struct notifier_block		ext_clk_nb;
> +	struct clk_hw			int_clk_hw;
> +
> +	bool				gpio4_clk_en;
> +	bool				int_clk_out_en;
> +};

> +
> +static const unsigned int ada4255_excitation_current_ua_tbl[] = {
> +	0, 100, 200, 300, 400, 500, 600, 700, 800,
> +	900, 1000, 1100, 1200, 1300, 1400, 1500
9 on 1st line is a bit random.  Go with a power of 2.  8 is per line
and 1 on the last line probably best choiceh ere.


> +};
> +
> +static const unsigned int ada4255_clk_cp_sel_hz_tbl[] = {
> +	16000000, 8000000
> +};
> +
> +static const unsigned int ada4255_int_clk_rate_hz_tbl[] = {
> +	1000000, 125000,
> +};
> +
> +static int _ada4255_find_tbl_index(const unsigned int *tbl, unsigned int tbl_len,
> +				   unsigned int val, unsigned int *index)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < tbl_len; i++)

The kernel style docs are a bit ambiguous IIRC on this, but I'd add {}
on basis next bit is multiline.

> +		if (val == tbl[i]) {
> +			*index = i;
> +			return 0;
> +		}
> +
> +	return -EINVAL;
> +}

> +static int ada4255_set_gain(struct ada4255_state *st, int val, int val2)
> +{
> +	ssize_t tbl_len = ARRAY_SIZE(ada4255_gain_tbl);
> +	unsigned int i, g5, g4, g3_0;
> +	int ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(ada4255_gain_tbl); i++)
> +		if (val == ada4255_gain_tbl[i][0] &&
> +		    val2 == ada4255_gain_tbl[i][1])
> +			break;
> +
> +	if (i == tbl_len)
> +		return -EINVAL;
> +
> +	g5 = ada4255_gain_reg_tbl[i][0];
> +	g4 = ada4255_gain_reg_tbl[i][1];
> +	g3_0 = ada4255_gain_reg_tbl[i][2];
> +
> +	mutex_lock(&st->lock);
As below. guard() helps in this sort of case


> +
> +	ret = regmap_update_bits(st->regmap, ADA4255_TEST_MUX_REG,
> +				 ADA4255_GAIN_G5_MASK,
> +				 FIELD_PREP(ADA4255_GAIN_G5_MASK, g5));
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_update_bits(st->regmap, ADA4255_GAIN_MUX_REG,
> +				 ADA4255_GAIN_G4_MASK | ADA4255_GAIN_G3_0_MASK,
> +				 FIELD_PREP(ADA4255_GAIN_G4_MASK, g4) |
> +				 FIELD_PREP(ADA4255_GAIN_G3_0_MASK, g3_0));
> +
> +out:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int ada4255_get_gain(struct ada4255_state *st, int *val, int *val2)
> +{
> +	ssize_t tbl_len = ARRAY_SIZE(ada4255_gain_reg_tbl);
> +	unsigned int i, gain, test_gain, g5, g4, g3_0;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = regmap_read(st->regmap, ADA4255_GAIN_MUX_REG, &gain);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_read(st->regmap, ADA4255_TEST_MUX_REG, &test_gain);
> +
> +out:
> +	mutex_unlock(&st->lock);
scoped_guard(mutex, &st->lock) 
is useful in cases like this as can return without having to worry
about unlocking by hand.

> +
> +	if (ret)
> +		return ret;
> +
> +	g5 = FIELD_GET(ADA4255_GAIN_G5_MASK, test_gain);
> +	g4 = FIELD_GET(ADA4255_GAIN_G4_MASK, gain);
> +	g3_0 = FIELD_GET(ADA4255_GAIN_G3_0_MASK, gain);
> +
> +	for (i = 0; i < ARRAY_SIZE(ada4255_gain_reg_tbl); i++)
> +		if (g5 == ada4255_gain_reg_tbl[i][0] &&
> +		    g4 == ada4255_gain_reg_tbl[i][1] &&
> +		    g3_0 == ada4255_gain_reg_tbl[i][2])
> +			break;
> +
> +	if (i == tbl_len)
> +		return -EINVAL;
> +
> +	*val = ada4255_gain_tbl[i][0];
> +	*val2 = ada4255_gain_tbl[i][1];
> +
> +	return IIO_VAL_INT_PLUS_NANO;
> +}

> +static int ada4255_set_ch_en(struct ada4255_state *st, unsigned int ch, int val)
> +{
> +	unsigned int ch_val = val ? ada4255_ch_input_mux_tbl[ch] : 0;
> +	int current_val;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
guard(mutex)(&st->lock);
+ include cleanup.h
so we can have simpler direct returns instead of goto.

> +
> +	ret = ada4255_get_ch_en(st, ch, &current_val);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (current_val == val) {
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	ret = regmap_write(st->regmap, ADA4255_INPUT_MUX_REG, ch_val);
> +
> +out:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}

> +static unsigned long ada4255_int_clk_recalc_rate(struct clk_hw *hw,
> +						 unsigned long parent_rate)
> +{
> +	struct ada4255_state *st = ada4255_from_clk_hw(hw);
> +	struct device *dev = &st->spi->dev;
> +	unsigned int i = 0;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADA4255_SYNC_CFG_REG, &i);
> +	if (ret)
> +		dev_err(dev, "Failed to read internal clock rate: %d\n", ret);
> +
> +	i = FIELD_GET(ADA4255_INT_CLK_OUT_MASK, i);
> +
> +	return ada4255_int_clk_rate_hz_tbl[i];
Might as well combine as

	return ada4244_int_clk_rate_hz_tbl[FIELD_GET(ADA4255_INT_CLK_OUT_MASK)];
to avoid confusing reuse of i.  Rename i as reg_val or something as well.

> +}
> +

> +static int ada4255_setup_ext_clk(struct ada4255_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	unsigned int divider;
> +	unsigned long rate;
> +	int ret;
> +
> +	ret = clk_prepare_enable(st->mclk);
Use get_optional_enabled() below.  If we have it want to turn it on and
then you don't need to handle tear down yourself.

> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, ada4255_clk_disable_unprepare,
> +				       st->mclk);

...

> +}
> +

> +
> +static int ada4255_setup(struct ada4255_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	unsigned int i;
> +	int ret = 0;

Always set, so no need to initialise here.

> +	u32 val;
> +
> +	st->mclk = devm_clk_get_optional(dev, "mclk");
> +	if (IS_ERR(st->mclk))
> +		return dev_err_probe(dev, PTR_ERR(st->mclk),
> +				     "Failed to get mclk\n");
> +
> +	if (st->mclk)
> +		ret = ada4255_setup_ext_clk(st);
> +	else
> +		ret = ada4255_setup_int_clk(st);
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = device_property_read_u32(dev, "adi,excitation-current-microamp", &val);
> +	if (!ret) {
> +		ret = ada4255_find_tbl_index(ada4255_excitation_current_ua_tbl,
> +					     val, &i);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(st->regmap, AD4255_EX_CURRENT_CFG_REG,
> +					 AD4255_EX_CURRENT_MASK,
> +					 FIELD_PREP(AD4255_EX_CURRENT_MASK, i));
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(st->regmap, AD4255_EX_CURRENT_CFG_REG,
> +					 AD4255_EX_CURRENT_SEL_MASK,
> +					 FIELD_PREP(AD4255_EX_CURRENT_SEL_MASK, 1));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = device_property_read_u32(dev, "adi,charge-pump-freq-hz", &val);
> +	if (!ret) {
> +		if (!st->chip_info->has_charge_pump)

This seems backwards.  Not up to us to check for extra properties in drivers.
So I'd check if we expect one before trying to read the property.

	if (!st->chip_info->has_charge_pump)
		return 0;

	ret = device_property_read_u32(dev, "adi,charge-pump-freq-hz", &val);
	if (ret)
		return ret; // 0 if it is optional.

	etc


> +			return dev_err_probe(dev, -EINVAL,
> +					     "Unsupported charge pump function\n");
> +
> +		ret = ada4255_find_tbl_index(ada4255_clk_cp_sel_hz_tbl, val, &i);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(st->regmap, ADA4255_SYNC_CFG_REG,
> +					 ADA4255_SYNC_CLK_CP_SEL_MASK,
> +					 FIELD_PREP(ADA4255_SYNC_CLK_CP_SEL_MASK, i));
> +		if (ret)
> +			return ret;

After reorder as above, can return regmap_update_bits() for this last one.

> +	}
> +
> +	return 0;
> +}

> +static int ada4255_reset(struct ada4255_state *st)
> +{
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, ADA4255_RESET_REG,
> +			   FIELD_PREP(ADA4255_RESET_REG, 1));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * A full calibration occurs after a soft reset and it takes
> +	 * approximately 85ms.
> +	 * See datasheet page 29, Section OUTPUT RIPPLE CALIBRATION
> +	 * CONFIGURATION.
I'd wrap this as one paragraph.  Looks a bit odd as it is now.
	 * A full calibration occurs after a soft reset and it takes
	 * approximately 85ms. See datasheet page 29, Section OUTPUT
	 * RIPPLE CALIBRATION CONFIGURATION.

> +	 */
> +	fsleep(85000);
> +
> +	return 0;
> +}
> +
> +static int ada4255_probe(struct spi_device *spi)
> +{
> +	static const char * const regulator_names[] = {
> +		"avdd",
> +		"dvdd",
> +		"vddcp",
> +		"vocm",

Fine to put these 4 on one line. We aren't likely to see
more added later and it will be a fairly short line.

> +	};
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ada4255_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +	st->chip_info = spi_get_device_match_data(spi);
> +	if (!st->chip_info)
> +		return -EINVAL;
> +
> +	indio_dev->info = &ada4255_info;
> +	indio_dev->name = st->chip_info->name;
> +	indio_dev->channels = ada4255_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ada4255_channels);
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
> +					     regulator_names);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
> +	st->regmap = devm_regmap_init_spi(spi, &ada4255_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	ret = ada4255_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ada4255_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ada4255_setup_gpio_chip(st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

> +static struct spi_driver ada4255_driver = {
> +	.driver = {
> +			.name = ADA4255_NAME,
> +			.of_match_table = ada4255_of_match,

Indent is 1 tab more than standard

> +		},

Also for this.

> +	.probe = ada4255_probe,
> +	.id_table = ada4255_id,
> +};
> +
A nice pattern that people use is to group the
module_spi_driver() with it's one parameter by not
putting a blank line inbetween. Hence I would delete this
one.
> +module_spi_driver(ada4255_driver);

THanks,

Jonathan

