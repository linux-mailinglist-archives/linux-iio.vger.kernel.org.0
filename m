Return-Path: <linux-iio+bounces-15919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01831A3FDDC
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 18:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6ACC701BB8
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 17:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139781FAC3D;
	Fri, 21 Feb 2025 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyiXXGMJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA72500B1;
	Fri, 21 Feb 2025 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160156; cv=none; b=fyMpQWJsjwm4QqVrsCcHWAEIQ/JTgJaRvnEGKs8Ckq+e8uDPCj+uNZLK72NdToU20xaxQqU0Jtgw9cdqKi5WOp4ZG3ZwBsD7DYm12WzwcUo697gxcgcvIk2j1t9gweuKasbLWF25D1S/SErhcG24s6DELCYuyUg4LoloxS2/e+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160156; c=relaxed/simple;
	bh=6JYtiUiZu542bx1Rnk2g88YxCd4cPBPV8npBQDG5FWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIqMhaJmiap/m7T/8GpjAs7YBnRdO809DHbooF2BGxSYSzzeTcO62RjzXAW2/hUgOjCEMPoYWl2OpFRmonJcSIUeLfSCG8Y0PWgNbMrS7Zyu+cMlvJokqO7r9PJReLjIW0v+txGhBbvjsWTWjZjtIl7GJVxn6pdM2jP8tComVJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyiXXGMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67FBC4CED6;
	Fri, 21 Feb 2025 17:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740160154;
	bh=6JYtiUiZu542bx1Rnk2g88YxCd4cPBPV8npBQDG5FWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QyiXXGMJAk4IlxEg1+lXDA6N+1boZJBfYoKKhrB5SLxM2BZ5QnYcG1nxEr2T/V6L1
	 K63VniUpyB8ozkCs50i5IpyUXMgpfoyx9KuvCWTcxvPnWjHdraV7huMS+8aXpxD/qf
	 GSXcDUyid0mtzK8ZEJoqaaBqTNs/5G5o41RwwS6Utm3qm9L+qrTcKCHL51xVmiV1tR
	 EMf82h/GpxT7F0tTS/ArGIhMQXN6YFhXZIGNquAbs8wIXVGlN2SLtclpSro0ZSbqLg
	 PSO19TL8r0Ptqjqw3t8OPlYMsXXsjOq74hW44JxfxravOfnSvqB3+0KhWoHpzlWlFx
	 poMlOw9BoWvtg==
Date: Fri, 21 Feb 2025 17:49:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/14] dt-bindings: iio: adc: add ad408x axi variant
Message-ID: <20250221-chop-amendment-063eabd73363@spud>
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
 <20250220135429.8615-7-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mfDG9m7sIc7aZIbM"
Content-Disposition: inline
In-Reply-To: <20250220135429.8615-7-antoniu.miclaus@analog.com>


--mfDG9m7sIc7aZIbM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 03:54:16PM +0200, Antoniu Miclaus wrote:
> Add a new compatible and related bindings for the fpga-based
> AD408x AXI IP core, a variant of the generic AXI ADC IP.
>=20
> The AXI AD408x IP is a very similar HDL (fpga) variant of the
> generic AXI ADC IP, intended to control ad408x familiy.

Very similar isn't very specific. Is it functionally different and needs
to be an enum member, or a fallback to the generic compatible is
sufficient for a driver to function?

>=20
> Wildcard naming is used to match the naming of the published
> firmware.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b=
/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> index cf74f84d6103..e91e421a3d6b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> @@ -27,6 +27,7 @@ description: |
>        the ad7606 family.
> =20
>    https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
> +  https://analogdevicesinc.github.io/hdl/library/axi_ad408x/index.html
>    https://analogdevicesinc.github.io/hdl/library/axi_ad485x/index.html
>    http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.html
> =20
> @@ -34,6 +35,7 @@ properties:
>    compatible:
>      enum:
>        - adi,axi-adc-10.0.a
> +      - adi,axi-ad408x
>        - adi,axi-ad7606x
>        - adi,axi-ad485x
> =20
> --=20
> 2.48.1
>=20

--mfDG9m7sIc7aZIbM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7i8lgAKCRB4tDGHoIJi
0oi6APoCUXAfZ/IvXoc+7oEOHcXulkK97BSMlkGZvzdBZ+epQgEA7rBJHTBr2iZb
K3ES/5nA1i9yQg8ZT6r2UKXCaYY5TAQ=
=ciLL
-----END PGP SIGNATURE-----

--mfDG9m7sIc7aZIbM--

