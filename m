Return-Path: <linux-iio+bounces-26909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D3BCAB86C
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 18:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EBEE301F5DC
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 17:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C162D4801;
	Sun,  7 Dec 2025 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PBkC56dl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9860526CE11
	for <linux-iio@vger.kernel.org>; Sun,  7 Dec 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765128808; cv=none; b=jLrGihsrMANHtKutvKh0pBTEKIw32mSWGikuoUFuhRrG89DgTGqozOje5qbZUqI9j9rxDoWnPsAcbt5sCJzLpSP/MI+jdGlbnI+zbp2ZVhSxNA/R2Ifc3KXRE26IGnLjpvixZ8MGn04GIYeLMZoFcidJ/U9woCljdsKwE31aygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765128808; c=relaxed/simple;
	bh=upuLaWJUfJ9Dtg6RiVX8ZQwvFkfM6+82FyVeqtASJt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXJy9LA6xWM4YFnKhMmJUlyZ5CC07G5XgaOVBT1E6Holr/MULBFqZrVKoYuFTriVrs8NtJu+dPaQxC/XWABQykrxQLYQ6m9pJQfGxL460BIAJVNIQi6exlVW/qvJpGwxNvUs5dWSseZGcyEhRzrH2KeeVv1/h+58W3pY5uuwJYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PBkC56dl; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3e37ad3d95aso2750186fac.3
        for <linux-iio@vger.kernel.org>; Sun, 07 Dec 2025 09:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765128806; x=1765733606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WuX0Nt/dS55N6wWwLBaQ7tdaGgJps7NbD2DaK1qGYx4=;
        b=PBkC56dl2GewTlli7x5ahG5JIt1bFqIsNKMnyB8hCt2qYhHA9iMKMFzugaFS8Tkr6T
         tUmx8Qtr9zWiYG8WAeF7iVo+eJAjN4bm9YSFm1EuQYOGjLCwzXvcYPyRH3SQWlJLalsM
         jA54fvWvujZ+6TlsevwqQ+cQ602jCMO1hGAZUhB6G7nA2kpLrGEZpqkyYEgqhryHRnAY
         K4USwuQoeWcF4fwOg8l4C4yeNaRmTi4MvdqbI3RNOgiH0AnFPlc2zlUJU89evCAzBVT7
         p21EO+MwP7iGnDb4ai93MWCwLH97r9B26PcisEHD1slZS3Wn64qBWYemGXMTHg2oqonS
         Jd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765128806; x=1765733606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuX0Nt/dS55N6wWwLBaQ7tdaGgJps7NbD2DaK1qGYx4=;
        b=GZ0TOw0euMjVbg3PSPq4rOC1iOt0kb8F6gFi0CS2HtMZCGoFuRlG2H3GldxhCfzvEo
         bCwR/bBP9MGVdDA+Ib7cXp4nHO7sKX+BvOPmrR0nUFwnZyQnnKbOzV8gT/FgUEsHHP89
         /UFkV56nYIfUi8k3edI2FEPG8PLkBhZeeZRW+hmDmkxzq9icrgshTCgChVY+UcM43Pgg
         y2HR/gixnz3z6PLdkhpqnxmJYtXXh1jckitgUFjrzPkYCgDfI+1XWttIXNYle9KWbZ5F
         3DweZ1hRxGqppJSbWoOVhCUHyLFPJIHYqDTsKgpwRpSjUPuZQLw/dDaXT79a8JFBkpVv
         CxTg==
X-Forwarded-Encrypted: i=1; AJvYcCU4j0EXIz/K2GA4L/QUtWc0dENMLl5BzQ/43umo2+uxzcyOyk38ea76RoCBsVmTh8fRCaBEmH70Cpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+UFweY+rRsSM2RP9FnUl/+nduhz99KRm5nhfS3is5f6IuAIXI
	Shvfa43IA58gLJsFhV0jkkrWnZ3uLKA6kq44s1FwNrmgtXqUzDX9f87y0yxajq94oD4=
X-Gm-Gg: ASbGncv89gl/qWhZL2yovI6oqgOrn16x1+0Dzo8wYmhJXgvj4z34BLvhNBxY9UELd1R
	hYOvfh1m4Os3HN+uRoBuZLqXy0rIPToDWyCT//sGttO0u3PRXV9HhUb6iKw9yXvQrP08N096f+W
	vJq+GoYuHBLdD2CJMGd7a9y33XxolkvJ8BKFYb7e7eE5R45D17PsXWFyn44rAEfAfjLtS+3QDwb
	L1kOlaiEKZcS2K/9HnOIk13ryc6DdOPim1ka+ViwuFExUeMAkP9xiK6Ctf/32WQ7Fj1wa9rUWge
	MRJsqSvv3lV4TBu1I1v38ZwOZkCc4FGXT3/M19YqLH50bQlq5ZdKsUcKQnIiAR0GmeHmywzYoXu
	zUkvUyoLeAOJBq/mD4MXwqPvfzb0omrnJ4O3TylpHs+SUs8yX77/c+WnBhL678Wyd/YPuD/cGhq
	LRdphrRxz89+82lu8a3zba/VxcVp5/RWc5H03XARsQwDU1ddKPWpyrqyUGiEDX
X-Google-Smtp-Source: AGHT+IEw7s/MMgwNbpoSL6Z3OPXYKqE1GK2i9be0sI0avG5SlO7iW66QamD3JVTnVg509CwIrcNanQ==
X-Received: by 2002:a05:6870:ec8a:b0:3e7:e08e:742 with SMTP id 586e51a60fabf-3f5440896b2mr2553279fac.32.1765128805623;
        Sun, 07 Dec 2025 09:33:25 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:be99:7ce8:d200:2438? ([2600:8803:e7e4:500:be99:7ce8:d200:2438])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f50aa34d4fsm7406835fac.5.2025.12.07.09.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Dec 2025 09:33:24 -0800 (PST)
Message-ID: <668712cb-06e8-40d1-8a21-bf8be3522e0d@baylibre.com>
Date: Sun, 7 Dec 2025 11:33:22 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: dac: adi-axi-dac: Make use of dev_err_probe()
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
References: <20251203-iio-axi-dac-minor-changes-v1-0-b54650cbeb33@analog.com>
 <20251203-iio-axi-dac-minor-changes-v1-1-b54650cbeb33@analog.com>
 <07439e95-47f5-434a-9f6d-d7740375a3d6@baylibre.com>
 <9bdbdb91ea6b8049658fd6015722c5e2beea183e.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <9bdbdb91ea6b8049658fd6015722c5e2beea183e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/3/25 10:29 AM, Nuno Sá wrote:
> On Wed, 2025-12-03 at 10:06 -0600, David Lechner wrote:
>> On 12/3/25 9:53 AM, Nuno Sá via B4 Relay wrote:
>>> From: Nuno Sá <nuno.sa@analog.com>
>>>
>>> Be consistent and use dev_err_probe() as in all other places in the
>>> .probe() path.
>>>
>>> While at it, remove the line break in the version condition. Yes, it
>>> goes over the 80 column limit but I do think the line break hurts
>>> readability in this case.
>>>
>>> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
>>> ---
>>>  drivers/iio/dac/adi-axi-dac.c | 20 +++++++++-----------
>>>  1 file changed, 9 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
>>> index 0d525272a8a8..0c7b62f5357d 100644
>>> --- a/drivers/iio/dac/adi-axi-dac.c
>>> +++ b/drivers/iio/dac/adi-axi-dac.c
>>> @@ -942,17 +942,15 @@ static int axi_dac_probe(struct platform_device *pdev)
>>>  	if (ret)
>>>  		return ret;
>>>  
>>> -	if (ADI_AXI_PCORE_VER_MAJOR(ver) !=
>>> -		ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {
>>> -		dev_err(&pdev->dev,
>>> -			"Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
>>> -			ADI_AXI_PCORE_VER_MAJOR(st->info->version),
>>> -			ADI_AXI_PCORE_VER_MINOR(st->info->version),
>>> -			ADI_AXI_PCORE_VER_PATCH(st->info->version),
>>> -			ADI_AXI_PCORE_VER_MAJOR(ver),
>>> -			ADI_AXI_PCORE_VER_MINOR(ver),
>>> -			ADI_AXI_PCORE_VER_PATCH(ver));
>>> -		return -ENODEV;
>>> +	if (ADI_AXI_PCORE_VER_MAJOR(ver) != ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {
>>
>> Can drop the braces now.
> 
> Yes, I thought about it but then kept the braces as we still have "multiple" lines (note checkpatch
> does not complain in cases like this). 
> 
> But I don't feel strong about it so can drop them if you do :)
> 
> - Nuno Sá
>>
>>>

No, I don't' feel strongly about it.

