Return-Path: <linux-iio+bounces-14524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C81C4A188C8
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 01:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28A43AA762
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 00:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381999479;
	Wed, 22 Jan 2025 00:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HJ3GxGFg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BC04C74
	for <linux-iio@vger.kernel.org>; Wed, 22 Jan 2025 00:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737504998; cv=none; b=HI0gUBQTXjMKafQHVublZo7Kvc097yKrT9vkDnGIChbFnOZyBG7L6wnBomV1bHoVOfBlALI+bQV6NN+hVQhWY/cmY2x7UIgtEfN5VixjgfuOOwhfFWHEAD56isTMSwOCik03hV9gxs25kSI7M//kPrLKVo9pnQJ/Wob3CipWR2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737504998; c=relaxed/simple;
	bh=uM1KsvQ1MYDHCJxMmAEieb4nYTSx7G7GmRY4HGe+/2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JimUD8UOU4fgWoITGn67YcYr1EC+Z9qlSZ3UTvyd0JCGNkpe/NRf7XO6Jg0xSJwWfnWcxaBrguFEcMBULQdbN659atbdlQqS2ANmqP1OGBX0tQJFQyt2Nqp8qBqnRxQqQajRE1lOx+As29ONAtp90a1e5oFCD61Rg75MqfAEzys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HJ3GxGFg; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3eb9bbcc936so3778835b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Jan 2025 16:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737504994; x=1738109794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQVDg8zwmBbcXYl6zUtnOQaEMDJDakZCCSAsHxpjPDA=;
        b=HJ3GxGFgN3xBd6zHT0IsXugvd2BSK2Upjsk8ZNTDIzg1+vO4oiKKq98ONbRSU0aOiR
         1YSw0hCzBu1HI63/aTCvsvqQe17rmf8qGuDu384S/1K1W+g1Gz/O1wy6Os87zbB/GT/W
         i8s3tAov9oVRobGeWjMOCkcejm1SUZrnpnKNnCmnk2lrFaKmdGqtPSwYp67j57dMG407
         g2SwviBAh7fXmUsT+BdIK/HJ5cBQQAhH+So2GB6O+4FrCs3IBxKLwpcJuZ7efxI/WXpI
         7ahobg1T5B3vi8sBMi9JXq2I8DVOyHwJqvjmPu/TkmJtgzvBdfDihXj6Ijx9k4xPV6OL
         /TfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737504994; x=1738109794;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQVDg8zwmBbcXYl6zUtnOQaEMDJDakZCCSAsHxpjPDA=;
        b=JgtPjHLF+XmDS8e2hm8b0rhNpHVQNAePYNnggEKwDt8feKqpu20umQ4TdGMKO1pG+c
         e/L44fQlpVzKLMn5NRD3MRXO9XpC/bcwQhtSYOF44g+FdxoMOYADaXWJK7LPLSvSBKFg
         KSB6DHCDNxfsinJxSS75sR6mzNL+f/RB/iu8ZCyT2x018DNxFAzgP6jC10yt6JfvGQn2
         0Zf6OKVPBaFTVMqzpkDDHBgZ6N6VPamUISFRHWnYzaWr+QqRdduoQgqYyVCac1ZYs0I4
         3SPRsdBVqvnY8utxyQun3ueBBK65DkchYYTXldHIWwd5dbCV26Vh9+hCqBzhLJ0drx9I
         sYSg==
X-Forwarded-Encrypted: i=1; AJvYcCWjV9GCbklsdghecs8Jrtgn4cG1hridjXW1TnqX4XFycqAldgFx+iYGPVXLlmQMwSQ5o2EPCRLHkeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOslsjxsIhB4OeOcB6xwo4tsJcVuG65bMLOYUXfkBGIIi0Qydl
	Z8V8RW7WTTuUjiVghrcEmUT+AsFLppOqUpvSNmuVQt0uquHEiD7mu8LmWJXUSCs=
X-Gm-Gg: ASbGncvMImnKDoWxnIxHnNZ+LZ9ufR+PFAzAameMky3zrB/gtlsyojofBZsjUjfhhDG
	aMXV3EJz5tKlsa8JQimD9iYYHoh0EgkBYyVLuV1ymelMEQo2XWMF0fqNg8+bXb9eDTPLmqoxTih
	jahfqTiqUkMFoGK2swcm/IQKQP8sRRwZNuWAaoPiEG+C2z+hpGSivuCcHKRGil4/YCU0FWogYpj
	dkU7PGuHENV2eRLBbvC9yNOMyDcI2QD5BqxFAHMHeNHVI7HS1pvxNe1YwabGlflvmOPCgMIJpDe
	Wf/ZmRoNua9gp1F0zgnNpl4lJ8A8V0k=
X-Google-Smtp-Source: AGHT+IFUzXtAIp3HDw6cXZF7Eh349UV04myuUv9p02O2+mdfioB7429VrhWHruPNNSQlkcbzikUpXw==
X-Received: by 2002:a05:6808:3c97:b0:3e6:f6a:de5c with SMTP id 5614622812f47-3f19fdd1253mr12737286b6e.27.1737504994385;
        Tue, 21 Jan 2025 16:16:34 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f19da6eab9sm3330497b6e.17.2025.01.21.16.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 16:16:32 -0800 (PST)
Message-ID: <9f40295b-484a-48e8-b053-ff8550e589d7@baylibre.com>
Date: Tue, 21 Jan 2025 18:16:32 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: spi: zynqmp-qspi: Split the bus
To: Sean Anderson <sean.anderson@linux.dev>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 linux-arm-kernel@lists.infradead.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
References: <20250116232118.2694169-1-sean.anderson@linux.dev>
 <20250116232118.2694169-2-sean.anderson@linux.dev>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250116232118.2694169-2-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/25 5:21 PM, Sean Anderson wrote:
> This device supports two separate SPI busses: 

...

> @@ -84,5 +94,32 @@ examples:
>          resets = <&zynqmp_reset ZYNQMP_RESET_QSPI>;
>          reg = <0x0 0xff0f0000 0x0 0x1000>,
>                <0x0 0xc0000000 0x0 0x8000000>;
> +
> +        spi-lower {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          num-cs = <2>;
> +          cs-gpios = <0>, <&gpio 5>;
> +
> +          flash@0 {
> +            reg = <0>;
> +            compatible = "jedec,spi-nor";
> +          };
> +
> +          flash@1 {
> +            reg = <1>;
> +            compatible = "jedec,spi-nor";
> +          };
> +        };
> +
> +        spi-upper {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          flash@0 {
> +            reg = <0>;
> +            compatible = "jedec,spi-nor";
> +          };
> +        };
>        };
>      };

In the IIO subsystem, we've been recently working on several "advanced" ADCs
that could use a SPI controller like this. These ADCs have multiple input
channels that perform conversions in parallel and the data for each channel
needs to be read back on a separate serial line (MISO) at the same time. Another
similar case is to have two separate chips, but they share a conversion trigger
and essentially operate as a single composite device rather than two distinct
devices [1]. This would be similar to some ADCs that are daisy-chained where we
consider all of the chips in the chain as a single composite device, but they
would be in parallel rather than chained.

[1]: https://lore.kernel.org/linux-iio/e5e8eba7-2455-488b-a36f-e246844e11fd@baylibre.com/

For those use cases though, as mentioned above, we only have a single device
that would be connected to both buses. So for such a SPI controller with
multiple buses, I was envisioning that instead of adding child nodes for each
of the child buses, that we would do something like add a spi-buses property
to the spi peripheral bindings where you could specify one or more buses that
a device was connected to.

e.g. a device connected to the lower bus would be spi-buses = <0>; one connected
to the upper bus would be spi-buses = <1>; and a device connected to both would
be spi-buses = <0>, <1>;.  This would also work for SPI controllers that have
4 or 8 busses.

SPI controllers like these have a striping feature that allows to control both
buses at the same to either mirror the same data on both buses at the same
time when writing, e.g. for configuration or to read and write two different
bytes at the same time. A peripheral driver for device that was connected to
both buses could make use of this feature to craft a single SPI message with
transfers containing (new) parameters that specify which bus to use (one or
both) and, in the case of using both buses, to mirror or stripe the data.

Could we make a single device connected to both buses like this work using
the proposed spi-lower and spi-upper or should we consider a different binding
like the one I suggested?
 

