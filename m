Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C125F4A38C1
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiA3TzJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiA3TzJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:55:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC4DC061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:55:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51270B829A6
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40281C340E4;
        Sun, 30 Jan 2022 19:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643572505;
        bh=HedoWPWbprAC6nWKX85KpJ9pUd4qxcBkTHgjOVsCnjU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cbaWhIWCb0wImiCqhxC+q2WcALe1g2Oe+qd6l6uwvfk/6EAtpdJif8vIM9rH2abLF
         /D7/JQoB7TyhYxaAighooRAfqm23Vdhcc2QxCcIh90Uan2NCFdJ0aaDYMm1ubJmR6p
         Bo/iX+NvJuG9LywWTcgRf/kZN8+N+efx1v9oPIBpnV9f+lae4hl0RVALmwSIS8MhTD
         NhZJ8x9Tx0BaGOV60NQTGCOVJTJVoL5qGOxyz1p9MtgCKoJFwcvQrn1rACBzGzIBlC
         vqu0vW9Ji+7zYNOt+d2jTR9hIK3aTWG7rcLsu1DtUdQJTs43ud346C1pjWiLhLMDXX
         Cd32q5JWe1u8g==
Date:   Sun, 30 Jan 2022 20:01:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Sean Nyekjaer <sean@geanix.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2 00/13] IIO: accel/st-sensors move into separate
 symbol namespaces
Message-ID: <20220130200128.58228e7b@jic23-huawei>
In-Reply-To: <20220116180535.2367780-1-jic23@kernel.org>
References: <20220116180535.2367780-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 Jan 2022 18:05:22 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi All,

I'd appreciate it if someone has a chance to look at this set.
Should be fairly simple to review as more or less mechanical changes
other than the choice of naming for each namespace.

Thanks,

Jonathan

>=20
> Changes since v1:
> * Add IIO_ prefix to namespaces.
>=20
> https://lwn.net/Articles/760045/ provides a good overview of this feature
> and why it might be used.  In this particular case we fall under the multi
> module case.  For each group of modules, I've moved the exports into
> an independent namespace.
>=20
> Whilst I'm not entirely sure it is worth the noise of moving the main
> IIO exports into a namespace, it is definitely worthwhile for these small
> clusters of related modules (typically a core + i2c and spi modules).
>=20
> I've just done those within drivers/accel (including all of st-sensors as
> I did not want to do that piecemeal) as an initial set to get feedback on
> what people think of the approach and in particular naming of the namespa=
ces.
>=20
> As you can see it is a straight forward change to makes so I'll do the
> rest of the IIO drivers once we are agreed on the generic details.
> Note that I'll be expecting this for any new cases of this pattern going
> forwards.
>=20
> Includes a small diversion in st-sensors where we had a bunch of duplicat=
ed
> MODULE_* macros for some of the core modules which were made up of multip=
le
> c files.
>=20
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lucas Stankus <lucas.p.stankus@gmail.com>
> Cc: Puranjay Mohan <puranjay12@gmail.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Mike Looijmans <mike.looijmans@topic.nl>
> Cc: Sean Nyekjaer <sean@geanix.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Denis Ciocca <denis.ciocca@st.com>
>=20
> Jonathan Cameron (13):
>   iio:accel:mma9551_core: Move exports into IIO_MMA9551 namespace
>   iio:accel:mma7455_core: Move exports into IIO_MMA7455 namespace
>   iio:accel:kxsd9: Move exports into IIO_KDSD9 namespace
>   iio:accel:bma400: Move exports into IIO_BMA400 namespace
>   iio:accel:adxl313: Move exports into IIO_ADXL313 namespace
>   iio:accel:adxl345: Move exports into IIO_ADXL345 namespace
>   iio:accel:adxl355: Move exports into IIO_ADXL355 namespace
>   iio:accel:adxl372: Move exports into IIO_ADXL372 namespace
>   iio:accel:bmc150: Move exports into IIO_BMC150 namespace
>   iio:accel:bmi088: Move exports into IIO_BMI088 namespace
>   iio:accel:fxl8962af: Move exports into IIO_FXL8962AF namespace
>   iio:st-sensors: Remove duplicate MODULE_*
>   iio:st-sensors: Move exports into IIO_ST_SENSORS namespace
>=20
>  drivers/iio/accel/adxl313_core.c              |  6 ++--
>  drivers/iio/accel/adxl313_i2c.c               |  1 +
>  drivers/iio/accel/adxl313_spi.c               |  1 +
>  drivers/iio/accel/adxl345_core.c              |  2 +-
>  drivers/iio/accel/adxl345_i2c.c               |  1 +
>  drivers/iio/accel/adxl345_spi.c               |  1 +
>  drivers/iio/accel/adxl355_core.c              |  6 ++--
>  drivers/iio/accel/adxl355_i2c.c               |  1 +
>  drivers/iio/accel/adxl355_spi.c               |  1 +
>  drivers/iio/accel/adxl372.c                   |  4 +--
>  drivers/iio/accel/adxl372_i2c.c               |  1 +
>  drivers/iio/accel/adxl372_spi.c               |  1 +
>  drivers/iio/accel/bma400_core.c               |  6 ++--
>  drivers/iio/accel/bma400_i2c.c                |  1 +
>  drivers/iio/accel/bma400_spi.c                |  1 +
>  drivers/iio/accel/bmc150-accel-core.c         |  8 ++---
>  drivers/iio/accel/bmc150-accel-i2c.c          |  1 +
>  drivers/iio/accel/bmc150-accel-spi.c          |  1 +
>  drivers/iio/accel/bmi088-accel-core.c         |  8 ++---
>  drivers/iio/accel/bmi088-accel-spi.c          |  1 +
>  drivers/iio/accel/fxls8962af-core.c           |  6 ++--
>  drivers/iio/accel/fxls8962af-i2c.c            |  1 +
>  drivers/iio/accel/fxls8962af-spi.c            |  1 +
>  drivers/iio/accel/kxsd9-i2c.c                 |  1 +
>  drivers/iio/accel/kxsd9-spi.c                 |  1 +
>  drivers/iio/accel/kxsd9.c                     |  6 ++--
>  drivers/iio/accel/mma7455_core.c              |  6 ++--
>  drivers/iio/accel/mma7455_i2c.c               |  1 +
>  drivers/iio/accel/mma7455_spi.c               |  1 +
>  drivers/iio/accel/mma9551.c                   |  1 +
>  drivers/iio/accel/mma9551_core.c              | 36 +++++++++----------
>  drivers/iio/accel/mma9553.c                   |  1 +
>  drivers/iio/accel/st_accel_buffer.c           |  5 ---
>  drivers/iio/accel/st_accel_core.c             |  5 +--
>  drivers/iio/accel/st_accel_i2c.c              |  1 +
>  drivers/iio/accel/st_accel_spi.c              |  1 +
>  .../iio/common/st_sensors/st_sensors_buffer.c |  7 +---
>  .../iio/common/st_sensors/st_sensors_core.c   | 28 +++++++--------
>  .../iio/common/st_sensors/st_sensors_i2c.c    |  2 +-
>  .../iio/common/st_sensors/st_sensors_spi.c    |  2 +-
>  .../common/st_sensors/st_sensors_trigger.c    |  9 ++---
>  drivers/iio/gyro/st_gyro_buffer.c             |  4 ---
>  drivers/iio/gyro/st_gyro_core.c               |  5 +--
>  drivers/iio/gyro/st_gyro_i2c.c                |  1 +
>  drivers/iio/gyro/st_gyro_spi.c                |  1 +
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c  |  3 +-
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c   |  1 +
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c   |  1 +
>  drivers/iio/magnetometer/st_magn_buffer.c     |  4 ---
>  drivers/iio/magnetometer/st_magn_core.c       |  5 +--
>  drivers/iio/magnetometer/st_magn_i2c.c        |  1 +
>  drivers/iio/magnetometer/st_magn_spi.c        |  1 +
>  drivers/iio/pressure/st_pressure_buffer.c     |  5 ---
>  drivers/iio/pressure/st_pressure_core.c       |  5 +--
>  drivers/iio/pressure/st_pressure_i2c.c        |  1 +
>  drivers/iio/pressure/st_pressure_spi.c        |  1 +
>  56 files changed, 111 insertions(+), 103 deletions(-)
>=20

