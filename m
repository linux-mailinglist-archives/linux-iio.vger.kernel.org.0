Return-Path: <linux-iio+bounces-5114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44778C9525
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 17:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C8F1C20BC5
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C958482DD;
	Sun, 19 May 2024 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PT6qobIx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DD01DFC5;
	Sun, 19 May 2024 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716132291; cv=none; b=SVAwjinnG01PVN8jdM7UxKQoVsDEMlulkf2kXfC9KfJXrfyTH/zj+HO5H6S901aCg+Y21rTxFgNZ4jXEfqeIxRbKY0rQbHSHY+eP2ycBRqnAwSvS5jcmUZHL7/YTwqhkwwKPeiwBRXVXtfoKM3ygpOz1kUpJ7ZBVz/MCzXctkh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716132291; c=relaxed/simple;
	bh=v9I2hwkn+xRjl8Hv+v8RU+7Zd/0VcGENLGntXlxGy9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDLCwCSpYi5DwQg57kYCE3MxHHt2J2Z+TmVZVq/tyuvA8ZlFAfQ4qzSjfd2nElS/NLa01KxmbDKJyqDe8ZhQXVmcVbfuVJ0ljZNaUv8IuXBvcoV1pibxJj7wvQRPcENbE/QBStaD4L0knr0wmL4xzPfFg9nug1QdrKGhQ+FR9mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PT6qobIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCFBC32781;
	Sun, 19 May 2024 15:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716132290;
	bh=v9I2hwkn+xRjl8Hv+v8RU+7Zd/0VcGENLGntXlxGy9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PT6qobIxueAym+LHnSfkLHfTMwI3M2DhSgTlkoErucIjkTmtwS3pM7s/PIPxAdJm2
	 wJNe8jdOFuF4lAqqS3XiIALu4qdeZJDYh1fxQpYJJ5+mcxETal25fzrz7WRTcmb76O
	 LUgkjOP4Gkb36F4iip2ZhfAEa2TsiezDYjlKsK+GLfvC3D+BK8bhC1gmMEpjLpsWs9
	 f/dRQVbwFf5ntaomJ1B1wIk2Ec2TSe+vMxdmzs8x+DXsLHn/DhjBOlR4rTbz39YRYd
	 oBRF/msM1vqQv6/vBKnUBOSIvSCEUrUOotF5rdBUzmle5HDV+H1R2teL1nVcqJidfj
	 gLJ14ekI2gX+A==
Date: Sun, 19 May 2024 16:24:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@outlook.com>
Cc: andy.shevchenko@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.a@analog.com, swboyd@chromium.org,
 u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com
Subject: Re: [PATCH v1 1/2] iio:proximity:hx9031as: Add TYHX
 HX9031AS/HX9023S sensor driver
Message-ID: <20240519162438.17af0ff8@jic23-huawei>
In-Reply-To: <SN7PR12MB810161203706CD288923AB1DA4E32@SN7PR12MB8101.namprd12.prod.outlook.com>
References: <20240511170143.7ca6a410@jic23-huawei>
	<20240514202540.341103-1-yasin.lee.x@outlook.com>
	<SN7PR12MB810161203706CD288923AB1DA4E32@SN7PR12MB8101.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 May 2024 04:25:39 +0800
Yasin Lee <yasin.lee.x@outlook.com> wrote:

> From: Yasin Lee <yasin.lee.x@gmail.com>
> 
> A SAR sensor from NanjingTianyihexin Electronics Ltd.
> 
> The device has the following entry points:
> 
> Usual frequency:
> - sampling_frequency
> 
> Instant reading of current values for different sensors:
> - in_proximity0_raw
> - in_proximity1_raw
> - in_proximity2_raw
> - in_proximity3_raw
> - in_proximity4_raw
> and associated events in events/
> 
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
Hi Yasin

This is improving but still needs a lot of cleanup.
Drop all the dev_info() prints.
Drop all custom bit manipulation macros etc. That stuff has standard
functions.

Generally try to cleanup up the code.  I'd expect at least 1/4 of what
is currently here to be gone in v3 making things easier to review.

Currently it is sufficiently messy that I haven't done a thorough review
of the functionality yet.

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-iio-hx9031as        |   11 +
>  drivers/iio/proximity/Kconfig                 |   12 +
>  drivers/iio/proximity/Makefile                |    1 +
>  drivers/iio/proximity/hx9031as.c              | 1379 +++++++++++++++++
>  4 files changed, 1403 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-hx9031as
>  create mode 100644 drivers/iio/proximity/hx9031as.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-hx9031as b/Documentation/ABI/testing/sysfs-bus-iio-hx9031as
> new file mode 100644
> index 000000000000..9a3ce803fefb
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-hx9031as
> @@ -0,0 +1,11 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity<id>_raw
Standards ABI. So you both shouldn't and for that matter can't duplicate the main
docs without causing a build issue for the documentation.

> +Date:		May 2024
> +KernelVersion:	6.9.0
> +Contact:	Yasin Lee <yasin.lee.x@gmail>
> +Description:
> +		Proximity measurement indicating that some object is
> +		near the combined sensor. The combined sensor presents
> +		proximity measurements constructed by hardware by
> +		combining measurements taken from a given set of
> +		physical sensors.
> +

> diff --git a/drivers/iio/proximity/hx9031as.c b/drivers/iio/proximity/hx9031as.c
> new file mode 100644
> index 000000000000..7f240b82dc59
> --- /dev/null
> +++ b/drivers/iio/proximity/hx9031as.c
> @@ -0,0 +1,1379 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 NanjingTianyihexin Electronics Ltd.
> + * http://www.tianyihexin.com
> + *
> + * Driver for NanjingTianyihexin HX9031AS & HX9023S Cap Sensor
> + * Author: Yasin Lee <yasin.lee.x@gmail.com>
> + */
> +
> +#include <linux/module.h>
alphabetical order.
Possibly with the iio stuff in a block at the end.
and definitely with asm-generic separate at the end.

> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
Used? If you are, you want to avoid doing so and use firmware
agnostic calls..
> +#include <linux/irq.h>
> +#include <linux/acpi.h>

Used?


> +#include <linux/bitfield.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
Custom attributes?  Didn't spot any so I doubt you need this.

> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <asm-generic/unaligned.h>
> +
> +#define SET_BIT(data, idx)	((data) |= 1 << (idx))
> +#define CLR_BIT(data, idx)	((data) &= ~(1 << (idx)))
> +#define CHK_BIT(data, idx)	((data) & (1 << (idx)))

Do not invent your own macros for this. There are standard
ones in kernel.

> +
> +#define HX9031AS_CHIP_ID 0x1D
> +#define HX9031AS_CH_NUM 5
> +#define HX9031AS_CH_USED 0x1F
> +#define CH_DATA_2BYTES 2
> +#define CH_DATA_3BYTES 3
> +#define CH_DATA_BYTES_MAX CH_DATA_3BYTES
> +#define HX9031AS_ODR_MS 200
> +#define TYHX_DELAY_MS(x) msleep(x)
> +#define HX9023S_ON_BOARD 0
> +#define HX9031AS_ON_BOARD 1
> +#define HX9031AS_CHIP_SELECT HX9023S_ON_BOARD
> +#if (HX9031AS_CHIP_SELECT == HX9023S_ON_BOARD)

No idea what this is, but it doesn't belong in a driver being posted for
upstream.

> +#define CS0 0
> +#define CS1 2
> +#define CS2 4
> +#define CS3 6
> +#define CS4 8
> +#else
> +#define CS0 4
> +#define CS1 2
> +#define CS2 6
> +#define CS3 0
> +#define CS4 8
> +#endif
> +#define IGNORED 16

...
> +struct hx9031as_channel_info {
> +	char name[20];

As below, not clear what point of name is.
If it's just for debug prints, then drop it.

> +	bool enabled;
> +	bool used;
> +	int state;
> +};
>
> +
> +struct hx9031as_data {
> +	struct mutex mutex;
> +	struct i2c_client *client;
> +	struct iio_trigger *trig;
> +	struct regmap *regmap;
> +	unsigned long chan_prox_stat;
> +	bool trigger_enabled;
> +	struct {
> +		__be16 channels[HX9031AS_CH_NUM];
> +
> +		s64 ts __aligned(8);
> +
Drop this blank line as doesn't help readability.
> +	} buffer;
> +	unsigned long chan_read;
> +	unsigned long chan_event; /*channel en bit*/
> +
> +	struct hx9031as_threshold thres[HX9031AS_CH_NUM];
> +	struct hx9031as_channel_info *chs_info;
> +	uint32_t channel_used_flag;
> +	uint8_t ch_en_stat;
> +	int32_t raw[HX9031AS_CH_NUM];
> +	int32_t diff[HX9031AS_CH_NUM];
> +	int32_t lp[HX9031AS_CH_NUM];
> +	int32_t bl[HX9031AS_CH_NUM];

Non obvious naming, so add some documentation.

> +	uint16_t dac[HX9031AS_CH_NUM];
> +	bool sel_bl[HX9031AS_CH_NUM];
> +	bool sel_raw[HX9031AS_CH_NUM];
> +	bool sel_diff[HX9031AS_CH_NUM];
> +	bool sel_lp[HX9031AS_CH_NUM];
> +	uint8_t accuracy;
> +	uint32_t prox_state_reg;
> +};


> +
> +static int hx9031as_data_lock(struct hx9031as_data *data, bool locked)
> +{
> +	int ret;
> +
> +	if (locked) {
> +		ret = regmap_update_bits(data->regmap, HX9031AS_DSP_CONFIG_CTRL1, BIT(4), BIT(4));

#define to give BIT(4) a name.

> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "[%s]i2c read failed\n", __func__);
> +			return ret;
> +		}
> +	} else {
> +		ret = regmap_update_bits(data->regmap,
> +					HX9031AS_DSP_CONFIG_CTRL1,
> +					GENMASK(4, 3),
> +					0x00);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "[%s]i2c read failed\n", __func__);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int hx9031as_get_id(struct hx9031as_data *data)
> +{
> +	int ret;
> +	uint32_t rxbuf[1];
> +
> +	ret = regmap_read(data->regmap, HX9031AS_DEVICE_ID, rxbuf);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "[%s]i2c read failed\n", __func__);
> +		return ret;
> +	}
> +
> +	dev_info(&data->client->dev, "id=0x%02X\n", rxbuf[0]);

Too noisy - at most dev_dbg()

> +	return 0;
> +}
> +
> +static int hx9031as_ch_cfg(struct hx9031as_data *data)
> +{
> +	int ret;
> +	int i;
> +	uint16_t reg;
> +	uint8_t reg_list[HX9031AS_CH_NUM * 2];
> +	uint8_t ch_pos[HX9031AS_CH_NUM] = {CS0, CS1, CS2, CS3, CS4};
> +	uint8_t ch_neg[HX9031AS_CH_NUM] = {IGNORED, IGNORED, IGNORED, IGNORED, IGNORED};
prefix that IGNORED with HX9031AS to avoid a name clash in future.

> +
> +	for (i = 0; i < HX9031AS_CH_NUM; i++) {
> +		reg = (uint16_t)((0x03 << ch_pos[i]) | (0x02 << ch_neg[i]));

> +		reg_list[i * 2] = (uint8_t)(reg);
> +		reg_list[i * 2 + 1] = (uint8_t)(reg >> 8);

		put_unaligned_le16()


> +	}
> +
> +	ret = regmap_bulk_write(data->regmap, HX9031AS_CH0_CFG_7_0, reg_list, HX9031AS_CH_NUM * 2);
> +	if (ret)
> +		dev_err(&data->client->dev, "[%s]i2c write failed\n", __func__);
> +
> +	return ret;
> +}
> +
> +static int hx9031as_reg_init(struct hx9031as_data *data)
> +{
> +	int i = 0;
> +	int ret;
> +
> +	while (i < (int)ARRAY_SIZE(hx9031as_reg_init_list)) {
> +		ret = regmap_bulk_write(data->regmap,
> +				hx9031as_reg_init_list[i].addr,
> +				&hx9031as_reg_init_list[i].val,
> +				1);
> +		if (ret) {
> +			dev_err(&data->client->dev, "[%s]i2c write failed\n", __func__);
> +			return ret;
> +		}
> +		i++;
Use a for loop

> +	}
> +	return ret;
> +}
> +

> +static int32_t hx9031as_set_thres_far(struct hx9031as_data *data, uint8_t ch, int32_t val)
> +{
> +	int ret;
> +	uint8_t buf[2];
> +
> +	val /= 32;
Mask val here by GENMASK(9, 0) I think.

> +	buf[0] = val & 0xFF;
> +	buf[1] = (val >> 8) & 0x03;
This is a masked unaligned_put_le16() so use that.
Could even use an __le16 as the storage.


> +	data->thres[ch].far = (val & 0x03FF) * 32;
Having masked earlier this is just * 32

> +
> +	if (ch == 4) {
> +		ret = regmap_bulk_write(data->regmap, HX9031AS_PROX_LOW_DIFF_CFG_CH4_0, buf, 2);
> +		if (ret)
> +			dev_err(&data->client->dev, "[%s]i2c write failed\n", __func__);
> +	} else {
> +		ret = regmap_bulk_write(data->regmap,
> +					HX9031AS_PROX_LOW_DIFF_CFG_CH0_0 + (ch * CH_DATA_2BYTES),
> +					buf,
> +					2);

sizeof(buf)  also combine last two lines into 1.
					buf, sizeof(buf));

Check for other similar cases.


> +		if (ret)
> +			dev_err(&data->client->dev, "[%s]i2c write failed\n", __func__);
> +	}
> +
> +	return ret;
> +}
> +
> +static void hx9031as_get_prox_state(struct hx9031as_data *data)
> +{
> +	int ret;
> +	uint32_t buf[1];

Just use a 
	unsigned int. 

However, note that it's an unsigned int as the parameter to regmap_read
not a uint32_t which may or may not be the same size.

> +
> +	data->prox_state_reg = 0;
> +	ret = regmap_read(data->regmap, HX9031AS_PROX_STATUS, buf);
> +	if (ret)
> +		dev_err(&data->client->dev, "[%s]i2c read failed\n", __func__);

Don't print function names in error messages.  If you want to do this, look
at dev_fmt() to push it to one location rather than every call.

> +	data->prox_state_reg = buf[0];
> +}
> +
> +static void hx9031as_data_select(struct hx9031as_data *data)
> +{
> +	int ret;
> +	int i;
> +	uint32_t buf[1];
> +
> +	ret = regmap_read(data->regmap, HX9031AS_RAW_BL_RD_CFG, buf);
> +	if (ret)
> +		dev_err(&data->client->dev, "[%s]i2c read failed\n", __func__);
> +
> +	for (i = 0; i < 4; i++) {
> +		data->sel_diff[i] = CHK_BIT(buf[0], i);
> +		data->sel_lp[i] = !data->sel_diff[i];
> +		data->sel_bl[i] = CHK_BIT(buf[0], i + 4);
> +		data->sel_raw[i] = !data->sel_bl[i];
> +	}
> +
> +	ret = regmap_read(data->regmap, HX9031AS_INTERRUPT_CFG1, buf);
> +	if (ret)
> +		dev_err(&data->client->dev, "[%s]i2c read failed\n", __func__);
Dynamic debug can add this sort of info. 
> +
> +	data->sel_diff[4] = CHK_BIT(buf[0], 2);
> +	data->sel_lp[4] = !data->sel_diff[4];
> +	data->sel_bl[4] = CHK_BIT(buf[0], 3);
> +	data->sel_raw[4] = !data->sel_bl[4];
> +}


> +static int hx9031as_update_chan_en(struct hx9031as_data *data,
> +				unsigned long chan_read,
> +				unsigned long chan_event)
> +{
> +	int i;
> +	unsigned long channels = chan_read | chan_event;
> +
> +	if ((data->chan_read | data->chan_event) != channels) {
> +		for (i = 0; i < HX9031AS_CH_NUM; i++) {
> +			if ((data->channel_used_flag >> i) & 0x1) {
> +				if ((channels >> i) & 0x1)
> +					hx9031as_ch_en_hal(data, i, true);
> +				else
> +					hx9031as_ch_en_hal(data, i, false);

Use test_bit() inline.

> +			}
> +		}
> +	}
> +
> +	data->chan_read = chan_read;
> +	data->chan_event = chan_event;
> +	return 0;
> +}

> +
> +static int hx9031as_set_samp_freq(struct hx9031as_data *data, int val, int val2)
> +{
> +	int i;
> +	int ret;
> +	int period_ms;
> +	uint8_t buf[1];
> +
> +	period_ms = 1000000000ULL / (val * 1000000ULL + val2);
> +	dev_info(&data->client->dev, "Freq=%d.%dHz, Period=%dms\n", val, val2, period_ms);
> +
> +	for (i = 0; i < ARRAY_SIZE(hx9031as_samp_freq_table); i++) {
> +		if (period_ms == hx9031as_samp_freq_table[i]) {
> +			dev_info(&data->client->dev,
> +				"Period:%dms found! index=%d\n",
> +				period_ms,
> +				i);

All these prints need to go from a driver being sent for upstream review.
They are noise both in terms of things we won't accept, and make the code
harder to review.

> +			break;
> +		}
> +	}
> +	if (i == ARRAY_SIZE(hx9031as_samp_freq_table)) {
> +		dev_err(&data->client->dev, "Period:%dms NOT found!\n", period_ms);
> +		return -EINVAL;
> +	}
> +
> +	buf[0] = i;
> +	ret = regmap_bulk_write(data->regmap, HX9031AS_PRF_CFG, &buf[0], 1);
> +	if (ret)
> +		dev_err(&data->client->dev, "[%s]i2c read failed\n", __func__);
> +
> +	return ret;
> +}

> +static irqreturn_t hx9031as_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct hx9031as_data *data = iio_priv(indio_dev);
> +
> +	if (data->trigger_enabled)
> +		iio_trigger_poll(data->trig);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static void hx9031as_push_events(struct iio_dev *indio_dev)
> +{
> +	struct hx9031as_data *data = iio_priv(indio_dev);
> +	s64 timestamp = iio_get_time_ns(indio_dev);
> +	unsigned long prox_changed;
> +	unsigned int chan;
> +
> +	hx9031as_sample(data);
> +	hx9031as_get_prox_state(data);
> +
> +	prox_changed = (data->chan_prox_stat ^ data->prox_state_reg) & data->chan_event;
> +
> +	for_each_set_bit(chan, &prox_changed, HX9031AS_CH_NUM) {
> +		int dir;
> +		u64 ev;
> +
> +		dir = (data->prox_state_reg & BIT(chan)) ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
> +		ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan, IIO_EV_TYPE_THRESH, dir);
> +
> +		iio_push_event(indio_dev, ev, timestamp);
No need for local variable for ev just put that stuff inline in the iio_push_event()
		iio_push_event(indio_dev,
			       IIO_UNMOD_EVENT_CODE(...));
The dir one is probably needed to keep line length sensible.


> +		dev_info(&data->client->dev,
> +			"chan=%d, dir=%d, prox_changed=0x%08lX, ev=0x%016llX\n",
> +			chan,
> +			dir,
> +			prox_changed,
> +			ev);

You must not print logs like this for every event. This isn't even appropriate
for dev_dbg()
 

> +	}
> +	data->chan_prox_stat = data->prox_state_reg;
> +}

> +
> +static int hx9031as_write_event_val(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan,
> +				  enum iio_event_type type,
> +				  enum iio_event_direction dir,
> +				  enum iio_event_info info, int val, int val2)
> +{
> +	struct hx9031as_data *data = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_PROXIMITY)
> +		return -EINVAL;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_PERIOD:

Why is a threshold being set with a period control?

> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			return hx9031as_set_thres_far(data, chan->channel, val);
> +		case IIO_EV_DIR_FALLING:
> +			return hx9031as_set_thres_near(data, chan->channel, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int hx9031as_read_event_config(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir)
> +{
> +	struct hx9031as_data *data = iio_priv(indio_dev);
> +	int en_state;
> +
> +	en_state = !!(data->chan_event & BIT(chan->channel));
> +	dev_dbg(&data->client->dev,
> +		"chan_event=0x%016lX, ch%d=%d, en_state=%d\n",
> +		data->chan_event,
> +		chan->channel,
> +		data->chs_info[chan->channel].enabled,
> +		en_state);

You are reading that.  Why bother with the dbg print? It must makes
this much more complex as otherwise it's

	return test_bit(chan->channel, data->chan_event);


> +	return en_state;
> +}
> +
> +static int hx9031as_write_event_config(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				int state)
> +{
> +	struct hx9031as_data *data = iio_priv(indio_dev);
> +
> +	if ((data->channel_used_flag >> chan->channel) & 0x1) {
> +		hx9031as_ch_en_hal(data, chan->channel, !!state);
> +		if (data->chs_info[chan->channel].enabled)
> +			data->chan_event = (data->chan_event | BIT(chan->channel));
set_bit() or __set_bit() if we care about overhead of doing atomically.

> +		else
> +			data->chan_event = (data->chan_event & ~BIT(chan->channel));

clear_bit()

> +	}
> +	return 0;
> +}
> +
> +static const struct iio_info hx9031as_info = {
> +	.read_raw = hx9031as_read_raw,
> +	.write_raw = hx9031as_write_raw,
> +	.write_event_value = hx9031as_write_event_val,
> +	.read_event_config = hx9031as_read_event_config, /*get ch en flag*/
> +	.write_event_config = hx9031as_write_event_config, /*set ch en flag*/
Not sure the comments add anything. I would drop them.
> +};
> +
> +static int hx9031as_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct hx9031as_data *data = iio_priv(indio_dev);
> +
> +	guard(mutex)(&data->mutex);

Can this not be masked at device? If possible do that instead.

> +	if (state)
> +		enable_irq(data->client->irq);
> +	else if (!data->chan_read)
> +		disable_irq_nosync(data->client->irq);
> +	data->trigger_enabled = state;
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops hx9031as_trigger_ops = {
> +	.set_trigger_state = hx9031as_set_trigger_state,
> +};
> +
> +static irqreturn_t hx9031as_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct hx9031as_data *data = iio_priv(indio_dev);
> +	__be16 val;
> +	int bit;
> +	int i = 0;
> +
> +	guard(mutex)(&data->mutex);
> +	hx9031as_sample(data);
> +	hx9031as_get_prox_state(data);
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
> +		val = data->diff[indio_dev->channels[bit].channel];
> +		data->buffer.channels[i++] = val;

Why bounce via val?

> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, pf->timestamp);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +

> +
> +static int hx9031as_init_device(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	int i;
> +	struct hx9031as_data *data = iio_priv(indio_dev);
> +
> +	ret = hx9031as_reg_init(data);
> +	if (ret)
> +		return ret;

blank line here for readability as these two blocks not closely related.

> +	ret = hx9031as_ch_cfg(data);
> +	if (ret)
> +		return ret;
blank line here.
> +	for (i = 0; i < HX9031AS_CH_NUM; i++) {
> +		hx9031as_set_thres_near(data, i, data->thres[i].near);
> +		hx9031as_set_thres_far(data, i, data->thres[i].far);
> +	}
> +
> +	return ret;

return 0;  Can't be anything else.

> +}
> +
> +static int hx9031as_probe(struct i2c_client *client)
> +{
> +	int ret = 0;
> +	int i;
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct hx9031as_data *data;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct hx9031as_data));
> +	if (!indio_dev) {
> +		ret = -ENOMEM;
> +		dev_err_probe(&client->dev, ret, "device alloc failed\n");
> +		return ret;

		return dev_err_probe(dev, -ENOMEM, "device alloc failed\n");
and drop the brackets.
> +	}
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	data->ch_en_stat = 0x00;
> +	data->accuracy = 16;
> +	data->thres[0].near = 320;
> +	data->thres[0].far = 320;
> +	data->thres[1].near = 320;
> +	data->thres[1].far = 320;
> +	data->thres[2].near = 640;
> +	data->thres[2].far = 640;
> +	data->thres[3].near = 640;
> +	data->thres[3].far = 640;
> +	data->thres[4].near = 960;
> +	data->thres[4].far = 960;
> +	data->channel_used_flag = 0x1F;
> +	mutex_init(&data->mutex);
> +
> +	data->chs_info = devm_kzalloc(&data->client->dev,
> +				sizeof(struct hx9031as_channel_info) * HX9031AS_CH_NUM,
> +				GFP_KERNEL);

Fixed size, so just embed this in the struct hx9031as_data rather than requiring
a separate allocation.

> +	if (data->chs_info == NULL) {
> +		ret = -ENOMEM;
> +		dev_err_probe(&data->client->dev, ret, "channel info alloc failed\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < HX9031AS_CH_NUM; i++) {
> +		snprintf(data->chs_info[i].name,
> +			sizeof(data->chs_info[i].name),
> +			"hx9031as_ch%d",
> +			i);
> +		dev_dbg(&data->client->dev,
> +			"name of ch_%d:\"%s\"\n",
> +			i,
> +			data->chs_info[i].name);

Seems unnecessary to carry name around fo rthis dbeug.

> +		data->chs_info[i].used = false;
> +		data->chs_info[i].enabled = false;
defaults anyway given kzalloc so don't set them explicitly.

> +		if ((data->channel_used_flag >> i) & 0x1) {
> +			data->chs_info[i].used = true;
This one may be reasonable to set.
Given this is all you are setting, using
for_each_bit_set() may be more efficient.


> +			data->chs_info[i].state = 0;
state == 0 is default.

> +		}
> +	}
> +
> +	dev_info(&data->client->dev,
> +		"name=%s, addr=0x%02X, irq=%d\n",
> +		client->name,
> +		client->addr,
> +		client->irq);

That's all information trivially found elsewhere; don't fill up the kernel 
log with this.

> +
> +	data->regmap = devm_regmap_init_i2c(client, &hx9031as_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		ret = PTR_ERR(data->regmap);
> +		dev_err_probe(&data->client->dev, ret, "regmap init failed\n");
> +		return ret;
> +	}
> +
> +	ret = devm_regulator_get_enable(&data->client->dev, "vdd");
> +	if (ret) {
> +		dev_err_probe(&data->client->dev, ret, "regulator get failed\n");
> +		return ret;
> +	}
> +
> +	usleep_range(1000, 1100);
> +
> +	ret = hx9031as_get_id(data);
> +	if (ret) {
> +		dev_err_probe(&data->client->dev, ret, "id check failed\n");
> +		return ret;
> +	}
> +
> +	indio_dev->channels = hx9031as_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(hx9031as_channels);
> +	indio_dev->info = &hx9031as_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = "hx9031as";
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret = hx9031as_init_device(indio_dev);
> +	if (ret) {
> +		dev_err_probe(&data->client->dev, ret, "device init failed\n");
> +		return ret;
> +	}
> +
> +	if (client->irq) {
> +		ret = devm_request_threaded_irq(dev,
> +						client->irq,
> +						hx9031as_irq_handler,
> +						hx9031as_irq_thread_handler,
> +						IRQF_ONESHOT,
> +						"hx9031as_event",
> +						indio_dev);
> +		if (ret) {
> +			dev_err_probe(&data->client->dev, ret, "irq request failed\n");
> +			return ret;
> +		}
> +
> +		data->trig = devm_iio_trigger_alloc(dev,
> +						"%s-dev%d",
> +						indio_dev->name,
> +						iio_device_id(indio_dev));

fix alignment - inconsistent with rest of the code.


> +		if (!data->trig) {
> +			ret = -ENOMEM;
> +			dev_err_probe(&data->client->dev, ret, "iio trigger alloc failed\n");
> +			return ret;
> +		}
> +
> +		data->trig->dev.parent = dev;
> +		data->trig->ops = &hx9031as_trigger_ops;
> +		iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +		ret = devm_iio_trigger_register(dev, data->trig);
> +		if (ret) {
> +			dev_err_probe(&data->client->dev, ret, "iio trigger register failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(dev,
> +					indio_dev,
> +					iio_pollfunc_store_time,
> +					hx9031as_trigger_handler,
> +					&hx9031as_buffer_setup_ops);
> +	if (ret) {
> +		dev_err_probe(&data->client->dev, ret, "iio triggered buffer setup failed\n");
> +		return ret;
as below.

> +	}
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret) {
> +		dev_err_probe(&data->client->dev, ret, "iio device register failed\n");
> +		return ret;
		return dev_err_probe(dev, ret, ...);
Same for all similar cases in here.


> +	}
> +
> +	return ret;

return 0;

> +}
> +
> +static int hx9031as_suspend(struct device *dev)
> +{
> +	struct hx9031as_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	disable_irq_nosync(data->client->irq);
> +	return 0;
> +}
> +
> +static int hx9031as_resume(struct device *dev)
> +{
> +	struct hx9031as_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	enable_irq(data->client->irq);

Better to disable these at the device end, than rely on the
interrupt controller to disable them.  Looks like this is easy
to do in the INTERRUPT_CFG register.


> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(hx9031as_pm_ops, hx9031as_suspend, hx9031as_resume);
> +
> +static const struct acpi_device_id hx9031as_acpi_match[] = {
> +	{ .id = "TYHX9031", .driver_data = HX9031AS_CHIP_ID },

This doesn't seem to be in the ACPI ID registry.  That might reflect
it being granted very recently. Whilst I'm on the appropriate ASWG mailing list
I 'might' have missed it.  If so, please call that out explicitly in the patch
description.

Also, use a chip_info structure not the ID in .driver_data.
That can then contain the ID as an element, but a general chip_info type
structure is a lot more flexible and easy to extend.



> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, hx9031as_acpi_match);
> +
> +static const struct of_device_id hx9031as_of_match[] = {
> +	{ .compatible = "tyhx,hx9031as", (void *)HX9031AS_CHIP_ID },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, hx9031as_of_match);
> +
> +static const struct i2c_device_id hx9031as_id[] = {
> +	{ .name = "hx9031as", .driver_data = HX9031AS_CHIP_ID },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, hx9031as_id);
> +
> +static struct i2c_driver hx9031as_driver = {
> +	.driver = {
> +		.name = "hx9031as",
> +		.acpi_match_table = hx9031as_acpi_match,
> +		.of_match_table = hx9031as_of_match,
> +		.pm = &hx9031as_pm_ops,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.probe = hx9031as_probe,
> +	.id_table = hx9031as_id,
> +};
> +module_i2c_driver(hx9031as_driver);
> +
> +MODULE_AUTHOR("Yasin Lee <yasin.lee.x@gmail.com>");
> +MODULE_DESCRIPTION("Driver for TYHX HX9031AS/HX9023S SAR sensor");
> +MODULE_LICENSE("GPL");


