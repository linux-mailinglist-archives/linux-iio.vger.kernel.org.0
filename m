Return-Path: <linux-iio+bounces-7762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1437693827C
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 20:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FE71C2100F
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 18:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ECA148848;
	Sat, 20 Jul 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCEzX/nH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA766145B38;
	Sat, 20 Jul 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721500173; cv=none; b=GFfaoaPMsGKX9fRCwi5wqaLuHWW5h/YMR/2w8RHnbywy9f8w4Zx7RrEmhgnppH53czP1Mjo0nrmZLx/Dx7HTcv6CR1lRUuWK7dgZSeMROEeDlyOU7CHA3Ts994B5lzuDTcgQtQ5vGdZYrI46ezbICgmuFjtpCZHt3s50P04ZxGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721500173; c=relaxed/simple;
	bh=56y0ZJPJ0ehnfj79RruU9p6Nlgz78bFgHO8qkjo8RoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlrXWvfTjWByA6UglkRtPcMqDWrA71HivrncreeQcYHyV/ZD376tTEHJ5weLFY7zZ3Jj9L0jYiX5200n4CWXRuu1NMs2yaOMcmTnK+9MotXt4Jl49kisLOXUY+PBo61pkNAq+z27f8kOQOE0bw1a2jQe1AFbWoKWfNKvkgXnxKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCEzX/nH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266fd39527so21472035e9.1;
        Sat, 20 Jul 2024 11:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721500169; x=1722104969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nRcMSep/74U/nixF8wvi6Qw4j/lKWIWJqpBRZ2PYTFk=;
        b=dCEzX/nHazTthqwC3WFrsgCDrVHiwqUNQ+Nc/jXlpVT+q8jXjkj4ClJC5EfdzvRMXL
         2CIHJwIEZIyCy2Dw31GLRqEGADID5NrXL2qs/g7cZvHvMPP5Ne9YAVxhjsOi2mAyZa81
         /1Mz26IUSr0Hx3AcvyaPPjE/D6ScAiyMK6O9iZOSJVLm1K6j+CPdbEpxbwZxWUEgASlz
         8rQxCGC5wOnx4IVkWV2CY/gqNi95t6PWzYK/Pij32v8v0h5pf3w3vJJWYW56wGR5SJ37
         rMD5MjdSSa8ihDjsOE0jUoBIkQF9Jy1lsaISJe78yFham7nLsVuOUEaYwBgYbhvZnL+X
         /tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721500169; x=1722104969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRcMSep/74U/nixF8wvi6Qw4j/lKWIWJqpBRZ2PYTFk=;
        b=RDmsVeJgGpBW5gWJZuDiBveHGUM3aAlkBM89Lz4mUusW7l6/Z8cX9sDdd6ECXg/v2O
         wX9hrvJNUccuvobTaHTg5BaImzlmpiW4gA2LTwt76s1ylc2mhClpoR2fXLLj4yRMIMEn
         3O0mLR8sLxBgb+MQOaKKy6Y+FW4xI8On1ewINnuc+57zPnpr4OuUlQCff80vZRY4lq/N
         ZVzFOCKW/gBo1rERyOr2tCUpVTgptacuBAhzgA5DuxEYYhwl5gzLGwQp7pEf91SS05Mn
         OV11Q5YUDPP4WGMOJ7bic5TO+cKrVfa4qjs6q0vNHVxX21+hS9HXImPoQuQktkpYIe7K
         iE4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUR21tdOSVVWyTFYfr6Fw24ZcN0h6+ZTXrhPraTbyRvKYo6MqCcLkZGsjmAYz92QX+/lNXPdkQqY/Y+pPNNDitn4V5GqI23InaTtqplzuMaaDJDCCMLHWd5gp9J20RLMpOYT96rww==
X-Gm-Message-State: AOJu0Yz/iyIBuZSZVIQfU2rsQ9l5+q0sZw6SxUqe4Esbr5CaAFQSBFyd
	Yu4nWVTLcIy4XVd5dpCnQazgve4QkqxBExKbgWA3CH0M4tekEkf0
X-Google-Smtp-Source: AGHT+IGJfBLRqrkHGoMrPGuQSRPrzvno2ZlX7NkF7liQ40KU25sL8dXVyLjfXzt5PbUemT2LzWUYeg==
X-Received: by 2002:a05:600c:1392:b0:426:5c9b:dedf with SMTP id 5b1f17b1804b1-427dc51d3bemr10580815e9.12.1721500169056;
        Sat, 20 Jul 2024 11:29:29 -0700 (PDT)
Received: from ?IPV6:2a10:d582:37c5:0:b6a4:402e:7bc0:d8af? ([2a10:d582:37c5:0:b6a4:402e:7bc0:d8af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8d8f9sm92188895e9.37.2024.07.20.11.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jul 2024 11:29:28 -0700 (PDT)
Message-ID: <cbefce0e-e5f9-400c-a387-f60609f5bba3@gmail.com>
Date: Sat, 20 Jul 2024 19:29:28 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] iio: light: ROHM BH1745 colour sensor
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, jic23@kernel.org,
 lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, mazziesaccount@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Ivan Orlov <ivan.orlov0322@gmail.com>
References: <20240718220208.331942-1-muditsharma.info@gmail.com>
 <20240718220208.331942-2-muditsharma.info@gmail.com>
 <2505dee2-c503-4566-a4ef-73103da9479d@gmail.com>
Content-Language: en-US
From: Mudit Sharma <muditsharma.info@gmail.com>
In-Reply-To: <2505dee2-c503-4566-a4ef-73103da9479d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2024 17:02, Javier Carrasco wrote:
> On 19/07/2024 00:02, Mudit Sharma wrote:
>> Add support for BH1745, which is an I2C colour sensor with red, green,
>> blue and clear channels. It has a programmable active low interrupt
>> pin. Interrupt occurs when the signal from the selected interrupt
>> source channel crosses set interrupt threshold high or low level.
>>
>> Interrupt source for the device can be configured by enabling the
>> corresponding event. Interrupt latch is always enabled when setting
>> up interrupt.
>>
>> Add myself as the maintainer for this driver in MAINTAINERS.
>>
>> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
>> Reviewed-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>> Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> Hi Mudit,
> 
> a couple of nitpicks inline.
> 
> ...
> 
> 
> Typo in debug message: corresponding. I would recommend you to pass
> codespell to checkpatch. It will often catch such things.
> 
Hi Javier,

Thank you for reviewing and the recommendation. Will keep in mind for 
future patches.

Best regards,
Mudit Sharma
>> +		dev_dbg(dev, "No corrosponding gain for requested integration time\n");
>> +		return ret;
>> +	}
>> +



