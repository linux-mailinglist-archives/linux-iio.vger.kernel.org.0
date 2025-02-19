Return-Path: <linux-iio+bounces-15776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9A1A3BDEE
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 13:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C0B3A7324
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3067A1DE89D;
	Wed, 19 Feb 2025 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k41tPrcH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0763286281
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967719; cv=none; b=URuo0X8YL8oWo0hCMA7skz04DBxZrXGd9v6I7npavdmjuH2JJUKSLoDsKcWTQ7Z8RawVbS8HeD2zKu29biXfybA3fxvmplJHQj+aYQ9ECfHesBoaei5NXdVPZBf0Jzt4fUjN8xsytvOcuuSsSfh/PTnp8gXLv28JMzFseTk84bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967719; c=relaxed/simple;
	bh=/d9zwL0BBsxcbH9d5WImhGsgPCtGFg4IJ9A30RtWzZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6Zuc1JKKH+Crl+9qhBCq4VbAFbzHLhvRSp4TWM8rfF+8CcuvgMqrBdbhwFRWS5/KD1SLnkkIWBTjXMXoJTMnKj8sDPyOhyO6mguVFFTnEWfycNf10xIwQ6YY+gtw+4rN8aR3v3XI9ylTUz7JyTVp4JC9mk8UkZlRQACfRFRkUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k41tPrcH; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-543d8badc30so7714442e87.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 04:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739967715; x=1740572515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IZXN/XeTXrAjCIb8aQjWNB+0k/DyfnZ34w7lywCbUs=;
        b=k41tPrcH3nnb4e5FCztJRBilnI1qsZw72j2ldWQ4qSKEXKByD5mCFUJt3QTxq09eZM
         iQZ1nophUXePQtFMxUppksdAlG0sseMf8wNAuFvPDJe1ZieGmNjXhCaokgNrS07nwWeS
         ulwOgBLHSNIJXFINO2hkpM+cBs0IFR1qnCRwn9Zxc7XA84HtGQLzDeEEkdzuDunJpcHG
         HnNom4PZVIu4W+a4xITPw0I3qIVgkrgmyoXdw38qEVfLVmHkEv9QjgNXMHhnKBTDarZb
         VvXeWZoRkrLm5+5h6uREgy7XjRwdFvf9JYCRpbs2saMtU8DfMDdzWOOHm4e1n+p87LCd
         RRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739967715; x=1740572515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IZXN/XeTXrAjCIb8aQjWNB+0k/DyfnZ34w7lywCbUs=;
        b=AiMcX4eLtiOxb9b0i4JhbkzPFlgrBLk5VEJuKS7W+Pw0+dLTExxGwGQ0ClIVYTMQjZ
         m557+5kEcvstuEqRQ+zEirWFyZ3FdNDMzfKl3qQf73B4Sd4trYk3l/SfYXi/Utpl82Eg
         yIFa3ltrxnuqQWyHgEfRYlqxsfuaddcDkn41N8AuVUOoy0l9ogr+E/htYhtcbTsS7HlH
         WC0KHTEmIdMoX4E9Vm/a/rfMdmHOW+zXFeCzwRfy3NqoyaK0KT0V1uBJSaKjrjb8m+Eg
         uZd24Jpttt66/eLh4rcjXPRS0n8dE1q7AAv6CwWlOxZ6f3UtWkQry/0GUo22FKOyjPxi
         7V1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQf6cy7xcFF8wVSxwYfxTFQ0eM3XOc76MbUsaqFj6TWIinHdkjvhktUo5xAfKLV+T2Vj5YlgLoM7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrDw/HgZAZS6l0lKbk/oRKYQPuqdNnwXvodAdlARSPsjS1fQhn
	1VOs4i+TbteFFe94s6aER48eLef3qoHFqUjs2kFPTokdgMZ0ie/I
X-Gm-Gg: ASbGncvpyfx33a7AQhfKM15C+DcUW2w+hQ/1QgLDUkl3lgtqovZ+8QOXq0XSRICgxEF
	UZGSxbgdmX35dTkqCVDkEQ2da7RY2Xv/lMUsMaFKM86Yjb8CaAxq1sNdPTRP9q7bppDbF9y5i2Y
	PsZu05NrXBHdTZ7r4IXe7gOJwlEqx+Oj6SGnxgOFKb74blQPFOlcyXuinvE6V0OqWp9/QLAMPnm
	zrSrsqJrUrIqMXoq/6fzLKTVUU6dYmpWBGcnC9q2aJOn2fYSoLxREAKVYHmzepSwSCbS8wJlL0Y
	oe6HNGG0/1ggCvUMcVBQd+kM/iW8/Au4vCQIfOupI5mG8uf39BpnAHHwxDhxo1ZN2EbO0i+U
X-Google-Smtp-Source: AGHT+IHClgWE7d9RQg/YjTw3fZgzOFSK1Oe4+IQ5nNgK+WCeZXSuJ6HtQqhhjsVherdkf0ZkvvBHqw==
X-Received: by 2002:a05:6512:3b9c:b0:540:2542:d89a with SMTP id 2adb3069b0e04-5452fe94d39mr5913899e87.52.1739967714428;
        Wed, 19 Feb 2025 04:21:54 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452c855259sm1739626e87.242.2025.02.19.04.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 04:21:52 -0800 (PST)
Message-ID: <ade6ee75-7f38-4826-9359-2411165decb5@gmail.com>
Date: Wed, 19 Feb 2025 14:21:51 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] iio: accel: kx022a: Switch to sparse friendly
 iio_device_claim/release_direct()
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250217140135.896574-1-jic23@kernel.org>
 <20250217140135.896574-6-jic23@kernel.org>
 <0e17116e-6160-4920-83d9-086218245299@gmail.com>
 <85d97cbe-9d34-462c-a89f-de6fc1ac6e34@baylibre.com>
 <ead33fc6-48b9-488c-8993-2ca647e59735@gmail.com>
 <df700bd7c8d3aab89177b122ed9adf0269bde62d.camel@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <df700bd7c8d3aab89177b122ed9adf0269bde62d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/02/2025 12:51, Nuno Sá wrote:
> On Wed, 2025-02-19 at 07:36 +0200, Matti Vaittinen wrote:
>> On 18/02/2025 17:42, David Lechner wrote:
>>> On 2/18/25 1:39 AM, Matti Vaittinen wrote:
>>>> On 17/02/2025 16:01, Jonathan Cameron wrote:
>>>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>
>>>>> These new functions allow sparse to find failures to release
>>>>> direct mode reducing chances of bugs over the claim_direct_mode()
>>>>> functions that are deprecated.
>>>>>
>>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>> ---
>>>>>     drivers/iio/accel/kionix-kx022a.c | 14 ++++++--------
>>>>>     1 file changed, 6 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/accel/kionix-kx022a.c
>>>>> b/drivers/iio/accel/kionix-kx022a.c
>>>>> index 727e007c5fc1..07dcf5f0599f 100644
>>>>> --- a/drivers/iio/accel/kionix-kx022a.c
>>>>> +++ b/drivers/iio/accel/kionix-kx022a.c
>>>>> @@ -577,13 +577,12 @@ static int kx022a_write_raw(struct iio_dev *idev,
>>>>>          * issues if users trust the watermark to be reached within known
>>>>>          * time-limit).
>>>>>          */
>>>>> -    ret = iio_device_claim_direct_mode(idev);
>>>>> -    if (ret)
>>>>> -        return ret;
>>>>> +    if (!iio_device_claim_direct(idev))
>>>>> +        return -EBUSY;
>>>>
>>>> Not really in the scope of this review - but in my opinion the logic of
>>>> this check is terribly counter intuitive. I mean,
>>>>
>>>>> +    if (iio_device_claim_direct(idev))
>>>>> +        return -EBUSY;
>>>
>>> I'm curious how you read this then. I read this as:
>>>
>>> "If claiming direct mode succeeded, then return an error!"
>>
>> I am used to seeing a pattern where function returning zero indicates a
>> success. I have no statistics but I believe this is true for a vast
>> majority of functions in the kernel. I believe this was the case with
>> the old 'iio_device_claim_direct_mode(idev)' too.
>>
> 
> Fair enough... Note though this is returning a boolean where true makes total
> sense for the "good" case. I do agree it's not super clear just by reading the
> code that the API is supposed to return a boolean.

Exactly. Just seeing the call in code was not obvious to me. It required 
finding the prototype to understand what happens.

Anyways, I guess this discussion is out of the scope of this patch and 
if no one else sees this important enough to go and change the 
iio_device_claim_direct() - then I am fine with this patch. So, with a 
bit of teeth grinding:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
   -- Matti



