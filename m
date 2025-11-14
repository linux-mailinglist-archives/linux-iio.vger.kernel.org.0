Return-Path: <linux-iio+bounces-26227-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5393AC5E7A2
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 18:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2FC73B0765
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CEA33710C;
	Fri, 14 Nov 2025 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MH0Cnjak"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396B3358D5;
	Fri, 14 Nov 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140401; cv=none; b=R7WyEFs60rPinoQ4Gci0th8kiWe7p1yb2aMgozyRtKV/z5GDjeqeVZ8m+RIcki3hFXdsmoO+qawP2/uGh4Uv9og5U3g1ZD7zorIgsdimFitTKZiHb3lcrDHCAfSBMc4LxB2qGw4Fitw5xdMrVsXjuCBcCuBg0axVNHkm3Z8y7/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140401; c=relaxed/simple;
	bh=+Bzp3fEwjU4swGO1VQTl09fdciqzmHGwTdRazJXd1v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AT+R7GHq6P/rDsU4ai5RgFOcX3ZjAg82c4aSyh1Ab84Syj5nr1JjJG7+bVCmRGTEhYAGUYAFCHzCr4rmI1fn+AB4bfkwoh2zK40HX0hc0qYGfjTSp1aHQ2Xz5VtK58mffL2VLbQYlTElTQ0RI/kl1LpUi53aGks3BRktfFnLMxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MH0Cnjak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58CCC2BCAF;
	Fri, 14 Nov 2025 17:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763140401;
	bh=+Bzp3fEwjU4swGO1VQTl09fdciqzmHGwTdRazJXd1v8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MH0CnjakYy5RZ5+SUyOMI7z/OrzdDgXR2Upjr4XT+ArNNO3sxNysmx7toOsg8eARD
	 tZ1cQYZW6ha9u924JKCC2szzgaHw1P4X426KxKPI634QxESflIacIwNoKVJZgbHV9z
	 xRLFQ+BFmUMrHzEEH01hawzHT9wVlRYYzzt3K0zbfx/Djy+yP8VO+YdEYqMcVkib2z
	 JZnDMNH4sR5Yf+/IT2PiQ1dy+QkEJGtAunpyJ4kSDbTG59RJgiQATDP6SFR52Li91A
	 EmHX1b9G02AVGhEmtCrqIroS2WGMLVyNsD6+ZYHCRYjUnIlsWmeSMvHWg0Sma99OvL
	 y0svXkLRFj6QA==
Date: Fri, 14 Nov 2025 17:13:16 +0000
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v3 1/2] bindings: iio: adc: Add bindings for TI ADS131M0x
 ADCs
Message-ID: <20251114-scurvy-chewable-d68637504645@spud>
References: <20251114092000.4058978-1-o.rempel@pengutronix.de>
 <20251114092000.4058978-2-o.rempel@pengutronix.de>
 <ce727652-c00b-4779-97ea-0b9e4fc3477d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hW2LHpf02kwcVMSJ"
Content-Disposition: inline
In-Reply-To: <ce727652-c00b-4779-97ea-0b9e4fc3477d@baylibre.com>


--hW2LHpf02kwcVMSJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 10:33:59AM -0600, David Lechner wrote:
> On 11/14/25 3:19 AM, Oleksij Rempel wrote:
> > Add device tree bindings documentation for the Texas Instruments
> > ADS131M0x analog-to-digital converters. This family includes the ADS131=
M02,
> > ADS131M03, ADS131M04, ADS131M06, and ADS131M08 variants.
> >=20
> > These variants differ primarily in the number of supported channels
> > (2, 3, 4, 6, and 8, respectively), which requires separate compatible
> > strings to validate the channel nodes.
> >=20
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > changes v3:
> > - Make channel@ regex patterns consistent
> > changes v2:
> > - Rename file to ti,ads131m02.yaml and update $id.
> > - Add supplies (avdd, dvdd, refin), interrupts, reset-gpios, and clock-=
names.
> > - Make avdd-supply, dvdd-supply, and clock-names required.
> > - Tighten channel validation logic for each device variant.
> > - Simplify channel description and reorder datasheet list.
> > - Update commit message to clarify device difference
> > ---
>=20
>=20
> ...
>=20
> > +  - if:
> > +      # 32-pin devices: M06, M08
> > +      # These support both XTAL/CLKIN and optional REFIN.
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - ti,ads131m06
> > +            - ti,ads131m08
> > +    then:
> > +      properties:
> > +        clock-names:
> > +          description:
> > +            Indicates if a crystal oscillator (XTAL) or CMOS signal is=
 connected
> > +            (CLKIN).
> > +          enum: [xtal, clkin]
>=20
>=20
> Usually, we want all possible properties declared at the top level and th=
en
> only limit them by the conditional statements.
>=20
> This makes it easier to see what all of the possibilities are. At first I
> thought clock-names had not been added.
>=20
>=20
> > +        refin-supply:
> > +          description: Optional external reference supply (REFIN).
>=20
> refin-supply should be at the top level as well.

Oh ye, good shout. I didn't notice those inside the list of different
devices.

--hW2LHpf02kwcVMSJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRdjLAAKCRB4tDGHoIJi
0sJ+APoDg+pqUNc7xW4MMoAewX0mgykQpAzkBKRMmQ1g/5/8BgEAn2DvdcnQvyDL
t/jNSZUt9WAvkNFqUO41Ne2ENdHy9wE=
=N05E
-----END PGP SIGNATURE-----

--hW2LHpf02kwcVMSJ--

