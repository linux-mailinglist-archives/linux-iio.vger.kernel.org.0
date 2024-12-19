Return-Path: <linux-iio+bounces-13650-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500009F7E8F
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37DD77A2FC0
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC032288E2;
	Thu, 19 Dec 2024 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq7KX05v"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6E6225770;
	Thu, 19 Dec 2024 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623642; cv=none; b=ZBgVH/fGyVYzcLF4W5U1Fk94FkCDD9ZxL6v/kxfTk/L3ITqYLeTgIfPasvHtDF9aaERbd1yFWOgzoQtvxkWLDDvvdNNElGmS5kkXO2aBKpbeUBNXGxJScX++nyWBSE/rEir2CGkFimpl0xYuj+wNzBMpsC8XdiHu57FIC/2WIhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623642; c=relaxed/simple;
	bh=33/4awr57J1g0Ra1odSM7CBad4ijwJMFFkUBXlYsDgA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twR5xnJS22iP+NtII6hV3lpfoL8teOPTZxiRF6T7EZvcxwiMu6qa2RXYtge4iJMK7IG9TVT+bSk0+9cQVIkCHTdMwcSxW/tAZEDxXAqW2oMTjTGSdk1EDiPEpTN9oIPqC6uXDvTwkzWDytjx3nD0w3KjJyA1Mvq9e7lGoA0rxUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq7KX05v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2D7C4CECE;
	Thu, 19 Dec 2024 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734623642;
	bh=33/4awr57J1g0Ra1odSM7CBad4ijwJMFFkUBXlYsDgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xq7KX05vrasxto5KC54R0D0nH5RYUK5nRpGUKnVg0GlCjrvea4zf1hRuIdL2YC9fE
	 jKSNeCVqOL1DuiEzjbjdoPF4x74fyTKf73GqntizWCo0+kEv1cSZuFECHGdtHs4XvJ
	 d6yAzkRRIOomabghGrLA0BZ56/URIsNVjX1aktpEaslmByHCycm06uLDIamP/bRjQ3
	 85lmMyACxr00Nfy3hs1BJnA03HRDFA0bozuTlVaPep0hoLuRFzH9221Xl3E+v0aZIm
	 u4+1nhXBSLeMIxMRoefWuIitzrD1yVQtiyVu//Vjpu/Z3eb8pcOfQYBvzQZEdN+eAy
	 VN8b309XgFieQ==
Date: Thu, 19 Dec 2024 15:53:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] doc: iio: ad4695: describe oversampling support
Message-ID: <20241219155353.20675775@jic23-huawei>
In-Reply-To: <20241217-ad4695-oversampling-v1-2-0b045d835dac@baylibre.com>
References: <20241217-ad4695-oversampling-v1-0-0b045d835dac@baylibre.com>
	<20241217-ad4695-oversampling-v1-2-0b045d835dac@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 16:47:29 -0500
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> Add a section to the ad4695 documentation describing how to use the
> oversampling feature. Also add some clarification on how the
> oversampling ratio influences effective sample rate in the offload
> section.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
This describes what I was expecting so all looks good to me.

Obviously need to wait for the spi offload series anyway
so plenty of time for others to take a look.

Thanks

Jonathan

> ---
>  Documentation/iio/ad4695.rst | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/iio/ad4695.rst b/Documentation/iio/ad4695.rst
> index ead0faadff4b..f40593bcc37d 100644
> --- a/Documentation/iio/ad4695.rst
> +++ b/Documentation/iio/ad4695.rst
> @@ -179,12 +179,38 @@ Gain/offset calibration
>  System calibration is supported using the channel gain and offset registers via
>  the ``calibscale`` and ``calibbias`` attributes respectively.
>  
> +Oversampling
> +------------
> +
> +The chip supports per-channel oversampling when SPI offload is being used, with
> +available oversampling ratios (OSR) of 1 (default), 4, 16, and 64.  Enabling
> +oversampling on a channel raises the effective number of bits of sampled data to
> +17 (OSR == 4), 18 (16), or 19 (64), respectively. This can be set via the
> +``oversampling_ratio`` attribute.
> +
> +Setting the oversampling ratio for a channel also changes the sample rate for
> +that channel, since it requires multiple conversions per 1 sample. Specifically,
> +the new sampling frequency is the PWM sampling frequency divided by the
> +particular OSR. This is set automatically by the driver when setting the
> +``oversampling_ratio`` attribute. For example, if the device's current
> +``sampling_frequency`` is 10000 and an OSR of 4 is set on channel ``voltage0``,
> +the new reported sampling rate for that channel will be 2500 (ignoring PWM API
> +rounding), while all others will remain at 10000.  Subsequently setting the
> +sampling frequency to a higher value on that channel will adjust the CNV trigger
> +period for all channels, e.g. if ``voltage0``'s sampling frequency is adjusted
> +from 2500 (with an OSR of 4) to 10000, the value reported by
> +``in_voltage0_sampling_frequency`` will be 10000, but all other channels will
> +now report 40000.

Ah. I forgot there is another series in flight for this and was going to say
that we needed a statement on the frequencies being a common control.
That is there in the spi offload series so all good!

> +
> +For simplicity, the sampling frequency of the device should be set (considering
> +the highest desired OSR value to be used) first, before configuring oversampling
> +for specific channels.
> +
>  Unimplemented features
>  ----------------------
>  
>  - Additional wiring modes
>  - Threshold events
> -- Oversampling
>  - GPIO support
>  - CRC support
>  
> @@ -233,3 +259,11 @@ words, it is the value of the ``in_voltageY_sampling_frequency`` attribute
>  divided by the number of enabled channels. So if 4 channels are enabled, with
>  the ``in_voltageY_sampling_frequency`` attributes set to 1 MHz, the effective
>  sample rate is 250 kHz.
> +
> +With oversampling enabled, the effective sample rate also depends on the OSR
> +assigned to each channel. For example, if one of the 4 channels mentioned in the
> +previous case is configured with an OSR of 4, the effective sample rate for that
> +channel becomes (1 MHz / 4 ) = 250 kHz. The effective sample rate for all
> +four channels is then 1 / ( (3 / 1 MHz) + ( 1 / 250 kHz) ) ~= 142.9 kHz. Note
> +that in this case "sample" refers to one read of all enabled channels (i.e. one
> +full cycle through the auto-sequencer).
> 


