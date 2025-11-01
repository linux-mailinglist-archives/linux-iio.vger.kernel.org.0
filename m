Return-Path: <linux-iio+bounces-25781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 427FBC27CD1
	for <lists+linux-iio@lfdr.de>; Sat, 01 Nov 2025 12:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3EB34E9967
	for <lists+linux-iio@lfdr.de>; Sat,  1 Nov 2025 11:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F0F2F5A00;
	Sat,  1 Nov 2025 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmWx0x2Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DDD27F16A
	for <linux-iio@vger.kernel.org>; Sat,  1 Nov 2025 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761997065; cv=none; b=uSpnzZD26e8yd0PhY5loy+oo3aVb5UTAEGyVYdJDE8yP1Gnt/EdrnWqW5F/1io0sTqKxNzD9wfAt3pRivyGJTlwE6JEqqVxmtU1pcHge1UeDFl6B24fBNxEqxHjbD8+VPsKeu1jsSSpwNqoT2b4ckURm5ck9Wgo9BMhO+Lbe5aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761997065; c=relaxed/simple;
	bh=7IfCe1yJZ8OATH2vDaCumIpLU4/MgZjeWWPo4JOsHeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFT88CfOoi5t2xNm8XhEshFfWjZ7sMPK3Ag6B/SU4xoq+Mkql7Idw1UY9UuJpfwkOaeHoHhkpgQTJnzI8NuEpyU5iXx9gQelCinB9Nj6nsHLzUwwKaNU4dj0qUc6AC/36cifsZdU37LsGd62Dzv9UqH3x+XzwuY+lEhgnkh2mak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmWx0x2Q; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-290aaff555eso28226895ad.2
        for <linux-iio@vger.kernel.org>; Sat, 01 Nov 2025 04:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761997064; x=1762601864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7p4U/aotayqb+o6BTayF37konWJWlNpUHWv7lMsZ+s=;
        b=kmWx0x2QJm2h7NYgilHXZjUnELxxao2Pn4NalMWDEtRS/GPrf6n0ogY01KiOuo6BXR
         kTpi4XFwIWtsqmkAJuGudfkY42Ro0eFGRyq39YfFvBfMiDonqXPm5dD/Tf+rzDGT1r9m
         L2RYAdlMcIDCAckLPN3jVjUq7EMhJ6np3YveBaoHkWfH8Cf7hdWNjpl8dlDGmB4aq4Pv
         nwmZZNnardmgtwv5gmWH6/1uCsqnZOTw4xpFa8N/Q23wOlKPsWYjz6/DKmb3oEif/rNn
         rQGyZ1WDY0N4EPQ6Vho6z4lV3/42e4ZY38vlUmmxjFCE1UXgXuJ322HE42vXasccKb33
         jgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761997064; x=1762601864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7p4U/aotayqb+o6BTayF37konWJWlNpUHWv7lMsZ+s=;
        b=kvREPCOVGOHdfkWAhujFp3+y0m2747UIh+G218kVqmacM4Ew5DIVRV/zb8tMbqkVBC
         JEa79GW20nCELVwk06pki6o/V5VjLuR4qYfuoS1Yirqt90BNdObE+1UZ6lJlfVdYhzlr
         8tv3iBJJHBnQh2cvOyZVsOdPfqbNTuB/dG+TdCmalg2QWmM8IJHxoyG+s41kyk08n5TO
         /5FSTVRK6Gux7wVmyATxYy9dOYHkrrS38aAMS3J3kqI74buG5N953Lt0q8jjmBBTPcdu
         RDgdmcIagO8MVshNVxBpUpFLLIdlBvsKYOlwz+Kb4taEyPWat/4Mt8scn1y36XgG5+72
         yQjg==
X-Gm-Message-State: AOJu0YxOUY+8HQEkF42yMlEpZqMZ4Y/M712VeTEfAyCF+qGaNdO3/32/
	1xvAUZeuVKzeNLVvmmb0lqClHvyt/taT2Z/1dW/nvY2qjgW8OCNDJeTO
X-Gm-Gg: ASbGncuyFNfHgznU2isaCQlaM5CT7as8r8/LNzFKnl3UORDsPmkltTUofxq/OAW+hZ0
	um1OG+gVG456z+B+QMK9P1vTRMFK+JHB2g2lrBYmbpPvST4865wBFIYvWBKiuJx4LpUWnJfqzQW
	FuMHjWocg6NQX2mv7vn3wmkLQ++/tIz6Mf8wx/wdhdeccwlQyVblnaHBYgrWqGfFd9jL3GyK2qR
	euLcp8fv8AkjbmYGddsdUYjI3bZX+RtX+3BC79r/kPXmxBOqdy03fym02jSekD03pmndCxJpXF7
	jMrkrgavat4hGvrqbRoq+r5Q/khPoGi78l8/fC43H89UCrjvchbZjaB5+wt3dHALI/Vv9c8OsEX
	zB5hH0hy2gG+ajWi3DCxBvlHdEwFFG7HI6oDOKn2OEw/ocweVykpSW8Lw4cAO+KaJnp+iw3Rvo4
	tHf5QICcHIvwvYsEoTwo5jHlEv8goH9wn55wizvuNy3BBh4cpHXnyq/umcf69XqV0mLmaTxd49o
	6ISAXxQLMEkrsgug4MWkTydkAuHpYO4k1OSXmBjNjCKts2KX48Qts86dn/0CP8+0Izj65QHfh4y
	8epje9Uk
X-Google-Smtp-Source: AGHT+IElqgpdi0hmBlhoWaDzwCMRVG9l19J7bo2p6s9Q8XOq2cgtoU26ySYjwTwYUrWC/KeNqbFRWQ==
X-Received: by 2002:a17:903:18b:b0:295:5dbe:f629 with SMTP id d9443c01a7336-2955dbef73cmr10992835ad.8.1761997063284;
        Sat, 01 Nov 2025 04:37:43 -0700 (PDT)
Received: from ?IPV6:2402:e280:21d3:2:61a9:cfa6:c139:b812? ([2402:e280:21d3:2:61a9:cfa6:c139:b812])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2955967f329sm16919845ad.108.2025.11.01.04.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 04:37:43 -0700 (PDT)
Message-ID: <406fbb02-5a2b-4097-a645-b97d3d74287c@gmail.com>
Date: Sat, 1 Nov 2025 17:07:38 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] iio: adc: Add support for TI ADS1120 ADC
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
 <aQR1N__AwvPm21tm@smile.fi.intel.com>
Content-Language: en-US
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
In-Reply-To: <aQR1N__AwvPm21tm@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/31/25 2:07 PM, Andy Shevchenko wrote:
> On Thu, Oct 30, 2025 at 10:04:08PM +0530, Ajith Anandhan wrote:
>> This RFC patch series adds support for the Texas Instruments ADS1120,
>> a precision 16-bit delta-sigma ADC with SPI interface.
>>
>> The driver provides:
>> - 4 single-ended voltage input channels
>> - Programmable gain amplifier (1 to 128)
>> - Configurable data rates (20 to 1000 SPS)
>> - Single-shot conversion mode
>>
>> I'm looking for feedback on:
>> 1. The implementation approach for single-shot conversions
>> 2. Any other suggestions for improvement
>>
>> Datasheet: https://www.ti.com/lit/gpn/ads1120
> The cover letter missed to answer the Q: Why a new driver? Have you checked the
> existing drivers? Do we have a similar enough one that may be extended to
> support this chip?
>
Hi Andy,

Thank you for the feedback.

I evaluated the following existing driver before creating a new one:

ads124s08.c - TI ADS124S08

- This is the closest match (both are delta-sigma, SPI-based)

- However, significant differences exist:

     * Different register layout (ADS124S08 has more registers)

     * Different command set ADS124S08 has built-in MUX for differential 
inputs

     * Different register addressing and bit fields and conversion 
timing and data retrieval.

would require extensive conditional code paths that might reduce 
maintainability for both devices. A separate, focused driver seemed cleaner.

BR,
Ajith Anandhan.


