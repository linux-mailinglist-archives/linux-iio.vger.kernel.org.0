Return-Path: <linux-iio+bounces-13076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 539079E356F
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 09:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22410160601
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 08:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D321953B0;
	Wed,  4 Dec 2024 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="SDAJlXbc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44B4192D7E
	for <linux-iio@vger.kernel.org>; Wed,  4 Dec 2024 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301103; cv=none; b=VveLxhQy6RFOAiIINVKOIdlj3t+XSClHgk7HFKRvpvy0GViaXdsvQ5ACgy8PaEC7mMiONgHckcEk3aEiQcPo4LNdvvIJPyIEKJu5FP7+zXDII0vSQ9XcdidcFIeK095Bz0uD7aZnIkQvv/aF5Afue3fRcEp1w8izgKjZ2DmqwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301103; c=relaxed/simple;
	bh=xabGMu3fdt5kFURE8R2vOsZrTXZ3kgYgaYfP0f8Lock=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHjEl8lAA6zQvYPyoJly80mCETKC3Kz4NM5oTkOk4p80vPHaOBk2GQIMBBPgVcKbg8QeylmYBLWItDPDD8AUlSeT10LwEYkFdro/r/m4gQ8aviZai9CsQlQJoCPCrraS4KvWa8IyRWgmK3oQLoAf3sXyi6/atMR+naGxSgmyiQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=SDAJlXbc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4349f160d62so53313685e9.2
        for <linux-iio@vger.kernel.org>; Wed, 04 Dec 2024 00:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733301099; x=1733905899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GuEPwyIkCadZaJxdWvgGbzvWeURHvA2orRW9IhLBR4k=;
        b=SDAJlXbc+dFNvAZtCEL9z4dO7tpL1NCIZbOIMTllgcn+Hwx9qKKFR3MICdDaB7bOwf
         pO/4C10NFE7PdQillzmvinuobHqVhIoVjmqfwPD2lsIW9GHKmEb12ZUCaejQDVk1c8tL
         93ilif2dimOKq5EgwBXMsGHqCZjPdYJGLC91roJR//vrsZX7LtJ7bAkXSusmh4i4QI4Q
         C4jQ2sjcNvYMsAntI4UN16oJaVBGP00bTrS8SUcstQvlhgeb3EuU/gMbhYSS0Rf3ZKxn
         MWo9tCtk0N6mFFMsteUj/0NdjyPfWB8FmHwF+bIlqSTQ57CuUy1o0Kj8j/8geIMbdCiM
         bf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733301099; x=1733905899;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GuEPwyIkCadZaJxdWvgGbzvWeURHvA2orRW9IhLBR4k=;
        b=c5ggKqxWLETGtDUGbvxSOtdgETL8sjkci6ZypjWaXv1Ms7nEsr4ZMNmFx5/cgpmPiB
         niDXE8kGsqTYd7i36piE8F07la5K7xJupr/fr5RXTUbuGRuw7SNFLYTrKc67k5Wqgk11
         2GkC6iPuqr+3tCoztlX236uItonq+g34JjTWqEMU3TEImMXS/mnTAc+ORKLTUn9pXr9w
         B3u34j7m7xQS+fAtrt5WkfY075183e7xWKqojCA2tSjeSgxvnv4PYlPsDvX0FaJoq/Vz
         1/5TFhDeJjhyYciOHrAHrKnKyTgACPY6+UgTxVbXjWq4YmDbodZSstkdzOYa2JJCh3rm
         YP4g==
X-Forwarded-Encrypted: i=1; AJvYcCVe6DMi8S0v2fkGH5mfQQ+Y/OTMUTQ/cFO8eSV9thYABNGMEmd/Atj0O9gjTIpNznCWhlDPKTBSQrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWTBYIjwiK2RRROSdOZADn0aiiAy9ENPcHGA9smCCurUSxNm0
	pwe0zgxb91op3Yl/5hTBQRJtJNMoOKXbigSc6YGc4b5X93eFIGeqrjD0RpN2iZ4=
X-Gm-Gg: ASbGncvXS9bvNfBtMWnu/yNyUclVg68YPHlYOVsXn7OBHD2yDE8Lt5tZO21aTV7SZeu
	mm2Mj0xQ/CfUo+wUl4Rqh3IGAxCaPM2oZYUyYJtESlECwOEt9R/hNs1uOqGByqouyAj3jgWWCum
	x6MPYtXjGtEPft9fT4AfeI1MGdUy364RipdGhnLk04z70ggd4Crr8uGcGfZTnHj1q/GprTMaz5M
	KQ77BEjQRYip14nkFsv/S1QNkJpa0EO20u0gE4BAzMg5vWqtUa2jtiGsAw=
X-Google-Smtp-Source: AGHT+IHQNqpt+GIB9xF7p8MXDoapzcemzg5VBTJ4EDGzEYyaHfuVToI8Mqv94RLzyinN5pW25vh12w==
X-Received: by 2002:a05:600c:5117:b0:431:6060:8b16 with SMTP id 5b1f17b1804b1-434d0a1d63dmr53758325e9.30.1733301098852;
        Wed, 04 Dec 2024 00:31:38 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52723b6sm16489015e9.6.2024.12.04.00.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 00:31:38 -0800 (PST)
Message-ID: <e05191b0-eb3b-472f-bd8f-9d9a28100d0a@tuxon.dev>
Date: Wed, 4 Dec 2024 10:31:36 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] iio: adc: rzg2l_adc: Enable runtime PM autosuspend
 support
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
 <20241203111314.2420473-8-claudiu.beznea.uj@bp.renesas.com>
 <20241203200046.0dfb784a@jic23-huawei>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20241203200046.0dfb784a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Jonathan,

On 03.12.2024 22:00, Jonathan Cameron wrote:
> On Tue,  3 Dec 2024 13:13:07 +0200
> Claudiu <claudiu.beznea@tuxon.dev> wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Enable runtime PM autosuspend support for the rzg2l_adc driver. With this
>> change, consecutive conversion requests will no longer cause the device to
>> be runtime-enabled/disabled after each request. Instead, the device will
>> transition based on the delay configured by the user.
>>
>> This approach reduces the frequency of hardware register access during
>> runtime PM suspend/resume cycles, thereby saving CPU cycles. The default
>> autosuspend delay is set to zero to maintain the previous driver behavior.
> 
> Unless you have a weird user who is polling slow enough to not trigger
> autosuspend with a non zero period, but is still saving power I'm not convinced
> anyone will notice if you just enable this for a sensible autosuspend delay.
> There will of course be a small increase in power usage for each read but
> hopefully that is trivial.
> 
> So I'd not go with a default of 0, though what value makes sense depends
> on the likely usecase + how much power is saved by going to sleep.
> 
> If you really want to keep 0 I don't mind that much, just seems odd!

I agree with you. I chose it like this as I got internal request (on other
drivers enabling autosuspend support) to keep the previous behavior in place.

Thank you for your review,
Claudiu

> 
> Jonathan
> 
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  drivers/iio/adc/rzg2l_adc.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
>> index eed2944bd98d..fda8b42ded81 100644
>> --- a/drivers/iio/adc/rzg2l_adc.c
>> +++ b/drivers/iio/adc/rzg2l_adc.c
>> @@ -207,7 +207,8 @@ static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc
>>  	rzg2l_adc_start_stop(adc, false);
>>  
>>  rpm_put:
>> -	pm_runtime_put_sync(dev);
>> +	pm_runtime_mark_last_busy(dev);
>> +	pm_runtime_put_autosuspend(dev);
>>  	return ret;
>>  }
>>  
>> @@ -372,7 +373,8 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
>>  	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
>>  
>>  exit_hw_init:
>> -	pm_runtime_put_sync(dev);
>> +	pm_runtime_mark_last_busy(dev);
>> +	pm_runtime_put_autosuspend(dev);
>>  	return ret;
>>  }
>>  
>> @@ -412,6 +414,9 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>>  		return PTR_ERR(adc->presetn);
>>  	}
>>  
>> +	/* Default 0 for power saving. Can be overridden via sysfs. */
>> +	pm_runtime_set_autosuspend_delay(dev, 0);
>> +	pm_runtime_use_autosuspend(dev);
>>  	ret = devm_pm_runtime_enable(dev);
>>  	if (ret)
>>  		return ret;
> 

