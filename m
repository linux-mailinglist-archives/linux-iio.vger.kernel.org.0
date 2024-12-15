Return-Path: <linux-iio+bounces-13497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1D09F242F
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 14:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722C91652E1
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 13:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28E318871A;
	Sun, 15 Dec 2024 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNTfSF5b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5417B502;
	Sun, 15 Dec 2024 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734269178; cv=none; b=ggWxIELpvgL6ISuDSzdImk76O/GT8UE4eJRRea9C9HSuDQa8y0zGq8Y17w5ulG+pT5YcWdtBQhNRXf24a8/R8ksnX1bD35Ds9GHjaCxK2IUjQCFC2tJgr/O9zjrnt+2OpTZQGgrR/Jf69a4i2AhLm40kGNk4DaQQGh4x2XCYe58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734269178; c=relaxed/simple;
	bh=dsIJ6JoGWNsDX1O0LfN9jADbUMGR+qvtfxh6FrqqK6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mA3lWHjlVXAXJEu245JbX23JV1weEwfbfho6TNnSPo+6v/cGTmF4XDXbwm9EW8XAEaZkKXX2tFVj3IQ60hmLPB3QzxQViPKrFJQ6TscrJF51JsAczenhl4nsujlnAsaYMYsoFRRosYy9pIjr49xXDYmw5VYVpsJjpBt1ecmHN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNTfSF5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4AFC4CECE;
	Sun, 15 Dec 2024 13:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734269177;
	bh=dsIJ6JoGWNsDX1O0LfN9jADbUMGR+qvtfxh6FrqqK6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BNTfSF5bB0v5zNyGtzMj1qRs/JdYyTapUe3bq/nWfjXWaWrsNNcaIah8R4Y6LnZmj
	 Wq2YD6Xzy7mtr28geT7RgtyY4S8y9/VX43X2uU+EEzsBslSYSHlqgy7el+7c04+iTJ
	 qaswPsAsOLrXW9+v5Y1Cx4vi7+AHK7NrBKs+gQNWG5Pq1VxVMARcWr1voltz1XQid8
	 h7KHRJNHo44tvWK3TZsHzEaOlcJVlzIpvv+6OIR9bQT+cim+CVyKKShbJ/N4dnNXRC
	 fTCadZq0WserSzEmEhhO4rrR1EntnyVsYtQ66dEshCii5iYZ1yK8xlds8SHrK+ohgf
	 NTHdykeTfVMzA==
Date: Sun, 15 Dec 2024 13:26:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Ranquet <granquet@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Mauro Carvalho
 Chehab <mchehab@kernel.org>
Subject: Re: [PATCH RFC] iio: adc: ad7173: add openwire detection support
 for single conversions
Message-ID: <20241215132610.4d488f3d@jic23-huawei>
In-Reply-To: <CABnWg9spateMzOnAGL42GmSbnhL5vwsMpwBm+rGVe4DAdyj6=A@mail.gmail.com>
References: <20241115-ad4111_openwire-v1-1-db97ac8bf250@baylibre.com>
	<b296a23d-bc65-481c-a194-cb16535d8c24@baylibre.com>
	<CABnWg9spateMzOnAGL42GmSbnhL5vwsMpwBm+rGVe4DAdyj6=A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Dec 2024 07:41:01 -0800
Guillaume Ranquet <granquet@baylibre.com> wrote:

> On Mon, 18 Nov 2024 21:48, David Lechner <dlechner@baylibre.com> wrote:
> >On 11/15/24 4:34 AM, Guillaume Ranquet wrote:  
> >> Some chips of the ad7173 family supports open wire detection.
> >>
> >> Generate a threshold event whenever an external source is disconnected
> >> from the system input on single conversions.
> >>
> >> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> >> ---
> >> Hi.
> >>
> >> This patch adds the openwire detection support for the ad4111 chip.
> >>
> >> The openwire detection is done in software and relies on comparing the
> >> results of two conversions on different channels.
> >>
> >> As presented here, the code sends a THRESH Rising event tied to the
> >> in_voltageX_raw channel on which it happened.
> >>
> >> We think this is not correct but we can't seem to find an implementation
> >> that would be elegant.
> >>
> >> The main idea would be to add a specific channel for openwire detection
> >> but we still would need to have the openwire enablement and threshold
> >> tied to the voltage channel.
See below, but a few things in this intro that will make that
make more sense...

The threshold does make things fiddlier. I wonder if the right value
is a actually always a hardware circuit characteristic and should be
encoded in firmware.  That may not help though as we still need
to trigger an explicit test of the channel if I understand correctly.


> >>
> >> Any thought on this?
> >>  
> >Just to spell this out in a bit more detail, my understanding is that
> >the procedure works like this...
> >
> >To detect an open wire on a single-ended input, we measure the voltage
> >on pin VIN0 using channel register 15, the we read the voltage on the
> >same pin again using channel register 0. The datasheet isn't clear on
> >the details, but on one or the other or both of these, the ADC chip is
> >applying some kind of pull up or pull down on the input pin so that
> >each measurement will be nearly the same if there is a wire attached
> >with a 0-10V signal on it. Or if the wire is detached and the pins are
> >left floating, the two measurements will be different (> 300 mV).

Ok. So it's a kind of input impedance measure.

> >
> >So this threshold value (the 300 mV) is measured in terms of the
> >difference between two voltage measurements, but of the same input pin.
> >
> >My suggestion is to create extra differential channels like
> >in_voltage0-involtage100_* where 100 is an arbitrary number. These
> >channels would be defined as the difference between the two measurements
> >on the same pin. The event attributes would use these channels since they
> >are triggered by exceeding the threshold value according to this difference
> >measurement.
> >
> >To complicate matters, these chips can also be configured so that two
> >input pins can be configured as a fully differential pair. And we can
> >also do open wire detection on these differential pairs. In this case
> >we would configure input pins VIN0 and VIN1 as a differential pair, then
> >read the difference of those two pins using channel register 1, then
> >read again using channel register 2. The we see if the difference of the
> >two differences exceeds the threshold.
> >
> >In this case, we can't have in_(voltage0-voltage1)-(voltage100-voltage101)_*
> >attributes. So I guess we would have to do something like
> >in_voltage200-voltage300 to handle this case? (voltage200 would represent
> >the first measurement of voltage0-voltage1 and voltage300 would represent
> >the 2nd measurement of the same).  
That's getting non intuitive fast.

We already have the channels, so maybe if we are doing something that is
channels specific we should have a trigger attribute on the relevant channel.
_check that runs any appropriate checks.  That doesn't give the reporting path
though.

> 
> Hi Jonathan,
> 
> I was wondering if you had any opinions on this RFC?

You caught me hiding from the tricky question :)  This was always the last email
in my todo list because almost all the others were easier!

Hmm. Lack of sensible handling for hardware failure of this sort of
'wire fell out' category has been a long term kernel gap in general, not
just in IIO.  I've talked to various maintainers etc about it over the years
and it was always in the category of things that were interesting but no one
had the time to take on.

I've never really come up with a satisfactory plan on what to do about it.
With my server kernel engineer hat on, I think there are masses of well established
paths for what is basically a RAS event, but are those well suited for embedded
ADC cases.  To give background on how we do it for big systems (ignoring EDAC as
that's definitely not relevant here).

1) Error detection anywhere in software spits out a tracepoint.
2) Tracepoints are scooped up by interested software. The opensource project for
   those is RASdaemon https://github.com/mchehab/rasdaemon
   +CC Mauro - my goto person for RAS events :)
   Note that any other interested application with sufficient priv can also listen
   for those tracepoints.

So what to do for embedded cases. I'd love a general agreement as a wire out is a wire
out whether it's an spi bus wire, a line to a camera or a input line to an ADC but
maybe that's a stretch too far.

So we could do:
a) Something a bit like you have here. Squirt it out as some sort of event on an
   IIO channel. I think it needs to be on the normal channel and not care about the
   complexity of how it is done under the hood. The solution of magic channels is
   way too device specific.   That may mean new attributes to trigger the check
   and new events to report a failure.   + New event types - I'm fine with a top
   level code for this if we go that way rather than using THRESH.
b) Do the triggering of checks as above (may well use a userspace script to do that
   periodically or even an in kernel thread).
   Spit the error out as a RAS trace event.  We'd need to try and define some general
   it broke event structures to avoid a massive proliferation with all the userspace
   tooling mess that brings.

Mauro, how does a trace event sound for this sort of thing to you?  Do you think we'd
get any sort of general adoption?  It's a bit early to poke the likely folk (hwmon,
SPI, I2C, other buses, maybe clk, regulator etc + all the the other subsytems that
have the sort of signals where wire out or short are common events to detect) but
if we feel it is a path forwards then I guess I'm sure we can put together a
good proposal for what will end up as a stable set of tracepoints.

IIO folk, would a trace event be too hard to deal with?  Steven Rostedt has some
nice libraries etc that wrap up all the complexity pretty well.  The tracepoint
syntax itself to declare them takes some getting used to but once you've got your
head around them is really neat.

Jonathan

> 
> Thx,
> Guillaume.


