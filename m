Return-Path: <linux-iio+bounces-3541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868C887C97E
	for <lists+linux-iio@lfdr.de>; Fri, 15 Mar 2024 08:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174581C21EA2
	for <lists+linux-iio@lfdr.de>; Fri, 15 Mar 2024 07:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B5B14280;
	Fri, 15 Mar 2024 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTss0qVp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57D114A83
	for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2024 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710489311; cv=none; b=EUkftBNN7dVIg8OJXCnPX4NajbJ1ju1HnLoS81HL0B7NmMABCTqj4ELvL1J6amdwsdqPdlZX947svl7ahJphZfJd2kgg1WgaUAWO+t/IjJ5jT8Qas7CMP55YlSLY2hmETKQGr0i5H97VfnYAkXjnScE3vmxHgIEFZtawiJizEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710489311; c=relaxed/simple;
	bh=yTf51qCFTPfpTwpYfMOqa6zUeAbeKAudBMqnLPMByQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LOxP9VIgBJvDzgkQsH6WSD1xEEA2hfKw3lnzdZqLWNQBRZvOCfs0GrYTLYw0bKNjBEXIuMENldY+hf72y+2fHOQIsCFzFp+7dltrV50ApWa7d3VIC1WcttYYdLseCyqAKwnA/lDYDz4qNcOKXUHWTMIKzf+DlrJcF9r3Sa2LY7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTss0qVp; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513b022a238so2255127e87.0
        for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2024 00:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710489308; x=1711094108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kx9unUjy8lM0QqEt0Znz/PPI/iFP/JIz1rJxeciiZ1Q=;
        b=aTss0qVp4kq5hltn6nigfSyUENdgA/jnXDKZWwTyeb6SdKoBtjhZI2OQdnOX92Jy4f
         xV5oX2BB+1zzuiYhrGQocm4RexGiOTT55UgVFo6VuxRAx1yNq4aYSBbvfr8qU3wsGJqx
         tpbsrJVrme1q5uOAOKU/bIzFiiZPinuLVwg5ZcD5BHH4FHgeIB+qBe2aaZI7mA9yEZJl
         QJFqUIKD32NQkZps974LXCZ2s5WD4cHvqqWl3oxmSCfVSIZls/0EP9Elie9mNZmf/Nxq
         p7n085jkg6qkgfLBxedFgKAnRDMbe6JaWLBgB8GYfJ7ISg/ybah8EX/iLyZyFYa86Pa4
         PCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710489308; x=1711094108;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kx9unUjy8lM0QqEt0Znz/PPI/iFP/JIz1rJxeciiZ1Q=;
        b=CPjuHYd3gDgQamtdPgLfDYtrOFUQWQBJxGu1hFfcOGfZc4hMljz6zS4NQ4QPOkYWjj
         /YwVlCW+Ncqmttne/kTjpV9PsihLMaYNK1C3Hn5FGsvJbxI3GIa39EhhB83IqMfKJSui
         oVx4ca4oHTFvYQ/7JAcDAASk9fKkBT7Avq01nw4hDherDHdcPTpNVFT8hZf7CHQ6cGzz
         paeJkf0pOmEFq6gBqevZ11sBgnnN9fLUmcBQhpDo17oZ7YroHnMOxMoG5WE6anigvz37
         IO20UYm/kG+e8lvd6yZN2niVrzvunhF6scbj5GATZeai7xJDjxNikkH1Gh4/gbhBQbsG
         Gqmg==
X-Forwarded-Encrypted: i=1; AJvYcCWJPvoRubgbv1fJb8XTgjTOGy0k3Kc8jTRSOVprvzB1DjcBivp91kHlA+dOHxc5t4cDgJS3L0a06jo8l6VGsnCOPu7Af/lwECv+
X-Gm-Message-State: AOJu0Ywupt19tOls2EOgVa8qyzaiGxJpY7HHSqFGOJBJMkYo91isKgLr
	uULc/LHX40/QFiXhp4GBVmDqTSG1M0Y4QOCSEbP4Q59s6vsT16Vh
X-Google-Smtp-Source: AGHT+IE07UevTv53UY+wnGP1zbPj5osfgFaGcp5dgKjjowa7c6Q8/Q2SrWMdhBc1aSsMFy3oBjBS6g==
X-Received: by 2002:a05:6512:521:b0:513:9e13:6403 with SMTP id o1-20020a056512052100b005139e136403mr3065830lfc.21.1710489307623;
        Fri, 15 Mar 2024 00:55:07 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 6-20020ac25f06000000b00513a84035a6sm561967lfq.237.2024.03.15.00.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 00:55:07 -0700 (PDT)
Message-ID: <a59061f8-5caa-43d4-bd4f-5ac4c39515ba@gmail.com>
Date: Fri, 15 Mar 2024 09:55:06 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: Fix the sorting functionality in
 iio_gts_build_avail_time_table
Content-Language: en-US, en-GB
To: Chenyuan Yang <chenyuan0y@gmail.com>, jic23@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org
References: <ZfHM73ZqgnCp6CZv@cy-server>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZfHM73ZqgnCp6CZv@cy-server>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chenyuan,

Thank you very much for taking the time and effort to fix my bugs! :)

On 3/13/24 17:57, Chenyuan Yang wrote:
> The sorting in iio_gts_build_avail_time_table is not working as intended.
> It could result in an out-of-bounds access when the time is zero.
> 
> Here are more details:
> 
> 1. When the gts->itime_table[i].time_us is zero, e.g., the time
> sequence is `3, 0, 1`, the inner for-loop will not terminate and do
> out-of-bound writes. This is because once `times[j] > new`, the value
> `new` will be added in the current position and the `times[j]` will be
> moved to `j+1` position, which makes the if-condition always hold.
> Meanwhile, idx will be added one, making the loop keep running without
> termination and out-of-bound write.
> 2. If none of the gts->itime_table[i].time_us is zero, the elements
> will just be copied without being sorted as described in the comment
> "Sort times from all tables to one and remove duplicates".
> 
> For more details, please refer to https://lore.kernel.org/all/6dd0d822-046c-4dd2-9532-79d7ab96ec05@gmail.com.
> 
> Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>

I think the suggested-by tag is a bit of an overkill :) I don't feel 
like taking the credit - you spotted the problem and fixed it!

> Fixes: 38416c28e16890b52fdd5eb73479299ec3f062f3 ("iio: light: Add gain-time-scale helpers")
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> ---
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 7653261d2dc2..61714a8d5717 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -375,7 +375,7 @@ static int iio_gts_build_avail_time_table(struct iio_gts *gts)
>   	for (i = gts->num_itime - 1; i >= 0; i--) {
>   		int new = gts->itime_table[i].time_us;
>   
> -		if (times[idx] < new) {
> +		if (idx == 0 || times[idx - 1] < new) {

This part should work just fine - thanks.

>   			times[idx++] = new;
>   			continue;
>   		}
> @@ -385,9 +385,10 @@ static int iio_gts_build_avail_time_table(struct iio_gts *gts)
>   				memmove(&times[j + 1], &times[j],
>   					(idx - j) * sizeof(int));
>   				times[j] = new;
> -				idx++;
> +				break;
>   			}
>   		}
> +		idx++;
>   	}

Here you successfully fix the sorting but the duplicates aren't removed. 
I'd like to have the removal of duplicates as occasionally we see 
hardware where multiple register values mean same setting. In such a 
case we probably want to have multiple entries with same integration 
time in the time array - so the driver can convert all register values 
to correct times. We, however, don't want to list same values for 
available times via sysfs. Hence I think removing the duplicates makes 
sense.

I think the logic we try to achieve is something like:

         /* Sort times from all tables to one and remove duplicates */ 

         for (i = gts->num_itime - 1; i >= 0; i--) {
                 int new = gts->itime_table[i].time_us;

                 if (idx == 0 || times[idx - 1] < new) {
                         times[idx++] = new;
                         continue;
                 }

                 for (j = 0; j <= idx; j++) {
                         if (times[j] == new) {
                                 idx--;
                                 break;
                         }
                         if (times[j] > new) {
                                 memmove(&times[j + 1], &times[j],
                                         (idx - j) * sizeof(int));
                                 times[j] = new;
                                 break;
                         }
                 }
                 idx++;
         }

but the flow can probably be further improved to avoid doing idx--; 
followed by idx++; for a duplicate.

Do you think you could fix the removal of the duplicates too?

In any case, this patch is far better than the existing code, and I did 
run some tests on it too, but I would be happy if the duplicates were 
handled as well :)

>   
>   	/* create a list of times formatted as list of IIO_VAL_INT_PLUS_MICRO */
> 

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


