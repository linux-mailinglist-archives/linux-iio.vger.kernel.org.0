Return-Path: <linux-iio+bounces-13028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE0C9E28A0
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 18:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0897EB84133
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFDF1F76D7;
	Tue,  3 Dec 2024 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grFFN0kd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F7823CE;
	Tue,  3 Dec 2024 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241883; cv=none; b=A2s0wI6irk2LoflisA81ZeszBpjedIsZwbzj5w2RNC0L3WYUR4uEjfZj76uMKjTrseXSLML0n9LwQZH23o+CBvch19YLvz9Q40/WPTSMNOABGLyAEpLXxprA0TCxnmp0Xzm/yBxCN/hykpSmwtX78dr/AYc7oO7qJKiBpQjBH7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241883; c=relaxed/simple;
	bh=nRqnMdmSdkD8myJJwIC7IooohtKniiu1ECEsFhV/dGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSo4lkVOyUewEaxy+EPkbMg8/WeBSil2c1F/KQwy3cbygBTd4QXauiWNb2L/VgvEEv6OG9ehwhZBZ25pruEwvALUENJ2Y8A9m+WBU2dodu33HfMyhuu5NLtiI9EITAaeP6/v2D0hg/bZMKREdYh/iYXaH8yEf4g6ExghExh/3dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grFFN0kd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926C5C4CECF;
	Tue,  3 Dec 2024 16:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733241882;
	bh=nRqnMdmSdkD8myJJwIC7IooohtKniiu1ECEsFhV/dGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=grFFN0kd9NcI2IDb79VQgisVVmIZ3ospPp8STXIwI/dRKnZZM6Oa2PEtAvExVhLwF
	 nfi51IgAai4Eeh8kfjv5EDKSnMCgcEgafbAieFnxwmTmOxoVzYWzD49tpVxF/YqXDv
	 BxUrjaegzNIIuBD2VbFq5egWBd90hlS8DxP3r1vfAJ5LZqh0vg5pHq4KAGufjRI30t
	 IktpNDUXVG1PUzEIj1KCKIAMevhHnte7xgwXYH27x0SOslc+bgDibmn66pzu4rj3lk
	 cqBZsNsYTXf5J8eU5IQttGEyiHCPj94CpmXn3k2PqCN2y80HUBQEttQNWtmInuy54P
	 34pVDr7hTDntw==
Date: Tue, 3 Dec 2024 16:04:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 11/14] dt-bindings: iio: adc: renesas,rzg2l-adc: Document
 RZ/G3S SoC
Message-ID: <20241203-germproof-trustless-2dac494108c5@spud>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
 <20241203111314.2420473-12-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z1zHaRpyP0LEy9hx"
Content-Disposition: inline
In-Reply-To: <20241203111314.2420473-12-claudiu.beznea.uj@bp.renesas.com>


--Z1zHaRpyP0LEy9hx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 01:13:11PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Document the ADC IP available on the RZ/G3S SoC. The ADC IP on the RZ/G3S
> differs slightly from the one found on the RZ/G2L. The identified
> differences are as follows:
> - different number of channels (one being used for temperature conversion=
);
>   consequently, various registers differ; the temperature channel
>   support was not available for the RZ/G2L variant; the #io-channel-cells
>   property was added to be able to request the temperature channel from
>   the thermal driver
> - different default sampling periods
> - the RZ/G3S variant lacks the ADVIC register.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Z1zHaRpyP0LEy9hx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ08sFAAKCRB4tDGHoIJi
0p+tAPwMh8zI0++xx3R2Zh80mJF7DF27Po96tIFFzd/ioaoymgD8DJ9ST9OY9m32
j+UiLN0r0ajtiqSmAPs/ES5YKbkVkww=
=s+EO
-----END PGP SIGNATURE-----

--Z1zHaRpyP0LEy9hx--

