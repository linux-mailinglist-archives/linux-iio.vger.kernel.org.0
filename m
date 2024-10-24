Return-Path: <linux-iio+bounces-11151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC57E9AEC76
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 18:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A95283F4E
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 16:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5170A167296;
	Thu, 24 Oct 2024 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEDmulmg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B55BA4B;
	Thu, 24 Oct 2024 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788323; cv=none; b=RCYNzReOGJ9/j5t9oeFQmkebLpj8Q7udGc43NDokS0yId/uuj13Uwn//y4P091t5N5xWwiGl9Tq/tab30MbEC54wNxy4QRkpyReP4Paepm03zL+0IHqJ7IvM/S6kyaNPOunC/BRJvkW0RYSaW1hqDqi4bhdJUrWaV8VBtpT28xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788323; c=relaxed/simple;
	bh=F2N1fgTfqSSguvKp5AK/qiCyt3drO7Yl3moVpUeNv/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3S2HEnOA3laMGA+v+HmG+7Fll6vt03blILz5+jSvEgv1ahOGY83EkcmYGw5NkcE7rQCl50nDKkVYbO/dSaj4R+RvQaP+ai/0OWpnt8VbKtikZVdAJTMuV6YU1Fw/2YbykKomJlqmVxDZ8JIUz/6eIACLSbUgDIdOP+EtC3mmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEDmulmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D5FC4CEC7;
	Thu, 24 Oct 2024 16:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729788322;
	bh=F2N1fgTfqSSguvKp5AK/qiCyt3drO7Yl3moVpUeNv/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qEDmulmgELcr1FwDFri7SECKfCVKZYfMkU8wBlrJT3heAVuuUJ4NJ2bc7eVYamZji
	 q0hJmCPpHp+nQ/FLfnWC5IWurVcbUcIb1ACRj8PJAIhiscOkBJgudwS9IEwxi3tTLg
	 x9PnqAKCPjiEeblnP+nF7h8JqJFoGuJ5CgTWr1pJPeyRKq3HL1mfnEUJu3nEce0xDq
	 aFt/K4IakYqrkFbTD92w1G5UlWjy776wmIFNadKuI7gtgVwBbhfkQRULt5dhx5Vj61
	 KQ+Ln8DWyQxGXq0XazXn2jN9lrpR3HrX5fHKrgeEYA5k/M0wcTiE+XgfmrsGZus2Bh
	 rML0qwWxsr2Ag==
Date: Thu, 24 Oct 2024 17:45:17 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant
Message-ID: <20241024-broiler-energetic-243fff75aa5b@spud>
References: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
 <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-2-969694f53c5d@baylibre.com>
 <20241022-flagpole-subject-51e68e81e948@spud>
 <zfggfhasl3njyux5n44j2au4dlyjlngbtt4fps2xqzpngbwn42@72icpspkogtz>
 <6c2f188fc04ea957c842fe595951039244c43b7e.camel@gmail.com>
 <6162ea7d-40d6-4a21-96e5-7f851bc587dc@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t9hji7BwtIhalldR"
Content-Disposition: inline
In-Reply-To: <6162ea7d-40d6-4a21-96e5-7f851bc587dc@baylibre.com>


--t9hji7BwtIhalldR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 09:43:02AM -0500, David Lechner wrote:
> >>>
> >> thanks, could you maybe have a look if it's ok now ?
> >> (maxItems not needed for a const list)
> >>
> >> =A0 clocks:
> >> =A0=A0=A0 minItems: 1
> >> =A0=A0=A0 maxItems: 2
> >>
> >> =A0 clock-names:
> >> =A0=A0=A0 items:
> >> =A0=A0=A0=A0=A0 - const: s_axi_aclk
> >> =A0=A0=A0=A0=A0 - const: dac_clk
> >> =A0=A0=A0 minItems: 1
> >>
> >> =A0 '#io-backend-cells':
> >> =A0=A0=A0 const: 0
> >>
> >> required:
> >> =A0 - compatible
> >> =A0 - dmas
> >> =A0 - reg
> >> =A0 - clocks
> >>
> >> allOf:
> >> =A0 - if:
> >> =A0=A0=A0=A0=A0 properties:
> >> =A0=A0=A0=A0=A0=A0=A0 compatible:
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 contains:
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const: adi,axi-ad3552r
> >> =A0=A0=A0 then:
> >> =A0=A0=A0=A0=A0 $ref: /schemas/spi/spi-controller.yaml#
> >> =A0=A0=A0=A0=A0 properties:
> >> =A0=A0=A0=A0=A0=A0=A0 clocks:
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 minItems: 2
> >> =A0=A0=A0=A0=A0=A0=A0 clock-names:
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 minItems: 2
>=20
>=20
> For this one, I think we also need:
>=20
>          required:
>            - clock-names

Ye, Angelo had that in the version posted in response to the driver
patch.
This looks ~correct.

>=20
> >> =A0=A0=A0 else:
> >> =A0=A0=A0=A0=A0 properties:
> >> =A0=A0=A0=A0=A0=A0=A0 clocks:
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 maxItems: 1
> >> =A0=A0=A0=A0=A0=A0=A0 clock-names:
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 maxItems: 1
> >=20
> > I guess in this case it could even be clock-names: false. One does not =
make much
> > sense.

And since it is not mandatory, doubly useless.

--t9hji7BwtIhalldR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxp5nQAKCRB4tDGHoIJi
0tsJAQDjmQdku08Vcilxbr3ECLgwI46Cp1TydiA9bGCvurLhvQD7BWBqCK9SqYs6
iIpELbf7/6j98iJujKA9yhOgsUzTkQU=
=Wj36
-----END PGP SIGNATURE-----

--t9hji7BwtIhalldR--

