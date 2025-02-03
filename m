Return-Path: <linux-iio+bounces-14907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C52A257FC
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 12:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017D0160F38
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 11:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5395F202C4F;
	Mon,  3 Feb 2025 11:19:57 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D162A1A4;
	Mon,  3 Feb 2025 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738581597; cv=none; b=QWDHnJGf8ObC7UDr7BlxY5d/AIQ53Mr+7Za3ehakr2cfCP7Q7fgwr3yZypcfbXKyULdfRPaujPHUWjHci+DzUYzLCDEhCtrw8l0qbxPHb42cd6Je5ahZ/0FFDDGqCUOptYzJjYP2vbNwCpGWLmJuvZennc1a+zEutkb9+MrJcB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738581597; c=relaxed/simple;
	bh=ZVRvgWsfvODU6Nzt/A5cjd5bh6rvxFxXYbmzsiYUAx8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JspvmPeImPoBPzsnd8n8BvekhTPPvzqt4XXQt4hvO0zxjTZ+JqtfJT8UHhcBxE2R/GMECx34anmz//33bEga3ZEbGFuYOgWodNq2/RYn5qUkQkxHClWYh7Yge1WEk3iYOqtDKMcIwlGK8yEy4lL0lSjFUOC/as/CCD4EWNJxwcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YmkVp4s9fz6M4S5;
	Mon,  3 Feb 2025 19:17:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5650414011B;
	Mon,  3 Feb 2025 19:19:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 12:19:50 +0100
Date: Mon, 3 Feb 2025 11:19:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Raag Jadav <raag.jadav@intel.com>
CC: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<linus.walleij@linaro.org>, <mika.westerberg@linux.intel.com>,
	<andriy.shevchenko@linux.intel.com>, <dmitry.torokhov@gmail.com>,
	<lgirdwood@gmail.com>, <broonie@kernel.org>, <sre@kernel.org>,
	<jic23@kernel.org>, <przemyslaw.kitszel@intel.com>,
	<linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-input@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 02/20] iio: imu: st_lsm9ds0: Replace device.h with
 what is needed
Message-ID: <20250203111949.00002fa7@huawei.com>
In-Reply-To: <20250203080902.1864382-3-raag.jadav@intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
	<20250203080902.1864382-3-raag.jadav@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon,  3 Feb 2025 13:38:44 +0530
Raag Jadav <raag.jadav@intel.com> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Instead of including a huge device.h with tons of dependencies
> include only what driver actually uses.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
I'm fine with these going whatever route makes sense.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c | 2 +-
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
> index 0732cfa258c4..8cc071463249 100644
> --- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
> +++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
> @@ -7,7 +7,7 @@
>   * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>   */
>  
> -#include <linux/device.h>
> +#include <linux/device/devres.h>
>  #include <linux/err.h>
>  #include <linux/gfp_types.h>
>  #include <linux/i2c.h>
> diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
> index 43ec57c1e604..806e55f75f65 100644
> --- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
> +++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
> @@ -7,7 +7,7 @@
>   * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>   */
>  
> -#include <linux/device.h>
> +#include <linux/device/devres.h>
>  #include <linux/err.h>
>  #include <linux/gfp_types.h>
>  #include <linux/module.h>


