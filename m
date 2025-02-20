Return-Path: <linux-iio+bounces-15893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A82A3E5B2
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 21:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164FB178C8B
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 20:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001A62135BB;
	Thu, 20 Feb 2025 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VATQUrUp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680021DDC14
	for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082826; cv=none; b=SrBsvcUfN+qZhgmI47y0LELr2pUXSvg3XpBgJ52QT18evGFjRoDItFyFzVB71ohU30RwL1mYwI1oJz/+WgJ4dC8sJ4kZYqQ7Znybpht1g+OiioUSr/58NSqHnkI9SUJUbObINRDWHcI7KM3caTlcmCUzZKkKAaWtl1frj1suTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082826; c=relaxed/simple;
	bh=9AJ8NJ3fQ71s31AL2ReKVKY4uz5K/1w53C9zcgxtO+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tC0B4cdytEO0MYL/bnJ1oSFxdFEMhd+ORQNwQmhtIjrFTAClctJmVoNgvdw91DVMNqE6cy5kql/aFcfgDMKfs93ptT7bfFKBowL34hxV96E6SmDzYX+fJ74jhrhQ1bGHPs2T9y0XUQDEpIoTtDfA9rmIYvgHSqmB8i5TfuMmVhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VATQUrUp; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5fc6cd89f85so575599eaf.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 12:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740082823; x=1740687623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3YA0S6DeTYDLSFKZ0z+n+MPKwXA/ZHvwCQOrhZShsds=;
        b=VATQUrUpyhnfA/wKRR5imajWPBWt/CitSu1NwmIu5xZMmmgvi51TsTD3b7iDHmreTd
         fW397KmI+vuS8Y9unSiTWOvpzOClSXH8q2ytMJgrFUw8q7BIP4KZ0coUzZbxUfhPXExI
         6BdGBuc+E5IMnCfkHaYCH0eOnRdzL5x7RcShAYfzG1BvoxW5u2cwevhvYUdHkl+Ag1O/
         +dVjnqYOIKPjSMVHQefpq39AW4lhAicb8MPuAmeoeEj9iv8AQWQSTxxPuvUPwZ42Zz45
         33ykJ1otFBQixPV8p8jj0Nm2mHIcycNW7rZntb1SguOMqaxszLtC5gu/kvSiP6At7gDC
         Zq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740082823; x=1740687623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YA0S6DeTYDLSFKZ0z+n+MPKwXA/ZHvwCQOrhZShsds=;
        b=rhchKDat4M5QeGZhitgHCWyrFyqH16Xg+x5rxvcDkSaBtNTUNt0UqnevSYZ2r+sROE
         LHJMIUqram5uAeoq62uOnV2qvhDUkJEieUhBvZzp0FqKtXK7jSbV/ZqO65FC3KCKaSDg
         YHljiN/5Qd0gIXJaXKRLTXM4PSnbLRXQP4mFFDBWswRQzomyJn0Vv57gJVirNZFR0wV4
         ApyzC98XKLxQBphtQaHqW8xAgcl7v6F0iscS8CWV9RWCP26eDrTlH0hyF//iUaLXDjyw
         AY9e8qXUEPRxYOiv1r5i15ye4nhuNrnDkdV08+k+o4nacljm0xDFk/6vhG0Niy8SxEFu
         velg==
X-Forwarded-Encrypted: i=1; AJvYcCWi0FAmZgNfPlE/RMMCgi1QZTKXrrodyVcoW2GxI+lP+mZtl3VttOGL+yzQ6YRBoUR5hf5fOj0LYXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJv9lL2nnLqRf+rManutEvVDrLQKn3YRvCROa0ED5JEsVUmtI2
	TAUqGv3qWtbJiM6mpA0+imDSrY5ypt5bA6XIMLVR/YRmJRAD29BaICdE4c1cHnM=
X-Gm-Gg: ASbGncv9Fss+prj6/o1OT661+92fJwZgvK4luOPxsNRz737aGwGgjD/sCmb/NEVHVHh
	nWmP+naBNZrUqhNaveDxA3Ynp9b0O3nlTvd1YmZKgVlR/t+1gMbcC4zwHE4WLpaUx4t6OZ7yEcj
	OlKEUpbGcsAjfd9LbHpvECYJeaURdmMQFCAEwWP2ytraxTztZOGPjNkgtP4RqQbIyNoZfIwLQi9
	IwwfbQ3afeLtNIFwiTJD2H7Un+5K4OHAABS6+L7+FeDSxH0g/4LZV42XNzQB7I0zLCpBssgSHSa
	IRNY90Bt5DS1kZIlWlvZZDLRXvp2aK2kDHiK5s6jY1AcCO8kHrMF
X-Google-Smtp-Source: AGHT+IGSPaTaOucH2dLQqzNmLsQTf0sq/ili5Qrkv0KGKys857Oj5ka28XQilT2mB8kbG8XY9mj4fw==
X-Received: by 2002:a05:6808:2112:b0:3f3:d5a1:a928 with SMTP id 5614622812f47-3f4247c1ef4mr590369b6e.32.1740082823499;
        Thu, 20 Feb 2025 12:20:23 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f41a6fc550sm504082b6e.39.2025.02.20.12.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:20:22 -0800 (PST)
Message-ID: <13c5e420-a3ca-468b-8810-3528b24d8664@baylibre.com>
Date: Thu, 20 Feb 2025 14:20:20 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] iio: backend: add support for number of lanes
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
 <20250220135429.8615-6-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250220135429.8615-6-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/25 7:54 AM, Antoniu Miclaus wrote:
> Add iio backend support for number of lanes to be enabled.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
This is why I was pushing for a similar function to be an iio_backend
function in [1]. :-)

[1]: https://lore.kernel.org/linux-iio/94efa413-5fa9-4014-86c2-331442e9d42e@baylibre.com/

Not sure if that changes what we want to do here, but just pointing it
out as a similar case to help us decide what the most useful generic
function would be for this.



