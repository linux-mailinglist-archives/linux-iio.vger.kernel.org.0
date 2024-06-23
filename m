Return-Path: <linux-iio+bounces-6748-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDB2913AA2
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 14:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A7F281742
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 12:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D96B180A9E;
	Sun, 23 Jun 2024 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apLx6mTM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E372512C559;
	Sun, 23 Jun 2024 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719146529; cv=none; b=KyE/UQjW49UEb6F/nWBuVhYbBPj0zhE5jJqc8FNVCO3FumKSYbtuW4+kFQhcor/gclKCbcKDSy+8e8DJ5X7k/JYqEoxS9hJiJ8eVFmGP15b6ZGvZCBnkGd/u4ACPE+PX9QhJNaMLzX9aTgbJgJ3oCl0o8jmj3jAMpwTuEiAe1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719146529; c=relaxed/simple;
	bh=A9hKnJ+8MudWJouvEnLEWB6hLGadfAdpcqd6kAZ8eCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZ+vAvkxVBlqqi2Mv5A+BujM3Uf/QCl8r51+B//nQgc31q253Oua0wnnHHXqirA7MRq2cwuEYIK76BFfQDt+Pa/kX75uP28g9+5I3LvAGYory9lMyb5FjfnNg+VgF+OOpLONPxzwFZUQrwtadGNV2KqJFbqkW4MgBh1KI1HNg1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apLx6mTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED80C2BD10;
	Sun, 23 Jun 2024 12:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719146528;
	bh=A9hKnJ+8MudWJouvEnLEWB6hLGadfAdpcqd6kAZ8eCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=apLx6mTMh9GDgJtY9uIvaPK2XBA5uIeG9SLJiBIhbeITseeZP5LhHvUVf6wl1shQV
	 fRfPOxh0XgwfSvoVjnMOiix3vPJWZBovCM+0CD1l2RMq+sVyqOUFFCHHhN/evNn5gW
	 A/d9Z+XylUcTcLM6oMZd2TEvizIAFEo6pHKhno5SXHJY34gFNOlZM9OUC5kxsIIvIO
	 aTVRhvaoqMG7DQi+9NPHL+rNPMI779iqDEVvZrZoo6TaJtZsENKNsr+gm1dUTooZ46
	 GVoKW3I99SJumwuvSR8GnVfmV9LjlwJhFZX9MOTCWCbqbtvVoYEQDr9+xKoaY9mzPt
	 JXypUnqKKKvbA==
Date: Sun, 23 Jun 2024 13:41:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Cosmin
 Tanislav <cosmin.tanislav@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Nuno Sa
 <nuno.sa@analog.com>, Maksim Kiselev <bigunclemax@gmail.com>, Marius
 Cristea <marius.cristea@microchip.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Okan Sahin <okan.sahin@analog.com>, Ivan
 Mikhaylov <fr0st61te@gmail.com>, Liam Beguin <liambeguin@gmail.com>, Mike
 Looijmans <mike.looijmans@topic.nl>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: add a7779 doc
Message-ID: <20240623134158.6dc26a15@jic23-huawei>
In-Reply-To: <20240619-pouring-evaluator-470155652a40@spud>
References: <20240619122105.22642-1-ramona.nechita@analog.com>
	<20240619122105.22642-2-ramona.nechita@analog.com>
	<20240619-pouring-evaluator-470155652a40@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Jun 2024 18:42:31 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Jun 19, 2024 at 03:20:44PM +0300, Ramona Alexandra Nechita wrote:
> > Add dt bindings for adc ad7779.
> >=20
> > Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
> > ---
> >  .../bindings/iio/adc/adi,ad7779.yaml          | 84 +++++++++++++++++++
> >  1 file changed, 84 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad777=
9.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> > new file mode 100644
> > index 000000000000..f1eec656acec
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> > @@ -0,0 +1,84 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7779.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD777X family 8-Channel, 24-Bit, Simultaneous Sa=
mpling ADCs
> > +
> > +maintainers:
> > +  - Ramona Nechita <ramona.nechita@analog.com>
> > +
> > +description: |
> > +  The AD777X family consist of 8-channel, simultaneous sampling analog=
-to-
> > +  digital converter (ADC). Eight full =CE=A3-=CE=94 ADCs are on-chip. =
The
> > +  AD7771 provides an ultralow input current to allow direct sensor
> > +  connection. Each input channel has a programmable gain stage
> > +  allowing gains of 1, 2, 4, and 8 to map lower amplitude sensor
> > +  outputs into the full-scale ADC input range, maximizing the
> > +  dynamic range of the signal chain.
> > +
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad7770.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad7771.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad7779.pdf
> > +
> > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad7770
> > +      - adi,ad7771
> > +      - adi,ad7779
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0 =20
>=20
> Why does this device have address/size cells, but not have any child
> nodes? Are you missing some channel child nodes? If you don't have
> children, you don't need these properties.
>=20
> Also, your patch is still not threaded with the other 2 patches in the
> series (I see 1/3 in the subject). Where are those patches?

Yeah, I have 3 copies of the cover letter, one with patch 1, one with patch=
 2,
one on it's own and a stray patch 3 and patchwork has failed to figure
it out...  Can one of the other Analog devices folk help Ramona get a
working confirmation for sending patches please.

The b4 gateway is a good option if no one has the magic config incantation
to get emails out of a particular corporate network.

>=20
> Thanks,
> Conor.
>=20
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  vref-supply:
> > +    description:
> > +      ADC reference voltage supply

I assume there is at least one more supply?  They should all
be listed in here and those that 'must' be turned on for the
device to function should be in required.  If it's optional, then
add to the description what happens if it isn't supplied. Typically that's
for reference supplies where the device has another option such as an inter=
nal
reference.

Jonathan

> > +
> > +  start-gpios:
> > +    description:
> > +      Pin that controls start synchronization pulse.
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +- |
> > +  #include <dt-bindings/gpio/gpio.h>
> > +  spi {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      adc@0 {
> > +        compatible =3D "adi,ad7779";
> > +        reg =3D <0>;
> > +        vref-supply =3D <&vref>;
> > +        start-gpios =3D <&gpio0 87 GPIO_ACTIVE_LOW>;
> > +        reset-gpios =3D <&gpio0 93 GPIO_ACTIVE_LOW>;
> > +        clocks =3D <&adc_clk>;
> > +      };
> > +  };
> > +...
> > --=20
> > 2.43.0
> >  =20


