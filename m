Return-Path: <linux-iio+bounces-26692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BB4C9FCA7
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 17:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B1C93004F33
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 16:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9441C34F49C;
	Wed,  3 Dec 2025 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pJvZ9vZM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C1034F488
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777915; cv=none; b=c/93V1YHxfMisTgkCLwKlAMI22Rxx0GqDDOZsbimgZ1MAdCdvbttmevBjW3Fgg+gNCjXj58xDc+ZRwn1mTQ5yZhWLTzgVaWaTTFudz+wxvON2STjVLX733iRg9bxWN29ZQINARuxHtKMB7PJih5/EuqLRynifA9as0wRUT3ip0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777915; c=relaxed/simple;
	bh=KieZqw7EdcdUozUXXjVH1logR7jXhd4pR+ZRY6ahxj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SG+VZ6jYSHLFzWirajDP6IEFDhONsMGCGXTyKbDOM5X7XF3jLFkGJ9Wb2lvV4UVbsS2qEFvlUL/FbQ7ppjZYUzfSKzHA+vAKPJniROhdVcGxWd1MsblzZJQZXVqGOeP4frF+dn6Ngtev1/lcq58N0c/efOsIyc6TRzbrML8QSHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pJvZ9vZM; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3e83c40e9dfso1797755fac.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 08:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764777912; x=1765382712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzzvW5Gc6Eat2+7zVTxZEh5y2R/qRR85T9JYUq/Ah+c=;
        b=pJvZ9vZMBUNfDvh961bu8jE4YBgENKTVsSxS0iSwkr+M2h4X2ESOppqzBDQXIBKBuQ
         xe9rFWWWnWkBo3fviysyDSRKXiOsgC31nhegCXXgnga3juZqX5ydTJkL5E9XPcXiB1yi
         efRe5z+y32Pd3nvkcRN+NdbZsBrU1CTbMLGiSY1ad0RTVek1m01nXIipzCW/5S3mRpvk
         eG7CrteihlberT4Ub09OQQ13epJQtitvjmkCtZXwPZAQc88ogJPCQQmeL5XDXzAThDXp
         uwgD1kLpkOODVT8krkRhheTg9+VPq6gLejFKq0SoKPuhKayAt17I5tJGl6bQE9B38tCm
         Y7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764777912; x=1765382712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzzvW5Gc6Eat2+7zVTxZEh5y2R/qRR85T9JYUq/Ah+c=;
        b=nN7Y8qZsAFJf7GrPrP0i9ADQl3eGJSfLU2JGx5uwVRzHAGSoc9m2CKIMaq0clftHor
         6B/v55dZSNZvKvChtb9wluNcNNqqD3xwA0wgJhok/Sxk6RHgCp/LNjvA42KnZXj4d6Ae
         DkB0FSsyf3cLYGuuiRXxQwuXeeo8PeNe7NZeu/dUCM8k2naJw5VKjIXqVWrhYLI8YrhU
         J8h/hH0J9CYb3EayHXnuUTZSeBZzoJgr6oHsLpj5hGwzIAbHC5TooMkrzfhIsCj37cCn
         Y7lzIXUT52o69hMNdQyBGNeBTIaWrGo+3nHE8m3Ct0q18es2RRVXvSWZEnhSlpwyFMg5
         lpcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNRT1q9vXakJiz17TQ3YtYgXimD0pP7RFwg4xciZD78YvAKpUfLqQGs3I4C2ZGA7ItiQo2YmHqEK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwRrlej05mslLaS9e+sVdYhTNaxqUR8JgQ3nrcpUp3xUWAX55T
	6boHstopVBRlEWJFvpwY60rWHS87mNmBCykYDpTRXjCjYJK/1s9+1NXFztqu4FgmCkU=
X-Gm-Gg: ASbGncttaxNmwJ1kQSvnklkjlur1A56A8N170xZJ0hiYPVUGZdo34HsuwWa+qBE0IWU
	tAlVdxTQeCiQk7N83e+qO1igZNsoOdegRm4k/8hv20xi4n8OiZiqZGnEs5OSt8l5vXJQHpeHFVm
	wXmIMd6WQsFDWDl2SBQFZtnBMknDNjmNrspKPHoY7PlGdX+VqHDCx1ffDjiZqMeVwGBKq/LjxEg
	tyhvCzUQce7ApPZPzYf/LMYa3DTvbAY+5tFJO+OXHU3KMxVQ/LgGasdMgCszGIO7kwEcbKte1XA
	qjHZ5Uj8VNOb/qmgRaplvhKw8QyO6DoRHp3yksiHi4mG8OunkfV0FAUV7hFwBCr5bUaNvwp8zNe
	BObqO2Q9AL15Q+GeEZe3Lej7psk70sii9OA+TmRmoubvKsAxs5I3MaGSDoGIrV2EC+uJtdcRX1I
	9R8fmRIlkZwFf/MLFVTTpTN4vwug8dT5B85buazYSzk+dYVdgChI2IUbFdzg==
X-Google-Smtp-Source: AGHT+IGyhRGkVZBUwh3AWH0hO5MK7KsOWGVsWlagdD8d+eII/8VC5/PEaXvINGHY5wrM/YBkGL7U8g==
X-Received: by 2002:a05:6870:d201:b0:3ec:3d37:87da with SMTP id 586e51a60fabf-3f1691362c6mr1676681fac.3.1764777911626;
        Wed, 03 Dec 2025 08:05:11 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:6b05:aad2:5053:6d1? ([2600:8803:e7e4:500:6b05:aad2:5053:6d1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dca40d4dsm10122928fac.9.2025.12.03.08.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 08:05:10 -0800 (PST)
Message-ID: <a17f410b-17b3-4abd-98c0-be6952894eaf@baylibre.com>
Date: Wed, 3 Dec 2025 10:05:09 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: dac: adi-axi-dac: Turn dev_info() into dev_dbg()
To: nuno.sa@analog.com, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
References: <20251203-iio-axi-dac-minor-changes-v1-0-b54650cbeb33@analog.com>
 <20251203-iio-axi-dac-minor-changes-v1-2-b54650cbeb33@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251203-iio-axi-dac-minor-changes-v1-2-b54650cbeb33@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/3/25 9:53 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> We should not abuse logging and logging a successful probe is clearly
> abuse. Turn it into dev_dbg().
> 
> If it turns out the IP version is that relevant we can make it easy to
> get through a new debugfs interface later on.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/iio/dac/adi-axi-dac.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index 0c7b62f5357d..f536158beb4c 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -1000,10 +1000,10 @@ static int axi_dac_probe(struct platform_device *pdev)
>  						"cannot create device.");
>  	}
>  
> -	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
> -		 ADI_AXI_PCORE_VER_MAJOR(ver),
> -		 ADI_AXI_PCORE_VER_MINOR(ver),
> -		 ADI_AXI_PCORE_VER_PATCH(ver));
> +	dev_dbg(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",

Didn't ADI HDL versioning policy change to semver so that the last number
is no longer necessarily an ASCII character?

We could probably change this to %d.%.d.%d while here.

> +		ADI_AXI_PCORE_VER_MAJOR(ver),
> +		ADI_AXI_PCORE_VER_MINOR(ver),
> +		ADI_AXI_PCORE_VER_PATCH(ver));
>  
>  	return 0;
>  }
> 


