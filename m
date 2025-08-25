Return-Path: <linux-iio+bounces-23199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E825AB33BFF
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 11:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952123A38B7
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 09:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9212D8DAA;
	Mon, 25 Aug 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyDKJ/+O"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A183328B3EB;
	Mon, 25 Aug 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115841; cv=none; b=czAe9Qdwz/WNsxI0okaOn2LQFUL1mfcoKzw8Ila9wZiyCGRFR+batiLxgb4ljFz53/mX08ELyEtzfwz46peD2Jt4JLmqTqWeyWsDJXay9UvlpKxdD817Ss+vw5fTYFqyivpYZBHL+FQJnD+9Cy7um1+wr58qig2iu/sx5Ujwp7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115841; c=relaxed/simple;
	bh=vwlBq4Owr1jO686WKV4W+2f+92H7k6xFVx9ZJIbVCEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpQyDuCv430cqjD1ba220b1ilraEqzYZfr3v5Rp1Owe/c3IljcjPgzKtS/GP3tUlmsmPqdp2XKjLeu87jO5ueCxQehb6nc5vM0KkOzqN9kRXK0yovb28YRqvz13ORhZh58WVopfpiMcgeZukOE5H48RPtsqu7p1ZA+bgkEXte0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyDKJ/+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC352C4CEED;
	Mon, 25 Aug 2025 09:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756115841;
	bh=vwlBq4Owr1jO686WKV4W+2f+92H7k6xFVx9ZJIbVCEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DyDKJ/+OuRnW/tTwGN5+5T5WW/IEo5+MfLUWDUmCFhhFRVmMQt5QGGiVVzHlCWgU/
	 iISpJ+nWhEiOexMxD77RnNlHdg9H4hjlbHqQuwowGdjAzyYwP0BQtJRWXvAI9a0HY+
	 QN1Kzt4mGSq6r4W1dABWgCOiL8sm+LgIGWW3maHBT6rmGT9VRQcwwpuWlIM9MQg5dl
	 TSTFuO6X78FEqXkZkwIb1boGgYSNYAdAEJ1tCbLfzA9w2HqIK3zgbX8Fl3YBBykf1Z
	 6ORUVs2Iu2nLSrq1EMuk+hPEtJxgJ4VXD/Hey8o6F0atmc8h4myDUMXM67Ojy9VakR
	 nsfnyrRgh3fFw==
Date: Mon, 25 Aug 2025 10:57:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/5] dt-bindings: iio: adc: add ade9000
Message-ID: <20250825105712.3c9a3776@jic23-huawei>
In-Reply-To: <20250820210340.GB986565-robh@kernel.org>
References: <20250815095713.9830-1-antoniu.miclaus@analog.com>
	<20250815095713.9830-4-antoniu.miclaus@analog.com>
	<20250816175258.42286693@jic23-huawei>
	<20250820210340.GB986565-robh@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Aug 2025 16:03:40 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sat, Aug 16, 2025 at 05:52:58PM +0100, Jonathan Cameron wrote:
> > On Fri, 15 Aug 2025 09:56:36 +0000
> > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> >  =20
> > > Add devicetree bindings support for ade9000.
> > >=20
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com> =20
> >=20
> > Hi Antoniu,
> > Sorry I missed v3 last week. Garage door crisis ate up my review time!
> >=20
> > A few minor comments inline.
> >=20
> > Jonathan
> >  =20
> > > ---
> > > changes in v4:
> > >  - improve description formatting (remove unnecessary pipe symbols)
> > >  - move $ref to end and remove allOf section for cleaner structure
> > >  .../bindings/iio/adc/adi,ade9000.yaml         | 108 ++++++++++++++++=
++
> > >  1 file changed, 108 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade=
9000.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.ya=
ml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> > > new file mode 100644
> > > index 000000000000..bd374c0d57d4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> > > @@ -0,0 +1,108 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +# Copyright 2025 Analog Devices Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/adi,ade9000.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices ADE9000 High Performance, Polyphase Energy Met=
ering driver
> > > +
> > > +maintainers:
> > > +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > +
> > > +description: |
> > > +  The ADE9000 s a highly accurate, fully integrated, multiphase ener=
gy and power =20
> >=20
> > is a=20
> >  =20
> > > +  quality monitoring device. Superior analog performance and a digit=
al signal
> > > +  processing (DSP) core enable accurate energy monitoring over a wid=
e dynamic
> > > +  range. An integrated high end reference ensures low drift over tem=
perature
> > > +  with a combined drift of less than =C2=B125 ppm/=C2=B0C maximum fo=
r the entire channel
> > > +  including a programmable gain amplifier (PGA) and an analog-to- di=
gital =20
> > analog-to-digital
> >  =20
> > > +  converter (ADC).
> > > +
> > > +  https://www.analog.com/media/en/technical-documentation/data-sheet=
s/ADE9000.pdf
> > > +
> > > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,ade9000
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  spi-max-frequency:
> > > +    maximum: 20000000
> > > +
> > > +  interrupts:
> > > +    maxItems: 3
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: irq0
> > > +      - const: irq1
> > > +      - const: dready =20
> >=20
> > I always forget how these work.  Does this allow me to say irq1 and dre=
ady
> > are wired but not irq0?=20
> >=20
> > Similar to question on interrupts being required below, if it is plausi=
ble
> > the driver could be modified to work with a lesser set, the binding sho=
uld allow
> > it.
> >  =20
> > > +
> > > +  reset-gpios:
> > > +    description:
> > > +      Must be the device tree identifier of the RESET pin. As the li=
ne is
> > > +      active low, it should be marked GPIO_ACTIVE_LOW.
> > > +    maxItems: 1
> > > +
> > > +  vdd-supply: true
> > > +
> > > +  vref-supply: true
> > > +
> > > +  clocks:
> > > +    description: External clock source when not using crystal
> > > +    maxItems: 1
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: clkin
> > > +
> > > +  "#clock-cells":
> > > +    description:
> > > +      ADE9000 can provide clock output via CLKOUT pin with external =
buffer.
> > > +    const: 0
> > > +
> > > +  clock-output-names:
> > > +    items:
> > > +      - const: clkout
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reset-gpios =20
> >=20
> > As with interrupts, can we not use it at all if the reset line is tied
> > to not reset?   Or is it a driver limitation (which is fine to have but=
 shouldn't
> > affect the binding).
> >  =20
> > > +  - interrupts
> > > +  - interrupt-names =20
> > My usual question on interrupts.  Is the device completely useless with=
out them or
> > is it just the case that we currently require them in the driver becaus=
e we don't
> > poll for completion as an alternative?  Fine to require them in the dri=
ver even
> > if the binding doesn't require them. =20
>=20
> That sounds to me the wrong way around. A driver is free to not require=20
> a property that the binding requires. They should only be not required=20
> if not hooking them up on the board design is valid (which would then=20
> imply a driver should be possible without them (or the h/w designer is=20
> incompetent)).

I think we are saying the same thing in different ways.
The not wired being fine was what I was referring to.  That is very common
for these sorts of devices. That is the case even if the driver today does
not deal with that case and will fail to probe.  So a driver can require
an optional property if it is possible to write a driver that does not
(or alternatively make the driver more flexible in future)

Jonathan

>=20
> Rob
>=20


