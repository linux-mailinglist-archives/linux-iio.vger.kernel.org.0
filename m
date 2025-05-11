Return-Path: <linux-iio+bounces-19424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C946AB2819
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 14:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97954171A91
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 12:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCC02566EB;
	Sun, 11 May 2025 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1ye16BP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD10319DF7A;
	Sun, 11 May 2025 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746965680; cv=none; b=qwY1KeWSu0U63D4NeJAKSkX8nJD3JbGlhXq2CF/6KSaS97Wwjyu9iP0681tSJF7CGV2BCgEiDWaRN5fxaCZEZVQs+MdP5vo/dWOS5tNwKNTzx+Ag2iYMFalUQHQjuRdauGnbwm6v+GCqM317GVuBa+p70tgZm3vKecaXdm7ECjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746965680; c=relaxed/simple;
	bh=rPkJ+5iZlXayivkAHRN0FLIytwxlqKxT4ysiT608Pss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dr7ke9wMUil8Yxdqy+7x1AIz7fDCpRaDbLoW94VdxrLX2fdd9EpPf2QZ3x2VNWYRjg3DLaxTN3/uxQcFcvAWurWbk0qVYg1AeR6ovAKeTaa6B1lNAYlWUK0qbBHDWYV/aj36NSu4+MatGloAvb4LFVRgrKggtUuv7i+6rk8A0r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1ye16BP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED19DC4CEE4;
	Sun, 11 May 2025 12:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746965679;
	bh=rPkJ+5iZlXayivkAHRN0FLIytwxlqKxT4ysiT608Pss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a1ye16BPkblW3XzUNOtLCQFbodhUNgYv17U6kdJ8o7ZuQYjOoHBsby1DqnMh+cd7e
	 wPwGv5mmWBaRbms30rGW71aT6DDY5d7cNVkajTzCZ/yMpiY7BZVf4d0VgAitDwxQZT
	 ywSrfADWptF365lfo11VKiTJGsqozM110aXxkxKVL9PAZg1dGMwY2xaui6oJhpXI3P
	 lET0VWQYavoviKhfnRufq2QebbuopA83jH35BxMtjj2I+YssgFdutykkePM99Slf0c
	 gm5iLFZ2J4d7AeZw8pLPIojKdhX755iNsbPNoEqTYZFD7GEcPu3pLKHWacqCir9Lny
	 mXaceEF5pWN1g==
Date: Sun, 11 May 2025 13:14:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
Message-ID: <20250511131432.1c6e381c@jic23-huawei>
In-Reply-To: <c5184074d85b68ca35ccb29ab94d774203b93535.1746802541.git.waqar.hameed@axis.com>
References: <cover.1746802541.git.waqar.hameed@axis.com>
	<c5184074d85b68ca35ccb29ab94d774203b93535.1746802541.git.waqar.hameed@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 May 2025 17:03:03 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> Nicera D3-323-AA is a PIR sensor for human detection. It has support for
> raw data measurements and detection notification. The communication
> protocol is custom made and therefore needs to be GPIO bit banged.
> 
> The device has two main settings that can be configured: a threshold
> value for detection and a band-pass filter. The configurable parameters
> for the band-pass filter are the high-pass and low-pass cutoff
> frequencies and its peak gain. Map these settings to the corresponding
> parameters in the `iio` framework.
> 
> The low-pass and high-pass cutoff frequencies are pairwise for the
> different available filter types. Because of this, only allow to set the
> low-pass cutoff frequency from `sysfs` and use that to configure the
> corresponding high-pass cutoff frequency. This is sufficient to
> unambiguously choose a filter type.
> 
> Raw data measurements can be obtained from the device. However, since we
> rely on bit banging, it will be rather cumbersome with buffer support.
> The main reason being that the data protocol has strict timing
> requirements (it's serial like UART), and it's mainly used during
> debugging since in real-world applications only the event notification
> is of importance. Therefore, only add support for events (for now).
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
Hi Waqar,

Biggest suggestion in here is hide those bitmaps. They are of interest
only at point of reading and writing. I wouldn't use them for device state
elsewhere as they make for much less readable code than using simple
fields in iio_priv() for the state elements and building up the bitmaps
only where needed.

Jonathan

> diff --git a/drivers/iio/proximity/d3323aa.c b/drivers/iio/proximity/d3323aa.c
> new file mode 100644
> index 000000000000..fa08b52636ba
> --- /dev/null
> +++ b/drivers/iio/proximity/d3323aa.c
> @@ -0,0 +1,868 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for Nicera D3-323-AA PIR sensor.
> + *
> + * Copyright (C) 2025 Axis Communications AB
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/bitmap.h>
> +#include <linux/cleanup.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +
> +#define D3323AA_DRV_NAME "d3323aa"

Put that inline where used.  A define like this both implies that various values
must be the same when they need not be and means that we have to go find the
define to fine out what they are set to.  Just setting the strings directly
tends to end up more readable.

> +
> +/*
> + * Register bitmap.
> + * For some reason the first bit is denoted as F37 in the datasheet, the second
> + * as F38 and so on. Note the gap between F60 and F64.
> + */
> +#define D3323AA_REG_BIT_SLAVEA1		0	/* F37. */
> +#define D3323AA_REG_BIT_SLAVEA2		1	/* F38. */
> +#define D3323AA_REG_BIT_SLAVEA3		2	/* F39. */
> +#define D3323AA_REG_BIT_SLAVEA4		3	/* F40. */
> +#define D3323AA_REG_BIT_SLAVEA5		4	/* F41. */
> +#define D3323AA_REG_BIT_SLAVEA6		5	/* F42. */
> +#define D3323AA_REG_BIT_SLAVEA7		6	/* F43. */
> +#define D3323AA_REG_BIT_SLAVEA8		7	/* F44. */
> +#define D3323AA_REG_BIT_SLAVEA9		8	/* F45. */
Perhaps these can be represented as masks using GENMASK() rather than
bits.  A lot of this will be hidden away if you follow suggesting to
only expose that you are using a bitmap to bitbang in the read/write
functions.

> +#define D3323AA_REG_BIT_SLAVEA10	9	/* F46. */
> +#define D3323AA_REG_BIT_DETLVLABS0	10	/* F47. */
> +#define D3323AA_REG_BIT_DETLVLABS1	11	/* F48. */
> +#define D3323AA_REG_BIT_DETLVLABS2	12	/* F49. */
> +#define D3323AA_REG_BIT_DETLVLABS3	13	/* F50. */
> +#define D3323AA_REG_BIT_DETLVLABS4	14	/* F51. */
> +#define D3323AA_REG_BIT_DETLVLABS5	15	/* F52. */
> +#define D3323AA_REG_BIT_DETLVLABS6	16	/* F53. */
> +#define D3323AA_REG_BIT_DETLVLABS7	17	/* F54. */
> +#define D3323AA_REG_BIT_DSLP		18	/* F55. */
> +#define D3323AA_REG_BIT_FSTEP0		19	/* F56. */
> +#define D3323AA_REG_BIT_FSTEP1		20	/* F57. */
> +#define D3323AA_REG_BIT_FILSEL0		21	/* F58. */
> +#define D3323AA_REG_BIT_FILSEL1		22	/* F59. */
> +#define D3323AA_REG_BIT_FILSEL2		23	/* F60. */
> +#define D3323AA_REG_BIT_FDSET		24	/* F64. */
> +#define D3323AA_REG_BIT_F65		25
> +#define D3323AA_REG_BIT_F87		(D3323AA_REG_BIT_F65 + (87 - 65))
> +
> +#define D3323AA_REG_NR_BITS (D3323AA_REG_BIT_F87 - D3323AA_REG_BIT_SLAVEA1 + 1)
> +#define D3323AA_THRESH_REG_NR_BITS                                             \
> +	(D3323AA_REG_BIT_DETLVLABS7 - D3323AA_REG_BIT_DETLVLABS0 + 1)
> +#define D3323AA_FILTER_TYPE_NR_BITS                                            \
> +	(D3323AA_REG_BIT_FILSEL2 - D3323AA_REG_BIT_FILSEL0 + 1)
> +#define D3323AA_FILTER_GAIN_REG_NR_BITS                                        \
> +	(D3323AA_REG_BIT_FSTEP1 - D3323AA_REG_BIT_FSTEP0 + 1)

> +/*
> + * High-pass filter cutoff frequency for the band-pass filter. There is a
> + * corresponding low-pass cutoff frequency for each of the filter types
> + * (denoted A, B, C and D in the datasheet). The index in this array matches
> + * that corresponding value in d3323aa_lp_filter_freq.
> + * Note that this represents a fractional value (e.g. the first value
> + * corresponds to 4 / 10 = 0.4 Hz).
> + */
> +static const int d3323aa_hp_filter_freq[][2] = {
> +	{ 4, 10 },
> +	{ 3, 10 },
> +	{ 3, 10 },
> +	{ 1, 100 },
> +};
> +
> +/*
> + * Low-pass filter cutoff frequency for the band-pass filter. There is a
> + * corresponding high-pass cutoff frequency for each of the filter types
> + * (denoted A, B, C and D in the datasheet). The index in this array matches
> + * that corresponding value in d3323aa_hp_filter_freq.
> + * Note that this represents a fractional value (e.g. the first value
> + * corresponds to 27 / 10 = 2.7 Hz).
> + */
> +static const int d3323aa_lp_filter_freq[][2] = {
> +	{ 27, 10 },
> +	{ 15, 10 },
> +	{ 5, 1 },
> +	{ 100, 1 },
> +};
> +
> +/*
> + * Register bitmap values for filter types (denoted A, B, C and D in the
> + * datasheet). The index in this array matches the corresponding value in
> + * d3323aa_lp_filter_freq (which in turn matches d3323aa_hp_filter_freq). For
> + * example, the first value 7 corresponds to 2.7 Hz low-pass and 0.4 Hz
> + * high-pass cutoff frequency.
> + */
> +static const int d3323aa_lp_filter_regval[] = {
> +	7,
> +	0,
> +	1,
> +	2,
> +};
> +
> +/*
> + * This is denoted as "step" in datasheet and corresponds to the gain at peak
> + * for the band-pass filter. The index in this array is the corresponding index
> + * in d3323aa_filter_gain_regval for the register bitmap value.
> + */
> +static const int d3323aa_filter_gain[] = {
> +	1,
> +	2,
> +	3,
> +};
	1, 2, 3,
is fine for such a short list.

> +
> +/*
> + * Register bitmap values for the filter gain. The index in this array is the
> + * corresponding index in d3323aa_filter_gain for the gain value.
> + */
> +static const u8 d3323aa_filter_gain_regval[] = {
> +	1,
> +	3,
> +	0,
> +};
> +
> +struct d3323aa_data {
> +	struct completion reset_completion;
> +	/*
> +	 *  Since the setup process always requires a complete write of the
> +	 *  _whole_ register bitmap, we need to synchronize it with a lock.
> +	 */
> +	struct mutex regmap_lock;
> +	atomic_t irq_reset_count;
> +	unsigned int irq;
> +
> +	struct device *dev;
> +
> +	/* Supply voltage. */
> +	struct gpio_desc *gpiod_vdd;
> +	/* Input clock or output detection signal (Vout). */

I'd rename. Vout kind of suggests a variable voltage. This seems to just
be a level signal.

> +	struct gpio_desc *gpiod_clk_vout;
> +	/* Input (setting) or output data. */
> +	struct gpio_desc *gpiod_data;
> +
> +	DECLARE_BITMAP(regmap, D3323AA_REG_NR_BITS);
> +
> +	/*
> +	 * Indicator for operational mode (configuring or detecting), i.e.
> +	 * d3323aa_irq_detection() registered or not.
> +	 */
> +	bool detecting;
> +};
> +
> +static int d3323aa_read_settings(struct iio_dev *indio_dev,
> +				 unsigned long *regmap)
> +{
> +	struct d3323aa_data *data = iio_priv(indio_dev);
> +	size_t i;
> +	int ret;
> +
> +	/* Bit bang the clock and data pins. */
> +	ret = gpiod_direction_output(data->gpiod_clk_vout, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = gpiod_direction_input(data->gpiod_data);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(data->dev, "Reading settings...\n");
> +
> +	for (i = 0; i < D3323AA_REG_NR_BITS; ++i) {
> +		/* Clock frequency needs to be 1 kHz. */
> +		gpiod_set_value(data->gpiod_clk_vout, 1);
> +		udelay(500);
> +
> +		/* The data seems to change when clock signal is high. */
> +		if (gpiod_get_value(data->gpiod_data))
> +			set_bit(i, regmap);
> +
> +		gpiod_set_value(data->gpiod_clk_vout, 0);
> +		udelay(500);
> +	}
> +
> +	/* The first bit (F37) is just dummy data. Discard it. */
> +	clear_bit(0, regmap);
> +
> +	/* Datasheet says to wait 30 ms after reading the settings. */
> +	msleep(30);
> +
> +	return 0;
> +}
> +
> +static int d3323aa_write_settings(struct iio_dev *indio_dev,
> +				  const unsigned long *regmap)

Rename regmap. regmap means some specific stuff in the kernel register_bm or something
like that avoids that potential confusion.

However, it would be much easier to read this driver if only this
function and the read one knew about the bitmap stuff.  Inside the reset
of the driver just store and pass around a structure with the various fields.
Then in here use that to build up the bitmap locally and write to the device.
The opposite in read which decodes the bitmap into those fields.

That will make for a more standard and easier to review driver.

> +{
> +	DECLARE_BITMAP(end_pattern, D3323AA_SETTING_END_PATTERN_NR_BITS);
> +	struct d3323aa_data *data = iio_priv(indio_dev);
> +	size_t i;
> +	int ret;
> +
> +	/* Bit bang the clock and data pins. */
> +	ret = gpiod_direction_output(data->gpiod_clk_vout, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = gpiod_direction_output(data->gpiod_data, 0);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(data->dev, "Writing settings...\n");
> +
> +	/* First bit (F37) is not used when writing the register map. */
> +	for (i = 1; i < D3323AA_REG_NR_BITS; ++i) {
> +		gpiod_set_value(data->gpiod_data, test_bit(i, regmap));
> +
> +		/* Clock frequency needs to be 1 kHz. */
> +		gpiod_set_value(data->gpiod_clk_vout, 1);
> +		udelay(500);
> +		gpiod_set_value(data->gpiod_clk_vout, 0);
> +		udelay(500);
> +	}
> +
> +	/* Compulsory end pattern. */
> +	bitmap_write(end_pattern, D3323AA_SETTING_END_PATTERN, 0,
> +		     D3323AA_SETTING_END_PATTERN_NR_BITS);
 
Why not use a larger bitmap with padding for this end pattern
and just write this into that?  At which point this can all be one loop.

> +	for (i = 0; i < D3323AA_SETTING_END_PATTERN_NR_BITS; ++i) {
> +		gpiod_set_value(data->gpiod_data, test_bit(i, end_pattern));
> +
> +		gpiod_set_value(data->gpiod_clk_vout, 1);
> +		udelay(500);
> +		gpiod_set_value(data->gpiod_clk_vout, 0);
> +		udelay(500);
> +	}
> +
> +	/* Datasheet says to wait 30 ms after writing the settings. */
> +	msleep(30);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t d3323aa_irq_detection(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct d3323aa_data *data = iio_priv(indio_dev);
> +	enum iio_event_direction dir;
> +	int val;
> +
> +	val = gpiod_get_value(data->gpiod_clk_vout);

Ideally I'd like a setup where we can wire the interrupt side of this
to one pin and the gpio needed for writing to another.  In practice
they may well be the same pin but that does introduced a bunch of races
and dependency on what the interrupt controller does when an irq
is disabled.

Using one pin as an irq and as a data line is prone to some nasty
corner cases though it works on some SoCs.


> +	if (val < 0) {
> +		dev_err_ratelimited(data->dev,
> +				    "Could not read from GPIO clk-vout (%d)\n",
> +				    val);
> +		return IRQ_HANDLED;
> +	}
> +
> +	dir = val ? IIO_EV_DIR_RISING : IIO_EV_DIR_FALLING;
> +	iio_push_event(indio_dev,
> +		       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> +					    IIO_EV_TYPE_THRESH, dir),
> +		       iio_get_time_ns(indio_dev));
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t d3323aa_irq_reset(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct d3323aa_data *data = iio_priv(indio_dev);
> +	int count = atomic_inc_return(&data->irq_reset_count);
> +

As below. It should be easy enough to have a unified handler and avoid
the need to unregister / reregister the irq.

> +	if (count == D3323AA_IRQ_RESET_COUNT)
> +		complete(&data->reset_completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int d3323aa_reset(struct iio_dev *indio_dev)
> +{
> +	struct d3323aa_data *data = iio_priv(indio_dev);
> +	long time;
> +	int ret;
> +
> +	/*
> +	 * Datasheet says VDD needs to be low at least for 30 ms. Let's add a
> +	 * couple more to allow VDD to completely discharge as well.
> +	 */
> +	gpiod_set_value(data->gpiod_vdd, 0);
> +	msleep(30 + 5);
> +
> +	/*
> +	 * After setting VDD to high, the device signals with
> +	 * D3323AA_IRQ_RESET_COUNT falling edges on CLK/Vout that it is now
> +	 * ready for configuration. Datasheet says that this should happen
> +	 * within D3323AA_RESET_TIMEOUT ms. Count these two edges within that
> +	 * timeout.
> +	 */
> +	atomic_set(&data->irq_reset_count, 0);
> +	reinit_completion(&data->reset_completion);
> +
> +	ret = gpiod_direction_input(data->gpiod_clk_vout);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(data->dev, "Resetting...\n");
> +
> +	gpiod_set_value(data->gpiod_vdd, 1);
> +
> +	/*
> +	 * Datasheet doesn't mention this but measurements have shown that
> +	 * CLK/Vout signal slowly ramps up during the first 1.5 ms after reset.
> +	 * This means that the digital signal will have bogus values during this
> +	 * period. Let's wait for this ramp-up before counting the "real"
> +	 * falling edges.
> +	 */
> +	usleep_range(2000, 5000);
> +
> +	if (data->detecting) {
> +		/*
> +		 * Device had previously been set up and was in operational
> +		 * mode. Thus, free that detection IRQ handler before requesting
> +		 * the reset IRQ handler.
> +		 */
> +		free_irq(data->irq, indio_dev);
> +		data->detecting = false;
> +	}
> +
> +	ret = request_irq(data->irq, d3323aa_irq_reset, IRQF_TRIGGER_FALLING,
> +			  dev_name(data->dev), indio_dev);

Can you keep to a single handler with a check on device state?  This
dance with releasing and requesting irqs is rather complex when all you need
to know is what the irq means and that is state the driver knows.


> +	if (ret)
> +		return ret;
> +
> +	time = wait_for_completion_killable_timeout(
> +		&data->reset_completion,
> +		msecs_to_jiffies(D3323AA_RESET_TIMEOUT));
> +	free_irq(data->irq, indio_dev);
> +	if (time == 0) {
> +		return -ETIMEDOUT;
> +	} else if (time < 0) {
> +		/* Got interrupted. */
> +		return time;
> +	}
> +
> +	dev_dbg(data->dev, "Reset completed\n");
> +
> +	return 0;
> +}
> +
> +static int d3323aa_setup(struct iio_dev *indio_dev, const unsigned long *regmap)
> +{
> +	DECLARE_BITMAP(read_regmap, D3323AA_REG_NR_BITS);
> +	struct d3323aa_data *data = iio_priv(indio_dev);
> +	unsigned long start_time;
> +	int ret;
> +
> +	ret = d3323aa_reset(indio_dev);
> +	if (ret) {
> +		if (ret != -ERESTARTSYS)
> +			dev_err(data->dev, "Could not reset device (%d)\n",
> +				ret);
> +
> +		return ret;
> +	}
> +
> +	/*
> +	 * Datasheet says to wait 10 us before setting the configuration.
> +	 * Moreover, the total configuration should be done within
> +	 * D3323AA_CONFIG_TIMEOUT ms. Clock it.
> +	 */
> +	usleep_range(10, 20);
> +	start_time = jiffies;
> +
> +	ret = d3323aa_write_settings(indio_dev, regmap);
> +	if (ret) {
> +		dev_err(data->dev, "Could not write settings (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = d3323aa_read_settings(indio_dev, read_regmap);
> +	if (ret) {
> +		dev_err(data->dev, "Could not read settings (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	if (time_is_before_jiffies(start_time +
> +				   msecs_to_jiffies(D3323AA_CONFIG_TIMEOUT))) {
> +		dev_err(data->dev, "Could not set up configuration in time\n");
> +		return -EAGAIN;
> +	}
> +
> +	/* Check if settings were set successfully. */
> +	if (!bitmap_equal(regmap, read_regmap, D3323AA_REG_NR_BITS)) {
> +		dev_err(data->dev, "Settings data mismatch\n");
> +		return -EIO;
> +	}
> +
> +	/* Now in operational mode. */
> +	ret = gpiod_direction_input(data->gpiod_clk_vout);
> +	if (ret) {
> +		dev_err(data->dev,
> +			"Could not set GPIO clk-vout as input (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = gpiod_direction_input(data->gpiod_data);
> +	if (ret) {
> +		dev_err(data->dev, "Could not set GPIO data as input (%d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = request_irq(data->irq, d3323aa_irq_detection,
> +			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,

Why both ways?  Add a comment.

> +			  dev_name(data->dev), indio_dev);
> +	if (ret) {
> +		dev_err(data->dev, "Could not request IRQ for detection (%d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	bitmap_copy(data->regmap, regmap, D3323AA_REG_NR_BITS);
> +	data->detecting = true;
> +
> +	dev_dbg(data->dev, "Setup done\n");
> +
> +	return 0;
> +}

> +
> +static int d3323aa_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct d3323aa_data *data = iio_priv(indio_dev);
> +	DECLARE_BITMAP(regmap, D3323AA_REG_NR_BITS);
> +	int ret;
> +
> +	guard(mutex)(&data->regmap_lock);
> +
> +	bitmap_copy(regmap, data->regmap, D3323AA_REG_NR_BITS);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> +		/*
> +		 * We only allow to set the low-pass cutoff frequency, since
> +		 * that is the only way to unambigously choose the type of
> +		 * band-pass filter. For example, both filter type B and C have
> +		 * 0.3 Hz as high-pass cutoff frequency (see
> +		 * d3323aa_hp_filter_freq).

This is somewhat unintiutive userspace inteface.  I'd try and do the best
possible in response to a userspace request.  So if the lp frequency is
already set to one of the values that matches requested hp then use that.
If it's not then pick the one that has best match lp (so nearest) on
assumption userspace is probably about to update the lp side anyway.

Slight fiddlier code than you have here, but a better attempt to figure
out what the users is after than rejecting writes.

> +		 */
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		ret = d3323aa_set_lp_filter_freq(regmap, val, val2);
> +		if (ret)
> +			return ret;
> +		break;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		ret = d3323aa_set_filter_gain(regmap, val);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return d3323aa_setup(indio_dev, regmap);

I'd bury this call in set_lp_filter() and set_fillter_gain() so they
actually do the setting.

> +}

> +
> +static int d3323aa_probe(struct platform_device *pdev)
> +{
> +	DECLARE_BITMAP(default_regmap, D3323AA_REG_NR_BITS);
> +	struct d3323aa_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return dev_err_probe(&pdev->dev, -ENOMEM,
> +				     "Could not allocate iio device\n");
> +
> +	data = iio_priv(indio_dev);
> +	data->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, indio_dev);

Should be unnecessary with the suggested change below.


> +
> +	init_completion(&data->reset_completion);
> +
> +	ret = devm_mutex_init(data->dev, &data->regmap_lock);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Could not initialize mutex (%d)\n", ret);

As already pointed out in other review - look at what dev_err_probe()
does.

> +
> +	/* Request GPIOs. */

This sort of code structure comment adds nothing useful. We can see
you are requesting gpios from the code.  As such, all it can do is
become wrong in future if code is reorganised.  Hence drop the comment.

> +	data->gpiod_vdd = devm_gpiod_get(data->dev, "vdd", GPIOD_OUT_LOW);

This seems to be a supply, not a gpio.  Use the regulator framework.
Make sure to request exclusive use though so you can turn it on and off.
_get_exclusive() etc should ensure no one else is using it.


> +	if (IS_ERR(data->gpiod_vdd))
> +		return dev_err_probe(data->dev, PTR_ERR(data->gpiod_vdd),
> +				     "Could not get GPIO vdd (%ld)\n",
> +				     PTR_ERR(data->gpiod_vdd));
> +
> +	data->gpiod_clk_vout =
> +		devm_gpiod_get(data->dev, "clk-vout", GPIOD_OUT_LOW);
> +	if (IS_ERR(data->gpiod_clk_vout))
> +		return dev_err_probe(data->dev, PTR_ERR(data->gpiod_clk_vout),
> +				     "Could not get GPIO clk-vout (%ld)\n",
> +				     PTR_ERR(data->gpiod_clk_vout));
> +
> +	data->gpiod_data = devm_gpiod_get(data->dev, "data", GPIOD_OUT_LOW);
> +	if (IS_ERR(data->gpiod_data))
> +		return dev_err_probe(data->dev, PTR_ERR(data->gpiod_data),
> +				     "Could not get GPIO data (%ld)\n",
> +				     PTR_ERR(data->gpiod_data));
> +
> +	ret = gpiod_to_irq(data->gpiod_clk_vout);
> +	if (ret < 0)
> +		return dev_err_probe(data->dev, ret, "Could not get IRQ (%d)\n",
> +				     ret);
> +
> +	data->irq = ret;
> +
> +	/* Do one setup with the default values. */
> +	bitmap_zero(default_regmap, D3323AA_REG_NR_BITS);
> +	d3323aa_set_threshold(default_regmap, D3323AA_THRESH_DEFAULT_VAL);
> +	d3323aa_set_filter_gain(default_regmap,
> +				D3323AA_FILTER_GAIN_DEFAULT_VAL);
> +	ret = d3323aa_setup(indio_dev, default_regmap);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info = &d3323aa_info;
> +	indio_dev->name = D3323AA_DRV_NAME
> +	indio_dev->channels = d3323aa_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(d3323aa_channels);
> +
> +	ret = devm_iio_device_register(data->dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Could not register iio device (%d)\n",
> +				     ret);
> +
> +	return 0;
> +}
> +
> +static void d3323aa_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct d3323aa_data *data = iio_priv(indio_dev);
> +
> +	if (data->detecting)
> +		free_irq(data->irq, indio_dev);

So this is an ordering mess.  You should never mix devm handling and
non devm handling - once something happens in probe that is non devm
you stop using devm_* from that point on.

The irq handling in here is complex, but not on fast paths. As such I'd
do devm_irq_request() and if you need to free it do so with devm_free_irq()
in the places where you immediately re request it.  However see above.
That should allow you to to drop this remove callabck.

> +}
> +
> +static const struct of_device_id d3323aa_of_match[] = {
> +	{
> +		.compatible = "nicera,d3323aa",
> +	},
> +	{}
	{ }

Is now standard format for these in IIO.

> +};
> +MODULE_DEVICE_TABLE(of, d3323aa_of_match);
> +
> +static struct platform_driver d3323aa_driver = {
> +	.probe = d3323aa_probe,
> +	.remove = d3323aa_remove,
> +	.driver = {
> +		.name = D3323AA_DRV_NAME,
> +		.of_match_table = d3323aa_of_match,
> +	},
> +};
> +module_platform_driver(d3323aa_driver);
> +
> +MODULE_AUTHOR("Waqar Hameed <waqar.hameed@axis.com>");
> +MODULE_DESCRIPTION("Nicera D3-323-AA PIR sensor driver");
> +MODULE_LICENSE("GPL");


