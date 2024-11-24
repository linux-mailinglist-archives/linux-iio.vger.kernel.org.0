Return-Path: <linux-iio+bounces-12565-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 081779D6EBA
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 13:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604E0B23538
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7211DF252;
	Sun, 24 Nov 2024 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELlan5s6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C0B1DEFC0;
	Sun, 24 Nov 2024 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452134; cv=none; b=mv/e8uUKDIdEgnkGoM2isO7oIo5Ybsj5eE7Me74oBqz1mbtqGW2Rm2zUsucavRHB/aPeXZLluX/2quEes8ir5du2ZOuNqAgsHPJVhsuSqlwp0zmirTJPOcWwewnwtPP8YmZfWZrDO/REKO9XgRSLTIGBoa3o9tYiUiypGACSeCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452134; c=relaxed/simple;
	bh=ekU+BPUrI7OLAlOfwZ0pMnZPmRN+Eax7TRxcTQkwIC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8OpjeUSWEcjpf7lCTSUPQ5eAYOirQVvLsdznTezsepQAHpgfKOxrgwzNy4mGlCdX7DIGXd6LOcvsKuTx0CHouk4ZLzegvZI1gMEvXooQ49Ojk6dH79cwG/jcCVRXKrNOByoOGgNiLnVeyyc7GEj/oY3Ydz+JoO2SOBqg6qRAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELlan5s6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A35C4CECC;
	Sun, 24 Nov 2024 12:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452133;
	bh=ekU+BPUrI7OLAlOfwZ0pMnZPmRN+Eax7TRxcTQkwIC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ELlan5s6QL2QuzVG3iKrEnkPd9pRgoJAw2Q2b88XiMgTHWZHvWJ2rBTbBZEAo6cQI
	 gHUadkxEjWKP4IBOabSEvBxYdKmf0UnY22hu4EG54gCf7HxeIx5WATjTO8OevInen/
	 h6vzzzCsTPiWCrp3EeHROUmWcoqO+f0RuhaT+2w9ykGInwoQUuD8aVpNOk6istv3WC
	 54KFb1VOq262KhhKYZVoqnzRztrWAUdG7AdFgXyWPI0Tn9VCCVlAA7w1WN4Ha/fpKV
	 A5XK3IgDT9z/n2un0mSw3l4sufX72lB5aOyfA/prRB13fIivhg4ji9V/cxQ3fa5057
	 XlU5WWjGzCNcg==
Date: Sun, 24 Nov 2024 12:42:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tobias Sperling via B4 Relay
 <devnull+tobias.sperling.softing.com@kernel.org>
Cc: tobias.sperling@softing.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: Add driver for ADS7128 / ADS7138
Message-ID: <20241124124205.02453a0c@jic23-huawei>
In-Reply-To: <20241122-adc_ml-v1-2-0769f2e1bbc1@softing.com>
References: <20241122-adc_ml-v1-0-0769f2e1bbc1@softing.com>
	<20241122-adc_ml-v1-2-0769f2e1bbc1@softing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 16:15:37 +0100
Tobias Sperling via B4 Relay <devnull+tobias.sperling.softing.com@kernel.org> wrote:

> From: Tobias Sperling <tobias.sperling@softing.com>
> 
> Add driver for ADS7128 and ADS7138 12-bit, 8-channel analog-to-digital
> converters. These ADCs have a wide operating range and a wide feature
> set. Communication is based on the I2C interface.
> 
> Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
Hi Tobias,

Various comments inline.  Some of the style ones apply in more locations
than I have highlighted so make sure to look for similar improvement opportunities
throughout the driver.

Thanks,

Jonathan


> diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..3ac76625bc6334965c78ba7938895236ee4edece
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads7138.c
> @@ -0,0 +1,796 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * ADS7138 - Texas Instruments Analog-to-Digital Converter
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
After other suggested changes inline you shouldn't need this include.

> +#include <linux/iio/types.h>
> +
> +#define MODULE_NAME "ads71x8"
Even inside the driver avoid wild cards.  Just pick a part number that is supported
for all naming.  Wild cards have gone wrong far too many times in the past as
manufacturers love to break 'obvious' number sequences with something different in
the middle.

> +
> +/* AVDD (VREF) operating range in millivolts */
> +#define ADS71x8_AVDD_MV_MIN		2350
> +#define ADS71x8_AVDD_MV_MAX		5500
> +
> +/*
> + * Always assume 16 bits resolution as HW registers are aligned like that and
> + * with enabled oversampling/averaging it actually corresponds to 16 bits.
> + */
> +#define ADS71x8_RES_BITS		16
> +
> +/* ADS71x8 operation codes */
> +#define ADS71x8_OPCODE_SET_BIT		0x18
> +#define ADS71x8_OPCODE_CLEAR_BIT	0x20
> +#define ADS71x8_OPCODE_BLOCK_WRITE	0x28
> +#define ADS71x8_OPCODE_BLOCK_READ	0x30
> +
> +/* ADS71x8 registers */
> +#define ADS71x8_REG_GENERAL_CFG		0x01
> +#define ADS71x8_REG_OSR_CFG		0x03
> +#define ADS71x8_REG_OPMODE_CFG		0x04
> +#define ADS71x8_REG_SEQUENCE_CFG	0x10
> +#define ADS71x8_REG_AUTO_SEQ_CH_SEL	0x12
> +#define ADS71x8_REG_ALERT_CH_SEL	0x14
> +#define ADS71x8_REG_EVENT_FLAG		0x18
> +#define ADS71x8_REG_EVENT_HIGH_FLAG	0x1A
> +#define ADS71x8_REG_EVENT_LOW_FLAG	0x1C
> +#define ADS71x8_REG_HIGH_TH_HYS_CH(x)	((x) * 4 + 0x20)
> +#define ADS71x8_REG_LOW_TH_CNT_CH(x)	((x) * 4 + 0x22)
> +#define ADS71x8_REG_MAX_LSB_CH(x)	((x) * 2 + 0x60)
> +#define ADS71x8_REG_MIN_LSB_CH(x)	((x) * 2 + 0x80)
> +#define ADS71x8_REG_RECENT_LSB_CH(x)	((x) * 2 + 0xA0)
> +
> +#define ADS71x8_GENERAL_CFG_RST		BIT(0)
> +#define ADS71x8_GENERAL_CFG_DWC_EN	BIT(4)
> +#define ADS71x8_GENERAL_CFG_STATS_EN	BIT(5)
> +#define ADS71x8_OSR_CFG_MASK		GENMASK(2, 0)
> +#define ADS71x8_OPMODE_CFG_CONV_MODE	BIT(5)
> +#define ADS71x8_OPMODE_CFG_FREQ_MASK	GENMASK(4, 0)
> +#define ADS71x8_SEQUENCE_CFG_SEQ_MODE	BIT(0)
> +#define ADS71x8_SEQUENCE_CFG_SEQ_START	BIT(4)
> +#define ADS71x8_THRESHOLD_LSB_MASK	GENMASK(7, 4)
> +
> +enum ads71x8_modes {
> +	ADS71x8_MODE_MANUAL,
> +	ADS71x8_MODE_AUTO,
> +};
> +
> +enum ads71x8_stats {
> +	ADS71x8_STATS_MIN,
> +	ADS71x8_STATS_MAX,
> +};
> +
> +enum ads71x8_chips { ads7128, ads7138 };
As below, use structures of information not an enum to deal with
chip differences. It ends up much more flexible and extensible
as drivers get more complex. Also avoids an issue with 0 being
an error value when getting data from some firmware table types.

> +
> +struct ads71x8_data {
> +	struct mutex lock;

Locks always need a comment to say what data they are protecting.

> +	struct i2c_client *client;
> +	struct regulator *vref_regu;
> +};
> +
> +struct ads71x8_freq_bits {
> +	u32 hz;
> +	u8 bits;
> +};
> +
> +static const struct ads71x8_freq_bits ads71x8_samp_freq[] = {
> +	{163, 0x1F}, {244, 0x1E}, {326, 0x1D}, {488, 0x1C}, {651, 0x1B},
> +	{977, 0x1A}, {1302, 0x19}, {1953, 0x18}, {2604, 0x17}, {3906, 0x16},
> +	{5208, 0x15}, {7813, 0x14}, {10417, 0x13}, {15625, 0x12}, {20833, 0x11},
> +	{31250, 0x10}, {41667, 0x09}, {62500, 0x08}, {83333, 0x07},
> +	{125000, 0x06}, {166667, 0x05}, {250000, 0x04}, {333333, 0x03},
> +	{500000, 0x02}, {666667, 0x01}, {1000000, 0x0}
Format this as something like.
	{ 163, 0x1F }, { 244, 0x1E }, { 326, 0x1D }, { 488, 0x1C },
	{ 651, 0x1B }, { 977, 0x1A }, { 1302, 0x19 }, { 1953, 0x18 },

So with more spaces and with a power of 2 entries on each line to make it easy
for people to work out the matching.

Once you use read_avail as requested below, you may well just want to use
the index of the array for the second field and have a simple array of value
assuming no holes that I'm missing.




> +};
> +
> +static int ads71x8_i2c_write_block(const struct i2c_client *client, u8 reg,
> +	u8 *values, u8 length)
Align after ( 

> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct ads71x8_data *data = iio_priv(indio_dev);
> +	int ret;
> +	struct i2c_msg msgs[] = {
> +		{
> +			.addr = client->addr,
> +			.flags = 0,
> +			.len = length + 2, /* "+ 2" for OPCODE and reg */
> +		},
> +	};
> +
> +	msgs[0].buf = kmalloc(msgs[0].len, GFP_KERNEL);

Use a local variable for this and then
	u8 *buf __free(kfree) = malloc(msg[0].len, GFP_KERNEL);
	if (!buf)
		return -ENOMEM;

	msgs[0].buf = ...
and you can drop the kfree below.

	
> +	if (!msgs[0].buf)
> +		return -ENOMEM;
> +
> +	msgs[0].buf[0] = ADS71x8_OPCODE_BLOCK_WRITE;
> +	msgs[0].buf[1] = reg;
> +	memcpy(&msgs[0].buf[2], values, length);
> +
> +	mutex_lock(&data->lock);
> +	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +	mutex_unlock(&data->lock);
> +	kfree(msgs[0].buf);
> +
As below, put 
	if (ret < 0)
		return ret;
	if (ret == ARRAY_SIZE(msgs))
		return -EIO;

	return 0;
in here to end up with a simpler to use function.

> +	return ret;
> +}
> +
> +static int ads71x8_i2c_write(const struct i2c_client *client, u8 reg, u8 value)
> +{
> +	return ads71x8_i2c_write_block(client, reg, &value, sizeof(value));
> +}
> +
> +static int ads71x8_i2c_setclear_bit(const struct i2c_client *client, u8 reg,
> +	u8 bits, u8 opcode)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct ads71x8_data *data = iio_priv(indio_dev);
> +	int ret;
> +	u8 buf[3] = {opcode, reg, bits};
	u8 buf[3] = { opcode, reg, bits };

There are no hard rules on this formatting in the kernel, but this
is the style I'm trying to standardise on for IIO.

> +	struct i2c_msg msgs[] = {
> +		{
> +			.addr = client->addr,
> +			.flags = 0,

flags being zero is kind of the 'obvious' choice.

> +			.len = ARRAY_SIZE(buf),
> +			.buf = buf,
> +		},
> +	};
Why not i2c_master_send()?

> +
	guard(mutex)(&data->lock);
	return i2c_transfer(...)

However, what is the lock protecting here?  The bus lock should be
enough unless there is a rmw cycle elsewhere.

> +	mutex_lock(&data->lock);
> +	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static int ads71x8_i2c_set_bit(const struct i2c_client *client, u8 reg, u8 bits)
> +{
> +	return ads71x8_i2c_setclear_bit(client, reg, bits,
> +		ADS71x8_OPCODE_SET_BIT);
Align with just after (
Same in all other cases. I've just pointed out a few that stood out.

> +}
> +
> +static int ads71x8_i2c_clear_bit(const struct i2c_client *client, u8 reg, u8 bits)
> +{
> +	return ads71x8_i2c_setclear_bit(client, reg, bits,
> +		ADS71x8_OPCODE_CLEAR_BIT);
> +}
> +
> +static int ads71x8_i2c_read_block(const struct i2c_client *client, u8 reg,
> +	u8 *out_values, u8 length)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct ads71x8_data *data = iio_priv(indio_dev);
> +	int ret;
> +	u8 buf[2] = {ADS71x8_OPCODE_BLOCK_READ, reg};

{ ADS ...

> +	struct i2c_msg msgs[] = {
> +		{
> +			.addr = client->addr,
> +			.flags = 0,

No need to set 'obvious' default of 0.

> +			.len = ARRAY_SIZE(buf),
> +			.buf = buf,
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +			.len = length,
> +			.buf = out_values,
> +		},
> +	};
> +
> +	mutex_lock(&data->lock);

guard(mutex)... As then can just return.  However I would prefer you
deal with the transfer size return here and check it matches expected.

> +	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static int ads71x8_i2c_read(const struct i2c_client *client, u8 reg)
> +{
> +	u8 value;
> +	int ret;
> +
> +	ret = ads71x8_i2c_read_block(client, reg, &value, sizeof(value));
> +	if (ret < 0)
> +		return ret;
> +	return value;
> +}
> +
> +static const struct ads71x8_freq_bits *get_closest_freq(int freq)
> +{
> +	const int idx_max = ARRAY_SIZE(ads71x8_samp_freq) - 1;
> +	u32 cur, best = ads71x8_samp_freq[idx_max].hz;
> +	int i;
> +
> +	freq = clamp_val(freq, ads71x8_samp_freq[0].hz,
> +		ads71x8_samp_freq[idx_max].hz);
> +
> +	for (i = 0; i <= idx_max; i++) {
> +		cur = abs(ads71x8_samp_freq[i].hz - freq);
> +		if (cur > best)
> +			return &ads71x8_samp_freq[i-1];

spaces around - 
checkpatch should have gotten that one, so make sure you run
it before posting along with sparse.

> +		best = cur;
> +	}
> +	return &ads71x8_samp_freq[idx_max];
> +}
> +
> +static u32 get_closest_log2(u32 val)
> +{
> +	u32 down = ilog2(val);
> +	u32 up = ilog2(roundup_pow_of_two(val));
> +
> +	return (val - (1 << down) < (1 << up) - val) ? down : up;

Concept closest is a little vague when on a log scale.
At very least name this local to this file as it is not really
as general as it sounds.

Generally I'd be more cynical. Provide the available values and
make chosing a userspace problem.  Reject anything not
provided by read_avail()


> +}
> +
> +static int ads71x8_read_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
> +{
> +	struct ads71x8_data *data = iio_priv(indio_dev);
> +	int i, ret, vref;
> +	u8 values[2];
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ads71x8_i2c_read_block(data->client,
> +			ADS71x8_REG_RECENT_LSB_CH(chan->channel), values,
> +			ARRAY_SIZE(values));
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ((values[1] << 8) | values[0]);

get_unaligned_le16()
or read into an __le16 and you can used le16_to_cpu()


> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = ads71x8_i2c_read(data->client, ADS71x8_REG_OPMODE_CFG);
> +		if (ret < 0)
> +			return ret;
> +
> +		for (i = 0; i < ARRAY_SIZE(ads71x8_samp_freq); i++) {
> +			if (ads71x8_samp_freq[i].bits ==
> +					(ret & ADS71x8_OPMODE_CFG_FREQ_MASK)) {
FIELD_GET()
Even though it is I guess the lowest bits. I'd like as a reviewer
to not care what bits it is whilst reading this code. FIELD_GET()
gives that.

> +				*val = ads71x8_samp_freq[i].hz;
> +				return IIO_VAL_INT;
> +			}
> +		}
> +
> +		ret = -EINVAL;
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (data->vref_regu) {
> +			vref = regulator_get_voltage(data->vref_regu);
> +			if (vref < 0)
> +				return vref;
> +			*val = vref / 1000;
> +		} else {
> +			*val = ADS71x8_AVDD_MV_MIN;
> +		}
> +		*val2 = ADS71x8_RES_BITS;
> +		ret = IIO_VAL_FRACTIONAL_LOG2;
> +		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = ads71x8_i2c_read(data->client, ADS71x8_REG_OSR_CFG);
> +		if (ret < 0)
> +			return ret;
> +		*val = (1 << (ret & ADS71x8_OSR_CFG_MASK));
> +		ret = IIO_VAL_INT;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ads71x8_write_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int val, int val2, long mask)
> +{
> +	struct ads71x8_data *data = iio_priv(indio_dev);
> +	const struct ads71x8_freq_bits *freq = NULL;
> +	int ret;
> +	u8 osr_val;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:

This is a read modify write cycle with no locking.
It can race against another access and end up with a rather unexpected state.

> +		freq = get_closest_freq(val);
> +		ret = ads71x8_i2c_read(data->client, ADS71x8_REG_OPMODE_CFG);
> +		if (ret < 0)
> +			return ret;
> +		ret = ads71x8_i2c_write(data->client, ADS71x8_REG_OPMODE_CFG,
> +			(ret & ~ADS71x8_OPMODE_CFG_FREQ_MASK) |
> +			(freq->bits & ADS71x8_OPMODE_CFG_FREQ_MASK));
FIELD_PREP() 
> +		ret = (ret > 0) ? 0 : ret;
Another case where just handling the errors nicely in the i2c_write
wrapper will make the code easier to read.


> +		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		/* Number of samples can only be a power of 2 */
> +		osr_val = get_closest_log2(clamp_val(val, 1, 128));
> +		ret = ads71x8_i2c_write(data->client, ADS71x8_REG_OSR_CFG,
> +			osr_val);
> +		ret = (ret > 0) ? 0 : ret;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t ads71x8_read_stats(struct iio_dev *indio_dev, uintptr_t priv,
> +	const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct ads71x8_data *data = iio_priv(indio_dev);
> +	int ret;
> +	u8 values[2];
> +
> +	switch (priv) {
> +	case ADS71x8_STATS_MIN:
> +		ret = ads71x8_i2c_read_block(data->client,
> +			ADS71x8_REG_MIN_LSB_CH(chan->channel), values,
> +			ARRAY_SIZE(values));
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	case ADS71x8_STATS_MAX:
> +		ret = ads71x8_i2c_read_block(data->client,
> +			ADS71x8_REG_MAX_LSB_CH(chan->channel), values,
> +			ARRAY_SIZE(values));
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return sprintf(buf, "%d\n", ((values[1] << 8) | values[0]));

I've no ideas what this is, so needs docs.
That last bit is a get_unaligned_le16() though so use that to make it
explicit what is going on.


> +}
> +
> +static int ads71x8_read_event(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, enum iio_event_type type,
> +	enum iio_event_direction dir, enum iio_event_info info, int *val,
> +	int *val2)
> +{
> +	int ret;
> +	u8 reg, values[2];
> +	struct ads71x8_data *data = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		reg = (dir == IIO_EV_DIR_RISING) ?
> +			ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel) :
> +			ADS71x8_REG_LOW_TH_CNT_CH(chan->channel);
> +		ret = ads71x8_i2c_read_block(data->client, reg, values,
> +			ARRAY_SIZE(values));
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ((values[1] << 4) | (values[0] >> 4));
> +		ret = IIO_VAL_INT;
Early returns in all cases, otherwise this looks fine.

> +		break;
> +	case IIO_EV_INFO_HYSTERESIS:
> +		ret = ads71x8_i2c_read(data->client,
> +			ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel));
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = (ret & ~ADS71x8_THRESHOLD_LSB_MASK);
> +		ret = IIO_VAL_INT;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ads71x8_write_event(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, enum iio_event_type type,
> +	enum iio_event_direction dir, enum iio_event_info info, int val,
> +	int val2)
> +{
> +	struct ads71x8_data *data = iio_priv(indio_dev);
> +	int ret;
> +	u8 reg, values[2];
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (val >= BIT(12) || val < 0) {
> +			ret = -EINVAL;
return -EINVAL;

> +			break;
> +		}
> +		reg = (dir == IIO_EV_DIR_RISING) ?
> +			ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel) :
> +			ADS71x8_REG_LOW_TH_CNT_CH(chan->channel);
> +
> +		ret = ads71x8_i2c_read(data->client, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		values[0] = (((val & 0x0F) << 4) |

Use a GENMASK and FIELD_PREP() to make this easier to read.

> +			(ret & ~ADS71x8_THRESHOLD_LSB_MASK));
> +		values[1] = (val >> 4);
> +		ret = ads71x8_i2c_write_block(data->client, reg, values,
> +			ARRAY_SIZE(values));
> +		ret = (ret > 0) ? 0 : ret;
		easier to make ads71x8_i2c_write_block() return 0 or negative
		error.

> +		break;
> +	case IIO_EV_INFO_HYSTERESIS:
> +		if (val >= BIT(4) || val < 0) {
> +			ret = -EINVAL;
return -EINVAL;

> +			break;
> +		}
> +		reg = ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel);
> +		ret = ads71x8_i2c_read(data->client, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = ads71x8_i2c_write(data->client, reg,
> +			((ret & ADS71x8_THRESHOLD_LSB_MASK) |
> +			(val & ~ADS71x8_THRESHOLD_LSB_MASK)));
> +		ret = (ret > 0) ? 0 : ret;

As above, just put the error check in i2c_write so the
greater than 0 thing maps to a stanard 0 success.

> +		break;
> +	default:
> +		ret = -EINVAL;
return -EINVAL;
> +		break;
> +	}
Should never get here as always returned above.
> +
> +	return ret;
> +}
> +
> +static int ads71x8_read_event_config(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, enum iio_event_type type,
> +	enum iio_event_direction dir)
> +{
> +	struct ads71x8_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_EITHER:
> +		ret = ads71x8_i2c_read(data->client, ADS71x8_REG_ALERT_CH_SEL);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = (ret & BIT(chan->channel)) ? 1 : 0;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
Similar to below return early to simplify this and use a check on the dir
to reduce indent of the rest by returning even earlier.
> +}
> +
> +static int ads71x8_write_event_config(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, enum iio_event_type type,
> +	enum iio_event_direction dir, int state)
> +{
> +	struct ads71x8_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_EITHER:
I would reduce the indent by
	if (dir != IIO_EV_DIR_EITHER)
		return -EINVAL;

	if (state)...

> +		if (state)
> +			ret = ads71x8_i2c_set_bit(data->client,
> +				ADS71x8_REG_ALERT_CH_SEL, BIT(chan->channel));
			return ...
> +		else
> +			ret = ads71x8_i2c_clear_bit(data->client,
> +				ADS71x8_REG_ALERT_CH_SEL, BIT(chan->channel));
			return ...
> +		break;
> +	default:
> +		ret = -EINVAL;
		return -EINVAL;
> +		break;
> +	}
> +
and drop this.
> +	return ret;
> +}
> +
> +static ssize_t ads71x8_show_samp_freq_avail(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	int i;
> +	ssize_t len = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(ads71x8_samp_freq); i++)
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> +			ads71x8_samp_freq[i].hz);

It's a static list so with read_avail() as below you can just provide
an array with all the values in it.

> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(ads71x8_show_samp_freq_avail);
> +
> +static struct attribute *ads71x8_attributes[] = {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL,
No comma on null terminators.

Prefer if this can be done with read_avail() and appropriate bitmap.
Old drivers tend to do it with explicit attributes as we didn't
have that infrastructure, but for modern code better to do it
with a callback as then we can use it for consumers within the
kernel which is sometimes useful.

> +};
> +
> +static const struct attribute_group ads71x8_attribute_group = {
> +	.attrs = ads71x8_attributes,
> +};
> +
> +static const struct iio_info ti_ads71x8_info = {
> +	.attrs = &ads71x8_attribute_group,
> +	.read_raw = &ads71x8_read_raw,
> +	.write_raw = &ads71x8_write_raw,
> +	.read_event_value = &ads71x8_read_event,
> +	.write_event_value = &ads71x8_write_event,
> +	.read_event_config = &ads71x8_read_event_config,
> +	.write_event_config = &ads71x8_write_event_config,
Definitely worth thinking about whether the device can be used to
some degree at least without interrupts.  It is annoyingly common
for board designers to not wire them.

If it is easy to support (without events) from the start that
is a nice to have. If more complex we can leave it until we know
of actual hardware.

> +};
> +
> +static const struct iio_event_spec ads71x8_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE)
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static const struct iio_chan_spec_ext_info ads71x8_ext_info[] = {
> +	{"stats_min", IIO_SEPARATE, ads71x8_read_stats, NULL, ADS71x8_STATS_MIN},
> +	{"stats_max", IIO_SEPARATE, ads71x8_read_stats, NULL, ADS71x8_STATS_MAX},
> +	{},
	{ "stats_min", ...
	{ }

No comma for terminating entries as we don't want it to be easy to add more
after them.

However, the fields in this structure are non obvious, so
	{
		.name = "stats_min",
etc
preferred.

This is custom ABI, so I'd expect to see a file under Documentation/ABI/testing/sysfs-bus-iio-*
that explains what these are.

Adding custom ABI however is a hard thing, so provide plenty of information
to see if these are justified or not.
Superficially they sound like debugfs things rather than suitable for sysfs.

> +};

> +
> +static irqreturn_t ads71x8_event_handler(int irq, void *priv)
> +{
> +	struct iio_dev *indio_dev = priv;
> +	struct ads71x8_data *data = iio_priv(indio_dev);
> +	int ret;
> +	u8 i, events_high, events_low;
> +	u64 code;

Pick an order for declarations.  If no reason for anything else, reverse
xmas tree looks fine.

> +
> +	/* Check if interrupt was trigger by us */
> +	ret = ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_FLAG);
> +	if (ret <= 0)
> +		return IRQ_NONE;
> +
> +	ret = ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_HIGH_FLAG);
> +	events_high = ret;
Check ret before setting event_high.  It's meaningless if ret is negative.
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_LOW_FLAG);
> +	events_low = ret;
as above.
> +	if (ret < 0)
> +		goto out;
> +
> +	for (i = 0; i < 8; i++) {

Why 8? Can we base that on some defines or similar?

> +		if (events_high & BIT(i)) {
> +			code = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
> +				IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING);
> +			iio_push_event(indio_dev, code,
> +				iio_get_time_ns(indio_dev));
> +		}
> +		if (events_low & BIT(i)) {
> +			code = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
> +				IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING);
> +			iio_push_event(indio_dev, code,
> +				iio_get_time_ns(indio_dev));
> +		}
> +	}
> +
> +	/* Clear all interrupt flags */
> +	ads71x8_i2c_write(data->client, ADS71x8_REG_EVENT_HIGH_FLAG, 0xFF);

Always check for errors - even if all we can do is print a warning.

> +	ads71x8_i2c_write(data->client, ADS71x8_REG_EVENT_LOW_FLAG, 0xFF);
> +
> +out:
> +	if (ret < 0)
> +		dev_warn(&data->client->dev,
> +			"Couldn't handle interrupt correctly: %d\n", ret);
Do this in each path so can provide a specific error message rather than
a shared one + return early if error as then nothing to do down here.

> +	return IRQ_HANDLED;
> +}

> +
> +static int ads7138_init_hw(struct ads71x8_data *data)
> +{
> +	int ret = 0;
Always set, so don't init here.

> +
> +	data->vref_regu = devm_regulator_get(&data->client->dev, "avdd");
> +	if (IS_ERR(data->vref_regu))
> +		data->vref_regu = NULL;
What is intent here? If you don't have a regulator you'll get a stub
which isn't an error. If you get an error for another reason, something
is very wrong, so error out. I may just be a deferral though so you
may end up successfully probing later.

> +
> +	/* Reset the chip to get a defined starting configuration */
> +	ret = ads71x8_i2c_set_bit(data->client, ADS71x8_REG_GENERAL_CFG,
> +		ADS71x8_GENERAL_CFG_RST);
Align with d after (
Do this everwhere it doesn't hurt readability.   It is fine to do a shorter
wrap in cases where line length gets silly but otherwise kernel style is
to align after (

> +	if (ret < 0)

Return immediately if nothing else to do.

> +		goto cleanup_config;
> +
> +	ret = ads71x8_set_conv_mode(data, ADS71x8_MODE_AUTO);
> +	if (ret < 0)
> +		goto cleanup_config;
> +
> +	/* Enable statistics and digital window comparator */
> +	ret = ads71x8_i2c_set_bit(data->client, ADS71x8_REG_GENERAL_CFG,
> +		(ADS71x8_GENERAL_CFG_STATS_EN | ADS71x8_GENERAL_CFG_DWC_EN));
> +	if (ret < 0)
> +		goto cleanup_config;
> +
> +	/* Enable all channels for auto sequencing */
> +	ret = ads71x8_i2c_set_bit(data->client, ADS71x8_REG_AUTO_SEQ_CH_SEL, 0xFF);
> +	if (ret < 0)
> +		goto cleanup_config;
> +
> +	/* Set auto sequence mode and start sequencing */
> +	ret = ads71x8_i2c_set_bit(data->client, ADS71x8_REG_SEQUENCE_CFG,
> +		(ADS71x8_SEQUENCE_CFG_SEQ_START | ADS71x8_SEQUENCE_CFG_SEQ_MODE));
> +	if (ret < 0)
> +		goto cleanup_config;
	return ads71...
assuming it returns 0 for good. If not, make it do so as that
is most common pattern for error returns vs good in the kernel.

That will also let you just do if (ret) above


> +
> +	return 0;
> +
> +cleanup_config:
Nothing to do so return above instead.

> +	return ret;
> +}
> +
> +static int ads71x8_probe(struct i2c_client *client)
> +{
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> +	struct iio_dev *indio_dev;
> +	struct ads71x8_data *data;
> +	int ret = 0;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
I'd add a
struct device *dev = &client->dev;
so as to shorten the various places you use this.

> +	if (!indio_dev) {
> +		ret = -ENOMEM;
return -ENOMEM;

> +		goto out;
> +	}
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	i2c_set_clientdata(client, indio_dev);
> +	mutex_init(&data->lock);
ret = devm_mutex_init()

> +
> +	indio_dev->dev.parent = &client->dev;
No need. That' sset by the IIO core in devm_iio_device_alloc.

> +	indio_dev->dev.of_node = client->dev.of_node;
Done by the IIO core IIRC - so should be no need to do it here.

> +	indio_dev->name = id->name;
Get that name from the per chip structures that you'll get via
i2c_get_match_data() after changes suggested eblow.

id->name proves annoying unstable with different firmware types etc.

> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ads71x8_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ads71x8_channels);
> +	indio_dev->info = &ti_ads71x8_info;
> +
> +	ret = devm_request_threaded_irq(&client->dev, client->irq,
> +		NULL, ads71x8_event_handler,
> +		IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
> +		client->name, indio_dev);
> +	if (ret)
After change above direct return.
> +		goto cleanup_mutex;
> +
> +	ret = iio_device_register(indio_dev);
ret = devm_iio_device_register()
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to register iio device\n");
> +		goto cleanup_mutex;
> +	}
> +
> +	ret = ads7138_init_hw(data);
The iio_device_register() exposes the device to userspace. You need
to finish all init before that.  So move this up to earlier in probe.

> +	if (ret) {
> +		dev_err(&client->dev, "Failed to initialize device\n");
return dev_err_probe() for all these error message prints from probe.
It is both shorter and handles this like deferred probe debug.

> +		goto cleanup_iio;
> +	}
> +
> +	return 0;
> +
> +cleanup_iio:
> +	iio_device_unregister(indio_dev);
> +cleanup_mutex:
> +	mutex_destroy(&data->lock);
As commented on below.
> +out:
Just return when you hit an error. It gives more readable code as no need
for the reviewer to go look for what cleanup is done.

> +	return ret;
> +}
> +
> +static void ads71x8_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct ads71x8_data *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
Use dev_iio_device_register() above and drop this.
> +	mutex_destroy(&data->lock);
Use ret = devm_mutex_init() above and drop this.

At that point nothing here so get rid of the remove callback.

> +}
> +
> +#ifdef CONFIG_PM
Update this to how it is done in modern drivers.
pm_ptr() allows the compiler to remove the unused functions without
need the ifdef fun.

> +static int ads71x8_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));

dev_get_drvdata()
is the same thing and shorter.

> +	struct ads71x8_data *data = iio_priv(indio_dev);
> +
> +	return ads71x8_set_conv_mode(data, ADS71x8_MODE_MANUAL);
> +}
> +
> +static int ads71x8_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct ads71x8_data *data = iio_priv(indio_dev);
> +
> +	return ads71x8_set_conv_mode(data, ADS71x8_MODE_AUTO);
> +}
> +#endif
> +
> +static const struct dev_pm_ops ads71x8_pm_ops = {
> +	SET_RUNTIME_PM_OPS(ads71x8_runtime_suspend, ads71x8_runtime_resume, NULL)
> +};
> +
> +static const struct of_device_id __maybe_unused ads71x8_of_match[] = {
Drop the __maybe_unused (see below)

> +	{
> +		.compatible = "ti,ads7128",
> +		.data = (void *)ads7128
Don't use enums in these it tends to go wrong as a driver gets more complex.
Better to provide a pointer to a structure instance that has all the information
about how the part works vs other parts in the driver.
> +	},
> +	{
> +		.compatible = "ti,ads7138",
> +		.data = (void *)ads7138
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ads71x8_of_match);
> +
> +static const struct i2c_device_id ads71x8_device_ids[] = {
> +	{ "ads7128", ads7128 },

Use pointers here as well (will need casting to a uintptr_t)

> +	{ "ads7138", ads7138 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ads71x8_device_ids);
> +
> +static struct i2c_driver ads71x8_driver = {
> +	.driver = {
> +		.name = MODULE_NAME,
I've never seen any advantage in doing a define for this.
Just put the string inline here instead.

> +		.of_match_table = of_match_ptr(ads71x8_of_match),

Drop the of_match_ptr(). That breaks probing with some firmware types
and adds no significant advantages. 

> +		.pm = &ads71x8_pm_ops,
> +	},
> +	.id_table = ads71x8_device_ids,
> +	.probe = ads71x8_probe,
> +	.remove = ads71x8_remove,
> +};
> +module_i2c_driver(ads71x8_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Tobias Sperling <tobias.sperling@softing.com>");
> +MODULE_DESCRIPTION("Driver for TI ADS71x8 ADCs");
> 


