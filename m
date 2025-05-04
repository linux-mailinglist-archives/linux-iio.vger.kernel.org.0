Return-Path: <linux-iio+bounces-19047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C20AA8783
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 18:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D3AB7A1E9A
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD19E19E98A;
	Sun,  4 May 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7vi6/we"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FCA746E;
	Sun,  4 May 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746374509; cv=none; b=BO8qvpunc9ump9clwPgPbkQsfXObWhbhSynmkdhegTUpMVTc63eeFAghuOT5xEHZ8p/b8F2dO492ifbm6flw0Mito3INEcAvuCHSqvJppEVmMtFUPMkMDfSDtOscHDXvTrPkUcIqQBG2fAg/rO6LPIdKdQL+vvCLSj6C4m3uhIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746374509; c=relaxed/simple;
	bh=lsT3ngYMzP3i8pLWi4LFabfKYm9YDJNVe7Nwv4FM0iw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQGFj1j85/xY2L9n3bZnYxs4N3Qu07tIkCdv1WM47ZD70i+9u7jVnitb4356JC5OynPii+WfqyEeypcxw1Uw6nG+SH+SCALWF06T739ka4Fpj91ViUV1rlwQYCpQtAESz2zXBOLoHoXNJF6ghb+JHd7LQg6bFdo0c8x+Q9T7VrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7vi6/we; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45D1C4CEE7;
	Sun,  4 May 2025 16:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746374509;
	bh=lsT3ngYMzP3i8pLWi4LFabfKYm9YDJNVe7Nwv4FM0iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A7vi6/werry32uMRySqF0WcxqQGvfvmzcr/K6d9iE2pWfSnO5Cxl4SGkQ/UmAfP2D
	 aBAK5mk5xZdNaI5KqAOsfcLnwJ8dPG6nXXQLDeG+88kWyt3fSpYcsqqdSmSPZYBlTY
	 SJrc885Csl44SEhFG+0PrUFJfG2nxm6YDJodHXbBNEUCQMJw27kxKICt08Xp52Zl7T
	 5jXh2UA9QmJJY+sV1kbN1LXnMF55xJ1x4Q3KfKlUjMR1j0TcexBQwWSB9NP25/BhxJ
	 ebJMlY97d0HY2Qscbq/uDhY2qyXiVMI1FUvzSGkZE5ORoNbTbyDB8aS1HPkKnFzQWX
	 qBw61mrFJ5Qew==
Date: Sun, 4 May 2025 17:01:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sayyad Abid <sayyad.abid16@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, javier.carrasco.cruz@gmail.com,
 olivier.moysan@foss.st.com, gstols@baylibre.com, tgamblin@baylibre.com,
 alisadariana@gmail.com, eblanc@baylibre.com, antoniu.miclaus@analog.com,
 andriy.shevchenko@linux.intel.com, stefan.popa@analog.com,
 ramona.gradinariu@analog.com, herve.codina@bootlin.com,
 tobias.sperling@softing.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] dt-bindings: iio: adc: add bindings for TI
 ADS1262
Message-ID: <20250504170135.578df43e@jic23-huawei>
In-Reply-To: <20250501100043.325423-6-sayyad.abid16@gmail.com>
References: <20250501100043.325423-1-sayyad.abid16@gmail.com>
	<20250501100043.325423-6-sayyad.abid16@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 May 2025 15:30:43 +0530
Sayyad Abid <sayyad.abid16@gmail.com> wrote:

> Add the Device Tree binding documentation for the Texas Instruments ADS1262 ADC.
> 
> Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
Hi Sayyad,

A few additional comments from me.

Jonathan

> ---
>  .../bindings/iio/adc/ti,ads1262.yaml          | 189 ++++++++++++++++++
>  1 file changed, 189 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
> new file mode 100644
> index 000000000000..8c4cc2cf6467
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
> @@ -0,0 +1,189 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1262.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments' ADS1262 32-Bit Analog to Digital Converter
> +
> +maintainers:
> +  - Sayyad Abid <sayyad.abid16@gmail.com>
> +
> +description: |
> +  Texas Instruments ADS1262 32-Bit Analog to Digital Converter with,
> +  internal temperature sensor, GPIOs and PGAs
> +
> +  The ADS1262 is a 32-bit, 38-kSPS, precision ADC with a programmable gain
> +  amplifier (PGA) and internal voltage reference. It features:
> +  - 11 single-ended or 5 differential input channels
> +  - Internal temperature sensor
> +  - Programmable gain amplifier (PGA) with gains from 1 to 32
> +  - Internal voltage reference
> +  - GPIO pins for control and monitoring
> +  - SPI interface
> +
> +  Specifications about the part can be found at:
> +  https://www.ti.com/product/ADS1262
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads1262
> +
> +  reg:
> +    maxItems: 1
> +    description: SPI chip select number
> +
> +  spi-max-frequency:
> +    maximum: 7372800
> +    description: Maximum SPI clock frequency in Hz (7.3728 MHz)
> +
> +  spi-cpha:
> +    type: boolean
> +    description: Required for SPI mode 1 operation
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO specifier for the reset pin (active low)
> +
> +  vref-supply:
> +    description: |
> +      The regulator supply for ADC reference voltage. If not specified,
> +      the internal 2.5V reference will be used.
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +  ti,pga-bypass:
> +    type: boolean
> +    description: |
> +      If true, bypass the PGA. If false or not specified, PGA is enabled.

Why do we want to support this?  If we do, why is it a wiring thing (so suitable
for DT) rather than a runtime configuration thing. e.g. If I set the scale to
1 does that mean I can bypass the PGA?

> +
> +  ti,data-rate:
As has been commented, this is a userspace thing to control, not
something we should get from DT.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 15
> +    description: |
> +      Data acquisition rate in samples per second
> +      0: 2.5
...

> +
> +patternProperties:
> +  "^channel@([0-9]|1[0-1])$":
> +    type: object
> +    additionalProperties: false
> +    description: |
> +      Represents the external channels which are connected to the ADC.
> +      Channels 0-9 are available for external signals, channel 10 is AINCOM,
> +      and channel 11 is the internal temperature sensor.
> +
> +    properties:

Should reference adc.yaml which will provide much of the basic per channel stuff
and ensure standard formats etc.

> +      reg:
> +        description: |
> +          Channel number. It can have up to 10 channels numbered from 0 to 9,
> +          channel 10 is AINCOM, and channel 11 is the internal temperature sensor.
> +        items:
> +          - minimum: 0
> +            maximum: 11
> +
> +      diff-channels:
> +        description: |
> +          List of two channel numbers for differential measurement.
> +          First number is positive input, second is negative input.
> +          Not applicable for temperature sensor (channel 11).
> +        items:
> +          - minimum: 0
> +            maximum: 9
> +          - minimum: 0
> +            maximum: 9
> +
> +      ti,gain:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 5
> +        description: |
> +          PGA gain setting. Not applicable for temperature sensor (channel 11).

Looks like a userspace thing rather than a DT one.

> +          0: 1 (default)
> +          1: 2
> +          2: 4
> +          3: 8
> +          4: 16
> +          5: 32
> +
> +    required:
> +      - reg
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ads1262: adc@0 {
> +        compatible = "ti,ads1262";
> +        reg = <0>;
> +        spi-max-frequency = <7372800>;
> +        vref-supply = <&adc_vref>;
> +        spi-cpha;
> +        reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> +        ti,pga-bypass;
> +        ti,data-rate = <15>; /* 38400 SPS */
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #io-channel-cells = <1>;
> +
> +        /* Single-ended channel */
> +        channel@0 {
> +          reg = <0>;
> +        };
> +
> +        /* Differential channel */
> +        channel@1 {
> +          reg = <1>;
> +          diff-channels = <1 2>;
> +          ti,gain = <2>; /* Gain of 4 */
> +        };
> +
> +        /* Temperature sensor */
> +        channel@11 {
> +          reg = <11>;
> +        };
> +      };
> +    };
> +...


