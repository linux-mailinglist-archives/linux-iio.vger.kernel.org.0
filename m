Return-Path: <linux-iio+bounces-20662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B814DAD9D6E
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 16:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E28A3A1AE2
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247722C08D4;
	Sat, 14 Jun 2025 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ta9SO3rE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763E3594E;
	Sat, 14 Jun 2025 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749910737; cv=none; b=HUMhnwoNX1YU/8EC5m7em6yZvy5BczR1hPJH30qqPg8w5z1f9gIE2foJ0w/VO1uyqidB45TO3UZOP2IWz3BNDFyhekNP/PzejeO3wbrJEBe070I2LGNWzBa7T/g4EWch92jz2S4Gi6fqFMu29SAGcAwGpm2FrLTlNNp/fWX0EpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749910737; c=relaxed/simple;
	bh=TAefawj8sFz6PzX77ED0UDRrtR9qcAx7l29OSrOfCJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRj+JhnPrydM7A7MzKiOJGEq7074GZkpmhonvhCsahc8zxPhUMNREup4ZxP9ccbwlqt37ZjIDTZEubjGgu/0i1B8hAkEej4AObGiAuvfIjzqGvD3K0vWnaREfIeBS9WzpgkNL9o1pYwTRB24TggyP6oD+phnfdaerfPNnqGE8y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ta9SO3rE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDCEC4CEEB;
	Sat, 14 Jun 2025 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749910737;
	bh=TAefawj8sFz6PzX77ED0UDRrtR9qcAx7l29OSrOfCJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ta9SO3rEXMSLA10FI7fBR3F6/8k5nRYF+su0+OPjS5hW+vMPqYqkjwkBqhYYBZJzi
	 WkxbcgQaolfGAHRjZceYZBqeLjg3nxqewEpEhi/mc3fXRRgOVjQmxu7ghIAZztiJWi
	 rcXaFy9n2AswtVLbxFPrJHJQ5k7DbNhVzkcrWFm8KVbZvInGvZmzv0P2o5TRxwzScJ
	 EXpRqYx7xKx2ZA5uXP8ZlvfB0XTbU8PVP30WMoANTItUUqs4EdtCQcckRCKr/THZHj
	 QqEd2x3S4DlvrLbcIOo7MzysAEzgrI8Z9I2cHL8+5MkDlEBeHuyeU6NRmGWVCBNvn6
	 0y8FcKrLKOhAw==
Date: Sat, 14 Jun 2025 15:18:44 +0100
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
Message-ID: <20250614151844.50524610@jic23-huawei>
In-Reply-To: <20250614131844.7fdc10b8@jic23-huawei>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
	<aEqbQPvz0FsLXt0Z@duo.ucw.cz>
	<2243943.irdbgypaU6@workhorse>
	<aEsiTy++yKGe1p9W@duo.ucw.cz>
	<aEsmDyc44P8amm5p@smile.fi.intel.com>
	<aE0a/Y9qVByfA2vI@duo.ucw.cz>
	<20250614131844.7fdc10b8@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Jun 2025 13:18:44 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 14 Jun 2025 08:47:25 +0200
> Pavel Machek <pavel@ucw.cz> wrote:
> 
> > On Thu 2025-06-12 22:10:07, Andy Shevchenko wrote:  
> > > On Thu, Jun 12, 2025 at 08:54:07PM +0200, Pavel Machek wrote:    
> > > > > On Thursday, 12 June 2025 11:17:52 Central European Summer Time Pavel Machek wrote:    
> > > > > >     
> > > > > > > Jonathan mentioned recently that he would like to get away from using
> > > > > > > memset() to zero-initialize stack memory in the IIO subsystem. And we
> > > > > > > have it on good authority that initializing a struct or array with = { }
> > > > > > > is the preferred way to do this in the kernel [1]. So here is a series
> > > > > > > to take care of that.    
> > > > > > 
> > > > > > 1) Is it worth the churn?
> > > > > > 
> > > > > > 2) Will this fail to initialize padding with some obscure compiler?    
> > > > > 
> > > > > as of right now, the only two C compilers that are supported are
> > > > > GCC >= 8.1, and Clang >= 13.0.1. If anyone even manages to get the
> > > > > kernel    
> > > > 
> > > > Well... I'm pretty sure parts of this would make it into -stable as a
> > > > dependency, or because AUTOSEL decides it is a bugfix. So..
> > > > 
> > > > GNU C                  4.9              gcc --version
> > > > Clang/LLVM (optional)  10.0.1           clang --version    
> > > 
> > > Even though, what the kernel versions are you referring to? I am sure there
> > > plenty of cases with {} there.    
> > 
> > 5.10, for example. I'm sure they are, uninitialized padding is a
> > security hole, but rather hard to detect if they are not specifically
> > looking.  
> 
> The stack kunit test is there back to 5.0-rc4 
> 50ceaa95ea09 ("lib: Introduce test_stackinit module")
> 
> So I think we should be pretty well defended against issues.
> 
> Hence I plan to pick this up curently.
> 
> Thanks all for inputs on this.
> 
> Fun corners of the C spec vs implementations!
> 
> Jonathan
> 
I want to give this some testing exposure from 0-day etc in case
we missed any build related issues so I've queued it up on my testing branch.
I can still pick up tags / rebase etc for now.

Thanks,

Jonathan

> > 
> > BR,
> > 								Pavel  
> 
> 


