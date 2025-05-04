Return-Path: <linux-iio+bounces-19040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 618A5AA8739
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D048A177106
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 15:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168261A3174;
	Sun,  4 May 2025 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NL4TCN3M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03D74C98;
	Sun,  4 May 2025 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746371772; cv=none; b=d8Pyj7b6tmwfkEQxLhw2ZwM1zom80IeGu53fCRdjC4TEtS+5xAdLI4yq2VXURj3Y7m2nNBgT18aYnhUW/rqLGzRaBlyMtw3uOMgxKKavcVgO1Y/3rGQ1EKaGzNgHBPdKwHxg4YsldvrkWQYt1+i0hqTFwif0MbUJpk7Odnnqlwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746371772; c=relaxed/simple;
	bh=/n7PsIRFaO1tVZEwPgW2xyzPKNMVYKJjsbb3LMBdVsA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gO6p8loCby3ym2Q4FsR8irzy57iOvkf0kj38sHoXOtk/yTlNtcOKdGAhLskKQADnPZfzvVcKdk0WrjFxTiymFp92KdxC4U09+zKFpewbeITF5rAGtx/G9sXskCDlGRFL4eno0fjsqYoyuvReC/TzpYbOYjf7AB68edb6HGt1k3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL4TCN3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E93C4CEED;
	Sun,  4 May 2025 15:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746371772;
	bh=/n7PsIRFaO1tVZEwPgW2xyzPKNMVYKJjsbb3LMBdVsA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NL4TCN3MXJ52+xKz3/98oZNc23fHybZlxWnXCH9thRlJ3lL1rHLuY+JxgKpRs+5w4
	 efLKv7MSs2fBtmSKTyEkj03qgOgNmOlh4+IDrk6lW70clPaWT3Wb0NJP6+4vZe745b
	 t2zffwZZW61KHyqacpXyjJxX1L7j1ihELgZl10h9sn1Io8DCobSXAeTUv8Zt4O53Dg
	 yu6pEPdR8eg7DCI1P6nQ1Qga713CKWu7utBtKhiRlk+c9OtxNl7Eu9dPwJRceev9Mv
	 bDe2VHVbLSf2hYFInR60w5ODfoiv1bjMtnDtNT/C39bIoXl35orsLo60MgHNxcbQYP
	 h5i0rPSRgoUig==
Date: Sun, 4 May 2025 16:16:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Documentation: ABI: IIO: add calibconv_delay
 documentation
Message-ID: <20250504161603.7d1027af@jic23-huawei>
In-Reply-To: <20250502-wip-bl-ad7606-calibration-v2-1-174bd0af081b@baylibre.com>
References: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
	<20250502-wip-bl-ad7606-calibration-v2-1-174bd0af081b@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 May 2025 15:26:58 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add new IIO calibconv_delay documentation.
> 
> The ad7606 implements a phase calibation feature, in nanoseconds.
> Being this a time delay, using the conv_delay suffix.
I made a late reply to v1...

Key point being that, in the general sense this is only a calibration
thing if it is both writeable and we are using it for filter phase correction.
In more general terms it's just a conversion sampling time offset (and as you have
it here in seconds).  I'm keen we define this to incorporate more general
cases including extra read only info on sequencer timing - that can be useful
if we have something like 
                 _____________
Input 0 --------|             |
Input 1 --------| 4 in, 2 out |-----  ADC0
Input 2 --------|  MUX        |
Input 3 --------|_____________|-----  ADC1

That is the ability to schedule more channels across a small number of
simultaneous sampling ADCs.  In these cases we've never had a way to
express what was done together.  Mostly there have been obvious
combinations (i.e. voltage and current at same time on a given wire for
power measurement), but it would still be nice to use your new interface
to allow us to describe what is running here (though probably not control
it as that would be hard to do!)

> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 33c09c4ac60a4feec82308461643134f5ba84b66..56eb42f88999660b5f93f2311b7d57e0303b0647 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -559,6 +559,26 @@ Description:
>  		- a small discrete set of values like "0 2 4 6 8"
>  		- a range specified as "[min step max]"
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibconv_delay

I wonder if simply in_voltageY_delay is enough?  I don't mind
in_voltageY_convdelay  but don't like the calib bit.

I have had requests to stop using underscores in middle of modifiers as they are a pain
to parse - hence convdelay rather than conv_delay

> +KernelVersion:  6.16
> +Contact:        linux-iio@vger.kernel.org
> +Description:
> +		Hardware applied calbiration delay (assumed to fix errors that are
> +		introduced from external circuitry).

Use this a an example of why this might be controllable.  It might be read only
if all it is doing is giving us a richer description of a sequencer.
Something like

		Delay of start of conversion in seconds from common reference point
		shared by all channels.  When used to compensate for delay variation
		in external filters feeding a simultaneous sampling ADC this may
		be referred to as a ...

> +		For the ad7606 ADC series, this value is intended as a time delay,
> +		as an integer plus nanoseconds.
Just call it seconds. Once it reaches userspace it might have different scaling but we 
fix that up with the right number of zeros.
No part specific units...  They all need to be seconds.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibconv_delay_available
> +KernelVersion:	6.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Available values of calibconv_delay. Maybe expressed as:
> +
> +		- a range specified as "[min step max]"
> +
> +		If shared across all channels, <type>_calibconv_delay_available
> +		is used.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
> 


