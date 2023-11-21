Return-Path: <linux-iio+bounces-231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148E87F2DEA
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 14:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCB41C209DD
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 13:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BE34643D;
	Tue, 21 Nov 2023 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVhleeve"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6885AD58
	for <linux-iio@vger.kernel.org>; Tue, 21 Nov 2023 05:04:47 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9fcfd2a069aso327861466b.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Nov 2023 05:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700571886; x=1701176686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJNLrkJhw983BGoRtAEsSHa8vmQeC8HVGtAZzgpBYJ4=;
        b=VVhleeve4e+I5zhttk3EmolYX1IAJbAirCbs50Bi3jUQeHZw9XXA7kO+I6gVKnf3Zl
         MT4/N8POYKQCurQs1LKaI5r52PuutcU9t8pFCo4/53ljyISh4DxCVjFW6L0sPkhGfwiI
         oWdsmcsUk6PQaBEqX8fqZZxa5SC4AEFWtA9CSMMylgw/p6Xwvv8j45f1RRHlwQkqAk4V
         wH+SSQ0dMfHXew4BjyRLzhSCnRnCu1stBrNIIdUCnZvdq1mxtpIyAdUWhHhqaUUODZlc
         NruMfcQeU17GGpGe60UHeOTReCORD4igIydHsU+ElTv1IT/kg8Tae9nu1ntoyfwh2uhs
         5ZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700571886; x=1701176686;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJNLrkJhw983BGoRtAEsSHa8vmQeC8HVGtAZzgpBYJ4=;
        b=Kb3xU5VPCFsxgBvLmg/X3lxn4XdX4hrTIq5X2awzyG/YRF5OTqK7xv48CXq75UKsrB
         slQzKFEHG0IIMhpIwLHVdmx5C5N+hF2lI7Oh39+LikRY/nR1Hf0djfuAv8dJkezKjZYY
         jWeYICiTJhjCDbUCXZmqTEZshVHDgYJFAN+mCV44rK/nSsSDZewlReMUGDqsIHd0U6z8
         1ytjxUBGtzDGGjRWtNxntmVZJ60om4wPAxBN+c7yv4EgIP9ZVtqhsQ//VC9hER/q4hrL
         +24HROQ6ZzuCAbqO/AZOALzUUoFQ2Sq5aIvG8+Nl9xRdc3kZrmbw47IFA1D7chtNRlVF
         WK6Q==
X-Gm-Message-State: AOJu0YxNAjKeRNp6OBVNnkV6RJWxJdPje/SnjeZZ9A3RFGzyctz8iozU
	1jyyhvBRdc3xxt2B3ZGPf44KUg2QGtmtQ4WVjqs=
X-Google-Smtp-Source: AGHT+IGMCD22fRf/LICxTRr0ykRJ40IRgqPHAZTBDyvGyNr9RJYChvFNLUA+x2O3j6uqbusy8W9sPQ==
X-Received: by 2002:a17:906:7d0:b0:9fe:458e:a813 with SMTP id m16-20020a17090607d000b009fe458ea813mr3966392ejc.73.1700571885883;
        Tue, 21 Nov 2023 05:04:45 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id la5-20020a170906ad8500b009fc8f309183sm3152196ejb.51.2023.11.21.05.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 05:04:45 -0800 (PST)
Message-ID: <c4f31613-8365-4d4d-a3ec-1b573f822968@linaro.org>
Date: Tue, 21 Nov 2023 14:04:44 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: frequency: add admfm2000
Content-Language: en-US
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231121100012.112861-1-kimseer.paller@analog.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231121100012.112861-1-kimseer.paller@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2023 11:00, Kim Seer Paller wrote:
> Dual microwave down converter module with input RF and LO frequency
> ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> for each down conversion path.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
> V1 -> V2: Removed '|' after description. Specified the pins connected to
>           the GPIOs. Added additionalProperties: false. Changed node name to gpio.

Why? Is this a GPIO? Your bindings title say this is a converter, not a
GPIO.

>           Aligned < syntax with the previous syntax in the examples.
> 
>  .../bindings/iio/frequency/adi,admfm2000.yaml | 130 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> new file mode 100644
> index 000000000000..92a7736c6eeb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> @@ -0,0 +1,130 @@
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
> +    Dual microwave down converter module with input RF and LO frequency ranges
> +    from 0.5 to 32 GHz and an output IF frequency range from 0.1 to 8 GHz.
> +    It consists of a LNA, mixer, IF filter, DSA, and IF amplifier for each down
> +    conversion path.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,admfm2000
> +
> +  switch1-gpios:
> +    description:
> +      Must contain an array of 2 GPIO specifiers, referring to the GPIO pins

Not much improved here - you still repeat the constraints.

> +      connected to the B15 and B16.
> +    minItems: 2
> +    maxItems: 2

Instead all this:
  items:
    - description: B15 GPIO something something doing something
    - description: B16 GPIO something something doing some switching

> +
> +  switch2-gpios:
> +    description:
> +      Must contain an array of 2 GPIO specifiers, referring to the GPIO pins
> +      connected to the L14 and K14.
> +    minItems: 2
> +    maxItems: 2
> +
> +  attenuation1-gpios:
> +    description:
> +      Must contain an array of 5 GPIO specifiers, referring to the GPIO pins
> +      connected to the C14, C15, C16, D14, and D15.
> +    minItems: 5
> +    maxItems: 5
> +
> +  attenuation2-gpios:
> +    description:
> +      Must contain an array of 5 GPIO specifiers, referring to the GPIO pins
> +      connected to the L15, L16, M14, M15, and M16.
> +    minItems: 5
> +    maxItems: 5
> +
Best regards,
Krzysztof


