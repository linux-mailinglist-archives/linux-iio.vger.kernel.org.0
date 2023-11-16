Return-Path: <linux-iio+bounces-103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969D07EE068
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 13:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A081F244B5
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 12:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6131B2DF91;
	Thu, 16 Nov 2023 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bm50j8mw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051921A5
	for <linux-iio@vger.kernel.org>; Thu, 16 Nov 2023 04:08:19 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a81ab75f21so7798047b3.2
        for <linux-iio@vger.kernel.org>; Thu, 16 Nov 2023 04:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700136498; x=1700741298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AzqVKfInmMwmubdRC02oh2g2HmLf2Gm7CSrF5ZLMm0I=;
        b=bm50j8mwUptEe74vJJUP2dtWuzRbEwVF8C8JJFryFg1nwDohjKNflH/tnjENqkIHFy
         34VS9bsowO3O52nVk4bCCSIiL/jqrH6u5qUaZ9SitEkjreZBNbBRYpI6N7K4SAvMiAp0
         gKpXD16tqdyL81RU/xrVuHowU+hJYUP8kPeYJ2YOTmN8IZ9LEUFzoyJfx7xIEMr8Dmb8
         +FWlonEhftzB6BQHEmSKbVnpFmx2gXq/YHMvh9Cp5paYDxZ5Po1LDwlqpCZ5ED4ehwgr
         x+1Shlsh53sBISNVle5KiiznRny/lTBn3Ayn92fdqMjbDq+jlcquHPNmNI+tj6Ha7s+e
         OcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700136498; x=1700741298;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AzqVKfInmMwmubdRC02oh2g2HmLf2Gm7CSrF5ZLMm0I=;
        b=BPlyJfCV0TuUzZbVSTL878/aRfZXs8SY/k/6O/2io08e5sExfFf6Eo4XW+R4oKNI06
         7tlwgeqmeNg4ybWus7eUqvg+TI1GReMYH6VnmmpvGJ8+LxD/GB+KkXrnMLPrtfDPD0CB
         aQK6I4DvYDwgSApUUbNPliiEp7eeYK8kQ68EzzopzsPYMJy4rqPK02c+jhcRHCW1vcc1
         pvhShhbWbqziQY2VcbIw1YrF9KB7e7yvwlgEQFt2JAgfXavmPnWjkUD746ycMsyulIP0
         Ga7/4mDTcSJlffBpy5HwGt7JVWhLmmqpVYG9WSB7/GNyhudKTrxQGsq/q+XifDk0ugOm
         E2Ag==
X-Gm-Message-State: AOJu0YyVGGGWto0VPCLUSuAkW1qup5FEM3b1C/6lBPG/s6jkVJjyk9VE
	ROFiStJsdBXRjpYCBvdYNif5Iw==
X-Google-Smtp-Source: AGHT+IEYHLbBOEhxirBBTBLnlWcSD1mz8I0Zdnbn7w9rDakgIRZaAjZh+A5v7mUwBj5fQIOslEkQ7g==
X-Received: by 2002:a25:44c4:0:b0:d81:894b:28e4 with SMTP id r187-20020a2544c4000000b00d81894b28e4mr13914953yba.51.1700136498205;
        Thu, 16 Nov 2023 04:08:18 -0800 (PST)
Received: from [192.168.212.13] ([12.191.197.195])
        by smtp.gmail.com with ESMTPSA id cz1-20020a056214088100b00671b009412asm1302334qvb.141.2023.11.16.04.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 04:08:17 -0800 (PST)
Message-ID: <c47558c8-58e0-4f97-b873-d37f2788a6ec@linaro.org>
Date: Thu, 16 Nov 2023 13:08:09 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: frequency: add admfm2000
Content-Language: en-US
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231116005643.245314-1-kimseer.paller@analog.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231116005643.245314-1-kimseer.paller@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/11/2023 01:56, Kim Seer Paller wrote:
> Dual microwave down converter module with input RF and LO frequency
> ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> for each down conversion path.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---

...

> +
> +title: ADMFM2000 Dual Microwave Down Converter
> +
> +maintainers:
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

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

That's obvious. Instead say which pins are this.

> +      connected to the channel 1 switch controls.
> +    minItems: 2
> +    maxItems: 2
> +
> +  switch2-gpios:
> +    description:
> +      Must contain an array of 2 GPIO specifiers, referring to the GPIO pins
> +      connected to the channel 2 switch controls.
> +    minItems: 2
> +    maxItems: 2
> +
> +  attenuation1-gpios:
> +    description:
> +      Must contain an array of 5 GPIO specifiers, referring to the GPIO pins
> +      connected to the channel 1 DSA attenuation controls.
> +    minItems: 5
> +    maxItems: 5
> +
> +  attenuation2-gpios:
> +    description:
> +      Must contain an array of 5 GPIO specifiers, referring to the GPIO pins
> +      connected to the channel 2 DSA attenuation controls.
> +    minItems: 5
> +    maxItems: 5
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

Missing additionalProperties: false. Look at other bindings.

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
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    admfm2000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +      compatible = "adi,admfm2000";
> +
> +      switch1-gpios = <&gpio 1 GPIO_ACTIVE_LOW>,
> +        <&gpio 2 GPIO_ACTIVE_HIGH>;

Align this with previous <

> +
> +      switch2-gpios = <&gpio 3 GPIO_ACTIVE_LOW>,
> +        <&gpio 4 GPIO_ACTIVE_HIGH>;
> +
Best regards,
Krzysztof


