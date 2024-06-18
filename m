Return-Path: <linux-iio+bounces-6511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E060190D6DA
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 17:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACC9287383
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CFF48788;
	Tue, 18 Jun 2024 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9Gor6RB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D81D69E;
	Tue, 18 Jun 2024 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723530; cv=none; b=JPX2beOQP/uRRw83WuVgTdmDcqwkTA/RzVdFRK+FDGlpYxZVJ8O3D1oX7U/fBJdhYXTobCYAXGywJscXh50tBKR8FBUHQqtnYpe4fH2MauVKUs41JNk3kxhWOXP6rivEeKsN3xGeYLIcHKz4yeo1Uc1z0UuSg5mGyD7R0C+MuQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723530; c=relaxed/simple;
	bh=bMfJOZvYtAPMyEwZepUNDHBwH3iCBZZUTjaVItVAg7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7MLKa+8iYS5S6yh6Vm91Ya1/KnIcJXIzVsPIX2z6+fqiKhpmiUY3tSZfjidgAQtv86wzx1jBA+8DbejC3nwVcgYMoIHvmdrN53K2QWRBOUeuLQBQmwR0DfDDLDiLVD3hL2Ap0doSCN1Q/qvfEIsxr5Rb8GoHHDmaWmdZDdt2P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9Gor6RB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0626C3277B;
	Tue, 18 Jun 2024 15:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718723529;
	bh=bMfJOZvYtAPMyEwZepUNDHBwH3iCBZZUTjaVItVAg7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9Gor6RBbqpPDQKTkJ0/s1IJIT2xMDmGcy90a65TX9mZnYBmf/UEX1KwADOac+2so
	 M7oJmcGtUw4et+lq5+e6iVjQMSu2hZ2p2G/5sw0MNoKkN2zzcgeaer1Xs+2xVibjll
	 u1a0Rsy2ceOWv7tx0WHKVJrECQTWNE47sFqdHg5QZk6mF+08JujRAzNS4MoQEpC2dh
	 V/u/WcZ2E2CdWN4ToU0ILCMWOmXsIkOCavGh9i4dLGeo8tFJKBure44RY/WWkxR6pV
	 p0e4dcyICY3IcLLzYVbmboJm0nKH2dwkFYeblTX+yzGcdG1Z/9iMhESMqjqNAXGyEx
	 zI2SVIaWi6Jeg==
Date: Tue, 18 Jun 2024 16:12:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Beniamin Bia <beniamin.bia@analog.com>,
	Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH 4/9] dt-bindings: iio: adc: adi,ad7606: add supply
 properties
Message-ID: <20240618-eggnog-cusp-8b5a17313367@spud>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
 <20240618-cleanup-ad7606-v1-4-f1854d5c779d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dwSxzLPU/JD5GHB2"
Content-Disposition: inline
In-Reply-To: <20240618-cleanup-ad7606-v1-4-f1854d5c779d@baylibre.com>


--dwSxzLPU/JD5GHB2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 02:02:36PM +0000, Guillaume Stols wrote:
> Add voltage supplies

Are these available on all devices?

>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index 80866940123c..e480c9a7c7ca 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -35,6 +35,15 @@ properties:
> =20
>    avcc-supply: true
> =20
> +  vdrive-supply:
> +    description:
> +      Determines the voltage level at which the interface logic pins will
> +      operate.
> +
> +  refin-supply:
> +    description:
> +      The voltage supply for optional external reference voltage.
> +
>    interrupts:
>      description:
>        The BUSY pin falling edge indicates that the conversion is over, a=
nd thus
>=20
> --=20
> 2.34.1
>=20

--dwSxzLPU/JD5GHB2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnGjxAAKCRB4tDGHoIJi
0jfNAQD/IO92nu0o5BVlJoeT8eKFMJuXZdNa82oSRiAaZ94tqAEAsrrW1Y2fjM9G
36teI0yB8XX9R9RohxAMR5+Ln9E71QE=
=Jamf
-----END PGP SIGNATURE-----

--dwSxzLPU/JD5GHB2--

