Return-Path: <linux-iio+bounces-5679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB7E8D841A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 15:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF961C21C0F
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 13:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B4012DD83;
	Mon,  3 Jun 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0ZzNp5Jo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B02209B
	for <linux-iio@vger.kernel.org>; Mon,  3 Jun 2024 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421817; cv=none; b=S18TBmszdFQgwP8MqeaQtEQA+UPHEBK3TFUJVveSuNg5/ub0fdIcpahKWx/CoSkNPhU3xlwWvaltVKxVLWvnQp59io84DLH+Q7pUm8Cdm+P6ar7Mu06W2dj//8GRpb9f6T0cynSn/i0S6sMGEcEjBQsVZEOhShSJZsAsh/wMgwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421817; c=relaxed/simple;
	bh=ttcizD8aqzGdjnI2golwzJicIDJIicbP6XGksbPjSbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPIh4a7FGuR980VjW9WhoxXbRE3TDpAUt2OdnuBJI7VJHxzOdJmfaemO6DYMgoLxGeX4bu5gk+Qwv5yLbSP2jwPvu8uY1C9B0yOLxdJks2yaDpey57omEzFkCRe+8pmfAbVlfJXvn7N7Pcaed2j/ukuOjoIR7Ct59ASHUeeDVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0ZzNp5Jo; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f8ef894ecdso2629228a34.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2024 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717421813; x=1718026613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1qq7UWn5K6k6IOKB88bjuVwYDqNTOU4W22ea0kVcM8=;
        b=0ZzNp5Jo4tBMEv1pSPq8zXUy3rXUlZXtqCeU55Pt0HxMCJ2/LVofO34H4APFhGPlsZ
         4g8SdgrtY7l9RgofhMgygdm4bAvQNpAZYgmgRGIQOiV5HWbRAXdrJnAK1ub2nEOx/95D
         jZ+jeJJtgonEhIw/2KDZgcpDls25PMjUujFh/6a01X5QBH+bVvkN0YpIl0pECbOPFbM8
         F7J1YiL6poc6u5A8LW1vh3xwmXuEiEaP8RoChmThEhefdrQPagDV/nozu17oJjnAC7xX
         I9/W3ubf5JJv5RH9ufhXvXHBCuMhKej5EK7VXPb9yt6j4kngURtw0ASRD7gCTA0Y/2WB
         0G/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717421813; x=1718026613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1qq7UWn5K6k6IOKB88bjuVwYDqNTOU4W22ea0kVcM8=;
        b=bWs43VtOudYxdURuquoU0O/N2ky8ObEDLOLL3ETcpXfGRNwOFw90I/Mu+S+Vllx2fJ
         xj+I0N2Tf4xevPCnXr9nogtJB6nz08g3ROokZqFUKl12K47Jykx58XBDXdYY8afaU+Sa
         oouweLcl37xznXYUDZXRLRW8/Y70yH5OkvuoUwvAi81vRH6toYE4PkBVE0AIuVAjzI1p
         dakbDf4CGEo8RPHPfcXVktIQQ6lZVM8RTP7n/FbjP3WLTcr4PL0n2DilAAcjxhvAs69T
         tf5nJkpyR1xcWsU9268Byb+FjHv9F4gkR9RMleTktsUuScUM29SFcfqnN1e8vGeszxh0
         RhVw==
X-Forwarded-Encrypted: i=1; AJvYcCWw7WhT9Q6tEjn3ywSjLXBb0cfT9Ezdw2TpznR9tW3ddpQtMw1UZ97Sk9YzGlbaG2fwQFsyl8Zg5m87ZBotR17HNAiXp0orUJMu
X-Gm-Message-State: AOJu0YxZcmbUcmD1r52744r6DNcPnJSv2SVPy6+RvXyVObhbAwJ4Omlc
	oGIl0PERtv1An1XT+lFEwYNYw0wxNHmJGjLladNLzQibDjpAnsrZFLTJOxvmeNE=
X-Google-Smtp-Source: AGHT+IF9WZpfibvv2GmZe4kUX8UKp4KjQFa3htZldW0WfM/LKDyRWEEaJwkOu3xrlySKML7GbL3LUw==
X-Received: by 2002:a05:6830:22fc:b0:6ee:23dd:7441 with SMTP id 46e09a7af769-6f911fb5639mr9510252a34.28.1717421813021;
        Mon, 03 Jun 2024 06:36:53 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f91054e9acsm1442812a34.35.2024.06.03.06.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 06:36:52 -0700 (PDT)
Message-ID: <9bcf9ed6-dcba-4e23-9845-a81cf39a3153@baylibre.com>
Date: Mon, 3 Jun 2024 08:36:51 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iio: adc: ad7192: use
 devm_regulator_get_enable_read_voltage
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
 <20240531-iio-adc-ref-supply-refactor-v1-1-4b313c0615ad@baylibre.com>
 <20240601134828.68c3acba@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240601134828.68c3acba@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/24 7:48 AM, Jonathan Cameron wrote:
> On Fri, 31 May 2024 16:19:32 -0500
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
> Ouch diff didn't like this one much and it is a bit hard to read.
> 
> One case where I think this has an unintended side effect.
> See below.
> 

...

>> @@ -1219,74 +1211,54 @@ static int ad7192_probe(struct spi_device *spi)
>>  	 * Newer firmware should provide a zero volt fixed supply if wired to
>>  	 * ground.
>>  	 */
>> -	aincom = devm_regulator_get_optional(&spi->dev, "aincom");
>> -	if (IS_ERR(aincom)) {
>> -		if (PTR_ERR(aincom) != -ENODEV)
>> -			return dev_err_probe(&spi->dev, PTR_ERR(aincom),
>> -					     "Failed to get AINCOM supply\n");
>> -
>> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "aincom");
>> +	if (ret == -ENODEV)
>>  		st->aincom_mv = 0;
>> -	} else {
>> -		ret = regulator_enable(aincom);
>> -		if (ret)
>> -			return dev_err_probe(&spi->dev, ret,
>> -					     "Failed to enable specified AINCOM supply\n");
>> +	else if (ret < 0)
>> +		return dev_err_probe(&spi->dev, ret, "Failed to get AINCOM voltage\n");
>> +	else
>> +		st->aincom_mv = ret / MILLI;
>>  
>> -		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, aincom);
>> +	/* AVDD can optionally be used as reference voltage */
>> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "avdd");
>> +	if (ret == -EINVAL) {
>> +		/*
>> +		 * We get -EINVAL if avdd is a supply with unknown voltage. We
>> +		 * still need to enable it since it is also a power supply.
>> +		 */
>> +		ret = devm_regulator_get_enable(&spi->dev, "avdd");
> 
> What happens if the entry simply isn't there in the DT.
> Previously I think the regulator framework would supply a stub whereas
> the devm_regulator_get_enable_read_voltage() returns -ENODEV so isn't
> caught by the handling and I think it should be.

Ah, yes so:

if (ret == -EINVAL || ret == -ENODEV) {


