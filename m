Return-Path: <linux-iio+bounces-23954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C828EB51F8D
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 960AC7BAC95
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 17:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CAE3314CB;
	Wed, 10 Sep 2025 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWYhE8FX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A8261B83;
	Wed, 10 Sep 2025 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527015; cv=none; b=fCzw++pBnWHFTiuGWHzEahVfkf4IaCAj99UkG7WkpCeiRUaKhguryzjIL6mjUQtyIyr0f8r/vwI2NwfaKei47CoFLplGrrpF1Di9PvSy7UP/lbvMXHrPspUD93UWs1BAh6HmdQicWMVg1zUkj/6ocvIkCeDs9FgpPBLnkjXv+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527015; c=relaxed/simple;
	bh=vN4Yt6jpF3qKancQU7aKyG1uRND8K/9lTEa1JQc74zU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gf9vDbLgqyx/x80wcZKWpE1pJP1iy6qxwPUN7mGvMceAalGfX+iykIhhTyM5xOGcjm5NK8FKJ5OQXwslMayHTcfEV5MAq7qHPtn1v06VQU+vSG36xjWhM7vhLVXdGsBdT3eW/DH7SSkmE6qbRxpr4ZbmtTKn5Lvo0BWcsHuyJa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWYhE8FX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6F9C4CEEB;
	Wed, 10 Sep 2025 17:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757527014;
	bh=vN4Yt6jpF3qKancQU7aKyG1uRND8K/9lTEa1JQc74zU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XWYhE8FXEzb22dYz42RegT6sHQAQq06Gaqs65ayhrBgtO6YV/8yH1WomoBgi7kisK
	 zwPtgJLEEp7fez+VuIQJAvpiSrbM2ZIn9xxkc5o6gfvNWHt4btp6X44otcJMlaqGyA
	 VqBI3v8+OYfvdpI/obCpFmOS+KVj3IlFE0tWEKhzZmwwOwuKbpziTlRs8SHqa9cskc
	 B9/6QGPiMqlccY8yz9kz9JRlgiF8oJPwnsHa/kQ3hgH+nkGdjQpEse0yQI0ldMJeOo
	 wNJySxlIT/eNvCqOvEZ/kEJ2yMWXCVv9KVlfeZz2fxvPK74WWeRjVGEp96MkHpFIWH
	 5tkOq5ZUw8xTg==
Date: Wed, 10 Sep 2025 18:56:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/14] iio: accel: bma220: split original driver
Message-ID: <20250910185646.7b62133f@jic23-huawei>
In-Reply-To: <20250910-bma220_improvements-v2-4-e23f4f2b9745@subdimension.ro>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
	<20250910-bma220_improvements-v2-4-e23f4f2b9745@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 10:57:09 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> In preparation for the i2c module, move the original code into multiple
> source files without any other functional change.

I'd add a note here that you are not even making the interfaces
bus type independent as you are doing that in later regmap patch.
Feels odd to have spi calls in common code!

> 
> Create the additional bma220_core module.
> Fix checkpatch warning about GPL v2 license in bma220_spi.c.

Also mention fixing a few includes in bma220_spi.c whilst you
were here.

A few really trivial comments.

> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> Changes:
> - split out open firmware table modification into separate patch
> - bma220_write_raw() exits without dev_err() based on similar feedback
>   from David
> - change includes in bma220.h
> - include bma220.h in bma220_core.c
> - add mutex.h and pm.h includes to bma220_core.c
> - cleanup struct spacing in bma220_spi.c
> ---
>  drivers/iio/accel/Kconfig       |   9 +-
>  drivers/iio/accel/Makefile      |   3 +-
>  drivers/iio/accel/bma220.h      |  19 +++
>  drivers/iio/accel/bma220_core.c | 313 ++++++++++++++++++++++++++++++++++++++++
>  drivers/iio/accel/bma220_spi.c  | 307 ++-------------------------------------
>  5 files changed, 354 insertions(+), 297 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 8c3f7cf55d5fa432a4d4662b184a46cd59c3ebca..2cc3075e26883df60b5068c73b0551e1dd02c32e 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -218,15 +218,20 @@ config BMA180
>  
>  config BMA220
>  	tristate "Bosch BMA220 3-Axis Accelerometer Driver"
> -	depends on SPI
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> +	select BMA220_SPI if SPI
>  	help
>  	  Say yes here to add support for the Bosch BMA220 triaxial
>  	  acceleration sensor.
>  
>  	  To compile this driver as a module, choose M here: the
> -	  module will be called bma220_spi.
> +	  module will be called bma220_core and you will also get
> +	  bma220_spi if SPI is enabled.
> +
> +config BMA220_SPI
> +	tristate
> +	depends on BMA220
>  
>  config BMA400
>  	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index ca8569e25aba31c3ae3437abf8506addbf5edffa..56a9f848f7f913633bc2a628c1ac5c9190774b9d 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -25,7 +25,8 @@ obj-$(CONFIG_ADXL380) += adxl380.o
>  obj-$(CONFIG_ADXL380_I2C) += adxl380_i2c.o
>  obj-$(CONFIG_ADXL380_SPI) += adxl380_spi.o
>  obj-$(CONFIG_BMA180) += bma180.o
> -obj-$(CONFIG_BMA220) += bma220_spi.o
> +obj-$(CONFIG_BMA220) += bma220_core.o
> +obj-$(CONFIG_BMA220_SPI) += bma220_spi.o
>  obj-$(CONFIG_BMA400) += bma400_core.o
>  obj-$(CONFIG_BMA400_I2C) += bma400_i2c.o
>  obj-$(CONFIG_BMA400_SPI) += bma400_spi.o
> diff --git a/drivers/iio/accel/bma220.h b/drivers/iio/accel/bma220.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..eb311183ebfe37d1a75d858d435eac777efc4ed8
> --- /dev/null
> +++ b/drivers/iio/accel/bma220.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Forward declarations needed by the bma220 sources.
> + *
> + * Copyright 2025 Petre Rodan <petre.rodan@subdimension.ro>
> + */
> +
> +#ifndef _BMA220_H
> +#define _BMA220_H
> +
> +#include <linux/pm.h>
> +#include <linux/spi/spi.h>

Don't need spi.h here. The forward declaration of spi_device
deals with only reason it would otherwise be needed.

> +
> +extern const struct dev_pm_ops bma220_pm_ops;
> +struct spi_device;
> +
> +int bma220_common_probe(struct spi_device *dev);
> +
> +#endif
> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..6bc2e5c3fb6cebd50209acbcc2d5340630c27cd1
> --- /dev/null
> +++ b/drivers/iio/accel/bma220_core.c

> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> index 01592eebf05bb6b002d44c41cca1d2dd5f28350c..3ad5e43aae496d265a8cf198595bf824f8e73692 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -5,326 +5,45 @@
>   * Copyright (c) 2016,2020 Intel Corporation.
>   */
>  
> -#include <linux/bits.h>
> -#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>

As mentioned above, these additions are good but I think not strictly
related to rest of the change.  That's fine. Just mention them in the commit description

>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/spi/spi.h>
>

