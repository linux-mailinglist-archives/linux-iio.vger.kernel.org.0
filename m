Return-Path: <linux-iio+bounces-27440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C23D3CEC569
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 18:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B05B230053FB
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A8D29A9FE;
	Wed, 31 Dec 2025 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="We3cIZ3E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE2D23E334;
	Wed, 31 Dec 2025 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201154; cv=none; b=dSH7i1pD9eRMbhAQAlg8sveghY+Uf6Un8wxVC6thAjRMh+XmOG9rWCBxDmV7SyxgqwvmP/+04BdHx1Me8lHftp5Pvo8s1D5yyUeQgHovJm8u3vTXUAKL3dfKfjaSVs+yXzMsy0QegI/gPkUV+P92JpSq0Vea0aM8T/EsaO/hweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201154; c=relaxed/simple;
	bh=zglNoK7x0polib2ecoOCXtGnKorIXlrlXC+gomkD7Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0s1fd2NFpNVMYwUan37NblO/ri5EYdpBmWExa2PxLRpg5ev3M8/yGoyI05lmolNVoeTxAd5THXULIbF5V+0NIV9GYb3E1ICPg1UOxvCslmKlwhNAhLUgK3MtpL3ObrfmuCQyfpXll6klet00HofkLSCY12G5isx84p54RueJ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=We3cIZ3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BDAC113D0;
	Wed, 31 Dec 2025 17:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767201154;
	bh=zglNoK7x0polib2ecoOCXtGnKorIXlrlXC+gomkD7Mk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=We3cIZ3EkOF0LDNuFrem5thO9BHYiR/ueJiNjZXfzV8yAvosK69VNJvbqtdQ297aU
	 AHbTqvoJh0aUDpGGRG6gSnNPXjkMtT/G/+4WCUQrO7gP6jwKGyMgSAtjAL+4HRwm3E
	 VDm4KM02lNB5QtkXns4FFQ20cAc2u5B6ap0UeZTyWXb9JIakqJQnpK5aWG9irkvBff
	 tOsSWCU4Y5enJN9sRK5bQHSjVfxOH0JTz58HUj/wkqdvy+/wpz0HAOKNsCX0NFiiGI
	 W+NV25uBVFJjh4V1n71F3binJ0SXCpH65TxPMXyd+9OAb4JCDBDmcqnecDajseL5kS
	 tlvjxy+agGnPA==
Date: Wed, 31 Dec 2025 17:12:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, David Lechner
 <dlechner@baylibre.com>, nuno.sa@analog.com, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>, Tobias Sperling
 <tobias.sperling@softing.com>, Eason Yang <j2anfernee@gmail.com>, Marilene
 Andrade Garcia <marilene.agarcia@gmail.com>, Cosmin Tanislav
 <cosmin-gabriel.tanislav.xa@renesas.com>, duje@dujemihanovic.xyz,
 herve.codina@bootlin.com, Rodolfo Giometti <giometti@enneenne.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/2] iio: adc: add driver for Texas Instruments TLA2528
 adc
Message-ID: <20251231171220.1f99e36d@jic23-huawei>
In-Reply-To: <efbe9720-0974-4d5e-9a03-fefd3c86e275@gmail.com>
References: <20251223155534.220504-1-maxime.chevallier@bootlin.com>
	<20251223155534.220504-3-maxime.chevallier@bootlin.com>
	<efbe9720-0974-4d5e-9a03-fefd3c86e275@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Dec 2025 10:20:23 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 23/12/2025 17:55, Maxime Chevallier wrote:
> > This adds a new driver for the TI TLA2528 ADC chip. It ha 8 12-bit
> > channels, that can also be configured as 16-bit averaging channels.
> > 
> > Add a very simple driver for it, allowing reading raw values for each
> > channel.
> > 
> > Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> >   MAINTAINERS                  |   7 ++
> >   drivers/iio/adc/Kconfig      |  10 ++
> >   drivers/iio/adc/Makefile     |   1 +
> >   drivers/iio/adc/ti-tla2528.c | 209 +++++++++++++++++++++++++++++++++++
> >   4 files changed, 227 insertions(+)
> >   create mode 100644 drivers/iio/adc/ti-tla2528.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index dc731d37c8fe..5c382ae216c7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -25866,6 +25866,13 @@ F:	include/dt-bindings/soc/ti,sci_pm_domain.h
> >   F:	include/linux/soc/ti/ti_sci_inta_msi.h
> >   F:	include/linux/soc/ti/ti_sci_protocol.h
> >   
> > +TEXAS INSTRUMENTS' TLA2528 ADC DRIVER
> > +M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Supported
> > +F:	Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
> > +F:	drivers/iio/adc/ti-tla2528.c
> > +
> >   TEXAS INSTRUMENTS' TMP117 TEMPERATURE SENSOR DRIVER
> >   M:	Puranjay Mohan <puranjay@kernel.org>
> >   L:	linux-iio@vger.kernel.org
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 58da8255525e..67376de410bf 100644  
> 
> Hmm. Would it ease merging if MAINTAINERS changes were in their own patch?

Not particularly.  Though I personally slightly prefer the logic
of bringing the entry in with the first file, then adding additional files
in later patches.

Given it is huge and in alphabetical order, conflicts in MAINTAINERS are
fairly rare and trivial to resolve.


