Return-Path: <linux-iio+bounces-12083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D5F9C2DE2
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 15:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50133282898
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFB9197A98;
	Sat,  9 Nov 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIT1FVEc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAFC1E4B2;
	Sat,  9 Nov 2024 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731164014; cv=none; b=S4gVpTvj/aDx4R18KptllC/kpOZmltou6QNwdNC/TB1pY2O2dojYrjuUmMVQEQ5T5D2aK5/1X56B+fjgcFju2wG2+Q9Zfsk1jxqrgfAnD3SEqhHOBqcBy6s5bSGGJTBbToCuBNlBduQezXuM595Dkx36fBXPJuapJ4jai8ExvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731164014; c=relaxed/simple;
	bh=VJ8ompsICNZ2GHQCxcP7VzkTwKcmU79VWOQb7QIr5no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uz1k7C0l5z0LlbCmHml233Hv2j307jizAKD18m3sSRMA9L5poLchQKRyTfJkFV7mGWmvogVVqZCBG/s0fSF2obTeZOtqyd0M3WH31c4jSt7nRu2y6Sy5rar33v2vT8Deoga+2IPal0HILN9GuLr8S1U7KoyOeyqclk37CJIYXx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIT1FVEc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-207115e3056so31853875ad.2;
        Sat, 09 Nov 2024 06:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731164012; x=1731768812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ghbuLAThgkIRMv7v5y1QI1mRj61wYj6v1lVWxgIrotk=;
        b=AIT1FVEc0vIcd47afY7hX/2FWX0kLMDfSqa4nVBWJLulUGsH9kP2nu9iJENXWyzu/E
         WuocH0mxd56iDeXP7guxuGzfXbD6GqDdaV3RTlAiRBoDe74+T5cx/aMUNDt9cofIyAu3
         wd9i0tzYFenaTYs8rwSrNAqZqF5JssOnGf+8qQ9fywvyA6/gUmZEtkGwkMbRgwJJS8Z6
         TYbEtdsa4UK9QNJr3c3kA3VGhTxZscx11NKBWMAwrZITmWXkuHEiZeHKPsdtv1ObdRzi
         CQQT1G+W2hdMMpokD/8/8DcB1GJOMrQqqNOtbTZ6Czcf/91sxKm9370coFwAwClY74JC
         QSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731164012; x=1731768812;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghbuLAThgkIRMv7v5y1QI1mRj61wYj6v1lVWxgIrotk=;
        b=PqCQfusZHFBS6wrvDc5+1uOTXMIn7SzYBgpMjfhr4WP6OUYnV6fPJAf3hgJZRRqS0O
         qMezBDS9/Bw84YfJefvNGQWeTLwRKRv//7qpS+TQABiKu/CrnjHsroGKKGUiuZsNpgaX
         Bm3wexZaXjKc6NpdjeU/kfTdyouOfR6Z+FSBtCweXYvXAylzL6QXEBacUjxZ7DPDeEL9
         GirM3akQxCbYco+kmm06Lbw8lxlLambpxdsjFHk6z8vi+IdtcsSU9xBkx8MeCX5melKq
         WpkbZz+Rt7Fos2tjypboBtNb3ttnPjqL8WPxNXMuSwpEWJ9h2RyZmIJPO/E+iQZMv+WZ
         vY1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7dA0unGgDnxc82T1BJwAd4kTYVch981gJ02SpZwoEmzL9RpRUe+yJIddJCUqYY84bFHdstSLNxzU3GnE=@vger.kernel.org, AJvYcCUag75IE+b7x8N8meKpbvEOheu9j/0xJgvpk1V+swdnLpbeyRXmf5vQDHho35AlIOkwnGAO/xtuWugVaLb4@vger.kernel.org, AJvYcCWDGdlNnhUk/jQcu3anqnHE+wJWxABXpihfiDOu1679rvWfYefp5bpEKiOlqC11nBbaKLOHj8OJ7FbK@vger.kernel.org, AJvYcCWXJXxl2NzqELiSAv3o/8bb7nsiyLSnXBWcNjVDhRRpVkuh+/RZ1eFM+fxYO+6Ua6JgBgme98mVa3rw@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJ7luks1umXL3Bkyi+QvFHc8BZUXJqkVEHbKGfmfZSQIWKqkf
	AZK+2+D2RT50w0NbD1nViPKTXHbEcvi1zNdKWTV5nS2iQ5BZj4e7
X-Google-Smtp-Source: AGHT+IHH537SxY8wFxXvHEldQOX00jSQbhq86kY8P4E7+gzAi230SDoUD4kLOapioickwHuD7+FOwA==
X-Received: by 2002:a17:902:c40b:b0:20d:2848:2bee with SMTP id d9443c01a7336-21183507aa0mr95841435ad.16.1731164012349;
        Sat, 09 Nov 2024 06:53:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e87544sm46034065ad.283.2024.11.09.06.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 06:53:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <014410fc-8a4c-440f-a6eb-1fafccc444a6@roeck-us.net>
Date: Sat, 9 Nov 2024 06:53:28 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hwmon: tmp108: Add support for I3C device
To: Jonathan Cameron <jic23@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Jean Delvare <jdelvare@suse.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-hwmon@vger.kernel.org
References: <20241108-p3t1085-v2-0-6a8990a59efd@nxp.com>
 <20241108-p3t1085-v2-3-6a8990a59efd@nxp.com>
 <20241109131604.5d8b701a@jic23-huawei>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241109131604.5d8b701a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/24 05:16, Jonathan Cameron wrote:
> On Fri, 08 Nov 2024 17:26:57 -0500
> Frank Li <Frank.Li@nxp.com> wrote:
> 
>> Add support for I3C device in the tmp108 driver to handle the P3T1085
>> sensor. Register the I3C device driver to enable I3C functionality for the
>> sensor.
>>
>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>> ---
>>   drivers/hwmon/tmp108.c | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
>> index bfbea6349a95f..83d6847cb542c 100644
>> --- a/drivers/hwmon/tmp108.c
>> +++ b/drivers/hwmon/tmp108.c
>> @@ -13,6 +13,8 @@
>>   #include <linux/mutex.h>
>>   #include <linux/of.h>
>>   #include <linux/i2c.h>
>> +#include <linux/i3c/device.h>
>> +#include <linux/i3c/master.h>
> 
> Seems odd you need master.h in a device driver.
> I'll guess that's because you should be using i3cdev_to_device()

I assume you mean i3cdev_to_dev() ?

Good point, but there are not many examples to draw from. The one
existing iio driver (st_lsm6dsx) doesn't use it either. I'll send
a patch shortly to fix that to prevent others from making the same
mistake.

Thanks,
Guenter


