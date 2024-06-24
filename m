Return-Path: <linux-iio+bounces-6860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 052CB915A36
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 01:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379B41C22585
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 23:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139BC1A2554;
	Mon, 24 Jun 2024 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XU46BrQQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FC74AECE
	for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719270208; cv=none; b=tZ+JrMd0RGVRlaKEjYGV+6STB86G5bhaWr6Tpm+ZglkdXG195KhCB8RP/axAliG/6a6V2TpsCoP7Udv/DSavCQXaamTJbv+ON1P0oFYmd3FJGn6cb4CmfSXhyj+JR6JsuUBidCl6PWeU/TOAj5lMA9sd5eoy+DYH/XoPSyUfsyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719270208; c=relaxed/simple;
	bh=dz/wiSha4je1wgyieF7YqjeDuJshflL0zybmjQ/WhXQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bvntlZhIb1WOEdcwH2rV+yL5WLfdwkAtEEWPFnFbfZavbIh+kR6qiRe9RyhqfueUF7+gGMmAQRQlKUD6Lb8PARmsB1ZH7oiMuwlOqDF0AC6SQRz8nBGc9QDAnYpObfWjOOOAbKTmCALOxftcZDtztaZNrWpk7M5p3w27P0pWmgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XU46BrQQ; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25ca30072eeso2577072fac.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 16:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719270206; x=1719875006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3g9D0Q46hO8kNhPpdEwaUtcHtAz8RcXtaZXccgR5jlY=;
        b=XU46BrQQN3kH2iQ6WdwWjcqi2VbOuoS/+Au5f24R3NmXPs6RUyIidxXehAKCsPr3vw
         R5hVkqpTW5WfdVM+3Za8WLO9M6ZBno577T5XPIX6TQkEwLYXISAGazDlovToWvByS/0D
         5sbvuuB5rUPZ4lx3LSJ7d1CxTBu2YVwLr/TsC8ZVPZQvJ0+pr9lf4ohX+QU3e4WALveM
         Is91N2uWL0Crti8ioMr0Pt4a/nTNivlznad8HOQvN5AbCvXdkHH5TG1QLmN/ZmAsHMI3
         U/XFmFUykA5UZM4NCrlIQMT9Zy0AjGY3XyVX3/Ih1W8IalTEhwMAKrBAIK0HKn3hdVDF
         ucaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719270206; x=1719875006;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3g9D0Q46hO8kNhPpdEwaUtcHtAz8RcXtaZXccgR5jlY=;
        b=qENbX+d88RWkx0X1/DaziXedjCcf4HBGJSfAv14BTJQztTb5u3YD+Wk1a6ao/X7+aY
         q+Qg1FA966B6PmR+ThetVsiYccM14Wv8jBvvs8QeJTDLkEdvi1dNMpYVSCgzuRTgK0Ow
         KB5rGKyX7RQ7CBs2S0DgfXTEc5aowe3999bruzt0yC4e3ucquI8RFScUnVFIS2DvxD3J
         OAEx/1QoezDcgkjuToyPTp1Ae3B/nqHGy0E80JkWIe79W7K6GiiT9AZjBJe11a1h97MI
         6K0yh1EQJQZM37vxN0MdHwn3+2rgPWZPbjmtwxDujbsbSV2SwugR25D46MaGNreoLVZt
         GyCA==
X-Forwarded-Encrypted: i=1; AJvYcCU6+B11kMyMo3LT366xfxJkeOaPNHMnCRlK3IvfMUOKaKTUx0GqtUbGlktsQezMUjgnL1+5LFUvkHTI0Cgf+qPsDPOKMnTjFwaB
X-Gm-Message-State: AOJu0Yye3JTPWeUkNyKBjbl0GPwyh8EaKmjJWN8Lz9tIj2KP/2nBAzSs
	bxdjaNyuPFOfYmU9+Pr3VIUc9zU/httu455/WKvB29i5MUXlzdV4ars00Bofnnk=
X-Google-Smtp-Source: AGHT+IFxVezURAd/5Q5yZQXgYOOeSHSb+PVhkQILWZlE/kdMWFKaJiNd06/ecIGHDTH4uAzjPurqBA==
X-Received: by 2002:a05:6870:b4aa:b0:25c:be1e:4cef with SMTP id 586e51a60fabf-25d016dc295mr7325113fac.32.1719270205819;
        Mon, 24 Jun 2024 16:03:25 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd4c040f0sm2137355fac.50.2024.06.24.16.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 16:03:25 -0700 (PDT)
Message-ID: <f169633d-5f53-4879-a151-f2cbcfb5efe2@baylibre.com>
Date: Mon, 24 Jun 2024 18:03:24 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: frequency: add amlogic clock measure support
From: David Lechner <dlechner@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20240624173105.909554-1-jbrunet@baylibre.com>
 <20240624173105.909554-3-jbrunet@baylibre.com>
 <04254d15-2f6e-435d-ba4c-8e2e87766b9b@baylibre.com>
Content-Language: en-US
In-Reply-To: <04254d15-2f6e-435d-ba4c-8e2e87766b9b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/24 5:51 PM, David Lechner wrote:
> On 6/24/24 12:31 PM, Jerome Brunet wrote:
>> Add support for the HW found in most Amlogic SoC dedicated to measure
>> system clocks.
>>
> 
> 
> 
>> +static int cmsr_read_raw(struct iio_dev *indio_dev,
>> +			 struct iio_chan_spec const *chan,
>> +			 int *val, int *val2, long mask)
>> +{
>> +	struct amlogic_cmsr *cm = iio_priv(indio_dev);
>> +
>> +	guard(mutex)(&cm->lock);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		*val = cmsr_measure_unlocked(cm, chan->channel);
> 
> Is this actually returning an alternating voltage magnitutde?
> Most frequency drivers don't have a raw value, only frequency.
> 
>> +		if (*val < 0)
>> +			return *val;
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_PROCESSED: /* Result in Hz */
> 
> Shouldn't this be IIO_CHAN_INFO_FREQUENCY?
> 
> Processed is just (raw + offset) * scale which would be a voltage
> in this case since the channel type is IIO_ALTVOLTAGE.
> 
>> +		*val = cmsr_measure_processed_unlocked(cm, chan->channel, val2);
>> +		if (*val < 0)
>> +			return *val;
>> +		return IIO_VAL_INT_64;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
> 
> What is this attribute being used for?
> 
> (clearly not used to convert the raw value to millivolts :-) )
> 
> Maybe IIO_CHAN_INFO_INT_TIME is the right one for this? Although
> so far, that has only been used with light sensors.

Probably not the right idea though since it applies to the frequency
measurement, not the voltage measurement.

> 
>> +		*val2 = cmsr_get_time_unlocked(cm);
>> +		*val = 1000000;
>> +		return IIO_VAL_FRACTIONAL;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +


