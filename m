Return-Path: <linux-iio+bounces-12955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 032F39E07F7
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 17:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6121690A9
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AA4209F43;
	Mon,  2 Dec 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf275xrI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4B1209F33;
	Mon,  2 Dec 2024 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153937; cv=none; b=LRYGVBgglettKfITolFTRIcBvvVL+rUnOFLXZidO1nfi0Bu/zs+wpqBfJBdcZNJTZ0rjk3uQ+6TNzEpbiuZyE+BH3jV4/gr4a0f2NixB44+byOoWkDriO2Szc4MCVQ+v2M7SKWfU/4esdZ2Uu8j6sEBJbkqlmGEoHvKjsYhrsNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153937; c=relaxed/simple;
	bh=6FMVUMuVmiKoknMUpwq7h0V6bMG4QeWN9obr8VkzD5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9VramS0B3HIH8nQPh/wg1U0dV9Hcl1U0xAUvaLbF34f2XhBhDA7F9aWh5rcENy1tVqj+HoLQ4a0Nzn5Z4jPF5lxLRMXuGgBDUdUJKJmkiQJubH7iYXr6pnmK08OXwjxX5xpon0w1qZTMeW4zYeLNXEeUu561iRedlMIAVTqcB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf275xrI; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-382610c7116so2941915f8f.0;
        Mon, 02 Dec 2024 07:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733153934; x=1733758734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BgMG9j17VIY/+uN0vXhoiOG0maPDfpV2MZAeVxSTQP8=;
        b=Wf275xrIqEt3FSSFceo9CILdLZiXcCZH/GyrrfPdoFfdlSntN1O/HF9YoBFMCfY+xA
         OBA5XRsQbbD+VHjE6OU6UN3Zga+xQcbvxTKPsGbe0ha8W9eaHWx8NI2ZJLZPZwyljzFm
         TAjIOg3aL/46/akzL6YX+naL+g69RnzjKREpEz+2mLtW+gIxa+jB4vYzTQHhqXRzJxQK
         4755AeeJ3ohKks4hdgqsUsmSLoL/XDK5BDYW0QnMabwoJmmZpann2aMKqO0ullQwzR/S
         qIdM/WbszeV/VnkZxi4tsjAYlogy56T3TWlPqS5GDffSDOT/9sPOrD4XBwjcow0Ae4Md
         hcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153934; x=1733758734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BgMG9j17VIY/+uN0vXhoiOG0maPDfpV2MZAeVxSTQP8=;
        b=hZNq9LRpF6My/iIDI6R4H9dKhAtxQey+V8wtwEGEGq37yq9CRwnZDDqC+TWzkND3ln
         FlI0mEPVRQbb1J90l9vVzCqtEIxZ8qHYLjsjpJ/+NttzgcGi9If9HWESzXnV6cdIAktO
         HH59aANNSzhlitnuy6AfIY3CF7vjDzqA7b4wOnBG5BU/XQM3Yaer6BaXNilpFcoofvP8
         egD5daMUYufjs47uTM2yrqPc8OTVouv71nRablqwHXij5eo1MsUUppMyQeMi68dKixwG
         vz69LgOsz4zHzzirSg7hXfJSE69MZmWks6Sl1QRyDOYS1NcQlmUxmuUFRwC1Wh5zS0zH
         OMrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFGp8BXE81YCAgf3bw0GAQ2VavXpcXVdXK7r8ygrP5TdDOYHXY8Bcd7/iVBvHH2QlRtgUP1tD/@vger.kernel.org, AJvYcCWxSqPjwTGNI5T5HNazfsTrPXZtEXVeeXPhqYUSiCLqmyJ0yEP1Mpj3RFHVa4PwVOdVK5tgMC+gd00=@vger.kernel.org, AJvYcCXYW6IzdhQkjf2kOOHfHZviPl+XZqjze9BS+HfEW6DwfrCwcNRLb94hhLUt3+0wzGvr/AedjbkdpVnLw0HS@vger.kernel.org
X-Gm-Message-State: AOJu0YzB4LE4USHhl94tYZhu+i/AcPqHQQOftCAoj7uSgTEiuVtEfAUV
	/cu3oIhuQKoGa22LMAy8B6WOQldKOCKM4d9vynwAZmR4AgkIaJIkddByeA==
X-Gm-Gg: ASbGncuKYwZmJqnQhmD5y5iwGUyoyrDLZdepyQBVsp7Lxpiy6YXIRGCLT+EJN5NDQmz
	CddtSyWde8KhSpdlYqjXWqGHQMcVYIURwL/oTSVFtSUAe/qNIWOsGcJ54//rl3iw/8yi9PmCtLI
	PSu4drC7T2zM6ua112ll9HW8mQsEZzF7vOLLqZ3fuYlWaWBuGMIHpqVDPwp3XRvxOOpMqyigBMA
	EIBwIGfG7rpWiDMQiCqnx3Ry6XwPmXC8aNyooxWajZYcX9XvwnvTDs9oYvIRCJ0gcpW/CXsD0+w
	ayPYEJ2IUyIV68N2UdYwup/CtRBihN0iI3MAugcZxDaOog4gteiIzLD9ofLOQYp3vGm9Dcil5n7
	hA67qV131AUltFnGFdqis4B9wGK2qceG4xoNQX5XJ
X-Google-Smtp-Source: AGHT+IHhYi7myBSgKxUDvKABHp7+6thL5rVSy5IQiw2xBG1LGFtHDCgslmsCFo7yTW1tKtZUpIBt1g==
X-Received: by 2002:a5d:64e2:0:b0:385:f092:e1a with SMTP id ffacd0b85a97d-385f0a152e1mr4081697f8f.11.1733153933559;
        Mon, 02 Dec 2024 07:38:53 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:f58:c447:145b:2b51? (2a02-8389-41cf-e200-0f58-c447-145b-2b51.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:f58:c447:145b:2b51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385f0056637sm4071203f8f.15.2024.12.02.07.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 07:38:52 -0800 (PST)
Message-ID: <9e1310d8-bcd9-40f9-8d44-abddc595ae9b@gmail.com>
Date: Mon, 2 Dec 2024 16:38:50 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] iio: light: as73211: fix information leak in
 triggered buffer
To: Jonathan Cameron <jic23@kernel.org>, Christian Eggers <ceggers@arri.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Antoni Pokusinski <apokusinski01@gmail.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Gregor Boirie <gregor.boirie@parrot.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, stable@vger.kernel.org
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
 <20241125-iio_memset_scan_holes-v1-10-0cb6e98d895c@gmail.com>
 <20241130204923.45d71fa4@jic23-huawei>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241130204923.45d71fa4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/11/2024 21:49, Jonathan Cameron wrote:
> On Mon, 25 Nov 2024 22:16:18 +0100
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> The 'scan' local struct is used to push data to userspace from a
>> triggered buffer, but it leaves the first channel uninitialized if
>> AS73211_SCAN_MASK_ALL is not set. That is used to optimize color channel
>> readings.
>>
>> Set the temperature channel to zero if only color channels are
>> relevant to avoid pushing uninitialized information to userspace.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 403e5586b52e ("iio: light: as73211: New driver")
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Huh.
> 
> If the temperature channel is turned off the data should shift. So should be read
> into scan.chan[0] and [1] and [2], but not [3].
> 
> Not skipping [0] as here.
> 
> So this code path currently doesn't work as far as I can tell.
> 
> Jonathan
> 
>> ---
>>  drivers/iio/light/as73211.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
>> index be0068081ebb..99679b686146 100644
>> --- a/drivers/iio/light/as73211.c
>> +++ b/drivers/iio/light/as73211.c
>> @@ -675,6 +675,9 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
>>  				(char *)&scan.chan[1], 3 * sizeof(scan.chan[1]));
>>  		if (ret < 0)
>>  			goto done;
>> +
>> +		/* Avoid leaking uninitialized data */
>> +		scan.chan[0] = 0;
>>  	}
>>  
>>  	if (data_result) {
>>
> 

Adding the driver maintainer (should have been added from the beginning)
to the conversation.

@Christian, could you please confirm this?

Apparently, the optimization to read the color channels without
temperature is not right. I don't have access to the AS7331 at the
moment, but I remember that you could test my patches on your hardware
with an AS73211, so maybe you can confirm whether wrong data is
delivered or not in that case.

Thanks and best regards,
Javier Carrasco


