Return-Path: <linux-iio+bounces-23167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD060B32A7A
	for <lists+linux-iio@lfdr.de>; Sat, 23 Aug 2025 18:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4132C3B5500
	for <lists+linux-iio@lfdr.de>; Sat, 23 Aug 2025 16:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320091F4C87;
	Sat, 23 Aug 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fvxG50VS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634BE1F948
	for <linux-iio@vger.kernel.org>; Sat, 23 Aug 2025 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965211; cv=none; b=E0jqR8Jpe5zkO+7RSpIT5YO99t5P3QwuBDzAvoCoeNYxKrgWu+UOhoity70zgGLMfGUNq4b2Qj9LvtpQAoyG5q24wjNY0cpWSD0AP/5WusxywRs1y+OckJ/XwggCieqlZvVLFK7KsuQ7uFHCwz782YY/eMQWv1/QPUcsFwluBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965211; c=relaxed/simple;
	bh=X1TmEq/uHKxFLbVs7AoCOdEDfHSKfGMWoOxHyk317mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sh+baVIe5reZl/xv4QmpfxJ16UXlQXKM5aU6LGHk4ClqElXNLkCDFqOinPBNW9qpgHDqcPDiHpOXAR1gohgOpIpmP0fDyPtb59m2QvbltYFLOiNBl2OkrpOMJxXOAyxzXmlyTQ+ushhCOhsWFDBgErp1h6PtiCqgae0ut27ODtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fvxG50VS; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-314f332e064so445586fac.2
        for <linux-iio@vger.kernel.org>; Sat, 23 Aug 2025 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755965208; x=1756570008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4xWDjHy7dybMcTQgi+MIUcku3Kv1UYV6zDqpzfzc0C0=;
        b=fvxG50VSVeM9ApW4J+vb5ZOPnalJ1fnja5kAqzyS4RUoiOpP2DnWLdeC8nhnpP9tAp
         AT+ciptx63xM3vRTzkAbMJHumPXaWFfG/hYngIX/I6xjdWZo1JskawMubFsxPtg0Nh6j
         cRhB6IomqGzDJio11d9TP6XSEuorAqadDFc/jdLSoofqjjupV9EAt00tymj+YMWKqWCr
         w4uLW4zjhQWy3jw69ZS+h3P+GN7pirM7kVDcAmnXE5f9YAtEx/i/2uSauvoqlYDHzkPW
         AM+FSEw6F/wql7UV1SKUv/5uxLDvi2fF+oRxse9IAM8y29WUfSzYbY4h+70tr/5qG/Ir
         vGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755965208; x=1756570008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xWDjHy7dybMcTQgi+MIUcku3Kv1UYV6zDqpzfzc0C0=;
        b=p8hFQbYIJnuSh96Eo7oQ64/xI9ohPsaIiqg3a+3+WSodmJuZVkh/jUTv4e/L9N+t89
         e7jMdc799zvvssEmfw5po6cqhhxHPBqAtmUo5Y1bbOR9UzH1+yR9Z5RN6v06ZG0tvZf2
         K3FlRPFJHvC1llKVFAq1Vld6guaVQtVi0Ic+Qy9q26aiMGO6Lq4306DM+cycu2gm4Ovj
         Ilj3cTCLsFHH7sbaBQPjc1e2kZ+VKNbQkNi5wTFpNoGhweeaqYPczC0K7RfqJSF8kRP8
         w09vJyAjckbzue9yxHaNfkx7Vx4fE/dfM5PK7zIUDklOQ1j84SkVkHyhVQWw1Zsyf2Fa
         beYQ==
X-Gm-Message-State: AOJu0YxVgj15pbQTSMCoZjQRdprSErDAdR/9vp+n4z2wyP4/U1QijLnu
	yYL9X64EdI9A4E6winnipQwfLPOULX5MfxNuG1BMcaCo4i/jdb2qhAMDZ2rni5yL6JQ=
X-Gm-Gg: ASbGncuHTS0xGjEPKHdgMqTBACUMb/PiceH3VpuYYfPaQ3/WY+50ecyxavpqPgWpHvl
	kSAfMGqCedmveWQvMavnPsaDA6DK5SPD+3Qgfj+rsPhQ4G+8Hp2u96iXmmX0DiuLmW5fdVryAUE
	MdoDPUxb6yVxSxrLmVTOeYDSd5PptxIv+fqrwkRLAP5gXjqPvpyTV+5U/1TMvzDSGVbNM1XxynT
	6HeiHP/EWAyeUXgXoDH/8p26dg0AQrBvWGHADrNKHg9EVPLQa9d+EzF8NObXvH4AIErt4y9WQuF
	B7vDhYy4ByzR+CTazAkWpLl124nFljD82A/AhBj7qO55zaPuWuUhVyaSYvQTTKpxccjPsAtN1TL
	Y8V3SJN7WSBe9n6vcw4O+9z/gEHOtJOlBwjeaeup4+vwscsMa4FFpwoIRdBwFPSOiO3a6LZUZ
X-Google-Smtp-Source: AGHT+IFh1RdEOG+NrL+CtSosGlDMB5qW20v9HRwXhWw7QRFD7qwUhzzJWpPfwqdd7bOpnUVWO1bfvQ==
X-Received: by 2002:a05:6808:4fe7:b0:435:8535:c0cd with SMTP id 5614622812f47-4378526c6dbmr2916641b6e.2.1755965208410;
        Sat, 23 Aug 2025 09:06:48 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4d25:af10:67ec:53d? ([2600:8803:e7e4:1d00:4d25:af10:67ec:53d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437969221dfsm383033b6e.33.2025.08.23.09.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 09:06:48 -0700 (PDT)
Message-ID: <a3f26804-d9fc-4e17-8485-40dfdc4e1eb7@baylibre.com>
Date: Sat, 23 Aug 2025 11:06:46 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/5] dt-bindings: iio: mcp9600: Set default 3 for
 thermocouple-type
To: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250822-upstream-changes-v8-0-40bb1739e3e2@watter.com>
 <20250822-upstream-changes-v8-1-40bb1739e3e2@watter.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250822-upstream-changes-v8-1-40bb1739e3e2@watter.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/25 8:23 AM, Ben Collins wrote:
> As is already documented in this file, Type-K is the default, so make
> that explicit in the dt-bindings.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> index d2cafa38a5442e229be8befb26ae3f34bae44cdb..57b387a1accc776683500949a22ef0290fc876e8 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> @@ -37,6 +37,7 @@ properties:
>  
>    thermocouple-type:
>      $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 3
>      description:
>        Type of thermocouple (THERMOCOUPLE_TYPE_K if omitted).
>        Use defines in dt-bindings/iio/temperature/thermocouple.h.
> 

Reviewed-by: David Lechner <dlechner@baylibre.com>

