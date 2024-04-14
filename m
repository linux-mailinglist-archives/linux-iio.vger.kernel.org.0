Return-Path: <linux-iio+bounces-4230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD35F8A3D14
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 17:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E436B21320
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 15:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAD244C7E;
	Sat, 13 Apr 2024 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGGnc2sN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8413E23A9;
	Sat, 13 Apr 2024 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713020787; cv=none; b=IYI049Hpr8RcY+uDwWS6Zwu5CDTbDe0S449+OoEctF5okCWEJus2U/HIewHM0jC1EILf93urLsrUmWxOYnEDb1ZFWGSfmkYqlqB87sL/lWrpm7xDoEYUVHCDj7/d8qkV4vgGM3+PHOUIslvDK4kbaXaGGvkn0HMCigxwONszq2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713020787; c=relaxed/simple;
	bh=ufEmyZ5IxA0KU7idNtT0jCJqpoBbRR2IuGsv3TUhayY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=py07R0PB9fIWmYLWDXfVJN1J+e8Qk+UdQO1XrSu1yg/gz8QmIEcdxZSwVpKOZuMJlD1orvB/fPNjYBTS84BA5EAHiCa5gkqNJlZY8C/hwasy7XZ9J7YYFaP+sXjIOrFXEV1aE84soxBWpCq9/7g1fko7pVHH/raeOlkDlxdgLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGGnc2sN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61535C113CD;
	Sat, 13 Apr 2024 15:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713020787;
	bh=ufEmyZ5IxA0KU7idNtT0jCJqpoBbRR2IuGsv3TUhayY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oGGnc2sN1igIn+gqpqJTNghcwxzZ6GCSEF9RbIb6Z20vniYloTKYuQbLQxLrAeSWd
	 pB+tzqakmFAYk8+Mqr8BrqDFKrtwFlp1F1/hn1ee/wWZwIU2OmyVg9cpjsY0zbS1Y5
	 D3xlfnfu03iK0daSRs3hfEvAUGfFbZ6q8+y7sizT2WV3BbgBy4XaYqz9fHfhb8Y0Dk
	 S5mfhRY0A7qZy6cHj7j+ZKUmdovhv2vtumhYsCup9wMgMWeXqiGnmaxuGoNZBFk/vT
	 yuRmOEQTBbypeOHrE9QqJBSWzcQ5p41+U9bzZA/YJ9P0AutkpjtPtJG+k3FeJBbyH5
	 HuGRJhfk2wMzQ==
Date: Sat, 13 Apr 2024 16:06:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 1/4] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Message-ID: <20240413160610.4cec010b@jic23-huawei>
In-Reply-To: <CAMknhBHgKK_OEcPz-5ktxj+YEkB7jHpw5owdh9HVj_qfwuVXkQ@mail.gmail.com>
References: <20240412032102.136071-1-kimseer.paller@analog.com>
	<20240412032102.136071-2-kimseer.paller@analog.com>
	<CAMknhBHgKK_OEcPz-5ktxj+YEkB7jHpw5owdh9HVj_qfwuVXkQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Apr 2024 16:23:00 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Thu, Apr 11, 2024 at 10:21=E2=80=AFPM Kim Seer Paller
> <kimseer.paller@analog.com> wrote:
> >
> > Add documentation for ltc2664 and ltc2672.
> >
> > Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

A few follow up comments inline as David and Krzysztof already gave
good feedback.

> > ---
> >  .../bindings/iio/dac/adi,ltc2664.yaml         | 230 ++++++++++++++++++
> >  MAINTAINERS                                   |   8 +
> >  2 files changed, 238 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc26=
64.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml=
 b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> > new file mode 100644
> > index 000000000..2f581a9e5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> > @@ -0,0 +1,230 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/adi,ltc2664.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices LTC2664 and LTC2672 DAC
> > +
> > +maintainers:
> > +  - Michael Hennerich <michael.hennerich@analog.com>
> > +  - Kim Seer Paller <kimseer.paller@analog.com>
> > +
> > +description: |
> > +  Analog Devices LTC2664 4 channel, 16 bit, +-10V DAC
> > +  Analog Devices LTC2672 5 channel, 16 bit, 300mA DAC
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/=
ltc2664.pdf =20
>=20
> This link gives a 404 error. Is there a typo?
>=20
>=20
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/=
ltc2672.pdf
> > +
> > +$defs:
> > +  toggle-operation:
> > +    type: object
> > +    description: Toggle mode channel setting.
> > +
> > +    properties:
> > +      reg:
> > +        description: Channel number.
> > +        minimum: 0
> > +        maximum: 4
> > + =20
>=20
> > +      adi,toggle-mode:
> > +        description:
> > +          Set the channel as a toggle enabled channel. Toggle operatio=
n enables
> > +          fast switching of a DAC output between two different DAC cod=
es without
> > +          any SPI transaction.
> > +        type: boolean =20
>=20
> I'm not convinced that this belongs in the devicetree. It seems like
> everything related to toggling can and should be left to runtime
> configuration.

Agreed - probably on a fifo basis, so each time you switch to the other
toggle value, but if you happen to already have the value stored already
you can elide the SPI transfer.

I think we already have a device doing this, though I can't remember which
driver it is.  Perhaps search for toggle.

>=20
> > +
> > +patternProperties:
> > +  "^channel@[0-4]$":
> > +    type: object
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ltc2664
> > +      - adi,ltc2672
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 50000000
> > +
> > +  vcc-supply:
> > +    description: Analog Supply Voltage Input.
> > + =20
>=20
> There is also an input supply for each output channel on ltc2672, so I
> think we also need vdd0-supply, vdd1-supply, etc.
>=20
> On ltc2664, there is V+ instead so it needs v-pos-supply.
>=20
> And there is V~ on both which can be between -5.5V/-15.75V and GND, so
> optional v-neg-supply seems appropriate.

Only make it optional in the binding if the settings of the device change
depending on whether it is there or not.  Looks like there is an internal
reference, so maybe it really is optional.

>=20
> > +  iovcc-supply:
> > +    description: Digital Input/Output Supply Voltage.
> > +
> > +  vref-supply:
> > +    description:
> > +      Reference Input/Output. The voltage at the REF pin sets the full=
-scale
> > +      range of all channels. If not provided the internal reference is=
 used and
> > +      also provided on the VREF pin. =20
>=20
> There is no VREF pin, so it looks like there is a typo. And it would
> make more sense to call this ref-supply as well.
>=20
> > +
> > +  clr-gpios:
> > +    description:
> > +      If specified, it will be asserted during driver probe. As the li=
ne is
> > +      active low, it should be marked GPIO_ACTIVE_LOW.
> > +    maxItems: 1 =20
>=20
> Some other potentially properties for complete bindings that would be
> trivial to add now:
>=20
> * (ltc2672) There is a FAULT output pin, so it would make sense to
> have an interrupts property for that signal.
> * (both) I haven't done any DACs myself yet, but I see ldac-gpios on a
> few other bindings. I assume this is the typical way for handling the
> LDAC signal on most DACs?
> * (both) I see these have daisy chain capabilities, so an optional
> #daisy-chained-devices could be appropriate.
>=20
> Maybe not so trivial:
>=20
> * (both) The MUX/MUXOUT pins look like we have an embedded pin mux, so
> it could mean we need #pinctrl-cells. ltc2664 would also need
> muxin-gpios for this.
Not convinced that's the right approach - looks more like a channel
selector than a conventional mux or pin control. Sure that's a mux, but
we want a clean userspace control to let us choose a signal to measure
at runtime

If you wanted to support this I'd have the binding describe optional
stuff to act as a consumer of an ADC channel on another device.=20
The IIO driver would then provide a bunch of input channels to allow
measurement of each of the signals.

Look at io-channels etc in existing bindings for how to do that.

>=20
>=20
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: adi,ltc2664
> > +    then:
> > +      properties:
> > +        adi,manual-span-operation-config:
> > +          description:
> > +            This property must mimic the MSPAN pin configurations.
> > +            By tying the MSPAN pins (MSP2, MSP1 and MSP0) to GND
> > +            and/or VCC, any output range can be hardware-configured
> > +            with different mid-scale or zero-scale reset options.
> > +            The hardware configuration is latched during power on reset
> > +            for proper operation.
> > +              0 - MPS2=3DGND, MPS1=3DGND, MSP0=3DGND
> > +              1 - MPS2=3DGND, MPS1=3DGND, MSP0=3DVCC
> > +              2 - MPS2=3DGND, MPS1=3DVCC, MSP0=3DGND
> > +              3 - MPS2=3DGND, MPS1=3DVCC, MSP0=3DVCC
> > +              4 - MPS2=3DVCC, MPS1=3DGND, MSP0=3DGND
> > +              5 - MPS2=3DVCC, MPS1=3DGND, MSP0=3DVCC
> > +              6 - MPS2=3DVCC, MPS1=3DVCC, MSP0=3DGND
> > +              7 - MPS2=3DVCC, MPS1=3DVCC, MSP0=3DVCC (enables SoftSpan=
 feature)
> > +          $ref: /schemas/types.yaml#/definitions/uint32
> > +          enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > +          default: 7 =20
>=20
> Are these always hard-wired or could they be connected to gpios and
> made configurable at runtime?

This is always a fun gap for GPIOs. It would be nice to have a generic
binding that said there was a fixed GPIO value that we could then query
but not set.  I'm not aware of a general way to do this so we end up with
optional GPIOs and some vendor specific property for when it's fixed.

>=20
> > +
> > +      patternProperties:
> > +        "^channel@([0-3])$":
> > +          $ref: '#/$defs/toggle-operation'
> > +          unevaluatedProperties: false
> > +
> > +          description: Channel in toggle functionality.
> > +
> > +          properties:
> > +            adi,output-range-microvolt:
> > +              description: Specify the channel output full scale range=
. =20
>=20
> How would someone writing a .dts know what values to select for this
> property? Or is this something that should be configured at runtime
> instead of in the devicetree? Or should this info come from the
> missing voltage supplies I mentioned?

Sometimes this one is a wiring related choice.  Sometimes to the extent
that picking the wrong one from any userspace control can cause damage
or is at least nonsense.=20

You look to be right though that the possible values here aren' fine
if the internal reference is used, but not the external.

However, it's keyed off MPS pins so you can't control it if they aren't
tied to all high.  So I'd imagine if the board can be damaged it will
be hard wired.  Hence these could be controlled form userspace.
It's a bit fiddly though as combines scale and offset controls and
you can end trying to set things to an invalid combination.
E.g. scale set to cover 20V range and offset set to 0V
To get around that you have to clamp one parameter to nearest
possible when the other is changed.

>=20
> > +              oneOf:
> > +                - items:
> > +                    - const: 0
> > +                    - enum: [5000000, 10000000]
> > +                - items:
> > +                    - const: -5000000
> > +                    - const: 5000000
> > +                - items:
> > +                    - const: -10000000
> > +                    - const: 10000000
> > +                - items:
> > +                    - const: -2500000
> > +                    - const: 2500000
> > +
> > +          required:
> > +            - adi,output-range-microvolt
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: adi,ltc2672
> > +    then:
> > +      properties:
> > +        adi,rfsadj-ohms:
> > +          description: If FSADJ is tied to VCC, an internal RFSADJ (20=
 k=CE=A9) is
> > +            selected, which results in nominal output ranges. When an =
external
> > +            resistor of 19 k=CE=A9 to 41 k=CE=A9 can be used instead b=
y connecting the
> > +            resistor between FSADJ and GND it controls the scaling of =
the
> > +            ranges, and the internal resistor is automatically disconn=
ected.
> > +          minimum: 19000
> > +          maximum: 41000
> > +          default: 20000 =20
>=20
> This is the kind of description that would be helpful on some of the
> other properties. It does a good job of explaining what value to
> select based on what is connected to the chip.
>=20
> > +
> > +      patternProperties:
> > +        "^channel@([0-4])$":
> > +          $ref: '#/$defs/toggle-operation'
> > +          unevaluatedProperties: false
> > +
> > +          description: Configuration properties for a channel in toggl=
e mode
> > +
> > +          properties:
> > +            adi,output-range-microamp:
> > +              description: Specify the channel output full scale range.
> > +              $ref: /schemas/types.yaml#/definitions/uint32
> > +              enum: [3125000, 6250000, 12500000, 25000000, 50000000, 1=
00000000,
> > +                     200000000, 300000000]
> > + =20
>=20
> Same comments as adi,output-range-microvolt apply here.
>=20
> > +          required:
> > +            - adi,output-range-microamp
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - spi-max-frequency
> > +  - vcc-supply
> > +  - iovcc-supply
> > +
> > +additionalProperties: false
> > + =20


