Return-Path: <linux-iio+bounces-10761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F3D9A4CC0
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 12:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71E50B22C9A
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 10:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E31DF96D;
	Sat, 19 Oct 2024 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxnloxF0"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35B1DC07B
	for <linux-iio@vger.kernel.org>; Sat, 19 Oct 2024 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729332209; cv=none; b=ZtDhfcGrTBTumafEUrxF7e5ZQYCDJozkU7m9AtbF5xDrCkln7a1J8E0S07jWooxSv90vDxLJEnXAIdcU+IJBvHnjSAmsw38ht/lk90uuzEC3R1JD8RzZkIfrz9UTygkchODoprLZGvcWbjPpWMxsFi+9oMmURGw8Sf6zQgr1J44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729332209; c=relaxed/simple;
	bh=U7PM/dNz5I96Ba7/XpaFXn/lBSoh0Jw64utHtnjJDCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQuf78Qx73gTpn7dlNMiMvohOw0ShWrT49ZT33D33+jKMTIcJbYUl6UFbMZTMAD1MfLycp0R47aaQ24KVOswdp8F+qvVWOJCRcGxImHb7pX8TOxIqKif1FnH8t7nGNTycg1dqnFJP7kFvoMCJ60fiqAVQ1VVB1R0RUiNEBUd0CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxnloxF0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729332206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQdLe7AC4cpIWV8LdUUUTpes6sLRsgEFIkPJaIztUC0=;
	b=XxnloxF0/ixk9qxhte6KMhR9a+dKS+Y/FftYiCFMgQEFdgHfBrk4lFyzg83bAmMrDhO5TY
	Bs9tGDWm1xHkoiJ1w+sINzhzT3JMi2Hxd6W1Zj6MGlpaLL9+9PpTU2YS0Id0hQxeEHIx/j
	w6MFglWDvkuPPQ4I7Frf9vrrA5McE7E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-2shie2Y5Mzu9O-U22U_qHA-1; Sat, 19 Oct 2024 06:03:22 -0400
X-MC-Unique: 2shie2Y5Mzu9O-U22U_qHA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c934295846so1737211a12.1
        for <linux-iio@vger.kernel.org>; Sat, 19 Oct 2024 03:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729332201; x=1729937001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQdLe7AC4cpIWV8LdUUUTpes6sLRsgEFIkPJaIztUC0=;
        b=fkqJr+8soA52X/OsRunXsCebCjPgkrBiuLR4wQymhIvBGhmYUqvki5jBpQ9NRPOKTL
         Ge28LXIjCZLOHLzRkNclG15+8cdx6TMCj3NmGIZT8ITuLQbo0J+iIB/E+qN+G44WeiKk
         QwHLLecoqZekWCZGJB7Uk3NDbyClaMCrIq4XGr5kuNfK4WUDl5x1ynTLfBc18H99XehB
         HlJmEMR3i6lyKnm9eR5X5aXdqAktxGPj4FwCNcjV5u4aSb8wWEn8LPDZpxQMnMwG92B7
         Am8OynNWfuRkyrtFCgl7xV4BJ0WJCgz/FyYhxlrWjcR01NwtxUpwl7WjO9ydSOLbAsrz
         NiVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1TGGPDtq5b+p0+sxPgtyRSvMGsKNBXyEpDOO34My06NJN3oYNaIUTTo4qtZH9wQXku5+IKICRQN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAxcFQMvsq3xfDUjPOo2r3fea0AOLftDVyVbk1uxI6HTc31xCk
	Su38mK9xltsdF6sxxNb2xdSuQLMCexi+yh1dQ24fd8uBIYb3oWnClyvmEiENlP1wHnhLE/Z6RcD
	Q+R2galqf4ovB5PmBPTAZqmn/6QBNzJTvEhcIZ6YkYsnt3FdcgkeAGYesXA==
X-Received: by 2002:a05:6402:4316:b0:5c8:8381:c1bf with SMTP id 4fb4d7f45d1cf-5ca0ac44799mr3261841a12.3.1729332201565;
        Sat, 19 Oct 2024 03:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaqFk9oqqqSjxjVrweCCXfJF51uwgxJVjHIxKFEkoVNAcG+G/U+1zY6NZd6YvWHHMeB1a3wA==
X-Received: by 2002:a05:6402:4316:b0:5c8:8381:c1bf with SMTP id 4fb4d7f45d1cf-5ca0ac44799mr3261828a12.3.1729332201122;
        Sat, 19 Oct 2024 03:03:21 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ca0b0f96b4sm1657456a12.87.2024.10.19.03.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 03:03:20 -0700 (PDT)
Message-ID: <e5cfc7d5-3f5c-44a2-a359-7b63ad7bf07a@redhat.com>
Date: Sat, 19 Oct 2024 12:03:19 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: magnetometer; bmc150_magn: Drop most likely
 fake ACPI IDs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
References: <20241018145805.2181682-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241018145805.2181682-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Oct-24 4:58 PM, Andy Shevchenko wrote:
> The commits in question do not proove that ACPI IDs exist.
> Quite likely it was a cargo cult addition while doing that
> for DT-based enumeration. Drop most likely fake ACPI IDs.
> 
> The to be removed IDs has been checked against the following resources:
> 1) DuckDuckGo
> 2) Google
> 3) MS catalog: https://www.catalog.update.microsoft.com/Search.aspx
> This gives no useful results in regard to DSDT, moreover, the official
> vendor IDs in the registry for Bosh are BSG and BOSC.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>



These HIDs are also not used in my acpidump collection (mostly
BYT / CHT models):

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/iio/magnetometer/bmc150_magn_i2c.c | 9 ---------
>  drivers/iio/magnetometer/bmc150_magn_spi.c | 9 ---------
>  2 files changed, 18 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
> index a28d46d59875..17e10a462ac8 100644
> --- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
> +++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
> @@ -38,14 +38,6 @@ static void bmc150_magn_i2c_remove(struct i2c_client *client)
>  	bmc150_magn_remove(&client->dev);
>  }
>  
> -static const struct acpi_device_id bmc150_magn_acpi_match[] = {
> -	{"BMC150B", 0},
> -	{"BMC156B", 0},
> -	{"BMM150B", 0},
> -	{},
> -};
> -MODULE_DEVICE_TABLE(acpi, bmc150_magn_acpi_match);
> -
>  static const struct i2c_device_id bmc150_magn_i2c_id[] = {
>  	{ "bmc150_magn" },
>  	{ "bmc156_magn" },
> @@ -67,7 +59,6 @@ static struct i2c_driver bmc150_magn_driver = {
>  	.driver = {
>  		.name	= "bmc150_magn_i2c",
>  		.of_match_table = bmc150_magn_of_match,
> -		.acpi_match_table = bmc150_magn_acpi_match,
>  		.pm	= &bmc150_magn_pm_ops,
>  	},
>  	.probe		= bmc150_magn_i2c_probe,
> diff --git a/drivers/iio/magnetometer/bmc150_magn_spi.c b/drivers/iio/magnetometer/bmc150_magn_spi.c
> index abc75a05c46a..c850de1bc79b 100644
> --- a/drivers/iio/magnetometer/bmc150_magn_spi.c
> +++ b/drivers/iio/magnetometer/bmc150_magn_spi.c
> @@ -41,20 +41,11 @@ static const struct spi_device_id bmc150_magn_spi_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, bmc150_magn_spi_id);
>  
> -static const struct acpi_device_id bmc150_magn_acpi_match[] = {
> -	{"BMC150B", 0},
> -	{"BMC156B", 0},
> -	{"BMM150B", 0},
> -	{},
> -};
> -MODULE_DEVICE_TABLE(acpi, bmc150_magn_acpi_match);
> -
>  static struct spi_driver bmc150_magn_spi_driver = {
>  	.probe		= bmc150_magn_spi_probe,
>  	.remove		= bmc150_magn_spi_remove,
>  	.id_table	= bmc150_magn_spi_id,
>  	.driver = {
> -		.acpi_match_table = bmc150_magn_acpi_match,
>  		.name	= "bmc150_magn_spi",
>  	},
>  };


