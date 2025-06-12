Return-Path: <linux-iio+bounces-20559-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D160AD767F
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 17:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1135D3BAB8C
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 15:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2B32BE7D7;
	Thu, 12 Jun 2025 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1qQ2O8ZI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702A421FF44
	for <linux-iio@vger.kernel.org>; Thu, 12 Jun 2025 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742281; cv=none; b=AL9x/S8RsQFfxNS+ntibPdWM+gPCi+XNWBXqnQ/+AMzuMX1zUbPBXpLUoXz7lTJb48VuuCoTW3i9//yLvYYzyowdf0IGoi3Spcham0ZWUys0fnb26Mf/d5ZdaNGTjKGijS2qPO9gl8SL7Sz38ZvYezkhyD/stq+Fp/tQ8mCW2jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742281; c=relaxed/simple;
	bh=H5AXH6AjSFVJtfqOdZnZSx9Rs/PN7fL6rlcePjJOXq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqSZUcSVih/cBC5toz3PdikK3f/2PRZDMI6Py2MuRBmJXMWh1skvTpmB21bILIB7FsRtfRhzPtUcFFbdauFsIu6esNR+YexNj+hnwKcf3mjBXKRimIBTbL5Psgq91ikyIapNQSvG/ifxZSNgajQF0SJuVHU/z+GLDs6Ctkt6G1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1qQ2O8ZI; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2d0d25cebfeso761216fac.2
        for <linux-iio@vger.kernel.org>; Thu, 12 Jun 2025 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749742278; x=1750347078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sb0DG68kqsOtJjiQeRDCa6cNRwoIg8RT6b2RdywqaM0=;
        b=1qQ2O8ZIA8NfjdOWHN2lZgyDpIBQ0djlGAZlWf7sfXsrQBjE2OWY114CAZ7XDyd/92
         I/pyV7JfVPrtn9J9cdC83nHctGRAevItfZTAX13AtEIwOLoXavoKY1vvwQua4LVVmsgs
         dHnb1qSAD4xoltOxoSPcw2xxU7TtOoCkzl7ysSE5zMASS60/eDQFv7gzdk2aZ3VwYkqi
         PcE1SlM29/5L7mHVnJ7K4I/MLHPRxVs16zwnKo27IpFmJ8B63S7tK6jFFeWIMWUpXgO8
         n/oujmALkDhm7Xcoq7w3+UjIdqLFXWQWW1G75aivNf86ie/U1kEM6IBmyTsL764XvxwQ
         dpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749742278; x=1750347078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sb0DG68kqsOtJjiQeRDCa6cNRwoIg8RT6b2RdywqaM0=;
        b=Di0c5feZdj8h/SKugrEmq8LZl4wF1+cy3sBR4xmysT4vxJNL5qLiVs08lllbqmaKlR
         NV+G6LsqwxITUXVx2neZxTRHPh4dcvG0TfTvoNAaDHPuFVJMwtY6hTiT/GA6+s5yUYXs
         eAWausm94Sc112LGxcAKMOkFafHyElhsqcOv7l7T/OV1m23JdoXCfqRmAfqWsx9T5czk
         jR7CAiopT/xu2Ube98doIOJouhcxJUeE07tP2yWTwiham7bILIO+6yAJeVtGos3wCGsQ
         rBhdafyV1zIlxwuFZDEv8Zu0/EniGmdvK5Kpy8pqTflaFiu1AnV0Clq6QAi9B6QvlFqC
         NPyg==
X-Forwarded-Encrypted: i=1; AJvYcCV0VbFct/GFjZFwGhLx57m1qlxQEKrDwtV0qjP0mwNuu2maDdYl7svCpVIqINHZGoIXP5jNM6pnepw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDCa0VesLni7qpgWBYCt6AzHR7Hl9POwPb3xlJX39L7S1BTpQ
	nitYkjZW3Dcynaz8kC4LYEtiTByElrxFWlit1PsCyHWYfe4qg+5KfICsM4l2GtchcwkteMoGMMc
	O3uJI
X-Gm-Gg: ASbGncu7D/fyaUo9qhXUyu0gLw6Cbnn3juHkP2SFx+4B+neDOiu4p4dYipSKsq7Rlkk
	eIDMO7nm2rRQXlVoY9h+GzXub8tQzaxMnkYBHckdL83DyRaew0Vk9T2lfVylXEw7Om6Cn/hEauF
	CpeXHAqS15MJS7bTZIr263j0okVMlCuicw+J0U4GJGc+vgPkSulLuJb5RYZHRl3Q8IhquXkfKK3
	P5j1PovYWMjG4ygrNH253yncWaJGZZHBJflgOZ11CVMLiYRLu6jqkVu41dYu5BEPYuRD8VYzp9M
	9j7L4G6AyX5jT7ehqCjEFMdKVk/YTTvhxbzJdWLiktGRxeJG9vQ7bcYxhYkTugWgGtaqHZnv6If
	RuXSQhFQRQssIKWStC7rY8WmcFG40s6/4QE3+pAo=
X-Google-Smtp-Source: AGHT+IEXk1MEAgn3GWL0UwcEnAB3sN4qw0YAKFMnUzzUstHuY7HcHFRe28KwG1k2QdtmDL8omNeQEA==
X-Received: by 2002:a05:6870:702c:b0:2c1:44a9:fc16 with SMTP id 586e51a60fabf-2ead0619abamr220359fac.38.1749742267689;
        Thu, 12 Jun 2025 08:31:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4753:719f:673f:547c? ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2eab891b2b9sm327301fac.14.2025.06.12.08.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 08:31:07 -0700 (PDT)
Message-ID: <fcd1af23-7d8b-4a0f-bae1-5a60f8876269@baylibre.com>
Date: Thu, 12 Jun 2025 10:31:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] iio: amplifiers: ada4250: use
 devm_regulator_get_enable_read_voltage()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-0-bf85ddea79f2@baylibre.com>
 <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-3-bf85ddea79f2@baylibre.com>
 <aErQEn5sdf25Vlvi@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aErQEn5sdf25Vlvi@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/25 8:03 AM, Andy Shevchenko wrote:
> On Wed, Jun 11, 2025 at 04:33:03PM -0500, David Lechner wrote:
>> Use devm_regulator_get_enable_read_voltage() to simplify the code.
>>
>> Replace 1000000 with MICRO while we are touching this for better
>> readability.
> 
> ...
> 
>> -	voltage_v = DIV_ROUND_CLOSEST(voltage_v, 1000000);
>> +	voltage_v = DIV_ROUND_CLOSEST(st->avdd_uv, MICRO);
> 
> Side note. I'm always worry about CLOSEST choice when it's related to voltage
> or current. Imagine the table which gives you 5, 3.3, and 1.2. If it happens to
> be closest to higher value, it may damage HW forever.
> 

The rounding to volts seems strange to me too, but I could not find a public
datasheet for this part, so I wasn't able to determine what the "right" thing
to do is. It sounds like this is just some sort of small gain/offset calibration,
so I don't think there is any serious problem here, like it could damage the part.
So I will have to leave it to someone with the part and the datasheet to figure
out if there is actually a problem here.

