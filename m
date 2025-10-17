Return-Path: <linux-iio+bounces-25168-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBF3BE6AD0
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 08:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEF01A65B00
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 06:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5211E21FF2A;
	Fri, 17 Oct 2025 06:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="JqnZ+cYf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD9A2417C2
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682635; cv=none; b=H79X54qtbbgMNaug3H/QT/g0aobjV4Ts+W2q/f+8nLyjaZcIoCmbvwXOp9gA24Uc26q6AexZXi18WRPtyZZA0mjshPYDC6+0Siv2+2tOEV/b66rWRmdR38tOtg/Zc7NzxOGti3MrxHr0O3WOjLjLmRdSS7aObt0+OsFLWHkpeLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682635; c=relaxed/simple;
	bh=uFu+pTsB8pI+GUFdNcyatCeYuZ876YAOsDz0NEO58Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+HpzzCfwsTDdW89mJMjy1I1XWqRupeNhQaLLSXXk/LcjRFXljlLmuxNu18F2Pg0ngiv2iiCuzmknX00EBt2l44nuOdGdzQIUHMmbimcMxS6gJo51BRNazqWSxGZpUX9JYVHmo3yyZg3nrLbP+sa5Yt0bSqPgRlSAmKXZVGSoJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=JqnZ+cYf; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=O7xM
	+w8vsz249zp6iqPFcWLDZWbI7OmkhCv22ZDZ8dY=; b=JqnZ+cYfaBiwYLqZ3hb9
	RufOrc/DIqfzl2CN+ULsF2rqaTW0p1R4Bl0vM3XU7GmibxziIeVT+hcl6irEZtuH
	yoo+qanSMLZFST3UZiLYaLnhCca+pYJnjlQHN3XNT3frtP67tvaD2+a9nWO0SemB
	kC92CYuneMN7pCADiKyFQSL4VcFT4DDLh3D/6tusI2PPFIZdTEqne19S7D50frz0
	+qbaCXvK73q8mZhvO29n2jtME1b3ImVXjh5GDJXhwuuaceIAxHJp+c99VojjkZdS
	kBYUOnlWWeI3KyNNNPbuB3wjfulNVaiiylytoJD/MiLv71+qCzwyI0fJddGIrSgg
	TQ==
Received: (qmail 4111707 invoked from network); 17 Oct 2025 08:30:30 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Oct 2025 08:30:30 +0200
X-UD-Smtp-Session: l3s3148p1@u33E3lRBLLQujntM
Date: Fri, 17 Oct 2025 08:30:30 +0200
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
Subject: Re: [PATCH 4/4] MAINTAINERS: Add the Renesas RZ/N1 ADC driver entry
Message-ID: <aPHihgPNuQgURAmY@ninjato>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
 <20251015142816.1274605-5-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oI+TfPz1PKdbXmGE"
Content-Disposition: inline
In-Reply-To: <20251015142816.1274605-5-herve.codina@bootlin.com>


--oI+TfPz1PKdbXmGE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Herve,

thanks for stepping up to be the maintainer!

> +RENESAS RZ/N1 ADC DRIVER
> +M:	Herve Codina <herve.codina@bootlin.com>
> +L:	linux-iio@vger.kernel.org

The iio list can go because it will be added by the generic IIO entry
which handles all "drivers/iio".

Happy hacking,

   Wolfram


--oI+TfPz1PKdbXmGE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjx4oYACgkQFA3kzBSg
KbYIdg//d8odnCOfUdJMRpsordOI1u251bqcKLtuIlx2FwJsdyg47s7tbUK3oprR
yMStg9prZnLZSPQKqYkpOIMorzObKYReac39MZA/JavrNXWWEesUZfk9dn6sQbQL
HgQuf+yshlwQcoUOBC6M6hPPyW7HdTdTg/jm1bPs7c/luj8AmI27QMV8VANS3RWX
mmw9kVX12cnxAgvJZUmB3oLJp/EAawZaJNFr1KLAb33x/18h7M9r3KLK+1/Zm4vy
kEHBr99Ge8yKULEj+fSzNjlatAePEybVVs3d4jlZcY5kIx6rDOb7QpxHMWz1FmN2
wC+lwzgih8FM/0MKTpzQTWI9SJZaqhEX85J989BQWI0BjFhYCUAlfIFNY+vq1wnp
qQ3vOqS0Gg/m0Z0/HWYYHYC8mn+MFgNcJOs/LCY7az734pZkGLFjdziVuyKUDG0p
ac9re17ls1ofpxNIVD5REi53v/tC1pGi+9gCu3zd0DHqgW6pAvGUHQSWBptAzlut
enzIyHOniWzuhxvmMGn4NhzheWl8s4TKlA+T2UyVJQbuouul52drmcAKFncly9nR
6KBfEANO9MX+JEtlbO8aBbbQs1cMjMVkj+GxmZ6UK1C+JVQY8vwXHGAmVThq/KvK
Xhk9N6ys8CcoC2gRfUCC+U8FPf0v8MfESLdyqC5Cvzio5WDL7TU=
=2Lm9
-----END PGP SIGNATURE-----

--oI+TfPz1PKdbXmGE--

