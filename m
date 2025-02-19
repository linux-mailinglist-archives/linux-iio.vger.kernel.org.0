Return-Path: <linux-iio+bounces-15797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88B9A3C3A2
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 16:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E523BB769
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDD61F4614;
	Wed, 19 Feb 2025 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LO9Qq71V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5C01F5859
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978705; cv=none; b=g9JdrlzqCdr1ZFJosgtyygFvGFSxJn8squl6cs7YGUsLq9QUSMJvbKfzxtSLSe7GuuiRCWsUromAnap3tfRcoXs7yQVmrPJinbuj9XWa3W1c40zGg8LTS6Pfubcq8wuizBuTgX3gCKzik3/ePHLNnUaZ4hVSX5m9NFJ0X86C9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978705; c=relaxed/simple;
	bh=xo9i9YY4VxqZAabx7JlbkZSncYY0CVcTX+lGSBuMNQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fy30D/XYBPKrk1iF0AWpcxDFUd1YVcYgCcRTIFAHeC4SM5Ap6jJFPtMnuAN7kwdI8nrO8Ku9uiGZmf9zf6B8m4Or5RnyQLzfNYqPi2Zbdm7rcX31N+V5FSPKvsmp1TGfKIt/ngnXHD3x0TIcZRoznt88FS/OKRzJxdZ4rUZK1dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LO9Qq71V; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7272dae0604so1308039a34.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 07:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739978701; x=1740583501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+3Ne9a+ljYjLyHYgmxptshkN7EiMBblmyAcH64rom6A=;
        b=LO9Qq71VI7Cmj69ziLlW2BouExlINEpRzoSJcU6J0VXnmRawTQQsDNDPzPTMAFe8o/
         epGfIa35oJybo34L6g9gY+SSbF7kzalFxkWMU904cQ8w2aGSKA+j22bmcGEl498a8Vae
         MCkM8oXXVl9AGjvEqtGScl8tC7Mg0/Is5M39JgHIQ5uOs1p+cOMoJa4Teur+2uPpmKv6
         zlaDyTf9RsfnduHnxVKuAXaWJSmPXbKnMcnp/AXWN0pLvLTCCysmPxjqypH8QKWtYKm5
         FZMU5L6kFbKXlEnP2V3fvcDF3wsCxXMgq4Q+VrMEOI3WWYLO5LKznmI0EaHJKmvMu5wr
         yZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739978701; x=1740583501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3Ne9a+ljYjLyHYgmxptshkN7EiMBblmyAcH64rom6A=;
        b=frXfi1glWXc/cMh+pAvf5X9+No8/q8igSlYgv8o/VsEVtCZnE9x7K+cFbO7Ka6rozn
         54MbrH5+2PBsd8nS7VTeBIDR7JeLFGIaoXKaYUGx/CA0cDCkoRe9vRABUQLfCETQOjJW
         RTANrPShp59w+jnVhUnV2SFFIgEIxjq/tPAr4gyQO1XuPs9SRPSJetxF/RrHUIioRoN/
         S0gw9cRs8Zw/lOSTjnBq21uOZlPUErcpDKunxhqk53JEqnzq+AqYj6G8rjbkYbeP61GQ
         +ockreKzTsKCEif2s9gr/wnYkVwdUnC1R1BkBbrUVS9QSOYumE5tuHIG5IjE6fD5iZqc
         ZYqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKIUZp1leLCsDx3XDRot9C0RjuvUyJHChHNa4pWncnSoW2R9BmwHPmQY0tEjWHAtCyfYaYkpnPw7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0mklMUAbWe/Hnu+IRyBfPc99zjShDwJ/qnjc3nEr5caw9qH4v
	llQjdCAZfUueL4wkbIncPMQQSPQaXtQenrqnif7GxzbtkXj39zKP+BGQyj7BJg0=
X-Gm-Gg: ASbGncsRBDIYr5NBIhOv72y8QmhRNgx5A7G1H1Ne0LcFl5Z5JeS/TcVDtBvl1feJ1Fo
	E0OQUhhN1++wkV6fD2IzBZJ7FxnYEgfBV8d+xwL9cSY6qi5sMrXNqNas7g+iN6NEOUBMCKlsat7
	tP56zbxG3+sYa61ZQ27Zl4Ecmd62/jelTlYPxFEFdh3MsJORgY96mU4wCmkyKvha06Xi51HP4LR
	sxRjeatKbkE3CEm69sKANTfT7PL89nweGfwFva7s52qvk3ugYN/RZewPmAjX4vCPkrKJ+48WuRt
	omS/+hmB0DPSy4/GL0yBp+QBvOR+VNacgFw0Kfz1eAxd1oo8UijP
X-Google-Smtp-Source: AGHT+IHOQx18U1f2UiEOhCr5xhouAZgxDGO55YUlpjKxU/k/FZoke46S04y9CU87l50vqPHgTMJtVg==
X-Received: by 2002:a05:6830:648e:b0:727:f9a:8ae8 with SMTP id 46e09a7af769-7271202a4c8mr11863856a34.3.1739978701466;
        Wed, 19 Feb 2025 07:25:01 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72733eb6951sm903498a34.7.2025.02.19.07.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 07:25:01 -0800 (PST)
Message-ID: <2ad4ca67-5a70-4b7b-b744-d9bd92ce386a@baylibre.com>
Date: Wed, 19 Feb 2025 09:25:00 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] iio: accel: kx022a: Switch to sparse friendly
 iio_device_claim/release_direct()
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250217140135.896574-1-jic23@kernel.org>
 <20250217140135.896574-6-jic23@kernel.org>
 <0e17116e-6160-4920-83d9-086218245299@gmail.com>
 <85d97cbe-9d34-462c-a89f-de6fc1ac6e34@baylibre.com>
 <ead33fc6-48b9-488c-8993-2ca647e59735@gmail.com>
 <df700bd7c8d3aab89177b122ed9adf0269bde62d.camel@gmail.com>
 <ade6ee75-7f38-4826-9359-2411165decb5@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ade6ee75-7f38-4826-9359-2411165decb5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/19/25 6:21 AM, Matti Vaittinen wrote:
> On 19/02/2025 12:51, Nuno Sá wrote:
>> On Wed, 2025-02-19 at 07:36 +0200, Matti Vaittinen wrote:
>>> On 18/02/2025 17:42, David Lechner wrote:
>>>> On 2/18/25 1:39 AM, Matti Vaittinen wrote:
>>>>> On 17/02/2025 16:01, Jonathan Cameron wrote:
>>>>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>>
>>>>>> These new functions allow sparse to find failures to release
>>>>>> direct mode reducing chances of bugs over the claim_direct_mode()
>>>>>> functions that are deprecated.
>>>>>>
>>>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>>> ---
>>>>>>     drivers/iio/accel/kionix-kx022a.c | 14 ++++++--------
>>>>>>     1 file changed, 6 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iio/accel/kionix-kx022a.c
>>>>>> b/drivers/iio/accel/kionix-kx022a.c
>>>>>> index 727e007c5fc1..07dcf5f0599f 100644
>>>>>> --- a/drivers/iio/accel/kionix-kx022a.c
>>>>>> +++ b/drivers/iio/accel/kionix-kx022a.c
>>>>>> @@ -577,13 +577,12 @@ static int kx022a_write_raw(struct iio_dev *idev,
>>>>>>          * issues if users trust the watermark to be reached within known
>>>>>>          * time-limit).
>>>>>>          */
>>>>>> -    ret = iio_device_claim_direct_mode(idev);
>>>>>> -    if (ret)
>>>>>> -        return ret;
>>>>>> +    if (!iio_device_claim_direct(idev))
>>>>>> +        return -EBUSY;
>>>>>
>>>>> Not really in the scope of this review - but in my opinion the logic of
>>>>> this check is terribly counter intuitive. I mean,
>>>>>
>>>>>> +    if (iio_device_claim_direct(idev))
>>>>>> +        return -EBUSY;
>>>>
>>>> I'm curious how you read this then. I read this as:
>>>>
>>>> "If claiming direct mode succeeded, then return an error!"
>>>
>>> I am used to seeing a pattern where function returning zero indicates a
>>> success. I have no statistics but I believe this is true for a vast
>>> majority of functions in the kernel. I believe this was the case with
>>> the old 'iio_device_claim_direct_mode(idev)' too.
>>>
>>
>> Fair enough... Note though this is returning a boolean where true makes total
>> sense for the "good" case. I do agree it's not super clear just by reading the
>> code that the API is supposed to return a boolean.
> 
> Exactly. Just seeing the call in code was not obvious to me. It required finding the prototype to understand what happens.
> 
> Anyways, I guess this discussion is out of the scope of this patch and if no one else sees this important enough to go and change the iio_device_claim_direct() - then I am fine with this patch. So, with a bit of teeth grinding:
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Yours,
>   -- Matti
> 
> 

Would a name like iio_device_try_claim_direct_mode() make it more
obvious that it returned a bool instead of int?

