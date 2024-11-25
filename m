Return-Path: <linux-iio+bounces-12651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB7B9D8D42
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 21:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A11BB24895
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 20:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5793D1C07FA;
	Mon, 25 Nov 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCYukZYB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A43A1552FC;
	Mon, 25 Nov 2024 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732565056; cv=none; b=h/8rc+mKOHAIAzZLY/rg24TcIMLfpov0+h5q2xQemxtX66yt+ZpkjAPR5K2tjP6Vn99k1SkcbIkJuYhOWTY+7LuCOQyNXWq/Q0uuDzHFDCaTWiSiocqn6BTnau9xfJrhFADGweu0m5cWtab9zJot/RqC15w4ad3Xc29Tp+koCE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732565056; c=relaxed/simple;
	bh=0jeOnmsSROXYZ+myVdKpJjRbTdKaje8IhFLtxe2XRM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o06bqscMbWJiLQ4TtgapXUtEG/bLdjasqfMHmV/a2g6UnBXmFkTs+x9s5Zc1vrobfO/YlpG6RbEn6y+0GdkKGiZYM9KJWqpmeUjf6E3urpeFVM4WRPu08N88BJ4YKHeSL0L2E37B0dra98rl8Qj7x0OQq+aaIskiC6YvDlEqT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCYukZYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9047C4CECE;
	Mon, 25 Nov 2024 20:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732565055;
	bh=0jeOnmsSROXYZ+myVdKpJjRbTdKaje8IhFLtxe2XRM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LCYukZYBsEixjABFBhgWYAdY3agpkay4QRtX+/WBJU67Z1CyyTibXrnEVrvZKLKvG
	 wcKl5TA9/btkpyjfVaeSDSIXH5H8ixp5KZcUDKB93qUozFLdduDWU5yk/vY0uXpahP
	 BqocKb3e5u+jNmsekfyV4pLBRBj130Bm5sAFTgCAXBfBGx5oKVgYqvgXFm9fIDJgj9
	 LPNIQ2UQjVYWFXRbkPI5yRRkiU2T3Bbye5r2K8b4nmuUVByHMBN2ppCM/R5DR+6J+E
	 izBq3L3Kf/N+7/beFyRIpry03XQPLw5HcZ0xQ3T9oS0L3rPhRFd3NiXtpfOLIo0TZI
	 7gp/mQ81MFuuA==
Date: Mon, 25 Nov 2024 20:04:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, Kim Seer Paller
 <kimseer.paller@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: frequency: Add ADF4382
Message-ID: <20241125200405.1d5dd495@jic23-huawei>
In-Reply-To: <20241114130340.7354-2-ciprian.hegbeli@analog.com>
References: <20241114130340.7354-1-ciprian.hegbeli@analog.com>
	<20241114130340.7354-2-ciprian.hegbeli@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 15:03:10 +0200
Ciprian Hegbeli <ciprian.hegbeli@analog.com> wrote:

Hi Ciprian,

> The ADF4382A is a high performance, ultralow jitter, Frac-N PLL
> with integrated VCO ideally suited for LO generation for 5G applications
> or data converter clock applications. The high performance

5G or data converter clock applications.
(no need to say applications twice)

> PLL has a figure of merit of -239 dBc/Hz, low 1/f Noise and
> high PFD frequency of 625MHz in integer mode that can achieve
> ultralow in-band noise and integrated jitter. The ADF4382A can
> generate frequencies in a fundamental octave range of 11.5 GHz to
> 21 GHz, thereby eliminating the need for sub-harmonic filters. The
> divide by 2 and 4 output dividers on the part allow frequencies to
> be generated from 5.75GHz to 10.5GHz and 2.875GHz to 5.25GHz
> respectively.
Wrap this lot to 75 chars otherwise that's fine if more detail than
many bother with! :)

> 
> Signed-off-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>

A few additional comments from me inline.

> ---
>  .../bindings/iio/frequency/adi,adf4382.yaml   | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf4382.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4382.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4382.yaml
> new file mode 100644
> index 000000000000..44a29ac7a2e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4382.yaml
> @@ -0,0 +1,141 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,adf4382.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADF4382 Microwave Wideband Synthesizer with Integrated VCO
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +  - Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> +
> +description: The ADF4382 is a high performance, ultralow jitter, Frac-N PLL with
> +   integrated VCO ideally suited for LO generation for 5G applications
> +   or data converter clock applications.

> +
> +   https://www.analog.com/en/products/adf4382a.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adf4382
> +      - adi,adf4382a
Description only talks about the a variant. Why is the one without the a?


> +  adi,charge-pump-microamp:
> +    description:
> +      The charge pump current that the external loop filter was designed for.
> +      If this property is not specified, then the charge pump current is set to the
> +      default 11100uA. The valid values are listed below. However, if the set value is
> +      not supported, the driver will look for the closest valid charge pump current.

Don't talk about the driver in a dt-binding. So delete last two sentences.

> +    anyOf:
> +      - enum: [790, 990, 1190, 1380, 1590, 1980, 2390, 2790, 3180, 3970, 4770, 5570, 6330, 7910, 9510, 11100]
> +
> +  adi,ref-divider:
> +    description:
> +      Input divider of the reference frequency, cannot be lower then 1 or
> +      higher then 63.
Why can this not be derived by the required settings in the driver?
That is, why is this a characteristic of the board design?

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 1
> +      - maximum: 63
> +      - default: 1
> +    maxItems: 1
Don't think the maxItems is needed.
> +
> +  adi,ref-doubler-enable:
As above. We should be able to figure out if this is necessary to meet
a particular requested output.

> +    description:
> +      Enables the doubling of the reference clock.
> +    type: boolean
> +    maxItems: 1
> +
> +  adi,bleed-word:
> +    description:
> +      A small programmable constant charge pump current, known as bleed current,
> +      can be used to optimize the phase noise and fractional spurious signals
> +      in fractional mode.
Can we express this in standard units for current?
Also call it bleed-current.

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 4095
> +      - default: 0
> +    maxItems: 1
As above, do we need maxItems?

> +
> +  adi,power-up-frequency:
> +    description:
> +      PLL tunes to the set frequency on probe or defaults to 2,305 GHz.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint64
> +      - minimum: 687500000
> +      - maximum: 22000000000
> +      - default: 2305000000
Why does a default power up frequency make sense?
I'd kind of expect the device to not put anything out until software
has configured it.

> +    maxItems: 1
> +
> +  adi,output-power-value:
> +    description:
> +      The output power amplitude level which will be applied for both channels
> +      at startup.
As above. Feels like this should be configured by userspace before anything is
enabled.  I'd be happy with limits if those make sense (as might reflect what
the circuitry can cope with).

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 15
> +      - default: 11
> +    maxItems: 1
> +
> +  adi,spi-3wire-enable:
> +    description:
> +      Uses SPI in 3 wire mode, by default is uses 4 wire mode.
Is this standard SPI 3 wire, or an ADI variant?
Is spi-3wire from main spi binding appropriate?

> +    type: boolean
> +    maxItems: 1
> +
> +  adi,cmos-3v3:
> +    description:
> +      Sets the SPI logic to 3.3V, by defautl it uses 1,8V.
spell check.

How do you configure it given with the wrong voltage is the
SPI bus reliable?


> +    type: boolean
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
supplies usually required.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        frequency@0 {
Indentation is a bit random.
Stick to 4 spaces throughout.

> +          compatible = "adi,adf4382";
> +          reg = <0>;
> +          spi-max-frequency = <1000000>;
> +          clocks = <&adf4382_clkin>;
> +          clock-names = "ref_clk";
> +          adi,charge-pump-current = <15>;
> +          adi,ref-divider = <1>;
> +        };
> +    };
> +...


