Return-Path: <linux-iio+bounces-18861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DF0AA1615
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 19:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8128B9A20C8
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62E82522A1;
	Tue, 29 Apr 2025 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YsIeU8WW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C523247280
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947591; cv=none; b=mb0BBPbFHCNVdzbkYJwW6200pKl3YDbelkoXNjIpLp+fHTLpHWQFsGiRwP3rbPeOVsTkaewTId1Uyf0aRZqM1MMWQf7tTmAMZhdcBgC0pHxvygpHShmm/ruXEsfeAQn8vT9a7j3iZRh03/QanyXoQ39JXDcge5u9ewGc6gImUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947591; c=relaxed/simple;
	bh=7/r+kRE8PwvZkzCqHeJ6cAWMXVFDXMKM0pFM4kYPawc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wdwg/XdmtoSGbsJl8DybvHdxAAPfwulsbL1zb/OmJp7Des5UFFgpDJmUzRFpNLJRl5WvN3R694sJmOuA7yV1hmRO+L1RT3doyPDPaB5OLHaGL6a6p6vX+sNWHW8O60n301/hwxJJsWWI4fVnIOvFHHuwQFw41gECO/KBQ6uP+4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YsIeU8WW; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-606440d92eeso3277537eaf.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 10:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745947588; x=1746552388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QZ2g6zKZfle2bhJ5TIK6uWf8PPm/y7+YFw/ot4iG/gE=;
        b=YsIeU8WWHBPME2MXC4GS8pEI26o+/u4xh7g3hTPUgT4NKWs8JPhiJF+ij1JxkJGV2e
         8qLxpyzdR231Pf4DD5AAfRptTaKDznrItbIotIKjJb/VnFrNz5+6ViXNQ6XOIBUHC2f6
         AsZnfZoOaHx0QjiDmhMyZnN07Oei2/z64w3y9YY4igWZ74yFAYBqN6i2ha0U7mUlLMVe
         uZzmx9Nf1s+IwMmAP893p4l1om6hb6iu8Z/99XigCr62v1z6IcDCdW6wIomaENAw6ZtF
         R7hZmcrzB1Xb/OLZnnulcIlYQ1QTdd7gBkk3r3Hu00ZZ+v7xTTYORCuTmbfpyK9JO4lV
         VVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745947588; x=1746552388;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ2g6zKZfle2bhJ5TIK6uWf8PPm/y7+YFw/ot4iG/gE=;
        b=MaG87mRzIs+OnJI3qoQzcbn3pNT/gZjkM44Qw/J1xxg3yqL+1jajAnh0+HVeuxGLSQ
         kR/FrJn7S0fOVcKcLuzwnpBGJwkgIcve3/6m8eUUuKpv7owVwg8fv4CGn8LyisEHzcDQ
         kU3hoEsXYQNLnhZSLWA6WUZvUiZ0Q2ks5xqqNoQS89rocg45Z7G48cobI07RfwSTwxzM
         EGbOuD6gRN66yGGuZVE+5MVYcGna9uzE5RaKui5rvPuX4P7WDa/f/SkwI4gPw1KH8bMr
         4X1NeuTVr1tvHTtORWJmIM+UNFm9xG2tkXGw1k1TSq56RLE+rN8gsScCgbp3CgQiAbH6
         Vcyg==
X-Forwarded-Encrypted: i=1; AJvYcCVcOIieG98hiavn6IFtuzoN67cYOyZCVAlh0oGvqL2b0lQIOzzIHKNKyxk+3baZugr0iw7GsrklHV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfK+OESAxfwmICJSyl1CoZuEYc7YXHkZEuSyZg8Z05d/CNilRX
	ZuePEwSYGrRG/vWSKlQcZBnGox8gPqzg5aZ29b6yG5GYZtn0VaWp4qRkeIj3w1g=
X-Gm-Gg: ASbGnctOJw2fIXBwTI4qqF1oVUDd0gKqD+mmsd86uxicRPL6GgYuDaJHKrn3A3ymt0B
	yHS0dbOJl/QxHjNtVe6VqJmKKHYh8/dSWBmcoenn0EhZR8XIF3JrNI4yIMK6p7voQ+B+om8wI7d
	7Yk8uoH4mv9U4DZMWdwEQy3W7K+aJ/3jl7Tje2ucKvp6vnJYVDAJPkQOGP5YBzoF5d58TFQ1gcv
	XuATiQYcvv+2V0n0loWeqtbzrOtQdJz/MCqZtrpHkiiCsWErF1hqXym3qOdjAh+h2aF1LiivQdV
	hKpH/6izQl0BEAoY/IxOqOIDlX+p++zKjyE3jcjGKq3EuRxhxxZBpgLvte1rnDwF1YpMiB61DJy
	BhnrUN/CrfH+qigggGw==
X-Google-Smtp-Source: AGHT+IEfTeUQO0w+CK2girx/RErz7NGrkaGNtLF/J9RvQJnFMJQ+cMG8h2DSovjttwNeq03UDsd/Uw==
X-Received: by 2002:a05:6870:9629:b0:2d5:2955:aa57 with SMTP id 586e51a60fabf-2da3eb9a0f3mr2337581fac.0.1745947588639;
        Tue, 29 Apr 2025 10:26:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6? ([2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7308b2ef3f3sm381658a34.54.2025.04.29.10.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 10:26:28 -0700 (PDT)
Message-ID: <7b11bb00-fd2a-4df4-bb7e-7e67ed396ba2@baylibre.com>
Date: Tue, 29 Apr 2025 12:26:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/11] iio: adc: adi-axi-adc: add num lanes support
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250425112538.59792-1-antoniu.miclaus@analog.com>
 <20250425112538.59792-10-antoniu.miclaus@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250425112538.59792-10-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/25 6:25 AM, Antoniu Miclaus wrote:
> Add support for setting the number of lanes enabled.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v3.
>  drivers/iio/adc/adi-axi-adc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index bf0155830d87..8ff781ab5ec3 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -44,6 +44,7 @@
>  #define   ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
>  
>  #define ADI_AXI_ADC_REG_CTRL			0x0044
> +#define    AXI_AD408X_CTRL_NUM_LANES_MSK	GENMASK(12, 8)

Same comment applies here. It looks like this is common to all cores, so no
AD408X in the name please.

>  #define    AXI_AD408X_CTRL_SYNC_MSK		BIT(3)
>  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
>  
> @@ -451,6 +452,19 @@ static int axi_adc_sync_status_get(struct iio_backend *back, bool *sync_en)
>  	return 0;
>  }


