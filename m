Return-Path: <linux-iio+bounces-24886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C6BBCAF73
	for <lists+linux-iio@lfdr.de>; Thu, 09 Oct 2025 23:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26DC41A64A80
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 21:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42AD272813;
	Thu,  9 Oct 2025 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="driywclE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46338274B5D
	for <linux-iio@vger.kernel.org>; Thu,  9 Oct 2025 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046283; cv=none; b=jOje9OCUpbgZxgP0UEVW21dPwvdj/R9cV1Mj5lWOK0vVRoGFYp9Vsf5shaca3GO0il3hDfTLdYZjSKudMu8TdbeNO1Mmz9XY7Y79DEMNliUjR9kCbGMhl96Sg7tN1J3dJ4SBFRkoSwTWFERX8BzMCp4D2a5gwTJwJV8xdTCVRec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046283; c=relaxed/simple;
	bh=hsKMli2TWpI7iWaO3vpGIpuuDDdFUHmjj4yc4Q0WZvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxQRGvingd1Z9g+4L39u7kMUy7JIbaR9RP81Y/IMCMS8Fhss71HpeEnxHlNO6hhMFvmRZR941NI81TGYyI85IbRFOQUDn+Ny/GKo7sXBmyUpo7ZPUHtbS6tvFP13yYUS1QIkBI7PctP2bvsz49NmowORgEVo8xb8Pks88aT7FDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=driywclE; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=dHwP
	G00BTUv8cSd54+QV8//5YX0qC1i4W9Md9aXcV9U=; b=driywclEQxLl/GqNH1uW
	GJ7TvM3i8dsWAJ4S8qSKFQNMOSTXKvMZWPpIcT+j2Jb0vIQ60+opZ9pLfG+kwsN2
	DHoRIkcV3O1NAiHldrTu+Bx1Zaaj2wYMmPBIR3cvbpwsYVakcHTewAHevR+mlWYL
	wsM7lkwN3djuAMK1CB2iDwIcsVlB76NqhomwIJL3unpNm6brz+FRNiRRLUzWQv9r
	Yb4vncQbdhdMbkhExksEyoj+7lVuck1yK998UibwnbQ7qyO8JDv1Yiq5BYDVzXdm
	xLTdh7pF3JCeytjFpe5nNQw0x9YvrEX75/7xKx2vZmQ10uRr37sLP3eMLuQ41ucC
	Lw==
Received: (qmail 1229727 invoked from network); 9 Oct 2025 23:44:37 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Oct 2025 23:44:37 +0200
X-UD-Smtp-Session: l3s3148p1@LM0ktcBAxuYujnv2
Date: Thu, 9 Oct 2025 23:44:37 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: iio: accel: adxl345: document
 second interrupt
Message-ID: <aOgsxSfGIVBpfkpb@shikoro>
References: <20251006172119.2888-1-wsa+renesas@sang-engineering.com>
 <20251006172119.2888-2-wsa+renesas@sang-engineering.com>
 <20251009204726.GA3306624-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k/Jc1chrWQe4p7b2"
Content-Disposition: inline
In-Reply-To: <20251009204726.GA3306624-robh@kernel.org>


--k/Jc1chrWQe4p7b2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +    oneOf:
> > +      - items:
> > +          - enum: [INT1, INT2]
> > +      - items:
> > +          - const: INT1
> > +          - const: INT2
>=20
> This is better written as:
>=20
> minItems: 1
> items:
>   - enum: [INT1, INT2]
>   - const: INT2
>=20
> It is mainly better because using 'oneOf' results in poor error=20
> messages.

But wouldn't that allow naming both interrupts INT2? Or is this
magically prevented somehow?


--k/Jc1chrWQe4p7b2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjoLMEACgkQFA3kzBSg
KbbUJA//XY7SsUpc6CoZzRM/7+5L82ezaPqqbeS5bOO8OZLH3VGbrs0QX0Twg86u
HcxchMlLec4Yxf5Q9ehc163QRzELDCexvSpFgEMezxOnRzr+08XOWGMGiLnrLHED
m5OcwecwVxBvLaZSFVtxCePgkkShO6yISpNQWS50rUVmRWt58XU70Szu7qIgc59n
qh6wEQBUWa/VZAFR3qa+azjES/IoQQgzsJ97Cf8tINmvAO/s514zWkcxF/LdD4BE
FyQn18Y7YM2L3bNtZM3K3sXD+ORUFootJ5O7RErERB/5fPZjaELxkc6ZsPfJkPrx
rGCq3x//n1Eay034wGIv5MOHQeGYuE6cxaI2scioHEeIt3RYpi2l5aT50PdBEFOd
2C1d5GUtLECJf7viNQ2AD8YvAnAuqeJM4R6+fBXxvshbUGCzMNTleSyqSI2h4rSA
8YFDHGr4hIbFSEeIDFWM+Oz7TnpQ5qUYGtBZk59oltJdNJMVGmtdIF4DXSOE26Iu
wbIE78lkeE9rK4a3IQEjRr4oz2LJOhR4dTjxK8Fr9bXJCMHW1C6Oq58WGLICfec5
wumVHTc8HiyfY8hWG0TXsnopVrJA8JTLWGRrT/u03ygh872kfc3u28C/PbVVFmIb
Y4ugvTh+9ZC3ESt08VY9S7M22OYY8prEDUaWhB3v1H+npSducaQ=
=qV9o
-----END PGP SIGNATURE-----

--k/Jc1chrWQe4p7b2--

