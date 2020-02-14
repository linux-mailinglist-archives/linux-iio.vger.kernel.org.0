Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0AA15F038
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 18:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbgBNP6Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 10:58:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388529AbgBNP6P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 10:58:15 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D408B24681;
        Fri, 14 Feb 2020 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695894;
        bh=IRI8TotyOj1hNG3twA3SdQJwD4E2NOI119Ov8Gu2pTo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xFLpIDTRzFnhChOk8mvBK76i21MgeXDv+NzOt3YEIiAUFKSWQaOb7TW8O4GJ+7wom
         cBXeodQqtRFT9b389khVykHUgMCs7sGYiau1lURCN0XcJS2Hr/4V9fI83WV5+IQjtC
         /C+5ajIBY5L43VnmVGzqgN5NYWGILhLuZSc9lE38=
Date:   Fri, 14 Feb 2020 15:58:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v5 4/7] iio: light: add Dyna-Image AL3010 driver
Message-ID: <20200214155809.28909980@archlinux>
In-Reply-To: <20200211191201.1049902-5-david@ixit.cz>
References: <20200211191201.1049902-1-david@ixit.cz>
        <20200211191201.1049902-5-david@ixit.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Feb 2020 20:11:58 +0100
David Heidelberg <david@ixit.cz> wrote:

> Based on:
> - 3320A in-kernel driver
> - https://www.spinics.net/lists/linux-iio/msg25145.html
> - https://lore.kernel.org/patchwork/patch/684179/
>=20
> I decided to keep it aside of AL3320A due to different approach and much
> simpler design of 3010.
>=20
> Tested on Nexus 7 2012 (grouper/tilapia).
>=20
> Tested-by: David Heidelberg <david@ixit.cz>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Hi David,

Code looks fine, but you need to change the module author and
I think it makes sense to add your own copyright notice to reflect the
work you did on this driver!

Thanks,

Jonathan

> ---
> v4:
> - SQUASHed: iio: light: al3010 implement suspend support
> - switched from _remove to devm_add_action_or_reset
> - implement bitfields FIELD_PREP & FIELD_GET, no functionality change
>=20
>  drivers/iio/light/Kconfig  |  10 ++
>  drivers/iio/light/Makefile |   1 +
>  drivers/iio/light/al3010.c | 240 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 251 insertions(+)
>  create mode 100644 drivers/iio/light/al3010.c
>=20
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 9968f982fbc7..43d9b830279d 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -43,6 +43,16 @@ config ADUX1020
>  	 To compile this driver as a module, choose M here: the
>  	 module will be called adux1020.
> =20
> +config AL3010
> +	tristate "AL3010 ambient light sensor"
> +	depends on I2C
> +	help
> +	  Say Y here if you want to build a driver for the Dyna Image AL3010
> +	  ambient light sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called al3010.
> +
>  config AL3320A
>  	tristate "AL3320A ambient light sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index c98d1cefb861..88bb93550fcc 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_ACPI_ALS)		+=3D acpi-als.o
>  obj-$(CONFIG_ADJD_S311)		+=3D adjd_s311.o
>  obj-$(CONFIG_ADUX1020)		+=3D adux1020.o
> +obj-$(CONFIG_AL3010)		+=3D al3010.o
>  obj-$(CONFIG_AL3320A)		+=3D al3320a.o
>  obj-$(CONFIG_APDS9300)		+=3D apds9300.o
>  obj-$(CONFIG_APDS9960)		+=3D apds9960.o
> diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
> new file mode 100644
> index 000000000000..8f8f7f18d620
> --- /dev/null
> +++ b/drivers/iio/light/al3010.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AL3010 - Dyna Image Ambient Light Sensor
> + *
> + * Copyright (c) 2014, Intel Corporation.
> + * Copyright (c) 2016, Dyna-Image Corp.

Also update this.

> + *
> + * IIO driver for AL3010 (7-bit I2C slave address 0x1C).
> + *
> + * TODO: interrupt support, thresholds
> + * When the driver will get support for interrupt handling, then interru=
pt
> + * will need to be disabled before turning sensor OFF in order to avoid
> + * potential races with the interrupt handling.
> + */
...

> +
> +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@nxp.com>");

You want to update this!

> +MODULE_DESCRIPTION("AL3010 Ambient Light Sensor driver");
> +MODULE_LICENSE("GPL v2");

