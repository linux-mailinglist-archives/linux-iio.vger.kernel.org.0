Return-Path: <linux-iio+bounces-23814-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B6DB46473
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 22:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802261BC2AE1
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 20:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2749315D5F;
	Fri,  5 Sep 2025 20:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oWqt1hEw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A3E1E51E0
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 20:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103359; cv=none; b=BE6NpZOY+zhFXN9IpwyLUr/Qqo9ct/Chkj5w1UyQZ0lif48MsErzU89XavjD4sK57Xh2mAF00QSj3aSZHTo6fjXzMBT4e6UpLJYzdR4pHIsgIHlcem5KnOROE/DcqHOzHkM8KnUZeznQeWsoO5Iy7nXLe0fHpKzoePDVYqCpa8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103359; c=relaxed/simple;
	bh=hBkcy/QSlD3kZfRXdZy4SDXPyiJMaAghkZ8AujrnPZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBPt0M9PwjvqzHkIKZ1vwI21icOpcDaEg/tzx1Nd72ahaN0/LlaPpKcPXIHTOV5omHJQ0/Qt1NQ1s+i/6eeZV9utovDDV7ZP7N79pm6WYFYAu2ksksF/RMIZR+T5iSv43kleJb+q2RuX0heTMie0ltrEy2Deg5HncGfYP+G3Avc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oWqt1hEw; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-31d6dcb5894so1936581fac.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 13:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757103357; x=1757708157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oU2MPYm/BYToRVEcXMaJFDCe0jK9yPC5sGlvfRyIAA4=;
        b=oWqt1hEw35ZpCuexM5/WATjkS1ujrG7Jn1vyd9HMqndm0j5KmKJGsjiDN/+buRr2vp
         T6Jd6zrZVdASAiB+ySyGuLTofgkKoaIUnZqdqjTxiuWs7bvBgV8XrHr03f6qeinoezi8
         oWs7SHoltGOIxyHs0zvgKKkw3iLMqhG63ifEt6KBkoToq6Ki1QReeNYKsftSskbh0DAk
         zySwMt3ulXs2DIjEwaGOR1bBgxZBRWNzgobSg/58foW2ZCZWPPSbMxAHkCZawNIofcwP
         3CDGpWmy+ioACqz8XljNsVDK+cJ89cQji1wVkTYukCgFDwxI+TNweEg8/5ZsltcnRQG/
         IIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757103357; x=1757708157;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oU2MPYm/BYToRVEcXMaJFDCe0jK9yPC5sGlvfRyIAA4=;
        b=jGZo4CWg5WGKc+8SMsLzS33QUqCdU4s8CC9/nrB97+5HdrL8K3raqu/3woJ3sN3fLk
         m+3Z/eq5Ble18xjBM8jRdBNetTuBbU/lDRF6MbffqBU4pw/3UD/amrJmNJjlB7dG4pOv
         dnoA325TIDqWaChf6OtjlfyBLmYWOwbBWebsqdW/LqEYPQgRDpIq7hbXF0G6xolY9luX
         Yj9H2Wyf3NwpOGJOji/g3PKgdsbh6mvc5LzPTfOIaWC82IZC5IeN3VZCgTcEA1FlsXHz
         5P/MwnvNG6WG3RyJSaAWj99XkgrbJNqGVqpP5QBKZ2yGlfAHE4IPMgRcZMlBsmr4/ykr
         HBZg==
X-Forwarded-Encrypted: i=1; AJvYcCVRS0uTkYQLKfPbjF3v5Jf/XWk9bxZeBTpLfXf4Uho+yKYloWno0YGCrwRl1C3Wlxx2tURiLQplBqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNVLamXrcPa7I/HeKn6lP0TrOeLaUS8O2nUsjaI6U//75YwGSt
	SkdGHT8TNnW26OrsKtngJghhsOgeNBM9ukmNP3kz80wONtVFoPIdp2FyaD2+5fIe9J0=
X-Gm-Gg: ASbGncs5N9TG5955uxgse5qozk0q1GRcL/kAxDbFkPESLBsXKnKn6hjhXLJenB3glJz
	CdUaMJM98biNAjNlzGHoFETzt6WbMVQTweJmKI2RKlA8y8ICO7jWj9YjGcqrSgtsfAI7RUnKoLp
	eEx7wb5y3KpvtF6symH9Zp7v2BpvJ1sabCfo8r87TZBL9OeQyIh1a8dFi/x3tHC0Io4FO5aa1XE
	o1KTKzoOh2d+TNcnAw7JAXvMID8yaCdzB0F/fmYPYx0xW+RqMazzlOi5a9IAH4AYuMU9WQkiQuQ
	9ZVFITrgaLTd8sMj3btldmMTSlBn65nYeBVwfV19zhISdiej3DtGiSiPaxLuMzFw6h4DTLP3DNr
	6J2imJ9Uw5udjKKP8TrqrroDbWNDWAp0x/Vz4qY80z+VAYs6MGpRPksmGIt1WTrH7QFG2nMBL
X-Google-Smtp-Source: AGHT+IGaWWr2wcKorxZ6VerSWKW6dJZydDL7VhWVJv7wB8FLbVUC7Juo2V+iK3ybXAhQvZ8xOHC9gw==
X-Received: by 2002:a05:6871:7383:b0:31d:7467:e394 with SMTP id 586e51a60fabf-31d746857b5mr5761825fac.4.1757103356802;
        Fri, 05 Sep 2025 13:15:56 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-31d56cd32a6sm3319397fac.32.2025.09.05.13.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 13:15:56 -0700 (PDT)
Message-ID: <210871b8-4967-40c9-bbaf-338d2d6d9c63@baylibre.com>
Date: Fri, 5 Sep 2025 15:15:55 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] dt-bindings: iio: accel: bosch,BMA220 improvements
To: Petre Rodan <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
 <20250901194742.11599-2-petre.rodan@subdimension.ro>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250901194742.11599-2-petre.rodan@subdimension.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 2:47 PM, Petre Rodan wrote:
>  - fix title typo
>  - add optional watchdog setting that recovers the sensor from a stuck-low
>  SDA condition
>  - set correct SPI phase and polarity
>  - interrupt on rising edge. the level-based interrupt that is being
>  replaced was not actually implemented in the driver.
> 
> This set of changes should not negatively affect existing users.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
>  .../bindings/iio/accel/bosch,bma220.yaml      | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
> index ec643de031a3..f71b2320b010 100644
> --- a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/accel/bosch,bma220.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> 
> -title: Bosch BMA220 Trixial Acceleration Sensor
> +title: Bosch BMA220 Triaxial Acceleration Sensor
> 
>  maintainers:
>    - Jonathan Cameron <Jonathan.Cameron@huawei.com>
> @@ -20,6 +20,20 @@ properties:
>    interrupts:
>      maxItems: 1
> 
> +  bosch,watchdog:
> +    description:
> +      In order to prevent the built-in I2C slave to lock-up the I2C bus, a
> +      watchdog timer is introduced. The WDT observes internal I2C signals and
> +      resets the I2C interface if the bus is locked-up by the BMA220.
> +      0 - off
> +      1 - 1ms
> +      2 - 10ms
> +    enum: [0, 1, 2]
> +    $ref: /schemas/types.yaml#/definitions/uint32

Why should this depend on how the chip is wired up? Normally, we don't have this
sort of control in devicetree. E.g. if it is useful, why shouldn't drivers just
always enable it?

If we can make the case that it belongs in the devicetree, it should use
standard units, e.g. property should be watchdog-timeout-ms with enum: [1, 10].
Maybe 0 for disabled is OK too - in that case should have default: 0.

> +
> +  spi-cpha: true
> +  spi-cpol: true
> +
>    vdda-supply: true
>    vddd-supply: true
>    vddio-supply: true
> @@ -44,8 +58,10 @@ examples:
>              compatible = "bosch,bma220";
>              reg = <0>;
>              spi-max-frequency = <2500000>;
> +            spi-cpol;
> +            spi-cpha;
>              interrupt-parent = <&gpio0>;
> -            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupts = <0 IRQ_TYPE_EDGE_RISING>;
>          };
>      };
>  ...
> --
> 2.49.1
> 


