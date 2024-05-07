Return-Path: <linux-iio+bounces-4860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083488BE777
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 17:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71D3285CF0
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 15:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722381635D5;
	Tue,  7 May 2024 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnJ2d+0Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C48014EC79;
	Tue,  7 May 2024 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095959; cv=none; b=pShRA1iR+G1jbo5R1fGlVi1Krh+RiUbHrojqQoHyeRrryDfhJxXPuor+TCO0G6EGICHVbVSyZsUZjG8CcGmRSWKrtMynPiGUR2c2PCewp8zZj2x+eZxqbL7wJTqzzX6UlAdI4K1R56K2C1ObdkPAZw/LAQ3z7WfzRsM3Qhqwc1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095959; c=relaxed/simple;
	bh=Ou2zeBM3QxUvyYDfBrHE0Lbt7oXWCXliKJ4+o7Ci9to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bsgx3CkUNWPLx5Dxq5dYwAjO8dDUqfH0R3obaAgY3/nmKtegOEaMRUG36LaZkWWgsB5RrUFzBGAY0NXFHihF6h3DoeMG54SvqnQB9rOLNRLOCmRfoanevNJae6XsIfcf6pIuUTa+KtyAwcJbEH/faEavCglm6Urp+Sbl86r+RLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnJ2d+0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF870C2BBFC;
	Tue,  7 May 2024 15:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715095958;
	bh=Ou2zeBM3QxUvyYDfBrHE0Lbt7oXWCXliKJ4+o7Ci9to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnJ2d+0Q5PTpw7KYJRs0p4OfwojxugEtKjGqEiVP+ZafwLPzBsp/kkR7pKhFV2vX0
	 EVKe2uQhW2d7vPlarApQ6fAN5NDmDHnlQKorVNCpEJv5Gc/wy4EhCi7za0xMljzyMW
	 rbYunMzgb6wJakhWt7ROf0nDey+vv9F7cRVp3XeLs0xSDe2duscxyGc4xxekE6pMA+
	 utxaU66zgNIj4R+X7liz/JtdIsZM59iT3fz/rwx3DL0XhpEXt0cSI0g/pe05goS1Ot
	 g3st1q6c8yTf7Ai/EJzVWWo7LGOvNCga26PkRoVdHYeekIEmKrcsAYq3QcdBuHuS2H
	 ul3JyjppYvTDQ==
Date: Tue, 7 May 2024 16:32:34 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <trabarni@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: imu: bmi160: add bmi120
Message-ID: <20240507-throwing-squealing-606f5d8ebd5b@spud>
References: <20240504-bmi120-v2-0-3b3ce6e1c3c6@gmail.com>
 <20240504-bmi120-v2-2-3b3ce6e1c3c6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zHUfXpDt/8/b/n3m"
Content-Disposition: inline
In-Reply-To: <20240504-bmi120-v2-2-3b3ce6e1c3c6@gmail.com>


--zHUfXpDt/8/b/n3m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 04, 2024 at 02:59:49PM +0200, Barnab=E1s Cz=E9m=E1n wrote:
> From: Danila Tikhonov <danila@jiaxyga.com>
>=20
> Document bosch,bmi120 compatible.
>=20
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> Signed-off-by: Barnb=E1s Cz=E9m=E1n <trabarni@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--zHUfXpDt/8/b/n3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjpJkgAKCRB4tDGHoIJi
0jUqAP0bwMEV57V9wdleYT2GDt/j5RfTV6A931H8hMgz361SnQEAv05YU6fqSPgW
+dE5egZOrmdLdi8JDxwv9aNb3d/qoAE=
=taDr
-----END PGP SIGNATURE-----

--zHUfXpDt/8/b/n3m--

