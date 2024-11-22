Return-Path: <linux-iio+bounces-12474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6AA9D5941
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 07:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC20281BE0
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 06:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E3C15B987;
	Fri, 22 Nov 2024 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxPCzrOi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D146158214;
	Fri, 22 Nov 2024 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732255816; cv=none; b=W2A1pCdnaXte8NdmYFpH7flzjembNym+JMM+mABuyi+yr881sSstE0USE5VXOCw3PWYQUPdv4A9XQavOL6AHI0hC0QDBssJjcHZORR1J0QFYOf3D+R0JJN+i7hg+oHAqyKuMdChI3szhkBxEx2KSv5Qe80qoXxHz/wrdVbxY7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732255816; c=relaxed/simple;
	bh=h1BuSolWKnMZV0lYRh/sj1XnIlI3eusKPoDlGjOs2YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roz3otCmFpjzpJPKSLMMXni37PRpEgBDQoBhQ/wTLcyD33JqqIx2u1oQi2EqbDX6TTXihvzJhRort9AIniI3gfelBRfSI0DABPBnZDiHLbnseMfe2iiER8fXqDZ8TEydpKbzQFCI5BVLbxtyOD166ZPwo4gfWR3wMMVqJsjGWlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxPCzrOi; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffa97d99d6so915481fa.1;
        Thu, 21 Nov 2024 22:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732255812; x=1732860612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lXmuqMypGahuge5EVWptLvwyNQ/jI/s77haxB8Mhc3E=;
        b=fxPCzrOi/t6pYczWHZN6r84RnpqpW4GJPmJIisfGdpDkfZutCWOMu1VMtPrqtrkCqE
         YEY68GxMln2J0qujzpMq8vZAenODeRw+EVSKKZEUHQzPLTtS+24VlhFPQHmszLwa9+0i
         GtNfv9b3Pe0ep4y+kJMYKFZtWOTb2QP0gVzv1Z4ADnuNLRKPrCb7Y+0qnvVfEPXrEPsR
         BlVgWhpd0FTjboz1Z8xpCJwaNoV7kRZ3qMLKS5p3j1bnGrMFYbdZHCHAgb/lxfate8F9
         WL4CAEooqj7yjHcJM0D85ADHU7M7b3asnQ7BRgzFekOnNHfklEFIP4VykIKIUf/Iv9eP
         /Enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732255812; x=1732860612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXmuqMypGahuge5EVWptLvwyNQ/jI/s77haxB8Mhc3E=;
        b=hcRZU/T27YU6gV1JEog4n83MkkFdZn8r3O85ZylHUdvAIdUkO4OiYT86jxsvxJip9Y
         HZN/NLeb0R/9ziSCtHsKqTSrQokVAwHI3BmUzAR13g9hXHP0/sIQqP7eplNfNsbYN1G9
         avek8TaUW7tQMEMgJkkS14aCmSarjTQYXf4o/NNyrVClVdOO/mwZrYeIEStfP/ZP6hnc
         lShrwDoaQPoAektZRq2ay4N3z71qVI98dGwEs4OWlTak00gvkoBAmXRn6QK6m6qDqVDy
         nCzaO6e6x0CDIqep97Qnz9n2v+KGrP0k+ZDp63N/JYvk8ht6YJcz+49cMidIouRXuMjS
         0yuw==
X-Forwarded-Encrypted: i=1; AJvYcCVBIXwlYDHxz8+ZB/JVBDZqQblLfe3D5itMvX2NiNPHcnrtQ6eyc4h0rVleZdqi6diChdnDRkkM/GTUUT1I@vger.kernel.org, AJvYcCVKhic8lTWIwM0IX4dy5io6jaxrqU09EoWTbSuOi3vNars6YDENyfiwGt7TQQkQ5IgNSFM3RCOtTug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt4NcpUcksIYok1HliBCZPjCSqKwQ60uFppMefdOD6SvKLZ6Tm
	cLEBF9z+511tlQQL64/Lu9hvpZp6ekK5FKHvl1sQCCfrLIWSDvQdgaI87Y8M
X-Gm-Gg: ASbGnctOwgns79KCr8ok1JT+aKJNwijJqeqxtx4ZKPuawEp6je8MRkWqwGRTLlMzuai
	IL4LWVogb+n8xwakMPUTPsLwzR2TeUcpy/m8vRLdpRRfri9qX6ZB+rB42IYex83jlgsZYTlW2Uc
	jY2GrpOv7rjqEu+pcnO8RVuRAx+CvhiNPV/2LVdxD8P5spDNQmxXvPZNLP76NQiO4DMrgAQ/MiS
	1IsyKWD/4JWETwyML/U1Nni5r3qarkMUwN0XzEF9OWH4UdY7DTvOq1ASil5tmsqFb5gEEWHju2M
	M8M8ffrhD1vAsZKVADXdTavA+2MiPxw=
X-Google-Smtp-Source: AGHT+IHlSjwCiOvjkf1xMUeTHog1xaJ0fNmCjHTSTG9l04ARGBd4a8eUwC1bTZei59htSK3+n/4abg==
X-Received: by 2002:a05:6512:10ca:b0:533:4689:973c with SMTP id 2adb3069b0e04-53dd36a084emr546807e87.23.1732255812118;
        Thu, 21 Nov 2024 22:10:12 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2489d92sm242004e87.193.2024.11.21.22.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 22:10:10 -0800 (PST)
Message-ID: <37bba4fa-34c6-4b7c-ae65-75929213a8f2@gmail.com>
Date: Fri, 22 Nov 2024 08:10:08 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: Use __cleanup for a few ROHM sensors
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1732193263.git.mazziesaccount@gmail.com>
 <2f321215-2ca3-4249-a9f0-427004c95d70@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <2f321215-2ca3-4249-a9f0-427004c95d70@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Javier,

On 21/11/2024 15:54, Javier Carrasco wrote:
> On 21/11/2024 14:04, Matti Vaittinen wrote:
>> Use __cleanup.
>>
>> The series converts the rest of the ROHM sensors (maintained by me) to
>> use guard(mutex). This simplifies the error paths.
>>
>> As a note, kx022a accelerometer driver is handled in another series,
>> which also adds support for two new accelerometers. I did also patch the
>> driver for the BU27008 and BU27010 - but when I was testing the changes
>> I found that the BU27008 status is set to "obsolete". I'll try to dig
>> some information about the BU27010 and decide if having the driver
>> in-tree is still worth the effort, or if I should just send out patches
>> to drop it all. Hence patch to rohm-bu27008.c is not included in the
>> series. If someone is actually using the BU27008 or BU27010 and wants
>> to patch it - feel free to pick
>> 131315de97ff ("iio: bu27008: simplify using guard(mutex)")
>> from
>> https://github.com/M-Vaittinen/linux/tree/bu27008-cleanup
>>
>> ---
>>
>> Matti Vaittinen (2):
>>    iio: bu27034: simplify using guard(mutex)
>>    iio: bm1390: simplify using guard(mutex)
>>
>>   drivers/iio/light/rohm-bu27034.c   | 73 ++++++++++------------------
>>   drivers/iio/pressure/rohm-bm1390.c | 78 ++++++++++++------------------
>>   2 files changed, 55 insertions(+), 96 deletions(-)
>>
>>
>> base-commit: adc218676eef25575469234709c2d87185ca223a
> 
> Hi Matti,
> 
> Both patches look good to me, but I noticed that you kept a few
> mutex_lock() + mutex_unlock() in both drivers, in particular in the
> cases where a scoped_guard() could simplify the code. Did you leave
> those cases untouched on purpose?

Thanks for taking a look at the patches. Much appreciated :)

I remember leaving couple of direct calls to mutex_lock() and 
mutex_unlock() - but I think I left them only to places where I saw no 
real improvement by the use of guard() or scoped_guard(). It is likely I 
considered the locking in these cases being trivial. (Probably only for 
a duration of one or couple of function calls, with no error handling 
when a lock is held). The direct mutex_lock()/mutex_unlock() has no real 
room for usual errors (like leaving the function while lock was taken) 
in such case.

For me,

mutex_lock();
ret = foo();
mutex_unlock();

is as clear as it gets. I don't think scoped_guard() has benefits there. 
On the contrary, for me the scoped_guard() would be more complex and 
less obvious :)

Yours,
	-- Matti


