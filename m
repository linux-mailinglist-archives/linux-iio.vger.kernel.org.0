Return-Path: <linux-iio+bounces-6844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4886191578B
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 22:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695CD1C20EB8
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 20:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFA21A00F7;
	Mon, 24 Jun 2024 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2NqJVsV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366FA19E7F8;
	Mon, 24 Jun 2024 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259540; cv=none; b=rzahD2RZ7hlSnNmtlJQhdoPaLtxkDNEeWUsoVCwrqhxCTvbDrlkZTaUGgk4PBHgAB3ibrtJ5K4Zk9WzY9PH6nmOxgw1kM24fm+nWKSUDNaja8/dLIpXMUdFFAoruu/0IchZF+MvZZagVheN9J099Mxramsf3jPfufI2lFrRskwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259540; c=relaxed/simple;
	bh=N1Vlrk3mnh1mJEtCrRuvn/jo5HxD3wKwkfdpi3Ma9pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jG+pLgoEl+yY/iC71XtLpoFwrNHDXr/r9yzPlkAjcJ4wtyIBFpAtsRa7Vby+NflRK8yw48e2b7HR0c1kQXQ7R156E+ithQD51lfZnTElez4o2cAgQOP3zYhM/TviMTvqWmPsqM0GFmhwL6bgAULoPxmznz2LLwjq4Su10GCPMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2NqJVsV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-70b2421471aso3330637a12.0;
        Mon, 24 Jun 2024 13:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719259538; x=1719864338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nwgTn6bXgujACIEx1Xs09av+Z52LVqFmWoBJ01Ymr7k=;
        b=D2NqJVsVv50W7qI+UAsplE+pkmCPqCyJ9u98FbLqCTpECYoOSynpWlqNGn9/PJCf6e
         7tGbephvpnnaCRPtuislvVL06CFyw0O9otcM2kxJB+TRUUjUjALKoHBVMlEV0BIteMCC
         ULwlNYhJb/ZDJNMT+npd6gvrqVG+ebXY0hoG2v3BTuPXQ/4+I1T6km9G2E8720XfZ75b
         RSsEacQFL0GVNTLCOij2/Yfxxn/4lr2PO45kNJ11fpT94p72DB5cDxgGXm1UR8l+83MC
         KetiEbE7yupO5yx31Jwl2WUtCLCdODWpRnZ2VLvo7LyaUEXABLLgw2qrIMDIXVUjfzRY
         4Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719259538; x=1719864338;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwgTn6bXgujACIEx1Xs09av+Z52LVqFmWoBJ01Ymr7k=;
        b=l5+pUUPCnJYpjCYyw+ESJJhKjiqDKgfraBBNHXVVOk+E2Hn7yvjFg93yfFYHLOcH5M
         vCtcCMIqU+Qv39+SXZYSfME1mZ2wd0J+f64zR7obviytbLONxsX/zhMz8JTTMXnpPcmB
         ZLau9FxA2eGKb6Dbg7QnMWEkPri3ydosisoaQNJ7JW0L8ru7LQXobsYIl+V35ozMV/ys
         UoTAJKFnwg0iZ9ABOSLb8FVGHGhasMMJDJ5jQggutO/o08SUJH4YNxH9vM2xxX5lZUJd
         CXXEU0CVUI48yVh3WV7CVxwDb8mORqvoJushRXDum9xoAFuB4N93VE65WABm8GS/mNKE
         mAAg==
X-Forwarded-Encrypted: i=1; AJvYcCUCKat8GeH+3f2jNJvaV8vUaOByN5fx0WnlDC1YpWxDdryI3LGNa5pYf7BDwSmDFhTDYR2ZE67tJ2yoDR1OvUQ1egNM+Oadjn5+PMIBaJCsOxJ0gmV9wORSWMhJPv1c9v3088WWfps=
X-Gm-Message-State: AOJu0YzE9R1h+XC5EdctsoqGXCdj94un8s5+Z9LauBoLsbtaWGKJehA6
	ymh7I6RQASP0iG/1IVhOFLz1ogAmN9nYKwZksbaUKEEaXnXdjpka
X-Google-Smtp-Source: AGHT+IG52lMviWOfBi/8g86U82c+TCR1BOMXXE2Kh4QFdVG20V50dp/PEbET3hpdDIwaxmTzCqOk7g==
X-Received: by 2002:a17:90b:1b0a:b0:2c8:85c:750b with SMTP id 98e67ed59e1d1-2c86146c84fmr4726058a91.34.1719259538050;
        Mon, 24 Jun 2024 13:05:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e649f5b7sm9114446a91.47.2024.06.24.13.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 13:05:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <11e054b6-a116-417b-9112-f32a8bc6b121@roeck-us.net>
Date: Mon, 24 Jun 2024 13:05:35 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: iio: Add labels from IIO channels
To: Sean Anderson <sean.anderson@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
References: <20240624174601.1527244-1-sean.anderson@linux.dev>
 <20240624174601.1527244-3-sean.anderson@linux.dev>
 <ff43e01e-5a26-4b75-bfaa-ed3ad4395e7c@roeck-us.net>
 <63046df2-e1fb-442b-a55f-2a9847c6c59e@linux.dev>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <63046df2-e1fb-442b-a55f-2a9847c6c59e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/24 12:34, Sean Anderson wrote:
> On 6/24/24 14:47, Guenter Roeck wrote:
>> On 6/24/24 10:46, Sean Anderson wrote:
>>> Add labels from IIO channels to our channels. This allows userspace to
>>> display more meaningful names instead of "in0" or "temp5".
>>>
>>> Although lm-sensors gracefully handles errors when reading channel
>>> labels, the ABI says the label attribute
>>>
>>>> Should only be created if the driver has hints about what this voltage
>>>> channel is being used for, and user-space doesn't.
>>>
>>> Therefore, we test to see if the channel has a label before
>>> creating the attribute.
>>>
>>
>> FWIW, complaining about an ABI really does not belong into a commit
>> message. Maybe you and lm-sensors don't care about error returns when
>> reading a label, but there are other userspace applications which may
>> expect drivers to follow the ABI. Last time I checked, the basic rule
>> was still "Don't break userspace", and that doesn't mean "it's ok to
>> violate / break an ABI as long as no one notices".
> 
> This isn't complaining about the ABI, just documenting the reason it was
> done this way...
> 

That a patch is implemented to follow its ABI is not worth mentioning
in the commit message. You _do_ mention it, and added "Although lm-sensors
gracefully ... ". So, from my perspective it is complaining about the ABI,
unless you think that pretty much all patches should include "this is done
to comply with the ABI, even though <some userspace application> is fine
with violating it".

Never mind though, I gave it my Acked-by:, and consider the issue closed.

Guenter


