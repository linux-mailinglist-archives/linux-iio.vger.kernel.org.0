Return-Path: <linux-iio+bounces-8109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8565B9431BF
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 16:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208EC282063
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 14:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126E21B373C;
	Wed, 31 Jul 2024 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vb2AIKWI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98331B14FF;
	Wed, 31 Jul 2024 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435111; cv=none; b=DF412jE0un1LVepFFHMoSbO0MOO5QNANWY2h8svjeFA44wQ8U2JUxCdKPh8BNKG73kIOxFC8/H9SsxUBKY6YCoU7A8++LYGRq5SCdI7SDieLkbaa2TPWTuDRb4re63hh2231KBDizmy/LiSqUtF6ucrU4TLtcjrMMJjENgZbN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435111; c=relaxed/simple;
	bh=jOPddklYaMJA2zOn9fiqpnFCA5J3HVvmBRrQsJsG5Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LztLcKhGIMZRCBJ54no2KAhq6/6rMWk8belG8WsgqRXXv80bN+iN+j4fy1eOWkzLIcDeWomnNJkbCwiK4ocE4/PPux/I/BpMKZnCRk6iwMG3DR/e5ni95YpuXE7o/Af04mVjPxQZnqj7zvnWZ6ccHhFwV0jwJqTSF1yaiAws1Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vb2AIKWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2374C116B1;
	Wed, 31 Jul 2024 14:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722435111;
	bh=jOPddklYaMJA2zOn9fiqpnFCA5J3HVvmBRrQsJsG5Uw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vb2AIKWIs9Uzq9/qZVRQy+/u/zyOwvNzs+lernwuhhSK6ZjaJFSSIsvXwVMkSMR7n
	 NYB3H1sx2nIq9j2SNZ+nicAAONQM2A/S9rR44Na1eSLG/VpyTa9zO+ZedN2I7zMp5S
	 Y/haBtqOqha1IfScWCXLrfuGGkRBpbcXBHeVQms9YFDh9vhawIwSTycehY8CnA1ijq
	 NDsT+FSGj0ykUN5q4vNj01lNgA1Rkd2smsuU6DQWKXOG5My4WUO+0Rzb1FtPE5iIAx
	 Jsn1s/WpwHBwQW76UaKy9GxvX7YD6mftay1VuqzYIxpvyphQCE48rtLnU+nk77w83r
	 Up3ICnaEEgrQQ==
Message-ID: <387b4028-7f8a-46df-a7f1-168d1700074d@kernel.org>
Date: Wed, 31 Jul 2024 16:11:45 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] dt-bindings: iio: adc: add AD762x/AD796x ADCs
To: Trevor Gamblin <tgamblin@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Lechner <dlechner@baylibre.com>,
 Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240731-ad7625_r1-v1-0-a1efef5a2ab9@baylibre.com>
 <20240731-ad7625_r1-v1-1-a1efef5a2ab9@baylibre.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240731-ad7625_r1-v1-1-a1efef5a2ab9@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/07/2024 15:48, Trevor Gamblin wrote:
> This adds a binding specification for the Analog Devices Inc. AD7625,
> AD7626, AD7960, and AD7961 ADCs.

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

Why this is not ready, but RFC? What exactly needs to be commented here?

> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7625.yaml    | 176 +++++++++++++++++++++
>  MAINTAINERS                                        |   9 ++
>  2 files changed, 185 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
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
> +  - Nuno Sá <nuno.sa@analog.com>
> +
> +description: |
> +  A family of single channel differential analog to digital converters
> +  in a LFCSP package. Note that these bindings are for the device when
> +  used with the PulSAR LVDS project:
> +  http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html.

Eh? And what could be other case - used for what? What are the
differences? Why mentioning it?

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
> +        description: PWM that gates the clock connected to the ADC's CLK input.
> +
> +  io-backends:
> +    description:
> +      The AXI ADC IP block connected to the D+/- and DCO+/- lines of the ADC.
> +    maxItems: 1
> +
> +  adi,en0-always-on:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Indicates if EN0 is hard-wired to the high state. If neither this
> +      nor en0-gpios are present, then EN0 is hard-wired low.
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

I don't think this was ever tested. Please use existing bindings or
example-schema as template.

> +    compatible:
> +      contains:
> +        enum:
> +	  - adi,ad7625
> +	  - adi,ad7626


Best regards,
Krzysztof


