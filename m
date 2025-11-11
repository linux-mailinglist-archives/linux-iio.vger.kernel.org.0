Return-Path: <linux-iio+bounces-26166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEDFC4C3F5
	for <lists+linux-iio@lfdr.de>; Tue, 11 Nov 2025 09:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4480F189499A
	for <lists+linux-iio@lfdr.de>; Tue, 11 Nov 2025 08:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187812D2382;
	Tue, 11 Nov 2025 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmFpkT1j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07731EF0B9;
	Tue, 11 Nov 2025 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848328; cv=none; b=jQI0lKzEYlXg5iVMrc9bslE4+HT4Hu6toDgtXbC6OaH3nOSoSkPFbte4R2jkMEp8c537rnxuBroKX9JOV4+BqRiw7gJGwXy4H2838YDZgAQQUE/netRICeS6sIExV8naUACYehcQNb6qPJa2CU0VtF/AuAnOx6ukyqgUih264Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848328; c=relaxed/simple;
	bh=8RFF/5pPXSon2xnZCsYJudGJl9uHsgxD+ZZHGVc5YuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrRGHCvjO0bwlw+UjLsueRki3DC+mq1X7Myn0qkHTupYz2CTPP2H+gXTibjsBlvn2heFz2Web4bCNxoNX8dK47Vwgzemwnqa5e4STRTK/KNfviNLuPCUI8D8LnBhd9/BIBg0aBAThuaOJDkwYwmxpSndcj6bkeBxs7CktpIrYuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmFpkT1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65AFC116B1;
	Tue, 11 Nov 2025 08:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762848328;
	bh=8RFF/5pPXSon2xnZCsYJudGJl9uHsgxD+ZZHGVc5YuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmFpkT1jx/ruZNfk74bWjMCyGRZ47ickpQqneFZ6v6cRJ2QlTLF7MJ42RsmfpkxLu
	 NwIfFzMzLZ+V8nOcOHO1WkBKjoVDIUn9Gy35ozNxQDb8tZZOV9CoRWDfXFXavBWa/x
	 H82UYRMtgllSPalYhWm7CfnIpV0gfWGoqv5xCrzMn9R+v/2xBnu/oGQ8jeuXXiHvGu
	 FIsDYHKVmpJ0BWReNqI6xosAyKuGBiCC37tHoeRSifKx8HprfmVTYd5a7XHT6x36I4
	 8WujR6J5kLsrpTt1kPzU5g3bv5a1tETGJDZH+mN1/aChm0Qv+Srh/A07OmOX5OGJXz
	 pOxM/5SQf3wlQ==
Date: Tue, 11 Nov 2025 09:05:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/3] dt-bindings: iio: frequency: add adf41513
Message-ID: <20251111-feathered-winged-bloodhound-b7e1a3@kuoka>
References: <20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com>
 <20251110-adf41513-iio-driver-v1-2-2df8be0fdc6e@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251110-adf41513-iio-driver-v1-2-2df8be0fdc6e@analog.com>

On Mon, Nov 10, 2025 at 03:44:45PM +0000, Rodrigo Alencar wrote:
> ultralow noise PLL frequency synthesizer that can be used to
> implement local oscillators (LOs) as high as 26.5 GHz
>=20
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---

Please organize the patch documenting compatible (DT bindings) before their=
 user.
See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/d=
evicetree/bindings/submitting-patches.rst#L46

=2E..

> +  clocks:
> +    maxItems: 1
> +    description: Clock that provides the reference input frequency.
> +
> +  '#clock-cells':
> +    const: 0
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description: Power supply for the device (3.3V)
> +
> +  chip-enable-gpios:

enable-gpios

> +    description:
> +      GPIO that controls the chip enable pin. A logic low on this pin
> +      powers down the device and puts the charge pump output into
> +      three-state mode.
> +    maxItems: 1
> +
> +  lock-detect-gpios:
> +    description:
> +      GPIO for lock detect functionality. When configured for digital lo=
ck
> +      detect, this pin will output a logic high when the PLL is locked.
> +    maxItems: 1
> +
> +  adi,power-up-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint64

Use standard unit suffixes. Frequency is in Hz for example.

> +    minimum: 1000000000
> +    maximum: 26500000000
> +    default: 10000000000
> +    description:
> +      The PLL tunes to this frequency (in Hz) on driver probe.
> +      Range is 1 GHz to 26.5 GHz for ADF41513, and 1 GHz to 10 GHz for A=
DF41510.
> +
> +  adi,reference-div-factor:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 32
> +    description:
> +      Reference division factor (R Counter). If not specified, the driver
> +      will calculate the optimal value automatically.

Then why do you need this property? If driver calculates the optimal,
why anyone would put wrong or sub-optimal value to DT?

Drop.

> +
> +  adi,reference-doubler-enable:
> +    description:
> +      Enables the reference doubler. The maximum reference frequency when
> +      the doubler is enabled is 225 MHz.
> +    type: boolean
> +
> +  adi,reference-div2-enable:
> +    description:
> +      Enables the reference divide-by-2 function. This provides a 50%
> +      duty cycle signal to the PFD.
> +    type: boolean
> +
> +  adi,charge-pump-current-microamp:
> +    minimum: 450
> +    maximum: 7200
> +    default: 2400
> +    description:
> +      Charge pump current in microamps. The value will be rounded to the
> +      nearest supported value.
> +
> +  adi,charge-pump-resistor-ohms:
> +    minimum: 1800
> +    maximum: 10000
> +    default: 2700
> +    description:
> +      External charge pump resistor value in ohms. This sets the maximum
> +      charge pump current along with the charge pump current setting.
> +
> +  adi,muxout-select:
> +    description:
> +      On chip multiplexer output selection.
> +      high_z - MUXOUT Pin set to high-Z. (default)
> +      muxout_high - MUXOUT Pin set to high.
> +      muxout_low - MUXOUT Pin set to low.
> +      f_div_rclk - MUXOUT Pin set to R divider output
> +      f_div_nclk - MUXOUT Pin set to N divider output
> +      lock_detect - MUXOUT Pin set to Digital lock detect
> +      serial_data - MUXOUT Pin set to Serial data output
> +      readback - MUXOUT Pin set to Readback mode
> +      f_div_clk1 - MUXOUT Pin set to CLK1 divider output
> +      f_div_rclk_2 - MUXOUT Pin set to R divider/2 output
> +      f_div_nclk_2 - MUXOUT Pin set to N divider/2 output
> +    enum: [high_z, muxout_high, muxout_low, f_div_rclk, f_div_nclk, lock=
_detect,
> +           serial_data, readback, f_div_clk1, f_div_rclk_2, f_div_nclk_2]
> +
> +  adi,muxout-level-1v8-enable:
> +    description:
> +      Set MUXOUT and DLD logic levels to 1.8V. Default is 3.3V.
> +    type: boolean
> +
> +  adi,phase-detector-polarity-positive-enable:
> +    description:
> +      Set phase detector polarity to positive. Default is negative.
> +      Use positive polarity with non-inverting loop filter and VCO with
> +      positive tuning slope, or with inverting loop filter and VCO with
> +      negative tuning slope.
> +    type: boolean
> +
> +  adi,lock-detect-precision:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 3
> +    description:
> +      Lock detector precision setting. Controls the sensitivity of the
> +      lock detector. Lower values of precision increases the lock detect=
or
> +      window size.
> +
> +  adi,lock-detect-count:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 7
> +    description: |
> +      Lock detector count setting (3-bit value). Determines the number of
> +      consecutive phase detector cycles that must be within the lock det=
ector
> +      window before lock is declared. The count grows in powers of two o=
f the
> +      programmed value:
> +      - if adi,fast-lock-enable is set count =3D 2 * 2^value
> +      - if adi,fast-lock-enable is not set count =3D 64 * 2^value
> +
> +  adi,lock-detect-bias-microamp:
> +    description:
> +      Lock detector bias current. Controls the lock detector window size
> +      along with the lock detector precision setting. Lower bias current
> +      increases the window size.
> +    enum: [10, 20, 30, 40]
> +
> +  adi,fast-lock-enable:
> +    description:
> +      Enable fast lock mode. This changes the lock detector clock select=
ion
> +      for faster lock indication.
> +    type: boolean
> +
> +  adi,phase-resync-enable:
> +    description:
> +      Enable phase resync functionality. This produces a consistent outp=
ut
> +      phase offset with respect to the input reference.
> +    type: boolean
> +
> +  adi,12bit-clk-divider:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 4095
> +    description:
> +      CLK1 divider value used when adi,phase-resync-enable is set
> +
> +  adi,12bit-clk2-divider:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 4095
> +    description:
> +      CLK2 divider value used when adi,phase-resync-enable is set
> +
> +  adi,le-sync-enable:
> +    description:
> +      Synchronize the rising edge of LE on an SPI write with the falling
> +      edge of the reference signal to prevent glitches.
> +    type: boolean
> +
> +  adi,freq-resolution:
> +    $ref: /schemas/types.yaml#/definitions/uint64
> +    minimum: 1
> +    default: 1000000
> +    description:
> +      Initial frequency resolution in micro-Hz (=C2=B5Hz) for the algori=
thm to achieve.
> +      This influences the choice between fixed and variable modulus mode=
s.
> +      Default is 1000000 =C2=B5Hz (1 Hz).
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - vcc-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        pll@0 {
> +            compatible =3D "adi,adf41513";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <10000000>;
> +            clocks =3D <&ref_clk>;
> +            vcc-supply =3D <&vcc_3v3>;
> +            #clock-cells =3D <0>;
> +
> +            adi,power-up-frequency =3D /bits/ 64 <12000000000>;
> +            adi,charge-pump-current-microamp =3D <2400>;
> +            adi,phase-detector-polarity-positive-enable;
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        /* Example with advanced features enabled */
> +        pll_advanced@0 {

pll@

> +            compatible =3D "adi,adf41513";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <25000000>;
> +            clocks =3D <&ref_clk>;
> +            vcc-supply =3D <&vcc_3v3>;
> +            chip-enable-gpios =3D <&gpio0 10 GPIO_ACTIVE_HIGH>;
> +            lock-detect-gpios =3D <&gpio0 11 GPIO_ACTIVE_HIGH>;
> +            #clock-cells =3D <0>;
> +            clock-output-names =3D "adf41513_clk";
> +
> +            adi,power-up-frequency =3D /bits/ 64 <15500000000>;
> +            adi,charge-pump-current-microamp =3D <3600>;
> +            adi,charge-pump-resistor-ohms =3D <2700>;
> +            adi,reference-doubler-enable;
> +            adi,muxout-select =3D "lock_detect";
> +            adi,lock-detect-precision =3D <1>;
> +            adi,lock-detect-count =3D <4>;
> +            adi,lock-detect-bias-microamp =3D <40>;
> +            adi,fast-lock-enable;
> +            adi,phase-resync-enable;
> +            adi,12bit-clk-divider =3D <1>;
> +            adi,12bit-clk2-divider =3D <200>;
> +            adi,le-sync-enable;
> +            adi,freq-resolution =3D /bits/ 64 <1000000>;
> +            adi,phase-detector-polarity-positive-enable;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8df4a0d216c8..1bbcff826238 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1606,6 +1606,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
>  F:	drivers/iio/frequency/adf41513.c
> =20
>  ANALOG DEVICES INC ADF4377 DRIVER
>=20
> --=20
> 2.43.0
>=20

