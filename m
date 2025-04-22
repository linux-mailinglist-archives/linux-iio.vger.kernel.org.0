Return-Path: <linux-iio+bounces-18521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5E7A972DF
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 18:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F72C189FF89
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 16:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F23293B71;
	Tue, 22 Apr 2025 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t7JtO7ox"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B460F290BBC
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339830; cv=none; b=Wnn7PxTI11vMOLBKoyNJcR00+E+A/7DK3++HBB+tY9pqeIKeYkPFhTCrdaDCrg55VREXUt/pC/iAu2IJVS42G7Uwk7VNnR4/g/S4b61KJSZgsuIO61h39PmK852LPXHeBtAe7wc+fToTcBI43nKnZR/1A6M4ZwdYT6pW1qOp7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339830; c=relaxed/simple;
	bh=nZrPMxYNkgQAw1l+m5oRrg6n8nxqvbfX20bz/ewIQt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCTmidq2fnhjvPno/PEmYIBPvs9Lnhx1Vfamr8wa2FEloZGcaZvJxizPRWipL4ZftN4Bz0e28APBuHFJHKDbVmKoYNgpd6gRVnTnw9H9Ss/RFAebEMK6rBhyp+eZFCGWglrYOR9yJjLfIoSsD+J1cZwlB9o7TnbgtLSrrXwZeDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t7JtO7ox; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-400fa6eafa9so3479194b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 09:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745339828; x=1745944628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pep2KTX2D95/sTe/gu9n1JKfRNihxNZ6pUsc7YWRGr0=;
        b=t7JtO7oxnZAPViyPe1Pa4ZJ+SS4jWY0tN0KjPhhxNyG2PbTRd/3bNy6wLFyVLebTDP
         Zf28LRCZQDP2HO/pyFDP4vTj5+/NcuFRr1UyzWBMqd+aLsy3QCO4HDFiBw/59nnCy2gv
         2nFswnoKWnShtMAUGVxDWEsEzFVBLs6yySQKOfdKKqua0m/WtTIhTwYlgTamn6K4Qp6b
         cNHJvKixgrNm0HrfSSG0q2KL+IWmtqK+1yyDBftLGIDBDrot+Sc3pGhDnojqkA/o1l96
         /xZ8bvYPqFysVj2tm8l+cHOuI8zbXQsEEH+kEm5A+1MUK/nAiZgaSbyPig3FW2LzUd8d
         Wzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339828; x=1745944628;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pep2KTX2D95/sTe/gu9n1JKfRNihxNZ6pUsc7YWRGr0=;
        b=igi0jLvobekKkdyyUWcVdsyzNPFs9d4olAYOMv22P1ONuciRzpoYvj7SeX76cgBD8f
         XsymJhlFSDXqt5DPVFQjQXFZad8bWcAyFiOHhKH485ukMfb+4yF9GAS6qqH1oCqkXZRW
         LhNYBtwX9qJnvlVfr1J/OowfD77uXIwwNCXhl8pcEpVLKJkDDKL9kabt4Un8c4DY2uLG
         kxL2iaJnUfkEhlZRfzZeG4Y34abG1Eps9RqcowYR8w1hC5aJlV8ZVMy1ADfDyr8aec12
         8P7ffziA8r4u1rxFGQ9tYdcFQoSlMABC6Zeg/qCykMgwwn8QishcltR8EVhGUbP3KFdw
         1VSw==
X-Forwarded-Encrypted: i=1; AJvYcCVxq0SZb1VgqLLnsXVE+1tOFGsymrNOc18qQlZz9/sFI8FXQV4H6inFoVog+Pot8yBeoPq9lkePPK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqglhVp5HOK172Sj5BCAcG/uKSBaHcDAwyPkNpfj+ptEccpO/K
	vjKZny5QsOJa/+V9gf0Wqf6qg08HjxZuX9mG5E0prukrJ8kAtIZ9wF5edSVEcJQ=
X-Gm-Gg: ASbGncvgkQepFuZk68IZ27IHsLjw4ZsQuS+nMOouJJNXzt/GBv6Hz63etOtIAgDZC78
	iDjFi0XfDymFsXT5ejr09VMqBORTM0K28W9kXV41JJI8wY1FFC6BethcQikC/8OuE2MK/MvQwnM
	jbOqEsXSed9YhqabDLMGO9KGQbGYYe90FgvIkW04pc2AzGtWwlBYiA8LiXoTZEiXlGGmywUhZ+g
	65dpy9nBiXPZYbWRv8J7gKoTSUlnjNIB5Yej4UjGM0xDgo3ao25H3i+ZvwNY/KLih8cHKWjCRl+
	LJrVcOOFGZdL4Q5p4PgVo+MEhOWxuWIr4btRrOWM+CdubeA1NUF3VPrxvKx63cfHnUsvoKQTEqB
	VVQEJMIgM+YIhK9UFnQ==
X-Google-Smtp-Source: AGHT+IEsNtQ5cBYHOB91x37Mh5K6Ezpdmm9D8utb/XIypNd8fTQbJlQwrNsui/TKQd2P0uFIbfLWhQ==
X-Received: by 2002:a05:6808:80cc:b0:3f6:aad5:eac8 with SMTP id 5614622812f47-401c0932754mr8613325b6e.6.1745339827721;
        Tue, 22 Apr 2025 09:37:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3? ([2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401beeea9c0sm2170837b6e.22.2025.04.22.09.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 09:37:07 -0700 (PDT)
Message-ID: <efec7563-9591-4539-a154-bf486d35df0e@baylibre.com>
Date: Tue, 22 Apr 2025 11:37:06 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
To: Andy Shevchenko <andy@kernel.org>,
 Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250421-togreg-v5-0-94341574240f@analog.com>
 <20250421-togreg-v5-3-94341574240f@analog.com>
 <aAexmOU1e-7hXq6Y@smile.fi.intel.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <aAexmOU1e-7hXq6Y@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 10:11 AM, Andy Shevchenko wrote:
> On Mon, Apr 21, 2025 at 12:24:54PM +0800, Kim Seer Paller wrote:

...

> 
>> +#define AD3530R_INTERNAL_VREF_MV		2500
> 
> _mV (yes, with Volts and Amperes we use proper spelling).

When did we start doing that? No one asked me to do this in any of the new
drivers I did in the last year, so I didn't know this was a thing we should
be doing.


> 
>> +#define AD3530R_LDAC_PULSE_US			100
> 
> ...
> 
>> +	int (*input_ch_reg)(unsigned int c);
> 
> c? channel?
> 
> ...
> 
>> +	int vref_mv;
> 
> _mV
> 
> ...
> 
>> +static int ad3530r_input_ch_reg(unsigned int c)
>> +{
>> +	return 2 * c + AD3530R_INPUT_CH;
>> +}
>> +
>> +static int ad3531r_input_ch_reg(unsigned int c)
>> +{
>> +	return 2 * c + AD3531R_INPUT_CH;
>> +}
> 
> c --> channel
> 
> ...
> 
>> +static const char * const ad3530r_powerdown_modes[] = {
>> +	"1kohm_to_gnd",
> 
> kOhm
> 
>> +	"7.7kohm_to_gnd",
> 
> Ditto.
> 
>> +	"32kohm_to_gnd",
> 
> Ditto.

These are defined by sysfs ABI, so can't be changed otherwise it would break
userspace.

Comes from...
What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown_mode

> 
>> +};
> 

