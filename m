Return-Path: <linux-iio+bounces-24045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA40B560E7
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 14:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511F117D85E
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DB62ECE8C;
	Sat, 13 Sep 2025 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO1Q6ll9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7C3199FB2;
	Sat, 13 Sep 2025 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757767590; cv=none; b=HJdLIJaBCoF6Oya0SUhCqyYczeydGnn7EaLGAqXmZcTb70LyFcF2A17UcjUNPih9aWQh6t4xO6nxXsl2CmFk4fborE8OMsHNel79L3A556T6Gjky9iY14tS1AXWE0bNuTvM+vvoSU/69GNfredqp2C3Wi3xcdaqkvpoGSOuVv3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757767590; c=relaxed/simple;
	bh=M3ucwWOkmd4GlagC3QAB3AkYHK0FWq/mlVQAJs0tkgA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKMERxyee2AQ4wdu/0JtLTQa5x5WP1WNx6lHhdGY8XpjPe2i1qaKJ0SMkgbhlK1oWOGZ2u3bPGen0AbkBIvqLavzhPepMCP6vr1IvMMyAbkRPyLeNdZcjB8Q9iuF/3UiS11MCPXJ9ygV/iNQKzfsae0xleHfxzYWQ19NBKj9JLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO1Q6ll9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69B7C4CEEB;
	Sat, 13 Sep 2025 12:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757767589;
	bh=M3ucwWOkmd4GlagC3QAB3AkYHK0FWq/mlVQAJs0tkgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cO1Q6ll9cwtVu0a8Lbt6yVbozMzHQs1pt5iRBbZUhVsXO+WaOQeLyvF3qeiu2QG0h
	 p8lRBqwVgfc8ImjbpTrgTXP5HAiAXi3GJu+GBNCJlqNd1uLCrWF9JlM21sZvk7eDfC
	 jd9BhIAit7SGV6DiC7KhhsGzucT6wWzoF6G4GLtubRxPlhHcD6cBB07kEeoO1ruql+
	 1oai/onvFGf/4wDLu1RRtEQ1Wj+k2J40v54+punVOaoZM7iGGbbs1xpeVNRf2TBpql
	 RbwhcM+MMx3+2cvcMdVyMwd0eymTPqG+u8/RkQadA0dhOuvUl31gZJ5F/WpCgiGayS
	 h2h+75KYJJ/KQ==
Date: Sat, 13 Sep 2025 13:46:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 4/6] iio: adc: add ade9000 support
Message-ID: <20250913134621.226ed6df@jic23-huawei>
In-Reply-To: <20250908073531.3639-5-antoniu.miclaus@analog.com>
References: <20250908073531.3639-1-antoniu.miclaus@analog.com>
	<20250908073531.3639-5-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Sep 2025 07:35:24 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add driver support for the ade9000. highly accurate,
> fully integrated, multiphase energy and power quality
> monitoring device.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

So, I made a few comments this time that I should probably have
noticed in earlier versions.  I'm not particularly keen to delay
an initial merge of the driver for them but I would like you consider
the suggestion of a perphase structure look up table to
reduce duplication as a potential follow up patch.

Jonathan

> diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> new file mode 100644
> index 000000000000..a3be4bd24686
> --- /dev/null
> +++ b/drivers/iio/adc/ade9000.c

> +/* Voltage events (zero crossing on instantaneous voltage) */
> +static const struct iio_event_spec ade9000_voltage_events[] = {
> +	{
> +		/* Zero crossing detection - datasheet: ZXV interrupts */
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),

Perhaps this event might be easier to understand if we provide a value that
is hard coded to 0?

> +	},
> +};
> +
> +/* Current events (zero crossing on instantaneous current) */
> +static const struct iio_event_spec ade9000_current_events[] = {
> +	{
> +		/* Zero crossing detection - datasheet: ZXI interrupts */
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),

As above.

> +	},
> +};

> +static int ade9000_iio_push_streaming(struct iio_dev *indio_dev)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	u32 current_page, i;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = spi_sync(st->spi, &st->spi_msg);
> +	if (ret) {
> +		dev_err_ratelimited(dev, "SPI fail in trigger handler\n");
> +		return ret;
> +	}
> +
> +	/* In streaming mode, only half the buffer is filled per interrupt */
> +	for (i = 0; i < st->wfb_nr_samples / 2; i += st->wfb_nr_activ_chan)
> +		iio_push_to_buffers(indio_dev, &st->rx_buff.word[i]);
> +
> +	ret = regmap_read(st->regmap, ADE9000_REG_WFB_PG_IRQEN, &current_page);
> +	if (ret) {
> +		dev_err_ratelimited(dev, "IRQ0 WFB read fail\n");
> +		return ret;
> +	}
> +
> +	if (current_page & ADE9000_MIDDLE_PAGE_BIT) {
> +		ret = regmap_write(st->regmap, ADE9000_REG_WFB_PG_IRQEN,
> +				   ADE9000_LAST_PAGE_BIT);
> +		if (ret) {
> +			dev_err_ratelimited(dev, "IRQ0 WFB write fail\n");
> +			return ret;
> +		}
> +
> +		ade9000_configure_scan(indio_dev,
> +				       ADE9000_REG_WF_HALF_BUFF);
> +	} else {
> +		ret = regmap_write(st->regmap, ADE9000_REG_WFB_PG_IRQEN,
> +				   ADE9000_MIDDLE_PAGE_BIT);
> +		if (ret) {
> +			dev_err_ratelimited(dev, "IRQ0 WFB write fail");
> +			return IRQ_HANDLED;
> +		}
> +
> +		ade9000_configure_scan(indio_dev,
> +				       ADE9000_REG_WF_BUFF);

Excessive wrap. Fits on one line.  I'll tidy this up if I pick up the patch.

> +	}
> +
> +	return 0;
> +}


> +
> +static int ade9000_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	u32 interrupts1;
> +	int ret;
> +
> +	/* All events use MASK1 register */
> +	ret = regmap_read(st->regmap, ADE9000_REG_MASK1, &interrupts1);
> +	if (ret)
> +		return ret;
> +
> +	switch (chan->channel) {
> +	case ADE9000_PHASE_A_NR:
> +		if (chan->type == IIO_VOLTAGE && dir == IIO_EV_DIR_EITHER)
> +			return !!(interrupts1 & ADE9000_ST1_ZXVA_BIT);

As below.  If you had a look up table with appropriate per phase structures
the 3 repeats here could basically be change from code to data which is
generally a good idea and is easier to read.

> +		else if (chan->type == IIO_CURRENT && dir == IIO_EV_DIR_EITHER)
> +			return !!(interrupts1 & ADE9000_ST1_ZXIA_BIT);
> +		else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_RISING)
> +			return !!(interrupts1 & ADE9000_ST1_SWELLA_BIT);
> +		else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_FALLING)
> +			return !!(interrupts1 & ADE9000_ST1_DIPA_BIT);
> +		dev_err_ratelimited(&indio_dev->dev, "Invalid channel type %d or direction %d for phase A\n", chan->type, dir);
> +		return -EINVAL;
> +	case ADE9000_PHASE_B_NR:
> +		if (chan->type == IIO_VOLTAGE && dir == IIO_EV_DIR_EITHER)
> +			return !!(interrupts1 & ADE9000_ST1_ZXVB_BIT);
> +		else if (chan->type == IIO_CURRENT && dir == IIO_EV_DIR_EITHER)
> +			return !!(interrupts1 & ADE9000_ST1_ZXIB_BIT);
> +		else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_RISING)
> +			return !!(interrupts1 & ADE9000_ST1_SWELLB_BIT);
> +		else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_FALLING)
> +			return !!(interrupts1 & ADE9000_ST1_DIPB_BIT);
> +		dev_err_ratelimited(&indio_dev->dev, "Invalid channel type %d or direction %d for phase B\n", chan->type, dir);
> +		return -EINVAL;
> +	case ADE9000_PHASE_C_NR:
> +		if (chan->type == IIO_VOLTAGE && dir == IIO_EV_DIR_EITHER)
> +			return !!(interrupts1 & ADE9000_ST1_ZXVC_BIT);
> +		else if (chan->type == IIO_CURRENT && dir == IIO_EV_DIR_EITHER)
> +			return !!(interrupts1 & ADE9000_ST1_ZXIC_BIT);
> +		else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_RISING)
> +			return !!(interrupts1 & ADE9000_ST1_SWELLC_BIT);
> +		else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_FALLING)
> +			return !!(interrupts1 & ADE9000_ST1_DIPC_BIT);
> +		dev_err_ratelimited(&indio_dev->dev, "Invalid channel type %d or direction %d for phase C\n", chan->type, dir);
> +		return -EINVAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ade9000_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      bool state)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	u32 bit_mask;
> +	int ret;
> +
> +	/* Clear all pending events in STATUS1 register (write 1 to clear) */
> +	ret = regmap_write(st->regmap, ADE9000_REG_STATUS1, GENMASK(31, 0));
> +	if (ret)
> +		return ret;
> +
> +	/* Determine which interrupt bit to enable/disable */
> +	switch (chan->channel) {
> +	case ADE9000_PHASE_A_NR:
> +		if (chan->type == IIO_VOLTAGE && dir == IIO_EV_DIR_EITHER) {

Perhaps consider per phase look up tables?

> +			bit_mask = ADE9000_ST1_ZXVA_BIT;
> +			if (state)
> +				st->wfb_trg |= ADE9000_WFB_TRG_ZXVA_BIT;
> +			else
> +				st->wfb_trg &= ~ADE9000_WFB_TRG_ZXVA_BIT;
> +		} else if (chan->type == IIO_CURRENT && dir == IIO_EV_DIR_EITHER) {
> +			bit_mask = ADE9000_ST1_ZXIA_BIT;
> +			if (state)
> +				st->wfb_trg |= ADE9000_WFB_TRG_ZXIA_BIT;
> +			else
> +				st->wfb_trg &= ~ADE9000_WFB_TRG_ZXIA_BIT;
> +		} else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_RISING) {
> +			bit_mask = ADE9000_ST1_SWELLA_BIT;
> +			if (state)
> +				st->wfb_trg |= ADE9000_WFB_TRG_SWELL_BIT;
> +			else
> +				st->wfb_trg &= ~ADE9000_WFB_TRG_SWELL_BIT;
> +		} else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_FALLING) {
> +			bit_mask = ADE9000_ST1_DIPA_BIT;
> +			if (state)
> +				st->wfb_trg |= ADE9000_WFB_TRG_DIP_BIT;
> +			else
> +				st->wfb_trg &= ~ADE9000_WFB_TRG_DIP_BIT;
> +		} else {
> +			dev_err_ratelimited(&indio_dev->dev, "Invalid channel type %d or direction %d for phase A\n",
> +					    chan->type, dir);
> +			return -EINVAL;
> +		}
> +		break;
> +	case ADE9000_PHASE_B_NR:
> +		if (chan->type == IIO_VOLTAGE && dir == IIO_EV_DIR_EITHER) {
> +			bit_mask = ADE9000_ST1_ZXVB_BIT;
> +			if (state)
> +				st->wfb_trg |= ADE9000_WFB_TRG_ZXVB_BIT;
> +			else
> +				st->wfb_trg &= ~ADE9000_WFB_TRG_ZXVB_BIT;
> +		} else if (chan->type == IIO_CURRENT && dir == IIO_EV_DIR_EITHER) {
> +			bit_mask = ADE9000_ST1_ZXIB_BIT;
> +			if (state)
> +				st->wfb_trg |= ADE9000_WFB_TRG_ZXIB_BIT;
> +			else
> +				st->wfb_trg &= ~ADE9000_WFB_TRG_ZXIB_BIT;
> +		} else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_RISING) {
> +			bit_mask = ADE9000_ST1_SWELLB_BIT;
> +			if (state)
> +				st->wfb_trg |= ADE9000_WFB_TRG_SWELL_BIT;
> +			else
> +				st->wfb_trg &= ~ADE9000_WFB_TRG_SWELL_BIT;
> +		} else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_FALLING) {
> +			bit_mask = ADE9000_ST1_DIPB_BIT;
> +			if (state)
> +				st->wfb_trg |= ADE9000_WFB_TRG_DIP_BIT;
> +			else
> +				st->wfb_trg &= ~ADE9000_WFB_TRG_DIP_BIT;
> +		} else {
> +			dev_err_ratelimited(&indio_dev->dev, "Invalid channel type %d or direction %d for phase B\n",
> +					    chan->type, dir);
> +			return -EINVAL;
> +		}
> +		break;
> +	case ADE9000_PHASE_C_NR:
> +		if (chan->type == IIO_VOLTAGE && dir == IIO_EV_DIR_EITHER) {
> +			bit_mask = ADE9000_ST1_ZXVC_BIT;
> +			if (state)
> +				st->wfb_trg |= ADE9000_WFB_TRG_ZXVC_BIT;
> +			else
> +				st->wfb_trg &= ~ADE9000_WFB_TRG_ZXVC_BIT;
> +		} else if (chan->type == IIO_CURRENT && dir == IIO_EV_DIR_EITHER) {
> +			bit_mask = ADE9000_ST1_ZXIC_BIT;
> +			if (state)
> +				st->wfb_trg |= ADE9000_WFB_TRG_ZXIC_BIT;
> +			else
> +				st->wfb_trg &= ~ADE9000_WFB_TRG_ZXIC_BIT;
> +		} else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_RISING) {
> +			bit_mask = ADE9000_ST1_SWELLC_BIT;
> +			if (state)
> +				st->wfb_trg |= ADE9000_WFB_TRG_SWELL_BIT;
> +			else
> +				st->wfb_trg &= ~ADE9000_WFB_TRG_SWELL_BIT;
> +		} else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_FALLING) {
> +			bit_mask = ADE9000_ST1_DIPC_BIT;
> +			if (state)
> +				st->wfb_trg |= ADE9000_WFB_TRG_DIP_BIT;
> +			else
> +				st->wfb_trg &= ~ADE9000_WFB_TRG_DIP_BIT;
> +		} else {
> +			dev_err_ratelimited(&indio_dev->dev, "Invalid channel type %d or direction %d for phase C\n",
> +					    chan->type, dir);
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Set bits if enabling event, clear bits if disabling */
> +	return regmap_assign_bits(st->regmap, ADE9000_REG_MASK1, bit_mask, state ? bit_mask : 0);
> +}


> +static int ade9000_setup(struct ade9000_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	int ret;
> +
> +	ret = regmap_multi_reg_write(st->regmap, ade9000_initialization_sequence,
> +				     ARRAY_SIZE(ade9000_initialization_sequence));
Really trivial and I definitely not worth a respin but does feel like some
abbreviation would have worked here! _init_seq maybe?




