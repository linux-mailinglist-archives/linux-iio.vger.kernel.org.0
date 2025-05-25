Return-Path: <linux-iio+bounces-19903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6624AC352D
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 16:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CB618954D1
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F38A18132A;
	Sun, 25 May 2025 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl/lLkMX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341544C62;
	Sun, 25 May 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748183424; cv=none; b=eFO1mucHNiA4ENspWDfI+oiKmltGFss6jWkdDboxuwrdwWoXQStt3SMSNUDKCpzvKWxJxzbOB2FlvM3teX0A+ez6uT0rZLcliGqUuK3O3K2lSsR8CdkvIrkv6E6NYnzyVAH43YEblKukc5KPdn6klk34NIEpPeY5W3yGBu0dj+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748183424; c=relaxed/simple;
	bh=YJqvH3zGM/8Uo7x//e887VjASChSXbUM7aUo8amNqtc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jS8aq0lAQ1hnNAecuK9dyM9XGcGR3WV8WxBr96K4czj8ohevo4or3ps6CkcC4XQrrhtALRIvh+3gX8jNLt3ldB9+5txJQ7RQMNd2+JIU56oZpAYITA4unoTs1wW7iBr+GKecfyX7YBFVsxBuQHhYXwHocFMRqgUuEpL1w7Nshe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl/lLkMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EF9C4CEEA;
	Sun, 25 May 2025 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748183423;
	bh=YJqvH3zGM/8Uo7x//e887VjASChSXbUM7aUo8amNqtc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hl/lLkMXUs4uFHVAG+D9pm7I35B7NYV7AqR64iIiPb1lgkKDObMc4405cBzYRWr1e
	 x5XBNI+zOGrbVUWg3s8++DG6ZPeyXuHxxKkzd6fV1BpEXh9rXghvlRNGTdk+qa+kzg
	 Yv8Gr+3D2pmSY2GmD3g35Cz0OFv9JcFGlxpMhdioyVFicvUA12CP5lSymUp1MSJLaj
	 degYqhc8UlY1WPF52MAwhzHJjCSe39WD7c+otIvoPuqXfFXvNz648uLWYCdEZXp7dw
	 IrLxCSA/M/go0zpj7TBTCnTXrxENOYvN2F4KxpkAt2ANU2BT4kVAj1k+3lKJT7BxoZ
	 XqL6oeyCGpKjw==
Date: Sun, 25 May 2025 15:30:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
 andriy.shevchenko@linux.intel.com, arthur.becker@sentec.com,
 perdaniel.olsson@axis.com, mgonellabolduc@dimonoff.com,
 muditsharma.info@gmail.com, clamor95@gmail.com, emil.gedenryd@axis.com,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <20250525153013.1ffdf4e0@jic23-huawei>
In-Reply-To: <20250519060804.80464-3-ak@it-klinger.de>
References: <20250519060804.80464-1-ak@it-klinger.de>
	<20250519060804.80464-3-ak@it-klinger.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 08:08:03 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Add Vishay VEML6046X00 high accuracy RGBIR color sensor.
> 
> This sensor provides three colour (red, green and blue) as well as one
> infrared (IR) channel through I2C.
> 
> Support direct and buffered mode.
> 
> An optional interrupt for signaling green colour threshold underflow or
> overflow is not supported so far.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Hi Andreas

A few little additions from me.

The one about iio_push_to_buffers_with_ts() is entirely up to you.
When I introduce new features like that I tend to give a window before insisting
on them being done by driver authors. It's unfair to insist when they crossed
with your code and the extra cost of one more driver on a big conversion is
trivial.

Jonathan


> diff --git a/drivers/iio/light/veml6046x00.c b/drivers/iio/light/veml6046x00.c
> new file mode 100644
> index 000000000000..d45fda49692d
> --- /dev/null
> +++ b/drivers/iio/light/veml6046x00.c

> +struct veml6046x00_scan_buf {
> +	__le16 chans[4];
> +	aligned_s64 timestamp;
> +};

You moved the definition inline but forgot to delete this one I think.
So drop it.


> +/*
Might as well be kernel-doc

/**

> + * veml6046x00_gain_pd - translation from gain index (used in the driver) to
> + * gain (sensor) and PD
> + * @gain_sen:	Gain used in the sensor as described in the datasheet of the
> + *		sensor
> + * @pd:		Photodiode size in the sensor
> + */
> +struct veml6046x00_gain_pd {
> +	int gain_sen;
> +	int pd;
> +};
> +
> +#define VEML6046X00_GAIN_PD(_gain_sen, _pd)				\
> +{									\
> +	.gain_sen = (_gain_sen),					\
> +	.pd = (_pd),							\
> +}

Macro not used any more so drop it.

> +
> +static const struct veml6046x00_gain_pd veml6046x00_gain_pd[] = {
> +	{.gain_sen = VEML6046X00_GAIN_0_5, .pd = VEML6046X00_PD_1_2},
{ .gain 

So add spaces after { and before }
> +	{.gain_sen = VEML6046X00_GAIN_0_66, .pd = VEML6046X00_PD_1_2},
> +	{.gain_sen = VEML6046X00_GAIN_0_5, .pd = VEML6046X00_PD_2_2},
> +	{.gain_sen = VEML6046X00_GAIN_0_66, .pd = VEML6046X00_PD_2_2},
> +	{.gain_sen = VEML6046X00_GAIN_1, .pd = VEML6046X00_PD_2_2},
> +	{.gain_sen = VEML6046X00_GAIN_2, .pd = VEML6046X00_PD_2_2},
> +};
> +
> +/*
> + * Factors for lux / raw count in dependency of integration time (IT) as rows
> + * and driver gain in columns
> + */
> +static const u32 veml6046x00_it_gains[][6][2] = {
> +	/* integration time: 3.125 ms */

> +	/* integration time: 400 ms */
> +	{
> +		{ 0,  42000 },	/* gain: x0.25 */
> +		{ 0,  31817 },	/* gain: x0.33 */
> +		{ 0,  21000 },	/* gain: x0.5 */
> +		{ 0,  15909 },	/* gain: x0.66 */
> +		{ 0,  10500 },	/* gain: x1 */
> +		{ 0,   5250 }	/* gain: x2 */

Convention is trailing comma for anything that isn't an explicit
terminator.  That tends to apply even when w know there will never
be more elements like here.  Same for earlier sub arrays.

> +	},
> +};

> +
> +static int veml6046x00_single_read(struct iio_dev *iio,
> +					enum iio_modifier modifier, int *val)
> +{
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int addr, it_usec, ret;
> +	__le16 reg;
> +
> +	switch (modifier) {
> +	case IIO_MOD_LIGHT_RED:
> +		addr = VEML6046X00_REG_R;
> +		break;
> +	case IIO_MOD_LIGHT_GREEN:
> +		addr = VEML6046X00_REG_G;
> +		break;
> +	case IIO_MOD_LIGHT_BLUE:
> +		addr = VEML6046X00_REG_B;
> +		break;
> +	case IIO_MOD_LIGHT_IR:
> +		addr = VEML6046X00_REG_IR;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = veml6046x00_get_it_usec(data, &it_usec);
> +	if (ret < 0)
> +		return ret;

Why is suspending not appropriate if this fails?
Sure comms may well be dead, but maybe we should try?
If not a comment is needed on why not.

> +
> +	ret = regmap_field_write(data->rf.mode, 1);
> +	if (ret)
> +		return ret;

As above.

> +
> +	ret = regmap_field_write(data->rf.trig, 1);
> +	if (ret)
> +		return ret;

As above.

> +
> +	/* integration time + 10 % to ensure completion */
> +	fsleep(it_usec + it_usec / 10);
> +
> +	ret = veml6046x00_wait_data_available(iio, it_usec * 10);
> +	if (ret != 1)
> +		goto no_data;
> +
> +	if (!iio_device_claim_direct(iio))
> +		return -EBUSY;
> +
> +	ret = regmap_bulk_read(data->regmap, addr, &reg, sizeof(reg));
> +	iio_device_release_direct(iio);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	*val = le16_to_cpu(reg);
> +
> +	return IIO_VAL_INT;
> +
> +no_data:
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return -EAGAIN;
> +}

> +
> +static irqreturn_t veml6046x00_trig_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio = pf->indio_dev;
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	int ret;
> +	struct {
> +		__le16 chans[4];
> +		aligned_s64 timestamp;
> +	} scan;
> +
> +	memset(&scan, 0, sizeof(scan));

Can use
	} scan = {};

as a shorter way to ensure it's zeroed.
The scattering of memset date back to me not being sure if {} zero's
holes. The C spec recent versions say that it does, and the kernel build options
should ensure it does.


> +
> +	ret = regmap_bulk_read(data->regmap, VEML6046X00_REG_R,
> +					&scan.chans, sizeof(scan.chans));
> +	if (ret)
> +		goto done;
> +
> +	iio_push_to_buffers_with_timestamp(iio, &scan, iio_get_time_ns(iio));

I've recently merged 
iio_push_buffers_with_ts() that in addition takes sizeof(scan) as a parameter
and allows the core code to run a sanity check that we haven't gotten the
size wrong. As it looks like you are respinning anyway, please consider
using that. I won't insist on it as it is very new and there are lots
of drivers to convert anyway so one more doesn't matter much!

> +
> +done:
> +	iio_trigger_notify_done(iio->trig);
> +
> +	return IRQ_HANDLED;
> +}


