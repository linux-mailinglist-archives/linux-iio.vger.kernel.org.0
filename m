Return-Path: <linux-iio+bounces-7864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAE293B531
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 18:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA241C22032
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A807415EFA4;
	Wed, 24 Jul 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag4ZtEJ3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7015ECEB;
	Wed, 24 Jul 2024 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721839343; cv=none; b=pdBqW1H1N4G1BNsuplHHgdg8fI7YGo77GPaRNmgdoWYmqAISY0SqHFpvCId+KfitLO2WR4qK/k8745BVCC1dToutfPC6is3ZA31IL+MbcAo+k4E6cV83RKQCc4e3fyMSHOHK1kHHJeAdrSWqJlNTxmxBV2i//MXIM+iL67sVe3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721839343; c=relaxed/simple;
	bh=4r8Kg7lFeZE2ux1sQl1pYkAw/KLHH60ExTTgysQ9my8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQWNPTQovqKy2QVrpk/VNEPbgWlKvY99AFqxFwb7B2zRRRpUINK58bNiTRID6XcmLuJb0QYGiWr/1vrBgvfM+f0fY+kM94AFnNJgGvl32W1jWoT0CMkj5d+6jNXlp/pig4KQumXvR201VFlClk5iGTBLZvbzyj3ih0pste6nIos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag4ZtEJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF34C32781;
	Wed, 24 Jul 2024 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721839342;
	bh=4r8Kg7lFeZE2ux1sQl1pYkAw/KLHH60ExTTgysQ9my8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ag4ZtEJ3Sohcltfkb7+G1OLoMNuU+0URAj+F9TbflVFZYl7AojFZx0XaIOuCWl3bS
	 esLgTwwzq1To0Ac0XxseTtbbuSoyRnCvzPk47V5GG9Y9fTsNohoTkbuxd8UhPYY8zZ
	 HWmAybj0ucIDcSAtQsHI1syW5JOJNllok3Zvk+/Oohp1Nplq85wA5X815KZ7AzomvX
	 NxwQ+9wF00ZUL6dwVWzZgUa5RstfeW49kgFHny1vWR1k4U+Rulr68SYHV2iVfa/kZE
	 0Pvb+p2RyalVZZFtZcSKX31CLGLLfW+IOe0hyxE/xd6LbKnZEF1jCADkgs4dv5BHqE
	 fAcT4Aj3yt/wQ==
Date: Wed, 24 Jul 2024 17:42:18 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: ad7192: Fix 'single-channel'
 constraints
Message-ID: <20240724-graveyard-outshine-a53d36367655@spud>
References: <20240723230904.1299744-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1olKMOy8cF7B70NW"
Content-Disposition: inline
In-Reply-To: <20240723230904.1299744-1-robh@kernel.org>


--1olKMOy8cF7B70NW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 06:09:03PM -0500, Rob Herring (Arm) wrote:
> The 'single-channel' property is an uint32, not an array, so 'items' is
> an incorrect constraint. This didn't matter until dtschema recently
> changed how properties are decoded. This results in this warning:
>=20
> Documentation/devicetree/bindings/iio/adc/adi,ad7192.example.dtb: adc@0: \
>   channel@1:single-channel: 1 is not of type 'array'
>=20
> Fixes: caf7b7632b8d ("dt-bindings: iio: adc: ad7192: Add AD7194 support")

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index a03da9489ed9..190889c7b62a 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -120,9 +120,8 @@ patternProperties:
>          description:
>            Positive input can be connected to pins AIN1 to AIN16 by choos=
ing the
>            appropriate value from 1 to 16. Negative input is connected to=
 AINCOM.
> -        items:
> -          minimum: 1
> -          maximum: 16
> +        minimum: 1
> +        maximum: 16
> =20
>      oneOf:
>        - required:
> --=20
> 2.43.0
>=20

--1olKMOy8cF7B70NW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqEu6gAKCRB4tDGHoIJi
0rd1AP9bt5CuulmUdKrAYaMmbSBG7huuuJZ+ivBHmlTNOEBgNwD/S1zNH4h4gMUM
rhwnu+jd3UWV4Ue7R4E06VN4cNs2xQg=
=JBvp
-----END PGP SIGNATURE-----

--1olKMOy8cF7B70NW--

