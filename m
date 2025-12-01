Return-Path: <linux-iio+bounces-26598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F79C982E8
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 17:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86473A2B05
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733AC33373A;
	Mon,  1 Dec 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ejKZL7nD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323AF333748
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764605263; cv=none; b=cFYThiATYeDJS91fDqWeKfJN5JLeqUHXlZj3T7HG34har2bkfwLbpzZ+2VUQEV4+uyBOCip+0B23YQVE27mHB26WG2pP5X9YJT/M0kwyj9XS9SnGqT6+Ola0AjnJzWb6ntXkavCrt/d/PlcnX32Nr/7d2iMwR9N4PK44/X1KeVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764605263; c=relaxed/simple;
	bh=4KqoW2kY6Y0iDicS4AkddU/tL9W9u5yhRKwbjPy3c8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2pemy2qxYHeiZauTwQS4OMA3ZYAmpd4Mu3F9VfHx2PQk2LlM5vMnllPLGxoafQ2rroytRhA856LbcVOfeupqWbYy1TVIG8CXhfGjJW/nNnCVbtnLWpW/YZEtEdp2T/xsMSY+PQgnh5szEzkhaQgX+fDnuQe299nqdVsCSzDW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ejKZL7nD; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c7bfba3996so2280282a34.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 08:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764605260; x=1765210060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDr0GYQPVWIPku3v/vQDg4xQ67n9L+U+dEfsUiT0Xbk=;
        b=ejKZL7nDsubd1BrcmsKgOQaVAoebsNbdDRLe9JbXEr7Do9PUTG4Aptg58KErIFJUsm
         eyTqPLNbV259gIXnyPIRXi8KL5Q3bIb4apKcj7A8fW88uCMiKK3f8cwshmA+7RH9THtU
         Mb28vw8+Kxg920iotrc4tul66TzyZ5N/os/JPRczXrn1wb+ghgChrjjVphOMo5bwpK21
         QJp8MJSOXk3aSA6Sk5ljxDCZcdDG5/4HII1zHkeDJntckooNWu9qml7f5BxjL/5Pdm8X
         iMfjyAg4hPL1bp8ELTwiQDaAxaz883swWuWRmGW0e+bN0PzYSLeNYQPa1N617ONpskJT
         49xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764605260; x=1765210060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDr0GYQPVWIPku3v/vQDg4xQ67n9L+U+dEfsUiT0Xbk=;
        b=ScRKOaIeVO12shPvtsY9wvPOMbjET2w+JKUOJShDn7NYWgD9agubLuiAZNQe93eYXY
         HlvMIeofDeEPjl9QGc50N6Iu4K/0CUQweaYq9Fh3yAlflB1bm7Kydo/YNnhqjJW8Qzzw
         SthEgEVZYnxZ5JeFHIPTgwRlvbJzn0+gN518scR3HOzZexmT6BlTqep5wmEcUy5UCU/D
         tGjR+FIgYDwGwFhtDSNWZvsGMgwedvUqLOGlnYXZFW2dMKLCmX3xEwCgGGZad2mXT6AH
         uT5wAqPr1571k3rBEapQdXYkEphqGoVSdIShoMhstBW4/3J3aLrxU+jPa+h9e2HjE8G5
         iPkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf6vec/X71ypWiLIiQAVlInPOyRfzMsC4I/rngtev3rX1PyR1W15cfCfBsK0vo+c4vhcbAlmpMZCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPUvNSj0jLJIx9Gal5X+cWi5mGnSbLAVCuskSMzxOtKbe58qI3
	6dgxM/K0/m8f3YlzxiK8FHoF13LaxhIuDD6sgGcRz++ZL7QMiYfzktl/3xZ01qNSYYw=
X-Gm-Gg: ASbGncuj9MjpUs5L9AX+kJdfa8njwTt6yZ1NbP3tlisK7FDseKRKeJbwZSn7m71cUjZ
	ZjEoJY+T9OfLd1yTc9fdNVHtOrFz6w1VrRmToPM8sYsNNnmXdi0j2KIeDm2l7zRYks+yR0xpDaJ
	T4JqTKSp0kDTUZQuTFxEmvayi7G0hal4J6c1xOcdYcvz13ZzUQK4iZvYRRiLad+QVBQS0kcuO0Z
	i5IgXk6epsrFVPdDgXkgEURDLglymLD2BMrfxUuj6mf+VqVCedyypyj87Ku0pUGqMs+LjzBKKBQ
	NrmmRGs6wrNMRlcEZ4Bwim05B488tGPGN6J5d2irRPbTjp+SoeXD2qCPgb3XcqcZy7p0+LML3jZ
	/k1Dx4uLaRMMvbcpP5/oepkW4e6XGzwhiiGFs4Z7eGEspAhIyeOcs2ymrJfY4rYKG+j/30KK1Fh
	4/5B653PV3Nm3JA5RAAUgbXIJqcFzoyx2qfK71hVtITa5eQFa3mb12nFWahA==
X-Google-Smtp-Source: AGHT+IHpbx0FCT24QrZNWptZAIGWfpVX2b3pIYnPENscCSvHxtedYLd1GigO8m2QJ6Zn/I5u+9WClQ==
X-Received: by 2002:a05:6830:915:b0:7c7:4bd:d527 with SMTP id 46e09a7af769-7c7c4466fa9mr10570580a34.21.1764605259959;
        Mon, 01 Dec 2025 08:07:39 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:b67b:16c:f7ae:4908? ([2600:8803:e7e4:500:b67b:16c:f7ae:4908])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90f5ffad8sm4717328a34.12.2025.12.01.08.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 08:07:39 -0800 (PST)
Message-ID: <18fbf486-c1cc-4cd2-af12-ffa093fa9ce7@baylibre.com>
Date: Mon, 1 Dec 2025 10:07:38 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
To: Kurt Borja <kuurtb@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Tobias Sperling <tobias.sperling@softing.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com>
 <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
 <aSsBdJZDWcadxEHC@smile.fi.intel.com> <DELPNLNPGQSM.1YDTB81AG0RAY@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DELPNLNPGQSM.1YDTB81AG0RAY@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/25 9:31 PM, Kurt Borja wrote:
> On Sat Nov 29, 2025 at 9:21 AM -05, Andy Shevchenko wrote:
> 

...

> 
>>> +static int ads1018_read_unlocked(struct ads1018 *ads1018, __be16 *cnv, bool hold_cs)
>>
>> Hmm... Don't we want to return value in CPU order? I don't know the answer
>> here, and IIRC IIO triggers might be actually good with endianess conversion
>> done, if required, in user space.
> 
> I specified IIO_BE endianness in each channel's .scan_type, so this
> works. However, I don't have issue especifying IIO_CPU and just
> returning CPU order values.
> 

Usually, we want to change the data as little as possible, so leaving
it as IIO_BE is fine.

> ...
> 
>>> + * Context: Expects iio_device_claim_direct() is held.
>>
>> Jonathan et al., do we have lockdep assert available for this?
>> I really prefer to see the code for it, while comment is good,
>> it is not good enough.
> 
> This would be nice.
> 
> ...
> 
>>> +	if (iio_device_claim_buffer_mode(indio_dev))
>>> +		goto out_notify_done;
>>> +
>>> +	if (iio_trigger_using_own(indio_dev)) {
>>> +		disable_irq(ads1018->drdy_irq);
>>> +		ret = ads1018_read_unlocked(ads1018, &scan.conv, true);
>>> +		enable_irq(ads1018->drdy_irq);
>>> +	} else {
>>> +		ret = spi_read(ads1018->spi, ads1018->rx_buf, sizeof(ads1018->rx_buf));
>>> +		scan.conv = ads1018->rx_buf[0];
>>> +	}
>>> +
>>> +	iio_device_release_buffer_mode(indio_dev);
>>> +
>>> +	if (ret)
>>> +		goto out_notify_done;
>>> +
>>> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
>>> +
>>> +out_notify_done:
>>> +	iio_trigger_notify_done(ads1018->indio_trig);
>>
>> Jonathan et al., maybe we need an ACQUIRE() class for this? It will solve
>> the conditional scoped guard case, no?

No, ACQUIRE() is not scoped, just conditional. I don't think it
will improve anything here.

> 
> ...
> 
> If no one prefers to do it, I can submit a patch implementing this. Same
> for the lockdep issue above.
> 

