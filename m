Return-Path: <linux-iio+bounces-14566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A244A1C318
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 13:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AB51671BB
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 12:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6C2207DEB;
	Sat, 25 Jan 2025 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAUN/PWH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B2D1DD866;
	Sat, 25 Jan 2025 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737807589; cv=none; b=PPIjtN3ZJGYyMuFMz/lCKTh6hmQgsgBIf0tuAoEH2SIuBDGniWZgLxYHbQp4Ic/vEeBjkxC5oOm+iNUY8CN5z7gEo2ZWAOL2DCX5r+WzSvum60FXrlah0YUDUTmJGEOsDp4O4YgWhC1kL263PGklyZ/vDbophfKPEWVwh2pFMiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737807589; c=relaxed/simple;
	bh=teaYGPCKmHh3iafa1ifzi0tEEJ6ICcpSJhwsJ8G8XYw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pq307Ke61BFwhtPsLSsn2HPUhHJGH9Y5f8YfLn8f+nFo0HF60/ssdvHX9q46sPrTelDaohXT3ttUBSj7nMGqOU6xp49B3x01vXZZlI3zRA7KH0ngEqANclswPaH8qXkC1SQN2N9qLn7RIym4BcmBjle4MEqF9QoKV8BVF3nl1dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAUN/PWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729B8C4CED6;
	Sat, 25 Jan 2025 12:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737807588;
	bh=teaYGPCKmHh3iafa1ifzi0tEEJ6ICcpSJhwsJ8G8XYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SAUN/PWHFfHXXKX0uxr0Ieyr+pDGYGAmAW9nu38ajnJmRADLHgwln2I+CvimWDgun
	 FmjLKswilpX6cfUYRrjoZ9ccQbScZN2frUDL+Qde+pQJUY9Xz3sZfNDrSeIlR6rlpU
	 bwnSv2njeIUVxp9t9eQhgnmuoElsBWTPhDUU/L1Jg1xsRhsnHuEtCwsIvSsVVOFQBY
	 wKRabSSzhV+sJVGiuZgQDc9zfTLF/iSNZB1CGf7rtjr++qDt0ei5MSaMkA7wVVpA91
	 Ja8IGBpfACLqcyTBLnR1OtykBDuhj2uZKzwBnY7jCDKRhLP+st6uSIjxkOkxRegXF0
	 9Dw5dkgjDyr4g==
Date: Sat, 25 Jan 2025 12:19:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich 
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad5791: fix storage
Message-ID: <20250125121941.1270e382@jic23-huawei>
In-Reply-To: <d7aa9c53958c1e685bff9f863890bd2f0f29cad5.camel@gmail.com>
References: <20250122-iio-dac-ad5791-fix-storagebits-v1-1-53746e0f25cd@baylibre.com>
	<d7aa9c53958c1e685bff9f863890bd2f0f29cad5.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Jan 2025 12:48:21 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2025-01-22 at 17:16 -0600, David Lechner wrote:
> > IIO uses "natural" alignment so storagebits should always be a power of
> > 2. Change storagebits to 32 since that is the natural size to store 24
> > bits of data.
> >=20
> > The ad5791 driver currently doesn't use this field anywhere and doesn't
> > support buffered writes, so this does not change anything. We just don't
> > want anyone to think that it is OK to have storagebits =3D 24 in other
> > drivers.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the testing branch of iio.git.

Thanks,
Jonathan
>=20
> > Since this is purely cosmetic, I didn't bother with a fixes flag.
> > ---
> > =C2=A0drivers/iio/dac/ad5791.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
> > index
> > 57374f78f6b885e1d4f2fb452ac0563b85fc222e..034228a7c059f136cdecfb4683228=
d0be4c3
> > 7477 100644
> > --- a/drivers/iio/dac/ad5791.c
> > +++ b/drivers/iio/dac/ad5791.c
> > @@ -294,7 +294,7 @@ static const struct ad5791_chip_info _name##_chip_i=
nfo =3D
> > {		\
> > =C2=A0			.scan_type =3D {					\
> > =C2=A0				.sign =3D 'u',				\
> > =C2=A0				.realbits =3D (bits),			\
> > -				.storagebits =3D 24,			\
> > +				.storagebits =3D 32,			\
> > =C2=A0				.shift =3D (_shift),			\
> > =C2=A0			},						\
> > =C2=A0			.ext_info =3D ad5791_ext_info,			\
> >=20
> > ---
> > base-commit: 012b8276f08a67b9f2e2fd0f35363ae4a75e5267
> > change-id: 20250122-iio-dac-ad5791-fix-storagebits-9f86efa07abb
> >=20
> > Best regards, =20
>=20


