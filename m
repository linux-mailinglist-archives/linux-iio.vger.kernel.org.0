Return-Path: <linux-iio+bounces-12941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A5A9DFFA9
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 12:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BB9160626
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 11:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1B51FCFC0;
	Mon,  2 Dec 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxVQmLsE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C171FBC9E;
	Mon,  2 Dec 2024 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137531; cv=none; b=bYzs5qO/cE1j9eRK5m6YJ1wn4UnRcrSUomwj0Sa4gh5+3hMhX60FiDlavGfnQSFPuumzbTjmGJQZCi+XwQVT04FLxnR8TwzDInE2w9Vhwu1P7Y/KsdDjwfWhNRmIyDVIZYJhdzWIXconuADMpBUxRCLMbg4VE9aIgXJ30gxnjLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137531; c=relaxed/simple;
	bh=1sYak3cuRCq5GY57CnsyhYDpYhlm2E5QeWuWN5eGYys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMcQx2+R+3vXRAsXPkO+OukgTUt6zXapKipUGqCemjBChERPV3f/X3qWgq6O3XgAtaJJU9/Dg+sotNl3EmDShqLEXpnd0efjiMsAEXfbot4d6jK1+4kaMBU3hi9bSV+L1jBAi4SVXMOytBzEwG2StvSoY6cUAsg376O67xqnJoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxVQmLsE; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53de852a287so4607534e87.2;
        Mon, 02 Dec 2024 03:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733137528; x=1733742328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uu0zS28pDaBagRkiedQBFXcTK0YW989CQebdf4iD8HE=;
        b=OxVQmLsEGBWsg1YtMXcnmYRsxdoL1hGZnu49HQWP5wPasjKoQzbFu5VJ3KEGhuxZuX
         kWMgvQINilaTknsDnJmLWj7O7kj01w8oT5GzbRxNvnp5PpmUMJEwnIuXiT6RiNVr5LAY
         bFSkILipYCal/cafzBnm/y51002rnvGeoS1LANAjbjLKuxSIL4foWbk0b281gCtovUms
         w4D2Q043n94q0diCmspmIT7yUGEK9c5NtvgSJk4DEy0Z0hSkAufF7Cz0ZHNgYDcMgOP/
         sEB7POqTPIMVr34v7/Qhto7qEQAVHgSA1ea9jMQaDdZTDCeLWDxrBudr9znfuiGfuKoB
         hNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733137528; x=1733742328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uu0zS28pDaBagRkiedQBFXcTK0YW989CQebdf4iD8HE=;
        b=RUuoP4k1CUUgDk7CUREYC+rKBNA9u+15tn1goSnYa3scdxZJ+ialCyXLj4pJ7Hk0JN
         WrJEhZztuPqXOynM2vjVdWR+GHcgiY4T4abFSr5OvuMd22/xLKc+Z+aDTXMqij0atDjp
         ktTlzcCAJhkbci5prcXVrrfJZbtomLtWwP55ADQpFSrTl+mdaJv1nXdbaj8+MaNc86d2
         9CFdLHS94c1PNQL0l63Mg77Oo802nf6WOBw6dYkgtRJAkJjqruO/jXq4rzcWEPpKj9mY
         S9kbXE4IJ39WpfBIQW8bdO9kEduX6dar4hrxV06ksyQNmvyn/YdqJsrlOUHvwChbcLCc
         /hHg==
X-Forwarded-Encrypted: i=1; AJvYcCU9Gr0N+XcPOca9TGuawNJF9juuQaR47chrSYb4GqctutooIRvz0C1jaYQeoiNiXXUanlqvRzl0PkQw@vger.kernel.org, AJvYcCXJCTLKMqGCXGHhIgTfMyeKOG8r8E+s6XGK3/uQQN9PDJi1u2QuhK6KdtCPB/ydhbMH9TnmxvScbYTY@vger.kernel.org, AJvYcCXUp0YjvQc0bYRrhIA+Yl3kJmVVxcGCBwAmZh+7y8G2cftSlDutLMfg5vHCqgNJAeMLfOaolNIcLTP4rS6Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl1fnxAedkPKPOmUDSnMH83WX3Pz9R06efbN1FI6yZCSPeSxPu
	Cy2i6lHSBECpjuMjtwwJcgHlVx5M3kG7PA1p3qUWylLYKIn+Pmxv
X-Gm-Gg: ASbGncuTFWoUKRWw7fOwsSkJz5PcvEeapnLhj6IUteIM5FxOS5tKwPQpNymAp4r5vhr
	GAY+T/RSNDFMwA7DPivRxtBjhuNaQWD4T+2K9LJk7iOWmTF27A9tgxAUkzvh8wivzkd4HDTeJqW
	bk06ZXeRHybwehg1UK3dIueRypx0mrbemtfqp4TpISuQxWxYV1f0txMkSdadXnuRiClwNJiePJV
	3C42qPz6TOFSuGp090qF5vDeVA9l5v3FNuqOn7ZHcH9VKhqnZ300FQj0AzkEk0oOnfRCv+aQ1dM
	VjxkCOGAFRa1x2dulaXo7P4Zo/CPenI=
X-Google-Smtp-Source: AGHT+IHJ/ldxxdVE8q6UHKkJydQA5phLfWvYSU924t20aswrS8s0hNVnWrCwGluXgOaN/mFoO+Kq4g==
X-Received: by 2002:a05:6512:3e08:b0:53d:a5c8:aaa6 with SMTP id 2adb3069b0e04-53df00d2c5amr6461246e87.13.1733137527730;
        Mon, 02 Dec 2024 03:05:27 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a07d8sm1440953e87.275.2024.12.02.03.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 03:05:27 -0800 (PST)
Message-ID: <108cb61d-df0c-4224-9e81-c642de81e147@gmail.com>
Date: Mon, 2 Dec 2024 13:05:24 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] iio: accel: kx022a: Support ICs with different
 G-ranges
To: Mehdi Djait <mehdi.djait@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1732783834.git.mazziesaccount@gmail.com>
 <fc667b1495adf4e3f29ecbb336495c1f18b47e61.1732783834.git.mazziesaccount@gmail.com>
 <4waoywlqb63yav6q3rdvqnwbihxccgl6p5y7f72yzdadnlzezz@g4fz63owgguj>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <4waoywlqb63yav6q3rdvqnwbihxccgl6p5y7f72yzdadnlzezz@g4fz63owgguj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2024 12:25, Mehdi Djait wrote:
> Hi Matti,
> 
> Sorry for the late answer. I know that this was already applied so maybe
> you can post a really small follow-up patch ?
> 
>> diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
>> index 7060438ad88c..36e9d9de8c13 100644
>> --- a/drivers/iio/accel/kionix-kx022a.h
>> +++ b/drivers/iio/accel/kionix-kx022a.h
>> @@ -161,6 +161,8 @@ struct kx022a_data;
>>   struct kx022a_chip_info {
>>   	const char *name;
>>   	const struct regmap_config *regmap_config;
>> +	const int (*scale_table)[2];
>> +	const int scale_table_size;
> 
> Could you please add kernel-doc for these two new elements like the others already
> have ?

Thanks Mehdi. I think this makes sense :)

Yours,
	-- Matti

