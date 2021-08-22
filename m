Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3883F40FA
	for <lists+linux-iio@lfdr.de>; Sun, 22 Aug 2021 20:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhHVSt2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Aug 2021 14:49:28 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:51219 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhHVSt2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Aug 2021 14:49:28 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 865CB40006;
        Sun, 22 Aug 2021 18:48:44 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linux-iio@vger.kernel.org
Subject: [PATCH v3 0/3] iio: chemical: Add Senseair Sunrise CO2 sensor
Date:   Sun, 22 Aug 2021 20:49:24 +0200
Message-Id: <20210822184927.94673-1-jacopo@jmondi.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver supports continuous reads of temperature and CO2 concentration
through two dedicated IIO channels. It also supports calibration and error
inspection through the concentration channel ext_info.

Minor changes in v3

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

Thanks
   j

Jacopo Mondi (3):
  dt-bindings: iio: chemical: Document senseair,sunrise CO2 sensor
  iio: chemical: Add Sensteair Sunrise 006-0-007 driver
  iio: ABI: docs: Document Senseair Sunrise ABI

 .../sysfs-bus-iio-chemical-sunrise-co2        |  51 ++
 .../iio/chemical/senseair,sunrise.yaml        |  53 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/iio/chemical/Kconfig                  |  13 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/sunrise_co2.c            | 450 ++++++++++++++++++
 7 files changed, 576 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
 create mode 100644 drivers/iio/chemical/sunrise_co2.c

--
2.32.0

