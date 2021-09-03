Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA827400179
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 16:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349499AbhICOs4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 10:48:56 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51441 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349248AbhICOs4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 10:48:56 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D548460008;
        Fri,  3 Sep 2021 14:47:53 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linux-iio@vger.kernel.org
Subject: [PATCH v4 0/3] iio: chemical: Add Senseair Sunrise CO2 sensor
Date:   Fri,  3 Sep 2021 16:48:25 +0200
Message-Id: <20210903144828.497166-1-jacopo@jmondi.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver supports continuous reads of temperature and CO2 concentration
through two dedicated IIO channels. It also supports calibration and error
inspection through the concentration channel ext_info.

A few substantial changes in v4, mostly in the calibration attributes
definition but also in the driver code

v3->v4
 - Rebased on v5.14
 - Remove unneeded Kconfig symbol dependencies
 - Remove unused header inclusion
 - Lock access to calibration and error status
 - Fix temperature scale
 - Fix for_each_set_bit()
 - Drop a few fields from driver's main structure
 - Lock the 'wakeup' session with an additional mutex
 - Disable regmap locking as the access to the i2c bus is now externally locked
 - Rework the calibration attributes defintion: one attribute per calibration
   mode
 - Make 'error_status' attributes SHARED_BY_ALL
 - Replace regmap_read_poll_timeout() with read_poll_timeout() to use
   the driver's byte read function that performs the proper chip 'wakeup'.
   It used to work with the previous version too, a few spurious NAK apart but
   this seems cleaner and allows to relax the sleep time
 - Update ABI documentation according to the new attributes layout
 - Remove label from bindings doc

v2->v3:
- [1/3]
 - Fix syntax error reported by dt_binding_check
   The device node label in the example cannot contain '-'
 - Add 'Typically' to the gpios polarities description

- [2/3]
 - As suggested by Andy:
   - depends on OF, SYSFS; select REGMAP_I2C
   - Fix style issues:
     - span over 80 cols where appropriate
     - remove , in last entries of all arrays
     - use for_each_set_bit in sunrise_error_status_read()
     - minor style issues (brakets, empty lines, wording)

v1->v2:
- Add ABI documentation in [3/3]
- [1/3]
  - Address Rob's comments on missing maxItem and add device node label
  - Do not change the pin's polarity description as suggested by Andy due to
    conflicting suggestions
- [2/3]
  - Expand Kconfig symbol name and change driver's name as suggested by Andy
  - Use regmap instead of raw smbus calls as suggested by Andy
  - Take into account minor style comments from Andy
  - Install channel's ext_info to support calibration triggering and enumerate
    calibration modes and error status
  - Matt suggested to use sysfs attributes, but I found the per-channel
    attributes more appropriate. Hope this is good as well.


Jacopo Mondi (3):
  dt-bindings: iio: chemical: Document senseair,sunrise CO2 sensor
  iio: chemical: Add Senseair Sunrise 006-0-007 driver
  iio: ABI: docs: Document Senseair Sunrise ABI

 .../sysfs-bus-iio-chemical-sunrise-co2        |  38 ++
 .../iio/chemical/senseair,sunrise.yaml        |  55 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/iio/chemical/Kconfig                  |  10 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/sunrise_co2.c            | 462 ++++++++++++++++++
 7 files changed, 574 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
 create mode 100644 drivers/iio/chemical/sunrise_co2.c

--
2.32.0

