Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F0443DEDE
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhJ1KdP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhJ1KdP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 06:33:15 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AA9461056;
        Thu, 28 Oct 2021 10:30:44 +0000 (UTC)
Date:   Thu, 28 Oct 2021 11:35:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org
Subject: Re: [v2 00/10] Add support for Bosch BNO055 IMU
Message-ID: <20211028113511.13803ecb@jic23-huawei>
In-Reply-To: <20211028101840.24632-1-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20211028101840.24632-1-andrea.merello@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andrea,

I'd advise not sending new versions of a series with the in-reply-to set
to an older version.  It's a good way to ensure anyone using an email client
handling threads never sees them...  It also gets very messy if we happen
to get replies to multiple versions overlapping.

New version, new email thread.

On Thu, 28 Oct 2021 12:18:30 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> This series (tries to) add support for Bosch BNO055 IMU to Linux IIO
> subsystem. It is made up several patches:
> 
>   1/10: introduces the generic helper find_closest_unsorted()
> 
>   2/10 to 5/10: add some IIO modifiers, and their documentation, to the IIO
>                 core layer, in order to being able to expose the linear
>                 acceleration and Euler angles among standard attributes.
> 
>   6/10 to 8/10: add the core IIO BNO055 driver and its documentation
>      	        (including documentation for DT bindings)
> 
>   9/10: adds serdev BNO055 driver to actually use the IMU via serial line
> 
>   10/10: adds I2C BNO055 driver to actually use the IMU via I2C wiring
> 
> 
> Differences wrt v1:
> 
>   - Fixed GPL license version, which was wrong due to bad copy-pastes
> 
>   - Make less noise in log and get rid of some dev_dbg()s
> 
>   - Fix deferred probe handing and fix devm_add_action_or_reset() usage
> 
>   - Get rid of unneeded zeroing for driver data and some IIO "val2"s
> 
>   - Get rid of some leftovers of my attempt to support interrupts (which
>     don't fully work unless the IMU firmware gets updated)
> 
>   - Move IIO buffer off stack and make sure its first zeroed not to leak
>     kernel data
> 
>   - Hopefully addressed all maintainers and reviewers stylistic advices;
>     fixed some typos
> 
>   - Take advantage of more kernel helpers. Note: this series depends on
>     Yury Norov bitmap series i.e. "[PATCH 14/16] bitmap: unify find_bit
>     operations"
> 
>   - Make find_closest_unsorted() become an external generic helper
> 
>   - Reworked sysfs ABI as per maintainers advices
> 
>   - Added ABI documentation where needed
> 
>   - Added I2C support
> 
>   - Reworked DT documentation as per maintainers advices. Added I2C example
> 
>   The serial protocol handling have been criticized because it is not very
>   robust, however I couldn't really find any way to improve it; no changes
>   here wrt v1. I think the protocol itself is inherently weak and there is
>   nothing we can do about this (BTW here it is working fine).
> 
> Differences wrt other BNO055 drivers:
> 
>   Previously at least another driver for the very same chip has been posted
>   to the Linux ML [0], but it has been never merged, and it seems no one
>   cared of it since quite a long time.
> 
>   This driver differs from the above driver on the following aspects:
> 
>   - This driver supports also serial access
> 
>   - The above driver tried to support all IMU HW modes by allowing to
>     choose one in the DT, and adapting IIO attributes accordingly. This
>     driver does not rely on DT for this, instead settings are done via
>     sysfs attributes.  All IIO attributes are always exposed; more on this
>     later on. This driver however supports only a subset of the
>     HW-supported modes.
> 
>   - This driver has some support for managing the IMU calibration
> 
> Supported operation modes:
> 
>   - AMG (accelerometer, magnetometer and gyroscope) mode, which provides
>     raw (uncalibrated) measurements from the said sensors, and allows for
>     setting some parameters about them (e.g. filter cut-off frequency, max
>     sensor ranges, etc).
> 
>   - Fusion mode, which still provides AMG measures, while it also provides
>     other data calculated by the IMU (e.g. rotation angles, linear
>     acceleration, etc). In this mode user has no freedom to set any sensor
>     parameter, since the HW locks them. Autocalibration and correction is
>     performed by the IMU.
> 
>   IIO attributes exposing sensors parameters are always present, but in
>   fusion modes the available values are constrained to just the one used by
>   the HW. This is reflected in the '*_available' IIO attributes.
> 
>   Trying to set a not-supported value always falls back to the closest
>   supported one, which in this case is just the one in use by the HW.
> 
>   IIO attributes for unavailable measurements (e.g. Euler angles in AMG
>   mode) just read zero (which is consistent WRT what you get when reading
>   from a buffer with those attributes enabled).
> 
> IMU calibration:
> 
>   The IMU supports for two sets of calibration parameters:
> 
>   - SIC matrix. user-provided; this driver doesn't currently support it
> 
>   - Offset and radius parameters. The IMU automatically finds out them when
>     it is running in fusion mode; supported by this driver.
> 
>   The driver provides access to autocalibration flags (i.e. you can known
>   if the IMU has successfully autocalibrated) and to calibration data blob.
>   The user can save this blob in a "firmware" file (i.e. in /lib/firmware)
>   that the driver looks for at probe time. If found, then the IMU is
>   initialized with this calibration data. This saves the user from
>   performing the calibration procedure every time (which consist of moving
>   the IMU in various way).
> 
>   The driver looks for calibration data file using two different names:
>   first a file whose name is suffixed with the IMU unique ID is searched
>   for; this is useful when there is more than one IMU instance. If this
>   file is not found, then a "generic" calibration file is searched for
>   (which can be used when only one IMU is present, without struggling with
>   fancy names, that changes on each device).
> 
>   In AMG mode the IIO 'offset' attributes provide access to the offsets
>   from calibration data (if any), so that the user can apply them to the
>   accel, angvel and magn IIO attributes. In fusion mode they are not needed
>   and read as zero.
> 
> 
> Access protocols and serdev module:
> 
>   The serial protocol is quite simple, but there are tricks to make it
>   really works. Those tricks and workarounds are documented in the driver
>   source file.
> 
>   The core BNO055 driver tries to group readings in burst when appropriate,
>   in order to optimize triggered buffer operation. The threshold for
>   splitting a burst (i.e. max number of unused bytes in the middle of a
>   burst that will be throw away) is provided to the core driver by the
>   lowlevel access driver (either serdev or I2C) at probe time.
> 
> [0] https://www.spinics.net/lists/linux-iio/msg25508.html
> 
> Andrea Merello (10):
>   utils_macro: introduce find_closest_unsorted()
>   iio: document linear acceleration modifiers
>   iio: document euler angles modifiers
>   iio: add modifiers for linear acceleration
>   iio: add modifers for pitch, yaw, roll
>   iio: document bno055 private sysfs attributes
>   iio: imu: add Bosch Sensortec BNO055 core driver
>   dt-bindings: iio: imu: add documentation for Bosch BNO055 bindings
>   iio: imu: add BNO055 serdev driver
>   iio: imu: add BNO055 I2C driver
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |   16 +
>  .../ABI/testing/sysfs-bus-iio-bno055          |   84 +
>  .../bindings/iio/imu/bosch,bno055.yaml        |   59 +
>  drivers/iio/imu/Kconfig                       |    1 +
>  drivers/iio/imu/Makefile                      |    1 +
>  drivers/iio/imu/bno055/Kconfig                |   15 +
>  drivers/iio/imu/bno055/Makefile               |    5 +
>  drivers/iio/imu/bno055/bno055.c               | 1485 +++++++++++++++++
>  drivers/iio/imu/bno055/bno055.h               |   12 +
>  drivers/iio/imu/bno055/bno055_i2c.c           |   54 +
>  drivers/iio/imu/bno055/bno055_sl.c            |  568 +++++++
>  drivers/iio/industrialio-core.c               |    6 +
>  include/linux/util_macros.h                   |   26 +
>  include/uapi/linux/iio/types.h                |    7 +-
>  14 files changed, 2338 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-bno055
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
>  create mode 100644 drivers/iio/imu/bno055/Kconfig
>  create mode 100644 drivers/iio/imu/bno055/Makefile
>  create mode 100644 drivers/iio/imu/bno055/bno055.c
>  create mode 100644 drivers/iio/imu/bno055/bno055.h
>  create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c
>  create mode 100644 drivers/iio/imu/bno055/bno055_sl.c
> 
> --
> 2.17.1

