Return-Path: <linux-iio+bounces-11825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA78D9B9E5C
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 10:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CF51F22CE7
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 09:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6CD166302;
	Sat,  2 Nov 2024 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8CGnuxb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C233F1487F4;
	Sat,  2 Nov 2024 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730540721; cv=none; b=loNcwdTmjANxSwiGd4o/R0sOsHucg48JsZRCZBmDHgi0gnyyYhJIQHIg5aD6oPsT66DpzaQjmmytHRCYS7V0i0NljUx/oKlhnnHzmTzr95mEZK8Jv3XL3xf9FN9dAbfgCyI9bDyf97K5rD2sfy9pwoZSYQSDqwt4gZmlv1ZAzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730540721; c=relaxed/simple;
	bh=OqVhb9WyD0EroQFQV0Fw25X7oHpCt7cWVjpDthVxCnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdqL8Rf2wWfGARRx1zdGI4zA5RZdPSqLBBcZwd/EIxTN39EtGjcx0VFHjXEVyyx6QxRqEvI7oz8gJld3W2PWw9qfC55/YWa6+9sfD3G5DfeOwMhk5w/oR39ScOO8bcI+28bD0tPJRuKx1q43UZbSamxRTlin769+1U9e/o/mfHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8CGnuxb; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f53973fdso2526107e87.1;
        Sat, 02 Nov 2024 02:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730540717; x=1731145517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4k5awbY2ujsGOHyJ7+thIpw6iC54FDDnJWG6i2UMOE0=;
        b=l8CGnuxb7/1JED4Zm1tt+sZplYQO1YdVeJAHAFmfC53jBH4+m4bzYW6q70QGjXC3Xq
         m+Xe7pKWRInpwhmO2yEBlMstuA9yuu7TPjzT9LeZy1OGXKsNkabmojJT/vMPtTe7AzVf
         k5Kr8Blf9vCHBgoB8TFJWRcjthW0/dG4EPq+61R7dr8bzNskQrM6wZZUSagzIVjjnUcB
         8XAdyDNmFdNqX9ueB9yqJQFxij1rDLQPbvj/lD5mueUVHtsR41qghxc+t7uTzT/naok7
         gz6xnMnF3A9YeYAQaWwXwMJ5zrsgtlKjvoiUh+y4PML9Ef1o4tlf5mDwrYVl3ig4HVo8
         HWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730540717; x=1731145517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4k5awbY2ujsGOHyJ7+thIpw6iC54FDDnJWG6i2UMOE0=;
        b=YhnJouR6s3OmfbFEED4OiRKG5PLBYfHsbHbm6+UYhX0Xu1KzyHmQbVaPaC9xDpfM3K
         SPNrA31jHsZKo8gWrKe45XCeOUu0cdEwOYbDNYwUU0/YjTJvuUFVIyAgc9MAmr1JfS0d
         KMbjgQ15WhRDsYYIAqf4ViJ7AQSlUHVsDi9WF0zaMCnDjWwhaaJ/4o/chT/Q/KqXE3Ap
         YeS58TGQfVL480fVl+Du9mr23n/mwvqfa+X+70HLashwAz6H/ITVE0c4w85wmT6NYo+W
         mOYdSDSWXlDkqrBotcZiA0mijNV+nnEqSwRCcjZQ1/6xSCZlQ5qDJfPhOzm56DKGBgZg
         wAlA==
X-Forwarded-Encrypted: i=1; AJvYcCVGQc3sjTiBaQEjoJqPhVqi4OXTc0loTlqUbNJU1Uln5sxL6ch0m7//N2smSj2+kJHPIIR7Ti7OpeM=@vger.kernel.org, AJvYcCVsZFCZ2itgaTyfZ+QHttAV2bX5tp/clgh82BwIV+TWe+H7bfl5igabnKcbpvFlD0DYCoCWPBYkCqJW1gV+@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/pK14PYF14aeMAdwecKwb717E2qijrt72AqLB3ZJzU1fVAIk
	DQImnC3oWc840kcUfjgD5ZEPiuMt/8ItotEcsGt7GKgKKVp1JeMDL8YYSXaG
X-Google-Smtp-Source: AGHT+IGc0O8EdvlNcOGMKyu4uggfG8dZtztMHSvyfs7RrfHRSItwVzmDSylvENg03q1mKvkw/9mqsg==
X-Received: by 2002:a05:6512:15aa:b0:53b:1684:c1df with SMTP id 2adb3069b0e04-53d65d91db4mr2064161e87.1.1730540716450;
        Sat, 02 Nov 2024 02:45:16 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdcbff8sm827650e87.210.2024.11.02.02.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 02:45:15 -0700 (PDT)
Message-ID: <0c616d01-f90b-472b-bddf-d4441e9159e4@gmail.com>
Date: Sat, 2 Nov 2024 11:45:13 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: Fix uninitialized symbol 'ret'
To: Zicheng Qu <quzicheng@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: tanghui20@huawei.com, zhangqiao22@huawei.com, judy.chenhui@huawei.com
References: <20241031014505.2313035-1-quzicheng@huawei.com>
 <5f80c1a2-118a-4685-ac1b-81b3479f5064@gmail.com>
 <1a004693-5dd5-458c-b8ff-b9a978298122@huawei.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <1a004693-5dd5-458c-b8ff-b9a978298122@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/11/2024 05:43, Zicheng Qu wrote:
> Hi Matti,
> 
> It might be better but I am not pretty sure whether have to have both 
> gains and times, so I modified 'ret' in places where issues might arise, 
> rather than adding a restriction in iio_gts_sanity_check().

Yes. Thanks for the fix.
> 
> In the corner case, there is a restriction that both num_hwgain and 
> num_itime cannot be 0 simultaneously in the iio_gts_sanity_check(). 

Right. Having both 0 would mean there was nothing at all to handle for 
the GTS.

> However, in the gain_to_scaletables() , if num_itime is 1 and num_hwgain 
> is 0, the 'gain_bytes' becomes 0 and 'all_gains' is not null after the 
> 'for' loop, which causes the subsequent 'while' or 'for' to become 
> ineffective, leading to an undefined 'ret' being returned in the 
> 'free_out'.

Yes. Thank you for the fix :)

Yours,
     -- Matti

