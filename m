Return-Path: <linux-iio+bounces-14024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AB0A06301
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 18:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBECD3A7CAA
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 17:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BD81FFC7B;
	Wed,  8 Jan 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WsJnBZQF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890A61FFC6C
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355975; cv=none; b=RxeMaYyoMG/iQT0VE98SBc6EFZEzQS5jTEmdag9T63bd6T1hEhYCCegIDxcRTa9AsBhWFXfM8kV8Es4BM71DhF+pmkFscKRhcl5+i8erPE7rbaAB9NDKbAs4R5gc+qiWHRsbhN4CANh+sorXGHeBvbCdkUY5OxC9xPW5DfzBm5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355975; c=relaxed/simple;
	bh=jCamsfLpcBDv0KT7qF02it6Id78FDWwVeoi+mD41IZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=um5BdAZWvln9W8XluO2/PEYCss3t39fDmW6jq6y/mye3rME/+BB6z3Ntbwcy680FKgv6a1TEsJpOcjUTrBqCroRgq3a3AuhxhbZct3RreOzlKd4Bv3I19WmgqN2K6f+1YoHLhXlvbwWj1fhFkabZcTKKE5FikNky+ZWQpzW8b2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WsJnBZQF; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eb6b16f1a0so4881393b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 09:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736355972; x=1736960772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/b4Xzx1xkuwA/wx5BhKWtA/mjZMQ0mArLR9j53cJLo=;
        b=WsJnBZQFZnH1CSsoN9fIHXN5k800U4yja6SiLWiBRwNgBxjwMCzcYinOUwsyMxE0fr
         lElSqVqS2KOC35bk8BJJrhi9DnFlBOkTkeS/p192FqfJHFoUEglhpXs2amTo+mW4V7g1
         r/dK89OLsP4oQAElb554Z23uNObr/VrzEzH7wibOWGlxRSHgfnCD9eHAig1eNkB6lIhk
         kVJSDvGgGYQDd6TMS5G6vQkaI01p3quOqigX7hwh75/H+TkBlFwHUBo8MOo7dmmzb/aa
         J+PpYlzIDbFv0L8H8iWZKFrqm1P8z/WwsnU0MDE6f1RwIDRJzpZhnAzLJtJ1D3m3kx+j
         SkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736355972; x=1736960772;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/b4Xzx1xkuwA/wx5BhKWtA/mjZMQ0mArLR9j53cJLo=;
        b=ZX0z5IGfUt0P9c2pZu8wZWnK7O6eCY+n64azkK10UjjNTJIhSsI+VevstcLTysCobq
         3lUK066gi27SdmLVdE/wYkYbwu6tJoRcwyAzxLDqwkzJMVw9ZP/ymyHq6M2jERm3bjNr
         8XsHV2/Y4Q64sVCTIgEy2N9oCsITc7MLg4t/FlhzVrFp2AVB9i9UsLPo+Ub4LehPuiUk
         Oepw6fX/M8YMb7W0jKFmC0h1FIU3nZNckQ5SKkmWfqd2EeFJhA7wS4MNjJxOA+duBMgz
         sOn18eJtC/2uyB8bPZlC0vTYYWdmVsp09lEcCPMKSST9wMLnqZjAZSef/eI6twNGv3aD
         YaEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlPhfEDg3jivyi4EwPKHvj0BSz63Ccn9lNWJkNqL6AUepYi46uAwcgJH3te2dUFfIEnfC+zOVFPZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv9bf4hEHQYQ6UG/PRKpDQm+ukjiQTPQDOMiwzyTEj8/Ca5xDk
	4civYXESZuZiGCad1wqb1RhwQJD1MuuoHysqASDkoHy5QQgJillv8nukFiIUx5E=
X-Gm-Gg: ASbGncvxxgmr9TmlHw2enitDHqkpooEfxcObZT+iVkZdTh48At2JtNL4au476irAp21
	F1IsdKVhufauDw3dFlFuHACF//GUUofFtWOcTEpqI9c81t4k0IWFP3vA7IdFvUCmRsKDpuicNrm
	l4ozGtBGpDfKIzaGPVgrjUlnjEFlHoTFjuFNr0Tcjn9GIekPo/02++FMhXXBecvWEd7fKGuhsMC
	1VarW5NtqluaOfuWZUm8T6AE7dvnyrnvnZ/JeLDt1nmir5GzThx44OIQ6HwfF769bwlWZRGq/at
	2i2RL2ucLesPLE09tA==
X-Google-Smtp-Source: AGHT+IEWotvyiUKl/k0KXLMw0knOeNaJYVLSpncNojbcFb3g/TMcabu1SuBV0WZUGqsskizMdV4GPA==
X-Received: by 2002:a05:6808:913:b0:3eb:5d13:f688 with SMTP id 5614622812f47-3ef2edd34d7mr1881257b6e.26.1736355972541;
        Wed, 08 Jan 2025 09:06:12 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ece244e86asm11434861b6e.5.2025.01.08.09.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 09:06:11 -0800 (PST)
Message-ID: <b650f023-19f6-4f84-ae07-4383376268e6@baylibre.com>
Date: Wed, 8 Jan 2025 11:06:09 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 8/8] iio: adc: ad4851: add ad485x driver
To: Jonathan Cameron <jic23@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241220120134.42760-1-antoniu.miclaus@analog.com>
 <20241220120134.42760-8-antoniu.miclaus@analog.com>
 <20241223120005.1bc9a208@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20241223120005.1bc9a208@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/24 6:00 AM, Jonathan Cameron wrote:
> On Fri, 20 Dec 2024 14:01:34 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> 

...

>> +	ret = devm_regulator_get_enable_optional(dev, "vddh");
>> +	if (ret < 0 && ret != -ENODEV)
>> +		return dev_err_probe(dev, ret, "failed to enable vddh voltage\n");
>> +
>> +	ret = devm_regulator_get_enable_optional(dev, "vddl");
>> +	if (ret < 0 && ret != -ENODEV)
>> +		return dev_err_probe(dev, ret, "failed to enable vddl voltage\n");
>> +
>> +	ret = devm_regulator_get_enable_optional(dev, "vrefbuf");
>> +	if (ret < 0 && ret != -ENODEV)
>> +		return dev_err_probe(dev, ret, "failed to enable vrefbuf voltage\n");
>> +
>> +	if (ret > 0)
> 
> I'm fairly sure that call never returns a positive.  Will return 0 for success so I think this
> should be if (ret == 0)

Even better, make it 1 line instead of 4 and use the specific error code we are
checking for:

		st->vrefbuf_en = ret != -ENODEV;
> 
>> +		st->vrefbuf_en = true;
>> +	else
>> +		st->vrefbuf_en = false;
>> +
>> +	ret = devm_regulator_get_enable_optional(dev, "vrefio");
>> +	if (ret < 0 && ret != -ENODEV)
>> +		return dev_err_probe(dev, ret, "failed to enable vrefio voltage\n");
>> +
>> +	if (ret > 0)
> 
> Same here.
  ^
> 
>> +		st->vrefio_en = true;
>> +	else
>> +		st->vrefio_en = false;
>> +
> ...
> 
>> +}
> 


