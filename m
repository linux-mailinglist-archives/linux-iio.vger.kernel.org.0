Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB5B43DE93
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhJ1KVS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhJ1KVQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 06:21:16 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB483C061570;
        Thu, 28 Oct 2021 03:18:49 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z20so22869047edc.13;
        Thu, 28 Oct 2021 03:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xdf+mQIMWQM/YjFwsIXE5lH5ekycTET8WYPUaao153s=;
        b=ddDZgzkqtf4yZWP8Mw0zoj1fpeXl5ggzt2+iVD3pNBXP0FsRSeR0ctEusqVUfNSiyL
         usPEukFAJWlNJby/vns9arBMn5Yt32JHG4VD40+1lZJ/eEMTVRd7lYtCDE2GI2fEXB1s
         p3zFTJqttU63uelAFRxYKUQtGWsTzapxGUGo07h5CG0zxjs2F5UvLPjVS5xPszH7kMia
         3rth/28H2ScG+EU/bt3srUMGQZlbjvrI6PYDjDR/RFs2lBNRpX4YMmrhV44/0xKtChzZ
         1E23lFUlhO3tm26vc+54buip1ebNAfHS8qYYaQPBjncCUgYc+Sad5K1923jWViS1qK6f
         3C2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xdf+mQIMWQM/YjFwsIXE5lH5ekycTET8WYPUaao153s=;
        b=xEgdkH2souZ7k8dH6SPzvoD19PwkBxPK3OVwIvFgKjY8cYeTf6JWHarnzfd+Bgxi9K
         /PZRDgzyWAa3S7BRQRjzsawD0y3j3ICjH/JHWJ9FfKKCtAhxLhrFL/XqYEQUhA6CBzEl
         yWeiAgtmj44xe6V4b1OfioXi3f8bl3TIFqo7eVqJ0PmrJfdKj8xLHyjvnyHWHaIvEf28
         cxfMoKf382O/Re3iPb0+dK1K+fONqjCnycezLpb6tPe9BLyi0ai/MH9SWjP3PolybjqE
         YEZ1irwgWX/G3DVrXJd4Cs/t5t5+Ckz0LSGrkFNJ4LwlV6pLCRh8arChl4L8hhZQ3J5y
         owZw==
X-Gm-Message-State: AOAM533TlOhy0FaDVLqyWxv60vnVaD3S3mnHkSiBjSumI46YUn8ddvbM
        0qbyLoNxR/Of+DenWi8L38U=
X-Google-Smtp-Source: ABdhPJxaq1HwO1uKNXQlrLO9tb946MrxwtxjzRyC7IIedIBZudGsS4zhJdFyYbjh2W6uINxUCmmcCw==
X-Received: by 2002:a05:6402:1d52:: with SMTP id dz18mr4939336edb.398.1635416328438;
        Thu, 28 Oct 2021 03:18:48 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.googlemail.com with ESMTPSA id mp9sm1175071ejc.48.2021.10.28.03.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:18:48 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org
Subject: [v2 00/10] Add support for Bosch BNO055 IMU
Date:   Thu, 28 Oct 2021 12:18:30 +0200
Message-Id: <20211028101840.24632-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715141742.15072-1-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series (tries to) add support for Bosch BNO055 IMU to Linux IIO
subsystem. It is made up several patches:

  1/10: introduces the generic helper find_closest_unsorted()

  2/10 to 5/10: add some IIO modifiers, and their documentation, to the IIO
                core layer, in order to being able to expose the linear
                acceleration and Euler angles among standard attributes.

  6/10 to 8/10: add the core IIO BNO055 driver and its documentation
     	        (including documentation for DT bindings)

  9/10: adds serdev BNO055 driver to actually use the IMU via serial line

  10/10: adds I2C BNO055 driver to actually use the IMU via I2C wiring


Differences wrt v1:

  - Fixed GPL license version, which was wrong due to bad copy-pastes

  - Make less noise in log and get rid of some dev_dbg()s

  - Fix deferred probe handing and fix devm_add_action_or_reset() usage

  - Get rid of unneeded zeroing for driver data and some IIO "val2"s

  - Get rid of some leftovers of my attempt to support interrupts (which
    don't fully work unless the IMU firmware gets updated)

  - Move IIO buffer off stack and make sure its first zeroed not to leak
    kernel data

  - Hopefully addressed all maintainers and reviewers stylistic advices;
    fixed some typos

  - Take advantage of more kernel helpers. Note: this series depends on
    Yury Norov bitmap series i.e. "[PATCH 14/16] bitmap: unify find_bit
    operations"

  - Make find_closest_unsorted() become an external generic helper

  - Reworked sysfs ABI as per maintainers advices

  - Added ABI documentation where needed

  - Added I2C support

  - Reworked DT documentation as per maintainers advices. Added I2C example

  The serial protocol handling have been criticized because it is not very
  robust, however I couldn't really find any way to improve it; no changes
  here wrt v1. I think the protocol itself is inherently weak and there is
  nothing we can do about this (BTW here it is working fine).

Differences wrt other BNO055 drivers:

  Previously at least another driver for the very same chip has been posted
  to the Linux ML [0], but it has been never merged, and it seems no one
  cared of it since quite a long time.

  This driver differs from the above driver on the following aspects:

  - This driver supports also serial access

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
  mode) just read zero (which is consistent WRT what you get when reading
  from a buffer with those attributes enabled).

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

Andrea Merello (10):
  utils_macro: introduce find_closest_unsorted()
  iio: document linear acceleration modifiers
  iio: document euler angles modifiers
  iio: add modifiers for linear acceleration
  iio: add modifers for pitch, yaw, roll
  iio: document bno055 private sysfs attributes
  iio: imu: add Bosch Sensortec BNO055 core driver
  dt-bindings: iio: imu: add documentation for Bosch BNO055 bindings
  iio: imu: add BNO055 serdev driver
  iio: imu: add BNO055 I2C driver

 Documentation/ABI/testing/sysfs-bus-iio       |   16 +
 .../ABI/testing/sysfs-bus-iio-bno055          |   84 +
 .../bindings/iio/imu/bosch,bno055.yaml        |   59 +
 drivers/iio/imu/Kconfig                       |    1 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/bno055/Kconfig                |   15 +
 drivers/iio/imu/bno055/Makefile               |    5 +
 drivers/iio/imu/bno055/bno055.c               | 1485 +++++++++++++++++
 drivers/iio/imu/bno055/bno055.h               |   12 +
 drivers/iio/imu/bno055/bno055_i2c.c           |   54 +
 drivers/iio/imu/bno055/bno055_sl.c            |  568 +++++++
 drivers/iio/industrialio-core.c               |    6 +
 include/linux/util_macros.h                   |   26 +
 include/uapi/linux/iio/types.h                |    7 +-
 14 files changed, 2338 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-bno055
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
 create mode 100644 drivers/iio/imu/bno055/Kconfig
 create mode 100644 drivers/iio/imu/bno055/Makefile
 create mode 100644 drivers/iio/imu/bno055/bno055.c
 create mode 100644 drivers/iio/imu/bno055/bno055.h
 create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c
 create mode 100644 drivers/iio/imu/bno055/bno055_sl.c

--
2.17.1
