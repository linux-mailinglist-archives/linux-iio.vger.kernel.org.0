Return-Path: <linux-iio+bounces-6252-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4122F907A77
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 19:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443A01C20C0E
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 17:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2EB12FF70;
	Thu, 13 Jun 2024 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MWGtiwtB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A6014A4F1
	for <linux-iio@vger.kernel.org>; Thu, 13 Jun 2024 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301565; cv=none; b=lWaSBMz4lJb3HiEp5Vacb8BeNza29bEnf9kjjISgdVbOg8YX0iEVB1q1q3s1vFUP1UpAaG/MqYGxbt0JxBNZv9FncrvyTD9bds9+tbgSZtFMfdvs/EyqrMcNplbZqdHlbv8fEGBxHtUmSEVV7ExVkKJFa8YHKQjBzBCGv6rqOr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301565; c=relaxed/simple;
	bh=MtUHYD2l4xxuwtdUTX926xYNHDRxYGGX0kXtv3HnGb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRNrOnXg4o3gsOrodV6hePSHAshqQZJZYM0Um+lg+gJQB8CTpxlHNDwDVri3C5DASeyeHbRp70VYchNOS1Dh+JBlqAChv3VrihxJnuSLBcli0cvX1AyX8W4lULx+qHD2tGyBQdQwHOHsiKx0RcCCuXYuLQe6LuSWMXQOG5Nz7Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MWGtiwtB; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-795502843ccso77923585a.1
        for <linux-iio@vger.kernel.org>; Thu, 13 Jun 2024 10:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718301561; x=1718906361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8DxvYUGVHxRZE8NgyFyBxxrydXJ+gJq/RSG2sz2esD8=;
        b=MWGtiwtBdurSak7iHInbxSCOdVMLkgIt4lhchazaQ0i7CU7at9pZ+oI1X2+tL4q+ZO
         eNniHYm/K9VSFerKCkSvPbEFl7ViYaIqq8lk0fpP5QyI6IBaBPvyIpcKOzjGMxpUjlCB
         BZazGGk35D12gW7QV5rxccO9v0pkO9NCFGDyO8Mekl446KMrBeZ+1CftoOfPr1EATfj9
         l7BFHeja2dkVrbHLb9IjhZwXkip8KQc9i0uIlaKD7cr0VvC7GgEB1ZL9UG5MdeBs15v6
         YqLJS1CGXkQYtuGSmYyHdpsFNwzUDe/RBsAafeL47ONyYrpI/EJoFAKm/gzAnas7djbO
         l8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718301561; x=1718906361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DxvYUGVHxRZE8NgyFyBxxrydXJ+gJq/RSG2sz2esD8=;
        b=IWR/aIwIv1RuIuFRXK4GWqt9jVAGwY82kScOZRrs87EtVABBiFwSZVh2k/Nnc/bIaf
         pRabAbtLGbSY8ddMd1FdmHfZ3wxrETYo2Jkt+YchedBLIyARBgLpqwwJJCf7Fr4e+7XG
         rSQjLuC2yD5yafsgfMmlkERw4n7WPKC9k3y0BKCGA/Hhk7ZFkVRiOxRPKY9un5qlsTn+
         Kj80NOMc6M9rVmT9nlUPpx9CP2N0XGdTGIiYVqWEPJEdY2YgnwrT82AF4EzLK9W7Bz1T
         QSjv2zjretCzxULK4DTufiRn6J9x8Dgdxq0m7mnMfbUMyQ6jCnaajpR2zZMgxTdJRAd4
         P9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoQHfzv8yTyO+bOAvrRwLbQt8SvyHIRMU7ST+kiX6ZhL+I0uflaZ41Aq/yF0ax0tUdG1Kbu2cOPk2Oqd5c8gmW7fmcwkBL1htr
X-Gm-Message-State: AOJu0Yz0aMu9feZPbj3nbSWzcsO/C4Oqpb+iouoRD4zUE+HwZXLk5tND
	NbZu0aB4yrcdCN2Rq1cXAeaQ79IgoBRuzM6BHe6ROLU5XimJi1LPc2h2iTbZ1h4=
X-Google-Smtp-Source: AGHT+IHYu0HIgU07HmWdvzdf4u4qWBn8WlIILCE4f7D5lT6HmhfiWx5mZ5m4ZVSvcO8gHLmSoTykaQ==
X-Received: by 2002:a05:620a:44d1:b0:795:4d93:9e86 with SMTP id af79cd13be357-798d2411207mr28622885a.22.1718301560815;
        Thu, 13 Jun 2024 10:59:20 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798a9d8fb49sm73268185a.0.2024.06.13.10.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 10:59:20 -0700 (PDT)
Message-ID: <0003e57b-4c6a-470b-a0d8-20a13091d325@baylibre.com>
Date: Thu, 13 Jun 2024 13:59:14 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH] iio: simplify with regmap_set_bits(),
 regmap_clear_bits()
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Lucas Stankus <lucas.p.stankus@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Chen-Yu Tsai <wens@csie.org>,
 Hans de Goede <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Saravanan Sekar <sravanhome@gmail.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Linus Walleij <linus.walleij@linaro.org>,
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Crt Mori
 <cmo@melexis.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-amlogic@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240611165214.4091591-1-tgamblin@baylibre.com>
 <20240613182021.00005072@Huawei.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20240613182021.00005072@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-06-13 1:20 p.m., Jonathan Cameron wrote:
> On Tue, 11 Jun 2024 12:52:06 -0400
> Trevor Gamblin <tgamblin@baylibre.com> wrote:
>
>> Simplify the way regmap is accessed in iio drivers.
>>
>> Instead of using regmap_update_bits() and passing the mask twice, use
>> regmap_set_bits().
>>
>> Instead of using regmap_update_bits() and passing val = 0, use
>> regmap_clear_bits().
>>
>> Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> Looks like a good change in general. However...
>
> The problem with a change like this is it results in
> non trivial backporting if we need to due to a fix in related
> code.
>
> As such, whilst it will obviously generate a lot of patches, I'd
> like this split up into a series so each patch touches only one driver.
> Fine to keep a single patch for the multiple module for a single
> device cases though.
>
> Also some very long lines that need the line breaks put back.

Thank you. I'll resubmit as a series of separate patches with those 
fixes soon.

Trevor

>
> Jonathan
>
>
>> diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
>> index b8ddbfd98f11..40e605c57adb 100644
>> --- a/drivers/iio/accel/msa311.c
>> +++ b/drivers/iio/accel/msa311.c
>> @@ -1034,10 +1034,8 @@ static int msa311_chip_init(struct msa311_priv *msa311)
>>   				     "failed to unmap map0/map1 interrupts\n");
>>   
>>   	/* Disable all axes by default */
>> -	err = regmap_update_bits(msa311->regs, MSA311_ODR_REG,
>> -				 MSA311_GENMASK(F_X_AXIS_DIS) |
>> -				 MSA311_GENMASK(F_Y_AXIS_DIS) |
>> -				 MSA311_GENMASK(F_Z_AXIS_DIS), 0);
>> +	err = regmap_clear_bits(msa311->regs, MSA311_ODR_REG,
>> +				MSA311_GENMASK(F_X_AXIS_DIS) | MSA311_GENMASK(F_Y_AXIS_DIS) | MSA311_GENMASK(F_Z_AXIS_DIS));
> Too long
>
>> diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
>> index b6c4ef70484e..8fabf748c36b 100644
>> --- a/drivers/iio/adc/cpcap-adc.c
>> +++ b/drivers/iio/adc/cpcap-adc.c
>> @@ -385,9 +385,8 @@ static irqreturn_t cpcap_adc_irq_thread(int irq, void *data)
>> @@ -424,23 +423,17 @@ static void cpcap_adc_setup_calibrate(struct cpcap_adc *ddata,
>>   	if (error)
>>   		return;
>>   
>> -	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
>> -				   CPCAP_BIT_ATOX_PS_FACTOR |
>> -				   CPCAP_BIT_ADC_PS_FACTOR1 |
>> -				   CPCAP_BIT_ADC_PS_FACTOR0,
>> -				   0);
>> +	error = regmap_clear_bits(ddata->reg, CPCAP_REG_ADCC2,
>> +				  CPCAP_BIT_ATOX_PS_FACTOR | CPCAP_BIT_ADC_PS_FACTOR1 | CPCAP_BIT_ADC_PS_FACTOR0);
> That one is over 100!
>>   	if (error)
>> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
>> index a791ba3a693a..ff1c81553045 100644
>> --- a/drivers/iio/gyro/mpu3050-core.c
>> +++ b/drivers/iio/gyro/mpu3050-core.c
>>   
>> @@ -513,12 +513,8 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
>>   				 "FIFO overflow! Emptying and resetting FIFO\n");
>>   			fifo_overflow = true;
>>   			/* Reset and enable the FIFO */
>> -			ret = regmap_update_bits(mpu3050->map,
>> -						 MPU3050_USR_CTRL,
>> -						 MPU3050_USR_CTRL_FIFO_EN |
>> -						 MPU3050_USR_CTRL_FIFO_RST,
>> -						 MPU3050_USR_CTRL_FIFO_EN |
>> -						 MPU3050_USR_CTRL_FIFO_RST);
>> +			ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
>> +					      MPU3050_USR_CTRL_FIFO_EN | MPU3050_USR_CTRL_FIFO_RST);
> Keep the line break to stay under 80 chars.
>
>> @@ -997,11 +991,8 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>>   			return ret;
>>   
>>   		/* Reset and enable the FIFO */
>> -		ret = regmap_update_bits(mpu3050->map, MPU3050_USR_CTRL,
>> -					 MPU3050_USR_CTRL_FIFO_EN |
>> -					 MPU3050_USR_CTRL_FIFO_RST,
>> -					 MPU3050_USR_CTRL_FIFO_EN |
>> -					 MPU3050_USR_CTRL_FIFO_RST);
>> +		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
>> +				      MPU3050_USR_CTRL_FIFO_EN | MPU3050_USR_CTRL_FIFO_RST);
> For IIO stuff try and stay under 80 chars unless there is a strong
> readability argument for going longer.  Here there isn't one.
>
>>   		if (ret)
>>   			return ret;
>>   

