Return-Path: <linux-iio+bounces-8241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49351946FAA
	for <lists+linux-iio@lfdr.de>; Sun,  4 Aug 2024 17:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC31F28182E
	for <lists+linux-iio@lfdr.de>; Sun,  4 Aug 2024 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019EE770E9;
	Sun,  4 Aug 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9PYLmuf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E349461;
	Sun,  4 Aug 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722786056; cv=none; b=Y+6vJvO+2ZmokFmm4HafSTsEjokL08pbb+rRxb/0+F/azbM7rZqxbR5wfjTmAgOJ7saEiervSB42C5Yz/KfnlCfiNIxIznnlAC0/1FoSVeCGUaAz5PZeGY5/hfHdgX8FR75LNttEa2kQk0rh9FD+LFY/y/vh4dKgrMIqN6i1SQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722786056; c=relaxed/simple;
	bh=stO15Vp2MTSUoK0r6Bw0WqMsKzKKaQBVjXW35KKw0Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+cMFsbblI0t4NTU2YSXKvKfjlK9PMDT4NlMaSQvg/JgcvDuNAvofP0KNccQIZYDtjzS+hHGVc5KT6TZZRLfx3AX9yZc0OvyxyT3MNGcs/nF45vpjqgxqE+nC3SxPYLemCrls5H4+JHHXYrkgTm1nJXwhvdQrAA4Hj4/sugyJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9PYLmuf; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f04c29588so15696198e87.3;
        Sun, 04 Aug 2024 08:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722786053; x=1723390853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qNZb+BVswMBSb2cwkZqZ2BFYdKJnDxJlOV2lgMbFE5k=;
        b=Z9PYLmuf1c2ZB70Mpeee97L8uRrsbrvSVOtvnN0a5fs9Rc8oQoQoYnZNQ3bhczm3kk
         rc0DxcUsbvnlRla6+eXUAoOs9uBKMw5HGfSAIsQBFWF+Pb2fMOr6s0jTBOOFmotfpgf1
         LH4MGd5vHFxPiAKNMjT2vRRVrjcv5SSTNdg6dUA16Y/UtPq1FiImC76l6P1LIXMuRfaP
         kMC0eX/F7grLtXRz28uG1sx8pX9/p1E8HIbNiHW3h9gAIkAmaLuyUxZGVWrbOj5+NY/j
         aLhzUwBZdcnacv/V4FtxTU20og4x3XDXZpX+aXZhsshVBNQQyBOZX+ovQpZZflYuNNjq
         6MMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722786053; x=1723390853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNZb+BVswMBSb2cwkZqZ2BFYdKJnDxJlOV2lgMbFE5k=;
        b=xESOpUTEvP4C0lrMSwT58uHnJfVbsR4ThpJY+oOxalCbt6c8Hsq0Bj0ouw1O8hMzsc
         x0DnZj9iuwJFmXWBsvcTRDAxt/iNNNw09zLPl1/K6pLGqRfkqe6HyufDch0ayi7FfeaB
         cJ2bxIVop2svJc+pPJrVW6E/aWh0zC4xvNy+pzHR3GgruVeukZjEFVB3iK23MbwKw7fd
         lDdLr7zrNI/7upvRtu5uCLOb9oBhaeB4tIIZrloHINy/6ykYdxwx18p+tt3vhL5ET4UE
         C+2Y6bOhLDAjLwMUhu78aVfdF0QDhwVdEWje5TbIL7wESe3UQ5c6Q8mo9m0m50/se1z3
         bQ3A==
X-Forwarded-Encrypted: i=1; AJvYcCW50HDtCL5M6hCwGWVrWHSP4Gx0H8BaEBVTSmJdxxZ54dwfD9t1WguNHtiBh3UWA8jJO7E75fxdLtaXXpg8T5pOH/P28agD+fl6Y7kSEqDDh8LW9wijF/8pgfDv09TQfL4L3QcdrCL7
X-Gm-Message-State: AOJu0YzZHsKJh6Maptfdiu3kLZV7CxobwY8zlHfVM5H4sOpnI7+XIGBE
	rNMRhfS/8LTbcjJ+tqJq8ReOXoJtUfryIS09K00mXc22UGhUEws1
X-Google-Smtp-Source: AGHT+IH2k84BS7srRcYYu8bjFP9JIewD3T1LchYzjZdmwHMc9YReQQB2D56rkmY8UnGSp3mWSlVDew==
X-Received: by 2002:a05:6512:3105:b0:530:c323:46a8 with SMTP id 2adb3069b0e04-530c32346e8mr2835046e87.23.1722786052592;
        Sun, 04 Aug 2024 08:40:52 -0700 (PDT)
Received: from [192.168.1.127] ([151.49.86.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0b62esm343737066b.62.2024.08.04.08.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 08:40:52 -0700 (PDT)
Message-ID: <b7e91e68-9f5f-4dd0-aa96-e57983e4a56d@gmail.com>
Date: Sun, 4 Aug 2024 17:40:49 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: bmi323: suspend and resume triggering on
 relevant pm operations
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Jagath Jog J <jagathjog1996@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Luke D . Jones" <luke@ljones.dev>,
 Jonathan LoBue <jlobue10@gmail.com>
References: <20240727123034.5541-1-benato.denis96@gmail.com>
 <20240727123034.5541-3-benato.denis96@gmail.com>
 <20240803164428.50fdd15c@jic23-huawei>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <20240803164428.50fdd15c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/08/24 17:44, Jonathan Cameron wrote:
> On Sat, 27 Jul 2024 14:30:34 +0200
> Denis Benato <benato.denis96@gmail.com> wrote:
> 
>> Prevent triggers from stop working after the device has entered sleep:
>> use iio_device_suspend_triggering and iio_device_resume_triggering helpers.
> 
> Hi Denis,
> 
Hello Jonathan,
> I'd got it into my head this was about main suspend / resume, but
> it's runtime PM. I assume the s2idle uses only that level which is
> interesting.
> 
I have catched the problem with s2idle, but I don-t fully understand
it will manifest outside of said scenario, nor if it will at all and
only s2idle is affected.

> Anyhow, solution seems safe. We might be able to do something nicer
> in the long run as potentially we could have the trigger driver
> notified when all consumers have entered this state at which point it
> could stop generating triggers at all.
> Totally agree.
> Anyhow, that's a job for when we actually care about it.
> 
> Applied to the togreg branch of iio.git and pushed out as testing
> for 0-day to poke at it.
> 
I have made a mistake while cleaning up patch 1/2 for submission and lost a piece:
the pollfunc->irq=0 you suggested in your first mail.

I would be more than happy to provide a v3, but if you prefer I can also send
a separate patch.

I am sorry about that and I would like guidance on what to do in cases like this.
> For now I'm not keen to see this pushed into drivers where we don't
> know if anyone is running into this particular situation.  We can
> reevaluate that if we start getting lots of reports of this.
> 
I catched the issue while developing an application for a handheld PC.

As the application will target these kind of devices we can apply the fix
to every relevant driver (bmi260 comes to mind) and have that well-tested
on multiple drivers.
> I'm also not going to rush this in as a fix. We can consider backporting
> it once it's been in mainline for a bit and no side effects have
> shown up.
> 
> Thanks,
> 
> Jonathan
> 
Thanks,

Denis
>>
>> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
>> ---
>>  drivers/iio/imu/bmi323/bmi323.h      |  1 +
>>  drivers/iio/imu/bmi323/bmi323_core.c | 23 +++++++++++++++++++++++
>>  drivers/iio/imu/bmi323/bmi323_i2c.c  |  1 +
>>  drivers/iio/imu/bmi323/bmi323_spi.c  |  1 +
>>  4 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/iio/imu/bmi323/bmi323.h b/drivers/iio/imu/bmi323/bmi323.h
>> index dff126d41658..209bccb1f335 100644
>> --- a/drivers/iio/imu/bmi323/bmi323.h
>> +++ b/drivers/iio/imu/bmi323/bmi323.h
>> @@ -205,5 +205,6 @@
>>  struct device;
>>  int bmi323_core_probe(struct device *dev);
>>  extern const struct regmap_config bmi323_regmap_config;
>> +extern const struct dev_pm_ops bmi323_core_pm_ops;
>>  
>>  #endif
>> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
>> index d708d1fe3e42..4b2b211a3e88 100644
>> --- a/drivers/iio/imu/bmi323/bmi323_core.c
>> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
>> @@ -2121,6 +2121,29 @@ int bmi323_core_probe(struct device *dev)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
>>  
>> +#if defined(CONFIG_PM)
>> +static int bmi323_core_runtime_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +
>> +	return iio_device_suspend_triggering(indio_dev);
>> +}
>> +
>> +static int bmi323_core_runtime_resume(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +
>> +	return iio_device_resume_triggering(indio_dev);
>> +}
>> +
>> +#endif
>> +
>> +const struct dev_pm_ops bmi323_core_pm_ops = {
>> +	SET_RUNTIME_PM_OPS(bmi323_core_runtime_suspend,
>> +			   bmi323_core_runtime_resume, NULL)
>> +};
>> +EXPORT_SYMBOL_NS_GPL(bmi323_core_pm_ops, IIO_BMI323);
>> +
>>  MODULE_DESCRIPTION("Bosch BMI323 IMU driver");
>>  MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
>>  MODULE_LICENSE("GPL");
>> diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
>> index 52140bf05765..057342f4f816 100644
>> --- a/drivers/iio/imu/bmi323/bmi323_i2c.c
>> +++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
>> @@ -128,6 +128,7 @@ MODULE_DEVICE_TABLE(of, bmi323_of_i2c_match);
>>  static struct i2c_driver bmi323_i2c_driver = {
>>  	.driver = {
>>  		.name = "bmi323",
>> +		.pm = pm_ptr(&bmi323_core_pm_ops),
>>  		.of_match_table = bmi323_of_i2c_match,
>>  		.acpi_match_table = bmi323_acpi_match,
>>  	},
>> diff --git a/drivers/iio/imu/bmi323/bmi323_spi.c b/drivers/iio/imu/bmi323/bmi323_spi.c
>> index 7b1e8127d0dd..487d4ee05246 100644
>> --- a/drivers/iio/imu/bmi323/bmi323_spi.c
>> +++ b/drivers/iio/imu/bmi323/bmi323_spi.c
>> @@ -79,6 +79,7 @@ MODULE_DEVICE_TABLE(of, bmi323_of_spi_match);
>>  static struct spi_driver bmi323_spi_driver = {
>>  	.driver = {
>>  		.name = "bmi323",
>> +		.pm = pm_ptr(&bmi323_core_pm_ops),
>>  		.of_match_table = bmi323_of_spi_match,
>>  	},
>>  	.probe = bmi323_spi_probe,
> 


