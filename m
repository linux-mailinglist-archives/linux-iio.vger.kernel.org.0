Return-Path: <linux-iio+bounces-22848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B439B28FA3
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 18:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BC95C21BD
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 16:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303022FDC2A;
	Sat, 16 Aug 2025 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wk5Cb79j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB019006B;
	Sat, 16 Aug 2025 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755363186; cv=none; b=SW+RItHE4doQLg8HEnZyA472H7dogZ/39ERc6tIMEBBAGev/+kxQGNWJ22axIQSmrCZjLmChaMnt6+N9IH0Qu3rwzF2JRpO3sxDB4eN8zg5Zclmh0OFRykZQFSUaSK8eiixKZwUrbU/7aEE/SAF2AmbCPlcf3Dj3CqUUVERWu8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755363186; c=relaxed/simple;
	bh=qkucZBqfyXM1IoYj9VCRVJSt5ZKnweElt8uY1jlL0uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYkWOE87QtVdNg20wCCQMSkjlwu30MdUTdpIxn8c+xZngRL1ZjtkbCo1gwddUNIgAOLnbUIUC9Buz0922DrLeYdoot9rCko7xQ7u2RLwOs200og7BayhKt+MQN+A/M6nMHtMnCsJsV4wNnZaI8Ms2w1OLWES42idVrO5GICjuyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wk5Cb79j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D06C4CEEF;
	Sat, 16 Aug 2025 16:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755363185;
	bh=qkucZBqfyXM1IoYj9VCRVJSt5ZKnweElt8uY1jlL0uw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wk5Cb79jDjj7h5A45pJu/w3qx/KleJZ06N622MUeoVcKsEhPP//22m44/oPBXmtTm
	 BxuWapYLdxsdFmZaeb4srP2pijf1sZ28Jcv8A/Iqezvl7GStgUetvX38bjstEsVrXt
	 pxyATHQ0Y2B7EH5F1X2xHprZGLM7J2vELMkDgKTFOc1TYZZDlw0EDEDm6anniya+00
	 yWEFgGnHiB1L8D9M5krkAIC+zF/3kIlwTxMb+/539KQmeDVz0wb8zhxJUn1UvpMHej
	 hkJhpqpjSCeRIof1xpcyw/vQJv79d25QLpEPi0e4kMDMbTmKP3S9WTUDswr/U3IAMH
	 OM6R/fjLy6peA==
Date: Sat, 16 Aug 2025 17:52:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] dt-bindings: iio: adc: add ade9000
Message-ID: <20250816175258.42286693@jic23-huawei>
In-Reply-To: <20250815095713.9830-4-antoniu.miclaus@analog.com>
References: <20250815095713.9830-1-antoniu.miclaus@analog.com>
	<20250815095713.9830-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Aug 2025 09:56:36 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add devicetree bindings support for ade9000.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu,
Sorry I missed v3 last week. Garage door crisis ate up my review time!

A few minor comments inline.

Jonathan

> ---
> changes in v4:
>  - improve description formatting (remove unnecessary pipe symbols)
>  - move $ref to end and remove allOf section for cleaner structure
>  .../bindings/iio/adc/adi,ade9000.yaml         | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000=
.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b=
/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> new file mode 100644
> index 000000000000..bd374c0d57d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ade9000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADE9000 High Performance, Polyphase Energy Meterin=
g driver
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  The ADE9000 s a highly accurate, fully integrated, multiphase energy a=
nd power

is a=20

> +  quality monitoring device. Superior analog performance and a digital s=
ignal
> +  processing (DSP) core enable accurate energy monitoring over a wide dy=
namic
> +  range. An integrated high end reference ensures low drift over tempera=
ture
> +  with a combined drift of less than =C2=B125 ppm/=C2=B0C maximum for th=
e entire channel
> +  including a programmable gain amplifier (PGA) and an analog-to- digital
analog-to-digital

> +  converter (ADC).
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
E9000.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ade9000
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  interrupts:
> +    maxItems: 3
> +
> +  interrupt-names:
> +    items:
> +      - const: irq0
> +      - const: irq1
> +      - const: dready

I always forget how these work.  Does this allow me to say irq1 and dready
are wired but not irq0?=20

Similar to question on interrupts being required below, if it is plausible
the driver could be modified to work with a lesser set, the binding should =
allow
it.

> +
> +  reset-gpios:
> +    description:
> +      Must be the device tree identifier of the RESET pin. As the line is
> +      active low, it should be marked GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  vref-supply: true
> +
> +  clocks:
> +    description: External clock source when not using crystal
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: clkin
> +
> +  "#clock-cells":
> +    description:
> +      ADE9000 can provide clock output via CLKOUT pin with external buff=
er.
> +    const: 0
> +
> +  clock-output-names:
> +    items:
> +      - const: clkout
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios

As with interrupts, can we not use it at all if the reset line is tied
to not reset?   Or is it a driver limitation (which is fine to have but sho=
uldn't
affect the binding).

> +  - interrupts
> +  - interrupt-names
My usual question on interrupts.  Is the device completely useless without =
them or
is it just the case that we currently require them in the driver because we=
 don't
poll for completion as an alternative?  Fine to require them in the driver =
even
if the binding doesn't require them.

> +  - vdd-supply
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      adc@0 {
> +          compatible =3D "adi,ade9000";
> +          reg =3D <0>;
> +          spi-max-frequency =3D <7000000>;
> +
> +          #clock-cells =3D <0>;
> +          reset-gpios =3D <&gpio 4 GPIO_ACTIVE_LOW>;
> +          interrupts =3D <2 IRQ_TYPE_EDGE_FALLING>, <3 IRQ_TYPE_EDGE_FAL=
LING>, <4 IRQ_TYPE_EDGE_FALLING>;
> +          interrupt-names =3D "irq0", "irq1", "dready";
> +          interrupt-parent =3D <&gpio>;
> +          /* Optional: external clock instead of crystal */
> +          /* clocks =3D <&ext_clock_24576khz>; */
> +          /* clock-names =3D "clkin"; */
It's an example so pick one of them - if anyone wants to know what else wor=
ks they can
look at the binding.  If there is something sufficiently unusual to be non =
obvious, have
a second example. Having stuff as comment in here is untestable and not par=
ticularly
easy to find.

> +          clock-output-names =3D "clkout";
> +          vdd-supply =3D <&vdd_reg>;
> +      };
> +    };


