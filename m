Return-Path: <linux-iio+bounces-7760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2342693823F
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 19:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4C3281CB0
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4BC1474DA;
	Sat, 20 Jul 2024 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjHdkeVx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F43372;
	Sat, 20 Jul 2024 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721495407; cv=none; b=OYSKCZMh9q0FYgWgjq3YH4CJ6eIpstQ1QQ4ocNTc+EAHoTdo8MkLwUP4SoPS4tNXicDznYnvrsd3ZPvVwdW8rCJf7KS6iKrJv4Ca/lavuiG9Jat4zSmAi0IJDWwyC6L/UoG6lpffHuzDat2IMq3BgF1mQKVT1+iFARCtFyOIVqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721495407; c=relaxed/simple;
	bh=CFrSdp9lLtd/lPFcuRMQ+Pi/13dsyBIxk8CF5fsmOMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INaDKWNR9x/rJZe9K9Cu/VAZBrU0nc6dYmaSjU/q4+dDeoiaHkVr0AQDyTjzdkWd3xO0q3YYn0+4Npb+oyhlj3Caw7np5h/HDOOZQffydE3TzVF/8wsUmISPX/9G9Ww0iSLDhu/vfyNa7n2NrpNJcq1E+y31T2tFzLEvR1Fqv3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjHdkeVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD97C2BD10;
	Sat, 20 Jul 2024 17:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721495406;
	bh=CFrSdp9lLtd/lPFcuRMQ+Pi/13dsyBIxk8CF5fsmOMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UjHdkeVxqI4N0kn16tmORzpNwma5jfApL7TT+YUEHZyydwpCYrAhhP8W9/H0zVF/+
	 7uzSmPb3RLmdhGZ5G+PIFiEYA7ylhATQTUQoM46NSgD6BgGtTETKFDtHvzn5TY+q7p
	 Tz4u4hB8vgUOTjvhlJuT12Bg4TkuzsfVfqJCMxkWBLajUyVDu9yP61Aa64TybT1GeF
	 wThq2Z9tZ7bf4PbfRsdLtSfPJ+vo/DEzMbgWK2q0mbeM2J5+9GD8oudHFlpfR0DeZ0
	 lRJn+gy5avfWQeBdABBBV+9r+J37A87v8ZdndqpKcDvzSjwe+iu6XlN7Rq3uimwDMW
	 ZokR7ttRGMN/w==
Date: Sat, 20 Jul 2024 18:09:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <marius.cristea@microchip.com>
Cc: <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: adding support for
 PAC194X
Message-ID: <20240720180959.23540945@jic23-huawei>
In-Reply-To: <20240719173855.53261-2-marius.cristea@microchip.com>
References: <20240719173855.53261-1-marius.cristea@microchip.com>
	<20240719173855.53261-2-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jul 2024 20:38:54 +0300
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the device tree schema for iio driver for
> Microchip PAC194X and PAC195X series of Power Monitors with Accumulator.
Hi Marius

Good to add a tiny bit either here or in below description for why
there are so many part numbers.

Looks like mixture of number of channels and high vs low side monitors.
And the big number is about voltage range?

Other comments inline.

Thanks,
Jonathan

> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  .../bindings/iio/adc/microchip,pac1944.yaml   | 168 ++++++++++++++++++
>  1 file changed, 168 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
> new file mode 100644
> index 000000000000..e997a4d536e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
> @@ -0,0 +1,168 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/microchip,pac1944.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PAC1944 and PAC1954 Power Monitors with Accumulator
> +
> +maintainers:
> +  - Marius Cristea <marius.cristea@microchip.com>
> +
> +description: |
> +  This device is part of the Microchip family of Power Monitors with Accumulator.
> +  The datasheet for PAC1941_1, PAC1941_1, PAC1942_1, PAC1942_2, PAC1943_1 and PAC1944_1 can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC194X-Family-Data-Sheet-DS20006543.pdf
> +  The datasheet for PAC1951_1, PAC1951_1, PAC1952_1, PAC1952_2, PAC1953_1 and PAC1954_1 can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC195X-Family-Data-Sheet-DS20006539.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,pac1941_1
> +      - microchip,pac1941_2
> +      - microchip,pac1942_1
> +      - microchip,pac1942_2
> +      - microchip,pac1943_1
> +      - microchip,pac1944_1
> +      - microchip,pac1951_1
> +      - microchip,pac1951_2
> +      - microchip,pac1952_1
> +      - microchip,pac1952_2
> +      - microchip,pac1953_1
> +      - microchip,pac1954_1
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  interrupts:
> +    maxItems: 2
Need names as annoyingly people often wire just the second one
(I've never understood why!)

> +
> +  slow-io-gpios:
> +    description:
> +      A GPIO used to trigger a change is sampling rate (lowering the chip power
> +      consumption). If configured in SLOW mode, if this pin is forced high,
> +      sampling rate is forced to eight samples/second. When it is forced low,
> +      the sampling rate is 1024 samples/second unless a different sample rate
> +      has been programmed.
> +
> +  microchip,gpio:
> +    type: boolean
> +    description:
> +      In default mode, this pin is a GPIO input pin. It can be
> +      configured to be an output pin, as well as the ALERT2
> +      function. This pin is an open-drain configuration and
> +      needs a pull-up resistor to VDD.

This one is a bit odd.
Can we do that configuration based on whether anyone requests it
or if it is wired as alert2?

So I don't think we should need this binding, but we may need
the stuff to provide a gpio.


Also, oddly short wrap.



> +
> +patternProperties:
> +  "^channel@[1-4]+$":
> +    type: object
> +    $ref: adc.yaml
> +    description:
> +      Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        items:
> +          minimum: 1
> +          maximum: 4
> +
> +      shunt-resistor-micro-ohms:
> +        description:
> +          Value in micro Ohms of the shunt resistor connected between
> +          the SENSE+ and SENSE- inputs, across which the current is measured.
> +          Value is needed to compute the scaling of the measured current.
> +
> +      microchip,vbus-mode:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The VBUS could be configured into the following full scale range (FSR)
Key with these range things is to make it clear why they are a wiring thing
rather than something userspace should control.  Perhaps you can add
some detail on that here?

> +            <0>  -  VBUS has unipolar +32V to 0V FSR (default)
> +            <1>  -  VBUS has bipolar +32V to -32V FSR
> +            <2>  -  VBUS has bipolar +16V to -16V FSR
> +        maximum: 2
> +
> +      microchip,vsense-mode:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The VSENSE could be configured into the following full scale range (FSR)
> +            <0>  -  VSENSE has unipolar +100 mV to 0V FSR (default)
> +            <1>  -  VSENSE has bipolar +100 mV to -100 mV FSR
> +            <2>  -  VSENSE has bipolar +50 mV to -50 mV FSR
> +        maximum: 2
> +
> +      microchip,accumulation-mode:
> +        $ref: /schemas/types.yaml#/definitions/uint32
Why is this a hardware thing? Is it specific to particular wiring?
Not sure this one belong in DT.

> +        description:
> +          The Hardware Accumulator could be configured to accumulate
> +          VPOWER, VSENSE or VBUS
> +            <0>  -  Accumulator accumulates VPOWER (default)
> +            <1>  -  Accumulator accumulates VSENSE
Add some info on what this is for (charge measurement)
Thankfully there is a nice section on why you'd want to do this in the datasheet
as only the power option made sense to me.
There is a nice statement that you might do this as an extreme form
of oversampling as well.

> +            <2>  -  Accumulator accumulates VBUS


> +        maximum: 2
> +
> +    required:
> +      - reg
> +      - shunt-resistor-micro-ohms
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
Basic power supplies should always be here as chips tend not to run without
power.  Note that doesn't mean a dts needs to actually list them if they are always
on as the regulator framework will provide stubs etc.

Jonathan



