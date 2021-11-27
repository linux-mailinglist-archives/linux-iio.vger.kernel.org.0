Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E735F46005A
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 17:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhK0RA4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 12:00:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46508 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbhK0Q64 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 11:58:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFC9CB82A16;
        Sat, 27 Nov 2021 16:55:40 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id B070AC53FBF;
        Sat, 27 Nov 2021 16:55:36 +0000 (UTC)
Date:   Sat, 27 Nov 2021 17:00:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] iio:filter:admv8818: add support for ADMV8818
Message-ID: <20211127170037.344cdd10@jic23-huawei>
In-Reply-To: <20211123133900.133027-2-antoniu.miclaus@analog.com>
References: <20211123133900.133027-1-antoniu.miclaus@analog.com>
        <20211123133900.133027-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 15:38:58 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADMV8818-EP is a fully monolithic microwave integrated
> circuit (MMIC) that features a digitally selectable frequency of
> operation. The device features four independently controlled high-
> pass filters (HPFs) and four independently controlled low-pass
> filters (LPFs) that span the 2 GHz to 18 GHz frequency range.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/admv8818-ep.pdf
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

I think the ABI needs tweaking a little if the clk isn't present
+ dt-binding currently says the clk is required but the driver has it optional.
Should definitely be optional...

...

> +
> +static int admv8818_set_mode(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     unsigned int mode)
> +{
> +	struct admv8818_state *st = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	switch (mode) {
> +	case ADMV8818_AUTO_MODE:
> +		if (st->filter_mode && st->clkin) {
> +			ret = clk_prepare_enable(st->clkin);
> +			if (ret)
> +				return ret;
> +
> +			ret = clk_notifier_register(st->clkin, &st->nb);
> +			if (ret)
> +				return ret;
> +		} else {
> +			return ret;

If you have a path that will always return 0, then just make it return 0
and don't set ret to a default value.  More readable to make that explicit
as I don't need to look at what value ret has.

I wondered about suggesting that you don't have a this attribute if not
clkin registered, but it's better to have it and just have it always
set to manual.  However that changes the available values, so you will
still need to have two seperate chan_spec arrays and pick between them
depending on whether the clock is supplied.

I'd express the logic here differently as well

	if (!st->clkin)
		if (mode == ADV8818_MANUAL_MODE)
			return 0; //you could just skip this case, but maybe it's nice to have.

		return -EINVAL;
	}
	//Now we know it might actually makes sense to do something

	switch(mode) {
	case ADMV8818_AUTO_MODE:
		if (!st->filter_mode)
			return 0;

		ret = clk_prepare_enable(st->clk_in);
		if (ret)
			return ret;

		ret = clk_notifier_register(st->clkin, &st->nb);
		if (ret) {
			clk_disable_unprepare(st->clk_in);

			return ret;
		}

	}

> +		}
> +
> +		break;
> +	case ADMV8818_MANUAL_MODE:
> +		if (st->filter_mode == 0 && st->clkin) {
> +			clk_disable_unprepare(st->clkin);
> +
> +			ret = clk_notifier_unregister(st->clkin, &st->nb);
> +			if (ret)
> +				return ret;
> +		} else {
> +			return ret;
> +		}
> +
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	st->filter_mode = mode;
> +
> +	return ret;
> +}
> +

...

> +
> +static int admv8818_init(struct admv8818_state *st)
> +{
> +	int ret;
> +	struct spi_device *spi = st->spi;
> +	unsigned int chip_id;
> +
> +	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> +				 ADMV8818_SOFTRESET_N_MSK |
> +				 ADMV8818_SOFTRESET_MSK,
> +				 FIELD_PREP(ADMV8818_SOFTRESET_N_MSK, 1) |
> +				 FIELD_PREP(ADMV8818_SOFTRESET_MSK, 1));
> +	if (ret) {
> +		dev_err(&spi->dev, "ADMV8818 Soft Reset failed.\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> +				 ADMV8818_SDOACTIVE_N_MSK |
> +				 ADMV8818_SDOACTIVE_MSK,
> +				 FIELD_PREP(ADMV8818_SDOACTIVE_N_MSK, 1) |
> +				 FIELD_PREP(ADMV8818_SDOACTIVE_MSK, 1));
> +	if (ret) {
> +		dev_err(&spi->dev, "ADMV8818 SDO Enable failed.\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_read(st->regmap, ADMV8818_REG_CHIPTYPE, &chip_id);
> +	if (ret) {
> +		dev_err(&spi->dev, "ADMV8818 Chip ID read failed.\n");
> +		return ret;
> +	}
> +
> +	if (chip_id != 0x1) {
> +		dev_err(&spi->dev, "ADMV8818 Invalid Chip ID.\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_B,
> +				 ADMV8818_SINGLE_INSTRUCTION_MSK,
> +				 FIELD_PREP(ADMV8818_SINGLE_INSTRUCTION_MSK, 1));
> +	if (ret) {
> +		dev_err(&spi->dev, "ADMV8818 Single Instruction failed.\n");
> +		return ret;
> +	}
> +
> +	st->freq_scale = HZ_PER_MHZ;
> +
> +	if (st->clkin)
> +		return admv8818_rfin_band_select(st);
> +	else
> +		return 0;
> +}
> +
> +static int admv8818_clk_setup(struct admv8818_state *st)
> +{
> +	struct spi_device *spi = st->spi;
> +	int ret;
> +
> +	st->clkin = devm_clk_get_optional(&spi->dev, "rf_in");
> +	if (IS_ERR(st->clkin))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
> +				     "failed to get the input clock\n");
> +	else if (!st->clkin)

You have this as required in the dt-binding which you should relax.
(note I didn't raise that for the dt-bindings as reviewed them before
the driver)

> +		return 0;
> +
> +	ret = clk_prepare_enable(st->clkin);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv8818_clk_disable, st);
> +	if (ret)
> +		return ret;
> +
> +	st->nb.notifier_call = admv8818_freq_change;
> +	ret = clk_notifier_register(st->clkin, &st->nb);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_add_action_or_reset(&spi->dev, admv8818_clk_notifier_unreg, st);
> +}

...

