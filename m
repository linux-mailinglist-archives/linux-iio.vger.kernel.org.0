Return-Path: <linux-iio+bounces-5211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602C58CD250
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 14:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC81280ED5
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 12:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160401474BC;
	Thu, 23 May 2024 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzCdnMwf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E8A1E4A0;
	Thu, 23 May 2024 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467632; cv=none; b=VCAjgvMEXPp+pFImEa1HKK/rVnZ18MOICg0eme5r4jiP8uMIsflktqgGzkTeczPs5m4ski8x+H+93KUJfBTu9pUHgn3aWrhjRfnLtbBNbac5fzJQrTTcpx79OWgET8dI6eGfDDKJ9RwAxCUor/+c36WLcZiw2GStVqqr7Ek59lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467632; c=relaxed/simple;
	bh=a8MmbzJBeepTahbb6Q+q7oc8lvq89ytBLirdGd192iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qg2JTcpkJXqbScaX1lCdBr/BCc37V5gweqpTqU7ezMpTdCiT14nOxtZKIXQFuT9N37l59QXzkDBLJP2fNHVnn6Vck14CPgo9cIB6pirrr7Hg1a/+QKXt/lZyMufAfqE6WseFLpOL5KnabYsyl+AFW6oVCQFPoXeRYNtIFTuQ8so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzCdnMwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216F7C2BD10;
	Thu, 23 May 2024 12:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716467632;
	bh=a8MmbzJBeepTahbb6Q+q7oc8lvq89ytBLirdGd192iY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XzCdnMwf9+VrGY2+RNwqK6SHIEV1J7zTUdWsHAHpcOrzQgLud8Zf8Ckxhll/Sz69g
	 kT74aFgaG66KcSgbsmgwfjT7aMt3+I9NWfDZyGDJpt0iRKO0bSxSBOBzIGsmd7jJVL
	 YGMNvC/2j73m6P1PPGJrhk8OIC29gfqsJpAMlyNkrYFsrIlE2Y2oqv8hG0fID752D9
	 0KRwR+zZygOZBFIhGrcWzsoo5EBHzzZHkZep3JL7Zu84ypYZXXQvE00XuINBo1Us44
	 VZ5rIr+T9a2CP4uDNK/zLhVlRd3NGDOxNtj9JGDcKRFSQXxudXyKOq9/iSKDQ4mNNf
	 bufHMtKR6bF5w==
Date: Thu, 23 May 2024 07:33:51 -0500
From: Rob Herring <robh@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
Message-ID: <20240523123351.GA2067525-robh@kernel.org>
References: <20240523031909.19427-1-kimseer.paller@analog.com>
 <20240523031909.19427-5-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240523031909.19427-5-kimseer.paller@analog.com>

On Thu, May 23, 2024 at 11:19:08AM +0800, Kim Seer Paller wrote:
> Add documentation for ltc2672.
> 
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../bindings/iio/dac/adi,ltc2672.yaml         | 159 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
> new file mode 100644
> index 000000000000..996aae315640
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
> @@ -0,0 +1,159 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ltc2672.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC2672 DAC
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description: |
> +  Analog Devices LTC2672 5 channel, 16 bit, 300mA DAC
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2672.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ltc2672
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 50000000
> +
> +  vcc-supply:
> +    description: Analog Supply Voltage Input.
> +
> +  v-neg-supply:
> +    description: Negative Supply Voltage Input.
> +
> +  vdd0-supply:
> +    description: Positive Supply Voltage Input for DAC OUT0.
> +
> +  vdd1-supply:
> +    description: Positive Supply Voltage Input for DAC OUT1.
> +
> +  vdd2-supply:
> +    description: Positive Supply Voltage Input for DAC OUT2.
> +
> +  vdd3-supply:
> +    description: Positive Supply Voltage Input for DAC OUT3.
> +
> +  vdd4-supply:
> +    description: Positive Supply Voltage Input for DAC OUT4.
> +
> +  iovcc-supply:
> +    description: Digital Input/Output Supply Voltage.
> +
> +  ref-supply:
> +    description:
> +      Reference Input/Output. The voltage at the REF pin sets the full-scale
> +      range of all channels. If not provided the internal reference is used and
> +      also provided on the VREF pin.
> +
> +  clr-gpios:
> +    description:
> +      Active Low Asynchronous Clear Input. A logic low at this level triggered
> +      input clears the device to the default reset code and output range, which
> +      is zero-scale with the outputs off. The control registers are cleared to
> +      zero.
> +    maxItems: 1
> +
> +  adi,rfsadj-ohms:
> +    description:
> +      If FSADJ is tied to VCC, an internal RFSADJ (20 kΩ) is selected, which
> +      results in nominal output ranges. When an external resistor of 19 kΩ to
> +      41 kΩ can be used instead by connecting the resistor between FSADJ and GND
> +      it controls the scaling of the ranges, and the internal resistor is
> +      automatically disconnected.
> +    minimum: 19000
> +    maximum: 41000
> +    default: 20000
> +
> +  io-channels:
> +    description:
> +      Analog multiplexer output. Pin voltages and currents can be monitored by
> +      measuring the voltage at MUX.

You need constraints for how many entries and what is each one.

> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel@[0-4]$":
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      reg:
> +        description: The channel number representing the DAC output channel.
> +        maximum: 4
> +
> +      adi,toggle-mode:
> +        description:
> +          Set the channel as a toggle enabled channel. Toggle operation enables
> +          fast switching of a DAC output between two different DAC codes without
> +          any SPI transaction.
> +        type: boolean
> +
> +      adi,output-range-microamp:
> +        description: Specify the channel output full scale range.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [3125000, 6250000, 12500000, 25000000, 50000000, 100000000,
> +               200000000, 300000000]
> +
> +    required:
> +      - reg
> +      - adi,output-range-microamp
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - vcc-supply
> +  - iovcc-supply
> +  - v-neg-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        dac@0 {
> +            compatible = "adi,ltc2672";
> +            reg = <0>;
> +            spi-max-frequency = <10000000>;
> +
> +            vcc-supply = <&vcc>;
> +            iovcc-supply = <&vcc>;
> +            ref-supply = <&vref>;
> +            v-neg-supply = <&vneg>;
> +
> +            io-channels = <&adc 0>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            channel@0 {
> +                    reg = <0>;
> +                    adi,toggle-mode;
> +                    adi,output-range-microamp = <3125000>;
> +            };
> +
> +            channel@1 {
> +                    reg = <1>;
> +                    adi,output-range-microamp = <6250000>;
> +            };
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7becbdf7d1df..3320b7af4c0b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12858,6 +12858,7 @@ S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/ABI/testing/sysfs-bus-iio-dac
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> +F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
>  
>  LTC2688 IIO DAC DRIVER
>  M:	Nuno Sá <nuno.sa@analog.com>
> -- 
> 2.34.1
> 

