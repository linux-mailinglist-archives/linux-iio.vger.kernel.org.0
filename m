Return-Path: <linux-iio+bounces-12078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910609C2DC5
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 15:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02101C20B7E
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEBD155315;
	Sat,  9 Nov 2024 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDr8KXMb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6E145A1C;
	Sat,  9 Nov 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731162772; cv=none; b=bk9C5MijPOcAXXsFNTvNBMiMHS04T/mdvd6LhbFI5yiWiJ7tjo6Y4/MDLis2O4O1c0VpCCCwqQnueFjutxJicrjlZz9hmauSikD0hWOGbQSXZAsOAxZ6WXwsqnPFG6JY3LcDEMrQl6kpCunUJQzv+T5YeDSkIYNo6BBzfppCwDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731162772; c=relaxed/simple;
	bh=97kYtPme1bD6E36ZlKmbVJQObN5gxrjhD0P/oXlGwpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9Gj7kWPaX9NF/TEdScfbdjTXfunHnd6AFBHOnw9466vITHy6GlR8puKyM6OxftGBAs0E57TkRn73WvqV6NQN6C5e79pJ9otTO/6r+wOlnkkMu3XGIaQPgeIwm4ojHhpsFv3Mgw3amxdk/G5aQOuvaIyG2LX/skAlvFMA8BEMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDr8KXMb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso37576365e9.0;
        Sat, 09 Nov 2024 06:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731162769; x=1731767569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XeAahN8yYobYf4xp4nox3tLy6OuPxlThQAbBcmO08Rc=;
        b=VDr8KXMbp8GmjUvn+mw+Dw8/sVl5XNV37ASZsFqq/uE/VkPAi842NA3f6VG2ezvArF
         P4tody9FSRgTvQVOUmhwN7/g++DXEaQDDbXbP5FF7fJS7QAiZZtGURU0JUAIdNy9U1Zn
         OSIO9MgPfNsqGD/pJsp/70jePAaSAmUmjKou2W1B7eRkHxzt0S14bXPXYpdgemE5ANsH
         BalrluJfBXq00G9UOV9rnOIlk0Z0oDW2wDZ3tlfe1wsv+nc+fgl8p1DhnWWri9bPvsKv
         u+EBja7dmy+WL3pUJIJiRjpMtnihx92iRUz4f2jcGMLJ1M+WbcHrv45963SpTwIofx+w
         5zIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731162769; x=1731767569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XeAahN8yYobYf4xp4nox3tLy6OuPxlThQAbBcmO08Rc=;
        b=Jf6rc7DnrRSFNvkRYN0xFZccir6+kz628WSdZfelgWBvv0diqvITebPbn0MiM1RpAQ
         TVTM8malF/F1OqFY/nz1NZlbB+6lw6sG8E1w9rHAwyTJ2Jt405vLaWYed3TlwwmTECUH
         SxK6odlMMonPTaYLoiQD4cD0nOHXeVCHsSF9NnY6/PAeMqtwl45bX1mqm8BMB5eaIAuQ
         V71+bYZQCdNczxmb/AEm0nRAarfZsKBc00Wk6xb2yftGfe6i64DEye/5pDn5MDaMhZwl
         6ncwEvJLb64xHJirmGPttsya4zzRWUcKodzMoQfB85duVhuF9F1bhE97MhWi+pzS03Xy
         HA8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdwcu+FetAodm58fCTx4JCmoWCq96hae5jJM8s1KXDVeEdd1jtkEpGPUH+g2sDqq8tyiggOrHxPI4vcCg8@vger.kernel.org, AJvYcCWrtNMapiRYlt1LVr4ilr39SZq1lq7UPs1To1/wcBYANd+STMVsJnAcXYDkoNzlje5APyNcrG1Q3oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhaMQ/jDrtDG9+aeoA8tmd1KQd7+9cmKHIB2ELTwXGYvxaUTds
	PTjw3KnDelVNutTQ89xfQYtN0G21mUex0rhdLm+x5ssS9twnLofF
X-Google-Smtp-Source: AGHT+IEATuqlHAQ2vkI6fAIFGnoe6/GY3yDJKWwUvDwmPw+7tfNtp7mzxGCp5F+DJBr9Hc6mliDwMw==
X-Received: by 2002:a05:600c:3586:b0:42f:8229:a09e with SMTP id 5b1f17b1804b1-432b751ef96mr69882965e9.29.1731162768841;
        Sat, 09 Nov 2024 06:32:48 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:c446:6b17:3107:cf45? (2a02-8389-41cf-e200-c446-6b17-3107-cf45.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:c446:6b17:3107:cf45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054b3fesm106366775e9.17.2024.11.09.06.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 06:32:48 -0800 (PST)
Message-ID: <8c9b1e43-f47e-46a5-9189-fbe73b16ff7b@gmail.com>
Date: Sat, 9 Nov 2024 15:32:45 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: veml6030: add support for triggered buffer
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241107-veml6030_triggered_buffer-v1-1-4810ab86cc56@gmail.com>
 <20241109132729.1459cf0a@jic23-huawei>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241109132729.1459cf0a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan, thanks for your feedback.

On 09/11/2024 14:27, Jonathan Cameron wrote:
> On Thu, 07 Nov 2024 21:22:45 +0100
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> All devices supported by this driver (currently veml6030, veml6035
>> and veml7700) have two 16-bit channels, and can profit for the same
>> configuration to support data access via triggered buffers.
>>
>> The measurements are stored in two 16-bit consecutive registers
>> (addresses 0x04 and 0x05) as little endian, unsigned data.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Hi Javier,
> 
> Some comments inline below.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/iio/light/Kconfig    |  2 ++
>>  drivers/iio/light/veml6030.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 86 insertions(+)
>>

...

>> +static irqreturn_t veml6030_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *iio = pf->indio_dev;
>> +	struct veml6030_data *data = iio_priv(iio);
>> +	int i, ret, reg;
>> +	int j = 0;
>> +
>> +	iio_for_each_active_channel(iio, i) {
> Given you've set the available_scan_masks such that all channels are on
> or off, you should be able to read them unconditionally.
> The IIO core demux code will break them up if the user requested a subset.
> 

What I wanted to model is that both channels (ALS and WH) should be
accessible, but allowing the user to request a single one, as the ALS
channel is usually more relevant. It seems that in that case I should
leave available_scan_masks as it is, right? I don't want to keep any
channel from being accessible.

> If it makes sense to allow individual channels (looks like it here)
> then don't provide available_scan_masks.
> 
> A bulk read may make sense (I've not checked register values).
> 

In my interpretation, I thought that I could read a single register if
there is only a single active channel, instead of using regmap_read_bulk
unconditionally. the data registers have consecutive addresses, and a
bulk read is possible, though.

What approach is preferred in this case? Reading and pushing both
channels at once without any loop, letting the IIO core demux do the
rest, or reading only the active channels as it is done here?

>> +		ret = regmap_read(data->regmap, VEML6030_REG_DATA(i), &reg);
>> +		if (ret)
>> +			goto done;
>> +
>> +		data->scan.chans[j++] = reg;
>> +	}
>> +
>> +	iio_push_to_buffers_with_timestamp(iio, &data->scan, pf->timestamp);
>> +
>> +done:
>> +	iio_trigger_notify_done(iio->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}

Thanks again and best regards,
Javier Carrasco


