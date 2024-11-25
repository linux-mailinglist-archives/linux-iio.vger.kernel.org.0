Return-Path: <linux-iio+bounces-12620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B1F9D8214
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 10:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1013B244B3
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 09:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3925E18FDCE;
	Mon, 25 Nov 2024 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXoIGlem"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBD51607A4;
	Mon, 25 Nov 2024 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526188; cv=none; b=nspLErwQ37RiUVT+ZI6aBip8EQJ2rBOGK+AKfjCxBosyuGT07Hfl6Y2u1J2XQKURi0jc7wWSeQzuwQSNkkwiTlmuM51LagfPe/bUaRjlB7c5iw1LezEMdD79YIKUwJrZZ/3a7Qs+GlA9lDVca1ENQhDVayv02K0oqoSwRwTSicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526188; c=relaxed/simple;
	bh=Ym3EiDg7mNxjj7Q/yW5OsCcdl3INhejPJO0EFm4ddJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utqk0H3XPrpPthPj55o3wigmG7jCMomgmRBib+mXopjACYZlDJBdvDjBDcwfK8alIiOcP8wFoG2UghmTgiqae7WaDfsWcw0VdE+iNUukRmaLLfTaw8H7KVaE/crtQaKuMYlzrYheS8/X1fXcEKAMzuxNvGm+uxi/G4QyNL8WLIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXoIGlem; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffb0bbe9c8so20250101fa.0;
        Mon, 25 Nov 2024 01:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732526184; x=1733130984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=olq9+ei4v6Ju6C86DLjepiM3XIsHf+3+X4kBYZA1YwM=;
        b=QXoIGlem7+Cnjrv4zmoVCx2kf4RcFzzTakSlCE6iFk5MZQPJN419QXwJE/+LdVyVmt
         E1EfeLCnWv12AU1QYaihn5MblDXBV3xSc1WrMb5mcDp+jx1BQiD6w45RRqhw8gvkpfr2
         NNxycnleXmukP9g8yLmXAVtCa33zluSKN2hlaJ6t5ai+vs1fdCyMWGWZbX3nzM2aE1gm
         vsPRXEpB9n362CuCquiYqNVU2MO5++0+IT305yiAqOZemUaxhBCjTn92sMZdZvljEhP+
         3PeJVuP6p0wS3D6j8ebnXN9YUNWIc411geZXNAylGJNC+mYeSlIQC2aYUg965WE1BdSS
         8B6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732526184; x=1733130984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=olq9+ei4v6Ju6C86DLjepiM3XIsHf+3+X4kBYZA1YwM=;
        b=ex9aEUo0J4Al8WLdU04qUGVFSi9cxdeoi4GX+th2vNTSzAgAy1V5uuduzL2/6Fy9rz
         z5kyL3mhZcexn25gBIr8B4nciu2kvHPQhBGS8nucuE6wE0ktzlhTx9IAc4YHZ/Qu260d
         d0v7ZT108zlG6BYbyfHLL8GvhtCHFzfW27j3ISGZZM+F1z0ZP+8wIvzqEcMFhKOv5ZAT
         KI6w/jcmqwpNEipBL96sWTnahLrolW++aUSyoZniPtzJCgK+q3ozQD1Z1uF17WfcPBo8
         PPyW5fUHLfVZmXTXWV44UeISDhAbI6biMBsWJkbBXQyRMEfR962sjmkO80n2dG02qatf
         N0EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBAlFoDCawysjcYbyI76Kfjtdlh8ffoZ2mEBKjQ3kyo+bKUBFhuFTFmTccCioIL/3eqAzgJ1x7Svsx@vger.kernel.org, AJvYcCVBreMueU/+Aj41WimNqQT6j5NvOtR//SZ4bzRodTTnkhUoT/hdaoo59SrjbljQx9SobootsYVaCHkKh1Sh@vger.kernel.org, AJvYcCWoChwVb6/u35xY3iKrERiX4ltECIzVmnmhwv7LTxmDkB4cbUCY72X1UhDn26GMFrV7UrOIiHsu8uvY@vger.kernel.org
X-Gm-Message-State: AOJu0YzsEkZqPisCRqINTOb85IfBVBBXi5ap+6UNXYsI4ygLNcJ1z5kQ
	eo97Ko6CgoXLU8WH1T0os1a8CESLIj6hy83UhHVoBcc2FFjInmn5oFGI0Q==
X-Gm-Gg: ASbGncu9J41FLn/acB53p9ba6/cw1+qde60ofsgNu4ZBsF1jx6vtCxUMjdIpMCUr7/a
	nJG5W2PazKdtU+7LI+ZrihD/hsLRH2OLCrU6FbwcCayJ7I2xwzicUNi9dRIRpbAZYOehi/GucRk
	hIjS8KW7SHNVEc6eYiuZCoC0c42/oycq5OUwQ6amBn2dsBbaYJYLCK66kH9KB2qdjAdSgpIRYYm
	x98oxxCcgchYrPZ70Bas5z1YChHe9KU6FGZp352lhvo3uwK2A+L/13sxbkx8po=
X-Google-Smtp-Source: AGHT+IEGABj/Ef3ZOUL9jxvGYKhb8A2rcL1PRQVmqdpD8nEJOAbqtF+JuWXEScWBdvDhbAV8OsVGxQ==
X-Received: by 2002:a2e:b891:0:b0:2ff:78be:e02d with SMTP id 38308e7fff4ca-2ffa7123e2emr52176651fa.11.1732526183996;
        Mon, 25 Nov 2024 01:16:23 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffae43dac4sm11321591fa.55.2024.11.25.01.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 01:16:23 -0800 (PST)
Message-ID: <964035d9-cccd-4e12-af71-00ca39cc3596@gmail.com>
Date: Mon, 25 Nov 2024 11:16:22 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] iio: gts: Simplify using __free
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1732105157.git.mazziesaccount@gmail.com>
 <5efc30d832275778d1f48d7e2c75b1ecc63511d5.1732105157.git.mazziesaccount@gmail.com>
 <20241123163713.2ec03a37@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241123163713.2ec03a37@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

Thanks once again for the review :)

On 23/11/2024 18:37, Jonathan Cameron wrote:
> On Thu, 21 Nov 2024 10:20:07 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The error path in the gain_to_scaletables() uses goto for unwinding an
>> allocation on failure. This can be slightly simplified by using the
>> automated free when exiting the scope.
>>
>> Use __free(kfree) and drop the goto based error handling.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>>
>> Revision history:
>>    v1 => v2:
>>    - patch number changed because a change was added to the series.
>>    - rebased on iio/testing to avoid conflicts with queued fixes
>> ---
>>   drivers/iio/industrialio-gts-helper.c | 19 ++++++++-----------
>>   1 file changed, 8 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
>> index 291c0fc332c9..602d3d338e66 100644
>> --- a/drivers/iio/industrialio-gts-helper.c
>> +++ b/drivers/iio/industrialio-gts-helper.c
>> @@ -4,6 +4,7 @@
>>    * Copyright (c) 2023 Matti Vaittinen <mazziesaccount@gmail.com>
>>    */
>>   
>> +#include <linux/cleanup.h>
>>   #include <linux/device.h>
>>   #include <linux/errno.h>
>>   #include <linux/export.h>
>> @@ -167,8 +168,8 @@ static int iio_gts_gain_cmp(const void *a, const void *b)
>>   
>>   static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>>   {
>> -	int i, j, new_idx, time_idx, ret = 0;
>> -	int *all_gains;
>> +	int ret, i, j, new_idx, time_idx;
>> +	int *all_gains __free(kfree) = NULL;
> See the docs in cleanup.h (added recently).
> 
> Constructor and destructor should go together.   Dan wrote good docs on this
> (which are now in cleanup.h) so I'll not go into why!

I went through the cleanup.h, and noticed the nice explanation for the 
pitfall where we have multiple "scoped operations" with specific 
ordering required. I didn't see other reasoning beyond that - I do hope 
I didn't miss anything.

I find introducing variables mid-function very confusing. Only exception 
for this has been introducing temporary variables at the start of a 
block, to reduce the scope. I would still like to avoid this when it 
isn't absolutely necessary, as it bleeds my eyes :)

I really don't see why we would have other cleanups which required 
specific ordering with the allocated "all_gains".

Anyways, if you think we really have a problem here, would it then 
suffice if I moved the:

         gain_bytes = array_size(gts->num_hwgain, sizeof(int));
         all_gains = kcalloc(gts->num_itime, gain_bytes, GFP_KERNEL);
         if (!all_gains)
                 return -ENOMEM;

to the beginning of the function, and the "int *all_gains __free(kfree) 
= NULL;" as last variable declaration?

(This is not optimal as we will then do the allocation even if 
converting gains to scales failed - but I don't think this is a real 
problem as this should never happen after the driver is proven working 
for the first time).

> Upshot is this goes where you do the kcalloc, not up here.

*whining* "but, but, but ... it is ugly..." :)

Yours,
	-- Matti

