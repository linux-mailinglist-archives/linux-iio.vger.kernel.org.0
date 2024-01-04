Return-Path: <linux-iio+bounces-1420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AA2824536
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jan 2024 16:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0804E1F23FDB
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jan 2024 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402592376D;
	Thu,  4 Jan 2024 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFPfvBBu"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F26D24B2D
	for <linux-iio@vger.kernel.org>; Thu,  4 Jan 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704382976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9vUKrcGeRu8tknVtrytb3FMCtNzSEJdxRnIasFkasSg=;
	b=dFPfvBBuV2yGgkOXQ2cK1nw/yggGTFaJRwdNTlAKtCBfXEIyHotdc6LjNdSmwD9xDBFElh
	4OqIecikgr/YhYR8U3G7una7uGsUzQM/x3VMfMbqaaPoD1POp/cv5aXKOBNuLEw9eT2atY
	+0Mw3yJhLt4df8pDbQOX65/gcDC0Np4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-F6kwE9PTOaWVAhqjGwz3eg-1; Thu, 04 Jan 2024 10:42:55 -0500
X-MC-Unique: F6kwE9PTOaWVAhqjGwz3eg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50e86a0debcso578948e87.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Jan 2024 07:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704382973; x=1704987773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vUKrcGeRu8tknVtrytb3FMCtNzSEJdxRnIasFkasSg=;
        b=m4XCJuYFbtPP6i0OXckSDUGNkiVZ98q9S9BQObhYwZl5jf8vwdLQi3NnmOfh5tDmn2
         5dB5upRXcWl7IxKdRmFii2STvNUWwaDNBUl180mPFRv8phdbvW5qZs7IjlbbXcTCJgYm
         +IIUNyrJEwxosoZdFYPf7uHRJybvedtjd4OIgEFyejRsxBID7I6VHA3ODkU/ZQvfLosc
         fEHrbn2Q8O3xLsjAZEY1F0LsIOJ/b57ky+rWuO+ERJk/0G9nAhiQt4+qFaLxdd56iefm
         Mb+k37PtbrPXVowWJkMPR5nmsceU373TvNCBCYosAxi2JpiCrOMSLn3PgWUIYhMh/ddW
         H6EQ==
X-Gm-Message-State: AOJu0YxjeVwPLNcDWVy2j/6+QlkVcxT0OtVov+YQRTb4N/lohecXldRP
	hKcn4fr/JU+Xh7iDtxCzOgZDUmU8CILSIcb9i9XFwYRmHffrnQJLk5Kvm0vCxHN3ASlYyi1Jhem
	D7j/md1idZAYL1H6dJKv5fKMBzhSZ9G0+X1pV
X-Received: by 2002:a05:6512:3cc:b0:50e:7b37:d17f with SMTP id w12-20020a05651203cc00b0050e7b37d17fmr442096lfp.114.1704382973624;
        Thu, 04 Jan 2024 07:42:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVJCu1Ifk8Ye+zEykA4osarQ4HElnc8WuvSs05ItF5PwmdMRyUhG67RBq8jXOU0I7rkcKM0Q==
X-Received: by 2002:a05:6512:3cc:b0:50e:7b37:d17f with SMTP id w12-20020a05651203cc00b0050e7b37d17fmr442089lfp.114.1704382973333;
        Thu, 04 Jan 2024 07:42:53 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lb16-20020a170906add000b00a28fa7838d2sm239568ejb.18.2024.01.04.07.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 07:42:52 -0800 (PST)
Message-ID: <b859f303-fdb0-4216-8048-31c1369be8cc@redhat.com>
Date: Thu, 4 Jan 2024 16:42:51 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: da280: Simplify id-matching
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20240101133234.10310-1-hdegoede@redhat.com>
 <20240101154200.28f32bd5@jic23-huawei>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240101154200.28f32bd5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/1/24 16:42, Jonathan Cameron wrote:
> On Mon,  1 Jan 2024 14:32:34 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> da280_match_acpi_device() is a DIY version of acpi_device_get_match_data(),
>> so it can be dropped.
>>
>> And things can be simplified further by using i2c_get_match_data() which
>> will also check i2c_client_id style ids.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Hi Hans and happy new year,
> 
> This runs into a slightly nasty corner case (which can't actually happen because
> we know it will match) of a NULL return on failure to match which ends up
> being the first enum entry whereas we should probably return an error.
> 
> My preferred cleanup would be to make both id tables point to a set of structs
> that encode the device differences as data rather than ids.
> 
> struct da280_chip_info {
> 	const char *name;
> 	int num_channels;
> }
> 
> or something along those lines.  Then we can rely on the generic lookup function
> without taking care about the 0 value.

That is a good idea, thanks.

I have prepared (and will send out shortly) a v2 implementing this.

Regards,

Hans




>> ---
>>  drivers/iio/accel/da280.c | 18 +-----------------
>>  1 file changed, 1 insertion(+), 17 deletions(-)
>>
>> diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
>> index 572bfe9694b0..e4cd4b3a28ab 100644
>> --- a/drivers/iio/accel/da280.c
>> +++ b/drivers/iio/accel/da280.c
>> @@ -89,17 +89,6 @@ static const struct iio_info da280_info = {
>>  	.read_raw	= da280_read_raw,
>>  };
>>  
>> -static enum da280_chipset da280_match_acpi_device(struct device *dev)
>> -{
>> -	const struct acpi_device_id *id;
>> -
>> -	id = acpi_match_device(dev->driver->acpi_match_table, dev);
>> -	if (!id)
>> -		return -EINVAL;
>> -
>> -	return (enum da280_chipset) id->driver_data;
>> -}
>> -
>>  static void da280_disable(void *client)
>>  {
>>  	da280_enable(client, false);
>> @@ -107,7 +96,6 @@ static void da280_disable(void *client)
>>  
>>  static int da280_probe(struct i2c_client *client)
>>  {
>> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>>  	int ret;
>>  	struct iio_dev *indio_dev;
>>  	struct da280_data *data;
>> @@ -128,11 +116,7 @@ static int da280_probe(struct i2c_client *client)
>>  	indio_dev->modes = INDIO_DIRECT_MODE;
>>  	indio_dev->channels = da280_channels;
>>  
>> -	if (ACPI_HANDLE(&client->dev)) {
>> -		chip = da280_match_acpi_device(&client->dev);
>> -	} else {
>> -		chip = id->driver_data;
>> -	}
>> +	chip = (uintptr_t)i2c_get_match_data(client);
>>  
>>  	if (chip == da217) {
>>  		indio_dev->name = "da217";
> 


