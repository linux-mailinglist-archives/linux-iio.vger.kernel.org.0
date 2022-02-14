Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4864B4D28
	for <lists+linux-iio@lfdr.de>; Mon, 14 Feb 2022 12:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349603AbiBNKyA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 14 Feb 2022 05:54:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349606AbiBNKxz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Feb 2022 05:53:55 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D615F7C787
        for <linux-iio@vger.kernel.org>; Mon, 14 Feb 2022 02:18:48 -0800 (PST)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jy0Sc5LYqz67yKG;
        Mon, 14 Feb 2022 18:14:24 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 11:18:46 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Feb
 2022 10:18:45 +0000
Date:   Mon, 14 Feb 2022 10:18:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Lucas Stankus" <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Sean Nyekjaer <sean@geanix.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2 00/13] IIO: accel/st-sensors move into separate
 symbol namespaces
Message-ID: <20220214101843.00004bfb@Huawei.com>
In-Reply-To: <20220130200128.58228e7b@jic23-huawei>
References: <20220116180535.2367780-1-jic23@kernel.org>
        <20220130200128.58228e7b@jic23-huawei>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 30 Jan 2022 20:01:28 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 16 Jan 2022 18:05:22 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Hi All,
> 
> I'd appreciate it if someone has a chance to look at this set.
> Should be fairly simple to review as more or less mechanical changes
> other than the choice of naming for each namespace.

I plan to pick this set up shortly on basis v1 got some review and
comments were all about the prefix.  So hopefully everything else
is fine.

However, if anyone does have time to sanity check it would be much
appreciated as I don't trust myself to not do something silly
(call it experience :)

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Changes since v1:
> > * Add IIO_ prefix to namespaces.
> > 
> > https://lwn.net/Articles/760045/ provides a good overview of this feature
> > and why it might be used.  In this particular case we fall under the multi
> > module case.  For each group of modules, I've moved the exports into
> > an independent namespace.
> > 
> > Whilst I'm not entirely sure it is worth the noise of moving the main
> > IIO exports into a namespace, it is definitely worthwhile for these small
> > clusters of related modules (typically a core + i2c and spi modules).
> > 
> > I've just done those within drivers/accel (including all of st-sensors as
> > I did not want to do that piecemeal) as an initial set to get feedback on
> > what people think of the approach and in particular naming of the namespaces.
> > 
> > As you can see it is a straight forward change to makes so I'll do the
> > rest of the IIO drivers once we are agreed on the generic details.
> > Note that I'll be expecting this for any new cases of this pattern going
> > forwards.
> > 
> > Includes a small diversion in st-sensors where we had a bunch of duplicated
> > MODULE_* macros for some of the core modules which were made up of multiple
> > c files.
> > 
> > Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Lucas Stankus <lucas.p.stankus@gmail.com>
> > Cc: Puranjay Mohan <puranjay12@gmail.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Mike Looijmans <mike.looijmans@topic.nl>
> > Cc: Sean Nyekjaer <sean@geanix.com>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Denis Ciocca <denis.ciocca@st.com>
> > 
> > Jonathan Cameron (13):
> >   iio:accel:mma9551_core: Move exports into IIO_MMA9551 namespace
> >   iio:accel:mma7455_core: Move exports into IIO_MMA7455 namespace
> >   iio:accel:kxsd9: Move exports into IIO_KDSD9 namespace
> >   iio:accel:bma400: Move exports into IIO_BMA400 namespace
> >   iio:accel:adxl313: Move exports into IIO_ADXL313 namespace
> >   iio:accel:adxl345: Move exports into IIO_ADXL345 namespace
> >   iio:accel:adxl355: Move exports into IIO_ADXL355 namespace
> >   iio:accel:adxl372: Move exports into IIO_ADXL372 namespace
> >   iio:accel:bmc150: Move exports into IIO_BMC150 namespace
> >   iio:accel:bmi088: Move exports into IIO_BMI088 namespace
> >   iio:accel:fxl8962af: Move exports into IIO_FXL8962AF namespace
> >   iio:st-sensors: Remove duplicate MODULE_*
> >   iio:st-sensors: Move exports into IIO_ST_SENSORS namespace
> > 
> >  drivers/iio/accel/adxl313_core.c              |  6 ++--
> >  drivers/iio/accel/adxl313_i2c.c               |  1 +
> >  drivers/iio/accel/adxl313_spi.c               |  1 +
> >  drivers/iio/accel/adxl345_core.c              |  2 +-
> >  drivers/iio/accel/adxl345_i2c.c               |  1 +
> >  drivers/iio/accel/adxl345_spi.c               |  1 +
> >  drivers/iio/accel/adxl355_core.c              |  6 ++--
> >  drivers/iio/accel/adxl355_i2c.c               |  1 +
> >  drivers/iio/accel/adxl355_spi.c               |  1 +
> >  drivers/iio/accel/adxl372.c                   |  4 +--
> >  drivers/iio/accel/adxl372_i2c.c               |  1 +
> >  drivers/iio/accel/adxl372_spi.c               |  1 +
> >  drivers/iio/accel/bma400_core.c               |  6 ++--
> >  drivers/iio/accel/bma400_i2c.c                |  1 +
> >  drivers/iio/accel/bma400_spi.c                |  1 +
> >  drivers/iio/accel/bmc150-accel-core.c         |  8 ++---
> >  drivers/iio/accel/bmc150-accel-i2c.c          |  1 +
> >  drivers/iio/accel/bmc150-accel-spi.c          |  1 +
> >  drivers/iio/accel/bmi088-accel-core.c         |  8 ++---
> >  drivers/iio/accel/bmi088-accel-spi.c          |  1 +
> >  drivers/iio/accel/fxls8962af-core.c           |  6 ++--
> >  drivers/iio/accel/fxls8962af-i2c.c            |  1 +
> >  drivers/iio/accel/fxls8962af-spi.c            |  1 +
> >  drivers/iio/accel/kxsd9-i2c.c                 |  1 +
> >  drivers/iio/accel/kxsd9-spi.c                 |  1 +
> >  drivers/iio/accel/kxsd9.c                     |  6 ++--
> >  drivers/iio/accel/mma7455_core.c              |  6 ++--
> >  drivers/iio/accel/mma7455_i2c.c               |  1 +
> >  drivers/iio/accel/mma7455_spi.c               |  1 +
> >  drivers/iio/accel/mma9551.c                   |  1 +
> >  drivers/iio/accel/mma9551_core.c              | 36 +++++++++----------
> >  drivers/iio/accel/mma9553.c                   |  1 +
> >  drivers/iio/accel/st_accel_buffer.c           |  5 ---
> >  drivers/iio/accel/st_accel_core.c             |  5 +--
> >  drivers/iio/accel/st_accel_i2c.c              |  1 +
> >  drivers/iio/accel/st_accel_spi.c              |  1 +
> >  .../iio/common/st_sensors/st_sensors_buffer.c |  7 +---
> >  .../iio/common/st_sensors/st_sensors_core.c   | 28 +++++++--------
> >  .../iio/common/st_sensors/st_sensors_i2c.c    |  2 +-
> >  .../iio/common/st_sensors/st_sensors_spi.c    |  2 +-
> >  .../common/st_sensors/st_sensors_trigger.c    |  9 ++---
> >  drivers/iio/gyro/st_gyro_buffer.c             |  4 ---
> >  drivers/iio/gyro/st_gyro_core.c               |  5 +--
> >  drivers/iio/gyro/st_gyro_i2c.c                |  1 +
> >  drivers/iio/gyro/st_gyro_spi.c                |  1 +
> >  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c  |  3 +-
> >  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c   |  1 +
> >  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c   |  1 +
> >  drivers/iio/magnetometer/st_magn_buffer.c     |  4 ---
> >  drivers/iio/magnetometer/st_magn_core.c       |  5 +--
> >  drivers/iio/magnetometer/st_magn_i2c.c        |  1 +
> >  drivers/iio/magnetometer/st_magn_spi.c        |  1 +
> >  drivers/iio/pressure/st_pressure_buffer.c     |  5 ---
> >  drivers/iio/pressure/st_pressure_core.c       |  5 +--
> >  drivers/iio/pressure/st_pressure_i2c.c        |  1 +
> >  drivers/iio/pressure/st_pressure_spi.c        |  1 +
> >  56 files changed, 111 insertions(+), 103 deletions(-)
> >   
> 

