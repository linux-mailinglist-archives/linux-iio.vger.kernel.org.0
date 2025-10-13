Return-Path: <linux-iio+bounces-25032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7E5BD4039
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 17:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADF63E627F
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 14:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D19309EF3;
	Mon, 13 Oct 2025 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="adaQomyY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694B2EC08B
	for <linux-iio@vger.kernel.org>; Mon, 13 Oct 2025 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367123; cv=none; b=jYSx+krnF1j36uemjPPTDK+YNLmdmIuwW4SvKgt82OHAG/S9Rf/prSp8nmc63z2eDgJT3ZZ5LvutOFZnxioNH+pj7ZQetaIoWDIYgXi22wE1YHb4ErZFWXN+Sxs83QGP6s9mWnnTiJKGgYvmQWeucTtV8J4X8K1WCRiETwfYGeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367123; c=relaxed/simple;
	bh=nXVVLzT4Nhn0Q/A4tv0nslm5cvTeZA35dLDIUC173GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKj9sFTyqQrbsIeKnvPSxqdds/ofwA+TplyZ9J4KZqYpHpkLdKdsc6Ku885tbXiCA4YKCO5QLZoVPA8Wpeyhj20OaQvh36KyVB4Hc24/SPtlrLm+wbmj8cT4kzGWWnExPKaShk7aRtOpMMBi0Uti7GXzM+yDEdUNSQYuRCUw+uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=adaQomyY; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-43f554ed252so2406874b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Oct 2025 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760367119; x=1760971919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4aRBgJpQr8jK9TQ7APmSoZVUZardfbkU5RGx9vJNeN4=;
        b=adaQomyYD8K27MhPD0vJ+ANdKN8325AXYbm2wtk6brSQzRrUAK9K+uh3aOjI1l/rY4
         caJ6lcJOQ+TgWuyQ4PNbW/x+quFjTqZ4EUnd1DBsd0LSSpRB/22WWAY+fpTiJY94jOH3
         BUaBOOrbV3y+axzlmICZpCf7oiRPGsJaMdzLrAZrBgaM2FJtE50acInorbDKNe+y/S9Y
         C/+HjinqvmcgKr3m94e4670NcRvYf/elXlNxu9eEtMQMrdnR/C/GBTdmcQXeMocjpSUx
         APAG23dE4KLbA4Ufkwhk9OHDiMGM7iO5nMO83HWr6t/10zAJ7rrjQ0N7wd1Zwhluvb82
         2CRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367119; x=1760971919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4aRBgJpQr8jK9TQ7APmSoZVUZardfbkU5RGx9vJNeN4=;
        b=LXXGkIZRklCCMUHgFYSBkXDAeD1Dtf2OBurtnBLXv0sK+wOVwaY5I4MAxGu1TrWiUf
         QdtywEG7lLQgIemWZKHgRYtnZwwd9TRHzmpnv4fitCatPagFscK3emzDwc9Y6OCUv3fJ
         cwXZtZAuvVkWcj8vlmOZS8h4FDL2cZ3pV8DXTcGFP9ch8m9GeFqXS/5yTdRIG2vk6s/v
         bW22mg+7W9V7fwyFqfbWERF5kfiO1p1gG2v8NgsZ2RJBwYeh16A6v5tmGIW8ZY4wSko8
         d1OPKj3Ar3C8rSEK1h/4KyGrdLqAS0kZOaxH3oLR9f5GiORbD/fy5fPKHim/V6wBcOZ7
         zSfQ==
X-Gm-Message-State: AOJu0YxB5GNmXkk8nLpRFs5gGGtmsluAgUB7Gn6658NIgnBPy4CIKi7/
	K/geYgkn1askCaHyHAwttziBdPgYItsfLJmwDURRjBXxJ5Hv0qERcsKEjjmLYxVV29MkLsxnidN
	9j4cZ
X-Gm-Gg: ASbGncvfLL9J2OmK7UHmBOCklKG8kC0rrY5Wgg/ozedKuzsni4wuqtGiFxTVeNvZJLM
	s51li8e/HRHZ8vbFWhpnDnwnGRAUUgVv/F3BouQ9A62c4vk4DNqfHv6HApsHoxDA2cjxK+8tGy8
	9lxSsq4tiRsNA4PQQUs57TBLiGYNb7PcsFX9mrlBuzuEB8rfE8wuIfGhv6fxZRabo/1hnUJ/GHz
	UCB+VoNxIxQNMieJZipqzNe4jcXBhAs2ZQJ2IrmO97Dd5FlPWQT1xrjLCnXBhrG/7gDRuGc3muO
	Js7LU7FLqLnljHGlJMiFm3Qukm5l2mpwp/0PwRK/Q8mGc7MRcU02EpBJ7LgjSmgNYj4B7Bu9IQl
	sa8eXe954SBm6Yz+UeFQggrFu1KNQSPv3vHX0AaIU2WYk0RaNsS/OGuypKNqCgisgc0AZ1St+DF
	o/qjYCQC53o3CexpBi9i9MZUKlgg==
X-Google-Smtp-Source: AGHT+IE7iMaPnJ50HxSkD1yLY7r5ZjIzoU4QH1L3ONVMMFfr9TT94SF+fUpUrrZKw2ofHxc9OlciiQ==
X-Received: by 2002:a05:6808:1484:b0:441:8f74:f12 with SMTP id 5614622812f47-4418f742030mr6323843b6e.60.1760367119185;
        Mon, 13 Oct 2025 07:51:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:dc0c:4910:f362:c012? ([2600:8803:e7e4:500:dc0c:4910:f362:c012])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65018130f87sm2630468eaf.3.2025.10.13.07.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 07:51:58 -0700 (PDT)
Message-ID: <ab4228f6-dba5-461a-92c8-47dd4987fe23@baylibre.com>
Date: Mon, 13 Oct 2025 09:51:57 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iio: accel: fix ADXL355 startup race condition
To: Andrej Valek <andrej.v@skyrain.eu>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Puranjay Mohan <puranjay@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Kessler Markus <markus.kessler@hilti.com>
References: <20251006095812.102230-1-andrej.v@skyrain.eu>
 <20251012162652.65619962@jic23-huawei>
 <6b4889b6-a806-4ecb-b6d3-ed164b821645@skyrain.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <6b4889b6-a806-4ecb-b6d3-ed164b821645@skyrain.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/13/25 2:07 AM, Andrej Valek wrote:
> Hello Jonathan,
> 
> 
> 
> On 12.10.2025 17:26, Jonathan Cameron wrote:
>> On Mon,  6 Oct 2025 11:58:12 +0200
>> Andrej Valek <andrej.v@skyrain.eu> wrote:
>>
>>> From: Valek Andrej <andrej.v@skyrain.eu>
>>>
>>> There is an race-condition where device is not full working after SW reset.
>>> Therefore it's necessary to wait some time after reset and verify shadow
>>> registers values by reading and comparing the values before/after reset.
>>> This mechanism is described in datasheet at least from revision D.
>>>
>>> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
>>> Signed-off-by: Kessler Markus <markus.kessler@hilti.com>
>> See submitting-patches.rst in documentation for how to format it, but as
>> requested on previous version please reply to this thread with
>> fixes tag.  No need to send a new version.
> I looked into this document, and to be honest didn't find any "issues" in my patch. I used checkpatch and get_maintainer scripts and passed without errors. So what's missing then?

This patch fixes a bug, so it needs a Fixes: tag that describes
the commit that introduced the bug. This information is used to
automatically select the patch for backports to stable kernels
that have the same bug.

So Jonathan was just asking you to reply with the following line...

Fixes: 12ed27863ea3 ("iio: accel: Add driver support for ADXL355")

See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes



>>
>>
>>> ---
>> Change log missing
> What do you mean by this? I didn't find any special document for this. Or do you mean the commit message, if yes, what's missing?


Each time you submit a new revision of a patch/series it should include
a changelog of what was change compared to the previous revisions that
were submitted. And preferably a link to the previous submission as well.
Tools like b4 can automate parts of this for you.

See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#commentary

>>
>> Otherwise looks good to me.
>>
>> Jonathan
>>
>>
> BR,
> Andy


