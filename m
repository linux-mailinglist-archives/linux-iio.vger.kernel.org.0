Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920673CA06A
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 16:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbhGOOUn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 10:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237908AbhGOOUn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Jul 2021 10:20:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A401C06175F;
        Thu, 15 Jul 2021 07:17:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l7so8009300wrv.7;
        Thu, 15 Jul 2021 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PQ0mRS7JGPmYjKtMWt8AoNncND+n747CDg6SOb6Jxew=;
        b=bWErtR3CDd+cf+YpCFvzQQmxRnHzMaQ0CNn8Ik8vGd53X7TWQZLVoh8dc0ZneV1qgB
         t32KuhPlwPlrsG0rYcL7mu8XKypzfCzKgV723C8EWDNPHNC8gGXz67Yw2Cn2oWpRY65T
         +HMw5nv2GMJC50wGaVqkI4R3O1NmQzjroyNVd9PicCG/EBdZy0FHmyMZN1FVOwmKpLka
         E7W6B53CsGfXLzRXj99cUrzz895099ziJBZP2EPjBzB+ilUWWzHxYZ3N9npBNfMJ+p82
         d5zXsHV3G7PQoVgTKoUJHtqZ5H26ZhWUqq3feIG5U7WUTABQnFxzQgofoZtgHatZ39Co
         6ATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PQ0mRS7JGPmYjKtMWt8AoNncND+n747CDg6SOb6Jxew=;
        b=YPcqhPkfC364ah/L5ROVWTDfi7uyrw5H1jP9uueGDeREMA/3aCAlMCGUq1/7RSNJIk
         NAoGg/97dfglohfZAv1G756Qao36QfaAJOwN+/2O6wd1D0k1Z5lYAqM/Gw3MsKqI6cLs
         DPoQWbwfdFy2b3vatZq2Z2qZO+2egTuyGtW1oZAiPZur9J1lpG2pUFn/WOtCOU4hc6R6
         BtKabRwG2eRYKsUebDLTDzGmPgCLayKbQ4fPfelgC1qPr0mZCKC8PVJ1Ud0XWvJlJgKF
         su7Fg6pIrBBLmPCdK3Fn5E8+SBmOjST/b9DBjEyLaTub1pBqOYAXmQozeUrW6NwogLPc
         NGHg==
X-Gm-Message-State: AOAM5321TWGzvjBz5h9ccCcXxmKDy9CGq9l629gCreDmDcJzgyFt/sw0
        6DU1g4nO9mAYF6qP0Y5pAHU=
X-Google-Smtp-Source: ABdhPJy2jO38f7gR15Ikuoe1OibWL20F7ECgujshI8YJJHjeh28EEYfFpUw3f6lgW97h5iBp67MgDQ==
X-Received: by 2002:a5d:6c6e:: with SMTP id r14mr6067703wrz.242.1626358668767;
        Thu, 15 Jul 2021 07:17:48 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id u16sm7989094wrw.36.2021.07.15.07.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 07:17:47 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     robh+dt@kernel.org, matt.ranostay@konsulko.com,
        andriy.shevchenko@linux.intel.com, vlad.dogaru@intel.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 0/4] Add support for Bosch BNO055 IMU
Date:   Thu, 15 Jul 2021 16:17:38 +0200
Message-Id: <20210715141742.15072-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series (tries to) add support for Bosch BNO055 IMU to Linux IIO
subsystem. It is made up four patches:

1/4: adds some IIO modifiers to the IIO core layer, in order to being
     able to expose the linear acceleration among standard attributes.

2/4: adds the core IIO BNO055 driver

3/4: adds DT bindings for the serdev BNO055 driver - Note: I've put
     as "maintainer" the one that ./scripts/get_maintainer.pl suggested
     to me, but I wasn't sure about this.

4/4: adds serdev BNO055 driver to actually use the IMU via serial line

Previously at least another driver for the very same chip has been
posted to the Linux ML [0], but it has been never merged, and it seems
no one cared of it since quite a long time.

This driver differs from the above driver on the following aspects:

- This driver supports serial access, instead of I2C access (however it
  is designed in a modular way that should make it easy to eventually add
  I2C support later on).

- The above driver tried to support all IMU HW modes by allowing to choose
  one in the DT, and adapting IIO attributes accordingly. This driver does
  not rely on DT for this, instead an attribute "operation_mode" is
  exposed. All IIO attributes used in all modes are exposed; more on this
  later on. This driver BTW supports only a subset of the HW-supported
  modes.

- This driver has some support for managing the IMU calibration

This driver supports three operation modes:

  - AMG (accelerometer, magnetometer and gyroscope) mode, which provides
  raw measurements from the said sensors, and allows for setting some
  parameters about them (e.g. filter cut-off frequency, max sensor ranges,
  etc).

  - Two flavors of fusion mode, which still provide AMG measures, while
  they also provide other data calculated by the IMU (e.g. rotation
  angles, linear acceleration, etc). In this mode user has no freedom to
  set any sensor parameter, since the HW locks them.

IIO attributes exposing sensors parameters are always present, but in
fusion modes the available values are constrained to just the one used
by the HW. This is reflected in the '*_available' IIO attributes.

Trying to set a not-supported value always falls back to the closest
supported one, which in this case is just the one in use by the HW.

IIO attributes for unavailable measurements (e.g. Euler angles in AMG
mode) just read zero (which is consistent WRT what you get when reading
from a buffer with those attributes enabled).
Another option could be make them return -EINVAL or to make those
attributes reading as "N/A" or something like that, but in those cases I
wouldn't know what to do with buffers..

About the IMU calibration:

The IMU supports for two sets of calibration parameters:
 - SIC matrix, which has to be provided by the user, and that this driver
   doesn't currently care about of (yet)
 - offset and radius parameters, which the IMU can automatically find
   out, and for which this driver has support

The driver provides access to autocalibration flags (i.e. you can known if
the IMU has successfully autocalibrated) and to calibration data blob.
The user can save this blob in a "firmware" file (i.e. in /lib/firmware)
that the driver looks for at probe time. If found, then the IMU is
initialized with this calibration data. This saves the user from performing
the calibration procedure every time (which consist of moving the IMU in
various way).

The driver looks for calibration data file using two different names:
first a file whose name is suffixed with the IMU unique ID is searched
for; this is useful when there is more than one IMU instance. If this
file is not found, then a "generic" calibration file is searched for
(which can be used when only one IMU is present, without struggling with
fancy names, that change on each device).

In fusion modes the HW applies calibration data to all measurements, while
in AMG mode the calibration data is not used by the HW.

The IIO 'offset' attributes provide access to the offsets from calibration
data, so that the user can apply them to the accel, angvel and magn IIO
attributes.

There is an hack here: since the HW does already apply the offsets when in
fusion modes, then we report 'zero' for all offsets when we are in fusion
modes. In this way offsets can be always applied by the user and this leads
to correct results in all operation modes.

Alternatively we could try to un-correct the measures when in fusion mode,
and let the offset attributes to report actual calibration offset, but this
seems awkward to me, and I can see some problems about races WRT HW
autocalibration (which always run in background anyway).

The last alternative could be to expose two sets of IIO attributes for
accel, anglvel and magn measures, which would refer to the same registers
indeed; one attribute set has associated offsets, while the other hasn't.
Then we make only one set "readable", depending by the current operation
mode. Unfortunately they would all still be "raw" anyway, since they still
need to get the 'scale' attribute applied. Furthermore this may complicate
things with buffer and bursts handling.

I've implemented the 1st solution because IMHO it's simpler and still
reasonably coherent.

About access protocol and serdev module:

The serial protocol is quite simple, but there are tricks to make it
really works. Those tricks and workarounds are documented in the driver
source file.

The core BNO055 driver tries to group readings in burst when appropriate,
in order to optimize triggered buffer operation. The threshold for
splitting a burst (i.e. max number of unused bytes in the middle of a
burst that will be throw away) is provided to the core driver by the
lowlevel access driver (which is the bno055_sl serdev driver indeed) at
probe time.

If an I2C access driver will be written, then it can provide its own
threshold value (which depends by the protocol overhead, etc..) to the
core bno055 driver.

Finally, I wrote and tested this driver on a Zynq-based custom board that
runs a kernel v5.4 and I've rebased on latest mainline tree on which I've
just compile-tested.

[0] https://www.spinics.net/lists/linux-iio/msg25508.html

Andrea Merello (4):
  iio: add modifiers for linear acceleration
  iio: imu: add Bosch Sensortec BNO055 core driver
  dt-bindings: iio: imu: add bosch BNO055 serdev driver bindings
  iio: imu: add BNO055 serdev driver

 .../bindings/iio/imu/bosch,bno055-serial.yaml |   40 +
 drivers/iio/imu/Kconfig                       |    1 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/bno055/Kconfig                |   12 +
 drivers/iio/imu/bno055/Makefile               |    7 +
 drivers/iio/imu/bno055/bno055.c               | 1361 +++++++++++++++++
 drivers/iio/imu/bno055/bno055.h               |   12 +
 drivers/iio/imu/bno055/bno055_sl.c            |  576 +++++++
 drivers/iio/industrialio-core.c               |    3 +
 include/uapi/linux/iio/types.h                |    4 +-
 10 files changed, 2016 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055-serial.yaml
 create mode 100644 drivers/iio/imu/bno055/Kconfig
 create mode 100644 drivers/iio/imu/bno055/Makefile
 create mode 100644 drivers/iio/imu/bno055/bno055.c
 create mode 100644 drivers/iio/imu/bno055/bno055.h
 create mode 100644 drivers/iio/imu/bno055/bno055_sl.c

--
2.17.1
