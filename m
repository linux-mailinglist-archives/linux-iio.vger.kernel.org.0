Return-Path: <linux-iio+bounces-15734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B42A3A19B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 16:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787E43A4E6A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DAE26D5D1;
	Tue, 18 Feb 2025 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0FtkOQ5F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0879326B2B2
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893367; cv=none; b=TldwzJmlegUiBy6EOPwmAl1CMDchLFnomgayeNKvBbszgCSW74IcvXov53RYZxH4dtv+xcFT8zWC6eYo8/8DmRVST7sPJtFVTPxDaUoR3BNuS1qLTevwv9TyaxQrElNAXZTGxvksW4GkU6MF30GZ1g+IQv0QdC0Nja+HL4rzwB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893367; c=relaxed/simple;
	bh=3AheCHxnoDLe8c98koL1FU4ulfJ/LahkwdXKC7b8T+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdeMuUKZ/9YOrlz/ylVhu2z/IQZhrScK7goL9a7UOKWchJHHF11GDC1YeyKWiobuDK6PLULJwzLX0JVohE0g9KEalLN7v5erQemmcgHUyXNdRLHQ1VHF0xhLxyko6BVOyt0SoI0Eyw8Q4wI4RgOnzBsgL/szU216wMpToX1JiaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0FtkOQ5F; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2a01bcd0143so4732802fac.2
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 07:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739893363; x=1740498163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vo8msz3q+I/6zug0xX5BSD3ZniYfXtD7Qj9ihxJnGJg=;
        b=0FtkOQ5F4st4Bw+AF5oNpBgxGY8gIq0OPMKUsgotLtskUS4xx/Csoz0WzwaOfIGkt1
         hKoxtYuXKFb161CBSEkUYcK9A1/j5pllqpOE4jC/h690AWiLOj9xgtHwi9oOKPwgVpRA
         4pqS+1GvbwpnkqD7hpyNlQsFXCVFOiM9kVFLUHz3livaACDkS6X1knWITVAb2YRSJ4oW
         Eb4wPI22e0IjfN8VAWCtuamF1gIDUA6sWKjYe4Y5X0pKhP/lpsbB6hGSq8TvXO9Gjt9l
         NziwMnW9rCFCD1vUFd3q6/6H6iFC7e5Ien2b6D6u6qHKjSUIKfwLQ9DvOnNcbHUI02Fv
         QGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739893363; x=1740498163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vo8msz3q+I/6zug0xX5BSD3ZniYfXtD7Qj9ihxJnGJg=;
        b=LuFeLSnztcBEIMWCyGnx6ZkMvBk30BEt1ADWl9j0v2uFrj9KHoBKSG+VFoabUFvnIJ
         kC7N45p+VY8TsGu0nsoAOp9wiLk0UVGiaRvFVK16HODB3iTcj4CDOxYbId5olaeWhwZk
         WCCTjGY4gUZLpHHIxI10q/ZPfNZTjz07dipcUX+6EWkWcci2XnDn2SoceA3PwqogwdDj
         Uo33AFZGF2gXFrPugydaR4RP58L7sHW304j8HQexHA3FzxMVBtTnFx/tSBppqKj+7rTJ
         X24xL3t9FC3M/lZY5XQ9CWEAPwlx7SLYh4mDD8n6m/BsNlS5r8x5SUqD51w5hxYVioBK
         mCUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqPPsvHg+z190vQ0HppN7fzouSfrpt9JoGyVoAjEGzl8bMjBKt4psSsJ/GpoadHefLjJ+ZnrPva/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXoqVg2HBfbU9bROK68yznJXqqWhY7kBFqgx0+hzb9MDqL7pRn
	TOuprbY0XA4Tefjx3trMqnRigVn78FMntlNeoRpp57ubKRtNV4VHYmJUwNaaWU0=
X-Gm-Gg: ASbGnctUr8RvB91xSgTDZEMNNRgTiSlaQK7liydwZhfeJOjRiUPIIDp2tWF5DJXBkMs
	x5EauZHoHMNdfVQ8ZaFkJfV2DNGAqUL202oLjIpISCI/rzMYpjVMWp0LsRBkv7srgPUX22avGMU
	kK879UmSuhGoCWug4/4dgQ+5nfKi2TIF+8MSyx8YbUpFVA5bOZFRBYw2FTl+7mNUt88OOUDRB0w
	DLjgAXH0HmMxVvOLGwx67gLElLQpZTUyp/EXMQvo/y2sO087wGTxRxe2ouLo/JUCxGTVyeZdENg
	PX63F+vNj4DVSp2P0FAGxZqbA4c70zJSCPmZFVfyMsC6Fzy8QZpu
X-Google-Smtp-Source: AGHT+IHue+rgd4TxGJkBjOJcQLKteB+D8JrBjg1KnR4tb/SlkaPZ66hwzTjEt2j6DFttHRWxHXgpew==
X-Received: by 2002:a05:6870:331e:b0:2bc:9175:670f with SMTP id 586e51a60fabf-2bd101e9f13mr53646fac.15.1739893363001;
        Tue, 18 Feb 2025 07:42:43 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b954875e0esm4976970fac.14.2025.02.18.07.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 07:42:41 -0800 (PST)
Message-ID: <85d97cbe-9d34-462c-a89f-de6fc1ac6e34@baylibre.com>
Date: Tue, 18 Feb 2025 09:42:39 -0600
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
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250217140135.896574-1-jic23@kernel.org>
 <20250217140135.896574-6-jic23@kernel.org>
 <0e17116e-6160-4920-83d9-086218245299@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <0e17116e-6160-4920-83d9-086218245299@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/18/25 1:39 AM, Matti Vaittinen wrote:
> On 17/02/2025 16:01, Jonathan Cameron wrote:
>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> These new functions allow sparse to find failures to release
>> direct mode reducing chances of bugs over the claim_direct_mode()
>> functions that are deprecated.
>>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>>   drivers/iio/accel/kionix-kx022a.c | 14 ++++++--------
>>   1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
>> index 727e007c5fc1..07dcf5f0599f 100644
>> --- a/drivers/iio/accel/kionix-kx022a.c
>> +++ b/drivers/iio/accel/kionix-kx022a.c
>> @@ -577,13 +577,12 @@ static int kx022a_write_raw(struct iio_dev *idev,
>>        * issues if users trust the watermark to be reached within known
>>        * time-limit).
>>        */
>> -    ret = iio_device_claim_direct_mode(idev);
>> -    if (ret)
>> -        return ret;
>> +    if (!iio_device_claim_direct(idev))
>> +        return -EBUSY;
> 
> Not really in the scope of this review - but in my opinion the logic of this check is terribly counter intuitive. I mean,
> 
>> +    if (iio_device_claim_direct(idev))
>> +        return -EBUSY;

I'm curious how you read this then. I read this as:

"If claiming direct mode succeeded, then return an error!"

Returning an error on success seem very counterintuitive to me.
And the way Jonathan implemented it seems the logical way to do it.

"If claiming direct mode did not succeed, then return an error."

> 
> would feel much more familiar. I actually had to look up the implementation of the iio_device_claim_direct() to see this was not a bug.
> 
> Other than that this looks very good to me.
> 
> Yours,
>     -- Matti


