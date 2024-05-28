Return-Path: <linux-iio+bounces-5410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9188D22CE
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 19:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4CD1F238A5
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 17:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3546945020;
	Tue, 28 May 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkEx+AVA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E248781;
	Tue, 28 May 2024 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918773; cv=none; b=Nzwyj9TemaaU+SLRRV4+IQ33qLDDYXX1FAieq4LXGMCE/q5+XE+zt+dPUkTa8bcs/elzrnsFTedGHXP1r1ZWU5F/mUgA4st8ZxBW/LCbNp2pUXVDuaXo47zfdBWpkcXNu7UPv6epBTOdxoDlg9lWVRnINEa++JTEqrxGRcsxYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918773; c=relaxed/simple;
	bh=rE9mbY6TdKIdAtMJSTiw3Um7FAbv+WUhCGvVtLNRmJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaB00NJBTKsRcoRPxf4Cw/6bjq9x8vU/d7qzPJZxpM3xLothtdr6KRl9bxC6LpXn5zn/6LkjSMBbXGy7rhQmLs5p/zWbyOEm5liOmIWlW8cI4n7hlWhUXdX4xOOTMGlh2p5+Q+9nMT3VGFEzmDQhOOvOEdrEm0Vm1uFNoTwZyno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkEx+AVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6982C3277B;
	Tue, 28 May 2024 17:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716918771;
	bh=rE9mbY6TdKIdAtMJSTiw3Um7FAbv+WUhCGvVtLNRmJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkEx+AVA0tx6eU9KTJgsl1xM6x2eYw+pwOlI1dLfm+jZu1tqDGPrC7/UcnkIrULGM
	 J1PM2vW6WbaSs1r9krqPJ6kZxVpYYBjp9T6OcXouGVItNBjvBMri5QXC1t1ITFX4aT
	 d3bnkW2Oui2rHgeEeX7GciAx0M1CXBEUfHfZj1W8b4mTi+ysPVLTrX3FSJhuzzLXKb
	 PT3fPcjyQE4g+zPZiLpskEyrgzvy5YWCSVnxEoRSYL00/dVdQF2B+Rsxa+0T8UKgGD
	 abd6ZCxEbuEw2589qp5O+J1q1yaTxiqCxQCUsjxjXiqby23Uyb98022RnmcalhmT2Y
	 MEuy/iv5X4CPA==
Date: Tue, 28 May 2024 18:52:46 +0100
From: Conor Dooley <conor@kernel.org>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: adc: ad7173: add support for ad411x
Message-ID: <20240528-filtrate-cloning-b9152322a3da@spud>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
 <20240527-ad4111-v3-1-7e9eddbbd3eb@analog.com>
 <20240527-arguably-said-361184ad848e@spud>
 <d87ae6ef-090d-4e47-bde4-4d08fd445ac1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JyMxpBvcw7wBYCtU"
Content-Disposition: inline
In-Reply-To: <d87ae6ef-090d-4e47-bde4-4d08fd445ac1@gmail.com>


--JyMxpBvcw7wBYCtU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 03:16:07PM +0300, Ceclan, Dumitru wrote:
> On 27/05/2024 20:48, Conor Dooley wrote:
> > On Mon, May 27, 2024 at 08:02:34PM +0300, Dumitru Ceclan via B4 Relay w=
rote:
> >> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >>
> >> Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.
> >>
> >> AD411x family ADCs support a VCOM pin, dedicated for single-ended usag=
e.
> >> AD4111/AD4112 support current channels, usage is implemented by
> >>  specifying channel reg values bigger than 15.
> >>
> >> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >> ---
> >>  .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 122 ++++++++++++=
++++++++-
> >>  1 file changed, 120 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml=
 b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> >> index ea6cfcd0aff4..5b1af382dad3 100644
> >> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> >> @@ -19,7 +19,18 @@ description: |
> >>    primarily for measurement of signals close to DC but also delivers
> >>    outstanding performance with input bandwidths out to ~10kHz.
> >> =20
> >> +  Analog Devices AD411x ADC's:
> >> +  The AD411X family encompasses a series of low power, low noise, 24-=
bit,
> >> +  sigma-delta analog-to-digital converters that offer a versatile ran=
ge of
> >> +  specifications. They integrate an analog front end suitable for pro=
cessing
> >> +  fully differential/single-ended and bipolar voltage inputs.
> >> +
> >>    Datasheets for supported chips:
> >> +    https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4111.pdf
> >> +    https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4112.pdf
> >> +    https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4114.pdf
> >> +    https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4115.pdf
> >> +    https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD4116.pdf
> >>      https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD7172-2.pdf
> >>      https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD7172-4.pdf
> >>      https://www.analog.com/media/en/technical-documentation/data-shee=
ts/AD7173-8.pdf
> >> @@ -31,6 +42,11 @@ description: |
> >>  properties:
> >>    compatible:
> >>      enum:
> >> +      - adi,ad4111
> >> +      - adi,ad4112
> >> +      - adi,ad4114
> >> +      - adi,ad4115
> >> +      - adi,ad4116
> >>        - adi,ad7172-2
> >>        - adi,ad7172-4
> >>        - adi,ad7173-8
> >> @@ -129,10 +145,36 @@ patternProperties:
> >>          maximum: 15
> >> =20
> >>        diff-channels:
> >> +        description: |
> >> +          For using current channels specify select the current inputs
> >> +           and enable the adi,current-channel property.
> >> +
> >> +          Family AD411x supports a dedicated VINCOM voltage input.
> >> +          To select it set the second channel to 16.
> >> +            (VIN2, VINCOM) -> diff-channels =3D <2 16>
> >> +
> >> +          There are special values that can be selected besides the v=
oltage
> >> +          analog inputs:
> >> +            21: REF+
> >> +            22: REF=E2=88=92
> >> +          Supported only by AD7172-2, AD7172-4, AD7175-2, AD7175-8, A=
D7177-2:
> >> +            19: ((AVDD1 =E2=88=92 AVSS)/5)+
> >> +            20: ((AVDD1 =E2=88=92 AVSS)/5)=E2=88=92
> >> +
> >>          items:
> >>            minimum: 0
> >>            maximum: 31
> >> =20
> >> +      single-channel:
> >> +        description: |
> >> +          Models AD4111 and AD4112 support single-ended current chann=
els.
> >> +          To select the desired current input, specify the desired in=
put pair:
> >> +            (IIN2+, IIN2=E2=88=92) -> single-channel =3D <2>
> >> +
> >> +        items:
> >> +          minimum: 1
> >> +          maximum: 16
> >> +
> >>        adi,reference-select:
> >>          description: |
> >>            Select the reference source to use when converting on
> >> @@ -154,9 +196,26 @@ patternProperties:
> >>            - avdd
> >>          default: refout-avss
> >> =20
> >> +      adi,current-channel:
> >> +        description: |
> >> +          Signal that the selected inputs are current channels.
> >> +          Only available on AD4111 and AD4112.
> >> +        type: boolean
> >> +
> >> +      adi,channel-type:
> >> +        description:
> >> +          Used to differentiate between different channel types as th=
e device
> >> +           register configurations are the same for all usage types.
> >> +          Both pseudo-differential and single-ended channels will use=
 the
> >> +           single-ended specifier.
> >> +        $ref: /schemas/types.yaml#/definitions/string
> >> +        enum:
> >> +          - single-ended
> >> +          - differential
> >> +        default: differential
> >=20
> > I dunno if my brain just ain't workin' right today, or if this is not
> > sufficiently explained, but why is this property needed? You've got
> > diff-channels and single-channels already, why can you not infer the
> > information you need from them? What should software do with this
> > information?
> > Additionally, "pseudo-differential" is not explained in this binding.
>=20
> In previous thread we arrived to the conclusion single-ended and
> pseudo-differential channels should be marked with the flag
> "differential=3Dfalse" in the IIO channel struct. This cannot
> really be inferred as any input pair could be used in that
> manner and the only difference would be in external wiring.
>=20
> Single-channels cannot be used to define such a channel as
> two voltage inputs need to be selected. Also, we are already
> using single-channel to define the current channels.

If I understand correctly, the property could be simplified to a flag
then, since it's only the pseudo differential mode that you cannot be
sure of?
You know when you're single-ended based on single-channel, so the
additional info you need is only in the pseudo-differential case.

> As for explaining the pseudo-differential, should it be explained?
> A voltage channel within the context of these families is actually
> differential(as there are always two inputs selected).
> The single-ended and pseudo-diff use case is actually wiring up a
> constant voltage to the selected negative input.
>=20
> I did not consider that this should be described, as there is no
> need for an attribute to describe it.

I dunno, adding an explanation of it in the text for the channel type
seems trivial to do. "Both pseudo-differential mode (where the
one of differential inputs is connected to a constant voltage) and
single-ended channels will..."

> > Also, what does "the device register configurations are the same for
> > all uses types" mean? The description here implies that you'd be reading
> > the registers to determine the configuration, but as far as I understand
> > it's the job of drivers to actually configure devices.
> > The only way I could interpret this that makes sense to me is that you'=
re
> > trying to say that the device doesn't have registers that allow you to
> > do runtime configuration detection - but that's the norm and I would not
> > call it out here.
>=20
> No, I meant that the same register configuration will be set for
> both fully differential and single-ended.=20
>=20
> The user will set diff-channels =3D <0, 1>, bipolar(or not) and
> then they can wire whatever to those pins:=20
> - a differential signal
> - AVSS to 1 and a single-ended signal to 0
> - AVSS+offset to 1 and a single-ended signal to 0
> 	(which is called pseudo-differential in some datasheets)
>=20
> All these cases will look the same in terms of configuration

In that case, I'd just remove this sentence from the description then.
How you configure the registers to use the device doesn't really have
anything to do with describing the configuration of the hardware.
Given it isn't related to configuration detection at runtime, what
you've got written here just makes it seem like the property is
redundant because the register settings do not change.

Instead, use the description to talk about when the property should be
used and what software should use it to determine, e.g. "Software can
use vendor,channel-type to determine whether or not the measured voltage
is absolute or relative". I pulled that outta my ass, it might not
be what you're actually doing, but I figure you just want to know if
you're measuring from the origin or either side of it.

Cheers,
Conor.

--JyMxpBvcw7wBYCtU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlYZ7gAKCRB4tDGHoIJi
0quAAP4oei1xG39MFKI4dDawI5n2Splt1d1pOAs3pqyqscvJaAEAvIsRtJ9fSVYT
hRBvb//KQJPRwRKOuAHlQCKo6Iu8AQk=
=p+d0
-----END PGP SIGNATURE-----

--JyMxpBvcw7wBYCtU--

