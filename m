Return-Path: <linux-iio+bounces-4951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39208C30DC
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 13:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B2E1F212EB
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 11:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C721754FB5;
	Sat, 11 May 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/q0COIZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFFB1E53A;
	Sat, 11 May 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715427011; cv=none; b=nCK2oYWGFuzogVROuPS4BQiB0XukcLJAlDx0E7jWhjsvENjfoR3YMHX5znjGCB6pvxy/oJqC0I5GLHjXfX42oZ5mSxCujMtgn6ceisFvfnu8WP5LF8wIzvau/t0A2J3jHr+4aUjWmgFSaQo1qF/SyHYr6vqFz59gbzAFKZBWso8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715427011; c=relaxed/simple;
	bh=VXOktNgtVb4YUN213DANq6eU0Sy8yRAxjtjpcgGCVtc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pp2RFwX7I4PfY0qSBTp2rOE3wsP4vfbCRyn3TOE5lWBxqSTT63mlty6OrylOr6KnkIycj22EdIIA69PFJOnud33ZTmGToC0P3s+FNSLUgdBvlivFM+RgvxV/LxNheqQ4sxAZ/qXCLGOp62VKM8tQUTL5NFbxitzNQBMNbCprLAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/q0COIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA7CC2BBFC;
	Sat, 11 May 2024 11:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715427011;
	bh=VXOktNgtVb4YUN213DANq6eU0Sy8yRAxjtjpcgGCVtc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z/q0COIZFr1qX4V+7On9qdm7Dj+szkW6nmCZVfRqSuj6rpK7w9nSQwQHhDzraH/TE
	 6ZDMTgKZWq7MLnx/DAsoDxQ4SOt3CACCTpR8qbRMpapOtR0ugyci6njGghs5w5Wn3R
	 XAJLX9ADTb+zKK89RAG/UEeGp4grrfGX5zHNwg4Z1l0if0Lq2f+Y4V4Qz1kDnQRMgF
	 12M+LojxCKqOqJSFaeH5yRrv+EnliVQNL2I1cNsTlH1RVO9E4gM7mE5aIg1QhKb8jC
	 sgLvsY+95nyLhF/OtYNOzUfYq3rTfGVgMBabkmgnVDdjQ2PDsWGAfCeQfrvbr+jTMr
	 OriG0TAMb4kuA==
Date: Sat, 11 May 2024 12:29:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, michael.hennerich@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexandru.tachici@analog.com,
 lars@metafoo.de, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
 andy@kernel.org, nuno.sa@analog.com, marcelo.schmitt@analog.com,
 bigunclemax@gmail.com, okan.sahin@analog.com, fr0st61te@gmail.com,
 alisa.roman@analog.com, marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
 liambeguin@gmail.com
Subject: Re: [PATCH v7 5/6] dt-bindings: iio: adc: ad7192: Add AD7194
 support
Message-ID: <20240511122955.2372f56e@jic23-huawei>
In-Reply-To: <20240510-figure-cotton-1edeb2b92bbd@spud>
References: <20240430162946.589423-1-alisa.roman@analog.com>
	<20240430162946.589423-6-alisa.roman@analog.com>
	<20240430-winnings-wrongness-32328ccfe3b5@spud>
	<73365049-670b-4068-a159-fbdd0539f5a9@gmail.com>
	<d5b8b193-0694-4e65-9b0a-64fa689ed344@baylibre.com>
	<20240510-figure-cotton-1edeb2b92bbd@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 May 2024 22:26:22 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Fri, May 10, 2024 at 09:21:37AM -0500, David Lechner wrote:
> > On 5/10/24 5:05 AM, Alisa-Dariana Roman wrote: =20
> > > On 30.04.2024 20:21, Conor Dooley wrote: =20
> > >> On Tue, Apr 30, 2024 at 07:29:45PM +0300, Alisa-Dariana Roman wrote:=
 =20
> > >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 diff-channels:
> > >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description:
> > >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Both inputs=
 can be connected to pins AIN1 to AIN16 by choosing the
> > >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 appropriate=
 value from 1 to 16.
> > >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minimum: 1
> > >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum: 16
> > >>> +
> > >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 single-channel:
> > >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description:
> > >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Positive in=
put can be connected to pins AIN1 to AIN16 by choosing the
> > >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 appropriate=
 value from 1 to 16. Negative input is connected to AINCOM.
> > >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minimum: 1
> > >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum: 16=
 =20
> > >>
> > >> Up to 16 differential channels and 16 single-ended channels, but onl=
y 16
> > >> pins? Would the number of differential channels not max out at 8? =20
> > >=20
> > > Hello, Conor! I really appreciate the feedback!
> > >=20
> > > The way I thought about it, the only thing constraining the number of=
 channels is the reg number (minimum: 0, maximum: 271). 272 channels cover =
all possible combinations (16*16 differential and 16 single ended) and I th=
ought there is no need for anything stricter. I added items: minimum:1 maxi=
mum:16 to make sure the numbers are from 1 to 16, corresponding to AIN1-AIN=
16.
> > >=20
> > > Please let me know what should be improved!
> > >=20
> > > Kind regards,
> > > Alisa-Dariana Roman.
> > >  =20
> >=20
> > Having looked at the datasheet for this and other similar chips, I agree
> > that this reasoning makes sense. Some of the similar chips that have fi=
xed
> > channel assignments still have, e.g. a channel where + and - are both
> > AIN2 (I assume for diagnostics). So I think it makes sense to allow for
> > doing something similar here even if the most common use cases will
> > probably have at most 16 channels defined in the .dts. =20
>=20
> Actually, I think there were a bunch of whiffs on this one by either
> misreading the property in question (me) or not realising that I had done
> that and trying to explain what the possible combinations are.
> Looking at it now, I dunno wtf I was smoking because there's no way that
> this would be a functional binding if the min/max in the quote above
> constraining the number of channels. I can hardly blame y'all for that
> though, I am supposed to know how bindings work after all...

Me too :(  I also failed to register this doesn't constrain
channel counts at all.

Anyhow, all's well that ends well!

J

