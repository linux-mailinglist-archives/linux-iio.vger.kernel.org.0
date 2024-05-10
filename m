Return-Path: <linux-iio+bounces-4916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA258C1D9A
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 07:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2C82B21C84
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 05:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271651527A0;
	Fri, 10 May 2024 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4+7Ho6L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4AA152791;
	Fri, 10 May 2024 05:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715318096; cv=none; b=aU/VYNqkj+e66ZITuLVD/9vI0G18cQOSpGgFDBFtqLcfN4KiZwbXyhcNKN78POge1d6g1ef1gm3X5w40k1MOzpgsoAu+wLS8CUMmEWFEh8P87kyBLqcocLAA18FX3RmiqB57cVT8fGCpPMaJ3Yszy8VZxz7sxJMqDCtLLsiQiGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715318096; c=relaxed/simple;
	bh=/wfp+sYuMpBKf4KLIPDyeRLT2GchQIx68TR8jcU6d3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLROMU/3ht3Zx40qEdkxn3Ux/7bWm8+DcaDeTxL6Gp+mjedqjEgqfzHiH5dDjN/UMeWFAABmwlSCbziJ9Kdw5/lGEZMaq7NXks00psCUsd8jk446LlU06S0z36EQgCCQNUPijQw+1RDmx6sCkk0pZ3GpGg9qqIDMp832PGzHvYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4+7Ho6L; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51fea3031c3so2181297e87.0;
        Thu, 09 May 2024 22:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715318093; x=1715922893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KD972YGs70ELqEUYYLAB1LZ0CP+hOI5m8/hTJEXwF4s=;
        b=T4+7Ho6LrbWNm6aq8/Hrepv35Lhr+0YcJ1z6wpYfM3IKYqHhLs7Q365gcATTBJqOWr
         7BZhZp9NJMe3Fui6S2j2jN/t26yK3U+AQB6/WSzfIecp+iOPqqPLKg135duS1YYbhVvX
         HjVNWd+ekFeFBQOqftl3hdNe0WdRGoo9I/AfBolx7NTR8Jggt8SQGMo6Fa/VWy6mHt8i
         o6XqHgGYyK4cLjIbPe10Aa3tPdQY/uHn8GXyWyFnPpLOSqlRSUpZmJkP0eJzxIR4QG7i
         yUPc6jg2GX5hGyI8tyIfABOa22e1AnjMhLSXSariNCh7iRNmDoRwaz7nyiE2bJkToxUr
         W8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715318093; x=1715922893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KD972YGs70ELqEUYYLAB1LZ0CP+hOI5m8/hTJEXwF4s=;
        b=hJ2CJHFxW38RL1SU4rlzjam2GeN82I+73HzDwiPfF6JPLWn9SvS+GUesYCivj8oHyI
         5Ditfk6jInt6zFB6GMPQEiH29V9MM7OtMQClfSpbvEfvOrWNBnd3HtsQejVuqPBhZP6w
         l1PBx64s42KfmXOhfOAZCuyTZdAgP76KFoz9BktQYnXSc84DNu6luGxqWEZqjVK2A6FG
         gg1ENh2KA/e3tOQd0IL5BKCv+qMFtByAR+HMgxjlTYpDGLX++5mBLiWEdiQ0+mDWmWal
         MGG1eX+ZLkXeqrbL1uDqufZ+iPtkcC5hkZyoYwbKW0RWW6R937OumZderzlmAzs6VJ/d
         zpQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwXba4b+6KU2Q1UYH57rIb78NDVisW6tQhn2zjq52wgIJazHUdbBHpmixJphcMjgMCC0PCDpftRDCkC2vFQh5gI78mqth8s9yNQacux3BPtKVITCwXUFQcDr3+bQiO9NITgOhA1Y3x
X-Gm-Message-State: AOJu0Yxf1WnwwXSCr85N/icGjUtZyOkgeenCQHRsX7rTtaK6C9S1jzOT
	MvarsA1FBdMxekH6uMoVcpnWdIajzKL+MJoZuFqpkeX6+TnMPpXi
X-Google-Smtp-Source: AGHT+IFHx/96hoTIyI75AZqjemK+UNHjFKK+dmJI3+TYhsrWFPWlOzyU/lEWFr7GNDYwmMtvxDjThg==
X-Received: by 2002:a05:6512:ea0:b0:520:676a:7322 with SMTP id 2adb3069b0e04-52210278595mr1383667e87.46.1715318092969;
        Thu, 09 May 2024 22:14:52 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ba59bsm558063e87.65.2024.05.09.22.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 22:14:52 -0700 (PDT)
Message-ID: <f9c59545-6816-4e45-9098-a52b2688a22a@gmail.com>
Date: Fri, 10 May 2024 08:14:51 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix the iio-gts-helpers available times table
 sorting
Content-Language: en-US, en-GB
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chenyuan Yang <chenyuan0y@gmail.com>
References: <cover.1714480171.git.mazziesaccount@gmail.com>
 <20240505185027.18809bfd@jic23-huawei>
 <11a16488-7f5f-4d53-a091-9cedcab76dc8@gmail.com>
 <20240506135356.7babe20f@jic23-huawei>
 <f5215081-c993-4147-8c50-fba1f56279b4@gmail.com>
 <20240509131516.000049d4@Huawei.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240509131516.000049d4@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/9/24 15:15, Jonathan Cameron wrote:
> On Tue, 7 May 2024 09:14:15 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>> On 5/6/24 15:53, Jonathan Cameron wrote:
>>> On Mon, 6 May 2024 08:09:27 +0300
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>> On 5/5/24 20:50, Jonathan Cameron wrote:
>>>>> On Tue, 30 Apr 2024 15:44:26 +0300
>>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>>>        >>> For now I'll leave it queued for 6.11 on the basis there are a lot 
of ways
>>> a driver writer can cause similar out of bounds accesses and they should
>>> notice it not working during testing.  So it 'should' not be a problem to
>>> not rush this in.
>>>    
>>
>> I guess this means the 6.10 won't have the fix? I believe this is fine -
>> assuming the 6.10 is not going to be an LTS. Thanks for taking care of
>> this! :)
> It may well get backported anyway, but after 6.11 merge window.

This sounds good. Thanks for clarifying!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


