Return-Path: <linux-iio+bounces-9697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC2D97E0BC
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 11:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4866C281093
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 09:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74AC137750;
	Sun, 22 Sep 2024 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MW/5Ddcg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ED91C36;
	Sun, 22 Sep 2024 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726998263; cv=none; b=cfb/RgGlJbeNETEx/eJ7YHQK66DKPBHRV+8N/gk+kNZabXqgxQiHDSq6o5ftrkci2CtxuIfaEqGm+vAeZH2E9tpObTvrBqjk6P1SNrI+5p7zBSnpoGgqz4p/3Bb121L02/6OyXxRWs2/Y4TiY7MpAyKX3TvEAGyaifM1YxqGHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726998263; c=relaxed/simple;
	bh=DrFN2nD4hC63onI+KzxJfmycnBXbYo3kmhA/9RDF+T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdSVxyubaizVg/TZ6g8BYJxjt0TuTZEj4Q9jranN5kwJQ1mUGS0GuGhDF7kM4yZJR9taQtevPe0/HyKukV8UqnkZm0yX9X9k0a14Umj2PF/efUlCNrpPoRg97a7B/8JdxdnYIyG52mcwBLKSYbYKt4QAK74IlgrFD7T8ZVOyVAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MW/5Ddcg; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75aaaade6so35266361fa.1;
        Sun, 22 Sep 2024 02:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726998260; x=1727603060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s3/FLcqKEpuWJAXkpa58GZS4Hs59zevTG5XxjYkpSTo=;
        b=MW/5DdcgYg/S2JOxhvs/hQjgH8Ca+EVQWy3ppGbnvWFSDtLq9MBL0S7LmrCduPBZmm
         DulIYFt8LaIEuNm2I8i0DC2wm32OaTwJ6z67FpdUJdmzm1e8teofaQGuJ0c5ixj1+WkD
         1SYo9twVNP8n2J42Zn57BjZaYZ0Pj32iH63OapIPmDY/fpQWmXm6nsoxBgChYY4MXj6a
         XVCh86glGmbTDxHZ2yOZFRbs/dNAqF9QIsdVCU/DIfs1V5YNz4urmfdNs5qpxx8/deOz
         yfd9XmneOpdpT9/cC/22u5TEpmC3ZsisZlTBuFESQi4PB2rIh2WzoRNZg+3/pgUYWIJ4
         1IbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726998260; x=1727603060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3/FLcqKEpuWJAXkpa58GZS4Hs59zevTG5XxjYkpSTo=;
        b=IdijUEogLkDwMWJ6wgOdqoqEgKHzWyz6p/Z1MyrwdWuSCNgIe7V1NXX3rzXnlY9i6g
         JjowrXo4d67f2KWtyBm3EXwYe5jfEydF4mdbC5IcRxwzP8hmhqsKSwY330JLsp0gAtIh
         880aez1PFzZD/v5ogti9Ypm0t5rGQEUYsIyYAdwULoUGBMUsFPhL3m1JaR5k8ZZF8WGh
         59UYPrI7mrbmMnMuZThNjN2mRDdA/JVIMAzHdOxNNuUiLZvajGmjLAiJXHTTQeDYlDyf
         +MjuIxyKebZeIIfoDf5xG3ltAnnqcxN99baGIIhTl7HxqLeJ0DTFQruqUAMQS4ERjdCK
         OSXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNkVGXs3rmadWWWUDMZf/4PZ/XWMffY4eCx0bZT6+y1HQWPtxaEz/3upaAe157B8EZpJaQuw1cM6Yj0aIB@vger.kernel.org, AJvYcCXS5Uggcq/TS/ao/GL5sZZ9kfm71GvwvQf0fw3l20C3bTNijCZEogdgXSmUICmnc99tU1Oz1IZ1WS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZYYm8RqZtNljyrfqCGrPXJl/oG/WN4rcZ+NwFn+9Gro6d/j9s
	WU2y7110o8QHd4jrQTnvb9nEynwpCoh1/LkNex9LAlX/GAYOH0JC
X-Google-Smtp-Source: AGHT+IEAQTDzN8DxTKi7KMchmj3sehYJ/YFXPBYzR2MVTg+nBmrTgC2xNVo4a24Z5+ASAB6Tckq3hQ==
X-Received: by 2002:a2e:9fca:0:b0:2f7:52c5:b67 with SMTP id 38308e7fff4ca-2f7cc5bb2c7mr31169331fa.29.1726998259606;
        Sun, 22 Sep 2024 02:44:19 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8b90da767sm5721401fa.119.2024.09.22.02.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 02:44:17 -0700 (PDT)
Message-ID: <609fdda9-fcf4-426f-84c8-411a59ed5fab@gmail.com>
Date: Sun, 22 Sep 2024 12:44:15 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] iio: core: remove iio_validate_own_trigger()
 function
To: Vasileios Amoiridis <vassilisamir@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240921181939.392517-1-vassilisamir@gmail.com>
 <cd1df0c5-d95f-4880-b374-a7544a323d93@metafoo.de>
 <20240921200759.GA400156@vamoiridPC>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240921200759.GA400156@vamoiridPC>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/24 23:07, Vasileios Amoiridis wrote:
> On Sat, Sep 21, 2024 at 12:23:39PM -0700, Lars-Peter Clausen wrote:
>> On 9/21/24 11:19, Vasileios Amoiridis wrote:
>>> The iio_validate_own_trigger() function was added in this commit [1] but it is
>>> the same with the below function called iio_trigger_validate_own_device(). The
>>> bodies of the functions can be found in [2], [3].
>>>
>>> [1]: https://lore.kernel.org/all/51cd3e3e74a6addf8d333f4a109fb9c5a11086ee.1683541225.git.mazziesaccount@gmail.com/
>>> [2]: https://elixir.bootlin.com/linux/v6.11/source/drivers/iio/industrialio-trigger.c#L732
>>> [3]: https://elixir.bootlin.com/linux/v6.11/source/drivers/iio/industrialio-trigger.c#L752
>>
>> The signature of the two functions are different, the order of the
>> parameters is switched. So you can't just swap them out for the
>> `validate_trigger` callback since the signature is not compatible. But maybe
>> you can update the implementation of one of the functions to calling the
>> other function.
>>
> 
> Hi Lars,
> 
> Hmm, I see what you mean. Still though, do you think that we could do some
> cleaning here? I can see 3 approaches:
> 
> 1) One of the 2 functions calls the other internally and nothing else has
> to change.

I would go with this. Changing the signatures to be the same would be 
(in my, not always humble enough, opinion) wrong. The different order of 
parameters reflects the different idea. One checks if device for trigger 
is the right one, the other checks if the trigger for the device is the 
right one. Thus, the order of parameters should be different.

Calling the same implementation internally is fine with me. Maybe 
Jonathan will share his opinion when recovers from all the plumbing in 
Vienna ;)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


