Return-Path: <linux-iio+bounces-16200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83CEA49E16
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 16:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CDF16EC29
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 15:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D77D2702D6;
	Fri, 28 Feb 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BVw8fyRw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D471260394
	for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758166; cv=none; b=qcKVwe/J+4C/qdiAu9hq8y3TMuvpfNnveB3khUBk4lXdJutvRw3HEDQi6ubJx0ryxAiMZHSJ4mXMmD8LdWRNCA6Jh6erISwUml3J1jehLQbltbBrTBkDnxR0gUHOI1qnBQRdqIjREhFeW5ojTX7Zbwwy/uLzTfvf0clQFp6VL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758166; c=relaxed/simple;
	bh=OJHp7VZvRwWS1K/7eV214nwFzt7cYL2SY5OmYa4hj/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M92UyxGcecOwD5cY+mq/RDP3IVWyXYM4gczuwf0Q3bT4xT3FREnM6l52GNV9SmWXmCor3D2BX3SDZN5y5NragCZxM57dO7iBFZXc3Qjz31nD14QXVEwsgtvVCdrbHJ/og6o8cRgKDXdVjYPuTDkPSjbAbxsOF6VXwuq8kZ4YJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BVw8fyRw; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3f554b1ebbeso714196b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 07:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740758163; x=1741362963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jSu8j+FYHI2OUVoF0suPQbNQe842QD9Q4xMlM7FXCrw=;
        b=BVw8fyRwu+r3c34756uI30aUJo0lj1GgcZrnhgPrWTdi5hyLjmZ1ZwHEgx5fiYj22T
         ZbjDlUO530z/AdZOeRLTA4F4b67J/Lv1jZ5v1I1LPe6gqCPAbsLBPoNXVY+Jn6Y/Wfkw
         PgHDIISh9Xx0KIP4Ete94ig3LLq/Zr57x/okc/4bvZSpVYMVmxIYBlD99qi/C1a0DS4q
         7JJR8WgSw7ZAVzlr34H0NNW7GJDMI6cmAfQ4TlW5X6rfEYPiiUKTMPtTDsEB4Ewrpgvb
         zjXzV28mJRo3jFuJQaHPDGzwmjZxivocicaEZ35aKkegxVAyViRfat2l4TzrQzOnkKHp
         9lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740758163; x=1741362963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSu8j+FYHI2OUVoF0suPQbNQe842QD9Q4xMlM7FXCrw=;
        b=BQJoJVIpsLt/0Bof3HvUdpzsG9BJMRuLtdYEkphzXA2rfsnwXWfljeyYwS2KmWPtyJ
         aaFMoMZoX61WYpiV6udPpk0kvIHQWG/OxEDwafD2G2w3fQDufunNZnb8CuF3RWdocSVd
         Qntvn3CEh4mNGLWJ4MnYCKDWJyJcmdMX6q/XC09q/ELuZUPfDsgTgYGx9A2POsewBbaA
         S/nT3pipGGTluM7VJEIRWS4UEag5ZgBGskEYM2xZHAWih3GapwQgnYsjL/SAUY47Y7ex
         USFDOmUbT4W1lOn2CG1RgHCYpVh+/jwoxwdYFwISmR3gFuQqunG1b1RyV6Ba7PIzLi5i
         lsgg==
X-Forwarded-Encrypted: i=1; AJvYcCXm+YDu2WBuSiF7V7wsq2Xp07XGCFCKSvcU7h2PiQWvVxr5ft1G5bWuOUOXXZ0WUVbKjaK+//MTkPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiqirBSbSeGML2vXUB26kH5zgO1xe0wwTMOiSncswVuCsti0PA
	0QncSCGBpx5wyW5BywKc76ycnOgPlquz6fdMmvwABRMklR44UNNdKakRSqsZ6fU=
X-Gm-Gg: ASbGncu40S+1fIaH1mqZeM3iO3mPVtMpgqELWq/SMbEDMb/2AlymmsoZyb4Q9V4jboe
	Ybv1fh+J8OfnaCtR+y0kxddpCq7X2v4TdXm1bYahoJARdLFZhahy+zG2oG9CEYQ6R+xSvPRWltr
	HuYXzb0IIH09iAsCeVN3+xff7NZJ/EdXdFKDUUYq6qt4sl6HbNd4g8go4kUDt2fW7zCme2nh/9b
	Mw0PzDEgA4j5nuWurAeTuQpKBHNPsccYm5G/ZUOOIPv5c8+Sox2GTooLDzNw6qrsl5/aa4VYbxI
	a1a1vtXQOLVNtZucwaQU+FbyJqtE1wfvmPyEOFIOTXTax9nQG+/8NzH3LfER0Os=
X-Google-Smtp-Source: AGHT+IEz+QWsZh9g7sxv9lpVwgpRYlPz2JWY5g4GsIrrNkXKATdXv7zz/1J+LshZPEHdJvIMw4mGhQ==
X-Received: by 2002:a05:6808:3a07:b0:3f3:b8c5:5008 with SMTP id 5614622812f47-3f54edc725amr5092826b6e.12.1740758163061;
        Fri, 28 Feb 2025 07:56:03 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f5507bfa32sm680421b6e.41.2025.02.28.07.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 07:56:01 -0800 (PST)
Message-ID: <ddb448f0-1cfc-497b-ac1f-9f3d9e9fcc3a@baylibre.com>
Date: Fri, 28 Feb 2025 09:55:59 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 12/17] iio: adc: ad7768-1: Add GPIO controller
 support
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jonath4nns@gmail.com, marcelo.schmitt1@gmail.com
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <62cb9786b02adde118db9349617cb796585ceb02.1739368121.git.Jonathan.Santos@analog.com>
 <CACRpkdaSY7WH191makzPcZqLd-vBsC_f6yagWzBa65MrC+pjKA@mail.gmail.com>
 <7c5e2364-038b-48a8-ad67-3cf0f2fd2be3@baylibre.com>
 <CACRpkdbw3BkpzPQp2PdV8M61V2XXaLcmuOpGTsxSoiQTH7wZXw@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CACRpkdbw3BkpzPQp2PdV8M61V2XXaLcmuOpGTsxSoiQTH7wZXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/28/25 2:52 AM, Linus Walleij wrote:
> On Thu, Feb 20, 2025 at 11:27 PM David Lechner <dlechner@baylibre.com> wrote:
>> On 2/19/25 2:34 PM, Linus Walleij wrote:
> 
>>> Is it not possible to use the gpio regmap library in this driver
>>> like we do in drivers/iio/addac/stx104.c?
>>>
>>> It cuts down the code size of simple GPIO chips on random
>>> chips quite a lot.
>>
>> I think the answer is "no" since we need to hold a conditional lock
>> while accessing registers. Namely: iio_device_claim_direct_mode()/
>> iio_device_release_direct_mode().
> 
> Sorry for potentially dumb question, but if this is required to access
> the registers, why is it not done in the regmap abstraction itself?
> It's kind of that stuff regmap is supposed to hide.
> 
> Yours,
> Linus Walleij

In some cases, we need to do multiple regmap operations while
holding the lock. Moving it to the regmap abstraction would only
allow the lock to be held for each individual regmap_x() call.
That would leave us vulnerable to race conditions.

regmap_multi_reg_write() couldn't be used for this currently
either because regmap_lock does not allow for a conditional
lock.


