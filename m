Return-Path: <linux-iio+bounces-13649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE3B9F7E4F
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DEDF7A1A19
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 15:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC37225768;
	Thu, 19 Dec 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiH6yHNi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A1A3D3B8;
	Thu, 19 Dec 2024 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623183; cv=none; b=kwGoYsaZx328BmoJyOahHB2NqHR9rHZsD3/u2HeUWXLV8ObKWhQU9rTD6mrCs16T0MRVmmukC+DZSLjzA2YDYMpNRVF6JLHMthBV2G/SPwWN9fQexBs4sHbgTW4WY5z6UstHfOiVInI5nyYrsRLXCa5lyuklGnXRGUzvNswCQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623183; c=relaxed/simple;
	bh=r3wbtJLmkn1A1Cj2eVwONnHoWwYroi04P1zMbkgFejI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nO7ERdjsPDQi7b3oYkMLkhQ7DxaGD06EQOBjrkui13NsKG/4Z95lpH5OmTIfABKdYDiuDmYT9R7MJKZsFBfz90RoSHY2VdvNzgAEsn2XRlBUX+vJlb+FH9ArXh+BVdosbhYIJsJUCNNveHV5tTEfma8a7b3K2HpK7gGkOc1D29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiH6yHNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592E2C4CECE;
	Thu, 19 Dec 2024 15:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734623183;
	bh=r3wbtJLmkn1A1Cj2eVwONnHoWwYroi04P1zMbkgFejI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qiH6yHNixfcJX0Y8bmTqGjS4ZHdQCqrZ2omPAYY3JFw2cLWJIH2BJRUeN9eXdAdyJ
	 BLF/yWrrq6tYAUJ9Zet3OuLUw1FTiwKUSRVV41jVVWwKT+zW4e1vXv0GMkBEwmkl0v
	 ADKI9nnjOzlrvMEON4foXY/dTM5WhuXnto66DRkNiJ8IngIHTGx+ranDIeFKPd7Xlc
	 bcbja0qJzy/ziJjWeYXh0G0Hz4CltAKZ+U8lIdncPZxEhfj5bkK2c4eM5GORi+swPL
	 WwU7p6TbxDOozyTc9hnDdQ8lpm+bvnuALwtkXWANtUS5zAZN+BsAHhFymR9zyoWNHw
	 WX8w6xmd/ZUng==
Date: Thu, 19 Dec 2024 15:46:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: adc: ad4695: add oversampling support
Message-ID: <20241219154614.321c1d32@jic23-huawei>
In-Reply-To: <20241217-ad4695-oversampling-v1-0-0b045d835dac@baylibre.com>
References: <20241217-ad4695-oversampling-v1-0-0b045d835dac@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 16:47:27 -0500
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> Add driver logic and documentation for the oversampling feature of the
> AD469x parts from Analog Devices. For now, this only works with offload
> support, and takes advantage of that mode's higher performance to make
> oversampling possible on multiple channels with varying sampling
> frequencies. Some significant rework of the driver had to be done in
> order to conditionally support this feature, including use of
> iio_scan_types to help determine the appropriate spi message
> configurations depending on oversampling ratio.
> 
> A dilemma that came up during development of this feature was whether or
> not the implementation of oversampling ratios against sampling frequency
> was actually correct. More specifically, it's unclear if the sampling
> frequency attribute is supposed to be the conversion rate or the data
> read rate (according to the IIO subsystem). 

Intent was it's the rate at which the reading becomes available to the
software (which I think you are calling data read rate).

In global schemes, it's all of the scan (normally they are
self clocked with delays between scans) in per channel schemes intent
was to provide the sampling rate at which that channel was sampled
if no others were being read (assuming the times sum up in a linear
way etc).

> If it's the former, then
> this implementation is probably incorrect. David Lechner pointed out
> during review that it would be easier if it were defined as the
> conversion rate and that it was userspace's responsibility to handle
> oversampling ratio, but that might also require more work in the IIO
> subsystem.

IIRC there are devices out there were oversampling rate is on top of
their controlled read out rate (which is more about delays between
starting sampling than about how long it takes).  I think one of those
drove the implementation of oversampling in the first place.
It's also not the case that an oversampling rate of x4 always means
that the time to data availability is necessarily 1/4 (can pipeline
some stages depending on the sensor design).

My thinking (it was a long time ago) was that userspace wouldn't want
to deal with the scaling.  We only fairly recently defined the
clear concept of per channel sampling frequencies. Before that they
were (almost?) all global.

Another aspect is that when we originally added this, it was new to userspace
so having defined sampling frequency, we couldn't have it's meaning
changing because oversampling was say a minimum of 2 on a device.

> Two other ADC drivers that were referenced for inspiration
> when working through this were the ad7380 and the rtq6056. The ad7380
> has a global oversampling setting rather than per-channel, and the

I'm not sure it being global matters a lot for question of whether
it takes into account oversampling or not.

> rtq6056 seems at least partially broken because it only takes
> oversampling ratio into account when getting the sampling frequency (but
> not when setting it). 

That is definitely broken and could do with a fix.  We should always
read back more or less the same value written (subject to rounding
etc in some cases).


> Instead of per-driver implementation, these three
> drivers might serve as inspiration for changes to how oversampling is
> handled in IIO?

It is very tricky to make any modifications (other than the fix above)
without making a mess of the ABI.

Or are you suggesting we could so something in the IIO core?  Maybe
some helper functions are appropriate (similar to Matti's GTS stuff
for gains where they are a mixture of various factors on light sensors
and similar.).

Jonathan


> 
> This series depends on David's recent SPI engine changes for adding
> offload support:
> 
> https://lore.kernel.org/all/20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com/
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
> Trevor Gamblin (2):
>       iio: adc: ad4695: add offload-based oversampling support
>       doc: iio: ad4695: describe oversampling support
> 
>  Documentation/iio/ad4695.rst |  36 ++++-
>  drivers/iio/adc/ad4695.c     | 378 +++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 383 insertions(+), 31 deletions(-)
> ---
> base-commit: 0c6c3bf84f541fb4ec7097baf9eac10136f98c62
> change-id: 20241217-ad4695-oversampling-2946fbe3aff3
> 
> Best regards,


