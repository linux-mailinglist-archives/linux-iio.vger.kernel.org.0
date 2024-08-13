Return-Path: <linux-iio+bounces-8444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CCB950949
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 17:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BA028339F
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67F51A071A;
	Tue, 13 Aug 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrlopLCH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66A191F71;
	Tue, 13 Aug 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563667; cv=none; b=b1fdARi/7Pk3qsI4dEgH/+qy1CRKB5gLMoTKHdO3dBWYSlQ0diYJ9+dNk9yrtRVaVD9ns07Bhjy7CZYcEmuJ/UVqUgHpjFKWOekKyp9iTDqiUv63mKBP2U9gjtiQ+zdaFQ/9xHtIn7fz1wJX9XRJAo5l/a/FjmvcA4ZaFLr2+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563667; c=relaxed/simple;
	bh=hDd5r8fffmfLxn++tGZ27rMp6epK7JR5Z6262s6Dh+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8Xk1tI4lgocR400n92CNyMKaG3QL643dY8E4Ntadpi8Wmw6LTaJSbqe5m2N6h3Xz1DkZr+ezdRY3bGD67U9xrl74z39u7zT/M/MaNn3BV738PPVeryqEYAbk9SwbrLk8JxLdGPHjqmRsNMSOy3VkcJMhhzarjvZnkjMfwjYaEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrlopLCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16730C4AF0B;
	Tue, 13 Aug 2024 15:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723563667;
	bh=hDd5r8fffmfLxn++tGZ27rMp6epK7JR5Z6262s6Dh+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rrlopLCHKFeIke2iSLlpXJ27/g5vxsy1mcXGlzyHm9s8CX4RP8m57//zt25HQjooz
	 4GCjD6Dqfl0GZJv8zUzPi7MlcnocqNPkJGStHrKZWPoQT/Qoh87n0iZjq7+HRbFySp
	 0isK5Y0JyLGy2EYzt0HPnn1yDdUoRimPgEZVmFXOF1Jj8QiPXiRmMUGmDbkd+uTgqj
	 fSLpiRUrP1hgsdu5vodPwx99iIiRdXfu5yTsrOv6QXA8S/a58QlA0TOHbstiFCDgXt
	 vhhWhHEkvdFiphnLpZUMF2kxrGYZjQv5Mzvczih7prP8jeJ8C1sY2mHTop0oCWZegs
	 XHb2o2DMgZhiw==
Date: Tue, 13 Aug 2024 16:41:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Chao Zeng <chao.zeng@siemens.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add EVERLIGHT
Message-ID: <20240813-moaning-scrabble-48599c03b459@spud>
References: <cover.1723527641.git.jan.kiszka@siemens.com>
 <1c79a109a7e91927a9380d2aee91fae32848d7f7.1723527641.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dn14bWwsrgFYSkP0"
Content-Disposition: inline
In-Reply-To: <1c79a109a7e91927a9380d2aee91fae32848d7f7.1723527641.git.jan.kiszka@siemens.com>


--dn14bWwsrgFYSkP0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 07:40:40AM +0200, Jan Kiszka wrote:
> From: Baocheng Su <baocheng.su@siemens.com>
>=20
> Add vendor prefix for EVERLIGHT Electronics Co., Ltd.
>=20
> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>

This is missing your signoff Jan. With it,
Acked-by: Conor Dooley <conor.dooley@microchip.com>


> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index a70ce43b3dc0..1d2bf326fe91 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -486,6 +486,8 @@ patternProperties:
>      description: Eukr=E9a Electromatique
>    "^everest,.*":
>      description: Everest Semiconductor Co. Ltd.
> +  "^everlight,.*":
> +    description: EVERLIGHT Electronics Co., Ltd.
>    "^everspin,.*":
>      description: Everspin Technologies, Inc.
>    "^evervision,.*":
> --=20
> 2.43.0
>=20

--dn14bWwsrgFYSkP0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrt+jgAKCRB4tDGHoIJi
0mZcAQC/mXyBrL54wAf/6EC+tJaig0nyHnRC8PRaqdzL5dIKigEA00QcMaaABVaC
KY86u5TeWp9F+WGvGcfb7FoZylH7QQM=
=ILKK
-----END PGP SIGNATURE-----

--dn14bWwsrgFYSkP0--

