Return-Path: <linux-iio+bounces-6859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C80C1915A1A
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 00:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842E928385D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 22:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88291A2541;
	Mon, 24 Jun 2024 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qCm3Tj3B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760C047A64
	for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269469; cv=none; b=IAljTryG+nOFjrNMVIKPW7WltGdDJ3INiMyZk/fd8NJ5IZQ5ZFJqlNQ+3H+4ygsn9j9qgoMzV3iYPxmOZs+LooBT6NUFcqREQlswQUsc9NDwibhh8Hbd3SNu7PLVoMXu4jcdMMCWJhRe9qYO+ZMbOicB3VZ8IYmrXJlJngp8gQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269469; c=relaxed/simple;
	bh=zvWzgsTq3P+0Mdgzi+iZmuD6UIRKkocR4ALPpJOB8bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RU/K0vEfRCBpeRDB12hmxignXPfcxqT+XdFFUnZi8R+6oZfsZy+9Dgc13hY5KJMUQw8oHIWb3xn9D1EkUbkMhcMdcsF/uHWWVbr1EgCsCeMP6e9troHEhnfW5K/lmhmVoOI/aqtRSiK+mbvvHgF7aAjEbOsTsIt0QWy0UcNtjoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qCm3Tj3B; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c9b94951cfso2806228b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 15:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719269466; x=1719874266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSMLalLoG8lPuYSLVxw52g/GhJCfhMgtmpMfHHuN7E4=;
        b=qCm3Tj3BaQIsddSWC3pXyU8Akk3VoFis0Dt57fO97uAr9v9bcu06zCUy1lASRdQwP0
         EOJBSmRqa97goiGW9My2U++ZWS2lewJJQHASbFAHWTE71Tji2BdIWLFLt3GFPtj5D/zs
         Y26olSMUbt/kRU3sJeQmaUVUCELNxqFyzxXYkfy/4BExck78tad40fIvQgCrKnpUVl0K
         uicrHYNVKxPTgkk60+lk+/wtqBtS/QR/tS9FHh8csGRkb2tMTINIK2nCFleDF3ZVQrUp
         E07iKB3KYSKMxwwAxKTd636Ligk+QYSawKjqOuKt7KFxt5CZZoJ21bx0g7nJYBbD68Lg
         9acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719269466; x=1719874266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSMLalLoG8lPuYSLVxw52g/GhJCfhMgtmpMfHHuN7E4=;
        b=WkFlnsGtoBHobsyy+S8Hq8s6PdVZ8snUS5wYjkF70Pqvrg+ohYCFv7y92VOoOqUyk2
         mU3DuI+Ox0YaW/UUbpi2q0esnU43v6/8bBO03hMAgZAenyIxxU52WSEw1itlGdCdgXT0
         owkGZVy6TPcy3uGwBWjTt+uBnCTGqIAWwWNb1V4m0At4IL+jKH1tPZma7Fh6V4VZUvwQ
         8RNyK8bLcpcIg1DNI0xu7o2Cd6RzQ7t61JQPhTt8BZZ8+84/AQmzY7BJlc6zZ44GziC5
         Dehh3GkU0fr92rP7esipjsas4YsmVqmLzogZGP277dDrNjFuI4iVgp04D49HMrvq8Fmi
         Tbmg==
X-Forwarded-Encrypted: i=1; AJvYcCVmg8QtnV13QD/cJfMeJkiaYkSlUpw17aDwlNgNG+pEymOHYRzB5wrUgRw0Xdsi16syhVv3tMqas6iZCbHvksdHpHz5hBeep/yI
X-Gm-Message-State: AOJu0YxQ1SU+kUSit56J6bV6tOD300wnFZoamaJq8bLXNjwLkgXASB/N
	aYXGFz1CYzOyGeSuZ5JsjPFPrCa548dMxRU0mhqyJCIMM+yE7KRpcnD4uSm75h8=
X-Google-Smtp-Source: AGHT+IFEgKMQ0KzJb3GzFBxAKLmZWqCWQSiAPzPkM5FnZP8YbirfIfWJTrgLNLNXsuor9teoG1ivgQ==
X-Received: by 2002:a05:6808:189c:b0:3d2:2780:1c8f with SMTP id 5614622812f47-3d54594f36fmr6962253b6e.4.1719269466564;
        Mon, 24 Jun 2024 15:51:06 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d5344dde49sm1672731b6e.1.2024.06.24.15.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 15:51:06 -0700 (PDT)
Message-ID: <04254d15-2f6e-435d-ba4c-8e2e87766b9b@baylibre.com>
Date: Mon, 24 Jun 2024 17:51:05 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: frequency: add amlogic clock measure support
To: Jerome Brunet <jbrunet@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20240624173105.909554-1-jbrunet@baylibre.com>
 <20240624173105.909554-3-jbrunet@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240624173105.909554-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/24 12:31 PM, Jerome Brunet wrote:
> Add support for the HW found in most Amlogic SoC dedicated to measure
> system clocks.
> 



> +static int cmsr_read_raw(struct iio_dev *indio_dev,
> +			 struct iio_chan_spec const *chan,
> +			 int *val, int *val2, long mask)
> +{
> +	struct amlogic_cmsr *cm = iio_priv(indio_dev);
> +
> +	guard(mutex)(&cm->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*val = cmsr_measure_unlocked(cm, chan->channel);

Is this actually returning an alternating voltage magnitutde?
Most frequency drivers don't have a raw value, only frequency.

> +		if (*val < 0)
> +			return *val;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_PROCESSED: /* Result in Hz */

Shouldn't this be IIO_CHAN_INFO_FREQUENCY?

Processed is just (raw + offset) * scale which would be a voltage
in this case since the channel type is IIO_ALTVOLTAGE.

> +		*val = cmsr_measure_processed_unlocked(cm, chan->channel, val2);
> +		if (*val < 0)
> +			return *val;
> +		return IIO_VAL_INT_64;
> +
> +	case IIO_CHAN_INFO_SCALE:

What is this attribute being used for?

(clearly not used to convert the raw value to millivolts :-) )

Maybe IIO_CHAN_INFO_INT_TIME is the right one for this? Although
so far, that has only been used with light sensors.

> +		*val2 = cmsr_get_time_unlocked(cm);
> +		*val = 1000000;
> +		return IIO_VAL_FRACTIONAL;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

