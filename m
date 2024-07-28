Return-Path: <linux-iio+bounces-8006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2704993E896
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 18:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F842813DD
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4B26214D;
	Sun, 28 Jul 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8f2uKS8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF92137708;
	Sun, 28 Jul 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722183799; cv=none; b=N1RRNFvvUaio3BQxHwim8/vZc0mdNgMcBHyc7lfFdnrLdmP3yrpKvIaWgoBv7WqnAgJTGFGBeW0tQ2F0bj6zSaDSRYilwydp/nIQKhCBQnRMTRafYBKSI+SxrbphG8GsGS4FdPlk2mZpo2BjQietrh/DVJ574YTbDdf0xkHdFkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722183799; c=relaxed/simple;
	bh=WyeKyzZehO3UtG2EeJ6HiE4fRSfVItVILunyCsUVLx4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGMGXMldbzE3iI8v402XLr4UUNK+TxzeJy3Pk4lQM5TOkdv2Pz7uum8pBgIi865TFOobCKvotQluoNcaD5uhlvZjwnR1pPlZjVOdrg7FIKJIgb0Cr6Zz30H/8FsOKPW6R/OEy09MdeOyEwMIBv+2AS8p7O6TMdPEVEJfGAg90FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8f2uKS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38D7C116B1;
	Sun, 28 Jul 2024 16:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722183798;
	bh=WyeKyzZehO3UtG2EeJ6HiE4fRSfVItVILunyCsUVLx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T8f2uKS8SVyCvSj330Fhgjl5hUUaW6Ew6rQ9lC4okS4hIUJixYxUFNEysq+RcZ/rq
	 MaCw+/pxcuSi0GlYk8KrdOBjhXZPd/QTZd3OZ8F8V4UBUSTMaiM1On8CrnaXXdgRgd
	 DuVp7R3+MzR3N8xV0ksNoyuD1/4mZd8cofHJbg4oLsqzdCUt09WHzscV2FRlPHT7l6
	 uvMH9LMCYqudvPx6le/Bm/EAP4npYO1lrB0heTd9EgJe7CFRhclchYniFXPLY4oiKz
	 tWm7I/DfGiusIMSqduDA6QIO2WLaia+wWkfqso6Z1P7QzLTqzqm8UYh9VX0QYn/wEk
	 ldJS6NAHQUZ2Q==
Date: Sun, 28 Jul 2024 17:23:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/5] ad7380: add support for single-ended parts
Message-ID: <20240728172309.13155e1b@jic23-huawei>
In-Reply-To: <20240726-ad7380-add-single-ended-chips-v1-3-2d628b60ccd1@baylibre.com>
References: <20240726-ad7380-add-single-ended-chips-v1-0-2d628b60ccd1@baylibre.com>
	<20240726-ad7380-add-single-ended-chips-v1-3-2d628b60ccd1@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 17:20:08 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> Adding ad7386/7/8 (16/14/12 bits) unsigned, dual simultaneous sampling,
> single-ended compatible parts, and the corresponding ad7386-4/7-4/8-4
> 4 channels.
> 
> These parts have a 2:1 multiplexer in front of each ADC. They also include
> additional configuration registers that allow for either manual selection
> or automatic switching (sequencer mode), of the multiplexer inputs.
> This commit focus on integrating manual selection. Sequencer mode will
> be implemented later.
> 
> From an IIO point of view, all inputs are exported, i.e ad7386/7/8
> export 4 channels and ad7386-4/7-4/8-4 export 8 channels.
> 
> Inputs AinX0 of multiplexers correspond to the first half of IIO channels
> (i.e 0-1 or 0-3) and inputs AinX1 correspond to second half (i.e 2-3 or
> 4-7). Example for AD7386/7/8 (2 channels parts):
> 
>           IIO   | AD7386/7/8
>                 |         +----------------------------
>                 |         |     _____        ______
>                 |         |    |     |      |      |
>        voltage0 | AinA0 --|--->|     |      |      |
>                 |         |    | mux |----->| ADCA |---
>        voltage2 | AinA1 --|--->|     |      |      |
>                 |         |    |_____|      |_____ |
>                 |         |     _____        ______
>                 |         |    |     |      |      |
>        voltage1 | AinB0 --|--->|     |      |      |
>                 |         |    | mux |----->| ADCB |---
>        voltage3 | AinB1 --|--->|     |      |      |
>                 |         |    |_____|      |______|
>                 |         |
>                 |         +----------------------------
> 
> When switching channel, the ADC require an additional settling time.
> According to the datasheet, data is valid on the third CS low. We already
> have an extra toggle before each read (either direct reads or buffered
> reads) to sample correct data, so we just add a single CS toggle at the
> end of the register write.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Hi Julien

LGTM - only one trivial comment inline.
If nothing else comes up I can change that whilst applying.
I won't be applying today however given this is a new series and has only been
on the list since Friday.

...

> @@ -92,8 +96,24 @@ enum {
>  	AD7380_SCAN_TYPE_RESOLUTION_BOOST,
>  };
>  
> -/* Extended scan types for 14-bit chips. */
> -static const struct iio_scan_type ad7380_scan_type_14[] = {
> +/* Extended scan types for 12-bit unsigned chips. */
> +static const struct iio_scan_type ad7380_scan_type_12_u[] = {
> +	[AD7380_SCAN_TYPE_NORMAL] = {
> +		.sign = 'u',
> +		.realbits = 12,
> +		.storagebits = 16,
> +		.endianness = IIO_CPU

Add trailing commas.  In theory we might expand this structure
in the future.   The only time we don't add trailing commas is
for 'null' terminator type entries where we know anything added
must come before them.


> +	},
> +	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
> +		.sign = 'u',
> +		.realbits = 14,
> +		.storagebits = 16,
> +		.endianness = IIO_CPU
> +	},
> +};

>  
> +/*
> + * Single ended parts have a 2:1 multiplexer in front of each ADC.
> + *
> + * From an IIO point of view, all inputs are exported, i.e ad7386/7/8
> + * export 4 channels and ad7386-4/7-4/8-4 export 8 channels.
> + *
> + * Inputs AinX0 of multiplexers correspond to the first half of IIO channels
> + * (i.e 0-1 or 0-3) and inputs AinX1 correspond to second half (i.e 2-3 or
> + * 4-7). Example for AD7386/7/8 (2 channels parts):
> + *
> + *           IIO   | AD7386/7/8
> + *                 |         +----------------------------
> + *                 |         |     _____        ______
> + *                 |         |    |     |      |      |
> + *        voltage0 | AinA0 --|--->|     |      |      |
> + *                 |         |    | mux |----->| ADCA |---
> + *        voltage2 | AinA1 --|--->|     |      |      |
> + *                 |         |    |_____|      |_____ |
> + *                 |         |     _____        ______
> + *                 |         |    |     |      |      |
> + *        voltage1 | AinB0 --|--->|     |      |      |
> + *                 |         |    | mux |----->| ADCB |---
> + *        voltage3 | AinB1 --|--->|     |      |      |
> + *                 |         |    |_____|      |______|
> + *                 |         |
> + *                 |         +----------------------------
> + *
> + * Since this is simultaneous sampling for AinX0 OR AinX1 we have two separate
> + * scan masks.
> + */

Good. I always like some nice art :)
+ your implementation takes the same approach I would have done.



