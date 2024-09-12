Return-Path: <linux-iio+bounces-9467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7124976B35
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 15:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BE8DB21605
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7813D1AD27A;
	Thu, 12 Sep 2024 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxwQ8k7R"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5724F1A4E89
	for <linux-iio@vger.kernel.org>; Thu, 12 Sep 2024 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149163; cv=none; b=pu+TMswaGjH/hxnkZJFon5T9TbmAu10XidRK6ZcVUMxRBRiC25cuBQL9RJzcO80taY7Y+AQGO/98PU6Mj1J46BAaVXsWpVPGny+hXZ0DVQtfsR2sgkSsZvEx/MQ+e1d5UJGTtR2G/hJhlNWKF6XOgEWCc2bofbNzxizD8rDQblI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149163; c=relaxed/simple;
	bh=847eTLZW0MfM6fAAiLbEcfeHHCOcPEU+ymVhnn3BG5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUJWDM58vOw40WVKzxTgWsnvxTWvUTcW0cHYHn6q/D7oW1ObOUwMaVY2BeAK/F0niNC5pIoz73LkoRbRNZPURNvEVxndHRoi+JDrdykJeN1P/15ORdFpt1EebZ33kNQZ+v/deCHd4f1JtfKqqtQRhkeAL+eKzTpELjWOCcY/yc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxwQ8k7R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726149160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bUGx0nxNlp6Ya2u4chOzdjTNWM8SNP7+zCSMGBl0LSw=;
	b=CxwQ8k7R8NiGW+OKEs0+CrTXH92A1JlNaea7aGGs1unIRS64Rit699weLyRv/dISWkxTe1
	32zucyueDpBKpylyp9awYyJwVe2yRk10Gw8DIShlzMMI/Hx/NLPdoICENM/VuCa6TtChIa
	UTA4L0rHM3LzC/SjrZLtT2/MS3J27go=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-dMpFmr4CMc-EM0X41Y_Zcw-1; Thu, 12 Sep 2024 09:52:37 -0400
X-MC-Unique: dMpFmr4CMc-EM0X41Y_Zcw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c24c92db25so2633178a12.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Sep 2024 06:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726149156; x=1726753956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUGx0nxNlp6Ya2u4chOzdjTNWM8SNP7+zCSMGBl0LSw=;
        b=OlI0v5TpgmoZnEcysYoLiY6DJCMwgiN/z6lqUC+m4AWkAeieoJ8grEOcnOU6qNgc25
         OeOkNolxVLO9Uq/5hsdctlKUKts5YX/onbigzu2T3S4lO9DOL1JWFIvXjg0m6HyCBjkY
         /ZCiKoUpkt08soC/yg/3n9chlCAVJ3XhxWWwXha9D/KfU8fump+Dr7EnxHndcqVUB6D2
         dArbbCf9ZmPZ8qiPmT8Uhb5TUxAj/210reSdVvrdNURwJlOdJKQZB0OKkVUAFdGe1sy4
         Ej86t+5350Jzb/4GpK3PSHKDdumwwLrAYgDbwKMAyUjOO/EBWlUPDwGMK/ZZauV4hNV5
         BLSw==
X-Forwarded-Encrypted: i=1; AJvYcCVodNy3LAjnAtko859tkO3AZAnPSU8b/Jbvu86HGVwWk+7nRPIJ88CUU1n3cSyD7RmYRA/0OVbka6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLA/jHJYfsr3uykn3S8VoPqJ/3M0w71kGfCN0J9X2sXpiLv1py
	bQPbXL0yXhc0ie4nttLDQVrRvOfnab5Lh1sT4KjfhgOac92uc8tLr5lP25y0Nk8W+HewFV7OwD1
	kp/hSZVIhTBMqnfc++LhotfWVOuLZi92wZJwi1lCE5IlSB6tzyCsFTzZlDA==
X-Received: by 2002:a05:6402:27c7:b0:5c2:7699:92ef with SMTP id 4fb4d7f45d1cf-5c414387344mr3595181a12.16.1726149155966;
        Thu, 12 Sep 2024 06:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUIaRkkEE7PI8ImUPDTHW8ksRiH/DOysbU4BTFTMACkOClQFBX7Xr2CoNq6fzXKdFBReixSQ==
X-Received: by 2002:a05:6402:27c7:b0:5c2:7699:92ef with SMTP id 4fb4d7f45d1cf-5c414387344mr3595144a12.16.1726149155453;
        Thu, 12 Sep 2024 06:52:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd41c36sm6596555a12.2.2024.09.12.06.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 06:52:35 -0700 (PDT)
Message-ID: <2b847413-f8ee-436c-a635-f5a36253e953@redhat.com>
Date: Thu, 12 Sep 2024 15:52:34 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: imu: kmx61: Drop most likely fake ACPI ID
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
References: <20240911213110.2893562-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240911213110.2893562-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/11/24 11:31 PM, Andy Shevchenko wrote:
> The commit in question does not proove that ACPI ID exists.
> Quite likely it was a cargo cult addition while doint that
> for DT-based enumeration.  Drop most likely fake ACPI ID.
> 
> Googling for KMX61021L gives no useful results in regard to DSDT.
> Moreover, the official vendor ID in the registry for Kionix is KIOX.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/iio/imu/kmx61.c | 25 +++----------------------
>  1 file changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index c61c012e25bb..2af772775b68 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -7,12 +7,13 @@
>   * IIO driver for KMX61 (7-bit I2C slave address 0x0E or 0x0F).
>   */
>  
> -#include <linux/module.h>
>  #include <linux/i2c.h>
> -#include <linux/acpi.h>
>  #include <linux/interrupt.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
> @@ -1217,16 +1218,6 @@ static irqreturn_t kmx61_trigger_handler(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> -static const char *kmx61_match_acpi_device(struct device *dev)
> -{
> -	const struct acpi_device_id *id;
> -
> -	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -	if (!id)
> -		return NULL;
> -	return dev_name(dev);
> -}
> -
>  static struct iio_dev *kmx61_indiodev_setup(struct kmx61_data *data,
>  					    const struct iio_info *info,
>  					    const struct iio_chan_spec *chan,
> @@ -1293,8 +1284,6 @@ static int kmx61_probe(struct i2c_client *client)
>  
>  	if (id)
>  		name = id->name;
> -	else if (ACPI_HANDLE(&client->dev))
> -		name = kmx61_match_acpi_device(&client->dev);
>  	else
>  		return -ENODEV;
>  
> @@ -1496,13 +1485,6 @@ static const struct dev_pm_ops kmx61_pm_ops = {
>  	RUNTIME_PM_OPS(kmx61_runtime_suspend, kmx61_runtime_resume, NULL)
>  };
>  
> -static const struct acpi_device_id kmx61_acpi_match[] = {
> -	{"KMX61021", 0},
> -	{}
> -};
> -
> -MODULE_DEVICE_TABLE(acpi, kmx61_acpi_match);
> -
>  static const struct i2c_device_id kmx61_id[] = {
>  	{ "kmx611021" },
>  	{}
> @@ -1513,7 +1495,6 @@ MODULE_DEVICE_TABLE(i2c, kmx61_id);
>  static struct i2c_driver kmx61_driver = {
>  	.driver = {
>  		.name = KMX61_DRV_NAME,
> -		.acpi_match_table = kmx61_acpi_match,
>  		.pm = pm_ptr(&kmx61_pm_ops),
>  	},
>  	.probe		= kmx61_probe,


