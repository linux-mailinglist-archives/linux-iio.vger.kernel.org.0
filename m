Return-Path: <linux-iio+bounces-23166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43021B32A77
	for <lists+linux-iio@lfdr.de>; Sat, 23 Aug 2025 18:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8841897F20
	for <lists+linux-iio@lfdr.de>; Sat, 23 Aug 2025 16:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF9420297E;
	Sat, 23 Aug 2025 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Qdg2WYrS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7331DB375
	for <linux-iio@vger.kernel.org>; Sat, 23 Aug 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965195; cv=none; b=jaHnXixUXK9iDfqD2qNVRX35+uOoq6fKmgoD5rDz5EEdPl2a6Yklh/W7vCgxVywIm4ome/tPm0HRoUZ6eU3c8eNnqELooGY0rFAQwMojrKM0iy2F5zgeoTFeo+B5WUAyL7/iCmePFf2g5J3j/2zORSOZCR8bMPOWlBqEC32A7Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965195; c=relaxed/simple;
	bh=ebM0IdDULzwaHyK8sfmNQvqNW9VpejYpzO1DUZFcvuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkTJYid7Jdk0dx0OxcsfmllzRll9wPuK4JGjBQG4qXrNXto/GwpaWD0R9BBYeuWXU0htSuMKtrYHFP9uhr6A8Uc0U2UKv6od7aM/Sk2uWoAc4InTO7XyhMozUx7jxHbIEgoSP5pV1xNRSPYPSIBYLoQHE08s0BlrFBAnine4fEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Qdg2WYrS; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-74381efd643so740094a34.1
        for <linux-iio@vger.kernel.org>; Sat, 23 Aug 2025 09:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755965192; x=1756569992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MH429/Xzff4T9QzrkUeAzGoqfBH4kBxhtsjO5g2qhx8=;
        b=Qdg2WYrSvcAEdw0hDQAuQZV30EddACkeYqfLKZitb7mTJRYnc9T1iBBDwHzrf4V9d4
         qRGlzbMp3q9BHRKftMJ0A4GuOst1LadbEZ4PrOqUNOEu+b98XaCZ4/Yjis3wBmZWobWg
         53NoRi3thvda1TLPPcbJk7Lk9AqYPO1v6aAjwb7brohRZQZjO4NPEz0jE7ZGhB5sKIZc
         dKA2zZxVRjnzOWLQLxkPkdgGXYv+8cYM4F9NZLDooPoZ9BjopK+ZLXMYmbuEMmHCoHy2
         NBfq2TLW0EvEWI5YblbrZGocwV7tSea5wtnbsVwofopR9zyvMuXvjPYWYifJTCmvtFSk
         j4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755965192; x=1756569992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MH429/Xzff4T9QzrkUeAzGoqfBH4kBxhtsjO5g2qhx8=;
        b=uo2AkeM5SH6ItZ0OoRKBfnvMsp4v+P6NYQ4VykK3XWXCSoFBYSmirSVreH3hs8Atsk
         hxqwaGZy86A3ajukj06H7wfHbhYBr1XhnR9aBBdwN4dKhorb3588tO7ZVl2G+dviYUkc
         jJOzi4JQxyfJ5QTRSN79C9JTK6ZdmgWbmxPkqTkEptTTELqZo6Z15WIo+Dr7P6QP6yZn
         fdyKi7sbwOzMQvN+5l4jAv/FT2qMEHi9ihbl/mIjKrdgx7VyjaR1slXevjSVVha4bGSi
         LJadHwAhaCqVb3uSSdSNc3tIm1Z6Iom/JgkLMnczTYX11D8r0r26oDklYGmHJQLRbnGa
         M9SQ==
X-Gm-Message-State: AOJu0Yzgj26LdWn/qaW5UbeC4JQOVqD828wO3mz2fd1rhKx9uBo4oSBu
	Wigq/MZG+dsr5HEiLWdjF6b+Gp52K1ULK5zM+5hkLWZltZn5jW+NTAFp4lkhwtmDQb8=
X-Gm-Gg: ASbGnctNVenBTF+5GBRGlwNhaGd3FCk85Xd6nzP1Of1w93MD+dUyd8cGOORSk90Wqjy
	P2NIr3v61VEagLMaq+0x1G450kKXllPQ8N0pipZ4EttVt5vuqF7rp+5ycggJEKrB4DtqvOEYD4d
	g7M+OfMemliRn5/vdZGT6HlsMky10tN1uuDXoTZSAMd+fHZTp7DlcnTv00C2yWoJLbUkMweZNOO
	xcS67tle75QPE+0X1aJyf6vPoju0ldlpdDYUx2lBPI6FhlBhezaKYYKcD9ohWHbuw8uPfS7XbXW
	RzNr2o6hxNPkIl22Ncnb1cO+/CNPsOUqTWplrFIuWZ569tbfzEHWDQt7rQ/BfctZ1Sr3qB7w7YE
	tuRgT44aRromkmiJoZOZ1mA58WklVVa9nwZpgekh1eKwfaSXdi6cPx/t//UB+HwdftsEHu57c
X-Google-Smtp-Source: AGHT+IEyRUbE9O2Dou5JQoL703SRQU0rAXzxfBj2sNtV84omC7i2T9OV2vhzOcAE7/ImVyLQKsdiWA==
X-Received: by 2002:a05:6830:2a16:b0:741:aa58:d500 with SMTP id 46e09a7af769-7450098d167mr3600537a34.3.1755965191927;
        Sat, 23 Aug 2025 09:06:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4d25:af10:67ec:53d? ([2600:8803:e7e4:1d00:4d25:af10:67ec:53d])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61dc7470b02sm354328eaf.0.2025.08.23.09.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 09:06:31 -0700 (PDT)
Message-ID: <f7089447-f164-406b-8e59-3bd3e8f94d59@baylibre.com>
Date: Sat, 23 Aug 2025 11:06:30 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] dt-bindings: iio: mcp9600: Add microchip,mcp9601
 and add constraints
To: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250822-upstream-changes-v8-0-40bb1739e3e2@watter.com>
 <20250822-upstream-changes-v8-2-40bb1739e3e2@watter.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250822-upstream-changes-v8-2-40bb1739e3e2@watter.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/25 8:23 AM, Ben Collins wrote:
> Add microchip,mcp9601 compatible in addition to the original
> microchip,mcp9600 to designate support between these two chips.
> 
> The current dt-binding has open-circuit and short-circuit as interrupt
> names, but these are only supported in mcp9601.
> 
> The OC and SC detection requires that mcp9601 VSENSE be wired up, which
> not only enables the OC SC interrupts, but also the OC and SC status
> register bits.
> 
> Add a microchip,vsense boolean to show the chip is wired for this
> support.
> 
> Add constraints so this feature only applies if the mcp9601 compatible
> is selected.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../iio/temperature/microchip,mcp9600.yaml         | 56 ++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> index 57b387a1accc776683500949a22ef0290fc876e8..fb3661c805934255d35f664e1018ed2ec91d05f0 100644
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
> @@ -14,7 +14,11 @@ description:
>  
>  properties:
>    compatible:
> -    const: microchip,mcp9600
> +    oneOf:
> +      - const: microchip,mcp9600
> +      - items:
> +          - const: microchip,mcp9601
> +          - const: microchip,mcp9600
>  
>    reg:
>      maxItems: 1
> @@ -43,8 +47,37 @@ properties:
>        Use defines in dt-bindings/iio/temperature/thermocouple.h.
>        Supported types are B, E, J, K, N, R, S, T.
>  
> +  microchip,vsense:
> +    type: boolean
> +    description:
> +      This flag indicates that the chip has been wired with VSENSE to
> +      enable open and short circuit detect.
> +
>    vdd-supply: true
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              const: microchip,mcp9601
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 1
> +          maxItems: 4
> +        interrupt-names:
> +          minItems: 1
> +          maxItems: 4
> +          items:
> +            enum:
> +              - alert1
> +              - alert2
> +              - alert3
> +              - alert4
> +        microchip,vsense: false
> +
>  required:
>    - compatible
>    - reg
> @@ -64,8 +97,25 @@ examples:
>              reg = <0x60>;
>              interrupt-parent = <&gpio>;
>              interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> -            interrupt-names = "open-circuit";
> +            interrupt-names = "alert1";
>              thermocouple-type = <THERMOCOUPLE_TYPE_K>;
>              vdd-supply = <&vdd>;
>          };
>      };
> +  - |
> +    #include <dt-bindings/iio/temperature/thermocouple.h>

This header isn't used in this example.

> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        temperature-sensor@62 {
> +            compatible = "microchip,mcp9601", "microchip,mcp9600";
> +            reg = <0x62>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <22 IRQ_TYPE_EDGE_RISING>, <23 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-names = "open-circuit", "short-circuit";
> +            vdd-supply = <&vdd>;
> +            microchip,vsense;
> +        };
> +    };
> 

With that fixed:

Reviewed-by: David Lechner <dlechner@baylibre.com>


