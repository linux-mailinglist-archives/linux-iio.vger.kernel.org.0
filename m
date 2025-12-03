Return-Path: <linux-iio+bounces-26693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDC2C9FD97
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 17:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 250DF304F65C
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 16:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3712234F492;
	Wed,  3 Dec 2025 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="refI+7c8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE722F0699
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777999; cv=none; b=MdUJPeQeiytbxzkdtepRoHuzL6D103CaiTtufC7zQAwijhVOBFueqkj0DERJv0jMrLkA3UnZBn99rFsA39TghefKOqHjpBpyTwZUIsUlRIazH4waADR6ERuD5AeyqP1pkbV2cDQkoGfgAaJd22gcjBRH0Zyp4K5v+Lua0Fh/TUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777999; c=relaxed/simple;
	bh=HC0V+cL9Xq/jRXEnrRC7XXfzGS7syO4dU2ji9FJ15UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OByEJMYka9MQY69T9uKcXU6A+L3PFrJ4/PAey6yC+yE0Fm9TMB6cnjEljuFt3GDOj5PjYnkJFXvzTKPWl/kTyYAllAtf4cHzVP+vpFe8bvHWmh4rJSQjl5Xy4n6dCOIbrE9GRyQwVSxFwXTTIStjZh6kJgVEUcuLDSbRTlMAGqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=refI+7c8; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-45330fe6e1bso2813283b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 08:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764777996; x=1765382796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pG6n+m/7QkQ9BUTPnCeeyPho3Nl41XqYiInpb0M+j3Q=;
        b=refI+7c8sKImUzHPyCZ+bCOvjBRjgK7fWUS0nvlx+jaukfTW01ZkDtWr3/yfnythrF
         DOqdY4CPKLjLm7VJYqSgaiPGt6PaZohQRDa6mPdBqCfvkBgdgzaGYlsBZN4LbTVzh0i5
         G49o56tPwFLTt/GfqvCjYrnLaTY+VhOjd0FjVERmhKyCi3tKAmltj0Ek86deicJEBe0s
         hTrBsIOJ9gXLL4BiKx3HZXJQfUZVtsj5USeI9Qa06VTDTNJRLp6+uM7E9g6BpFJx2s3V
         Cq0DlJVmG8YA6hgjFPK+9xp3pdYQql16ler+AdrMPgAfmk6FEUDFktQWpQhdwODqNTJA
         p+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764777996; x=1765382796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pG6n+m/7QkQ9BUTPnCeeyPho3Nl41XqYiInpb0M+j3Q=;
        b=cyydTeDWa32aBupzmwmoUm+X40B3dqLuFHVXPQtrcI/o2utzgh4ia8qc8cEyVhVkiM
         HXa0pkrvcvISl4wtG7O8cK2scU9dx28j1ZEsG0tfJjJmqxZxna4tjjE3Fbh8Zqufsc81
         uGA6obxqe2SWaaAepNrSkM59e11EENKP69BRzpsdc1aEo8Ef0BOmdXmh1UagWyb5+dPj
         obASg3WhB+5Roe7GfVsAsezeB/o8i71mGj0GLWCrfF0amQAlhMfRkioyZOy+LtBUkV6r
         9/k18OrOSGH5xY/LiePgRboqiEJ7XPurWuyjF2At3k484WngYtpJXFOC0lLF3VdTFBUr
         gt+A==
X-Forwarded-Encrypted: i=1; AJvYcCWIq5gGYqPLT8ZH1fos3jRmjDx9nXIvYla6iRhwwxnqpAMVTyvx2P/cvI2tafMmrFLE7Rd9YBeIo2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz2+pgegRHRyLEnIkY2OFdlV26ikcNzYflnnMBmSRfIADVyAf4
	OT6maGfdZ9RxwWz4kNtTt3RJ6y2Q5dhdLvh/s2gjRj5NOLrgHKNQU/Gd6fOZs/rDI08=
X-Gm-Gg: ASbGncuKw7e5+VAqx6RAf6r6LM1iOXuFu3bjGZtN2TaDitKo1o8KtJNfM6shlbrAMKA
	u7IpPIH/1CcJ23tid0HeKXCe4t8Zyx9SPrcvE/Ed0M2l+5jxKUGGNn253VHEwRVp7ZVDJZSrL3h
	g/WKGW4MFihzOnnSnRAwB/LKGItetoHlOmpYajJKfHFpJxPJXb4MDavcoiKzRHEkND+Cas4rz3R
	AawS2SzL+6KWhz6+ThKN1LtX/Up8V3EimjVB1id34g2oCBIEays8qxCY7axDw99WBVQjyDaFdaA
	R/46MbQPHmP5gmldjHFRd2v1CsrHaJueh/CV2/sSxzpmMbUy79DAtbexjOPYSWQywMvtRvUALqL
	bNeQw6vz9qNbmst8G1sr2THxvAEp9BzudVX7rUOYUblTNSxxkEQ3Xe6JenpgX1XapegqWd6vc6y
	YXDJ4yJHCNY9RG8h9VYL5G839JjxpQBM2mKdaFJAYfFNQeSvpdgIwFgI1BVQ==
X-Google-Smtp-Source: AGHT+IGS+zbMreg2z7pKM1sf6oRGE5uZXXukxJ/dLQj9rKcaHGq68GL8FvHDKaBnCzpUlnZ+ts0y+Q==
X-Received: by 2002:a05:6808:6716:b0:450:abd0:d815 with SMTP id 5614622812f47-4536e43d52bmr1331148b6e.28.1764777996203;
        Wed, 03 Dec 2025 08:06:36 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:6b05:aad2:5053:6d1? ([2600:8803:e7e4:500:6b05:aad2:5053:6d1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dcfdb503sm10347653fac.14.2025.12.03.08.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 08:06:35 -0800 (PST)
Message-ID: <07439e95-47f5-434a-9f6d-d7740375a3d6@baylibre.com>
Date: Wed, 3 Dec 2025 10:06:33 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: dac: adi-axi-dac: Make use of dev_err_probe()
To: nuno.sa@analog.com, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
References: <20251203-iio-axi-dac-minor-changes-v1-0-b54650cbeb33@analog.com>
 <20251203-iio-axi-dac-minor-changes-v1-1-b54650cbeb33@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251203-iio-axi-dac-minor-changes-v1-1-b54650cbeb33@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/3/25 9:53 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> Be consistent and use dev_err_probe() as in all other places in the
> .probe() path.
> 
> While at it, remove the line break in the version condition. Yes, it
> goes over the 80 column limit but I do think the line break hurts
> readability in this case.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/iio/dac/adi-axi-dac.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index 0d525272a8a8..0c7b62f5357d 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -942,17 +942,15 @@ static int axi_dac_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	if (ADI_AXI_PCORE_VER_MAJOR(ver) !=
> -		ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {
> -		dev_err(&pdev->dev,
> -			"Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
> -			ADI_AXI_PCORE_VER_MAJOR(st->info->version),
> -			ADI_AXI_PCORE_VER_MINOR(st->info->version),
> -			ADI_AXI_PCORE_VER_PATCH(st->info->version),
> -			ADI_AXI_PCORE_VER_MAJOR(ver),
> -			ADI_AXI_PCORE_VER_MINOR(ver),
> -			ADI_AXI_PCORE_VER_PATCH(ver));
> -		return -ENODEV;
> +	if (ADI_AXI_PCORE_VER_MAJOR(ver) != ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {

Can drop the braces now.

> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
> +				     ADI_AXI_PCORE_VER_MAJOR(st->info->version),
> +				     ADI_AXI_PCORE_VER_MINOR(st->info->version),
> +				     ADI_AXI_PCORE_VER_PATCH(st->info->version),
> +				     ADI_AXI_PCORE_VER_MAJOR(ver),
> +				     ADI_AXI_PCORE_VER_MINOR(ver),
> +				     ADI_AXI_PCORE_VER_PATCH(ver));
>  	}
>  
>  	/* Let's get the core read only configuration */
> 


