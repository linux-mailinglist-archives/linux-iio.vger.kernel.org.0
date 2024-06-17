Return-Path: <linux-iio+bounces-6427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2140790BC56
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 22:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696EEB20FE7
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 20:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E9A18FC8A;
	Mon, 17 Jun 2024 20:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bOvOFdJ9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59067492
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718657335; cv=none; b=ADT1/Ma0J6V9ZRJYJQm59W4R8iLPwaoZgYFSnPwY6/nRfESLIoFKfHo3dhBgjv9HjwoRwFxieo25k6nSrrFQu5il8dXvoAECO2hc70OSoMP0VbdN7dXc8MXNzVkIQ8ATYnMoFkDEBCOmXwF1JS/0c2llprW/bLIGzsILSrmjIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718657335; c=relaxed/simple;
	bh=+wg5rGWnub6d6ueoxs/8H2knoEi7JkxL+8IPuLbzhZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgBJX3+77GxHyRRAiEOR2Up1tK9/TF1RAwUtLkL5sGymAB4Ob6y60xN1YaPOvp9Z4Du035IIS2YtKpAVxp88rzI0BLAY6AmUrzNsWEqNxgwa9kNW6KxfmlVLlXSb/thIez+OzQlpupuq49WWcvDJpoAjfD1n+Zdf0VUkcjjbl4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bOvOFdJ9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35e1fcd0c0fso3857811f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718657332; x=1719262132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Prxca8WsXgeUFt4L2M3lgOG9HB9DoX/SrgkfE/LHB8=;
        b=bOvOFdJ9xjH1W5FdxmBv9AcBUc+GA2jyPU/nXMv50RZdB6L3AfRbk/LQEcZPtFYomm
         gdGLW2sL5Mp9aUHDRclc6VspKgx8b8yGvgXwTQZSY8doC/QTADg5g5zUApAJ67NBWWgp
         ei3kv54Jgndh/qaRQ5DDXPbq61I//rQNNum5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718657332; x=1719262132;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Prxca8WsXgeUFt4L2M3lgOG9HB9DoX/SrgkfE/LHB8=;
        b=b4WOpJlIfV2ZsFMcVwqya4ZlhDPIaxjJrMzkJOppc0GMgCYkLmfgu4XdaTP7BBRyRi
         mT388S9XMnTWLBXkEQhQ1Q74NmtrQfCqBCV/P4sYywTXZpx0FhvDyJ5lYjWs0QuWZ1LJ
         RSdbvqMMPSxDVUdeqqV+2f9eHjZyqjZT+C9fFZ0gTfVgQB1UCG0HLtmWcE2N09et+P1J
         VcSuJJ9YdwlwlxR1soGgxlkEwLLaZ97PmzFNqt7ctmW1t8AVNNcZqMlHYSeA5HU/7/u5
         DIt0zvc7P00vsc0JdP/XgsuDZqLYVvEkktNG/KYEChcQv1CdquGFpK1KtCpTiaDjVPz7
         wbpA==
X-Forwarded-Encrypted: i=1; AJvYcCWnUj9+72sCDd5jpDdQI5YLMJYg1Cy3zyHqxSTsYD74eR7dLn/RApk5nvlPkcIAR6CMNhQ3xkQW1lNczi/zM2FG9REtjTCCnPbI
X-Gm-Message-State: AOJu0YymjiyCYDC3K9YhkeYzv4oCgtscdyP9H6oM02F30u0OOU+XdykX
	H/htStUuXc/bANBv0NWml9tyLzXkQ6nN7l00flMv6hqzm8yADq24+xdjzW/ZLg==
X-Google-Smtp-Source: AGHT+IHEU62suYWnRXwKdzpdAXSz5KBYd2epiiTyciPo+/4BqNzGad5ovJJPFBopMPwoL4rztkfXKQ==
X-Received: by 2002:a5d:4b83:0:b0:360:7557:3239 with SMTP id ffacd0b85a97d-3607a763270mr7051286f8f.20.1718657332016;
        Mon, 17 Jun 2024 13:48:52 -0700 (PDT)
Received: from [10.66.192.68] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db62e5sm547701466b.84.2024.06.17.13.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 13:48:51 -0700 (PDT)
Message-ID: <19e8a6dd-b0d4-4e88-9ad2-e38787a5aee8@broadcom.com>
Date: Mon, 17 Jun 2024 13:48:38 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: dac: Fix dependencies of AD9739A
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 lkp@intel.com, zack.rusin@broadcom.com, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, linux-iio@vger.kernel.org,
 jic23@kernel.org, lars@metafoo.de, nuno.sa@analog.com,
 dragos.bogdan@analog.com, anshulusr@gmail.com, andrea.collamati@gmail.com,
 oe-kbuild-all@lists.linux.dev, x86@kernel.org
References: <202406152104.FxakP1MB-lkp@intel.com>
 <20240616012511.198243-1-alexey.makhalov@broadcom.com>
 <20240616012511.198243-2-alexey.makhalov@broadcom.com>
 <20240617090428.GBZm_8HMQ9XJe_VQga@fat_crate.local>
Content-Language: en-US
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
Autocrypt: addr=alexey.makhalov@broadcom.com; keydata=
 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 EuY0
In-Reply-To: <20240617090428.GBZm_8HMQ9XJe_VQga@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/17/24 2:04 AM, Borislav Petkov wrote:
> On Sat, Jun 15, 2024 at 06:25:11PM -0700, Alexey Makhalov wrote:
>> 0-DAY CI Kernel Test automation reported an issue:
>>
>>     ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_read':
>>     regmap-spi.c:(.text+0xf): undefined reference to `spi_write_then_read'
>>     ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_gather_write':
>>     regmap-spi.c:(.text+0x2b4): undefined reference to `spi_sync'
>>     ld: drivers/base/regmap/regmap-spi.o: in function `spi_sync_transfer.constprop.0':
>>     regmap-spi.c:(.text+0x337): undefined reference to `spi_sync'
>>     ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_async_write':
>>     regmap-spi.c:(.text+0x445): undefined reference to `spi_async'
>>     ld: drivers/iio/dac/ad9739a.o: in function `ad9739a_driver_init':
>>     ad9739a.c:(.init.text+0x10): undefined reference to `__spi_register_driver'
>>
>> Kconfig warnings: (for reference only)
>>     WARNING: unmet direct dependencies detected for REGMAP_SPI
>>     Depends on [n]: SPI [=n]
>>     Selected by [y]:
>>     - AD9739A [=y] && IIO [=y] && (SPI [=n] || COMPILE_TEST [=y])
>>
>> The issue is caused by CONFIG_AD9739A=y when CONFIG_SPI is not set.
>>
>> Add explicit dependency on SPI and conditional selection of REGMAP_SPI.
>>
>> Fixes: e77603d5468b ("iio: dac: support the ad9739a RF DAC")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202406152104.FxakP1MB-lkp@intel.com/
>> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
>> ---
>>   drivers/iio/dac/Kconfig | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
>> index 3c2bf620f00f..d095f4d26e49 100644
>> --- a/drivers/iio/dac/Kconfig
>> +++ b/drivers/iio/dac/Kconfig
>> @@ -133,8 +133,8 @@ config AD5624R_SPI
>>   
>>   config AD9739A
>>   	tristate "Analog Devices AD9739A RF DAC spi driver"
>> -	depends on SPI || COMPILE_TEST
>> -	select REGMAP_SPI
>> +	depends on SPI
>> +	select REGMAP_SPI if SPI_MASTER
>>   	select IIO_BACKEND
>>   	help
>>   	  Say yes here to build support for Analog Devices AD9739A Digital-to
>> -- 
> 
> FWIW, I appreciate it you fixing other breakages. However, there's a patch for
> that already, on its way:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg&id=75183e461ce033605c3e85518a9f3d4e4ef848a3
> 
> Don't get discouraged, though, when fixing something that is not in our
> immediate area of interest!
> 
> :-)
> 
> Thx.
> 

Lesson learned and noted for next time to address only related/new 
warnings and errors. Thanks!

