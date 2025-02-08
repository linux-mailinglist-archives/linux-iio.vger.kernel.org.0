Return-Path: <linux-iio+bounces-15165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76041A2D6A0
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 15:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8333AA3F7
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 14:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0E02475EB;
	Sat,  8 Feb 2025 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzjsT0pW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0AF182BC;
	Sat,  8 Feb 2025 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739025325; cv=none; b=Pb92ioV+eZ3pl2CvVBAQvcfU6mZ2+/o38k5e7GzsvnnVJk+RvWNHf/+sI2l0R1RwShqywkUgwFIgD8J6TaUfAAG9zQqe2TK75uRa02GVyKqjHB4ciqpFHtv5YkX0qXmfqpDSTePrEUgT0JkCEejbWHNv0cinA2cmcXQkmF20CxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739025325; c=relaxed/simple;
	bh=aBF1RM7ns4mvKouKEITmUpZR7BuFcLU+O2CgksQs/+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYati4tXrkqd6fD3NnkRv2hyykAVnmpPnuOagjkyT/vo4oHsOpcoC19nPO7wd3qz/TfADavveZkHlCdKvHlUFUFxHfiSqur6Hwsyrekl18gj6Qj+zwrjPlOrKWaYs+FKB5JUTl8sDUY8+8pJMO3rmsETzneNOwHJU//MqCdgS2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzjsT0pW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1E1C4CED6;
	Sat,  8 Feb 2025 14:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739025324;
	bh=aBF1RM7ns4mvKouKEITmUpZR7BuFcLU+O2CgksQs/+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nzjsT0pWTU8VSdyg6NRGrXWAeRSFyCqSEOTt2guNZB73ngNLeMpr7tG0EvgU/C10n
	 gIYB21NpPvWWAGpE7jeVNa0JxWoNpJNpgKI56sSDM7RiqowXXZyr1ZT5vwhUKyhAQZ
	 c8ufQYlZ4/OQwZoSN6EvaHdOgpv7l+tgz0sRJyxXxgz6mr3874uOjajUlnJrFHXp2r
	 2sgAXH4ajr6bEfRko7f9X+eUHcftDP8zdsiM05vnw507wEUnaOcKLmSI/pyF1j2tud
	 1TfFdvIBuEYu4k/RnRNOiXXUfJQNPahwryeQZilF47rEEWCJP4pYCy2GCwO0z/j5jQ
	 dYmpDpr7RSCEA==
Date: Sat, 8 Feb 2025 14:35:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>, "Rob Herring (Arm)"
 <robh@kernel.org>, Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Ramona Gradinariu
 <ramona.bolboaca13@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>
Subject: Re: [PATCH v4 2/3] iio: adc: ad7191: add AD7191
Message-ID: <20250208143514.1db3510f@jic23-huawei>
In-Reply-To: <3f03b03d-9f41-4683-a284-df48afbee83e@baylibre.com>
References: <20250203133254.313106-1-alisa.roman@analog.com>
	<20250203133254.313106-3-alisa.roman@analog.com>
	<3f03b03d-9f41-4683-a284-df48afbee83e@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> 
> 
> > +
> > +static const struct iio_chan_spec ad7191_channels[] = {
> > +	{
> > +		.type = IIO_TEMP,
> > +		.address = AD7191_CH_TEMP,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_OFFSET),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),  
> 
> Should this one be info_mask_separate?
> 
> Since this is a multiplexed ADC and not simelutaneous sampling, I would expect
> that if the ORD pins are set to 10Hz (0.1s period), then a buffered read with
> all channels enabled would take 0.3s to do the 3 samples (effective sample rate
> of 3.33Hz), but if only one channel was enabled in the buffer, then it only
> takes 0.1s to do all of the samples (effective sample rate is 10Hz).
> 
> The iio convention is to use info_mask_separate for the sampling_frequency
> attribute to indicate that the rate only applies to each individual channel
> and not the combined rate to do one "set" of samples for all enabled channels.
> 
> A sampling_frequency attribute that was shared_by_all would mean that on each
> period equivlent to this rate, all samples are read no matter how many channels
> were enabled for a buffered read.

I think this device channel selection is onehot.  As such only one channel
is ever enabled at a time. See num_slots in ad_sigma_delta
which is set to 1 if not specified. We could argue that maybe one day the
infrastructure will be added to make that code deal with dynamic channel 
changes, settling time and all that mess though so maybe it should be
separate even though it makes no difference today.

Jonathan


