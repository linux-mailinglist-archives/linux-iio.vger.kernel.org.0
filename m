Return-Path: <linux-iio+bounces-27928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6CBD39967
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 20:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93EAC3001804
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 19:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54032FFDE6;
	Sun, 18 Jan 2026 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vxSlQKDk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0181E1FF1B5
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 19:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768764617; cv=none; b=MR13iR8Q4VtskHD91rh57429OM2poHY2xMN/ChXF2STjO+RGAaDBJV0nF4d40GJL5S8ns6zNg2npCjX3pqrGNsNz6fSHyixNkLitaXKdZuI3emHkWLLXHZ9KGKbqhEANubfd6kv9O0YkX3ZMl0FSL2vnMo9m7XgXDDs0uDFcYk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768764617; c=relaxed/simple;
	bh=XaDBiv5M+RFEv9IJJoFZ/qrG6BEziOBJceL/IH/8v2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiT/GtVvh3z3pqmmwqtYt9cT8XpILmqGT8aTA4MoY5wnI4vj08n4LauhcMOhoHszFNcUdJC89QxEBTWRrKP0CM6EJHk+SGgzNphFr74Okns1BNNUzH5NtbIWDUWkEun0CDt91cBhZlPWqY47TEXNuvdKkuR1bkb/Bi8ZeRnb5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vxSlQKDk; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-65f65538a90so2691104eaf.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 11:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768764614; x=1769369414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FE91AlC+Wf3fpDTOpQTd2EcMaLnOUTf8XrrOstYz7Jk=;
        b=vxSlQKDkTk7lETeGBMO4B8ps+6pQeHm3jp/IaJq33J+5iTERlU9XfhmjrxR3aGCql0
         z3xbn6vyA74w1NUqkaZW+sVSeBjeEp3BBWIp2xmS/zULhGY4DrmGZPdfRxC4vG+t5kYJ
         q+XPhe1sBB/mdTKX/iolVMPyyFDAOsZ/O1K/5Kx9m5S/M6uDy9NJs89W3l64eUD7hl3d
         xTqbC0frifoLq+l8bQAbqImquQJ/Cpi5xUk5u/zznS7ACSySAuTW1mADCDJfCn2NS/kJ
         Dpp1AVmAVu2090sFsgTDXC/IDbvHK9JNx3GriMM1Gz0JVJNh8LQzM7tPFy5RYjAruCj8
         K00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768764614; x=1769369414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FE91AlC+Wf3fpDTOpQTd2EcMaLnOUTf8XrrOstYz7Jk=;
        b=daSJnYks9GCmtyKUPmDVgAbVMM1BPLWfMZryZc3j/SKJfkYUyW6SQK+0isndM7qWjZ
         nBYAJPZO7HE1u0NCrHeuuWXMAHLV1dDfhwOMpRWLrxFeBwaKEC1VGoYr//BVFARW9lYe
         jhUI+6AlsG0iWp1Bx3ZnMsTXqXiJ/1zbRt2wKkmY0t9BqmtEduP3cLMekN6qi1CHoS+T
         zE0PYccYV7YriwJB6ab1szg/Q5dyKmIp2R4xjBNCZ7iNlThxgDKFEg4o1TLFm1liXYMG
         6ZF6pEqUCIb+S9dksiLoAgPvnLI6R590K/O4VIOgIml9haoipq5pcid8JF54ezOYBgFP
         3AOw==
X-Forwarded-Encrypted: i=1; AJvYcCU/YLwTc4z8EDtcN/nSJJQmZxIWudTDXTgvBYsI98jYzXtjILh55AtaHLwSrwMf3p1/gFEOwhehh3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1amUDgr03a0rnZb9Q5jEnvO/fg3ZlDZsJBH6nCTNDvcl0KXRB
	6rfanCPNAnUnZI4L3n95Q/EE8DFfuZydZJtq2AcvqbK1U8Y2HrmFEoE/zFJGM+kDdXI=
X-Gm-Gg: AY/fxX5pBmhrKipAj3pIuMVrw3VlQDpQcpI3lkebi477rtSnqqSacyzw4LaHDdK6o0q
	4TylImk8zw7BfWWBtyxhMoOW+kayXsS+sx/CFwdKUwhcX6nxiluhw3cjd0TB3flW4IW3cLFWT5W
	FQN+gtHePi0o8ESqzR3KczbdL5a3Nxs7dMbXU77VNV2S088WUW/NrQugbpREG6VbWR82hw3wn1x
	wFEMfJLbJaECoUbJreKfxQKxGjFxJ+PDqQYt0sOCHsNQ4y9YkiYWyz1Ft87jtC8bMO+W+2yQB3O
	oa1JBCoXrPK0QuJhXgLsLhqmfHzd+AxJ+uPA3NCgFFD/THhzib3RkopdVyBwZBm7ruZLK0Th/vu
	P5JORyPDmsrAr+vl43A/WfI1vtRAyJDo/gz03JpnG+wFrQegdP/LTF9BwFMVDIIU4qNcJWfJumB
	zvWRoNoLXLoqgTDR13jDjTPTB8XT3ina6anRL+018wxgj0Ng9S6jG2aO9QNDWM
X-Received: by 2002:a05:6820:1688:b0:659:9a49:8ed8 with SMTP id 006d021491bc7-66118020948mr3526334eaf.12.1768764613766;
        Sun, 18 Jan 2026 11:30:13 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d542:af69:64b6:f7df? ([2600:8803:e7e4:500:d542:af69:64b6:f7df])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bd5d62csm5629835fac.19.2026.01.18.11.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 11:30:12 -0800 (PST)
Message-ID: <c73935a2-1c71-493e-9504-5ea205169eb7@baylibre.com>
Date: Sun, 18 Jan 2026 13:30:10 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] iio: core: Add cleanup.h support for
 iio_device_claim_*()
To: Kurt Borja <kuurtb@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>,
 Shrikant Raskar <raskar.shree97@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
References: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
 <20260106-lock-impr-v3-4-1db909b192c0@gmail.com>
 <27cf1ec1-545b-4e44-8229-852f8bdae116@baylibre.com>
 <DFRTH0GI1UPO.12NSSABBNSRST@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DFRTH0GI1UPO.12NSSABBNSRST@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/26 9:23 AM, Kurt Borja wrote:
> On Fri Jan 16, 2026 at 5:03 PM -05, David Lechner wrote:
>> On 1/6/26 2:06 AM, Kurt Borja wrote:
>>> Add guard classes for iio_device_claim_*() conditional locks. This will
>>> aid drivers write safer and cleaner code when dealing with some common
>>> patterns.
>>>
>>> These classes are not meant to be used directly by drivers (hence the
>>> __priv__ prefix). Instead, documented wrapper macros are provided to
>>> enforce the use of ACQUIRE() or guard() semantics and avoid the
>>> problematic scoped guard.
>>>
>>> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>>> ---
>>>  include/linux/iio/iio.h | 71 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 71 insertions(+)
>>>
>>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>>> index d8af0456f966..c795f731f2d8 100644
>>> --- a/include/linux/iio/iio.h
>>> +++ b/include/linux/iio/iio.h
>>> @@ -10,6 +10,7 @@
>>>  #include <linux/align.h>
>>>  #include <linux/device.h>
>>>  #include <linux/cdev.h>
>>> +#include <linux/cleanup.h>
>>>  #include <linux/compiler_types.h>
>>>  #include <linux/minmax.h>
>>>  #include <linux/slab.h>
>>> @@ -740,6 +741,76 @@ static inline bool iio_device_try_claim_buffer_mode(struct iio_dev *indio_dev)
>>>   */
>>>  #define iio_device_release_buffer_mode(indio_dev) __iio_dev_mode_unlock(indio_dev)
>>>  
>>> +/*
>>> + * These classes are not meant to be used directly by drivers (hence the
>>> + * __priv__ prefix). Instead, documented wrapper macros are provided bellow to
>>> + * enforce the use of ACQUIRE() or guard() semantics and avoid the problematic
>>> + * scoped guard variants.
>>> + */
>>> +DEFINE_GUARD(__priv__iio_dev_mode_lock, struct iio_dev *,
>>> +	     __iio_dev_mode_lock(_T), __iio_dev_mode_unlock(_T));
>>> +DEFINE_GUARD_COND(__priv__iio_dev_mode_lock, _try_direct,
>>> +		  iio_device_claim_direct(_T));
>>> +
>>> +/**
>>> + * IIO_DEV_ACQUIRE_DIRECT_MODE(_dev, _var) - Tries to acquire the direct mode
>>> + *                                           lock with automatic release
>>
>> I don't think it is usual to put the function parameters in the
>> doc comment like this. They don't match the actual names anyway.
> 
> Hi David,
> 
> This format of kernel-doc applies to function-like macros too [1]. I'll
> match the name of the variables though.

Right. And it has no parameters between the () on the first line
in that documentation.

/*
 * function_name() - Brief description of function.


So it should be just `IIO_DEV_ACQUIRE_DIRECT_MODE() - ...

>
>> + * @dev: IIO device instance
>> + * @claim: Variable identifier to store acquire result
>> + *

The parameters go below like this, which is already correct.


