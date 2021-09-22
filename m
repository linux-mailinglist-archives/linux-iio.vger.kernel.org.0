Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE164146B8
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 12:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhIVKlo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 06:41:44 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:32844 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbhIVKlM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 06:41:12 -0400
Received: from ert768.prtnl (ert768.prtnl [192.168.224.11])
        by sparta.prtnl (Postfix) with ESMTP id 1E0E544A024E;
        Wed, 22 Sep 2021 12:39:36 +0200 (CEST)
From:   Roan van Dijk <roan@protonic.nl>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>,
        Roan van Dijk <roan@protonic.nl>
Subject: [PATCH v3 0/4] iio: chemical: Add support for Sensirion SCD4x CO2 sensor
Date:   Wed, 22 Sep 2021 12:39:21 +0200
Message-Id: <20210922103925.2742362-1-roan@protonic.nl>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series adds support for the Sensirion SCD4x sensor.

The driver supports continuous reads of temperature, relative humdity and CO2
concentration. There is an interval of 5 seconds between readings. During
this interval the drivers checks if the sensor has new data available.

The driver is based on the scd30 driver. However, The scd4x has become too
different to just expand the scd30 driver. I made a new driver instead of
expanding the scd30 driver. I hope I made the right choice by doing so?

Changes since v3:
scd4x.c
  - Change read and write_and_fetch function parameter. CRC byte is now
    hidden inside the function.
  - Fix minor style issues
  - Add calibration_forced_value_available attribute to the driver
  - Remove including BUFFER_TRIGGERED
  - Change calibbias to raw ADC readings rather than converting it to
    milli degrees C.
Documentation:
  - Change description of driver attributes
  - Add calibration_forced_value_available documentation

Changes since v2:
scd4x.c:
  - Change boolean operations
  - Document scope of lock
  - Remove device *dev from struct
  - Add goto block for errror handling
  - Add function to read value per channel in read_raw
  - Fix bug with lock in error paths
  - Remove conversion of humidity and temperature values
  - Add scale and offset to temperature channel
  - Add scale to humidity channel
  - Move memset out of locked section
  - Remove unused irq functions
  - Move device register at end of probe function
Documentation:
  - Copy content of sysfs-bus-iio-scd30 to sysfs-bus-iio
  - Remove Documentation/ABI/testing/sysfs-bus-iio-scd30

Changes since v1:
dt-bindings:
  - Separated compatible string for each sensor type
scd4x.c:
  - Changed probe, resume and suspend functions to static
  - Added SIMPLE_DEV_PM_OPS function call for power management
    operations.

Roan van Dijk (4):
  dt-bindings: iio: chemical: sensirion,scd4x: Add yaml description
  MAINTAINERS: Add myself as maintainer of the scd4x driver
  drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor
  iio: documentation: Document scd4x calibration use

 Documentation/ABI/testing/sysfs-bus-iio       |  41 ++
 Documentation/ABI/testing/sysfs-bus-iio-scd30 |  34 -
 .../iio/chemical/sensirion,scd4x.yaml         |  46 ++
 MAINTAINERS                                   |   6 +
 drivers/iio/chemical/Kconfig                  |  13 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/scd4x.c                  | 694 ++++++++++++++++++
 7 files changed, 801 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
 create mode 100644 drivers/iio/chemical/scd4x.c

-- 
2.30.2

