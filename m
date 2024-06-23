Return-Path: <linux-iio+bounces-6744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27BA913A23
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 13:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236FB1C20AD8
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 11:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1937C145326;
	Sun, 23 Jun 2024 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NF7Ew3cT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC1F144D1E;
	Sun, 23 Jun 2024 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719143004; cv=none; b=HN0NT+2/21RKoEekYXlL5kWueUqSwZvqMXzRtXmNyYtglFbRmLnvUN317l1y0xge7JcN0gx02V+f25/27mgLSNej/ggzEEBeuAVUDcMRygxR8VrqtGn+TP3dClZWr7KJHcsFeDdnGKZYJ8yqJcZUsftL4BejYMxDhxy/Egjpjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719143004; c=relaxed/simple;
	bh=W/Rd/FoEAydffV3hb5itlCcyaOhG6bq1qVbbmW86q38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8WmU9ltDVMi+O2DbmHNqepcTcaEUHERcylrfm8WDvZ11ZWmYzqPavCloS8+uEaEhQmUAgQp3HlyHi/BMIs6fLTBYtdkBoVr5poKqd2Z5wqSdjbU328E/aMUIIAQyynO6YNHe5ePXnaObHL3KBI+4lpiklXXfHSo5WEA2Dk+H8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NF7Ew3cT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4251C2BD10;
	Sun, 23 Jun 2024 11:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719143004;
	bh=W/Rd/FoEAydffV3hb5itlCcyaOhG6bq1qVbbmW86q38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NF7Ew3cT82gmm19ktDDRCAKwZ8ugEVeAUr6zRDUrBJ6Exslkox3qIlJ91iSH6pln4
	 z0uAjuAudjB7QUr2pKU4+R7dPhRn4lvwNh/rY4HSSalHki4DoO0SulPys/paOe1m3E
	 iwQ4ZHDYW4k7gPAvyGqmSxDE8tRNT1D4MWcsXcnBdSu7pIiT1wd5DbHg7L1MMct5P7
	 kfU+Rk8xzJxBEfm1At+0825F/Ja9SJVfBBfmrWUDvUjNTo2IQfuSZ8E6cqH5wtf1Gk
	 VIwt98OC1gT2Z+tAjlhz+zyIaxLm7eF+mG1ImmJzwRlPxvF59/mQZusvP1tXLJOvMr
	 y/VlgIEd8T4PA==
Date: Sun, 23 Jun 2024 12:43:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, "Michael Hennerich" <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jun Yan
 <jerrysteve1101@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>,
 Mehdi Djait <mehdi.djait.k@gmail.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, Mario Limonciello
 <mario.limonciello@amd.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: accel: add ADXL380 driver
Message-ID: <20240623124314.318cd4c8@jic23-huawei>
In-Reply-To: <20240621101756.27218-2-antoniu.miclaus@analog.com>
References: <20240621101756.27218-1-antoniu.miclaus@analog.com>
	<20240621101756.27218-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 13:17:04 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> From: Ramona Gradinariu <ramona.gradinariu@analog.com>
> 
> The ADXL380/ADXL382 is a low noise density, low power, 3-axis
> accelerometer with selectable measurement ranges. The ADXL380 supports
> the +/-4 g, +/-8 g, and +/-16 g ranges, and the ADXL382 supports
> +/-15 g, +/-30 g and +/-60 g ranges.
> The ADXL380/ADXL382 offers industry leading noise, enabling precision
> applications with minimal calibration. The low noise, and low power
> ADXL380/ADXL382 enables accurate measurement in an environment with
> high vibration, heart sounds and audio.
> 
> In addition to its low power consumption, the ADXL380/ADXL382 has many
> features to enable true system level performance. These include a
> built-in micropower temperature sensor, single / double / triple tap
> detection and a state machine to prevent a false triggering. In
> addition, the ADXL380/ADXL382 has provisions for external control of
> the sampling time and/or an external clock.

A little marketing heavy, but it does include a good feature description
so fair enough I guess :) 

> 
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

If you do another big driver like this (typically > 1000 lines) see
if you can break it up.  It's tricky to review so much code in one go.
How to break things up depends on the driver, but adding event support
can often be done cleanly as a follow up patch.

It takes a long time to review very large patches and it's
hard to do it in multiple sessions, so you'll typically
get fewer reviewers.

Anyhow, not necessary for this one unless others request it.

Generally pretty good driver, so most of the comments inline are
fairly superficial things that should be easy to tidy up.

Jonathan


> ---
> changes in v2:
>  - include <linux/irq.h>
>  MAINTAINERS                     |    4 +
>  drivers/iio/accel/Kconfig       |   27 +
>  drivers/iio/accel/Makefile      |    3 +
>  drivers/iio/accel/adxl380.c     | 1919 +++++++++++++++++++++++++++++++
>  drivers/iio/accel/adxl380.h     |   26 +
>  drivers/iio/accel/adxl380_i2c.c |   74 ++
>  drivers/iio/accel/adxl380_spi.c |   73 ++
>  7 files changed, 2126 insertions(+)
>  create mode 100644 drivers/iio/accel/adxl380.c
>  create mode 100644 drivers/iio/accel/adxl380.h
>  create mode 100644 drivers/iio/accel/adxl380_i2c.c
>  create mode 100644 drivers/iio/accel/adxl380_spi.c
> 



> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> new file mode 100644
> index 000000000000..d62573bf6864
> --- /dev/null
> +++ b/drivers/iio/accel/adxl380.c
> @@ -0,0 +1,1919 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ADXL380 3-Axis Digital Accelerometer core driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/units.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/irq.h>
Make this alphabetical.  Can do groups with 
linux/*

linux/iio/* as more specific

asm/* as also more specific

local header as most specific.

> +#include <asm/unaligned.h>
> +
> +#include "adxl380.h"

> +#define ADXL380_DIG_EN			0x27
> +#define ADXL380_CHAN_EN_MSK(chan)	BIT(4 + (chan))
> +#define ADXL380_FIFO_EN_MSK		BIT(3)
> +
> +#define ADXL380_INT0_MAP0		0x2B
> +#define ADXL380_FIFO_WM_INT0_MSK	BIT(3)
> +#define ADXL380_ACT_INT0_MSK		BIT(5)
I'd name fields so that it builds up from where to what

#define ADXL380_INT0_MAP0_REG
#define  ADXL380_INT0_MAP0_FIFO_WM_MSK
#define  ADXL380_INT0_MAP0_ACT_MSK

etc  as then it's easy to spot confusion over field definition
and register addresses.  The spacing above is deliberate as makes
it easy to differentiate from register address to fields within
that register.


> +#define ADXL380_INACT_INT0_MSK		BIT(6)
> +#define ADXL380_INT0_MAP1		0x2C
> +#define ADXL380_SINGLE_TAP_INT0_MSK	BIT(0)
> +#define ADXL380_DOUBLE_TAP_INT0_MSK	BIT(1)
> +
> +#define ADXL380_INT0			0x5D
> +#define ADXL380_INT0_POL_MSK		BIT(7)
> +
> +#define ADXL380_RESET			0x2A
> +#define ADXL380_FIFO_DATA		0x1D
> +
> +#define ADXL380_DEVID_AD_VAL		0xAD
> +#define ADXL380_RESET_CODE		0x52
> +
> +/* ADXL380_STATUS_0 */
> +#define ADXL380_STATUS_0_FIFO_FULL(x)		(((x) >> 1) & 0x1)
> +#define ADXL380_STATUS_0_FIFO_WM(x)		(((x) >> 3) & 0x1)
> +
> +/* ADXL380_STATUS_2 */
STATUS_1?  No need to include that comment as naming makes it clear.

> +#define ADXL380_STATUS_1_INACT(x)		(((x) >> 6) & 0x1)
> +#define ADXL380_STATUS_1_ACT(x)			(((x) >> 5) & 0x1)
> +#define ADXL380_STATUS_1_DOUBLE_TAP(x)		(((x) >> 1) & 0x1)
> +#define ADXL380_STATUS_1_SINGLE_TAP(x)		(((x) >> 0) & 0x1)
Define the event related  BIT() and use FIELD_GET() in the code.
Accessor macros like this generally make things harder to read not
easier.


> +
> +#define ADXL380_FIFO_SAMPLES			315UL
> +
> +enum adxl380_channels {
> +	ADXL380_ACCEL_X,
> +	ADXL380_ACCEL_Y,
> +	ADXL380_ACCEL_Z,
> +	ADXL380_TEMP,
> +	ADXL380_CH_NUM,
> +};
> +
> +enum adxl380_axis {
> +	ADXL380_X_AXIS,
> +	ADXL380_Y_AXIS,
> +	ADXL380_Z_AXIS,
> +};
> +
> +enum adxl380_op_mode {
> +	ADXL380_STANDBY,
> +	ADXL380_HEART_SOUND,
> +	ADXL380_ULP,
> +	ADXL380_VLP,
> +	ADXL380_LP,
> +	ADXL380_LP_ULP = 6,
> +	ADXL380_LP_VLP,
> +	ADXL380_RBW,
> +	ADXL380_RBW_ULP = 10,
> +	ADXL380_RBW_VLP,
> +	ADXL380_HP,
> +	ADXL380_HP_ULP = 14,
> +	ADXL380_HP_VLP,
> +};
> +
> +enum adxl380_range {
> +	ADXL380_4G_RANGE = 0,
> +	ADXL382_15G_RANGE = 0,
> +	ADXL380_8G_RANGE = 1,
> +	ADXL382_30G_RANGE = 1,
> +	ADXL380_16G_RANGE = 2,
> +	ADXL382_60G_RANGE = 2,
> +};
> +
> +enum adxl380_activity_type {
> +	ADXL380_ACTIVITY,
> +	ADXL380_INACTIVITY,
> +};
> +
> +enum adxl380_tap_type {
> +	ADXL380_SINGLE_TAP,
> +	ADXL380_DOUBLE_TAP,
> +};
> +
> +enum adxl380_tap_time_type {
> +	ADXL380_TAP_TIME_LATENT,
> +	ADXL380_TAP_TIME_WINDOW,
> +};
> +
> +enum adxl380_activity_axis {
> +	ADXL380_NO_AXIS,
> +	ADXL380_X_AXIS_EN,
> +	ADXL380_Y_AXIS_EN,
> +	ADXL380_X_Y_AXIS_EN,
> +	ADXL380_Z_AXIS_EN,
> +	ADXL380_X_Z_AXIS_EN,
> +	ADXL380_Y_Z_AXIS_EN,
> +	ADXL380_X_Y_Z_AXIS_EN,
> +};
> +
> +enum adxl380_hpf_3db {
> +	ADXL380_HPF_OFF,
> +	ADXL380_HPF_24_7,
> +	ADXL380_HPF_6_2084,
> +	ADXL380_HPF_1_5545,
> +	ADXL380_HPF_0_3862,
> +	ADXL380_HPF_0_0954,
> +	ADXL380_HPF_0_0238,
> +};
> +
> +enum adxl380_fifo_mode {
> +	ADXL380_FIFO_DISABLED,
> +	ADXL380_FIFO_NORMAL,
> +	ADXL380_FIFO_STREAMED,
> +	ADXL380_FIFO_TRIGGERED,
> +};
Associate these enums with the register fields.  Given they are specific values, 
set them expclicilty and you might be better off with defines.

Association can be by naming, but definitely needs to be by placing these
next to relevant register field definition not all grouped down here.

> +
> +/*
> + * At +/- 4g with 16-bit resolution, scale is given in datasheet
> + * as 133.3ug/LSB = 0.0001333 * 9.80665 = 0.001307226 m/s^2.
> + */
> +#define ADXL380_RANGE_SCALE_TBL							\
> +{										\
> +	[ADXL380_4G_RANGE] = {0, 1307226},					\
> +	[ADXL380_8G_RANGE] = {0, 2615434},					\
> +	[ADXL380_16G_RANGE] = {0, 5229886},					\
> +}
> +
> +/*
> + * At +/- 15g with 16-bit resolution, scale is given in datasheet
> + * as 500ug/LSB = 0.0005 * 9.80665 = 0.004903325 m/s^2.
> + */
> +#define ADXL382_RANGE_SCALE_TBL							\
> +{										\
> +	[ADXL382_15G_RANGE] = {0, 4903325},					\
> +	[ADXL382_30G_RANGE] = {0, 9806650},					\
> +	[ADXL382_60G_RANGE] = {0, 19613300},					\
> +}
Spacing after { and before } for all these.

Just put this inline. It's only used in one place I think?


> +
> +static const int adxl380_range_scale_factor_tbl[] = {1, 2, 4};
> +
> +const struct adxl380_chip_info adxl380_chip_info = {
> +	.name = "adxl380",
> +	.chip_id = ADXL380_ID_VAL,
> +	.scale_tbl = ADXL380_RANGE_SCALE_TBL,
> +	.samp_freq_tbl = {8000, 16000, 32000},

spacing as below.

> +	/*
> +	 * The datasheet defines an intercept of 470 LSB at 25 degC
> +	 * and a sensitivity of 10.2 LSB/C.
> +	 */
> +	.temp_offset =  25 * 102 / 10 - 470,
> +
> +};
> +EXPORT_SYMBOL_NS_GPL(adxl380_chip_info, IIO_ADXL380);
> +
> +const struct adxl380_chip_info adxl382_chip_info = {
> +	.name = "adxl382",
> +	.chip_id = ADXL382_ID_VAL,
> +	.scale_tbl = ADXL382_RANGE_SCALE_TBL,
> +	.samp_freq_tbl = {16000, 32000, 64000},
 Spaces so { 16000, 32000, 64000 },

> +	/*
> +	 * The datasheet defines an intercept of 570 LSB at 25 degC
> +	 * and a sensitivity of 10.2 LSB/C.
> +	 */
> +	.temp_offset =  25 * 102 / 10 - 570,
> +};
> +EXPORT_SYMBOL_NS_GPL(adxl382_chip_info, IIO_ADXL380);

> +
> +struct adxl380_state {
> +	int irq;
> +	struct device *dev;
> +	struct regmap *regmap;

Andy normally points this one out, but put your most regularly used
element first.   Here probably regmap as it may save a few instructions
and is more logical than starting with irq anyway!

> +	const struct adxl380_chip_info *chip_info;
> +	/*
> +	 * Synchronize access to members of driver state, and ensure atomicity
> +	 * of consecutive regmap operations.
> +	 */
> +	struct mutex lock;
> +	enum adxl380_range range;
> +	u8 odr;
Given no particular ordering in here, group the u8 elements
and it'll save a byte or two in size.

> +	u32 act_time_ms;
> +	u32 act_threshold;
> +	u32 inact_time_ms;
> +	u32 inact_threshold;
> +	u32 tap_latent_us;
> +	u32 tap_window_us;
> +	u32 tap_duration_us;
> +	u32 tap_threshold;
> +	enum adxl380_axis tap_axis_en;
> +	u8 fifo_set_size;
> +	u16 watermark;
> +	int lpf_tbl[4];
> +	int hpf_tbl[7][2];

I think we still can't rely on regmap always copying so need to provide
dma safe buffers for bulk reads.  So mark these __aligned(IIO_DMA_MINALIGN);
If you can use a union of trans_buf and fifo_buf as we want fifo_buf to
be on the alignement boundary so that we don't have the small dma buffer
copying stuff (arm64 only I think currently) kick in and assume it needs
to bounce the data.

> +	u8 transf_buf[3];
> +	__be16 fifo_buf[ADXL380_FIFO_SAMPLES];
> +};
> +
> +bool adxl380_readable_noinc_reg(struct device *dev, unsigned int reg)
> +{
> +	return (reg == ADXL380_FIFO_DATA);

Drop brackets.

> +}
> +EXPORT_SYMBOL_NS_GPL(adxl380_readable_noinc_reg, IIO_ADXL380);

>
> +
> +static int _adxl380_set_act_inact_time_ms(struct adxl380_state *st,
> +					  enum adxl380_activity_type act,
> +					  u32 ms)
> +{
> +	u8 reg = adxl380_time_reg_high_addr[act];
> +	unsigned int reg_val;
> +	int ret;
> +
> +	/* 500us per code is the scale factor of TIME_ACT / TIME_INACT registers */
> +	reg_val = DIV_ROUND_CLOSEST(ms * 1000, 500);
> +	if (reg_val > ADXL380_TIME_MAX)
> +		reg_val = ADXL380_TIME_MAX;

	regval = min(DIV_ROUND_CLOSEST(ms * 1000, 500), ADXL380_TIME_MAX);
> +
> +	st->transf_buf[0] = reg_val >> 16;
> +	st->transf_buf[1] = reg_val >> 8;
> +	st->transf_buf[2] = reg_val;

put_unaligned_be24() 

> +
> +	ret = regmap_bulk_write(st->regmap, reg, st->transf_buf, sizeof(st->transf_buf));
> +	if (ret)
> +		return ret;
> +
> +	if (act == ADXL380_ACTIVITY)
> +		st->act_time_ms = ms;
> +	else
> +		st->inact_time_ms = ms;
> +
> +	return 0;
> +}

> +
> +static int adxl380_set_range(struct adxl380_state *st, enum adxl380_range range)
> +{
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = _adxl380_set_measure_en(st, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap,
> +				 ADXL380_OP_MODE,
> +				 ADXL380_OP_MODE_RANGE_MSK,

Can line wrap less. In general go through and optimize all line wrapping to stay
under 80 chars where easy to do but not overly wrap like here.

> +				 FIELD_PREP(ADXL380_OP_MODE_RANGE_MSK, range));
> +
> +	if (ret)
> +		return ret;
> +
> +	_adxl380_scale_act_inact_thresholds(st, st->range, range);
> +
> +	/* Activity thresholds depend on range */
> +	ret = _adxl380_write_act_inact_threshold(st,
> +						 ADXL380_ACTIVITY,
> +						 st->act_threshold);
More over wrapping.  It's a long patch anyway, don't make it longer! :)


> +	if (ret)
> +		return ret;
> +
> +	ret = _adxl380_write_act_inact_threshold(st,
> +						 ADXL380_INACTIVITY,
> +						 st->inact_threshold);
> +	if (ret)
> +		return ret;
> +
> +	st->range = range;
> +
> +	return _adxl380_set_measure_en(st, true);
> +}



> +
> +static int _adxl380_set_fifo_samples(struct adxl380_state *st)
> +{
> +	int ret;
> +	u16 fifo_samples = st->watermark * st->fifo_set_size;
> +
> +	ret = regmap_update_bits(st->regmap, ADXL380_FIFO_CONFIG_0,
> +				 ADXL380_FIFO_SAMPLES_8_MSK,
> +				 FIELD_PREP(ADXL380_FIFO_SAMPLES_8_MSK, (fifo_samples & BIT(8))));

Long line that doesn't need to be.

> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap,
> +			    ADXL380_FIFO_CONFIG_1, fifo_samples & 0xFF);

Odd line wrap. 

> +}
> +
> +static int _adxl380_get_status(struct adxl380_state *st,
> +			       u8 *status0, u8 *status1)
> +{
> +	u16 val;
> +	int ret;
> +
> +	/* STATUS0, STATUS1 are adjacent regs */
> +	ret = regmap_bulk_read(st->regmap, ADXL380_STATUS_0,
> +			       &st->transf_buf, 2);
> +	if (ret)
> +		return ret;
> +
> +	val = get_unaligned_be16(st->transf_buf);

It's not a be16 if you immediately split it.  Just assign directly
from transf_buf to status0 and status1

> +
> +	*status0 = (val >> 8) & 0xFF;
> +	*status1 = val & 0xFF;
> +
> +	return 0;
> +}
> +
> +static int adxl380_get_fifo_entries(struct adxl380_state *st, u16 *fifo_entries)
> +{
> +	u16 val;
> +	int ret;
> +
> +	ret = regmap_bulk_read(st->regmap, ADXL380_FIFO_STATUS_0,
> +			       &st->transf_buf, 2);
> +	if (ret)
> +		return ret;
> +
> +	val = get_unaligned_be16(st->transf_buf);
> +
> +	*fifo_entries = ((val >> 8) & 0xFF) | ((BIT(0) & val) << 8);

That looks like it's not big endian at all as you are byte swaping and
masking by 1FF I think.  So read it as little endian and avoid the byte
swap.

> +
> +	return 0;
> +}

> +
> +static irqreturn_t adxl380_irq_handler(int irq, void  *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct adxl380_state *st = iio_priv(indio_dev);
> +	u8 status0, status1;
> +	u16 fifo_entries;
> +	int i;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = _adxl380_get_status(st, &status0, &status1);
> +	if (ret)
> +		goto exit;
> +
> +	adxl380_push_event(indio_dev, iio_get_time_ns(indio_dev), status1);
> +
> +	if (ADXL380_STATUS_0_FIFO_WM(status0)) {
> +		ret = adxl380_get_fifo_entries(st, &fifo_entries);
> +		if (ret)
> +			goto exit;
> +
> +		for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
> +			ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA,
> +						&st->fifo_buf[i],
> +						2 * st->fifo_set_size);
> +			if (ret)
> +				goto exit;
> +			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> +		}
> +	}
> +
> +exit:
> +	return IRQ_HANDLED;

If nothing else to do, just return above instead of goto.
Also lets you do
	if (!ADX380_STATUS_0_FIFO_WM(status0))
		return IRQ_HANDLED;

	ret = ...

and reduce the indent / improve readability a bit.

> +}
> +
> +static int adxl380_write_calibbias_value(struct adxl380_state *st,
> +					 unsigned long chan_addr,
> +					 u8 calibbias)

s8 probably more appropriate type given you sign extend in the read path.

> +{
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = _adxl380_set_measure_en(st, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADXL380_X_DSM_OFFSET + chan_addr, calibbias);
> +	if (ret)
> +		return ret;
> +
> +	return _adxl380_set_measure_en(st, true);
> +}
> +
> +static int adxl380_read_calibbias_value(struct adxl380_state *st,
> +					unsigned long chan_addr,
> +					int *calibbias)
> +{
> +	int ret;
> +	unsigned int reg_val;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_read(st->regmap, ADXL380_X_DSM_OFFSET + chan_addr, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	*calibbias = sign_extend32(reg_val, 7);

Does that must make it an s8?  If so use an s8 for the parameter
and assign val at the caller.

> +
> +	return 0;
> +}



...

> +static int adxl380_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long info)
> +{
> +	struct adxl380_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = adxl380_read_chn(st, chan->address);
error check missing

		iio_device_claim_direct_scoped()
might make this easier to read, but up to y ou.

> +
> +		iio_device_release_direct_mode(indio_dev);
> +
> +		*val = sign_extend32(ret >> chan->scan_type.shift,
> +				     chan->scan_type.realbits - 1);
> +		return IIO_VAL_INT;
...

> +}
> +
> +static int adxl380_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	struct adxl380_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type != IIO_ACCEL)
> +			return -EINVAL;
> +		*vals = (const int *)st->chip_info->scale_tbl;
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		*length = ARRAY_SIZE(st->chip_info->scale_tbl) * 2;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = (const int *)st->chip_info->samp_freq_tbl;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(st->chip_info->samp_freq_tbl);
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*vals = (const int *)st->lpf_tbl;
I'd guess the non accel axis aren't filtered.. So if the != IIO_ACCEL
check above makes sense then add one here.

or reply on the fact you didn't register the attributes for the wrong
channel types so should not be necessary to check at all.

> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(st->lpf_tbl);
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> +		*vals = (const int *)st->hpf_tbl;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		/* Values are stored in a 2D matrix */
> +		*length = ARRAY_SIZE(st->hpf_tbl) * 2;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}



> +
> +static int adxl380_read_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type, enum iio_event_direction dir,

Aim for < 80 unless it hurts readabilty. Here it is easy to do.


> +				    enum iio_event_info info, int *val, int *val2)
> +{
> +	struct adxl380_state *st = iio_priv(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE: {
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				*val = st->act_threshold;
> +				return IIO_VAL_INT;
> +			case IIO_EV_DIR_FALLING:
> +				*val = st->inact_threshold;
> +				return IIO_VAL_INT;
> +			default:
> +				return -EINVAL;
> +			}
> +		}
> +		case IIO_EV_INFO_PERIOD:
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				*val = st->act_time_ms;
> +				*val2 = 1000;
> +				return IIO_VAL_FRACTIONAL;
> +			case IIO_EV_DIR_FALLING:
> +				*val = st->inact_time_ms;
> +				*val2 = 1000;
> +				return IIO_VAL_FRACTIONAL;
> +			default:
> +				return -EINVAL;
> +			}
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_EV_TYPE_GESTURE:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			*val = st->tap_threshold;
> +			return IIO_VAL_INT;
> +		case IIO_EV_INFO_RESET_TIMEOUT:
> +			*val = st->tap_window_us;
> +			*val2 = 1000000;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_EV_INFO_TAP2_MIN_DELAY:
> +			*val = st->tap_latent_us;
> +			*val2 = 1000000;
> +			return IIO_VAL_FRACTIONAL;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adxl380_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type, enum iio_event_direction dir,
> +				     enum iio_event_info info, int val, int val2)
> +{
> +	struct adxl380_state *st = iio_priv(indio_dev);
> +	u32 val_ms, val_us;
> +
> +	if (chan->type != IIO_ACCEL)
> +		return -EINVAL;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				return adxl380_set_act_inact_threshold(indio_dev, ADXL380_ACTIVITY, val);

Long lines and no great way to avoid that.
hey are going to be over 80 but break after the indio_dev, and ACTIVITY, to minimise
how much over.

> +			case IIO_EV_DIR_FALLING:
> +				return adxl380_set_act_inact_threshold(indio_dev, ADXL380_INACTIVITY, val);
> +			default:
> +				return -EINVAL;
> +			}
> +		case IIO_EV_INFO_PERIOD:
> +			val_ms = val * 1000 + DIV_ROUND_UP(val2, 1000);
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				return adxl380_set_act_inact_time_ms(st, ADXL380_ACTIVITY, val_ms);
> +			case IIO_EV_DIR_FALLING:
> +				return adxl380_set_act_inact_time_ms(st, ADXL380_INACTIVITY, val_ms);
> +			default:
> +				return -EINVAL;
> +			}
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_EV_TYPE_GESTURE:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			return adxl380_set_tap_threshold_value(indio_dev, val);
> +		case IIO_EV_INFO_RESET_TIMEOUT:
> +			val_us = val * 1000000 + val2;
> +			return adxl380_write_tap_time_us(st, ADXL380_TAP_TIME_WINDOW, val_us);
> +		case IIO_EV_INFO_TAP2_MIN_DELAY:
> +			val_us = val * 1000000 + val2;
> +			return adxl380_write_tap_time_us(st, ADXL380_TAP_TIME_LATENT, val_us);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t in_accel_gesture_tap_maxtomin_time_show(struct device *dev,
> +						       struct device_attribute *attr,
> +						       char *buf)
> +{
> +	int vals[2];
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl380_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	vals[0] = st->tap_duration_us;
> +	vals[1] = 1000000;

MICRO

> +
> +	ret  = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, vals);
> +
Odd spacing but...

> +	return ret;
return iio_format_value();

> +}
> +
> +static ssize_t in_accel_gesture_tap_maxtomin_time_store(struct device *dev,
> +							struct device_attribute *attr,
> +							const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl380_state *st = iio_priv(indio_dev);
> +	int ret, val_int, val_fract_us;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = iio_str_to_fixpoint(buf, 100000, &val_int, &val_fract_us);

hmm. I'd forgotten the unintuitive 2nd parameter of that function. If we made
it ten times bigger then the parameter would be MICRO and all would look
correct.  May be worth a revisit, but obviously not a problem for this patch! 

> +	if (ret)
> +		return ret;
> +
> +	/* maximum value is 255 * 625 us = 0.159375 seconds */
> +	if (val_int || val_fract_us > 159375)

Do we need to check for negatives as well?

> +		return -EINVAL;
> +
> +	ret = _adxl380_write_tap_dur_us(indio_dev, val_fract_us);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR_RW(in_accel_gesture_tap_maxtomin_time, 0);
> +
> +static struct attribute *adxl380_event_attributes[] = {
> +	&iio_dev_attr_in_accel_gesture_tap_maxtomin_time.dev_attr.attr,

Not providing an available?  May make it tricky to use.

> +	NULL
> +};
> +
> +static const struct attribute_group adxl380_event_attribute_group = {
> +	.attrs = adxl380_event_attributes,
> +};

> +static int adxl380_set_watermark(struct iio_dev *indio_dev, unsigned int val)
> +{
> +	struct adxl380_state *st  = iio_priv(indio_dev);
> +
> +	if (val > ADXL380_FIFO_SAMPLES)
> +		val = ADXL380_FIFO_SAMPLES;

	st->watermark = min(val, ADXL380_FIFO_SAMPLES);
> +
> +	st->watermark = val;
> +
> +	return 0;
> +}


> +
> +static int _adxl380_config_irq(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct irq_data *desc;
> +	unsigned long irq_flag;
> +	u32 irq_type;
> +	u8 polarity;
> +	struct adxl380_state *st = iio_priv(indio_dev);

Good to apply some order to local declarations. I don't care that much what it is.
If you have no strong feeling reverse xmas tree looks pretty...

> +
> +	desc = irq_get_irq_data(st->irq);
> +	if (!desc)
> +		return dev_err_probe(st->dev, -EINVAL, "Could not find IRQ %d\n", st->irq);
> +
> +	irq_type = irqd_get_trigger_type(desc);
> +	if (irq_type == IRQ_TYPE_LEVEL_HIGH) {
> +		polarity = 0;
> +		irq_flag = IRQF_TRIGGER_HIGH;
> +	} else if (irq_type == IRQ_TYPE_LEVEL_LOW) {
> +		polarity = 1;
> +		irq_flag = IRQF_TRIGGER_LOW;
> +	} else {
> +		return dev_err_probe(st->dev, -EINVAL, "Invalid interrupt type 0x%x specified\n",
Say why. Perhaps:  Device only supports level interrupts.
> +			irq_type);
> +	}
> +
> +	ret = regmap_update_bits(st->regmap, ADXL380_INT0,
> +				 ADXL380_INT0_POL_MSK,
> +				 FIELD_PREP(ADXL380_INT0_POL_MSK, polarity));
> +	if (ret)
> +		return ret;
> +
> +	return devm_request_threaded_irq(st->dev, st->irq, NULL,
> +					 adxl380_irq_handler,
> +					 IRQF_ONESHOT | irq_flag,

I think the irq_flag bit should already be set by the irq core code via the irq_type you
read above.  So should be no need to do it again here.

> +					 indio_dev->name, indio_dev);
> +}
> +
> +static int _adxl380_setup(struct iio_dev *indio_dev)
As below (I review backwards hence comments may make more sense that way
around) - why the _ ?
> +{
> +	unsigned int reg_val;
> +	u16 part_id, chip_id = ADXL380_ID_VAL;
> +	int ret, i;
> +	struct adxl380_state *st = iio_priv(indio_dev);
> +
> +	ret = regmap_read(st->regmap, ADXL380_DEVID_AD, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	if (reg_val != ADXL380_DEVID_AD_VAL)
> +		dev_warn(st->dev, "Invalid device id %x\n", reg_val);
> +
> +	ret = regmap_bulk_read(st->regmap, ADLX380_PART_ID,
> +			       &st->transf_buf, 2);
> +	if (ret)
> +		return ret;
> +
> +	part_id = get_unaligned_be16(st->transf_buf);
> +	part_id >>= 4;
> +
> +	if (part_id != ADXL380_ID_VAL)
> +		dev_warn(st->dev, "Invalid part id %x\n", part_id);
Unknown chip id, not invalid.   It might be a future backwards compatible
device we don't yet know about.


So the two parts of have same ID in the register and use an alternate
register to split them. Ugly :( Make that more explicit in the code.
Have two chip_info fields. One for this and one for the second
part of the match. Maintain two local variables here and check them
both for the warning below. 

> +
> +	ret = regmap_read(st->regmap, ADXL380_MISC_1, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	/* Bit to differentiate between ADXL380/382. */
> +	if (reg_val & BIT(7))
> +		chip_id = ADXL382_ID_VAL;
> +
> +	if (chip_id != st->chip_info->chip_id)
> +		dev_warn(st->dev, "Invalid chip id %x\n", chip_id);
Unexpected chip id.  This message is about us having a known but
different part in DT vs the actual fitted one. Maybe go for more explicit

Chip ID different from that expected from firmware description: %x\n
  
> +
> +	/*
> +	 * Perform a software reset to make sure the device is in a consistent
> +	 * state after start up.
> +	 */
I'd drop that comment as kind of obvious.

> +	ret = regmap_write(st->regmap, ADXL380_RESET, ADXL380_RESET_CODE);
> +	if (ret)
> +		return ret;
> +
> +	/* Delay required after software reset. */
If this one can give an explicit reference to a datasheet value then it
is worthwhile. If established by trial and error worth saying that.
Aim is that if it turns out to be too short, we want to know if we just modify it
or if someone should got to analog and get the datasheet fixed.

> +	fsleep(500);
> +
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		ret = regmap_update_bits(st->regmap, ADXL380_DIG_EN,
> +					 ADXL380_CHAN_EN_MSK(i),
> +					 1 << (4 + i));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_update_bits(st->regmap, ADXL380_FIFO_CONFIG_0,
> +				 ADXL380_FIFO_MODE_MSK,
> +				 FIELD_PREP(ADXL380_FIFO_MODE_MSK, ADXL380_FIFO_STREAMED));
> +	if (ret)
> +		return ret;
> +
> +	/* Select all 3 axis for act/inact detection. */
> +	ret = regmap_update_bits(st->regmap, ADXL380_SNSR_AXIS_EN,
> +				 ADXL380_ACT_INACT_AXIS_EN_MSK,
> +				 FIELD_PREP(ADXL380_ACT_INACT_AXIS_EN_MSK, ADXL380_X_Y_Z_AXIS_EN));
> +	if (ret)
> +		return ret;
> +
> +	ret = _adxl380_config_irq(indio_dev);

Drop all these preceeding _  When we do a prefix like that it needs to have
a well defined reason.  Normally it's macro stacks needed for some reason, not
every day functions.

> +	if (ret)
> +		return ret;
> +
> +	ret = _adxl380_fill_lpf_tbl(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = _adxl380_fill_hpf_tbl(st);
> +	if (ret)
> +		return ret;
> +
> +	return _adxl380_set_measure_en(st, true);
> +}
> +
> +int adxl380_probe(struct device *dev, struct regmap *regmap,
> +		  int irq, const struct adxl380_chip_info *chip_info)
> +{
> +	struct iio_dev *indio_dev;
> +	struct adxl380_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;

As per the binding review I just wrong, I'd expect some
devm_regulator_get_enabled() in here, or maybe a bulk variant.

> +
> +	st = iio_priv(indio_dev);
> +
> +	st->dev = dev;
> +	st->regmap = regmap;
> +	st->irq = irq;

Also as per the binding review, datasheet suggests 2 irqs so you'll need
to do something more complex so we know which is which - or in the annoying
case of someone wires only one of them, which one is wired.  Will need
interrupt-names etc.


> +	st->chip_info = chip_info;
> +
> +	mutex_init(&st->lock);
> +
> +	indio_dev->channels = adxl380_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adxl380_channels);
> +	indio_dev->name = chip_info->name;
> +	indio_dev->info = &adxl380_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = _adxl380_setup(indio_dev);

Why the leading _ ?

> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_kfifo_buffer_setup_ext(st->dev, indio_dev,
> +					      &adxl380_buffer_ops,
> +					      adxl380_fifo_attributes);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(adxl380_probe, IIO_ADXL380);
> +
> +MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
> +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADXL380 3-axis accelerometer driver");
> +MODULE_LICENSE("GPL");

...

> diff --git a/drivers/iio/accel/adxl380_i2c.c b/drivers/iio/accel/adxl380_i2c.c
> new file mode 100644

...

> +
> +static int adxl380_i2c_probe(struct i2c_client *client)
> +{
> +	struct regmap *regmap;
> +	const struct adxl380_chip_info *chip_data;
> +	const struct i2c_device_id *adxl380;
> +
> +	chip_data = device_get_match_data(&client->dev);
	chip_data = i2c_get_match_data()

handles all this fallback stuff for you.

The effort to move all drivers over to this is ongoing (I took a load more
patches doing this for IIO drivers last week)

> +	if (!chip_data) {
> +		adxl380 = to_i2c_driver(client->dev.driver)->id_table;
> +		if (!adxl380)
> +			return -EINVAL;
> +
> +		chip_data = (void *)i2c_match_id(adxl380, client)->driver_data;
> +		if (!chip_data)
> +			return -EINVAL;
> +	}

...

> diff --git a/drivers/iio/accel/adxl380_spi.c b/drivers/iio/accel/adxl380_spi.c
> new file mode 100644
> index 000000000000..13bbe6c0bed1
> --- /dev/null
> +++ b/drivers/iio/accel/adxl380_spi.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ADXL380 3-Axis Digital Accelerometer SPI driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>

Shouldn't need of specific headers.
mod_devicetable.h covers the id table. You have it right for the spi version.
If this was cut and paste from somewhere else, shout and we'll fix that up
as well. I thought I'd cleared all these out a while back, but maybe some new
ones have gotten in.


> +#include <linux/spi/spi.h>
> +
> +#include "adxl380.h"
> +
> +static const struct regmap_config adxl380_spi_regmap_config = {
> +	.reg_bits = 7,
> +	.pad_bits = 1,
> +	.val_bits = 8,
> +	.read_flag_mask = BIT(0),
> +	.readable_noinc_reg = adxl380_readable_noinc_reg,
> +};
> +
> +static int adxl380_spi_probe(struct spi_device *spi)
> +{
> +	const struct adxl380_chip_info *chip_data;
> +	struct regmap *regmap;
> +
> +	chip_data = device_get_match_data(&spi->dev);

spi_get_device_match_data() and no need to do this dance with the various
sources of data in the driver as that function already contains this
logic.

> +	if (!chip_data) {
> +		chip_data = (void *)spi_get_device_id(spi)->driver_data;
> +
> +		if (!chip_data)
> +			return -EINVAL;
> +	}
> +
> +	regmap = devm_regmap_init_spi(spi, &adxl380_spi_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return adxl380_probe(&spi->dev, regmap, spi->irq, chip_data);
> +}


