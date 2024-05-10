Return-Path: <linux-iio+bounces-4937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B998C2BE0
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 23:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E341281646
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 21:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F12513B5A0;
	Fri, 10 May 2024 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqN7jGKW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DCD524DC;
	Fri, 10 May 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376389; cv=none; b=dtpGvmKea3OzQHxV/LTTgjACO+oayJhTrv7oiKPxsBIi/FH2Ht+C69uUZQMlWg2AuJTQPCgt6RsH13OgOIi09oQtRb/opT5/4cR6MrUurE7F+0g78HBhcmYaGV954kYGl5VeVtu7tbTus4nJLj2NDJ/3P/838k/SqX1hJnDBZic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376389; c=relaxed/simple;
	bh=Pllg8sK//+UMqEigSvF6ZfmiBOjtSh9pbumGwZPb68I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcoVy+cY1+/pLgE0FlsBybjXIKCPtrtYe1wZAZNw/KWPW+C2rR3xxQmTauA49DVRgn4FeJzoA98P48xgK15hMRKC++OC9tgpd2oyHxxwj7ZQd3XTJfbUB6fvWvsYUxDiEi+PjIKoXDym+GN9mmR2AvDp3n5s1A4cmiJv+1SpCPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqN7jGKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A8AC113CC;
	Fri, 10 May 2024 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715376388;
	bh=Pllg8sK//+UMqEigSvF6ZfmiBOjtSh9pbumGwZPb68I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KqN7jGKWu1ukl2Sw1hD5n0M3gvXO7/jyOV77tmg3gQU6P/vavEMMCB8pnXldeyNV/
	 xDWPhGci2rDmvRYMoLsseRGGlb+9hgispiBM1AUY7HEh8xyyqhExsKxElEVqaJpDx7
	 eeoFjp9tW8VMC+g5zc+u/1/YcfAKCqXJ5QgX90rYT1mUpZiiMk7haM3h2+5zL4Ipjj
	 eofLbgQpQpHdQpushV2MSK4FTiUM9ZLG/DP7saMg1w0XjzOXKZ0Psv+/s0HBxvrumG
	 qzlJnQvEPKmqYHAkObwlb6/7fRoc/bUxenMDWoSXWHGxjgAmelmjuzPdYvEpBG+esQ
	 bQpp2JE7wIHwQ==
Date: Fri, 10 May 2024 22:26:22 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>,
	michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
	andy@kernel.org, nuno.sa@analog.com, marcelo.schmitt@analog.com,
	bigunclemax@gmail.com, okan.sahin@analog.com, fr0st61te@gmail.com,
	alisa.roman@analog.com, marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com, liambeguin@gmail.com
Subject: Re: [PATCH v7 5/6] dt-bindings: iio: adc: ad7192: Add AD7194 support
Message-ID: <20240510-figure-cotton-1edeb2b92bbd@spud>
References: <20240430162946.589423-1-alisa.roman@analog.com>
 <20240430162946.589423-6-alisa.roman@analog.com>
 <20240430-winnings-wrongness-32328ccfe3b5@spud>
 <73365049-670b-4068-a159-fbdd0539f5a9@gmail.com>
 <d5b8b193-0694-4e65-9b0a-64fa689ed344@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i4THszHJQ+zcpyur"
Content-Disposition: inline
In-Reply-To: <d5b8b193-0694-4e65-9b0a-64fa689ed344@baylibre.com>


--i4THszHJQ+zcpyur
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 09:21:37AM -0500, David Lechner wrote:
> On 5/10/24 5:05 AM, Alisa-Dariana Roman wrote:
> > On 30.04.2024 20:21, Conor Dooley wrote:
> >> On Tue, Apr 30, 2024 at 07:29:45PM +0300, Alisa-Dariana Roman wrote:
> >>> +=A0=A0=A0=A0=A0 diff-channels:
> >>> +=A0=A0=A0=A0=A0=A0=A0 description:
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 Both inputs can be connected to pins AIN=
1 to AIN16 by choosing the
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 appropriate value from 1 to 16.
> >>> +=A0=A0=A0=A0=A0=A0=A0 items:
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 minimum: 1
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 maximum: 16
> >>> +
> >>> +=A0=A0=A0=A0=A0 single-channel:
> >>> +=A0=A0=A0=A0=A0=A0=A0 description:
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 Positive input can be connected to pins =
AIN1 to AIN16 by choosing the
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 appropriate value from 1 to 16. Negative=
 input is connected to AINCOM.
> >>> +=A0=A0=A0=A0=A0=A0=A0 items:
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 minimum: 1
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0 maximum: 16
> >>
> >> Up to 16 differential channels and 16 single-ended channels, but only =
16
> >> pins? Would the number of differential channels not max out at 8?
> >=20
> > Hello, Conor! I really appreciate the feedback!
> >=20
> > The way I thought about it, the only thing constraining the number of c=
hannels is the reg number (minimum: 0, maximum: 271). 272 channels cover al=
l possible combinations (16*16 differential and 16 single ended) and I thou=
ght there is no need for anything stricter. I added items: minimum:1 maximu=
m:16 to make sure the numbers are from 1 to 16, corresponding to AIN1-AIN16.
> >=20
> > Please let me know what should be improved!
> >=20
> > Kind regards,
> > Alisa-Dariana Roman.
> >=20
>=20
> Having looked at the datasheet for this and other similar chips, I agree
> that this reasoning makes sense. Some of the similar chips that have fixed
> channel assignments still have, e.g. a channel where + and - are both
> AIN2 (I assume for diagnostics). So I think it makes sense to allow for
> doing something similar here even if the most common use cases will
> probably have at most 16 channels defined in the .dts.

Actually, I think there were a bunch of whiffs on this one by either
misreading the property in question (me) or not realising that I had done
that and trying to explain what the possible combinations are.
Looking at it now, I dunno wtf I was smoking because there's no way that
this would be a functional binding if the min/max in the quote above
constraining the number of channels. I can hardly blame y'all for that
though, I am supposed to know how bindings work after all...

--i4THszHJQ+zcpyur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj6Q/gAKCRB4tDGHoIJi
0jZgAP4t1kxmrJ2JJSskA6bOUNUVp7bftPdSBLKpqLDza7OBRgD+PJKBgBmrXiZD
waVTQqZrXribrQ/vRoRJHn6ayrvD/g8=
=d7Qc
-----END PGP SIGNATURE-----

--i4THszHJQ+zcpyur--

