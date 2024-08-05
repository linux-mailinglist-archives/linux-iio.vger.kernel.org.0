Return-Path: <linux-iio+bounces-8248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E5B9479D0
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 12:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108741F20F71
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 10:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC7D1509A5;
	Mon,  5 Aug 2024 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwVnUpdr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF51E505;
	Mon,  5 Aug 2024 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853729; cv=none; b=griOaZ5GwTYsqEDuNB3TYAvzKXsh76Y25sjxXbEf8DlbfbqPdmqIy5BspGzUkHbqHnC60Uq0/+PNkLBS2DvTRjWfiRuIgIWSrgS1Fd86OO/4X/hXj9C9JlJW3OBtE1qAMCUCil+VG4q68quZBdk6NjAZj6bHdbKuKD/3Hz+d5No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853729; c=relaxed/simple;
	bh=we3oxTn6hETz8INVEye2nJuMXpHgH2R91W0fDhDvYSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPAtAWx9B0MkM5BdWp0dplqruQszP7QH7OUyvlpLpOgik/aFWv0UH9S0xhVVeeVz8gmZ97cys14rsEPONkD4vleyklobr5a680RAV5tUX9ShgGR6ftTZ0hX+Y99GuV1xsounDola82mrEqArJY4UuTmTt46dTHEqTa4nk1uk0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwVnUpdr; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef1c12ae23so115299561fa.0;
        Mon, 05 Aug 2024 03:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722853726; x=1723458526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6AaE1bRufEKsPZbCdARUjQJfzT+p05vZdiBhOYyzZg=;
        b=PwVnUpdrjuGM6v1CQZH9ZtT4BSoRKyDurgJi0hMgGBWFTSsgfV/Hco/0vG7p9baSrl
         y+ZAT+W4znwgq2LO7W4D3WyxwSEQVNELMWTEQl1wKMagfQtTQM6Z1ufnXxIdDfpH4ayR
         guQ1ppV/sy/H4EEyGI6fLSxwjFtdSkeiWi6YhOIzSxLW6dZpanEJrW9uJuXXi/LN9gB5
         NyRlWe3J/CidBAljIx/dpwUdLNUutgYCWd4iWp7Ag6UTOGt88daAW9o3nfgNnKvRGOwL
         Bg2R1RR8rCbfovkzjUZ/nhSilcb6coPpjz3lzRU7svgsJBTpeKqxAKDEs6QQRxcJjKgm
         i0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722853726; x=1723458526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6AaE1bRufEKsPZbCdARUjQJfzT+p05vZdiBhOYyzZg=;
        b=BlzPiKGsiMKEGOBanmtRpkTrKe+QDIbuX1i2ft9JelmGp/UiqBSWPjIAkxwZi3hIAg
         0SOxqCnn3z+O5T5z69xTWF1Tg8L9lqUfUCGT3L+BvsJc2Sgq88BcOn52haaLxY+Ceb1+
         qmvHUToSylvYPx4xtd/Dq/y2FWg6hw5EZ4QFOlBzu+XAqbn8RkV+wzIKTh76RUvrCIyM
         jvvZo7OOB9tLObW+SYu1TJ+3FZD/AxRmMKPYhXJgy08uN0BJsYeDUhhjkccXqT1Kx/G4
         mi2SSnXm7PeFb5n3iZRkpef3vKyhwfaOH01LNj1xvu4Ty9KFs5gcwZ9gyko6HQB5UWI1
         /Diw==
X-Forwarded-Encrypted: i=1; AJvYcCWWRUnqnUJLFParnXhHaKk1k1J6imahYtj6CRM+n32oMcG5i+suACMUF+wnkhBslso9Q4AM1OzS752/FQxVphS5tVoqBksyzK3by3HBfZtvIXG/T6y5k+DoXeInLttthQflvS7CHA==
X-Gm-Message-State: AOJu0YypRJFXdbgXa/vy1itbZfhBS4xyRQAFfOQDieWtQWdJoF3VIEZM
	5beTkd7y3o6wAHWG5yWLIo4ycf090pj1dX5zzFSZagIXm5lT3HJhNSveOw==
X-Google-Smtp-Source: AGHT+IEa6os5riobehR69li/EKLxp5m3BW1qc3/CoEYByRbHrHmIH06hpdZc7+HPrJf3bUqkGDudeg==
X-Received: by 2002:a05:6512:3051:b0:52c:8206:b986 with SMTP id 2adb3069b0e04-530bb4d5720mr7508716e87.56.1722853724751;
        Mon, 05 Aug 2024 03:28:44 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba10fe4sm1094022e87.114.2024.08.05.03.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 03:28:44 -0700 (PDT)
Message-ID: <5622f011-222a-459e-9086-138adf0796aa@gmail.com>
Date: Mon, 5 Aug 2024 13:28:43 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] iio: light: ROHM BH1745 colour sensor
To: Mudit Sharma <muditsharma.info@gmail.com>, jic23@kernel.org,
 lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Ivan Orlov <ivan.orlov0322@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <20240718220208.331942-1-muditsharma.info@gmail.com>
 <20240718220208.331942-2-muditsharma.info@gmail.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240718220208.331942-2-muditsharma.info@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/19/24 01:02, Mudit Sharma wrote:
> Add support for BH1745, which is an I2C colour sensor with red, green,
> blue and clear channels. It has a programmable active low interrupt
> pin. Interrupt occurs when the signal from the selected interrupt
> source channel crosses set interrupt threshold high or low level.
> 
> Interrupt source for the device can be configured by enabling the
> corresponding event. Interrupt latch is always enabled when setting
> up interrupt.
> 
> Add myself as the maintainer for this driver in MAINTAINERS.
> 
> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
> Reviewed-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Hi Mudit & All :)

I know I am late. The series has already been applied (thanks 
Jonathan!). I've mostly been offline for the last 1.5 months or so - 
"all work and no play makes Jack a dull boy", you know ;)

Anyways, as Jonathan asked me to take a look at the GTS stuff (at v7), I 
tried to quickly glance at this. It looks good to me!

Well, the real test will be the users of the sensor driver - so please 
let us know if GTS stuff brings problems to users. I am mostly 
interested in knowing if gain changes caused by integration time changes 
are handled gracefully by the users. :) Well, seeing there is no 
per-channel gain or integration time setting, you should be safe from 
the worst side-effects :)

Nice driver!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


