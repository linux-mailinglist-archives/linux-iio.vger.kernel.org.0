Return-Path: <linux-iio+bounces-8514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA180954E85
	for <lists+linux-iio@lfdr.de>; Fri, 16 Aug 2024 18:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6627D1F22F8F
	for <lists+linux-iio@lfdr.de>; Fri, 16 Aug 2024 16:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC091BF33E;
	Fri, 16 Aug 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAE5VwL7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183491BF32D;
	Fri, 16 Aug 2024 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723824696; cv=none; b=gFIBM+fIHNrzETn1x6dKNFhkBeUkiRvsuwF3trYzTHsZauKQBCy9Lwunl16h2RvSfnKH3SMMfgBUidC96g4riN7r3S5HnOomuCBGfEs+EFF6kUU/a6/xZ8unW2cENkM5mAhtKBOMtJu4bcraFcb9DTOurRn9aU/QTGGPl1t1SC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723824696; c=relaxed/simple;
	bh=15M3c2agbGhzm6bHjBcm8kKDdhK7N9qdA5tyXE/Q6zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMqtGlw1wqwFFdgXBTqfiAnyayM+gWOuNXhXdoiX2CvWFUhX796TAE38ou6PpWZeYxy35v+QOvBgPyu8qo5SVzommqzchLG5FDEHMumcNP7CiSz54/4uxh8JPWolhgBJe6vOkU9f27wUt/taV/eHMDHZqhUhUYK0B23hRalH7og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAE5VwL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E276C32782;
	Fri, 16 Aug 2024 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723824695;
	bh=15M3c2agbGhzm6bHjBcm8kKDdhK7N9qdA5tyXE/Q6zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DAE5VwL7RymuhHO/xhBSjJXkYl3y8KQ3hDCOpOCSYFcZZmP8EA2ANbXv/B/PdOCl8
	 JvgMWINABapYMcSJOH7pBKBAjCKJ/gRN5yRc3hwBNPh31IxM45XfdVL/As0AXsHqWi
	 kWeaq2pjbtZ2IVtFKmNfE7tXxGvPTeRMwMwaVt6vySbis3ZaH7ht4mbjI3vsFSf6/I
	 DEi9gU24zkUNMoD0B+pAj5o11RO9CD7sBtun96OSju68kjdo6CIcEgpw38dDQDUnLb
	 R4l04LsznHY4XhC/t6YYmi1juQaFQmh97UtsRJoe6IH2A108kCEaqZzUbGY1i/JWZo
	 a6vRFq2BPpwzg==
Date: Fri, 16 Aug 2024 17:11:31 +0100
From: Conor Dooley <conor@kernel.org>
To: "Li, Hua Qian" <HuaQian.Li@siemens.com>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>,
	"Zeng, Chao" <chao.zeng@siemens.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"Su, Bao Cheng" <baocheng.su@siemens.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: iio: Add everlight pm16d17 binding
Message-ID: <20240816-absolute-wireless-87bc3975cef5@spud>
References: <cover.1723527641.git.jan.kiszka@siemens.com>
 <f6476e06cd8d1cf3aff6563530612c536cd45716.1723527641.git.jan.kiszka@siemens.com>
 <20240813-captivity-spellbind-d36ca0f31e22@spud>
 <a458a2cbc96a23c0a2ef89327e1f8bcd2e2777e6.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sPwfgDXrIWGtLfNj"
Content-Disposition: inline
In-Reply-To: <a458a2cbc96a23c0a2ef89327e1f8bcd2e2777e6.camel@siemens.com>


--sPwfgDXrIWGtLfNj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 01:48:36AM +0000, Li, Hua Qian wrote:
> On Tue, 2024-08-13 at 16:52 +0100, Conor Dooley wrote:
> > On Tue, Aug 13, 2024 at 07:40:41AM +0200, Jan Kiszka wrote:
> > > From: Chao Zeng <chao.zeng@siemens.com>
> > >=20
> > > Add the binding document for the everlight pm16d17 sensor.
> > >=20
> > > Signed-off-by: Chao Zeng <chao.zeng@siemens.com>
> > > Co-developed-by: Baocheng Su <baocheng.su@siemens.com>
> > > Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
> >=20
> > Ditto here Jan.
> >=20
> > > ---
> > > =A0.../iio/proximity/everlight,pm16d17.yaml=A0=A0=A0=A0=A0 | 95
> > > +++++++++++++++++++
> > > =A01 file changed, 95 insertions(+)
> > > =A0create mode 100644
> > > Documentation/devicetree/bindings/iio/proximity/everlight,pm16d17.y
> > > aml
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/iio/proximity/everlight,pm16d17
> > > .yaml
> > > b/Documentation/devicetree/bindings/iio/proximity/everlight,pm16d17
> > > .yaml
> > > new file mode 100644
> > > index 000000000000..fadc3075181a
> > > --- /dev/null
> > > +++
> > > b/Documentation/devicetree/bindings/iio/proximity/everlight,pm16d17
> > > .yaml
> > > @@ -0,0 +1,95 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id:
> > > http://devicetree.org/schemas/iio/proximity/everlight,pm16d17.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Everlight PM-16D17 Ambient Light & Proximity Sensor
> > > +
> > > +maintainers:
> > > +=A0 - Chao Zeng <chao.zeng@siemens.com>
> > > +
> > > +description: |
> > > +=A0 This sensor uses standard I2C interface. Interrupt function is
> > > not covered.
> >=20
> > Bindings should be complete, even if software doesn't use the
> > interrupts. Can you document them please.
> >=20
> > > +=A0 Datasheet:
> > > https://en.everlight.com/sensor/category-proximity_sensor/digital_pro=
ximity_sensor/
> >=20
> > Do you have a link to a datasheet? The link to the pm16d17 here 404s
> > for
> > me.
> >=20
> > > +
> > > +properties:
> > > +=A0 compatible:
> > > +=A0=A0=A0 enum:
> > > +=A0=A0=A0=A0=A0 - everlight,pm16d17
> > > +
> > > +=A0 reg:
> > > +=A0=A0=A0 maxItems: 1
> > > +
> > > +=A0 ps-gain:
> > > +=A0=A0=A0 description: Receiver gain of proximity sensor
> > > +=A0=A0=A0 $ref: /schemas/types.yaml#/definitions/uint32
> > > +=A0=A0=A0 enum: [1, 2, 4, 8]
> > > +=A0=A0=A0 default: 1
> > > +
> > > +=A0 ps-itime:
> >=20
> > How did you get itime from conversion time? To the layman (like me!)
> > conversion-time would make more sense...
> >=20
> > Also, "ps"? The whole thing is a proxy sensor, so why have that
> > prefix
> > on properties. What is missing however is a vendor prefix.
> >=20
> > > +=A0=A0=A0 description: Conversion time for proximity sensor [ms]
> > > +=A0=A0=A0 $ref: /schemas/types.yaml#/definitions/string
> >=20
> > Instead of a string, please use the -us suffix, and put this in
> > microseconds instead.
> >=20
> > In total, that would be s/ps-itime/everlight,conversion-time-us/.
> >=20
> > I would, however, like to know why this is a property of the
> > hardware.
> > What factors do you have to consider when determining what value to
> > put
> > in here?
> >=20
> > > +=A0=A0=A0 enum:
> > > +=A0=A0=A0=A0=A0 - "0.4"
> > > +=A0=A0=A0=A0=A0 - "0.8"
> > > +=A0=A0=A0=A0=A0 - "1.6"
> > > +=A0=A0=A0=A0=A0 - "3.2"
> > > +=A0=A0=A0=A0=A0 - "6.3"
> > > +=A0=A0=A0=A0=A0 - "12.6"
> > > +=A0=A0=A0=A0=A0 - "25.2"
> > > +=A0=A0=A0 default: "0.4"
> > > +
> > > +=A0 ps-wtime:
> > > +=A0=A0=A0 description: Waiting time for proximity sensor [ms]
> > > +=A0=A0=A0 $ref: /schemas/types.yaml#/definitions/string
> >=20
> > All of the same comments apply here. E.g. why "wtime" isntead of
> > "waiting-time" and so on.
> > I would really like to know why these things are properties of the
> > hardware, rather than something that software should control.
> >=20
> > > +=A0=A0=A0 enum:
> > > +=A0=A0=A0=A0=A0 - "12.5"
> > > +=A0=A0=A0=A0=A0 - "25"
> > > +=A0=A0=A0=A0=A0 - "50"
> > > +=A0=A0=A0=A0=A0 - "100"
> > > +=A0=A0=A0=A0=A0 - "200"
> > > +=A0=A0=A0=A0=A0 - "400"
> > > +=A0=A0=A0=A0=A0 - "800"
> > > +=A0=A0=A0=A0=A0 - "1600"
> > > +=A0=A0=A0 default: "12.5"
> > > +
> > > +=A0 ps-ir-led-pulse-count:
> > > +=A0=A0=A0 description: IR LED drive pulse count
> > > +=A0=A0=A0 $ref: /schemas/types.yaml#/definitions/uint32
> >=20
> > All custom properties require a vendor prefix, not "ps". Again, what
> > makes this a property of the hardware, rather than something that
> > software should control?
> >=20
> > > +=A0=A0=A0 minimum: 1
> > > +=A0=A0=A0 maximum: 256
> > > +=A0=A0=A0 default: 1
> > > +
> > > +=A0 ps-offset-cancel:
> > > +=A0=A0=A0 description: |
> > > +=A0=A0=A0=A0=A0 When PS offset cancel function is enabled, the resul=
t of
> > > subtracting any
> > > +=A0=A0=A0=A0=A0 value specified by the PS offset cancel register fro=
m the
> > > internal PS
> > > +=A0=A0=A0=A0=A0 output data is written to the PS output data registe=
r.
> >=20
> > Again, what makes this a property of the hardware? What hardware
> > related
> > factors determine that value that you put in here?
> >=20
> > Thanks,
> > Conor.
>=20
> Certain parameters such as conversion time, wait time, or sampling rate
> are directly tied to the physical characteristics and capabilities of
> the sensor. These parameters are typically determined by the sensor
> specifications, and the datasheet usually provides recommended values
> for these parameters. Below is an excerpt from the datasheet:
>=20
> /*
> +-----------------------+-------+------+------+------+-----+----------+
> | Parameter             | Symbol| Min  | Typ  | Max  | Unit| Condition|
> +-----------------------+-------+------+------+------+-----+----------+
> | PS A/D conversion time| TPS   | 21.4 | 25.2 | 28.9 | ms  | PS
> A/DC=3D16bit  |
> | PS wait time setting  | TPSWAIT| 10.6| 12.5 | 14.3 | ms  | 12.5ms
> setting |
> +-----------------------+-------+------+------+------+-----+----------+
> */
>=20
>=20
> However, there are some similar cases in the kernel, as follows:
>=20
> Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
>     - startup-time-ms
> Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
>     - semtech,avg-pos-strength
>     - semtech,ph01-resolution
>     - semtech,input-analog-gain
>     - ...
> Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
>     - vishay,led-current-microamp
>=20
> This is why we are leveraging the hardware properties.

"Other people did it" is not sufficient justification, you need to
independently justify the properties you add. It appears however, that
Jonathan (who understands these devices better than I, and had a
functioning datasheet link), is also of the opinion that these would be
better suited as userspace controls or require improved explanations.
I suggest you read and reply to his mail in an itemised manner.

Cheers,
Conor.

--sPwfgDXrIWGtLfNj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZr96MwAKCRB4tDGHoIJi
0pgkAPoCWnBjV0gB9bFBZWC+S+RLtXdF4dvQenICgqPiWBZUfQEAzQc682w8hDai
7Vw2TmsTQCxEzCTVX/7Q5dMHT9HkfwI=
=XM/t
-----END PGP SIGNATURE-----

--sPwfgDXrIWGtLfNj--

