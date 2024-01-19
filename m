Return-Path: <linux-iio+bounces-1758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2748832949
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jan 2024 12:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C34D1F24FB6
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jan 2024 11:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D2B4F1EF;
	Fri, 19 Jan 2024 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="a4JdEE+O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA44944F
	for <linux-iio@vger.kernel.org>; Fri, 19 Jan 2024 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705665426; cv=none; b=GVSi645bYZxnZaJuhS1DSqUbHsSUZXYTDCh94YIH6L28L4x0qleuHviON+QZa+tZXtdwCGV94GtksEDahPoRs33L9Pk9ZRUcoXYEBqJIq2NaThXiIyZFslwfvolu7ykWh8Uyy1Bo880IgsGnTHGiBxM/gdF7noTitnR0k2TUZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705665426; c=relaxed/simple;
	bh=fVuPsl7YWFUpEJh06zIUwD1ZtlwmU2Vm11++xGNKYP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQQ6EeLQT7LzoJmtAQqbZIZpzXS+I+2Isa59Zpp3AY29gMC0lDpna0S+NXpKaYOivDI7M5E/R7/1t/0pgyV1APeeJLGejIYRSRygVkAdA9GsE2c93niCgT7IovGiTxVcQUd/z/79yhdJBs4t1DXasAJx5jVUhr33AK8WbDDZrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=a4JdEE+O; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-290449c30d4so380381a91.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Jan 2024 03:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1705665423; x=1706270223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lux3UVQlOyKwmTBEJ+0A8e/kL23oNu9FD/5hw0zpRlM=;
        b=a4JdEE+OYWzztlQn8ani1jluHRS29verXO9HMovFKZVHdNeKqK6wwyEbzspLAalZzd
         WFwpXe9SpVyAThmG4phKTrb+vn3EgfrDFjLSPPOfWHaNfeH8Q1nSykmkBr60sWa+/rBi
         +CssUjhqPlnK9gKI6h4J+ihiaYaYglqqBIee4JX34+K3fPYg+iKgSQM4e7RS/hYN6LMK
         quBNCfH/mrMZPmSFkXr2+uTVi2IjrE1ZQYqYQ1lU92t3bpnZEjQxy52ZouIjIWvDyMx4
         59y1tsppLP1pMjpS6Bbzbm+90NKxrwFY+mQGrllQnKOwhnaWZ20wWTaXw//lb5pAPUhs
         tuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705665423; x=1706270223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lux3UVQlOyKwmTBEJ+0A8e/kL23oNu9FD/5hw0zpRlM=;
        b=DZSs/LV/hoclWPMjFiJ/DHb+QI+HV4wcEeQixVosZrrsuF2QyacZ4HptOKegkeX+L6
         8ffz6hkJsw/58UV8vv6lizoIT3v3O/EJOy9AjI82eoZbPOaIJkr+8Kev9mcM/TzBmmWi
         23zIHlFf/3dMDdUKqXOXACYW70z0h+dr2q7WRVNF4nOmEvO6v8mpD4AlHFnc9RfrOvGL
         AWhPhOncbfbjheXNZ+lcx8r390dD92tBlJ63T+f1h5WNA8s7q4cO9UWQHWA0D8tfC0V9
         V4wRxZl5+yGHfOc37R7nRf6pWGnOONS0nYE6t27jAcOVnPb0mSBAWrQv1IRinlINTni2
         +0cA==
X-Gm-Message-State: AOJu0YzsoR3/ulfiqBSxPZ5tCZ5tuknLm1A4H5mAuzSqzA7PA4aFzdxX
	3sk8AHOzApOB++WYTXnozu3/iLtp9ESrSbvoYnlDcBg+cXSiM2EEQMBzU3hCalA=
X-Google-Smtp-Source: AGHT+IGEOi+n2nE8jX+7woP4kzEbqceg+eVMp8pOXvm0yamZFKU/n5y16oj5HPGCF91gF/9E98j/XA==
X-Received: by 2002:a17:90a:fb89:b0:28d:bd12:1812 with SMTP id cp9-20020a17090afb8900b0028dbd121812mr1861942pjb.48.1705665423128;
        Fri, 19 Jan 2024 03:57:03 -0800 (PST)
Received: from ?IPV6:2403:580d:82f4:0:179a:c38f:18a2:7cdb? (2403-580d-82f4-0-179a-c38f-18a2-7cdb.ip6.aussiebb.net. [2403:580d:82f4:0:179a:c38f:18a2:7cdb])
        by smtp.gmail.com with ESMTPSA id sr15-20020a17090b4e8f00b002904cbe8dc9sm1406054pjb.1.2024.01.19.03.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 03:57:02 -0800 (PST)
Message-ID: <a41ef2c9-bd74-4b0e-afb7-12e198847609@tweaklogic.com>
Date: Fri, 19 Jan 2024 22:26:58 +1030
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: gts-helper: Fix division loop
To: Jonathan Cameron <jic23@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZZZ7pJBGkTdFFqiY@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
 <20240107162253.66c1f0f1@jic23-huawei>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20240107162253.66c1f0f1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 02:52, Jonathan Cameron wrote:
> On Thu, 4 Jan 2024 11:34:28 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The loop based 64bit division may run for a long time when dividend is a
>> lot bigger than the divider. Replace the division loop by the
>> div64_u64() which implementation may be significantly faster.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> 
> Hmm. Fix or not perf improvement?  I'm going to take the middle ground
> and leave the fixes tag, but not rush this in.
> 
> So applied to the togreg branch of iio.git and for now just pushed out
> as testing for 0-day etc to take a look before I rebase that tree after
> rc1.
> 
> 
> 
>> ---
>>
>> I've implemented also a fixup series for supporting rounding of
>> gains/scales:
>> https://lore.kernel.org/lkml/37d3aa193e69577353d314e94463a08d488ddd8d.1701780964.git.mazziesaccount@gmail.com/
>>
>> That series does also remove the offending loop.
>>
>> We don't currently have any in-tree users of GTS helpers which would
>> need the rounding support so pushing the rounding is not urgent (and I
>> haven't heard of Subjahit whose driver required the rounding). Hence, we
>> may want to only take this loop fix in for now (?) and reconsider
>> rounding when someone need that.
>>
>> Jonathan, what's your take on this?
> Agreed - let us wait for the rounding to have a user, but makes sense
> to tidy this corner up in the meantime.
> 
> Thanks,
> 
> Jonathan
> 
>>
>>   drivers/iio/industrialio-gts-helper.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
>> index 7653261d2dc2..abcab2d38589 100644
>> --- a/drivers/iio/industrialio-gts-helper.c
>> +++ b/drivers/iio/industrialio-gts-helper.c
>> @@ -34,7 +34,7 @@
>>   static int iio_gts_get_gain(const u64 max, const u64 scale)
>>   {
>>   	u64 full = max;
>> -	int tmp = 1;
>> +	int tmp = 0;
>>   
>>   	if (scale > full || !scale)
>>   		return -EINVAL;
>> @@ -48,8 +48,7 @@ static int iio_gts_get_gain(const u64 max, const u64 scale)
>>   		tmp++;
>>   	}
>>   
>> -	while (full > scale * (u64)tmp)
>> -		tmp++;
>> +	tmp += div64_u64(full, scale);
>>   
>>   	return tmp;
>>   }
>>
>> base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
> 
> 
Hi Matti,

Your fix works beautifully with the latest version of apds9306 driver which I am working on.
All available scale values can be set without any errors. Thank you.

Moving to a new city with a new full time job with the assumption of getting more time
for my list of opensource projects and contributions proved to be utterly wrong!

Regards,
Subhajit Ghosh

