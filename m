Return-Path: <linux-iio+bounces-27595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B638D0ECEE
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F9AD30123C3
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8000339B44;
	Sun, 11 Jan 2026 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgSkqR0C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9842D318BAB;
	Sun, 11 Jan 2026 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768133209; cv=none; b=pcF+JTejK7BmblrE3mDAioFT0QfNHFp6gqh9BOAlSyfr4amfBFKZMOyk2QwjMesM8eB/aLnIHhfszdArOFW45f4j6AqzWgRZPE5V6QKBMl3Gp48nzqjv7BfIsNOBlGvCdhLCNO2GT9OOXv0qZXBLvJwoQKh/bOJBNcFm86qJBfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768133209; c=relaxed/simple;
	bh=BZw2XBOYbpiqMDnj26jpYjAEvsUvDh+nwlen6umIw2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfhD2W41Ruhylj5m8152tmlhvkoPn5Dkm81BVsVa+fPiY1hjnNIIIlPxhTP7QCYMsz28KiD7PX4QKXi2SwqreOkWA36ESKM9WxuDSBsYSJ4eChm9zH3rCoiDkHxQvxC4TE7KXvtNeNnBPCCsEYs2FBmsMHOpK+wmW/9tlOCEklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgSkqR0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC9EC4CEF7;
	Sun, 11 Jan 2026 12:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768133209;
	bh=BZw2XBOYbpiqMDnj26jpYjAEvsUvDh+nwlen6umIw2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SgSkqR0C9GDomSK76wu39P6fgCBYn2yBx81a//rIKcOtCyd24DsfBs6jvwE6w67ZZ
	 1u6ct9v1ZlP+AM818oHlAE5EAS/H3rnngxSQqnil04ryae1HoVYE+wD/mG7T5oKK5J
	 B1ruxryHjxvyYy0CnzOyPiyY8ByPjMNgu/JJcSGKCZ47JstHkP+Vq1F+K9KwJfXOVz
	 AbZnxGkdaFyO7LM8da6LeahN5g4kyTJMgN/L/pQK75K8aX3YWtihdpC5vCfv22pcfV
	 /Es64fx8hiotAFmgJIsXAMdg5KE3bFs3pqHaLJMbr5JrmKPstgSJ0UiilW0yX2c+D3
	 tFP5GzID5TWPw==
Date: Sun, 11 Jan 2026 12:06:35 +0000
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
Message-ID: <20260111120635.46f7216e@jic23-huawei>
In-Reply-To: <286a032d-7a14-409d-9bb3-6033c35f8e99@gmail.com>
References: <20251223155534.220504-1-maxime.chevallier@bootlin.com>
	<20251223155534.220504-3-maxime.chevallier@bootlin.com>
	<efbe9720-0974-4d5e-9a03-fefd3c86e275@gmail.com>
	<20251231171220.1f99e36d@jic23-huawei>
	<286a032d-7a14-409d-9bb3-6033c35f8e99@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Jan 2026 09:13:51 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 31/12/2025 19:12, Jonathan Cameron wrote:
> > On Mon, 29 Dec 2025 10:20:23 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> On 23/12/2025 17:55, Maxime Chevallier wrote:  
> >>> This adds a new driver for the TI TLA2528 ADC chip. It ha 8 12-bit
> >>> channels, that can also be configured as 16-bit averaging channels.
> >>>
> >>> Add a very simple driver for it, allowing reading raw values for each
> >>> channel.
> >>>
> >>> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> >>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> >>> ---
> >>>    MAINTAINERS                  |   7 ++
> >>>    drivers/iio/adc/Kconfig      |  10 ++
> >>>    drivers/iio/adc/Makefile     |   1 +
> >>>    drivers/iio/adc/ti-tla2528.c | 209 +++++++++++++++++++++++++++++++++++
> >>>    4 files changed, 227 insertions(+)
> >>>    create mode 100644 drivers/iio/adc/ti-tla2528.c
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index dc731d37c8fe..5c382ae216c7 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -25866,6 +25866,13 @@ F:	include/dt-bindings/soc/ti,sci_pm_domain.h
> >>>    F:	include/linux/soc/ti/ti_sci_inta_msi.h
> >>>    F:	include/linux/soc/ti/ti_sci_protocol.h
> >>>    
> >>> +TEXAS INSTRUMENTS' TLA2528 ADC DRIVER
> >>> +M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
> >>> +L:	linux-iio@vger.kernel.org
> >>> +S:	Supported
> >>> +F:	Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
> >>> +F:	drivers/iio/adc/ti-tla2528.c
> >>> +
> >>>    TEXAS INSTRUMENTS' TMP117 TEMPERATURE SENSOR DRIVER
> >>>    M:	Puranjay Mohan <puranjay@kernel.org>
> >>>    L:	linux-iio@vger.kernel.org
> >>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> >>> index 58da8255525e..67376de410bf 100644  
> >>
> >> Hmm. Would it ease merging if MAINTAINERS changes were in their own patch?  
> > 
> > Not particularly.  Though I personally slightly prefer the logic
> > of bringing the entry in with the first file, then adding additional files
> > in later patches.
> > 
> > Given it is huge and in alphabetical order, conflicts in MAINTAINERS are
> > fairly rare and trivial to resolve.
> >   
> 
> Thanks for this clarification :)
> 
> I don't know where I had picked up this idea, but I thought that the 
> volume of changes in MAINTAINERs was somewhat annoying source of 
> conflicts. I sit and type corrected :)

Low chance for any given patch, but high chance overall as so many patches
touch it!  Resolving it isn't really any easier if it is inside a bigger
patch or not.

Jonathan

> 
> 
> Yours,
> 	-- Matti
> 
> ---
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
> 
> ~~ When things go utterly wrong vim users can always type :help! ~~


