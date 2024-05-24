Return-Path: <linux-iio+bounces-5272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7278CE9FA
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 20:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3DA92812E2
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 18:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383633F8ED;
	Fri, 24 May 2024 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6GaHx1U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6E43A268;
	Fri, 24 May 2024 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575905; cv=none; b=ZCKT7xyL81YTKO5sgDqDh8HBJa9O/DD76CQEP9WPV42cDr/FwmLnisQzzFB8iQi3feiFjrRbunU6O8gpxAKV/Kwdj67I1vCefyqyefuYrb7inAPLbCFt/u7H9kj0zelLH+v3LFhXpE4PY5wpjwss8p2xR9MoTmtN4iWQudwTyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575905; c=relaxed/simple;
	bh=MPzmwM32Cfa/hwgRGrz2r65tg31njSxJUb69ic81vwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMi3ztcvzBtjPjOaYKYxIG0y7GaXzUxJL85y2gI5NcjdAgn/mEIye1LmIKfeww3CThlEAnd+RETNqW0nBfO0mNc4egajzcXNdFOGfe8y/IoIc4JApkr+rFWN7QjuJLMeu5IhJwrh6QZuT5GfysG6tBR3NdTtpk/I7jZhgpYR4DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6GaHx1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87618C2BBFC;
	Fri, 24 May 2024 18:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716575904;
	bh=MPzmwM32Cfa/hwgRGrz2r65tg31njSxJUb69ic81vwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6GaHx1UFKxCCQOn/EREl8jRcMX7uh5PFRGJIL4uBstfyoNK2qOZZH2uKwPHcDoLc
	 QSHgQPSpy7G3X7TcYfo2tVrKOaNpyTDx69E7DcsB1oW7ESCVzyrtxjmXa/gAU9vHTR
	 v4gVk/Ts6vXIuIpj0ipsnKwdD0RiFQiOyNx6biyi4yGJdsq2pTDlBnCK10nvyGWv9o
	 agTT0flNJD/j82LKP0ZzphzS4cV2tiaRBfKpM1I+njyacuGVX+WXnMMCJY32kGU4IK
	 ivXn5mSaHal/yCu9Q70ypYWDfeaTGii9C3np/ORKZTpshVEAZGfR/+vBEK+ykOcG6k
	 PiHmC2ekGaKig==
Date: Fri, 24 May 2024 19:38:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Judith Mendez <jm@ti.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	William Breathitt Gray <william.gray@linaro.org>,
	David Lechner <david@lechnology.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: counter: Add new ti,am62-eqep
 compatible
Message-ID: <20240524-wrecker-busybody-2c082b87ddef@spud>
References: <20240523231516.545085-1-jm@ti.com>
 <20240523231516.545085-3-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E9Q3nvSBq6suiBDa"
Content-Disposition: inline
In-Reply-To: <20240523231516.545085-3-jm@ti.com>


--E9Q3nvSBq6suiBDa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 06:15:10PM -0500, Judith Mendez wrote:
> Add new compatible ti,am62-eqep for TI K3 devices. If a device
> uses this compatible, require power-domains property.
>=20
> Since there is only one functional and interface clock for eqep,
> clock-names is not really required. The clock-name also changed
> for TI K3 SoCs so make clock-names optional for the new compatible
> since there is only one clock that is routed to the IP.

Really the clock should be named after the function it has in the IP
block - it looks like "sysoutclk" is more likely the name of the clock
routed to the IP rather than the role it has?=20
>=20
> While we are here, add an example using ti,am62-eqep compatible.
>=20
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> Changes since v1:
> - Fix eqep binding for new compatible, require
>  power-domains for new compatible
> ---
>  .../devicetree/bindings/counter/ti-eqep.yaml  | 53 +++++++++++++++++--
>  1 file changed, 48 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.yaml b/Doc=
umentation/devicetree/bindings/counter/ti-eqep.yaml
> index 85f1ff83afe72..c4bb0231f166a 100644
> --- a/Documentation/devicetree/bindings/counter/ti-eqep.yaml
> +++ b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
> @@ -11,7 +11,9 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    const: ti,am3352-eqep
> +    enum:
> +      - ti,am3352-eqep
> +      - ti,am62-eqep

I'm going to ack this even though the driver makes it seem like the
devices are compatible (there's no match data etc) given the addition of
the power domain and changes in required properties.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--E9Q3nvSBq6suiBDa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlDemwAKCRB4tDGHoIJi
0tf1AQDclii2PIEAKJGAD1KJi4QZdecV3uYhCax+XAtJTBcW8QEA4KwtQwk4Mfib
jGDANn12fw8QkA7cVDzLlPckUIpdoAI=
=BbQp
-----END PGP SIGNATURE-----

--E9Q3nvSBq6suiBDa--

