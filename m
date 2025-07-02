Return-Path: <linux-iio+bounces-21240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 663EDAF5AE8
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 16:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC544A0239
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 14:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EEE2EFDBE;
	Wed,  2 Jul 2025 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QIJsd0F/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101CC2EFD84
	for <linux-iio@vger.kernel.org>; Wed,  2 Jul 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465818; cv=none; b=Mlr3jN+JPXW2KGkKX1B8sojTuS/5hT9DfML6YTW41fS6nPjHjqu0tx5jbFsqc9KvXmfeyD57yQKAZl7gw5WeCbManCy7Jf9bo6UoLK2Dieio74WeFBx0quPH4i7D4QnqXMmM9rwLx7Ge7c4mK1gzzrsmk0PEnmk/AfmWuoYjPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465818; c=relaxed/simple;
	bh=ivkSgMTtV81CdANQ5XafOK5UJU4ttt5I90ZuP9XelP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRvHRZlsIGgkHKjx6rT8jNjn1pPWvevIAsUwAEub7vbtrbAKmVB8jVtpLLqIM8gm48bBVgQ5sV+Uj0vu/HtzPz5ywoX9/OTbi7j8uHhMSuJ7YuG77h1SaycoU5x6fdnA7j2Kj+b7VnJTb09PvlTunHoIbDpUuVkOrjB5G2sIhOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QIJsd0F/; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2ef60dbaefbso3114283fac.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Jul 2025 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751465815; x=1752070615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCNt8orVvRnPdLUcXvMNqNxbNUJlKlGrsoDHbOPwgJM=;
        b=QIJsd0F/MbFF49Boy+x1Af49w/0wyrnkTsPYjdyr9VuNaiOCkgY23qxpljBn7nqmAp
         liOIHpmk/RCAdlYe0wweHopiZBw0ShCotJCrr7CijEH0teqdvRPrhFYQIy3rHqk4nIrI
         uZLHdY/RkOgJhvj7b7tmQSjHGRRqlTm7v12KSGANWWKbKJcHI0g9jaIZI7Yuvw5anyDI
         uVwK6o6T7mH5TrL1r9rjtD1NkFPixUBzdloXmnqW5qA9dmX5vQ/D13kBYVx44mZGGbc2
         hLg66JW1Mn+TSLgVmmd8fJYNcp6+AfBn0nFPibF7DWjenQKPDp8nVdxCQ9KcirRN4/ja
         3Bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751465815; x=1752070615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCNt8orVvRnPdLUcXvMNqNxbNUJlKlGrsoDHbOPwgJM=;
        b=KtTc/bvgXdTyLIXFF37HYlr0/pXekVQwGqf30yzw6Tn7G6pqtSv6Vl0fJRSndheocU
         RZ9Qdty8z98pEyTAB8bPkYLnS92kFRg6Az5Apw5nnmQteFuUj2jz+A6CpaeLzaOzqcGL
         JGMxqe48l6zOOAgnv9Obo3PXs5fmAYCcVHjzOza3VfoPTr6YfKBIAb5m+VFlx97oVc78
         70uBF7j1uA7V/bQcf2VrudunDafjsG9Yc13XaQBNCbUQwWn7kjvQRTr16sMv4Sj0K/da
         jVqYrrvk72ovnyyFeGv6H7zvqcLzbnNCYysoYUiKTwNWwp1PkoMmGFtQHZmtI1ctLoI4
         oLSg==
X-Forwarded-Encrypted: i=1; AJvYcCUJUqNsttc1wz8BjyYS8NUQVZSIcBGft9Nqyu3YIW3BeDtixxlZSE1pefORUqlZj9/jl7U1TW0JPOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcJbeTOpxHicHDztx27MiCLfId+/zzEjaeewaD7Bb/jhkgKPpz
	plplRaAQb+5/CfhMjs65obYTZXfS+AbMFIoQsIXid8OhyWjSpU5X6tMbjxPFGlw+QHc=
X-Gm-Gg: ASbGncuKwxOSYxBrOau8ulAIPD/iMs9T4XFxUB6IkpecUzxjaU64tywwBtLrIgxibQK
	yYRTkPFBdk0Hq+nKG7Qea9nqE5fs2RkcBjUyeJKtowXaEPDl9cXnk+47dlEn24exD2MBagTfpv3
	zQu3hiF7mqV4xHXx3fbDGBxUg0SsgSj8IlKvg3LcycXCOsBx6fx+uYLxWxFQw4VnfVgDWZftZny
	r1NKP+dr8lyB9Olc54Iq0ZwAE9DEzNGYsN8mS2AkQw22jHB6yHQ0BpQN8VuSLQ1HGnbaFCTifK+
	XIDtnQ+oh6qxnBI6tXiytn61U07MUBhrzv51fBh8OE8anPhCLp2nxfAtw0rHtgIfuEwK5xC/K1V
	uG2hCrCgnk5qDbvyN2EPBiExL/vhXOSdBYEeQm30=
X-Google-Smtp-Source: AGHT+IE3wezFD6gq5YO9AtpQHZYWN89aAqaWHJI6eS+Rikhf0NRsNSoAVq5E1EldNNLhjkG+5ZMahA==
X-Received: by 2002:a05:6870:288:b0:296:b568:7901 with SMTP id 586e51a60fabf-2f5a8c19495mr1923947fac.16.1751465814997;
        Wed, 02 Jul 2025 07:16:54 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5? ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd50f9748sm3929916fac.37.2025.07.02.07.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 07:16:53 -0700 (PDT)
Message-ID: <f96b68a5-d750-45f0-8cdd-9761b5daca1d@baylibre.com>
Date: Wed, 2 Jul 2025 09:16:51 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
To: Akshay Bansod <akbansd@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250702135855.59955-1-akbansd@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250702135855.59955-1-akbansd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 8:58 AM, Akshay Bansod wrote:
> Update the sysfs interface for sampling frequency and scale attributes.
> Replace `scnprintf()` with `sysfs_emit_at()` which is PAGE_SIZE-aware
> and recommended for use in sysfs.
> 
> Signed-off-by: Akshay Bansod <akbansd@gmail.com>
> ---
> 
> Testing:
> - Built the driver (`st_lsm6dsx_i2c`) as a module.
> - Tested using `i2c-stub` to mock the device.
> - Verified that reading sysfs attributes like `sampling_frequency_available`
>   works correctly and shows no change in functionality.

Nice to see it was actually tested. :-)

> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index c65ad4982..1cef10919 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2035,7 +2035,7 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev,
>  
>  	odr_table = &sensor->hw->settings->odr_table[sensor->id];
>  	for (i = 0; i < odr_table->odr_len; i++)
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
> +		len += sysfs_emit_at(buf, len, "%d.%03d ",
>  				 odr_table->odr_avl[i].milli_hz / 1000,
>  				 odr_table->odr_avl[i].milli_hz % 1000);

Let's keep checkpatch happy and change the indent of the wrapped lines to
line up with ( since the ( moved.

>  	buf[len - 1] = '\n';
> @@ -2054,7 +2054,7 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *dev,
>  
>  	fs_table = &hw->settings->fs_table[sensor->id];
>  	for (i = 0; i < fs_table->fs_len; i++)
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
> +		len += sysfs_emit_at(buf, len, "0.%09u ",
>  				 fs_table->fs_avl[i].gain);

ditto

>  	buf[len - 1] = '\n';
>  


