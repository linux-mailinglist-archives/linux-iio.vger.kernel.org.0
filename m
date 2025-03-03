Return-Path: <linux-iio+bounces-16391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A339FA4ECC9
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 20:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348458E5E7F
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 18:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319B7255244;
	Tue,  4 Mar 2025 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="V2VWHjdH"
X-Original-To: linux-iio@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A87027E1D5
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112872; cv=pass; b=OfNIQSa/WKiK6nZN8lAzMekbkFVPGQV5pzUruvukRhDdC18w2KSzvxKuwNrc53b1KeGcHO5AcJOOEXWDPEnpObpysDiDMye5tPdGgSA9AoZiy4JyZmtwaoKGu9pzzTXjBH9ZLLxOlh74opBc7uFm6UTXuNf6d2LlcosT0tpVRHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112872; c=relaxed/simple;
	bh=AMDQ9eFx0aMl37aNjAdud2rQll+8S9hW7w2yT459u9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dck3fRK1YLZQbGZF1YWNpUmgQ3yVhD57HJJIRLYuqgFj4SApTg6WahjZYTYnDPOscOHJ95fhziM+TSIUPbZXayy6w5UkrKs6AQaMUnHykutuWHJmSkmfE+1d1qi0iled4plUqfjP7978CTSnKdb2v53p3d4Z0+ok5GYzgPsFipc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=V2VWHjdH; arc=none smtp.client-ip=94.124.121.26; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id B0AE440D1F53
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 21:27:48 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=protonic.nl header.i=@protonic.nl header.a=rsa-sha256 header.s=202111 header.b=V2VWHjdH
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dN10PG3zFwTP
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 17:28:49 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id B2A4E400C6; Tue,  4 Mar 2025 17:28:34 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=V2VWHjdH
X-Envelope-From: <linux-kernel+bounces-541784-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=V2VWHjdH
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 15B8041AD7
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:20:07 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id BE722305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:20:06 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151D116E48C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A35213E92;
	Mon,  3 Mar 2025 13:18:48 +0000 (UTC)
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4F120F093
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007923; cv=none; b=fKuBsotT/r/oTKUFj/dRXPtxU+rpDz1sXecsgbthSSum4WnvtaweEnsiRiNBKsJ7MT4jTCi9LGYyxnKRLhoj3halOojX/8Qnk+hopDxobi+qd6rJeim4gsdbOxOP8Pkb/nQ1obZe0V200wcs+TTJB+6P5L1xEXI/imZXnNzY2GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007923; c=relaxed/simple;
	bh=AMDQ9eFx0aMl37aNjAdud2rQll+8S9hW7w2yT459u9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7ywlUY++JYkYwDOiJ6lnVZaFRwVQK5h6Mr/TGzRn0DBWxwKy3EBYMmQiYtcQBfyEgANCtFB/ZfJ7SQOJZ0mG6+WkiQ1C1BOiS7uMsOLYAWKIW/t+sfjbkOULDLcVxXSjWkFd+l4D85juZwALB3+IfKbDBCyNQLXKVRqqWczII4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=V2VWHjdH; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=07jHBQ0Ocr20eMkBHU7wCv3Kb+u8M2gSl1jHl4Krjyw=;
	b=V2VWHjdH50wFOAzqiqTCz4ucfQSAqCESzCrmKnlGDokUdrXyVCjY95wGlKxQEqab88IbyapJ8HitR
	 HhPCkTVbdTVmITlaPVwF3DF45rsjZ8KKS9QR1QgL9Z9ZJ5PpeqMyb4Z4Br1b1QGHaU9XuSjwQA5XjL
	 A9EK9KrVHqZcBBGpkCbhwHNy2zuIXnCvY+Yqh6IJUonUEaNniEQT+LOJaiv8qIBYHv/lxzT4aRN+2w
	 0Ycn1oeGVIj2B/QPxKjK8H50uESCFnozuiYgwKdA25We/6ZDtA7Zez1CmVi/IbJCfJ/OrJ8aJ40Ipn
	 ZWeXSYlWcX+QRqZW16a2zXBCEZZ+o4g==
X-MSG-ID: 04a26b70-f832-11ef-a39b-00505681446f
Date: Mon, 3 Mar 2025 14:18:37 +0100
From: David Jander <david@protonic.nl>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>
Subject: Re: [RFC PATCH 6/7] dt-bindings: motion: Add adi,tmc5240 bindings
Message-ID: <20250303141837.782e57f7@erd003.prtnl>
In-Reply-To: <CAMknhBFoRoaXWBL-vDnDrepqw_KJ-VrYeOoGJfjz8q=wDNM6xA@mail.gmail.com>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-7-david@protonic.nl>
	<7b2a8d71-9d83-4d40-903b-ba7ef1c686f3@baylibre.com>
	<20250303122253.26fec335@erd003.prtnl>
	<CAMknhBFoRoaXWBL-vDnDrepqw_KJ-VrYeOoGJfjz8q=wDNM6xA@mail.gmail.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dN10PG3zFwTP
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741717548.58334@qwSI24JsOiyiFnkKceixkg
X-ITU-MailScanner-SpamCheck: not spam


Dear David,

On Mon, 3 Mar 2025 13:28:35 +0100
David Lechner <dlechner@baylibre.com> wrote:

> (Sorry if you get this twice. I don't have my regular computer today
> and didn't realize I was sending HTML the first time. Resending in
> plain text so the lists pick it up.)
>=20
> On Mon, Mar 3, 2025 at 12:22=E2=80=AFPM David Jander <david@protonic.nl> =
wrote:
> >
> >
> > Dear David,
> >
> > On Fri, 28 Feb 2025 16:38:51 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> > =20
> > > On 2/27/25 10:28 AM, David Jander wrote: =20
> > > > Add device-tree bindings for Analog Devices TMC5240 stepper control=
lers.
> > > >
> > > > Signed-off-by: David Jander <david@protonic.nl>
> > > > ---
> > > >  .../bindings/motion/adi,tmc5240.yaml          | 60 +++++++++++++++=
++++
> > > >  1 file changed, 60 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/motion/adi,tm=
c5240.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/motion/adi,tmc5240.y=
aml b/Documentation/devicetree/bindings/motion/adi,tmc5240.yaml
> > > > new file mode 100644
> > > > index 000000000000..3364f9dfccb1
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/motion/adi,tmc5240.yaml
> > > > @@ -0,0 +1,60 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/motion/adi,tmc5240.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Analog Devices TMC5240 Stepper Motor controller
> > > > +
> > > > +maintainers:
> > > > +  - David Jander <david@protonic>
> > > > +
> > > > +description: |
> > > > +   Stepper motor controller with motion engine and SPI interface. =
=20
> > >
> > > Please include a link to the datasheet. =20
> >
> > Will do.
> > =20
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - adi,tmc5240
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1 =20
> > >
> > > I assume that this is the overvoltage output (OV pin). Would be nice =
to have
> > > a description here saying that. There are also NAO and DIAG0/1 output=
 pins, so
> > > it's a bit ambiguous otherwise. =20
> >
> > This is the DIAG0 output pin which on this chip has a dual function as =
either
> > a STEP output or an interrupt output. The pin name is a bit misleading,=
 but it
> > is the "interrupt" function that is meant here. The datasheet documents=
 all
> > the different events that can trigger this interrupt.
> > I will add a description to clarify this.
> > =20
>=20
> If it makes sense that other pins could possibly ever be connected to
> interrupts then we can add those and also add interrupt-names (but
> only if there is more than one possible interrupt).

AFAIK, only DIAG1 would potentially make sense to be connected to an
interrupt. It can be programmed to go low when the motor position matches t=
he
contents of the X_COMPARE/X_COMPARE_REPEAT register setting.

I will add that one if you agree. It will not be mandatory of course.

In any case, if that pin was connected to an interrupt pin right now, it co=
uld
already be used as an IIO trigger for example. Just not (yet) via this driv=
er.

>[...]
> > The resistor connected to the IREF pin (Rref) OTOH does have an implica=
tion to
> > the software, as it sets the full-range current of the output stage.
> >
> > How should we specify that? Is it adequate to add an optional DT proper=
ty
> > "rref" or "rref-ohm" with an int32 value in Ohm? The default value if
> > unspecified is 12000 Ohm. =20
>=20
> It looks like there are a few standardized properties, like
> sense-resistor-ohms if that fits the use case. Otherwise, an
> vendor-specific ti,rref-ohms would work. FYI, you can find the
> preferred units at [1].
>=20
> [1]: https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schem=
as/property-units.yaml

Ah, thanks! This is helpful.

Will use this for ti,rref-ohms. I guess in this case that would be easier to
understand than "sense-resistor-ohms", which is also okay, but would require
reading the description to know what exactly is meant in this context.

> > > And if there are any pins would make sense to connect to a gpio, we c=
an add
> > > those even if the driver doesn't use it currently.
> > > =20
> > > > +  clocks:
> > > > +    maxItems: 1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - interrupts
> > > > +  - clocks
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > > +  - $ref: /schemas/motion/common.yaml# =20
> > >
> > > If we need to know about what is connected to the output of a motor c=
ontroller
> > > I would expect it to be done with child node for each output. That wa=
y each
> > > output can be unique, if needed. Basically, similar to iio/adc.yaml i=
s used to
> > > provide common properties for channel@ child nodes on iio devices. =20
> >
> > This controller chip only has one single output for one stepper motor (4
> > wires). While technically you could connect something else to those 4 w=
ires, I
> > don't think it is the scope of LMC to support that. The chip itself isn=
't
> > designed for that purpose and it would clearly go far beyond the intend=
ed
> > purpose of this device.
> >
> > That being said, your suggestion of supporting child nodes may actually=
 be a
> > good idea. Right now, we specify the type of motor (basically nominal- =
and hold
> > current settings) in user-space and set the IRUN/IHOLD parameters from
> > user-space via the sysfs attributes interface. It might make sense to h=
ave a DT
> > child node to specify this, although in our current application this is=
 not
> > very practical, since there are many motor controllers on one board, an=
d it is
> > configurable in software (runtime) which motor is connected to which ou=
tput.
> >
> > But I can imagine a situation where it may be fixed and thus can be des=
cribed
> > in the DT of a board.
> >
> > Then again I don't know if it would be over-complicating things with so=
mething
> > like this:
> >
> >         motor-controller@0 {
> >                 ...
> >                 motor@0 {
> >                         compatible =3D "nanotec,st4118s1006";
> >                         irun-ma =3D <1800>;
> >                         ihold-ma =3D <270>;
> >                 };
> >         };
> >
> > where we'd possibly have a stepper-motors.c file with a lot of structs =
and
> > matching tables for the different motor types.... sounds like overkill =
to me,
> > but maybe not? =20
>=20
> A compatible for motors seems too much. I was just thinking along the
> lines that 1) if we need to so some scaling or something that depends
> on a motor constant, then it would make sense to put those constants
> in the DT and 2) if there is a motor controller with more than one
> output that could be connected to two or more different sizes of
> motors with different constants, then we either need child nodes or an
> array to be able to enter the different constants. Either one would
> work. So maybe simpler to just use an array instead of child nodes now
> that I'm thinking about it more.

Well, in the case of the TMC5240 there isn't much more than a single motor
with possibly some fixed setting of irun/ihold in some cases, but like I sa=
id,
in our case it is run-time configurable, so not something fixed to the
hardware-description. Apart from that, there are the speed- and acceleratio=
n-
conversion constants, which per default are the constants stated in the
datasheet. In some rare cases one might want to overrule them, but that can
already be done.

LMC does als support multi-channel controllers, and in that case I intend to
make use of child nodes for the different channels, to be able to specify
those parameters per motor.

So maybe just leave it as it currently is for the tmc5240?

> > > > +
> > > > +unevaluatedProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    spi {
> > > > +        #address-cells =3D <1>;
> > > > +        #size-cells =3D <0>;
> > > > +
> > > > +        motor@0 { =20
> > >
> > > motor-controller@ or actuator-controller@
> > >
> > > The chip is the controller/driver, it is not a motor. =20
> >
> > Make sense. Will change this.
> > =20
> > > > +            compatible =3D "adi,tmc5240";
> > > > +            reg =3D <0>;
> > > > +            interrupts-extended =3D <&gpiok 7 0>;
> > > > +            clocks =3D <&clock_tmc5240>;
> > > > +            enable-supply =3D <&stpsleepn>;
> > > > +            spi-max-frequency =3D <1000000>;
> > > > +        };
> > > > +    }; =20

Best regards,

--=20
David Jander


