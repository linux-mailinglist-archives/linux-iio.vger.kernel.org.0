Return-Path: <linux-iio+bounces-23226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36628B3423B
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 15:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DF42A117E
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 13:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767992EFDB5;
	Mon, 25 Aug 2025 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YW5/XWFv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F3F2EFDB8;
	Mon, 25 Aug 2025 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129703; cv=none; b=pC3qDIoSoAgk0m6dSFTY4KDQsowzcnG36ty5P2F05xJ3s8u7Ddjrs30pXAwLJ5/30hwoTv7s194WblAGwlMN45cwE9HTdAJZdvLjkqeOwXNTcUISGNadzoM2rcK2fCF8NedYNsJqLcUHwaJrChscS/3zeShPQsDX4s9rAczIiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129703; c=relaxed/simple;
	bh=lxwgkl+A94pkDY8Q4p9vL4gV4koeKGK9ks3G1berbq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0totOq7iBfHcOdVA0KGyvJPnlsvfTR8M/F1RJ64QgP/Sy37bt4qBWJmSyPZ0kJnoFE59y9t4rEYZawIuc4qgiHe/4KbPLd4fEJ/W0AWcJWwNOVXHwpdj+OzL0brFNSxwbmEgOqyzoDizlN89CA8ZBGfcnppg/DqtxqAPxPMCeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YW5/XWFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D95AC4CEED;
	Mon, 25 Aug 2025 13:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756129702;
	bh=lxwgkl+A94pkDY8Q4p9vL4gV4koeKGK9ks3G1berbq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YW5/XWFv7TjKNkdzqBj6QTPqalAhRJntbPQExdYkj2VpMSIYUizp+xrgAEYeQdIfW
	 34Fsu/nAS2YNfWTJWH/BrelSm3EkmEEXgjbOjFpIwX6Ymr8aRhRslbzL60LSm1jYTW
	 tbosxITKx+K36578enyweAtzCqWPeinr6Hhon+JjTRMqItcBSiz7kSRKpi0T+ianGe
	 mCFhJcXycmXiIijRLKHS7CRQ857zBRaxtr24zQFPEpegw09A7SUZ5Y4bKpm77K5Ewj
	 brYAKOOuiZ6GgPaROWCklellCjTUY/86j7t9Hs97SxiUOglwQ/0EN05bhlg2fbeO2d
	 /gaXRbOsXxW1g==
Date: Mon, 25 Aug 2025 14:48:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 4/6] iio: adc: add ade9000 support
Message-ID: <20250825144815.6cfeee2d@jic23-huawei>
In-Reply-To: <20250822160157.5092-5-antoniu.miclaus@analog.com>
References: <20250822160157.5092-1-antoniu.miclaus@analog.com>
	<20250822160157.5092-5-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 16:01:53 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add driver support for the ade9000. highly accurate,
> fully integrated, multiphase energy and power quality
> monitoring device.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Various comments inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> new file mode 100644
> index 000000000000..41f766e00de0
> --- /dev/null
> +++ b/drivers/iio/adc/ade9000.c
> @@ -0,0 +1,2011 @@

> +/* Peak and overcurrent detection disabled */
> +#define ADE9000_CONFIG3			0x0000
> +
> +/*
> + * 50Hz operation, 3P4W Wye configuration, signed accumulation

No idea what a 3P4W Wye configuration is...
Spell that out.

> + * Clear bit 8 i.e. ACCMODE=0x00xx for 50Hz operation
> + * ACCMODE=0x0x9x for 3Wire delta when phase B is used as reference
> + */
>

> +
> +static const struct iio_event_spec ade9000_events[] = {
> +	{
> +		/* Energy ready event - datasheet: EGYRDY interrupt */

I'll address these alongside the docs.

> +		.type = IIO_EV_TYPE_MAG,
> +		.dir = IIO_EV_DIR_NONE, /* Non-directional event */
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		/* Sequence error event - datasheet: SEQERR interrupt */
> +		.type = IIO_EV_TYPE_CHANGE,
> +		.dir = IIO_EV_DIR_NONE, /* Non-directional event */
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		/* Threshold events - datasheet: zero crossing timeout, sag/swell */
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_NONE, /* Timeout events (ZXTOUT register) */
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE), /* Per-channel enable */
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE), /* Shared threshold value */
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING, /* for swell */
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING, /* for dip */
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
> +	},
> +};

> +#define ADE9000_POWER_ACTIVE_CHANNEL(num) {				\
> +	.type = IIO_POWER,						\
> +	.channel = num,							\
> +	.address = ADE9000_ADDR_ADJUST(ADE9000_REG_AWATT, num),		\
> +	.channel2 = IIO_MOD_ACTIVE,					\
> +	.modified = 1,							\
> +	.indexed = 1,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_CALIBBIAS) |		\
> +			      BIT(IIO_CHAN_INFO_CALIBSCALE) |		\
> +			      BIT(IIO_CHAN_INFO_POWERFACTOR),		\

You have power factor documented as in_power0_powerfactor which is not what
this will generate.  Check the ABI docs vs what the driver generates
closely.

> +	.scan_index = -1						\
> +}



> +static int ade9000_spi_write_reg(void *context, unsigned int reg,
> +				 unsigned int val)
> +{
> +	struct ade9000_state *st = context;
> +	u16 addr;
> +	int ret, len;
> +
> +	guard(mutex)(&st->lock);
> +
> +	addr = FIELD_PREP(ADE9000_REG_ADDR_MASK, reg);
> +	put_unaligned_be16(addr, st->tx);
> +
> +	if (reg > ADE9000_REG_RUN && reg < ADE9000_REG_VERSION) {
> +		put_unaligned_be16(val, &st->tx[2]);
> +		len = 4;
> +	} else {
> +		put_unaligned_be32(val, &st->tx[2]);
> +		len = 6;
> +	}
> +
> +	ret = spi_write(st->spi, st->tx, len);

See below. I'd make this spi_write_then_read() and use local variables + a read
size of 0.

> +	if (ret)
> +		dev_err(&st->spi->dev, "problem when writing register 0x%x\n", reg);
> +
> +	return ret;
> +}
> +
> +static int ade9000_spi_read_reg(void *context, unsigned int reg,
> +				unsigned int *val)
> +{
> +	struct ade9000_state *st = context;
> +	u16 addr;
> +	int ret, rx_len;
> +
> +	guard(mutex)(&st->lock);
> +
> +	addr = FIELD_PREP(ADE9000_REG_ADDR_MASK, reg) |
> +	       ADE9000_REG_READ_BIT_MASK;
> +
> +	put_unaligned_be16(addr, st->tx);
> +
> +	/* Skip CRC bytes - only read actual data */
> +	if (reg > ADE9000_REG_RUN && reg < ADE9000_REG_VERSION)
> +		rx_len = 2;
> +	else
> +		rx_len = 4;
> +
> +	ret = spi_write_then_read(st->spi, st->tx, 2, st->rx, rx_len);

Using write then read doesn't need to use a DMA safe buffer (it is documented
as always bouncing the data) so you could use variables on the stack to
keep the data local for read_reg.
Could also use write_then_read with a zero size read to allow the same
in *spi_write_reg()


> +	if (ret) {
> +		dev_err(&st->spi->dev, "error reading register 0x%x\n", reg);
> +		return ret;
> +	}
> +
> +	if (reg > ADE9000_REG_RUN && reg < ADE9000_REG_VERSION)
> +		*val = get_unaligned_be16(st->rx);
> +	else
> +		*val = get_unaligned_be32(st->rx);
> +
> +	return 0;
> +}

> +
> +static int ade9000_configure_scan(struct iio_dev *indio_dev, u32 wfb_addr)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	u16 addr;
> +
> +	addr = FIELD_PREP(ADE9000_REG_ADDR_MASK, wfb_addr) |
> +	       ADE9000_REG_READ_BIT_MASK;
> +
> +	put_unaligned_be16(addr, st->tx_buff);
> +
> +	st->xfer[0].tx_buf = &st->tx_buff[0];
> +	st->xfer[0].len = 2;
> +
> +	st->xfer[1].rx_buf = st->rx_buff.byte;
> +
> +	/* Always use streaming mode */
> +	st->xfer[1].len = (st->wfb_nr_samples / 2) * 4;
> +
> +	spi_message_init_with_transfers(&st->spi_msg, st->xfer, ARRAY_SIZE(st->xfer));
> +	return 0;

Never fails, return type of void to make that clear.

> +}



> +static irqreturn_t ade9000_irq1_thread(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	unsigned int bit = ADE9000_ST1_CROSSING_FIRST;
> +	s64 timestamp = iio_get_time_ns(indio_dev);
> +	u32 handled_irq = 0;
> +	u32 interrupts;

	u32 interrupts, result, status, tmp;

> +	u32 result;
> +	u32 status;
> +	u32 tmp;
> +	unsigned long interrupt_bits;
> +	int ret;
> +
> +	if (!completion_done(&st->reset_completion)) {
> +		ret = regmap_read(st->regmap, ADE9000_REG_STATUS1, &result);
> +		if (ret) {
> +			dev_err(&st->spi->dev, "IRQ1 read status fail\n");
> +			return ret;

Don't return errno in an irq thread handler.  They aren't irqreturn_t

> +		}
> +
> +		if (result & ADE9000_ST1_RSTDONE_BIT)
> +			complete(&st->reset_completion);
> +		else
> +			dev_err(&st->spi->dev, "Error testing reset done\n");
> +
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = regmap_read(st->regmap, ADE9000_REG_STATUS1, &status);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "IRQ1 read status fail\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = regmap_read(st->regmap, ADE9000_REG_MASK1, &interrupts);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "IRQ1 read status fail\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	interrupt_bits = interrupts;
> +	for_each_set_bit_from(bit, &interrupt_bits,
> +			      ADE9000_ST1_CROSSING_DEPTH){
> +		tmp = status & BIT(bit);
> +
> +		switch (tmp) {
> +		case ADE9000_ST1_ZXVA_BIT:

There are a lot of these, maybe a lookup table with event code and field
in handled_irq?  Use a marker like no event code to indicate the bits
we don't handle.

> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXVA_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXVA_BIT;

These are all the same as handled_irq |= tmp; ?
maybe can take that out of the switch statement? 

If you do a lookup table on bit, that will end up even nicer.


> +			break;
> +		case ADE9000_ST1_ZXTOVA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXTOVA_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXTOVA_BIT;
> +			break;
> +		case ADE9000_ST1_ZXIA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_CURRENT,
> +							    ADE9000_ST1_ZXIA_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXIA_BIT;
> +			break;
> +		case ADE9000_ST1_ZXVB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXVB_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXVB_BIT;
> +			break;
> +		case ADE9000_ST1_ZXTOVB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXTOVB_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXTOVB_BIT;
> +			break;
> +		case ADE9000_ST1_ZXIB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_CURRENT,
> +							    ADE9000_ST1_ZXIB_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXIB_BIT;
> +			break;
> +		case ADE9000_ST1_ZXVC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXVC_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXVC_BIT;
> +			break;
> +		case ADE9000_ST1_ZXTOVC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXTOVC_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXTOVC_BIT;
> +			break;
> +		case ADE9000_ST1_ZXIC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_CURRENT,
> +							    ADE9000_ST1_ZXIC_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXIC_BIT;
> +			break;
> +		case ADE9000_ST1_SWELLA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_SWELLA_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_RISING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_SWELLA_BIT;
> +			break;
> +		case ADE9000_ST1_SWELLB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_SWELLB_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_RISING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_SWELLB_BIT;
> +			break;
> +		case ADE9000_ST1_SWELLC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_SWELLC_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_RISING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_SWELLC_BIT;
> +			break;
> +		case ADE9000_ST1_DIPA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_DIPA_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_FALLING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_DIPA_BIT;
> +			break;
> +		case ADE9000_ST1_DIPB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_DIPB_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_FALLING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_DIPB_BIT;
> +			break;
> +		case ADE9000_ST1_DIPC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_DIPC_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_FALLING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_DIPC_BIT;
> +			break;
> +		case ADE9000_ST1_SEQERR_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_SEQERR_BIT >> 12,
> +							    IIO_EV_TYPE_CHANGE,
> +							    IIO_EV_DIR_NONE),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_SEQERR_BIT;
> +			break;
> +		default:
> +			return IRQ_HANDLED;
> +		}
> +	}
> +
> +	ret = regmap_write(st->regmap, ADE9000_REG_STATUS1, handled_irq);
> +	if (ret)
> +		return ret;
> +
> +	return IRQ_HANDLED;
> +}

> +
> +static int ade9000_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val,
> +			    int *val2,
> +			    long mask)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	unsigned int reg, measured;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		if (chan->type == IIO_VOLTAGE) {
> +			int period_reg;
> +			int period;
> +
> +			switch (chan->channel) {
> +			case ADE9000_PHASE_A_NR:
> +				period_reg = ADE9000_REG_APERIOD;
> +				break;
> +			case ADE9000_PHASE_B_NR:
> +				period_reg = ADE9000_REG_BPERIOD;
> +				break;
> +			case ADE9000_PHASE_C_NR:
> +				period_reg = ADE9000_REG_CPERIOD;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +			ret = regmap_read(st->regmap, period_reg, &period);
> +			if (ret)
> +				return ret;
> +			*val = 4000 * 65536;

Why this particular multiplier?  Maybe a spec reference.

> +			*val2 = period + 1;
> +			return IIO_VAL_FRACTIONAL;
> +		}
> +
> +		ret = regmap_read(st->regmap, ADE9000_REG_ACCMODE, &reg);
> +		if (ret)
> +			return ret;
> +		*val = (reg & ADE9000_ACCMODE_60HZ) ? 60 : 50;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type == IIO_ENERGY) {
> +			u16 lo_reg = chan->address;
> +
> +			ret = regmap_bulk_read(st->regmap, lo_reg,
> +					       st->bulk_read_buf, 2);
> +			if (ret)
> +				return ret;
> +
> +			*val = st->bulk_read_buf[0];  /* Lower 32 bits */
> +			*val2 = st->bulk_read_buf[1]; /* Upper 32 bits */
> +			return IIO_VAL_INT_64;
> +		}
> +
> +		ret = iio_device_claim_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read(st->regmap, chan->address, &measured);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		*val = measured;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_POWERFACTOR:
> +		ret = iio_device_claim_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		/* Map power channel to corresponding power factor register */
> +		reg = ADE9000_ADDR_ADJUST(ADE9000_REG_APF, chan->channel);
> +		ret = regmap_read(st->regmap, reg, &measured);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		*val = measured;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->info_mask_shared_by_all) {
> +			/* Shared PGA gain read - only for channel with shared frequency */
> +			ret = regmap_read(st->regmap, ADE9000_REG_PGA_GAIN, &reg);
> +			if (ret)
> +				return ret;
> +			*val = min(1 << ((reg >> (8 + chan->channel)) & GENMASK(1, 0)), 4);
> +			return IIO_VAL_INT;

return, so no need for else to follow.

same for later else ifs 

> +		} else if (chan->type == IIO_CURRENT || chan->type == IIO_VOLTAGE ||
> +			   chan->type == IIO_ALTVOLTAGE) {
> +			switch (chan->address) {
> +			case ADE9000_REG_AI_PCF:
> +			case ADE9000_REG_AV_PCF:
> +			case ADE9000_REG_BI_PCF:
> +			case ADE9000_REG_BV_PCF:
> +			case ADE9000_REG_CI_PCF:
> +			case ADE9000_REG_CV_PCF:
> +				*val = 1;
> +				*val2 = ADE9000_PCF_FULL_SCALE_CODES;
> +				return IIO_VAL_FRACTIONAL;
> +			case ADE9000_REG_AIRMS:
> +			case ADE9000_REG_AVRMS:
> +			case ADE9000_REG_BIRMS:
> +			case ADE9000_REG_BVRMS:
> +			case ADE9000_REG_CIRMS:
> +			case ADE9000_REG_CVRMS:
> +				*val = 1;
> +				*val2 = ADE9000_RMS_FULL_SCALE_CODES;
> +				return IIO_VAL_FRACTIONAL;
> +			default:
> +				return -EINVAL;
> +			}
> +		} else if (chan->type == IIO_POWER) {
> +			*val = 1;
> +			*val2 = ADE9000_WATT_FULL_SCALE_CODES;
> +			return IIO_VAL_FRACTIONAL;
> +		} else {
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ade9000_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val,
> +			     int val2,
> +			     long mask)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	u32 addr;
> +	u32 tmp;	

	u32 addr, tmp;
saves us a line for no lost of readability.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_FREQUENCY:

> +}

> +static int ade9000_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	u32 interrupts0, interrupts1, number;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADE9000_REG_MASK0, &interrupts0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, ADE9000_REG_MASK1, &interrupts1);
> +	if (ret)
> +		return ret;
> +
> +	if (type == IIO_EV_TYPE_MAG)
> +		return interrupts0 & ADE9000_ST0_EGYRDY;

Might as well do that before reading interrupts1.  Save a bit of bus traffic
without complicating the code.  Even better, only read interrupts0 at all
if type == IIO_EV_TYPE_MAG.


> +
> +	if (type == IIO_EV_TYPE_CHANGE)
> +		return interrupts1 & ADE9000_ST1_SEQERR_BIT;
> +
> +	number = chan->channel;
> +
> +	switch (number) {
> +	case ADE9000_PHASE_A_NR:
> +		if (chan->type == IIO_VOLTAGE) {
> +			if (dir == IIO_EV_DIR_EITHER)
> +				return interrupts1 & ADE9000_ST1_ZXVA_BIT;
> +			if (dir == IIO_EV_DIR_NONE)
> +				return interrupts1 & ADE9000_ST1_ZXTOVA_BIT;
> +			if (dir == IIO_EV_DIR_RISING)
> +				return interrupts1 & ADE9000_ST1_SWELLA_BIT;
> +			if (dir == IIO_EV_DIR_FALLING)
> +				return interrupts1 & ADE9000_ST1_DIPA_BIT;
> +		} else if (chan->type == IIO_CURRENT) {
> +			return interrupts1 & ADE9000_ST1_ZXIA_BIT;
> +		}
> +		break;
> +	case ADE9000_PHASE_B_NR:
> +		if (chan->type == IIO_VOLTAGE) {
> +			if (dir == IIO_EV_DIR_EITHER)
> +				return interrupts1 & ADE9000_ST1_ZXVB_BIT;
> +			if (dir == IIO_EV_DIR_NONE)
> +				return interrupts1 & ADE9000_ST1_ZXTOVB_BIT;
> +			if (dir == IIO_EV_DIR_RISING)
> +				return interrupts1 & ADE9000_ST1_SWELLB_BIT;
> +			if (dir == IIO_EV_DIR_FALLING)
> +				return interrupts1 & ADE9000_ST1_DIPB_BIT;
> +		} else if (chan->type == IIO_CURRENT) {
> +			return interrupts1 & ADE9000_ST1_ZXIB_BIT;
> +		}
> +		break;
> +	case ADE9000_PHASE_C_NR:
> +		if (chan->type == IIO_VOLTAGE) {
> +			if (dir == IIO_EV_DIR_EITHER)
> +				return interrupts1 & ADE9000_ST1_ZXVC_BIT;
> +			if (dir == IIO_EV_DIR_NONE)
> +				return interrupts1 & ADE9000_ST1_ZXTOVC_BIT;
> +			if (dir == IIO_EV_DIR_RISING)
> +				return interrupts1 & ADE9000_ST1_SWELLC_BIT;
> +			if (dir == IIO_EV_DIR_FALLING)
> +				return interrupts1 & ADE9000_ST1_DIPC_BIT;
> +		} else if (chan->type == IIO_CURRENT) {
> +			return interrupts1 & ADE9000_ST1_ZXIC_BIT;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ade9000_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      bool state)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	u32 interrupts, tmp;
> +	int ret;
> +
> +	/* Clear all pending events in STATUS1 register (write 1 to clear) */
> +	ret = regmap_write(st->regmap, ADE9000_REG_STATUS1, GENMASK(31, 0));
> +	if (ret)
> +		return ret;
> +
> +	if (type == IIO_EV_TYPE_MAG) {
> +		ret = regmap_update_bits(st->regmap, ADE9000_REG_STATUS0,
> +					 ADE9000_ST0_EGYRDY, ADE9000_ST0_EGYRDY);

regmap_set_bits() exists for this case.

> +		if (ret)
> +			return ret;
> +		return regmap_update_bits(st->regmap, ADE9000_REG_MASK0,
> +					 ADE9000_ST0_EGYRDY,

MASK and field don't seem to match even wrt to which register they are in.

Having fixed that regmap_assign_bits() probably useufl here.

> +					 state ? ADE9000_ST1_SEQERR_BIT : 0);
> +	}
> +
> +	if (type == IIO_EV_TYPE_CHANGE)
> +		return regmap_update_bits(st->regmap, ADE9000_REG_MASK1,
> +					 ADE9000_ST1_SEQERR_BIT,
> +					 state ? ADE9000_ST1_SEQERR_BIT : 0);

		return regmap_assign_bits(st->regmap, ADE9000_REG_MASK1,
					  ADE9000_ST1_SEQERR_BIT, state);
is a little simpler and avoids chance of register / field mismatch like above.


> +
> +	if (dir == IIO_EV_DIR_EITHER) {
> +		static const struct {
> +			u32 irq;
> +			u32 wfb_trg;
> +		} trig_arr[6] = {
> +			{
> +				.irq = ADE9000_ST1_ZXVA_BIT,
> +				.wfb_trg = ADE9000_WFB_TRG_ZXVA_BIT
> +			}, {
> +				.irq = ADE9000_ST1_ZXIA_BIT,
> +				.wfb_trg = ADE9000_WFB_TRG_ZXIA_BIT
> +			}, {
> +				.irq = ADE9000_ST1_ZXVB_BIT,
> +				.wfb_trg = ADE9000_WFB_TRG_ZXVB_BIT
> +			}, {
> +				.irq = ADE9000_ST1_ZXIB_BIT,
> +				.wfb_trg = ADE9000_WFB_TRG_ZXIB_BIT
> +			}, {
> +				.irq = ADE9000_ST1_ZXVC_BIT,
> +				.wfb_trg = ADE9000_WFB_TRG_ZXVC_BIT
> +			}, {
> +				.irq = ADE9000_ST1_ZXIC_BIT,
> +				.wfb_trg = ADE9000_WFB_TRG_ZXIC_BIT
> +			},
> +		};
> +		if (state) {
> +			interrupts |= trig_arr[chan->channel * 2 + chan->type].irq;
> +			st->wfb_trg |= trig_arr[chan->channel * 2 + chan->type].wfb_trg;
> +		} else {
> +			interrupts &= ~trig_arr[chan->channel * 2 + chan->type].irq;
> +			st->wfb_trg &= ~trig_arr[chan->channel * 2 + chan->type].wfb_trg;
> +		}
> +	}
> +
> +	if (dir == IIO_EV_DIR_NONE) {
> +		switch (chan->channel) {
> +		case ADE9000_PHASE_A_NR:
> +			tmp |= ADE9000_ST1_ZXTOVA_BIT;
> +			break;
> +		case ADE9000_PHASE_B_NR:
> +			tmp |= ADE9000_ST1_ZXTOVB_BIT;
> +			break;
> +		case ADE9000_PHASE_C_NR:
> +			tmp |= ADE9000_ST1_ZXTOVC_BIT;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (state)
> +			interrupts |= tmp;
> +		else
> +			interrupts &= ~tmp;
> +	} else if (dir == IIO_EV_DIR_RISING) {
> +		switch (chan->channel) {
> +		case ADE9000_PHASE_A_NR:
> +			tmp |= ADE9000_ST1_SWELLA_BIT;
> +			break;
> +		case ADE9000_PHASE_B_NR:
> +			tmp |= ADE9000_ST1_SWELLB_BIT;
> +			break;
> +		case ADE9000_PHASE_C_NR:
> +			tmp |= ADE9000_ST1_SWELLC_BIT;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (state) {
> +			interrupts |= tmp;
> +			st->wfb_trg |= ADE9000_WFB_TRG_SWELL_BIT;
> +		} else {
> +			interrupts &= ~tmp;
> +			st->wfb_trg &= ~ADE9000_WFB_TRG_SWELL_BIT;
> +		}
> +	} else if (dir == IIO_EV_DIR_FALLING) {
> +		switch (chan->channel) {
> +		case ADE9000_PHASE_A_NR:
> +			tmp |= ADE9000_ST1_DIPA_BIT;
> +			break;
> +		case ADE9000_PHASE_B_NR:
> +			tmp |= ADE9000_ST1_DIPB_BIT;
> +			break;
> +		case ADE9000_PHASE_C_NR:
> +			tmp |= ADE9000_ST1_DIPC_BIT;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (state) {
> +			interrupts |= tmp;
> +			st->wfb_trg |= ADE9000_WFB_TRG_DIP_BIT;
> +		} else {
> +			interrupts &= ~tmp;
> +			st->wfb_trg &= ~ADE9000_WFB_TRG_DIP_BIT;
> +		}
> +	}
> +
> +	return regmap_update_bits(st->regmap, ADE9000_REG_MASK1, interrupts,
> +				  interrupts);

	return regmap_set_bits()

check the rest of the driver for places where these clear/set/assign
regmap functions can simplifiy things.

> +}


> +static int ade9000_reset(struct ade9000_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct gpio_desc *gpio_reset;
> +	int ret;
> +
> +	gpio_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpio_reset))
> +		return PTR_ERR(gpio_reset);
> +
> +	if (gpio_reset) {
> +		fsleep(10);
> +		gpiod_set_value_cansleep(gpio_reset, 0);
> +		fsleep(50000);
> +	} else {
> +		ret = regmap_update_bits(st->regmap, ADE9000_REG_CONFIG1,
> +					 ADE9000_SWRST_BIT, ADE9000_SWRST_BIT);
> +		if (ret)
> +			return ret;
> +		fsleep(90);
> +		return 0;

This code structure is more complex than it needs to be.  There is no sharing
of the code that follows between the if / else so either drag that
into the if (gpio_reset) branch and return early or flip the logic and
do the if (!gpio_reset) first allowing the fsleep(10) gpio_set_value_cansleep()
etc to be indented less.  That is

	if (gpio_reset) {
		fsleep(10);
		gpiod_set_value_cansleep(gpio_reset, 0);
		fsleep(50000);
		if (!wait_for_completion_timeout(&st->reset_completion,
						 msecs_to_jiffies(1000))) {
			dev_err(dev, "Reset timeout after 1s\n");
			return -ETIMEDOUT;
		}

		return 0;
	}

	ret = regmap_update_bits(st->regmap, ADE9000_REG_CONFIG1,
				 ADE9000_SWRST_BIT, ADE9000_SWRST_BIT);
	if (ret)
		return ret;
	fsleep(90);

	return 0;


Or the other way around.
> +	}
> +
> +	if (!wait_for_completion_timeout(&st->reset_completion,
> +					 msecs_to_jiffies(1000))) {
> +		dev_err(dev, "Reset timeout after 1s\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}

