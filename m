Return-Path: <linux-iio+bounces-26273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9B6C66924
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 00:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id F2287298E0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 23:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EF2321440;
	Mon, 17 Nov 2025 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NID8ih42"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8E31A061
	for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763422932; cv=none; b=ZRRruMQn1X80SDR2CWIn40XlkRrEC19WB8xnIxdAQ3NKojllpgpSz4nbqgLIvcOLikGrwQcH1Y8n/v279lju4anfsAvbkrUM6x58V1EGJGNLAZuFlRSIKTsRyvE84WDwdnfN4zqA/Zfsr2N2fGrK5KCUK8z0XGddT2nola32Oe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763422932; c=relaxed/simple;
	bh=C1CiXSMjr1ONnvgc8yNUoBYht2QInAElu2Jdtm3VvzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lf0yk+8EahJ2bh12qseYAbyByo7BrelChtkDnkdVfjTWu+rtpcuWeIitucTKu2ViUBO0TxTFxsnlw90aJLlPgDvqubBgJFvUIsS4S5wLNC+fXOffrZBp+l7VIlPs7M4KLu2rIOhArNrTQAORQcEnKyCg9xwsrGfn8hVsp71ZJ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NID8ih42; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-657244ed2c2so1234955eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 15:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763422927; x=1764027727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tg/jgZzk5xK45ykGPR1yuuEKOuJiixva9naVUDB32NY=;
        b=NID8ih42Js4E6N3Yy7hnGf2vR9sitn8A5fW+/cOaYdlhq1oWYsuq9PeeqyMzDhS6af
         2j1ZTp8ww0YLM5aOd8g9x8lC4lUsquGJVDZ35e8fWCzRcrhr8cx8AWtWUCwMRQkJ9rDG
         QVfX1DIy9XB05VkSIxMKZlAWHw7Wy7yaLUNIDuiBnL6cf3Ef57ONvqGGbCzrF2YeYD5h
         7ws2kIfX7LlRX3rAzJritg6+f9TrRV68jSXKvtX9Yio3SRWprLgGvyrdP/+FlIUKvh9t
         cQdmVxdZL01xQffud9F+X0Ic1vUd6WwAaM2lgxIMg2EiKWMYnY/QsaCOtVTISw7mE7Vb
         RhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763422927; x=1764027727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tg/jgZzk5xK45ykGPR1yuuEKOuJiixva9naVUDB32NY=;
        b=UL+KcHLwMAtRa65mTuuJln1v9cWdtT/eEKy4l148IoB5DeJTq0f0ERTAk9q5mVRgQE
         FmaacsseGzxlz/RHiMCJkQ+PpnW4ayNDtOxeWXVZXo5jMkk075mD1SEQErL9bP4EOgWH
         pea95y35MsIhNS2isD5czRMUJf7OC0gohFpsBcNnkfVCjXFz28JWoFFZoFUxp8LnjM9b
         /OWY0G9d9QRB2VyUVxXytqIxpkC6T4mF25O65DSNj2nGHSb1gYT5Nro1weFCa9usb35a
         EP448iruKWPtlhcxhpidVLcJCc3Mr/9ibsspd+8lbqieqn353xHnF0+fYYdkBvmKb2bK
         r3bw==
X-Forwarded-Encrypted: i=1; AJvYcCVl3jxn7KHQdVg2TllL6yGAQzGikCGphb8TewJ86XYumvjgqt1tYN2pMCIgkQqP4AbBz846yDpMso4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvNLWx6hcepqW+/tcU8tXBwqSfSyAlgio1smS3hPVK+mnDhTI2
	s8Lo6WcP/MccGyeeOmEBJS1TQv0VVGWZgZJ26HZbl+Bkl27u3OnCHdPv68TdoHac36NI4ziiWUp
	rmtjF
X-Gm-Gg: ASbGnctLQHh8WXHL+gK0zVeRH/vMNQJ+RbvCaWKXeTg2UiCehH5I7rlUNd2KyPawyn2
	kxYgM+xpQI/K+4E750eWE1KDck0csF6XWcG6eEYHs+IMw18IlWuVEu4aMEblYWWlQ4oTaFvV7XK
	UZDJeX4axg2IJ3d7gPTxKwQCxbZtn38TinO9k4wXe39lbOGix0qod+GAppSNDhq/cqV+A8ERpbM
	Hru3o25pejRg8qSj7vfQnsvjJ4rJliQO6NCCgzQxYNsmCs7cOpy2jqvG1Gt4QqRzIS+s2SSmfSx
	SQUJCVSfKuwtPD81puUQiUq4BCh0OhZAzueCOIlH6nUJPmwP9MeIYb1feGJK9nrNgn9zOy5+Fdj
	MyctU2k/p5ayh51UeLJPZcIajIQGCmNkSicZ0Bzql2815yOqVoWKJQC/2DvSrpzwNXNwaahGhT3
	Rx/vcqLtgFs7foiVlUBrkJ1I3rmIC4E3le6s5bdW+mlBXlyJEgHw==
X-Google-Smtp-Source: AGHT+IF9rsbj2v0migbUw/0QbebZ9MvOA2t7vDRnUBel/lU5OuvNJRbNK6ZCXzUCdjPOQXjEWKGxuw==
X-Received: by 2002:a05:6808:4f6b:b0:450:bb4e:8395 with SMTP id 5614622812f47-450bb4e89e9mr3417672b6e.53.1763422927119;
        Mon, 17 Nov 2025 15:42:07 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8e86:179b:44b8:cc2b? ([2600:8803:e7e4:500:8e86:179b:44b8:cc2b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a3bd060sm5970941a34.24.2025.11.17.15.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 15:42:05 -0800 (PST)
Message-ID: <bf45b26e-2cd1-464f-a180-46120b4b0473@baylibre.com>
Date: Mon, 17 Nov 2025 17:42:04 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: amplifiers: add adl8113
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251114115725.5660-1-antoniu.miclaus@analog.com>
 <20251114115725.5660-2-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251114115725.5660-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/25 5:57 AM, Antoniu Miclaus wrote:
> Add devicetree bindings for adl8113.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> 
> Changes in v3:
> - Remove extra blank line from YAML file for cleaner formatting
> ---
>  .../bindings/iio/amplifiers/adi,adl8113.yaml  | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
> new file mode 100644
> index 000000000000..0ad83a01ee37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/amplifiers/adi,adl8113.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADL8113 Low Noise Amplifier with integrated bypass switches
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  The ADL8113 is a 10MHz to 12GHz Low Noise Amplifier with integrated bypass
> +  switches controlled by two GPIO pins (VA and VB). The device supports four
> +  operation modes:
> +    - Internal Amplifier: VA=0, VB=0 - Signal passes through the internal LNA
> +    - Internal Bypass: VA=1, VB=1 - Signal bypasses through internal path
> +    - External Bypass A: VA=0, VB=1 - Signal routes from RFIN to OUT_A and from IN_A to RFOUT
> +    - External Bypass B: VA=1, VB=0 - Signal routes from RFIN to OUT_B and from IN_B to RFOUT
> +
> +    https://www.analog.com/en/products/adl8113.html
> +
> +properties:
> +  compatible:
> +    const: adi,adl8113
> +
> +  vdd1-supply: true
> +
> +  vdd2-supply: true
> +
> +  vss2-supply: true
> +
> +  va-gpios:
> +    description:
> +      GPIO connected to the VA control pin. Must be specified as GPIO_ACTIVE_HIGH.
> +    maxItems: 1
> +
> +  vb-gpios:
> +    description:
> +      GPIO connected to the VB control pin. Must be specified as GPIO_ACTIVE_HIGH.
> +    maxItems: 1


Could make things simpler to make a single property and use it as
a gpio array. I would call it switch-gpios.

> +
> +required:
> +  - compatible
> +  - va-gpios
> +  - vb-gpios
> +  - vdd1-supply
> +  - vdd2-supply
> +  - vss2-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    amplifier {
> +        compatible = "adi,adl8113";
> +        va-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
> +        vb-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;

Seems like we would also want some binding to describe what is
connected to each of the bypasses. Maybe io-channels that link
to other amplifier channels?

> +        vdd1-supply = <&vdd1_5v>;
> +        vdd2-supply = <&vdd2_3v3>;
> +        vss2-supply = <&vss2_neg>;
> +    };
> +...


