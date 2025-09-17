Return-Path: <linux-iio+bounces-24231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB67B81E64
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 23:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE233A7DD7
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 21:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE273303A21;
	Wed, 17 Sep 2025 21:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="twuEkCiE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9E302770
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143564; cv=none; b=AhwGy2m9cvg7SaYj2n6HCo3FcCQ1f7SBWE352icZ5WHaAwSTnRd/sjc1gKcxKzyrXQIJcgpfjTGQaM+LuwZBpETWnc5ctNNrM1/udzsH6azpqGhF2P5ZFHkP7Xg0PxFdv8N9hi1tjqUPYk/C4TZoEpwbSEPxTgpp+9mpyrJAAJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143564; c=relaxed/simple;
	bh=/pZUpGBHTmE6mbNDSvYncRjIgMqSNBgKDeqYVc3dpF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FlgfJSBJkOTFoVY1yPbhRkiHemApCE3H2AROXde6xxXlFfLolJRq1tGHOG6wl7dt0+aQ4Q0jPBWUqYieOGDOG59yOiDqLBeAxjKYiL47wxHdmrq6BvuWOM7XWLh1t/b9uB1PcbjPW0fgj7K+ctSEsGI2HBPpJtefo3eMa+5tDzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=twuEkCiE; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30cceb749d7so85393fac.2
        for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 14:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758143561; x=1758748361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0iSXIXWGlC6CrncsGDJJsV/PQ7JiHZCG+7TpNAxXWjQ=;
        b=twuEkCiEHfVrJ7qx/t03Z362603PQqJOAPvpoIOXzav7JaH10rdLMewO6otJpjlDTY
         BguiDXIZ1lKXnuow2eMYQylnA5LzIc5IRB5nR/sXvAvIcKzTipQFOxOxW//PNoWB9nZX
         2dGye2XVlabnzipZmhjR2oo6dxrNU7StICrJrgUadKuEhysMuEfaRyKzERoijDSkV3B+
         IFRnnVsWuDIjzId1HBY64BM1FflSzTqkEEuQ9bfoqU8XbNM9A1CcA4Li8fy8jpq4QtOx
         Pm9Fi+yglZ2FAaeh+5rNvd6fLrjSHnyNkPCPqJS19ZZUYBAs6BTRKV0l2InRpjjzGHUo
         +hsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758143561; x=1758748361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0iSXIXWGlC6CrncsGDJJsV/PQ7JiHZCG+7TpNAxXWjQ=;
        b=hIsWg51j+vwSd2ecLD7wD5KD/j+p8IP9tExRXcnAQVlEv4XVVdY+/rUcppSDuCqWbR
         lRbn50w5KNj9vfcFgcmLdSulL8l7SjTpyeVKnj9uFH5XX5FSjWJn2r8VKjq7SbRGdJWV
         XkGbof/Soo1xZuxL/OHKhk48F6a8mn74GhGtUo8rqSruOQF6OsHEGs8ixNMuNfOJYUtJ
         kdxs7H4PUn/KqWSIENS/3OKMi8L581XkpXPJ0Lla4QHUowXlhBiaJ14BmSD3PRMAz1SG
         AkW6GLylFHZnKuUwXoTyTlu/j5nfY0xk4KnV59xO0dE5d0DQFPv/Khia7GBKdhij4pRK
         mWZA==
X-Gm-Message-State: AOJu0YylHer34we18j4C2PD2B86N2ATVXjyxTUMYxDqhT3Y2hGhhG337
	6gL4o8WDP/ej2KTKni7qcMLfB0v+phyBxoa/NQKp7IIlMUeH8+bBn64bk6NgORQfj0c=
X-Gm-Gg: ASbGnctHoQcdqwcSP1//BN3pTIc0cdY66AHDelmq5usf374MW8qlX6+7TuX2zTk3J5u
	Fo7RScuBpFbz3F4hTvzg9WSmw/IjNrx9Ncqd5NeQTLUvTt6Yfd01ecx50CJ5LS1FQH1nIy6f4hs
	D+oGphykFckKkAy743Jvtns+dNMl5e+8jiXJFGDBSSh25onemSGimNawmOQzhuLYsRSNnUDMc2E
	YNL0LoY7ZSILilwMJ5fjXVG4yd/WPSTMLgtcAHJ6g3Qlq1UdFm692cdHGwSWv44LhSInn945UH+
	N8KL5oAEgMgjsITegN+Z1EEqRC+118owU+RvHE2ij5q3g+mugKc53Bx8LJ5pC1S6W+q6QdDNbvS
	N17nTzFL+AEmYnvspjMbcSa4p0AoFZKEQAfhPFzYHjyW+K4y0ZSdNnGRTQ9WMSmI0XGz0j5ivfA
	d7x+DY61UpsJWjWt3DwYxNKwGYlw==
X-Google-Smtp-Source: AGHT+IESyBoa6fy5Yx804lUnxEgI0bjSNyCE0o/DwX9crp+DsZQn64gew1ZEZemPRgXYgahL8sIKxQ==
X-Received: by 2002:a05:6871:3294:b0:315:ab22:8833 with SMTP id 586e51a60fabf-335bf629019mr1908198fac.38.1758143561391;
        Wed, 17 Sep 2025 14:12:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:72c:cb37:521d:46e2? ([2600:8803:e7e4:1d00:72c:cb37:521d:46e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7692a973dc1sm252607a34.30.2025.09.17.14.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 14:12:40 -0700 (PDT)
Message-ID: <3a2096ed-a12b-4e36-aa3b-cec3353bb39d@baylibre.com>
Date: Wed, 17 Sep 2025 16:12:40 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: iio: light: APDS9160: fix missing type
 definition warning
To: Yixun Lan <dlan@gentoo.org>,
 Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250918-60-dt-iio-apds9160-v1-1-0bd6bcbc547d@gentoo.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250918-60-dt-iio-apds9160-v1-1-0bd6bcbc547d@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/25 4:02 PM, Yixun Lan wrote:
> DT validation will report missing type definition warning for the property of
> 'ps-cancellation-current-picoamp', explicitly add type definition to fix it.
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
> I got following DT warning, when running dtbs_check
> 
> $ make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- dtbs_check W=1
> generic check all files
>   UPD     include/config/kernel.release
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> /home/work/linux-6.y/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml: ps-cancellation-current-picoamp: missing type definition
> ---
>  Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> index bb1cc4404a55760d3f2ef3818d8f5c14782dc5b8..f9c35c29fe04c3623349b636a0dd7ffa4ea24a14 100644
> --- a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> @@ -37,6 +37,7 @@ properties:
>      maximum: 63
>  
>    ps-cancellation-current-picoamp:
> +    $ref: /schemas/types.yaml#/definitions/uint32

`-picoamp` is already a standard property suffix [1]. Git blame says it
was added 8 months ago, so maybe you haven't updated dtschema in a while?

[1]: https://github.com/devicetree-org/dt-schema/blob/4b28bc79fdc552f3e0b870ef1362bb711925f4f3/dtschema/schemas/property-units.yaml#L92

>      description:
>        Proximity sensor crosstalk cancellation current in picoampere.
>        This parameter adjusts the current in steps of 2400 pA up to 276000 pA.
> 
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250918-60-dt-iio-apds9160-bdb725db100d
> 
> Best regards,


