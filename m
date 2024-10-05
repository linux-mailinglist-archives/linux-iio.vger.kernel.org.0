Return-Path: <linux-iio+bounces-10211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810A7991953
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 20:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B6528127F
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 18:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BE7158D8D;
	Sat,  5 Oct 2024 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+8iAKpl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398331552E0;
	Sat,  5 Oct 2024 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151985; cv=none; b=r4NSyIWJWv4c8qesNHSXL9U3B08EkRO50KKNGYOcCIXWo7xIJ/3gOBKCQuED3FISZm8h9LCmWGv8DNKL6J4v6mAGgd1ic6lwykLKdnyB8ffX/xVxwz3Kwp53IMaUmjcsocYkA04JPH9cgTIKHh2gOoW7lDqBSbhZo1IEY4RuW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151985; c=relaxed/simple;
	bh=TUAHoAWqH9cEsjlXUbgTXg56hGWN1KLx8hlC8oi9MSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFlMgQPLo761lSgkWd83bKD1L0TcI7DB554gqLZyrT3xYrkZrJD39Ozi5CXMbinhTtJwMKxr1Tpu314Bksj7XexkleylOh43EUcoIN2GzFYbNkvZaGNQUPWZ0gaCPd4Z1PVOnC74IZPn7ny/UNqX9Ob0KDTTvuKU9fmmYF3PDvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+8iAKpl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so18782475e9.1;
        Sat, 05 Oct 2024 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728151982; x=1728756782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y00+S3Ow4bi2G3EUw0WQWl7NTok6pXq+sd2/WK9umKU=;
        b=I+8iAKplNEKXls1OWxdAV0ETAP/gC0GXBtAs2uWYVaZRw1yTZ9/w/goQMI575CKw4E
         nz6qs062dSYvuRM88LWCXaFs9uTOTOM/2gYismwXPPElo1NVewMLpAKvYFmJYQkFBcdH
         K1V6UzBq5khgVrm90/a+oujAfWODv4oPrCxyTAZXkc5lsOTh550EYFOK+SX0LS73X9T2
         2pRkJ4lCftSt3jx1WlKSgrPSwEEpO/qSp7L8glCCtcu/OEU+H4aN14nGEPZ+OJpWiJYL
         8PCbFPDgbj7T59nGUK2af7wPEGhVKwtnzjJvK3iLQV036rJNj0wlIKFll0ViPU0GxTQ4
         nLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728151982; x=1728756782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y00+S3Ow4bi2G3EUw0WQWl7NTok6pXq+sd2/WK9umKU=;
        b=tdxkeCV0/Vlz0rT0+8Mo7NFnbMa6yjkjZruA9nxYFdXBu+uFHIw2nBgf4N6qAxIabe
         sht6ISmziRubnYzKUqa5RD9I9XiEjHtuGNu4VY/mo3BT4nOl8xDs1wuaW1jYHNrM9b9K
         nOKLZszbwl1dutQbbrXke6gmQciFdAXg6SKprRPfHu5YebLEnrRnYqbvLFMi5ykkAVG3
         RLoTSClOaa/qMURFLjSFqbPgawL4DOMQmGndlKdO+Rpx1kI696RjBRVCJjiEPiPnkGt6
         tCizp11tuK1wtOCCpfs0BgrReu70ELaCsdrBo/sjWPPc84Hkem0euft+P69FuqDjX8Wb
         k5eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXe6JxgmR24TTUeK1cRVditYBI6xl5lmbebXpa79ls1o6gyGQ67r+dBVWAvNLYIvlvM3Y130bGWBSbahjG@vger.kernel.org, AJvYcCWN4CbYhAUg5nnONUva1KyxGQG9XFHHQdGi46v06BDGz3IhJVSXeuG0rqyo1zoBPMYltEA8uumKe4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwJ8gZosPNg6AyHz43xN/qcORLPXb0KpVzBY8lZy6UApImJrgb
	4sSXhzCkq2pu8+Q3JVXScMrpfuwQzQw6WQNk9I+J5HloiRA0vNJ/
X-Google-Smtp-Source: AGHT+IFJOmGyu/wJXf5iE1+pczO0aqB5bMBOR0ro/AI5bInEJdtCOn7Djtcr0MM7X+i/UKoEdERJeg==
X-Received: by 2002:a05:600c:3b91:b0:42f:8515:e4ad with SMTP id 5b1f17b1804b1-42f856d271dmr38318925e9.14.1728151982298;
        Sat, 05 Oct 2024 11:13:02 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:6d78:36fc:b417:bb45? (2a02-8389-41cf-e200-6d78-36fc-b417-bb45.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6d78:36fc:b417:bb45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89bfb494sm29338025e9.21.2024.10.05.11.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 11:13:01 -0700 (PDT)
Message-ID: <2199263c-13e5-49b7-bc5f-1fe367c460bd@gmail.com>
Date: Sat, 5 Oct 2024 20:12:57 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] iio: pressure: bu1390: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>,
 =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
 Mihail Chindris <mihail.chindris@analog.com>,
 Alexandru Ardelean <ardeleanalex@gmail.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Shoji Keita <awaittrot@shjk.jp>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Dalton Durst <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>,
 Andreas Klinger <ak@it-klinger.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
 <20241003-iio-select-v1-12-67c0385197cd@gmail.com>
 <20241005190147.084dd468@jic23-huawei>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241005190147.084dd468@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/10/2024 20:01, Jonathan Cameron wrote:
> On Thu, 03 Oct 2024 23:04:58 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> This driver makes use of triggered buffers, but does not select the
>> required modules.
>>
>> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
>>
>> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
> Seems unlikely in the bm1390 driver. Huh. It is accurate, but I'll fix the
> patch description to refer to the bm1390 which seems to be the right
> name and add a note on this as it looks suspect otherwise.
> 

Yes, it seems that there was a typo in the title of the patch that added
the driver (The "Fixes:" is therefore right as it is), and I propagated
it in the title of this patch as well. But you are right, the driver's
name is indeed bm1390.

>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  drivers/iio/pressure/Kconfig | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
>> index df65438c771e..d2cb8c871f6a 100644
>> --- a/drivers/iio/pressure/Kconfig
>> +++ b/drivers/iio/pressure/Kconfig
>> @@ -19,6 +19,9 @@ config ABP060MG
>>  config ROHM_BM1390
>>  	tristate "ROHM BM1390GLV-Z pressure sensor driver"
>>  	depends on I2C
>> +	select REGMAP_I2C
>> +	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
>>  	help
>>  	  Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z
>>  	  can measure pressures ranging from 300 hPa to 1300 hPa with
>>
> 


