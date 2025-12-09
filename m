Return-Path: <linux-iio+bounces-26976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE03CB0AA7
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 18:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C37B8301CBBF
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 17:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C842329C75;
	Tue,  9 Dec 2025 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z7zrM7qJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D2A329C7E
	for <linux-iio@vger.kernel.org>; Tue,  9 Dec 2025 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765299927; cv=none; b=EkbYLjF5joC59l/NMzlodINlK9Ijdf6roQKO+8MQCAZvnTq7dIBXqc9wPd4RGHXureifK4Cora+tPkWm+37Rz0nDXBHzIjnGFUs2DmU3whnRDJvmKL3/4FRPUp2kdLqrytDWkJKgB1uPxcArK1MuKzdXoxh9/A3Q3u32yWsCI/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765299927; c=relaxed/simple;
	bh=djwV1YPqHJRmfMBqb2pv7M2B8bAh/V9aaC8VS4CE0eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWN7tJ8xfCKxCU+XcSyBeFZ2kybXR4ItLZE9s8U/8LVEC6nWByN5oIk6YCvlOK7Rkb8e0ugRGmqeWOW96DUA3WvMbe8IVhphTL1NbYigplqAt9tYb7t/QU3UnRaJqF1fpOGhNVVMzNP+Q8L+inzeNgpKWfkJWl+r9DZMbH7YXew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z7zrM7qJ; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c77fc7c11bso24609a34.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Dec 2025 09:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765299925; x=1765904725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4n56/mm+y5lEIPHBvAL6dNtszRve9ILxt5EMAL7gg8=;
        b=z7zrM7qJ8sXuoRlLGJ07uvlVq6I/btvkDv1GNSKG5iSTw5HdxXwQFkfjCCR8C7eGGX
         Vtbpa2518QxoTiqVcC1FqAWLmFOsPvZCdIDDZCe4gx321Th19vyQm1HRO+hRqMyKNBPP
         0zxQt2kSuV78jv/NAbvQLumEtR+AQK/M59pcarISck9UsL5jR5KXJidiAOaNRIuCbOCx
         Q0A+QgYh/piRDHU+NLxhGnoR5GyJngcIa2l+zZBO/t5qYrxiWTqWkDh/LHSsLtBjlf21
         NAR5ZL7EyLmBhMkp0mg1iIbwpbIH6uPHR/Q9ygQEUPe+VcDeWhhwkebizPl1dxX1RQpy
         mIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765299925; x=1765904725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4n56/mm+y5lEIPHBvAL6dNtszRve9ILxt5EMAL7gg8=;
        b=WE1y8Xnby7UDQMqARb5pYcGXLJ9ifJojpszvXgySvvh0n8yEPLW1LyOPU4rf/aux05
         YLMwXU9Aaq/quDFUk00OMifBPYSXmi8SMJ/+zOapCqfxALFDnQXJPw0nuAEP6I58dvQI
         s8KA3CByWgvMUK4g1FyOuv/mVH0FHGOaQ3/zqF/YoKCE729Xcm6a3R9A+ijOegg7Dk9e
         /xoZy7BOG0uKWuMr/v9OF2HGr3rABG8JSaZDZMPPSYuYx8YmQBcvA4wMvyQ8Ko9D2+Th
         r3Lso9Y08CRd66jNtedZfhPk5WXcjsSbrIoOpijNCXNkKdcefKCAUk6fc+N0fK33xpC+
         phCg==
X-Forwarded-Encrypted: i=1; AJvYcCVxF87eg2QqLBc+ALMx6o/cYpoYKdpL8mpyW6JWMskTlTav3CI76BSQUWj/pvdShSDiRYqV+mfNggE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZb0G68ORFPD1Gys5SAEeZ/3+BEIdaaD4+Ar9EoOwa11zY+m3F
	y/nO6keGVhl39FyQtBlctuidQTapLlzz2+Jmew/+zzGZUCOzdVNymJpssstJq8ldLGw=
X-Gm-Gg: ASbGncu+tu4pxWLdECRW4ZlVStsOTXj0ZT25rg/Br08UNk3LJCUoy+Fkvgy5faQ949J
	paM6eZbtbdJbrfdPfynkACGjDWN+JTm2fuEuHlLYubqO1tRer4ymsxzf+g9aZGxYOhU/da+KD/4
	aSJ1eJ2EyXussUaUk6uP5L4sPrfoUIlvI0+AVybPrn4LNbrh0kOq9dVTv6fjWBdHuknulwRwdre
	eqqjtAVjUyeGiIB29hZUUf/x8uz/9yCNBy3TWhLDGcWXj6Rqw1yUMkm2Myqv9dUo53zS4/t1i+h
	ByuOU96IvzHUTv1EOjAk+G/0fdyQ2PEKNRggVJX69JfZdM9rrySjIxnEDIhgtqcWFnSVS6RCOJn
	tA3d3obA1TSIeXNI1OwGJnLmMbIMJJ3C+hqXFNi9XiBxm5PCgFnveBUWuEsblQsIBm4UIDDKYeP
	r96GS3mSWxqI19HsC7S8NfYwlLb1E2Sx1KhnpuA3taIW6jCNgQaUqtaQF9UTMd
X-Google-Smtp-Source: AGHT+IHciYLjfEru5jIntKmz+IlcCYn208iA7CXd8tNMDSBw5mXO3tJHz1jntfIlpMhCeSxWYUZMIg==
X-Received: by 2002:a05:6830:6e85:b0:7c7:6a56:cfb5 with SMTP id 46e09a7af769-7cac65f16f5mr870582a34.11.1765299924620;
        Tue, 09 Dec 2025 09:05:24 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e3b0:13f2:d6fb:6f28? ([2600:8803:e7e4:500:e3b0:13f2:d6fb:6f28])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c95ac833d3sm12635774a34.17.2025.12.09.09.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 09:05:24 -0800 (PST)
Message-ID: <7aeab2a4-72d9-452f-af86-1e44d5133b67@baylibre.com>
Date: Tue, 9 Dec 2025 11:05:22 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/6] iio: core: Introduce cleanup.h support for mode
 locks
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kurt Borja <kuurtb@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Benson Leung <bleung@chromium.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>,
 Shrikant Raskar <raskar.shree97@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Guenter Roeck <groeck@chromium.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <77ca77847511e67066a150096a7af2fb84f1f25f.camel@gmail.com>
 <CAHp75VdNjqZdy0+aSbBzn9CwEwHUhjwED+KRVqkdOMc_N+nX9w@mail.gmail.com>
 <20251206184645.51099254@jic23-huawei>
 <54483083c42cf7500239ebb7c0d32d25f11bb02f.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <54483083c42cf7500239ebb7c0d32d25f11bb02f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/9/25 4:34 AM, Nuno Sá wrote:
> On Sat, 2025-12-06 at 18:46 +0000, Jonathan Cameron wrote:
>> On Thu, 4 Dec 2025 17:07:28 +0200
>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>
>>> On Thu, Dec 4, 2025 at 4:35 PM Nuno Sá <noname.nuno@gmail.com> wrote:
>>>> On Wed, 2025-12-03 at 14:18 -0500, Kurt Borja wrote:  
>>>>>
>>>>> In a recent driver review discussion [1], Andy Shevchenko suggested we
>>>>> add cleanup.h support for the lock API:
>>>>>
>>>>>       iio_device_claim_{direct,buffer_mode}().  
>>>>
>>>> We already went this patch and then reverted it. I guess before we did not had
>>>> ACQUIRE() and ACQUIRE_ERR() but I'm not sure that makes it much better. Looking at the
>>>> last two patches on how we are handling the buffer mode stuff, I'm really not convinced...
>>>>
>>>> Also, I have doubts sparse can keep up with the __cleanup stuff so I'm not sure the
>>>> annotations much make sense if we go down this path. Unless we want to use both
>>>> approaches which is also questionable.  
>>>
>>> This, indeed, needs a (broader) discussion and I appreciate that Kurt
>>> sent this RFC. Jonathan, what's your thoughts?
>>
>> I was pretty heavily involved in discussions around ACQUIRE() and it's use
>> in CXL and runtime PM (though that's still evolving with Rafael trying
>> to improve the syntax a little).  As you might guess I did have this use
>> in mind during those discussions.
>>
>> As far as I know by avoiding the for loop complexity of the previous
>> try we made and looking (under the hood) like guard() it should be much
>> easier and safer to use.  Looking at this was on my list, so I'm very happy
>> to see this series from Kurt exploring how it would be done.
>>
>> Sparse wise there is no support for now for any of the cleanup.h magic
>> other than ignoring it.  That doesn't bother me that much though as these
>> macros create more or less hidden local variables that are hard to mess
>> with in incorrect ways.
>>
>> So in general I'm very much in favour of this for same reasons I jumped
>> in last time (which turned out to be premature!)
>>
>> This will be particularly useful in avoiding the need for helper functions
>> in otherwise simple code flows.
>>
> 
> Ok, it seems we are going down the path to introduce this again. I do agree the new ACQUIRE()
> macros make things better (btw, I would be in favor of something similar to pm runtime). Though
> I'm still a bit worried about the device lock helper (the iio_device_claim one). We went through
> some significant work in order to make mlock private (given historical abuse of it) and this
> is basically making it public again. So I would like to either think a bit harder to see if we
> can avoid it or just keep the code in patches 5 and 6 as is (even though the dance in there is
> really not pretty).
> 
> At the very least I would like to see a big, fat comment stating that lock is not to be randomly
> used by drivers to protect their own internal data structures and state.
> 
> - Nuno Sá

Due to the way that conditional guards only extend regular guards, I don't
think there is a way to not expose the basic mlock wrapper. So "don't use this
unless you really know what you are doing" docs seem like the best option.

