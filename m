Return-Path: <linux-iio+bounces-5318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B364E8CF4C7
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 17:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71D61C206A7
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2EB179BC;
	Sun, 26 May 2024 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYox2exv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D377C171CC;
	Sun, 26 May 2024 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716738345; cv=none; b=XY0/upiNmVoUzKssytanbSttCX9677r6xkKLSsUbNraUMWchZJOag+8bW5DObXG8bWh6UQZlIn4G2kS+FC/n3zBYOxPaBYtXo/jJJDenWhm18/LSKWSf0c65fpmEGbSNCYU1hdTGP5kJUGPfm5jryi7yxqRlLrX66CtJfQcwCSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716738345; c=relaxed/simple;
	bh=9yFVJ82e242IH9QBdMocDHZK6zErfeb2QrxlJvc4+fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAp8Fw7Q8XyVadBNBlKMdD6cw+zE8O2aPEDzeFRfJhHgqXa/iJV98YmMpOuNBzaPgCOS2D1+Flf1NV6xYUDpD/+AZE8eAD/6sOAFvZwqK+ipESzSSr9YewT1ClkWUC0fMu7oLpd35WG7nNV1hM3pPNIXuBnM5Pi8Jzi26HaP5Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYox2exv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6696AC2BD10;
	Sun, 26 May 2024 15:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716738344;
	bh=9yFVJ82e242IH9QBdMocDHZK6zErfeb2QrxlJvc4+fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYox2exv3GKpYl83K76KDfOGC8GHvq3APF42q1kgLtN3G/T44a421CX0gDjGUips0
	 rV2hSgV+OEsMga852Z0C5/wVVAXjgU1jhSsTzfFO6lLFQY7iKKOmi3UDWqV3waLIWa
	 lsufu6wB2Q2GkMIIGxN2UkB108IuIFgl0nlXvwYtck86oWZgi5P3I6xnSJWa1kqx4y
	 OEvqSurzWj8PiNopZXafNvI6qz/aHsS0svXPqNbC1LJyd9ZuPjSGFG02N/8uhLns1O
	 Vwamw9aduhCTyWmIE2+1oYuxTtBehNMRDjIKppM3TQ3SHY/rdc8OaKmuRs+9d6WBiK
	 mU+2MG13ZRgzQ==
Date: Sun, 26 May 2024 16:45:39 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
Message-ID: <20240526-stylized-preaching-d0b15a95fe19@spud>
References: <20240513-headsman-hacking-d51fcc811695@spud>
 <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
 <20240514-aspire-ascension-449556da3615@spud>
 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
 <20240516-rudder-reburial-dcf300504c0a@spud>
 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
 <59df2cc3-5a62-45be-a0aa-5bbff13c2ae4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QI9Azi51wmSyyaZK"
Content-Disposition: inline
In-Reply-To: <59df2cc3-5a62-45be-a0aa-5bbff13c2ae4@baylibre.com>


--QI9Azi51wmSyyaZK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 09:28:54AM -0500, David Lechner wrote:
> On 5/22/24 1:24 PM, Conor Dooley wrote:
> > On Tue, May 21, 2024 at 09:54:39AM -0500, David Lechner wrote:
> >> On Sun, May 19, 2024 at 7:53=E2=80=AFAM Conor Dooley <conor@kernel.org=
> wrote:
> >>>
> >>> On Fri, May 17, 2024 at 11:51:58AM -0500, David Lechner wrote:
> >>>> On Thu, May 16, 2024 at 4:32=E2=80=AFPM Conor Dooley <conor@kernel.o=
rg> wrote:
> >>>>> On Tue, May 14, 2024 at 05:56:47PM -0500, David Lechner wrote:
> >>>
>=20
> ...
>=20
> >> This time, the periodic trigger (PWM) is connected to the pin on the
> >> ADC that triggers a sample conversion (CNV). The ADC has a BUSY output
> >> that will go high at the start of the conversion and go low at the end
> >> of the conversion. The BUSY output of the ADC is wired as the hardware
> >> trigger input of the offload.
> >>
> >> In this case would we still consider the PWM as part of the SPI
> >> controller/offload since it can only be used in conjunction with the
> >> SPI offload? It isn't connected to it at all though.
> >=20
> > No, in this case the ADC is a PWM consumer and the offload engine is
> > not. The ADC is a "trigger" provider and the SPI offload engine is a
> > trigger consumer.
>=20
> Makes sense.
>=20
> ...
>=20
>=20
> >=20
> >>> In fact, looking at the documentation for the "spi engine" some more,=
 I
> >>> am even less convinced that the right place for describing the offloa=
d is
> >>> the peripheral as I (finally?) noticed that the registers for the off=
load
> >>> engine are mapped directly into the "spi engine"'s memory map, rather=
 than
> >>> it being a entirely separate IP in the FPGA fabric.
> >>
> >> True, but we don't use these registers, e.g., to configure the
> >> sampling frequency of a trigger (if it can even be done). That is done
> >> in a completely separate IP block with it's own registers.
> >=20
> > Where is the binding for that IP block? I think describing that is
> > pretty key. goto continuation;
>=20
> For the real-world case I used to test this series, it is an AXI PWMGEN
> [1] that is providing the trigger event source. It has a typical PWM
> provider binding with #pwm-cells [2].
>=20
> Calling this a "trigger" provider to the SPI offload instance just like t=
he
> case above where the ADC is directly connected as the offload trigger mak=
es
> sense to me.
>=20
> What I was going for in this patch (slightly revised to use #cells) is th=
at
> this trigger provider, whatever it is, is selected by one of the cells of
> #spi-offload-cells. It doesn't seem like there should be a special case f=
or
> if the trigger provider is a clock or PWM where the SPI controller node
> becomes a consumer of the clock or PWM provider rather than just describi=
ng
> the trigger relationship.
>=20
> For example, supposing we had an FPGA/HDL that could handle all 3 wiring
> configurations we have discussed so far. A) PWM connected directly to SPI
> offload as trigger, B) PWM connected to CNV of ADC and BSY of ADC connect=
ed
> to SPI offload as trigger, C) self clocked ADC with RDY of ADC connected
> to SPI offload as trigger. So the DT would have:
>=20
> controller:
> #spi-offload-cells =3D <2>: /* 1st cell =3D offload instance
>                            * 2nd cell =3D trigger provider */
>=20
> peripheral (choose one based on actual wiring):
> spi-offloads =3D <0 0>; /* case A */
> spi-offloads =3D <0 1>; /* case B */
> spi-offloads =3D <0 2>; /* case C */
>=20
>=20
> As to what is the actual consumer of the PWM provider in each of these
> cases...
>=20
> * C is easy. There isn't a PWM provider since the ADC is self-clocked.
> * B, as discussed elsewhere is fairly straight forward. The ADC node is
>   the consumer since the PWM is connected directly to the ADC.
> * A is the one we need to figure out. I'm proposing that the PWM consumer
>   should be whatever kind of composite device node we come up with that
>   also solves the issue described below about where does the CRC checker
>   (or whatever) go. I think we are in agreement here at least on the point
>   that it doesn't belong in the SPI controller node?

To be clear, you're saying that we agree that the CRC checker doesnt
belong in the SPI controller node, right?

--QI9Azi51wmSyyaZK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlNZIwAKCRB4tDGHoIJi
0rcJAP4wlXLinDBuLMMunDenDCKzMAGTqwXYWCzQ/j3lCyGyoQD/VtLRpzJv9NSw
f18ipYHVyeIm4uS0jnHQHIEOmj5gjAo=
=AKAC
-----END PGP SIGNATURE-----

--QI9Azi51wmSyyaZK--

