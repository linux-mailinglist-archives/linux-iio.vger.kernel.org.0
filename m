Return-Path: <linux-iio+bounces-13639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0C89F7CCA
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 15:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C162D188A37A
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 14:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AE32253ED;
	Thu, 19 Dec 2024 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLHpXOxe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E4224AEB;
	Thu, 19 Dec 2024 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734617039; cv=none; b=LZ0fxj3xPUiq8Dvq3UZAURCdlzTNTi9jsu8P9VrCSRcVxcT/bkg7RDX33c0CUZUak281aG2mc7G/1RPLCRV2CwZ4FX3PF/dc34lu2TJZIXAmyEszir2G/MHGKokDs7aLNmeuPz1cwqP9RkcMu06d2nrZ/NNyCblqFIe876dt4bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734617039; c=relaxed/simple;
	bh=ZibmLPWJyJMHYifJwD7ZshqSmF9mPrw0110BNGzkPL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghFfyCICcSHld+CPVb9NTZVWWjsGqil+aHnsTuTFZMdXPlVu2pU2ftCJ73MuR64eZnyoY5Y3cQF1OWOVc8jVxWmuR+nLqchM5zsOHlHzlmlwqf5xK20szHZw9hgTVJwBn7bPIPICrSGzEG93tqmUIXMeQt6MsGfuD4qrgtfCHYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLHpXOxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D370C4CECE;
	Thu, 19 Dec 2024 14:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734617039;
	bh=ZibmLPWJyJMHYifJwD7ZshqSmF9mPrw0110BNGzkPL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uLHpXOxe7gWkTh28Fn3K6pxYnS66ha1oah8n6srLLmSJzxxH9dqX5mH382RuVwzCn
	 ttKlY8hYDfHTFLreObhXZghyLbYyHhNOJjWXOVIsp4TUdUTcIvwzYMzJfDS0y2Q1rQ
	 fjOOBmSX5qKqcq5YKFMIzgrn5jjJ/LvXZMeRIilCVDRIGa6GXqPSWjU7y+W4BFHoVQ
	 pTzsr6xsPaxNyCxI9eI58xMvRlYFt0jUfqH+2YQXwAbl0KIRF5cqyLkz2SwiXEnIWn
	 HN6gKyT20wfn95jlnOsUifOk4dgnE9QoFT2CZdC2OoLDC63yg1uw8pRZW9TLaW1GRk
	 swLpT1/sWeJAA==
Date: Thu, 19 Dec 2024 14:03:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <ana-maria.cusco@analog.com>,
 <marcelo.schmitt1@gmail.com>
Subject: Re: [RFC PATCH 2/4] dt-bindings: iio: adc: Add AD4170
Message-ID: <20241219140353.787ffccc@jic23-huawei>
In-Reply-To: <caadb73da62e80877eab8b0287d996b52266d912.1734530280.git.marcelo.schmitt@analog.com>
References: <cover.1734530280.git.marcelo.schmitt@analog.com>
	<caadb73da62e80877eab8b0287d996b52266d912.1734530280.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Dec 2024 11:37:42 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add device tree documentation for AD4170 sigma-delta ADCs.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad4170.yaml          | 473 ++++++++++++++++++
>  1 file changed, 473 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> new file mode 100644
> index 000000000000..8c5defc614ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> @@ -0,0 +1,473 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4170.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4170 Analog to Digital Converter
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +
> +description: |
> +  Analog Devices AD4170 Analog to Digital Converter.
> +  Specifications can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4170-4.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4170
> +
> +  avss-supply:
> +    description:
> +      Referece voltage supply for AVDD. AVSS can be set below 0V to prov=
ide a
> +      bipolar power supply to AD4170-4. Must be =E2=88=922.625V at minim=
um, 0V maximum.
> +      If not specified, this is assumed to be analog ground.
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
ion.
> +
> +  refin2p-supply:
> +    description: REFIN2+ supply that can be used as reference for conver=
sion.
> +
> +  refin2n-supply:
> +    description: REFIN2- supply that can be used as reference for conver=
sion.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: |
> +      Optional external clock source. Can include one clock source: exte=
rnal
> +      clock or external crystal.
> +
> +  clock-names:
> +    enum:
> +      - ext-clk
> +      - xtal
> +
> +  '#clock-cells':
> +    const: 0
> +
> +  adi,gpio0-power-down-switch:
> +    type: boolean
> +    description:
> +      Describes whether GPIO0 is used as a switch to disconnect bridge c=
ircuits
> +      from AVSS. Pin defaults to GPIO if this property is not present.

This is interesting because it's power control for external bridges.=20
Maybe should be described as a regulator (output)?  Any bridge circuit will=
 need to be
an IIO consumer anyway so we can work out the channel scaling so that would=
 then
consume this regulator as it's power supply.

> +
> +  adi,gpio1-power-down-switch:
> +    type: boolean
> +    description:
> +      Describes whether GPIO1 is used as a switch to disconnect bridge c=
ircuits
> +      from AVSS. Pin defaults to GPIO if this property is not present.
> +
> +  adi,vbias-pins:
> +    description: Analog inputs to apply a voltage bias of (AVDD =E2=88=
=92 AVSS) / 2 to.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

This is described as being relevant if we have say a thermocouple wired up.
For that I'd expect it to both be channel specific and us to need a bunch o=
f other
description.

> +    minItems: 1
> +    maxItems: 9
> +    items:
> +      minimum: 0
> +      maximum: 8
> +
> +  adi,dig-aux1:

If it's a data ready signal, then interrupt/ interrupt-names probably
appropriate.

Sync is messier as you need a binding to describe where that goes but we ha=
ve
provided a specific property for this in the past. Try to match up with an =
existing
one. Trickier as there are multiple of these here.


The high impedance is what you do if not an interrupt and the sync out not =
set.

> +    description:
> +      Describes whether DIG_AUX1 pin will operate as data ready output,
> +      synchronization output signal (SYNC_OUT), or if it will be disable=
d.
> +      A value of 0 indicates DIG_AUX1 pin disabled. High impedance.
> +      A value of 1 indicates DIG_AUX1 is configured as ADC data ready ou=
tput.
> +      A value of 1 indicates DIG_AUX1 is configured as SYNC_OUT output.
> +      If this property is absent, DIG_AUX1 pin is disabled.
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    enum: [0, 1, 2]
> +    default: 0
> +
> +  adi,dig-aux2:
> +    description:
> +      Describes whether DIG_AUX2 pin will function as DAC LDAC input,
> +      synchronization start input (START), or if it will be disabled.
> +      A value of 0 indicates DIG_AUX2 pin is disabled. High impedance.
> +      A value of 1 indicates DIG_AUX2 pin is configured as active-low LD=
AC input
> +      for the DAC.
> +      A value of 2 indicates DIG_AUX2 pin is configured as START input.

Ah. the other side of sync.
Also DAC toggle pin. If we are using it as a dac toggle, needs a gpio bindi=
ng.
Start will need a specific property.  High impedance is what we do if the o=
thers
not set.

> +      If this property is absent, DIG_AUX2 pin is disabled.
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    enum: [0, 1, 2]
> +    default: 0
> +
> +  adi,sync-option:
> +    description:
> +      Describes how ADC conversions are going to be synchronized. A valu=
e of 1
> +      indicates the SYNC_IN pin will function as a synchronization input=
 that
> +      allows the user to control the start of sampling by pulling SYNC_I=
N high.
> +      Use option number 2 to set the alternate synchronization functiona=
lity
> +      which allows per channel conversion start control when multiple ch=
annels
> +      are enabled. Option number 0 disables synchronization.
> +      A value of 0 indicates no synchronization. SYNC_IN pin disabled.
> +      A value of 1 indicates standard synchronization functionality.
> +      A value of 2 indicates alternate synchronization functionality.

This is a software choice.  I can't see why it belongs in DT unless
the assumption is some external timing circuitry is driving this.
To actually control mode 2 timing would be interesting as doesn't correspond
to triggering etc in iio which is matching standard synchronization assuming
I got right idea from quick read of the datasheet section on this).

> +      If this property is absent, no synchronization is performed.

Inconsistent with default.

> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    enum: [0, 1, 2]
> +    default: 1
> +

All the bridge related excitation control etc makes me wonder if we need
a way to describe the bridge rather than the modes of this device.
I can't immediately see how to do it though as I'm not sure this stuff
is that standard across devices.

> +  adi,excitation-pin-0:
> +    description: |
> +      Specifies the pin to apply excitation current 0 (IOUT0). Besides t=
he
> +      analog pins 0 to 8, the excitation current can be applied to GPIO =
pins.

Add some flavour for this.  What is it for?  Basically make a clear argument
it is all about the external circuitry.

> +      17: Output excitation current IOUT0 to GPIO0.
> +      18: Output excitation current IOUT0 to GPIO1.
> +      19: Output excitation current IOUT0 to GPIO2.
> +      20: Output excitation current IOUT0 to GPIO3.
> +      If this property is absent, IOUT0 is not routed to any pin.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 17, 18, 19, 20]
> +    default: 0
> +
> +  adi,excitation-pin-1:
> +    description: |
> +      Specifies the pin to apply excitation current 1 (IOUT1). Besides t=
he
> +      analog pins 0 to 8, the excitation current can be applied to GPIO =
pins.
> +      17: Output excitation current IOUT1 to GPIO0.
> +      18: Output excitation current IOUT1 to GPIO1.
> +      19: Output excitation current IOUT1 to GPIO2.
> +      20: Output excitation current IOUT1 to GPIO3.
> +      If this property is absent, IOUT1 is not routed to any pin.

Default doesn't make much sense if that is intent. Just drop it.

Maybe see if there is a sensible path to sharing the text for these
given repitition.  If they were always there I'd suggest
an array, but we need the 'not in use' value and magic
numbers for that are nasty.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 17, 18, 19, 20]
> +    default: 0
> +
> +  adi,excitation-pin-2:
> +    description: |
> +      Specifies the pin to apply excitation current 2 (IOUT2). Besides t=
he
> +      analog pins 0 to 8, the excitation current can be applied to GPIO =
pins.
> +      17: Output excitation current IOUT2 to GPIO0.
> +      18: Output excitation current IOUT2 to GPIO1.
> +      19: Output excitation current IOUT2 to GPIO2.
> +      20: Output excitation current IOUT2 to GPIO3.
> +      If this property is absent, IOUT2 is not routed to any pin.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 17, 18, 19, 20]
> +    default: 0
> +
> +  adi,excitation-pin-3:
> +    description: |
> +      Specifies the pin to apply excitation current 3 (IOUT3). Besides t=
he
> +      analog pins 0 to 8, the excitation current can be applied to GPIO =
pins.
> +      17: Output excitation current IOUT3 to GPIO0.
> +      18: Output excitation current IOUT3 to GPIO1.
> +      19: Output excitation current IOUT3 to GPIO2.
> +      20: Output excitation current IOUT3 to GPIO3.
> +      If this property is absent, IOUT3 is not routed to any pin.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 17, 18, 19, 20]
> +    default: 0
> +
> +  adi,excitation-current-0-microamp:
> +    description: |
> +      Excitation current in microamps to be applied to IOUT0 output pin
> +      specified in adi,excitation-pin-0.

As above, see if you can combine entries and add a bit of flavour on the wh=
y.

> +    enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
> +    default: 0
> +
> +  adi,excitation-current-1-microamp:
> +    description: |
> +      Excitation current in microamps to be applied to IOUT1 output pin
> +      specified in adi,excitation-pin-1.
> +    enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
> +    default: 0
> +
> +  adi,excitation-current-2-microamp:
> +    description: |
> +      Excitation current in microamps to be applied to IOUT2 output pin
> +      specified in adi,excitation-pin-2.
> +    enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
> +    default: 0
> +
> +  adi,excitation-current-3-microamp:
> +    description: |
> +      Excitation current in microamps to be applied to IOUT3 output pin
> +      specified in adi,excitation-pin-3.
> +    enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
> +    default: 0
> +
> +  adi,chop-iexc:
> +    description: |
> +      Specifies the chopping/swapping functionality for excitation curre=
nts.
> +      0: No Chopping of Excitation Currents.
> +      1: Chop/swap IOUT0 and IOUT1 (pair AB) excitation currents.
> +      2: Chop/swap IOUT2 and IOUT3 (pair CD) excitation currents.
> +      3: Chop/swap both pairs (pair AB and pair CD) of excitation curren=
ts.
> +      If this property is absent, no chopping is performed.
> +      There are macros for the above values in dt-bindings/iio/adi,ad417=
0.h.
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    enum: [0, 1, 2, 3]
> +    default: 0
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel@([0-9]|1[0-5])$":
> +    $ref: adc.yaml
> +    type: object
> +    unevaluatedProperties: false
> +    description: |
> +      Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. The device can have up to 16 channels numb=
ered
> +          from 0 to 15.
> +        items:
> +          minimum: 0
> +          maximum: 15
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
> +            17: Temperature sensor input

I guess we can't stop this being set to silly value (so one side of tempera=
ture
against anything else).

> +            18: (AVDD-AVSS)/5
> +            19: (IOVDD-DGND)/5
> +            20: DAC output
> +            21: ALDO
> +            22: DLDO
> +            23: AVSS
> +            24: DGND
> +            25: REFIN+
> +            26: REFIN-
> +            27: REFIN2+
> +            28: REFIN2-
> +            29: REFOUT

Most of these are typically used for calibration. I'd be tempted to drop th=
em
from the channel configuration.  Or maybe keep them also provide a way to o=
verride
and set these up anyway as needed.

> +
> +          There are macros for those values in dt-bindings/iio/adi,ad417=
0.h.
> +
> +        items:
> +          minimum: 0
> +          maximum: 31

Use an enum.  We don't want the reserved values.

> +
> +      single-channel: true
> +
> +      common-mode-channel: true
> +
> +      bipolar: true
> +
> +      adi,config-setup-number:
> +        description: |
> +          Specifies which of the 8 setups are used to configure the chan=
nel.
> +          A setup comprises of: AFE, FILTER, FILTER_FS, MISC, OFFSET, an=
d GAIN
> +          registers. More than one channel can use the same configuratio=
n setup
> +          number in which case they will share the settings of the above
> +          mentioned registers.

We have always done this in the driver previously.  It can be complex due to
need to match equivalent configs, but most of this is stuff we want
to control.  It doesn't lead to simple code, but it does give a lot of flex=
ibility
as things like filters and gains etc are not characteristics of the externa=
l wiring
(though good choices are related to it).


> +        items:
> +          minimum: 0
> +          maximum: 7
> +
> +      adi,chop-adc:
> +        description: |
> +          Specifies the chopping/swapping functionality for a channel se=
tup.
> +          Macros for adi,chop-adc values are available in
> +          dt-bindings/iio/adi,ad4170.h. When enabled, the analog inputs =
are
> +          continuously swapped and a conversion is generated for each ti=
me a
> +          swap occurs. The analog input pins are connected in one direct=
ion,
> +          sampled, swapped, sampled again, and then the conversion resul=
ts are
> +          averaged. The input swap minimizes system offset and offset dr=
ift.
> +          This property also specifies whether AC excitation using 2 or =
4 GPIOs
> +          are going to be used.
> +          0: No channel chop.
> +          1: Chop/swap the channel inputs.
> +          2: AC Excitation using 4 GPIOs.
> +          3: AC Excitation using 2 GPIOs.
> +          If this property is absent, no chopping is performed.
> +        $ref: /schemas/types.yaml#/definitions/uint16
> +        enum: [0, 1, 2, 3]
> +        default: 0
> +
> +      adi,burnout-current-nanoamp:
> +        description: |
> +          Current in nanoamps to be applied for this channel. Burnout cu=
rrents
> +          are only active when the channel is selected for conversion.

All about open wire detection.  So a runtime configuration thing. =20

> +        enum: [0, 100, 2000, 10000]
> +        default: 0
> +
> +      adi,buffered-negative:
> +        description: Enable precharge buffer, full buffer, or skip refer=
ence
> +          buffering of the negative voltage reference. Because the output
> +          impedance of the source driving the voltage reference inputs m=
ay be
> +          dynamic, RC combinations of those inputs can cause DC gain err=
ors if
> +          the reference inputs go unbuffered into the ADC. Enable refere=
nce
> +          buffering if the provided reference source has dynamic high im=
pedance
> +          output.

Say why you would not enable it

> +        enum: [0, 1, 2]

Value meanings?

> +        default: 0
> +
> +      adi,buffered-positive:
Probably put positive first. Feels more natural!
> +        description: Enable precharge buffer, full buffer, or skip refer=
ence
> +          buffering of the positive voltage reference. Because the output
> +          impedance of the source driving the voltage reference inputs m=
ay be
> +          dynamic, RC combinations of those inputs can cause DC gain err=
ors if
> +          the reference inputs go unbuffered into the ADC. Enable refere=
nce
> +          buffering if the provided reference source has dynamic high im=
pedance
> +          output.
> +        enum: [0, 1, 2]
> +        default: 0
> +
> +      adi,reference-select:
> +        description: |
> +          Select the reference source to use when converting on the spec=
ific
> +          channel. Valid values are:
> +          0: Differential reference voltage REFIN+ - REFIN=E2=88=92.
> +          1: Differential reference voltage REFIN2+ - REFIN2=E2=88=92.
> +          2: Internal 2.5V referece (REFOUT) relative to AVSS.
> +          3: Analog supply voltage (AVDD) relative relative AVSS.
> +          If this field is left empty, the internal reference is selecte=
d.

There is an argument that this might be something you want to change at run=
time
but it's pretty unlikely so I'm fine with this in DT.

Hmm. I'm not a fan of trying to review these AFE + bridge supporting ADCs.
So fiddly and with so many weird options that only make sense if I dig out
my memory of analog circuits courses from years ago :(

Jonathan


> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        enum: [0, 1, 2, 3]
> +        default: 2
> +
> +    required:
> +      - reg
> +      - adi,config-setup-number
> +
> +    allOf:
> +      - oneOf:
> +          - required: [single-channel]
> +            properties:
> +              diff-channels: false
> +          - required: [diff-channels]
> +            properties:
> +              single-channel: false
> +              common-mode-channel: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - iovdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/iio/adc/adi,ad4170.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            compatible =3D "adi,ad4170";
> +            reg =3D <0>;
> +            avdd-supply =3D <&avdd>;
> +            iovdd-supply =3D <&iovdd>;
> +            spi-max-frequency =3D <20000000>;
> +            interrupt-parent =3D <&gpio_in>;
> +            interrupts =3D <0 IRQ_TYPE_EDGE_FALLING>;
> +            adi,dig-aux1 =3D /bits/ 8 <1>;
> +            adi,dig-aux2 =3D /bits/ 8 <0>;
> +            adi,sync-option =3D /bits/ 8 <0>;
> +            adi,excitation-pin-0 =3D <19>;
> +            adi,excitation-current-0-microamp =3D <10>;
> +            adi,excitation-pin-1 =3D <20>;
> +            adi,excitation-current-1-microamp =3D <10>;
> +            adi,chop-iexc =3D /bits/ 8 <1>;
> +            adi,vbias-pins =3D <5 6>;
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            // Sample AIN0 with respect to AIN1 throughout AVDD/AVSS inp=
ut range
> +            // Fully differential. If AVSS < 0V, Fully differential true=
 bipolar
> +            channel@0 {
> +                reg =3D <0>;
> +                bipolar;
> +                diff-channels =3D <AD4170_MAP_AIN0 AD4170_MAP_AIN1>;
> +                adi,config-setup-number =3D <0>;
> +                adi,reference-select =3D /bits/ 8 <3>;
> +                adi,burnout-current-nanoamp =3D <100>;
> +            };
> +            // Sample AIN2 with respect to DGND throughout AVDD/DGND inp=
ut range
> +            // Peseudo-differential unipolar (fig. 2a)
> +            channel@1 {
> +                reg =3D <1>;
> +                single-channel =3D <AD4170_MAP_AIN2>;
> +                common-mode-channel =3D <AD4170_MAP_DGND>;
> +                adi,config-setup-number =3D <1>;
> +                adi,reference-select =3D /bits/ 8 <3>;
> +            };
> +            // Sample AIN3 with respect to 2.5V throughout AVDD/AVSS inp=
ut range
> +            // Pseudo-differential bipolar (fig. 2b)
> +            channel@2 {
> +                reg =3D <2>;
> +                bipolar;
> +                single-channel =3D <AD4170_MAP_AIN3>;
> +                common-mode-channel =3D <AD4170_MAP_REFOUT>;
> +                adi,config-setup-number =3D <2>;
> +                adi,reference-select =3D /bits/ 8 <3>;
> +            };
> +            // Sample AIN4 with respect to DGND throughout AVDD/AVSS inp=
ut range
> +            // Pseudo-differential true bipolar if AVSS < 0V (fig. 2c)
> +            channel@3 {
> +                reg =3D <3>;
> +                bipolar;
> +                single-channel =3D <AD4170_MAP_AIN4>;
> +                common-mode-channel =3D <AD4170_MAP_DGND>;
> +                adi,config-setup-number =3D <3>;
> +                adi,reference-select =3D /bits/ 8 <3>;
> +            };
> +            // Sample AIN5 with respect to 2.5V throughout AVDD/REFOUT i=
nput range
> +            // Pseudo-differential unipolar (AD4170 datasheet page 46 ex=
ample)
> +            channel@4 {
> +                reg =3D <4>;
> +                single-channel =3D <AD4170_MAP_AIN5>;
> +                common-mode-channel =3D <AD4170_MAP_REFOUT>;
> +                adi,config-setup-number =3D <4>;
> +                adi,reference-select =3D /bits/ 8 <2>;
> +            };
> +            // Sample AIN6 with respect to REFIN+ throughout AVDD/AVSS i=
nput range
> +            // Pseudo-differential unipolar
> +            channel@5 {
> +                reg =3D <5>;
> +                single-channel =3D <AD4170_MAP_AIN6>;
> +                common-mode-channel =3D <AD4170_MAP_REFIN1_P>;
> +                adi,config-setup-number =3D <4>;
> +                adi,reference-select =3D /bits/ 8 <2>;
> +            };
> +            // Sample AIN7 with respect to DGND throughout REFIN+/REFIN-=
 input range
> +            // Pseudo-differential bipolar
> +            channel@6 {
> +                reg =3D <6>;
> +                bipolar;
> +                diff-channels =3D <AD4170_MAP_AIN7 AD4170_MAP_DGND>;
> +                adi,config-setup-number =3D <5>;
> +                adi,reference-select =3D /bits/ 8 <0>;
> +            };
> +        };
> +    };
> +...
> +


