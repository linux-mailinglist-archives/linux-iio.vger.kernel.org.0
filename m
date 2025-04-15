Return-Path: <linux-iio+bounces-18141-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE29A8A60A
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 19:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A7016A29A
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 17:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692E321D3EA;
	Tue, 15 Apr 2025 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tr/R4gwl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22556136E37;
	Tue, 15 Apr 2025 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739529; cv=none; b=ca5chjHG5N54pJZOTrnuXEkJuQJUlzHyIZ8HQOQ/oHK8Rpoh6RVtYSqj4SSkln1XpGxt/6GXzbMgBC5xw2Vcnt8+9YeXEPLPASZX8bas6JQ+G8nQieu3xMTikysaI0k+53pW3T8WGwOxJkITYntChcsa7GItngDZSTUmFes+2Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739529; c=relaxed/simple;
	bh=RQoQseg/+U+g9e30dznS6KwLoPKb1ll48CUVIcQsrNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nx1EwOi8IKtRmkxHPRD+kJus17EoF4XSbEhNffPgVLA4jpwGlrjynQPBx5/FrB1S+XdWCkQ+txfuzX4rUu5EvlnSFmuoc9sNe9X1TV/QEsKuflbJByQxtqLrJuKXaoGrtxTv2K5Iw3eQaSVIo6XE8DXo/xYJoNljmeRf5NRWE0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tr/R4gwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03F7C4CEE9;
	Tue, 15 Apr 2025 17:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744739528;
	bh=RQoQseg/+U+g9e30dznS6KwLoPKb1ll48CUVIcQsrNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tr/R4gwlaEgaBLaOhu8IiEn/dTQPHsbZJxH2R6e/pO1s5GDf/Fyfm0CVziIemq9Gu
	 dXtWedaPrk2P9WJPctRRSpZJVZgk6I7+3/1hBgdvGiLTFQBZjSYwEbmmOzPC7QTOs5
	 wvn8DMpJUDPwUj+WYruME3FYFW74567g/p9WWvqXiRHS+Og8zKalK1TX5eMywze/Qq
	 tZ/W2UaTDO66uEnLtJNcnDPXCW7+Gl3mMAl3ORnO7vCySscYzrpmCeePWnaNTP/sTE
	 jIZVZBR8o5/jznAWErAmllxHb/O6UydhIOXtmQPetpnpOZ93aVMXgE14AuKGTvYHyf
	 AEZ4NtfzSL6Tw==
Date: Tue, 15 Apr 2025 18:52:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <victor.duicu@microchip.com>
Cc: <andy@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <marius.cristea@microchip.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
Message-ID: <20250415185200.396d6356@jic23-huawei>
In-Reply-To: <20250415132623.14913-2-victor.duicu@microchip.com>
References: <20250415132623.14913-1-victor.duicu@microchip.com>
	<20250415132623.14913-2-victor.duicu@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 16:26:22 +0300
<victor.duicu@microchip.com> wrote:

> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This is the devicetree schema for Microchip MCP998X/33 and
> MCP998XD/33D Multichannel Automotive Temperature Monitor Family.
Hi Victor,

Please state briefly here in what way the parts are incompatible
as a justification for no fallback compatibles.  Quite a bit
of that will become apparent when you enforce validity of parameters
as suggested below.

Various comments inline.
> 
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
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
> +      - const: ALERT2
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

Can we just make this a userspace thing using appropriate _hysteresis ABI element?


> +    
> +  microchip,extended-temp-range:
> +    description: |
> +      Set the chip to work in the extended temperature range -64 degrees C to 191.875 degrees C.
> +      Omit this tag to set the default range 0 degrees C to 127.875 degrees C
> +    type: boolean

I'm curious.  Why does this belong in the DT binding?

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

Why is this a hardware thing that belongs in dt?  Enforce the constraint
in the schema rather than text.

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

This one is unusual.  Maybe a little more description (I looked it up
and am fine with why this is in DT)

> +    type: boolean
> +    
> +  microchip,recd12:
> +    description: |

No need for | on paragraphs where formatting doesn't need to be maintained.

> +      Enable resistance error correction for external channels 1 and 2.
> +      Not all chips support resistance error correction on external
> +      channels 1 and 2, please consult the documentation.

Enforce it in the schema, no need to say that chips don't support it
in text. Look at the various allOf statements with compatible matches
in other bindings for how to do that.

> +      Omit this tag to disable REC for channels 1 and 2 by default.
> +    type: boolean
> +    
> +  microchip,recd34:
> +    description: |
> +      Enable resistance error correction for external channels 3 and 4.
> +      Not all chips support resistance error correction on external
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
> +    description: |
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

wrap at 80 chars. Also try to avoid explicit formatting where it isn't needed.

> +          Omit this tag in order to set the default value.
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
> +                reg = <0x1>;
> +                label = "CPU Temperature";
> +            };
> +            
> +            channel@2{
> +                reg = <0x2>;
> +                label = "GPU Temperature";
> +            };
> +        };
> +    };
> +
> +...


