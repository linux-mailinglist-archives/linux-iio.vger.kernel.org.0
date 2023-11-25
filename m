Return-Path: <linux-iio+bounces-347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C06F87F8C15
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 16:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B241C20984
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 15:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E6728E35;
	Sat, 25 Nov 2023 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfDFye/9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15EE20305;
	Sat, 25 Nov 2023 15:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20148C433C7;
	Sat, 25 Nov 2023 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700926543;
	bh=9XcsX/rqDUE/4rKkKOqkuc0WCIhP5kbJTDOZF+yyUdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YfDFye/96iTRHnHeNU8ERa87yaX1BE1X8OKGpDaGtpH/vBdMyetR3HhPJiYJ9w0cW
	 shnam6A6V5JY2ryE5t//mOE2an0DiUVmc9JKrmgQcnUyjUwr0MfWMaRoffY4OSPTu1
	 IBhEgaplHK7KfIOEVUSUkrtFBoCRep02HN41QXwyrhBoyU5KTxHLwa+z5pkTjQQnPJ
	 OUvSWD0mgsbZaU6laBOQO6eh636rsSPouTImiS0Z7Xgym2drr9qacRiebnyVKAeZVx
	 BpoQrUR1P5Pd906CZkETmg1tY8CvquxV5OXIKqkEJZyKXjouyApjs20TRLCrkOvdHf
	 y19Ket1nYSszg==
Date: Sat, 25 Nov 2023 15:35:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Crt Mori <cmo@melexis.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: frequency: add admfm2000
Message-ID: <20231125153535.08045a2e@jic23-huawei>
In-Reply-To: <20231124105116.5764-1-kimseer.paller@analog.com>
References: <20231124105116.5764-1-kimseer.paller@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Nov 2023 18:51:15 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> Dual microwave down converter module with input RF and LO frequency
> ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> for each down conversion path.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 
Hi,

Sorry I'm late to the party.

Long term we might want to support cases where some of the pins are hard wired,
but that can happen when someone comes along with such a board.

Only thing I wonder is if the gpios could be moved under the child nodes
as I think they only apply to specific channels?  Would make the
driver a little more complex but the binding cleaner.

Thanks Krzysztof for all your reviews btw
(in general, rather than just this!)

Follow on comments inline...


> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> new file mode 100644
> index 000000000..037438737
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2023 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,admfm2000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADMFM2000 Dual Microwave Down Converter
> +
> +maintainers:
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description:
> +  Dual microwave down converter module with input RF and LO frequency ranges
> +  from 0.5 to 32 GHz and an output IF frequency range from 0.1 to 8 GHz.
> +  It consists of a LNA, mixer, IF filter, DSA, and IF amplifier for each down
> +  conversion path.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,admfm2000
> +
> +  switch1-gpios:
> +    items:
> +      - description: B15 GPIO, when high (and B16 low) channel 1 is in
> +          Direct IF mode.
> +      - description: B16 GPIO, when high (and B15 low) channel 1 is in
> +          Mixer mode.
> +
> +  switch2-gpios:
> +    items:
> +      - description: K14 GPIO, when high (and L14 low) channel 2 is in
> +          Mixer mode.
> +      - description: L14 GPIO, when high (and K14 low) channel 2 is in
> +          Direct IF mode.
> +
> +  attenuation1-gpios:
> +    description: |
> +      Choice of attenuation:
> +      D15 D14 C16 C15 C14
I don't think there is a useful public data sheet, but normally I'd expect
these to have friendly names rather than pin coords.
chan0-att0, chan0-att1 or something like that.
Hopefully with something like that we could combine the docs if we can push
the GPIOs down into the child nodes.

> +      1   1   1   1   1   0 dB
> +      1   1   1   1   0   -1 dB
> +      1   1   1   0   1   -2 dB
> +      1   1   0   1   1   -4 dB
> +      1   0   1   1   1   -8 dB
> +      0   1   1   1   1   -16 dB
> +      0   0   0   0   0   -31 dB
> +
> +    items:
> +      - description: C14 GPIO
> +      - description: C15 GPIO
> +      - description: C16 GPIO
> +      - description: D14 GPIO
> +      - description: D15 GPIO
> +
> +  attenuation2-gpios:
> +    description: |
> +      Choice of attenuation:
> +      M16 M15 M14 L16 L15
> +      1   1   1   1   1   0 dB
> +      1   1   1   1   0   -1 dB
> +      1   1   1   0   1   -2 dB
> +      1   1   0   1   1   -4 dB
> +      1   0   1   1   1   -8 dB
> +      0   1   1   1   1   -16 dB
> +      0   0   0   0   0   -31 dB
> +
> +    items:
> +      - description: L15 GPIO
> +      - description: L16 GPIO
> +      - description: M14 GPIO
> +      - description: M15 GPIO
> +      - description: M16 GPIO
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel@[0-1]$":
> +    type: object
> +    description: Represents a channel of the device.
> +
> +    additionalProperties: false
> +
> +    properties:
> +      reg:
> +        description:
> +          The channel number.
> +        minimum: 0
> +        maximum: 1
> +
> +      adi,mode:
> +        description:
> +          RF path selected for the channel.
> +            0 - Direct IF mode
> +            1 - Mixer mode
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +
> +    required:
> +      - reg
> +      - adi,mode
> +
> +required:
> +  - compatible
> +  - switch1-gpios
> +  - switch2-gpios
> +  - attenuation1-gpios
> +  - attenuation2-gpios




