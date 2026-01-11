Return-Path: <linux-iio+bounces-27594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFE4D0ECE7
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CC70302EAE7
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E31339B44;
	Sun, 11 Jan 2026 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXTFNXda"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31D331211;
	Sun, 11 Jan 2026 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768133105; cv=none; b=P5nQ/p1FKLOHBqtwv5XDeDkOivBHTDD85Vya8+3GYiiDK1YXb2q11IPss1/cwuWEro3njlE11nHNocVxNbQAyE0DocH+zQb67X7rKztC2oZM9gd3z7D4j2aW786xtPMmQlJ50YfANaOVYeHr/DhP3Bi8AUFeDW27MgHDnVupVuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768133105; c=relaxed/simple;
	bh=K1DaJOvo9FmFtESIfBXrncDvD/xqtsmCB9+Etad+FAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RshfZB/4N359ti4R08WN4IavyRxECI7/BrU0fRoN70bC6Sate4b36jqZb5cOivlvCJARDbZPW129i+38K1VnZTi3kbGYEkQfmeGP3vJdGY4BPthJqKoDEfiKV3cg+4qkkZmXF5bjvEE+EerW8be7Sw1bdvnwLLiqociImSheIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXTFNXda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE079C19423;
	Sun, 11 Jan 2026 12:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768133104;
	bh=K1DaJOvo9FmFtESIfBXrncDvD/xqtsmCB9+Etad+FAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fXTFNXdaNRZqDEOzHwY84dMpHvsb/CfDN0qzJKGw6EpfKv/n8OZ2+1uiwDTpUeG38
	 ZsA5laBqjnAyvhaZwevTZL1+sKv02r4/4qYyaPCAcr5hYrM4mBhxwhOdToE1sMy64u
	 YpSo4Gva5KD+w5u9/TcmkAWlGE2OhWCogB51Vh2fSYmKEEQPqs4dLf33OgrLDWt3SP
	 tfkvpD5ccOVPvD6XonZe/z9qQT7Sc+l7Pxl45JoaV4HwnAO8E/fJnBaWN+6vFjynS8
	 UhChstJaP3EFbOZIQaafrjhXf409PzCj4ovv+9UQF2g2dODimiSp0EQh2NTDjGmbB2
	 u6KMTmnCgp60A==
Date: Sun, 11 Jan 2026 12:04:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>, Tobias Sperling
 <tobias.sperling@softing.com>, Eason Yang <j2anfernee@gmail.com>, Marilene
 Andrade Garcia <marilene.agarcia@gmail.com>, Cosmin Tanislav
 <cosmin-gabriel.tanislav.xa@renesas.com>, duje@dujemihanovic.xyz,
 herve.codina@bootlin.com, Rodolfo Giometti <giometti@enneenne.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/2] iio: adc: add driver for Texas Instruments TLA2528
 adc
Message-ID: <20260111120452.0a0dae0a@jic23-huawei>
In-Reply-To: <6b7bf02e-d016-4d2b-a409-6cd378d409fb@bootlin.com>
References: <20251223155534.220504-1-maxime.chevallier@bootlin.com>
	<20251223155534.220504-3-maxime.chevallier@bootlin.com>
	<20251227184204.6815a3b4@jic23-huawei>
	<6b7bf02e-d016-4d2b-a409-6cd378d409fb@bootlin.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 11:16:39 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Hi Jonathan,
> 
> On 27/12/2025 19:42, Jonathan Cameron wrote:
> > On Tue, 23 Dec 2025 16:55:33 +0100
> > Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> >   
> >> This adds a new driver for the TI TLA2528 ADC chip. It ha 8 12-bit
> >> channels, that can also be configured as 16-bit averaging channels.
> >>
> >> Add a very simple driver for it, allowing reading raw values for each
> >> channel.
> >>
> >> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> >> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>  
> > 
> > Hi Maxime,
> > 
> > A few extra bits from me
> > 
> > Thanks,
> > 
> > Jonathan
> > 
Hi Maxime,

Small process related request.  If you agree with a bit of feedback in a review,
just crop that bit out.  Keep the polite response for the change log of the
next version.

Whilst this can feel a little rude, the gain in efficiency and the reduction
in people missing the bits that actually warrant more discussion makes it worthwhile.

2nd time I'm posting this advice today!  Lets see how many more times it is
relevant ;)

Jonathan

