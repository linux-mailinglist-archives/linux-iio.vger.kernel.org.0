Return-Path: <linux-iio+bounces-20641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C03CAD9CA9
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 14:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42636179AD5
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 12:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B93C2741AD;
	Sat, 14 Jun 2025 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPWHVI8P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EFC1DE3A8;
	Sat, 14 Jun 2025 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749903541; cv=none; b=Q78iuQPhvZRFZjvV8KMimT5NPBWYwRj5lanvLmVdrhtTtnL4+smOiRcIvKmdOgCr6BkiHozxALKfJLd757/604WDRxq3kdZ+2xhskEMNrAfBEfVh1JFFaqtV16QmeEEUIpUZaIXCIhQ6ANQdf3nOAjD0VN4Lz6HUUvnDOI8hmFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749903541; c=relaxed/simple;
	bh=PKJ0MCiecE4yglZMxR339G1ACqEGU8r/l9NXHPYw7Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4KPl7sduzavIZQU+3p+T7PJPVAh4UZG0fpw+q4C3nh0q2MOdZ42KBDZh2jXD34g5aXrgO58KtiWi4nEUgFENdj6CYpP6TftgS+NQrQfY6eu2Wno5/32R9lRnPJHt3GT+PylzgalOjTKWxv9pF9dTDfkM+BSTJQYtxSInq6VG+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPWHVI8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A468C4CEEB;
	Sat, 14 Jun 2025 12:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749903538;
	bh=PKJ0MCiecE4yglZMxR339G1ACqEGU8r/l9NXHPYw7Ac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tPWHVI8PJ/YFW4mFxP8gpuscF+qnzTGShqYvVxG+RXB6OJc3vE5MkB4XnOL3FYbGy
	 zVnavAD1gEV3ABPiELtjvJf7d5phQf/g5HpyBECyplnopLe6sKnWDl7XTzz7Vaxfzx
	 kTbVBTE/DJnsUPZtGM09csSfRm+K/QdNNVqo+8HzALETdAF058aTJ9Ny6J/D0LrN60
	 B82/TQ8eC4KkPMGojhstZDLj6ZPrEH2O7C1qyEB8IrqunqCGWd0AocGyrJYy+5NGGP
	 0fHmi3Wg7fFhSDwRF2vHvEm087IK3ASIb2Z8JoQVhY9pMA3h/eYLTXUtgdR7eK5w4G
	 aB4K2P4LRuymw==
Date: Sat, 14 Jun 2025 13:18:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Nicolas Frattaroli
 <nicolas.frattaroli@collabora.com>, David Lechner <dlechner@baylibre.com>,
 linux-rockchip@lists.infradead.org, Michael Hennerich
 <michael.hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Heiko Stuebner
 <heiko@sntech.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Francesco Dolcini
 <francesco@dolcini.it>, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZl?=
 =?UTF-8?B?cw==?= <jpaulo.silvagoncalves@gmail.com>, Leonard
 =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, kernel@pengutronix.de,
 Oleksij Rempel <o.rempel@pengutronix.de>, Roan van Dijk <roan@protonic.nl>,
 Tomasz Duszynski <tomasz.duszynski@octakon.com>, Jacopo Mondi
 <jacopo@jmondi.org>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Mudit Sharma
 <muditsharma.info@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, =?UTF-8?B?T25kxZllag==?= Jirman
 <megi@xff.cz>, Andreas Klinger <ak@it-klinger.de>, Petre Rodan
 <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 00/28] iio: zero init stack with { } instead of memset()
Message-ID: <20250614131844.7fdc10b8@jic23-huawei>
In-Reply-To: <aE0a/Y9qVByfA2vI@duo.ucw.cz>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
	<aEqbQPvz0FsLXt0Z@duo.ucw.cz>
	<2243943.irdbgypaU6@workhorse>
	<aEsiTy++yKGe1p9W@duo.ucw.cz>
	<aEsmDyc44P8amm5p@smile.fi.intel.com>
	<aE0a/Y9qVByfA2vI@duo.ucw.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Jun 2025 08:47:25 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> On Thu 2025-06-12 22:10:07, Andy Shevchenko wrote:
> > On Thu, Jun 12, 2025 at 08:54:07PM +0200, Pavel Machek wrote:  
> > > > On Thursday, 12 June 2025 11:17:52 Central European Summer Time Pavel Machek wrote:  
> > > > >   
> > > > > > Jonathan mentioned recently that he would like to get away from using
> > > > > > memset() to zero-initialize stack memory in the IIO subsystem. And we
> > > > > > have it on good authority that initializing a struct or array with = { }
> > > > > > is the preferred way to do this in the kernel [1]. So here is a series
> > > > > > to take care of that.  
> > > > > 
> > > > > 1) Is it worth the churn?
> > > > > 
> > > > > 2) Will this fail to initialize padding with some obscure compiler?  
> > > > 
> > > > as of right now, the only two C compilers that are supported are
> > > > GCC >= 8.1, and Clang >= 13.0.1. If anyone even manages to get the
> > > > kernel  
> > > 
> > > Well... I'm pretty sure parts of this would make it into -stable as a
> > > dependency, or because AUTOSEL decides it is a bugfix. So..
> > > 
> > > GNU C                  4.9              gcc --version
> > > Clang/LLVM (optional)  10.0.1           clang --version  
> > 
> > Even though, what the kernel versions are you referring to? I am sure there
> > plenty of cases with {} there.  
> 
> 5.10, for example. I'm sure they are, uninitialized padding is a
> security hole, but rather hard to detect if they are not specifically
> looking.

The stack kunit test is there back to 5.0-rc4 
50ceaa95ea09 ("lib: Introduce test_stackinit module")

So I think we should be pretty well defended against issues.

Hence I plan to pick this up curently.

Thanks all for inputs on this.

Fun corners of the C spec vs implementations!

Jonathan

> 
> BR,
> 								Pavel


