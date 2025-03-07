Return-Path: <linux-iio+bounces-16538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAB1A56CE4
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 17:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C48C17AD4B
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 16:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCAD222566;
	Fri,  7 Mar 2025 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPyVWWfO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E337F2222B4;
	Fri,  7 Mar 2025 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363121; cv=none; b=bjrfWtkRVziaLE+KnwfGPgfqoNvmgr4fdS7ZJjGRtulISdadCfqvGwyp6Yo1tA5SP6CHxbDx4/EI2zxdA9xqd5YescvpgbMZx5E67ztOWL7kqDqUFF8QmsBxmBeafW7n6aP5jLMSaBaX0NoEvbwaEgfVJx11spLUUXV6rpaJikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363121; c=relaxed/simple;
	bh=qIjEQRPaB18kefxL0AfkJKEKomtj3Ay/2qC0bYTJ9GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VA3IPRRy2R8AnTDBIlWjCPF2AerlC1LsCz3ulb/NK2b7zlPBLvRpyb+dAXT4cLsznkp3oBhwvGvoa4dSLFLZWr9pbn9/3w21bgb5KXZ6N4Kf/XUW2ZEce3/JalOzcmZ/+IXc1TKd/v0MADtExTOge69QOQ1vUgS+32UjnLLwO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPyVWWfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F21FC4CEEB;
	Fri,  7 Mar 2025 15:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741363120;
	bh=qIjEQRPaB18kefxL0AfkJKEKomtj3Ay/2qC0bYTJ9GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oPyVWWfOwbo7R7OEgpGaAJMpK16OGzfnWJHsl0XwAQHcN/O9BR61XjSv2xvVEydn8
	 ntM7iXqKuNl8aVZVwGBLggTD+zczblQ4MVK9yL64kAwNZmusOl21kjI41FxMjuR1hN
	 wbCQ/W2/xrSajNoez1EgPJDRf/XAxaKf6yIfUuZgCX0wrT4kFkefJAicHqp/Uygcro
	 aurEoQ8+5p6RKccxdrWwfzlVuYRt+tIjdNbp0Emvn3kgPIDiuohZmjerf7PxD5BNR7
	 cfrFuzO1Z3Gcz2iM3TH8dRDZLFZ4Mg9LxEsgN5Z0i9LU8JblUfg9zsEr1BifqvaxSA
	 f967i5gFC0eSQ==
Date: Fri, 7 Mar 2025 15:58:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER" <linux-iio@vger.kernel.org>,
	"open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER" <imx@lists.linux.dev>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: Add i.MX94 and i.MX95 support
Message-ID: <20250307-county-dissuade-eed621016369@spud>
References: <20250306170825.239933-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KXsyaRMt3FIL14G8"
Content-Disposition: inline
In-Reply-To: <20250306170825.239933-1-Frank.Li@nxp.com>


--KXsyaRMt3FIL14G8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 12:08:25PM -0500, Frank Li wrote:
> Add compatible string "nxp,imx94-adc" and "nxp,imx95-adc", which is
> backward compatible with i.MX93. Set it to fall back to "nxp,imx93-adc".
>=20

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/iio/adc/nxp,imx93-adc.yaml       | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml=
 b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> index dfc3f512918f6..c2e5ff418920c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> @@ -19,7 +19,14 @@ description:
> =20
>  properties:
>    compatible:
> -    const: nxp,imx93-adc
> +    oneOf:
> +      - enum:
> +          - nxp,imx93-adc
> +      - items:
> +          - enum:
> +              - nxp,imx94-adc
> +              - nxp,imx95-adc
> +          - const: nxp,imx93-adc
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.34.1
>=20

--KXsyaRMt3FIL14G8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8sXqgAKCRB4tDGHoIJi
0sW1AQDC/Er748sapxFMd23satNd1nUEpiuLsDDeYVNHhH7FaAD+K4ncLXN2PlXH
N/Yu5AqvnRZT54ZbMVn+FGE+3SLsRA4=
=SPaL
-----END PGP SIGNATURE-----

--KXsyaRMt3FIL14G8--

