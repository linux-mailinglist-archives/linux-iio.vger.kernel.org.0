Return-Path: <linux-iio+bounces-18271-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7BFA93A80
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFCB11784C0
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B13218AA5;
	Fri, 18 Apr 2025 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E6hcIrrX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2163618641
	for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992943; cv=none; b=gjsrbnRrPvC1t0wlVYPf/XFr1t7Tyy/8b/Khl3d2ZgOXToFnS/qKcsflfKdkWt3nT0ja3xs0PscZrN9ljbz1pfiyWVh3VUkGy9WLxLhM7xZ1SHefVKTeY5oGL94l0VaTpnRvv685Gh2kU2U+g01p/dORUr8S912SDvEIlZ5GAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992943; c=relaxed/simple;
	bh=K+/CRwoooD32z1HfZkIvN1+3Y4G9naq0LdYY4gBYDyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHvbSCtMJYtOrvNgQ83KSU9LSMEXXdcf7Q2Yp++pcA8Q1fEdsKw/IqzKgtWaDxK79XegCxgFl40fmqsxv+o8Sj0cNg9Om+87+AUEU/u1SQY6Jefh9407L0ECkmBTjQwC7nPRYZ/TBPQnNsKWYHNW0tKHj4BFu7LZ9XKozAx7UOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E6hcIrrX; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-604ad6c4d3dso554906eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 09:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744992940; x=1745597740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WGewu/6Uc/A3LPxDq+bmb4Xyd0I+dI4OpVDZkGsXcDg=;
        b=E6hcIrrXOWS6p9ogKJCNVjvVM/f/dW8U08Yjpo+AE3OXQJMHWgS1kikDM6/UyIfxO4
         xKMWijZ5spxGGtmDvQ6D48AYKdNsnmLEMH22MujiauGSGfW1Au9A9BWYg7AcUedY/El9
         OQpqfkJMIl9wjCSsEkp+2nL28I7jsw+Mt+JiXF7LOfXKNiFCdzBNYOwkAvLAfnJR4h0z
         inwdmtrXW/gArd+KH+CFw1+q1oLJV3ZHkRQUAK6/XiqWFZEq2Vex8+pVm0EMfVevKnPw
         s8kD3Yw17o9fUcpGL0MODFZ3yAjk8wbvi4H5K8SSG1SQkjXM/FmCxy33bI2Ca2jv8wgi
         X8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744992940; x=1745597740;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGewu/6Uc/A3LPxDq+bmb4Xyd0I+dI4OpVDZkGsXcDg=;
        b=GgAU0jckN4gTlS9Ftnw+Bz1sKM5onyLWi3sGbw5TV1oDsfT782jXvXXjKMZvRNikcv
         YhJc9hg6rmQqx6iuDIoB/lphUAFoxctVVZ0anfjOiTUHtSq75QYzN6z8uprjPXCLENZx
         K4Pl6zX5VPnWblueuAfPyb95ybTRZ+2XCVde4TFAPj5ee7QSgoHvl+DKr6uKfjd9OCwz
         Ia2aG9TLfFHkHww7z39LSzb5sGrm4bonOn2vFWrM5rPnvZ3AYQroClAdrTwdZXxdA/su
         6yiENd+S1K+S5wozkhzUsf2CN+jLxyLPHJj+1+I+U/X8V99SXruN7byPkf8R4347n27l
         2erQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe+W4GlsDdIqG/cNb8bT+Deqnzc6cabygxslrwLAuiGIyiUBk53cHMz94mdp8t8scJD5haf4VFb5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgV5FctatgZxUR7VsnHfG66ppJraLuKjQXHGjic8JObUz25xDm
	xGCDnAUt90oU/jEyIT8axoF9NUa9WlymDIDvBANLyzsMl+rbNU0lLvl7MVwSpos=
X-Gm-Gg: ASbGncszp28pCfkLELTN9LZsAivzpYYVPY3tYVgUksGarw9pcKCUTZHCiebP6sQdGch
	C1OHCmBZACrbupT351uTSEQgyg4NABeDB8+y2DoOx5xFkxveGnhzRu9mAGmsshNuutkVXk1Tlcs
	nP9d5WAhTWb5WpDd5yE3M1pr11JJTahkG4Xln8nJ3SEdOcRxmKtemROuGfFHapl2LyIA/CcNPZw
	Y51jgp040is+3Y6Ogt2RIWUqjaITgMkEb4JBjh9wM70MUIQ++rNhcSOR4NlTWa9cD0eEJLe9+1V
	WQwQTdlW98Mw/zzm5QBEXIJAMth7fFL9xalQIbeYm0wxDDM52Zac1iFhzvVogxYPMvhbtJdaav0
	vx4G0qUM1dH5SHhygyA==
X-Google-Smtp-Source: AGHT+IGE1zwH/9pCVtJ65BBx41n2gg+r20RAvwIpV+gKuVenwX9jlxR/s4HYv+sV9yWK1DRiHVSJcg==
X-Received: by 2002:a05:6871:5582:b0:2d5:336f:2d53 with SMTP id 586e51a60fabf-2d5336f74f3mr1143727fac.31.1744992939736;
        Fri, 18 Apr 2025 09:15:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279? ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300478e34asm390673a34.4.2025.04.18.09.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 09:15:39 -0700 (PDT)
Message-ID: <ebfd728a-7994-4fd4-9e58-1336fb5f9237@baylibre.com>
Date: Fri, 18 Apr 2025 11:15:37 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7606: fix serial register access
To: Jonathan Cameron <jic23@kernel.org>,
 Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250417-wip-bl-ad7606-fix-reg-access-v1-1-0ce341f3cfc3@baylibre.com>
 <20250418165649.64ebef8b@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250418165649.64ebef8b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/25 10:56 AM, Jonathan Cameron wrote:
> On Thu, 17 Apr 2025 23:42:51 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
> 
>> From: Angelo Dureghello <adureghello@baylibre.com>
>>
>> Fix register read/write routine as per datasheet.
>>
>> When reading multiple consecutive registers, only the first one is read
>> properly. This is due to missing chip select between first and second
>> 16bit transfer.
> In what sense of missing? Given code you mean missing being unselected
> briefly between transfers I think.
> 
> chip select itself is always set in current code and hence the 'missing'
> description had me confused!

Agree it would be better to describe this as missing the momentary chip select
deassert between the transfers.

Reviewed-by: David Lechner <dlechner@baylibre.com>


