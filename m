Return-Path: <linux-iio+bounces-11008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE189ACEF0
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC1B1C228E8
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB9F1C6F54;
	Wed, 23 Oct 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQT6eEYv"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B854E1C4605
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697788; cv=none; b=j4yefvT+A5Tg8DFeopdNxpuQ8UF8DV1eRylfDxN211cDXM/xyP82bo47x2U2FILqGZxUvY0KdgnwZcQTAYpsXAHzoTcw9js6ua9Z6cAb0LUVg0N92372Dcbe/r0vr05kGmKNB0jnE8RBtotTimKcL0PPaW2dNgvYF7hEdi25Ops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697788; c=relaxed/simple;
	bh=hLA1RQo8/RcVFBLspjlNQ/FEotGEHQu2tn1mH5H7qGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/XSm8Fdtg3JWUc64x5wKjsLvUNwG1ecHH/FFHY2n6N1fyTzaCMTHnO0NtuwN7J9kHpxQ+qQRgEoqF4of5a7jgcQOqXW3GQxNRQOn4PvT6HEiffiCXj4GeNe1EdSC46D/GuyyQh7+oonqQHicwBAMpA5MZ4KmA+rtflEc52B3bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQT6eEYv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729697785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W12atCawGWIIMbzM+o0TKKbvEulWWaQhHboBuLLrayc=;
	b=gQT6eEYvOfLjKV7ERBVQMmFNUrkIeVZGqcM7chhzuFzpP1jVALgbhD4RkUnJQLvPCUTce+
	XrtqooKX3Ui/vHtwtX30M7ndS7Im5gg+1KtMjG2zTLe7XpHJcAU9CS+SvwKTGjhivKTW4y
	ZlhyoyO7jR0mpcTmDGUYgCUgRNKi6E4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-etFaFRp9NTC3oYh5Q4xNkQ-1; Wed, 23 Oct 2024 11:36:23 -0400
X-MC-Unique: etFaFRp9NTC3oYh5Q4xNkQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539eeb63cc3so5201242e87.2
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 08:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697782; x=1730302582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W12atCawGWIIMbzM+o0TKKbvEulWWaQhHboBuLLrayc=;
        b=gXmFuZZX5kAG1obMOIgW1nSfXyq/fpo8i/9C9kFK29sAmcD0s1AaZYDpxr63FrDvMK
         2yuv/zWKlwiPNcBXRXW7H58cTYauvWRq8xZpStvneTT6e6BJx7Dj2L0Wo4fVz6mqziTE
         X7bmbO7FyUi2bg5/69OD6WczUyHHYCA+SIcvbg8QrTzOauKrt+HJmutdKtLVdJWg6NuM
         ew6FAUSB20eWkRG6EblZkdc2L9gbvd0VoCKbNvAmIkP2Z+p30VN+sDqR7wBLMV2T5onK
         8545lcsLWAlqsd053ix586X/fRANBXhxti6IevhkE9yjG7SKnqnZ4GR/2xMQ2WwxFMuB
         O/Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVYbO4GowjPFOuPWim5zgDBji1NfToYfHdcNwLuvfUDBjQfi5P4bL9ogRRBmsQMV8AKvI58hd1SOFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuLtW8uWvZUwknRT55WLKSpDJr7VDdlr0zjCwNW1SpU0wijACc
	Vpp4dHnVp9gB/9czl5I6Eh1uK64Gn0p18YHH6zop/FtyEzkob+2oJJQJjTMHKNBPS5mzoyUKV1C
	jrJJk2TPL8bz6AouA0ApeQvze+Utcxvs+1gKiwN1wU3H6UDgwq9CIGb4LOA==
X-Received: by 2002:a05:6512:3caa:b0:539:f630:f233 with SMTP id 2adb3069b0e04-53b1a396616mr1704037e87.57.1729697782031;
        Wed, 23 Oct 2024 08:36:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOTmpkqv0SJnjqxX01hB8AB1rRaXAa5SfDtN0cPFdQexruh9uHn2xIIyAyw/VnACPHbMqdEA==
X-Received: by 2002:a05:6512:3caa:b0:539:f630:f233 with SMTP id 2adb3069b0e04-53b1a396616mr1704015e87.57.1729697781553;
        Wed, 23 Oct 2024 08:36:21 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a653f5sm4571880a12.26.2024.10.23.08.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 08:36:21 -0700 (PDT)
Message-ID: <6d6d038a-bc0a-4a13-9dcb-94e289767b44@redhat.com>
Date: Wed, 23 Oct 2024 17:36:19 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/13] iio: Clean up acpi_match_device() use cases
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
References: <20241023152145.3564943-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241023152145.3564943-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 23-Oct-24 5:17 PM, Andy Shevchenko wrote:
> There are current uses of acpi_match_device():
> - as strange way of checking if the device was enumerated via ACPI
> - as a way to get IIO device name as ACPI device instance name
> - as above with accompanying driver data
> 
> Deduplicate its use by providing two new helper functions in IIO ACPI
> library and update the rest accordingly.
> 
> This also includes a rework of previously sent ltr501 patch.

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans


> Andy Shevchenko (13):
>   iio: magnetometer: bmc150: Drop dead code from the driver
>   iio: adc: pac1934: Replace strange way of checking type of enumeration
>   iio: imu: inv_mpu6050: Replace strange way of checking type of
>     enumeration
>   iio: acpi: Improve iio_read_acpi_mount_matrix()
>   iio: acpi: Add iio_get_acpi_device_name_and_data() helper function
>   iio: accel: mma9551: Replace custom implementation of
>     iio_get_acpi_device_name()
>   iio: accel: mma9553: Replace custom implementation of
>     iio_get_acpi_device_name()
>   iio: gyro: bmg160: Replace custom implementation of
>     iio_get_acpi_device_name()
>   iio: light: isl29018: Replace a variant of
>     iio_get_acpi_device_name_and_data()
>   iio: light: isl29018: drop ACPI_PTR() and CONFIG_ACPI guards
>   iio: light: ltr501: Drop most likely fake ACPI IDs
>   iio: light: ltr501: Add LTER0303 to the supported devices
>   iio: light: ltr501: Replace a variant of
>     iio_get_acpi_device_name_and_data()
> 
>  drivers/iio/accel/mma9551.c                | 19 ++-------
>  drivers/iio/accel/mma9553.c                | 19 ++-------
>  drivers/iio/adc/pac1934.c                  |  2 +-
>  drivers/iio/gyro/bmg160_core.c             | 15 --------
>  drivers/iio/gyro/bmg160_i2c.c              |  4 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c |  5 +--
>  drivers/iio/industrialio-acpi.c            | 45 ++++++++++++++++++++--
>  drivers/iio/light/isl29018.c               | 38 ++++++------------
>  drivers/iio/light/ltr501.c                 | 29 +++++---------
>  drivers/iio/magnetometer/bmc150_magn.c     | 15 --------
>  include/linux/iio/iio.h                    | 10 +++++
>  11 files changed, 86 insertions(+), 115 deletions(-)
> 


