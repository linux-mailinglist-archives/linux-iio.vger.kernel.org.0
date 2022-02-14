Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBE34B5503
	for <lists+linux-iio@lfdr.de>; Mon, 14 Feb 2022 16:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiBNPke (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Feb 2022 10:40:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiBNPkd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Feb 2022 10:40:33 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842CB60A9F
        for <linux-iio@vger.kernel.org>; Mon, 14 Feb 2022 07:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644853225; x=1676389225;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PZfjvmSaL/J0TQy4l+6En+KIReCh1RZJbO4oVhzQ+tc=;
  b=Su1Xq2wm1WSjQKk01RfNZ4N3hiE8NBU+tMCD2FyIDx+luzfhNU27rBvj
   0lWMM6ZAwYVePW9hA4zw+51TDV9kQb25VJ8sf85pJ4j4mgGr2DwLOvi9n
   uyRNuqwkGMgDkAH8wEEJhKGV2+I5Aw7F4/VYF+u5Ny1Be6wRRTjZWnY03
   eh9Pkq/5ONSRPgVrNJ/mw9XKFDAnH9XtLkehf/fJccyhOHpmOLfUVSrn6
   XQbwitrW2SrbdcBKdD4pd654K7mMCWrVQyZOsIWW134Pb+A2R/AuA8YJa
   cWZc8Pzt0CV4ipR8ANi4Lcm3Lb/cmfP5Qp1NWMFLExIY42jM2PK0Ig15z
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250318150"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="250318150"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 07:40:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="501882900"
Received: from junliao-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.133.237])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 07:40:24 -0800
Message-ID: <e23ff571cb023799d9890b2d9426c34e27a58ae4.camel@linux.intel.com>
Subject: Re: [PATCH v2 00/13] IIO: accel/st-sensors move into separate
 symbol namespaces
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Sean Nyekjaer <sean@geanix.com>,
        Denis Ciocca <denis.ciocca@st.com>
Date:   Mon, 14 Feb 2022 07:40:24 -0800
In-Reply-To: <20220214101843.00004bfb@Huawei.com>
References: <20220116180535.2367780-1-jic23@kernel.org>
         <20220130200128.58228e7b@jic23-huawei> <20220214101843.00004bfb@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2022-02-14 at 10:18 +0000, Jonathan Cameron wrote:
> On Sun, 30 Jan 2022 20:01:28 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Sun, 16 Jan 2022 18:05:22 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> > 
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > 
> > Hi All,
> > 
> > I'd appreciate it if someone has a chance to look at this set.
> > Should be fairly simple to review as more or less mechanical
> > changes
> > other than the choice of naming for each namespace.
> 
> I plan to pick this set up shortly on basis v1 got some review and
> comments were all about the prefix.  So hopefully everything else
> is fine.
> 
> However, if anyone does have time to sanity check it would be much
> appreciated as I don't trust myself to not do something silly
> (call it experience :)
I did sanity check, didn't find any issue.

Thanks,
Srinivas

> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> > > 
> > > Changes since v1:
> > > * Add IIO_ prefix to namespaces.
> > > 
> > > https://lwn.net/Articles/760045/ provides a good overview of this
> > > feature
> > > and why it might be used.  In this particular case we fall under
> > > the multi
> > > module case.  For each group of modules, I've moved the exports
> > > into
> > > an independent namespace.
> > > 
> > > Whilst I'm not entirely sure it is worth the noise of moving the
> > > main
> > > IIO exports into a namespace, it is definitely worthwhile for
> > > these small
> > > clusters of related modules (typically a core + i2c and spi
> > > modules).
> > > 
> > > I've just done those within drivers/accel (including all of st-
> > > sensors as
> > > I did not want to do that piecemeal) as an initial set to get
> > > feedback on
> > > what people think of the approach and in particular naming of the
> > > namespaces.
> > > 
> > > As you can see it is a straight forward change to makes so I'll
> > > do the
> > > rest of the IIO drivers once we are agreed on the generic
> > > details.
> > > Note that I'll be expecting this for any new cases of this
> > > pattern going
> > > forwards.
> > > 
> > > Includes a small diversion in st-sensors where we had a bunch of
> > > duplicated
> > > MODULE_* macros for some of the core modules which were made up
> > > of multiple
> > > c files.
> > > 
> > > Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Lucas Stankus <lucas.p.stankus@gmail.com>
> > > Cc: Puranjay Mohan <puranjay12@gmail.com>
> > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Cc: Mike Looijmans <mike.looijmans@topic.nl>
> > > Cc: Sean Nyekjaer <sean@geanix.com>
> > > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Denis Ciocca <denis.ciocca@st.com>
> > > 
> > > Jonathan Cameron (13):
> > >   iio:accel:mma9551_core: Move exports into IIO_MMA9551 namespace
> > >   iio:accel:mma7455_core: Move exports into IIO_MMA7455 namespace
> > >   iio:accel:kxsd9: Move exports into IIO_KDSD9 namespace
> > >   iio:accel:bma400: Move exports into IIO_BMA400 namespace
> > >   iio:accel:adxl313: Move exports into IIO_ADXL313 namespace
> > >   iio:accel:adxl345: Move exports into IIO_ADXL345 namespace
> > >   iio:accel:adxl355: Move exports into IIO_ADXL355 namespace
> > >   iio:accel:adxl372: Move exports into IIO_ADXL372 namespace
> > >   iio:accel:bmc150: Move exports into IIO_BMC150 namespace
> > >   iio:accel:bmi088: Move exports into IIO_BMI088 namespace
> > >   iio:accel:fxl8962af: Move exports into IIO_FXL8962AF namespace
> > >   iio:st-sensors: Remove duplicate MODULE_*
> > >   iio:st-sensors: Move exports into IIO_ST_SENSORS namespace
> > > 
> > >  drivers/iio/accel/adxl313_core.c              |  6 ++--
> > >  drivers/iio/accel/adxl313_i2c.c               |  1 +
> > >  drivers/iio/accel/adxl313_spi.c               |  1 +
> > >  drivers/iio/accel/adxl345_core.c              |  2 +-
> > >  drivers/iio/accel/adxl345_i2c.c               |  1 +
> > >  drivers/iio/accel/adxl345_spi.c               |  1 +
> > >  drivers/iio/accel/adxl355_core.c              |  6 ++--
> > >  drivers/iio/accel/adxl355_i2c.c               |  1 +
> > >  drivers/iio/accel/adxl355_spi.c               |  1 +
> > >  drivers/iio/accel/adxl372.c                   |  4 +--
> > >  drivers/iio/accel/adxl372_i2c.c               |  1 +
> > >  drivers/iio/accel/adxl372_spi.c               |  1 +
> > >  drivers/iio/accel/bma400_core.c               |  6 ++--
> > >  drivers/iio/accel/bma400_i2c.c                |  1 +
> > >  drivers/iio/accel/bma400_spi.c                |  1 +
> > >  drivers/iio/accel/bmc150-accel-core.c         |  8 ++---
> > >  drivers/iio/accel/bmc150-accel-i2c.c          |  1 +
> > >  drivers/iio/accel/bmc150-accel-spi.c          |  1 +
> > >  drivers/iio/accel/bmi088-accel-core.c         |  8 ++---
> > >  drivers/iio/accel/bmi088-accel-spi.c          |  1 +
> > >  drivers/iio/accel/fxls8962af-core.c           |  6 ++--
> > >  drivers/iio/accel/fxls8962af-i2c.c            |  1 +
> > >  drivers/iio/accel/fxls8962af-spi.c            |  1 +
> > >  drivers/iio/accel/kxsd9-i2c.c                 |  1 +
> > >  drivers/iio/accel/kxsd9-spi.c                 |  1 +
> > >  drivers/iio/accel/kxsd9.c                     |  6 ++--
> > >  drivers/iio/accel/mma7455_core.c              |  6 ++--
> > >  drivers/iio/accel/mma7455_i2c.c               |  1 +
> > >  drivers/iio/accel/mma7455_spi.c               |  1 +
> > >  drivers/iio/accel/mma9551.c                   |  1 +
> > >  drivers/iio/accel/mma9551_core.c              | 36 +++++++++----
> > > ------
> > >  drivers/iio/accel/mma9553.c                   |  1 +
> > >  drivers/iio/accel/st_accel_buffer.c           |  5 ---
> > >  drivers/iio/accel/st_accel_core.c             |  5 +--
> > >  drivers/iio/accel/st_accel_i2c.c              |  1 +
> > >  drivers/iio/accel/st_accel_spi.c              |  1 +
> > >  .../iio/common/st_sensors/st_sensors_buffer.c |  7 +---
> > >  .../iio/common/st_sensors/st_sensors_core.c   | 28 +++++++------
> > > --
> > >  .../iio/common/st_sensors/st_sensors_i2c.c    |  2 +-
> > >  .../iio/common/st_sensors/st_sensors_spi.c    |  2 +-
> > >  .../common/st_sensors/st_sensors_trigger.c    |  9 ++---
> > >  drivers/iio/gyro/st_gyro_buffer.c             |  4 ---
> > >  drivers/iio/gyro/st_gyro_core.c               |  5 +--
> > >  drivers/iio/gyro/st_gyro_i2c.c                |  1 +
> > >  drivers/iio/gyro/st_gyro_spi.c                |  1 +
> > >  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c  |  3 +-
> > >  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c   |  1 +
> > >  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c   |  1 +
> > >  drivers/iio/magnetometer/st_magn_buffer.c     |  4 ---
> > >  drivers/iio/magnetometer/st_magn_core.c       |  5 +--
> > >  drivers/iio/magnetometer/st_magn_i2c.c        |  1 +
> > >  drivers/iio/magnetometer/st_magn_spi.c        |  1 +
> > >  drivers/iio/pressure/st_pressure_buffer.c     |  5 ---
> > >  drivers/iio/pressure/st_pressure_core.c       |  5 +--
> > >  drivers/iio/pressure/st_pressure_i2c.c        |  1 +
> > >  drivers/iio/pressure/st_pressure_spi.c        |  1 +
> > >  56 files changed, 111 insertions(+), 103 deletions(-)
> > >   
> > 
> 

