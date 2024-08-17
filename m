Return-Path: <linux-iio+bounces-8547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B809B955864
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD50A1C210FD
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DC09460;
	Sat, 17 Aug 2024 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1WDGQaK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD28F5B;
	Sat, 17 Aug 2024 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723905600; cv=none; b=M1v8M6UmGmn/WUgdkXTDraxiHwtrko2hjgETYkXp21ijllm5udEA6NwSMUedIv0xhhaxS/N36slp96l7Gs1ycrHQOJcXnbnlGEvcL4X8GT8GiyWA/3vjWxeUThCQVusSWxSVd4OudE6dwpROTQyl5/ajtYTeTMxhyB/SlPePPY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723905600; c=relaxed/simple;
	bh=oV7gL9U0OxSz7uICiweR70xLoCxaWWIoKb/tunnLAlg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWjHEL0sYpETbyd8wXsijTLSINtvbHAOpG5UuuO3Pmv6htfaoJ1MBxmIODsQTtKRyba+NwQP0kft8s6z9XJqJPfQBRChHZfi1eqmQtcYXFypoCDqy18cb80y4of6CItyzAJF6153tF5dx8DgoWbA6Grx8iwTnPTu02teVoEuaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1WDGQaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930BEC116B1;
	Sat, 17 Aug 2024 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723905599;
	bh=oV7gL9U0OxSz7uICiweR70xLoCxaWWIoKb/tunnLAlg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V1WDGQaKD+UGy9zLFWKk0w5AUXYm85mOOi+b4QYpLl+4psseon1nyNX1f935aRSMf
	 7Daw/38WIJrtFYUgdSmnjAhFhgFo32uisHsIFjIfKv15dhN6UjFOXo3pIfoH3XhUog
	 7Da3inhQtdk9aRF+mYcAIlsk5287nNF37/XHIcYvQ+lxMPua3TxPvs9Qq0beNVkxNJ
	 UvUAnVEhAqP9mNjSkw6OYTcXqb2CUplhs7pgfDKC2sMzYhPm1wp4ssKaEegT/Cipkp
	 Fwl+OlznvRShmZMfo5JIS3jg/Xm94/cHRlwLLgnyXyJt4+mDQH/zQAKo5QbnD57j0s
	 Fi3Wj++bB69/w==
Date: Sat, 17 Aug 2024 15:39:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] Add light channel for LTR390
Message-ID: <20240817153953.1743e020@jic23-huawei>
In-Reply-To: <20240814113135.14575-1-abhashkumarjha123@gmail.com>
References: <20240814113135.14575-1-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 17:01:32 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Hello,
> 
> The first patch adds a new channel for the ALS feature of the sensor.
> The same configuration of gain and resolution has to be provided for this
> channel as well. As there are two IIO channels now, we would need to
> switch the sensor's mode of operation depending on which sensor is being
> accessed. Hence, mode switching is also provided.
> 
> Then the second patch adds support for calculating `counts_per_uvi` based
> on the current gain and resolution value.

This is v7 mark 2.  I'm confused, but I think I picked up this version
(Seems I'd queued an earlier one and not mentioned it on the list though
so I've dropped that in favour of this).

> 
> Changes in v7:
> - Changed the `ltr390_set_mode` function to do better error handling.
> - Link to v6: https://lore.kernel.org/linux-iio/20240803180950.32821-1-abhashkumarjha123@gmail.com/T/#t
> 
> Changes in v6:
> - Changed IIO_CHAN_INFO_PROCESSED to IIO_CHAN_INFO_RAW
> - Changed the scaling code
> - Link to v5: https://lore.kernel.org/linux-iio/CAG=0Rq+q0WJzMroYwQy-4Ng0aSkTvaw-FEMx68i3MqAZwfteCg@mail.gmail.com/T/#t
> 
> Changes in v5:
> - Replaced the IIO_INTENSITY channel with IIO_LIGHT channel
> - We calculate the lux value directly using `als_data / (gain * int_time)`
> - Provided a scale channel where the scale is 0.6 * WINDOW_FACTOR
> - Link to v4: https://lore.kernel.org/linux-iio/20240730065822.5707-1-abhashkumarjha123@gmail.com/T/#m
> 
> Changes in v4:
> - Added "bitfield.h" include to fix `-Wimplicit-function-declaration`.
> - Link to v3: https://lore.kernel.org/linux-iio/20240729115056.355466-1-abhashkumarjha123@gmail.com/
> 
> Changes in v3:
> - Added cover letter to the patch series.
> - Fixed indentation in the patch description.
> - Patch specific changes are listed below.
> 
> [PATCH v3 1/3]
> 	- Cleaned up the spurious changes made in v2.
> 	- ltr390_set_int_time and ltr390_set_gain now return -EINVAL to
> 	indicate no match.
> 
> [PATCH v3 2/3]
> 	- Used enum ltr390_mode inside the ltr390_data struct.
> 	- Refactored `ltr390_set_mode` function according to the comments in v2.
> 
> [PATCH v3 3/3]
> 	- Simplified the formula for `counts_per_uvi` calculation.
> 	- Removed spurious whitespace changes introduced in v2.
> 
> - Link to v2: https://lore.kernel.org/linux-iio/20240728151957.310237-1-abhashkumarjha123@gmail.com/
> 
> Changes in v2:
> - Split the single patch into 3 patches.
> - Used FIELD_PREP to perform bit shifting.
> - Used enum for mode selection instead of defines.
> - Fixed indentation and whitespace issues pointed out in the comments
> - Replaced `mutex_lock(&data->lock)` with `guard(mutex)(&data->lock)`
> - Provided available values for gain and resolution via `read_avail`
>   instead of sysfs attributes.
> - Refactored `ltr390_set_gain` and `ltr390_set_int_time`.
> - Used early returns instead of single exit points.
> 
> - Link to v1: https://lore.kernel.org/linux-iio/20240718104947.7384-1-abhashkumarjha123@gmail.com/
> 
> Regards,
> Abhash
> 
> Abhash Jha (2):
>   iio: light: ltr390: Add ALS channel and support for gain and
>     resolution
>   iio: light: ltr390: Calculate 'counts_per_uvi' dynamically
> 
>  drivers/iio/light/ltr390.c | 115 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 100 insertions(+), 15 deletions(-)
> 


