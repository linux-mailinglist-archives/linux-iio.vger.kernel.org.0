Return-Path: <linux-iio+bounces-2695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2CC859021
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 15:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAA91F21879
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8A37B3CC;
	Sat, 17 Feb 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="PANa8sru"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA44D149E03
	for <linux-iio@vger.kernel.org>; Sat, 17 Feb 2024 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708180781; cv=none; b=N0zbtPay68ZTLtfk/I/qeAk10Q1O8mdkZBLKmm1fSImn2dtXVAkxEAVAZWy/2s3Q/QPPP0BPOfrEI9lgX9fpavQRHCip+MsoU8n+IUB9Pdfks1OThIlQ1Xlk3Wkm674cPn9nvuqo8HsppDAJAGiQ0a99pWdRCmLN9USZ3AH4hkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708180781; c=relaxed/simple;
	bh=xWWAkwL0hz4hu8Jh3YaTF/1bFJqdVShaDpWcm63XY2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBZOT//8bVfd/8fk30dRyW6BflqM4ua19KF8uqcsxFr7IUeH8ljc61NIcQaQ04wfRiURxMFkaGKoV6bGhyxNld2n5xsus/h//anwgPUDknMjDTz48Nf7G98o+wofLeh6DG5Q/I958OZv3mQHS7KlkySO7IgNQ6fxpl2EAQIlP0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=PANa8sru; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6da9c834646so2700628b3a.3
        for <linux-iio@vger.kernel.org>; Sat, 17 Feb 2024 06:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1708180779; x=1708785579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Snv5IU+ADbcqgOjycYAOmXHtXMcTl5Y5BUfYBZJWwIg=;
        b=PANa8sruRbDv1u1RX0i4Py3Kum7c4V+fkE0skrMnyP0J+rhT4d1dXfcX4j/8uSpLoS
         18MjyajSDSsHbK998T2wlaGdSppt2k/eIkGrDRkVsXt0322sbiFHLDQl1KMQ0O6sTz6K
         CZAKqQXkhLgm0nvbzDBD99PyI6J4ApEE5b3kqOxZzcQvYSOdwFzhawGVOM+CUThNf6mI
         SG1Gy/c5zOXyhHJGJsXGk7OIPZB47vYh+/l0jYPs0hztlLvUjzkr0IBII49GeWbXdDTN
         kiBi/S1k5gx05WHo6l1CVS7i2FBDez/T6ot9Pz4O8HJKK0EJMA6m92fCQWCNdk/p0LJl
         hgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708180779; x=1708785579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Snv5IU+ADbcqgOjycYAOmXHtXMcTl5Y5BUfYBZJWwIg=;
        b=gRiXWN8MzTHb5rjNKWleDD1B4Gaz815EK9NGd4tnY/Ryax6Gew6ovW/zf09XOY5GWD
         IebEg1YBfNfv5Bzs4Ym4IPzZlV8Xfyt0ko8XJpZf8uhRClcKRwwbutwXPD3wxLUy9Ay8
         fHI9vJYRjbsMgeHZ6k/EHhr5MdU9w1e/I2wCEdJZvm6KHTNVwy290Fzif4sbWLHFWfVI
         7hMcLeQD9YA1c4SxUx4aZch4d4MyqospBO6qAr+oGrnIRg74tdaHi+9jFlW7I2zNSeCK
         MCx+K9vV+Mv28ch19KzbqsXdg9nkLBilXJ8XRZShTjlSzLhJ32996Kgpe2UJ+0p1WXGr
         tXDg==
X-Forwarded-Encrypted: i=1; AJvYcCWQtyRrp7hPPgBBf18MamD022HymHkmU3ETO4BiI2zBlHGNhcJaxEqn6ZHjH78shU6q2BCMiY8HcnghXsB+1dWX7CQSwPsYwKhQ
X-Gm-Message-State: AOJu0YygJErdSQMEQPGky0JUyPWNevptbm9MZ0duJtBHzEnlr+7VripR
	Bmr5PkYITuU+0xHzDoECacO/y+2gly3hcL+mSp1jmfKjJBte3NbLvE5ytT+jZbE=
X-Google-Smtp-Source: AGHT+IFxc2PAnZvU9E8M/6kregS4EPVrmZJU0xTOHO0l1B7IbunDfGh0jPEaAt9U+I1OeuRBW+LXfA==
X-Received: by 2002:a05:6a20:9e48:b0:1a0:60b2:45b with SMTP id mt8-20020a056a209e4800b001a060b2045bmr9980124pzb.6.1708180778915;
        Sat, 17 Feb 2024 06:39:38 -0800 (PST)
Received: from [192.168.20.11] ([180.150.113.62])
        by smtp.gmail.com with ESMTPSA id n14-20020a635c4e000000b005dc2ca5b667sm1454274pgm.10.2024.02.17.06.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 06:39:38 -0800 (PST)
Message-ID: <dfe6e5da-b104-4acd-b323-4a7fa980de88@tweaklogic.com>
Date: Sun, 18 Feb 2024 01:09:33 +1030
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] iio: gts-helper: Fix division loop
To: Jonathan Cameron <jic23@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 David Laight <David.Laight@aculab.com>, linux-iio@vger.kernel.org
References: <Zcn-6e-0-nh2WcfU@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
 <20240216135812.07c9b769@jic23-huawei>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20240216135812.07c9b769@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/2/24 00:28, Jonathan Cameron wrote:
> On Mon, 12 Feb 2024 13:20:09 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The loop based 64bit division may run for a long time when dividend is a
>> lot bigger than the divider. Replace the division loop by the
>> div64_u64() which implementation may be significantly faster.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>>
>> ---
>> This is a resend. Only change is the base which is now the v6.8-rc4 and
>> not the v6.8-rc1
> Given I'm not rushing this in, it is going via my togreg tree, so the
> rebase wasn't really helpful (thankfully didn't stop it applying).
> Would have been fine to send a ping response to the first posting of it.
> 
> I was leaving some time for David or Subhajit to have time to take
> another look, but guess they are either happy with this or busy.
> 
> Applied to the togreg branch of iio.git and pushed out as testing for
> all the normal reasons.
> 
> Jonathan
> 
>>
>> This change was earlier applied and reverted as it confusingly lacked of
>> the removal of the overflow check (which is only needed when we do
>> looping "while (full > scale * (u64)tmp)". As this loop got removed, the
>> check got also obsolete and leaving it to the code caused some
>> confusion.
>>
>> So, I marked this as a v2, where v1 is the reverted change discussed
>> here:
>> https://lore.kernel.org/linux-iio/ZZZ7pJBGkTdFFqiY@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi/
>>
>> Revision history:
>> v1 => v2:
>>   - Drop the obsolete overflow check
>>   - Rebased on top of the v6.8-rc4
>>
>> iio: gts: loop fix fix
>> ---
>>   drivers/iio/industrialio-gts-helper.c | 15 +--------------
>>   1 file changed, 1 insertion(+), 14 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
>> index 7653261d2dc2..b51eb6cb766f 100644
>> --- a/drivers/iio/industrialio-gts-helper.c
>> +++ b/drivers/iio/industrialio-gts-helper.c
>> @@ -34,24 +34,11 @@
>>   static int iio_gts_get_gain(const u64 max, const u64 scale)
>>   {
>>   	u64 full = max;
>> -	int tmp = 1;
>>   
>>   	if (scale > full || !scale)
>>   		return -EINVAL;
>>   
>> -	if (U64_MAX - full < scale) {
>> -		/* Risk of overflow */
>> -		if (full - scale < scale)
>> -			return 1;
>> -
>> -		full -= scale;
>> -		tmp++;
>> -	}
>> -
>> -	while (full > scale * (u64)tmp)
>> -		tmp++;
>> -
>> -	return tmp;
>> +	return div64_u64(full, scale);
>>   }
>>   
>>   /**
Hi Matti and Jonathan,

I somehow missed testing this patch earlier. The above patch works fine with apds9306 v7 driver(which work in progress!).
There are no errors.
My test script is simple:
#!/bin/bash
D=0
S=`cat /sys/bus/iio/devices/iio:device${D}/in_illuminance_scale_available`

for s in $S; do
	echo $s
	echo $s > /sys/bus/iio/devices/iio:device${D}/in_illuminance_scale
	sleep 5
done

One question - if I test a patch like this, do I put a "Tested-by" tag or just mention that I have tested it?

Regards,
Subhajit Ghosh

>>
>> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
> 


