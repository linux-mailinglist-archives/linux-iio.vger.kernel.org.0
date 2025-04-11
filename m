Return-Path: <linux-iio+bounces-17987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08870A8688B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 23:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 384607B8650
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 21:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A5129CB45;
	Fri, 11 Apr 2025 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M6dr6Jbo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C7728F927
	for <linux-iio@vger.kernel.org>; Fri, 11 Apr 2025 21:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744408635; cv=none; b=qbJk9OgOjrTWkvdbLKhh0ZR/QHdQf0bYK/Vjxl45Uu77BwIXiefrH45hM/7fO3/0gvFqJilPWQ1CdryPAFgYXHKfI2gz+zCrg8rO9HUhJDEsNYdhEB5Bcy51gp+2TE1rBjvdlS+dI0uUZDIbDiwgp4IVd5KM4gc1jXAt0RAXLqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744408635; c=relaxed/simple;
	bh=U/5OSHIm4xidi8WZpyCWBuRqvMGUXBR//iyTnMoWcNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bh3CsFhl5CxKA6qeBZrOf0EadmhxyfPohci6yFirlnOhxN7BEcxvHb0rZeHgLmiw5VZ85Zks8wm/GsFkot4Jxfolr+yBvSXJZtCRUVFj4lSRldrBzqWwJ4Ribq1+0yl81qTu2s2HzjBbgUhJgpIr3KQErMSVPsReWXXRGTRKclA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M6dr6Jbo; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72bceb93f2fso1865855a34.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Apr 2025 14:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744408632; x=1745013432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGxgbzS8SsXJLi5EFV0c4NWHcpynG76/jsFGgon3TKI=;
        b=M6dr6Jbo7oVS8NsgNlCn2EguipsGDH9H50oBIxFxjAr2bh3JnWasNuTJv1AxkFTXfW
         wW9ke+3WzhjlrvUPLqip92zDQnEylA7TyYXpVOAvkvPdrecqxToTDOBBWn3YDsVugdBM
         qjegjBZ6JAfYQ2hb9UwjGJd63z//gobAM2zNdIo1VSUNp7Sb1Z4Y4ekfDo07v4YNC+a8
         NkfDxkhUVLS3VC8rblHwI4hwSHfECa2TrLUY68IbhOQVnc2Rgssn7N5UIeE/1Fqs7Vr1
         13qeE8fs1DYcsdDeqpfehtdJSSNbB0g0Qon9CzeMTWVun/ixOjOwv+/9KKIkWuo7hTHm
         q4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744408632; x=1745013432;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGxgbzS8SsXJLi5EFV0c4NWHcpynG76/jsFGgon3TKI=;
        b=eNn9TMwDsHwZ/OFeOjaSj4DtGM9jMH+SZXcHpHVM86QdtlAdmin38YShqQp4tkZbF8
         cOjE3WCGW81PXUtTm50jPywneiNbvV8tDIekvcEnkLcakcelFgUWxFduT4GMcaANSR4J
         rW4OlOxMF4gbeLZSqv8sUc0D6lk86F4F8IgqoFr6pvGWPnzD/IMd2daK99LJuWRU64W1
         IQFSriOYVyoxfYjATj4dVnqHig8mJsW63HuuL0uAUbeezUWsJdNRq/e1nlUHLPxWY4MP
         wS1ZERizO1jmnMXltglxATaxQ9lE3vrvoEX3W6idhwRc5yFLWPA/Ku9u8JFokJdjNmEw
         Xc2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsWLjphrwkzZXCctlm9GwwUJC07Hi9Sl3hs2Bm2OmsZ6xknNh7L4QOCWSVp+fJzaCeGwl54al1ZgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4iTWfNhDMgOTNIVjmW7r80lpvMBJV0kBoIKxfjP/5xkqZripD
	B/6uyzV8SjgvGLQgnGklA0Yt8FfpazKYcq4bBWY8JWP6VtCXUQAy9zKm5w+bL18=
X-Gm-Gg: ASbGncvGWnyLYcVFCaN7hd3hNFGi+dQ8v8q6NrrZgMABaPm8U8Mcv3/pLE3UueXGSuI
	IJWSYEzRrjuLIdTfSubxCn8tl2a10w5WuEs1pzsscqA7iLRpk3Rn+nH0eav648PLbXcCDbepeck
	eBbKYllq/MONSBQ+3mhra9mEtCzAe0bME9FW7EpcFa3gPKreLbwAV6QuyCnkJB1QA0H1bISrdgx
	nSMAfVhW13RBzDXxoERF5VQi4Y7TKx6URpsR/tDKg3iq7IsCxbH6xPFIY4Lx1nGcMH8IyaNeihK
	NtdPY50q1KCbb3jbdHWt0K5vRMZp5t2ymznVL6BJwjSyXADAnos5w2sSOY4DiVJzPHdM3x5H8MA
	3OlT/kQqy7awq
X-Google-Smtp-Source: AGHT+IHJ8jsSgRFDtzkrcSxyEZnKdBoL/URDBhhkNCEX69zyJiLizO+9RyTuZoOivQHbrnufomIfTQ==
X-Received: by 2002:a05:6808:17aa:b0:3f9:176a:3958 with SMTP id 5614622812f47-4007bfe4d70mr4807862b6e.11.1744408631784;
        Fri, 11 Apr 2025 14:57:11 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6045f5b295bsm1073636eaf.35.2025.04.11.14.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 14:57:10 -0700 (PDT)
Message-ID: <3027a9b0-cf4a-4e55-80a7-7f0dd2a008e4@baylibre.com>
Date: Fri, 11 Apr 2025 16:57:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/14] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, jonath4nns@gmail.com
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
 <35481552e9ce39a24a0257ab001c0bcfea1a23be.1744325346.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <35481552e9ce39a24a0257ab001c0bcfea1a23be.1744325346.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 10:56 AM, Jonathan Santos wrote:
> In addition to GPIO synchronization, The AD7768-1 also supports
> synchronization over SPI, which use is recommended when the GPIO
> cannot provide a pulse synchronous with the base MCLK signal. It
> consists of looping back the SYNC_OUT to the SYNC_IN pin and send
> a command via SPI to trigger the synchronization.
> 
> Introduce the 'trigger-sources' property to support SPI-based
> synchronization, along with additional optional entries for the SPI
> offload trigger and the START signal via GPIO3.
> 
> While at it, add description to the interrupts property.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

...

> @@ -57,6 +80,15 @@ properties:
>    "#io-channel-cells":
>      const: 1
>  
> +  "#trigger-source-cells":
> +    description: |
> +      Indicates the trigger source type for each entry:
> +      0 = Synchronization GPIO-based trigger
> +      1 = Synchronization device trigger (e.g., another ad7768-1)
> +      2 = GPIO3 pin acting as START signal
> +      3 = DRDY pin acting as SPI offload trigger
> +    const: 1
> +

0 and 1 don't sound like trigger outputs that this ADC is providing, so don't
seem appropriate here. But the SYNC_OUT pin is missing from this list.

Also, outputs could be used to trigger anything, not just SPI offload, so don't
need to mention that.

