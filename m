Return-Path: <linux-iio+bounces-21035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1411AEC821
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED1F1890FD5
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410B421FF36;
	Sat, 28 Jun 2025 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQMtmK4f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99CF20125F;
	Sat, 28 Jun 2025 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751123053; cv=none; b=kvemAkPby89loPEpdEyK+F9u1zmEJitLWjQwvlaKLBBtprhdVAVlIoywLY6dGvkT0uq/RMAwwEHiL5NeRKURcOgiwCs1KpyNL7izfD1qk7A6tF00zf7a2yv7f9ler3OzB8KvKy7oTerf2ezt+smdyVEaBh8B7c8HSk88BfbheF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751123053; c=relaxed/simple;
	bh=OD/sDaIteeknyhO36WRs78FTQSA8fSteu6BSvgNmYs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3L4AjvVwmgcDGXNdrx2JTOR1rodc8uBfE0JPn8/ercuS23k9roB6MUeco1+XM7fzAkWrllpJi5dTQNZ83UQ2P9a1HOlaEQ7gyQPvqd9N03n+hZx7XDNPB5SKZBznLE7UU4Cq82pPrpU1vwl9fLum6kct30Nm32aFG929ckz1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQMtmK4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EB0C4CEEA;
	Sat, 28 Jun 2025 15:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751123052;
	bh=OD/sDaIteeknyhO36WRs78FTQSA8fSteu6BSvgNmYs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JQMtmK4fnEaiIMTO205snN+7til9HwpCthof3HVgvqmIsBmBqv3iZxJ4YnqAYbCYh
	 Y/0osQqB7ifSWGmd4Y5ioFu145e54tdq2cn7xK6yDgSGe0Ryx7e0bKuootbsoi6r8q
	 KPt9Vy1Fm+XoE1LIKdtDgH1XtN895rY/gXtxZOX12zmNDVk3cD620aTNrFcizLpUyd
	 xbFT3OIYEG0tkfzgMya/SkFnb6z2wfkSpCDUxl4SfbZll2IvWX4A+YKe5Mk1M0TszH
	 Kmuv2ALavyNIlshn+AyiESll5oqNAdebevsA+gL7m1BXLixFESVlxFQK82R+1JNVbg
	 kVs4USvtBCpzg==
Date: Sat, 28 Jun 2025 16:04:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 01/11] iio: adc: ad_sigma_delta: don't overallocate
 scan buffer
Message-ID: <20250628160402.1f97c0fe@jic23-huawei>
In-Reply-To: <20250628155521.056b3394@jic23-huawei>
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
	<20250627-iio-adc-ad7173-add-spi-offload-support-v2-1-f49c55599113@baylibre.com>
	<20250628155521.056b3394@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 15:55:21 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 27 Jun 2025 18:39:57 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > Fix overallocating the size of the scan buffer by converting bits to
> > bytes. The size is meant to be in bytes, so scanbits needs to be
> > divided by 8.
> > 
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  drivers/iio/adc/ad_sigma_delta.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> > index 4c5f8d29a559fea7226b84141bcb148fb801f62c..6b3ef7ef403e00804abeb81025ed293b188e492b 100644
> > --- a/drivers/iio/adc/ad_sigma_delta.c
> > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > @@ -489,7 +489,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
> >  			return ret;
> >  	}
> >  
> > -	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits, 8);
> > +	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8, 8);  
> 
> Seems like a good place for BITS_TO_BYTES() from bitops.h.  Given we have another 8
> kicking around in the same code line it might be a tiny bit confusing as / 8
> 
> If everything else is good I'll tweak this whilst applying (and add the include if needed).

Found it in patch 4.   No problem doing it there.  'Maybe' a hint in the description would
have been a nice to have, but not particularly important.

> 
> >  	samples_buf_size += sizeof(int64_t);
> >  	samples_buf = devm_krealloc(&sigma_delta->spi->dev, sigma_delta->samples_buf,
> >  				    samples_buf_size, GFP_KERNEL);
> >   
> 


