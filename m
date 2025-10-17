Return-Path: <linux-iio+bounces-25167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E28BE6AA9
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 08:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A607A1A623BF
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 06:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA6130F555;
	Fri, 17 Oct 2025 06:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gyxVETQj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB4430F546
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 06:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682502; cv=none; b=t/5KcdBASdo3M99M3BYfzplfmBA4gQYhCCH7rLMwFEvvMlJ8ihSTBo6gXk979Uzrt5SC1HSKmeK/jb4EutRoiJMFN3bcSYWgORoGxXZGQpVHteTiGVRKNCxSCHt/QmEBLaYcLAFEKssk14Yu23xtF2csQTWahtXjrCYUepIMoEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682502; c=relaxed/simple;
	bh=1skSP4bvyaASkhMsDYC0Ytmyg9AdRRkPMR/qRR6Je64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMbpbRepLbplViJ/H/hAY1Ann8YGeYf56qTqbZQMPF/qYDOuGYkNGywWZqWaq2Wvn/aaMCwHSLxshCwz9qoOVaTAjINRScgE4Cgtb3cH55741RQve8KbJI0DVOt5bWeaXhipqhEr9csXhdn9HlHaE++0zG7sAzrwgF+bR9LMOh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=gyxVETQj; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=gJt4
	AX0jAJEsbJbs7mQWYlVKeWdnj3O5qxSO3uoznnE=; b=gyxVETQjeY7fH2Xsws1J
	6ac/EYjsehRdMuwcziAJxS2NMjf5fRJBGRCSpQ5THCE/AFUtoBqDZvGRyjM7dEXW
	+35qWLZxDNWTqkZVrpRBSYhcmg8Lhldt8KhSGSS8n+0wckvGP6xE6FhBlM2P14iZ
	pO/DXVc3OMMnebjRQ8GaZwRx9P+0bdYdq6ztTIELKeCsYsCue37D8uQFH9zYNbq4
	MNMA7VsvcBGeTbGdThluj58OZQBIfgVfgwkOz/4ZXNa/TzsRRHrvJWB0Ysr/SVNW
	bWmcUQ8tw0vm1JcU+Kp0/X6RAo1FIM6JU19h7cgvye/Z7wCyl9O+tTIknp5Km0BU
	hw==
Received: (qmail 4110937 invoked from network); 17 Oct 2025 08:28:16 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Oct 2025 08:28:16 +0200
X-UD-Smtp-Session: l3s3148p1@7tK/1lRBxukujntM
Date: Fri, 17 Oct 2025 08:28:16 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Message-ID: <aPHiAObA61OVf8mY@ninjato>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
 <20251015142816.1274605-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4YX1L8avXP3RqxRn"
Content-Disposition: inline
In-Reply-To: <20251015142816.1274605-3-herve.codina@bootlin.com>


--4YX1L8avXP3RqxRn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Herve,

On Wed, Oct 15, 2025 at 04:28:14PM +0200, Herve Codina (Schneider Electric)=
 wrote:
> The Renesas RZ/N1 ADC controller is the ADC controller available in the
> Renesas RZ/N1 SoCs family. It can use up to two internal ACD cores (ADC1

ADC cores

> and ADC2) those internal cores are not directly accessed but are handled
> through ADC controller virtual channels.
>=20
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.co=
m>

Very high level review.

> +/*                  ADC1 ADC2
> + * RZ/N1D, BGA 400   y    y
> + * RZ/N1D, BGA 324   y    n
> + * RZ/N1S, BGA 324   y    n
> + * RZ/N1S, BGA 196   y    n
> + * RZ/N1L, BGA 196   y    n
> + */

I think this table can go. N1D is the only variant supported by Linux
because others have no SDRAM controller. Maybe a comment after the
copyright is helpful stating that the second ADC core is utilized when
the adc2-* bindings are supplied?

> +static void rzn1_adc_vc_setup_conversion(struct rzn1_adc *rzn1_adc, u32 =
ch,
> +					 int adc1_ch, int adc2_ch)
> +{
> +	u32 vc =3D 0;
> +
> +	if (adc1_ch !=3D -1)
> +		vc |=3D RZN1_ADC_VC_ADC1_ENABLE | RZN1_ADC_VC_ADC1_CHANNEL_SEL(adc1_ch=
);
> +
> +	if (adc2_ch !=3D -1)
> +		vc |=3D RZN1_ADC_VC_ADC2_ENABLE | RZN1_ADC_VC_ADC2_CHANNEL_SEL(adc2_ch=
);

Are you open to either use an errno (maybe EACCES) or define something
custom (maybe RZN1_ADC_NO_CHANNEL) instead of hardcoded -1? I think I
like the latter a tad more.

Happy hacking,

   Wolfram


--4YX1L8avXP3RqxRn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjx4f8ACgkQFA3kzBSg
KbYqlA//XvIRXS8LUAF1Sr5kX0Eg9t4H+84Im2G7CLzzhz9wFd3Kd2qZ/tQFii/4
gkBUOVS0AGkh/mu8d34dz4AP/NSezG6DmMAnXYXrUl/bO84GaLRwfpySy69xT5yQ
7Ry2U8ArVK++W0a3BptjeChE4bok1PAjY2qurAkfh+RKl+k11MiEkqvltDT31KPt
/uTaEu0DoMJ88KAWENlZQqSOfPnDRRALMhiLuJpjMxlV7y4bS3vT4LFH6l/+S3kJ
tusuGZ1tzEvLVtGu4eEjUBFWdOVln1ZtbyXkFVTPA0Qql9XmGdoXjMfCAjJF7uiT
QhOuLezA0qKUvwW0xXClGIkZa1GstlNxnjedkmKj5qMaOuUr5f47kSO625nuKvUa
JApl45GgU/8s2xzZefJwGOcRrrYCsYmZCtcp6TXZrCUZEk8ENeLQt+6cJPJaDeqD
CyiMFEnpsu8kCVoKnzA/eTDyHIdoKuLOdOJQgo4i5HleU94+JWE0UxSMNjlkO8Yi
7ue4KqVK2n1Jjpb1F0DyScIrDK9EJGYtHZuB/3Z8GWW5A3A10g78qAtoRwoDp566
8xi53KVRRX6s73XfoHL9cEkxUm6t4+DQbbJFr8q/EgzDTot+nN3wOXmH1zPOWBli
emzAHMfbNDNsxrD4M4JJjPgZNYzHcp6TNOqLX/1ImirbO9mVObE=
=iNW/
-----END PGP SIGNATURE-----

--4YX1L8avXP3RqxRn--

