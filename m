Return-Path: <linux-iio+bounces-12980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3CB9E0EDA
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 23:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A121654CD
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 22:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92C61DF972;
	Mon,  2 Dec 2024 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MNnX0H/w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BEA1DED48
	for <linux-iio@vger.kernel.org>; Mon,  2 Dec 2024 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733178098; cv=none; b=VfO/azWDwXjeo4bJH9QAfyQfDKv+IG5hzXlinvopMVny3ni33BzBsLx9CxXQ5JK84W9CqqnqWQQ/jf+oCWVRY2a44kgzQAN2N9wUWVSdhUm/ZowHMLpse44opefMeu7vF7q6ei05FNC9udmmmvlfT0I7PQ5tjacpVCbs+Oal3Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733178098; c=relaxed/simple;
	bh=K6qdGsv9rncddp1uJyfOLr9w0wJrOROqBbZo+QJHdBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/88fRALa9iqrxrAM8LlGOO3NNfL7cgkKQHqE9jTCwS6Lnfuo0GxK6dlv62uWeohPzGXyhqOl6Vi73iv0BQJdTo3XxQo9W3ja4TsYBbBc2IUV9s0i+Xf8czHInlS27q4XF0eMcm0Xbqy4v8yR46LdSg8glVl1NM2a8YIqU6HG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MNnX0H/w; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3ea33a922afso2411618b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2024 14:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733178094; x=1733782894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7JPQc1khf/GUJg+4Lfme601MXC/XRn+qWK7wBatyTg=;
        b=MNnX0H/wy2D+OzxY8Qy9q+psJasaF3+h7GNMgGOvUBk3ABQoZPnlZu/fwxRkgzRmjP
         yGmKs2+Bje/gB8smjlXl2T/4oO5MfZWH9xXanG2kw5B3upXOcQ8JiQwyAO2V2hRqhhts
         puHkmITOzgwJfJSwBfJw5/goDHSrWs1e5C6FUysW15w/Nxrcxy8cWvFqDXzToOO3jadW
         Nxw1KODpJJ8K4X/19eXekHFQT6D77b1n7725re1MDr5psJIGGSFU9OuSvAs83P1RdlC6
         Z0vzgrFTx4aG+biKHkhiBGJbKfykLEbu07L4RN0F4KDBgtXE2mW8SmgdQfxchgQ/UzNh
         ullw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733178094; x=1733782894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7JPQc1khf/GUJg+4Lfme601MXC/XRn+qWK7wBatyTg=;
        b=R2JDQf6VWG7Px4bJrPOap+UNTCyDmzWjXY+LJZgrKlgJoCW3qv1rgTBtfOxFPu6T7/
         C2EZaFipvEITFAYGDwI+c3OhpgqHqaPqo3ncCbNSzULYxZeprCHft+93Ex4OZKruRzc4
         MKuSw89pmN1dtXYCmlROwGUJSQaxrxPw8cWWbQhG6MfVbt1kWP7hFFzF7FSB9HNfnExV
         Z09zr5kz/yTrsUNLbLIjlA8ZfMaqnRK4DNMCqVa1z+oYPln9MK766LzWW1la7Im0YIFI
         dN/g8tTUwUdV2ER9Moq78zXB75b5/IwvfovtmH4M6RZxEOliAWssidiqttC1G4zr3TFW
         QohA==
X-Forwarded-Encrypted: i=1; AJvYcCWmUxua10oCxFpPT1pnWV9ynrbBiYC6iHQELKP7qaO3jmdjI5X5GUND0p5hDiarWwDW6SLeL+xDZFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK2pY/CWiiSJO78MJrkO+l32v8iorAMgTfE4gRGJPYOwCP5NBC
	IBvKXI57xtf1VIcd97/Nr47k53D3WpP6a8Ixgs+Z0j4Y7jn/dUmO3t2IbqjJo6A=
X-Gm-Gg: ASbGncs2Qg3jeKF2tGCRNAmgnt2RfBMHjaUSmDMVZUHxf5MUv67F02g1Oqh4uD6Zawf
	9Ee/nHCBESITzS5ogPOTCBl1Grfbp9gw8ILVeUKu++b10Cy2RqV3QnYZk7G1sd8yoeaNndMnaKv
	yTqSuMHLlXrhsK2Z2txU9istbr6gjRWugQoGqi4Vy6/50nXKe66BiEx9VGLhCdtJsX8JLtTXf6w
	+etvXteBsqAOKheYphfwQ8SmT8gpAWj/1vKWlObWxBx3MCZXRJ9cNFLoOe1SnC8OzsjbQiZtZ8+
	tAasGkTY9Ig=
X-Google-Smtp-Source: AGHT+IG3AMQarL4RhG3Os+XmQUKhY9ZiY4GhYh+yf5CUfkRn32xlYB8p450z/FZ5Ke74fWDPV/KDiQ==
X-Received: by 2002:a05:6808:38c9:b0:3ea:6708:51af with SMTP id 5614622812f47-3ea6dc27ff4mr24272753b6e.20.1733178094462;
        Mon, 02 Dec 2024 14:21:34 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea8634d733sm2482803b6e.50.2024.12.02.14.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 14:21:32 -0800 (PST)
Message-ID: <7eadbe02-4f81-42d6-b1c5-932e6bbedb19@baylibre.com>
Date: Mon, 2 Dec 2024 16:21:31 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] dt-bindings: iio: adc: ad7192: Add sync gpio
To: Alisa-Dariana Roman <alisadariana@gmail.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Hennerich <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20241128125811.11913-1-alisa.roman@analog.com>
 <20241128125811.11913-3-alisa.roman@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241128125811.11913-3-alisa.roman@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 6:55 AM, Alisa-Dariana Roman wrote:
> Add support for the SYNC pin GPIO specification in the devicetree
> bindings. This pin allows synchronization of digital filters and analog
> modulators when using multiple devices. Update the examples to
> demonstrate the usage of the new property.
> 
> Also update the interrupt type in the examples to use the proper
> IRQ_TYPE_EDGE_FALLING macro instead of the raw value.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7192.yaml          | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index f70caefdace7..1cd0fd13bc42 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -59,6 +59,17 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  sync-gpios:
> +    description: |
> +      Optional GPIO spec for the SYNC pin. The SYNC pin allows synchronization
> +      of the digital filters and analog modulators when using multiple AD7192
> +      devices. When SYNC is pulled low, it resets the digital filter nodes,
> +      filter control logic, calibration control logic, and holds the analog
> +      modulator in reset state. Only specify this property if you need to
> +      actively control SYNC for multi-device synchronization, otherwise it
> +      defaults to HIGH.

The datasheet says that the /SYNC pin can also be used to trigger a conversion.
But I'm not sure we really need all this explanation here. The important parts
are that this is a GPIO that is connected to the /SYNC pin and in the
synchronization use case, the same GPIO might be connected to multiple ADC
chips.

> +    maxItems: 1
> +
>    aincom-supply:
>      description: |
>        AINCOM voltage supply. Analog inputs AINx are referenced to this input
> @@ -182,6 +193,8 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
>      spi {
>          #address-cells = <1>;
>          #size-cells = <0>;
> @@ -194,8 +207,9 @@ examples:
>              spi-cpha;
>              clocks = <&ad7192_mclk>;
>              clock-names = "mclk";
> -            interrupts = <25 0x2>;
> +            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>              interrupt-parent = <&gpio>;
> +            sync-gpios = <&gpio0 26 GPIO_ACTIVE_HIGH>;

On the schematic, the SYNC pin is marked as active low, so I would
expect GPIO_ACTIVE_LOW here.

>              aincom-supply = <&aincom>;
>              dvdd-supply = <&dvdd>;
>              avdd-supply = <&avdd>;
> @@ -208,6 +222,7 @@ examples:
>          };
>      };
>    - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
>      spi {
>          #address-cells = <1>;
>          #size-cells = <0>;
> @@ -223,7 +238,7 @@ examples:
>              spi-cpol;
>              spi-cpha;
>              #clock-cells = <0>;
> -            interrupts = <25 0x2>;
> +            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>              interrupt-parent = <&gpio>;
>              aincom-supply = <&aincom>;
>              dvdd-supply = <&dvdd>;


