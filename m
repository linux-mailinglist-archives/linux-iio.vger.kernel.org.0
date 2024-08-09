Return-Path: <linux-iio+bounces-8371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F147494D2F0
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 17:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BCB5B215F1
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 15:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BE3197A7A;
	Fri,  9 Aug 2024 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3NPNVJW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595B9155A25;
	Fri,  9 Aug 2024 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216152; cv=none; b=cyfYATh0uuYfxm2gu7Et4A4sD04z9PjxCa2QPHqPW0dYMZh5WW6B9uXg332NU701lJYlcZO8XQsgG9v+jgALlWaFiCbdSQdLKhvQ+KA7GNCVgKjGWHQpl7vhf7b790gvkaOD05t5IyBlPYv6zlXA1Ex2WjQWXDg/ncjQYal8gBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216152; c=relaxed/simple;
	bh=Zd2NZGppqJ5H2ZezF19+St/GBCUKROAZMrbD9l7nyRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDtJ5hkJXkZhoj5Eh3h1PCjLd0msdtzleXasVm2GinMyxzAH+iwj5aAF7vtCj1D9hhoXCAYGWSq4olkLIbfVal22wKtYehPjcQLpoIiO2gEh+Y0sFyFxtopW6YW+wZgNlj0x5nVkzuVqUofx/vNsLqb0vUtDKlLz8WBKQmAnw70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3NPNVJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D536C32782;
	Fri,  9 Aug 2024 15:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723216151;
	bh=Zd2NZGppqJ5H2ZezF19+St/GBCUKROAZMrbD9l7nyRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3NPNVJWFdVcMudjhf/waU1B2KmzMjAlWEeBdbYOuIlU/IDAYVpX/I8oF2xXcwu8W
	 hHZDD+BjfzQMwLNVuU8yNjAMoAl+3cY5/3F3kGn9ue75lFf8r7rPS4v40Gs3zyD/B0
	 s6QVqZw0CW6++/9eFq9SNm+EC9xcWNS8ogc0wUfaL3fJ/tvHPHVSaYlyEy+7Q86DEE
	 V9zmRyDVTWMvsqZmhhc8R2vU55Hhk5bWUXy8w3OgvLD142gOsmKh4gb+y4SHHTQbdv
	 uSkqjrk/IHtt7/BKtsvTIeMeCodeptt2DEtYKRDFnIhisv+i7gnlmzfzhDvQGpURGw
	 KJTtBqhZTqaZw==
Date: Fri, 9 Aug 2024 16:09:07 +0100
From: Conor Dooley <conor@kernel.org>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: adc: ad7173: add support for ad4113
Message-ID: <20240809-autograph-sugar-e79e54fd7a24@spud>
References: <20240809-ad4113-v2-0-2a70c101a1f4@analog.com>
 <20240809-ad4113-v2-1-2a70c101a1f4@analog.com>
 <20240809-glowing-discard-87263f656a7e@spud>
 <67eb7f5c-3f20-4831-a0cc-e407ac3f24ad@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mZH1m8C8+ubbaXbm"
Content-Disposition: inline
In-Reply-To: <67eb7f5c-3f20-4831-a0cc-e407ac3f24ad@gmail.com>


--mZH1m8C8+ubbaXbm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 05:32:08PM +0300, Ceclan, Dumitru wrote:
> On 09/08/2024 17:21, Conor Dooley wrote:
> > On Fri, Aug 09, 2024 at 01:33:24PM +0300, Dumitru Ceclan via B4 Relay w=
rote:
> >> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >>
> >> This commit adds bindings support for AD4113.
> >>
> >> The AD4113 is a low power, low noise, 16-bit, =CE=A3-=CE=94 analog-to-=
digital
> >> converter (ADC) that integrates an analog front end (AFE) for four
> >> fully differential or eight single-ended inputs.
> >>
> >> Added ad4113 to the compatible list and the "avdd2-supply: false"
> >> restriction.
> >>
> >> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >> ---
> >>  Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml=
 b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> >> index 17c5d39cc2c1..ad15cf9bc2ff 100644
> >> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> >> @@ -28,6 +28,7 @@ description: |
> >>    Datasheets for supported chips:
> >>      https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4111.pdf
> >>      https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4112.pdf
> >> +    <AD4113: not released yet>
> >=20
> > Am I meant to ack it with this placeholder? When will the document be
> > released?
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> Not really sure tbh, up to you. The document will be released in the upco=
ming months.
>=20
> If it's considered best to wait until the docs are public and send another
> version with the correct link.=20
> If not, and maintainers consider that these changes can be accepted even
> without viewing the datasheet, I'll send a patch when it goes public.

I don't really care, it's just to Jonathan I think. I'm happy enough
with you adding it when it is released.

--mZH1m8C8+ubbaXbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrYxEwAKCRB4tDGHoIJi
0n/qAP46DdaGcNK4r+njbC8daaCXJoPLBI99yaM2E3AykeSMawEA4nNzddIASR+c
oCMX3Zn4oRUKQWEVbeAuGqK3vcfpiAc=
=crai
-----END PGP SIGNATURE-----

--mZH1m8C8+ubbaXbm--

