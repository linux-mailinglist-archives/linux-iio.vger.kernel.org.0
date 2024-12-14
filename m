Return-Path: <linux-iio+bounces-13472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76949F203B
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 19:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA61E16642F
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 18:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74706198836;
	Sat, 14 Dec 2024 18:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT5Dbf+o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6B28F1;
	Sat, 14 Dec 2024 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734199422; cv=none; b=YwR6WZbu8hJL1htj0jVuupZtUcAwLRr2h25gM/QZTlCqxE0kS2bejVaJZ5MXObJaycZttyJ44YI8oqW7JkdIJYuiCQF+JHysKfxVy88bgVq7FT8hTzOuaB4jJFDRh7H/A70dJ65yhNQC3ihOpyFm9SxNHaxXfLvy1g58hk7SSqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734199422; c=relaxed/simple;
	bh=GhngBH1qQ5YnaWU5AxKJ/v831cYmnjCdshZJcUZaDPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGQMY9CpNw8eztnVAitM7MK4UdUE2Ra1Sb1TC/9XL4BbHa6ZqBPfSY3e58z2UcjBBbGlOTznw/6YVmPgTHlyVUiLq/8jWijVq660PSxaZubR01Ktetpzmp88SxS+EsmBVed5U/mYa0Sw8mPSXNaPLc4ebFhChvopG/qI12YYVqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT5Dbf+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8367EC4CED1;
	Sat, 14 Dec 2024 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734199420;
	bh=GhngBH1qQ5YnaWU5AxKJ/v831cYmnjCdshZJcUZaDPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WT5Dbf+o0MMSTnkeYYb04NHo50xvjz7xgt4gJJG+l+ae9a8DJZzsKm9c7hoF1DVhc
	 RrkzQdIXO0zDgoNu3QKJGahcGSTgli3NvDryXquR4GKudfB+Krh2N7cC4twnzYB3XV
	 R+bZFy6yOfQ/fGGgqH+vMXMs069KhFpyTaUBJfXJhTN6ODk8Ak69JoZwGmDZ05cocG
	 W4vmaHhk3h6ihKz+GucVauk6SSdOelWNtFA8TPYJ4a3sAHjUBPipnqd+Ph3LfmfReO
	 RIJKnC8FZEAHadp+V22NrtaoZk80rkQgR3tGWboFMzrZ8nD3MTy4iqTJ4KY+p9lgvv
	 4thV5+fsVQfzA==
Date: Sat, 14 Dec 2024 18:03:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, rickard.andersson@axis.com, kernel@axis.com
Subject: Re: [PATCH v8 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <20241214180331.1a2600e3@jic23-huawei>
In-Reply-To: <7022f77e-6d54-4b33-97cd-e284cf93e07e@axis.com>
References: <20241126155312.1660271-1-perdaniel.olsson@axis.com>
	<20241126155312.1660271-3-perdaniel.olsson@axis.com>
	<20241201125107.2e62ffcc@jic23-huawei>
	<7022f77e-6d54-4b33-97cd-e284cf93e07e@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 15:02:23 +0100
Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:

> Hi Jonathan
> 
> I'm sorry for the slow response, I've been a little busy lately. 

No problem!  I know that feeling all too well.

> Good point
> about the races. I have now been trying to figure out a way to handle this
> issue. Basically the driver is running in three potentially concurrent use
> cases, sysfs read, triggered buffer and threshold events. The hardware has two
> different main parameters to play with, sampling and irq. Sampling can be either
> single shot or continuous. The irq can be set to trigger on each new sample or
> just on thresholds.
> These are the requirements for the different use cases:
> 
> Sysfs read:
> - Requires irq on each sample.
> - Requires single shot sampling but works in continuous mode.
> 
> Threshold events:
> - Requires irq on thresholds but works with irq on each sample.
> - Requires continuous sampling.
> 
> Triggered buffer:
> - Requires irq on each sample.
> - Requires continuous sampling.
> 
> Basically this means that all use cases work in high irq and high sampling. The
> potential races occur when lowering irq or sampling without synchronization. My
> plan is to claim direct mode from the sysfs read code and the event code. If the
> call to iio_device_claim_direct_mode() returns EBUSY, the code will continue
> without lowering irq or sampling since it knows that the triggered buffer is
> enabled. The triggered buffer will lower both irq and sampling when being
> disabled in a synchronized way. I will also have to introduce a local mutex to
> protect the potential race between enabling events and sysfs read. That problem
> could happen if the triggered buffer is disabled or events are being changed at
> the same time as a sysfs read is waiting for its sample irq. The other potential
> race is between events and the triggered buffer. That race will be avoided by
> setting the thresh_event_lo_active and thresh_event_hi_active before attempting
> to change irq settings. This is implemented in v9 of the driver.

I think the scheme you've gone for more or less works, but some corners that I'll
call out in review of v9

> 


> >> +		return 0;
> >> +
> >> +	ctrl_reg &= ~OPT4060_CTRL_OPER_MODE_MASK;
> >> +	ctrl_reg |= FIELD_PREP(OPT4060_CTRL_OPER_MODE_MASK,
> >> +				OPT4060_CTRL_OPER_MODE_ONE_SHOT);
> >> +
> >> +	/* Trigger a new conversion by writing to CRTL register. */
> >> +	ret = regmap_write(chip->regmap, OPT4060_CTRL, ctrl_reg);
> >> +	if (ret)
> >> +		dev_err(chip->dev, "Failed to set ctrl register\n");
> >> +	return ret;
> >> +}
> >>
> >> +
> >> +static int opt4060_trigger_new_samples(struct iio_dev *indio_dev)
> >> +{
> >> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> >> +	int ret;
> >> +
> >> +	/*
> >> +	 * The conversion time should be 500us startup time plus the integration time
> >> +	 * times the number of channels. An exact timeout isn't critical, it's better
> >> +	 * not to get incorrect errors in the log. Setting the timeout to double the
> >> +	 * theoretical time plus and extra 100ms margin.
> >> +	 */
> >> +	unsigned int timeout_us = (500 + OPT4060_NUM_CHANS *
> >> +				  opt4060_int_time_reg[chip->int_time][0]) * 2 + 100000;
> >> +
> >> +	if (chip->irq) {
> >> +		reinit_completion(&chip->completion);
> >> +		ret = opt4060_trigger_one_shot(chip);
> >> +		if (ret)
> >> +			return ret;
> >> +		if (wait_for_completion_timeout(&chip->completion,
> >> +						usecs_to_jiffies(timeout_us)) == 0) {
> >> +			dev_err(chip->dev, "Completion timed out.\n");
> >> +			return -ETIME;
> >> +		}
> >> +		/*
> >> +		 * The opt4060_trigger_one_shot() function will enable irq on
> >> +		 * every conversion. If the buffer isn't enabled, irq should
> >> +		 * only be enabled for thresholds.
> >> +		 */
> >> +		if (!iio_buffer_enabled(indio_dev)) {  
> > 
> > This is the race with buffer enable / disable in read_raw() call stack. That transition
> > can be avoided by iio_device_claim_direct_mode().  For this one I don't think we care
> > about that potentially blocking reads via sysfs.  That's a common thing anyway
> > for drivers to not support when the buffer is in use because it greatly simplifies the
> > code and normally mixing buffered interface and sysfs reads isn't something anyone does.  
> 
> With the implementation in v9, I can keep allowing sysfs reads also when the buffer is enabled.

Ok. I can see that it doesn't simplify much to do otherwise.


> >>
> >> +static int opt4060_write_event_config(struct iio_dev *indio_dev,
> >> +				      const struct iio_chan_spec *chan,
> >> +				      enum iio_event_type type,
> >> +				      enum iio_event_direction dir, bool state)
> >> +{
> >> +	int ch_sel, ch_idx = chan->scan_index;
> >> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> >> +	int ret;
> >> +
> >> +	if (chan->type != IIO_INTENSITY)
> >> +		return -EINVAL;
> >> +	if (type != IIO_EV_TYPE_THRESH)
> >> +		return -EINVAL;
> >> +
> >> +	ret = opt4060_get_channel_sel(chip, &ch_sel);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (state) {
> >> +		/* Only one channel can be active at the same time */
> >> +		if ((chip->thresh_event_lo_active ||
> >> +			chip->thresh_event_hi_active) && (ch_idx != ch_sel))
> >> +			return -EBUSY;
> >> +		if (dir == IIO_EV_DIR_FALLING)
> >> +			chip->thresh_event_lo_active = true;
> >> +		else if (dir == IIO_EV_DIR_RISING)
> >> +			chip->thresh_event_hi_active = true;
> >> +		ret = opt4060_set_channel_sel(chip, ch_idx);
> >> +		if (ret)
> >> +			return ret;
> >> +	} else {
> >> +		if (ch_idx == ch_sel) {
> >> +			if (dir == IIO_EV_DIR_FALLING)
> >> +				chip->thresh_event_lo_active = false;
> >> +			else if (dir == IIO_EV_DIR_RISING)
> >> +				chip->thresh_event_hi_active = false;
> >> +		}
> >> +	}
> >> +  
> > This makes me a little nervous because we are allowing the control of
> > continous mode from here and the buffer setup and not preventing them
> > running at the same time.  Maybe there are no races, but I'm not convinced.
> > 
> > It is possible to avoid this, but fiddly as we shouldn't directly
> > take the iio_dev->mlock from a driver (which protects the buffer state
> > transitions.  Basically we need to successfully pin the device in
> > either direct or buffered mode and if we miss in both (due to a transition
> > in flight) retry.
> > 
> > There is one example doing this in the max30102.c
> > https://elixir.bootlin.com/linux/v6.12.1/source/drivers/iio/health/max30102.c#L479
> > (that one is weird because we read the channel in an entirely different way depending
> >  on the device mode).

I think you still need this complex dance in at least one place. If nothing
else it makes the code that is protected easier to reason about.

> > 
> > I suspect we have other cases missed during review however.
> > 
> > The tricky bit is that most races around buffer enable are harmless
> > as they tend to mean we get one extra or one less sample pushed to the
> > buffer, or an read that perturbs the buffered capture timing.  So it
> > is fairly hard to spot a real one :(
> > 
> > This one is vanishingly unlikely though so I'm fine taking the driver
> > on the basis you'll take another look at close the race if you agree
> > with my analysis.  The side effect of this one is that we either
> > burn some power when no one is interested, or fail to enable data capture
> > if we hit the race. Neither is great, but not that bad either.
> > 
> > Jonathan
> >   
> 
> I think I have managed to fix this race in v9.
Review underway.

Thanks,

Jonathan

> 
> Best regards / Per-Daniel
> 
> >   
> >> +	return opt4060_event_set_state(indio_dev, chip->thresh_event_hi_active |
> >> +				       chip->thresh_event_lo_active);
> >> +}  
> > 
> >   
> 


