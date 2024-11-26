Return-Path: <linux-iio+bounces-12676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BBB9D94D2
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 10:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6277C1633C4
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 09:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480091BCA19;
	Tue, 26 Nov 2024 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT1cMEnB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F05C96;
	Tue, 26 Nov 2024 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614404; cv=none; b=JCIoG7ZkJXVu6Yzo/+DVY3qoieiSXPvQkN0ABKEMb5/2k4xAcAWvMWxYHSXLbl+1/9Oul8F1jp3zlZTZA1P4a3iMKObE8aUJNo4lCC5mfWFBXvL3pSe5OhFVfyb6ZVMHdeFlUMH0MN+qdHMKi4yiN/l6aCP2ZlX4Xi3Yo+ldyV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614404; c=relaxed/simple;
	bh=sEQaJPPvW2X6+3AFq3uS6HMUoT4YOsXz9iyfneuovQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcEZRFNGm6Iz/NHDHci1PcgJ4TlHJYA8xkKJ5/MjAwNYQJjvq8gIsPqLDj9rwKcNMPvGPLBrnl0Y+YVvXlZPiyBxFX606xzP5nvsL5W+f+eToKrAKlga6ioKEXbWsTA0rPF99grRfuXiYzEqPvaJOICm2eALb26DkEK0y6A1zn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AT1cMEnB; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa549f2f9d2so301586066b.3;
        Tue, 26 Nov 2024 01:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732614400; x=1733219200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=awnAZrvKIYXJxvtoDAboGj0ceKNoH7UCQHZ+qQeKDtc=;
        b=AT1cMEnBAl0zA4FMf4YWfMwjLh+xfS3mdhsVceH0UONZN8R/Ui0HvYNgllkBlRytTx
         F+hsT1J6n11pSw8MXeSAFx/IgoPBt1Y1FbwQ9ciaLsBR/QblF2QI8JfSvrWf6lkq3eIU
         Yk8ZeRWP/h7z/58J+p+Vn+Ub1FjsNa2gy9hNj9KyLndANyrTxLUIU7lnbwbhC1THJwh5
         1b8I8IaJ28aqYDckhw26cM5ldBVBejw5mz9adlp6EVbavFK8tDNSZPlN1FJBp5h7r58W
         IPkq4FAAVibn1bSv6Fn3jsiQzrOhj4adNw3ZHVd442ORsRE1bubxkDneTKw6+G/zVlMj
         N8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732614400; x=1733219200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awnAZrvKIYXJxvtoDAboGj0ceKNoH7UCQHZ+qQeKDtc=;
        b=kMr4DttRP7914t2fUbvdeNuCNc/eynC6wlg8hZHAK33kcjnd/usqWL5rjjMSOaKb2s
         nOMmgm4iRvH05RXOi9N9obVRk5qTQ3tUW/CVBkAGAVdNCCYmZy4yJhuVf/+8yZbfLCXf
         v/TZlPQ4GxPK6JWuAp8IYYfE45FeSo5WljCdqNj6rdSjRAEgchwu22anXu0xI4o38hUT
         O8mvyT21rcq3G6UwYEMlpD1ckg+tXC4kc8ySbGF0J/2YHU5viVcnG6/gQGD6j+qvC2IW
         2OrxApc/+xpYcM/wK+cJHCsaqi5ybyzTHp4SNMqdRJGWVhytW6GSGkbKZHh6gL2uG7uz
         qPAw==
X-Forwarded-Encrypted: i=1; AJvYcCU4qNQ2ZnU2j6jgp8UgH5Ss1qX9FVF1oWQM6Lub8MQYrSAgY83xGYFTLlAh6VExTmiS0RXyd3XaN/c=@vger.kernel.org, AJvYcCWkQPH0uG5qxKLEiEC8Um6NOt0sl8Jq0dbKt7DcKAtcSar6+93tnGY8QxcqfQwiPMVAkQ8cxHO12YkG8Kbc@vger.kernel.org, AJvYcCX/O7jEI2R4ZgiUXuAH9XHsbkg5Jbe1jth9bhEwbS8m0SFxpuDBG/3APU4BqOuagrqj8jHLWlXg@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ7uRiSFBzz0S+VRaXQuLBITwfqeqGCv7dz6nLMxVFJCEcL0dg
	ikcpiyO9/qXTCsKTGsAUYDDvb+0tq2IqqiJG8trpKXVsWEzWT1CC
X-Gm-Gg: ASbGncuqZ2lmV5iJaYchPre+GXX1NmjDh5+9zZ12+SfvDuBHPj183xyrFKVMoX5Znj7
	c3YwSyoRtdPxRkapYHTQCpRyFSDPe6yAOV5E14/h/24oDX1kwWaOzzCLF9MGN6leGV9H64JEz7U
	OJnz2ZV9pwhPoz8k6kw5L1MhsotcOparPbhqUR9TuhFA8gcSVcDH5zYyWUJ+tS071CvcWted10j
	1rOApI/i9ErTi3uXkqQpoIPYlbVIooTnc5oo9A3aK80761wJlVKN0naQ29YvQtrBI1HQOsvrLzk
	VwkzHQejt72reheVnSHEi99w9Qed
X-Google-Smtp-Source: AGHT+IETAgPrDEk67T6ikZ69+OzPEqLXprc1SO8UIPXfuFw9A5Iwuo/Br5aMdfYKuk+Qp3u21F7hDg==
X-Received: by 2002:a17:906:9ca:b0:aa5:3bcf:20e4 with SMTP id a640c23a62f3a-aa53bcf23c9mr750193866b.32.1732614400405;
        Tue, 26 Nov 2024 01:46:40 -0800 (PST)
Received: from [10.10.40.97] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52f781sm577953466b.108.2024.11.26.01.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 01:46:39 -0800 (PST)
Message-ID: <59a4b096-101b-419d-8a19-1063d759b4e2@gmail.com>
Date: Tue, 26 Nov 2024 10:46:37 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] iio: adc: ti-ads1119: fix information leak in
 triggered buffer
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Antoni Pokusinski <apokusinski01@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Gregor Boirie <gregor.boirie@parrot.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, stable@vger.kernel.org
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
 <20241125-iio_memset_scan_holes-v1-2-0cb6e98d895c@gmail.com>
 <20241126085958.GA13577@francesco-nb>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241126085958.GA13577@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2024 09:59, Francesco Dolcini wrote:
> On Mon, Nov 25, 2024 at 10:16:10PM +0100, Javier Carrasco wrote:
>> The 'scan' local struct is used to push data to user space from a
>> triggered buffer, but it has a hole between the sample (unsigned int)
>> and the timestamp. This hole is never initialized.
>>
>> Initialize the struct to zero before using it to avoid pushing
>> uninitialized information to userspace.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  drivers/iio/adc/ti-ads1119.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
>> index e9d9d4d46d38..2615a275acb3 100644
>> --- a/drivers/iio/adc/ti-ads1119.c
>> +++ b/drivers/iio/adc/ti-ads1119.c
>> @@ -506,6 +506,8 @@ static irqreturn_t ads1119_trigger_handler(int irq, void *private)
>>  	unsigned int index;
>>  	int ret;
>>  
>> +	memset(&scan, 0, sizeof(scan));
> 
> Did you consider adding a reserved field after sample and just
> initializing that one to zero?
> 
> It seems a trivial optimization not adding much value, but I thought about
> it, so I'd like to be sure you considered it.
> 
> In any case, the change is fine.
> 
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Thanks,
> Francesco
> 

Hi Francesco, thanks for your review.

In this particular case where unsigned int is used for the sample, the
padding would _in theory_ depend on the architecture. The size of the
unsigned int is usually 4 bytes, but the standard only specifies that it
must be able to contain values in the [0, 65535] range i.e. 2 bytes.
That is indeed theory, and I don't know if there is a real case where a
new version of Linux is able to run on an architecture that uses 2 bytes
for an int. I guess there is not, but better safe than sorry.

We could be more specific with u32 for the sample and then add the
reserved field, but I would still prefer a memset() for this small
struct. Adding and initializing a reserved field looks a bit artificial
to me, especially for such marginal gains.

Moreover, the common practice (at least in IIO)is a plain memset() to
initialize struct holes, and such common patterns are easier to maintain :)

Best regards,
Javier Carrasco

