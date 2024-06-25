Return-Path: <linux-iio+bounces-6919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7012B91710E
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 21:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943891C2254E
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 19:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C244217C7D2;
	Tue, 25 Jun 2024 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkRh1Tz8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045CA1DDF8;
	Tue, 25 Jun 2024 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719343506; cv=none; b=mU+BJiMQOh0++d9P5JefN6Uj+O6BNM5ed5Pe+cveLpHWzjclataSLRn3MNWmq75nnkrB0oRrpJdKZrp+oOm1WlXsqjPyca2mXpsdBlR1oSs0ljhNBPe2x2wm9Xmqa1A84tOW7WGdYgz3xQY/35XCVMgheMumhcYyouq0hrS7edM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719343506; c=relaxed/simple;
	bh=8aSqX9hkLIrrIDQR0JhCR5LNnUahZPNJR09HnPkpNP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lh+Lo/NGwCq28ep9vbh7KpxQYk5KnD8dXjIiXzM/6mKFKOdasvHEi1IwVybzmGZWA6iaVhh2t30aCn4DmblD4QJnEjdhEthzAD6jdQu3/bRpjVMDU9Xu4CscQwEnni9Ss8DM2o/oNOKPLM4T+6/3N5kUhGm+KYnzhB05ApVhEqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkRh1Tz8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-424adaa6ceeso377505e9.1;
        Tue, 25 Jun 2024 12:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719343503; x=1719948303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNSR6fYYnr7DHgDey2nQ/LSZryKgufbR+vce5mKG6qE=;
        b=UkRh1Tz8dRb4//o2E/HJlGbEZk3QyOjX7PuwtAV4reFmlir275h+TGimAwtFN2cgnb
         p4hzjCgEIab6HJgUF6Yh7Mg0T7KCtIFMjLyzOHVI8h9nSWhfA9742wACJoq5fOLBNNwU
         ARRWIXf5huG76Wk0kB+X9kyIDe5g/BLhm3Gi3fg0aCmaqHt7N5HRWxCJdlC3DCjPRriE
         pLjUrVCWUARCdj0v5718FZwwdWVf7rD8w+uxzs8srRww098vRg0+WJC3chKWUwE8FXVx
         u9f5pfwcRx4io2rpzNAAVcr8brniT4CAG3N3S+xoQlWg/bfWIuLVxGZsPdhzVzRqFkT8
         BgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719343503; x=1719948303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNSR6fYYnr7DHgDey2nQ/LSZryKgufbR+vce5mKG6qE=;
        b=IA1KeKgYQluuftE28GOXV8NgiiLLFbBwwrdwCgdcuBPEi+sC/y0iZt8M9GxaRnv+v9
         8owBsQTrU4RAs7lDG8mQJNu8jHi48+nEvMn4SO4pvu+aBNYJK4VQpNwCgEnGm2/ipxGj
         q/MgINAldcMYFYs6Gw/lGkoIISnj4xZvV95gUlSGR3ifaQiDOn3bEmbXzga9Ox/QbJkP
         26faKfBXzO+zoggNzfuXKsIyvrsPLh3Rg5iUkXgZGv1LggsU3TL3loSahH0I5gSvevmN
         da07igf1uVIfgeNRnsVZD/K90dXIyuVkSseNVA2dtEXuU6FgwMqFvs/mrEfWd2WKD/8P
         FUnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ9f7vzMYCWNqHQR60uwEZ2MbNIdl6vi+H9DDwK8M2d0zI9i4phevLipeG6DfbT6xXSZ7DiNGjXAk4g7luW3TwwCbqxpBUxRtk2dbkOUC8xjYn8WcY5Vt01RXP0VdSCUIhQZZBwoOvSLIqmiFDwy1vpsT0mE28tbqm3FLpTFlbdBbQ3g==
X-Gm-Message-State: AOJu0YyZDLsW03r1jMJk+fHCPhxY8IKBFSyJ7z2EiO7R3SbzPs2SNQuy
	64d8HoUGKFP2txrvFwhpCwNbLNxI7+tGQ9y912zcZLc02ZKLFykgDLa+/HYZHOU=
X-Google-Smtp-Source: AGHT+IHMQadZlsFWfZONY6s/5x001YloyrvPown+lI3fxg4zwP3n0okE1igXG9gd769w0YL9T98MEg==
X-Received: by 2002:a05:600c:4f07:b0:422:97d:43d4 with SMTP id 5b1f17b1804b1-4248cc18c86mr60159585e9.6.1719343502684;
        Tue, 25 Jun 2024 12:25:02 -0700 (PDT)
Received: from ?IPV6:2a10:d582:37c5:0:a86b:b44f:15fa:ccf9? ([2a10:d582:37c5:0:a86b:b44f:15fa:ccf9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d212254sm221762825e9.45.2024.06.25.12.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 12:25:02 -0700 (PDT)
Message-ID: <7fde0674-c20a-4455-bb78-3a6521ae99ed@gmail.com>
Date: Tue, 25 Jun 2024 20:25:00 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] iio: light: ROHM BH1745 colour sensor
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, jic23@kernel.org,
 lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Cc: ivan.orlov0322@gmail.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20240624215543.459797-1-muditsharma.info@gmail.com>
 <20240624215543.459797-2-muditsharma.info@gmail.com>
 <cf06ea77-c8b0-4476-94d1-32171c96f22f@gmail.com>
Content-Language: en-US
From: Mudit Sharma <muditsharma.info@gmail.com>
In-Reply-To: <cf06ea77-c8b0-4476-94d1-32171c96f22f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/06/2024 23:27, Javier Carrasco wrote:
> 
>> +static int bh1745_set_trigger_state(struct iio_trigger *trig, bool state)
>> +{
>> +	int ret;
> 
> Why is value initialized here? If regmap returns an error, you will not
> use value anyway. I caught my eye because it is initialized here, and
> not in the other functions where you use the same pattern.

Hi Javier,

Thank you for the review on this.

'value' is initialized here for case when we un-set the trigger. In that 
case, 'state' will be false and 'value' of 0 (default value for 
BH1745_INTR register) will be written.

Best regards,
Mudit Sharma
> 
>> +	int value = 0;
>> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>> +	struct bh1745_data *data = iio_priv(indio_dev);
>> +
>> +	guard(mutex)(&data->lock);
>> +	if (state) {
>> +		ret = regmap_read(data->regmap, BH1745_INTR, &value);
>> +		if (ret)
>> +			return ret;
>> +		// Latch is always set when enabling interrupt
>> +		value |= BH1745_INT_ENABLE |
>> +			FIELD_PREP(BH1745_INT_SIGNAL_LATCHED, 1) |
>> +			FIELD_PREP(BH1745_INT_SOURCE_MASK, data->int_src);
>> +		return regmap_write(data->regmap, BH1745_INTR, value);
>> +	}
>> +
>> +	return regmap_write(data->regmap, BH1745_INTR, value);
>> +}
> 
> 
> Best regards,
> Javier Carrasco
> 


