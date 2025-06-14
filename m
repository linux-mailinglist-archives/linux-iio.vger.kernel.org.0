Return-Path: <linux-iio+bounces-20635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC0DAD9C86
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A45179835
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 11:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A62B2C08D6;
	Sat, 14 Jun 2025 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIYrMGob"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F251F1531;
	Sat, 14 Jun 2025 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749901227; cv=none; b=Gm4x3Km18ZT3UJkqnadPoMTYBLxWRYI9VFG8zzQmNwt0nJyvCeV3R96Jx3dZDOUoRss/V2Zw9GUun8ikDSnnGIeasm6j+IUwmvnoWcQ8zdjayHBudprQYz2ub6pjUEdNVTKqoBRDUMSPFAEJpve7LeQIlIeYiSGTFRzLoFFKA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749901227; c=relaxed/simple;
	bh=6My9Wlirf2exQSKlnTmP3+KTjTBj/UNq/AL2IrRVC7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgl8v1jWz90BipF+9rqqKMMEUTn/V/08iH3VNHjMbPaVTvPA+zSVRHolQyN5E0eS5a7VRYxXfNZJ2BGoOvkCU6nlK2W6hSTYZfnFZB2zzbUU6uyg8DNRHT0Oz41hZqBWXghCoDc1IJtPy+2NhB5RrmmxlGkT9rM4vHN5/FcqdXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIYrMGob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07DDC4CEEB;
	Sat, 14 Jun 2025 11:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749901226;
	bh=6My9Wlirf2exQSKlnTmP3+KTjTBj/UNq/AL2IrRVC7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hIYrMGob8I9X6ijwrUoUObU9xJu0/o7WSj2ch4icNuILPG6yF9UDL5ZNGmyOVioDz
	 tXm0bfrm7YtuuLscWcPqjRS4tLLSXq/h10WgmQ6hk4KH1PufbTykqvn1l7vrp2PU1z
	 u8cVHGCRf9DBszyk4iyU7wr22Dt+7eUGU3Nb4i7qO00Uhb+cdtTx8Q5xgA4lh55w9y
	 YSNX5vZGvV09uXAojqQPjCBTb18P5hBSyGZRa98Bzjw1iVs87HQGLseRSM6+dLOMBd
	 bqwrgbeM4h5jtorHh1CoLUQVuTy/eBxyihwIG0wQtTM7hhKbsyEswrOJaIrp2iKEgm
	 PO0gz2UjjPm3g==
Date: Sat, 14 Jun 2025 12:40:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Da Xue <da@libre.computer>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7949: use spi_is_bpw_supported()
Message-ID: <20250614124019.114079e0@jic23-huawei>
In-Reply-To: <1bbee6de-adac-4f28-9a96-fd6480691ac4@baylibre.com>
References: <20250611-iio-adc-ad7949-use-spi_is_bpw_supported-v1-1-c4e15bfd326e@baylibre.com>
	<aEmdhV0ATRuUeGaL@smile.fi.intel.com>
	<851b7d08-3e77-4344-97d1-9d60f1fb8762@baylibre.com>
	<20250611175506.01d11675@jic23-huawei>
	<1bbee6de-adac-4f28-9a96-fd6480691ac4@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 12:00:27 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/11/25 11:55 AM, Jonathan Cameron wrote:
> > On Wed, 11 Jun 2025 10:21:56 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> On 6/11/25 10:15 AM, Andy Shevchenko wrote:  
> >>> On Wed, Jun 11, 2025 at 10:04:58AM -0500, David Lechner wrote:    
> >>>> Use spi_is_bpw_supported() instead of directly accessing spi->controller    
> >>>> ->bits_per_word_mask. bits_per_word_mask may be 0, which implies that    
> >>>> 8-bits-per-word is supported. spi_is_bpw_supported() takes this into
> >>>> account while spi_ctrl_mask == SPI_BPW_MASK(8) does not.    
> >>>     
> >>>> Closes: https://lore.kernel.org/linux-spi/c8b8a963-6cef-4c9b-bfef-dab2b7bd0b0f@sirena.org.uk/    
> >>>
> >>> Reported-by yourself. I'm wondering if the Closes adds a value in this case.
> >>> Otherwise I can do the same to maybe 10% of my patches, for instance. But
> >>> I don't think I put Closes tag on whatever improvement potential bug fix
> >>> I do report (read: notice) myself.    
> >>
> >> I included it so that Da Xue will know that this has been resolved and
> >> doesn't need to do anything more. Normally I would have not included
> >> it though.  
> > 
> > If I followed the discussion correctly does this need a fixes tag?  
> 
> I supposed it doesn't hurt. It could be possible that someone tries to
> use an older stable kernel with a SPI controller that didn't set the
> flags, in which case there could be a problem.
> 
> Fixes: 0b2a740b424e ("iio: adc: ad7949: enable use with non 14/16-bit controllers")
Applied to the fixes-togreg branch of iio.git.

I didn't mark it for stable purely because it would have been obvious
I think if anyone actually hit this.

Jonathan

> 
> >   
> >>  
> >>>     
> >>>> Signed-off-by: David Lechner <dlechner@baylibre.com>    
> >>>
> >>> Code wise LGTM,
> >>> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> >>>     
> >>  
> >   
> 


