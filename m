Return-Path: <linux-iio+bounces-9942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BD898ACCA
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 21:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDB11C21207
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 19:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE41B19994D;
	Mon, 30 Sep 2024 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j27rHrwc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4A1199396
	for <linux-iio@vger.kernel.org>; Mon, 30 Sep 2024 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724363; cv=none; b=RDJwyt8az4wYFZJi0pD+fm7tdvL5NBhzhJhgKNvLBljZEqvcm0T/ysXYfxOizl7Q+sWD8mhBGu6GISxvIlxOYeuR3+B8lCOs6YEzD5so1Sc3MdkSRhvY5itQ0sV3xOmd0RI4u7HxbkakU5l7qpblVEODdvJUigvELEQBXbCNc+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724363; c=relaxed/simple;
	bh=upXczX9xyZlgGn4PPLtbLvXxPzMauKCBcBofWs39sYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5TwhTom/VqkIrEMjLaiiFcucByDePUQhrp1Wu4iPoj9Fh6CFyCDLZqO66GyfilaJUBv+IbLq4HJhyPSoSe/cON62quwOLGy1hHsA+HB4AemeEKEdEmF58yEnjMqefnE2l0jxuToj62QWAzLLcO+TIeGwcl29XMpu+d8y3Hbx+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=j27rHrwc; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e03d17365bso2945111b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Sep 2024 12:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727724361; x=1728329161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nwBcs3gI4LkvtP1tfi1gw48Tjhc70X0W4lawVSHPYHQ=;
        b=j27rHrwcH6sazDh70H48ubq8Fb34BeBLU2oXca+CzvLDtw9dPQNv7BJcIBk5dWPyJO
         JEWOA8aRQo0iX3ZcFtDX/Ry5p2Fss6NfUFrfYrUegC+lRZ5juzzLnnIY936xv03U6DBE
         NCg8BuE4KA33s8u2Xfixbpa91KZGgaAAEEm0YRZOMr1NKkXmad5KdBKKCYfRIQSqCHAY
         4/8U20pQSX4ajCYmYaKOem2JtEg64Iw8TOOyqOCUrp478TW3mGrfB6MvXVmZxzJOmlNC
         niemNKiuVFaRe5uP9SB2OZr6bjgtaP+6q1UEkXOnTwq4KcdPZtxQVnTQOp+tAUTMQL57
         UCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727724361; x=1728329161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwBcs3gI4LkvtP1tfi1gw48Tjhc70X0W4lawVSHPYHQ=;
        b=FTUeJMfdliqlNLEXy6psF/5d+M+KNhm0Og0AviSjMR1Mz85P8iFjSsaj+KWbwDSkwg
         3SxnalOqZI/pEYpuQHmfaA86m53ZKmGM5qfcK6bdJILBg3HAJa7R9J2BYppdhPobeX/G
         hiw/en+K8qrVl4qS8oX5xhWezbhqsV5BuXL0tUk7ycNhXucOokYkJEsMzolGZoSqy1zP
         LAVneqXStATCJvhi1GBfaJk9W4ABJOzS5p8xW6imZMPL1sTIVGABF+M79n/lgSdH6ox7
         CmdcV9goN9raXs7cq52neavjhYqW7CIkSx2m+EGhgxqsupSDeOcRishm646VUMmVaMiU
         jZ5g==
X-Forwarded-Encrypted: i=1; AJvYcCWHHzOV4C+oUpU1WSDCDrO2IbMztHGcnz6TZr1TwlxdvxVqQvVn/i6nCSfltbsiBO7bSUthStOUlRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8bcchU3lCV90IoCev9he5eNW7OvDpmEhqBxXqIYP6Q+EVFoG0
	AG2xmS60WOCWw3TdnVGLDG8jG1aEKBpm4KLHqLj1nwYF81D8wmUOHrWZMNBPFrg=
X-Google-Smtp-Source: AGHT+IFUg9O4QQqYDWBYxWMhU88gXfp4i3F/4V8s8sFNruPO7jyvNsgoybkJIaGG2NjPdM9jhqqsLw==
X-Received: by 2002:a05:6808:1b8c:b0:3e0:80ed:3f9b with SMTP id 5614622812f47-3e393984970mr8248308b6e.27.1727724360674;
        Mon, 30 Sep 2024 12:26:00 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e39357a90dsm2650904b6e.10.2024.09.30.12.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 12:25:59 -0700 (PDT)
Message-ID: <c9e30ebf-c661-4345-87bd-3169b57175fc@baylibre.com>
Date: Mon, 30 Sep 2024 14:25:55 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] iio: backend: extend features
To: Jonathan Cameron <jic23@kernel.org>,
 Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-5-a17b9b3d05d9@baylibre.com>
 <20240929120535.6b41c37e@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240929120535.6b41c37e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/24 6:05 AM, Jonathan Cameron wrote:
> On Thu, 19 Sep 2024 11:20:01 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
> 
>> From: Angelo Dureghello <adureghello@baylibre.com>
>>
>> Extend backend features with new calls needed later on this
>> patchset from axi version of ad3552r.
>>
>> The follwoing calls are added:
>>
>> iio_backend_ext_sync_enable
>> 	enable synchronize channels on external trigger
>> iio_backend_ext_sync_disable
>> 	disable synchronize channels on external trigger
>> iio_backend_ddr_enable
>> 	enable ddr bus transfer
>> iio_backend_ddr_disable
>> 	disable ddr bus transfer
>> iio_backend_set_bus_mode
>> 	select the type of bus, so that specific read / write
>> 	operations are performed accordingly
>> iio_backend_buffer_enable
>> 	enable buffer
>> iio_backend_buffer_disable
>> 	disable buffer
>> iio_backend_data_transfer_addr
>> 	define the target register address where the DAC sample
>> 	will be written.
>>
>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> Hi Angelo,
> A few trivial comments inline.
> 
>> ---
>>  drivers/iio/industrialio-backend.c | 111 +++++++++++++++++++++++++++++++++++++
>>  include/linux/iio/backend.h        |  23 ++++++++
>>  2 files changed, 134 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
>> index 20b3b5212da7..f4802c422dbf 100644
>> --- a/drivers/iio/industrialio-backend.c
>> +++ b/drivers/iio/industrialio-backend.c
>> @@ -718,6 +718,117 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
> ...
> 
>> +/**
>> + * iio_backend_ddr_disable - Disable interface DDR (Double Data Rate) mode
>> + * @back: Backend device
>> + *
>> + * Disabling DDR data is generated byt the IP at rising or falling front
> 
> Spell check your comments.
> 
>> + * of the interface clock signal (SDR, Single Data Rate).
>> + *
>> + * RETURNS:
>> + * 0 on success, negative error number on failure.
>> + */
>> +int iio_backend_ddr_disable(struct iio_backend *back)
>> +{
>> +	return iio_backend_op_call(back, ddr_disable);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_disable, IIO_BACKEND);
> 				 struct fwnode_handle *fwnode)
>>  {
>> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
>> index 37d56914d485..41619b803cd6 100644
>> --- a/include/linux/iio/backend.h
>> +++ b/include/linux/iio/backend.h
>> @@ -14,12 +14,14 @@ struct iio_dev;
>>  enum iio_backend_data_type {
>>  	IIO_BACKEND_TWOS_COMPLEMENT,
>>  	IIO_BACKEND_OFFSET_BINARY,
>> +	IIO_BACKEND_DATA_UNSIGNED,
>>  	IIO_BACKEND_DATA_TYPE_MAX
>>  };
>>  
>>  enum iio_backend_data_source {
>>  	IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE,
>>  	IIO_BACKEND_EXTERNAL,
>> +	IIO_BACKEND_INTERNAL_RAMP_16BIT,
>>  	IIO_BACKEND_DATA_SOURCE_MAX
>>  };
>>  
>> @@ -89,6 +91,13 @@ enum iio_backend_sample_trigger {
>>   * @read_raw: Read a channel attribute from a backend device
>>   * @debugfs_print_chan_status: Print channel status into a buffer.
>>   * @debugfs_reg_access: Read or write register value of backend.
>> + * @ext_sync_enable: Enable external synchronization.
>> + * @ext_sync_disable: Disable external synchronization.
>> + * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
>> + * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
>> + * @buffer_enable: Enable data buffer.
>> + * @buffer_disable: Disable data buffer.
> 
> This needs more specific text. What buffer?  I think this came
> up earlier but it needs to say something about the fact it's enabling
> or disabling the actual capture of data into the DMA buffers that
> userspace will read.
> 
>> + * @data_transfer_addr: Set data address.
>>   **/
>>  struct iio_backend_ops {
>>  	int (*enable)(struct iio_backend *back);
>> @@ -129,6 +138,13 @@ struct iio_backend_ops {
>>  					 size_t len);
>>  	int (*debugfs_reg_access)(struct iio_backend *back, unsigned int reg,
>>  				  unsigned int writeval, unsigned int *readval);
>> +	int (*ext_sync_enable)(struct iio_backend *back);
> I know we've done it this way for existing items, but I wonder if we should
> squish down the ops slightly and have new enable/disable pairs as
> single functions.
> 	int (*ext_sync_set_state)(struct iio_backend *back, bool enable);
> etc.  If nothing else reduces how many things need documentation ;)
> 
> Nuno, what do you think? Worth squashing these pairs into single
> callbacks?

I'm not a fan of combining enable and disable functions into one function.

The implementation will pretty much always be:

if (enabled) {
        /* so stuff */
} else {
        /* do other stuff */
}

Which just adds indent and makes code harder to read.

> 
>> +	int (*ext_sync_disable)(struct iio_backend *back);
>> +	int (*ddr_enable)(struct iio_backend *back);
>> +	int (*ddr_disable)(struct iio_backend *back);
>> +	int (*buffer_enable)(struct iio_backend *back);
>> +	int (*buffer_disable)(struct iio_backend *back);
>> +	int (*data_transfer_addr)(struct iio_backend *back, u32 address);
>>  };


