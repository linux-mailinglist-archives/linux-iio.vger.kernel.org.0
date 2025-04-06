Return-Path: <linux-iio+bounces-17687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45A4A7CF16
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A713AF814
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B06413A3F2;
	Sun,  6 Apr 2025 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r6WJVTVi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64211CA81
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743959727; cv=none; b=DX1scH6E4RCHkeo6Rh28Hl4MiFO9jdyL8cLWUEoKuWT8A6nEHKW5W1fYk+EcJW5AEj5DYC2nFg7oqWyd9VMN6LJYWFOh5d72P2/W2Au9AWqGqQFy/7leI1QSnKiokdwiePcyL2kxLA2IqzmjVc+4kJJAixOxGIQ67D3uquYqVbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743959727; c=relaxed/simple;
	bh=z5Fmz9wrTFnX7upk1eHboHRQp9wQ//b5RzzrZznTCXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rG7i/Tjo6FAED/6Uf2d9meS+xa3SnBmAgnzHZqXXWHgpo0v1MQgVBe+jDG8ysJ/xI+2tkwUFeJAeDxH8WyEizxGn6XsyA8o6nBhiI8F4XKaMaiH7uhEoOYxmdKLKF7KY0fa5uj7ANzXq379RFGYxCFc/MJAVO7NB1BrJ7dG3YVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r6WJVTVi; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2cc36b39545so1308201fac.1
        for <linux-iio@vger.kernel.org>; Sun, 06 Apr 2025 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743959723; x=1744564523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jz83Dw5tVQi44nZWg92+kyfzNcUQGgFoUXuI2b/kQi0=;
        b=r6WJVTViUNq/uidtIXIMChglnPuNtqvYxfe54c0HOsvhfNgor83PgGcYP6lGs5FKzs
         IQ3e500uvwXlVh4Sv99AoA9bCThhBc+5GLmH2cKnFCBBwoaMvG6cbmGbujfUgPAjElQH
         keCZfR5dRZxcHWS/n7WS4FPYTcuaXRbc57XCg6cRyrWEFVQyVSMxukJMfHJ3PCKMju7z
         D55pmuzhSUq+eLfyfmKcgC5zCE2sEsh7Co0J+9l1sQnGQYhAZkV9LtRunjCvKYFeNtJn
         fT3RW/sWmmIMq9o0A2sv+FofRDTIX0WO7Q6MVJU0a4PtxvhyL41gakgMbjcOYKfpVuIC
         VIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743959723; x=1744564523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jz83Dw5tVQi44nZWg92+kyfzNcUQGgFoUXuI2b/kQi0=;
        b=bUZV3tnZDf4nzJkuhTFLG5ioEfF2c8J5K5OIGOYNCppU/GTObvSG/vDqE85mWiNk+i
         b8hZMkO9ZxcSF6wMg9kflVMvs+k1K3W0gyhGWxvfcoD9hN0p73zhgkg+CMbaSrw4yBIT
         D41pe+sCPCO7RV/3QhnOHXWtlobJU7pwLqxYUx5EyritvMzp2I/2p5JzPu46igvHhX8O
         2fQnKrScEI/ThJBy4i3tQiZfrf6OZ/ylqn4S3Da5uJL2nlma/Qy/lD1snhUIRcRQ0/Zf
         I0bqYLACg3yOfZMSp9yVzU/V95ZcS2kOtwwyGqYG3aZ6+uAIxSNphpPhCHAdHf9wRzqw
         vkhA==
X-Gm-Message-State: AOJu0YzWxl4mGEIq5leeWJM8AJsDk0YktJEyPzJP+4fSEekd84wdqixk
	c/ODvghnv6Ac6UJSG9yfRdqPnIh0gjYVxNq1to4G28ZrG7VkeB8JtVWk4CeR9rJVuGfJEEFHshL
	eUss=
X-Gm-Gg: ASbGnctE4kBAd9Dh96MvTD/ShkqDEIlcc1K8RgiTCbY+p9vicj2mCJ5lDFwdUbliRzB
	tBB9+F6u8zy4z62Gb9BnIow+vf6nYYaw+6VH2vSQpO96fCLjID5AfTnyPSc3xGQye02yQmKOuwi
	jhWGgBLzRbfzSOCEWZ5y5fQgEQCyPPt/ZQXLiEK7pCnUh4ddq1UMYTAsuB5xH8kIlGXzBTMNWB7
	mWXH2R9FXFdMWUp8bYa7q4mwvD9LVY5i9glEcZ1k0gEiQn4FcsAEcdocpyZjC9/GhkP4f3txCCj
	cpzFix1lIXLnwD/1Fe/crdbSlCiVDZZcN183di2YbhsctncIW+7xqut/P5lDYGIr9hws8JzWAuB
	kgG/EOA==
X-Google-Smtp-Source: AGHT+IG3vkUcEvD8pndyvW0vWzCHFA2L2/fjxcBEekWIXA2mpXFpg7IYN2WA/vrsSL6mB7lt02u+gQ==
X-Received: by 2002:a05:6870:962a:b0:2c1:2262:7941 with SMTP id 586e51a60fabf-2cc9f16fae8mr5908694fac.16.1743959722907;
        Sun, 06 Apr 2025 10:15:22 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2cc84b26ebdsm1682434fac.32.2025.04.06.10.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 10:15:21 -0700 (PDT)
Message-ID: <987e1564-4409-4bb9-8ce1-4bfb1208052c@baylibre.com>
Date: Sun, 6 Apr 2025 12:15:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] iio: adc: Use iio_push_to_buffers_with_ts() to
 provide length for runtime checks.
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309182100.1351128-1-jic23@kernel.org>
 <20250309182100.1351128-6-jic23@kernel.org>
 <b282990a-de51-4120-abde-9b628847d9f9@baylibre.com>
 <20250406180246.108a58a5@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250406180246.108a58a5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/25 12:02 PM, Jonathan Cameron wrote:
> On Mon, 10 Mar 2025 16:49:18 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 3/9/25 1:20 PM, Jonathan Cameron wrote:
>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>

...

>>> @@ -425,7 +425,8 @@ static irqreturn_t mxs_lradc_adc_trigger_handler(int irq, void *p)
>>>  		j++;
>>>  	}
>>>  
>>> -	iio_push_to_buffers_with_timestamp(iio, adc->buffer, pf->timestamp);
>>> +	iio_push_to_buffers_with_ts(iio, adc->buffer, sizeof(adc->buffer),  
>>
>> u32			buffer[10] __aligned(8);
>>
>> Technically OK, but could use ALIGN. There are some other drivers like this
>> but I won't call all of them out since they should be OK.
> 
> You mean to calculate the number of entrees in the array?
> 
> Jonathan
> 
>>

Most of the ones like this have comments explaining that the number
is X number of Y-byte samples plus 8-byte aligned timestamp.

Even though the ALIGN variant is a bit more verbose, it documents
the same thing in code instead of the comments.

So it's just a personal preference thing.


