Return-Path: <linux-iio+bounces-16890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A5AA6352E
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 12:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA03916EF38
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 11:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9965A1A3168;
	Sun, 16 Mar 2025 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB05gxOU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526CA10F2;
	Sun, 16 Mar 2025 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742122969; cv=none; b=lVWrbm6JtlmEP8hAncMGU9FgcqEExQJVXwDcIh/OCukvdGfjvqHaWu1Madx6+m4mrWp0LWTQ8Kz63xfT4a+NyfsprUGb+FBaoYakpz9LhFDzBX/iy/sQfdRlZ2khzKN1jDeRHnPqhfqHgJX21QwzZlY9SImkhvbS5id/UX3HWuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742122969; c=relaxed/simple;
	bh=GjgXFuSkKYCqC5gatyBw2YKekvHRrwOiavBqOKQJTaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHPcOoFwNOCLR20jPcNi+w+xTT5CQ6YD1PWsu0GtA6X4mrlPYa/wMrKSi/j0zgn/m5NFsFtbPHF2ezd7/STK4DZAExONlplxSXyzX/ZiLifOziAonjdvz3wn3DJIGrbfBkGBiMhEDCnE1stQQNEnhJ3l7eA7AFoShbxMBSEtuDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB05gxOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA39C4CEDD;
	Sun, 16 Mar 2025 11:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742122968;
	bh=GjgXFuSkKYCqC5gatyBw2YKekvHRrwOiavBqOKQJTaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fB05gxOU49v7IQc0PCoUUGf0Kjmojj3J21rynhXI+MYlqiAs3Yh22DPcCsZtVVhxw
	 j6Qt8ChWfdGLjdy+F15FhDEjHZNUpBHBkRp+q6ED9xmTiiWnP0v77BFh7VWUjpRlSq
	 QXvGgdteLavRpwtf7JTfn8Iz1xbSTPsKIOfCJpFhesMfHGE5xBmzEFJmuIlTfiHr4c
	 remWOJ9bL0EtpDXDygrt+d3kundI3G7m2gpD8KGEz1V8BubI/GKSwOrlOfJQfNgP1T
	 OOYYIKfSgYKRcDGfbrJOWVlw/RwNuGC7MoT1J9b+9Wdv/H708LGlrWbbnP827kjF0k
	 8MeA6mB9klGTw==
Date: Sun, 16 Mar 2025 11:02:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Guillaume Stols
 <gstols@baylibre.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, Trevor
 Gamblin <tgamblin@baylibre.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, =?UTF-8?B?Sm/Do28=?=
 Paulo =?UTF-8?B?R29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 06/10] iio: adc: Support ROHM BD79124 ADC
Message-ID: <20250316110237.0b558248@jic23-huawei>
In-Reply-To: <b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
	<b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 09:19:03 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
> an automatic measurement mode, with an alarm interrupt for out-of-window
> measurements. The window is configurable for each channel.
> 
> The I2C protocol for manual start of the measurement and data reading is
> somewhat peculiar. It requires the master to do clock stretching after
> sending the I2C slave-address until the slave has captured the data.
> Needless to say this is not well suopported by the I2C controllers.
> 
> Thus the driver does not support the BD79124's manual measurement mode
Given you are going to be doing a v8 and I'm bored on a train, so utterly
trivial comments that you get as a frequent contributor as things to
consider for future patches. (I'm sure it's just what you always wanted
:)


In theory should be imperative though I don't care as much as some.

Hence, do not support the....

> but implements the measurements using automatic measurement mode relying
> on the BD79124's ability of storing latest measurements into register.
> 
> The driver does also support configuring the threshold events for
> detecting the out-of-window events.
Trivial editorial comment: that 'does' is not providing anything use
in modern English (might have done in the past, no idea!)

"Also support configure the threshold..."

> 
> The BD79124 keeps asserting IRQ for as long as the measured voltage is
> out of the configured window. Thus the driver masks the received event
> for a fixed duration (1 second) when an event is handled. This prevents
> the user-space from choking on the events
> 
> The ADC input pins can be also configured as general purpose outputs.
> Those pins which don't have corresponding ADC channel node in the
> device-tree will be controllable as GPO.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

A few trivial things inline.

Jonathan

> +/*
> + * The high and low limits as well as the recent result values are stored in
> + * the same way in 2 consequent registers. The first register contains 4 bits
> + * of the value. These bits are stored in the high bits [7:4] of register, but
> + * they represent the low bits [3:0] of the value.
> + * The value bits [11:4] are stored in the next regoster.
> + *
> + * Conver the integer to register format and write it using rmw cycle.
Convert?

> + */
> +static int bd79124_write_int_to_reg(struct bd79124_data *data, int reg,
> +				    unsigned int val)
..
> +static int bd79124_read_event_config(struct iio_dev *iio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct bd79124_data *data = iio_priv(iio_dev);
> +
> +	if (chan->channel >= BD79124_MAX_NUM_CHANNELS)
> +		return -EINVAL;
> +
> +	return (data->alarm_monitored[chan->channel] & BIT(dir));

Drop the outer brackets as not adding anything.

> +}



> +static int bd79124_probe(struct i2c_client *i2c)
> +{
...

> +	data->gpio_valid_mask = gpio_pins;
> +	data->gc = bd79124gpo_chip;
> +	data->gc.parent = dev;
> +	devm_mutex_init(dev, &data->mutex);

ret = devm_mutex_init(dev, &data->mutex);
if (ret)
	return ret;

It is very unlikely to fail so no point in papering over failing
to register the cleanup.

> +
> +	ret = devm_gpiochip_add_data(dev, &data->gc, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "gpio init Failed\n");
> +
> +	if (i2c->irq > 0) {
> +		ret = devm_request_threaded_irq(dev, i2c->irq,
> +			bd79124_irq_handler, &bd79124_event_handler,
> +			IRQF_ONESHOT, "adc-thresh-alert", iio_dev);
> +		if (ret)
> +			return dev_err_probe(data->dev, ret,
> +					     "Failed to register IRQ\n");
> +	}
> +
> +	return devm_iio_device_register(data->dev, iio_dev);
> +}


