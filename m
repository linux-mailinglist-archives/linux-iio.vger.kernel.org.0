Return-Path: <linux-iio+bounces-23792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C08B45F97
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 19:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1233F5C305A
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 17:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E235343D8D;
	Fri,  5 Sep 2025 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Gi8Ie0zb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD03F314B72
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092007; cv=none; b=VEobjoPFPTnEntVvR4Z83chLEcogoEnsyOb5ZCkmEZLhdPxZMfI3e8NYX4Qgdk2gQcWYw61Wvo1jutcouKDM6LSoBrTgYb8qq4yZzGtUiU1bCxPB/E18Mi/gzf0MdC39cLRcDiXSJtJWGNDzbqUWYxVvHgF4Ceax4QhXHu/aGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092007; c=relaxed/simple;
	bh=jN0s/h7c25JUNJUarwGqsw47/AYuJ42K931uUXRodvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ugj3BKKuBg4WOFMj25dsRK3WVyFOk+ZUquCIiCgExf79ymXwSBLE9kEoGFf+M7dQiLM4gPzPFCmRPHUqlTZCaa/5nf3yrP4vo/bNqK0QY8f2FlyU7NOE0gUKIoUlr8kvtLD8fIaiSlz3/xIFfWR/TtL1LZQOiv8jsmuIajpwsH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Gi8Ie0zb; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-438376b7f5eso73269b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 10:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757092005; x=1757696805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DVItyR2m2+5QjtGCrAbeXGO+ngiTgRfmo3zC9GGSyMY=;
        b=Gi8Ie0zbP8BPPd/qSAEaaNTfW/Z7wVTa0NxQ6jGwSwNlcDR2xwxBpxb8Dp8I6r8luL
         9kMG2jWsCriWDQAZp+OANr0MP5zNuGuwF/nljJSaOBhT29mko8B4owi/CLriWIJrmkIe
         mAuTX3KXQFITPgsCV0/ImYEzhFmXePg7FOFbicZhKVloaJ7wzfnGF139dhDd/Xn0oNnn
         nq7papv4pLpbpzBsaspoQUTubh6mA61w06fjoHDRBAWklprlXFkYo3cH313IQRNEoMGK
         yftZAv6bv7RVmObWtK7EJ52/EgZg07/i15LQsWT6Sy24wSOWtlmSZooo4G2JDYvPCJPI
         KxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092005; x=1757696805;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVItyR2m2+5QjtGCrAbeXGO+ngiTgRfmo3zC9GGSyMY=;
        b=n0BuXXNJnVEszEtBGG0+4C7h6iRfINLXPPJgbimg1cONNwPQXKgKenJb+z8yFuIDAm
         LRtWmbZ1JtSkTEnjbdxNGdJqBmC+IlRJQ1HifCh0GT8ep5cp8ORedc68kR4s4xajnjhK
         Kv27zHD97DcQucQYrOVyzK4kCVCM06ZtdujmpF3azkh1LNqUqlpToJWL4cx6SKnWNvRV
         cgCYtwgpuwpHyB+B0rf7vbc13h0apirgs97ibpyEPfRx4CPKzn0OFcdkIPymaJ3Zo3yS
         ym0ge49AuK0vcf1LpmFvXP6UJwAUdJ/FCDmkFqdsZ4J5XlVd5LHM6YyGHlPKD/Yb3kdG
         XRuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlDGJdJsZKR5OgdSteYget5ifCfB6fmcSX9fMrLGAJvyDlCxlgAqPudhcB+qc10wJmwyjsjiPXYFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqTL9x7B+5A/abArnyJjzFKs/o3eR7MLqw5GIV0z66H9Bev2WW
	R+WiiDOjyjx1y57nn/O8D5BaaDNQzYQ+WuHfSJnMt2Y8U3N3+8SDxmii6V+XaXi5d0g=
X-Gm-Gg: ASbGncsFelkg+xdcQs7L4MCp8qKyMdRcadIyTy4yxq0eb5F6baYLEIypHskmqUKOIvq
	jRXv+LLNOaXwYZcFKDc2B9mXfFBVzfNlBVJWkH1MivzPGoP7hqh81U/VSAvRkJEL+iHSU/XypZf
	slI9+eGxcOJlcFzVhHxL+u8w9NY10JcBqtWYsOFDAR0SA321l+NRE3h68fJX+KJoWVJ433n82o5
	xxlPchfzQYiWqCIpMR3RViKa2h40hIcG7WzR1em5eNDrgICw4yOv/V2gaGiRCpBSPmhvvx3fO0P
	J8Ght0wfJATCIn99Yao9RUejRp2Nidg/9rq0j9cCXpHTg4vQhtDss+7vLbKNI81Jb1xjItNnUi1
	2/6o51ICYWyKuUuZknKuO1s1J/8FKm2H9Vp4XsM27FUNKnaVehd5lE3a/3pJugzKU7wRvahSs
X-Google-Smtp-Source: AGHT+IGCip+t0CW1JF3kCxDlGyKFDm8SFolIuf1wSJVnpOilreSjhclhFmaFcTthQJmi9hElEWUmJg==
X-Received: by 2002:a05:6808:48d6:b0:437:d7b0:878d with SMTP id 5614622812f47-437f7ddeecbmr10847393b6e.50.1757092004820;
        Fri, 05 Sep 2025 10:06:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437ffed9f15sm3544740b6e.10.2025.09.05.10.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:06:44 -0700 (PDT)
Message-ID: <09cbea15-1b14-4a0e-b643-563253e2a918@baylibre.com>
Date: Fri, 5 Sep 2025 12:06:42 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] iio: adc: ad7768-1: introduce chip info for future
 multidevice support
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com, jonath4nns@gmail.com
References: <cover.1757001160.git.Jonathan.Santos@analog.com>
 <098a8b2556ea95fdce5f81cbac98983f91ca1a9d.1757001160.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <098a8b2556ea95fdce5f81cbac98983f91ca1a9d.1757001160.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 4:49 AM, Jonathan Santos wrote:
> Add Chip info struct in SPI device to store channel information for
> each supported part.
> 

...

> @@ -1371,9 +1387,14 @@ static int ad7768_probe(struct spi_device *spi)
>  
>  	st->mclk_freq = clk_get_rate(st->mclk);
>  
> -	indio_dev->channels = ad7768_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(ad7768_channels);
> -	indio_dev->name = spi_get_device_id(spi)->name;
> +	st->chip = spi_get_device_match_data(spi);

Generally, we want this early in probe so that chip info is available as early
as possible. Might not need it now, but would save us from having to move this
later if we ever do.

> +	if (!st->chip)
> +		return dev_err_probe(&spi->dev, -ENODEV,
> +				     "Could not find chip info data\n");
> +

