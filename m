Return-Path: <linux-iio+bounces-12707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888E39D9DE3
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 20:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4E52828FB
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 19:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE9C1DE4C6;
	Tue, 26 Nov 2024 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FLM5/8Cf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C441DB52D
	for <linux-iio@vger.kernel.org>; Tue, 26 Nov 2024 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732648387; cv=none; b=GL0Bp/I6PqCMkrvMLkjJyN3Rma1dkQySlGKSrc9tDzsjcLXV2Ad2yaO/5HlKXWbZ3jXsaWDHmTuTk307T3IKebJyCvB6+l0sfe5tjPknW06LzJM+hg5uWbiUIKDzkNFG2+tDYLaFAY5SPKU/Bwx5PV3TsdgwT60U39gCeEARQQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732648387; c=relaxed/simple;
	bh=93BTRZse9FM9AQxxaE3QHX9HlG/LTHWLtygtkJIjM+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSlS9kitQJCkH6KVmlv58hEOY64Iz8EcZ9SAg1rridt+pTokECaO80VylgVd2fhQVRlmf66E+zN5rrErTg6Y6yaKMVAYpVE2xlph1WqYdhwjm8PvBjftcICh9ofgLkgMmt/QgMhPajDJqTOY39Cogu7gR8XQoLe9+7AkLjl3Gxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FLM5/8Cf; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-29737adb604so2060758fac.1
        for <linux-iio@vger.kernel.org>; Tue, 26 Nov 2024 11:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732648383; x=1733253183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hxuYSh97+uoLGUQ/ZGA65IHk5iK3MvMU7/ozJSLtfAA=;
        b=FLM5/8CfTrtCc61W6llOpXPPYhr4WpKMxUh1OzdcPB2uUbVswKz6320gdDvwFhUChR
         X6RRLTDNB/SXJRO4f5Z4JdTNs05eW3KvIEfQLk8Pvdi/yYM1PdEAAsHfA6BXTbpUTt+f
         IXBSa0yYzALPtlYVyOTdJR6izuxzwmwCtikZz7BiXcQZ/YMsdBO8aYYOT+EUHYizJvRY
         8+Kf6EbnKJuAPcbbVzGu0RMKubtGvnsPoI4ojyWYFISrsj6UDwGxn1q5YN4Odbkw4BNN
         WBCPo2mNs2OwXpclE7D7TiXBnCQuw9dY8WZMRTLjvzri1Hs0mf09kd1nv6NyTbVqzbLT
         HLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732648383; x=1733253183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxuYSh97+uoLGUQ/ZGA65IHk5iK3MvMU7/ozJSLtfAA=;
        b=EZk6m2KgIK8HC4lwloVp6RG4bGKuaSOXfY/KYP7xvDh6pjGKyF29oKG5dBhKI+/CFC
         kPAVkG9TRHH+g/o821zo2HSNHEDkVXhYSTCZjEDO8JYM3i3R9YVd+Q0pkZnQH/p8DqY3
         asxlrZa/wHrMEOkEwmvoZ1NSSDYfMGvwEH2iqBrMx2M83RHhFOc0o/2N2/LduOtMClnO
         Xh1bIL89xhfkaO2qXSQFtqGAa6meXvtM0nOKeCsab0af8I0BEx+QkMjjOWv0N1gk6358
         PgW65Tqfscp2SlOrbc6138T8/aCVGZjRh+dNX4aTFKZuohm6OHeGTdlavAy1nScM6Za7
         nZnw==
X-Forwarded-Encrypted: i=1; AJvYcCWmAcZTTxTkOmiju6kYEhxmYku+pr1T6OJ9mAZZwFdMp7OIt1Y/olyOek/18gNFxUl7L/QoJH4Be1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt5hlBQlqsBFwefWSStcA0kvl0aPPZzZA4aLq3DzNnE+W58WFG
	uv9sR+ajlL646bvrRqndpJBw9bWsThmxkKVKOAESb1xzTxjDZE5zCzYg8z/cCS4=
X-Gm-Gg: ASbGncvlPXFOLcZeJywmr5T4XHMKv7+Az/zplEBXr8b349oE6Su1+j8vMwzF5P9txeO
	QcleGZIMvf2l8EVsrH5pGgHZGFATJ2L/U3jUUybYw12tuqNn9kb/imJnQS1DBifHIvYeKZsOXme
	I+rcN8KBpIvFBlz+2d3WJSUmEvR7LxXx6LKuV2Non+t86l+oJ/MmJ2rFywOp5En4UvoMHGrFVok
	CrHC203Dxh0U7hShExxBy5SBF2RqXJTi9zbRXsaERQlV9Dl5n+LMcINC40Y9tSRs7jnJSne934c
	kXZ0d6s0dYM=
X-Google-Smtp-Source: AGHT+IGvvs/3m9Kc79fYwVlDePn9MhTkwzH3DrsnbvsG44IRsBGPsXgVJ52HGlQjA8LWs57NwhZ5HQ==
X-Received: by 2002:a05:6870:1691:b0:296:de84:3ea with SMTP id 586e51a60fabf-29dc4308234mr121728fac.34.1732648383542;
        Tue, 26 Nov 2024 11:13:03 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2972288053bsm4061320fac.3.2024.11.26.11.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 11:13:02 -0800 (PST)
Message-ID: <69352c32-56fb-4bfe-aead-4126e144a1e6@baylibre.com>
Date: Tue, 26 Nov 2024 13:13:00 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] iio: adc: ad7606: Add support for writing registers
 when using backend
To: Jonathan Cameron <jic23@kernel.org>, Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, jstephan@baylibre.com, aardelean@baylibre.com,
 adureghello@baylibre.com
References: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
 <20241121-ad7606_add_iio_backend_software_mode-v1-9-8a693a5e3fa9@baylibre.com>
 <20241126184851.5d28793e@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241126184851.5d28793e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/24 12:48 PM, Jonathan Cameron wrote:
> On Thu, 21 Nov 2024 10:18:31 +0000
> Guillaume Stols <gstols@baylibre.com> wrote:
> 
>> Adds the logic for effectively enabling the software mode for the
>> iio-backend, i.e enabling the software mode channel configuration and
>> implementing the register writing functions.
>>
>> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> 
> A few comments inline, but basically looks fine to me.
> 
> Thanks,
> 
> Jonathan
> 
>> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
>> index a25182a3daa7..0c1177f436f3 100644
>> --- a/drivers/iio/adc/ad7606_par.c
>> +++ b/drivers/iio/adc/ad7606_par.c
> 
>>  static int ad7606_bi_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *scan_mask)
>>  {
>>  	struct ad7606_state *st = iio_priv(indio_dev);
>> @@ -70,7 +83,7 @@ static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio
>>  	if (ret)
>>  		return ret;
>>  
>> -	ret = devm_iio_backend_enable(dev, st->back);
>> +	ret = devm_iio_backend_enable(st->dev, st->back);
> 
> Is that a different dev? That's not obvious...
> 
>>  	if (ret)
>>  		return ret;
>>  
>> @@ -86,9 +99,52 @@ static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio
>>  	return 0;
>>  }
>>  
>> +static int ad7606_bi_reg_read(struct iio_dev *indio_dev, unsigned int addr)
>> +{
>> +	struct ad7606_state *st = iio_priv(indio_dev);
>> +	int val, ret;
>> +	struct ad7606_platform_data *pdata =  st->dev->platform_data;
>> +
>> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
>> +		ret = pdata->bus_reg_read(st->back,
>> +					addr,
>> +					&val);
> 
> As below.
> 
>> +	}
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return val;
>> +}
>> +
>> +static int ad7606_bi_reg_write(struct iio_dev *indio_dev,
>> +			       unsigned int addr,
>> +			       unsigned int val)
>> +{
>> +	struct ad7606_state *st = iio_priv(indio_dev);
>> +	struct ad7606_platform_data *pdata =  st->dev->platform_data;
>> +	int ret;
>> +
>> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> 
> Given David's if_not_cond_guard() should land shortly I'd prefer
> to use that going forwards for cases like this.

Well, Torvalds wasn't happy with the patch and suggested we should
give up on trying to do conditional guards altogether in cleanup.h.

[1]: https://lore.kernel.org/all/CAHk-=whn07tnDosPfn+UcAtWHBcLg=KqA16SHVv0GV4t8P1fHw@mail.gmail.com/

So I'm tempted to just revert the if_not_cond_guard() patch rather
than trying to fix it.

> 
>> +	ret = pdata->bus_reg_write(st->back,
>> +					addr,
>> +					val);
> Put parameters all on one line.
> + return here (which needs the new if_not_cond_guard() to avoid
> confusing the compiler).
> 
>> +	}
>> +	return ret;
>> +}


