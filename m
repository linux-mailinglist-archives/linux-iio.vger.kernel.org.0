Return-Path: <linux-iio+bounces-17975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2C7A864DC
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 19:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3947A4605BC
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 17:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36369239565;
	Fri, 11 Apr 2025 17:36:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C6323A9A0;
	Fri, 11 Apr 2025 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392983; cv=none; b=LJ7AfAa3VMOnIluj8HadHKKPrScLJ1CK5/2+tGsZwTbVhEfAJYWy43uRH0jkYlvXZomCwxzBgQeYRrYLBfyf6leNJHk5zqoV0t1DprmiNtBFE4rGWmrok/B45BPWeiK0/ODh6znsKkru4Ukr/wvZLyc9K43WXEEmoAw0nm6IRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392983; c=relaxed/simple;
	bh=RrQmy/7o+Lvxl/t4l7CT1gzLGDDGt209WtpOumTSV00=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdkXsSMYZFcho5WttZ0Di+C+j4EeTTpOaW9qo8QToG/upOFkNKiXtMYgYorW2C8yFEvgD/QeZ30VgKfw3aQc76b6/YktQqXwAJf+GP/njzP1vsjxeGlZFEKJCao1t8e+ksa+Fip+9dAINY/g1eFT8K6zqsEtCyn9Mjl3eWosq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZZ3f821gxz6K9X0;
	Sat, 12 Apr 2025 01:32:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D77C81402F7;
	Sat, 12 Apr 2025 01:36:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Apr
 2025 19:36:16 +0200
Date: Fri, 11 Apr 2025 18:36:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
CC: <remi.buisson@tdk.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH 6/8] iio: imu: add Kconfig and Makefile for inv_icm45600
 driver
Message-ID: <20250411183614.00002382@huawei.com>
In-Reply-To: <20250411-add_newport_driver-v1-6-15082160b019@tdk.com>
References: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
	<20250411-add_newport_driver-v1-6-15082160b019@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Apr 2025 13:28:38 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Add 4 modules:
> - inv-icm45600
> - inv-icm45600-i2c
> - inv-icm45600-spi
> - inv-icm45600-i3c.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>

Hi Remi,

One quick comment.  A driver should be structured to build fully
after each patch.  That means the makefile and kconfig should be introduced
in patch 1 of the series. Obviously more stuff will be added as you go
along.

If someone just wants to pick up the patches for the core and one bus
they should be able to do so and expect that to work.

Some other areas of the kernel are more flexible on this than I am
but for IIO at least that's they way we have always done things
and I'm not keen to change it.  It means that we know everything
we need to review each step in sequence is there as otherwise it
would not build.

It does mean that you need to build test each additional patch
whenever you do a new version to be sure that the series will be
fine for a bisection build. 

The exception of 'hidden' library modules like the core one here
that won't get built until someone selects them from another kconfig
symbol is fine though.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/Kconfig               |  1 +
>  drivers/iio/imu/Makefile              |  1 +
>  drivers/iio/imu/inv_icm45600/Kconfig  | 70 +++++++++++++++++++++++++++++++++++
>  drivers/iio/imu/inv_icm45600/Makefile | 17 +++++++++
>  4 files changed, 89 insertions(+)
> 
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> index 15612f0f189b5114deb414ef840339678abdc562..9d732bed9fcdac12a13713dba3455c1fdf9f4a53 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -109,6 +109,7 @@ config KMX61
>  	  be called kmx61.
>  
>  source "drivers/iio/imu/inv_icm42600/Kconfig"
> +source "drivers/iio/imu/inv_icm45600/Kconfig"
>  source "drivers/iio/imu/inv_mpu6050/Kconfig"
>  
>  config SMI240
> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
> index e901aea498d37e5897e8b71268356a19eac2cb59..2ae6344f84699b2f85fff1c8077cb412f6ae2658 100644
> --- a/drivers/iio/imu/Makefile
> +++ b/drivers/iio/imu/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_FXOS8700_I2C) += fxos8700_i2c.o
>  obj-$(CONFIG_FXOS8700_SPI) += fxos8700_spi.o
>  
>  obj-y += inv_icm42600/
> +obj-y += inv_icm45600/
>  obj-y += inv_mpu6050/
>  
>  obj-$(CONFIG_KMX61) += kmx61.o
> diff --git a/drivers/iio/imu/inv_icm45600/Kconfig b/drivers/iio/imu/inv_icm45600/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..4fade8852a0dcf54df2bbd67b9269ed2c59f8699
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/Kconfig
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +config INV_ICM45600
> +	tristate
> +	select IIO_BUFFER
> +	select IIO_KFIFO_BUF
> +	select IIO_INV_SENSORS_TIMESTAMP
> +
> +config INV_ICM45600_I2C
> +	tristate "InvenSense ICM-456xx I2C driver"
> +	depends on I2C
> +	select INV_ICM45600
> +	select REGMAP_I2C
> +	help
> +	  This driver supports the InvenSense ICM-456xx motion tracking
> +	  devices over I2C.
> +	  Supported devices:
> +	  - ICM-45605
> +	  - ICM-45686
> +	  - ICM-45688-P
> +	  - ICM-45608
> +	  - ICM-45634
> +	  - ICM-45689
> +	  - ICM-45606
> +	  - ICM-45687
> +
> +	  This driver can be built as a module. The module will be called
> +	  inv-icm45600-i2c.
> +
> +config INV_ICM45600_SPI
> +	tristate "InvenSense ICM-456xx SPI driver"
> +	depends on SPI_MASTER
> +	select INV_ICM45600
> +	select REGMAP_SPI
> +	help
> +	  This driver supports the InvenSense ICM-456xx motion tracking
> +	  devices over SPI.
> +	  Supported devices:
> +	  - ICM-45605
> +	  - ICM-45686
> +	  - ICM-45688-P
> +	  - ICM-45608
> +	  - ICM-45634
> +	  - ICM-45689
> +	  - ICM-45606
> +	  - ICM-45687
> +
> +	  This driver can be built as a module. The module will be called
> +	  inv-icm45600-spi.
> +
> +config INV_ICM45600_I3C
> +	tristate "InvenSense ICM-456xx I3C driver"
> +	depends on I3C
> +	select INV_ICM45600
> +	select REGMAP_I3C
> +	help
> +	  This driver supports the InvenSense ICM-456xx motion tracking
> +	  devices over I3C.
> +	  Supported devices:
> +	  - ICM-45605
> +	  - ICM-45686
> +	  - ICM-45688-P
> +	  - ICM-45608
> +	  - ICM-45634
> +	  - ICM-45689
> +	  - ICM-45606
> +	  - ICM-45687
> +
> +	  This driver can be built as a module. The module will be called
> +	  inv-icm45600-i3c.
> diff --git a/drivers/iio/imu/inv_icm45600/Makefile b/drivers/iio/imu/inv_icm45600/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..0fd6fbce0286f24504dbfe71925f9c35e717c446
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/Makefile
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +obj-$(CONFIG_INV_ICM45600) += inv-icm45600.o
> +inv-icm45600-y += inv_icm45600_core.o
> +inv-icm45600-y += inv_icm45600_gyro.o
> +inv-icm45600-y += inv_icm45600_accel.o
> +inv-icm45600-y += inv_icm45600_temp.o
> +inv-icm45600-y += inv_icm45600_buffer.o
> +
> +obj-$(CONFIG_INV_ICM45600_I2C) += inv-icm45600-i2c.o
> +inv-icm45600-i2c-y += inv_icm45600_i2c.o
> +
> +obj-$(CONFIG_INV_ICM45600_SPI) += inv-icm45600-spi.o
> +inv-icm45600-spi-y += inv_icm45600_spi.o
> +
> +obj-$(CONFIG_INV_ICM45600_I3C) += inv-icm45600-i3c.o
> +inv-icm45600-i3c-y += inv_icm45600_i3c.o
> 


