Return-Path: <linux-iio+bounces-256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8662D7F42FA
	for <lists+linux-iio@lfdr.de>; Wed, 22 Nov 2023 10:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B49B280F71
	for <lists+linux-iio@lfdr.de>; Wed, 22 Nov 2023 09:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E295A25578;
	Wed, 22 Nov 2023 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f51q5szW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB471CA9B
	for <linux-iio@vger.kernel.org>; Wed, 22 Nov 2023 09:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539EDC433C7;
	Wed, 22 Nov 2023 09:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700647033;
	bh=R8AzpLhBlnSmiqQSga2HQjICVA5GPGTE6vSngH7Ls9c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f51q5szWw8hNmGM8L3YV+613sfnrX4ZZVjw5CXHizwNggr1YfJkfV9sbdaFW+n+lW
	 4cIsFssRZuTV44UaU6yZ4ztC1oI/ZwvHxAI91lTSiGF59fTaTavYYRQk93Sd/lH6Y/
	 V7gRu9rCjZzF9WoqkBuM4ceDGTNTXCAN5uVw/sbINicl63hb49W3RGoAIuaEraSoWD
	 ++dMTtLtXUVEpqh+a1kYnB2jdQoynMxQ69vgoGwl+TtOf+U1YRRQrhB/UHKWPIgzkD
	 Hfthx0Wg7Qe1ICqjHzUJTJ/LYbkOkCi89w9TO/75S77NU0DyU9+GqkzUdpr0yUEMrC
	 YpDvrFMNqr8/g==
Message-ID: <78518d57-04a7-4cfb-8c1a-1eaf4e3483cf@kernel.org>
Date: Wed, 22 Nov 2023 10:57:09 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] dt-bindings: iio: Add binding documentation for
 AD7091R-8
Content-Language: en-US
To: marcelo.schmitt@analog.com, beniamin.bia@analog.com,
 paul.cercueil@analog.com, Michael.Hennerich@analog.com, lars@metafoo.de,
 jic23@kernel.org, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1700595310.git.marcelo.schmitt1@gmail.com>
 <566503a54feba35178c778a7929bced66ebd8870.1700595310.git.marcelo.schmitt1@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <566503a54feba35178c778a7929bced66ebd8870.1700595310.git.marcelo.schmitt1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2023 22:36, marcelo.schmitt@analog.com wrote:
> From: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> Add device tree binding documentation for AD7091R-8.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time, thus I will skip this patch entirely till you follow
the process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7091r8.yaml        | 101 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
> new file mode 100644
> index 000000000000..f10b6727737f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7091r8.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7091R8 8-Channel 12-Bit ADC
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +
> +description: |
> +  Analog Devices AD7091R-8 8-Channel 12-Bit ADC
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7091R-2_7091R-4_7091R-8.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7091r2
> +      - adi,ad7091r4
> +      - adi,ad7091r8
> +
> +  reg:
> +    maxItems: 1
> +
> +  vref-supply: true
> +
> +  spi-max-frequency: true
> +
> +  adi,conversion-start-gpios:
> +    description:
> +      Device tree identifier of the CONVST pin.
> +      This logic input is used to initiate conversions on the analog
> +      input channels.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:

This goes after pattern.

> +  - compatible
> +  - reg
> +  - adi,conversion-start-gpios
> +
> +patternProperties:
> +  "^channel@[0-7]$":
> +    $ref: "adc.yaml"

You never tested this... considering that you opted-out of automated
testing, you basically send buggy code. NAK.

Best regards,
Krzysztof


