Return-Path: <linux-iio+bounces-27299-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 962D6CD44FC
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 20:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3BA83005BBC
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F278316184;
	Sun, 21 Dec 2025 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi86AWxe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFC21FC101;
	Sun, 21 Dec 2025 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766346247; cv=none; b=T0hubBu9C6F7F2lmxNhbeTB0X2YEWecxBj1RXKk1Lrj1unijMdsLaAoO5Ny4GQMhlXP296poICVJGJ3DVEbDbmUbjI6Q/M/eNPfrFD+WQ8PIZFydoFAdS55JK40VdUCqJXjit1LWU1OAnQK1y9h9XfAfNCe7TxiyL0aOb6XOL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766346247; c=relaxed/simple;
	bh=WnMxUpxZCdrp+8JHcHsUD15fQNhBBQ8TrewpeFAH0Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uv9VIVzBNwbRlf8zfqYUeNghTL0do0fvPErcsWn/HNS7FqN8MwwwdQYMQq7AYDY56zY+WUw9Nvnbw1yzAACon5zRMRrFuN50PA1XYbYQkmEZV6RBdTYva4OJ/mP6PmqPkGplk3TGGaRRIaB62WCRMrBId0ceHesUBfI3VTj0RDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi86AWxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15781C4CEFB;
	Sun, 21 Dec 2025 19:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766346247;
	bh=WnMxUpxZCdrp+8JHcHsUD15fQNhBBQ8TrewpeFAH0Ow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oi86AWxe+DwKCLEsi4wH9BhJsmlyVvgJTeCNYT1DaSfDMq9Ag/gA1fxVs5aOCnLM5
	 01zFpwQiBj6NsOUSunI2H0omT4eU8I/V8ZtZxXAV9PGzFEuiYNW9TXUqmLvu/Vv1MR
	 Du2EnBRKFX6d9V8/+QyxUy3Q2ldbcCpJWx4s8h3b4gIZ2QPhryEvKsvDaA1KTHuK2C
	 nM26xtJK3RR4g0sFCG/FISC7E9fdsgMwHkhVRK6QCuCo5fMAoaeUUckfrTgfwhVcCV
	 9rdDchGwPkqXCCPYhJdORLvGTHR17+z10IsgnmHk08G9SqoEKsnaF+Zyygq3Gfat0f
	 D3LpzAtZmSPJw==
Date: Sun, 21 Dec 2025 19:43:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Tomas Borquez <tomasborquez13@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 5/5] staging: iio: ad9832: add sysfs documentation
Message-ID: <20251221194358.3284acb4@jic23-huawei>
In-Reply-To: <aUQZW3XBusWl3TU4@debian-BULLSEYE-live-builder-AMD64>
References: <20251215190806.11003-1-tomasborquez13@gmail.com>
	<20251215190806.11003-6-tomasborquez13@gmail.com>
	<aUQZW3XBusWl3TU4@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 12:10:19 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 12/15, Tomas Borquez wrote:
> > Add sysfs ABI documentation for the AD9832/AD9835 Direct Digital
> > Synthesizer chips, documenting frequency, phase, output control,
> > and pin control attributes.
> > 
> > Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
> > ---
> >  .../Documentation/sysfs-bus-iio-dds-ad9832    | 41 +++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-dds-ad9832
> > 
> > diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-dds-ad9832 b/drivers/staging/iio/Documentation/sysfs-bus-iio-dds-ad9832
> > new file mode 100644
> > index 0000000000..5ceea57917
> > --- /dev/null
> > +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-dds-ad9832
> > @@ -0,0 +1,41 @@
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrent0_frequencyY  
> To be more generic, I think we could use a capital letter for the channel number
> too and avoid the symbol postfix in the this attribute's name.
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_frequency
> 
> > +KernelVersion:	6.19
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +    Frequency in Hz for frequency register Y (0-1). The active
> > +    frequency register is selected via out_altcurrent0_frequency_symbol.  
> Maybe, if we can keep only the 'Frequency in Hz for frequency channel Y.' part
> of the description, this is something that could actually go into sysfs-bus-iio
> when the driver graduates. Though, the 'register is selected via
> out_altcurrent0_frequency_symbol' part is trickier since it seems to be design
> specific. 

For now, these interfaces are specific enough I'd be tempted to put them in
sysfs-bus-iio-frequency or a driver specific file for now.

That lets us keep a little more track of how they are used. It's a lot
easier to make sure documentation is generic enough once there are a few users
(though as Marcelo suggests, make it as a general as possible from the start!)

Jonathan

> 
> What if we do something like
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_frequency_symbolZ
> +KernelVersion:	6.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +    Frequency in Hz for symbol Z of frequency Y channel. The active
> +    frequency symbol is selected via out_altcurrentY_frequency_symbol.
> ?
> 
> Same thoughts about out_altcurrent0_phaseY.


