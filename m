Return-Path: <linux-iio+bounces-18184-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ABAA9133E
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 07:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927641898411
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 05:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B541DEFD9;
	Thu, 17 Apr 2025 05:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmMUgnFq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674B1DE2DB;
	Thu, 17 Apr 2025 05:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868930; cv=none; b=mHcoCt6Oek7zsBfJauDxfWnIqeZ9X1pjFXON66w2+X4pUXuZbE2Fu4+7axwBYupzGcqkhqpbiqHrD2WfMdv/+N+Rn13rX93WCeb3ItxYDTlTpy6tJgGCC5OEblrjDBzlCr7dd3nALStDlmwFttFMbfeVzB8f29Ihl2Gozei6kcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868930; c=relaxed/simple;
	bh=j1ZBYuVBrZJCmWxUwT77cthlWHAR/U5idBaQjE3I0oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHeVsiUPQJ5dpPjL8d6v+hram5NjNenDBmL1Rm8ubNVifyBDulkYxOsSzBHPEtcig3DOSTYXb5rjDbpwOa/gWDhrWFwA332PS9mSK3ptCx0FHYaLQGHXH9iyxaCLq1e9WjZFXZbAa5yjEqsP3TP87ZqKewRawTnrpe8ffUlvjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmMUgnFq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22c33e4fdb8so4274215ad.2;
        Wed, 16 Apr 2025 22:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744868928; x=1745473728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNsf6WXByV5kGLNoh4Utq0sYrI3KSxAvmYlZ4eczIl4=;
        b=NmMUgnFqhXXRZh1NwEfzAtz2A/zfPZNQ1W2AWpOP8Pr56JW5EEM+PCK79W6JBeiWQK
         SuQlZR6CcXa5Vvf+okA53/D/Wfu+rngAMfxeijtwsLyhn5m1OJwjQzIMHdgPVhkPYF93
         m4vy09LKg6M54XbHJud+DKm5PK46atVAxof3CfplyafoTXfYFSSnzgK4Jd1V0VHAEUUZ
         ZOazRTs6Zqd7Ruhjm3mZKqEQFcXid2JSrLjMBHfx2VvOaavqXl4Z3+dkeaejEB6i3ZYU
         LCKTWTGAHDaIdpzwLB2HVkFd4fNEbEASl5uAGpwqC0Y50a1Vu//BH2MVGDXQA6zpltg4
         nteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744868928; x=1745473728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNsf6WXByV5kGLNoh4Utq0sYrI3KSxAvmYlZ4eczIl4=;
        b=kigWe2CuRum5XdwtFWI3lhIKOPylwAaaNX+QLoEdiIEY05jKsOceWbcizvvO4BtCLn
         VedP5CJf1cUMPgtROrCY2Y2+cURd3qo7lWAGVNbxufltHByd7vsxjdld43YZd/IY/a11
         +8JjcHCdxLLfmyzEo883Dxz8I3p//XARBaM+Ps82H2iwAMpYlayT0SJnf/x9/naIsdnS
         TZjqx0mZ8pL0aCzNWDcdzBYbuKLDPySMUGDWbU1hXbLzLXA1rA5Y1+Ze/c2EFAIBT3qE
         gxITvaEwuX8yusn2UWYHPq5vDDSUB6SxK9AA5pVRNTr9vgccjdjgpWUQNLuw7T9cxIJ/
         H82g==
X-Forwarded-Encrypted: i=1; AJvYcCVqsBiAy+dI9b1+PtVzxqYaeuzKULnvZ6WV7cvQX2f2Ho0O6utooMlA2eI+44W0d9LRPNWxZQFKZDg=@vger.kernel.org, AJvYcCVrFRvHus5H8sNMjLjbpWERRe4feElvaCKJeFidJqO1xHS0nmWYwfSnY72mBFgs1Fbt4E8eqL/HPIQbkV6F@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJ7aqYoW0u9xDGZ+pHML6qXAAcPex1mjANjPYt8bQWkMuNwtu
	tOeTgJIkiw+Bxe/AV+taPPBpSMMw2TaStPSRZKbT5ejZX2VmdcimlXGBsxmQ
X-Gm-Gg: ASbGnctU56sXzl+4Dx8D29VfRVFujHmqL1u0U6T6+QEiYOYYLWh4Q8QIj16wiugCxeh
	0Cd7reSM4DNdqNeou+Ks+e68Zd6FeRyDrujoOMgWTVuDCttg5H8y1qqSMqf6y7Fi8SWPYQIEoTD
	sb/SFWipWWAUFZITWgReqJvpJVLP76I+GzBP3YPYCCaCHwbWYeHDSCoR87PdDjCapC/c1LD45Ae
	2er4ezJogxAi0vvDgbpG197Fj1acsRyqPkmZ7dNJ0DvmezZ5Y8V4eL/6lZ5W9iNBrvX5uOFArpR
	RcNQhAhaICdQnqXXjyrnGXKC/BVLomcEjEOKZHQ2aYn1eIgJdP4Z7EOcJ3/f
X-Google-Smtp-Source: AGHT+IHezBF0z9ROPg31/enyGAUOnxCTQmX38YqiUYlSWdkhSgmUwXaiD6iT9D/Ho+BmJm9yeUyJ/g==
X-Received: by 2002:a17:903:2409:b0:21f:bd66:cafa with SMTP id d9443c01a7336-22c358db577mr64486325ad.17.1744868928047;
        Wed, 16 Apr 2025 22:48:48 -0700 (PDT)
Received: from [192.168.0.161] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c388fsm11881651b3a.54.2025.04.16.22.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 22:48:47 -0700 (PDT)
Message-ID: <471d32cb-89d2-4abe-bfbd-772466184d0d@gmail.com>
Date: Thu, 17 Apr 2025 11:18:43 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad_sigma_delta: Fix use of uninitialized
 status_pos
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250410170408.8585-1-purvayeshi550@gmail.com>
 <20250412180046.62f9eab4@jic23-huawei>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <20250412180046.62f9eab4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/04/25 22:30, Jonathan Cameron wrote:
> On Thu, 10 Apr 2025 22:34:08 +0530
> Purva Yeshi <purvayeshi550@gmail.com> wrote:
> 
>> Fix Smatch-detected issue:
>> drivers/iio/adc/ad_sigma_delta.c:604 ad_sd_trigger_handler() error:
>> uninitialized symbol 'status_pos'.
>>
>> The variable `status_pos` was only initialized in specific switch cases
>> (1, 2, 3, 4), which could leave it uninitialized if `reg_size` had an
>> unexpected value.
>>
>> Fix by adding a default case to the switch block to catch unexpected
>> values of `reg_size`. Use `dev_err_ratelimited()` for error logging and
>> `goto irq_handled` instead of returning early.
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> Seems like reasonable hardening of the code.
> 
> Applied.
> 
> Thanks,

Hi Jonathan,

Thank you for reviewing and applying the patch.

> 
>> ---
>> V1 - https://lore.kernel.org/all/20250409200151.201327-1-purvayeshi550@gmail.com/
>> V2 - Moved the reg_size validation inside the switch statement using a default case,
>> replaced dev_err() with dev_err_ratelimited(), and replaced return IRQ_HANDLED
>> with goto irq_handled;
>>
>>   drivers/iio/adc/ad_sigma_delta.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
>> index 6c37f8e21120..4c5f8d29a559 100644
>> --- a/drivers/iio/adc/ad_sigma_delta.c
>> +++ b/drivers/iio/adc/ad_sigma_delta.c
>> @@ -587,6 +587,10 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>>   		 * byte set to zero. */
>>   		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[1]);
>>   		break;
>> +
>> +	default:
>> +		dev_err_ratelimited(&indio_dev->dev, "Unsupported reg_size: %u\n", reg_size);
>> +		goto irq_handled;
>>   	}
>>   
>>   	/*
> 

Best regards,
Purva

