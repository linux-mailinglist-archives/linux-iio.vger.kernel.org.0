Return-Path: <linux-iio+bounces-7448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C3492A7CA
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 19:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7501F219E0
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 17:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52DD148317;
	Mon,  8 Jul 2024 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9a+jeTS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2B814386F;
	Mon,  8 Jul 2024 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458306; cv=none; b=YkJePTPTtxg0O0TsVPjPjpCIJttwTwVCO9TeTZzPx8b23zvfGoFBZ1ARS0sNadlYeribYpfehCP3QxF3OVaYY8477NOWRanYqkMHIWvrfsvq1cp6rG2zVt2C6CfNLZstDbIapza+RDsrvSst6cQsV0onNsqkGJBSFNRzLXJXQMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458306; c=relaxed/simple;
	bh=/ypUnOPaaDcANLO8V6xw6lc3/FNqT2W5dzoChCLg4oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGCfcBb/QbZ0zsi0gz90nEExgcpGl1WG0xfJgxjDUH0Ejiuv/OMGpoerworHFgbjZsWlvyyExbOL1C/yDyn8JLb6zNGRl3y5h9TcXMIazUKV+Xgrc/UwN8/bQvO6yeHh1WYsUcPrnpi6UDPZVXlWdQ5K6vhErXbv+oDW19uOXLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9a+jeTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E512BC116B1;
	Mon,  8 Jul 2024 17:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720458306;
	bh=/ypUnOPaaDcANLO8V6xw6lc3/FNqT2W5dzoChCLg4oE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9a+jeTSOFz+Rczh1fzBqeZNKHo/7ONwrxGlF3qfmbL6GOCx0fzBFqoHGav1Tva0V
	 m/fkGbU9xVoTqxaNqk/9wNOT+yC7KSCjIze3AdXNzZaREg3DS8AwgG7b80pzndh8o8
	 LDul23CdjjjaThee1kI6cX7MprR+gNLW3Gb7To8ElHh5Cei3r6inw19d6UF6dBZqmz
	 OxQPtT7J9F+WEB+gBMGMTa6+FrgtLy+7P1K22XdRHMKrrpHagAgQGhTVEf6JX3K9p1
	 FrogDrHX+sFZeGb2lrF8zzUJvDUOAhDf4PgNvb0p1pueljEfKCXQWV0eGWPBN37BmX
	 niYC2i17+4/aA==
Date: Mon, 8 Jul 2024 18:05:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: iio: rename bu27034 file
Message-ID: <20240708-eloquent-overdrive-092c7678f913@spud>
References: <cover.1720176341.git.mazziesaccount@gmail.com>
 <f83cf0d6f5b0ed391703ea3908ebd65b3f6e5c87.1720176341.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rE3svPFlBvjURuY5"
Content-Disposition: inline
In-Reply-To: <f83cf0d6f5b0ed391703ea3908ebd65b3f6e5c87.1720176341.git.mazziesaccount@gmail.com>


--rE3svPFlBvjURuY5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 01:54:26PM +0300, Matti Vaittinen wrote:
> The BU27034NUC was cancelled before it entered mass production. It was
> replaced by a new variant BU27034ANUC (note, added 'A'). The new
> variant gained a few significant changes, like removal of the 3.rd data
> channel and dropping some of the gain settings. This means that, from
> software point of view these ICs are incompatible. Lux calculation based
> on the data from the sensors needs to be done differently, and on the
> BU27034ANUC the channel 3 data is missing. Also, the gain setting
> differencies matter.
>=20
> The old sensor should not be out there so the compatible was dropped and
> a new compatible was added for the bu27034anuc. Move the yaml file so
> the file name matches the binding and change the $id.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> Revision history:
> v1 =3D> v2:
> - New patch
> ---
>  .../iio/light/{rohm,bu27034.yaml =3D> rohm,bu27034anuc.yaml}      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/iio/light/{rohm,bu27034.yaml =
=3D> rohm,bu27034anuc.yaml} (92%)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yam=
l b/Documentation/devicetree/bindings/iio/light/rohm,bu27034anuc.yaml
> similarity index 92%
> rename from Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
> rename to Documentation/devicetree/bindings/iio/light/rohm,bu27034anuc.ya=
ml
> index 535bd18348ac..fc3d826ed8ba 100644
> --- a/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/rohm,bu27034anuc.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/iio/light/rohm,bu27034.yaml#
> +$id: http://devicetree.org/schemas/iio/light/rohm,bu27034anuc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#

IMO this should be squashed.

--rE3svPFlBvjURuY5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZowcPQAKCRB4tDGHoIJi
0n3kAP446HgtqUolgJsUtBHi7psvLVj+ResneCECocwx8fBtbAD/WBiC8qxma0wr
hRQhZmIMBh2xZAFzTKsITSG5G1OTmgk=
=BCa7
-----END PGP SIGNATURE-----

--rE3svPFlBvjURuY5--

