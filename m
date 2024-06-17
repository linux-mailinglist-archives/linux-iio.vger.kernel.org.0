Return-Path: <linux-iio+bounces-6342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1388390AAD3
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 12:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E7FEB2FB93
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 09:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710511946D7;
	Mon, 17 Jun 2024 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi/pzgcx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312F1946C2;
	Mon, 17 Jun 2024 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616947; cv=none; b=uXPFzTtizB8yjc/QCzVk0fi+Z336EZQBEDqOPBG9lnnLRafwFY0sgaydBiNihq/6FePPIZX5NbEO/QKiKZmmWAGwZYdp8etAXZX/x58CdH6CUOKEMKu+so+AWrUdVwB6qzcy8u3k1RYBFwB1uvSJRaFVqd2p7+7eJCAmNFjMJNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616947; c=relaxed/simple;
	bh=ISTGOrNx+qky+Jf5GkYALSgWEhhMC0r4cnJ4/R8olvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibCCZdIfBmR2Zy+D/6i1QIFY+63YgvcPBu1AdA1PB4tPwsQZeUsjQfNIALyj470NZLBSgeK2lfqVlArebrC2V2+tWRMK1yceazQuVmjAKTZ50VlXlVyP7zWq/dEh7LmpCMqigfQSZHydU9CrpOaBC97AnvqzQ14eOO5LV8ZLz8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oi/pzgcx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4218314a6c7so34768705e9.0;
        Mon, 17 Jun 2024 02:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718616944; x=1719221744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NItPfN2Qb0jONFGc3TV9yNBIU5BBovoAluD8hqM7ItQ=;
        b=Oi/pzgcxhbH+1ZLhhaWr6YN40AuJ5sFQJwk79rQSW+OsFoI77NmYUswqcZwDHIGTxd
         nrKW6hpc/cjfBc+YgouNVefyDvhXaG5NdHxewRFgJkyk/X46V21PibgjV7u69VLMKXTa
         6Qf+9D+GC4pKIs8V4xbQu58y8aP9dMAv4ELGgNPRtEk2If6ASgc0niZnRNCLmL7ILhrs
         KSPxIh9V43tPRnqP9G8BqQ7+G3vaB23Xh3sD3mv1heaT+DxgyjHBIq1ZGQUxRjk308Zt
         T3laH7btUhIpu3mSk+gvmht/5Wy2E5pvvhe/H8sqvDbDL5ooLP2/lzGjA35/CuKsxVXf
         yfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718616944; x=1719221744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NItPfN2Qb0jONFGc3TV9yNBIU5BBovoAluD8hqM7ItQ=;
        b=U5sIuKaXvq0VNnlgX2Ftha+e27oTGwsUoT3JDY88hg21xgid0Wqu2VRQ2UcSGA4TuQ
         nLev9VqhMAGYIeoEdIRGMISpdffu/imhj+E0QijBfNah/fjZCQq93jpDMVlFB61UJHvl
         yP63FvwqGsgf+npFmLgbgI5rTx4IUZC2FXspS1MzbpZyJDECNgePcn9ZYjAPKDVNnVRp
         Nxqir5uHraTVE2b3Dc0oR2e0rvfdO50ZFvnL2j1OP1L/CrA1nI23BrTADx03YABZ5vgS
         wMR8+P8U40Vu+d3ZE8mHi7AN0KdWWATo+QAv0IBFT5UaKebkBQmcy8sm870rCCH4d5Tr
         s3gg==
X-Forwarded-Encrypted: i=1; AJvYcCUDzzklHP1YZn5SjNGQZRgYfY3LxMhGrlpGqT7OCzmwHAqpd3C6p2z2vKJFOvZ6114RZRuB3/N6sc6WMZ5xZlDEyVw4ByYSF40izEDDDO8lku+YuwKQJ6wGDAYYoX8Uw5jw7khWZFGN
X-Gm-Message-State: AOJu0YxaRnPrUKFGsTZh5BLof4KwdCkalhwmhv1OztsvtiZAUH5rfg/Z
	BywWElPU8JRM3O++/uRMoNTMqFow9wo5b/yrPCSI6YJ/q2eIT84k
X-Google-Smtp-Source: AGHT+IHkhFqJsu0zmOOch7REDu686xAm493O5ju1z/aAIv+qBa/8GbjT4Fi1o5mdTMUXXVy7avigzA==
X-Received: by 2002:adf:f7d1:0:b0:360:9625:c571 with SMTP id ffacd0b85a97d-3609625c5f8mr1581491f8f.48.1718616943752;
        Mon, 17 Jun 2024 02:35:43 -0700 (PDT)
Received: from [10.76.84.188] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104b8bsm11521810f8f.105.2024.06.17.02.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 02:35:43 -0700 (PDT)
Message-ID: <dbf947a3-3d3b-4686-a707-a813b6a4ce5a@gmail.com>
Date: Mon, 17 Jun 2024 12:35:42 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] iio: adc: ad7192: use
 devm_regulator_get_enable_read_voltage
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
 <20240612-iio-adc-ref-supply-refactor-v2-1-fa622e7354e9@baylibre.com>
 <20240615130858.22043725@jic23-huawei>
Content-Language: en-US
From: Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <20240615130858.22043725@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.06.2024 15:08, Jonathan Cameron wrote:
> On Wed, 12 Jun 2024 16:03:05 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> This makes use of the new devm_regulator_get_enable_read_voltage()
>> function to reduce boilerplate code.
>>
>> Error messages have changed slightly since there are now fewer places
>> where we print an error. The rest of the logic of selecting which
>> supply to use as the reference voltage remains the same.
>>
>> Also 1000 is replaced by MILLI in a few places for consistency.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> 
> Complicated bit of code, but seems correct.
> However, it crossed with Alisa-Dariana switching adding a
> struct device *dev = &spi->dev to probe() that I picked up earlier
> today.
> 
> I could unwind that but given Alisa-Dariana has a number of
> other patches on this driver in flight, I'd like the two of you
> to work out the best resolution between you.  Maybe easiest option
> is that Alisa-Dariana sends this a first patch of the next
> series I should pick up.
> 
> Thanks,
> 
> Jonathan
I will add this patch to my series and send it shortly.

Kind regards,
Alisa-Dariana Roman.

