Return-Path: <linux-iio+bounces-7109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62DA91E8AF
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 21:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908D2B21CB7
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 19:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAE916F848;
	Mon,  1 Jul 2024 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPVSdg3K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759F1282ED;
	Mon,  1 Jul 2024 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862470; cv=none; b=osWxp+gWFjuzNLkKduVLCO34oT4hPb17zMINEP2zj7rTXPGQfFpMJbZiLV9tUO7A660bVG656hGGppCLsmIfaUUFjePwBubUsB9KtRxeUeDVKsrmSTVMnuf0d4e1etj1PGzX8gqxz+wKGfiu9UGCFYI+onmEsX9cp4rzmrsSR5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862470; c=relaxed/simple;
	bh=3Ky8mgu2j3WUOyh1bAAt87sh0bmuke9AaeQ1b1ZO8+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAYDO7sZKYtejrN8NMNE5lRwXbcnxb+IeNpJyFhlJ15ubtbGoG02h9jM8gTtuuCvYVbgbOz74UWnDSsDyEwpIoUL6f4nqqwsjP4Qfi1bSb4sHULCJPh5m5srBEbj8hVJ6Q1Y3m3nfy7u0kw1UG/3TMFL5FOonngWFLEy89UMajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPVSdg3K; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42565cdf99cso30337385e9.3;
        Mon, 01 Jul 2024 12:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719862467; x=1720467267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SPYaq5FewjWom3DFGFtD3B7b78iOp1/6FVum1jHZ6nA=;
        b=UPVSdg3KW8x7tAak0EwkSYRQhsps+axC025id23thqqiCw2O+mxldNEYCwQI27kO1B
         uZhIhhuUMH/nMjRaWOf1Yitdj291zlJ24WjiodaAfukDf7VRqh8cHWfbgdBWztsFNpDw
         8lvkGlO2eiJM0f2k2ugB1NvZ0jW4EgYBlw+aLavfXWDxBE6VqBby0ny0id9VnI/Y+0X3
         1lgWBSGHdvKNS3qOnR9RLtjD7trrIGFE1+mK3Xq70OqfrvXODw5qya0NISf47rwdiJMH
         r23DyBwG69bjd+byugLhFowa4MVHiXjS90swcyrBQVe8Wy2akjS0DcLo3nXTPT7QuACj
         inMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719862467; x=1720467267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPYaq5FewjWom3DFGFtD3B7b78iOp1/6FVum1jHZ6nA=;
        b=Bd1AzD7IQE9FqfllJcc/+AHdtUAVSjXZj2voFGtsxfGzU6ZfA7aFmLh1ZRsBeSMba8
         DetyT9xhOAyepCMdCSygaLB6gT0QOV1xNnM20gsujZCsO14d6CKpENo/rSxBPLJPWUFL
         qJw43LyOGh0u+Odp9INLK3nw/2n9cnMhgcjXNfyASpQHjGngH6zy7g0hkFAdYmQOgZRm
         Vh0CjZhTMQrghh0+Xph49P7KGtLn/s2MhIpecpxOGB0OYChllZYQE69XMr9p4hGsNUA9
         ae4RbMdXjuPe2S/uQx1ESzRG4THZQeAW13aIj2BW5VKkUQ5gmFsAXKZVkiw4IUlwVmms
         D0nw==
X-Forwarded-Encrypted: i=1; AJvYcCUGfbxGqKSRADEu0Ve+mcORpC4lprfVizR5mlkI6B3saVJ5UfB6G9jLa97ef6iXxfO5NAE0Xqqp//6R5JIg9hKu+3VQ6JOwGhkNM1stn7W+4KeBeFwKqIhZ0jdYiYGhJSP07p0/WKpytn7OeTtWKR2eyhaIQs/umfIsNFyIRBrFb+uOSA==
X-Gm-Message-State: AOJu0YzdgGozfB2Ybo0Q0i8/RMno0t/AcCcCXI2/engyYZwxhlQzRp8G
	0qOiUIT2vGGklbwieTZsvwE8Wgvwu0YlG2eP3Dwft45dQQidm87V
X-Google-Smtp-Source: AGHT+IE/x49jwq+1EKk7g8eziIbuhKqSy2R+oVNFp48VWsPHMIhUzf1vy/rgzhopW15bBAcDuUYiDg==
X-Received: by 2002:a05:600c:33a8:b0:425:6976:f5d6 with SMTP id 5b1f17b1804b1-4257a026ed4mr53409025e9.33.1719862466233;
        Mon, 01 Jul 2024 12:34:26 -0700 (PDT)
Received: from ?IPV6:2a10:d582:37c5:0:a6cf:581a:1e41:3fd0? ([2a10:d582:37c5:0:a6cf:581a:1e41:3fd0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b061095sm157925425e9.23.2024.07.01.12.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 12:34:25 -0700 (PDT)
Message-ID: <f9211cc1-7392-4b5e-83fe-e971b274f348@gmail.com>
Date: Mon, 1 Jul 2024 20:34:24 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] iio: light: ROHM BH1745 colour sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Ivan Orlov <ivan.orlov0322@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <20240625220328.558809-1-muditsharma.info@gmail.com>
 <20240625220328.558809-2-muditsharma.info@gmail.com>
 <20240628203701.507c477c@jic23-huawei>
 <66122c40-9c69-471c-8f59-cfb1c9b0b6ec@gmail.com>
 <20240629185046.290c7d81@jic23-huawei>
Content-Language: en-US
From: Mudit Sharma <muditsharma.info@gmail.com>
In-Reply-To: <20240629185046.290c7d81@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/06/2024 18:50, Jonathan Cameron wrote:
> On Sat, 29 Jun 2024 10:10:19 +0100
> Mudit Sharma <muditsharma.info@gmail.com> wrote:
> 
>> On 28/06/2024 20:37, Jonathan Cameron wrote:
>>> Hi Mudit,
>>>
>>> I'd failed on previous reviews to notice the odd trigger in here.
>>> What is it, because it doesn't seem to be a dataready trigger as the device
>>> doesn't seem to provide such an interrupt?
>>
>> Hi Jonathan,
>>
>> Thank you for your review on this.
>>
>> I've incorrect called it as a dataready trigger, I missed this as part
>> of my initial cleanup - apologies for the confusion caused by this. I
>> should potentially call it 'threshold' or 'dev'. Please suggest what you
>> think would be appropriate here.
>>
>> The sensor has an active low interrupt pin which is connected to a GPIO
>> (input, pullup). When the sensor reading crosses value set in threshold
>> high or threshold low resisters, interrupt signal is generated and the
>> interrupt gets handled in 'bh1745_interrupt_handler()' (interrupt also
>> depends on number of consecutive judgements set in BH1745_PERSISTENCE
>> register)
> 
> This isn't really a trigger. Just report the event and don't register a trigger at
> all.
> 
> In theory we could have a trigger with these properties (and we did discuss
> many years ago how to do this in a generic fashion) but today it isn't
> something any standard userspace will understand how to use.
> 
>>
>>>
>>> Various other comments inline.
>>
>> Will address all for v7
>>>   
>> ...
>>>> +static irqreturn_t bh1745_interrupt_handler(int interrupt, void *p)
>>>> +{
>>>> +	struct iio_dev *indio_dev = p;
>>>> +	struct bh1745_data *data = iio_priv(indio_dev);
>>>> +	int ret;
>>>> +	int value;
>>>> +
>>>> +	ret = regmap_read(data->regmap, BH1745_INTR, &value);
>>>> +	if (ret)
>>>> +		return IRQ_NONE;
>>>> +
>>>> +	if (value & BH1745_INTR_STATUS) {
>>>> +		guard(mutex)(&data->lock);
>>>> +		iio_push_event(indio_dev,
>>>> +			       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, data->int_src,
>>>> +						    IIO_EV_TYPE_THRESH,
>>>> +						    IIO_EV_DIR_EITHER),
>>>> +			       iio_get_time_ns(indio_dev));
>>>
>>> What is happening here.  You always push out the event and use that as
>>> a trigger?  This is an unusual trigger if it's appropriate to use it for
>>> one at all.  You've called it a dataready trigger but it is not obvious
>>> that this device provides any such signal.
>>
>> When an interrupt occurs, BH1745_INTR_STATUS bit is set in the
>> BH1745_INTR register. Event is only pushed out when the
>> BH1745_INTR_STATUS bit is set.
> That bit is fine. My confusion is more about the trigger.  I think
> the short answer is drop the next line and indeed all the code registering
> a trigger as this device doesn't provide appropriate hardware.
> 

Noted - thank you for your guidance.

Will include the changes for v7.

Best regards,
Mudit Sharma



