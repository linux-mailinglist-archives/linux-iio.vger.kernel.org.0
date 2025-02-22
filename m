Return-Path: <linux-iio+bounces-15942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D7CA40897
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 14:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3223B189E11C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 13:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CB01EEA4D;
	Sat, 22 Feb 2025 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bd2oLIip"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F21EA90
	for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740229754; cv=none; b=epwqiMLKNq4syOTABUU8WP6F3unDuSVdt9Is3Ypfi79KwsKZOBsewI5SV9xj5YCLtPpafjzuBuVAGEJhZty88VdvpEwIVGK/pq4FRtoqsWwkkMXN+JAm3XbEtyIpLjH+O6hXB98CT6apu+KMxxaYpVoO77OhHvDq3kJIrUWD4Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740229754; c=relaxed/simple;
	bh=nCpcEyJg5Smixx7UZvlmRrrgssAbAbyBruD/4FH/g/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXHMCZ9znOSjGF64Ip/4kqPZLVy/UNUI9E2XjkCsYAbAMr8IGaC8K0gbx92jwzydRhfeiJmSYayp5atI3EXGbQ+2jjUtAsgF7F6HVtelHMHu8rrNCK1AXXzQY5MR9nsruaT6q1I24Hkd19FqSegnY8+lH/fb+TVX97bsDtnRg/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bd2oLIip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8380AC4CED1;
	Sat, 22 Feb 2025 13:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740229753;
	bh=nCpcEyJg5Smixx7UZvlmRrrgssAbAbyBruD/4FH/g/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bd2oLIipOlZUtNmTMau7IbqEiz/NbV/1rKeXcl5P2gf4HI5xfGH1dX3K/6MKublcp
	 tod4gUiCE9BJNP3i9w6DuGqSW5/w9Wul2hAMMR0Ndq+rbkZD3CT+y5U3auhn2xJeaj
	 LzVy+MvN3GBeHFO8FEvtb/WRH9HknNF1Lw+xuk41eXVD6AAOgGJl5bXWFnsdxbJNrC
	 KEMVoQda80OtiH/wTZ+IwFRAyUS6SwuIp7qxqVVcwlXNp90S/R4icUGGxgeG5+sFpI
	 lvE0zhhNeEVovkkRJN0MH2IBSo7TS3FIRoUNJo8C6DNFK3poXS828bdmLVbOZW7QxQ
	 GuJbziuAGETPQ==
Date: Sat, 22 Feb 2025 13:09:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>, Mike
 Looijmans <mike.looijmans@topic.nl>, Phil Reid <preid@electromag.com.au>,
 Marek Vasut <marek.vasut+renesas@gmail.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>, Marek Vasut <marex@denx.de>,
 Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/29] IIO: ADCs: Sparse friendly claim of direct mode
Message-ID: <20250222130903.3c8a47bd@jic23-huawei>
In-Reply-To: <20250217141630.897334-1-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 14:16:00 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Note that a number of the drivers touched in this series have no
> obvious active maintainer, so it would be much appreciated if anyone
> has time to take a look! It is a large series so feel free to review
> any you have time to look at rather than feeling you need to look
> at the whole thing!
> 
> This is effectively part 3 of what will probably be around 5 series
> focused on moving from iio_device_claim/release_direct_mode() to
> iio_device_claim/release_direct(). The new form is more consistent
> with conditional locking semantics and sparse markings have been
> added that let us detect miss-balance between claim and release.
> 
> More details can be found in the cover letter of the first series:
> https://lore.kernel.org/all/20250209180624.701140-1-jic23@kernel.org/
> 
> This series focuses on the ADC drivers.
I'm going to pick up those that have tags just to trim down how
many of these we have in flight (more coming soon ;)

So for now applied. 7-26 and 29.  If anyone has time to look
at 1-6 and 27-28 that would be great.

As normal pushed out as testing initially to give 0-day something
to poke at.

Thanks,

Jonathan

> 
> Jonathan Cameron (29):
>   iio: adc: vf610: Move claim of direct mode to caller of
>     vf610_read_sample and use guard(mutex)
>   iio: adc: vf610: Switch to sparse friendly
>     iio_device_claim/release_direct()
>   iio: adc: ti-ads1100: Use guard(mutex) to allow direct returns
>   iio: adc: ti-ads1100: Switch to sparse friendly
>     iio_device_claim/release_direct()
>   iio: adc: ti-ads1015: Use guard(mutex) and factor out code for
>     INFO_RAW
>   iio: adc: ti-ads1015: Switch to sparse friendly
>     iio_device_claim/release_direct()
>   iio: adc: stm32-dfsdm: Factor out core of reading INFO_RAW
>   iio: adc: stm32-dfsdm: Switch to sparse friendly
>     iio_device_claim/release_direct()
>   iio: adc: ad4030: Switch to sparse friendly
>     iio_device_claim/release_direct()
>   iio: adc: ad7192: Factor out core of ad7192_write_raw() to simplify
>     error handling.
>   iio: adc: ad7192: Switch to sparse friendly
>     iio_device_claim/release_direct()
>   iio: adc: ad7768-1: Move setting of val a bit later to avoid
>     unnecessary return value check
>   iio: adc: ad7768-1: Switch to sparse friendly
>     iio_device_claim/release_direct()
>   iio: adc: ad7606: Switch to sparse friendly
>     iio_device_claim/release_direct()
>   iio: adc: ad7791: Factor out core of ad7791_write_raw() to simplify
>     error handling
>   iio: adc: ad7791: Switch to sparse friendly
>     iio_device_claim/release_direct()
>   iio: adc: ad7793: Factor out core of ad7793_write_raw() to simplify
>     error handling
>   iio: adc: ad7793: Switch to sparse friendly
>     iio_device_claim/release_direct()
>   iio: adc: ad799x: Switch to sparse friendly
>     iio_device_claim/release_direct()
>   iio: adc: ad_sigma_delta: Switch to sparse friendly
>     iio_device_claim/release_direct()
>   iio: adc: at91-sama5d2: Move claim of direct mode up a level and use
>     guard()
>   iio: adc: at91-sama5d2: Switch to sparse friendly
>     iio_device_claim/release_direct()
>   iio: adc: max1027: Move claim of direct mode up one level and use
>     guard()
>   iio: adc: max1027: Switch to sparse friendly
>     iio_device_claim/release_direct()
>   iio: adc: max11410: Factor out writing of sampling frequency to
>     simplify errro paths.
>   iio: adc: max11410: Switch to sparse friendly
>     iio_device_claim/release_direct()
>   iio: adc: mxs-lradc: Switch to sparse friendly
>     iio_device_claim/release_direct()
>   iio: adc: rcar: Switch to sparse friendly
>     iio_device_claim/release_direct()
>   iio: adc: Switch to sparse friendly iio_device_claim/release_direct()
> 
>  drivers/iio/adc/ad4030.c           |  21 ++--
>  drivers/iio/adc/ad7173.c           |   9 +-
>  drivers/iio/adc/ad7192.c           | 119 ++++++++++----------
>  drivers/iio/adc/ad7266.c           |   7 +-
>  drivers/iio/adc/ad7298.c           |   7 +-
>  drivers/iio/adc/ad7380.c           |  56 +++++-----
>  drivers/iio/adc/ad7476.c           |   7 +-
>  drivers/iio/adc/ad7606.c           |  14 ++-
>  drivers/iio/adc/ad7768-1.c         |  10 +-
>  drivers/iio/adc/ad7791.c           |  31 +++---
>  drivers/iio/adc/ad7793.c           |  80 +++++++-------
>  drivers/iio/adc/ad7887.c           |   7 +-
>  drivers/iio/adc/ad7923.c           |   7 +-
>  drivers/iio/adc/ad7944.c           |   7 +-
>  drivers/iio/adc/ad799x.c           |  14 ++-
>  drivers/iio/adc/ad_sigma_delta.c   |   7 +-
>  drivers/iio/adc/at91-sama5d2_adc.c |  54 +++++-----
>  drivers/iio/adc/dln2-adc.c         |   7 +-
>  drivers/iio/adc/max1027.c          |  37 +++----
>  drivers/iio/adc/max11410.c         |  72 ++++++-------
>  drivers/iio/adc/mxs-lradc-adc.c    |  14 ++-
>  drivers/iio/adc/rcar-gyroadc.c     |   9 +-
>  drivers/iio/adc/stm32-adc.c        |   7 +-
>  drivers/iio/adc/stm32-dfsdm-adc.c  |  76 +++++++------
>  drivers/iio/adc/ti-adc084s021.c    |   9 +-
>  drivers/iio/adc/ti-adc108s102.c    |   7 +-
>  drivers/iio/adc/ti-ads1015.c       | 168 ++++++++++++-----------------
>  drivers/iio/adc/ti-ads1100.c       |  44 +++-----
>  drivers/iio/adc/ti-ads1298.c       |   7 +-
>  drivers/iio/adc/ti-ads131e08.c     |  14 ++-
>  drivers/iio/adc/ti-tlc4541.c       |   7 +-
>  drivers/iio/adc/vf610_adc.c        |  36 +++----
>  32 files changed, 440 insertions(+), 531 deletions(-)
> 


