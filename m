Return-Path: <linux-iio+bounces-1422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119E68245AA
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jan 2024 17:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB7B1B22CB5
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jan 2024 16:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79589249F5;
	Thu,  4 Jan 2024 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anRx5x4o"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF462250F5
	for <linux-iio@vger.kernel.org>; Thu,  4 Jan 2024 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704384179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=557GDbKk13LSTc98qnADprKqlTFOMRKf8G++jol3Ovw=;
	b=anRx5x4oqEJRwjWA0rfxyx4FGgdUKlvfDe8zaNEBdj6K7ifociQK8mtF9tG1e1IByrhbEH
	SenxhUToGb8Gn6iB/ClVc0WF1rl+OAfYXqMq4HZJt0P1hF2s3qDmRtNGWENAyFbt/v9VXz
	TAQoIJcdlvX+tJ/u8dRUSzS+Nqiz0xQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-SQJ6E8-tOt-dhHvCjGoM3A-1; Thu, 04 Jan 2024 11:02:58 -0500
X-MC-Unique: SQJ6E8-tOt-dhHvCjGoM3A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2888d63b80so30641366b.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Jan 2024 08:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704384177; x=1704988977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=557GDbKk13LSTc98qnADprKqlTFOMRKf8G++jol3Ovw=;
        b=JfYe7qFbOZeowF1XR4VpnufUwG5a8508fkNFi9NQIzVuPa4gGEx4zyTT0dHjsLSdNR
         XtuzNYKbBg39ZShSyjO1B4clyCPbC8rqr9ljiIAnT313IyhSrfN8wgsX7rT4X7qyvp9Y
         aA3q5cc42WJim/xgL5WBTnKHY4mXB2GmE+L+mUXZnC4ylCyujGLhKa9P9ngfvMIt4kJE
         RTwvZc4FEjh8p5x7p09KSG7XQ/32kNI1nNo/oyjVuyp6A20aZvlKBWusV1KS6XxHCvRF
         80mI63j5cdJ0CvDdQYA4Vew01sx5xnUpfTsE5JgmJRdr1tYWIkwWuFQlUZk+6/QJmgtl
         2jXA==
X-Gm-Message-State: AOJu0Yx2jz9Z0zQTIJJZ0R/v7L9M6GfN8Xh7uS0hk15+zsL+FFYFz8gL
	x+Utd9XUuqIS3cmDjutltW88gRQfoggVUsqkUie4aSdbCRyq2un7pvg4dIWac0eLlp8RgASWS49
	9wwg1DCKA31hVhTiADIcE/s8+PyeI
X-Received: by 2002:a17:906:3755:b0:a28:dc82:cde0 with SMTP id e21-20020a170906375500b00a28dc82cde0mr394370ejc.137.1704384177071;
        Thu, 04 Jan 2024 08:02:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9O+ZiJx3F++Eb5kIMI3oNPCBCHKKTYlXj5nwIX15zv7c2AZmMnGV4tXvmS4PlATL0CHAadw==
X-Received: by 2002:a17:906:3755:b0:a28:dc82:cde0 with SMTP id e21-20020a170906375500b00a28dc82cde0mr394361ejc.137.1704384176681;
        Thu, 04 Jan 2024 08:02:56 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gi16-20020a1709070c9000b00a19b7362dcfsm13932610ejc.139.2024.01.04.08.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 08:02:56 -0800 (PST)
Message-ID: <6b770383-aff0-486b-a476-855f51eb480c@redhat.com>
Date: Thu, 4 Jan 2024 17:02:55 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: da280: Simplify id-matching
Content-Language: en-US, nl
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20240104160152.304100-1-hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240104160152.304100-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Note his is v2, I forgot to pass -v2 when git format-patch(ing) this (sorry).

Regards,

Hans

On 1/4/24 17:01, Hans de Goede wrote:
> da280_match_acpi_device() is a DIY version of acpi_device_get_match_data(),
> so it can be dropped.
> 
> And things can be simplified further by using i2c_get_match_data() which
> will also check i2c_client_id style ids.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Add a new da280_match_data struct to hold the name + num_channels and
>   use that instead of the da280_chipset enum
> - Error check i2c_get_match_data() returning NULL
> 
> Handle i2c_get_match_data() returning NULL on missing match-data
> ---
>  drivers/iio/accel/da280.c | 64 +++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
> index 572bfe9694b0..756e2ea7c056 100644
> --- a/drivers/iio/accel/da280.c
> +++ b/drivers/iio/accel/da280.c
> @@ -23,8 +23,6 @@
>  #define DA280_MODE_ENABLE		0x1e
>  #define DA280_MODE_DISABLE		0x9e
>  
> -enum da280_chipset { da217, da226, da280 };
> -
>  /*
>   * a value of + or -4096 corresponds to + or - 1G
>   * scale = 9.81 / 4096 = 0.002395019
> @@ -47,6 +45,11 @@ static const struct iio_chan_spec da280_channels[] = {
>  	DA280_CHANNEL(DA280_REG_ACC_Z_LSB, Z),
>  };
>  
> +struct da280_match_data {
> +	const char *name;
> +	int num_channels;
> +};
> +
>  struct da280_data {
>  	struct i2c_client *client;
>  };
> @@ -89,17 +92,6 @@ static const struct iio_info da280_info = {
>  	.read_raw	= da280_read_raw,
>  };
>  
> -static enum da280_chipset da280_match_acpi_device(struct device *dev)
> -{
> -	const struct acpi_device_id *id;
> -
> -	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -	if (!id)
> -		return -EINVAL;
> -
> -	return (enum da280_chipset) id->driver_data;
> -}
> -
>  static void da280_disable(void *client)
>  {
>  	da280_enable(client, false);
> @@ -107,16 +99,21 @@ static void da280_disable(void *client)
>  
>  static int da280_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> -	int ret;
> +	const struct da280_match_data *match_data;
>  	struct iio_dev *indio_dev;
>  	struct da280_data *data;
> -	enum da280_chipset chip;
> +	int ret;
>  
>  	ret = i2c_smbus_read_byte_data(client, DA280_REG_CHIP_ID);
>  	if (ret != DA280_CHIP_ID)
>  		return (ret < 0) ? ret : -ENODEV;
>  
> +	match_data = i2c_get_match_data(client);
> +	if (!match_data) {
> +		dev_err(&client->dev, "Error match-data not set\n");
> +		return -EINVAL;
> +	}
> +
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -127,23 +124,8 @@ static int da280_probe(struct i2c_client *client)
>  	indio_dev->info = &da280_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = da280_channels;
> -
> -	if (ACPI_HANDLE(&client->dev)) {
> -		chip = da280_match_acpi_device(&client->dev);
> -	} else {
> -		chip = id->driver_data;
> -	}
> -
> -	if (chip == da217) {
> -		indio_dev->name = "da217";
> -		indio_dev->num_channels = 3;
> -	} else if (chip == da226) {
> -		indio_dev->name = "da226";
> -		indio_dev->num_channels = 2;
> -	} else {
> -		indio_dev->name = "da280";
> -		indio_dev->num_channels = 3;
> -	}
> +	indio_dev->num_channels = match_data->num_channels;
> +	indio_dev->name = match_data->name;
>  
>  	ret = da280_enable(client, true);
>  	if (ret < 0)
> @@ -168,17 +150,21 @@ static int da280_resume(struct device *dev)
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(da280_pm_ops, da280_suspend, da280_resume);
>  
> +static const struct da280_match_data da217_match_data = { "da217", 3 };
> +static const struct da280_match_data da226_match_data = { "da226", 2 };
> +static const struct da280_match_data da280_match_data = { "da280", 3 };
> +
>  static const struct acpi_device_id da280_acpi_match[] = {
> -	{"NSA2513", da217},
> -	{"MIRAACC", da280},
> -	{},
> +	{ "NSA2513", (kernel_ulong_t)&da217_match_data },
> +	{ "MIRAACC", (kernel_ulong_t)&da280_match_data },
> +	{}
>  };
>  MODULE_DEVICE_TABLE(acpi, da280_acpi_match);
>  
>  static const struct i2c_device_id da280_i2c_id[] = {
> -	{ "da217", da217 },
> -	{ "da226", da226 },
> -	{ "da280", da280 },
> +	{ "da217", (kernel_ulong_t)&da217_match_data },
> +	{ "da226", (kernel_ulong_t)&da226_match_data },
> +	{ "da280", (kernel_ulong_t)&da280_match_data },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, da280_i2c_id);


