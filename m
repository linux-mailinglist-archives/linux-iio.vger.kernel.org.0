Return-Path: <linux-iio+bounces-22031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F3FB12C5F
	for <lists+linux-iio@lfdr.de>; Sat, 26 Jul 2025 22:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5784E7AB611
	for <lists+linux-iio@lfdr.de>; Sat, 26 Jul 2025 20:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5125E288537;
	Sat, 26 Jul 2025 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eo8rusya"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808081DF968
	for <linux-iio@vger.kernel.org>; Sat, 26 Jul 2025 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753562777; cv=none; b=GK07dCROnTzlH+XopUddj7ue8QffZRWZDkLSrlDyOVwoofrnD/r35vwXq6YzvyFQE4TxN5bIYMUmDGCtIDWxLUqBciRPGKW0cnpezj0uZ4ZOXte471C06lk2jV7T6L7LCRqffOW8MSCXxoK3vO6w2ESjJ1I6DioeY/XEYk/2u5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753562777; c=relaxed/simple;
	bh=AgFl8oYApeBrJhPG9hAm6A9ogSmb60gaE3IC/9S0mSM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=fbVVE3FxXXPFWPyj7q9kCkThXtWIq3r+AzTCLIpyIiIUtJ+ha1bi8m3epWnh44xB6mKmzCzO3/PEjEAhQlJYWWEbFXKlnCJ22DQMdxr3pLohMrxXdhL5LIuEFR3qjdHB2c3/sUyttl3YFXia3MV+++dnUtjWU1DuiB0wqdxegJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eo8rusya; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-73e82d2ec21so1624351a34.2
        for <linux-iio@vger.kernel.org>; Sat, 26 Jul 2025 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753562774; x=1754167574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adVyS8ykePUpCxVa6P/qJ+4OYY/RJo9Vkh0bwyU9BA4=;
        b=eo8rusyafloyFYiF3i/916Rlbwhgj0y1HsdrGHI4It2dHVim3gORD7FP+qz0cK/PFu
         UZ4GHeDmbvnZI5mPkJpl9MQRi+fwk3iJLbkIqo2d0xq4w/iTdowIpjSXSnmX66X/OtWN
         U0DCXfFS8EqhA8yV/n/L8sropIEMz+yOuo11r8NfbbnI3wRYa4Yfw+kKsgpCcg/YXVTZ
         2U+1KfMCzTjAxbigxbXwNWZjkZJK7SS0pG4uQ+PDk4/eHvmq8eZhTgQ2vD1DevLbM+4Q
         zxD5Xbi2ZuUVlEK0MUzBkNi7LwMvCMhVkC++xO94iAXh92mUbEK2XT3w0WnkwI/qXGNd
         OiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753562774; x=1754167574;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adVyS8ykePUpCxVa6P/qJ+4OYY/RJo9Vkh0bwyU9BA4=;
        b=QzulXDjrX4Os8lgtosBwhPXjyqXJFZ4XgW3zjCsi9608vZFeH0OlcI4AEA61ao+Tf+
         3yDcPjpLx6YvumJn2wtL2l3gMkhBt2bgkCdGnyxv2o0J8LJUeTy/Mzu83mPozZk3sfZ/
         fhca2rDDNwGPWCkeDbB8WYEWa9TCht1JYeJSyAEDPh0U4NJaUcMHmWEvg5CLqIIm2rAG
         tdOnN08hc0CfiGrAntCWMA8UfYrViQktK1mOdX7dsuIxEviQmA+R/y+YdT3t3pBkL54B
         VSeJpe+HDgW58GyF+8NFP+BctRN/HVjqGPpAi/yB90pofnTgmzX/vSVQKkHXDPcGYQEj
         7JMw==
X-Forwarded-Encrypted: i=1; AJvYcCWrun7zWFpoI/UkiVoTtvRFCpU+B0vjQbQTfpaU0j3pekP+UgneBxP6ZZjSvrr3KAxGhcznFxE+tLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoe8998YYPoqgPpeOIE44niTaVU8lg7fUavgctv9UJfCooPhEe
	5wkFpS51+uHQpHyzZcoc/jPMX363flv6n5fss3lpR4tZ7FT9/2xRhf5ow1EDBzfRAfo=
X-Gm-Gg: ASbGncsymGW97wswbYLBTYERAHMeAetxfb/kef+F7yUGJ8WLkKRidzIEEIk+RB6+01G
	90MxhpbB1x+cQshMzs0AA9SF68LGS2KPEmMhTvREyfk5YkhuHMQYXcsNI7OqIZQCQ9fUNBRv/yZ
	QTfbey2OWaRltN4+q1QdMsCXZVds+sWvJU3VJH6PY5/wzymJz4A919I4veJDDt1r4R3tl0rw0f4
	tDUTcZwnWhk/7vG0LbVlCCtx8uD7PpmtRwF5LZlXBVFHwk62uIpdkyupyH7pazH+IyQk/z2E65p
	pbAtESceHrjCXVnldVAPHbdhxj10z6BGxjU9+fjI7OEVdeTY0ltvPkM3rAztXlNUCPOWuMA1Djq
	PN5Qnd8kFr0OP1bhm3ifjeLuRM5QDoSovqWFaTo5iQm05fjwmdsfYPE5t+rDMzIv2p9NbluBi
X-Google-Smtp-Source: AGHT+IH9t28zTolDysbNhdXb23sMoRkURov5APnmp/JHYYlxIDPTMz/ZosJ9ofjYg1FWWz24zqLsng==
X-Received: by 2002:a05:6830:924:b0:73e:9857:9839 with SMTP id 46e09a7af769-7413d96e6a6mr3842789a34.0.1753562774403;
        Sat, 26 Jul 2025 13:46:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:63fb:769a:c359:cee? ([2600:8803:e7e4:1d00:63fb:769a:c359:cee])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74148230156sm445250a34.49.2025.07.26.13.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 13:46:12 -0700 (PDT)
Message-ID: <b09d59ed-8bc8-4db4-b758-78e05af399df@baylibre.com>
Date: Sat, 26 Jul 2025 15:46:12 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: iio: adc: add ade9000
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250721112455.23948-1-antoniu.miclaus@analog.com>
 <20250721112455.23948-2-antoniu.miclaus@analog.com>
Content-Language: en-US
In-Reply-To: <20250721112455.23948-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/25 6:24 AM, Antoniu Miclaus wrote:
> Add devicetree bindings support for ade9000.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
>  - move interrup-names near interrupts
>  - remove properties related to the waveform buffer and make them runtime attributes
>  - remove egy-time property and make it a runtime attribute.
>  - remove wf-src and use filter_type in the driver.
>  - add vref, vdd support.
>  - use adc standard channels instead of phase channels.

It seems that you ignored some of my v1 comments without saying why.

>  .../bindings/iio/adc/adi,ade9000.yaml         | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> new file mode 100644
> index 000000000000..0176252aae35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ade9000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADE9000 High Performance, Polyphase Energy Metering driver
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  The ADE9000 s a highly accurate, fully integrated, multiphase energy and power
> +  quality monitoring device. Superior analog performance and a digital signal
> +  processing (DSP) core enable accurate energy monitoring over a wide dynamic
> +  range. An integrated high end reference ensures low drift over temperature
> +  with a combined drift of less than ±25 ppm/°C maximum for the entire channel
> +  including a programmable gain amplifier (PGA) and an analog-to- digital
> +  converter (ADC).
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ade9000
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: irq0
> +      - const: irq1

I still think that there should be 3 interrupts, the 3rd one being
the C4/EVENT/DREADY pin.

> +
> +  reset-gpios:
> +    description: |
> +      Must be the device tree identifier of the RESET pin. As the line is
> +      active low, it should be marked GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  vref-supply: true
> +

There is also a clock input and clock output that we can add
clocks and #clock-cells for.

> +patternProperties:
> +  "^channel@[0-2]$":
> +    $ref: /schemas/iio/adc/adc.yaml#
> +    type: object
> +
> +    properties:
> +      reg:
> +        description: The channel number (0-2 for phases A, B, C)
> +        minimum: 0
> +        maximum: 2
> +
> +    required:
> +      - reg

Why do we need channel properties? Do we expect in some cases to
only have 1 or 2 phases wired up? Otherwise, this provides no additional
information.

> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - interrupts
> +  - interrupt-names
> +  - vdd-supply
> +

