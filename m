Return-Path: <linux-iio+bounces-5514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CE48D51E9
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 20:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263DB281854
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 18:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F337D4DA11;
	Thu, 30 May 2024 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXj9ORn3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3524C3C3;
	Thu, 30 May 2024 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717094579; cv=none; b=b8lCNxt8JCebYQ9yEBaX62qSssFHIkkSFrKmf7c/6jK77RcrqQxK6q2wDPJAKR5G8ZF0HoTLbRl00B5sXMkaVCEMdU4QoBaJmy1EZwqx8UheLbKTQK7gzjDfCPW+dii0k/j0eeTnKFwA212bUcuaK/IvNai2VfHQlUCT7Y5svHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717094579; c=relaxed/simple;
	bh=xZzKpfi6oNrG++hVHlFq0OVifdz6osfncqrryun6xrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tePQwaPPavw1UVCoEP6FMmt0YwnluWMxHV5XHbvyl5KEFlWFopK2PavoD7gS5bFfTgAtjVIrmy46IZvKgW/CwYgJTy2Vr92gS7aXzm8yMkYA1nVk6mqPuDG9V3hNs3lL5tTUBIKR9oCV0WDkzbSJbXBp4qyt7STzWDbZG8RyOH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXj9ORn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7C8C2BBFC;
	Thu, 30 May 2024 18:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717094579;
	bh=xZzKpfi6oNrG++hVHlFq0OVifdz6osfncqrryun6xrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WXj9ORn3MMUWcHB8anUoEMWZV6AGmTa+NTnHh3zKw/XoWiK1ihjPeRpbJRCnGM/Ua
	 I8S/L0peNaJovhmRw+vbUs3RpTRe6M9Rvxme8DRBSn+WeulF0cWkdkZgWHhNopfFDW
	 b6OqLLh0RbQL0mkcghiHpGhE+SlVq+pVg4ZX+2ucZ+xGubJxwcYlphtN3CTq2NLkDz
	 1ZSzPmoeFLGkGYeynUe9t5mqtbrZgYYLDRUykvK1yB9mE8JRRKbpydKSF+sXVHlyff
	 eool+EB+LOOnCJ8cEEeWhMIKuIerf6FdiokBWWZotJ3aamPZVYbFpl8kozWy1DPMMW
	 SvHoaRiSQpCCQ==
Date: Thu, 30 May 2024 19:42:54 +0100
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
Message-ID: <20240530-coronary-crumb-f047bd2f41c3@spud>
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
	protocol="application/pgp-signature"; boundary="HplkXR1b2QRr3bCu"
Content-Disposition: inline
In-Reply-To: <59df2cc3-5a62-45be-a0aa-5bbff13c2ae4@baylibre.com>


--HplkXR1b2QRr3bCu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 09:28:54AM -0500, David Lechner wrote:
> On 5/22/24 1:24 PM, Conor Dooley wrote:
> > On Tue, May 21, 2024 at 09:54:39AM -0500, David Lechner wrote:
> >> On Sun, May 19, 2024 at 7:53=E2=80=AFAM Conor Dooley <conor@kernel.org=
> wrote:

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

I think C and B are correct here. The term "composite device" scares me,
but yeah the PWM gets connected to the device that encompasses the
offload engine. In case B and C, the trigger signals are connected to
the offload engine - what property are we using to describe that?
If this were not a "passive" process and the OS was actually involved
in kicking off an action when the ADC asserted the !BSY signal,
interrupts would make sense, but I'm not sure here.

Maybe interrupts is the right thing to do, because that would also make
sense in the case that we used the busy signal without an offload and
plumbed it into a regular interrupt controller?

gpio0: gpio@20120000 {
	compatible =3D "microchip,mpfs-gpio";
	reg =3D <0x0 0x20120000 0x0 0x1000>;
	interrupt-parent =3D <&plic>;
	interrupt-controller;
	#interrupt-cells =3D <1>;
	clocks =3D <&clkcfg CLK_GPIO0>;
	gpio-controller;
	#gpio-cells =3D <2>;
};

adc {
	interrupt-parent =3D <&gpio0>;
	interrupts =3D <0 HIGH>;
};

I suppose then the offload needs to be an interrupt provider too, even
if no irqchip is ever actually created for it. I dunno how tf that's
gonna work out on the software side though? If you have spi-offloads you
interpret the interrupts property differently (IOW you ignore it)?

Or were you thinking of not really hooking that up at all, but instead
just saying checking for whatever x is in spi-offloads =3D <0 x> and
defining 2 to mean "active low" and 1 to mean "active high" etc?

Once again, had to take a break to make food in the middle of responding
here, so I hope I didn't write something incomprehensible.

Thanks,
Conor.

>=20
> [1]: http://analogdevicesinc.github.io/hdl/library/axi_pwm_gen/index.html
> [2]: https://lore.kernel.org/linux-pwm/20240424125850.4189116-2-tgamblin@=
baylibre.com/


--HplkXR1b2QRr3bCu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZljIrQAKCRB4tDGHoIJi
0hDiAP9dx+nbZooLjZgVCCQk65jhh8sRMO+cZFoSKL/XJFXywwD9EtGVJp4epZ0K
USFouvgZHuPZgj39rpyWPq5zkAKv2wQ=
=qW+K
-----END PGP SIGNATURE-----

--HplkXR1b2QRr3bCu--

