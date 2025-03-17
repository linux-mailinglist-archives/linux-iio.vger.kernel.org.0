Return-Path: <linux-iio+bounces-16930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B39EDA6436C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 08:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33A7188D8C0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 07:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A10214A8F;
	Mon, 17 Mar 2025 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izr2nYqP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AE81B0F11
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196267; cv=none; b=dmzRPEmoQzz9jRzuCNKK1ZuYRRsqcR75s5ExZQQ8Q6j1nr5TqNuVXE5u83N/4lD/c7F9iarz2ekMGq2hc1iPMJsol9XEeok2uQeDMPAOqUbtzwTzIY8Y9b6aedC6AFU6B9LO026kSXXSA4PN0NVbGOFY0c64YQu0TS93PHF5D+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196267; c=relaxed/simple;
	bh=FuHfL2smwV/D2VfXXIvoMvqjs+G9bMim9aee+Cu3maQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYAi1S1z1pfFHrHHGGQ4HNGDgm5JwVp1+KlhZ3xi3VKwLI/VC2Y7qjjDoSGiBeaIbJM94yXgERh+BV/O223MEjEm88hu7qC3lH37M+2Tcxx+qGNs01V6MtSRdrfHxnhz9Gjhg0L2HTMbQrZf47dzEc2GhUFUmC80+iJ0viQ0Dt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izr2nYqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD114C4CEE3;
	Mon, 17 Mar 2025 07:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742196266;
	bh=FuHfL2smwV/D2VfXXIvoMvqjs+G9bMim9aee+Cu3maQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=izr2nYqP6GF83QXsUTWd+C5FNkgsf9+oV6etydEO6FZi7et4hN7G+bJTbcahd1G5m
	 6cpXR9xDpBQDDkPlFmC3MagfhzmEu+DLnMjbA/CaoZ7CpNanocTVQHDad5vYYk5c00
	 GcCnXpaQ96bYgCu4QPaS9uExkIxUXjZyB9FNyWtAdp+c+yP9atRicU9RrN9XOH9O36
	 6/oa/f/NpSiDkb25NneAi97ss8sP2uB6vwBiV3aEaG8VPpbrJaFVkwcmDA6JCkO+OI
	 fgDV8VQ5P0NSjs6/v0m3tM5TeiDXIDJmFV9Fngl+OToBaknPIp9Hdpz6eOgBUX2oWI
	 Qbp3sg0YECejw==
Message-ID: <01f48f6d-55a4-4dbe-b1ae-ef8c54dcc1ff@kernel.org>
Date: Mon, 17 Mar 2025 08:24:21 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: bh1750: Add hardware reset support via GPIO
To: Sergio Perez <sergio@pereznus.es>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org
References: <20250316145514.627-1-sergio@pereznus.es>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
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
In-Reply-To: <20250316145514.627-1-sergio@pereznus.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/03/2025 15:55, Sergio Perez wrote:
> Some BH1750 sensors require a hardware reset before they can be
> detected on the I2C bus. This patch adds support for an optional
> reset GPIO that can be specified in the device tree.
> 
> The reset sequence pulls the GPIO low and then high before
> initializing the sensor, which enables proper detection with
> tools like i2cdetect.
> 
> Update the devicetree binding documentation to include the new
> reset-gpios property with examples.
> 
> Signed-off-by: Sergio Perez <sergio@pereznus.es>

Please run scripts/checkpatch.pl and fix reported warnings. After that,
run also `scripts/checkpatch.pl --strict` and (probably) fix more
warnings. Some warnings can be ignored, especially from --strict run,
but the code here looks like it needs a fix. Feel free to get in touch
if the warning is not clear.

<form letter>
Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline) or work on fork of kernel
(don't, instead use mainline). Just use b4 and everything should be
fine, although remember about `b4 prep --auto-to-cc` if you added new
patches to the patchset.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time.

Please kindly resend and include all necessary To/Cc entries.
</form letter>


> ---
>  .../devicetree/bindings/iio/light/bh1750.yaml |  20 +++-
>  drivers/iio/light/bh1750.c                    | 113 ++++++++++++------


... and please go through your patch and see what happened there.
>  2 files changed, 95 insertions(+), 38 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.yaml b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
> index 1a88b3c253d5..d53b221eb84b 100644
> --- a/Documentation/devicetree/bindings/iio/light/bh1750.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
> @@ -11,6 +11,9 @@ maintainers:
>  
>  description: |
>    Ambient light sensor with an i2c interface.
> +  
> +  Some BH1750 sensors require a hardware reset before being properly detected
> +  on the I2C bus. This can be done using the optional reset-gpios property.
>  
>  properties:
>    compatible:
> @@ -23,6 +26,10 @@ properties:
>  
>    reg:
>      maxItems: 1
> +    
> +  reset-gpios:
> +    description: GPIO connected to the sensor's reset line (active low)
> +    maxItems: 1
>  
>  required:
>    - compatible
> @@ -41,5 +48,16 @@ examples:
>          reg = <0x23>;
>        };
>      };
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      light-sensor@23 {
> +        compatible = "rohm,bh1750";
> +        reg = <0x23>;
> +        reset-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
> +      };
> +    };
>  
> -...
> +...
> \ No newline at end of file

You have unrelated changed all over the place.


Best regards,
Krzysztof

