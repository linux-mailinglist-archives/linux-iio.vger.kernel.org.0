Return-Path: <linux-iio+bounces-22424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DC4B1E1CD
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 07:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA7D3A7ABA
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 05:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242D7204C0C;
	Fri,  8 Aug 2025 05:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLv+Qqab"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EADF1F5834;
	Fri,  8 Aug 2025 05:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754631803; cv=none; b=rSXDT9jOTLObl233rE4fqO1vKnPCdq/1oX7LvYkHALNkyGnj4pIrbA6UR7D8AaMgBaJ1IIEHzTRzv8pKE/QEuFQvJDtrKjeok2FzZDkJZs8GaeQHbdfaBY5Fg0l+3QYrJjiNew3KpfLvI0KzOW6qxDbTXlVsXC8hAg6tQy2d9cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754631803; c=relaxed/simple;
	bh=bKlVyLKOnTbKeG0Y9zbYXqtuy/zh3R4yDafYGzyHWpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnAbtGND8TziTBib+e5hBXXU5xG/P88bnWkCzoIB1z5y9inRdE1/U4RdnkGGaAlPZLIb99QHQB8YHl9ULOsTaiB31HZ8Nvk+hRq5X0AzB4e4pouo1WWFiz3/0/h2RoUKJS6r2/uvZhgZeCzuY3ZLxqDlyy6j5QUJauiYSQRNzSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLv+Qqab; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55b975b459aso1627675e87.3;
        Thu, 07 Aug 2025 22:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754631800; x=1755236600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5amIdnpZgeDGy492j3d6HXkFwKBswvaK7B5RnSg3Ec=;
        b=TLv+QqabHQmGAXqe6IQYNiaxK+V/WlqrvhgJBfATOjPa1LPKVlVIYLGznDPqo0lo2d
         oyV84wRtWdOfwE6vrf8iuURjfTaAruKxYiy/od2H8FgbduUA8/s9pll84vU2ZnldtcNK
         iWYcl6KlU5msFhwZCJ4J2qPev8nKku830cT04bV/xdTJAF+xmSEaiGUdO/chppxHBQ1D
         cu57j+hyF7UpufgDUTX12/mhlkr/u/oOyCnunk0WAJyT+CxHIoRGap/EjiAw9pN9WPXL
         EQtuzuqVLRBKevbatAL04qXuGAX4m+ZmTEXfp1hkSs0Slw26zfqik+d5RzGWcTP2OauA
         RSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754631800; x=1755236600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5amIdnpZgeDGy492j3d6HXkFwKBswvaK7B5RnSg3Ec=;
        b=cE3EGswpbvri6e8/lzk1P0toiiO1oQ/qiAivEYzroF45wMI4db7XpTtVw2dTC4aGQF
         Wa+F+B0YLvw/dlEcKNHoDs2AtwOdG6OU62igD2B2a0cu9C+S48hy0qG93T5AVbKE1Lw/
         wT/l43b+NCV8IM2YZsIaNWst4Fn3wiMdsN+zEFxk3SNIVc7WNMW9oOcIGsO6km2HCAWJ
         VSe0kV8cVe1WtsCN7fhvMwB2Wsmv7gbcPg/t2TQ6jHiTGj4cpcVerTBwplJnQ0qNF/3N
         7L4PfrO7OzgQJQEfncgALFgOIJRfx25+NA5fXLoiyApFMX2y8pjnx8JWf+A6FUe1Pdly
         MDug==
X-Forwarded-Encrypted: i=1; AJvYcCVkGFXlJrTrCM9R+DsEUTJsqRWteg+nFadVz5xulHOBa+VLaNtE6wWxNPysCimr7pfmuAOM7NiEo/eU@vger.kernel.org, AJvYcCWsD14yIEpkUTH+XnhdsL+9zYcKs3WqGaEOSLt3U4dq/J77vJQ6WSd2KIqfk4GNmA95lnKXUkIAG1i+@vger.kernel.org, AJvYcCXmCK+jdgb6DkxHUcOWpSO4VBGStxcg4XRF8gWXdZQFe69mcvLg513kmO9AuA2R+aP7A7ITUUnsZlFghTHr@vger.kernel.org
X-Gm-Message-State: AOJu0YwTaPJlIZk8BejiehS5IdOBXAjWctjQlWKsnP6tT95jJdlT5hAl
	/j5U8vLhmq+KkuMS6q+zZpGKk+9fGIAlvWytLFBjywbrzbfintEVPBFb
X-Gm-Gg: ASbGncsG76IS7EcocrEzK+eDmMcWEFXTMbbt+2VM590eIB86BOedhFfSbZWyOIyrz8v
	eWc6AmnTNwMZbVzz2s04G0gdunSiBpRuMKmjpmdaPsLocgec1kqWWu8DBvspTsiaSd35O7AbH/s
	Aeby2RWFEq6VmK0Cvs9OeTy0RjU57TIyTrQR0OISVMSaOFHItCUH8MMH7unLvmuuth22DYCuvNR
	VYoIq9NOZdDPw/hZP48j/lVsrs8H/CcWJ/3B7Bto+QIhCxjDhsMbewqtKp6fsnqSoASYPV+QLdG
	lurfjTQO/WEzch61sgMzbI0SHxRU+Yw7qse6LH8eHVMLGf0+kG+6cU0tJhcpMT83vA3nYZ52ucj
	R40BkbW82mtn1NPozR9PY7tMvtajmQadjs04HE1rLLmoEyxV6ZQOyevpbFcB7c8vtaIw/XnijsV
	5lmoQ=
X-Google-Smtp-Source: AGHT+IFmKY3MgaZebQSsv5BpJOV0DvBN/geCeEdzOjDX7cyrB/eyb8tR1jdAcN8rPhOmoLccLwBkhw==
X-Received: by 2002:a05:6512:1195:b0:55b:941d:bde2 with SMTP id 2adb3069b0e04-55cc00aec48mr414061e87.7.1754631800124;
        Thu, 07 Aug 2025 22:43:20 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cabb67sm2965906e87.152.2025.08.07.22.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 22:43:19 -0700 (PDT)
Message-ID: <f8c8cbd3-ce40-4b49-b8e4-cbb84e30dfe1@gmail.com>
Date: Fri, 8 Aug 2025 08:43:18 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] iio: adc: ad7476: Conditionally call convstart
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <bb96107301b249d4be912fa4384ed4de7791410b.1754559149.git.mazziesaccount@gmail.com>
 <jqq73v23juc3wj3ykq5df3mevjatnq3zb2aq4w524xnl4xgban@qemnvtvs2twn>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <jqq73v23juc3wj3ykq5df3mevjatnq3zb2aq4w524xnl4xgban@qemnvtvs2twn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/08/2025 15:47, Nuno Sá wrote:
> On Thu, Aug 07, 2025 at 12:35:03PM +0300, Matti Vaittinen wrote:
>> The ad7476 supports two IC variants which may have a 'convstart' -GPIO
>> for starting the conversion. Currently the driver calls a function which
>> tries to access the GPIO for all of the IC variants, whether they
>> support 'convstart' or not. This is not an error because this function
>> returns early if GPIO information is not populated.
>>
>> We can do a tad better by calling this function only for the ICs which
>> have the 'convstart' by providing a function pointer to the convstart
>> function from the chip_info structure, and calling this function only
>> for the ICs which have the function pointer set.
>>
>> This does also allow to support ICs which require different convstart
>> handling than the currently supported ICs.
>>
>> Call convstart function only on the ICs which can support it and allow
>> IC-specific convstart functions for the ICs which require different
>> handling.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>> Revision history:
>>   v1 => v2:
>>   - Adapt to the change which removed the chip_info pointer from the
>>    driver's state structure.
>>
>> The follow-up patch adding support for the ROHM BD79105 will bring
>> different 'convstart' functions in use. The IC specific pointer will
>> also prepare the way for this.
>> ---
>>   drivers/iio/adc/ad7476.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
>> index a30eb016c11c..8914861802be 100644
>> --- a/drivers/iio/adc/ad7476.c
>> +++ b/drivers/iio/adc/ad7476.c
>> @@ -30,6 +30,7 @@ struct ad7476_chip_info {
>>   	unsigned int			int_vref_mv;
>>   	struct iio_chan_spec		channel[2];
>>   	void (*reset)(struct ad7476_state *);
>> +	void (*conversion_pre_op)(struct ad7476_state *st);
>>   	bool				has_vref;
>>   	bool				has_vdrive;
>>   };
>> @@ -37,6 +38,7 @@ struct ad7476_chip_info {
>>   struct ad7476_state {
>>   	struct spi_device		*spi;
>>   	struct gpio_desc		*convst_gpio;
>> +	void (*conversion_pre_op)(struct ad7476_state *st);
> 
> Ok, I was going to reply to patch patch 5 saying I was not sure about
> the change. And now this makes it clear. My point would be that it's
> fairly easiy to end up needing chip info after probe. The above function
> pointer only has to exist because of patch 5. So I would better drop
> patch 5 and...

Andy had the same comment. I personally like to only carry around stuff 
that is used after probe in the driver's private data. In my eyes it 
makes things clearer (and cleaner) as you know what is used. But yes, 
(also) here it leads to some duplication.

Well, I'll drop the patch 5.

Thanks!

Yours,
	-- Matti

