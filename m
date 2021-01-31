Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28302309C4A
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jan 2021 14:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhAaNBG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 31 Jan 2021 08:01:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:55810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231967AbhAaMiC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Jan 2021 07:38:02 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44BA464DD8;
        Sun, 31 Jan 2021 12:37:20 +0000 (UTC)
Date:   Sun, 31 Jan 2021 12:37:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v3 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity
 driver
Message-ID: <20210131123717.776f96fb@archlinux>
In-Reply-To: <20210128084011.3270281-4-swboyd@chromium.org>
References: <20210128084011.3270281-1-swboyd@chromium.org>
        <20210128084011.3270281-4-swboyd@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Jan 2021 00:40:11 -0800
Stephen Boyd <swboyd@chromium.org> wrote:

> Add support for a ChromeOS EC proximity driver that exposes a "front"
> proximity sensor via the IIO subsystem. The EC decides when front
> proximity is near and sets an MKBP switch 'EC_MKBP_FRONT_PROXIMITY' to
> notify the kernel of proximity. Similarly, when proximity detects
> something far away it sets the switch bit to 0. For now this driver
> exposes a single sensor, but it could be expanded in the future via more
> MKBP bits if desired.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

From a final look through, just one trivial request for a comment on
lock scope.  Otherwise looks good to me.

Jonathan

> ---
> 
> Changes from v2:
>  * Get clock base and use iio time if not boottime
> 
> Changes from v1:
>  * Sorted includes
>  * Renamed to have MKBP everywhere
>  * Use last_event_time for timestamp
>  * Dropped claim calls
>  * Dropped useless dev assignment
> 
>  drivers/iio/proximity/Kconfig                 |  11 +
>  drivers/iio/proximity/Makefile                |   1 +
>  .../iio/proximity/cros_ec_mkbp_proximity.c    | 245 ++++++++++++++++++
>  3 files changed, 257 insertions(+)
>  create mode 100644 drivers/iio/proximity/cros_ec_mkbp_proximity.c
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index 12672a0e89ed..7c7203ca3ac6 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -21,6 +21,17 @@ endmenu
>  
>  menu "Proximity and distance sensors"
>  
> +config CROS_EC_MKBP_PROXIMITY
> +	tristate "ChromeOS EC MKBP Proximity sensor"
> +	depends on CROS_EC
> +	help
> +	  Say Y here to enable the proximity sensor implemented via the ChromeOS EC MKBP
> +	  switches protocol. You must enable one bus option (CROS_EC_I2C or CROS_EC_SPI)
> +	  to use this.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called cros_ec_mkbp_proximity.
> +
>  config ISL29501
>  	tristate "Intersil ISL29501 Time Of Flight sensor"
>  	depends on I2C
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index 9c1aca1a8b79..cbdac09433eb 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -5,6 +5,7 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AS3935)		+= as3935.o
> +obj-$(CONFIG_CROS_EC_MKBP_PROXIMITY) += cros_ec_mkbp_proximity.o
>  obj-$(CONFIG_ISL29501)		+= isl29501.o
>  obj-$(CONFIG_LIDAR_LITE_V2)	+= pulsedlight-lidar-lite-v2.o
>  obj-$(CONFIG_MB1232)		+= mb1232.o
> diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
> new file mode 100644
> index 000000000000..c8f33cf11b42
> --- /dev/null
> +++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for cros-ec proximity sensor exposed through MKBP switch
> + *
> + * Copyright 2021 Google LLC.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/notifier.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#include <asm/unaligned.h>
> +
> +struct cros_ec_mkbp_proximity_data {
> +	struct cros_ec_device *ec;
> +	struct iio_dev *indio_dev;
> +	struct mutex lock;

Totally trivial, but please add a comment documenting the
scope of this lock.  If nothing else, one of the static analysers
tends to complain about this so we'll end up adding one later :)

> +	struct notifier_block notifier;
> +	bool enabled;
> +};
> +
