Return-Path: <linux-iio+bounces-24173-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425ABB59DE2
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 18:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4F887A9B8B
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D96031E8B6;
	Tue, 16 Sep 2025 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MK6tTGwL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4B31E8A5
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040853; cv=none; b=DT1oqA6RqeN619d/bLOxDq1bu6kX9AmI2QFamNymYlAPDgEYcsm+1uJh5WRgUVS18VJycbHmjvuBJmxdYXXqiXx6S1+nIFAm1cOyQ4HLPaJfcKxg5P7tSedcLWAXtFUozIvlhnSdVMG7m+LwdLACnY709WKd7MQXZujVOQs/wmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040853; c=relaxed/simple;
	bh=DSmVQSHhOos2PKtH8mYX9XMol+4AxC1wakS95WHvgtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlb9RfbVU7umwS1+xN1Z9L1gy7E3NcC8/NZLvzX6lsr+tKFTvp5c5Vg2oE9oInGvhtBWS4gOwe9qzduU0nCIoTsPKNRSK+TQg0iHU1OfnJdZS6mMQw6FxaGDh08c7Ss7M6IOPtQat6eeKKjbpwWi4OjBEcxPPL3nbCHhX2DZY/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MK6tTGwL; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-43d2da52291so17221b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 09:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758040849; x=1758645649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IRpNM2/xCih59eBZEAbu4g3iE4/D/L64LgWMt1ePFPk=;
        b=MK6tTGwLI0rmWuk+E/GK7DPlGDssqHY5Oj5l/oPC7RMC4mYknQcWTifKQt8/FlNtjG
         o7wxo40oAuhEG8Vq5oiqgqBUEsTE42F6Lten6xFTuOCGtKzRYByKQHo2AajrRxJLC0y4
         9ikojLrD8XEprAMZV//m9/Jow2MtNOYbsER6PSwWNU2MK69xlpYWv6DxLuXf5Me1cZJ/
         7Po0fLKnpu6nSyi1HIr+sODA7qrjapcWe+REnJIhB0AQ7Qc8vJvFK86TgWdwGZkBZgmR
         rdEzWVV2tTNHuir2UiGV23IMkT6gaImsNooG+5vUzOSpje3ajB+q9RyeMTcVDyviNCCg
         aZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758040849; x=1758645649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRpNM2/xCih59eBZEAbu4g3iE4/D/L64LgWMt1ePFPk=;
        b=gJbfPJC8h0hquKCNYRB3xwqyxC8V1/u17Hc0Y9kftbBTVjJiss3qIUhxQgRyRfxaqC
         V0SP+8PuefrRd6Ct6YbJdecoA7O7mFJPjCpD4L+ARniM+spXkeolzBqs6rYW6fRM9ozp
         pHf7yu7ZEDiwsf7asThCTQdOozWsOuv4lf51UnZS6R+XDR73ty0JGo+ZbQKpmGQ69V5y
         mOde8eZziAg+ebnN31tYfUBBQJEvARdlB/knl5rCgXRjyRFg6LYtNsNKRO4JVVwtVpza
         AG++VwGefr1Q9n1epjYahsWPqgLQXMWwtrzESsO9TLetG5t6USD8dfrnQkntZe/n08Zk
         L8tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSZANMiYRrq/5Ac1IRKVjLP9YMJfmLaoYyDehiWzkQYzQUu5HjiYZNBoxuwRol6tU1rpOwLVytovI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3HjCbpeZKhoPmDQ03zBHK/rBLKIgSh4N/G1TSOeyMyeckyBB
	y72UNSSUgAeEOG6VAgjYbe5+sAI4onT0z1PvoujD7iT2v3Yr4/vFhkDTVPXhcxxYzPg=
X-Gm-Gg: ASbGncvXOLhMvjjZXkqj03WfDJcF8opHsJ+rWl0Yrt07ZmMn00iBy7Td7Jos3L8EO7D
	kRAG/MbWE3VioTfyp/aDzJpDEbfY4Ez/mXRhvHKEpr5QXav8ojZ+NMwjSS4rtWljWnNbBqfDswZ
	VzaaLDkgA0xobAgHjg3uSoQnJgWnd0cFdvmrFCAovbr7U/yZwLiuxGs6vqJOcpClxa8HDaVyB3S
	Bd5Y1QsPNUq7CUiPSjPpqEVxy/laY2TQISoCeWyeluBiXyGeNI1osw5Im1oI9dKEwx01+XJqsXS
	/BPf8obkTEOuuPgd7L9QZA3quIMaWN9VfN9PGzpSrFyiObSuuPe27AoHZuieVE6QeM+xo2yYl34
	ay7rAHzzs4/+SUg7+KkW0VO4EEitHR4TTXiUB7akqUMAwhcHX1iw+7RtHQ97TjMUUiXi0iOJwWM
	U=
X-Google-Smtp-Source: AGHT+IGcltY2eODvqYysqxpgvPqREuroqKSUaoNzZhYArRNaV4gU6OV6VkN+Z5JtCrPDyUnvVfBJrQ==
X-Received: by 2002:a05:6808:198f:b0:438:228e:ccc0 with SMTP id 5614622812f47-43d3f3ab4b9mr1377157b6e.16.1758040849051;
        Tue, 16 Sep 2025 09:40:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:70a1:e065:6248:ef8b? ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b82ae6c1fsm3333747b6e.27.2025.09.16.09.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 09:40:48 -0700 (PDT)
Message-ID: <8e88b601-1329-4cdb-bbd7-feb998c552e8@baylibre.com>
Date: Tue, 16 Sep 2025 11:40:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/3] dt-bindings: iio: adc: add max14001
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>
References: <cover.1757971454.git.marilene.agarcia@gmail.com>
 <30f33a64da0339eccc1474406afb2b1d02a0cd6b.1757971454.git.marilene.agarcia@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <30f33a64da0339eccc1474406afb2b1d02a0cd6b.1757971454.git.marilene.agarcia@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/15/25 5:16 PM, Marilene Andrade Garcia wrote:

...

> Notes:
> Since v10, I have not used exactly the same approach as Kim did in v9, nor 
> the same approach as in my v1. Instead, I merged both implementations, and 
> this v11 is quite different from both. Therefore, I have dropped the review 
> by Krzysztof Kozlowski. I am not very familiar with the kernel’s review 
> process, should I add it back? Should I list your names as Reviewed-by? 
> Thanks.

I think you made the right judgement call here. The changes are significant
enough to deserve another look. And you did the right thing by explaining why
you dropped the review tags.

> 
> The MAX14001 and MAX14002 both have the COUT output pin and the FAULT
> output pin, and work the same. I have decided to declare them as interrupts
> because I think some action should be done when they are hit. However, the
> implementation of these features is not present in the v11 driver code, as
> it was not in v9. But I plan to submit it in the next steps.

The devicetree bindings should be as complete as possible and not care
if the driver doesn't use everything. So adding them now is the right
thing to do.

> 
> 
>  .../bindings/iio/adc/adi,max14001.yaml        | 87 +++++++++++++++++++
>  MAINTAINERS                                   |  8 ++
>  2 files changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> new file mode 100644
> index 000000000000..c61119b16cf5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> @@ -0,0 +1,87 @@
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
> +    oneOf:
> +      - const: adi,max14002
> +      - items:
> +          - const: adi,max14001
> +          - const: adi,max14002
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
> +  refin-supply:
> +    description:
> +      ADC voltage reference supply.
> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: |
> +          Asserts high when ADC readings exceed the upper threshold and low
> +          when below the lower threshold. Must be connected to the COUT pin.
> +      - description: |
> +          Alert output that asserts low during a number of different error
> +          conditions. The interrupt source must be attached to FAULT pin.
> +

I don't think the `|` is needed here. It is only needed when formatting
should be preserved, e.g. you have paragraphs or a list. Or when there
are certain characters like `:` in the text. But neither are the case here.

> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: cout
> +      - const: fault
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - vddl-supply
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      max14001: adc@0 {
> +        compatible = "adi,max14001", "adi,max14002";
> +        reg = <0>;
> +        spi-max-frequency = <5000000>;

I would add:

           spi-lsb-first;

to this example so that people know it is a possibility.

I don't think we need to list it in the properties though since
it is included by $ref: /schemas/spi/spi-peripheral-props.yaml#.

> +        vdd-supply = <&vdd>;
> +        vddl-supply = <&vddl>;
> +      };
> +    };
> +...

