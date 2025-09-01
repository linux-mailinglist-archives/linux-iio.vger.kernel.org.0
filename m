Return-Path: <linux-iio+bounces-23588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E8BB3EC40
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 18:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B76207ED1
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 16:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD7D30648D;
	Mon,  1 Sep 2025 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrFpFRuf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B64E2D593F;
	Mon,  1 Sep 2025 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744480; cv=none; b=S9czSK9tziuXZZbf9PF0iODd1ZyEgZxYkOx4gdq0X4BO/5VU7aeNXMhCCEAX5H/O7ZYN8ZcLWQJN6xNKvjPFXse+07Wi4f6RXtSK8xCsJpQnMwRMgiAXlGZ0i15Sq3GyiLqJif2M2qXdEMZJ93oYSOOBmpDBBUrYr4QBdaNXlgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744480; c=relaxed/simple;
	bh=HLK5ity3Uglbp3imUuMuBIINdlUiyPESL7xc8wYgcUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMFqRY/sNE8Kufi4imNuzQrWbPQKSZT/2kKZmeL3XDAbUnXPjxwTbLs7nFl13bIEoSX5XP0SoUYaGymMYLkoM18tSv1fwrT2xtLiaHCCridqDwFtefd0VV4nZTSrsjsc0syHfKUG+UNweps0uf0I9EbtWGfxAaVW/4MQKNrS11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrFpFRuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC33CC4CEF0;
	Mon,  1 Sep 2025 16:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756744479;
	bh=HLK5ity3Uglbp3imUuMuBIINdlUiyPESL7xc8wYgcUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IrFpFRufDAK8SGfOJZXtTEq1+ub17xFjQ9VPf2H1+SiTX94dIZ9ARJ0+Cgn/Lo24X
	 GdNT4/LrXCFk46n6AW+EoiRzBCiC+hZnHSQ+/kJIWebAUfzw8wAo5Y8H4bYjsGYMKH
	 1JWK/DummBYdDBFJhlyM9MUa8T59LPqSuHkKmVVapFiLsDGgoepD35Fmlppqn/o48G
	 Ep2GZTSEJP+yQ3zu4vV6WmSxVfJjSIPutegYXRZiZnylziaghf4uKpjgwvGNbZ34wK
	 2ArkACTFlUgraxIGBynZrbIak2DruFlC51bsYO6RMRVEKyKlo1qXf31CSqQV4oSnyH
	 6mt8xQlW2P5nQ==
Date: Mon, 1 Sep 2025 17:34:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 4/6] iio: adc: add ade9000 support
Message-ID: <20250901173431.08e52c78@jic23-huawei>
In-Reply-To: <7b10341d-b5a3-4a37-a2b1-fa7826ea116b@baylibre.com>
References: <20250829115227.47712-1-antoniu.miclaus@analog.com>
	<20250829115227.47712-5-antoniu.miclaus@analog.com>
	<7b10341d-b5a3-4a37-a2b1-fa7826ea116b@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 17:02:04 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/29/25 6:41 AM, Antoniu Miclaus wrote:
> > Add driver support for the ade9000. highly accurate,
> > fully integrated, multiphase energy and power quality
> > monitoring device.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
I took advantage of David not having cropped his review and
added some comments on top. Not I did crop away a bunch of stuff
David wrote that you also need to deal with though!

Jonathan

> > diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> > new file mode 100644
> > index 000000000000..b39023be390c
> > --- /dev/null
> > +++ b/drivers/iio/adc/ade9000.c
> > @@ -0,0 +1,1845 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/**
> > + * ADE9000 driver
> > + *
> > + * Copyright 2025 Analog Devices Inc.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/kfifo_buf.h>
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/sysfs.h>
This header is kind of an ancient bit of legacy we only need
if doing custom attrs (not the nice enum ones)  So assuming
I remember this right you shouldn't need it here.



> > +static irqreturn_t ade9000_irq1_thread(int irq, void *data)
> > +{
> > +	struct iio_dev *indio_dev = data;
> > +	struct ade9000_state *st = iio_priv(indio_dev);
> > +	unsigned int bit = ADE9000_ST1_CROSSING_FIRST;
> > +	s64 timestamp = iio_get_time_ns(indio_dev);
> > +	u32 handled_irq = 0;
> > +	u32 interrupts, result, status, tmp;
> > +	unsigned long interrupt_bits;
> > +	const struct ade9000_irq1_event *event;
> > +	int ret, i;
> > +
> > +	if (!completion_done(&st->reset_completion)) {
> > +		ret = regmap_read(st->regmap, ADE9000_REG_STATUS1, &result);
> > +		if (ret) {
> > +			dev_err(&st->spi->dev, "IRQ1 read status fail\n");
> > +			return IRQ_HANDLED;
> > +		}
> > +
> > +		if (result & ADE9000_ST1_RSTDONE_BIT)
> > +			complete(&st->reset_completion);
> > +		else
> > +			dev_err(&st->spi->dev, "Error testing reset done\n");
> > +  
> 
> We don't need to clear the status here?
> 
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	ret = regmap_read(st->regmap, ADE9000_REG_STATUS1, &status);
> > +	if (ret) {
> > +		dev_err(&st->spi->dev, "IRQ1 read status fail\n");
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	ret = regmap_read(st->regmap, ADE9000_REG_MASK1, &interrupts);
> > +	if (ret) {
> > +		dev_err(&st->spi->dev, "IRQ1 read mask fail\n");
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	interrupt_bits = interrupts;  
> 
> bitmap_from_arr32() would make a bit more sense. Otherwise looks a bit
> like unnecessary copying.
> 
> > +	for_each_set_bit_from(bit, &interrupt_bits,
> > +			      ADE9000_ST1_CROSSING_DEPTH) {
> > +		tmp = status & BIT(bit);
> > +		if (tmp) {

Perhaps here
		if (!tmp)
			continue;

		event = NULL;
etc is worth while to reduce the indent a little.

> > +			event = NULL;
> > +
> > +			/* Find corresponding event in lookup table */
> > +			for (i = 0; i < ARRAY_SIZE(ade9000_irq1_events); i++) {
> > +				if (ade9000_irq1_events[i].bit_mask == tmp) {
> > +					event = &ade9000_irq1_events[i];
> > +					break;
> > +				}
> > +			}
> > +
> > +			if (event) {
> > +				iio_push_event(indio_dev,
> > +					       IIO_UNMOD_EVENT_CODE(event->chan_type,
> > +								    event->channel,
> > +								    event->event_type,
> > +								    event->event_dir),
> > +								    timestamp);
> > +			}
> > +			handled_irq |= tmp;
> > +		}
> > +	}
> > +
> > +	ret = regmap_write(st->regmap, ADE9000_REG_STATUS1, handled_irq);
> > +	if (ret)
> > +		dev_err(&st->spi->dev, "IRQ1 write status fail\n");
> > +  
> 
> Probably should use rate limited version of dev_err() everywhere in this
> function in case there is an "interrupt storm". Applies to all functions
> called by the irq handlers as well.
> 
> > +	return IRQ_HANDLED;
> > +}

> > +
> > +static int ade9000_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int val,
> > +			     int val2,
> > +			     long mask)
> > +{
> > +	struct ade9000_state *st = iio_priv(indio_dev);
> > +	u32 addr, tmp;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_FREQUENCY:
> > +		switch (val) {
> > +		case 50:
> > +			return regmap_write(st->regmap, ADE9000_REG_ACCMODE,
> > +					    ADE9000_ACCMODE);
> > +		case 60:
> > +			return regmap_write(st->regmap, ADE9000_REG_ACCMODE,
> > +					    ADE9000_ACCMODE_60HZ);
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		switch (chan->type) {
> > +		case IIO_CURRENT:
> > +			return regmap_write(st->regmap,
> > +					    ADE9000_ADDR_ADJUST(ADE9000_REG_AIRMSOS,
> > +								chan->channel), val);
> > +		case IIO_VOLTAGE:
> > +		case IIO_ALTVOLTAGE:
> > +			return regmap_write(st->regmap,
> > +					    ADE9000_ADDR_ADJUST(ADE9000_REG_AVRMSOS,
> > +								chan->channel), val);
> > +		case IIO_POWER:
> > +			tmp = chan->address;
> > +			tmp &= ~ADE9000_PHASE_B_POS_BIT;
> > +			tmp &= ~ADE9000_PHASE_C_POS_BIT;
> > +
> > +			switch (tmp) {
> > +			case ADE9000_REG_AWATTOS:
> > +				return regmap_write(st->regmap,
> > +						    ADE9000_ADDR_ADJUST(ADE9000_REG_AWATTOS,
> > +									chan->channel), val);
> > +			case ADE9000_REG_AVAR:
> > +				return regmap_write(st->regmap,
> > +						    ADE9000_ADDR_ADJUST(ADE9000_REG_AVAROS,
> > +									chan->channel), val);
> > +			case ADE9000_REG_AFVAR:
> > +				return regmap_write(st->regmap,
> > +						    ADE9000_ADDR_ADJUST(ADE9000_REG_AFVAROS,
> > +									chan->channel), val);
> > +			default:
> > +				return -EINVAL;
> > +			}
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_CALIBSCALE:
> > +		/*
> > +		 * Calibration gain registers for fine-tuning measurements.
> > +		 * These are separate from PGA gain and applied in the digital domain.
> > +		 */
> > +		switch (chan->type) {
> > +		case IIO_CURRENT:
> > +			return regmap_write(st->regmap,
> > +					    ADE9000_ADDR_ADJUST(ADE9000_REG_AIGAIN,
> > +								chan->channel), val);
> > +		case IIO_VOLTAGE:
> > +			return regmap_write(st->regmap,
> > +					    ADE9000_ADDR_ADJUST(ADE9000_REG_AVGAIN,
> > +								chan->channel), val);
> > +		case IIO_POWER:
> > +			return regmap_write(st->regmap,
> > +					    ADE9000_ADDR_ADJUST(ADE9000_REG_APGAIN,
> > +								chan->channel), val);
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		/* Only shared PGA scale is writable, per-channel scales are read-only */
> > +		if (!(chan->info_mask_shared_by_all))
> > +			return -EINVAL;
> > +
> > +		/*
> > +		 * PGA (Programmable Gain Amplifier) settings affect the analog
> > +		 * input stage scaling, shared by all channels. This is different
> > +		 * from the per-channel calibration gains above.
> > +		 */
> > +		if (val > 4 || val < 1 || val == 3)
This is matching just 1, 2 and 4 I think.  Just check those explicitly as that
will be easier to read.
		if (val != 1 && val != 2 && val != 4)

> > +			return -EINVAL;
> > +		addr = ADE9000_REG_PGA_GAIN;
> > +		/*
> > +		 * PGA gain settings: 1x, 2x, 4x (3x not supported)
> > +		 * Each channel uses 2 bits in PGA_GAIN register:
> > +		 * - Channel 0: bits [9:8]
> > +		 * - Channel 1: bits [11:10]
> > +		 * - Channel 2: bits [13:12]
> > +		 * Convert gain (1,2,4) to register value (0,1,2) using ilog2()
> > +		 */
> > +		val = ilog2(val) << (chan->channel * 2 + 8);
> > +		tmp = GENMASK(1, 0) << (chan->channel * 2 + 8);
> > +		return regmap_update_bits(st->regmap, addr, tmp, val);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}

> > +
> > +static int ade9000_read_event_config(struct iio_dev *indio_dev,
> > +				     const struct iio_chan_spec *chan,
> > +				     enum iio_event_type type,
> > +				     enum iio_event_direction dir)
> > +{
> > +	struct ade9000_state *st = iio_priv(indio_dev);
> > +	u32 interrupts1;
> > +	int ret;
> > +
> > +	/* All events use MASK1 register */
> > +	ret = regmap_read(st->regmap, ADE9000_REG_MASK1, &interrupts1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	switch (chan->channel) {
> > +	case ADE9000_PHASE_A_NR:
> > +		if (chan->type == IIO_VOLTAGE && dir == IIO_EV_DIR_EITHER)
> > +			return !!(interrupts1 & ADE9000_ST1_ZXVA_BIT);
> > +		else if (chan->type == IIO_CURRENT && dir == IIO_EV_DIR_EITHER)
> > +			return !!(interrupts1 & ADE9000_ST1_ZXIA_BIT);
> > +		else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_RISING)
> > +			return !!(interrupts1 & ADE9000_ST1_SWELLA_BIT);
> > +		else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_FALLING)
> > +			return !!(interrupts1 & ADE9000_ST1_DIPA_BIT);
> > +		break;  
> 
> Just return 0; here. Same applies elsewhere.

Getting here is a bug I think. Should call that out with an error print
if so.

> 
> > +	case ADE9000_PHASE_B_NR:
> > +		if (chan->type == IIO_VOLTAGE && dir == IIO_EV_DIR_EITHER)
> > +			return !!(interrupts1 & ADE9000_ST1_ZXVB_BIT);
> > +		else if (chan->type == IIO_CURRENT && dir == IIO_EV_DIR_EITHER)
> > +			return !!(interrupts1 & ADE9000_ST1_ZXIB_BIT);
> > +		else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_RISING)
> > +			return !!(interrupts1 & ADE9000_ST1_SWELLB_BIT);
> > +		else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_FALLING)
> > +			return !!(interrupts1 & ADE9000_ST1_DIPB_BIT);

likewise

> > +		break;
> > +	case ADE9000_PHASE_C_NR:
> > +		if (chan->type == IIO_VOLTAGE && dir == IIO_EV_DIR_EITHER)
> > +			return !!(interrupts1 & ADE9000_ST1_ZXVC_BIT);
> > +		else if (chan->type == IIO_CURRENT && dir == IIO_EV_DIR_EITHER)
> > +			return !!(interrupts1 & ADE9000_ST1_ZXIC_BIT);
> > +		else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_RISING)
> > +			return !!(interrupts1 & ADE9000_ST1_SWELLC_BIT);
> > +		else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_FALLING)
> > +			return !!(interrupts1 & ADE9000_ST1_DIPC_BIT);

and here as well.

> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ade9000_write_event_config(struct iio_dev *indio_dev,
> > +				      const struct iio_chan_spec *chan,
> > +				      enum iio_event_type type,
> > +				      enum iio_event_direction dir,
> > +				      bool state)
> > +{
> > +	struct ade9000_state *st = iio_priv(indio_dev);
> > +	u32 bit_mask = 0;

With the suggested elses below this should always be written before use.

> > +	int ret;
> > +
> > +	/* Clear all pending events in STATUS1 register (write 1 to clear) */
> > +	ret = regmap_write(st->regmap, ADE9000_REG_STATUS1, GENMASK(31, 0));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Determine which interrupt bit to enable/disable */
> > +	switch (chan->channel) {
> > +	case ADE9000_PHASE_A_NR:
> > +		if (chan->type == IIO_VOLTAGE && dir == IIO_EV_DIR_EITHER) {
> > +			bit_mask = ADE9000_ST1_ZXVA_BIT;
> > +			if (state)
> > +				st->wfb_trg |= ADE9000_WFB_TRG_ZXVA_BIT;
> > +			else
> > +				st->wfb_trg &= ~ADE9000_WFB_TRG_ZXVA_BIT;
> > +		} else if (chan->type == IIO_CURRENT && dir == IIO_EV_DIR_EITHER) {
> > +			bit_mask = ADE9000_ST1_ZXIA_BIT;
> > +			if (state)
> > +				st->wfb_trg |= ADE9000_WFB_TRG_ZXIA_BIT;
> > +			else
> > +				st->wfb_trg &= ~ADE9000_WFB_TRG_ZXIA_BIT;
> > +		} else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_RISING) {
> > +			bit_mask = ADE9000_ST1_SWELLA_BIT;
> > +			if (state)
> > +				st->wfb_trg |= ADE9000_WFB_TRG_SWELL_BIT;
> > +			else
> > +				st->wfb_trg &= ~ADE9000_WFB_TRG_SWELL_BIT;
> > +		} else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_FALLING) {
> > +			bit_mask = ADE9000_ST1_DIPA_BIT;
> > +			if (state)
> > +				st->wfb_trg |= ADE9000_WFB_TRG_DIP_BIT;
> > +			else
> > +				st->wfb_trg &= ~ADE9000_WFB_TRG_DIP_BIT;
> > +		}

I'm guessing we should get here?  If so perhaps
		return dev_err(...) is appropriate here?

> > +		break;
> > +	case ADE9000_PHASE_B_NR:
> > +		if (chan->type == IIO_VOLTAGE && dir == IIO_EV_DIR_EITHER) {
> > +			bit_mask = ADE9000_ST1_ZXVB_BIT;
> > +			if (state)
> > +				st->wfb_trg |= ADE9000_WFB_TRG_ZXVB_BIT;
> > +			else
> > +				st->wfb_trg &= ~ADE9000_WFB_TRG_ZXVB_BIT;
> > +		} else if (chan->type == IIO_CURRENT && dir == IIO_EV_DIR_EITHER) {
> > +			bit_mask = ADE9000_ST1_ZXIB_BIT;
> > +			if (state)
> > +				st->wfb_trg |= ADE9000_WFB_TRG_ZXIB_BIT;
> > +			else
> > +				st->wfb_trg &= ~ADE9000_WFB_TRG_ZXIB_BIT;
> > +		} else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_RISING) {
> > +			bit_mask = ADE9000_ST1_SWELLB_BIT;
> > +			if (state)
> > +				st->wfb_trg |= ADE9000_WFB_TRG_SWELL_BIT;
> > +			else
> > +				st->wfb_trg &= ~ADE9000_WFB_TRG_SWELL_BIT;
> > +		} else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_FALLING) {
> > +			bit_mask = ADE9000_ST1_DIPB_BIT;
> > +			if (state)
> > +				st->wfb_trg |= ADE9000_WFB_TRG_DIP_BIT;
> > +			else
> > +				st->wfb_trg &= ~ADE9000_WFB_TRG_DIP_BIT;
> > +		}

similar here, I'd add what happens if none of the above match.

> > +		break;
> > +	case ADE9000_PHASE_C_NR:
> > +		if (chan->type == IIO_VOLTAGE && dir == IIO_EV_DIR_EITHER) {
> > +			bit_mask = ADE9000_ST1_ZXVC_BIT;
> > +			if (state)
> > +				st->wfb_trg |= ADE9000_WFB_TRG_ZXVC_BIT;
> > +			else
> > +				st->wfb_trg &= ~ADE9000_WFB_TRG_ZXVC_BIT;
> > +		} else if (chan->type == IIO_CURRENT && dir == IIO_EV_DIR_EITHER) {
> > +			bit_mask = ADE9000_ST1_ZXIC_BIT;
> > +			if (state)
> > +				st->wfb_trg |= ADE9000_WFB_TRG_ZXIC_BIT;
> > +			else
> > +				st->wfb_trg &= ~ADE9000_WFB_TRG_ZXIC_BIT;
> > +		} else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_RISING) {
> > +			bit_mask = ADE9000_ST1_SWELLC_BIT;
> > +			if (state)
> > +				st->wfb_trg |= ADE9000_WFB_TRG_SWELL_BIT;
> > +			else
> > +				st->wfb_trg &= ~ADE9000_WFB_TRG_SWELL_BIT;
> > +		} else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_FALLING) {
> > +			bit_mask = ADE9000_ST1_DIPC_BIT;
> > +			if (state)
> > +				st->wfb_trg |= ADE9000_WFB_TRG_DIP_BIT;
> > +			else
> > +				st->wfb_trg &= ~ADE9000_WFB_TRG_DIP_BIT;
> > +		}

Same here. If it's all going wrong just exit with an error.

> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!bit_mask)
> > +		return -EINVAL;

With above I think this test is not needed.

> > +
> > +	return regmap_assign_bits(st->regmap, ADE9000_REG_MASK1, bit_mask, state ? bit_mask : 0);

That last parameter looks fishy fir a boolean. Perhaps a comment or state && bit_mask
which think does the same thing. 

> > +}

> > +
> > +static int ade9000_waveform_buffer_config(struct iio_dev *indio_dev)
> > +{
> > +	struct ade9000_state *st = iio_priv(indio_dev);
> > +	u32 wfb_cfg_val = 0;

Set in all paths where it's used, so don't initialise it here.

> > +	u32 active_scans;
> > +
> > +	bitmap_to_arr32(&active_scans, indio_dev->active_scan_mask,
> > +			indio_dev->masklength);
> > +
> > +	switch (active_scans) {
> > +	case ADE9000_SCAN_POS_IA | ADE9000_SCAN_POS_VA:
> > +		wfb_cfg_val = ADE9000_WFB_CFG_IA_VA;
> > +		st->wfb_nr_activ_chan = 2;
> > +		break;
> > +	case ADE9000_SCAN_POS_IB | ADE9000_SCAN_POS_VB:
> > +		wfb_cfg_val = ADE9000_WFB_CFG_IB_VB;
> > +		st->wfb_nr_activ_chan = 2;
> > +		break;
> > +	case ADE9000_SCAN_POS_IC | ADE9000_SCAN_POS_VC:
> > +		wfb_cfg_val = ADE9000_WFB_CFG_IC_VC;
> > +		st->wfb_nr_activ_chan = 2;
> > +		break;
> > +	case ADE9000_SCAN_POS_IA:
> > +		wfb_cfg_val = ADE9000_WFB_CFG_IA;
> > +		st->wfb_nr_activ_chan = 1;
> > +		break;
> > +	case ADE9000_SCAN_POS_VA:
> > +		wfb_cfg_val = ADE9000_WFB_CFG_VA;
> > +		st->wfb_nr_activ_chan = 1;
> > +		break;
> > +	case ADE9000_SCAN_POS_IB:
> > +		wfb_cfg_val = ADE9000_WFB_CFG_IB;
> > +		st->wfb_nr_activ_chan = 1;
> > +		break;
> > +	case ADE9000_SCAN_POS_VB:
> > +		wfb_cfg_val = ADE9000_WFB_CFG_VB;
> > +		st->wfb_nr_activ_chan = 1;
> > +		break;
> > +	case ADE9000_SCAN_POS_IC:
> > +		wfb_cfg_val = ADE9000_WFB_CFG_IC;
> > +		st->wfb_nr_activ_chan = 1;
> > +		break;
> > +	case ADE9000_SCAN_POS_VC:
> > +		wfb_cfg_val = ADE9000_WFB_CFG_VC;
> > +		st->wfb_nr_activ_chan = 1;
> > +		break;
> > +	case (ADE9000_SCAN_POS_IA | ADE9000_SCAN_POS_VA | ADE9000_SCAN_POS_IB |
> > +	      ADE9000_SCAN_POS_VB | ADE9000_SCAN_POS_IC | ADE9000_SCAN_POS_VC):
> > +		wfb_cfg_val = ADE9000_WFB_CFG_ALL_CHAN;
> > +		st->wfb_nr_activ_chan = 6;
> > +		break;
> > +	default:
> > +		dev_err(&st->spi->dev, "Unsupported combination of scans\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	wfb_cfg_val |= FIELD_PREP(ADE9000_WF_SRC_MASK, st->wf_src);
> > +
> > +	return regmap_write(st->regmap, ADE9000_REG_WFB_CFG, wfb_cfg_val);
> > +}

> > +static int ade9000_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +	struct ade9000_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = ade9000_waveform_buffer_config(indio_dev);  
> 
> Should this be .validate_scan_mask callback instead of calling it here?

That wouldn't normally do any actual register writes so I'm not seeing
how it is a good fit for this call.  It might make sense to provide
an available_scan_masks array to rule out configs that aren't supported
(and let the core demux deal with it).


> 
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->wfb_nr_samples = ADE9000_WFB_MAX_SAMPLES_CHAN * st->wfb_nr_activ_chan;
> > +
> > +	ade9000_configure_scan(indio_dev, ADE9000_REG_WF_BUFF);
> > +
> > +	ret = ade9000_waveform_buffer_interrupt_setup(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_set_bits(st->regmap, ADE9000_REG_WFB_CFG,
> > +			      ADE9000_WF_CAP_EN_MASK);
> > +	if (ret) {
> > +		dev_err(&st->spi->dev, "Post-enable waveform buffer enable fail\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}

