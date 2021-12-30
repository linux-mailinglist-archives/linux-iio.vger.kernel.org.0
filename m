Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7ABA481FDB
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 20:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbhL3T1t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 14:27:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57780 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbhL3T1t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 14:27:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B084961751
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 19:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE5DC36AE9;
        Thu, 30 Dec 2021 19:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640892468;
        bh=gZOk87iXr7POZ1OURyJd0MU7uzTOPhQdW34kN5++Cm8=;
        h=From:To:Cc:Subject:Date:From;
        b=mGVvwkWmWH9LdPdoSKAncfsh5ojIoOVq/B0h6iwDAVFpI/tO9m50ywo9uJiUHLd3D
         5Fznzi/4b66jOg8eiIkSc/dTga9GeT1PnTMzxZsn+ljX6x5furARfIpF/cFKWNEvAv
         v339Hxx+Q26B7+gzQFWL9WBgOHk2lH5pFOebfyZocCgvnKo6GZ1QAUlmdbp7nuFGDf
         D3pkWOm4HzaHMSDYDw+vT03ugJu3kHoG5obXHIhUGBpBhhH+fe99RrAOxWiQefTsUU
         A/Ir4j7WkO9xAOLWAQ5QQ8IFQgFjvNSdCB8YHcPUJBQnowAJ6M6DGH3NwAMYswvtzG
         FRo/SQpPbbUyA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Sean Nyekjaer <sean@geanix.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 00/13] IIO: accel/st-sensors move into separate symbol namespaces
Date:   Thu, 30 Dec 2021 19:33:18 +0000
Message-Id: <20211230193331.283503-1-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

https://lwn.net/Articles/760045/ provides a good overview of this feature
and why it might be used.  In this particular case we fall under the multi
module case.  For each group of modules, I've moved the exports into
an independent namespace.

Whilst I'm not entirely sure it is worth the noise of moving the main
IIO exports into a namespace, it is definitely worthwhile for these small
clusters of related modules (typically a core + i2c and spi modules).

I've just done those within drivers/accel (including all of st-sensors as
I did not want to do that piecemeal) as an initial set to get feedback on
what people think of the approach and in particular naming of the namespaces.

As you can see it is a straight forward change to makes so I'll do the
rest of the IIO drivers once we are agreed on the generic details.
Note that I'll be expecting this for any new cases of this pattern going
forwards.

Includes a small diversion in st-sensors where we had a bunch of duplicated
MODULE_* macros for some of the core modules which were made up of multiple
c files.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lucas Stankus <lucas.p.stankus@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Sean Nyekjaer <sean@geanix.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Denis Ciocca <denis.ciocca@st.com>

Jonathan Cameron (13):
  iio:accel:mma9551_core: Move exports into MMA9551 namespace
  iio:accel:mma7455_core: Move exports into MMA7455 namespace
  iio:accel:kxsd9: Move exports into KDSD9 namespace
  iio:accel:bma400: Move exports into BMA400 namespace
  iio:accel:adxl313: Move exports into ADXL313 namespace
  iio:accel:adxl345: Move exports into ADXL345 namespace
  iio:accel:adxl355: Move exports into ADXL355 namespace
  iio:accel:adxl372: Move exports into ADXL372 namespace
  iio:accel:bmc150: Move exports into BMC150 namespace
  iio:accel:bmi088: Move exports into BMI088 namespace
  iio:accel:fxl8962af: Move exports into FXL8962AF namespace
  iio:st-sensors: Remove duplicate MODULE_*
  iio:st-sensors: Move exports into ST_SENSORS namespace

 drivers/iio/accel/adxl313_core.c              |  6 ++--
 drivers/iio/accel/adxl313_i2c.c               |  1 +
 drivers/iio/accel/adxl313_spi.c               |  1 +
 drivers/iio/accel/adxl345_core.c              |  2 +-
 drivers/iio/accel/adxl345_i2c.c               |  1 +
 drivers/iio/accel/adxl345_spi.c               |  1 +
 drivers/iio/accel/adxl355_core.c              |  6 ++--
 drivers/iio/accel/adxl355_i2c.c               |  1 +
 drivers/iio/accel/adxl355_spi.c               |  1 +
 drivers/iio/accel/adxl372.c                   |  4 +--
 drivers/iio/accel/adxl372_i2c.c               |  1 +
 drivers/iio/accel/adxl372_spi.c               |  1 +
 drivers/iio/accel/bma400_core.c               |  6 ++--
 drivers/iio/accel/bma400_i2c.c                |  1 +
 drivers/iio/accel/bma400_spi.c                |  1 +
 drivers/iio/accel/bmc150-accel-core.c         |  8 ++---
 drivers/iio/accel/bmc150-accel-i2c.c          |  1 +
 drivers/iio/accel/bmc150-accel-spi.c          |  1 +
 drivers/iio/accel/bmi088-accel-core.c         |  8 ++---
 drivers/iio/accel/bmi088-accel-spi.c          |  1 +
 drivers/iio/accel/fxls8962af-core.c           |  6 ++--
 drivers/iio/accel/fxls8962af-i2c.c            |  1 +
 drivers/iio/accel/fxls8962af-spi.c            |  1 +
 drivers/iio/accel/kxsd9-i2c.c                 |  1 +
 drivers/iio/accel/kxsd9-spi.c                 |  1 +
 drivers/iio/accel/kxsd9.c                     |  6 ++--
 drivers/iio/accel/mma7455_core.c              |  6 ++--
 drivers/iio/accel/mma7455_i2c.c               |  1 +
 drivers/iio/accel/mma7455_spi.c               |  1 +
 drivers/iio/accel/mma9551.c                   |  1 +
 drivers/iio/accel/mma9551_core.c              | 36 +++++++++----------
 drivers/iio/accel/mma9553.c                   |  1 +
 drivers/iio/accel/st_accel_buffer.c           |  5 ---
 drivers/iio/accel/st_accel_core.c             |  5 +--
 drivers/iio/accel/st_accel_i2c.c              |  1 +
 drivers/iio/accel/st_accel_spi.c              |  1 +
 .../iio/common/st_sensors/st_sensors_buffer.c |  7 +---
 .../iio/common/st_sensors/st_sensors_core.c   | 28 +++++++--------
 .../iio/common/st_sensors/st_sensors_i2c.c    |  2 +-
 .../iio/common/st_sensors/st_sensors_spi.c    |  2 +-
 .../common/st_sensors/st_sensors_trigger.c    |  9 ++---
 drivers/iio/gyro/st_gyro_buffer.c             |  4 ---
 drivers/iio/gyro/st_gyro_core.c               |  5 +--
 drivers/iio/gyro/st_gyro_i2c.c                |  1 +
 drivers/iio/gyro/st_gyro_spi.c                |  1 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c  |  3 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c   |  1 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c   |  1 +
 drivers/iio/magnetometer/st_magn_buffer.c     |  4 ---
 drivers/iio/magnetometer/st_magn_core.c       |  5 +--
 drivers/iio/magnetometer/st_magn_i2c.c        |  1 +
 drivers/iio/magnetometer/st_magn_spi.c        |  1 +
 drivers/iio/pressure/st_pressure_buffer.c     |  5 ---
 drivers/iio/pressure/st_pressure_core.c       |  5 +--
 drivers/iio/pressure/st_pressure_i2c.c        |  1 +
 drivers/iio/pressure/st_pressure_spi.c        |  1 +
 56 files changed, 111 insertions(+), 103 deletions(-)

-- 
2.34.1

