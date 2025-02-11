Return-Path: <linux-iio+bounces-15359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4728EA31577
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 20:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625501634D6
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 19:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B6B26E63F;
	Tue, 11 Feb 2025 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnsVHo1X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3098926E630;
	Tue, 11 Feb 2025 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302374; cv=none; b=lh150Tlwmo2xu9HpcZ2Qs+qyP4U+jA/x/6LI5CNhiOQdNpjZVoCm/9OOy89bRKz3CU0wDtpU6pK5qqteYbUHC2/eo+m3ey39ZG3OCSsAH6/gfqy8VWOr9iPn+9F28lNC48qsKgUP+KzVSi36S/8Q5tWNGAiqnMtvtkOWGCwIjqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302374; c=relaxed/simple;
	bh=nrF/BY5g0Fese/y5+1M+6ye+pt+/UVs0YfYfjIbl/kw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmGLGqXR5Hgbs3jSwL0Y8f2aj2Z5HkHVoHtGDMDjVB1+dSaEumdHDB5M+uAplY9JNU7yLyb7uebeRkGtK58Mgv6GEGYE6lW87lh0lNFkMtyPQLEV5sREIQ5jJsGbtVEZQk4+E3C4yoNTiFs3r8DerNSxoYXB2DG4IQSj4GUb+zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnsVHo1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDD0C4CEDD;
	Tue, 11 Feb 2025 19:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739302373;
	bh=nrF/BY5g0Fese/y5+1M+6ye+pt+/UVs0YfYfjIbl/kw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rnsVHo1XDIw8OUvt711dV4Z4LzQhKN4mnKBWikxohCNxlxoizdFwcx4QMUgvbFc6g
	 hz4BbIsOiykxXb2Nxt0Q48Ciw9Sg1rxo8Lz8rjgTc1vhfDMu5kYoCq0o93dXBlryl+
	 cZ3IInQnhjeWwDxxJSip3cIr+5Srxwa8Z3OYXhBIsdBR3tDJmizr38cU83YISg6ZOf
	 QcZbTlPVZFqJV0GGnLzlD0/CC9vhA4j6oSsocvpuJnL8128XSY0gjbeqidHNhYKct6
	 zmEXjFkaaLFwjCmvTEHO3kmuSHP9XOONjSo90VFxvCGHmQn/g1QaP4J3blP0q9EWIq
	 o+sky5Ojg235A==
Date: Tue, 11 Feb 2025 19:32:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 11/17] iio: adc: ad7944: add support for SPI offload
Message-ID: <20250211193242.6c9a6740@jic23-huawei>
In-Reply-To: <f989c3d7-0fc0-40f0-8548-4d5dd1a336ac@baylibre.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
	<20250207-dlech-mainline-spi-engine-offload-2-v8-11-e48a489be48c@baylibre.com>
	<f989c3d7-0fc0-40f0-8548-4d5dd1a336ac@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 13:09:59 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/7/25 2:09 PM, David Lechner wrote:
> > Add support for SPI offload to the ad7944 driver. This allows reading
> > data at the max sample rate of 2.5 MSPS.
> >   
> 
> ...
> 
> > ---
> >  drivers/iio/adc/Kconfig  |   1 +
> >  drivers/iio/adc/ad7944.c | 291 ++++++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 276 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index a3e8ac569ce4c6b6b30b48acb265d530aa98e89c..995b9cacbaa964d26424346120c139858f93cdcd 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -360,6 +360,7 @@ config AD7923
> >  config AD7944
> >  	tristate "Analog Devices AD7944 and similar ADCs driver"
> >  	depends on SPI
> > +	select SPI_OFFLOAD
> >  	select IIO_BUFFER  
> 
> I missed adding
> 
> 	select IIO_BUFFER_DMAENGINE
> 
Tweaked and pushed out.

> Closes: https://lore.kernel.org/oe-kbuild-all/202502082251.NuHT15R7-lkp@intel.com/
> 
> >  	select IIO_TRIGGERED_BUFFER
> >  	help  
> 
> 


