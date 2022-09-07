Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81705B0547
	for <lists+linux-iio@lfdr.de>; Wed,  7 Sep 2022 15:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiIGNhk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Sep 2022 09:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiIGNhh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Sep 2022 09:37:37 -0400
Received: from es400ra02.iit.it (mx.iit.it [90.147.26.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E43889CD6;
        Wed,  7 Sep 2022 06:37:31 -0700 (PDT)
Received: from es400ra02.iit.it (127.0.0.1) id h32f9i0171sv; Wed, 7 Sep 2022 15:22:18 +0200 (envelope-from <prvs=1249fcc2cf=Andrea.Merello@iit.it>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iit.it;
        s=mx; i=@iit.it; h=Received:Received:From:To:CC:Subject:Date:
        Message-ID:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=gDh3lp6yC0I2SraIj3VbafTtbE9Q34FWInm46CYBs0g=; b=GMMSCIEmuKfp0
        RUpzcN5HI6hvyqGL9w6hn5DJKg7JEcx7DyLGp2VLGMuKiZtV7HqHlCjpiyedqpWE
        K3R6V5MQfOAwEy6IamUsVKFrQwP1uIkFORibQB703jP9bFKaPj/S2gGlSt7bBbPo
        3T9M0PSbD8dLr2/Fkqums2uXvZBs0c=
Received: from mail.iit.it ([10.255.8.186])
        by es400ra02.iit.it ([172.31.0.242]) (SonicWall 10.0.16.7295)
        with ESMTPS (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256)
        id o202209071322180212542-8; Wed, 07 Sep 2022 15:22:18 +0200
Received: from poker.iit.local (10.10.20.64) by iitmxwge020.iit.local
 (10.255.8.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.31; Wed, 7 Sep
 2022 15:22:16 +0200
From:   <andrea.merello@iit.it>
To:     <jic23@kernel.org>, <mchehab+huawei@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <matt.ranostay@konsulko.com>,
        <ardeleanalex@gmail.com>, <jacopo@jmondi.org>,
        <andrea.merello@gmail.com>, <bagasdotme@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v7 00/14] Add support for Bosch BNO055 IMU
Date:   Wed, 7 Sep 2022 15:21:51 +0200
Message-ID: <20220907132205.28021-1-andrea.merello@iit.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.10.20.64]
X-ClientProxiedBy: IITMXWGE021.iit.local (10.255.8.187) To
 iitmxwge020.iit.local (10.255.8.186)
X-Mlf-DSE-Version: 6948
X-Mlf-Rules-Version: s20220810181453; ds20200715013501;
        di20220831211829; ri20160318003319; fs20220901203539
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: Andrea.Merello@iit.it
X-Mlf-Version: 10.0.16.7295
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202209071322180212542
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

This series (tries to) add support for Bosch BNO055 IMU to Linux IIO
subsystem. It is made up several patches:

  1/14 to 6/14: add some IIO modifiers, and their documentation, to the IIO
                core layer, in order to being able to expose the linear
                acceleration and Euler angles among standard attributes.
                Also update the IIO event monitor tool

  7/14: fix binary attributes didn't work with IIO

  8/14 to 11/14: add the core IIO BNO055 driver and documentation for sysfs
                 attributes and DT bindings

  12/14: adds serdev BNO055 driver to actually use the IMU via serial line

  13/14: adds I2C BNO055 driver to actually use the IMU via I2C wiring

  14/14: add a documentation file that describe the bno055 driver and
         specifically the calibration

In this series this [1] patch has been also squashed.

Differences wrt v6:

- fix some typos.
- fix some style issues.
- get rid of ifdefs for CONFIG_DEBUG_FS.
- avoid pushing data to the IIO layer if we actually failed reading it.
- rework debugfs file creating failure path.
- fix errors and warning found by kernel test robot <lkp@intel.com>
- rebase

Differences wrt other BNO055 drivers:

  Previously at least another driver for the very same chip has been posted
  to the Linux ML [0], but it has been never merged, and it seems no one
  cared of it since quite a long time.

  This driver differs from the above driver on the following aspects:

  - This driver supports also serial access (to be reliable, reset pin is
    required to be wired)

  - The above driver tried to support all IMU HW modes by allowing to
    choose one in the DT, and adapting IIO attributes accordingly. This
    driver does not rely on DT for this, instead settings are done via
    sysfs attributes.  All IIO attributes are always exposed; more on this
    later on. This driver however supports only a subset of the
    HW-supported modes.

  - This driver has some support for managing the IMU calibration

Supported operation modes:

  - AMG (accelerometer, magnetometer and gyroscope) mode, which provides
    raw (uncalibrated) measurements from the said sensors, and allows for
    setting some parameters about them (e.g. filter cut-off frequency, max
    sensor ranges, etc).

  - Fusion mode, which still provides AMG measures, while it also provides
    other data calculated by the IMU (e.g. rotation angles, linear
    acceleration, etc). In this mode user has no freedom to set any sensor
    parameter, since the HW locks them. Autocalibration and correction is
    performed by the IMU.

  IIO attributes exposing sensors parameters are always present, but in
  fusion modes the available values are constrained to just the one used by
  the HW. This is reflected in the '*_available' IIO attributes.

  Trying to set a not-supported value always falls back to the closest
  supported one, which in this case is just the one in use by the HW.

  IIO attributes for unavailable measurements (e.g. Euler angles in AMG
  mode) can't be read (return -EBUSY, or refuse to enable buffer).

IMU calibration:

  The IMU supports for two sets of calibration parameters:

  - SIC matrix. user-provided; this driver doesn't currently support it

  - Offset and radius parameters. The IMU automatically finds out them when
    it is running in fusion mode; supported by this driver.

  The driver provides access to autocalibration flags (i.e. you can known
  if the IMU has successfully autocalibrated) and to calibration data blob.
  The user can save this blob in a "firmware" file (i.e. in /lib/firmware)
  that the driver looks for at probe time. If found, then the IMU is
  initialized with this calibration data. This saves the user from
  performing the calibration procedure every time (which consist of moving
  the IMU in various way).

  The driver looks for calibration data file using two different names:
  first a file whose name is suffixed with the IMU unique ID is searched
  for; this is useful when there is more than one IMU instance. If this
  file is not found, then a "generic" calibration file is searched for
  (which can be used when only one IMU is present, without struggling with
  fancy names, that changes on each device).

  In AMG mode the IIO 'offset' attributes provide access to the offsets
  from calibration data (if any), so that the user can apply them to the
  accel, angvel and magn IIO attributes. In fusion mode they are not needed
  and read as zero.


Access protocols and serdev module:

  The serial protocol is quite simple, but there are tricks to make it
  really works. Those tricks and workarounds are documented in the driver
  source file.

  The core BNO055 driver tries to group readings in burst when appropriate,
  in order to optimize triggered buffer operation. The threshold for
  splitting a burst (i.e. max number of unused bytes in the middle of a
  burst that will be throw away) is provided to the core driver by the
  lowlevel access driver (either serdev or I2C) at probe time.

[0] https://www.spinics.net/lists/linux-iio/msg25508.html
[1] https://lore.kernel.org/lkml/20220704034041.15448-1-bagasdotme@gmail.com/

Andrea Merello (14):
  iio: add modifiers for linear acceleration
  iio: document linear acceleration modifiers
  iio: event_monitor: add linear acceleration modifiers
  iio: add modifers for pitch, yaw, roll
  iio: document pitch, yaw, roll modifiers
  iio: event_monitor: add pitch, yaw and roll modifiers
  iio: add support for binary attributes
  iio: imu: add Bosch Sensortec BNO055 core driver
  iio: document bno055 private sysfs attributes
  iio: document "serialnumber" sysfs attribute
  dt-bindings: iio/imu: Add Bosch BNO055
  iio: imu: add BNO055 serdev driver
  iio: imu: add BNO055 I2C driver
  docs: iio: add documentation for BNO055 driver

 Documentation/ABI/testing/sysfs-bus-iio       |   25 +
 .../ABI/testing/sysfs-bus-iio-bno055          |   81 +
 .../bindings/iio/imu/bosch,bno055.yaml        |   59 +
 Documentation/iio/bno055.rst                  |   51 +
 Documentation/iio/index.rst                   |    2 +
 drivers/iio/imu/Kconfig                       |    1 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/bno055/Kconfig                |   25 +
 drivers/iio/imu/bno055/Makefile               |   10 +
 drivers/iio/imu/bno055/bno055.c               | 1698 +++++++++++++++++
 drivers/iio/imu/bno055/bno055.h               |   13 +
 drivers/iio/imu/bno055/bno055_i2c.c           |   57 +
 drivers/iio/imu/bno055/bno055_ser_core.c      |  560 ++++++
 drivers/iio/imu/bno055/bno055_ser_trace.c     |   14 +
 drivers/iio/imu/bno055/bno055_ser_trace.h     |  104 +
 drivers/iio/industrialio-core.c               |   10 +-
 include/uapi/linux/iio/types.h                |    7 +-
 tools/iio/iio_event_monitor.c                 |    6 +
 18 files changed, 2722 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-bno055
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
 create mode 100644 Documentation/iio/bno055.rst
 create mode 100644 drivers/iio/imu/bno055/Kconfig
 create mode 100644 drivers/iio/imu/bno055/Makefile
 create mode 100644 drivers/iio/imu/bno055/bno055.c
 create mode 100644 drivers/iio/imu/bno055/bno055.h
 create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c
 create mode 100644 drivers/iio/imu/bno055/bno055_ser_core.c
 create mode 100644 drivers/iio/imu/bno055/bno055_ser_trace.c
 create mode 100644 drivers/iio/imu/bno055/bno055_ser_trace.h

--
2.17.1
