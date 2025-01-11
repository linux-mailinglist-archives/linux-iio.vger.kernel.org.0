Return-Path: <linux-iio+bounces-14147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C72D0A0A69C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 00:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C7807A388A
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 23:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC7A1BCA0A;
	Sat, 11 Jan 2025 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvgOxR6I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B07F1CFBC;
	Sat, 11 Jan 2025 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736636868; cv=none; b=Pazv1tmS0eRC5UURE1hi/4zpozxrW5iooOcy+fBRO2YTINVuzvdIjVTopSF16dhNm7sZpq1dSJicmekTFuMm9g4Oa8OYOGU0aC0GFBwuavR+UFswxH8TmZdUGQHTjp1xvTcYupe7O1/UwSIXr+DggQa20nwwtAMU/dehbooKVb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736636868; c=relaxed/simple;
	bh=D0QYQVBVzeopreDi6WRah1oRNNXsfK1Kau47j3RSABw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jaomkBPXNPFmw0ObALE8tfNGqEil3K15U4+4sII507SbDz8Id8SwRH8stmsMDCgtKfVFiPfHUT9Dq3gnWjHp2p2gsnL35TnVsVM+ht1uHDQxjeBkIX/tgs1etL7ehwKRqUVxFgumN6TltRgrLoeAVY543DUZk1AHzG6Khwo4vro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvgOxR6I; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso611779966b.2;
        Sat, 11 Jan 2025 15:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736636865; x=1737241665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+o+/TxnUei/i2FW4BNiTNlesJOgQPjQm1JKYkDHRiyY=;
        b=cvgOxR6ICk9Zc1gSjNajg6FsFdXwuNjuwIa9wXJzfAGFVYfazckmPR3SsS+XJ1MhcN
         wkvMaKqQusWgnkOk12I507ntl4bL5p/ICjf62AXqwgB36dqqr4V1xRYxefrhpTxXuEF2
         UW+9I82Nbe0jujWMSocs+no7FFSO1e1iRGsfpPliJQZG5ckopjLFMIHfSdHpnPkVQOI9
         yVLZgPQ4uQmtwDwFmDHr5rxGFrhr3lUG0K9w4uJ/H0jEqzOOLE2QhUOcvdNVFSzwlboa
         2/oz0imwIpIjgwo8MB+wSa9vk7zYiuWcAQvkJ9B1TmIBbhmJpLV2RTkSUvVoJLKmC7t4
         Qfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736636865; x=1737241665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+o+/TxnUei/i2FW4BNiTNlesJOgQPjQm1JKYkDHRiyY=;
        b=gJgCMhuKE1/tiQ25c90Qs4i0wQvVFbcu76YcdnRnXjJZleUqoSk9lcpcWSou+9OHVH
         MPJhPqGduX/PV+EjCRczioQ+Tzi68Xy2nGjrHHkTg4RJj6Mlh7szEZ69GxUQdPtpwHr0
         fFMkncsEpoYdgRzOZFbyo2obs+0MqWXyHB2YfvGDyhUvcMkU2OjWTE2opF+FJoqeddqh
         wNlu2aH2zf+d4KPVNBPw2KGyYoDeNFARwC3j2QfBv5TeWwM+N8pmIpQnPSVIU1h6q7ti
         7sl3x+eNYo4EjgJkgp5AaGfs6MVhXUcJMJ76+/Pb57xLVJJXc/xsw+2J+MCss8FUtn1x
         pc6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsiumLnjtvxI2e2abCaU676ZP1ERfcYN/oj1lK+0/Cmd8MmolR+LlHI79sC63JZ4ELpZjBJ1RyG2kZ@vger.kernel.org, AJvYcCWtEIfw8f9kSqA8PQc83aSVt9FwBEa3iyOwRtQmefEAuLgmB0GFQ8+y+2AaHE1bElKuCq3RynjzjOvj/vJn@vger.kernel.org
X-Gm-Message-State: AOJu0YygvhguCIEyMbd4QYHV/5M5UX4KrjVFo7gi05oIZBWEjHUfdk6v
	4iHrlEewyzSsOu+kVyzmB5B778pgVv7Ci5KqqBYkbvemULoMuXwK
X-Gm-Gg: ASbGncuT6yTmwZUbcEDnv0GWhozIWWwI06kyJd/+ZcseJbKzJoaVEwsPBtgPIZlEX3f
	Hz2btcJlUYMXyaEHYkaaxL7M+g+bq5c6VrYeNaxGYyXAvSo34caxsxKJLfzd4OxREBY20loSU1T
	C0qzUdHAqv0cln9TBU4MGCT7G+SQybpEV8jm3UNLNLzolzezd2mHa4MbZ7gxhT6TCBEZL+Q4J3J
	v+3k9ezjaAD2qEaQe5zQr5Dz01Xk3qxilpVrEi4Fqw8998qV/1ZsK1TVDOKU9Psd1RU
X-Google-Smtp-Source: AGHT+IGtcNP5ojAkgowPuauyoP8eiaJtGWScoJuG/s9NqhI06uvp8SbpVN6sIt55LI+78TsrnVsHEw==
X-Received: by 2002:a17:907:3f1f:b0:aa6:9198:75a6 with SMTP id a640c23a62f3a-ab2ab703fd8mr1313301566b.21.1736636865544;
        Sat, 11 Jan 2025 15:07:45 -0800 (PST)
Received: from [192.168.31.111] ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9060bccsm311762366b.22.2025.01.11.15.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 15:07:45 -0800 (PST)
Message-ID: <108b1eeb-7e95-491e-83fc-bbd061697222@gmail.com>
Date: Sun, 12 Jan 2025 01:07:44 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] iio: accel: mc3230: add OF match table
To: nekodevelopper@gmail.com, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
 <20250111-mainlining-mc3510c-v1-2-57be503addf8@gmail.com>
Content-Language: en-US
From: Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <20250111-mainlining-mc3510c-v1-2-57be503addf8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/11/25 10:11 PM, Vasiliy Doylov via B4 Relay wrote:
> From: Vasiliy Doylov <nekodevelopper@gmail.com>
>
> This will make the driver probe-able via device-tree.
> While the I2C match table may be sufficient, this should extend the cover
> of this driver being probed by other methods.
>
> Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
> ---
>   drivers/iio/accel/mc3230.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
> index 48787c0494ae6f0ef1d4d22bc5a4608035cbe123..3cad6f2d7a2a79df38f90e5656763f6ed019a920 100644
> --- a/drivers/iio/accel/mc3230.c
> +++ b/drivers/iio/accel/mc3230.c
> @@ -205,10 +205,17 @@ static const struct i2c_device_id mc3230_i2c_id[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
>   
> +static const struct of_device_id mc3230_of_match[] = {
> +	{ .compatible = "mcube,mc3230" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mc3230_of_match);
> +
>   static struct i2c_driver mc3230_driver = {
>   	.driver = {
>   		.name = "mc3230",
>   		.pm = pm_sleep_ptr(&mc3230_pm_ops),
> +		.of_match_table = mc3230_of_match,
Should also be alphabetic over here.
>   	},
>   	.probe		= mc3230_probe,
>   	.remove		= mc3230_remove,

