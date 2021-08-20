Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D433F2D3D
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 15:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhHTNiV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 09:38:21 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:53765 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhHTNiV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 09:38:21 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 8902C24000F;
        Fri, 20 Aug 2021 13:37:38 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 0/3]  iio: chemical: Add Senseair Sunrise CO2 sensor
Date:   Fri, 20 Aug 2021 15:38:18 +0200
Message-Id: <20210820133821.159239-1-jacopo@jmondi.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

v2 of the driver for Senseair Sunrise 006-0-0007 CO2 sensor.

The driver supports continuous reads of temperature and CO2 concentration
through two dedicated IIO channels. It also supports calibration and error
inspection through the concentration channel ext_info.

Changelog:

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
 .../iio/chemical/senseair,sunrise.yaml        |  53 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/iio/chemical/Kconfig                  |  10 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/sunrise_co2.c            | 458 ++++++++++++++++++
 7 files changed, 581 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
 create mode 100644 drivers/iio/chemical/sunrise_co2.c

--
2.32.0

