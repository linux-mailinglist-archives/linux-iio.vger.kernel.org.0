Return-Path: <linux-iio+bounces-420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D21CF7F9B4B
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 09:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010031C208CD
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915A910A28;
	Mon, 27 Nov 2023 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zcdih+E0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA7413A
	for <linux-iio@vger.kernel.org>; Mon, 27 Nov 2023 00:06:57 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a02cc476581so512666666b.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Nov 2023 00:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701072416; x=1701677216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gLJ10lWr+VznaTgQQ6a2J82y9b9UDNLlA4e91ixO/YA=;
        b=Zcdih+E0wlco2Q8nzaqgvSWpFASDaSylKxMRE8f2lpJ0qQo1XZdrOTftPvMf9cWXmW
         apHAOE1FkJMu6FrfJWuCM/6AhEi+DUxn8qPNnWAU4ySqsIU5S5lsYjvZaHjLVuOw4yPh
         7gNaTJ1X1wEQ/mty1jl4aPbv7Ha7j5Q5FJ7iPiHDc/8F3zyzEj0jUGFRwY/ZFUBa9qV3
         x4n4zGlcYp4nCufWHLyZZcTyBCEoWVTMOt5bGOPb4sPLZjtAFhyEXR7L8netm7UoLTAr
         T3BRbsGrcQKAWVpl2coXLSc/6Q7jk1dkBqyWOWRbLBnzejtc+T9JIQY/ZAzRJJk8CLUl
         k23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701072416; x=1701677216;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLJ10lWr+VznaTgQQ6a2J82y9b9UDNLlA4e91ixO/YA=;
        b=hHGbXcGc9PjQq5CWrO/EIJ8d8zmRaYCc4pKKT0ZIHdJQpps52o/vKJ+48k2v0MSxZD
         AjFLeR/TxYMzK/UdxN8I8RA1mMVW/LWj20p2a8qeBdX4SbtnvlCupn7VGzKu78Y1jjHd
         N5t2ZGN3vEJb9DPfvMcocwNMCsqq4Xi2Ha3h6XWt/5FjT9MlfYCz1K79P02tx4xNfl41
         EOS+DLsWs6fuXUdrxJHIbIUzKgGpTJ+BdGq+Eflq6EjMefPYmGZ7ZIMC7Nycz6EeHUEd
         kbpSwSRNOlpTTpeMKIteZl356L59k0l4uSKB0YyNkcuhTQnrM2zlraiyxRVO59uVVL26
         YlmA==
X-Gm-Message-State: AOJu0YweMqrDWIFIuUjU13EbyATnTVrD3HvsIVIyrDZdjtF0pUyoeRQB
	LF1Gp9n8MicxmFxI/gfvUnjpnw==
X-Google-Smtp-Source: AGHT+IF8Ps9R1WYpdO8vYfUDoR4wf/og+YZDh/wvMcqOTLU/2G4jjiC/mQi387mIRyyuPR9XlyIRmw==
X-Received: by 2002:a17:906:747:b0:9e2:af47:54c9 with SMTP id z7-20020a170906074700b009e2af4754c9mr7770136ejb.19.1701072415788;
        Mon, 27 Nov 2023 00:06:55 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id uz2-20020a170907118200b00a098348d803sm3986237ejb.141.2023.11.27.00.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 00:06:55 -0800 (PST)
Message-ID: <8641e35a-d481-4c27-b450-9ee72ae769b5@linaro.org>
Date: Mon, 27 Nov 2023 09:06:54 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Content-Language: en-US
To: Petre Rodan <petre.rodan@subdimension.ro>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Jonathan Cameron <jic23@kernel.org>
References: <20231126101443.13880-1-petre.rodan@subdimension.ro>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231126101443.13880-1-petre.rodan@subdimension.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2023 11:14, Petre Rodan wrote:
> Adds binding for digital Honeywell TruStability HSC and SSC series
> pressure and temperature sensors. 
> Communication is one way. The sensor only requires 4 bytes worth of
> clock signals on both i2c and spi in order to push the data out.
> The i2c address is hardcoded and depends on the part number.
> There is no additional GPIO control.


> +
> +  honeywell,transfer-function:
> +    description: |
> +      Transfer function which defines the range of valid values delivered by
> +      the sensor.
> +      0 - A, 10% to 90% of 2^14
> +      1 - B, 5% to 95% of 2^14
> +      2 - C, 5% to 85% of 2^14
> +      3 - F, 4% to 94% of 2^14

You need enum here as well

> +    $ref: /schemas/types.yaml#/definitions/uint32



> +
> +  honeywell,pmin-pascal:
> +    description: |
> +      Minimum pressure value the sensor can measure in pascal.
> +      To be specified only if honeywell,pressure-triplet is set to "NA".
> +    $ref: /schemas/types.yaml#/definitions/int32
> +
> +  honeywell,pmax-pascal:
> +    description: |
> +      Maximum pressure value the sensor can measure in pascal.
> +      To be specified only if honeywell,pressure-triplet is set to "NA".
> +    $ref: /schemas/types.yaml#/definitions/uint32

Sent a pull request:
https://github.com/devicetree-org/dt-schema/pull/118
Once it get merged, both $ref could be dropped.

Best regards,
Krzysztof


