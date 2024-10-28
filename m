Return-Path: <linux-iio+bounces-11514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBB39B3AF7
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 21:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0B91C219D7
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 20:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919C11E0090;
	Mon, 28 Oct 2024 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWnlG4zE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480471DFE2F;
	Mon, 28 Oct 2024 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145665; cv=none; b=KpnjVa9dcd8GTlFn1aJSdZpU8N8Sn8KD+lGG6yNwnTANOa6BOBbhQAk5dMOk2katEJJ6GzM7BCgLfsnVXm416GfoqQgWtZquenO90KnYp9AzgKbvEaARMS3Zte3BLM7Hk4CB8RZbxFoqUdHWDKDKL7SLg/E8s/qGhpj+Zge4gzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145665; c=relaxed/simple;
	bh=Y5Rde23G8yjiBQKn9oafKKfUVhQw22BUSq1r1LdQQ+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdse8Fcf8qCXBkpngxdodvBAPuStMrPtOaZ43MBeFcqAPSYEgTfRKastdi0114nYyJKgDPlcfOhwU3mqW1Q5oYac7r0ed/1AVUKJH94TWgz/HEWqh5OKpBcFgsgPcLjWFcft4QUqWtLx+sP8aKMApq1gKtkKaGUpqJ5i1sR9Swc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWnlG4zE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0B0C4CEE4;
	Mon, 28 Oct 2024 20:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730145664;
	bh=Y5Rde23G8yjiBQKn9oafKKfUVhQw22BUSq1r1LdQQ+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BWnlG4zEZEDIYp1V7ESkLALzehM8gtIg1N5svgVLmK100cBNdEZg0uk+Szp/CyTwm
	 VfHJURNJuMqO+8Cn/xIyYqDxnZcT5/VRkJeXfjX5Pn3GXZJ9MrGoW/LW2FUP4bPI1I
	 cI5SW8gLj0yxcA3mD/ckqUD63UL3gghif0YvM0BpBmuykCF6YDmrwRmiyfnRJwn4A8
	 q0/2vSzS1OpB48B7jrUcfd2ObeJLa8jx+JUkVOG6QE6FRJ5j9gHgdP6movbPtry2BE
	 dsoypyb7HA/rV8IiEt5k+oNWgvJdkgUa06+tL87m7TC7RInYBl8dY1Eiw+kzP487Dj
	 BkBWM5mLHjS3Q==
Date: Mon, 28 Oct 2024 20:00:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown
 <broonie@kernel.org>, dlechner@baylibre.com
Subject: Re: [PATCH v8 7/8] iio: dac: ad3552r: add high-speed platform
 driver
Message-ID: <20241028200057.369dcd58@jic23-huawei>
In-Reply-To: <3boluky2zvz6n4u3gjgxuzlo2cm3a4xcbfq5sjmzoz3i5lfsml@j3wikyf74xyj>
References: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-0-74ca7dd60567@baylibre.com>
	<20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-7-74ca7dd60567@baylibre.com>
	<20241026185740.4144f6c8@jic23-huawei>
	<3boluky2zvz6n4u3gjgxuzlo2cm3a4xcbfq5sjmzoz3i5lfsml@j3wikyf74xyj>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 10:14:25 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> Hi Jonathan,
> 
> On 26.10.2024 18:57, Jonathan Cameron wrote:
> > On Fri, 25 Oct 2024 11:49:40 +0200
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> >   
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > 
> > > Add High Speed ad3552r platform driver.
> > > 
> > > The ad3552r DAC is controlled by a custom (fpga-based) DAC IP
> > > through the current AXI backend, or similar alternative IIO backend.
> > > 
> > > Compared to the existing driver (ad3552r.c), that is a simple SPI
> > > driver, this driver is coupled with a DAC IIO backend that finally
> > > controls the ad3552r by a fpga-based "QSPI+DDR" interface, to reach
> > > maximum transfer rate of 33MUPS using dma stream capabilities.
> > > 
> > > All commands involving QSPI bus read/write are delegated to the backend
> > > through the provided APIs for bus read/write.
> > > 
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---  
> > Hi Angelo,
> > 
> > I'd missed a build issue in previous reviews. :(
> >   
> > >  drivers/iio/dac/Kconfig      |  14 ++
> > >  drivers/iio/dac/Makefile     |   1 +
> > >  drivers/iio/dac/ad3552r-hs.c | 530 +++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/iio/dac/ad3552r-hs.h |  19 ++
> > >  drivers/iio/dac/ad3552r.h    |   4 +
> > >  5 files changed, 568 insertions(+)
> > > 
> > > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > > index 26f9de55b79f..f76eaba140d8 100644
> > > --- a/drivers/iio/dac/Kconfig
> > > +++ b/drivers/iio/dac/Kconfig
> > > @@ -6,6 +6,20 @@
> > >  
> > >  menu "Digital to analog converters"
> > >  
> > > +config AD3552R_HS
> > > +	tristate "Analog Devices AD3552R DAC High Speed driver"
> > > +	select ADI_AXI_DAC
> > > +	help
> > > +	  Say yes here to build support for Analog Devices AD3552R
> > > +	  Digital to Analog Converter High Speed driver.
> > > +
> > > +          The driver requires the assistance of an IP core to operate,
> > > +          since data is streamed into target device via DMA, sent over a
> > > +	  QSPI + DDR (Double Data Rate) bus.  
> > 
> > Tabs and space mix that needs fixing.
> >   
> > > +
> > > +	  To compile this driver as a module, choose M here: the
> > > +	  module will be called ad3552r-hs.
> > > +
> > >  config AD3552R
> > >  	tristate "Analog Devices AD3552R DAC driver"
> > >  	depends on SPI_MASTER
> > > diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> > > index c92de0366238..d92e08ca93ca 100644
> > > --- a/drivers/iio/dac/Makefile
> > > +++ b/drivers/iio/dac/Makefile
> > > @@ -4,6 +4,7 @@
> > >  #
> > >  
> > >  # When adding new entries keep the list in alphabetical order
> > > +obj-$(CONFIG_AD3552R_HS) += ad3552r-hs.o ad3552r-common.o
> > >  obj-$(CONFIG_AD3552R) += ad3552r.o ad3552r-common.o  
> > 
> > This causes all sorts of issues. The same code should not be linked into two
> > separate drivers.  Try building one as a module and one built in.
> >   
> right now, seems i cannot catch any issue, nor building or in runtime:
> 
> ad3552r     [M]
> ad3552r-hs  [*]
> (ad3552r-common stays built in), ad3552r visible in lsmod, ad3552r-hs works
> 
> ad3552r     [*]
> ad3552r-hs  [M]
> (ad3552r-common stays built in), ad3552r-hs visible in lsmod, ad3552r-hs works
> 
> ad3552r     [M]
> ad3552r-hs  [M]
> (ad3552r-common.ko), ad3552r, ad3552r-hs and ad3552r-common are visible in lsmod,
> ad3552r-hs works, probe and removal, and also link/unlink tested).
> 
> Please let me know, i can proceed modifying as you require, if it's the case.
Hi Angelo,

I can't remember exactly what triggers this; maybe it's no longer a problem.
However, if nothing else it is a waste to end up with two copies in the
drivers. Hence switch to a common library module still a good idea.

Also this is missing includes for bitfield.h in ad3352r.c and ad3552r-common.c
so doesn't build for me at all.

Jonathan

> 
> 
> > The trick is a hidden symbol in Kconfig and an extra line in here
> > obj-$(CONFIG_AD3352R_LIB) += ad3552-common.o
> > 
> > and 
> > //note no text as we don't want this to be user selectable
> > 
> > config AD3352R_LIB
> > 	tristate
> > 
> > config AD3552R_HS
> > 	tristate "Analog Devices AD3552R DAC High Speed driver"
> > 	select ADI_AXI_DAC
> > 	select AD3352R_LIB
> > 	help
> > 	  Say yes here to build support for Analog Devices AD3552R
> > 	  Digital to Analog Converter High Speed driver.
> > 
> > 	  The driver requires the assistance of an IP core to operate,
> > 	  since data is streamed into target device via DMA, sent over a
> > 	  QSPI + DDR (Double Data Rate) bus.
> > 
> > 	  To compile this driver as a module, choose M here: the
> > 	  module will be called ad3552r-hs.
> > 
> > 
> > config AD3552R
> >  	tristate "Analog Devices AD3552R DAC driver"
> >  	depends on SPI_MASTER
> > 	select AD3352R_LIB
> > 	help
> > 	  ...
> > 
> > The pressure/mpl115 is done like this.
> > 
> >   
> > >  obj-$(CONFIG_AD5360) += ad5360.o
> > >  obj-$(CONFIG_AD5380) += ad5380.o  
> > 
> > Anyhow, to me the code looks ready to go subject to this.
> > 
> > If nothing else comes up I'm almost confident enough of the fix to just
> > do it (and the few trivial things in previous review), but probably quicker
> > and less prone to error if you have time to spin a v9, perhaps after letting others
> > have a day or two to review v8 next week.
> > 
> > rc5 is tomorrow, so we have a little time left this cycle.
> > 
> > Jonathan  
> 
> Regards,
>   angelo


