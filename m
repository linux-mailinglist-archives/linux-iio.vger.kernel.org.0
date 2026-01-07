Return-Path: <linux-iio+bounces-27526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2223FCFE926
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 16:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CD3A30019C5
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 15:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090E13491F9;
	Wed,  7 Jan 2026 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGPuL6md"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26385392813
	for <linux-iio@vger.kernel.org>; Wed,  7 Jan 2026 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799723; cv=none; b=HDK27TSp4uGq7ay3L9s0O7dVTwWlVyFPU1oXrU81Ijl+cI85E5Ybk4KYo6KT02wzFPufkSHSdAqp6WI5MPRtQkFDb8wlSX0qfiuGE9CTrFHq+nDj5xnS2ma2gkRdCEl4YH7ADH9ZGGAu+/mV0MaLwk9SZfXY9AYNQUbr1qnhK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799723; c=relaxed/simple;
	bh=mUZ7kfMbkoroVbIoeEWCejtFU9nuCrw7RndVi8OlCbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ghq6OlgFeVuVaizPu2VytcTapv2I/Yl6E4Zk8P/ITgqXyFodteuwuzSywUKPTgii4qYgXm8p+VIq7akqv6I7/tjB9G7sVCQJYtraZRKNUIZvSwoHThzP0nwHWLtaOvf5JkL0FKapwt+vVZjlZoaVnegEapGS7HPVvnC0qKuXHIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGPuL6md; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso10497605e9.1
        for <linux-iio@vger.kernel.org>; Wed, 07 Jan 2026 07:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767799716; x=1768404516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VqRhayTUmyhcODArXKcjmj0UBcZxmD7IfqP56ekElK0=;
        b=UGPuL6mdwXXMZJRVRs4NKLCTwqEkjJZmp7xbygkQswtGPrIyTr8pWgrdO4xfqwhO4E
         7y43GSoyAuB2TSABQSNdUR5L4iScgU6fl5NKySKV7lOIyCfIdLh5/mi1zDFQTOxDcMaj
         Cc5mXj5ODyxoaA/lQGSnbZyvoArW7oBfyCTKfPCEQzeOCVIpTu0P2Xh87Cu4SeskP1g0
         5BKv5LNMoZD2Y145vR2fSMkxPsik3EPj/kyzrrGVKvobrIsDYmEEnjPeBdPmTYLMZf41
         7KhjMKPVLwP9r23ItwEilrjp+yAnqLAanEA+6e3mpYAiWajEZkpV2S1LoNj8U3ANs2wL
         cDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767799716; x=1768404516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqRhayTUmyhcODArXKcjmj0UBcZxmD7IfqP56ekElK0=;
        b=BmY5PKvduzphUCZFFFdwPGgmLvpu13zlVIqaD0uiv61acLPc3hURPN4MgFSBGJF6qK
         XBh8BZN+DEUkh+vfriMMRMZ7cjQdtYXKFzUNK6mkQyZxjzmdujDlqT1XWCAioVWNXZHd
         24aEQ4M0a//a1wV9QytMATvQS70Bp2jangTXa2vHjH4nBX61qPbZY+xN5a15viqzSMv3
         c/+OBbGRKsVuuVHfIbz6eDYsA+yX/P1DNiYOdHG1NAg/qOyxWP6u+Y0UDJJfrDYOrnJc
         XStNqmNLtLjbKOTPt2cygz/qefH8vHHusZp0EO2dyIfnXibJoBCyKbq9vrDwrqgw5yFD
         RlBA==
X-Forwarded-Encrypted: i=1; AJvYcCXtNdJW8Opwh1qBsujxinPZztM5KisQ0ohUmYNzAhyFD/dAPYBxusTfFuxGaB9pHtaMm8nFXcq/ZzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEw6WhmRWjniY+1i69kppx1eY0Bw1G02NqOKQDdHE31+BVIVcR
	F4jaD3CUR1qzzkM/rMNFcUVB2OizQnFPz9LTwlXNytrZYvbgpS9mLIOu
X-Gm-Gg: AY/fxX5t6VKLJLi8D53ZJCbGiJGe9tUw5PXpcKcN+8eAuhMUvjkkwFi40373v5yurhn
	687ruIOjnvVv4p94pHIAhmyBi2yoxxHFS77S0zF0g0PSp11hWrFiM7Jq1E0FtDIOfjyOrTumMYG
	jL21W4bcZ/K3HWfElzr1YDHBMYs1pVbvivaPJx0dSuzHpVGoOI+oP2Ssm8mRO7fsxkCSYJFDGBx
	98Rsi4T2/GDNXSmv3yrythum5W6I/mlGVPzNJ3YhPofAA/QtkPts1HkplMDHtJVax0g2EDZ0jt/
	li3jenLMrfgxUj9J6G4kEmAp2AbnisHgQrn81cKeJaDlqB5tHQbVFK8EXh7r6jr/ACscSmgjn6n
	Il5InVF4daYyUvtTOus/yzDpJYCA4QjuREWAfwdZmEwmax7EQnSeKXLarNWyFC2txfJ2xOP3MP+
	PYAQw0qlI0gHn35eBYYmvItRp4xg==
X-Google-Smtp-Source: AGHT+IFQCEz86nZFe/ZN6aj6TRT9W61fn3p7PqlYbuzvjwXbuJGztbbCFvGYekjehJsKR8Xcz4GdVw==
X-Received: by 2002:a05:600c:470c:b0:475:da13:2568 with SMTP id 5b1f17b1804b1-47d84b39626mr31843425e9.25.1767799715282;
        Wed, 07 Jan 2026 07:28:35 -0800 (PST)
Received: from [172.24.138.145] ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f653cd6sm109017225e9.9.2026.01.07.07.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 07:28:34 -0800 (PST)
Message-ID: <013a144f-101e-49dd-9865-79dd6181f43a@gmail.com>
Date: Wed, 7 Jan 2026 16:28:31 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: dac: Add MAX22007 DAC driver support
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 jan.sun97@gmail.com, gastmaier@gmail.com
References: <20251219-max22007-dev-v1-0-242da2c2b868@analog.com>
 <20251219-max22007-dev-v1-3-242da2c2b868@analog.com>
 <20251219172510.00007208@huawei.com>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <20251219172510.00007208@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

Thank you for your review.

On 12/19/25 18:25, Jonathan Cameron wrote:
> On Fri, 19 Dec 2025 16:31:17 +0100
> Janani Sunil <janani.sunil@analog.com> wrote:
>
>> Add support for the MAX22007 4 channel DAC
>> that drives a voltage or current output on each channel.
> wrap to 75 chars rather than 50-60ish

Noted. Will correct this.

>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> Hi Janani
>
> A few minor things inline.  Also add turning on any required
> power supplies.  See how other drivers do it with a single call
> in in probe. If your board is using always on supplies it will just
> work as a stub regulator will be provided by the regulator core.
>
>
> Thanks,
>
> Jonathan

Will take a reference from the other drivers and add the power supply configurations.

>> diff --git a/drivers/iio/dac/max22007.c b/drivers/iio/dac/max22007.c
>> new file mode 100644
>> index 000000000000..0d57fee27367
>> --- /dev/null
>> +++ b/drivers/iio/dac/max22007.c
>> @@ -0,0 +1,487 @@
>> +
>> +#define MAX22007_NUM_CHANNELS				4
>> +#define MAX22007_REV_ID_REG				0x00
>> +#define MAX22007_STAT_INTR_REG				0x01
>> +#define MAX22007_INTERRUPT_EN_REG			0x02
>> +#define MAX22007_CONFIG_REG				0x03
>> +#define MAX22007_CONTROL_REG				0x04
>> +#define MAX22007_CHANNEL_MODE_REG			0x05
>> +#define MAX22007_SOFT_RESET_REG				0x06
>> +#define MAX22007_DAC_CHANNEL_REG(ch)			(0x07 + (ch))
>> +#define MAX22007_GPIO_CTRL_REG				0x0B
>> +#define MAX22007_GPIO_DATA_REG				0x0C
>> +#define MAX22007_GPI_EDGE_INT_CTRL_REG			0x0D
>> +#define MAX22007_GPI_INT_STATUS_REG			0x0E
>> +
>> +/* Channel mask definitions */
>> +#define     MAX22007_CH_MODE_CH_MASK(channel)		BIT(12 + (channel))
> maybe use x or ch rather than channel to shorten the defines a little.

Right, shall take up the change.

>
>> +#define     MAX22007_CH_PWR_CH_MASK(channel)		BIT(8 + (channel))
>> +#define     MAX22007_DAC_LATCH_MODE_MASK(channel)	BIT(12 + (channel))
>> +#define     MAX22007_LDAC_UPDATE_MASK(channel)		BIT(12 + (channel))
>> +#define     MAX22007_SW_RST_MASK			BIT(8)
>> +#define     MAX22007_SW_CLR_MASK			BIT(12)
>> +#define     MAX22007_SOFT_RESET_BITS_MASK		(MAX22007_SW_RST_MASK | \
>> +	    MAX22007_SW_CLR_MASK)
> Align after (

Right. Shall take up the change.

>
>> +#define     MAX22007_DAC_DATA_MASK			GENMASK(15, 4)
>> +#define     MAX22007_DAC_MAX_RAW			GENMASK(11, 0)
>> +#define     MAX22007_CRC8_POLYNOMIAL			0x8C
>> +#define     MAX22007_CRC_EN_MASK			BIT(0)
>> +#define     MAX22007_RW_MASK				BIT(0)
>> +#define     MAX22007_CRC_OVERHEAD			1
>> +
>> +/* Field value preparation macros with masking */
>> +#define     MAX22007_CH_PWR_VAL(channel, val)	(((val) & 0x1) << (8 + (channel)))
>> +#define     MAX22007_CH_MODE_VAL(channel, val)	(((val) & 0x1) << (12 + (channel)))
>> +#define     MAX22007_DAC_LATCH_MODE_VAL(channel, val)	(((val) & 0x1) << (12 + (channel)))
>> +
>> +static u8 max22007_crc8_table[256];
>> +
>> +enum max22007_channel_mode {
>> +	MAX22007_VOLTAGE_MODE,
>> +	MAX22007_CURRENT_MODE
> Add trailing comma. Not obvious there will never be more if other devices are supported
> by the driver.
>
> I'd also give these explicit values given they are written to HW.
> = 0,
> = 1,

Agreed. Shall take up the change.

>
>> +};
>> +
>> +enum max22007_channel_power {
>> +	MAX22007_CH_POWER_OFF,
>> +	MAX22007_CH_POWER_ON,
> This isn't bringing value over renaming the field mask define
> to MAX22007_CH_PWRON_CH_MASK()
> and using 0 / 1 as appropriate.

Got your point. Shall take this up.

>
>> +};
>> +
>> +struct max22007_state {
>> +	struct spi_device *spi;
>> +	struct regmap *regmap;
>> +	struct iio_chan_spec *iio_chan;
> I'd go with iio_chans just to make it clear there can be multiple.

I shall take this up.

>
>> +	u8 tx_buf[4] __aligned(IIO_DMA_MINALIGN);
>> +	u8 rx_buf[4];
>> +};
>> +
>> +static int max22007_spi_read(void *context, const void *reg, size_t reg_size,
>> +			     void *val, size_t val_size)
>> +{
>> +	struct max22007_state *st = context;
>> +	u8 calculated_crc, received_crc;
>> +	u8 crc_data[3];
>> +	int ret;
>> +	struct spi_transfer xfer = {
>> +		.tx_buf = st->tx_buf,
>> +		.rx_buf = st->rx_buf,
>> +	};
>> +
>> +	xfer.len = reg_size + val_size + MAX22007_CRC_OVERHEAD;
>> +
>> +	memcpy(st->tx_buf, reg, reg_size);
>> +
>> +	ret = spi_sync_transfer(st->spi, &xfer, 1);
>> +	if (ret) {
>> +		dev_err(&st->spi->dev, "SPI transfer failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	crc_data[0] = st->tx_buf[0];
>> +	crc_data[1] = st->rx_buf[1];
>> +	crc_data[2] = st->rx_buf[2]
> The use of only the first byte for tx and later for rx suggest this a
> spi_write_then_read()
>
> Using that should simplify your code a little particularly as it doesn't need
> dma safe buffers (bounces anyway).
>
> I'd be tempted to check reg_size == 1 then hard code that through this function.

You are right. Shall implement this.

>
>> +
>> +	calculated_crc = crc8(max22007_crc8_table, crc_data, 3, 0x00);
>> +	received_crc = st->rx_buf[3];
>> +
>> +	if (calculated_crc != received_crc) {
>> +		dev_err(&st->spi->dev, "CRC mismatch on read register %02x:\n", *(u8 *)reg);
>> +		return -EIO;
>> +	}
>> +
>> +	/* Ignore the dummy byte 0 */
>> +	memcpy(val, &st->rx_buf[1], val_size);
>> +
>> +	return 0;
>> +}
>> +
>> +static int max22007_spi_write(void *context, const void *data, size_t count)
>> +{
>> +	struct max22007_state *st = context;
>> +	struct spi_transfer xfer = {
>> +		.tx_buf = st->tx_buf,
>> +		.rx_buf = st->rx_buf,
>> +	};
>> +
>> +	memset(st->tx_buf, 0, sizeof(st->tx_buf));
>> +
>> +	xfer.len = count + MAX22007_CRC_OVERHEAD;
>> +
>> +	memcpy(st->tx_buf, data, count);
>> +	st->tx_buf[count] = crc8(max22007_crc8_table, st->tx_buf,
>> +				 sizeof(st->tx_buf) - 1, 0x00);
>> +
>> +	return spi_sync_transfer(st->spi, &xfer, 1);
>> +}
>> +static int max22007_write_channel_data(struct max22007_state *state, unsigned int channel,
>> +				       unsigned int data)
>> +{
>> +	unsigned int reg_val;
>> +
>> +	if (data > MAX22007_DAC_MAX_RAW)
>> +		return -EINVAL;
>> +
>> +	reg_val = FIELD_PREP(MAX22007_DAC_DATA_MASK, data);
>> +
>> +	return regmap_write(state->regmap, MAX22007_DAC_CHANNEL_REG(channel), reg_val);
>> +}
>> +
>> +static int max22007_read_channel_data(struct max22007_state *state, unsigned int channel,
> Where it doesn't hurt readability my preference is still to stay nearer to 80 chars.

Noted your point. Shall apply the readability preferences as said.

>
>> +				      int *data)
>> +{
>> +	int ret;
>> +	unsigned int reg_val;
>> +
>> +	ret = regmap_read(state->regmap, MAX22007_DAC_CHANNEL_REG(channel), &reg_val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*data = FIELD_GET(MAX22007_DAC_DATA_MASK, reg_val);
>> +
>> +	return 0;
>> +}
>> +
>> +static int max22007_read_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan,
>> +			     int *val, int *val2, long mask)
>> +{
>> +	struct max22007_state *st = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = max22007_read_channel_data(st, chan->channel, val);
>> +		if (ret)
>> +			return ret;
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		if (chan->type == IIO_VOLTAGE) {
>> +			*val = 5 * 2500;  /* 5 * Vref(2.5V) in mV */
>> +			*val2 = 12;  /* 12-bit DAC resolution (2^12) */
> Given resolution is the same either way, drop that out of the if / else
> 		if (chan->type == IIO_VOLTAGE)
> 			*val = ...
> 		else
> 			*val = ...
> 		val2 = 12; /* 12-bit DAC resolution */
>
> The 2^12 is a bit confusing so I'd drop that bit.

Yes, it can be confusing. I shall drop the redundant explanation.

>
>> +		} else {
>> +			*val = 25;  /* Vref / (2 * Rsense) = 2500mV / 100 */
>> +			*val2 = 12;  /* 12-bit DAC resolution (2^12) */
>> +		}
>> +		return IIO_VAL_FRACTIONAL_LOG2;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>
>> +static const struct iio_chan_spec_ext_info max22007_ext_info[] = {
>> +	{
>> +		.name = "powerdown",
>> +		.read = max22007_read_dac_powerdown,
>> +		.write = max22007_write_dac_powerdown,
>> +		.shared = IIO_SEPARATE,
>> +	},
>> +	{ },
> No trailing comma for a 'terminating' entry like this. We don't want
> to make it easy to add stuff after.

Sure, will remove them.

>> +};
>> +
>> +static const struct iio_chan_spec max22007_channel_template = {
>> +	.output = 1,
>> +	.indexed = 1,
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>> +	.ext_info = max22007_ext_info,
>> +};
>> +
>> +static int max22007_parse_channel_cfg(struct max22007_state *st, u8 *num_channels)
>> +{
>> +	struct device *dev = &st->spi->dev;
>> +	struct iio_chan_spec *iio_chan;
>> +	int ret, num_chan = 0, i = 0;
> Please don't mix declarations that assign with those that don't. It makes
> it to easy to miss which ones are in which category.
> 	int num_chan = 0, i = 0;
> 	int ret;
> Noted on this. I will separate them accordingly.
>> +	u32 reg;
>> +
>> +	num_chan = device_get_child_node_count(dev);
>> +	if (!num_chan)
>> +		return dev_err_probe(dev, -ENODEV, "no channels configured\n");
>> +
>> +	st->iio_chan = devm_kcalloc(dev, num_chan, sizeof(*st->iio_chan), GFP_KERNEL);
>> +	if (!st->iio_chan)
>> +		return -ENOMEM;
>> +
>> +	device_for_each_child_node_scoped(dev, child) {
>> +		const char *channel_type_str;
>> +		enum max22007_channel_mode mode;
>> +
>> +		ret = fwnode_property_read_u32(child, "reg", &reg);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					     "failed to read reg property of %pfwP\n", child);
>> +
>> +		if (reg >= MAX22007_NUM_CHANNELS)
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "reg out of range in %pfwP\n", child);
>> +
>> +		iio_chan = &st->iio_chan[i];
>> +
>> +		*iio_chan = max22007_channel_template;
> The template is only used here so I'd be tempted to just do
> 		*iio_chan = (struct iio_chan_spec) {
> 			.output = 1,
> 			.indexed = 1,
> 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> 					      BIT(IIO_CHAN_INFO_SCALE),
> 			.ext_info = max22007_ext_info,
> 			.channel = reg,
> 		};
> inline here.
> Or after other changes suggested below you can do
>
> 		st->iio_chan[i++] = (struct iio_chan_spec) {
> 			.output = 1,
> 			.indexed = 1,
> 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> 					      BIT(IIO_CHAN_INFO_SCALE),
> 			.ext_info = max22007_ext_info,
> 			.channel = reg,
> 			.type = chan_type,
> 		}

This is a great idea. I will take this up.

>> +		iio_chan->channel = reg;
>> +
>> +		ret = fwnode_property_read_string(child, "adi,type", &channel_type_str);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					     "missing adi,type property for %pfwP\n", child);
>> +
>> +		if (strcmp(channel_type_str, "current") == 0) {
>> +			mode = MAX22007_CURRENT_MODE;
>> +			iio_chan->type = IIO_CURRENT;
>> +		} else if (strcmp(channel_type_str, "voltage") == 0) {
>> +			mode = MAX22007_VOLTAGE_MODE;
>> +			iio_chan->type = IIO_VOLTAGE;
>> +		} else {
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "invalid adi,type '%s' for %pfwP\n",
>> +					     channel_type_str, child);
>> +		}
> If you do this to set a local type variable before the *iio_chan =
> suggestion above, can assign it when filling in the rest of the chan_spec

I will take this up.

>
>> +
>> +		ret = regmap_update_bits(st->regmap, MAX22007_CHANNEL_MODE_REG,
>> +					 MAX22007_CH_MODE_CH_MASK(reg),
>> +					 MAX22007_CH_MODE_VAL(reg, mode));
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* Set DAC to transparent mode (immediate update) */
>> +		ret = regmap_update_bits(st->regmap, MAX22007_CONFIG_REG,
>> +					 MAX22007_DAC_LATCH_MODE_MASK(reg),
>> +					 MAX22007_DAC_LATCH_MODE_VAL(reg, 1));
>> +		if (ret)
>> +			return ret;
>> +
>> +		i++;
> With other changes suggested above, i will only be used in one place I think
> so you can do the ++ inline at that point. See above for details.

Got your point here.

>> +	}
>> +
>> +	*num_channels = num_chan;
>> +
>> +	return 0;
>> +}
>> +
>> +static int max22007_probe(struct spi_device *spi)
>> +{
>> +	struct iio_dev *indio_dev;
>> +	struct max22007_state *state;
>> +	struct gpio_desc *reset_gpio;
>> +	u8 num_channels;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
> Use a local
> 	struct device *dev = &spi->dev;
> to shorten all the places you have &spi->dev currently in this function.

Will implement this.

>
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	state = iio_priv(indio_dev);
>> +	state->spi = spi;
>> +
>> +	crc8_populate_lsb(max22007_crc8_table, MAX22007_CRC8_POLYNOMIAL);
>> +
>> +	state->regmap = devm_regmap_init(&spi->dev, &max22007_regmap_bus, state,
>> +					 &max22007_regmap_config);
>> +	if (IS_ERR(state->regmap))
>> +		return dev_err_probe(&spi->dev, PTR_ERR(state->regmap),
>> +				     "Failed to initialize regmap\n");
>> +
>> +	reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LOW);
> What sets the gpio high? I'd expect a transition from what is requested here
> to what is set in the set_value() below.

It needs to be toggled within the probe. Will add proper implementation for this.

>
>> +	if (IS_ERR(reset_gpio))
>> +		return dev_err_probe(&spi->dev, PTR_ERR(reset_gpio),
>> +				     "Failed to get reset GPIO\n");
>> +
>> +	if (reset_gpio) {
>> +		gpiod_set_value_cansleep(reset_gpio, 0);
>> +	} else {
>> +		ret = regmap_write(state->regmap, MAX22007_SOFT_RESET_REG,
>> +				   MAX22007_SOFT_RESET_BITS_MASK);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	ret = regmap_update_bits(state->regmap, MAX22007_CONFIG_REG,
>> +				 MAX22007_CRC_EN_MASK,
>> +				 MAX22007_CRC_EN_MASK);
> regmap_set_bits() saves repeating the mask.

That's a good point. I will take this up.

>
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = max22007_parse_channel_cfg(state, &num_channels);
>> +	if (ret)
>> +		return ret;
>> +
>> +	indio_dev->info = &max22007_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->channels = state->iio_chan;
>> +	indio_dev->num_channels = num_channels;
>> +	indio_dev->name = "max22007";
>> +
>> +	return devm_iio_device_register(&spi->dev, indio_dev);
>> +}
>

