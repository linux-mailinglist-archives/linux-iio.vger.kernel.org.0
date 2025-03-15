Return-Path: <linux-iio+bounces-16866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB94A62FE9
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 17:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9EA174FD4
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 16:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8F41FDA62;
	Sat, 15 Mar 2025 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="Yb8PBQ0R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CAF18EB0
	for <linux-iio@vger.kernel.org>; Sat, 15 Mar 2025 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742055462; cv=none; b=WzowKMJXsJ3yrbwRnn0MVGg1UaWZRHn1CI3R455w7jBpZzWPYxWR47GzChx7Z1mxxFuNqGsVKBnAusERaSAyDgn+nzcejCEq7zJiIDGW+IP1oXBqkig3mpLNcGESCq+paSKjd3v7WeDNc7CuyFfegNmZfjYhfrPMFGsiNMyMAEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742055462; c=relaxed/simple;
	bh=EGvkxja32Y6mTyzetrc/k23oxIpKsBYWpb75PyF5XqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qd9t0iOBlig/NnXsiiaH+nQfDdmNLjVqPlLtqJ/kn54oBGTLiRNWQdrggPmXbRmE0JaCRZOYYI4WURxHktvLivr1nKAALkaJcgPE0gQeOuqaqSmF9kk8R1w8TOy7A7ADxhZvpmO0FCBxo3/+HioUd57qrlICcUT/Roe74lRohow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=Yb8PBQ0R; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2241053582dso2773975ad.1
        for <linux-iio@vger.kernel.org>; Sat, 15 Mar 2025 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1742055458; x=1742660258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvADqlsSskIdVYv2KjuNEvf+4wtq0dNBBSirwOe8Rx0=;
        b=Yb8PBQ0RaN8av7XS51o8XH1YR0Qcz6L3VZu7Gxcx5+qiOzWYpqKCpy8LILb7/FzuvC
         CUME2D5s+JaSXvhptwlkLvuy7TouyJamRpgPRBR8ySb6L/IrVlwVzTZwF2379tS0lWau
         9wXw5hJtMcVZu7ddsv2AGGDCl2z4YPGIZtLSBvJWae2e/vg8b3vL+7X1JmcFhkG7DfC8
         pLu/KFc8HCjvvwDjyX0qszj6t9ohTwoOCgGzGbHo4MOk6KiH8+51USIPNG/Kv8yxTglx
         StTNehxhdbHXVcUSKxPvGL2x8wP4slsoQ9/LQOc7xTP9uJZ3w+Evpgq6NpvZOFgKh8fQ
         CtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742055458; x=1742660258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvADqlsSskIdVYv2KjuNEvf+4wtq0dNBBSirwOe8Rx0=;
        b=tkBjygIJFh/5tmjqSts4FjMMCf64MqF1zq9D57UB4uOq9aANkCH44/78YaquxbUV8U
         bgtels3+aQ77kue2wJesogiT1UZnVIMn78JIyg5ULT6degqm9Vgr0AilRYcx3EttEbrS
         zj+/WBdTA3QEd4Z/sK+6TSQjbRQ5XkZ39vIR9DJn6Y/NaMS4By3sfS7r4/u8fcfq1IKO
         68vIZcxbqwERy9B9Um9jzS0FYbVCVqrwfVcpi4CzzmQz5fziusp0RqcB7Q3CbjxFjy4I
         eT+bXEYe81u7NQPC/bjvR6eiM35ym/ZBk5ejPOHMvcZH3twrY5gHTBAXiuQmtKB/lEED
         HuJQ==
X-Gm-Message-State: AOJu0YxrLswqLvYESgROLyitTZbXBI+GDT+FnyEKYD1PWI5LoPtf7Uxk
	gNE+pzepG+MQSIqDYzTF8adkOddiN5AN4Dz4MWbjgmwmU0cGQWUgXnCoREz2S0w=
X-Gm-Gg: ASbGnctVa0Zt/4hkJTcLp6oum5R5Pk4eT0Sisrc1+WoMSYNgivHP7cTyZxOBjHdzfit
	WdbF465UanejekCv8wqEclJJFIk3d+n+uPwWi2/iSCfHQA4Jrrcnc+M4t3lMvud/IUm2i/t9K+G
	ITf75NSHl/mRS10aYg21OpUpheXmEvUMV8oUOcCqCz+avwdDiZaaVx8fy5i3dTJ1V5NPxkMbsBt
	D18JlMa5tiWqMJ4BeQ5qRv/UqmWQi+CS8hFAkQpnIhLKAEtfpFO8FYjbQlPwOjDZUYfCcSyTp8F
	2COh0oWf9+d8RYTyEf+FhiaaoDsOmLnPzBwPJmH5otXuIjorrrlp+DikfNQqQjC2OfAjoVPVwJW
	XJBw6FP/9alZfB3fuejHbwbCV6nwzgOFhG4tf
X-Google-Smtp-Source: AGHT+IGt661Qp4scw/VMwwpd9ncX3KjBW/b4jPe3MBQG+q6B3BuWGFdjrB0T11gO7/fnhdSvqLCc/g==
X-Received: by 2002:a17:903:1d0:b0:21f:6c81:f63 with SMTP id d9443c01a7336-225e0a89e29mr70053765ad.16.1742055458078;
        Sat, 15 Mar 2025 09:17:38 -0700 (PDT)
Received: from [192.168.50.161] (61-245-156-102.3df59c.adl.nbn.aussiebb.net. [61.245.156.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68883dbsm46273455ad.19.2025.03.15.09.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 09:17:37 -0700 (PDT)
Message-ID: <6aa9146b-daa3-4582-9b11-c5c19448b3f6@tweaklogic.com>
Date: Sun, 16 Mar 2025 02:48:03 +1030
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] iio: light: apds9306: Switch to sparse friendly
 iio_device_claim/release_direct()
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Astrid Rost <astrid.rost@axis.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309170633.1347476-1-jic23@kernel.org>
 <20250309170633.1347476-2-jic23@kernel.org>
 <5ecd4fc5-a35f-4a2a-87c9-4d0fcb14771e@tweaklogic.com>
 <20250310200142.1a91a6bc@jic23-huawei>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20250310200142.1a91a6bc@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 06:31, Jonathan Cameron wrote:
> On Mon, 10 Mar 2025 17:05:50 +1030
> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
> 
>> On 10/3/25 03:36, Jonathan Cameron wrote:
>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>
>>> These new functions allow sparse to find failures to release
>>> direct mode reducing chances of bugs over the claim_direct_mode()
>>> functions that are deprecated.
>>>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
>>> ---
>>>    drivers/iio/light/apds9306.c | 7 +++----
>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
>>> index 69a0d609cffc..fca7e73a905c 100644
>>> --- a/drivers/iio/light/apds9306.c
>>> +++ b/drivers/iio/light/apds9306.c
>>> @@ -831,11 +831,10 @@ static int apds9306_read_raw(struct iio_dev *indio_dev,
>>>    		 * Changing device parameters during adc operation, resets
>>>    		 * the ADC which has to avoided.
>>>    		 */
>>> -		ret = iio_device_claim_direct_mode(indio_dev);
>>> -		if (ret)
>>> -			return ret;
>>> +		if (!iio_device_claim_direct(indio_dev))
>>> +			return -EBUSY;
>>>    		ret = apds9306_read_data(data, val, reg);
>>> -		iio_device_release_direct_mode(indio_dev);
>>> +		iio_device_release_direct(indio_dev);
>>>    		if (ret)
>>>    			return ret;
>>>      
>> Thank you Jonathan.
> Maybe a tag if it looks fine to you?  Reviewed-by or Acked-by
> 
> Thanks,
> 
> Jonathan

Hi Jonathan,

Looks good. My bad. Totally missed it.

Acked-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

Regards,
Subhajit Ghosh

