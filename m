Return-Path: <linux-iio+bounces-22048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B85B12FBD
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 15:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758E417612C
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 13:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DA2137932;
	Sun, 27 Jul 2025 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5bp4PnG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91EA7E9;
	Sun, 27 Jul 2025 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753623488; cv=none; b=jlaVNrIrECq5KsM6bCT9STPkFV0a4Dhq/ZrAov87AnLMDo5bSYq+C11AV5KoKpY43hM8bYYRyUBakKK4EwNfdxT3AwvM6v15vlZWjSBrH1gMiMHyGiaFyu80XG27lAulUOO293WqeKE2C0vQJU/Mtrgy/6D9PicFjVutpIsbPiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753623488; c=relaxed/simple;
	bh=W63d++1mImp7daZ8G/o8sLT3DO5aSXl9dxZqiv2V1hU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tu+c624okTosFiBJcqzoxD6avWeXnztFUg1Thdx9f8Mp3ZVHzCXrXd1qzoLA74srg6ZhKMb/mC6+WzRp2PRKTwp7av26xukCbrd0rohFooDWB5VixZwxbWMhKdk2xJevZ8YX4D4WZBpAPFCnDz6UZ5tpBBfJo0uctZHzI3AGutY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5bp4PnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3C4C4CEEB;
	Sun, 27 Jul 2025 13:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753623488;
	bh=W63d++1mImp7daZ8G/o8sLT3DO5aSXl9dxZqiv2V1hU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N5bp4PnGDSzh0LVn2a7Jx2LDYcAzRxKKa6hMexxnIvEg3GQkdRwGAAtbLUUw6upO2
	 ngwp7V0pj8XacZVSeLxUG2czj7ktnI/OAwdGbR/joT2PsAb7+5rXwB8vwWco6X9jl4
	 i15iMYMZg1PpjuSriVX5fnq60+3p95oVacRcuhImHUp/y4PSMiwsOzZNTjsb5eKN1S
	 PsG6B5Mm2tAh8JKmRRQshNzdlysCJUaawtkGwcvIArtFHvpVnieOgRcbkcEHtvu1dB
	 vnMVWK9i2T2DYAHYJRN6qc1DEXKYt0Zt2o8MgnbH+8fYuVoZEYRydbtWk7H+NAKSc2
	 Mwzv5znCKYLwg==
Date: Sun, 27 Jul 2025 14:38:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] Documentation: ABI: iio: adc: add ade9000 ABI
Message-ID: <20250727143801.69cb377d@jic23-huawei>
In-Reply-To: <20250721112455.23948-5-antoniu.miclaus@analog.com>
References: <20250721112455.23948-1-antoniu.miclaus@analog.com>
	<20250721112455.23948-5-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 14:24:45 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add sysfs ABI documentation for the ADE9000 ADC driver,
> documenting the device-specific attributes and interfaces.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  new in v2.
>  .../ABI/testing/sysfs-bus-iio-adc-ade9000     | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ade9000
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ade9000 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ade9000
> new file mode 100644
> index 000000000000..fa92fd67483f
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ade9000
> @@ -0,0 +1,64 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/wf_cap_en
> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Enable fixed data rate for waveform buffer instead of resampled data.
> +		When enabled (1), the waveform buffer uses a fixed data rate.
> +		When disabled (0), the waveform buffer uses resampled data.

I had to go read the datasheet section on this to find out what this means.
It is changing the sampling frequency to the wave form frequency / 128.
We need to figure out how to map this to something related to sampling frequency.
Given the fixes sample rates are 8k or larger, maybe we just use anything below 8K to mean
use this mode?  Bit hacky but mostly that's the right thing to do as line frequencies
tend to be lower than that anyway.

> +
> +		This attribute is shared by all channels and represents a device-wide
> +		setting that affects the entire waveform buffer configuration.
> +		Changes immediately update the hardware configuration.
> +
> +		Reading: Returns current setting (0 or 1)
> +		Writing: Accepts 0, 1
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/wf_mode
> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Waveform buffer filling and trigger mode configuration.
> +
> +		Valid values:
> +		0 - Stop when waveform buffer is full
> +		1 - Continuous fill, stop only on enabled trigger events
> +		2 - Continuous filling, center capture around enabled trigger events
> +		3 - Streaming mode
> +
> +		This attribute is shared by all channels and represents a device-wide
> +		setting that affects the entire waveform buffer configuration.
> +		Changes immediately update the hardware configuration.
> +
> +		Reading: Returns current mode (0-3)
> +		Writing: Accepts values 0, 1, 2, or 3
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/wf_in_en
> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Enable IN waveform samples readout from waveform buffer.
> +		When enabled (1), IN waveform samples are included in buffer readout.

What does buffer readout mean here? Is this the IIO buffer?  In which case why isn't it
just a channel?

> +		When disabled (0), IN waveform samples are excluded from buffer readout.

Hmm. This waveform buffer stuff needs some more thought.  We should really be mapping this
to a buffer with control over the triggering.   Smells a bit like the old impact sensors
but we never actually got those out of staging ;(


I'd be tempted to drop this support from the initial driver so that we can revisit
it and consider it carefully after the main part of the driver is upstream.

Gut feeling is this needs to be using a separate buffer from main channels with
separate trigger controls etc.  The multibuffer stuff is not yet much used so
there may be some core features missing.

> +
> +		This attribute is shared by all channels and represents a device-wide
> +		setting that affects the entire waveform buffer configuration.
> +		Changes immediately update the hardware configuration.
> +
> +		Reading: Returns current setting (0 or 1)
> +		Writing: Accepts 0, 1
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/egy_time
If we keep this, the name definitely needs some work. Probably needs to be standard
ABI as well.

> +KernelVersion:	6.13
That was a while back!

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Energy accumulation time setting for energy registers.
> +		This value configures the time period over which energy
> +		measurements are accumulated in the ADE9000 device.

So this is interesting.  Feels a bit like it corresponds to a low pass filter
on a power measurement? Or kind of scaling on the power measurement but in terms
of timing.  I'd like inputs from others on how to handle this but I don't think
a custom ABI is the way to go

> +
> +		This attribute is shared by all channels and represents a device-wide
> +		setting that affects energy accumulation across all phases.
> +		Changes immediately update the hardware configuration.
> +
> +		Reading: Returns current energy accumulation time value
> +		Writing: Accepts any valid 32-bit unsigned integer value
> +


