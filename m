Return-Path: <linux-iio+bounces-14110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D0BA09D62
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 22:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BEB3AA775
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 21:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A4820ADC6;
	Fri, 10 Jan 2025 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0cE+NGW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23439209696;
	Fri, 10 Jan 2025 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736545837; cv=none; b=WX9vui7N1+iADsg7CCj5P+eP8Unln173qpjszP6KOLp0prkatSQRyywwh+fKqrDB43HghC4Yf2f2dHCusPURa/k+VT31xSIK+bBVefez9BejiT4WV/UMTMCt6pql4vAfEPwMX9N5MBAp1YmKzjOOwddodstm0trx73QLeLlWgiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736545837; c=relaxed/simple;
	bh=0OyY23vJ0d2YYHt7z8F4xbKFu7fMbUTv4q9YBWnySa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cA2h2MStOCYGXP2dSseiVEggVBFBsqUVTEgdKDTQ1w2mETa1pSsPeztxYi68Jr8AYwiN4WjrfdvgQ2stoCUH73mj67xtGq7DG23/IYbaW9UBTJf8OlZG+62DyrSp660TcNcZa0R4BRabr49a8R+Kw37IJS4mRPiO0ZnuqQtAPv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0cE+NGW; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-85c559ed230so676988241.0;
        Fri, 10 Jan 2025 13:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736545835; x=1737150635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bMQH1h0Dr9ppiNzpovv7gXauZahIJxSRMst8z1BloBs=;
        b=W0cE+NGWA0b5gAsR5qiAvJ0LNpJ6GfoKqarSeYhXgdO2+2nNQ3loP9rQ+7ngGgPwH9
         WaMbj8N0RQYMcNhJP4UrqV4j5oqsYzPJn/7XgDAYRuy/AFVt7rQLsXuGSc2LcFV/BXtf
         Hq8mBmZNCKyOHkZAp4K9NG3K3ll7/dciAUbmszDQ6sK+OkVPESKQv85jK0rBbKOLAwqJ
         mNzC20rMuBq4CR1CsOJCPKMkIsP7kaC5yAaupJ8Eyy65jjJ5QUhUksS3zYcs5GkEKqEm
         UYiiyjEHFjivktdGTzMZVbletg4dcAc4Fy/tBmgpDp4hcWN12mpV9coX2O5EHYk64XaJ
         c/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736545835; x=1737150635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMQH1h0Dr9ppiNzpovv7gXauZahIJxSRMst8z1BloBs=;
        b=porzulgNqm7vZst9jc8UkxSLeviwwXDbOKAqXf/+ARb0E1Wij52wofF617ejZAuqZn
         2zgPFregv+6dQls4xlih14SmCRebRr/Ngg/CDJor187NWxCJPLLLLklYJEj7Pu4lBiRd
         uGs9qzFmZSsrCmC9V6vzG97wxJjWj0gZlhx76t4ZkRIgpUVsBwNN8q81ocRke/1Jbl8l
         1Hi5HwyuxDKtUGGU9ploqzBxCKrGeQzIGNNhgw4XPyiethSjOYUAH2hNxP34ONIH9MqC
         wLO7t06KfDpOTe2XPa0JJsnjXfYgnoIFIu/YVri/TPlSis46VjG7WablfnKiuzYGnKrV
         yhDw==
X-Forwarded-Encrypted: i=1; AJvYcCV0G6RBYbE5vdAeFHwV8WSv+jHJpiXZ5McLY05iOUdvhMPnKMZIcE2OBuS6nTaGlq1Pm2qzysJgiCRZVESU@vger.kernel.org, AJvYcCWl3w2tFJkVbV4A4ZPTrPyJAhxTrcgCRn2TWHwfQVUDMTbSOUaXY4UZxZ/4uX0nyCfOZaVuyU6u0ULX@vger.kernel.org
X-Gm-Message-State: AOJu0YzeCZzyLgVelpVmWN4/LSQm+iC+X1Lmaj2FoCh39BoS00QvCJrW
	T3/6mZ2XIR4bsaDBrVbDBgg+rETvB/oKenfvVFzaHBHhgdwAutA6
X-Gm-Gg: ASbGncszRb0HMpRR8Oe0+o+b6tU4jH5GM2lhFyV4IWEIz7CzPpmwpjtOTkqKWKu/Go/
	INvyDyLngPVIk8fKhul2/CrU9gsjJIDFXA4CTrZulA8mAv3lVAZWXbkeb2gVQ7Q0ChnZM+cZIgS
	ow4qqRDYBXUqxlvqf5k9bsxwaqfCPM9GwYzLU371sykMTxNhzoTnNZ4QqO/49TjTVV3Rf/zACGw
	dK0PjAqtr8YZYSED2X9RoFWxA3PFUUAnhOd75smIBZL6qKCESSNOZUPGuuhRseRSnQ=
X-Google-Smtp-Source: AGHT+IFTcKXjrqi4Rlf8I8DFX2cAubhoPFBolLt4O2nr5fXV8r8c8y67vAcrclgSxKCq09jXeVmiUQ==
X-Received: by 2002:a05:6102:6e88:b0:4b3:ece0:7daa with SMTP id ada2fe7eead31-4b3ece08829mr10065071137.23.1736545834855;
        Fri, 10 Jan 2025 13:50:34 -0800 (PST)
Received: from localhost ([2804:30c:1f79:9d00:c6c6:ec89:7531:7838])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f04da0sm3147512137.2.2025.01.10.13.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 13:50:33 -0800 (PST)
Date: Fri, 10 Jan 2025 18:51:06 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 01/15] dt-bindings: iio: adc: ad7768-1: add
 synchronization over SPI property
Message-ID: <Z4GWSgruwnkDfYSg@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <bde43579b41199f0c17f07dfacefcb137028e66e.1736201898.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bde43579b41199f0c17f07dfacefcb137028e66e.1736201898.git.Jonathan.Santos@analog.com>

On 01/07, Jonathan Santos wrote:
> Add adi,sync-in-spi property to enable synchronization over SPI.
> This should be used in the case when the GPIO cannot provide a
> pulse synchronous with the base MCLK signal.
> 
> User can choose between SPI, GPIO synchronization or neither of them,
> but only if a external pulse can be provided, for example, by another
> device in a multidevice setup.
> 
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
> +    description:
> +      Enables synchronization of multiple devices over SPI. This property is
> +      used when a signal synchronous to the base MCLK signal cannot be provided
> +      via GPIO. It requires the SYNC_OUT pin to be connected to the SYNC_IN pin
> +      on the ADC. In the case of multiple devices, the SYNC_OUT pin of one device
> +      should be routed to the SYNC_IN pins of the other devices.
So, if I'm getting it right, /SYNC_IN may be driven by a GPIO (ADAQ7768-1
datasheet Figure 131), /SYNC_IN may be driven by own device /SYNC_OUT
(ADAQ7768-1 datasheet Figure 133), or /SYNC_IN may be driven by other AD7768-1
/SYNC_OUT pin (also Figure 133).
That is too much to describe with a boolean.

If David's suggestion of using a trigger-source doesn't fit, this property
should at least become an enum or string.

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
> +
>  unevaluatedProperties: false
>  
>  examples:
> -- 
> 2.34.1
> 

