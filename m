Return-Path: <linux-iio+bounces-26641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA3EC9C35A
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 17:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 56825342214
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 16:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B106D28640F;
	Tue,  2 Dec 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EHGXQQfs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37F270557
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764692973; cv=none; b=qrxy7O19LkUIEfYowBnl0PqYmwgtDdKQ/4CKWzG/t2O5eVhN9u4WDPz/K9k3icekSDgrekDD+UCDqKR6bOOLDuKDg3oscetMSw3Z7qUfZmPpg0EYNwDKW8UpyJ4bhGrXyKlAklLAm+O+FiIiZmTzpTVZIkf3qb5BQ338jXNP9MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764692973; c=relaxed/simple;
	bh=7Ob/SW0CCBrP6rVCm5L7RBvmi5T1Z6RTpPIUlZyLOfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bd8AyjRwcYBDhS2JU0OdsZ9/c6preoxymR/7Byrs+kuOhC7bHMWUAxHapRruIQXZodyDVg90TRQU6WqdixbZKoygb9GPTAbJ/dSCLFLYgB/HkuIQZDRdPNvKfhpSfOFTLbwBOviZ7xbtDN6x1m4fB6qb3cVdOxapkCfwOpSPztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EHGXQQfs; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c6cc366884so1711390a34.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Dec 2025 08:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764692970; x=1765297770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iCwyHQPtWtaQ1W7hHrnxyQUAOefNwO9H71b7bAnV3zo=;
        b=EHGXQQfsLcnEsubGU79KxYt2DpZSjsZ6MhuRg6DQv9DboqvKTWggDWwZqOIH+biBMi
         +IMdn7GjWEOBNMhrj/1mg8YWuLMgWJCnXc5uyojfuOtsUQGbLiuJvv7l85COIg9rSjNf
         8eo1ZlYLf8kj08r3FtogX9TbpQSNgxqqzdj+7oNY/iJM7QpGmq4BDhTimsNi0ceq+bKn
         fzncK38piy5auEJnKthqFbUXkBTfvmvSP4iEM8WiMRaL1oEOyTU/pxlicVcUwgYKx/r/
         7EeyHjrOPed7mB6pmH9ckdfggtW0bFok7ui4M/QKPdb9+g9nVIx72epTZJx4J3M10Oov
         2n2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764692970; x=1765297770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCwyHQPtWtaQ1W7hHrnxyQUAOefNwO9H71b7bAnV3zo=;
        b=JFrebGaLUAVQfXCHKXPUpIsyvnQ1kuosvhRAU6O0Sk/Hxu0QyMnngjcqjVx7Pa1RJf
         775SF4ZkPPBzVnQP9TmiZc49ez1ljHDk+xR6PTmcnA5i+9LflBYc8ZrhbdLlf0jjDgi8
         cncUSdR0GAZ1T+/J08xU/6vUr3wbK2/JetxduNzdi4OsOPIjiqqygT1wHtMLIr9mW9ci
         ZDPfMZZ5fj1wqROazCLruTsbhKh9VcgVEajR8AV9sRyvT+dAnUAoggA8Mf+zsKNVHhFq
         v8IO2SvEv90+UCNZ/WzRfUGMZ9kqAk7FLPDpZ2g0SiKl6ay7hzU6ht7xMr4470kBDoGo
         4axg==
X-Forwarded-Encrypted: i=1; AJvYcCVg5Psa13n8hLHJ/16gNg49POp9UaX2czujyyRKXF0NfWgpQ0NiVpupcZ2CGGtkR54Qy3ijRbjTsds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQuIr+FMDFe9oDXzfjNpMRYjyuT+QHxIIffw9ROMIn8b+sqHc
	ZtRGKalsriPpLIwRrzkh2FO04fP/w2uMwjH7NuyIeBPfYN8NngpEgB9SAtk+NDyBiDs=
X-Gm-Gg: ASbGnctPh1Xw0gdV5VLlujpvcj7XkaMd8alDl6jGaQ7E++LAuYWnOfHX1i+3Iw8ihWf
	lzEr1NgzzOSR3Om6Zqknm8mfCbjJAo5L4OXshqVj4REievtmR9DJlpGr6Iz6uw16RsM6U+I0PQn
	YMWam9UDO2+M1u08trg7UrE2N2sw54MQKbh4Wh+rQGQtiC6ck0tiTKSPNHwT+nuXpJTBAnvDhlO
	NfJGXzTOND5yjrNi2jE9bOTzbJQgdm5YHW27wOC8V47le5H7TIPff98dFyMbuvp4d51dYPtXdHF
	eYz28E0pDn5rp5zFpQj1wkjMyDLWwIHzgW7D7U3z8VjrXNneFvMX5qD2he9Oz7X+si73/BW4Y54
	aNWKUtvF2UHCuO60f5RItYfxR5Vwh0UdCK8kLS4CyO6nfMNFDD2PJZbBAD56KlVVaQYIyyRLydj
	z5ALBRg/RRo8wmgrxPjKXu8O31ZADKFrOpIE93zeALAedrHbAkNX7suAqTrtfo
X-Google-Smtp-Source: AGHT+IFbzrMau3TkW8XR5v7695pyjhfacK0gWPg9OK/lv1/9IXxrc0EQfiWkOLsYP0yQV3QfIjle4w==
X-Received: by 2002:a05:6830:6303:b0:7c7:827f:872e with SMTP id 46e09a7af769-7c94aebdec1mr43867a34.38.1764692970157;
        Tue, 02 Dec 2025 08:29:30 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8f05:e265:a988:1b22? ([2600:8803:e7e4:500:8f05:e265:a988:1b22])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90fe0b238sm6888271a34.20.2025.12.02.08.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 08:29:29 -0800 (PST)
Message-ID: <02285ef6-0928-46a9-8f93-b63fce30535d@baylibre.com>
Date: Tue, 2 Dec 2025 10:29:28 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] iio: adc: ad9467: fixes for ad9434
To: Tomas Melin <tomas.melin@vaisala.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 6:53 AM, Tomas Melin wrote:
> Add support for setting offset range (calibration) for the ad9434
> and fixup vref mask handling.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
> Changes in v2:
> Updates according to received feedback:
> - embed ad9434 channel description instead of resorting to macro
> - change INFO_OFFSET to INFO_CALIBBIAS
> - keep offset value untouched in case of error
> - drop length from avail_range
> - Link to v1: https://lore.kernel.org/r/20251201-ad9434-fixes-v1-0-54a9ca2ac514@vaisala.com
> 
> ---
> Tomas Melin (2):
>       iio: adc: ad9467: fix ad9434 vref mask
>       iio: adc: ad9467: support write/read offset
> 
>  drivers/iio/adc/ad9467.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 2 deletions(-)
> ---
> base-commit: 9b9e43704d2b05514aeeaea36311addba2c72408
> change-id: 20251201-ad9434-fixes-6dfdc86fb881
> 
> Best regards,

Reviewed-by: David Lechner <dlechner@baylibre.com>


