Return-Path: <linux-iio+bounces-10643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5B499F251
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 18:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53261F232D2
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F7F1F4FA7;
	Tue, 15 Oct 2024 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i/dXZ2II"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA6D1E7C35
	for <linux-iio@vger.kernel.org>; Tue, 15 Oct 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008503; cv=none; b=snUEGgdsjSYMwd0E99gFXYa03H/M1Zgyi2MPAIB4TJXq2oIdJ1PECG1dkwbGFQ0oYqT9WYobrYZ0tfOjGWD3OulLtNh6TxAfOuuaxa4eCIVqbnWkYP954RRZvkl2xwfbOTb7y11BDUWA7gcY7xOAz3Mdwj1tHc/H1XuKxiTrbj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008503; c=relaxed/simple;
	bh=4Bzdfhl+m7ShnIiiJTobPwP7Xgi6C+hX2rwg3xphCJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mL54pbq/J/EmLIyGIp0zgz/zahVhrU9w58R3A2+Ha72nvSvIP0YGSlGg9CohiuXWFpGcGfzDhB0KHW9RK2GdfJ7wK9QkOhklnSkZPszLISiRukiVeu2JssNCgucqcv77dB6QOSp9lE7O93POOgCUigO2BKnt8Ja5acVJvHdSfJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=i/dXZ2II; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-716a6e6d5a3so3784400a34.2
        for <linux-iio@vger.kernel.org>; Tue, 15 Oct 2024 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729008500; x=1729613300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=swtPW+tLLd0OzR6ekCZ+L05YNw5hBkLTnVHdB063/5s=;
        b=i/dXZ2IIxke8jaX3Vdp7BpaSW/1VCxIE32jLHX0OXehjHTiwukbn+e5ozb1jqMNFIQ
         E5GWz8ALGnxe20sCyiFp+l5iMpoUi3ywzhq6qu/DEVcvABQjEyOsytKm7IMZ/cE5o9WN
         JQ1C6BgHvH/nWN7H5dKYYHqQLrnBoqpCnBxqN6yLk5Su+t9TuuvNt/2p3WphC9MylTk9
         ZIlznqIGkTJTnu64EQOj/aT6RqtyrpSCcTz0UP8R824NQ8HKGTfw2Kw6PlJyYxUUF4ga
         yoZgAwoEHHXI/vJSJ9oqZCIVblYnWlnBX+iaOLKIHVxl7EHu8/85GvRy7QsdLVFIfzhC
         yzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729008500; x=1729613300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swtPW+tLLd0OzR6ekCZ+L05YNw5hBkLTnVHdB063/5s=;
        b=OdY4MI1n5Vl9lbkxvKHhGhue1gUv5BeYa4lA1n2u6pvnGnc2Oicqe2lVQfiuxR59DJ
         TPahmrGhnpfx9nSSa59Ltq2n8iOtwxMgM9WnIUyAHyVGg5Ujy5zViBWnwH93Y/i0eZlQ
         RfbFKPAUoRGL6zlwq0/u8ZbGaD2IvK4ZPy0xTh+T1wK5mexdlV/hLFtLw8DUawE1pdwQ
         cYxzjHX7TQ/y9CyLxRLLfgIJiebf5LxpU3Jg0J6h17zFMraOXGQqdKoVq2Rme3QqMgGH
         +fzPBMN3wrJzAaz3XfbIKhYHPBKhwL5xTL/sX8/cpdPL4uXYXz5rC59txI/zM8LUSfrK
         +iOg==
X-Forwarded-Encrypted: i=1; AJvYcCWMjjhbkyILtDHITau4QyVGuZuyyXtgNVW1tIRwJDhW51GsKfax1W1lpHqsh1jCPuWQigZu4JJvgbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTjc2muT7sZIwA9lwMEWdMmceCNQxN5e92S32KUce75OsBqK2q
	OA4cWgf2enrIrKP12RxNARlPBmko/QqlJMCmoID6CL+C34xa0qaFH2PRGzRg06I=
X-Google-Smtp-Source: AGHT+IEwPPYkT6dxAxzECLc4uz6QgfRyPeTxs3ZCoeVmhMjxDE6Q2Jva1e5+jR93VB23GYq/ngQhtA==
X-Received: by 2002:a05:6830:3688:b0:717:d601:eb42 with SMTP id 46e09a7af769-7180350411amr1306094a34.31.1729008500459;
        Tue, 15 Oct 2024 09:08:20 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-717fb9ee9d6sm347988a34.21.2024.10.15.09.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 09:08:19 -0700 (PDT)
Message-ID: <704f4440-9699-48ef-acd7-e0bf9c4ae5b0@baylibre.com>
Date: Tue, 15 Oct 2024 11:08:18 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] iio: adc: ad4851: add ad485x driver
To: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241014094154.9439-1-antoniu.miclaus@analog.com>
 <20241014094154.9439-6-antoniu.miclaus@analog.com>
 <Zw0ZM0vQXJep3dFJ@smile.fi.intel.com> <20241014201515.463c7c07@jic23-huawei>
 <Zw5N_fxdDKQxlPoj@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <Zw5N_fxdDKQxlPoj@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/24 6:11 AM, Andy Shevchenko wrote:
> On Mon, Oct 14, 2024 at 08:15:15PM +0100, Jonathan Cameron wrote:
>> On Mon, 14 Oct 2024 16:14:27 +0300
>> Andy Shevchenko <andy@kernel.org> wrote:
>>> On Mon, Oct 14, 2024 at 12:40:40PM +0300, Antoniu Miclaus wrote:
> 
> ...
> 
>>>> +config AD4851
>>>> +	tristate "Analog Device AD4851 DAS Driver"
>>>> +	depends on SPI
>>>> +	select REGMAP_SPI
>>>> +	select IIO_BACKEND
>>>> +	help
>>>> +	  Say yes here to build support for Analog Devices AD4851, AD4852,
>>>> +	  AD4853, AD4854, AD4855, AD4856, AD4857, AD4858, AD4858I high speed
>>>> +	  data acquisition system (DAS).  
>>>
>>> I think I already commented on this... Anyway, it's much better to support when
>>> this list is broke down on per device per line. In such a case it's less churn
>>> if we need to remove or add an entry in the future.
>>>
>>>> +	  To compile this driver as a module, choose M here: the module will be
>>>> +	  called ad4851.  
>>>
>>> Also, with all these devices to be supported why not ad485x as the name of
>>> the driver? Is it a preference by the IIO subsystem?
>>
>> Don't.  We've been bitten by too many cases of manufacturers noticing
>> a hole in their part numbers and 'slotting' something unrelated in.
>> So it just causes confusion.  Hence strong preference for any new code
>> is pick a name from the list.  The wild card also implies restrictions
>> that tend to break overtime when other part numbers outside the range
>> are used.  Not using a wildcard keeps it consistently wrong so people
>> get used to it :)
> 
> I see your point!
> 
> But shouldn't we have a formal criteria for choosing that one from the list?
> I would go with "most featured device" as it may be aligned with all enabled
> features that otherwise would be questionable / confusing for the chips that
> do not support them or support in a limited manner.
> 

I always go with the lowest number supported by the driver at the time
the driver was created. It is a simple, objective criteria and no one
has to spend time looking through features to decide which one is "best".

