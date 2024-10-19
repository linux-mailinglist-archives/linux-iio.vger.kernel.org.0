Return-Path: <linux-iio+bounces-10762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2DE9A4CE5
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 12:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D091C2151D
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 10:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120481DEFDB;
	Sat, 19 Oct 2024 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4CyEaMU"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C0B2032A
	for <linux-iio@vger.kernel.org>; Sat, 19 Oct 2024 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729334043; cv=none; b=O/3K6LuAPOS4H/IjyJrrZwr1vdk1noVrYUab1eEd05r4jECjOmuEs4paBlRZ2XIzocdMC5Sw8CFfy7YsnJYfd4IkqCJkcFHVmHHc5PBhCnecx17wbxNI9/jZCLds8MGMnA76jiwJZh3X/oZk7YKlj1RvVARU1mJbxl+dDcKscuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729334043; c=relaxed/simple;
	bh=WKD2VUu1VUZFL/i+siPCUW1cDpqRV46S8o+S7UVVOvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZB6kfJApFdOcyJZBSy+3YqsZ39ejVJLtIHetypbPivhzBx4wjy1mv+40tEAmZFNVPCfwDVHTWLNJBBbW7ChXUFufRNvaJRwK5IMzDs5Madi7imiNeFSqL+Y3hm7z+lD8DuDyPbg0rksfMmnbp3MFZOUX+ami0MUcg6bKYBmsrno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4CyEaMU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729334040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ilk3CSIftMozUI7syqFVY15ByMjnzeurICXCGBQvEc=;
	b=b4CyEaMUs/Ll95v9jJxZpeb6DZQtgGd7shG2JSpx5PFIrawc39gSKe5Ak8phRaUMhjB74k
	UTfYhmUpv9Pqd3tc/Teh/xOMwQofspsJV7lsaSoPG/UdQuyN0Msh29nby+qpxqGBl6C4ed
	Py5+/mhCDTuFoOyRr4OOS2YiQq6xQhA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-J2T8OE9zOsGNAPDrSNy4RA-1; Sat, 19 Oct 2024 06:33:59 -0400
X-MC-Unique: J2T8OE9zOsGNAPDrSNy4RA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a1828916fso317379866b.1
        for <linux-iio@vger.kernel.org>; Sat, 19 Oct 2024 03:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729334038; x=1729938838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ilk3CSIftMozUI7syqFVY15ByMjnzeurICXCGBQvEc=;
        b=pmb0ilwYIycBDyvxN2QTUSOTWLy5jQtjRFBvkEcGWis7mlXLmms/93MLtuSTjzbijI
         hPtI9chN/HjC3o366V+ch8+KLp197JZ+dbkGJ7hyD6lPNRXZQ/wbhiOLKaZ0p8qU57VQ
         DtPSvNzKjVIHp7Hi5g+XrG7jfPsGn3QQTQCKRvtBqGVFute/vqCn4GJXeX3/DYUwMlel
         5TjEN3sW+JAasWVFjUwVh9cbAB1VWjCtI8/eiLC/CasnwwHOb8Pwi2Wl/aul8UF+xH9X
         bcPfdx0etBP7ES6+IH0WGkiX2HItNjVzkVa8mp925A00WUV6kkhNR870go/pvlrGKhV3
         iAvg==
X-Forwarded-Encrypted: i=1; AJvYcCUkrapvA8Ui787iReSPZG3D4hUL/em/fvCNggO3mOUW+MhzRYFvVMaUU8l+galUlDcxOiUQpHWiXEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrIgibCkWjXvQSO3gBag091G15ScD+OKmUjP2eaJJuUZRshjpU
	PPY4YlkDzYAklZqHBvAo0dtCO/uUvATmsJOWLQrlgGy17nfqsQuqW1Y71bSEvfsF9vaGigpEh+9
	gxMGcFlTUqhU1S1xuN4XrKwnqqWvn76J0G+kNj5kmBxKujqQi8I645WKPcw==
X-Received: by 2002:a17:907:9404:b0:a99:ee26:f416 with SMTP id a640c23a62f3a-a9a4c2ef2a6mr984291166b.14.1729334037876;
        Sat, 19 Oct 2024 03:33:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiRLik/Qx7H7nLBueSJfiADvAIJ6pdoT4Rr1fTobbt7uumNL3SmFFDQ+LERBNDSORlGnSucw==
X-Received: by 2002:a17:907:9404:b0:a99:ee26:f416 with SMTP id a640c23a62f3a-a9a4c2ef2a6mr984289666b.14.1729334037498;
        Sat, 19 Oct 2024 03:33:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68a921c9sm201127066b.4.2024.10.19.03.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 03:33:56 -0700 (PDT)
Message-ID: <aa7f2214-203d-4b7d-82f3-188fdc6b8673@redhat.com>
Date: Sat, 19 Oct 2024 12:33:55 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: gyro: bmg160: Drop most likely fake ACPI IDs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
References: <20241018145732.2181309-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241018145732.2181309-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Oct-24 4:57 PM, Andy Shevchenko wrote:
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
> ---
>  drivers/iio/gyro/bmg160_i2c.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
> index 672d0b720f61..a81814df5205 100644
> --- a/drivers/iio/gyro/bmg160_i2c.c
> +++ b/drivers/iio/gyro/bmg160_i2c.c
> @@ -39,8 +39,6 @@ static void bmg160_i2c_remove(struct i2c_client *client)
>  
>  static const struct acpi_device_id bmg160_acpi_match[] = {
>  	{"BMG0160", 0},
> -	{"BMI055B", 0},
> -	{"BMI088B", 0},
>  	{},
>  };
>  

Doing a grep on my acpidump collection shows that the BMI prefix is used
for some Bosch IMU-s. It seems that some of the Bosch ACPI HID
prefixes are like this:

Bosch Measurement Accel -> BMAxxxx
Bosch Measurement Gyro  -> BMGxxxx
Bosch Measurement IMU   -> BMIxxxx

In itself these 3 non official vendor prefixis seem to be quite
wildly used and such are not an indication that a HID is not in use.

But using BMI which is for IMU-s in a non IMU driver is suspect.
Note that has Jonathan has pointed out there is a valid BMI0160
HID used by the drivers/iio/imu/bmi160/ code.

I also notice a "BMI055A" HID in the bmc150-accel-[i2c|spi].c drivers,
which seems equally wrong.

It seems that if anything there should be a "BMI055" (no suffix) HID
for drivers/iio/imu/bno055/bno055_i2c.c, but we should only add that
if we actually encounter it in the wild.

TL;DR:

I agree with the removal of the "BMI055B" and "BMI088B" ACPI HIDs
from this driver, because if these are valid for anything they
are valid for the bno055 + some unknown 088 IMU drivers and not
for a gyro driver.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


