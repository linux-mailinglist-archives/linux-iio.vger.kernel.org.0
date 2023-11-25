Return-Path: <linux-iio+bounces-366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB3A7F8DCE
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 20:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECEB1F20CD6
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 19:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96132F842;
	Sat, 25 Nov 2023 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvVxdyO5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEAE171C7
	for <linux-iio@vger.kernel.org>; Sat, 25 Nov 2023 19:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E75CC433C8;
	Sat, 25 Nov 2023 19:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700939632;
	bh=0pMTcoXCwHtJRdFZBhJodqGwmnMP648ewc0W1JO0iX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TvVxdyO5msPU1STSUW/0S3dp2uCnVj1HA0aAfRgUZpEp7ltLiFR+2Y/ox2W26Jq++
	 c6GKuJoThdtfj8rpBTRMOBlQCw8MT/J65nTGvsyil390J+VXt0zCVZteEjwhiu4Qe9
	 nPcC0Ek7/XXJoLNy8iLKD49NATP+5JbY7GFspfJsSEXeuyF7fanSo3rFpVty8Zw7xH
	 TB9/QIuB7U+2oCnbAECBJhurcRpo0cwA3wa5qF1o5GlgLRCMYzylK9Xro1z84RgVCk
	 ebrnjU8mKkhfUbXoMBL09/ROZHHdwgA2kIpTB5F9vKceFJ7XLQ4OGS5co9COEqnfsl
	 HSSI9WCGn4BhQ==
Date: Sat, 25 Nov 2023 19:13:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Angel Iglesias <ang.iglesiasg@gmail.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Andreas Klinger <ak@it-klinger.de>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] iio: pressure: driver for Honeywell HSC/SSC series
 pressure sensors
Message-ID: <20231125191343.30fc4825@jic23-huawei>
In-Reply-To: <ZV2a213oidterHYZ@sunspire>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
	<20231117164232.8474-2-petre.rodan@subdimension.ro>
	<ZVtSm5f-Qyp8LFFp@smile.fi.intel.com>
	<ZV2a213oidterHYZ@sunspire>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 08:08:27 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> hello,
> 
> first of all, thank you for the code review.
> in the interest of brevity I will skip all comments where I simply remove the block, blankline, or fix indentation.
> 
> On Mon, Nov 20, 2023 at 02:35:39PM +0200, Andy Shevchenko wrote:
> > > +	select HSC030PA_I2C if (I2C)
> > > +	select HSC030PA_SPI if (SPI_MASTER)  
> > 
> > Unneeded parentheses  
> 
> ack
Where you agree, just crop it out. Saves on scrolling!

> > > +	case IIO_CHAN_INFO_RAW:
> > > +		mutex_lock(&data->lock);
> > > +		ret = hsc_get_measurement(data);
> > > +		mutex_unlock(&data->lock);  
> > 
> > Use guard() operator from cleanup.h.  
> 
> I'm not familiar with that, for the time being I'll stick to mutex_lock/unlock if you don't mind.
> 

It's simple and worth taking a look for new drivers as it makes some error paths much much simpler.
I'm sitting on a big set that applies it to quite few IIO drivers.



> > > +	ret = devm_regulator_get_enable_optional(dev, "vdd");
> > > +	if (ret == -EPROBE_DEFER)
> > > +		return -EPROBE_DEFER;  
> > 
> > Oh, boy, this should check for ENODEV or so, yeah, regulator APIs a bit
> > interesting.  
> 
> since I'm unable to test this I'd rather remove the block altogether.
> if I go the ENODEV route my module will never load since I can't see any vdd-supply support on my devboard.
Problem here is why do you think that regulator is optional? Does your device
work with out power?  What is optional is whether the regulator is fixed and
on and hence doesn't need to be in DT or whether it is specified there.
That's unconnected to the enabling in driver.

The call you have here is for when the power supply really is optional.
That is the driver does something different if nothing is supplied on the pin.
Typically this is used when we have option of either an internal reference voltage
or supplying an external one. The absence on an external one means we fallback
to only enabling the internal one.


Jonathan

