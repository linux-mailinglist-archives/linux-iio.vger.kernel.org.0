Return-Path: <linux-iio+bounces-23650-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0092DB406C0
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 16:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A380920687C
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C441A30EF6E;
	Tue,  2 Sep 2025 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d4RwbFT8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AC630DEC0
	for <linux-iio@vger.kernel.org>; Tue,  2 Sep 2025 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823349; cv=none; b=qQweCxUlye65KeuDyrFK7lOkdyhA/azF4Pc1/MyoHYDnjJtg4lZ0HmTh4bLeP8gc3g7y/RYFG71j1gA6d6dZNspKncOrKcl0pN3Gy6kmW83RByFlaWy3QUqG9XWk6fI4oy+dB1gdOBe0hG/soYoQ25UnVKUiTs3OoHdbAWQwPMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823349; c=relaxed/simple;
	bh=Zh/esVOjxW9buYPgrg25ime4g5npaPosuL61f9Sd6lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0Z+G8c709aDtd+kkP0Blbs3NUz2KXN1yRLJbRcB3rJZ3a5n+boJ3UlaxrO5zW3KN53+pKaxT9vxOHtS3lhNp5dtwcHSk4E5yK1NZ0Abr0jVDvJ+nBoE12GsZvoOnSJEBtC85rNJFbiuxc8zx/LptquUs9m0238y/LjWIpuSyCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d4RwbFT8; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-743814bcca2so3834376a34.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Sep 2025 07:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756823346; x=1757428146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pp38Yvg3RiytProyc5t2mGqns6Lb9l3HNRoLbsNuGqs=;
        b=d4RwbFT8GryJDSSfS/vvnQ5NYIUEncQQTaY0qPKyd22otXxkGl/RXepzlCAZlhetZd
         2WNkXNwB7npWfxum7PvK605qGN2qcfiITRUiA2WU+P276RqaltQHmVxGCNP9CA0gct8W
         CJ9Nm6gy/2Gk/ONx07/u3Wxo1zjifXYaGm8yQjM6EFD4LqdZKzsn+n4iw2GDTPoKsLBJ
         Xm3eFlLf+3uPjcLAY5G0Hv56XgXOIdi2yfetiKOdQI9sVkC4DlnxRbuGR4Q8A4jrNkqb
         JBUMeq+mqXgCOqyFFrKqzg8TY9xev/pr7IWS8+jZST5sLM4/NkZX4+uYckl1ZJPLC095
         wAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823346; x=1757428146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pp38Yvg3RiytProyc5t2mGqns6Lb9l3HNRoLbsNuGqs=;
        b=lXF9hHZ+zUcKNzjnAQnXnKSBXRBu8af4UQJggne1b8Y/YNBWbHGk9i+wTdTGihPQ8O
         0eyhYQOL+E7N9nTMNMOgNjpvi0FY+jAKp/jwBa0tK7+9ZR/sdbdeHD13mjYBywLMCOno
         r4HpdxATH8cK26T7NI/3zQ5Ydh/PKI2ry6rYxN+P0IdLXHGuDiPggP4eT6iJJmYO/sM1
         kDg3yiJlef2S9eRAhREbsJ/8SR5oXo+N0nsmNVf4V3d+QcwgEcOlyD54ULpHFItxprpJ
         e0P4Nc9u20Of+1xlKP0ASeY+zd5VLDzPSNwIwgVPJxzG372eATntB5xSwEQkfd6TlkMe
         M1XA==
X-Forwarded-Encrypted: i=1; AJvYcCUyBkqS7Ve0UWcnc7WPUIV0vXtQ6NmFQbISmClMrAWqIKONYeJ7GnILVmQo/568vswqIliTQmwIBfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNAltdb9KCMeSb8p92I6MHAtzyJQmoNY/Ex6g4RujwWGXyPtEn
	VNhteKGmWivD+3Z7LHHBqyZ0//Hd2nTBB2uXPE8KIjEokec+xbrJcIhwqkjFjX2I51Y=
X-Gm-Gg: ASbGncsbMs5t6U9NPjlO9t1jK3gBBaDpxNnz6bitP2/Byaj2iEoJDrUrr8diw0rUN5p
	XRaB8hTjwcX0RjxDp2eHL8lSAHCLJ9dJ6yXQh+9jDLaxDcsUViRkDGOYNgQ30wLN0k5yMWKvIXe
	KHdmVQuPMvM3osQXn6F4jWSbkmz75+M5CG92EjKw/Eol5QVY5JuCErjit0VfYAiKzP9MWtBLUcu
	yunDQ8zlo7O7IenVIgX2WOJ1XKNOid8eCNehAi5ifsg0fPrlfCVWBTYjqymer9zT35sT34k82MN
	4LfJwdsGH0o/NTlq+QxONT/mSpxlIh+rExKMKaRy8yas3HvzwdLveTfnSHvlZO+cNu3wFfK4WuN
	8H+yeLuqk7XJrXDTXK6AeeLXtGEhzuI7a5ZrjwS8b89kQ3myc2jQpQ3NowIuk6U5F30bHwqUr
X-Google-Smtp-Source: AGHT+IGLw6/8aesIjAkhpVEJeXPBKTkpcMtabs/+MAUeiJpSmdalTytyjetDUXmkZqhdD3fGgZrheA==
X-Received: by 2002:a05:6830:7101:b0:73e:9fea:f2a5 with SMTP id 46e09a7af769-74569d9deb9mr8195564a34.4.1756823346157;
        Tue, 02 Sep 2025 07:29:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d95:114e:b6f:bf5b? ([2600:8803:e7e4:1d00:8d95:114e:b6f:bf5b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745743d0e97sm1581788a34.42.2025.09.02.07.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 07:29:05 -0700 (PDT)
Message-ID: <89265de7-eeff-4eea-838b-6a810c069a20@baylibre.com>
Date: Tue, 2 Sep 2025 09:29:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/2] dt-bindings: iio: adc: add max14001
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>
References: <cover.1756816682.git.marilene.agarcia@gmail.com>
 <34b7cc7226e789acdc884d35927269aa5a0d5e14.1756816682.git.marilene.agarcia@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <34b7cc7226e789acdc884d35927269aa5a0d5e14.1756816682.git.marilene.agarcia@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 8:15 AM, Marilene Andrade Garcia wrote:
> Add device-tree documentation for MAX14001/MAX14002 ADCs.
> The MAX14001/MAX14002 are isolated, single-channel analog-to-digital
> converters with programmable voltage comparators and inrush current
> control optimized for configurable binary input applications.

When there are multiple devices, DT maintainers like to know
what is the difference between the devices.

> 
> Co-developed-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

Sine the patch is From: M.A.G., according to [1], this should be:

Co-developed-by: K.S.P.
Signed-off-by: K.S.P.
Signed-off-by: M.A.G.

(hopefully obvious, but don't use the abbreviations - I just did
that for brevity)

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> ---
>  .../bindings/iio/adc/adi,max14001.yaml        | 79 +++++++++++++++++++
>  MAINTAINERS                                   |  8 ++
>  2 files changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> new file mode 100644
> index 000000000000..ff9a41f04300
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023-2025 Analog Devices Inc.
> +# Copyright 2023 Kim Seer Paller
> +# Copyright 2025 Marilene Andrade Garcia
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,max14001.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX14001-MAX14002 ADC
> +
> +maintainers:
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +  - Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> +
> +description: |
> +    Single channel 10 bit ADC with SPI interface.
> +    Datasheet can be found here
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/MAX14001-MAX14002.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max14001
> +      - adi,max14002
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 5000000
> +
> +  vdd-supply:
> +    description:
> +      Isolated DC-DC power supply input voltage.
> +
> +  vddl-supply:
> +    description:
> +      Logic power supply.
> +
> +  vrefin-supply:

The actual pin name is REFIN, so refin-supply would make more sense.

> +    description:
> +      ADC voltage reference supply.
> +
> +  interrupts:

Likely needs `minItems: 1` in case only one interrupt is wired.

> +    items:
> +      - description: |
> +          Interrupt for signaling when conversion results exceed the configured
> +          upper threshold for ADC readings or fall below the lower threshold for
> +          them. Interrupt source must be attached to COUT pin.

We could shorten these descriptions. The important part is which pin
it is connected to.

> +      - description: |
> +          Alert output that asserts low during a number of different error
> +          conditions. The interrupt source must be attached to FAULT pin.
> +

And also `interrupt-names:` makes sense so we know which one is
is wired if only one is given.

> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - vddl-supply
> +

