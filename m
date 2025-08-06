Return-Path: <linux-iio+bounces-22343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E991B1C8D8
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 17:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 276CC4E35E5
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 15:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8927291C3A;
	Wed,  6 Aug 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Mlrgkfhp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945A82918DB
	for <linux-iio@vger.kernel.org>; Wed,  6 Aug 2025 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494601; cv=none; b=rjXJorfJiZQletDhhQsxnIQ06VsyXtw42hgnWSJhwLDhJSR99sYnUpKQXJGx59/eOrKTwxVT4TPrrmbudz/l0XSF8pfNsE32vgG9NqLeQXYDMS9nQrmjx2TEhjMoBuyqb13vGhgGvF8cknsw1fS3J2f72uCRwRnveYJ6MFHOHU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494601; c=relaxed/simple;
	bh=uvmxOPt36TrYQmAZH5PJimtskptI3m4APwNFvRAT5p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGBhEEgQnhWc9QOGLc5R0G2jXLgwwjVmcnUXLRG1R4j6HrlWhkRs76udQUxwzWeD+kGbx6W9qpG9wtgsgTERCvePLXwxAVdEECdD9ZnsPtw7KCnFfIH0zBMzkKfe7gxnwSZTu30COS8w2uWVy/QgWivU9846Y3LGRtqeM8pc44k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Mlrgkfhp; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61997c8e2a1so18021eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 06 Aug 2025 08:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754494598; x=1755099398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=thKq8nqRZOrjc9MmhrunTNzuRRm/Pq05XYSm+m11iWc=;
        b=MlrgkfhpSclxFqg9LOKqOdeMYXIsk2PCUGRpWGY/tEXhuPHPMcj5gZ9/zrE1+zsIkK
         Y/q5narRBlPtijtt+TCUOW9l8jIy/6jJx0+IhHzWKzEpV/I4PAb7ILSIfRdzKLZWhKgu
         uNxU0aWrLh9EbZzyAZ/0f+W/EhB+yR6eteueaulYUhTkBW/GH0YxKjiQXsQc+8tvgZsE
         yoehWtAwf6YlLjxfAFVuqo1aNTTfLsn/1vpDk8J7llrGzqEJ4SHsMpssA3gmpg+YiWsB
         mQC4csXZR6DCFAYI8izDowXzxdClgJbvyjY1112gPT9un1jQ0/SEjMvBP93x8Ib73xUg
         avwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754494598; x=1755099398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thKq8nqRZOrjc9MmhrunTNzuRRm/Pq05XYSm+m11iWc=;
        b=vO/LMdID2zxqNf5SsYaPDqZaAX/0+ghZW1PouiIUuOl7epYp24uCc0fqYKeBLQBpYB
         xzWwIsTJiy2PlGFdaT6m4Ozx/HCusJHMKZ5GYfjMuZp3Sj5H1qlhLKouMe9pd5WQzQls
         x0Z20g9emnl86dyNzkW2NVBeba4AftwuyIJtBRZpXPd1hiL3EDbLqa6LGVMo9btl5Krh
         B1zpbqKByLoy3MIDesLkSYKwjA9v81PH+K8NXpHqj6Wn6q8n0ZGFGB1QdikQcpljjhuo
         v3AZKigN7ZWNXc326Do3Stsuss9eEuNFzVxkLrQigtbkllz24gQIJm10xcOefThZHIEZ
         f/RA==
X-Forwarded-Encrypted: i=1; AJvYcCV60OfDCJkQNXBGZhbfiKij5th8SzTp3WiwgrR1AW7oC5+HFr5xXmE/SJ70vtkGEF+OxbcyEXSZg7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp523Pe786FXL1hAQ+JhWJIiU0pA2/3TezKsxJIumJ+KBs1naJ
	CrL+YYc030b8eo1l3S0owXSgcr/r34YXz4IxIsFzyad1NV0TzwM+cuz4+Bb5AMIwqrk=
X-Gm-Gg: ASbGncvPcf2NNcyDXMWdJeUgiYbd5oVXEspDaMxTtVcSRPTZoS3a/JJg8lvhm39MH+H
	Eohpcp/E+ECWr/bIaGw8aLU10qG1dTk16vQQ5nzrKA6ylmKmS2Q9NJfIzJ2ki02lVMfT2kSOT96
	AqiL5bZc6hCm2yq7mtxsb64JGZ9TvQXmw2N4oXj+Jw0kiE4yPsejgOxu6FdyrIVw7MRdSOfuQfg
	fzKmqcm/CR1gtE1SEkdjvEGBdPV6BOSTdTJBbroBTQpMyjj2pS7+vR0xn+Ft1/XG34fBwueC9kR
	H9Ay5UgH0p566g9weRy8xiFIzIu6s1fjv5PEmu0ETPvDZpmDxPg/GfU7B7r+2pDE6xouxFBy5yc
	KwdLqMGQNNgKflwnxc69X/unTYtOrTBBnbMDRs5B5fin5BuVwOCDyiasdsKtFmnZEwcr+o+oEHJ
	Q=
X-Google-Smtp-Source: AGHT+IEgpLxbOH1IdG1r864d3lWsygwTIH9kiW5cLmLAD0mJvYuFu4isOEti/2PmnFdeRsjTDRUgUw==
X-Received: by 2002:a05:6820:999:b0:619:a34b:3e29 with SMTP id 006d021491bc7-61b5f62b957mr1973618eaf.1.1754494598540;
        Wed, 06 Aug 2025 08:36:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d? ([2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-619705183bbsm2402087eaf.10.2025.08.06.08.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 08:36:37 -0700 (PDT)
Message-ID: <6397c502-26b2-4fdc-825c-2f666c43ea95@baylibre.com>
Date: Wed, 6 Aug 2025 10:36:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: ad799x: add reference voltage capability to
 chip_info
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefano Manni <stefano.manni@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250806090158.117628-1-stefano.manni@gmail.com>
 <20250806090158.117628-2-stefano.manni@gmail.com>
 <20250806155853.00003f0b@huawei.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250806155853.00003f0b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 9:58 AM, Jonathan Cameron wrote:
> On Wed,  6 Aug 2025 11:01:57 +0200
> Stefano Manni <stefano.manni@gmail.com> wrote:
> 

...

>> +	else {
> 
> 	} else {
> 
>> +		st->vref = NULL;
>> +		dev_dbg(&client->dev, "Supplied reference not supported\n");
>> +	}
>>  
>>  	st->client = client;
>>  
> 

I would just completely drop the else. st->vref is already
NULL since st is zeroed at allocation and the message is no
longer useful. Previously, it warned that the devicetree
contained a vref-supply when the chip didn't support it.
But now no message is printed in that case and this message
would be printed on all chips that don't have vref-supply
in the devicetree when that case didn't print anything before.

