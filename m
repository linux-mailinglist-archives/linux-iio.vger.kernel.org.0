Return-Path: <linux-iio+bounces-8204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79454946A1E
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 16:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300F8281B31
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 14:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34A71509B6;
	Sat,  3 Aug 2024 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIP4MOKD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A050014E2FC;
	Sat,  3 Aug 2024 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722695748; cv=none; b=eY87X21Aj1AnONFhyh9NGMFHV9DDWhL4d+QvYFW+OwEzAx3kJa4yvUuTVZW8J1Ns/IpF++1Rmla/zKxizXDcHMCHjFnYQ6/e6pXV/B493dqmkYVXmhNJmDp6pCgncdFTRBKH+jhmtBb4aH26ueOTbrDpUEzaCYhnAJG+UCzT0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722695748; c=relaxed/simple;
	bh=oBPrXUonNO9pQiYaX33t8BvaMG4+Syyr7vyRuVmvIJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOEa45d8T4efko7dRqeVE6xI7mAYOrKq3uzlv5yuw0UZinXhe1524Rn0C2GSHTgSJICdOvxpY+NNvvQt8U5n7/+sLAzILF9HsjHMCRUrlxvlQ/kwABYO6qbaxxZbuOcbylPPnlE22AcP77tTZqZoxROLjSON6WxYzuZSeeSIq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIP4MOKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ACCC4AF0D;
	Sat,  3 Aug 2024 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722695748;
	bh=oBPrXUonNO9pQiYaX33t8BvaMG4+Syyr7vyRuVmvIJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cIP4MOKD1qsWVd9ecz2qyMF00uSGHRgJb2fx4Vuar949LBmhVvxpXpZwxfWqMyZB8
	 gZ+MQc8eoqC4Vo0hTLx4w8ZEVbnCIuSmWaw2+crxpSJW/EPCtX1/WNhifyMbLWtefX
	 0V3dSikYAtjgE5L+QrWCVTxkD+szwk40ip23s0ocKXYqR1NJh0ep7D8IO9pCc72nyb
	 o8lx6R55+h3cTYDVjrUTMwzapg4LQPXYmQhQqlIwsJ/Me882anFAicXj5ypgaCJchA
	 LfSCItrfIIP3DaLVkuAB96nayplBFpgiOIhBaVRah0FMwoGCoWYYM4XBLjGZyKYjKu
	 /6uPBxBIgMd4w==
Date: Sat, 3 Aug 2024 15:35:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David
 Lechner <dlechner@baylibre.com>, Uwe Kleine-Konig
 <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH RFC 1/3] dt-bindings: iio: adc: add AD762x/AD796x ADCs
Message-ID: <20240803153540.17627489@jic23-huawei>
In-Reply-To: <20240731-ad7625_r1-v1-1-a1efef5a2ab9@baylibre.com>
References: <20240731-ad7625_r1-v1-0-a1efef5a2ab9@baylibre.com>
	<20240731-ad7625_r1-v1-1-a1efef5a2ab9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jul 2024 09:48:03 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> This adds a binding specification for the Analog Devices Inc. AD7625,
> AD7626, AD7960, and AD7961 ADCs.

Given the RFC question is effectively about the binding and may influence
it a lot - make sure it's talked about here!

>=20
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7625.yaml    | 176 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   9 ++
>  2 files changed, 185 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
> new file mode 100644
> index 000000000000..e88db0ac2534
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
> @@ -0,0 +1,176 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7625.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices Fast PulSAR Analog to Digital Converters
> +
> +maintainers:
> +  - Michael Hennerich <Michael.Hennerich@analog.com>
> +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> +
> +description: |
> +  A family of single channel differential analog to digital converters
> +  in a LFCSP package. Note that these bindings are for the device when
> +  used with the PulSAR LVDS project:
> +  http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html.

As per the discussion in the cover letter I think the need to represent
if the DCO+ is connected between ADC and LVDS converter strongly suggests
we shouldn't represent it as one aggregate device.

> +
> +  * https://www.analog.com/en/products/ad7625.html
> +  * https://www.analog.com/en/products/ad7626.html
> +  * https://www.analog.com/en/products/ad7960.html
> +  * https://www.analog.com/en/products/ad7961.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7625
> +      - adi,ad7626
> +      - adi,ad7960
> +      - adi,ad7961
> +
> +  vdd1-supply:
> +    description: A supply that powers the analog and digital circuitry.
Doesn't really tell us anything. I'd just go with
    vdd1-supply: true
    vdd2-supply: true
    vio-supply: true


> +
> +  vdd2-supply:
> +    description: A supply that powers the analog and digital circuitry.
> +
> +  vio-supply:
> +    description: A supply for the inputs and outputs.
> +
> +  ref-supply:
> +    description:
> +      Voltage regulator for the external reference voltage (REF).
> +
> +  refin-supply:
> +    description:
> +      Voltage regulator for the reference buffer input (REFIN).
> +
> +  clocks:
> +    description:
> +      The clock connected to the CLK pins, gated by the clk_gate PWM.
> +    maxItems: 1
> +
> +  pwms:
> +    maxItems: 2
> +
> +  pwm-names:
> +    maxItems: 2
> +    items:
> +      - const: cnv
> +        description: PWM connected to the CNV input on the ADC.
> +      - const: clk_gate
> +        description: PWM that gates the clock connected to the ADC's CLK=
 input.
> +
> +  io-backends:
> +    description:
> +      The AXI ADC IP block connected to the D+/- and DCO+/- lines of the=
 ADC.

So you have a backend. Great - we have something to indicate a connection
to or not for the DCO+/o lines.  It's a bit ugly to just repesent it as a c=
lk
but that would I think work.

> +    maxItems: 1
> +
> +  adi,en0-always-on:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Indicates if EN0 is hard-wired to the high state. If neither this
> +      nor en0-gpios are present, then EN0 is hard-wired low.
It's unfortunate there isn't a special 'fixed' gpio-chip option where we co=
uld
just query it is fixed and what the state of the pin is.  This is getting
quite common so would be good to have a better solution.

Linus, Bartosz - is there a better way to do this?

> +
> +  adi,en1-always-on:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Indicates if EN1 is hard-wired to the high state. If neither this
> +      nor en1-gpios are present, then EN1 is hard-wired low.
> +
> +  adi,en2-always-on:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Indicates if EN2 is hard-wired to the high state. If neither this
> +      nor en2-gpios are present, then EN2 is hard-wired low.
> +
> +  adi,en3-always-on:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Indicates if EN3 is hard-wired to the high state. If neither this
> +      nor en3-gpios are present, then EN3 is hard-wired low.
> +
> +  en0-gpios:
> +    description:
> +      Configurable EN0 pin.
> +
> +  en1-gpios:
> +    description:
> +      Configurable EN1 pin.
> +
> +  en2-gpios:
> +    description:
> +      Configurable EN2 pin.
> +
> +  en3-gpios:
> +    description:
> +      Configurable EN3 pin.
> +
> +required:
> +  - compatible
> +  - vdd1-supply
> +  - vdd2-supply
> +  - vio-supply
> +  - clocks
> +  - pwms
> +  - pwm-names
> +  - io-backends
> +
> +- if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +	  - adi,ad7625
> +	  - adi,ad7626
> +  then:
> +    properties:
> +      en2-gpios: false
> +      en3-gpios: false
> +      adi,en2-always-on: false
> +      adi,en3-always-on: false
> +    allOf:
> +      # ref-supply and refin-supply are mutually-exclusive (neither is a=
lso
> +      # valid)
> +      - if:
> +          required:
> +            - ref-supply
> +        then:
> +          properties:
> +            refin-supply: false
> +      - if:
> +          required:
> +            - refin-supply
> +        then:
> +          properties:
> +            ref-supply: false
> +
> +- if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +	  - adi,ad7960
> +	  - adi,ad7961
> +  then:
> +    oneOf:
> +      required:
> +        - ref-supply
> +      required:
> +        - refin-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    adc {
> +        compatible =3D "adi,ad7625";
> +        vdd1-supply =3D <&supply_5V>;
> +        vdd2-supply =3D <&supply_2_5V>;
> +        vio-supply =3D <&supply_2_5V>;
> +        io-backends =3D <&axi_adc>;
> +        clock =3D <&ref_clk>;
> +        pwms =3D <&axi_pwm_gen 0 0>, <&axi_pwm_gen 1 0>;
> +        pwm-names =3D "cnv", "clk_gate";
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42decde38320..2361f92751dd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1260,6 +1260,15 @@ F:	Documentation/devicetree/bindings/iio/addac/adi=
,ad74413r.yaml
>  F:	drivers/iio/addac/ad74413r.c
>  F:	include/dt-bindings/iio/addac/adi,ad74413r.h
> =20
> +ANALOG DEVICES INC AD7625 DRIVER
> +M:	Michael Hennerich <Michael.Hennerich@analog.com>
> +M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> +R:	Trevor Gamblin <tgamblin@baylibre.com>
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +W:	http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
> +
>  ANALOG DEVICES INC AD7768-1 DRIVER
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  L:	linux-iio@vger.kernel.org
>=20


