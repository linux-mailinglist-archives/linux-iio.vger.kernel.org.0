Return-Path: <linux-iio+bounces-12267-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FD29C92F4
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 21:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04A11F22847
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 20:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAEA1AAE02;
	Thu, 14 Nov 2024 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0sWXXBn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA971EEDE;
	Thu, 14 Nov 2024 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615055; cv=none; b=hrnGK8mJ2NA6UXiVUsQHVmAOsm+SQhSuNxt5JsHlyb2Kb7oTxlwG0qpk3QzodE/9g7+O4AXw7nSsDAEornmtYzjh+8Y1MqpIMUB3y2UNQraPxS9HvD8HvwGCWO2SbAayjQEmbdnxeOVzkLf/PWoaX8QULhSrsm0sfzHwV5DYHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615055; c=relaxed/simple;
	bh=bblZEPVR6b3uGBtW1kaMS6XG3kAFVfeGzhKTpPHpw1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROfcYOCXZenHG3fUZUNARSunlEvsmxk48Os0LFp5Sl16wR4jdww9cssp+xLGvnqyLphCR3Isw2Cr13CQjwAuDlcW/r3fRSszI9QfC4hGLr8qCIS2cuRy5f1AnRBVbqelknuZg2vGxWQKqrpm+6Am5ZXH7y8flQrhITfszyMoDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0sWXXBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC9EC4CECF;
	Thu, 14 Nov 2024 20:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731615054;
	bh=bblZEPVR6b3uGBtW1kaMS6XG3kAFVfeGzhKTpPHpw1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O0sWXXBnSwAp+v4JuIQb4xY0WDw6LG3RlS0IA2afzOjvHdmvJRPWkp+SzCAMqfLpk
	 qf96WDwYiU1ffMfVtT1fobvYhrzdFUJ1Sv/vlb501vMGRWFXXTrAHlSCU0fxReHPXH
	 v37GO/8wkDqQJCY5MpyF3s9DjyGljtRs8fq2Afle5Neus7qBaj9dvCeKf0+JtUKabt
	 LmpW8pn8sCfp50SPJAutAarAiWhtvs0xD5yLYGN7RV8gK1lb2bUu4lYFcDycH4m4SX
	 g1bQwEvNvKwUOoswEAnEH9vSr4aMk6hugWqO4LFvVScbdnlL1xBHJThCrQFa5jITI9
	 Rxena9Uikv3IQ==
Date: Thu, 14 Nov 2024 20:10:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: ROHM KX134ACR-LBZ
Message-ID: <20241114-afterlife-ride-08068767f1e4@spud>
References: <cover.1731495937.git.mazziesaccount@gmail.com>
 <d979a0a8160118d560ba2255346d05237f73b9ce.1731495937.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tth/TTD3Gd9N/oPl"
Content-Disposition: inline
In-Reply-To: <d979a0a8160118d560ba2255346d05237f73b9ce.1731495937.git.mazziesaccount@gmail.com>


--tth/TTD3Gd9N/oPl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 01:20:49PM +0200, Matti Vaittinen wrote:
> Add compatible and information for ROHM KX134ACR-LBZ accelerometer.

The commit message mention what makes this device incompatible - but
I'll let you away with it the description below contains it.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  .../devicetree/bindings/iio/accel/kionix,kx022a.yaml          | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.ya=
ml b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
> index 66ea894dbe55..c973f4941a6d 100644
> --- a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
> @@ -11,7 +11,8 @@ maintainers:
> =20
>  description: |
>    KX022A, KX132ACR-LBZ and KX132-1211 are 3-axis accelerometers supporti=
ng
> -  +/- 2G, 4G, 8G and 16G ranges, variable output data-rates and a
> +  +/- 2G, 4G, 8G and 16G ranges. The KX134ACR-LBZ supports +/- 8G, 16G,
> +  32G and 64G. All the sensors also have variable output data-rates and a
>    hardware-fifo buffering. These accelerometers can be accessed either
>    via I2C or SPI.
> =20
> @@ -21,6 +22,7 @@ properties:
>        - kionix,kx022a
>        - kionix,kx132-1211
>        - rohm,kx132acr-lbz
> +      - rohm,kx134acr-lbz
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.47.0
>=20



--tth/TTD3Gd9N/oPl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzZZSgAKCRB4tDGHoIJi
0pKlAPwLSaCuhpFuooqQFdSNRR302NNIX6H6HMMQ1JqE06rjZwEAubI22rFZ00qT
w30a289Tfr8w6clBVGSotSgOnGMpJw0=
=G3pR
-----END PGP SIGNATURE-----

--tth/TTD3Gd9N/oPl--

