Return-Path: <linux-iio+bounces-21500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60625AFFA35
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 08:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407F7548129
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 06:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F4D28726A;
	Thu, 10 Jul 2025 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkWZAyeF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A978E23AE93
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130386; cv=none; b=WRs3ggOjk5TI/15x1o7KmwCYuIoZWYE/IKpKb7J+pDdu6tKbyEQGC8ZSJPtddm+IiojLYdEp02ZnNy+aMf4BoMFOIpfN7sR0N+mcspflD7SW5mT3Au8nEacXR6comwZX7jZJ+3xwp0iz0coJLwTCKiAG4g4hgicNHIRpwJAkx0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130386; c=relaxed/simple;
	bh=RYIiCyyBetfTA1e0+WRdXFn7Dnc0SYr/27aeitUbW8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/hXWmWB/o6Ao1na2MgcBch9oyXCw65yK9gICgAhw/nMqqFhT8fAp4w1grDyJLskA0nkL47nkDxcwtfA9CJ3XBAchRrD6OnXnj+W/5MKDts8w62rYtdsKvjGAjvT7U+L/tjbTLGeJ8uSR5IFtNw7JMixT4Y7sdctl4ATekjXE7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkWZAyeF; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b43846e8cso4465321fa.0
        for <linux-iio@vger.kernel.org>; Wed, 09 Jul 2025 23:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752130383; x=1752735183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jbMev2qtrGXZahrTzZJPlysqsIB0tgIPcQQFu2L1JlU=;
        b=FkWZAyeFVGcrA5W7YHnOTQzgkWEuUyYQx+4WAAXsfvOFvjgV6QZhoofQZPb+WK5btP
         lfVScRZfBMx7nVAzXP4+bp5+espTfVSLJzUpOSVddThDxdXZI9n6Q1orHglBSqqFfGgm
         30z2NqD8eGkfQKSy9YIg+rVoLpG+3OK+3AiVdmpYnYq6ZTF6ZSxez8F2pCbka5cDexVl
         CN5Xn6cUpBqAWaghg+dfg7SJxZI/nrDye64jpqKWYvqdMgyaRq+qc6eK40jBkUGOMYzf
         O8gO79OgVdyYmZAcR32VG1x2qbLuYqQPnSMW4glfkJLJxawPyTlDvV+B7CeqiEGkzIVm
         /F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752130383; x=1752735183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbMev2qtrGXZahrTzZJPlysqsIB0tgIPcQQFu2L1JlU=;
        b=u7ljGE1GeqX7AHNsXy0HpuzVrgkCZeFjMHurMiXrcWyqDcYLjSrmfM5sLZaFx3Rx3V
         gNJa53sos5hDnJjYnd8xE3e77eI0NS9oyGpVuRYUET8kQgLvG8bmcI5/ssyZqoNaEujW
         AObHEPEntB53q+lrZO6Hi6RnU4foYM6Jpdjkanw1giFDLGpdY+Nfbcxx3cESMJWCVJa1
         gl5GXBF92K7brBZcKgcUvSNGmG80RDxIC4/go8a406eKZDXvCq2OuGk90KuDaz/ekKks
         2VqVYiyLrV2fl3cIbk+NXTV1JXuirvJPJYEFZbhIDb2Cl1rQTk4UEIuUWjjzJ6Q8c/63
         MYfg==
X-Gm-Message-State: AOJu0Yzkaxv+vkrzNkEO8DfzcB+UuuzaYZl3OzuQ5HFQB23C7cmFqGMu
	9wd0kviLz0Gj7xLeLN1tCfQMCPXL2zdx+I5tMmwVoUusdyeTiAT7kMiF
X-Gm-Gg: ASbGnctoyPZ62+spKBzoTFAIkUNUF6Bu5kf+h0oJgbmhv/c4PQWljDDYUYfsqgRm/0t
	B10FUmzhUjOIrTDCob2adYiDj/ENKtWXSzclSqJwI9ZHLvcYg7QuYIIj0Qr3AJxW2lJ92lUS1ji
	gLy0JYUtS5Jg2mXlG2MJU3EGad+WFBc1jtF73KLW++wGMgD8JRz/zwwHBKKWVZUkCMMjdxJIpT5
	Z3iHX+SI+AJKuGZLDxMxuvwJB4OTSCa/LHbXrMeN5PTUn+dqr7+hf97RtE3eOY8Cc3q80XpsWKd
	hYFZBgAJi3GVIC/EvC0kIY2B3/wFTltHbCsUKrPSwq0/l058iiGt/g/MFvF4rwLY8wUgSpgH/11
	hjOXvCZXSsy4ttFTKGxa6v48vHuOiFN3Yzw9bx44BwCU=
X-Google-Smtp-Source: AGHT+IGIuRX2H4H3Ibc7IHCBEiqecMW//52s7gr15fi2+4buqIL9Sl66d6edwKjVfvuKUAbxwwuvPw==
X-Received: by 2002:a05:651c:49c:b0:32b:80e1:300d with SMTP id 38308e7fff4ca-32f4fdaa020mr6791571fa.0.1752130382512;
        Wed, 09 Jul 2025 23:53:02 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fab8edd6esm1726261fa.89.2025.07.09.23.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 23:53:02 -0700 (PDT)
Message-ID: <058aabd0-e2f7-43d3-a91c-9c2baa382a69@gmail.com>
Date: Thu, 10 Jul 2025 09:53:01 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: kionix-kx022a: Apply approximate iwyu
 principles to includes
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250629183649.184479-1-jic23@kernel.org>
 <aGJpoNfSMW_cQ4Ry@smile.fi.intel.com> <20250706181322.3ef4d3c0@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250706181322.3ef4d3c0@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/07/2025 20:13, Jonathan Cameron wrote:
> On Mon, 30 Jun 2025 13:40:32 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
>> On Sun, Jun 29, 2025 at 07:36:49PM +0100, Jonathan Cameron wrote:
>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>
>>> Motivated by the W=1 warning about export.h that was introduced this cycle
>>> this is an attempt to apply an approximation of the principles of including
>>> whatever is used in the file directly.
>>>
>>> Helped by the include-what-you-use tool.
>>>
>>> Reasoning:
>>> - Drop linux/moduleparam.h as completely unused.
>>> - linux/array_size.h for ARRAY_SIZE()
>>> - linux/bitmap.h for for_each_set_bit
>>> - linux/errno.h for error codes.
>>> - linux/export.h for EXPORT_SYMBOL*()
>>> - linux/math64.h for do_div - alternative would be asm/div64.h
>>> - linux/minmax.h for min()
>>> - linux/sysfs.h for sysfs_emit()
>>> - linux/time64.h for USEC_PER_MSEC
>>> - linux/iio/buffer.h for iio_push_to_buffers_with_timestamp()
>>> - asm/byteorder.h for le16_to_cpu()
>>>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>
>>> I picked this one fairly randomly as an example but longer term I'd like
>>> to look through at least all new drivers with this in mind + all the ones
>>> that are currently messing up my W=1 build logs.
>>>
>>> Note I've been very descriptive in this patch to allow people to suggest
>>> better alternatives for some of the ones that aren't entirely obvious.
>>
>> Thanks for trying it again, very much appreciated!
>>
>> What we actually miss is the database (in any text-based format, even *.d would
>> work I suppose) for the guarantees. For example, if code uses ERR_PTR() and at
>> the same time (very likely) uses something like -EINVAL, the errno.h is implied
>> (and guaranteed!) by err.h. Explicit errno.h is in two cases: 1) nothing is used
>> from err.h, but errno.h; 2) Linux special error codes are in use, e.g. EPROBE_DEFER.
>>
>> Next, what I would really start with is the kernel.h. this is the beast that is
>> happening in many files and old snippets all over the internet, it would be nice
>> to clean it sooner than later. Especially if it's in the headers (should not be
>> as written at the top of that file). So, hence just a priority for these cleanups
>> first.
>>
> Those W=1 warnings are driving me mad, so I'll drive this from point of view
> of cleaning those up.  Will sweep around doing others later.
> 
> Speaking of which lots of discussion about how to do this - anyone fancy
> giving me a review for this actual patch? :)
> 

Sorry, it has been the holiday season for me ;) And still is - until 
August. Well, it's already applied - but still wanted to say it looks 
very good to me!

Yours,
	-- Matti

