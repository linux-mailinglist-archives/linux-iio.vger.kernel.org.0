Return-Path: <linux-iio+bounces-8212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CD1946A59
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 17:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3EA1C20B68
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5793315445E;
	Sat,  3 Aug 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2WqUzP1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F505337F
	for <linux-iio@vger.kernel.org>; Sat,  3 Aug 2024 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722698725; cv=none; b=fe+wwlS4woeUKIKNyevI+e1pW7+DQDKo32Q3iUDPqTPvAUKYAAMYaK1U283oq7hfw6r6avV4KE4yO+iaqn1txGh6J0u+F17S22CYKXv6Ea7vd55OhINorDpJvqBpBfABGCIYyBS8GbinygQaftrpcPOcTzBF0jvRANtJ/jJXsF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722698725; c=relaxed/simple;
	bh=E2jmL3cZHEkfwuCZkhLbIf7mOlNAHNA+HwD4Vc60hy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlSz6eLjd+ywjnsgvcULeSXodQQwJdBTF3oFZTqmMZ2waNedFOLEHIT5DnsAiptsCmFmG6OSqLjQIOnGtAVc8fgYBRPqFq3A6bgZFFXZCzmq0BFg9CYdTrJMgr+mJ6EUREQBhOXXbfEHMBAgiRgol20m6GoTIV+DSqUQt1MXaIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2WqUzP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812DEC4AF09;
	Sat,  3 Aug 2024 15:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722698724;
	bh=E2jmL3cZHEkfwuCZkhLbIf7mOlNAHNA+HwD4Vc60hy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V2WqUzP1WRWwMkj7eIHcCFeFKolgakIirpOr4fvRGWZvMf/QZVbD4mFJNxMxB5hyT
	 8h7MwrDKx5dM3kBxpalghu1sNJ5VMLo4xwljzdoAx0IKVD6bel4byBaNgqVKV4gQwx
	 oBlk4Zn//PWDtQOFXkQo6Csyo8XWlO6j1pg0+h1/s13kRnklMYg0aNzt2Gq+qCaAEW
	 fL2QB+QrAio0gnwUzPWXQgo/sH2HqD5fFxnyLgzRyMg1tYvCh9v0qjHIYJi2oMSIth
	 lWF5f8gjbvggYN65zCv3El7b+ZObkjicmbmPfOEew4XP3w2o0QGrFfIMIE3Vb+bwWp
	 M4mLuJRWqHSoQ==
Date: Sat, 3 Aug 2024 16:25:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arnout Diels <Arnout.Diels@dekimo.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "honda@mechatrax.com" <honda@mechatrax.com>, "Jonathan.Cameron@huawei.com"
 <Jonathan.Cameron@huawei.com>, nuno.sa@analog.com
Subject: Re: iio: adc: ad_sigma_delta:  IRQ issue in conjunction with IMX
 gpio hardware
Message-ID: <20240803162518.79d10cc7@jic23-huawei>
In-Reply-To: <DBBPR04MB79150A4614B6957A759EC31EFEB02@DBBPR04MB7915.eurprd04.prod.outlook.com>
References: <DBBPR04MB79150A4614B6957A759EC31EFEB02@DBBPR04MB7915.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 14:29:24 +0000
Arnout Diels <Arnout.Diels@dekimo.com> wrote:

> Hello,
> 
> I have a remark regarding ad_sigma_delta's IRQ implementation, especially in conjunction with gpio chips that do no support disabling IRQ, but do support masking them on a HW level.
> 
> 
> Specifically I was trying to bring up a ad7192 chip on an IMX8 platform. The IMX8 gpio driver (gpio-msc) does not implement interrupt disabling.
> I was the same issue as others have seen, namelijk that when doing single ADC measurments, the values are stale, because the driver does not wait correctly for the IRQ to come through.
> The fact that this chip muxes an IRQ line with an SPI MISO line is the fundamental cause of all trouble. 
> 
> For one, this requires hardware designers to typically route the pin to two MCU peripherals (an SPI pin and a GPIO pin - to avoid having to support both gpio interrupts and doing SPI transactions on the same pin). But ok, that can be done
> But the second issue, is that on this pin, per definition, not just IRQ edges will be visible, but also MISO data. The driver has to correctly "time" the enablement of the actual IRQ.
> 
> The ad_sigma_delta driver .. does this, but it can only do so much, if the underlying subsystem is limited.
> 
> Practically, in case of the IMX8, the *hardware* supports falling-edge detection, which is needed and I configured correctly. If this is detetected, this then always calls <handle_level_irq>.
> The *AD driver* tries to disable and enable IRQ at the right moments using <disable_irq_nosync> and <enable_irq>.
> 
> But, when reading some single values from sysfs for example, triggering <ad_sigma_delta_single_conversion>, the following scenario plays out:
> 
> - The first time everything goes well: 
>   > SPI command to start sampling
>   > IRQ enabled (HW unmasked to look for falling edges), to wait for conversion finished result muxed on nRDY/MISO pin
>   > Falling edge occurs and irq is done, breaking a waiting loop
>     > During the callback, the interrupt is disabled again.   
> 
>   > SPi command is sent to read out the data  
> 
> 
> But, during the readout command, things go wrong. 
> Since the hardware -cannot- be disabled, it WILL see another falling edge at this point. In fact mulitple during that MISO readout.
> What happens then, depends on other settings. Assuming lazy interrupt disabling is used, this will actually first trigger another interrupt, which then masks future interrupts on a HW level. (Or, this masking is already done sooner).
> However, crucially, MASKING interrupts on a HW level QUEUES them. The subsequent falling edges on the masked hardware will set a bit in the registers, and cause the issue the NEXT readout.
> 
> What then happens on the next readout, is that, when the IRQ is again enabled, it fires IMMEDIATELY (since the previous falling edge was still 'queued' in hardware). 
> 
> (This then leads to the waiting loop to break too soon, and a stale value to be returned)
> 
>  
> 
> ----
> 
> The proper way to deal with this, would be to (optionally) -clear- any HW-saved value when enabling the IRQ. (Or wait a while to "flush" it out as a less elegant solution)
> 
> What I find strange is that that seemingly the same issue is supposedly reported to be fixed last year (https://github.com/torvalds/linux/commit/626d312028bec44209d0ecd5beaa9b1aa8945f7d). 
> However, the "fix" here was to disable lazy IRQ. This does not fix anything when using the IMX8 gpiochip, since this will just mask the HW upfront, rather than waiting another IRQ cycle first.
> 
> 
> 
> I'd love to hear your thoughts on this. 

Thanks for the detailed description.

This is a horrible corner case and honestly I'm not sure there will be interest
in a comprehensive situation to clear the pending interrupts etc.

One option might be to make the interrupt optional. If it's not present then
don't allow the device clocked data capture modes (continuous mode)
and just rely on sleeping to ensure data capture has occurred after a capture
is triggered.  Not great performance wise but it should 'work'.

Given tight coupling of this driver and the ad_sigma_delta shared code I'm not
sure how easy this would be to do.   Maybe an early option would be to
just stop enabling buffered capture.  Then we'd remain in single mode and
maybe all that is needed is a time to sleep value from the device specific
driver.

Jonathan

 
> 
> Kind regards,
> Arnout
> 
> 


