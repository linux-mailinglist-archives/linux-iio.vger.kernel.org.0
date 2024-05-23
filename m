Return-Path: <linux-iio+bounces-5203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6198CCBE3
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 07:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4049281F43
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 05:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CE9537F5;
	Thu, 23 May 2024 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdVMATvZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF241C3E;
	Thu, 23 May 2024 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716443428; cv=none; b=XkmYbKaT8LS0eOpTOdtHHAH40uHRUR12muAPeuIqwpoXbGQ5fGigkFFq45EbsvpfNvM3ts+93LJ3KQUuZSAakONw+UxpTgwnjh18R9WbtIm9AXrdyCUKOeeKf5qxiBtARq5ICX61oG7AeObIKVQud6NQxzgmP1qhLatFvaWlDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716443428; c=relaxed/simple;
	bh=O9ZpLdrSq0BPu4TXhdDqOZw6yiHYNY75gDerfpgrPYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOmT2Stn8IbRyblz8oA5+OVPU7ivSyTogr+BeLEpxWqve39J0XWklKsIIbUwlvdvH6qHQnrdZSsV0TyPXx0pfHNERuR34tMnF8bCpZwxs8KkzYetruOR0dS8jCepmVwmN4jf1JAglAp33YWAuBFzLLl8JYQDggxcoxZFc/obGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdVMATvZ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f3a49ff7dso9456778e87.2;
        Wed, 22 May 2024 22:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716443425; x=1717048225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Rk+2rzBjeJPDMqabcGBOYt/yCems4idycSDBd2Ha6w=;
        b=SdVMATvZKPtiDKEUDVQ9HeFlymYKQ/gtkY1bEyB6iaTzKvz35eL8UDjWAvCeCm6yuE
         KQ/ZzjR5ywkzCvWWRgEInPyn481zw1EmQivr60zlzf6B4Zlqr4EQsOc2cs91wiVH9TSa
         h8lzlyxSeYWGCTsI+sLO7p1UPMRrMj70WZAWs4vFYtx4zjfW3KlmPgBsDTKJLo5UaZPw
         3atEc6ohm46c0PIzW4GmUyHI4ZtT9NgKOQJ5lnqgeXKOx9DO/rWK2NiDWH59+crtFsOT
         X+tBpSYmDkEB7PDB3qyQ2Jv5o+VjqXqGEaAjH1sIYvSsH6upkn+ocIRF6ciEt9QjD1mz
         sAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716443425; x=1717048225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Rk+2rzBjeJPDMqabcGBOYt/yCems4idycSDBd2Ha6w=;
        b=Myv+qpq3Ts/MKN0l2bWNcb9e56sjhsL5i8tbhXZGy7klde1nQDRNFVPnFY+vLOwoAN
         iMhwQ0/2b2XJZ6/Sdsdne3a9HANlkiEGdNpFqxXwch05tQdeL/5zpEQkjEYMcRDli3bC
         tU5i18kzdUgVU+EfPee7lADus3bc/zQ7LKL1fb8vj8LVoqRd5cXm8Se9kL43lpc0lJRo
         v3bV17ruRN/efcYvWMfCE2QUzy+YDu5uW+6by62w2ICzqeNxGg+3Z44tDLxelyr91DKz
         k9pr2ZiBjWrFWMOHCpre4AJg2p9VK7y3/ItrDxt5K7HEBKzO5MHIPksoQ7juz0qujtGJ
         KN9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkb7TbjrIItdvXjRKtLvs1e8M1IHjDArVzUhsxqsYZ0W0DxC0NBNfIeBeSRD0/nalzrBVgh47Eud6lPEyTw9RYa/WQ8yLF2dz79Pw1
X-Gm-Message-State: AOJu0YyRg9xZLptgTFoi4M2Ww7B0zqTHsT5+HNBEn6LeD52eEGSgJFrq
	0t6UmYpcH7KSrP3fUR0LrINjtTzj1Ay+RX8Uy1RGt2I4E8BX5vbb5mup9Q==
X-Google-Smtp-Source: AGHT+IHcBTQocFRmfGDmFhycDP49W1VqxUeX0BMLFRCUlmyn7MN3hLSkMNtLV6VCH/o6BEFohMlfQw==
X-Received: by 2002:ac2:58f2:0:b0:521:7885:150f with SMTP id 2adb3069b0e04-526bdd487f6mr1899403e87.28.1716443424684;
        Wed, 22 May 2024 22:50:24 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52867f38c56sm59605e87.3.2024.05.22.22.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 22:50:24 -0700 (PDT)
Message-ID: <eb24b250-6654-4f2a-ba03-3eca2cfa543b@gmail.com>
Date: Thu, 23 May 2024 08:50:22 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: light: rohm-bu27034: remove unused struct
 'bu27034_result'
To: linux@treblig.org, jic23@kernel.org, lars@metafoo.de,
 marius.cristea@microchip.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240522230457.478156-1-linux@treblig.org>
 <20240522230457.478156-4-linux@treblig.org>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240522230457.478156-4-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks David!

On 5/23/24 02:04, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'bu27034_result' is unused since the original
> commit e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

As I wrote earlier, this driver in it's current form is pretty much 
useless. The BU27034NUC was cancelled and, as far as I know, never 
produced "en masse". The replacement, BU27034ANUC, has undergone 
somewhat meaningful changes like removal of one of the data channels - 
so this driver is not producing correct results on that IC.

I have promised to rework this driver to support the new variant, and I 
have this new HW on my table - but I am currently negotiating to be able 
to provide an open-source Lux calculation formula in the driver... This 
is causing some slight delay.

So, I think applying this patch is still worth :)

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/light/rohm-bu27034.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
> index bf3de853a811..4937bf6fa046 100644
> --- a/drivers/iio/light/rohm-bu27034.c
> +++ b/drivers/iio/light/rohm-bu27034.c
> @@ -223,12 +223,6 @@ struct bu27034_data {
>   	} scan;
>   };
>   
> -struct bu27034_result {
> -	u16 ch0;
> -	u16 ch1;
> -	u16 ch2;
> -};
> -
>   static const struct regmap_range bu27034_volatile_ranges[] = {
>   	{
>   		.range_min = BU27034_REG_SYSTEM_CONTROL,

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


