Return-Path: <linux-iio+bounces-12257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF949C8C21
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 14:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056DD1F22284
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 13:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF0C208D0;
	Thu, 14 Nov 2024 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfYGU6BX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB654A95C;
	Thu, 14 Nov 2024 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592187; cv=none; b=oWPa/fRA86Nz9VJcBfA4NWeGO/C22rId01xM2opF6xeJicUA5cd1JqDCe03JmxeC5PiasZ5kYUHbyW4iJW/hA/z6Tjwx5dfHg8QkjjBw40+4olbcGh+Zer1CEMp2Az67TCb8qqhQaLTISaAg0PtVihojAQ8LWjrmUDdTrK9UVHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592187; c=relaxed/simple;
	bh=qTo7CKolt1E4uoCLpV2VbWUachLChgD6RdUPRWDDkos=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SYVseSstTmx1fja0BsvTdzhHtpV8ujJULmvc9nkTTWDQSSiHA6DnnkHT2wjLOblxxSdOzRqzblBXLKfyq9o7c4sMWQvdCmE2AywTE2/DkzPPDvi4jcS4y1pBhLArnTbhXmdhn5VmTxnJqV+2INrRiTQ+gTqo5gx8fodLVU/GGms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfYGU6BX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so1082338a12.0;
        Thu, 14 Nov 2024 05:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731592184; x=1732196984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cgeG6n1ozGjtCnGyPOQPPbX46cvHrRUzjtSnNcbz9o4=;
        b=cfYGU6BXELAzQ99sUrZC1hC7a5UDllAsv36IGppAyAvqTz3u1t0EhmgThgvZMWAoI2
         LhyyVsKRuwOqQrTsLP4ScDwevG6Oc0+qQF1WTy2Iqe/e77wOHx8UW6KspRAgEbFPoUfO
         Fbufopyhrq4UmiyLUllcYkrsIjIakeZeFYzxe0Dj1mY7rHSUsGGFGXQIf/t5fcMxC8J8
         bhOMc58kzCxuu3NwE3oI6Vtpre/HMe4abmLy66G/TZdHAWUP/8x4NLouJOSR2qFglDdv
         Ow441Agvqdq+kXn6hXJeePRLO5CtC0Gb0iDFSMR5rP585C5Xw+kyIASLX22Ov68PyCYK
         bv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731592184; x=1732196984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgeG6n1ozGjtCnGyPOQPPbX46cvHrRUzjtSnNcbz9o4=;
        b=WG0HPSS4pN+7uE9C9Pascr5OKDYsy3bsO+f4La7EAu2uZAllMxZqQvtPL/vpL5fXq+
         8veGEdA6SnXwgNI3KTglgHdfIqbLFyY1Jk/WWFWm+LsCmYNZ/GaU1204Evg6siA7eMUX
         yGp5joCcMEl/yfMs4ReS/WMxgHJr7S6qzpJK0FziWef8QUk1kN9HQSryLBWWpLKv7ol0
         EgLriH/m+4TMWt/rUOMd0hkb3S5/c4GmKx/GofwD11RW1giq2LPsbk1sV3IwflmJ/Rog
         zY+E/na4/AT4ylOS6HWgw+ezHtHIxdRKKx/RBFH7zaq3RYEIwc4JLKtcjDBmUV/k9tKY
         TX1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIyEo/t15ITStn6Bhg1aPXWjPV5AUneKKVWRH73WDAIKlz9xseKogEsyvEZcgTnzyUaOq9i2ygB5im@vger.kernel.org, AJvYcCWC8+iuXpUaQTTrcpNs78LnZavYeYkw475XLmh+mtZQk4L3U8B2QodlDS2z69IFcv3S34OXMLcy8xfN@vger.kernel.org, AJvYcCWGrhxyFtcXyneYRp5utVt9pjz2/HVLsgFS/+d1EfFZ+Qbohyd7h6HTUvld67IYNfS8psguOOkrppGebUXD@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk1R+moeDiqmhu6Tfw3Pg9KW+zn5Y/06IjQfQHc21vXMyqe7z9
	aGssai41SXbXsgTYYo0mN7UUerDw8BqhciOhyBGLQHUZshXs0X2xgy143A==
X-Google-Smtp-Source: AGHT+IFiffkdkgwmQq/XTUWNHqnv90zEwXnpGUeF218xEUTOqrccqRc0R4HbF4cKEeIdkK4w9YvfMw==
X-Received: by 2002:a05:6402:3509:b0:5cf:3d1b:5ebd with SMTP id 4fb4d7f45d1cf-5cf4f33693fmr8074284a12.3.1731592183814;
        Thu, 14 Nov 2024 05:49:43 -0800 (PST)
Received: from [10.10.40.97] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79b9fabdsm620106a12.30.2024.11.14.05.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 05:49:43 -0800 (PST)
Message-ID: <adbcacda-c3c6-452e-9dfe-22d55bfb293e@gmail.com>
Date: Thu, 14 Nov 2024 14:49:41 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: frequency: Add ADF4382
To: Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kim Seer Paller <kimseer.paller@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241114130340.7354-1-ciprian.hegbeli@analog.com>
 <20241114130340.7354-2-ciprian.hegbeli@analog.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241114130340.7354-2-ciprian.hegbeli@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/11/2024 14:03, Ciprian Hegbeli wrote:
> The ADF4382A is a high performance, ultralow jitter, Frac-N PLL
> with integrated VCO ideally suited for LO generation for 5G applications
> or data converter clock applications. The high performance
> PLL has a figure of merit of -239 dBc/Hz, low 1/f Noise and
> high PFD frequency of 625MHz in integer mode that can achieve
> ultralow in-band noise and integrated jitter. The ADF4382A can
> generate frequencies in a fundamental octave range of 11.5 GHz to
> 21 GHz, thereby eliminating the need for sub-harmonic filters. The
> divide by 2 and 4 output dividers on the part allow frequencies to
> be generated from 5.75GHz to 10.5GHz and 2.875GHz to 5.25GHz
> respectively.
> 
> Signed-off-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> ---
>  .../bindings/iio/frequency/adi,adf4382.yaml   | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf4382.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4382.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4382.yaml
> new file mode 100644
> index 000000000000..44a29ac7a2e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4382.yaml
> @@ -0,0 +1,141 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,adf4382.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADF4382 Microwave Wideband Synthesizer with Integrated VCO
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +  - Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> +
> +description: The ADF4382 is a high performance, ultralow jitter, Frac-N PLL with
> +   integrated VCO ideally suited for LO generation for 5G applications
> +   or data converter clock applications.
> +
> +   https://www.analog.com/en/products/adf4382a.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adf4382
> +      - adi,adf4382a
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 75000000
> +
> +  clocks:
> +    description: Clock to provide CLKIN reference clock signal.
> +    maxItems: 1
> +
> +  clock-names:
> +    description:
> +      External clock that provides reference input frequency.
> +    items:
> +      - const: ref_clk
> +
> +  '#clock-cells':
> +    const: 0
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  adi,charge-pump-microamp:
> +    description:

These lines are a bit over 80 chars, maybe you could rearrange them.

> +      The charge pump current that the external loop filter was designed for.
> +      If this property is not specified, then the charge pump current is set to the
> +      default 11100uA. The valid values are listed below. However, if the set value is
> +      not supported, the driver will look for the closest valid charge pump current.
> +    anyOf:
> +      - enum: [790, 990, 1190, 1380, 1590, 1980, 2390, 2790, 3180, 3970, 4770, 5570, 6330, 7910, 9510, 11100]
> +
> +  adi,ref-divider:
> +    description:
> +      Input divider of the reference frequency, cannot be lower then 1 or
> +      higher then 63.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 1
> +      - maximum: 63
> +      - default: 1
> +    maxItems: 1
> +
> +  adi,ref-doubler-enable:
> +    description:
> +      Enables the doubling of the reference clock.
> +    type: boolean
> +    maxItems: 1
> +
> +  adi,bleed-word:
> +    description:
> +      A small programmable constant charge pump current, known as bleed current,
> +      can be used to optimize the phase noise and fractional spurious signals
> +      in fractional mode.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 4095
> +      - default: 0
> +    maxItems: 1
> +
> +  adi,power-up-frequency:
> +    description:
> +      PLL tunes to the set frequency on probe or defaults to 2,305 GHz.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint64
> +      - minimum: 687500000
> +      - maximum: 22000000000
> +      - default: 2305000000
> +    maxItems: 1
> +
> +  adi,output-power-value:
> +    description:
> +      The output power amplitude level which will be applied for both channels
> +      at startup.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 15
> +      - default: 11
> +    maxItems: 1
> +
> +  adi,spi-3wire-enable:
> +    description:
> +      Uses SPI in 3 wire mode, by default is uses 4 wire mode.
> +    type: boolean
> +    maxItems: 1
> +
> +  adi,cmos-3v3:
> +    description:
> +      Sets the SPI logic to 3.3V, by defautl it uses 1,8V.
> +    type: boolean
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        frequency@0 {
> +          compatible = "adi,adf4382";
> +          reg = <0>;
> +          spi-max-frequency = <1000000>;
> +          clocks = <&adf4382_clkin>;
> +          clock-names = "ref_clk";

Should it not be adi,charge-pump-microamp instead? dt_binding_check
complains about this.

> +          adi,charge-pump-current = <15>;
> +          adi,ref-divider = <1>;
> +        };
> +    };
> +...


Best regards,
Javier Carrasco

