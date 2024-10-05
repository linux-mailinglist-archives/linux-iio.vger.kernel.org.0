Return-Path: <linux-iio+bounces-10213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C9E991960
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 20:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230951F21EAB
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 18:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9DF158DA0;
	Sat,  5 Oct 2024 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfClBQLs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547D81798C;
	Sat,  5 Oct 2024 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728152473; cv=none; b=gTD29Rk9yrPu9kyBKHMkmyLLc5UIUqMn5L/7TWihKphiNxOR9ulZS+r8r61UZgccILOAtQ3Ks48z819retUzLLH49OcsCm1O7/sjKT4SDtiRu5Ed6sQQ7xwWwv3G60Mg3Z3KoRfdt93qTSo8yx5z2Notcz5bnNXqUJZ7ge1Hkts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728152473; c=relaxed/simple;
	bh=DvcMf5/HeKRUSZojHkHZF68QLnGuWSrrXLDKhFRy110=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVfImkjb+tthFR7ygABYNRqdnjOH+WzWzKn/MUHDjlY9oI4FhSL/2QDK+H7X9IlxHeI/Sb74dEmaICShC89nXniR2G1BbKdkB3dcDBhxMMpqLK5QolK31WmSqpmhGhowXnN+t0MXJvPZ0BkalPTdEkVMRWfURQPhito1k2odm/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfClBQLs; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cdbcb139cso2437543f8f.1;
        Sat, 05 Oct 2024 11:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728152470; x=1728757270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w0N+f0QrNk/7IBy9s5iZg9Yt6FI+f3/ZQhjUgn06TS0=;
        b=MfClBQLsZPl/0nSRjfVjsAh44NJ6zD1dlgMrPaAYGoNTy0ZiVLcdRBKYBbKyrOew1z
         SgEsKi98PMIacpUmeN03WJ/Ns1Pyle/6wmV3FSjbXQQHArxaAIR6pq3/1RP4BmnFY8D+
         A0H6aX6j3iHxS86hkbr1HpQNT7EFHU/kpo3tUlj0DlKPkz0w1hrqQSSRqK4PtqDh44gL
         L7VZoVbMQu/rzFW3gvQ4Uxz511iBjoHsgVE8p1a2DM/Ug1djTUJCm6YbqQOyiMzztSXd
         q9emvS5UMIh+uDmbHRXoHUK80g96s3QamCpLEL/2QS/S807Z1bHfemYgjIb9YTmWPMOy
         g6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728152470; x=1728757270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w0N+f0QrNk/7IBy9s5iZg9Yt6FI+f3/ZQhjUgn06TS0=;
        b=IHPmMQqG8bucaEUq5+GD293hxkAwLnFy32q/IEps0hZAU+YHztsAo2HTEMBTGRZ9kO
         LDg17kdi7+OwzZpXcHScX5Gz66soRCo9OrsL0F37WcYkvtkvpnQm4Er/e0wrbFoyHV5n
         ViWmWoavHENz6QC/6wVkmv1oPdSxNu6gI+FeteRc/7tpLE7QnMDg/9e/XXW8rMHkSZ3D
         oDUk0oZO3inXclc3c3WeX1PG7dcYJz767aa2TDkstY21QE5bqLKZWEXR3tdgO9buV6ZS
         4boUqG/PHDHRPce95K0jCAV0OEcQvGQDoSsySNKco+oh2k5Lrq5dLGvsvkqbs4afSkcW
         4fmA==
X-Forwarded-Encrypted: i=1; AJvYcCU7yx+hSmgAfTFdRrEw6IBqVNFMbKhKLQgL7lqW0gFUD8GXkp6ReFMmhPehfODUf0K6dFIlFPWKZAQ=@vger.kernel.org, AJvYcCVxG9H5AIjVA/YhSjvBJ/6+H36sCE39ap8YYiMvv+0haWOcY+bLlNMMVHoyX1bISYirX2kjI13TQmO+Xjlj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6YBs8gTu9E7Ex8k05VRA/HbRKWMA/TpWd23intbnhhDx1QdVt
	78q1YLIoztWCRCD7g1aU7nC6KdXzWRoRZTVdWgupWgexD/W6oI8r
X-Google-Smtp-Source: AGHT+IGaSqJpvFxoa+QVTMvgK1Lr6stXy6J1TFOfJXvk4Bslf+lUM+5T5LfW3yFGaNiXOH738zav5w==
X-Received: by 2002:a5d:6504:0:b0:37c:d558:a931 with SMTP id ffacd0b85a97d-37d0e789e3cmr3576556f8f.31.1728152469345;
        Sat, 05 Oct 2024 11:21:09 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:6d78:36fc:b417:bb45? (2a02-8389-41cf-e200-6d78-36fc-b417-bb45.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6d78:36fc:b417:bb45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec63c3sm28153005e9.38.2024.10.05.11.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 11:21:08 -0700 (PDT)
Message-ID: <34f22420-ec6b-438e-9edb-1aa7a837eb98@gmail.com>
Date: Sat, 5 Oct 2024 20:21:06 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] iio: adc: ti-ads8688: add missing select
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
 <20241003-iio-select-v1-4-67c0385197cd@gmail.com>
 <20241005184018.6b06e850@jic23-huawei>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241005184018.6b06e850@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/10/2024 19:40, Jonathan Cameron wrote:
> On Thu, 03 Oct 2024 23:04:50 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> This driver makes use of triggered buffers, but does not select the
>> required modules.
>>
>> Fixes: 2a86487786b5 ("iio: adc: ti-ads8688: add trigger and buffer support")
>> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> Fixes tag must be part of the tag block.
> 
> Also this one looks to be a false positive. The driver includes
> buffer.h but doesn't actually have buffered support.
> 

Are you sure? These are the errors I get when I compile the ti-ads8688.c:

ld: drivers/iio/adc/ti-ads8688.o: in function `ads8688_probe':
ti-ads8688.c:(.text+0x1cf): undefined reference to
`devm_iio_triggered_buffer_setup_ext'
ld: drivers/iio/adc/ti-ads8688.o: in function `ads8688_trigger_handler':
ti-ads8688.c:(.text+0x3be): undefined reference to `iio_push_to_buffers'
ld: ti-ads8688.c:(.text+0x3c9): undefined reference to
`iio_trigger_notify_done'
make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
make[1]: *** [/home/jc/pw/linux/linux-next/Makefile:1173: vmlinux] Error 2
make: *** [Makefile:224: __sub-make] Error 2

And I see the offending functions in its code. Am I missing something
here or are we talking about different drivers?

>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  drivers/iio/adc/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 45872a4e2acf..e6be1f1ec79f 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -1483,6 +1483,8 @@ config TI_ADS8344
>>  config TI_ADS8688
>>  	tristate "Texas Instruments ADS8688"
>>  	depends on SPI
>> +	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
>>  	help
>>  	  If you say yes here you get support for Texas Instruments ADS8684 and
>>  	  and ADS8688 ADC chips
>>
> 


