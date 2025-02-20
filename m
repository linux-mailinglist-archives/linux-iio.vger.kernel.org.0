Return-Path: <linux-iio+bounces-15898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741D3A3E67F
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 22:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB1C421E5E
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 21:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A892144D0;
	Thu, 20 Feb 2025 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="G9MBe+tY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD931E9B14
	for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086529; cv=none; b=ESuY9nZMtGWub3hIUyBWdneA+outejtL+IU7IiXEv8naSh08wV6mFLg4Zpze0AaPxiAwWXG6qoipa+Lz2g71/ymEeShtSRFdOo5Y1DZ/Ay5Pg+hZ3u0OHnEOwZ4QTPDLlvVdZPEXzmrOSkObv1OMvf5I/Ust0VUEiol0z/Kvgvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086529; c=relaxed/simple;
	bh=gK/PZJt4q2sG2dHwxcG9hM90AJLo2wr2AMBT39R3psE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ty2xTwOo6tfwG8Go7kQY4z7S1zSBTiO6If+NPw6eC6qkyvgZT+Xo/r2kdhVREMKxMCKJa5jFK+DQwwdLIfExLCsch/6dTK0idRM86yH19ZlF07Az9n8Kof5spMtk5bq2KgpD0IO31RhTpjW1VcFX6feH+l1oQ0vaen4PwsPN3Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=G9MBe+tY; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5fd0c7be155so576079eaf.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 13:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740086525; x=1740691325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRkG5vaOS0lDY9pA5VGqjHoCOhTN4lWgMCGaymcjWZA=;
        b=G9MBe+tYBa11JrS5TsgQQTahtDvYPHmlPf82vn5wvOCVrTMgoXIypZOz8XaE6aHvv5
         UTeFyQloANhzvNHQJNC+bXUXzcWDIoESN9hhXNXQ6DLHJEOdB8pj4uCLWSrU/Wp3B5se
         TNbumdYlvRt/joqJrv2Vs9iKy/onNFkTbiNKQnZRmTrDHsmQBd93ywerXZZ7SuKH/5+e
         XR3YaIlF7ZhnUzCka6UiRf3R3Qemet7oAmorZMyk6ABea3Ez4Y/8LOnRhYkkJlWrc4Er
         U9IW4UCVt37HkOT/nmVGq2hLV/Lnyt+As/hySP4bHfOut2Nf4QLeAG020dbNPMLUMyXd
         mSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740086525; x=1740691325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRkG5vaOS0lDY9pA5VGqjHoCOhTN4lWgMCGaymcjWZA=;
        b=Xancs7HfB+VoK8zv1FIAiaulDuEsUx4kgBlSLz26Vw/N2Be3n/bAi4/5Cav9WEMqPj
         lfZGasE+6KDdzH5IZc18VkFdbEEJw2yMirU9JgyoX+wYI6TKcQ1ybZbbk73SsbL456Ct
         rN9GzZ/Ggyfa4DTfBYsCxbrC96TWsd/hpNTNvHPTc2sVSXZ9i579mEqe/Xs85jy55IGl
         gktMo005UOWQsyn0+BhFVHcwPQAgBR59mJr5ot2qAICk+eeJvfOSvrmz6P8bNHK7ouBs
         bWplDTCeR5qWnUl4Oyu8mkpnV0OvXHW5z9Md/6Pj8j+8iXzlKxBEUEaCQmnEwH3mGR6E
         qUDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXWVhJYRlg79TQp+dU0ZD2pUcjOKgB+p8l7vDXUDgU4+c1FCV33wsR0B128pkeEs5wnlYr4UxHSAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhue8dUlAWnsnO/+37MInGw4srpOIwsnJrkXNujNgfyBsiHUy1
	+MKN7Ip/8TYCqXdX0KBcmfyRNUx4WBLTpzxV1C5AxuKBWie1MI96oJ8SQjm5tYAMdxZVQJKerT3
	P
X-Gm-Gg: ASbGncsd3bo6h92i0hHeG+M3H/wWg38u6zezplJeqFWgK7rwQmt7+aF5yv01AIdunJx
	nyw5Cv1U+7xV3dlJdRWKeYdTautQFmLsnr1VzRD5t/nl3I3gHIEPCllfBr5xpAPQGQR4DBBPb4x
	ZkRZzx/I1YBxpMEkPCOVWwY28D4NvPDxgTPFUQGH99czu6gmh3aDQGX0JV7nLkDHhJpurHJcYau
	jJUfaSLjTDWU5FTY2Gh/4ShnOQ0N7YAf9zlyuyzWoMvYJw3wAiMoQkwBGLFNkywgvxFSbUIDLus
	xRioXHgTA/oIN+TZzFVALSVH95lTraPgqTWuOUKeT1nOwF6RNZ5g
X-Google-Smtp-Source: AGHT+IHtrPQu27iToW6SI7eNT9OONk9gLd1u3ON/T5VT69MV/0pGe9KjerOvTUnPcei575boK3DXTA==
X-Received: by 2002:a05:6820:1a07:b0:5fa:4c67:b70c with SMTP id 006d021491bc7-5fd19a941e2mr688320eaf.1.1740086524833;
        Thu, 20 Feb 2025 13:22:04 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fce04080besm2294468eaf.13.2025.02.20.13.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 13:22:03 -0800 (PST)
Message-ID: <e7940b89-f884-44a4-b656-383950b6f778@baylibre.com>
Date: Thu, 20 Feb 2025 15:22:01 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 05/17] dt-bindings: iio: adc: ad7768-1: document
 regulator provider property
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com,
 marcelo.schmitt1@gmail.com
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <78c7d5d139d6c158423804f0e6c81cbfe9717b1b.1739368121.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <78c7d5d139d6c158423804f0e6c81cbfe9717b1b.1739368121.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 12:16 PM, Jonathan Santos wrote:
> The AD7768-1 provides a buffered common-mode voltage output
> on the VCM pin that can be used to bias analog input signals.
> 
> Add regulators property to enable the use of the VCM output,
> referenced here as vcm_output, by any other device.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v3 Changes:
> * VCM is now provided as a regulator within the device, instead of a 
>   custom property.
> 
> v2 Changes:
> * New patch in v2.
> ---
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> index e2f9782b5fc8..38f7bb0a0e20 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -59,6 +59,19 @@ properties:
>        in any way, for example if the filter decimation rate changes.
>        As the line is active low, it should be marked GPIO_ACTIVE_LOW.
>  
> +  regulators:
> +    type: object
> +    description:
> +      list of regulators provided by this controller.
> +
> +    properties:
> +      vcm_output:

I think property names are supposed to use - and not _.

 +      vcm-output:

> +        $ref: /schemas/regulator/regulator.yaml#
> +        type: object
> +        unevaluatedProperties: false
> +
> +    additionalProperties: false
> +
>    reset-gpios:
>      maxItems: 1
>  
> @@ -152,6 +165,14 @@ examples:
>                  reg = <0>;
>                  label = "channel_0";
>              };
> +
> +            regulators {
> +              vcm_reg: vcm_output {
> +                regulator-name = "vcm_output";
> +                regulator-min-microvolt = <900000>;
> +                regulator-max-microvolt = <2500000>;
> +              };
> +            };
>          };
>      };
>  ...


