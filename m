Return-Path: <linux-iio+bounces-4979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB668C3645
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 13:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1EE5B20E22
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 11:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC8A208CB;
	Sun, 12 May 2024 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljkF2R1x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367C91C2AD;
	Sun, 12 May 2024 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715514737; cv=none; b=bqMmhlSFF9qseTzqLeDDTw+XowVVfmq2DIxqVe2dQ5Zlur+DHIAWUkwJANSbKSridE2CfdRGYv8C0l8NrCRp/ZxQCIzKPEKbs+L9UoOHAmODGhezTMXSx6Vzof1X+ksAKVwgVK6pSmboJRpvoseMvxVrrMXjKABDGdX9wBDu7SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715514737; c=relaxed/simple;
	bh=v15+8QTi7Lu1dvYp4AaC787advGK52IzzFq4cv1dswQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1pRrEApb/EcUIgiSqm4uroKLfDAF8PahyxfaSVPzzCP/EhWKdcwKQWywDNC743qkEyscWy8gC4Mk9xb1VRkT3uicrYZuYidFZIFaV03RNKeHGUaB+l6lDl9J8Nr55RdIRSOKpMW6+uuQ5aThg0nzWpdqVXtAE41/65wqKtNBBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljkF2R1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7829FC116B1;
	Sun, 12 May 2024 11:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715514736;
	bh=v15+8QTi7Lu1dvYp4AaC787advGK52IzzFq4cv1dswQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ljkF2R1xYfGxlIdUxblo0YdsP5cPZko4XbAiX7gXXIAJXmMiVLiY33Dc40mfeMf6Z
	 xuh18XltQF2GRRNE3rpRfogp4/4PJiS0lhVfDqLZA9Hot34qtitUaHxBCtNsqBBmno
	 G0QMqA6qtWjt+7XMn6vQGpPfe14mdnTSwisZ4I+luby2I3ul66pEaV34DKRttTBBPT
	 rB564hmz8nJslNABoxIdkDg04TjKMTXL3fSDNObzv4kZWxBdy7WxuJbbR8/bOOTWrv
	 I+ufFladUnlnP3sIQD6zLJd1KIqnoceU9PTLXnWrMbVPEkL/qMuHThAr2iRku7tca7
	 X9JvTulSVR7Rg==
Date: Sun, 12 May 2024 12:52:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v2 8/8] iio: adc: ad7944: add support for SPI
 offload
Message-ID: <20240512125202.312d0576@jic23-huawei>
In-Reply-To: <CAMknhBGG9bYwzPw8woaR_YaVRW+wpT4W1KpHzG32nWj9Qi7fig@mail.gmail.com>
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
	<20240510-dlech-mainline-spi-engine-offload-2-v2-8-8707a870c435@baylibre.com>
	<20240511175832.6c2f6517@jic23-huawei>
	<CAMknhBGG9bYwzPw8woaR_YaVRW+wpT4W1KpHzG32nWj9Qi7fig@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 11 May 2024 13:41:09 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Sat, May 11, 2024 at 11:58=E2=80=AFAM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Fri, 10 May 2024 19:44:31 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> > =20
> > > This adds support for SPI offload to the ad7944 driver. This allows
> > > reading data at the max sample rate of 2.5 MSPS.
> > >
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > >
> > > v2 changes:
> > >
> > > In the previous version, there was a new separate driver for the PWM
> > > trigger and DMA hardware buffer. This was deemed too complex so they
> > > are moved into the ad7944 driver.
> > >
> > > It has also been reworked to accommodate for the changes described in
> > > the other patches.
> > >
> > > RFC: This isn't very polished yet, just FYI. A few things to sort out:
> > >
> > > Rather than making the buffer either triggered buffer or hardware buf=
fer,
> > > I'm considering allowing both, e.g. buffer0 will always be the trigge=
red
> > > buffer and buffer1 will will be the hardware buffer if connected to a=
 SPI
> > > controller with offload support, otherwise buffer1 is absent. But sin=
ce
> > > multiple buffers haven't been used much so far, more investigation is
> > > needed to see how that would work in practice. If we do that though, =
then
> > > we would always have the sampling_frequency attribute though even tho=
ugh
> > > it only applies to one buffer. =20
> >
> > Why would someone who has this nice IP in the path want the conventional
> > triggered buffer?  I'm not against the two buffer option, but I'd like =
to know
> > the reasoning not to just provide the hardware buffer if this SPI offlo=
ad
> > is available.
> >
> > I can conjecture reasons but would like you to write them out for me :)
> > This feels like if someone has paid for the expensive hardware they pro=
bably
> > only want the best performance.
> > =20
>=20
> For me, it was more of a question of if we need to keep the userspace
> interface consistent between both with or without offload support. But
> if you are happy with it this way where we have only one or the other,
> it is less work for me. :-)

So inconsistency in userspace interfaces can occur for many reasons like
whether the interrupt is wired or not, but in this particularly
case I guess we have ABI stability issue because there are boards out there
today and people using the driver without this offload functionality.
I'd not really thought that bit through, so I think you are correct that
we need to maintain the triggered buffer interface and 'add' the new
ABI for the offloaded case.  The multibuffer approach should work for this.
Will be interesting if any problem surface from having two very different
types of buffer on the same device.

Jonathan

