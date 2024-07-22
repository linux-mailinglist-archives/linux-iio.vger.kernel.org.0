Return-Path: <linux-iio+bounces-7792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E229392F4
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 19:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD96282293
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 17:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7076816EB56;
	Mon, 22 Jul 2024 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bp0MY6Xz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B14A16D312;
	Mon, 22 Jul 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721667905; cv=none; b=ILXTkaWv5qDAmY6IUa0GKGnS7yn/kFz31cTaQqzqUJ943Ij8/FNHzX8mqxCM3eQOgDf5qkpyqFW9CAINFVDGNrij03UrgZpvkRCFcz2gX8pCgaCru2RCzibW53yFtYZXfk3k4VkwK8NH4VfDcBovOUC6q13u7RybWjVdnT9ap+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721667905; c=relaxed/simple;
	bh=j8n8Jqt0qFOtbSwm/hNbavTr8cougfs0ozqvm3fu8lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TM/VBoGytcuiV/CPe0LajRot1VouRjdRL5xqQNcOmZ0v7XFLpdVrMeabZM6bfgqK1poEkhMRc5lJ0N8Ck726hYjuc/yJJnYXMRqxCTaxYiqKascOS51n7o+UQ0JuD750/6q6CzrmwveihC5L1tv55Q3wrWibXWai1Jki11SudI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bp0MY6Xz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A5DC116B1;
	Mon, 22 Jul 2024 17:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721667904;
	bh=j8n8Jqt0qFOtbSwm/hNbavTr8cougfs0ozqvm3fu8lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bp0MY6Xz0hrjbUv4XVnl0d/gCIoXDum7ldPkvros/xcRHrv4XoxXtVFrzPacS2Yx1
	 r3KaUSBaNS4hGU5xNY0nBWv3LRXbkmkpO7C0AItgVO/mJe9o1xkyLPVonCGWsadSIj
	 kUBq0QcBGIPpPcoC8h+KsqQHt0oduwvtPeuQyfmzm3f1juY7CmRefS5Mk6apydptVh
	 MeKwL5hnT2o9gFa+284K+R3NYAIaecxFupQk8jjkDCFFM0DZTTDx1PFLSqtBRG9S9O
	 uprakCEoLxwa8258CYKnR674OxDZCKb14o91FGSEtM49ikC90PyVmdRbqbgwR+t3NS
	 rTea9PfW6UIDQ==
Date: Mon, 22 Jul 2024 18:05:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: light: stk33xx: add compatible
 for stk3013
Message-ID: <20240722-affection-abstract-57fb331782e3@spud>
References: <20240721-stk3310-v3-0-98fcb6f551a1@disroot.org>
 <20240721-stk3310-v3-3-98fcb6f551a1@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gUB/I20dU10rvQFg"
Content-Disposition: inline
In-Reply-To: <20240721-stk3310-v3-3-98fcb6f551a1@disroot.org>


--gUB/I20dU10rvQFg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 21, 2024 at 03:44:31PM +0530, Kaustabh Chakraborty wrote:
> STK3013 is a proximity sensor by Sensortek, bearing chipid of 0x31. Despi=
te
> being marketed as a proximity sensor, it also appears to have ambient
> light sensing capabilities.
>=20
> The part is fully compatible with the existing implementation of the
> device driver. Add the compatible string of stk3013 to the existing
> list, with a fallback of stk3310.
>=20
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 13 +++++++++-=
---
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/D=
ocumentation/devicetree/bindings/iio/light/stk33xx.yaml
> index f6e22dc9814a..d5f6b622c8da 100644
> --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> @@ -18,10 +18,15 @@ allOf:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - sensortek,stk3310
> -      - sensortek,stk3311
> -      - sensortek,stk3335
> +    oneOf:
> +      - enum:
> +        - sensortek,stk3310
> +        - sensortek,stk3311
> +        - sensortek,stk3335
> +      - items:
> +        - enum:
> +          - sensortek,stk3013
> +        - const: sensortek,stk3310
> =20

=2E/Documentation/devicetree/bindings/iio/light/stk33xx.yaml:23:9: [warning=
] wrong indentation: expected 10 but found 8 (indentation)
=2E/Documentation/devicetree/bindings/iio/light/stk33xx.yaml:27:9: [warning=
] wrong indentation: expected 10 but found 8 (indentation)
=2E/Documentation/devicetree/bindings/iio/light/stk33xx.yaml:28:11: [warnin=
g] wrong indentation: expected 12 but found 10 (indentation)

=46rom dt_binding_check, please fix.

>    reg:
>      maxItems: 1
>=20
> --=20
> 2.45.2
>=20

--gUB/I20dU10rvQFg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZp6RPQAKCRB4tDGHoIJi
0hGyAP0Yjy4k3EiRFrSECTSRI/KRAlzCegxC4Fb00ftvLlTJqAEAuJP1AtuA7Y7d
oybNBqFV/wbCqMEQRbcTa/kwvxId7gw=
=IwyL
-----END PGP SIGNATURE-----

--gUB/I20dU10rvQFg--

