Return-Path: <linux-iio+bounces-13666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBD89F80E6
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 18:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75548188D6DD
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CF91922F1;
	Thu, 19 Dec 2024 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OEsMnqxt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5419995D
	for <linux-iio@vger.kernel.org>; Thu, 19 Dec 2024 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627675; cv=none; b=DQ4DWqiTLFBrveP42TewqcyRUmdQYWmm4gOX23cWUsUzwLuurBGB9Ix8thHHDA0vxYCruhUFEY11WIcPd1UMQ6OrwZ4O2jf72UX/of6cieqEH9QHFUMkbXWq5l9wMy2cSdx/kLRT8dNRcNZ/es6pFWmts7nybDEXAXOKZUFnoOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627675; c=relaxed/simple;
	bh=AjD83FY3s3Rg+H6CFlU1E099C6Oj3p5cQP9EQB4oZqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJ2ppBTBDGOAhEFijVuh+MR/dzut9wmkNJQVtH3y82+z2eCBmDX19Ocsz3tuxtApMVREa07pMwzhBrLs5Xm4TdD6PdmsGMDzel1x5fu8jmsp98PrpRP3TMSibXJfGotyPAJfpe884LizJ0Ls8ZlZTlncZFRl11HSRkCyGGj6FvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OEsMnqxt; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eb8db8ae9aso404053b6e.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Dec 2024 09:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734627672; x=1735232472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=seYCbwhuufp+j/ujr+9eXs0TRXFJTNhViK8/tEkc+8o=;
        b=OEsMnqxtXhfznZZr+79B7S3mLu6S5rttIS0Ikxnoanfp3Txo+05Cl82CpZJRkztQ5m
         JvJEK/F/Ihv1KZa80iTc31K166WUsa3G6IJvbd3rkDE5oVR6VJE8avdyAB5ATsEHTaNi
         YeqVcnKv9j4KeEXFItthk22BQ2jZyZLqDdqkRtSZL0LOcvPoSO/hGjasKSY6eGHugsPZ
         jIDAP+4+LdpNy/gSS0Mef3KHZOKwfDnuwoY5YP7TcBy94IVWmZ/0B/cGm/Iljre6Mqix
         MsB11n3aZR4xCS6mNoRBAeZsv8D5QieRyhivO9UGFTGVVEoGcxPzx0x3g7k2GdVCOi5s
         lS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734627672; x=1735232472;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seYCbwhuufp+j/ujr+9eXs0TRXFJTNhViK8/tEkc+8o=;
        b=LXKP5NJCcvT+tvjBUebwJgSEKTrS2h2kJg5HMuQzCstS0KqeXysAsde2LKPl2hDevT
         amZQr/ZdMtLbKoN3OegTBztqOMn74lngjNYyRr2c4jkflv+QndhKbFzOX8WHwUo6RaG8
         +ObfYnfKk9PWIBfQu+N4/ugrogBB7nsSduV6QNjiqOkv1VNJp39PqD/SOpNh/yZppDTt
         FZFx0/KoZ1e+OQI/giaM8fvutSDAu39/W8a1cFYGnXbkvYBr9/QSz7eScV4BBUydnCgr
         5mZa3NWy+d6M+joAK+SiP01pMB8r0pLmcte9G7legAvu6zZ385bXBof3aHntMY4pUfqo
         wHYw==
X-Forwarded-Encrypted: i=1; AJvYcCUldCvTH1MUgNI+2dtknkNcrBByu3QFIuWLJHoKkrNfI/rv/F+EmF9Xf6+Mzm42t9/w8HgVu9c20rM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2UT1iII6Rb2hhqcZD3PhbEkGQJwZ81x89JJVZOrLi6WZQ4sRv
	hBZilOsLtnPY3NZTUQe6mS3f9c9fAn6Fl/xW7wFXtKlIyiv5ne+RtJG/Yt1I/ZU=
X-Gm-Gg: ASbGnctdTFIralRkBlat6lI0HpVA9EYvjjMdYDgguW2GF+IvJ6pXNtwRE1xf+k/GgE3
	6pV8ZlgzXgMa3eNzQ21dJshRZpr5dXnXrvDrmIP5TQjuis+aW1EMa43+2gEENzoNpyhC4/5cHEv
	Z/fKfvpJBOgSF0mL0weEtF3jONpT8SpymxCo8+YDeTv3EZ2JA8Y7r8IswZ8f1APz006lHiVwEkl
	JdirC8FOoYpHT98SDGnkAHkj34f8a8m8rOybh5tZq5PXO2cpjN+V+WnX6sN/C3+FO5rG/Y5cOYV
	+i2Si1Hbj+5nmhc6bw==
X-Google-Smtp-Source: AGHT+IHi7ROK/EahnwH9KRaMB4O8IDicD5PQVxVMLATyDKK3nBcXD13N27MeWFm2M+6hvaxA3e43pg==
X-Received: by 2002:a05:6870:4786:b0:29f:c5f3:a827 with SMTP id 586e51a60fabf-2a7b32d1f65mr4039034fac.35.1734627671925;
        Thu, 19 Dec 2024 09:01:11 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d74c68e5sm391020fac.20.2024.12.19.09.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 09:01:11 -0800 (PST)
Message-ID: <94efa413-5fa9-4014-86c2-331442e9d42e@baylibre.com>
Date: Thu, 19 Dec 2024 11:01:09 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] iio: backend: add API for interface configuration
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Antoniu Miclaus <antoniu.miclaus@analog.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
 <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-4-856ff71fc930@baylibre.com>
 <b5a773858a71e6929667fc73b9384908ca3ff313.camel@gmail.com>
 <20241219164233.087ff9cb@jic23-huawei> <20241219165115.23717a71@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20241219165115.23717a71@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/19/24 10:51 AM, Jonathan Cameron wrote:
> On Thu, 19 Dec 2024 16:42:33 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Tue, 17 Dec 2024 11:13:59 +0100
>> Nuno Sá <noname.nuno@gmail.com> wrote:
>>
>>> On Mon, 2024-12-16 at 21:36 +0100, Angelo Dureghello wrote:  
>>>> From: Antoniu Miclaus <antoniu.miclaus@analog.com>
>>>>
>>>> Add backend support for setting and getting the interface type
>>>> in use.
>>>>
>>>> Link:
>>>> https://lore.kernel.org/linux-iio/20241129153546.63584-1-antoniu.miclaus@analog.com/T/#m6d86939078d780512824f1540145aade38b0990b
>>>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>>>> Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
>>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>>>> ---
>>>> This patch has been picked up from the Antoniu patchset
>>>> still not accepted, and extended with the interface setter,
>>>> fixing also namespace names to be between quotation marks.
>>>> ---
>>>>  drivers/iio/industrialio-backend.c | 42
>>>> ++++++++++++++++++++++++++++++++++++++
>>>>  include/linux/iio/backend.h        | 19 +++++++++++++++++
>>>>  2 files changed, 61 insertions(+)
>>>>
>>>> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-
>>>> backend.c
>>>> index 363281272035..6edc3e685f6a 100644
>>>> --- a/drivers/iio/industrialio-backend.c
>>>> +++ b/drivers/iio/industrialio-backend.c
>>>> @@ -636,6 +636,48 @@ ssize_t iio_backend_ext_info_set(struct iio_dev
>>>> *indio_dev, uintptr_t private,
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, "IIO_BACKEND");
>>>>  
>>>> +/**
>>>> + * iio_backend_interface_type_get - get the interface type used.
>>>> + * @back: Backend device
>>>> + * @type: Interface type
>>>> + *
>>>> + * RETURNS:
>>>> + * 0 on success, negative error number on failure.
>>>> + */
>>>> +int iio_backend_interface_type_get(struct iio_backend *back,
>>>> +				   enum iio_backend_interface_type *type)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = iio_backend_op_call(back, interface_type_get, type);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (*type >= IIO_BACKEND_INTERFACE_MAX)
>>>> +		return -EINVAL;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, "IIO_BACKEND");
>>>> +
>>>> +/**
>>>> + * iio_backend_interface_type_set - set the interface type used.
>>>> + * @back: Backend device
>>>> + * @type: Interface type
>>>> + *
>>>> + * RETURNS:
>>>> + * 0 on success, negative error number on failure.
>>>> + */
>>>> +int iio_backend_interface_type_set(struct iio_backend *back,
>>>> +				   enum iio_backend_interface_type type)
>>>> +{
>>>> +	if (type >= IIO_BACKEND_INTERFACE_MAX)
>>>> +		return -EINVAL;
>>>> +
>>>> +	return  iio_backend_op_call(back, interface_type_set, type);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_set, "IIO_BACKEND");
>>>> +
>>>>  /**
>>>>   * iio_backend_extend_chan_spec - Extend an IIO channel
>>>>   * @back: Backend device
>>>> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
>>>> index 10be00f3b120..2b7221099d8c 100644
>>>> --- a/include/linux/iio/backend.h
>>>> +++ b/include/linux/iio/backend.h
>>>> @@ -70,6 +70,15 @@ enum iio_backend_sample_trigger {
>>>>  	IIO_BACKEND_SAMPLE_TRIGGER_MAX
>>>>  };
>>>>  
>>>> +enum iio_backend_interface_type {
>>>> +	IIO_BACKEND_INTERFACE_SERIAL_LVDS,
>>>> +	IIO_BACKEND_INTERFACE_SERIAL_CMOS,    
>>>
>>> The above are apparently not used in the next patch so I would not add them now.  
>>>> +	IIO_BACKEND_INTERFACE_SERIAL_SPI,
>>>> +	IIO_BACKEND_INTERFACE_SERIAL_DSPI,
>>>> +	IIO_BACKEND_INTERFACE_SERIAL_QSPI,    
>>>
>>> I'll throw my 2 cents but it would be nice to have more feedback on this. I'm
>>> not completely sure about the xSPI stuff in here. We treated the QSPI as a bus
>>> both for control and data in which we also add child devices. And we've been
>>> adding specific bus operations/configurations through the 'struct
>>> ad3552r_hs_platform_data' interface. So, I'm wondering if this should also not
>>> be set through that interface?  
>>
>> Maybe - kind of hard to tell until we actually have code.
>> I'd go for kicking them into the long grass for now if they aren't used and
>> just dropping them from this patch.  If we ever need them,easy to bring back
>> and then we should have a justification for why!
> 
> oops. Misread. Obviously Nuno was saying the ones above aren't used, not the
> SPI ones...  I don't feel strongly either way on setting these via
> this generic interface, or via the other path.
> 
> Jonathan
> 
>>
>> J
>>
>>
>>>
>>> LVDS/CMOS still looks slightly different to me...
>>>
>>> - Nuno Sá
>>>
>>>
>>>   
>>
>>
> 

I'm the one that suggested doing it this way to Angelo, so I'll chime in
with my thinking. In Angelo's previous series where we added IIO backend
support for this family of chips, in the devicetree discussion, we
considered the possibility of two SPI controllers, one for register
access and one for the high-speed streaming provided by the backend.
Since the dual and quad SPI here is for IIO backend (the high-speed sample
data interface) is what made me think we should put the control here rather
than putting it in the platform data interface.

Since this is new HDL, maybe we could avoid this issue altogether and
tweak the implementation in the FPGA a bit. Clearly we had the AD3552R
working without needing to poke this registers, so why can't we do the
same for the new chip? In other words, make these things a compile time
option in the HDL rather than a runtime option?

