Return-Path: <linux-iio+bounces-9521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF3A978780
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 20:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BE8289410
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA7D126BF0;
	Fri, 13 Sep 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tv71CAS6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9731684A40;
	Fri, 13 Sep 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250842; cv=none; b=m6iKpZmKrBt5xRkn44awf3gnutd1zSHpknHRHYYrU/lrTjUrYkoSDCCim/9/8dLuvM9eCiCVFRQecHa66egVyMre3GbhQr9EFzCkGQdW2KIywQAZC/eC4YD66N965R95NShylSEQgLKSlIbO1I28vF78yYDih0/fqlB0UkwJSMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250842; c=relaxed/simple;
	bh=WBLnnwyIn8w3d6CyiQ5QRfFUDAUXUgM89Rb9FC2tTuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpMkks+fO40qQx/yKGbr3Vjd0b/y0AYpeWfSvVnoZhXxscS/r+9+w9reFhWnX3CMQ6YzUQpR8JXdi+FRNKMg5KePleVpgFRcYFqG07DsucDLVi5V0ZqkgHWVDy30abfrK6epuHBuI4fA3eHx5fImTWfhm4XqpR/BoUZkMqbbnto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tv71CAS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C91C4CEC0;
	Fri, 13 Sep 2024 18:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726250842;
	bh=WBLnnwyIn8w3d6CyiQ5QRfFUDAUXUgM89Rb9FC2tTuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tv71CAS6S+Rn/U6AgWyhAvSEENpd0fXHR2JGo+NxDsSjcvv4XSXTTDcvomlbr4pVL
	 761kLpNapeJsT+mnqSsW0fYFtjAstxZzQgAIhmNUGj0nzwrhYoYuq6BsMZ8Wis+SOA
	 fwTYtlxbFnMKHZCZU9I38NYsjbI2j8WNghKSRqo+fOYT9nTznxJgXHokC8DQr7OSu/
	 q8uzJESdASA+VHrD54jAzdR/FTI8CWSS32RiwLWcja1D+imWjLTJGOhkvSMIijs0bC
	 EG7szqoEss2dkcxIV9BKCwYPwrN4P8Jdta+pMMAHry85pcXxDWlQ5xawKlmH/gKYQd
	 I8ch69EbpfI/w==
Date: Fri, 13 Sep 2024 19:07:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Emil Gedenryd <emil.gedenryd@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andreas Dannenberg <dannenberg@ti.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@axis.com
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: light: opt3001: add compatible
 for opt3002
Message-ID: <20240913-stimulate-swell-3964c45e6e81@spud>
References: <20240913-add_opt3002-v2-0-69e04f840360@axis.com>
 <20240913-add_opt3002-v2-2-69e04f840360@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MTkaypvhF8DGEqkj"
Content-Disposition: inline
In-Reply-To: <20240913-add_opt3002-v2-2-69e04f840360@axis.com>


--MTkaypvhF8DGEqkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 11:57:03AM +0200, Emil Gedenryd wrote:
> OPT3002 is a Light-to-Digital Sensor by TI with support for wide-range
> spectrum light.
>=20
> Add the compatible string of opt3002.

You should mention what makes the 02 and 01 devices different here, and
with that done,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
> ---
>  Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml =
b/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
> index 441e9343fc97..67ca8d08256a 100644
> --- a/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
> @@ -15,7 +15,9 @@ description: |
> =20
>  properties:
>    compatible:
> -    const: ti,opt3001
> +    enum:
> +      - ti,opt3001
> +      - ti,opt3002
> =20
>    reg:
>      maxItems: 1
>=20
> --=20
> 2.39.2
>=20

--MTkaypvhF8DGEqkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuR/VQAKCRB4tDGHoIJi
0mk3AP9Mdpd5kDmgviAPbnYr/o6taLkyGrfPkZYsZSB9P7CU1QEAo4Cun+yDOwLB
7R92PVr/Fyr+wIcMVNHu7PnQvvogLwg=
=LyEq
-----END PGP SIGNATURE-----

--MTkaypvhF8DGEqkj--

