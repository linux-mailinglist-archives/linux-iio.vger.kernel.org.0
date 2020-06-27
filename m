Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A6620C1C1
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jun 2020 15:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgF0N3h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jun 2020 09:29:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgF0N3h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jun 2020 09:29:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D837B20885;
        Sat, 27 Jun 2020 13:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593264576;
        bh=bYRgBNnkNpkhq+5KsbmZ23kTjQ4YEcihVz5msz6QX6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ISLsKv7lswwBX0YXGOxRlv6mx3SzMEnQNIm4PXazGlt5GVbGFdmHPNJ+RR2M5Fhip
         CzufdX98ZclkKj8hh0YCgpzadpiNnz2vW/r59/ZMILWkmyfxX5Vyzo37Pj3tYzy02G
         pSIGHWb6G3X3XpUAG+qnyvfIiXF6qOPHthQw8sHg=
Date:   Sat, 27 Jun 2020 14:29:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     robh+dt@kernel.org, robh@kernel.org, mchehab+huawei@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/13] iio: imu: new inv_icm42600 driver
Message-ID: <20200627142931.4a522c6e@archlinux>
In-Reply-To: <20200622153729.12702-1-jmaneyrol@invensense.com>
References: <20200622153729.12702-1-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Jun 2020 17:37:16 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

Looks good to me.  Whole series applied (picking up Rob's ack
for the DT binding docs patch) to the togreg branch of iio.git and pushed
out as testing for the various autobuilders to poke at it.

Thanks,

Jonathan

> Changelog
> v1
>   -initial patch submission
> v2
>   - formatting reworks, missing headers, code cleanup ...
>   - delete all debug traces
>   - add commentaries for better explanation of suspend/resume, timestamp, ...
>   - delete i2c/spi table ids keeping only of, and use I2C probe_new function
>   - switch calibbias to SI units and add calibias_available attribute
>   - use DMA-safe buffer for all regmap_bulk_* calls
>   - delete iio trigger usage and setup/handle interrupt in core module
>   - add open-drain interrupt support
>   - add FIFO on reference counter and buffer postenable/predisable to replace
>     iio trigger usage
>   - check that temperature data is present before copying in buffer
>   - add temperature sensor off when fifo is turned off
>   - delete timestamp channel reading
>   - move timestamp state in IIO device private data
>   - allow only 1 ODR change in a batch of data
>   - add driver-open-drain in devicetree YAML and delete spi options
> v3
>   - delete const pointer cast for iio_device_get_drvdata
>   - change gyro and accel init to return the allocated iio_dev structure
>   - delete manual parent device assignment
>   - correct style and improve readability
>   - add commentaries about IIO buffer and watermark complex computation
>   - add timestamp alignment in IIO buffer structure
>   - wrap lines 80 columns for dt bindings
>   - add ABI documentation for calibbias values in SI units
> v4
>   - return high resolution 16 bits temperature as raw data when polled with the
>     corresponding scale and offset.
>   - for data buffer return temperature in the same 16 bits using the same
>     scale and offset. Convert low resolution temperature FIFO data to high
>     resolution format.
>   - explicitely zero out data buffer before copying to iio buffer.
> 
> This series add a new driver for managing InvenSense ICM-426xx 6-axis IMUs.
> This next generation of chips includes new generations of 3-axis gyroscope
> and 3-axis accelerometer, support of I3C in addition to I2C and SPI, and
> intelligent MotionTracking features like pedometer, tilt detection, and
> tap detection.
> 
> This series is delivering a driver supporting gyroscope, accelerometer and
> temperature data, with polling and buffering using hwfifo and watermark,
> on I2C and SPI busses.
> 
> Gyroscope and accelerometer sensors are completely independent and can have
> different ODRs. Since there is only a single FIFO a specific value is used to
> mark invalid data. For keeping the device standard we are de-multiplexing data
> from the FIFO to 2 IIO devices with 2 buffers, 1 for the accelerometer and 1
> for the gyroscope. This architecture also enables to easily turn each sensor
> on/off without impacting the other. The device interrupt is used to read the
> FIFO and launch parsing of accelerometer and gyroscope data. A complex
> timestamping mechanism is added to handle correctly FIFO watermark and dynamic
> changes of settings.
> 
> 
> 
> Jean-Baptiste Maneyrol (13):
>   iio: imu: inv_icm42600: add core of new inv_icm42600 driver
>   iio: imu: inv_icm42600: add I2C driver for inv_icm42600 driver
>   iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver
>   iio: imu: inv_icm42600: add gyroscope IIO device
>   iio: imu: inv_icm42600: add accelerometer IIO device
>   iio: imu: inv_icm42600: add temperature sensor support
>   iio: imu: add Kconfig and Makefile for inv_icm42600 driver
>   Documentation: ABI: add specific icm42600 documentation
>   iio: imu: inv_icm42600: add device interrupt
>   iio: imu: inv_icm42600: add buffer support in iio devices
>   iio: imu: inv_icm42600: add accurate timestamping
>   dt-bindings: iio: imu: Add inv_icm42600 documentation
>   MAINTAINERS: add entry for inv_icm42600 6-axis imu sensor
> 
>  .../ABI/testing/sysfs-bus-iio-icm42600        |  20 +
>  .../bindings/iio/imu/invensense,icm42600.yaml |  90 ++
>  MAINTAINERS                                   |   8 +
>  drivers/iio/imu/Kconfig                       |   1 +
>  drivers/iio/imu/Makefile                      |   1 +
>  drivers/iio/imu/inv_icm42600/Kconfig          |  29 +
>  drivers/iio/imu/inv_icm42600/Makefile         |  15 +
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h   | 395 +++++++++
>  .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 787 +++++++++++++++++
>  .../imu/inv_icm42600/inv_icm42600_buffer.c    | 601 +++++++++++++
>  .../imu/inv_icm42600/inv_icm42600_buffer.h    |  98 +++
>  .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 786 +++++++++++++++++
>  .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 798 ++++++++++++++++++
>  .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 101 +++
>  .../iio/imu/inv_icm42600/inv_icm42600_spi.c   | 100 +++
>  .../iio/imu/inv_icm42600/inv_icm42600_temp.c  |  84 ++
>  .../iio/imu/inv_icm42600/inv_icm42600_temp.h  |  30 +
>  .../imu/inv_icm42600/inv_icm42600_timestamp.c | 195 +++++
>  .../imu/inv_icm42600/inv_icm42600_timestamp.h |  85 ++
>  19 files changed, 4224 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-icm42600
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
>  create mode 100644 drivers/iio/imu/inv_icm42600/Kconfig
>  create mode 100644 drivers/iio/imu/inv_icm42600/Makefile
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600.h
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.h
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
> 

