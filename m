Return-Path: <linux-iio+bounces-13628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C8F9F7486
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 07:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1C7188E77C
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 06:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA77121660F;
	Thu, 19 Dec 2024 06:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZFOHoUi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1B1F867C;
	Thu, 19 Dec 2024 06:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734588323; cv=none; b=UpqoQczjJAybmk4B+mSMxoX1zww6U8d5ydYvZWmTxGoNb4MQzCU7uTRCnNoSGdAtFHvorFDVzLWFSINv0W5FnRjIDUH0oCMjI1HSkHcHdI4CtJ/zofqlGnZgxL3IdqZwjoVRNXavY08gRlrVdCn8m3IjRFgPlD2rl5lSI640E3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734588323; c=relaxed/simple;
	bh=eiWdyH2iRPv90aOUtcK6I56ow1G1PI25K7claUUUrXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ett24HcA1CZrvdYu6JtmfnAqqHeI5A9ghX6BgK1OAhJ389Mzj6SByAErnAaAofm/G7BSGuN0DG1cnpIKspRQo34LaZ/rUuDTl0pT/ci7Pv0AyG+pt8+jQOgch3wKaYQMnwqjQi5jIi3kd92NV0mTpIPsr3hxc4Aj3VtJqxdOUoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZFOHoUi; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3023c51146cso5008711fa.1;
        Wed, 18 Dec 2024 22:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734588320; x=1735193120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5vcEghD0tV81JRMPchK/JheCzOkTAQxdlacri7dBs5Q=;
        b=gZFOHoUi9xJ+Gtya99sdqp1I01d6cXyLPoWsYeGAg3+MRDitcemHpkJ1/ZswIbIzB6
         ozD5FkslBdHu57iEwIxutLsaQsXJS1Eu6WxFwyJ1O8snrYJonv7uegjl0NzGmW60/laI
         FU4Rxo1ehjcmCNzpZsbvyDInatqEUXvyW/GRQaH/19K9m32bDjTzP3FdQCPwwhMu6fYC
         1oD0lmc4CHt0TGYEDKVbgIMVIVBcCei3IA1RDM6+L6oZpw9UiakLI8EdSx1kF4SzvZ0X
         8mhhueSMGUATBbjMWvT8UKpD/IA8fUlLSTT/dAXXf0y4WDJLZxO8fFW7U5ClJUHt0Gkg
         PInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734588320; x=1735193120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vcEghD0tV81JRMPchK/JheCzOkTAQxdlacri7dBs5Q=;
        b=lV1GdzzyXzbI07Z5zeMnRQr85FkXG663//UPtgnvu0tyFalRa0vFnG1uK/30s8SnOP
         uHnm7cwKJYGeNP0DOh3NHHZZrt3Ti+7GjKqWjQSp4fmlYTCnOR1OvcI6y5XB8JWkp9o8
         sfCNR4/HeJDjzRzHaUxMwgd5yAESfUJAuIPRf1ON6RJbdfpK4wJ2tjezHRkQuQN3h0Jc
         hSFL19Zc/+Swcy5iiEeCQWKaMHQCtV/iAJ7KCJSdLM62JhGmdMaenmmXhQ5kbOk4jnvG
         TigjFosA+z3PLC9/TYalF/q6CYeb27U8ibseOGvZgSoVThwOKzL9JkLWg0BMM2hOJ2t1
         LsGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1REvTj7Io6vC+osPqOA3AhgFi6Ykdp0i/+V+7PWLclnbK/MVqSLqcqxHQLY5dzbor8HiPDnOoIgXSOa/3@vger.kernel.org, AJvYcCWkrib5VUeKfj1kVoVQah/kb3kHXFcYo5tvWzhyL0xD6KZH8CyMx5+fuL+5uWoiIgFRe6Gpv2pK4m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ8FddkGVLWN5xa6mSo+Uo9Tas3nKkw++l4UVR6O7nlFUflXPl
	aYCbtQe3IAHBXiehIiKHpDP0pac/oKPll6pasSEulEXCTwfa2PyBnw2vQQ==
X-Gm-Gg: ASbGncspe1TcS70Rkm780AIUSn2rO3DoAnlTNE+X2pCgLOBJzf4JedZXoptomzAmuxK
	p5/d/cX3a7/Gyn36+pveus1AA4HWYAFCGLN46MQL6Bjlzjx2A+s1hyKWaDpBH9JBpJ5eE5fTOJW
	eCcMpm/BKUMLTfB5PVPRqnoRZcAAPWa8n4O9VAEBN4pZBpmB7BQ/gka7gcRzqaqCD7jjZ7y1Fz9
	YeMUCwvb48Y8jbWXaZHtFHDNw1Ddxz/MuGWXnrAlR2216K2mOaA4172qvojB2yArZuC+hBpEXV6
	B2XxANrhAN8V22lIAhQw+VgfYtsxoMmZ3c0=
X-Google-Smtp-Source: AGHT+IE66kHCQyT0ZfT0YWGMniziIwHHGSKcbT0jp9KjN/hO8PCSZkVT/3DvBqjuyd4U0zoteoV3Vw==
X-Received: by 2002:a05:651c:b0a:b0:302:49f7:1d72 with SMTP id 38308e7fff4ca-304583860b4mr5745601fa.9.1734588319527;
        Wed, 18 Dec 2024 22:05:19 -0800 (PST)
Received: from ?IPV6:2001:14ba:419:b800::7? (2001-14ba-419-b800--7.rev.dnainternet.fi. [2001:14ba:419:b800::7])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad9bdb4sm928201fa.47.2024.12.18.22.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 22:05:18 -0800 (PST)
Message-ID: <c1795ffa-c2e7-428f-8897-2b8846e9fa44@gmail.com>
Date: Thu, 19 Dec 2024 08:05:17 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iio: dac: ad5624r_spi.c - use of scan_type
To: Lars-Peter Clausen <lars@metafoo.de>,
 David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <3f5ff01b-8c32-423f-b3cc-a95399b69399@gmail.com>
 <296d9e03-1153-4589-95b8-87195d7bbdef@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <296d9e03-1153-4589-95b8-87195d7bbdef@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/12/2024 22:53, David Lechner wrote:
> On 12/18/24 2:38 AM, Matti Vaittinen wrote:
>> Hi dee Ho peeps,
>>
>> I started drafting a driver for a ROHM DAC. I took a quick look at the ad5624r_spi.c, and the use of the 'scan_type' -field in the struct iio_chan_spec puzzled me.
>>
>> I think this field is used by the driver to convert the data from user to register format while performing the INDIO_DIRECT_MODE raw writes. I don't spot any buffer usage. Furthermore, as far as I can say the 'sign' and 'storagebits' are unused.
>>
>> My understanding has been that the scan_type is only intended for parsing the buffered values, and usually when the data direction is from driver to user.
>>
>> I suppose I shouldn't copy the ad5624r_spi.c use of scan_type to a new driver. I'm somewhat tempted to send a patch which drops the scan_type from the ad5624r_spi.c, and adds the 'realbits' and 'shift' to the driver's internal struct ad5624r_state. This, however, will change the interface to userland so maybe it's best to not do that.

I think I was wrong here. I suppose plain scan_type population does not 
result user visible entries if buffer is not created. So, confusion 
stays in driver - but it also means changes wouldn't impact the userland.

>>
>> I wonder if I am missing something? (That wouldn't be unheard of XD). If not, then at least a documentary patch with a comment "don't do this in new drivers" might be Ok, or how do you see this?
>>
>> Yours,
>>      -- Matti
>>
> 
> I think scan_type is a convenient place to store this information even if
> buffers aren't implemented. The struct is there whether we use it or not,

Valid point.

> so
> might as well use it. And if buffer support is ever added, that is one less
> thing to do (removing the duplicate fields).

I find populating the scan_type still somewhat confusing for a reader. 
Kinda willing to hear what Jonathan thinks of it, he probably has 
broadest view on how to keep things consistent in IIO. If it is usual to 
use the scan_type without buffer, then this is totally fine with me.

I suppose the shifts and amount of bits are constants? In that regard 
one could also just use a define, which would make it possible to not 
add this information to any of the structs.

Out of the curiosity, do we use 'input buffers' in IIO? This far I've 
mostly worked with IIO devices focusing on output.

Thanks for sharing your opinion!

Yours,
	-- Matti


