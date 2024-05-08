Return-Path: <linux-iio+bounces-4884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3288C0002
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 16:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96451C233C3
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 14:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BD97C0AB;
	Wed,  8 May 2024 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbziYtq8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202142575A;
	Wed,  8 May 2024 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178759; cv=none; b=rZiltHY6MgmfEUwiZLmTpMBVnNRI+9wMvMz2YwfNvQNF625fz4RycxhtdQ7n7aI4+dwrw8Y5IuvicBR0ir5ra4BY22VLG/WbklLIHA4rB6623WCQpOI0DVNniBOCRmBkQjGQlV6E5aKLzqU5zQ5E/6Kh6zTem50Jw5FxmoBEL8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178759; c=relaxed/simple;
	bh=oj63ouKpfDlDfTL/RNh6p+xuT5dFT21ACWDeoMAXWQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekgPpLAii9RxDNGGh7OSjlvR84aKi8hTvkA3aeVGd9ZWRUzE/3AX9f7GzCC9GP7Hp4ALSKhRRzyK/oW/QMIgjlVmdOV15JCfbOoB6gLU2A/1XfZSJov8KpXMLmq9ZyrEka8Cjm2kTQhdusyD+recSHAuDXULy8OkWCPjpfrnO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbziYtq8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41b79451145so33225605e9.3;
        Wed, 08 May 2024 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715178756; x=1715783556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ysuS9s45cXIq/QGNikc88+ChWM3Bs7tDYJ9bNDy61j0=;
        b=JbziYtq8ge0m6uq/5KqpOHIAX9j4Vllx/hXsI/oX3//ya8RBcZjEJhVmUAeeL3VtH6
         E9YrCogqaY7U/xeLtfgtsp1VuqUVI2lwKa1j+FO6SME9e+2Ebiuh9YyYJEluF34OyFC3
         BuJ9JLoN7lt5o1iSAtFC1aXkWIywm/PmgDe8VKY3k0h8R9N/Mr5aLVvekjfBwHB5d3c1
         JukBZcc5htYD/Dr5Ul8IHqKb2uUbHEY7ey801VVu/PObkB/qVXiBjqa9R/21Na+HmjWx
         RxJ7E7SUHQ3ttymWbA9vNAfchbAUXPqbDypGjBRhWqmlmoxVzjoeYITuxx/OxTGprVsQ
         mNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715178756; x=1715783556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysuS9s45cXIq/QGNikc88+ChWM3Bs7tDYJ9bNDy61j0=;
        b=tNWuU7YnAeJastSWXtbQLbN9rjFfeL+ercO/NlxKBMehjgt6CEEOzLEUi9y9iLBw1f
         S4n4TP+wYfXL6UacudDVikO1UshXlgOsm43BeL9dGhXPIZ2CzIliWj3whoyOgckdfkBT
         xZ5U3ZMrK+rjJePDOK9FihC8LWnQzkIwgLsssgByT/FNwqvr/q+tCAzey110m7pKYjcF
         9Mi5oaH6/pdfaEu2eo0kqmjMZYIzUEzk2ZRszllfN645peN90ShlGZfK0fYeZPSzjAPl
         Y3bItESWKFcmFvIOlxbLctgvM6xtiE3+UnVaocxXDxTmab7JBn/P8FKnCMJ3ybr+1Lm0
         LxzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj9ienH0Eg1QtJoY7EIyszrnPOv/ci0WxfaP7gYNIqJrzIsAzqvhDuDjS0XE13P5bg76MZPpi/yoB8ew+V7jgWU4vj4NWr09OZfOH+g+NFtBb442A17xjhbzgQyP50IUZB9oqYNw==
X-Gm-Message-State: AOJu0YzvFGQqTeC2YuRfmxFn5cdER+rNcZNmXHJGtNbc9xs/qTw+wPSZ
	3S7Q1MhwWNNv/gILIzeaMSxg/KydQrJpHmMn6FWTsneOuOVkRLTA
X-Google-Smtp-Source: AGHT+IF7JyJMW/2+y+417Mt+FzxeX3YJfo5b/Vq5CftloTSaSuNJ0N9CXhAzJycKfVv9t6i5ee3aXA==
X-Received: by 2002:adf:e6c6:0:b0:34c:a509:6138 with SMTP id ffacd0b85a97d-34fca623484mr1976806f8f.49.1715178756097;
        Wed, 08 May 2024 07:32:36 -0700 (PDT)
Received: from [10.76.84.112] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id cm11-20020a5d5f4b000000b0034dd27adb2fsm15500861wrb.107.2024.05.08.07.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 07:32:35 -0700 (PDT)
Message-ID: <9f0a8fdb-dd34-4a53-948d-d4ed0410de6f@gmail.com>
Date: Wed, 8 May 2024 17:32:34 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] drivers: iio: imu: Add support for adis1657x family
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
References: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
 <20240426135339.185602-8-ramona.bolboaca13@gmail.com>
 <20240428154523.17b27fa8@jic23-huawei>
Content-Language: en-US
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
In-Reply-To: <20240428154523.17b27fa8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Jonathan,

Some explanations from my side.

>> @@ -437,6 +467,130 @@ static int adis16475_set_filter(struct adis16475 *st, const u32 filter)
>>  	return 0;
>>  }
>>  
>> +static ssize_t adis16475_get_fifo_enabled(struct device *dev,
>> +					  struct device_attribute *attr,
>> +					  char *buf)
>> +{
>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +	struct adis16475 *st = iio_priv(indio_dev);
>> +	int ret;
>> +	u16 val;
>> +
>> +	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_FIFO_CTRL, &val);
>> +	if (ret)
>> +		return ret;
>> +	val = FIELD_GET(ADIS16475_FIFO_EN_MASK, val);
>> +
>> +	return sysfs_emit(buf, "%d\n", val);
> As below, might as well put the FIELD_GET() in the sysfs_emit rather than
> writing the local parameter.

In all instances where I did, I did it to avoid casting. v2 inlines the values and
the cast is needed to avoid compilation errors.

> 	
>> +	if (adis->data->burst_max_len)
>> +		burst_max_length = adis->data->burst_max_len;
>> +	else
>> +		burst_max_length = burst_length;
>> +
>> +	tx = adis->buffer + burst_max_length;
>> +	tx[0] = ADIS_READ_REG(burst_req);
>> +
>> +	if (burst_req)
> If !burst_req does the rest of this do anything at all?
> If so flip the logic as
> 	if (!burst_req)
> 		return adis16475_push_single_sample(pf);
>
> 	the rest...
> 	return spi_sync(adis->spi, &adis->msg);

The update is needed even if burst_req is false. The adis message has to be updated
based on the burst request value, which is then used either in 
adis16475_push_single_sample or in spi_sync call.

> 		
>
>> +		return spi_sync(adis->spi, &adis->msg);
>> +
>> +	return adis16475_push_single_sample(pf);
>> +}
>> +
>> +/*
>> + * This handler is meant to be used for devices which support burst readings
>> + * from FIFO (namely devices from adis1657x family).
>> + * In order to pop the FIFO the 0x68 0x00 FIFO pop burst request has to be sent.
>> + * If the previous device command was not a FIFO pop burst request, the FIFO pop
>> + * burst request will simply pop the FIFO without returning valid data.
>> + * For the nth consecutive burst request, the
>> + * device will send the data popped with the (n-1)th consecutive burst request.
>> + * In order to read the data which was popped previously, without popping the FIFO,
>> + * the 0x00 0x00 burst request has to be sent.
>> + * If after a 0x68 0x00 FIFO pop burst request, there is any other device access
>> + * different from a 0x68 0x00 or a 0x00 0x00 burst request, the FIFO data popped
>> + * previously will be lost.
>> + */
>> +static irqreturn_t adis16475_trigger_handler_with_fifo(int irq, void *p)
>>  {
>>  	struct iio_poll_func *pf = p;
>>  	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct adis16475 *st = iio_priv(indio_dev);
>> +	struct adis *adis = &st->adis;
>> +	int ret;
>> +	u16 fifo_cnt, i;
>>  
>> -	adis16475_push_single_sample(pf);
>> +	adis_dev_lock(&st->adis);
>> +
>> +	ret = __adis_read_reg_16(adis, ADIS16475_REG_FIFO_CNT, &fifo_cnt);
>> +	if (ret || fifo_cnt < 2)
>> +		goto unlock;
> I would break these conditions and add a comment on why fifo_cnt < 2 is
> a reason to just return 0;

Updated this in v2, and actually fifo_cnt can also be 1 so the code simply
verifies if !fifo_cnt.

>
>> +
>> +	if (fifo_cnt > st->fifo_watermark)
>> +		fifo_cnt = st->fifo_watermark;
> fifo_cnt = min(fifo_cnt, st->fifo_watermark);
>
> This confuses me though as normally overreading after a fifo watermark is
> both safe and the right thing to do (as reduces chance of overflow etc).
> If we need to clamp to the watermark for some reason, add a comment.

Removed this in v2.

>>  
>>  			ret = __adis_write_reg_16(&st->adis,
>>  						  ADIS16475_REG_UP_SCALE,
>> @@ -1467,7 +1888,23 @@ static int adis16475_config_irq_pin(struct adis16475 *st)
>>  	 */
>>  	usleep_range(250, 260);
>>  
>> -	return 0;
>> +	/*
>> +	 * If the device has FIFO support, configure the watermark polarity
>> +	 * pin as well.
> The pin is for polarity or the polarity is for the watermark signalling on that
> pin?  I'm not seeing a datasheet yet for these parts so I couldn't check.

The device has a watermark pin, which can be used as a trigger source.
In this case we set the polarity for the watermark pin.

>
>> +	 */
>> +	if (st->info->flags & ADIS16475_HAS_FIFO) {
>> +		val = ADIS16475_WM_POL(polarity);
>> +		ret = adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL,
>> +				       ADIS16475_WM_POL_MASK, val);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* Enable watermark interrupt pin. */
>> +		val = ADIS16475_WM_EN(1);
>> +		ret = adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL, ADIS16475_WM_EN_MASK, val);

Best Regards,
Ramona


