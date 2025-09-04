Return-Path: <linux-iio+bounces-23725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBEFB446B4
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 21:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA817AB07E
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 19:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816CF272811;
	Thu,  4 Sep 2025 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hIxA6llD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CE2237707
	for <linux-iio@vger.kernel.org>; Thu,  4 Sep 2025 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757015241; cv=none; b=dPS84PxRQWpfZ3ANx2cn4MB2XhIlw0D1hn1G4/kRmxq5euMT2WQUzIfhfDJdmDsnRFKc3viQAQY5wmoI1oq+2cFBFB+4WD7zaZ99/7OehkosakDpfT4REEJzjdClSxFi4pDItlDoNR6HgSi9LOGKg5kjHmmwb0HQPJYBqphxD1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757015241; c=relaxed/simple;
	bh=0uKBluwkW8S9ZJojZ77XmvLQl0hO1ujm9d+I2eVJD9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRp4cTOF1trx250lCMXj2yCLSTYowDZkaLXV3+evJsCK2ebrlOnW4hTSBvn0dW+eGFKjhsSIXYPEzAnRw8BN3HMsAcvaMiSnP2+ZoZOEt8qZkXR3ujs6gbdxgUccnJO7yhqG0FgX314AXxtHrnPxyl82UkWqwWnaM5Yl8gPZKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hIxA6llD; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-61e23ec2538so972882eaf.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Sep 2025 12:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757015238; x=1757620038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WdrAdy+IWPnyy2x2OiP/b29/tYOXeCzQkBFpQM/hl8M=;
        b=hIxA6llDXXzK/GvZGyMiInf0MscUctA466Fj1Wik4GeERuD/lkfbpApQC5uw3iUp81
         d2f6VHqKy6lTeS2r+tKJCLpSS7uus40IolEbHY92ylL/6vc/wlU3wPV8L+/agsyaJeLL
         stVIVfVEM0OOpmaecAZT9pOet9VUF8duv3eDJByMi301CHuo0t725Tk5TWPBI0LZpdqi
         zFN1OyI9TMyW8y6+DesETY9ary9+jStO+ZBoobVWUz1VM2Sm14Y4z1XtW+JK7JfpSK+J
         9ZDAcA51hhEEgo5Q7Qc+xRNqi3+r3wi/hZF0aZ3e9aHSMctrBrohq2Y9Ogafzh8cSfKo
         QNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757015238; x=1757620038;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdrAdy+IWPnyy2x2OiP/b29/tYOXeCzQkBFpQM/hl8M=;
        b=KV1l/lwRPcvgmS44RmCLL2/cOb75Xy6zN0ZUqncGu7cqIyzChQI/2UeagT86cOkh06
         /a+MBgXCWxmtuFgei4RXh1lOFxbvCg7QK+CJsrlK2hJzQkG6OKhBiVVkHX3S5eR3NSaN
         Sa4manbevsvAiukBjdwTyeRsRsjFxEtB2HiehM7LyiQ+iWAYsndMUV1/pBeu1CwOATvv
         M14FMgw4nfhMj9RpA0z/g0+RHSlFKybh0g2JtPsnR1xGLumh6Q2rfXKWoobiLGGKVnjk
         M4rm2hML0PtL6XtBuCsfl5izSZ5iwlh5rB9KBziS/pspKkMhQFzIFf71c+YklhjmG64D
         CFtQ==
X-Gm-Message-State: AOJu0Ywolq5mm/slVkUdLjsRVIRKfGDczMqWF9/PdYe/j0Fy2l65j3BO
	kPmqPhuFKjlThgkS5mQ3oq660jSsNtjKkI+8oCeLinwPLP1LF9KWvSlhh66KVEeGMhs=
X-Gm-Gg: ASbGncuRGHB3hgvoZx7FTm4WPDY95tRTPwPPvNvUbcqkdYjflw4KnZ8uNeklLg0lAHq
	LjK7/pet30cN0dRpCVnMWfPLmoGse12lTuGFhOHbo21BVEVMEH+iDQaht7mPnyYD2Hf/tp6dVu1
	tq9aynCV7csV7JE4A3gzI34jbuHbT80kkgBFvASBkc6HuoqLnErQ+iDJuW/MHfFu3qBt+SeXDQL
	7EKBj6aCpSQrHDiGVbRoMNL1GkiSzJ/RXvd8OqOuu4BCfTAichQviKx4shAu+toVC+0ep5aGhu4
	5Yne+JFr0Gz/GJ0CVoIF1Fgf/OSUNrwOkQRDwOsM5HGItwx7vKsKRYzq7Bh/FUzwxvA49j6CIGe
	3NJkf4wqDlkYcLktTTrGP1fSmnJ7xNlhqr4I2dTec6bAwCgzF6lTpgi24SGo6KrRV2j6FaHiPNt
	ryN2kcEe2h6Q==
X-Google-Smtp-Source: AGHT+IEw0CdMxMBJHWPN4YIH+Prs/3E9C5k20ULoXPlkVgyx+QT8YIIdd6jgssVML2iYRirYhicCOg==
X-Received: by 2002:a05:6808:8117:b0:438:8c9:5d8 with SMTP id 5614622812f47-43808c90671mr7979280b6e.48.1757015238298;
        Thu, 04 Sep 2025 12:47:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a178:aa1c:68f0:444a? ([2600:8803:e7e4:1d00:a178:aa1c:68f0:444a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4380001d11asm2968057b6e.16.2025.09.04.12.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 12:47:17 -0700 (PDT)
Message-ID: <99775fab-c0b3-4ecb-bc79-eabbc4975d28@baylibre.com>
Date: Thu, 4 Sep 2025 14:47:16 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add the NXP SAR ADC for
 s32g2/3 platforms
To: Daniel Lezcano <daniel.lezcano@linaro.org>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-2-daniel.lezcano@linaro.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250903102756.1748596-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/25 5:27 AM, Daniel Lezcano wrote:

...

> +  clock-names:
> +    minItems: 1

Usually if there is only 1 clock, we don't bother with clock-names.

If we keep clock names though, I think it should be:

  clock-names:
    items:
      const: adc

Since that is the only allowed name.

Although the reference manual calls this the "bus" clock, so that might be a
better name.

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    adc@401f8000 {
> +        compatible = "nxp,s32g2-sar-adc";
> +        reg = <0x401f8000 0x1000>;
> +        interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clks 0x41>;
> +        clock-names = "adc";
> +        dmas = <&edma0 0 32>;
> +        dma-names = "rx";
> +    };


