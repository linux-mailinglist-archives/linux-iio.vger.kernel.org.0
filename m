Return-Path: <linux-iio+bounces-5777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B08C8FBACE
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 19:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D933C281D1A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 17:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A040514F114;
	Tue,  4 Jun 2024 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeLdwi8c"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DA514F106;
	Tue,  4 Jun 2024 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522973; cv=none; b=kwruu7MlVHmC3nzGIeAuAIoHb2dY7RBwEVLAIQC9UI/YXIQ75GIG2IIaqPovnUAw/czhXcPRee00DXJkKRHDNMp2z9Im7sGMUdGair7ybF/m9YVHJnjsFm95vwnSd4rEXga0+clXQtYe73k7ugynEfWcs4sKqX3ylWYcU73lkJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522973; c=relaxed/simple;
	bh=9ZDdQxZgE5rT+xnz9EaVUQSZwdka7kPTuTY6LYAVhWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHq4JLKYVIXrsIabp0TrCKrGdtwMslqLMrYFb43uGI9yQyd4Hs0K1Xmx0g17CXg8CYF791BAH7TXdXyOpYG1S2G5foh53brVRMWm6D5aIWQw6Fk1CiED0WxcUneXvwfPJHg7xKJEYsFlUmQ+6YzoRa5r2LYId6DimyMUjrVfhMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeLdwi8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F19CC2BBFC;
	Tue,  4 Jun 2024 17:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717522972;
	bh=9ZDdQxZgE5rT+xnz9EaVUQSZwdka7kPTuTY6LYAVhWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BeLdwi8cSohO3ByZuLm4Tu2/0iY9vfBprVnraZqhGr11xhqvCXRjYBkCm3z1DyTrY
	 oSRSpgwxYB3P8azugzt3uSf8A1qp5OaFR7YGitqxJrKD1TiM/j/C0iJ+nrajN/PT8V
	 Qv0Foels3jbevo27oZZ+F82xxBeaYr+12JeLaUz59Ksuz3Di97XpattErpddgzfI9F
	 ENfe1Sl78gDeE+IKf96cx4vY/QEk9usypn4spj1VEdQvfSjWGwZGGgU56xthgW/T1J
	 pZWULplv/Kz7CCnbfHFY13x+qWTTbDKBjjiSlXgrfTA6ADrxPYieLMT6xFyPJposIn
	 tMqo0FLuhpxpQ==
Date: Tue, 4 Jun 2024 18:42:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Konstantin Porotchkin <kostap@marvell.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-phy@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 3/7] dt-bindings: iio: adc: ti,ads1015: add compatible
 for tla2021
Message-ID: <20240604-suspend-schnapps-191d2c1ad53e@spud>
References: <20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com>
 <20240602-cn9130-som-v6-3-89393e86d4c7@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TVLzrn2EdXz7R3Sf"
Content-Disposition: inline
In-Reply-To: <20240602-cn9130-som-v6-3-89393e86d4c7@solid-run.com>


--TVLzrn2EdXz7R3Sf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2024 at 05:49:38PM +0200, Josua Mayer wrote:
> TI tla2021 is a limited single-channel variant of tla2024 which is
> similar enough to be easily supportable through the same driver.
>=20
> Add compatible string for tla2021 so boards may describe it in
> device-tree.
>=20
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/=
Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> index d605999ffe28..718f633c6e04 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> @@ -18,6 +18,7 @@ properties:
>      enum:
>        - ti,ads1015
>        - ti,ads1115
> +      - ti,tla2021
>        - ti,tla2024
> =20
>    reg:
>=20
> --=20
> 2.35.3
>=20

--TVLzrn2EdXz7R3Sf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZl9SFgAKCRB4tDGHoIJi
0qTZAP9VTInHBzPieEsZwrjfLF/njMhzTn87Oa3SIf0ORwC1fwEAmfEN49Q5o2D4
T+05ZNpG/57fQf2cyIrNTl7y3WGByAE=
=Vlni
-----END PGP SIGNATURE-----

--TVLzrn2EdXz7R3Sf--

