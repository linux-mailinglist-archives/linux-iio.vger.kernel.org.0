Return-Path: <linux-iio+bounces-17589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44AFA79D80
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 09:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89713B6B2E
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 07:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5600A24113A;
	Thu,  3 Apr 2025 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bonBzEVS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D561A23B9;
	Thu,  3 Apr 2025 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743666985; cv=none; b=DUnITqdE8/inz9iYcrP5BZVSs4arfmcz6J05TRE/V8+npyZhV0zrb0anxo+yYCWC+OQoJe+7GrVCrg2shUD7+/RLk9OP+NJCILtu0Rs3XcVDxOtOqRAZh1s13y4c8rlBrNjBgaLDczTZAvjp7p+Q0i6KNXcGe0qRnivch0c1/YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743666985; c=relaxed/simple;
	bh=cVRFaKCtW9EkxwJD2YpJ360jCAHaYC2eciW066lxdFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYwohDRKon6kXd49lwvWXctJzwuCwzg2w9XZsf0fU7b5wNHHkZwadUZ2gMd3I/h7z+FkQL2SihbRCFenPk9Sw1Fimp80Q5OpH9BJz7siPIF7n08+rFGxTXPmJC7RlHMBE8defxqG3VGnuKL6Y8LZYL47g3hhYRjlPSW/eWkhCG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bonBzEVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6476C4CEE3;
	Thu,  3 Apr 2025 07:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743666984;
	bh=cVRFaKCtW9EkxwJD2YpJ360jCAHaYC2eciW066lxdFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bonBzEVSVoBnVEgQWRYoKgknAKOUDADEaP47hbMlx+5WcwMJ649KOoRA2gk3LfZoA
	 5mDLoNayTSzruS4RnCJFX6Ujgwvo62L0hdP/0g9S3YpTiSPU81tJLXKrO2EXWXVu37
	 l1bE3BG6FYS2485SguDHiPVsoo34iO59KPXVQH5yKXTqtq4TQ8+SezxnXz850RctYf
	 2QnQJSmCmSYMjolKn9vEdjuKgzi7qka6xsGa6Z7+jfAHaL0zywqQM4WwMuYoFmlDh0
	 4EnItzhew47vLwDaN/I2385VP1S5sp43OrY1TqWH4kI2FC1H4D0FhaX9dN0YQ26Phh
	 yzxNM/UsKwxBQ==
Message-ID: <28f4a7e5-ff96-4c7f-9eab-6bf358f19007@kernel.org>
Date: Thu, 3 Apr 2025 09:56:18 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] iio: chemical: add support for winsen MHZ19B CO2
 sensor
To: Gyeyoung Baek <gye976@gmail.com>, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, lars@metafoo.de,
 gustavograzs@gmail.com, javier.carrasco.cruz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
References: <20250403053225.298308-1-gye976@gmail.com>
 <20250403053225.298308-5-gye976@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250403053225.298308-5-gye976@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2025 07:32, Gyeyoung Baek wrote:
> Add support for winsen MHZ19B CO2 sensor.
> 
> Datasheet:
> https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf
> 
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> ---
>  drivers/iio/chemical/Kconfig  |  10 +
>  drivers/iio/chemical/Makefile |   1 +
>  drivers/iio/chemical/mhz19b.c | 386 ++++++++++++++++++++++++++++++++++
>  3 files changed, 397 insertions(+)
>  create mode 100644 drivers/iio/chemical/mhz19b.c
> 
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index 330fe0af946f..bb4dfe3986f6 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -108,6 +108,16 @@ config IAQCORE
>  	  iAQ-Core Continuous/Pulsed VOC (Volatile Organic Compounds)
>  	  sensors
> 
> +config MHZ19B

probably WINSEN_MHZ19B

> +	tristate "MHZ19B CO2 sensor"

Similarly here

> +	depends on SERIAL_DEV_BUS
> +	help
> +	  Say Y here to build Serdev binterface support for the MHZ19B

Typo, interface

> +	  CO2 sensor.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called mhz19b.
> +
>  config PMS7003
>  	tristate "Plantower PMS7003 particulate matter sensor"
>  	depends on SERIAL_DEV_BUS
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> index 4866db06bdc9..c63daebf39ac 100644
> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_ENS160) += ens160_core.o
>  obj-$(CONFIG_ENS160_I2C) += ens160_i2c.o
>  obj-$(CONFIG_ENS160_SPI) += ens160_spi.o
>  obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
> +obj-$(CONFIG_MHZ19B) += mhz19b.o
>  obj-$(CONFIG_PMS7003) += pms7003.o
>  obj-$(CONFIG_SCD30_CORE) += scd30_core.o
>  obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
> diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
> new file mode 100644
> index 000000000000..f8f06c01623f
> --- /dev/null
> +++ b/drivers/iio/chemical/mhz19b.c
> @@ -0,0 +1,386 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mh-z19b co2 sensor driver
> + *
> + * Copyright (c) 2025 Gyeyoung Baek <gye976@gmail.com>
> + *
> + * Datasheet:
> + * https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf
> + *
> + * TODO:
> + *  - vin supply regulator
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/serdev.h>
> +#include <linux/unaligned.h>
> +
> +struct mhz19b_state {
> +	struct serdev_device *serdev;
> +
> +	/* TO DO, nothing for now.*/
> +	struct regulator *vin_supply;

Drop. Don't add dead code.

> +
> +	/* serdev receive buffer.
> +	 * When data is received from the MH-Z19B,
> +	 * the 'mhz19b_receive_buf' callback function is called and fills this buffer.
> +	 */
> +	char buf[9];
> +	int buf_idx;
> +
> +	/* must wait the 'buf' is filled with 9 bytes.*/
> +	struct completion buf_ready;
> +
> +	/* protect access to mhz19b_state */
> +	struct mutex lock;

mhz19b_receive_buf() does not need any locking?


Best regards,
Krzysztof

