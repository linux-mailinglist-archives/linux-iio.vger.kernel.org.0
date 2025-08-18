Return-Path: <linux-iio+bounces-22896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DF4B299A3
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 08:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111F83BDFA0
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 06:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B99274B3B;
	Mon, 18 Aug 2025 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXX7rlwG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4338C274B2A;
	Mon, 18 Aug 2025 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755498518; cv=none; b=oq61LStyKgbgtsYqGXIN9BTnoeFHAIvXlp6Yfv8TH4XdMzzg0rOctKxLq4OqGwC/PIH5NY/yGb+AKr+brPVJs+KBrtoQjxt1sL51gtv1/NeTNpXJVuGi8W7ol4CiaT1P31Db9CoIFAHCWEkMChJgkH8RDnJqko5w6N0nDhqEX3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755498518; c=relaxed/simple;
	bh=FbnbRZKMKBATM5dvzv+W2sjK0yQmb8OPQUc1DWS/VfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ha1axgJZgpi04EL59rmez6HyTu/kxBsPVfGsXZ/IqeSDd5kgyu1I29x9ylrPrkGHa4iApbkEdxi7wRe+QGf3zgBgzvxg9rBa9bgD3x613YzoJpe9+DInnw/QsCrg4JXDFLbmsZZh4KdFnHpbHI1tNuq2Zc9LEaC87Vhp/+JlnAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXX7rlwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB3AC4CEEB;
	Mon, 18 Aug 2025 06:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755498515;
	bh=FbnbRZKMKBATM5dvzv+W2sjK0yQmb8OPQUc1DWS/VfU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kXX7rlwGNPiBoG60NaZqwQwFlkxv2WTgjnhU0z3rnUKWeWKd+WH99dCuO8TNHoONj
	 GpQYTdFJ6OocGe2SySu2aTee/TTQC7hffh0FxWumPoE5nQmVmlGV09rlhzSHUA2jWb
	 FzzGMZ6zKs4roT5mlJVcbMYBT+JUXDEJKi3tPPgH22AIBpLiZM8x7P1Tq+P540PkZ/
	 cUz1KLDb5OIbBkfkujvM+5hSjS8rQmO4W6WIDBA+rpJeEu+HU2bh5b2uY0rBB8X0LI
	 2eWr5OLbm2PuusaLsLVJWtY8YMmCQtVgh8NOHpYowl/XKVDyA/yxXh7HVWJ92hSa5i
	 yYgHXQtKaWqnw==
Message-ID: <cb826943-69d8-4fc9-8597-fbb2439f04f2@kernel.org>
Date: Mon, 18 Aug 2025 08:28:30 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] dt-bindings: iio: mcp9600: Add microchip,mcp9601
 and add constraints
To: Ben Collins <bcollins@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: Ben Collins <bcollins@watter.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818035953.35216-1-bcollins@kernel.org>
 <20250818035953.35216-2-bcollins@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250818035953.35216-2-bcollins@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/08/2025 05:59, Ben Collins wrote:
> From: Ben Collins <bcollins@watter.com>
> 
> The mcp9600 driver supports the mcp9601 chip, but complains about not
> recognizing the device id on probe. A separate patch...
> 
> 	iio: mcp9600: Recognize chip id for mcp9601
> 
> ...addresses this. This patch updates the dt-bindings for this chip to
> reflect the change to allow explicitly setting microchip,mcp9601 as
> the expected chip type.
> 
> The mcp9601 also supports features not found on the mcp9600, so this
> will also allow the driver to differentiate the support of these
> features.
> 
> In addition, the thermocouple-type needs a default of 3 (k-type). The
> driver doesn't support this, yet. A later patch in this series adds it:
> 

None of this driver argument here and earlier is relevant. Please
describe the hardware and reasons behind this patch.

> 	iio: mcp9600: Add support for thermocouple-type
> 
> Lastly, the open/short circuit functionality is dependent on mcp9601
> chipsset. Add constraints for this and a new property, microchip,vsense,
> enables this feature since it depends on the chip being wired
> properly.
> 
> Passed dt_binding_check.

Drop, not relevant. You do not have to say that you built your code. You
must build your code.

> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---
>  .../iio/temperature/microchip,mcp9600.yaml    | 69 +++++++++++++++----
>  1 file changed, 56 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> index d2cafa38a5442..1caeb6526fd20 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9600.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Microchip MCP9600 thermocouple EMF converter
> +title: Microchip MCP9600 and similar thermocouple EMF converters
>  
>  maintainers:
>    - Andrew Hepp <andrew.hepp@ahepp.dev>
> @@ -14,29 +14,30 @@ description:
>  
>  properties:
>    compatible:
> -    const: microchip,mcp9600
> +    oneOf:
> +      - const: microchip,mcp9600
> +      - items:
> +          - const: microchip,mcp9600
> +          - const: microchip,mcp9601
>  
>    reg:
>      maxItems: 1
>  
>    interrupts:
>      minItems: 1
> -    maxItems: 6
> +    maxItems: 4

Why?
I did not find explanation of this in commit msg.

>  
>    interrupt-names:
>      minItems: 1
> -    maxItems: 6
>      items:
> -      enum:
> -        - open-circuit
> -        - short-circuit
> -        - alert1
> -        - alert2
> -        - alert3
> -        - alert4
> +      - const: alert1
> +      - const: alert2
> +      - const: alert3
> +      - const: alert4

Neither this and it is ABI break. ABI breaking needs clear reasoning why
and some evaluation of impact on users.


>  
>    thermocouple-type:
>      $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 3
>      description:
>        Type of thermocouple (THERMOCOUPLE_TYPE_K if omitted).
>        Use defines in dt-bindings/iio/temperature/thermocouple.h.
> @@ -44,6 +45,33 @@ properties:
>  
>    vdd-supply: true
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,mcp9601
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 1
> +          maxItems: 6
> +        interrupt-names:
> +          items:
> +            - const: alert1
> +            - const: alert2
> +            - const: alert3
> +            - const: alert4
> +            - const: open-circuit
> +            - const: short-circuit
> +        microchip,vsense:
> +          default: false

There is no default for bool.

> +          description:
> +            This flag indicates that the chip has been wired with VSENSE to
> +            enable open and short circuit detect. By default, this is false,
> +            since there's no way to detect that the chip is wired correctly.

Properties should be defined in top level. Here you only disallow them
(see example schema).

> +          type: boolean
> +
>  required:
>    - compatible
>    - reg
> @@ -62,9 +90,24 @@ examples:
>              compatible = "microchip,mcp9600";
>              reg = <0x60>;
>              interrupt-parent = <&gpio>;
> -            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> -            interrupt-names = "open-circuit";
> +            interrupts = <25 IRQ_TYPE_EDGE_RISIN>;
> +            interrupt-names = "alert1";
>              thermocouple-type = <THERMOCOUPLE_TYPE_K>;
>              vdd-supply = <&vdd>;
>          };
>      };
> +  - |
> +    #include <dt-bindings/iio/temperature/thermocouple.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        temperature-sensor@60 {
> +            compatible = "microchip,mcp9601", "microchip,mcp9600";
> +            microchip,vsense;
> +            reg = <0x62>;
> +            interrupt-parent = <&gpio>;

Incomplete interrupts.

> +            vdd-supply = <&vdd>;
> +        };
> +    };


Best regards,
Krzysztof

