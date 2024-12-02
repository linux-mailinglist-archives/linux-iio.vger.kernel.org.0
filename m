Return-Path: <linux-iio+bounces-12981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5419E0EDE
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 23:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0978AB2AC74
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 22:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA34F1DF96C;
	Mon,  2 Dec 2024 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SUfnJrCV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51621DED6E
	for <linux-iio@vger.kernel.org>; Mon,  2 Dec 2024 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733178108; cv=none; b=PfPPRkJy6gzDN2aOjwIKThr5ZG26akPSxmQBtOvOK1eca3fF4rKgMj5Qpfhtot+d/BaoythpPCJ8Z4kHXP5CcyzxnOK/NC9xSsk/+PUl0zkQ3ebBfI8UhFWVyjPFJ6vMPq8WG0/UdGxQ+mlf5+OR+O8onneb2nJ08GPUw3KltHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733178108; c=relaxed/simple;
	bh=iVxWuWFPRmSH/w9N967rYnMYs9UZvnDcHqFoPlDaNek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgaT7teG7HvhjdSXGRZ8iKfiJmmzk2jt9hTQia3QJXXuLYpE/EgSvG3gGKncA98Zd9YZJtUnD6rhH4WeTr+ib9PELY+K1unyUh2mLzosBSONsI+WeTFJO1z4h7DBr34TXZShW30zoa7hUM4CfWlJORsl7J9aKB0zwTwvgBjAtAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SUfnJrCV; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5f1eb278d85so1909396eaf.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2024 14:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733178106; x=1733782906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y5EgvmKsjGlRlTXrv3znxvdWmIWbD+0pEBkl/VL3Zl4=;
        b=SUfnJrCVbC1XaTkmdRGTMIrrayufxY8cYEpwSd27IpOZbuAJjjeCL4iAR/OAGcMe2+
         xfuNTgLIeFBGXs65gT922emPXFcuWrQBEFbLYcLYUtuUxOcY7zwDyvtcft6mrn31u7vY
         sxlKn12AiOk5r8FPo37JCaUup3Fdlr+un0+cvCe6KmPzXVYfli/kh1JcjBiXhHgJRHRM
         J2Lg3t7KufPnrE/1lssQiU6GY48TMSHCyyxJmSkWr6YCvDIa+Y0zdMl12MfnyWc6exnF
         qEuU//u/CUtvO0T8mxcwhJq4ZtWVXvh5vuLkbTbVRC+fRte6M6FbXN+ZP7r1SKHxXXtT
         Oq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733178106; x=1733782906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5EgvmKsjGlRlTXrv3znxvdWmIWbD+0pEBkl/VL3Zl4=;
        b=uZzxpHH5MEhgR7n2tCRyNMeNYgfhk3y6+z1CUCRT1po2gDk5ZiRZN28nfrYA8x0rlu
         rPNUJTTgomDLhJ6JwhHc7twLoxe+ajo7yN9RWUjDayhnewGxeJBXsA28vPVwT84taRHw
         vmvOBVIAsHfYeHOeC95USVTI6+glJhwu0+sxLrcGoW4N8u8j6qtCQbTgQAMeujuRBzbh
         VMqNapAJPKCvJyKlFC667QF1M6iKkGXIGreBPolZcQpqqx4cc/XAU+UTewVfJnMUhwAY
         Pg4ppOVOZSHJDFUeo7NMTWmFYUwJDMgoLcDfYtCTDASG6pRqRALdzwYr+swbcBYLa1g2
         g1Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWfX9wqCM4yBZpP/4qGSrj31aBXUg58QjhYB7/bdGcGOxvyzLnz3pMbWbyf5gBQ5jIt7w6h6xC5NVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAlVkxXr3XiRORFRYiu0NA/xAjG2PPutGRKFQGi7uLzYUaGMIj
	gryTscdNKEaLVy8PLH9rWJYx0YXMHEYkbCkF3nvSqyrC097/5lyaxUtVgn32PoQ=
X-Gm-Gg: ASbGncvpLE307E7kXeouJkgmqu8Lw7RMjQuWxc2CbfdZ6Xl05bhOUSMAxB+AAgnsQr9
	ET4ngxQ9OkUO0hy1C9qAF5eYgK8a79iaqXnSdWjzh8k7EHT4pL9ajsnBUXQaET+2Z3OHc4N3gBn
	1NqlmNTYSfJdZ5Yrs3BU6tVzfMRBoJYKIYJIiCXWOMw2ThJHAsCG0+Cj3VJn0HH88ljAgDJqXLm
	uJjs89uLbDfOJLZWFSBfEdyUDQwHpqCstZDhK/uAf+d1JORxbJinrOsSf6CZ+AhFWja4VAcg+Fc
	5sL6lWlG5r0=
X-Google-Smtp-Source: AGHT+IH5D8zxsG/6N3xFU3CJRtyYDYXLofQVTyGbW0rtmiK7Peq5YuuswOgSTSpcxUTfc25zA9oMfg==
X-Received: by 2002:a4a:edc3:0:b0:5e5:941c:ca5a with SMTP id 006d021491bc7-5f25ad2f79emr98037eaf.1.1733178106010;
        Mon, 02 Dec 2024 14:21:46 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f21a311700sm2481289eaf.6.2024.12.02.14.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 14:21:44 -0800 (PST)
Message-ID: <6435f696-40fe-4ff9-ae76-1f121fe7604f@baylibre.com>
Date: Mon, 2 Dec 2024 16:21:43 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] iio: adc: ad7192: Add sync gpio
To: Jonathan Cameron <jic23@kernel.org>,
 Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Hennerich <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20241128125811.11913-1-alisa.roman@analog.com>
 <20241128125811.11913-4-alisa.roman@analog.com>
 <20241130183839.1fd5884f@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241130183839.1fd5884f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/30/24 12:38 PM, Jonathan Cameron wrote:
> On Thu, 28 Nov 2024 14:55:03 +0200
> Alisa-Dariana Roman <alisadariana@gmail.com> wrote:
> 
>> Add support for the SYNC pin of AD719x devices. This pin is controlled
>> through a GPIO. The pin allows synchronization of digital filters and
>> analog modulators when using multiple devices.
>>
>> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> Hi.
> 
> Like all userspace ABI, this needs documentation.
> 
> It's an unusual feature, so some usecases would help.
> 
> It is also cross multiple devices which makes this odd as only one device
> can presumably acquire the gpio?
> 
> An alternative would be to look at how to do this with a 'wrapper' sort of device
> so that we have one instance to which this applies.
> 
> I'm not sure that helps that much though as we'd still need some for of
> 'I'm setup for all channels, now you can go' ABI.
> 
> Jonathan
> 

Giving userspace direct control over the /SYNC pin without coordinating
with the rest of the driver does seem like it could be asking for trouble.

It seems like the only time you would want to actually toggle the /SYNC
pin is when starting a buffered read.

1. Deassert /SYNC so that no conversions can be triggered.
2. Enable buffered reads for all chips connected to the same GPIO.
3. Assert /SYNC to start all conversions at the same time.

So it could make sense to integrate this into the buffer pre/post enable
callbacks somehow instead of adding a new sysfs attribute.

For the "wrapper" device, maybe we could do something with configfs to
enable dynamically connecting multiple device instances? We might not
need to actually create a separate device in sysfs, but just do something
so that enabling a buffered read on the first chip will enable buffered
reads on all of the chips in the group.

It seems like we have some other chips that are currently being worked on
that also have the possibility of some sort of multi-chip synchronization
like this so it would be nice to come up with a general solution.

Another use case for a general synchronized buffered read/write between
multiple chips would be the AD3552R DAC. Recently, while adding support
for an IIO backend for this chip, we saw that the AXI DAC backend has a
synchronization feature like this where you set an "arm" bit on all AXI
DAC instances. Then when you enable streaming to the first chip, it also
triggers all of the other AXI DAC blocks to start streaming at the same
time. We ended up not implementing that feature since the IIO subsystem
doesn't really support this yet, but could be a good one to look at as a
similar feature with a different implementation to help us find a general
solution.


