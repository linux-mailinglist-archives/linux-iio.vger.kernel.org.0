Return-Path: <linux-iio+bounces-22029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E14B8B12C59
	for <lists+linux-iio@lfdr.de>; Sat, 26 Jul 2025 22:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC1517A6181
	for <lists+linux-iio@lfdr.de>; Sat, 26 Jul 2025 20:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20629289357;
	Sat, 26 Jul 2025 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kY85WDlv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3841DE8A3
	for <linux-iio@vger.kernel.org>; Sat, 26 Jul 2025 20:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753562642; cv=none; b=BMVyOlMRFf4PmMJ6epcklRRqFttFtEJJ54k+mhXq+AW5Fjgtja9a0DQZZxMZJCGQqAd/ji+cc8j6K4jS0a0N39UUynePwesr/BX9owI1eTXrmRxMOFDAEfVBhieNTuPlqOJ4+jVHPhrbDKlnZTsYkBHQpBmlImmdMclntjXj3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753562642; c=relaxed/simple;
	bh=hVFqFW7cOFOiaXdFtF/ymY7QPwLfXyT0ruqyFR7toI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUyH/gg7IBzLLxq0zfWxa8u8OZ2QiEWjth7IaJARXfqSQ6OxPELGV8LCEQrb4fnvLr3csyvlfSuczpL7ghisFjZvd8xFX7uwUWnQQosL+kD7HHzAokK7AO5eRbWG0BvIKs3OQp+QQf8qYuOw4VnsihR9sxJWpjG6eCXoPR7gDWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kY85WDlv; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30063371404so974892fac.1
        for <linux-iio@vger.kernel.org>; Sat, 26 Jul 2025 13:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753562638; x=1754167438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+VEtfM3QjGsaTfXwqMtI7zqonqiZkp3vGLu4Zr/dLU=;
        b=kY85WDlvrHGZBGMjGkeMmhd73CtxaZ9Yh9fkDDN/fKKCSqV9/7kTzvOfYNlx7DVK4h
         JsIsA/KIeMTavny2yFcFtbVr/aYJnCGFpQT+1JcIkL08tX2cmXB3JdaMChT71Y2prLeU
         2b1yRKN2j5pFP0WMes8gatRdRLKjUoCRd0/ahSOnohynEbvz9vvpeiXd1cwYnSj2gG7R
         eNB5f11VVS6QHAxQyrPU8DUZFITm+FJKOae53FdMTK/KJreB9IOFbB2CyhIVTY12SBM5
         dnjTd4tWKYSSjyEs3p1Oub0fzX4JnLNDp4PqAJPTza21dNyF6tClNNHmJjYLVJxBIb36
         mxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753562638; x=1754167438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+VEtfM3QjGsaTfXwqMtI7zqonqiZkp3vGLu4Zr/dLU=;
        b=WXFZDjXTlaAAw8TKkP94qwoPoRCXC5H5Ztnnypcs+iqJQsyC3etcGQm7DoVKVlaSLO
         iR53301DF9cZZc53s/z9K57sU9NR+KrBRJngTIp6xIvkYU1rG1Bd/0XKiwWrbvwEQH+i
         sUS9bMWc9gEjo1b7dtR7w5fHTQGoApY5v8FVna4JcbrVWJYSjs1GvMWF1csEm0DnXqHR
         sOvefVzCIiG4YO+BKb9skFtn24DnQdlyiHPBXZHkA4kt388yRYCjZQTD4JzfBWGlFVYF
         Rl0oW0c+cqvxa8REkz/5BFV3QYVTIDdwUPYtXIcPniaU1mwYJA22luh09sIpXyYgD9zr
         Dqaw==
X-Forwarded-Encrypted: i=1; AJvYcCXNxbC7aZNJS05V0/Jf/q2VGUv0LW/uEqFhStpM93NHwzBez2l5StPnYNJOEexurp1HWPElvlISJV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjhxaFY6/g/vmqdEqstCRtWVZ/UOb1LK1D5DwEnk5rKQlqXTjI
	mmeGQa/fP/R4N1PX/uxCZeXKJ3H00gwsbv8PzO9GDzEU/IvA8CGX61moX5jhS+mL3r4=
X-Gm-Gg: ASbGncvTcc01s8qI9Boc45IsJiRPLWK9JrWJWdToS76bwTxUyjgti1BTimitXdgdTu2
	k3TRzEKTO9AtIgtNnrrrR15uQOG0YlFamHKG+5QvIwZy0+evPmNGcV6LqD7P42U70dmOu+yaTAw
	ROBh3axaO8FNz+9/I+8dXh3j+YElWA1ThxNOB04ppZ4bmBb2mAp8C4H0RCVIEqnDdUX6lSXAo/b
	zPFpPXkmUgAlPbPA4WhpppAuYhLE17oI3Al9g6nDZGyglRtfmKxMAGcyBWh7O6lNWqpTWSaP149
	OnEXg1Yn7r3f3Ltx2DNCNTyMx6vZxbkRSgXkqOdzwdk4AHcJoELe3cBJjn9Amtjxz5zV6+U2ZHr
	3RwYZ1zLOtoPuwJkFnLjL8DdKHB8a19L/dsab1gpXnqqAOz8jTDOJhd5xx04uCPFcKHRhWDN/
X-Google-Smtp-Source: AGHT+IHInHpwFsfqMhkUnV7fED7f07ZAN7n8vLTTLRmZx5LbLMF5I3XV73v/JsAsj6bdSTSLdJZn/Q==
X-Received: by 2002:a05:6871:341b:b0:2e9:512:ee1a with SMTP id 586e51a60fabf-30701858b2emr4610174fac.4.1753562638003;
        Sat, 26 Jul 2025 13:43:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:63fb:769a:c359:cee? ([2600:8803:e7e4:1d00:63fb:769a:c359:cee])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-307132c2e7asm745791fac.18.2025.07.26.13.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 13:43:57 -0700 (PDT)
Message-ID: <455141b2-e82f-45fd-b30f-5d9436aa861b@baylibre.com>
Date: Sat, 26 Jul 2025 15:43:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: iio: magnetometer: document Infineon
 TLV493D 3D Magnetic sensor
To: Dixit Parmar <dixitparmar19@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
 <20250726-tlv493d-sensor-v6_16-rc5-v1-2-deac027e6f32@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250726-tlv493d-sensor-v6_16-rc5-v1-2-deac027e6f32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/26/25 4:37 AM, Dixit Parmar wrote:
> Document the bindings for Infineon TLV493D Low-Power 3D Magnetic Sensor
> controlled by I2C interface. Main applications includes joysticks, control
> elements (white goods, multifunction knops), or electric meters (anti
> tampering).
> 
> The device can be configured in to different operating modes by optional
> device-tree "mode" property. Also, the temperature sensing part requires
> raw offset captured at 25°C and that can be specified by "temp-offset"
> optional device-tree property.
> 
> Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> 
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> ---
>  .../iio/magnetometer/infineon,tlv493d.yaml         | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml
> new file mode 100644
> index 000000000000..0442cf41503b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/infineon,tlv493d.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Infineon Technologies TLV493D Low-Power 3D Magnetic Sensor
> +
> +maintainers:
> +  - Dixit Parmar <dixitparmar19@gmail.com>
> +
> +properties:
> +  $nodename:
> +    pattern: '^magnetometer@[0-9a-f]+$'
> +
> +  compatible:
> +    const: infineon,tlv493d-a1b6
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: 2.8V to 3.5V supply

The SDA pin can also be a /INT signal, so we need to have an
optional interrupts property as well.

> +
> +  mode:
> +    description: Sensor operating mode. Must be one of the defined enum values.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 0 # Power Down Mode. No measurement.
> +      - 1 # Fast Mode
> +      - 2 # Low-Power Mode
> +      - 3 # Ultra Low-Power Mode
> +      - 4 # Master Controlled Mode
> +    default: 4

This is not the sort of thing that really belongs in a devicetree.
We should be describing here how the chip is wired up, and only
control how it works based on that.

If there are any wiring conditions that could affect this setting,
they could go here. For example, if the power supply doesn't have
enough current, then we can only operate in one of the low power
modes. Otherwise generally we just stick to the best performing
mode. And specifying the power down mode here really doesn't make
sense - you could never use the sensor!

> +
> +  temp-offset:
> +    description: Raw temperature offset at 25°C to apply before applying scale and correction.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 340

This is another one that likely doesn't belong in the devicetree.
There is a standard *_calibbias attribute that can be used for
such a calibration if needed.

> +
> +required:
> +  - compatible
> +  - reg

Power supplies are usually required.

> +
> +additionalProperties: false
> +
> +example:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      magnetometer@5e {
> +        compatible = "infineon,tlv493d-a1b6";
> +        reg = <0x5e>;
> +        vdd = <&hall_vcc>;
> +      };
> +    };
> 


