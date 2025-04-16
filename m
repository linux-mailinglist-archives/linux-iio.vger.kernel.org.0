Return-Path: <linux-iio+bounces-18155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3879AA8B10B
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 08:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E541E3A90B4
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 06:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9382A204866;
	Wed, 16 Apr 2025 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtk2Bf7a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E02922A4E5;
	Wed, 16 Apr 2025 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785943; cv=none; b=W5w3vy/rVCc0V6TDaPbwNvCKL8itc10N+1vTocDWnAUuod+xkwLhWpUSeQbqpPH+Z+Rb+1ipRIlOfMlU66FjSy5I6/PL2wMvNF9OJ/zTOg+wBRxCIrmwjzGVDskoMETUkQZtf3Axeqe7+BUUiCuQOdW8OiFHsIPbCECuzVbjblg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785943; c=relaxed/simple;
	bh=xh72Sbq9MmoTSv2ZjJjuj6ljsAi9tqThZCsBernp5Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9i6wBhxlPJInYd+sjy/dmML9iNZy9QQIJ5VXw7ls6G/pJ3ia5bgwH4Z6DnBgtB45m4THlAL2hepqBdDsKyQ5BI5JqTdB9EwE3zdPyOhpHUq775zOFHqaTQ2NeF6d9A/Gxs6ojC4IUVMdYlqaCYxysb72qffQKRd9IEO2NEfqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtk2Bf7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA0FC4CEE2;
	Wed, 16 Apr 2025 06:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744785942;
	bh=xh72Sbq9MmoTSv2ZjJjuj6ljsAi9tqThZCsBernp5Ew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qtk2Bf7a3veT2/4IffpeucE6R8e8kemMRHPWo7967OO9HrTzcdOKIROXb4iH6ikxB
	 9yxjurdtEtebXXO3lvTBwrZeMCTHsbjU3/o4YpMxFT08ebAkVU1b6UftDmRzqOfv6h
	 TJb+tNJ1xgZh3eFIdeDPRFdMI87UhsMuIYVk1v44iXhF+EGKiJlclEFDePDQYO9sZz
	 5wzhIPXkfyUiR9cisJly0kol2XpxEvGXyYeQtjKDU48vb3P2x9H2mvIMvtxjUuP9tK
	 0DtUeURjkCvaGijlBLpH8owrux6s/iQBmJMGBp73CFUxoQmptnkxb3W9LR+J3YPTHy
	 z0FoB5Bu7ix7Q==
Message-ID: <72df35d9-1783-4a9b-8163-43ff3258c3ef@kernel.org>
Date: Wed, 16 Apr 2025 08:45:37 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
To: victor.duicu@microchip.com, jic23@kernel.org
Cc: andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 marius.cristea@microchip.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250415132623.14913-1-victor.duicu@microchip.com>
 <20250415132623.14913-2-victor.duicu@microchip.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250415132623.14913-2-victor.duicu@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/04/2025 15:26, victor.duicu@microchip.com wrote:
> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This is the devicetree schema for Microchip MCP998X/33 and
> MCP998XD/33D Multichannel Automotive Temperature Monitor Family.
> 
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>

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
>  .../iio/temperature/microchip,mcp9982.yaml    | 182 ++++++++++++++++++
>  1 file changed, 182 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
> new file mode 100644
> index 000000000000..8cbf897d1278
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
> @@ -0,0 +1,182 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9982.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP998X/33 and MCP998XD/33D Multichannel Automotive Temperature Monitor Family

Wrap according to coding style document.

> +
> +maintainers:
> +  - Victor Duicu <victor.duicu@microchip.com>
> +
> +description: |
> +  The MCP998X/33 and MCP998XD/33D family is a high-accuracy 2-wire multichannel
> +  automotive temperature monitor.
> +  The datasheet can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP998X-Family-Data-Sheet-DS20006827.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp9933
> +      - microchip,mcp9933D
> +      - microchip,mcp9982
> +      - microchip,mcp9982D
> +      - microchip,mcp9983
> +      - microchip,mcp9983D
> +      - microchip,mcp9984
> +      - microchip,mcp9984D
> +      - microchip,mcp9985
> +      - microchip,mcp9985D
> +
> +  reg:
> +    maxItems: 1
> +    
> +  interrupts:
> +    maxItems: 2
> +    
> +  interrupt-names:
> +    description: |
> +      ALERT1 indicates a HIGH or LOW limit was exceeded.
> +      ALERT2 indicates a THERM limit was exceeded.
> +    items:
> +      - const: ALERT1

alert1

> +      - const: ALERT2

alert2

> +    
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  microchip,temp-hysteresis:
> +    description: |
> +      Value of temperature limit hysteresis.
> +      Omit this tag to set the default value.
> +    $ref: /schemas/types.yaml#/definitions/uint32

temperature is in specific units, see property units in dtschema.

> +    
> +  microchip,extended-temp-range:
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Set the chip to work in the extended temperature range -64 degrees C to 191.875 degrees C.

does not look wrapped.

> +      Omit this tag to set the default range 0 degrees C to 127.875 degrees C
> +    type: boolean

Why is this a property of the board? I imagine someone might want
different accuracy during runtime.

> +    
> +  microchip,beta-channel1:
> +    description: |
> +      The beta compensation factor for external channel 1 can be set
> +      by the user, or can be set automatically by the chip.
> +      If one wants to enable beta autodetection, omit this tag.
> +      Please consult the documentation if one wants to set a specific beta.
> +      If anti-parallel diode operation is enabled, the default value is set
> +      and can't be changed.
> +    type: boolean
> +    
> +  microchip,beta-channel2:
> +    description: |
> +      The beta compensation factor for external channel 2 can be set
> +      by the user, or can be set automatically by the chip.
> +      If one wants to enable beta autodetection, omit this tag.
> +      Please consult the documentation if one wants to set a specific beta.
> +      If anti-parallel diode operation is enabled, the default value is set
> +      and can't be changed.
> +    type: boolean
> +    
> +  microchip,apdd-state:
> +    description: |
> +      Enable anti-parallel diode mode operation.
> +      Omit this tag to disable anti-parallel diode mode by default.
> +    type: boolean
> +    
> +  microchip,recd12:
> +    description: |
> +      Enable resistance error correction for external channels 1 and 2.
> +      Not all chips support resistance error correction on external
> +      channels 1 and 2, please consult the documentation.
> +      Omit this tag to disable REC for channels 1 and 2 by default.
> +    type: boolean
> +    
> +  microchip,recd34:
> +    description: |
> +      Enable resistance error correction for external channels 3 and 4.
> +      Not all chips support resistance error correction on external

Then this should be restricted per compatible in allOf:if:then:.

> +      channels 3 and 4, please consult the documentation.
> +      Omit this tag to disable REC for channels 3 and 4 by default.
> +    type: boolean
> +    
> +  label:
> +    description: Unique name to identify which device this is.


> +    
> +  vdd-supply: true
> + 
> +patternProperties:
> +  "^channel@[1-4]+$":

4 or 44? Drop +

> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Represents the external temperature channels to which a remote diode is
> +      connected.
> +    type: object
> +
> +    properties:
> +      reg:
> +        items:
> +          minimum: 1
> +          maximum: 4
> +      
> +      microchip,ideality-factor:
> +        description: |
> +          Each channel has an ideality factor.
> +          Beta compensation and resistance error correction automatically correct
> +          for most ideality error. So ideality factor does not need to be adjusted in general.
> +          Omit this tag in order to set the default value.

default: X

> +          Please consult the documentation if one wants to set a specific ideality value.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +      
> +      label:
> +        description: Unique name to identify which channel this is.
> +    
> +    required:
> +      - reg
> +    
> +    unevaluatedProperties: false

additionalProperties or reference appropriate schema for subnode.

> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        
> +        temperature-sensor@4c {
> +            compatible = "microchip,mcp9985";
> +            reg = <0x4c>;
> +            
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            label = "temperature-sensor";
> +            
> +            microchip,temp-hysteresis = <10>;
> +            microchip,extended-temp-range;
> +            microchip,apdd-state;
> +            microchip,recd12;
> +            microchip,recd34;
> +            vdd-supply = <&vdd>;
> +            
> +            channel@1{

Missing spaces. Please see DTS coding style or any DTS style.



Best regards,
Krzysztof

