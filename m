Return-Path: <linux-iio+bounces-20719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9172CADB5AB
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 17:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B6A188DC7F
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 15:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6BD257458;
	Mon, 16 Jun 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJVlYQl/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A9820F09A;
	Mon, 16 Jun 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088467; cv=none; b=Oa5kJBetq7ipP7ppSg14vMGsy04GJjpDPcA09zYrDBLC2uYAjp5mL0H9zYFP9H0Pwe14cE9kRA65H8a4NncDdaHwIvZcLRky/cHTXu8SDz4TQbSCDIoCkRc9a4KwUaUkzOxQUnuAGuFhdGToL5yv/u2f/Bznvu2Q/pyiHRNbFRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088467; c=relaxed/simple;
	bh=73D40RyWswHRMfPg2+CFpm+821Lhm+ns1xPGi1i5jDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM01dd9/ZHlc1+qIpODekYx74gFaIl5fLVSycPJ1N0reo5UaxQdvR5rbowrtwPzKYSgqkZ2PfvEZKlMw0x5WgbfxxIJGVKoEMR37nrMqF9gnfCr53bnvNe2bd5LilzpK1kp4LK1bMTKnwqxx4AKFI2j78TUV2CSwGRwUxBBL2gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJVlYQl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60D9C4CEEA;
	Mon, 16 Jun 2025 15:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750088467;
	bh=73D40RyWswHRMfPg2+CFpm+821Lhm+ns1xPGi1i5jDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJVlYQl/WwPgF3RPueT2lPUir/VzWRbExLeg2qMd8C12kiiP8kS+TlEAERAfCYhjF
	 ZdsH54Ayo2+hcAeCO74CREJSPquwN4sKef8jhbte8ddxIF1pJCV4prkeZjmCWEBXdk
	 tmr5/GtaTKfNzWgq8Uf5eSzEfh6FYb6WzwhktVXajZ2sdZqFQiyN+idtgyp/ykTmD3
	 0jGE/I5MLVtAOL86hc27wPDe3IOhMYgHG6CzEtl7CKuP1SXZiMBjTotyK2ovUhZOR3
	 urlpgT98ttoFlSd+Dm5nWDQ4MoiZAi7Wx+vNu46t5sCtlIFKSHhoi5BaqJe+fh3RUi
	 s1QDYIxrH17VQ==
Date: Mon, 16 Jun 2025 16:41:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linus.walleij@linaro.org, brgl@bgdev.pl, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v5 01/11] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250616-neurology-explicit-ec2a829bd718@spud>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
 <4df9d4d0de83090300b6870afc8ae7b22279cd22.1749582679.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q50QzP2eWs4lR+kQ"
Content-Disposition: inline
In-Reply-To: <4df9d4d0de83090300b6870afc8ae7b22279cd22.1749582679.git.marcelo.schmitt@analog.com>


--Q50QzP2eWs4lR+kQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 05:31:04PM -0300, Marcelo Schmitt wrote:
> Add device tree documentation for AD4170 and similar sigma-delta ADCs.
> The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v4 -> v5
> - Dropped interrupt maxItems constraint.
> - Spelled out RC acronym in reference-buffer description.
> - Require to specify interrupt-names when using interrupts.
> - Added interrupt-names to the examples.
> - Made adi,excitation-pin properties identical to adi,ad4130.
> - Removed interrupt-parent props from the examples.
>=20
> Proposing new types and ways of describing hardware for weigh scale load =
cells
> and related sensors external to ADCs can lead to potential better descrip=
tion of
> how those components connect to the ADC. However, we must use what already
> exists for properties documenting features that are the same across diffe=
rent
> devices.=20
>=20
> Maybe, we could use generic defs to define adi,excitation-current-n-micro=
amp and
> adi,excitation-pin and avoid repetition with those. Though, that triggers=
 a
> dt_binding_check warning. Also, having mixed notation (some prop declarat=
ions
> using defines and others not) seems to not be desirable.
>=20
> It looks like the only option left is making adi,excitation-pin properties
> identical to adi,ad4130.
>=20
> On one hand, dropping adi,excitation-pin defs and making those properties
> identical to adi,ad4130 preserves their syntax and semantics accross
> dt-bindings. OTOH, we end up with more text repetition in the doc.
>=20
>=20
>  .../bindings/iio/adc/adi,ad4170.yaml          | 564 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 571 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> new file mode 100644
> index 000000000000..e3249ec56a14
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> @@ -0,0 +1,564 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4170.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4170 and similar Analog to Digital Converters
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +
> +description: |
> +  Analog Devices AD4170 series of Sigma-delta Analog to Digital Converte=
rs.
> +  Specifications can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4170-4.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4190-4.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4195-4.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +$defs:
> +  reference-buffer:
> +    description: |
> +      Enable precharge buffer, full buffer, or skip reference buffering =
of
> +      the positive/negative voltage reference. Because the output impeda=
nce
> +      of the source driving the voltage reference inputs may be dynamic,
> +      resistive/capacitive combinations of those inputs can cause DC gain
> +      errors if the reference inputs go unbuffered into the ADC. Enable
> +      reference buffering if the provided reference source has dynamic h=
igh
> +      impedance output. Note the absolute voltage allowed on REFINn+ and=
 REFINn-
> +      inputs is from AVSS - 50 mV to AVDD + 50 mV when the reference buf=
fers are
> +      disabled but narrows to AVSS to AVDD when reference buffering is e=
nabled
> +      or in precharge mode. The valid options for this property are:
> +      0: Reference precharge buffer.
> +      1: Full reference buffering.
> +      2: Bypass reference buffers (buffering disabled).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +    default: 1

Why make this property a uint32, rather than a string where you can use
something like "precharge", "full" and "bypass" (or "disabled")? The
next similar device could use something slightly different then the
binding becomes pretty clunky.
Can you explain why this is a dt property rather than something
adjustable at runtime?

Otherwise, what you have here looks sane enough to me - but I'd like to
see some comments from Jonathan or David etc about your approach to the
excitation properties.

Cheers,
Conor.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4170
> +      - adi,ad4190
> +      - adi,ad4195
> +
> +  avss-supply:
> +    description:
> +      Reference voltage supply for AVSS. If provided, describes the magn=
itude
> +      (absolute value) of the negative voltage supplied to the AVSS pin.=
 Since
> +      AVSS must be =E2=88=922.625V minimum and 0V maximum, the declared =
supply voltage
> +      must be between 0 and 2.65V. If not provided, AVSS is assumed to b=
e at
> +      system ground (0V).
> +
> +  avdd-supply:
> +    description:
> +      A supply of 4.75V to 5.25V relative to AVSS that powers the chip (=
AVDD).
> +
> +  iovdd-supply:
> +    description: 1.7V to 5.25V reference supply to the serial interface =
(IOVDD).
> +
> +  refin1p-supply:
> +    description: REFIN+ supply that can be used as reference for convers=
ion.
> +
> +  refin1n-supply:
> +    description: REFIN- supply that can be used as reference for convers=
ion. If
> +      provided, describes the magnitude (absolute value) of the negative=
 voltage
> +      supplied to the REFIN- pin.
> +
> +  refin2p-supply:
> +    description: REFIN2+ supply that can be used as reference for conver=
sion.
> +
> +  refin2n-supply:
> +    description: REFIN2- supply that can be used as reference for conver=
sion. If
> +      provided, describes the magnitude (absolute value) of the negative=
 voltage
> +      supplied to the REFIN2- pin.
> +
> +  spi-cpol: true
> +
> +  spi-cpha: true
> +
> +  interrupts:
> +    description:
> +      Interrupt for signaling the completion of conversion results. The =
data
> +      ready signal (RDY) used as interrupt is by default provided on the=
 SDO
> +      pin. Alternatively, it can be provided on the DIG_AUX1 pin in whic=
h case
> +      the chip disables the RDY function on SDO. Thus, there can be only=
 one
> +      data ready interrupt enabled at a time.
> +
> +  interrupt-names:
> +    description:
> +      Specify which pin should be configured as Data Ready interrupt.
> +    enum:
> +      - sdo
> +      - dig_aux1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Optional external clock source. Can specify either an external clo=
ck or
> +      external crystal.
> +
> +  clock-names:
> +    enum:
> +      - ext-clk
> +      - xtal
> +    default: ext-clk
> +
> +  '#clock-cells':
> +    const: 0
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +    description: |
> +      The first cell is for the GPIO number: 0 to 3.
> +      The second cell takes standard GPIO flags.
> +
> +  ldac-gpios:
> +    description:
> +      GPIO connected to DIG_AUX2 pin to be used as LDAC toggle to contro=
l the
> +      transfer of data from the DAC_INPUT_A register to the DAC.
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  adi,vbias-pins:
> +    description: Analog inputs to apply a voltage bias of (AVDD =E2=88=
=92 AVSS) / 2 to.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 9
> +    items:
> +      minimum: 0
> +      maximum: 8
> +
> +allOf:
> +  # Some devices don't have integrated DAC
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad4190
> +              - adi,ad4195
> +    then:
> +      properties:
> +        ldac-gpios: false
> +
> +  # Require to specify the interrupt pin when using interrupts
> +  - if:
> +      required:
> +        - interrupts
> +    then:
> +      required:
> +        - interrupt-names
> +
> +  # If an external clock is set, the internal clock cannot go out and vi=
ce versa
> +  - oneOf:
> +      - required: [clocks]
> +        properties:
> +          '#clock-cells': false
> +      - required: ['#clock-cells']
> +        properties:
> +          clocks: false
> +
> +patternProperties:
> +  "^channel@[0-9a-f]$":
> +    $ref: /schemas/iio/adc/adc.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description:
> +          The channel number.
> +        minimum: 0
> +        maximum: 15
> +
> +      diff-channels:
> +        description: |
> +          This property is used for defining the inputs of a differential
> +          voltage channel. The first value is the positive input and the=
 second
> +          value is the negative input of the channel.
> +
> +          Besides the analog input pins AIN0 to AIN8, there are special =
inputs
> +          that can be selected with the following values:
> +          17: Internal temperature sensor
> +          18: (AVDD-AVSS)/5
> +          19: (IOVDD-DGND)/5
> +          20: DAC output
> +          21: ALDO
> +          22: DLDO
> +          23: AVSS
> +          24: DGND
> +          25: REFIN+
> +          26: REFIN-
> +          27: REFIN2+
> +          28: REFIN2-
> +          29: REFOUT
> +          For the internal temperature sensor, use the input number for =
both
> +          inputs (i.e. diff-channels =3D <17 17>).
> +        items:
> +          enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 17, 18, 19, 20, 21, 22, 23, =
24, 25,
> +                 26, 27, 28, 29]
> +
> +      adi,reference-select:
> +        description: |
> +          Select the reference source to use when converting on the
> +          specific channel. Valid values are:
> +          0: REFIN+/REFIN-
> +          1: REFIN2+/REFIN2=E2=88=92
> +          2: REFOUT/AVSS (internal reference)
> +          3: AVDD/AVSS
> +          If not specified, REFOUT/AVSS is used.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2, 3]
> +        default: 1
> +
> +      adi,positive-reference-buffer:
> +        $ref: '#/$defs/reference-buffer'
> +
> +      adi,negative-reference-buffer:
> +        $ref: '#/$defs/reference-buffer'
> +
> +      adi,sensor-type:
> +        description:
> +          The AD4170 and similar designs have features to aid interfacin=
g with
> +          load cell weigh scale, RTD, and thermocouple sensors. Each of =
those
> +          sensor types requires either distinct wiring configuration or
> +          external circuitry for proper sensor operation and can use dif=
ferent
> +          ADC chip functionality on their setups. A key characteristic o=
f those
> +          external sensors is that they must be excited either by voltag=
e supply
> +          or by ADC chip excitation signals. The sensor can then be read=
 through
> +          a pair of analog inputs. This property specifies which particu=
lar
> +          sensor type is connected to the ADC so it can be properly setu=
p and
> +          handled. Omit this property for conventional (not weigh scale,=
 RTD, or
> +          thermocouple) ADC channel setups.
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum: [ weighscale, rtd, thermocouple ]
> +
> +      adi,excitation-pin-0:
> +        description:
> +          Analog input to apply excitation current to while the channel
> +          is active.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 20
> +        default: 0
> +
> +      adi,excitation-pin-1:
> +        description:
> +          Analog input to apply excitation current to while the channel
> +          is active.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 20
> +        default: 0
> +
> +      adi,excitation-pin-2:
> +        description:
> +          Analog input to apply excitation current to while the channel
> +          is active.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 20
> +        default: 0
> +
> +      adi,excitation-pin-3:
> +        description:
> +          Analog input to apply excitation current to while the channel
> +          is active.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 20
> +        default: 0
> +
> +      adi,excitation-current-0-microamp:
> +        description:
> +          Excitation current in microamperes to be applied to pin specif=
ied in
> +          adi,excitation-pin-0 while this channel is active.
> +        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
> +        default: 0
> +
> +      adi,excitation-current-1-microamp:
> +        description:
> +          Excitation current in microamperes to be applied to pin specif=
ied in
> +          adi,excitation-pin-1 while this channel is active.
> +        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
> +        default: 0
> +
> +      adi,excitation-current-2-microamp:
> +        description:
> +          Excitation current in microamperes to be applied to pin specif=
ied in
> +          adi,excitation-pin-2 while this channel is active.
> +        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
> +        default: 0
> +
> +      adi,excitation-current-3-microamp:
> +        description:
> +          Excitation current in microamperes to be applied to pin specif=
ied in
> +          adi,excitation-pin-3 while this channel is active.
> +        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
> +        default: 0
> +
> +      adi,excitation-ac:
> +        type: boolean
> +        description:
> +          Whether the external sensor has to be AC or DC excited. When o=
mitted,
> +          it is DC excited.
> +
> +    allOf:
> +      - oneOf:
> +          - required: [single-channel, common-mode-channel]
> +            properties:
> +              diff-channels: false
> +          - required: [diff-channels]
> +            properties:
> +              single-channel: false
> +              common-mode-channel: false
> +      # Usual ADC channels don't need external circuitry excitation.
> +      - if:
> +          not:
> +            required:
> +              - adi,sensor-type
> +        then:
> +          properties:
> +            adi,excitation-pin-0: false
> +            adi,excitation-pin-1: false
> +            adi,excitation-pin-2: false
> +            adi,excitation-pin-3: false
> +            adi,excitation-current-0-microamp: false
> +            adi,excitation-current-1-microamp: false
> +            adi,excitation-current-2-microamp: false
> +            adi,excitation-current-3-microamp: false
> +            adi,excitation-ac: false
> +      # Weigh scale bridge AC excited with one pair of predefined signal=
s.
> +      - if:
> +          allOf:
> +            - properties:
> +                adi,sensor-type:
> +                  contains:
> +                    const: weighscale
> +            - required:
> +                - adi,excitation-ac
> +                - adi,excitation-pin-2
> +                - adi,excitation-pin-3
> +            - not:
> +                required:
> +                  - adi,excitation-current-2-microamp
> +                  - adi,excitation-current-3-microamp
> +        then:
> +          properties:
> +            adi,excitation-pin-2:
> +              const: 19
> +            adi,excitation-pin-3:
> +              const: 20
> +      # Weigh scale bridge AC excited with two pairs of predefined signa=
ls.
> +      - if:
> +          allOf:
> +            - properties:
> +                adi,sensor-type:
> +                  contains:
> +                    const: weighscale
> +            - required:
> +                - adi,excitation-ac
> +                - adi,excitation-pin-0
> +                - adi,excitation-pin-1
> +                - adi,excitation-pin-2
> +                - adi,excitation-pin-3
> +            - not:
> +                required:
> +                  - adi,excitation-current-0-microamp
> +                  - adi,excitation-current-1-microamp
> +                  - adi,excitation-current-2-microamp
> +                  - adi,excitation-current-3-microamp
> +        then:
> +          properties:
> +            adi,excitation-pin-0:
> +              const: 17
> +            adi,excitation-pin-1:
> +              const: 18
> +            adi,excitation-pin-2:
> +              const: 19
> +            adi,excitation-pin-3:
> +              const: 20
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - iovdd-supply
> +  - spi-cpol
> +  - spi-cpha
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            compatible =3D "adi,ad4170";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <20000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            avdd-supply =3D <&avdd>;
> +            iovdd-supply =3D <&iovdd>;
> +            clocks =3D <&clk>;
> +            clock-names =3D "xtal";
> +            interrupts =3D <0 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names =3D "dig_aux1";
> +            adi,vbias-pins =3D <7>;
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            // Sample AIN0 with respect to DGND throughout AVDD/DGND inp=
ut range
> +            // Pseudo-differential unipolar
> +            channel@0 {
> +                reg =3D <0>;
> +                single-channel =3D <0>;
> +                common-mode-channel =3D <24>;
> +                adi,reference-select =3D <3>;
> +            };
> +            // Weigh scale sensor
> +            channel@1 {
> +                reg =3D <1>;
> +                bipolar;
> +                diff-channels =3D <1 2>;
> +                adi,reference-select =3D <0>;
> +                adi,positive-reference-buffer =3D <0>;
> +                adi,negative-reference-buffer =3D <0>;
> +                adi,sensor-type =3D "weighscale";
> +                adi,excitation-pin-2 =3D <19>;
> +                adi,excitation-pin-3 =3D <20>;
> +                adi,excitation-ac;
> +            };
> +            // RTD sensor
> +            channel@2 {
> +                reg =3D <2>;
> +                bipolar;
> +                diff-channels =3D <3 4>;
> +                adi,reference-select =3D <0>;
> +                adi,sensor-type =3D "rtd";
> +                adi,excitation-pin-0 =3D <5>;
> +                adi,excitation-pin-1 =3D <6>;
> +                adi,excitation-current-0-microamp =3D <500>;
> +                adi,excitation-current-1-microamp =3D <500>;
> +                adi,excitation-ac;
> +            };
> +            // Thermocouple sensor
> +            channel@3 {
> +                reg =3D <3>;
> +                bipolar;
> +                diff-channels =3D <7 8>;
> +                adi,reference-select =3D <0>;
> +                adi,sensor-type =3D "thermocouple";
> +                adi,excitation-pin-0 =3D <18>;
> +                adi,excitation-current-0-microamp =3D <500>;
> +            };
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            compatible =3D "adi,ad4170";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <20000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            avdd-supply =3D <&avdd>;
> +            iovdd-supply =3D <&iovdd>;
> +            #clock-cells =3D <0>;
> +            clock-output-names =3D "ad4170-clk16mhz";
> +            interrupts =3D <0 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names =3D "dig_aux1";
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            // Sample AIN0 with respect to AIN1 throughout AVDD/AVSS inp=
ut range
> +            // Differential bipolar. If AVSS < 0V, differential true bip=
olar
> +            channel@0 {
> +                reg =3D <0>;
> +                bipolar;
> +                diff-channels =3D <0 1>;
> +                adi,reference-select =3D <3>;
> +            };
> +            // Sample AIN2 with respect to DGND throughout AVDD/DGND inp=
ut range
> +            // Pseudo-differential unipolar
> +            channel@1 {
> +                reg =3D <1>;
> +                single-channel =3D <2>;
> +                common-mode-channel =3D <24>;
> +                adi,reference-select =3D <3>;
> +            };
> +            // Sample AIN3 with respect to 2.5V throughout AVDD/AVSS inp=
ut range
> +            // Pseudo-differential bipolar
> +            channel@2 {
> +                reg =3D <2>;
> +                bipolar;
> +                single-channel =3D <3>;
> +                common-mode-channel =3D <29>;
> +                adi,reference-select =3D <3>;
> +            };
> +            // Sample AIN4 with respect to DGND throughout AVDD/AVSS inp=
ut range
> +            // Pseudo-differential bipolar
> +            channel@3 {
> +                reg =3D <3>;
> +                bipolar;
> +                single-channel =3D <4>;
> +                common-mode-channel =3D <24>;
> +                adi,reference-select =3D <3>;
> +            };
> +            // Sample AIN5 with respect to 2.5V throughout AVDD/AVSS inp=
ut range
> +            // Pseudo-differential unipolar (AD4170 datasheet page 46 ex=
ample)
> +            channel@4 {
> +                reg =3D <4>;
> +                single-channel =3D <5>;
> +                common-mode-channel =3D <29>;
> +                adi,reference-select =3D <3>;
> +            };
> +            // Sample AIN6 with respect to 2.5V throughout REFIN+/REFIN-=
 input range
> +            // Pseudo-differential bipolar
> +            channel@5 {
> +                reg =3D <5>;
> +                bipolar;
> +                single-channel =3D <6>;
> +                common-mode-channel =3D <29>;
> +                adi,reference-select =3D <0>;
> +            };
> +            // Weigh scale sensor
> +            channel@6 {
> +                reg =3D <6>;
> +                bipolar;
> +                diff-channels =3D <7 8>;
> +                adi,reference-select =3D <0>;
> +                adi,sensor-type =3D "weighscale";
> +                adi,excitation-pin-0 =3D <17>;
> +                adi,excitation-pin-1 =3D <18>;
> +                adi,excitation-pin-2 =3D <19>;
> +                adi,excitation-pin-3 =3D <20>;
> +                adi,excitation-ac;
> +            };
> +        };
> +    };
> +...
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index abfd5ded8735..44735314a43e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1392,6 +1392,13 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4=
130
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>  F:	drivers/iio/adc/ad4130.c
> =20
> +ANALOG DEVICES INC AD4170 DRIVER
> +M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> +
>  ANALOG DEVICES INC AD4695 DRIVER
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> --=20
> 2.47.2
>=20

--Q50QzP2eWs4lR+kQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaFA7DQAKCRB4tDGHoIJi
0qZIAQCMKi3jOcmI4QEYQFk76p51IIFxk85ft/4pZkmWQaKSWgD9HpOUoUNx4Itb
Amh2FQrF1e9uvxVmzKfmTXRCT3e8QQg=
=7R+w
-----END PGP SIGNATURE-----

--Q50QzP2eWs4lR+kQ--

