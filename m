Return-Path: <linux-iio+bounces-14001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCEDA04D9B
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 00:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2B216625C
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 23:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D951F3D31;
	Tue,  7 Jan 2025 23:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cjd0BLYw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C01E47B0
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 23:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736292914; cv=none; b=IK2Awue80ypxJ5Ca4y81IgT2bqJAFgHodcNxtqP1I4Ib62+fJd9oBeqXUrUYfcRHN416wzOoCy0fmErXzb4wtM4KQHPRgvCnyFxrTxTI89+OvAwXez4fylcs1MQnWooZaSaCeo0iPpnsLk12H8DYY8AfZ23s/F8fLqe6bA7JVB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736292914; c=relaxed/simple;
	bh=38u5AZwtgN7nNlI3NnVHXVWBZ15WteFQMmOJE7/zGkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAXltrWD5ScUPdSF6C1trz5gaPJQGVja1JmPzawqOHpOem0/XhY7u5IXsk5NT2bFlZMLc/67MVCr7+67CZj7AbkB9tCSXKSyq414obO50PhZk0oaffsotSFgpZMRgTUmNurmC+eYGgZJk/Pz+mdNqKU/BzHw31liXLmGIMJrT+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cjd0BLYw; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71e3eb8d224so3847347a34.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 15:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736292911; x=1736897711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyRVb3qwLePvkJYFvWifu9zIvV3WADLkuj3UA1XLNak=;
        b=cjd0BLYw66syZoL+liM6UoGcovNjjHZ5fxCDrcOLiJlE3uxkvuEK2/KYlXUCtEu6Jc
         7xI2dw8tMnY1316M+DWkvDi/7ZP2+b/W9775GpfhsJVvJje/gZxvWIzwQsvJXOwSnV0b
         QeQ6bG7tM5tqcePwIrscJBa4IWZ2XCF2naIUnVlDUGSpikvvqn7dsnkpFYnZ3x48y85N
         dADc/s0tha4aEt4MJ6iYldav2b3Nd2NTWE0q+zb3fBlUp78LVSqJsKJZtPvZPONAzXoe
         oPgaSGnAdYb03mYpA1vEsLyxwnmYU9cCq0SP7+BggqizFPAbThyWLrduke7OIrf6CuBz
         7wEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736292911; x=1736897711;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyRVb3qwLePvkJYFvWifu9zIvV3WADLkuj3UA1XLNak=;
        b=dgoG9E6Xwd2HXYP3aSVNPbtZPYpV/tbJdPx8rQjJhaZXyIpnqBJfNdLwKuIKUGUCMu
         7s0TOmXYOdfPTYT4TYR3EeoV7x59XxD0kMK4Qx6z3dD6VILyKJ/jhKh1H44K5JkwIhz0
         3o50lf2cXNzYL1zJo92cCGhZoLUq5+paQgrVttf+rjwBoM0K8C0JNAa+1pcYSztqjCji
         Ud7L/6xOhiRGUl+A0Q6MrrciQFeHHlRK42HalAUS+Ef0sphPH70FLN2o7OV/FWMfBufj
         cAxCQGZLodtQx5WHxN+87mWm0fNzbnlbD0oVaYA58mr5jkZD+O7B0iHWdIZfZVJyuyI1
         W9pw==
X-Forwarded-Encrypted: i=1; AJvYcCUx8WXC2OMwOO+IZyF7N9snSYHJkjgqQrsS9tttEvVDwxhzD+/XDYTxwWNH0Me38X23s+jTFgWJuV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc2e8fZOnTesvNorgsdH7/YDwyrYEiHCCP7of0A89wXgiUhGAz
	E/8CCvQqWvxWVeqysxMNsJYRiEb8JZKTQS2tnUtrKQlODdzYyCOV/zB+otqqvCE=
X-Gm-Gg: ASbGncs/63uUFA9A9FE9k2jSKQ413tDAoBU3Iv4sYK/fMMBH3KIbAomxg/M73SPeJge
	ErSJaq5p66QdOKYl+7FhAR0stiSgtVOlqbie0ZqMMiEB0eZe97w8KVi+jTGXZE8H0M9MoOu4wKu
	cAAfqQPVNDaBxF50huoEws2mw+01bKGPkhTk126qUxh7IS5Wvzq4CsT08W4A8norgCgEM6kHBsC
	L5kG6s41MXSd8RImobMexHzqmcROkUiZpdSsuhHFt1INWjWgndMl/u1QIjQUjgt+EDfj39d0lrT
	Air3TP05faIJ6cL0LA==
X-Google-Smtp-Source: AGHT+IGjHkwDEl+hw0YAKs4E01VXgqq6J1vxtL3PC5R8TuiwUehNX5loL0s78UBW9fwMkukB/ysZGQ==
X-Received: by 2002:a05:6830:390a:b0:71e:4ce2:4342 with SMTP id 46e09a7af769-721e2eb1026mr524228a34.19.1736292910702;
        Tue, 07 Jan 2025 15:35:10 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc998fc92sm10658656a34.47.2025.01.07.15.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:35:09 -0800 (PST)
Message-ID: <dc7f6461-6fce-4dbd-9be4-f7814053e7dc@baylibre.com>
Date: Tue, 7 Jan 2025 17:35:08 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/15] dt-bindings: iio: adc: ad7768-1: add
 synchronization over SPI property
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <bde43579b41199f0c17f07dfacefcb137028e66e.1736201898.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <bde43579b41199f0c17f07dfacefcb137028e66e.1736201898.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 9:24 AM, Jonathan Santos wrote:
> Add adi,sync-in-spi property to enable synchronization over SPI.
> This should be used in the case when the GPIO cannot provide a
> pulse synchronous with the base MCLK signal.
> 
> User can choose between SPI, GPIO synchronization or neither of them,
> but only if a external pulse can be provided, for example, by another
> device in a multidevice setup.
> 

While we are fixing up these bindings, we could add some more trivial things,
like power supplies.

Also, the interrupt property could use a description since the chip has multiple
output pins. I assume it means the /DRDY pin?

> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> index 3ce59d4d065f..55cec27bfe60 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -47,6 +47,15 @@ properties:
>        in any way, for example if the filter decimation rate changes.
>        As the line is active low, it should be marked GPIO_ACTIVE_LOW.
>  
> +  adi,sync-in-spi:

If this is saying that SYNC_OUT is connected to SYNC_IN, then I think the name
should be something like adi,sync-in-sync-out. SPI seems irrelevant here since
we should just be describing how things are wired up, not how it is being used.

But if we also need to consider the case where SYNC_OUT of one chip is connected
to SYNC_IN of another chip, we might want to consider using trigger-source
bindings instead (recently standardized in dtschema).

> +    description:
> +      Enables synchronization of multiple devices over SPI. This property is
> +      used when a signal synchronous to the base MCLK signal cannot be provided
> +      via GPIO. It requires the SYNC_OUT pin to be connected to the SYNC_IN pin
> +      on the ADC. In the case of multiple devices, the SYNC_OUT pin of one device
> +      should be routed to the SYNC_IN pins of the other devices.
> +    type: boolean
> +
>    reset-gpios:
>      maxItems: 1
>  
> @@ -65,7 +74,6 @@ required:
>    - vref-supply
>    - spi-cpol
>    - spi-cpha
> -  - adi,sync-in-gpios
>  
>  patternProperties:
>    "^channel@([0-9]|1[0-5])$":
> @@ -89,6 +97,20 @@ patternProperties:
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
> +  # adi,sync-in-gpios and adi,sync-in-spi are mutually exclusive (neither is also valid)
> +  - if:
> +      required:
> +        - adi,sync-in-gpios
> +    then:
> +      properties:
> +        adi,sync-in-spi: false
> +  - if:
> +      required:
> +        - adi,sync-in-spi
> +    then:
> +      properties:
> +        adi,sync-in-gpios: false

I think this can be simplified to using oneOf: to provide XOR validation

> +
>  unevaluatedProperties: false
>  
>  examples:


