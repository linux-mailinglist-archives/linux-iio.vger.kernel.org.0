Return-Path: <linux-iio+bounces-5010-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 125E98C44C0
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 18:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E6E1C21369
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410C1155329;
	Mon, 13 May 2024 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV8R2lzv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91B147C60;
	Mon, 13 May 2024 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616175; cv=none; b=G0fxcJmcjFt/DQoh/bi9HeLsLY+oy/vtgqZnX8Ex7kBcy3cmPIeRTy3s1cvKDGXtyYKaXGtWgVUle/FwwdhE69R0USb6T+KRG/CrA1gd6AeAcC97ZzwzcfQZ8R+/hNc3ApIJqrHjlNRqI4D1QqM5PEdy7CxyT5xBcOrJ5i/dK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616175; c=relaxed/simple;
	bh=ZYUsMvbE3F1zih0Bi+6eFTsa3DX4SbMk211lkAqs+tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oy3tAGKVg7JsIae23i0XnievxNl7qmFrd+nl3hsLFy7BooyJeYJaMEUjcrTwWONOD/4RP72kM8tQTAK2BXgVasdsI9ORdqgTYw41SdFjSTRnQgjwdJ++GduuEeueLa8yf0B99N72w4Cjk7hBp7Z68cpPGyXFkYztxQ38EqcR8iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV8R2lzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44942C113CC;
	Mon, 13 May 2024 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715616174;
	bh=ZYUsMvbE3F1zih0Bi+6eFTsa3DX4SbMk211lkAqs+tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OV8R2lzvW+ZFWLTql+BTFBNdFcEYx1ykw1rGjWKanwVpflj1gIFRKGgkhc3ti4inK
	 FhKctbkwwwWo2hSG77dyZH6cEyWrXEGm2yehZIa7dSUdfhyjIq1fYWRpIz98ImHiiX
	 SrUBKDuUP2PuHQLtkz58vPHLgmTDsVpyZqOaAYTrReonH1bfr9ZgbE/alDxLVMUq1K
	 D7avBrRQdltnxicNipUUauMXHhfVpTom13ozqhXzgNZJJDq2QNReJLkvvLQDYkn0Jz
	 DTuuilsgJh4RXCm69LCwEE3XYlkf3NksyvCTMF5nHHhGOryhk/U0pz9JWsddrtDqmm
	 wxeSMu6W6el3Q==
Date: Mon, 13 May 2024 17:02:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lars@metafoo.de, christophe.jaillet@wanadoo.fr,
	gerald.loacker@wolfvision.net, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: vendor-prefixes: add ScioSense
Message-ID: <20240513-credibly-expanse-dbf321dbdb30@spud>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
 <20240512210444.30824-2-gustavograzs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GrsbxW7unxrSDcxV"
Content-Disposition: inline
In-Reply-To: <20240512210444.30824-2-gustavograzs@gmail.com>


--GrsbxW7unxrSDcxV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2024 at 06:04:37PM -0300, Gustavo Silva wrote:
> Add vendor prefix for ScioSense B.V.
> https://www.sciosense.com/
>=20
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--GrsbxW7unxrSDcxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkI5qgAKCRB4tDGHoIJi
0tTDAP4sF1wdC+ZxfzjWrsk79d1EzW/3V7hiRnOSOIuZ925M7AD/UnIxJmsjvKxz
lrbqg1YRiI+jtqy8PQJkG+hg4z+hIgY=
=rUFx
-----END PGP SIGNATURE-----

--GrsbxW7unxrSDcxV--

