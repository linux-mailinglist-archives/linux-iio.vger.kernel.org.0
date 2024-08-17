Return-Path: <linux-iio+bounces-8539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14715955822
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 15:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118701C20C2B
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E17615359A;
	Sat, 17 Aug 2024 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHlp26IH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85312745E;
	Sat, 17 Aug 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723902144; cv=none; b=T4XYClyqqOaAJ8DKmTEn81wpBhFxpypDOrZZFcPUnARRa9euublKUgSvXlyzMVeq3n86b/JMr3eD8eA2GeeaeBKiiGQhp/9B8A5jMa1M/avpG7LlGXKVrQ7Dxoj7wNRbqHKATC5m4c631279/YZn7javRgEvolqq8G2qx/xD334=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723902144; c=relaxed/simple;
	bh=hYXiXv4D4hGebvEHZRWy15ifimGJBekHZxkDSjvrFmo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtA1KBamM52sCBSfNwTIn6eCEk3D9cL20Ic2WPEygjuqDADVUJOfRcwU+ZhaTytOj9p6usX7Da00SV27eRX/Lu6vLz8jNWrBOc4XxYXPsttywXmZcihSCFf+Hp4OBQH/tPbBVP77VwnzK3kzi40I/Q6wHknX1nvAIGpOStraFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHlp26IH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7D8C116B1;
	Sat, 17 Aug 2024 13:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723902143;
	bh=hYXiXv4D4hGebvEHZRWy15ifimGJBekHZxkDSjvrFmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fHlp26IH7KPh/yfX2x8Phvo+MFeSJaUNo35q1JJuNfIF3Q1tVAPxPSQHbWPoSP3wh
	 tATM4C+nxd/MASrwRG/e4BB3tK7/8XMDkCYMNO6wSxozPCwiOd+VLecETXGgzGYd4T
	 oqMXpVb3iC7CUzJ5udNH1ulOVBeTGhsFSzDV+eqYrIvliWUUKcAJFMw9YIqbwtY3tx
	 +iLoHYN47WtapOz/tUZ2TgQLzd2OUItkFH2opFbgPpomqmjhXRNOPS4SAw3druS2eE
	 hfU64xtafODIrrc35MtQ1YzFTUaxvOxmbz5LS7i+Dq7zWBEVNdMihuzeFChybrei1Q
	 zSuwgXne9CPjQ==
Date: Sat, 17 Aug 2024 14:42:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Li, Hua Qian" <HuaQian.Li@siemens.com>
Cc: "conor@kernel.org" <conor@kernel.org>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>, "Zeng, Chao" <chao.zeng@siemens.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "Su, Bao Cheng"
 <baocheng.su@siemens.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: iio: Add everlight pm16d17 binding
Message-ID: <20240817144215.1b2e9db3@jic23-huawei>
In-Reply-To: <a458a2cbc96a23c0a2ef89327e1f8bcd2e2777e6.camel@siemens.com>
References: <cover.1723527641.git.jan.kiszka@siemens.com>
	<f6476e06cd8d1cf3aff6563530612c536cd45716.1723527641.git.jan.kiszka@siemens.com>
	<20240813-captivity-spellbind-d36ca0f31e22@spud>
	<a458a2cbc96a23c0a2ef89327e1f8bcd2e2777e6.camel@siemens.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Aug 2024 01:48:36 +0000
"Li, Hua Qian" <HuaQian.Li@siemens.com> wrote:

> On Tue, 2024-08-13 at 16:52 +0100, Conor Dooley wrote:
> > On Tue, Aug 13, 2024 at 07:40:41AM +0200, Jan Kiszka wrote: =20
> > > From: Chao Zeng <chao.zeng@siemens.com>
> > >=20
> > > Add the binding document for the everlight pm16d17 sensor.
> > >=20
> > > Signed-off-by: Chao Zeng <chao.zeng@siemens.com>
> > > Co-developed-by: Baocheng Su <baocheng.su@siemens.com>
> > > Signed-off-by: Baocheng Su <baocheng.su@siemens.com> =20
> >=20
> > Ditto here Jan.
> >  =20
> > > ---
> > > =C2=A0.../iio/proximity/everlight,pm16d17.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 95
> > > +++++++++++++++++++
> > > =C2=A01 file changed, 95 insertions(+)
> > > =C2=A0create mode 100644
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
> > > +=C2=A0 - Chao Zeng <chao.zeng@siemens.com>
> > > +
> > > +description: |
> > > +=C2=A0 This sensor uses standard I2C interface. Interrupt function is
> > > not covered. =20
> >=20
> > Bindings should be complete, even if software doesn't use the
> > interrupts. Can you document them please.
> >  =20
> > > +=C2=A0 Datasheet:
> > > https://en.everlight.com/sensor/category-proximity_sensor/digital_pro=
ximity_sensor/ =20
> >=20
> > Do you have a link to a datasheet? The link to the pm16d17 here 404s
> > for
> > me.
> >  =20
> > > +
> > > +properties:
> > > +=C2=A0 compatible:
> > > +=C2=A0=C2=A0=C2=A0 enum:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - everlight,pm16d17
> > > +
> > > +=C2=A0 reg:
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > +
> > > +=C2=A0 ps-gain:
> > > +=C2=A0=C2=A0=C2=A0 description: Receiver gain of proximity sensor
> > > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/uint32
> > > +=C2=A0=C2=A0=C2=A0 enum: [1, 2, 4, 8]
> > > +=C2=A0=C2=A0=C2=A0 default: 1
> > > +
> > > +=C2=A0 ps-itime: =20
> >=20
> > How did you get itime from conversion time? To the layman (like me!)
> > conversion-time would make more sense...
> >=20
> > Also, "ps"? The whole thing is a proxy sensor, so why have that
> > prefix
> > on properties. What is missing however is a vendor prefix.
> >  =20
> > > +=C2=A0=C2=A0=C2=A0 description: Conversion time for proximity sensor=
 [ms]
> > > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/string =20
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
> >  =20
> > > +=C2=A0=C2=A0=C2=A0 enum:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "0.4"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "0.8"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "1.6"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "3.2"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "6.3"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "12.6"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "25.2"
> > > +=C2=A0=C2=A0=C2=A0 default: "0.4"
> > > +
> > > +=C2=A0 ps-wtime:
> > > +=C2=A0=C2=A0=C2=A0 description: Waiting time for proximity sensor [m=
s]
> > > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/string =20
> >=20
> > All of the same comments apply here. E.g. why "wtime" isntead of
> > "waiting-time" and so on.
> > I would really like to know why these things are properties of the
> > hardware, rather than something that software should control.
> >  =20
> > > +=C2=A0=C2=A0=C2=A0 enum:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "12.5"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "25"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "50"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "100"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "200"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "400"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "800"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "1600"
> > > +=C2=A0=C2=A0=C2=A0 default: "12.5"
> > > +
> > > +=C2=A0 ps-ir-led-pulse-count:
> > > +=C2=A0=C2=A0=C2=A0 description: IR LED drive pulse count
> > > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/uint32 =20
> >=20
> > All custom properties require a vendor prefix, not "ps". Again, what
> > makes this a property of the hardware, rather than something that
> > software should control?
> >  =20
> > > +=C2=A0=C2=A0=C2=A0 minimum: 1
> > > +=C2=A0=C2=A0=C2=A0 maximum: 256
> > > +=C2=A0=C2=A0=C2=A0 default: 1
> > > +
> > > +=C2=A0 ps-offset-cancel:
> > > +=C2=A0=C2=A0=C2=A0 description: |
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 When PS offset cancel function is ena=
bled, the result of
> > > subtracting any
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value specified by the PS offset canc=
el register from the
> > > internal PS
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 output data is written to the PS outp=
ut data register. =20
> >=20
> > Again, what makes this a property of the hardware? What hardware
> > related
> > factors determine that value that you put in here?
> >=20
> > Thanks,
> > Conor. =20
>=20
> Certain parameters such as conversion time, wait time, or sampling rate
> are directly tied to the physical characteristics and capabilities of
> the sensor.

Ah. I think I'd missed this uses an external LED (rather than it being
in package).  In that case, the characteristics that 'work' for
proximity sensing are somewhat dependent on the system design
(simplifying heavily, led output for a given current, optical filter
 on that LED etc).

For the sensor specific side, it should be just from the compatible, but
when another part is involved, DT binding based tuning may make sense
as long as it is 'per consumer device / board' not per specific instance.




> These parameters are typically determined by the sensor
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

Doesn't apply to everything you have here though. wtime / wait time
is about how often you get a reading not the physical device.  How is
that affected by the physical device?

I 'think' the table above is giving precision of the value for a particular
control setting. If you set wtime to 12.5msec (value 0 in register)
then it will actually be between 10.6 and 14.3 msec, not that you should
set it to 12.5msec.

There are 3 controls related to gain that you could argue for defaults
for in DT (maybe) but given proximity sensing is also about the
target, not just the measurement device, there won't be a right answer
unless your proximity sensor is being used for a fixed purpose (e.g.
WIFI signal strength limiting or a button type control).
>=20
>=20
> However, there are some similar cases in the kernel, as follows:
>=20
> Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
>     - startup-time-ms
That's after a resume and I think depends one exactly what the circuitry
is (in this case the device is more of a reference design than a single
device).

> Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
>     - semtech,avg-pos-strength
>     - semtech,ph01-resolution
>     - semtech,input-analog-gain
These are SAR sensors I think, so the sensor element is external to
the device.  In theory we could have described the sensing element
and used that to work out the right values of these, but in practice
it was easier to just provide the parameters from some 'per design'
tuning.

>     - ...
> Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
>     - vishay,led-current-microamp

I think this is about whether you can burn the external LED out or not.
On the datasheet I'm looking at for this device, only value 000 is
specified in this 3bit field so I guess it's not controllable?

Pulse counts are less likely to be relevant to the LED burning out, but
maybe(?)

Anyhow, it's not entirely obvious to me that it makes sense to control
so much in DT for this device.  Better to put it in userspace control
and rely on udev etc setting things right for a given device + application.

Jonathan




>=20
> This is why we are leveraging the hardware properties.
>=20
> Thanks,
> Hua Qian
>=20
> >  =20
> > > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/uint32
> > > +=C2=A0=C2=A0=C2=A0 default: 0
> > > +=C2=A0=C2=A0=C2=A0 maximum: 65535
> > > +
> > > +required:
> > > +=C2=A0 - compatible
> > > +=C2=A0 - reg
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +=C2=A0 - |
> > > +=C2=A0=C2=A0=C2=A0 i2c {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lightsensor: pm16d17@44 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ompatible =3D "everlight,pm16d17";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eg =3D <0x44>;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
s-gain =3D <1>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
s-itime =3D "0.4";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
s-wtime =3D "12.5";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
s-ir-led-pulse-count =3D <1>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
s-offset-cancel =3D <280>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > +=C2=A0=C2=A0=C2=A0 };
> > > --=20
> > > 2.43.0
> > >  =20
>=20


