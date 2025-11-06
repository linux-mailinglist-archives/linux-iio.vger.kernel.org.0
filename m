Return-Path: <linux-iio+bounces-25968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FD4C3BBF2
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 15:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63B014EAF24
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 14:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45F733CE86;
	Thu,  6 Nov 2025 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lZi/m8mf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1F830BBA0
	for <linux-iio@vger.kernel.org>; Thu,  6 Nov 2025 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439052; cv=none; b=YYaC8iwJdFZhH1QTdcEE85xH+TPOnO8aBwMLKoK/tCC1n1KUtRxWOenunOCBoac4hFKORWntb2jj9Y3KQahMgKvzG/uxu+8iYI9724KT45XWx6PNrfXJKf4YzE/+E71w5LGaMFI60/l9u2MA7dKS4PgjF1i6MNKSNFBnQ0+12zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439052; c=relaxed/simple;
	bh=Ve2Cua6Y5x7JZiN/l0mkL2+le072jA+6HmVmFg2sMaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtdkxSGQCKq/fKBfAIJhb7BuHCBGIVp23VfWdsRwdLO9LslTknYJnO5RNd7tlIyFJV+xdO+YgmhlHhvUSwJgcbJ8u3k2fSSA12N0Q96Zd7g28xy7n6FDKNCUsMc9/+9vhQ2collE72qcsE8NjtFo60g8jxYjDDp4FVXwNKKUV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lZi/m8mf; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so1214309a12.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Nov 2025 06:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762439049; x=1763043849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBGZoHNjV7rP3ZwyXMhZHV9qS2bMMg3F8+53EMom6ek=;
        b=lZi/m8mffnFBeO+dCMgynIiMynn+1qOrh0940Vz6Vjzmrx6xhd0CnKa+Pc46ifIz7N
         TldHB9x7QArw9BiFWNBKkbkFw86qfGW7YfXQjaU28cr5j5tsPZzurAh5g4Epr6F4Mz4m
         2yVQB11ZLFe6gPaKxMp2TqPQxQXpG/JFe6s3vszMZKXBeE/94cswixUyL3GLWft0LZ07
         hbeQFpUOnLH7QEw+1c6x5FJZUNKwoOroP9WsWlw2cJtduKvICdQHTzXPL9atZUTGy5Nt
         +T0jMep3eeQeljg+UxiQM0qps1sqGSUkLjPD9wWo5RbF+3x1R7xZM11TXtS8qf2DEZfe
         UvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439049; x=1763043849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBGZoHNjV7rP3ZwyXMhZHV9qS2bMMg3F8+53EMom6ek=;
        b=LayDzOV0MEEQuq2hIM+DhikDphqBv4rOfWNr61NVcVWM4YgQv9rlVcqj5D2tQZZbjG
         dgNBvxwXngDfnerTrqI6Y9kBlW7pfuqan7CCRkL4hxPkZzSpt1uD7MUwyzkPLe6z8cZd
         6blZR/QOZWfpHu8EWZ+Huo3mTh3+Fql6+GbWhgyiG5Shd3UGIHF4U8vyrORunHxsNUAI
         4EHjzZHJGpIRcinl7D1yKc0zqMW65gAFetr2/OF4TBn0+Qp/BCgKUFXYpBzAxlIv/u4R
         THEgPhYpGCjxthwE3LTCqKUhbfJc/vCsoCUPB4p5mFCenKRLAcLjwvCv+sQVGJgTlg6i
         Hj6g==
X-Gm-Message-State: AOJu0YxlsaMYb5dM9pX9Iwf8tMX1H+pTEqrEYTlVTw9KpEJ719dxeBaw
	Pu/xsZG/zg+dzRHoy16SDWE6ifFdwwU3yHt6OqWf/E3VdfbNhUguGU70H97KaitNdi4=
X-Gm-Gg: ASbGnctWwc+7+3B7ZSwsFwl43aMqrUuEVIVxiPI8hzzNFtikdGC/uLlCfACtvU16DAo
	YTi2BbGAsjRoJZXMS2JOdwBi8iJXHXxR0Htv3HPZzc38DiAJXCKyaDjsCo4VeKvPrCmqRibl7lL
	Zrl/MeVCYjzc7c+PbErrO1KUWj6CCXz80GXViJ9Gc/Mzj2iO2qod0NgMNLGJDwHj1WnGrDN5EZJ
	HrqnhlJPreMWs0RD3mgX5QCfldcMxk2dutTI9lpOGgLiXs6HgrUoyS6nwLf13gSOcOgzZdJ+huc
	c1ZPeEbO48T/P6CJsXwOZ91XT/70d+AAMM+gMnADcnjNlTKnM3Qn9GjlhxyAbxU9sfAed6IOL4k
	uFUjDsXOmCuETltd1IDNLThGf+bBLho/BVFelHHMAgBlfdk2/XdM2FlkZDaNlFIGeJ+AEJIuGxz
	9RtwJMb0bsDLiPHfHML67x
X-Google-Smtp-Source: AGHT+IFJQwc5igxE+SGlKDBP9k3w+n4h+84+Jq8CqIZHXI6J7F5RLEKhdKuk9mv4aoUzLxdAQAwT1A==
X-Received: by 2002:a05:6402:13c8:b0:640:fb1f:e95c with SMTP id 4fb4d7f45d1cf-64105a44b72mr6838423a12.20.1762439049121;
        Thu, 06 Nov 2025 06:24:09 -0800 (PST)
Received: from [172.20.148.34] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8578dfsm1936167a12.24.2025.11.06.06.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:24:08 -0800 (PST)
Message-ID: <cbd2f040-9377-4862-ae52-aac35adb1b9d@linaro.org>
Date: Thu, 6 Nov 2025 16:24:07 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: adc: at91-sama5d2_adc: Fix potential
 use-after-free in sama5d2_adc driver
To: Jonathan Cameron <jic23@kernel.org>, Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <90dec520a9537af2feab9d56b22d99878fba9e2a.1761705396.git.xiaopei01@kylinos.cn>
 <20251102115458.4d37556a@jic23-huawei>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251102115458.4d37556a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/2/25 13:54, Jonathan Cameron wrote:
> On Wed, 29 Oct 2025 10:40:16 +0800
> Pei Xiao <xiaopei01@kylinos.cn> wrote:
> 
>> at91_adc_interrupt can call at91_adc_touch_data_handler function
>> to start the work by schedule_work(&st->touch_st.workq).
>>
>> If we remove the module which will call at91_adc_remove to
>> make cleanup, it will free indio_dev through iio_device_unregister but
>> quite a bit later. While the work mentioned above will be used. The
>> sequence of operations that may lead to a UAF bug is as follows:
>>
>> CPU0                                      CPU1
>>
>>                                      | at91_adc_workq_handler
>> at91_adc_remove                      |
>> iio_device_unregister(indio_dev)     |
>> //free indio_dev a bit later         |
>>                                      | iio_push_to_buffers(indio_dev)
>>                                      | //use indio_dev
>>
>> Fix it by ensuring that the work is canceled before proceeding with
>> the cleanup in at91_adc_remove.
>>
>> Fixes: 3ec2774f1cc ("iio: adc: at91-sama5d2_adc: add support for position and pressure channels")
> This ID doesn't exist in my history  it should be
> 23ec2774f1cc
> 
> I'll fix that up whilst applying.  Ideally I'd like Eugen to take a look
> but I'm fairly confident so I'll queue this up on the fixes-togreg branch
> of iio.git and mark it for stable.
> 
> Thanks,
> 
> Jonathan
> 
> 
> 
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>> ---
>> changlog in v3: move cancel_work_sync after iio_device_unregister
>> changlog in v2: use correct Fix id
>> ---
>>  drivers/iio/adc/at91-sama5d2_adc.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
>> index b4c36e6a7490..aa4ba3f5a506 100644
>> --- a/drivers/iio/adc/at91-sama5d2_adc.c
>> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
>> @@ -2481,6 +2481,7 @@ static void at91_adc_remove(struct platform_device *pdev)
>>  	struct at91_adc_state *st = iio_priv(indio_dev);
>>  
>>  	iio_device_unregister(indio_dev);
>> +	cancel_work_sync(&st->touch_st.workq);

Hi Jonathan,

Can we push to buffers *after* device was unregistered with
iio_device_unregister() ? Is that right ? Both Pei and I considered it's
not.

Eugen



>>  
>>  	at91_adc_dma_disable(st);
>>  
> 



