Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055A172163F
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jun 2023 12:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjFDK6t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jun 2023 06:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjFDK6t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jun 2023 06:58:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8165DCA
        for <linux-iio@vger.kernel.org>; Sun,  4 Jun 2023 03:58:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14B0A60D24
        for <linux-iio@vger.kernel.org>; Sun,  4 Jun 2023 10:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B270EC433EF;
        Sun,  4 Jun 2023 10:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685876326;
        bh=hQdQXgyjf8Pr3JA4xQbqtKUyQ122m6jlsJMyBFQXMl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sYeyV2pcwy7D/v6LK09cK4pz8NHX7jrJhSZGrjI86fRipupchPG+SE2bjAuapWKWB
         sZVD+ZtUB3P2Y6w84KUqY9Mx6bsYd6xE7M4HIKqi76zE9WYxbggdKNKjlyFh2XAQnu
         kw9MvO95fY0Qc3VHvAm0pJ817ZTB6+QmgHBUvgNaEudqxQHQfHN40USz1yZ5wY12Ps
         hPvwSAhlO2fCzHpwj0n/Rvl8N59yacDoGO0TRTue9x5QjMNfhX2revz0mSaJu2Gs/z
         oJDpgcLb8+P1R056tNnarSz7KvdOE8MJp5L2sqEZqBg5+WN/sSv5RREUenCJKlOoCZ
         exL+eerqoP6ww==
Date:   Sun, 4 Jun 2023 11:58:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     inv.git-commit@tdk.com
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 2/4] iio: move inv_icm42600 timestamp module in common
Message-ID: <20230604115843.5f887bb4@jic23-huawei>
In-Reply-To: <20230531142513.48507-3-inv.git-commit@tdk.com>
References: <20230531142513.48507-1-inv.git-commit@tdk.com>
        <20230531142513.48507-3-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 31 May 2023 14:25:11 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Create new inv_sensors common modules and move inv_icm42600
> timestamp module inside.
> Modify inv_icm42600 driver to use timestamp module.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Hi Jean-Baptiste,

Any plan to use this outside of IMU drivers?  If not I'd be tempted
to keep it more local.

drivers/iio/imu/inv_common/ or similar and avoid the global
header by using a "../inv_common/" include path.

Changes themselves look fine to me.

Jonathan

> ---
>  drivers/iio/common/Kconfig                           |  1 +
>  drivers/iio/common/Makefile                          |  1 +
>  drivers/iio/common/inv_sensors/Kconfig               |  7 +++++++
>  drivers/iio/common/inv_sensors/Makefile              |  6 ++++++
>  .../inv_sensors}/inv_icm42600_timestamp.c            | 12 ++++++++++--
>  drivers/iio/imu/inv_icm42600/Kconfig                 |  1 +
>  drivers/iio/imu/inv_icm42600/Makefile                |  1 -
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c    |  2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c   |  2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c     |  3 ++-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c     |  2 +-
>  .../linux/iio/common}/inv_icm42600_timestamp.h       |  0
>  12 files changed, 31 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/iio/common/inv_sensors/Kconfig
>  create mode 100644 drivers/iio/common/inv_sensors/Makefile
>  rename drivers/iio/{imu/inv_icm42600 => common/inv_sensors}/inv_icm42600_timestamp.c (91%)
>  rename {drivers/iio/imu/inv_icm42600 => include/linux/iio/common}/inv_icm42600_timestamp.h (100%)
> 
> diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
> index 0334b4954773..1ccb5ccf3706 100644
> --- a/drivers/iio/common/Kconfig
> +++ b/drivers/iio/common/Kconfig
> @@ -5,6 +5,7 @@
>  
>  source "drivers/iio/common/cros_ec_sensors/Kconfig"
>  source "drivers/iio/common/hid-sensors/Kconfig"
> +source "drivers/iio/common/inv_sensors/Kconfig"
>  source "drivers/iio/common/ms_sensors/Kconfig"
>  source "drivers/iio/common/scmi_sensors/Kconfig"
>  source "drivers/iio/common/ssp_sensors/Kconfig"
> diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile
> index fad40e1e1718..d3e952239a62 100644
> --- a/drivers/iio/common/Makefile
> +++ b/drivers/iio/common/Makefile
> @@ -10,6 +10,7 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-y += cros_ec_sensors/
>  obj-y += hid-sensors/
> +obj-y += inv_sensors/
>  obj-y += ms_sensors/
>  obj-y += scmi_sensors/
>  obj-y += ssp_sensors/
> diff --git a/drivers/iio/common/inv_sensors/Kconfig b/drivers/iio/common/inv_sensors/Kconfig
> new file mode 100644
> index 000000000000..28815fb43157
> --- /dev/null
> +++ b/drivers/iio/common/inv_sensors/Kconfig
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TDK-InvenSense sensors common library
> +#
> +
> +config IIO_INV_SENSORS_TIMESTAMP
> +	tristate
> diff --git a/drivers/iio/common/inv_sensors/Makefile b/drivers/iio/common/inv_sensors/Makefile
> new file mode 100644
> index 000000000000..93bddb9356b8
> --- /dev/null
> +++ b/drivers/iio/common/inv_sensors/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for TDK-InvenSense sensors module.
> +#
> +
> +obj-$(CONFIG_IIO_INV_SENSORS_TIMESTAMP) += inv_icm42600_timestamp.o
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
> similarity index 91%
> rename from drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
> rename to drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
> index ceae8ccb1747..411f561e1a24 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
> +++ b/drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
> @@ -5,9 +5,9 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/math64.h>
> +#include <linux/module.h>
>  #include <linux/errno.h>
> -
> -#include "inv_icm42600_timestamp.h"
> +#include <linux/iio/common/inv_icm42600_timestamp.h>
>  
>  /* internal chip period is 32kHz, 31250ns */
>  #define INV_ICM42600_TIMESTAMP_PERIOD		31250
> @@ -54,6 +54,7 @@ void inv_icm42600_timestamp_init(struct inv_icm42600_timestamp *ts,
>  	/* use theoretical value for chip period */
>  	inv_update_acc(&ts->chip_period, INV_ICM42600_TIMESTAMP_PERIOD);
>  }
> +EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_init, IIO_INV_SENSORS_TIMESTAMP);
>  
>  int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
>  				      uint32_t period, bool fifo)
> @@ -66,6 +67,7 @@ int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_update_odr, IIO_INV_SENSORS_TIMESTAMP);
>  
>  static bool inv_validate_period(uint32_t period, uint32_t mult)
>  {
> @@ -153,6 +155,7 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
>  	if (valid)
>  		inv_align_timestamp_it(ts);
>  }
> +EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_interrupt, IIO_INV_SENSORS_TIMESTAMP);
>  
>  void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
>  				      uint32_t fifo_period, size_t fifo_nb,
> @@ -184,3 +187,8 @@ void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
>  		ts->timestamp = ts->it.up - interval;
>  	}
>  }
> +EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_apply_odr, IIO_INV_SENSORS_TIMESTAMP);
> +
> +MODULE_AUTHOR("InvenSense, Inc.");
> +MODULE_DESCRIPTION("InvenSense sensors timestamp module");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/imu/inv_icm42600/Kconfig b/drivers/iio/imu/inv_icm42600/Kconfig
> index 50cbcfcb6cf1..f56b0816cc4d 100644
> --- a/drivers/iio/imu/inv_icm42600/Kconfig
> +++ b/drivers/iio/imu/inv_icm42600/Kconfig
> @@ -3,6 +3,7 @@
>  config INV_ICM42600
>  	tristate
>  	select IIO_BUFFER
> +	select IIO_INV_SENSORS_TIMESTAMP
>  
>  config INV_ICM42600_I2C
>  	tristate "InvenSense ICM-426xx I2C driver"
> diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/inv_icm42600/Makefile
> index 291714d9aa54..0f49f6df3647 100644
> --- a/drivers/iio/imu/inv_icm42600/Makefile
> +++ b/drivers/iio/imu/inv_icm42600/Makefile
> @@ -6,7 +6,6 @@ inv-icm42600-y += inv_icm42600_gyro.o
>  inv-icm42600-y += inv_icm42600_accel.o
>  inv-icm42600-y += inv_icm42600_temp.o
>  inv-icm42600-y += inv_icm42600_buffer.o
> -inv-icm42600-y += inv_icm42600_timestamp.o
>  
>  obj-$(CONFIG_INV_ICM42600_I2C) += inv-icm42600-i2c.o
>  inv-icm42600-i2c-y += inv_icm42600_i2c.o
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> index c3f433ad3af6..1015de636a94 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> @@ -12,12 +12,12 @@
>  #include <linux/math64.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/common/inv_icm42600_timestamp.h>
>  #include <linux/iio/kfifo_buf.h>
>  
>  #include "inv_icm42600.h"
>  #include "inv_icm42600_temp.h"
>  #include "inv_icm42600_buffer.h"
> -#include "inv_icm42600_timestamp.h"
>  
>  #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)		\
>  	{								\
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> index 32d7f8364230..4a39d31e911f 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> @@ -11,9 +11,9 @@
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/common/inv_icm42600_timestamp.h>
>  
>  #include "inv_icm42600.h"
> -#include "inv_icm42600_timestamp.h"
>  #include "inv_icm42600_buffer.h"
>  
>  /* FIFO header: 1 byte */
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index c34735b05830..f3e379f9733d 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -16,10 +16,10 @@
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/common/inv_icm42600_timestamp.h>
>  
>  #include "inv_icm42600.h"
>  #include "inv_icm42600_buffer.h"
> -#include "inv_icm42600_timestamp.h"
>  
>  static const struct regmap_range_cfg inv_icm42600_regmap_ranges[] = {
>  	{
> @@ -799,3 +799,4 @@ EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42600_pm_ops, IIO_ICM42600) = {
>  MODULE_AUTHOR("InvenSense, Inc.");
>  MODULE_DESCRIPTION("InvenSense ICM-426xx device driver");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_INV_SENSORS_TIMESTAMP);
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> index 9d94a8518e3c..6caea7b8a344 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> @@ -12,12 +12,12 @@
>  #include <linux/math64.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/common/inv_icm42600_timestamp.h>
>  #include <linux/iio/kfifo_buf.h>
>  
>  #include "inv_icm42600.h"
>  #include "inv_icm42600_temp.h"
>  #include "inv_icm42600_buffer.h"
> -#include "inv_icm42600_timestamp.h"
>  
>  #define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)		\
>  	{								\
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h b/include/linux/iio/common/inv_icm42600_timestamp.h
> similarity index 100%
> rename from drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
> rename to include/linux/iio/common/inv_icm42600_timestamp.h

