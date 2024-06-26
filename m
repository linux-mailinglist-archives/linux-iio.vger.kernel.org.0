Return-Path: <linux-iio+bounces-6970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB969186E1
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 18:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACE51C209C0
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 16:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1C118EFE4;
	Wed, 26 Jun 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN+wcHBR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA2018A947;
	Wed, 26 Jun 2024 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418012; cv=none; b=B+7h5+yMBj3JWwdyLHvDUqXyZp0/AtP0DeO1XtlsMVjx3q1G+PF7+DswlqwAw5o2lb3lXW2acfIk04f4TTQa3ijlu/5BuF23c5/KGJ4X+SHJUVPp5Ph7BAY5e3lrYDMQmGwU4qut89dURlL5U3IOlxBkmZB6LmgTyrVbTura/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418012; c=relaxed/simple;
	bh=vg8bjwg9qhAceZohlSMlIDnbeR1NcResfeWT3nh4QEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYGd85+afd9bUeRzM7Oy9x/12CjvPpehRtubWBcFZ+SthjsASfy/PoXO/d4SUu3EWxkDG3NP6mQl8D8pzBtmlKCBvcQfaZdN0+OoYMYoXaHUUKhwB+k5eUHcfYoHxl4YnKzW0cvE2g/akvh764XLw+jWF4cgwoM8rLHkbSH5goE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN+wcHBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393F9C116B1;
	Wed, 26 Jun 2024 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719418011;
	bh=vg8bjwg9qhAceZohlSMlIDnbeR1NcResfeWT3nh4QEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jN+wcHBRPKfefhnzSNEvBy79OtK5kiDzy0jJcvkCw5Eexnpv5VSUkshlFSRR4uLWI
	 QX1WyVhUxBJkDaS0qfNBThjrkvu7tqTkXM6pDJsdJUVg1b0pK2SQ1Xqa2LM1zmw32i
	 DhcM9wkFyVDnAPGiomKdHKuHeoBVkI9YEBhEyC4umIDzuRLpszYbKV2isbpNWtvNpc
	 mzk199moI2PYICEWsQgyOjy3kpvoPxYLbEP/7z1nq96flvQy+8/MCQg2aqFeRo0p0x
	 IpK08IVZSFGYt1PaQYIH7YGRP2TUE1jjEoJIJjL46WxVvJg13JqO4xBS9tWPMfllEt
	 dVSCvB8sHGl2Q==
Date: Wed, 26 Jun 2024 17:06:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: light: stk33xx: add compatible for
 stk3013
Message-ID: <20240626-junior-tag-cd3e27c4b140@spud>
References: <20240625165122.231182-1-kauschluss@disroot.org>
 <20240625165122.231182-2-kauschluss@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tjyA5n3dQxWMwHsE"
Content-Disposition: inline
In-Reply-To: <20240625165122.231182-2-kauschluss@disroot.org>


--tjyA5n3dQxWMwHsE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 10:21:06PM +0530, Kaustabh Chakraborty wrote:
> Add the compatible string of stk3013 to the existing list.
>=20
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/D=
ocumentation/devicetree/bindings/iio/light/stk33xx.yaml
> index f6e22dc9814a..6003da66a7e6 100644
> --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> @@ -19,6 +19,7 @@ allOf:
>  properties:
>    compatible:
>      enum:
> +      - sensortek,stk3013

The driver change suggests that this device is compatible with the
existing sensors.
Jonathan, could we relax the warning during init
	ret =3D stk3310_check_chip_id(chipid);
	if (ret < 0)
		dev_warn(&client->dev, "unknown chip id: 0x%x\n", chipid);
and allow fallback compatibles here please?

>        - sensortek,stk3310
>        - sensortek,stk3311
>        - sensortek,stk3335
> --=20
> 2.45.2
>=20

--tjyA5n3dQxWMwHsE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnw8mAAKCRB4tDGHoIJi
0qiaAQCONvC05D7JguxYURSX5X10Y9V8bYSsS458YXvyOisjlwEA6z/4P2jNyXck
2IPKjVaY0lWYEOzh+PYOYCjiNjCUkwU=
=Ol3c
-----END PGP SIGNATURE-----

--tjyA5n3dQxWMwHsE--

