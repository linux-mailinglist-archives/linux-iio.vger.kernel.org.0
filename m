Return-Path: <linux-iio+bounces-23977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 169E7B52DB4
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 11:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5430C1C24C1D
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 09:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA9A2EAB72;
	Thu, 11 Sep 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="cEaYDl2n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980B4329F13;
	Thu, 11 Sep 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757584411; cv=none; b=Fh+IXQojT3Tu4a4VWUk7bIZWK27LZPIqvb3ZPtilSAqLHACAY65UgoqxUaMcE/dsrGdYm0i5fXUgWwhRLQr3rU/fUAB1PZ7WQM9HoOPsX2x4N+HVdL+nW2vn9NX8BXlEDTx9tihe0h2bsM7MkaXtX2nqZR6gNJ949WrUnRjkyPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757584411; c=relaxed/simple;
	bh=e8UEqQlddy9WhqEcv507M2baEDC0bJL/x14pz0r5Q30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rzg7kcsJbX7WrdTwkZ5dDbdWzBNgPoaeCreIvKPU2wnEP25K+kIMr+Sm1xLOoqClxJPhHkYyV+dEtVVNOfBLhVeXf2ate2j4cQIWAT/qJk3VikwPlKo8UN9r3dbSDLLaxmdWSvQGKZPIu3C9ocwSW2I8GWIy3vBMoaj28LewAt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=cEaYDl2n; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 0E00F173BE2;
	Thu, 11 Sep 2025 12:53:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757584399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7sE/F5cI9yfwjkLBljXJg6o4uP2E9VZw3ZP4xh7waDU=;
	b=cEaYDl2nh76qDkR+LycCGFXoU9UbPfslINVED+ZQs9ImJjkFv7zAVyrVty2Ud0MFD/Czdj
	FEBMtzFF3MQZWeok3Hpa1urMOVozeL/vBRTB7ENBMRbp4pNcMkwmiLHft2aiFbShJCYfKK
	EoVI5LQZMLxw726TgppQYlGuJ7gDM0Dje44LZjSypsn9Q9D6JUtbT/J7AFaUZUSsaAGAQK
	/vI5gxI7Z1gRiKmCce+ZplQr/Bjpn915DYr3BU9E2TCoT/3juyMAb2fZtQaPgQ9vpHorST
	kzXhQ2leuitG7WMLqkkYfLRwSK/LG5kZ9p9fgOSZmtm5NBFCDQhZy6F87ATl1A==
Date: Thu, 11 Sep 2025 12:53:16 +0300
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno S?? <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/14] dt-bindings: iio: accel: bosch,bma220 change
 irq type
Message-ID: <aMKcDJ4n7X4YeWgo@sunspire>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-3-e23f4f2b9745@subdimension.ro>
 <20250911-nostalgic-sturdy-markhor-57f87f@kuoka>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2cmfI1rv6oAUibTR"
Content-Disposition: inline
In-Reply-To: <20250911-nostalgic-sturdy-markhor-57f87f@kuoka>


--2cmfI1rv6oAUibTR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Krzysztof,

On Thu, Sep 11, 2025 at 09:33:25AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Sep 10, 2025 at 10:57:08AM +0300, Petre Rodan wrote:
> > Set the interrupt type to rising edge instead of high level.
> >=20
> > Quoting from the datasheet:
> >=20
> >  "If at least one of the configured conditions applies, an interrupt
> >  (logic ???1???) is issued through the INT pin of the sensor."
>=20
> I don't see how this explains/suggests raising edge.

well, I want my driver to react directly at the transition from lo to hi
(aka rising edge) of the INT signal.

why?
1. by default the latch register is disabled, thus the master (my driver) i=
s not
expected to ack or clear any interrupt flag. the sensor controls when the I=
NT line
deasserts. for instance during a tap interrupt the bottom half handles the =
rising
edge condition after 250-300us and the irq gets deasserted by the sensor 15=
0-300ms
later without any other interaction from the driver.

which means that the time interval the trigger is asserted for can not be
controlled by the master (without tweaking the latch register).

2. there is no scenario in which an irq trigger that has been asserted befo=
re probe()
needs to be handled.

3. there is zero reason to handle one event multiple times.

these would be my reasons for gravitating toward edge triggering.

best regards,
peter

--2cmfI1rv6oAUibTR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmjCnAwACgkQzyaZmYRO
fzCVNRAAmb7ecrz94S7Z36WmxRahEyaNxBdVHFuWFgatVkJUY6AyhP00nePzZqpv
2LFOfqEoMVAj4NWewxK+ls7WoNT50I/xRfIzPcxJrkSCfBq9uwcrLFApMymSILfM
Sr/NBf5/Z61Xzjerh3id63IBfuNXz8CyjbajlduCfjZoN00GQ5DXpKDh4i9rgWpc
AeZ0AEOeTyMTRgb9TRLnJSccgMTIf3Y2z29r7HQ+d2uwVzeOxkJqWG5H00+SgH6T
G5yOHJFhHSz6grlJC1tP1PYhITJtRTcxydly7D6SVAznpR4bTigT0wR9+c1MjbBf
FuIldPd6WyxTqUDeGPUSTYADWq57P0E5zDiXHO4NGnL86cW1+ullOGmTC394O+ft
y6Lqcuuh7OTw8ysFjwBJrLNGkiFwRHVloEBTuK7hd7G6m7x1DxyH18Fnec9J570n
aZPuNNEZy0U70Z7AsP1nJG45pvyp1EsPf/3tVQWCGbfzbjfA9bSthCbKTgv7iz3R
ridMpuEkQUug7JtQ72lLFpN9mbTbv+iWGg+u6NwkjlKQixSX2rl8W36hBmed2Ux8
0mQX/QtvnZAnGnZovxsrMnjt9qRLqwtbYC1YeE1pPsLwAVLtCF4XdjLCghnaKaFv
Pqh0OSUg3NKmBMP+eLBRAQq9ZdmRCPDWip2Q4C/DeL/dd7Ku4tU=
=SUUJ
-----END PGP SIGNATURE-----

--2cmfI1rv6oAUibTR--

