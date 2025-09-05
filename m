Return-Path: <linux-iio+bounces-23731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5118B44DAC
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE893B7A69
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 05:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734D4235BEE;
	Fri,  5 Sep 2025 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZ9DBeyA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0C0EEAB;
	Fri,  5 Sep 2025 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757051270; cv=none; b=r/IllSSXs+AOdF8hRJ0LJzE3izaKbWGmxOH1sdcvKlMooVudIUEzjXdav5wtfaMvs7cA4vzRydMXz6RnhBDBcwBsRHuy3LYnayuPAJt4BOXMRDMQvCYzLrmHzSJ7N0ncyZXxROfM4C8wmnscuO17cQsdcw5NNeARYEu7onGZwa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757051270; c=relaxed/simple;
	bh=Wz7naupFrJpTuHMt1wVGz7sZ5XBLZtPb9kQJkmHnnNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3CjNW2FcI+C0Hkp5VSNR+0hCw1tUVgrMT2+ao329EXg9noMswKBBArW2pO1YK0QsMo/CjezthsCZ2sZXwdkAEbdXf664SiFQF1JOnnxnlMjPpdfDY9g6fZXSEjwl2Q3abA5Qg7TMEXFC3Dma2o0XEJAZwtGBMQ5WZ6jDe+Hysg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZ9DBeyA; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f6507bd53so1899991e87.3;
        Thu, 04 Sep 2025 22:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757051267; x=1757656067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EY1wx/hTaPVWB7ToJ66uksdPwS0xHGCPH10mQTR6JuI=;
        b=JZ9DBeyAdrNof5Vv7oLnRekarL2qg3bs01QMt7SLpbJ2swwEOkl6j3fdCtqFJo6zA0
         CV0XYHIyRJQqs4tc3lOSOQ8LAiY1gcLcvjLfUT9hFvkrXtomkpa3nU/xDIIUvlamv3It
         nrJc/sPuPsmLnZAoDS5WrHN9E+3kWIHQ8nJPm4FlBM+wJqp98AcjGI+IoAotpPrkjGaO
         sO9eSSpbYPX5Fs6a+Mb9IKzVAhjL7rFfXVBRGr8dt7PdujxKI1M5Wabn5BUilA9LPyVx
         wZZ2AQ6vtu4E5sEqe6ZLLoTrozXvyBumnaQdRz64JaAGaeEK0sr4lDjnbHuEGH2vv7/N
         4JGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757051267; x=1757656067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EY1wx/hTaPVWB7ToJ66uksdPwS0xHGCPH10mQTR6JuI=;
        b=M79joxlZwyQBTAPi2DggYsK8e7VNlLYMdVKk6wkKZ7v08Lezv6Spl0HyDDeBucPD24
         m0vObVQ/lpywGgn3JrE/z6VYylwGXnbok3KDqk8hWnXCk68ivzY+gfWx3vQOKPW0qPdV
         7+4Bd6OnJ/OLIgKS1hKoLrXLwgExZK8FPVqsjyD4U/h02RTi5Xzy4MxwcAt3rhKaegh+
         q4FOSaqTF/eFYem6BoaEtdEr6eL4EJDZvbu1m3mP0e5kiRiByPHMqd636Y/hHRwn+yQp
         4hGBVTpZhiX3u6s12C/asG09c0vWVOoxDi/CC3A89IlHmLW2tFfV74A0JRWeN81Gshv2
         LUmw==
X-Forwarded-Encrypted: i=1; AJvYcCUwXJ0GqR5L1AQUBC8SDEAg8LzRZPyCFI0HKq6/98xYhwKMwlYCQObVRh6/ySJLNrVdC3oP8TDozSC38g==@vger.kernel.org, AJvYcCVOBNdTd2ku+oAMQkJn3YiV0uuToBPoYAGnmhWMrIftNvunASHCnANLCJa+dq6k1ibV9KeUjmNhNauxvWfV@vger.kernel.org, AJvYcCWoMy6QQAmgMLLXnp8Wa2yE/dN1Getv9KfoPbEsG0pvrhTuEPS2Gxm+uv3PmiChSpVOqY51a9mI9OVb@vger.kernel.org, AJvYcCXk+72NoxukOVZCXqG43/jjRKBSkiHmjKBMuFq/SMGkSd3ZNOn2C3wSbJwYlNr7HwIG36kkDfmuWSWH@vger.kernel.org
X-Gm-Message-State: AOJu0YzzzRXtLl3ycu1KQXVi4C9Fjkt6OkB16/hjkXrH6kduCNSxvZat
	lJqxv5ZWiqHg19FFCnVXx2ipGqhN02RmG1qkDDGFeR2WNTwvbOI2ljJ/
X-Gm-Gg: ASbGnctuGpdFQhKpTd1r6EKovAxwnV+HvLQfSdkBHRch5sErXGP5c7J4U9zB2Sr3qN2
	PAG5JXBCIKruviWAzP8ry1/+csNV1DQN24plIZZbpBERJZarU40NZn2jc5zEn2i3UGkBlniNUPU
	n5Low0reeoS841EvgaIh8L2KfUpPawu/fiIlPHFevuf2G7RQmRLWF9QzLX7++/2SiohGP0pK9Oo
	1wYLGnL/+kkgzUDTM7GZ+g3hDEd2CgKvk3rzLAnDnPYFTk3T95T3irOTTgzXAnyVjezoUoaqK2q
	XC1PkLe9/e+NSQyOsD0/r873Si9WCfJDBAOhkjHsK56ACbsgOUYqwvFkzJi19OVuz8NijKT1H+v
	DDBDwG3bUtN546hu0UIiDvlN+U3nIa7qAHicx7AEnY/TiwwsVGXC3XHUxaTSZtfsvjkXFDRu+ly
	vrttoU7aYbDPM0ZD4=
X-Google-Smtp-Source: AGHT+IFpsuu1jzyehan4myYlV1Vbx2XvBMEJjqMLs1GIZrGmV7bs6BYZtSXMmSbFs0GHSOdFHOXlCA==
X-Received: by 2002:a05:6512:2347:b0:55f:6ddb:25 with SMTP id 2adb3069b0e04-55f708a2b1amr7576130e87.3.1757051266342;
        Thu, 04 Sep 2025 22:47:46 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab5c226sm1645179e87.22.2025.09.04.22.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 22:47:45 -0700 (PDT)
Message-ID: <37f9c6bd-f3b2-4258-a455-c4b08023d8a9@gmail.com>
Date: Fri, 5 Sep 2025 08:47:44 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Hans de Goede <hansg@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1756813980.git.mazziesaccount@gmail.com>
 <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
 <aLb8HuIG0XXLu653@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <aLb8HuIG0XXLu653@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/09/2025 17:15, Andy Shevchenko wrote:

>> +	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, &bd79112_chan_template,
>> +		BD79112_MAX_NUM_CHANNELS - 1, &cs);
> 
> Hmm... Indentation can be amended.
> 
>> +	if (ret < 0) {
> 
> Why ' < 0' ?
> 
>> +		/* Register all pins as GPIOs if there are no ADC channels */
>> +		if (ret == -ENOENT)
>> +			goto register_gpios;
>> +
>> +		return ret;
>> +	}
> 
> Assuming ret can't be positive this can be refactored as:

I returned back to this after reading your comment to v2.

ret can be positive.

> 
> 	/* Register all pins as GPIOs if there are no ADC channels */
> 	if (ret == -ENOENT)
> 		goto register_gpios;
> 	else if (ret)
> 		return ret;
> 
> I find it easier to follow.

I still kinda like your suggestion. I'll change this to something like 
below for v3:

         /* Register all pins as GPIOs if there are no ADC channels */
         if (ret == -ENOENT)
                 goto register_gpios;

         if (ret < 0)
                 return ret;

Thanks again!

Yours,
	-- Matti

