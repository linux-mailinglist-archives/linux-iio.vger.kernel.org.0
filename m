Return-Path: <linux-iio+bounces-6601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A1E90F5DE
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 20:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F511C2148F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F3E15747F;
	Wed, 19 Jun 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UyQVV3m/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60350157467
	for <linux-iio@vger.kernel.org>; Wed, 19 Jun 2024 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718821226; cv=none; b=dxH62b0T//OmXqdhfvq90wPfNvJjivPfIvQNQbL8gPUgtznhM1E+SEiGzh5esi4crHsVYkYAFv/hqO9/GGmo/hSBFMqRrEIrUShNoxA+pwsLFI6iDuC7OWEuS+Ck/BrBYHDTz/NujAsEWIeqLiZlAEiayQqcEiz7J79j9ObR3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718821226; c=relaxed/simple;
	bh=RlFcuST3MTYw2HhcrIt93bRlktGhL2E9Pa+qAshb+Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3MXpxhxHhVOWhpizjuOcFmtpytDWv3LooZLWd9lki17KboEbSb7oD0Dl4nNBIDIs7iNKyzH/Auwv71ua2zONbDThKTrSHJ8xBkWydGGpbsNCt3t3JvwIB3tNTRXiVGfbpZp4DymWqBmR0x0vMHmaVG5LO3UJzUDanDpcCjuxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UyQVV3m/; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25980546baeso67570fac.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Jun 2024 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718821223; x=1719426023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EEAmDmdxj2IHWsPzPWl7VVZMI4gsZPCFHp3nAK0/dQs=;
        b=UyQVV3m/1fcKRjM21ZcHn17RogJM5/UU8Ea41Dgb8Z2wPL36J+rQ3smwnAANQVngOL
         dIXUI9AqDZAVF27NXLZE090YmRLAl2zH+LyLfxTJ2C3q7Te2vnz5vjkXPOV+7S31mUUX
         O1dpq7GiY2HgP8lzXFAALVPPD73tZtTkgY5BAbwpuROpk0x3ba+KzfTKTy9TeTFK6sbn
         W3XbJBYFSqB58DNN3udAyE0yV4lg9ZOksvA6mxqzXwe6MQZD9UqrQn+mm5UVMMif+U8X
         X7aa+xywMwYn9+CUyl62VsVQSWpobAhj0hEC+2wminpvxpsRO4U4vbluN16wp82AM/kF
         eZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718821223; x=1719426023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEAmDmdxj2IHWsPzPWl7VVZMI4gsZPCFHp3nAK0/dQs=;
        b=BP2o2kWe2iHVt1K+3DJ22x61a2fXM2/JI6uRcSV+j3P5QTNpdNavtMyoilVsXATC2u
         ZGezNDtgByXxTBTbe6yfYCdRQQBUiNtPfZpMRdltlTfgW6ydYz3voURiKym3iAfq0puV
         0+wMI2z/6ldPux7oAo6faWrD5hhS0acyoqSk8f90PJu2mBJHNen+xckrlMabtosKUSXG
         JBCZVAwXBK+YFGEdr7MsOfJ1DLyxcqmd5DQDwya9dYCf8xby4BGlYKfFTqxlKt6ZVvXB
         anHx+Tah10lMQcYp63ggZQwxiKqnvjjBJBN+yAl2brg+XJwnt7OZwUmvcM4+Gfkd20Y/
         h8PA==
X-Forwarded-Encrypted: i=1; AJvYcCW8V1NzsHQh80103QgrYS287Or+ugXxnz8yhuMd/UOe41p3CjY0b2VjCRrdUpXLt5hF3Lyl+iIXEP0FlWxHryQNEZy/n2mWfTbn
X-Gm-Message-State: AOJu0YwWIlvVMxfhaoSGmdZKMUEgvAi6v3aU+lhP3ZN1nxaNGFByqo8v
	N7c767NiU0x+VSWD152bia7/gNoNERealdIIPEVyMrn30AiG/oQw3tyc8fAlJJI=
X-Google-Smtp-Source: AGHT+IE46EgTLGf5oN4IQLbetpDLGBop9HxlMQVzbGsKy4Pf+gc303cZxbeI8m5oLWrSKPVR+6EHzg==
X-Received: by 2002:a05:6870:6494:b0:254:997e:ea4d with SMTP id 586e51a60fabf-25c94910162mr3750542fac.10.1718821223499;
        Wed, 19 Jun 2024 11:20:23 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm3826912fac.41.2024.06.19.11.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 11:20:23 -0700 (PDT)
Message-ID: <d7cf1a03-9a03-40e1-b9a9-f06d28c21f92@baylibre.com>
Date: Wed, 19 Jun 2024 13:20:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] spi: spi-axi-spi-engine: Add support for MOSI idle
 configuration
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <ead669c15db7cfad4034df1d743fd4088f1c2253.1718749981.git.marcelo.schmitt@analog.com>
 <6f945701-cac0-4a56-9ca7-1daceccc5efd@baylibre.com>
 <ZnMU-OUV2DCpS3mu@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ZnMU-OUV2DCpS3mu@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 12:27 PM, Marcelo Schmitt wrote:
> On 06/19, David Lechner wrote:
>> On 6/18/24 6:11 PM, Marcelo Schmitt wrote:



>>> @@ -646,6 +651,9 @@ static int spi_engine_probe(struct platform_device *pdev)
>>>  
>>>  	host->dev.of_node = pdev->dev.of_node;
>>>  	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE;
>>> +	if (ADI_AXI_PCORE_VER_MAJOR(version) >= 1 &&
>>
>> Currently, the major version is required to be 1, so this check is not
>> strictly needed.
>>
> This is expecting the MOSI idle feature to be available on all versions from 1.3 on.
> Will SPI-Engine always be major version 1?

<yoda voice>Difficult to see, the future is.</yoda voice>

It's fine if you want to leave it the way it is.

> 
>>> +	    ADI_AXI_PCORE_VER_MINOR(version) >= 3)
>>> +		host->mode_bits |=  SPI_MOSI_IDLE_LOW | SPI_MOSI_IDLE_HIGH;
>>

