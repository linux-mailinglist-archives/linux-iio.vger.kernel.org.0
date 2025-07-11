Return-Path: <linux-iio+bounces-21583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBD2B022E5
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 19:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A602B1C288ED
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 17:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E612F0E5E;
	Fri, 11 Jul 2025 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E4M0UZpo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4A12EF678
	for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255796; cv=none; b=HJdP0n2q1vYdAhAnutners49ol5fDGOEZx1/89ocvwVrWc8Gnn//OOuBw8h0P6Pf5H1KQY29cRnYM94djTlcf3m7Evga3VXztsvKNPUiSOAruBm15RzaOPTFVySU6zAGdflKsEuOe8iaUxCRtE9OkNkZeCWQgNqhztWm2sCNvVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255796; c=relaxed/simple;
	bh=NIjb6tJpXFO1Aa3nUsMHCLQBnlEa9zmtYz/P5JEAarw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XRT2xHRQAnLfLAJ24ByQ3N8yfpJ+eqOglmYlhp9OA9Fldeseyg0ezjCAW5asKacMFEv8BLk/y8jZauGzaLYEYJvbxyqI8pXHcAdi5PPBezaFpAQMrXIjofG9JiW4DG7AG1mcqwGUue8lUSlHkJh6tcb685Uk/fNbEmW5F3h1zLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E4M0UZpo; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-73cdff99fcdso1344976a34.1
        for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752255792; x=1752860592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y77pZNFKGFm2u5BmE2Xthvf2yTb17YeJ0EDuvg4ntVI=;
        b=E4M0UZpowCaGUlSzEiY0gXdbB4nRL1W+mScBst+bPcTYM8pl2AwsLFGJsWHQhwAh2v
         s2TZ51cOtOKuqfM3ZwY3/okoT+Z0lQMGFo1cjr314EX9RzLrxjxAOZk11hukepfRIv77
         lQ2jOxODeGBpfKZCRBKu0r+Pw+0NWe96ojFheYpT7am3qQs/MObrwch9MMkxH05LLN+r
         d+mXIbIbBmGEb8qfqnwtwpCHFYKLqHLOZJd/NGNQl6LtWk7JSgDhYtN88bA1y8V2Ak9a
         CuzAs8v1e2SUU6CGilZ2R+nmNvTf+NBftcDpg+KJyvua/cUFa0WKzKQGktYqeRbbUScn
         RDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255792; x=1752860592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y77pZNFKGFm2u5BmE2Xthvf2yTb17YeJ0EDuvg4ntVI=;
        b=LA2GfbToLAeVob+2CYRGFyDToHIWl/AgEHvZfcYC9vdH3+G/UnzbOfMbWCifBqLrOq
         +mdPq/mqXZO0KGVJAebXcgc+ZH2/SpPgXztWmcuZCLs3Kmki7IDB+F8os87065XfEBaP
         HiczqM1RQ5klCqX74naTLZcEM8jWO10IufljE8Mt+ehsf+899nE3GEpZ9u19znLcVxAj
         VDaFOJol7rnEuec1od35xhrwXwfBUaeUSfPMaoSMUt/1XgyxgyTcCAUXzjVba2g8SvWy
         oM1MWWMWuqfd0LnGcq9V0dRp/rFtHSBFCxEHM7PXlAOhLu4oUImbgvNIW/vRJh3sf6vz
         d+0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAn+Gaxp8W0iMqMANyno+7+hHAD0fjJgraPrxPgkSBSElH46IU3tmoaoLek01V9T9XABxRz5zJwds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3LqFXvbVIgaXeWQ3fdFwQ96THbA/JMoYnHqrqOtEkHy0rGM1e
	Dmc1bi7UiYaJADqCVh8YQTUMIWGd1UPOa4JkttGCi9ekEEtAVnneasha+01stk9CHVo=
X-Gm-Gg: ASbGnctE2v2x5v5nZObNZSsmN/r7QjuMmf/3LVnN+g7mk20gMaWKHA8kWOoFoUpinMB
	/L66PkzHEKC8FjFsZx4diS+bIt9fW/J/AuXwGPyB+0CfBSZAsCCpbylYH+hB4k6IskKT4Rp0HZV
	TcU4t0dxJxyXGfMWo/RhQIAReyhXFLlLpVvcCVEg3t8GPq/u1W9MVXv0AZjmG4qrQt/pLOy277X
	rnksVCMENKeph6HGZ+w7H86nadDXlp/AJM5yBi8iXsa9uYeorE63MwSqDAK91aExDeSpsXtmBNe
	fUTOUuX8ewQ5CNE2Dznc3gKq0JLAVnETxBoTTKp3RKmJc/2NURTBy3d7OmHfBZ9fgxXAic/+RSo
	wx1gLJ4j4IFMOHSWLbVv0NSPG18fSUghQxWaxLJEHqZciKDAL0sxyse/7QT9VCUqwC+nAW5duk9
	QwrnCvjlqGow==
X-Google-Smtp-Source: AGHT+IFYS1v6tuSBK8OmhxDArr5WN3nXOdB5LApDggJHKO7FO+cvcmVvVevvp0AiP9vbdF/fdux2SQ==
X-Received: by 2002:a05:6830:4c98:b0:727:876:c849 with SMTP id 46e09a7af769-73cfb256be1mr1763663a34.27.1752255791686;
        Fri, 11 Jul 2025 10:43:11 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4601:15f9:b923:d487? ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf1064d8esm637760a34.12.2025.07.11.10.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 10:43:10 -0700 (PDT)
Message-ID: <3de10398-6521-4c8a-9af1-e8d15421b963@baylibre.com>
Date: Fri, 11 Jul 2025 12:43:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: add ade9000
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711130241.159143-1-antoniu.miclaus@analog.com>
 <20250711130241.159143-3-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250711130241.159143-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/11/25 8:02 AM, Antoniu Miclaus wrote:
> Add devicetree bindings support for ade9000.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/adc/adi,ade9000.yaml         | 157 ++++++++++++++++++
>  1 file changed, 157 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> new file mode 100644
> index 000000000000..660dca4ea9b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> @@ -0,0 +1,157 @@
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

Let's keep this together with interrupt-names.

> +
> +  reset-gpios:
> +    description: |
> +      Must be the device tree identifier of the RESET pin. As the line is
> +      active low, it should be marked GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: irq0
> +      - const: irq1

The C4/EVENT/DREADY pins can also be an output and would make sense
as a 3rd interrupt.

> +
> +  adi,wf-cap-en:
> +    description: Enable fixed data rate for waveform buffer instead of resampled data
> +    type: boolean

This one sounds like a runtime setting depending on how you want to
configure sampling.

> +
> +  adi,wf-mode:
> +    description: |
> +      Waveform buffer filling and trigger mode.
> +      0 - Stop when waveform buffer is full
> +      1 - Continuous fill, stop only on enabled trigger events
> +      2 - Continuous filling, center capture around enabled trigger events
> +      3 - Streaming mode
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]

This one sounds like something that would be determined by how
a buffered read is setup in the IIO driver, not something that
should be in the devicetree.

> +
> +  adi,wf-src:
> +    description: |
> +      Waveform buffer data source selection.
> +      0 - Sinc4 output, at 16 kSPS
> +      1 - Reserved
> +      2 - Sinc4 + IIR LPF output, at 4 kSPS
> +      3 - Current and voltage channel waveform samples, processed by the DSP at 4 kSPS
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 2, 3]

There is a standard filter_type attribute that should be used
for selecting the filter type rather than hard-coding it in the
devicetree.

> +
> +  adi,wf-in-en:
> +    description: Enable IN waveform samples readout from waveform buffer
> +    type: boolean

This one also sounds like something that would be configured based
on how a scan is setup at runtime.

> +
> +  adi,egy-time:
> +    description: Energy accumulation time setting for energy registers
> +    $ref: /schemas/types.yaml#/definitions/uint32

And another one that sounds like it would be more of a runtime
setting based on what type of data capture you are setting up.

> +

Power and reference voltage supplies are missing.

ref-supply, vdd-supply

And there is a clock input and a clock output that we could
add trivial bindings for.


> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - interrupts
> +  - interrupt-names
> +  - adi,wf-mode
> +  - adi,wf-src
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  "^phase@[0-2]$":
> +    type: object
> +    description: |
> +      Represents the external phases which are externally connected. Each phase
> +      has a current, voltage and power component
> +
> +    properties:
> +      reg:
> +        description: |
> +          The phase represented by a number
> +          0 - Phase A
> +          1 - Phase B
> +          2 - Phase C
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2]

If we are calling this an ADC, we should be using adc.yaml and
calling these channel@ rather than phase@. There could be a custom
adi,phase property for each channel if needed. But I'm guessing
IAP/IAN is always going to be phase A, IBP/IBN is always going to
be phase B, etc. so I'm not sure we actually need any special channel
properties at this point.

> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +

