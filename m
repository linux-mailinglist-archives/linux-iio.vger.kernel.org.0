Return-Path: <linux-iio+bounces-11541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0D59B426D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 07:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D452832A3
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 06:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4050201108;
	Tue, 29 Oct 2024 06:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwWSJiCI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF151E0B93;
	Tue, 29 Oct 2024 06:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730183696; cv=none; b=QiogwTD69i/+G37n2LFjMrKQwajGd4oSaFdYJ/r7LLiI3LvaSwDnriEzYALyyR+aImh7RaYir/374XS0oN8bPvqTrfyzeTVPjDEK7XIPBaIcNn9GbKkL6DelRj3MtpGMzZvtMFKUIapQngYzQUxhBfm96YhSBNJsknJ+zPH938A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730183696; c=relaxed/simple;
	bh=cB3UuohXNvIsjeVdbHwVYAB8OTFa3RaX1V6PrY6zhl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSG9yaK2TPixUBjHX9RPSSYteuZBwsQYBhAcm6R+RbhcNCfBDRUU6lad9X524B7otH+idQXIBgjFJYdjFS9/CnCyHZR8wgljcrUYzxTPkSjfm6QjGaZ/wbPXGrY/CGzc6Y/X3eBdvFdBP4ZnT6WPerEFCF28FamsuJdFARvSxIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwWSJiCI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e59dadebso5942631e87.0;
        Mon, 28 Oct 2024 23:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730183693; x=1730788493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7lWcMDGFyPr0tPj1+w5lqRWcRyFwcQQ9skKFiNTRgo=;
        b=PwWSJiCIL9Fz7mwa4yhYmOVnnaFF/YRrfMzU5RydW35zxpCjfuU7fZmGqffBnXdqw8
         +7lP2dL7MFmne8RHwqrtXb2zK7t2EJV3lzqzmq6roqnqE14BieVwLT0T/Yg+THRYi2zu
         ztXzNCMrDszt43ms+WpCCKZ1mtbGbelaC4M3PGy+lJVmgys4FXnHZQVYl27i0SMuj12n
         p7qrJ4ymzfpAEKc2Dw7NDJzLNPkrlPHeVNl6hSAdqbARCPniao1Bpz2a0OZ0QJGxCS4P
         FXJU+7hJh75X3NGVAx9D7TBd8PMuqjaR5DgkGBEMVzuxPwosMr7AHVXiQetVRfYxqLHE
         teBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730183693; x=1730788493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7lWcMDGFyPr0tPj1+w5lqRWcRyFwcQQ9skKFiNTRgo=;
        b=nEPkBXNQDOgkxYNOnyyjO1Wr69wm2sRKbWfZ/xHe7552umFIaYiVp9h98QKiZ5yAkH
         BF3ubWkdc4QIyGI6mKv/0xImWiKAgN3zMKsMZ8QdVyCVNJpdHelOLKySHR+FAzQWckI0
         Edt4tKGiV5hkZF0xf0e+IHZ9EqQiTgUt46hvsMntslFuZOP6W4yemQ0Tk/CTuy9XgVOa
         CYs9wFyGY9G1VGltvigH7/7/pSvnJntTtr0u3tQvwoYoLeqMNhnNVwrP6namE4hq2mR3
         dbmu3TNTy2WafE0IgLluyKU/B5cBE1mYiMWoWD4h+JAC99fDS7hSRf1Ip94oKpyqG8ON
         zrow==
X-Forwarded-Encrypted: i=1; AJvYcCXVgqqhBMeDwaCNm7yfHA40/m1Vio76kidFwZTrT+gw5nj3VsHhFVvlyNKB9yUECFeyo/3iNcf03AJJZT6n@vger.kernel.org, AJvYcCXxloQmakzt4wII7zxpBbZqufzfjQvzu56BtiMTdx1SPGrVqhcxYeHr65JGqk3OXKnU2gQqgIRQ88Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyysViZtJb7RS+ZOXqGZ3eA/5YL4l9klo5kq1zEmlfIJHy+Mhmc
	D6FYiHhrcdcOSHU/7dsUgMyMHoutU2Zz7YPppPs0X6BcTL5ahSvdWI3Pb/8r
X-Google-Smtp-Source: AGHT+IHeIl7D20nNjh7KL0gDsAUCF23pvJQWxOjbznPcnRgY55HUeE7wmGFkWsncyod3M/jyWWARbA==
X-Received: by 2002:a05:6512:684:b0:539:ffb5:8d2c with SMTP id 2adb3069b0e04-53b3490f2eemr4596597e87.30.1730183692306;
        Mon, 28 Oct 2024 23:34:52 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a8f0sm1280136e87.15.2024.10.28.23.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 23:34:51 -0700 (PDT)
Message-ID: <a72e0950-be11-45a3-8387-5b51b9a2e78a@gmail.com>
Date: Tue, 29 Oct 2024 08:34:48 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/24] iio: Clean up acpi_match_device() use cases
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/10/2024 22:04, Andy Shevchenko wrote:
> There are current uses of acpi_match_device():
> - as strange way of checking if the device was enumerated via ACPI
> - as a way to get IIO device name as ACPI device instance name
> - as above with accompanying driver data
> 
> Deduplicate its use by providing two new helper functions in IIO ACPI
> library and update the rest accordingly.
> 
> This also includes a rework of previously sent ltr501 patch.
> 
> Besides that there ie a big clean up for the kxcjk-1013 driver, started
> with the revert of the one patch discussed earlier today. Feel free to
> route that one via fixes branch of your tree.
> 
> In v3:
> - collected tags (Marius)
> - added note to the documentation about usage of new API (Jonathan)
> - added a handful patches for kxcjk-1013 driver
> 
> In v2:
> - collected tags (Hans, Jean-Baptiste)
> - updated SoB chain in patch 4
> 
> Andy Shevchenko (24):
>    iio: magnetometer: bmc150: Drop dead code from the driver
>    iio: adc: pac1934: Replace strange way of checking type of enumeration
>    iio: imu: inv_mpu6050: Replace strange way of checking type of
>      enumeration
>    iio: acpi: Improve iio_read_acpi_mount_matrix()
>    iio: acpi: Add iio_get_acpi_device_name_and_data() helper function
>    iio: accel: kxcjk-1013: Remove redundant I²C ID
>    iio: accel: kxcjk-1013: Revert "Add support for KX022-1020"
>    iio: accel: kxcjk-1013: Switch from CONFIG_PM guards to pm_ptr() etc
>    iio: accel: kxcjk-1013: Use local variable for regs
>    iio: accel: kxcjk-1013: Rename kxcjk1013_info
>    iio: accel: kxcjk-1013: Start using chip_info variables instead of
>      enum
>    iio: accel: kxcjk-1013: Move odr_start_up_times up in the code
>    iio: accel: kxcjk-1013: Convert ODR times array to variable in
>      chip_info
>    iio: accel: kxcjk-1013: Get rid of enum kx_chipset
>    iio: accel: kxcjk-1013: Replace a variant of
>      iio_get_acpi_device_name_and_data()
>    iio: accel: kxcjk-1013: drop ACPI_PTR() and move ID out of CONFIG_ACPI
>      guards

I missed reviewing these kxcjk changes. Not sure I loved all of them but 
I must admit the resulting code is looks better in general.

Thanks for the clean-up Andy!

Yours,
	-- Matti

