Return-Path: <linux-iio+bounces-20723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB048ADBB51
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 22:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB727A5CAA
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 20:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD5A20F063;
	Mon, 16 Jun 2025 20:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XuHMbROX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701AC20B800
	for <linux-iio@vger.kernel.org>; Mon, 16 Jun 2025 20:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750106474; cv=none; b=LLt9BD8xCl1+DYslfpyKJEx0/3P9jyYsrFzygnKSFTar605pvmon5FoDbaqco0Zbog53mhCPwJdsWGrlBU9JToQX4dCt0gOY88jml7u5UniOIh/xP4H5fZP7ZP5uisp++aSB+r2qwSRZlh91ZeBKOa3S+Gy/Om9iIoQbr0SPmPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750106474; c=relaxed/simple;
	bh=I1ADj1YYA/0P9VYww4mRdxVOFiO6OjCF4bRvlcPDmRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kj8838mv2uUBaSOUOqh4yTSM5yLpluQ3HBl82tnk5+9NfqVF/dnWS8sI/lKdvPuryKflKebPEuEEI1XFA6i6GlZ0bw5+KqfMwQHY9GhWLgE0krxbb9MNZgILrjRCLARCVMVbd6zp4AYhqrVY05A7n5BzJQj7HNcSZAagpoO2kf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XuHMbROX; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-73a43d327d6so1273114a34.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Jun 2025 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750106470; x=1750711270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=im5kNIHpg71oIpCldz19fuuBQyresJi1tem3UV0h1IQ=;
        b=XuHMbROXNaoCbeHPU9sw/Q84sLVt+xnwqOWM+u0WpJLZOyLBHz8Ka+3nl+JTxssMLG
         pmRCwu2PKecsy0rFNc2Jc28ZFQV5+Qia1uGB7to4uRzev/rykrj7ruQzpPwAJw5dsrB9
         av5eemvB8fzUtIk6R1+P8Y2sZMEAhSF8ZGpgjDvGZt5c02ey/YUBOdlKwG7sU2Xl6TWn
         yq2ALoVYhpDWYONEzjrkUO9Tbql9d40V8sFzXKs7yAaFtK4cw1mMG6npFhII1WORQbd7
         ZqIq6jkxNEWa0zfLrKGFWSGz3lHB/2ztudXKJ6STpQS47CJhl0UN1Z6U0EbDr6hnMi6q
         oAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750106470; x=1750711270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=im5kNIHpg71oIpCldz19fuuBQyresJi1tem3UV0h1IQ=;
        b=Dk5+XoruWydnnrLZTm4U+u/juwjEPyia29n7aoE8GSZxxgwdtHs+TtkDhqMh5dOgxs
         hWhD6e14M9ZEcRDwu2FGtEEHq+pFVcqcefh2cmDWIjej81QpPokOeXqH5whCsc+qhsze
         T2jlB3ePhtZTH44QxMwn1MJjPaThIveT65yJ25BBSmFFoPbclQjKQG6fv7bSeI4tdUHn
         O42AxepZFAxLXZAwKGBHOZSXidRqqSoZnpccKX8ieV6PvEG44lDdRgsKwrz/KGjKOb1p
         yWCu/dFZFZ4vJqfCiK0o/zg/osRo2dur/QCtvgBY1AfUFx75opr1jeH0cK8oZ4EHhjsM
         Eksg==
X-Gm-Message-State: AOJu0YxLKj4KnxXk3wUyQJky6qzksF9xWMzKk1cswksjAwo6bIYN9Bg9
	bWO0IXZ6Ed9HZgEEEYyQEooax9rhx2j4xUhsU5TvQ73FvevBJW96ohNC05J7Q6XNl8w=
X-Gm-Gg: ASbGnctsv99VMdAYDjE02Xp3TCI/WOidX0waLqB9ddsglTBSrUtfbaIeh0hKoBQic1A
	ghAcqI3ubaDGIQJRfBxCS20nFd89e9lTgAe4QoRL03gLKUhsW7pBPQQgK3f5fxN5DXEUnqYDfWI
	AjffIX69aHz70mhxfAKCpm15D22UoRcxGw87AmfKpNlTnPtoVLmKCblnVS7G/eSgF6tUqAdUKG2
	46KlF4FcZH1xzCba+lPQgMsZ956+Io/F3VVxgHx8YlHoIeUp88sbFL8KMPhGn4+tLN5IHao7YaS
	9ml4RX0Xrhe/eg85zyt7NxsmqcL9BUjmteNyZpF79ojKV47EIj1Z8P1g4ilvUb7QOXFNhovp0GC
	uun7YAWbRTQjYIkdPTRqxCC3+Kl3B60mYE+R1JUdbZRnvgb035g==
X-Google-Smtp-Source: AGHT+IEsH+GjWx5DBPXhNJpG9GJzxKD3U06ehvPiNJ6zYbwHj4bcCVL5kJnMon+0twMR1UaMdanrvA==
X-Received: by 2002:a05:6830:2c06:b0:72c:320c:d898 with SMTP id 46e09a7af769-73a363f5a90mr6912233a34.22.1750106470433;
        Mon, 16 Jun 2025 13:41:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:9583:1e37:58ed:10ae? ([2600:8803:e7e4:1d00:9583:1e37:58ed:10ae])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a28402beesm1275336a34.19.2025.06.16.13.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 13:41:10 -0700 (PDT)
Message-ID: <eeb66815-3f7d-41fc-9d32-c28a3dda7749@baylibre.com>
Date: Mon, 16 Jun 2025 15:41:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/11] dt-bindings: iio: adc: Add AD4170
To: Conor Dooley <conor@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linus.walleij@linaro.org, brgl@bgdev.pl, marcelo.schmitt1@gmail.com
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
 <4df9d4d0de83090300b6870afc8ae7b22279cd22.1749582679.git.marcelo.schmitt@analog.com>
 <20250616-neurology-explicit-ec2a829bd718@spud>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250616-neurology-explicit-ec2a829bd718@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 10:41 AM, Conor Dooley wrote:
> On Tue, Jun 10, 2025 at 05:31:04PM -0300, Marcelo Schmitt wrote:
>> Add device tree documentation for AD4170 and similar sigma-delta ADCs.
>> The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
>>
>> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
>> ---
>> Change log v4 -> v5
>> - Dropped interrupt maxItems constraint.
>> - Spelled out RC acronym in reference-buffer description.
>> - Require to specify interrupt-names when using interrupts.
>> - Added interrupt-names to the examples.
>> - Made adi,excitation-pin properties identical to adi,ad4130.
>> - Removed interrupt-parent props from the examples.
>>
>> Proposing new types and ways of describing hardware for weigh scale load cells
>> and related sensors external to ADCs can lead to potential better description of
>> how those components connect to the ADC. However, we must use what already
>> exists for properties documenting features that are the same across different
>> devices. 
>>
>> Maybe, we could use generic defs to define adi,excitation-current-n-microamp and
>> adi,excitation-pin and avoid repetition with those. Though, that triggers a
>> dt_binding_check warning. Also, having mixed notation (some prop declarations
>> using defines and others not) seems to not be desirable.
>>
>> It looks like the only option left is making adi,excitation-pin properties
>> identical to adi,ad4130.
>>
>> On one hand, dropping adi,excitation-pin defs and making those properties
>> identical to adi,ad4130 preserves their syntax and semantics accross
>> dt-bindings. OTOH, we end up with more text repetition in the doc.
>>
>>
>>  .../bindings/iio/adc/adi,ad4170.yaml          | 564 ++++++++++++++++++
>>  MAINTAINERS                                   |   7 +
>>  2 files changed, 571 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
>> new file mode 100644
>> index 000000000000..e3249ec56a14
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
>> @@ -0,0 +1,564 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4170.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Analog Devices AD4170 and similar Analog to Digital Converters
>> +
>> +maintainers:
>> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
>> +
>> +description: |
>> +  Analog Devices AD4170 series of Sigma-delta Analog to Digital Converters.
>> +  Specifications can be found at:
>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4170-4.pdf
>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4190-4.pdf
>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4195-4.pdf
>> +
>> +$ref: /schemas/spi/spi-peripheral-props.yaml#
>> +
>> +$defs:
>> +  reference-buffer:
>> +    description: |
>> +      Enable precharge buffer, full buffer, or skip reference buffering of
>> +      the positive/negative voltage reference. Because the output impedance
>> +      of the source driving the voltage reference inputs may be dynamic,
>> +      resistive/capacitive combinations of those inputs can cause DC gain
>> +      errors if the reference inputs go unbuffered into the ADC. Enable
>> +      reference buffering if the provided reference source has dynamic high
>> +      impedance output. Note the absolute voltage allowed on REFINn+ and REFINn-
>> +      inputs is from AVSS - 50 mV to AVDD + 50 mV when the reference buffers are
>> +      disabled but narrows to AVSS to AVDD when reference buffering is enabled
>> +      or in precharge mode. The valid options for this property are:
>> +      0: Reference precharge buffer.
>> +      1: Full reference buffering.
>> +      2: Bypass reference buffers (buffering disabled).
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1, 2]
>> +    default: 1
> 
> Why make this property a uint32, rather than a string where you can use
> something like "precharge", "full" and "bypass" (or "disabled")? The
> next similar device could use something slightly different then the
> binding becomes pretty clunky.
> Can you explain why this is a dt property rather than something
> adjustable at runtime?
> 
> Otherwise, what you have here looks sane enough to me - but I'd like to
> see some comments from Jonathan or David etc about your approach to the
> excitation properties.

This looks like something that should be in the devicetree to me. For example
if the external reference supply is high impedance, buffering is pretty
much required. And using precharge is an application design choice to
reduce THD at the expense of other limitations.


> 
> Cheers,
> Conor.
> 
>> +
>> +properties:

...

>> +allOf:
>> +  # Some devices don't have integrated DAC
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - adi,ad4190
>> +              - adi,ad4195
>> +    then:
>> +      properties:
>> +        ldac-gpios: false
>> +
>> +  # Require to specify the interrupt pin when using interrupts
>> +  - if:
>> +      required:
>> +        - interrupts
>> +    then:
>> +      required:
>> +        - interrupt-names
>> +
>> +  # If an external clock is set, the internal clock cannot go out and vice versa
>> +  - oneOf:
>> +      - required: [clocks]
>> +        properties:
>> +          '#clock-cells': false
>> +      - required: ['#clock-cells']
>> +        properties:
>> +          clocks: false
>> +
>> +patternProperties:

...

>> +required:
>> +  - compatible
>> +  - reg
>> +  - avdd-supply
>> +  - iovdd-supply
>> +  - spi-cpol
>> +  - spi-cpha
>> +
>> +unevaluatedProperties: false
>> +

It would be more logical to place these before patternProperties (actually
really before allOf) so that they are close to the properties that they are
referencing.

