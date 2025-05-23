Return-Path: <linux-iio+bounces-19830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9922AC26EB
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 17:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5483BC38B
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCD1295530;
	Fri, 23 May 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ph60W/EX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652AD19CC29
	for <linux-iio@vger.kernel.org>; Fri, 23 May 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015827; cv=none; b=ucc3Lsz6N2rERmkCoJNaQB9wZGdhIx9OaTH93mcITfNOh85SJTKOB5JH9hUEcz1/RTvFw5mrWeZiSzkge9KhAV+qGcTxsBKOFyJCiDCPWtlHzHcBoWD5vR7KlZPG7vsmklYziESXIvJzirSNWu0G2N3Z5xBfAZvQvSafQVYsqOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015827; c=relaxed/simple;
	bh=ILxEcaiDntXsflkF+6pQtHGgWFkbnjUWXJxdfu3Hvc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xxj1zudDpDn7KhVP/vlqhRKgrMQV5I5M5a3FcK9KdyuZTDvwP8DbXtA9q9VaTzkfoaP4Ys7AjgEs96yRmpqqtTDU3OQMSYxDHWDsghKo7sfVX/LrPSNC3hpK7uLosOc/vPrEsWtogLNYfMYFPldDzbf0nD4Bv0rSIM6D2hNpQKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ph60W/EX; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72ecc30903cso2555a34.0
        for <linux-iio@vger.kernel.org>; Fri, 23 May 2025 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748015824; x=1748620624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HCbggnBXhDFmScN6GeHb5Y4f9rXuA+BgiNUVjW1ACkE=;
        b=Ph60W/EXNL7g4208D/4r8v0ThIIFZoGRpxHj5uiOMVo8yYqfmRkn3AWzjoFMDcQyU6
         cP8keA8QMPwPjrpJeDi0fsbcq+4DArm97lz7Tc7Q7VOERsXMU7JnWu68JxnDG5v1ydI5
         glgAfebJiiN/Egq2FCUp/ZTD45KSgYdkRGlEpU/kGgmNArhqyCKRuCswvRURHIGU302E
         NXMFYVrgVy33HGR3lCqcPpiir+C3pxdcC3+V5KA25vERp0M9KlX+NG67DMYma/jKuMWG
         nBVBUEp9ezO2+erKuJ1RZhfV+0/Y8BghAIGSjZcedTk3kkAOQ/430amCC0LtdYmLkT5G
         7uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748015824; x=1748620624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCbggnBXhDFmScN6GeHb5Y4f9rXuA+BgiNUVjW1ACkE=;
        b=PLIXnZPCXSJ/4LCnlq2kr7dRBadVLFR/mcAAWeqWB7IkBkBCDaKaB37m8m7HnKMvvU
         dJNx3B6g8VQ2r0oSJqW700BK4KTtHys6wwD4E1LCmyyHHtmaL2HKrqWaldUmfVOs1zFx
         53TU4SJWSyspKNCt7Nn3C0b4Yz/AYflAPRWjB3ZjMaiB5gIQAiEMMbS7Svg0fLm1E8iI
         IORmYrOeeJAR6WoYmEw4czrbCaMkvHwVqq0jPGoWHqg6GSz6iboW2ivlpYFOVAGZiYWQ
         2MzIRNbJK/hmjy819Dj4Hj9krjC5+JOtW+yDXIU20/NhcbK0jtw82YMSFMzf+kdNgC8l
         yHTQ==
X-Gm-Message-State: AOJu0YwMBati7Ody5uXnrI8b7Ib91lD/VDiA7VkCRuKt0IRS5B56XJBh
	hgODkedRaUJ40nIArfswtins3OQns4UpeNg6/HHbUo0oW6sdgR6KRBdUheAb3mb1t5w=
X-Gm-Gg: ASbGncs4FoYkYgX3TQ6EqdkHxxSJv/+5v9qcNAcP8Fis5wbSzTgfFg6jzd4eRr2p97O
	FLAnqvxaygVMkk0Q57k7HyZwV61Q2hieTfE0Su4+XI/fQL4+LiKBuoSXsDAEP4oI7/GlBTphqua
	2g8Qd1gb9oeTOj/PXKiST02Ls4lRJIwe08Flw4/T1s6Nh3ERR8b+IZDe1gd79os4Jo8aXOpXDXo
	h/VUDK+no3KmyaGyRxK4yi8c0vJv+VuLp2f8yTk08ey9AyreyPrkK3vDPABhZYoUGFRMlZ1zkFi
	mxne+Rc5NuT3WXy+OxVGiKf69Fp2Njr98Jc0BL7a/+ucmGaFxLLqHcD9x2brJO5MM8fRnXXVk+K
	YTRiEUghNF1xvy6dm3DoxxjRQbvU3
X-Google-Smtp-Source: AGHT+IFc3c1i95mFKKiwhRskWte/zI9f2iV5+4DvWEUtWy3xpbU32DrMGlEVO2qex8u//4NOEEsbzw==
X-Received: by 2002:a05:6830:388d:b0:72c:10d5:783e with SMTP id 46e09a7af769-7355cfb0164mr17458a34.10.1748015824170;
        Fri, 23 May 2025 08:57:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d0c7:531a:e465:4a2e? ([2600:8803:e7e4:1d00:d0c7:531a:e465:4a2e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-734f6a4b206sm2902299a34.3.2025.05.23.08.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 08:57:03 -0700 (PDT)
Message-ID: <bcf45254-6c02-471e-86a6-66599a77c999@baylibre.com>
Date: Fri, 23 May 2025 10:57:02 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: iio: adc: adi,ad7606: fix dt_schema
 validation warning
To: Angelo Dureghello <adureghello@baylibre.com>, Nuno Sa
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org
References: <20250523-wip-bl-ad7606-dtschema-fixes-v1-1-d9147fb2a199@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250523-wip-bl-ad7606-dtschema-fixes-v1-1-d9147fb2a199@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/25 9:24 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Fix following dt_schema warning when offload is used:
> 
>   DTC [C] arch/arm/boot/dts/xilinx/zynq-zed-adv7511-ad7606.dtb
> /home/angelo/dev-baylibre/linux-iio/arch/arm/boot/dts/xilinx/zynq-zed-adv7511-ad7606.dtb: adc@0: 'oneOf' conditional failed, one must be fixed:
> 	'interrupts' is a required property
> 	'io-backends' is a required property
> 	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#
> 
> Offload is a third option, so none of the above is needed. Used
> "#trigger-source-cells" to identify offload usage.
> 
> Fixes: ccf8c3f106a2 ("dt-bindings: iio: adc: adi,ad7606: add SPI offload properties")
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> Fix dt_schema validation warning.
> 
> Link: https://lore.kernel.org/linux-iio/20250408-wip-bl-ad3552r-fixes-v4-0-b33c0264bd78@baylibre.com
> ---

I think this is too restrictive. Generally speaking, a trigger could be
connected to trigger something other than a SPI offload. So we wouldn't
want to exclude that possibility as this change would.

The existing binding has the same issue for interrupts. There isn't any
reason that we couldn't have interrupts wired up at the same time we
are using io-backends or SPI offload.

So I think we should just drop this whole oneOf: and let all of these
properties just be optional.

It smells to me like the original binding was written based on what the
driver supports rather than how things could actually be wired up.

