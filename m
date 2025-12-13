Return-Path: <linux-iio+bounces-27064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A23CBB133
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 17:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36FB7301BEB7
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C39026D4E5;
	Sat, 13 Dec 2025 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWaKDDzC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA8218AAD;
	Sat, 13 Dec 2025 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765642609; cv=none; b=MES+eKhzSKHUH+zKlr//c7OcWWZy5fQuuZUpzW/TBv5SoQIKbcI0LEDwb6aEFP2vp99Nf8aZo0d6lr+9lm2VzxQTY/O52HF0hQtELBes4+oBw1oJ3LPikjbgOOcI2+sLLlkG9oUcPiuWVDB6fXTu0r8HILekLiHOisaOlRNwMZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765642609; c=relaxed/simple;
	bh=2FPFf9fkqbxYPA7xMLGYCzp0XXfQz6y4pI1f2CaedUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpjsGlDt6+CUcftO8d8jCVCXavgw1ERnv6mjyBzomV2gg5VT3DYKGQDIloCV4gw7gK2+J710NupuQV62St71XzyD3VHzP5PzEyZt0uEr5IDpT4uXvjqpwQZ+rmBfEpqoe96m/mADK/4l6737GlGg5jyHaBmsLsEbv/u52ADnPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWaKDDzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E310C4CEF7;
	Sat, 13 Dec 2025 16:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765642607;
	bh=2FPFf9fkqbxYPA7xMLGYCzp0XXfQz6y4pI1f2CaedUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tWaKDDzCiqR+3V9frkjruTNgVDAOQyCqUTsfUpRaAtJQ+HE90xSOUj/ydZRGUp4hA
	 9jSRcRi5sTXkoI42rwTkhuMxO4PVuXyGXD1OPtGF6ni/6aul06JCrGBC78aB8JxTa3
	 IkSERRrvqAoIkIoXuQkrOu0qyBlZuXDlknH5aGO0x2JhelNGsbr5YgC7GiNjmVi4D6
	 YppmqgpNYYunUFOSmBlRvTov+Zkq2EEaX31ihOq9TrajS3WHkZb48DSkVQEaG/IJmL
	 YG0Ss2x3TRf47hMUbBN0d4ys0fSrUjbY3/7XNKpwqdkjD4/9M5xNm9oX0NJgoXaVR/
	 5PYNH4t8+RVtw==
Date: Sat, 13 Dec 2025 16:16:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Kurt Borja" <kuurtb@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Tobias Sperling"
 <tobias.sperling@softing.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 2/2] iio: adc: Add ti-ads1018 driver
Message-ID: <20251213161638.4b5df606@jic23-huawei>
In-Reply-To: <DEU8P8MUASOG.228OIP4QQDZD1@gmail.com>
References: <20251204-ads1x18-v6-0-2ae4a2f8e90c@gmail.com>
	<20251204-ads1x18-v6-2-2ae4a2f8e90c@gmail.com>
	<20251206200721.5e683a83@jic23-huawei>
	<DES3ZWAKXXEB.2LQPMDZN4JFCB@gmail.com>
	<5b843df0-138e-4e2e-a70d-beb8a39ed85f@baylibre.com>
	<20251207195613.0e222b3a@jic23-huawei>
	<DESJEELPCGK3.3H15VL3YAC0RT@gmail.com>
	<04aee30f-908b-4390-934a-e49990217d15@baylibre.com>
	<DEU8P8MUASOG.228OIP4QQDZD1@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Dec 2025 23:08:33 -0500
"Kurt Borja" <kuurtb@gmail.com> wrote:

> On Mon Dec 8, 2025 at 11:00 AM -05, David Lechner wrote:
> > On 12/7/25 10:06 PM, Kurt Borja wrote:  
> >> On Sun Dec 7, 2025 at 2:56 PM -05, Jonathan Cameron wrote:  
> >>> On Sun, 7 Dec 2025 11:12:51 -0600
> >>> David Lechner <dlechner@baylibre.com> wrote:
> >>>  
> >>>> On 12/7/25 10:02 AM, Kurt Borja wrote:  
> >>>>> On Sat Dec 6, 2025 at 3:07 PM -05, Jonathan Cameron wrote:    
> >>>>>> On Thu, 04 Dec 2025 13:01:28 -0500
> >>>>>> Kurt Borja <kuurtb@gmail.com> wrote:
> >>>>>>    
> >>>>>>> Add ti-ads1018 driver for Texas Instruments ADS1018 and ADS1118 SPI
> >>>>>>> analog-to-digital converters.
> >>>>>>>
> >>>>>>> These chips' MOSI pin is shared with a data-ready interrupt. Defining
> >>>>>>> this interrupt in devicetree is optional, therefore we only create an
> >>>>>>> IIO trigger if one is found.
> >>>>>>>
> >>>>>>> Handling this interrupt requires some considerations. When enabling the
> >>>>>>> trigger the CS line is tied low (active), thus we need to hold
> >>>>>>> spi_bus_lock() too, to avoid state corruption. This is done inside the
> >>>>>>> set_trigger_state() callback, to let users use other triggers without
> >>>>>>> wasting a bus lock.
> >>>>>>>
> >>>>>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>    
> >>>>>
> >>>>> ...
> >>>>>     
> >>>>>>> +#define ADS1018_VOLT_CHAN(_index, _chan, _realbits) {				\
> >>>>>>> +	.type = IIO_VOLTAGE,							\
> >>>>>>> +	.channel = _chan,							\
> >>>>>>> +	.scan_index = _index,							\
> >>>>>>> +	.scan_type = {								\
> >>>>>>> +		.sign = 's',							\
> >>>>>>> +		.realbits = _realbits,						\
> >>>>>>> +		.storagebits = 16,						\
> >>>>>>> +		.shift = 16 - _realbits,					\
> >>>>>>> +		.endianness = IIO_BE,						\
> >>>>>>> +	},									\
> >>>>>>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> >>>>>>> +			      BIT(IIO_CHAN_INFO_SCALE) |			\
> >>>>>>> +			      BIT(IIO_CHAN_INFO_SAMP_FREQ),			\    
> >>>>>>
> >>>>>> What motivates per channel sampling frequency?
> >>>>>>
> >>>>>> Given you have to write it each time you configure I guess it doesn't matter much
> >>>>>> either way.    
> >>>>>
> >>>>> I guess making it shared by all is simpler too, so I'll go with that.
> >>>>>     
> >>>> Just keep in mind that if there is ever some use case we don't know
> >>>> about that would require a different rate per channel, we can't change
> >>>> it without breaking usespace. Once the decision is made, we are
> >>>> locked in. Keeping it per-channel seems more future-proof to me.  
> >>>
> >>> Only way I can think of that might cause that to matter would be
> >>> if the complex dance to avoid the onehot buffer restriction is added.
> >>> Given you gave this response I went looking and that might make
> >>> sense as an enhancement as the SPI protocol would allow a crafted message
> >>> sequence to do this efficiently.  Extension of figure 15 where first message
> >>> sets config and after that they read out channel and set config for next one.  
> >> 
> >> This is possible, yes. But would the timestamp even make sense in this
> >> case? Even in the fastest sampling rate, we would have to wait at least
> >> 1 ms for each channel and the timestamp would become stale.
> >> 
> >> That was my reasoning for using the onehot restriction.
> >> 
> >> Is that acceptable? Or maybe we would need to disallow the timestamp
> >> channel if more than one channel is selected?  
> >
> > Yes. We have pretty much the same situation with timestamps on every
> > other ADC. The timestamp is usually when one full set of samples is
> > triggered. Not when the actual individual conversions are performed.  
> 
> This is good to know for future patches or drivers. Thanks!
In theory we have the ABI to describe the relative timing, but meh, it's
rarely useful to do so. Hence we don't use it except in very odd corner cases.
See docs for in_voltageY_convdelay in Documentation/ABI/testing/sysfs-bus-iio

I've vaguely thought about suggesting we use that more widely but no one has
asked for it.  Use cases that I came across are things like 
complex filters across multiple channels (think of orientation tracking
if they were accelerometer axis).

So generally probably not a good idea to describe it at all. :)

Jonathan


> 
> 


