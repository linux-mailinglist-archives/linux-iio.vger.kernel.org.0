Return-Path: <linux-iio+bounces-507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779A07FF400
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 16:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE9428197C
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 15:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863EC53808;
	Thu, 30 Nov 2023 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWTJmj6g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7F2208A;
	Thu, 30 Nov 2023 15:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE8DC433C8;
	Thu, 30 Nov 2023 15:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701359612;
	bh=HrIeUu7V7smPbz53czTMhVOKIhnJX6FObsHMqEgNuww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWTJmj6guoUZxaxt6RIJl4h1DsBIWv/7g3q4qKBMb15RXr7Fs2wvfEKnOK6rG16nX
	 45OdwoH02duq0uGWs4bJbWEbkn8b8uzmW2JBSlzD6PR7V0Aa0o4BcJfbzkNI78j/FT
	 cdfn/nZ2ARojwYf1WZp4ntPp3BEbjki/RMmFrqLL4em0VcmrE5P+5nvoFZpJr96uay
	 oVrbrQ5PqGT8qFz1JX+VGFNsgks2ojGh9/pZC+cnKGaostTf9zZS5xpMK33ptqx4Vr
	 8Ky45g5pqU2uS6pd5Zjx7EZbgwXCQhdNxJs/77t8TVniEHmU2Bfk0J4hlErV5Ap1sg
	 SugTdBq1JUJ4g==
Date: Thu, 30 Nov 2023 15:53:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	marius.cristea@microchip.com, lars@metafoo.de, robh+dt@kernel.org,
	jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: adding support for PAC193X
Message-ID: <20231130-obedient-pointer-6b4470a85c63@spud>
References: <20231115134453.6656-1-marius.cristea@microchip.com>
 <20231115134453.6656-2-marius.cristea@microchip.com>
 <fedd4bcf-7892-4096-bcca-7ea72d39576f@linaro.org>
 <20231116-channel-variety-cc7c262924ad@squawk>
 <20231125194754.304523e6@jic23-huawei>
 <20231126-nineteen-clumsy-701ac4145ba8@spud>
 <20231126160438.01ff57d7@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oP7sV86AVSwt1W+s"
Content-Disposition: inline
In-Reply-To: <20231126160438.01ff57d7@jic23-huawei>


--oP7sV86AVSwt1W+s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 04:04:38PM +0000, Jonathan Cameron wrote:
> On Sun, 26 Nov 2023 11:24:56 +0000
> Conor Dooley <conor@kernel.org> wrote:
> > On Sat, Nov 25, 2023 at 07:47:54PM +0000, Jonathan Cameron wrote:
> > > On Thu, 16 Nov 2023 18:21:33 +0000
> > > Conor Dooley <conor@kernel.org> wrote: =20
> > > > On Thu, Nov 16, 2023 at 04:01:43PM +0100, Krzysztof Kozlowski wrote=
: =20
> > > > > On 15/11/2023 14:44, marius.cristea@microchip.com wrote:   =20
> > > > > > From: Marius Cristea <marius.cristea@microchip.com> =20
> > > > > > +patternProperties:
> > > > > > +  "^channel@[1-4]+$":
> > > > > > +    type: object
> > > > > > +    $ref: adc.yaml
> > > > > > +    description: Represents the external channels which are co=
nnected to the ADC.
> > > > > > +
> > > > > > +    properties:
> > > > > > +      reg:
> > > > > > +        items:
> > > > > > +          minimum: 1
> > > > > > +          maximum: 4
> > > > > > +
> > > > > > +      shunt-resistor-micro-ohms:
> > > > > > +        description: |
> > > > > > +          Value in micro Ohms of the shunt resistor connected =
between
> > > > > > +          the SENSE+ and SENSE- inputs, across which the curre=
nt is measured. Value
> > > > > > +          is needed to compute the scaling of the measured cur=
rent.
> > > > > > +
> > > > > > +    required:
> > > > > > +      - reg
> > > > > > +      - shunt-resistor-micro-ohms
> > > > > > +
> > > > > > +    unevaluatedProperties: false
> > > > > > +
> > > > > > +required:
> > > > > > +  - compatible
> > > > > > +  - reg
> > > > > > +  - "#address-cells"
> > > > > > +  - "#size-cells"
> > > > > > +
> > > > > > +allOf:
> > > > > > +  - if:
> > > > > > +      properties:
> > > > > > +        compatible:
> > > > > > +          contains:
> > > > > > +            const: interrupts   =20
> > > > >=20
> > > > >=20
> > > > > I don't understand what do you want to say here. I am also 100% s=
ure you
> > > > > did not test it on a real case (maybe example passes but nothing =
more).   =20
> > > >=20
> > > > As far as I understand, the same pin on the device is used for both=
 an
> > > > output or an input depending on the configuration. As an input, it =
is
> > > > the "slow-io" control, and as an output it is an interrupt.
> > > > I think Marius is trying to convey that either this pin can be in
> > > > exclusively one state or another.
> > > >=20
> > > > _However_ I am not sure that that is really the right thing to do -=
 they
> > > > might well be mutually exclusive modes, but I think the decision ca=
n be
> > > > made at runtime, rather than at devicetree creation time. Say for
> > > > example the GPIO controller this is connected to is capable of acti=
ng as
> > > > an interrupt controller. Unless I am misunderstanding the runtime
> > > > configurability of this hardware, I think it is possible to actually
> > > > provide a "slow-io-gpios" and an interrupt property & let the opera=
ting
> > > > system decide at runtime which mode it wants to work in. =20
> > >=20
> > > I'll admit I've long forgotten what was going on here, but based just=
 on
> > > this bit of text I agree. There is nothing 'stopping' us having a pin
> > > uses as either / or / both interrupt and gpio.
> > >=20
> > > It'll be a bit messy to support in the driver as IIRC there are some =
sanity
> > > checks that limit combinations on IRQs and output GPIOS.  Can't remem=
ber
> > > how bad the dance to navigate it safely is.
> > >=20
> > > First version I'd just say pick one option if both are provided and
> > > don't support configuring it at runtime. =20
> >=20
> > Just to be clear, you are suggesting having the
> > "microchip,slow-io-gpios" and "interrupts" properties in the binding,
> > but the driver will just (for example) put that pin into alert mode
> > always & leave it there?
>=20
> Yes.
>=20
> > If that is what you are suggesting, that seems pragmatic to me.
>=20
> If a use case to do something else comes along later, then we can
> be smarter, but I'd like to keep it simple initially at least.

Sounds good to me, thanks Jonathan. Seems like a good compromise of
depicting the hardware accurately and not overcomplicating the driver
implementation.

Marius, I completely forgot to get in touch with you about this - give
me a shout on teams if there's anything outstanding that I can help you
with.

--oP7sV86AVSwt1W+s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWiv9wAKCRB4tDGHoIJi
0uHzAPwLRSFe3lyznjBdX2nugpHz1wH9XkPMsIfMCDZMgNeUhQD/QIvnrIRYkwXk
T9Reuc+W3+2ww8eTAHVikTkLYDMDvQ8=
=fi+Q
-----END PGP SIGNATURE-----

--oP7sV86AVSwt1W+s--

