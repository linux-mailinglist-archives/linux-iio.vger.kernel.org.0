Return-Path: <linux-iio+bounces-27098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F064ACBF425
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 18:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FB2C3006A8A
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9AA30FC22;
	Mon, 15 Dec 2025 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4aE9rhB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80BE15E97
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765820348; cv=none; b=BTMbi55yazmlBZiLAl+2/4FUdMoLfNyLbg9fh5R9u2SnKd6vKRvw7ZSVtDWApOna6+j81Qgq3hjRUKN7DFVMoPfvqkvpGPmGQPU1ClCUH+48+PB+eXslxpkwViZ2XykshhNdwkRPGcc4jdbXJmbab1LbM9SqQq8PZ/JUSysUaW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765820348; c=relaxed/simple;
	bh=psA0R8uGmpGOA2fhUCx8jrhNdynv6YxOoiERa8JAm0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7vADCGmXBqcM+GD7Hox/yi0JNZnBmOgCjv2hZUoNfX9H3S/NgEXawPXRO2nB3SN7pGlCDbNrMsuGOhc3l+GLQprtVX2iI4/QpJ87C8PbFpbV7AyCDMpiWcaKDkiaQRp99lt6F4Vg+hf6ZLXCPP+0KSwXucwzIHJZdd76rEivdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4aE9rhB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0bb2f093aso18252005ad.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 09:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765820346; x=1766425146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4h6/dnocvbSI7wy9WOBKXhAE/Pd1GTroBa3YOvaI4E=;
        b=W4aE9rhBtPanpxXLQdmxHy+8eHxo+o73fkJCn5h0QY1h2QF6Bhqj+ftuI3Ht68FC2c
         +Yl+aqRWDoQGaBgJKbqGKbEDNIeK7rT8ipZlittt05DBf1/pzrTH4bv1L1tyqliny+Ri
         DsollwYUoGd6eAAgXJS/t7SPg033SW9Rvt46oAPvGWoe5vpPiDtcroeCjb/9lsSeExcb
         QzTpo18xz1I74FZxsrMsPcNg9PAsORn6iqw074xX/FytYJohM1LDKD52EJcAEr/K/th4
         LjbiozT3BNp5lrfWwowXN49VACCJP8I2JJ+/ntL7wr3EfgO6oXG88EM9gTCCn5xyUFqs
         zgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765820346; x=1766425146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4h6/dnocvbSI7wy9WOBKXhAE/Pd1GTroBa3YOvaI4E=;
        b=mOFuHiS4b5xDB8HehMq6PdEt6CGO0QVSzrfMYR8vtg8CbDqL2QuXWBn9U5XKrlsa7m
         Vi28hIepHJ64d4jLsLa5eSMrS0wWTuuIcbGwdsUyQRhjesLoDANwQoTUDA6u3GmhW44L
         orrzdTIuw7RkWSh0L9dppit+Zt3COHahIl8FLmF5XVzHq/tjrrDiXbQasf31Cmss5aM9
         uLQYPBj5Hch93pWQPAdksfTTWNKqa551UllGpuawd672hSqNNscfsqT1WSQck4XVACyi
         jbURb+QEUEiMp6FRn+lbKLX8IP+3TNbmJqQZWAArd6HK2NmzT2E/kkm3q4MFYSLD/KMZ
         WZtw==
X-Forwarded-Encrypted: i=1; AJvYcCXUgejSffySQaGesUrvoO+5qzrsd4Q+GIN/NNk3Xdwihl2U2n7tiREtAMqhcOkkJ/+c0jLjQqdvsh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/PDg5liK04AbZTXwz4Jr/o574nppVuyO72QAYP0xSgr6aMrt+
	/URBN8mHDBpCAQKo457SzaOg10NnRMA7xGajeknG8mBmAINXWb1n6g45f+wT5gVq
X-Gm-Gg: AY/fxX52KDLQnnY9/czXrbuRSSEv7rQBfMq6ULalfevyG16C1QV6kHxl/gzxwZOtHn6
	ctVk89oAlbeELHW6csVuhHsqA8BkW2gfEmQhLhMuZTtVypt5EX7TEsDVywZaXSWAL+Ej5/gXxjz
	KvaltAtsxLlxMrxz9o7uwAsbE7BrecN5wzjdTpdIlMlc5vUfggozrFRbomjrfvTkBX78DsB1puQ
	7miDS0tmCa2Ce3b/v56liRjsygYL1MsztgXZgLCcKMYAMgzHSIXSkJdWky8cqsNdB/aILtXtvSQ
	fPzHQAm6bgSwnfsuUERwsb4Pv4LpEMCWYNgHZptsTvKnfdXf5IjF0dA4I0JUTSRO1y/zsKpgB6v
	yUqCvIlUC0WOTgccGKB2HDKsHeNlbJev+UQt9x3cPYtGSZLECym7vqJphnGBQDKAGAioIzhY/HR
	/GvxL3KALpX748k36SWRkSY44duaVnZrdTzBzo9bIlq+rIzeOM2+GdzUYNZFrVHhw=
X-Google-Smtp-Source: AGHT+IE46iX/+UepoP75ugQxR9RVc4LZtluzmX+M6lYVRNxOVnAo/xUyAvLUfTOY+OUvXeZbNmPVLw==
X-Received: by 2002:a17:902:d488:b0:2a0:d149:5d0f with SMTP id d9443c01a7336-2a0d1495d3emr54427205ad.17.1765820345955;
        Mon, 15 Dec 2025 09:39:05 -0800 (PST)
Received: from ?IPV6:2402:e280:21d3:2:50bc:8636:2ee8:5158? ([2402:e280:21d3:2:50bc:8636:2ee8:5158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0be984c7csm55202695ad.66.2025.12.15.09.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 09:39:05 -0800 (PST)
Message-ID: <bf220707-cca1-4a11-a194-04e131544d54@gmail.com>
Date: Mon, 15 Dec 2025 23:08:58 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: Add support for TI ADS1120
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251109141119.561756-1-ajithanandhan0406@gmail.com>
 <20251109141119.561756-3-ajithanandhan0406@gmail.com>
 <5f15284b-159b-4860-b58b-35c624e2539f@baylibre.com>
 <8e2c73ca-3746-4b2a-9d85-c12b51a69059@gmail.com>
 <8ad18de5-53cd-49ba-8e84-1e8c7e5bd627@baylibre.com>
 <15106906-3bcc-4187-87d9-c838fe99b583@gmail.com>
 <CAHp75VcA2SNGb6cpHaOQwQ_dNaG5xCZnfrXtu+u9pB1+oz7xew@mail.gmail.com>
Content-Language: en-US
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
In-Reply-To: <CAHp75VcA2SNGb6cpHaOQwQ_dNaG5xCZnfrXtu+u9pB1+oz7xew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/15/25 10:30 PM, Andy Shevchenko wrote:
>> Thanks for the pointer.
>>
>> I did look at reg_shift, but it doesn’t fit this device. With .reg_shift
>> = 2, regmap would send only (reg << 2) (e.g. 0x0c for reg 3).
>>
>> The ADS1120 requires the command byte to be CMD | (reg << 2) (e.g. 0x20
>> | 0x0c = 0x2c for an RREG of reg 3).
>>
>> Similarly,
>>
>>    .read_flag_mask would produce reg | mask (e.g. 0x03 | 0x20 = 0x23),
>> which is also not the required format.
>>
>> Unless I’m missing a regmap configuration that can generate (reg << 2) |
>> CMD as a single byte,
>>
>> a custom regmap bus seems necessary here. Please let me know if there is
>> a way to express this with standard regmap-spi.
> So, and if you define both?

Hi Andy,

You're right! Using both reg_shift and the flag masks produces the 
correct format
Thank you for catching this! I will drop the custom regmap wrapper.

BR,

Ajith.

>
>
>


