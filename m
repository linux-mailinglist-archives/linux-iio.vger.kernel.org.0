Return-Path: <linux-iio+bounces-20470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1144AD5CB7
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 18:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DB4175BF0
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316842063D2;
	Wed, 11 Jun 2025 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCFKS3OV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE722338;
	Wed, 11 Jun 2025 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660914; cv=none; b=dMmh7hRVF2yNM+zPDUZT/6p9uAD4A/+bRg/0Cb3bL61MBC/UQ6VONEm0CrL4bdqQQKofjrMBm0PlGTnH5YVa0UiX0nKx4sIvS/xjLCNk8CnxvzuWww/7A2AKlB+M/F9fpSWNweqFcUy/ZoP7L+bCjg9Kjuiu9s0/m9QuWR46ZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660914; c=relaxed/simple;
	bh=m/PwAkiiVHHJw2QiKL5QvGkPvJ7GRB3BXGGzMcGJYZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKaSv8SLcbxJCRnJ9oGZ2bQG9+AmKb+RG2KNKlJBp6aKJJJVRIlMUmCJrgGjQSIQXR3c4SNgCxHWO6P4Y+t71BF5vlUsVS7ejERqPNrBfL6owxtHbWiwj0uosl71vKsjewKy946pR5KFeHKH1vYRogNRqmdcPW8GnIHPEIIlIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCFKS3OV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC9EC4CEE3;
	Wed, 11 Jun 2025 16:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660913;
	bh=m/PwAkiiVHHJw2QiKL5QvGkPvJ7GRB3BXGGzMcGJYZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NCFKS3OVabpqRYi/QeQ7FKarYGiwk56zxwiRy1+AGURu/F+ApJePO33Mb1bWmhbwE
	 dNj0yCoATDW/LS3wj2mDPemUifNxiRyVwl3HfLeILcDu8FHgOmkLTQWM7DikBxSUfR
	 ICHgGsq70Er1H5pudfYDSRNxbfFCJuZzJTS+4iAE6KUFe/xUXxWBJpyQcORIuWy8fb
	 O0UNpU+VNy/S+sgw8hnvRotvXNjwBFgsZhMpGC/bglaFJJ8uYeXKgQJP8+fwmssFx1
	 8FcGAwWsGYM/1+npUc0/tLfsVWSQ71DApIkZFMt6a/r4Kn1a0oPCkdcKZD1l3G6TFn
	 w596j/jl9rV0A==
Date: Wed, 11 Jun 2025 17:55:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Da Xue <da@libre.computer>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7949: use spi_is_bpw_supported()
Message-ID: <20250611175506.01d11675@jic23-huawei>
In-Reply-To: <851b7d08-3e77-4344-97d1-9d60f1fb8762@baylibre.com>
References: <20250611-iio-adc-ad7949-use-spi_is_bpw_supported-v1-1-c4e15bfd326e@baylibre.com>
	<aEmdhV0ATRuUeGaL@smile.fi.intel.com>
	<851b7d08-3e77-4344-97d1-9d60f1fb8762@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 10:21:56 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/11/25 10:15 AM, Andy Shevchenko wrote:
> > On Wed, Jun 11, 2025 at 10:04:58AM -0500, David Lechner wrote:  
> >> Use spi_is_bpw_supported() instead of directly accessing spi->controller  
> >> ->bits_per_word_mask. bits_per_word_mask may be 0, which implies that  
> >> 8-bits-per-word is supported. spi_is_bpw_supported() takes this into
> >> account while spi_ctrl_mask == SPI_BPW_MASK(8) does not.  
> >   
> >> Closes: https://lore.kernel.org/linux-spi/c8b8a963-6cef-4c9b-bfef-dab2b7bd0b0f@sirena.org.uk/  
> > 
> > Reported-by yourself. I'm wondering if the Closes adds a value in this case.
> > Otherwise I can do the same to maybe 10% of my patches, for instance. But
> > I don't think I put Closes tag on whatever improvement potential bug fix
> > I do report (read: notice) myself.  
> 
> I included it so that Da Xue will know that this has been resolved and
> doesn't need to do anything more. Normally I would have not included
> it though.

If I followed the discussion correctly does this need a fixes tag?

> 
> >   
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>  
> > 
> > Code wise LGTM,
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> >   
> 


