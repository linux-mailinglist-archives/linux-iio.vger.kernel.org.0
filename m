Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A52264B94
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgIJRkT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgIJRfP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:35:15 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3736920C09;
        Thu, 10 Sep 2020 17:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759312;
        bh=CNVy0FOT+q6i29HvfkATWUfTUZMcyKphyuFSYLf67Js=;
        h=From:To:Cc:Subject:Date:From;
        b=tEPTMFKtGJRNNzS3PxqJrD7Wu5M2ZS+On2RGBEKGsjYuGhoZAGm2nifmvOoIg3pcV
         LvMYB2bqVmCnDSkWSWO8aQhmJbBw2AL48IHKwbhA4ccxdN0aDEyWQnS/TnAT5clVUX
         nV25iBZlJJqmmIfbELQ9jEUI1TTSu5V413h7EYdU=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/38] iio: remaining easy of_match_ptr removal and related.
Date:   Thu, 10 Sep 2020 18:32:04 +0100
Message-Id: <20200910173242.621168-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This bumper set removes all the remaining cases where of_match_ptr
is mostly serving to prevent use of the device via ACPI PRP0001 and
complicating the code. The main aim of this set is to reduce the chances
of it being used in future drivers.
It also includes some related refactorings, use of generic fw accessors,
dropping of CONFIG_OF and lots of header changes inline with the above.

For examples of how to use PRP0001 see https://github.com/westeri/meta-acpi
which is an excellent resource from which to copy snippets of DSDT tables.

It may well not be worth changing the remaining 10 IIO drivers and I
certainly don't plan to do so anytime soon.

Jonathan Cameron (38):
  iio:potentiometer:ad5272: Drop of_match_ptr and CONFIG_OF protections.
  iio:potentiometer:ds1803: Drop of_match_ptr and CONFIG_OF protections
  iio:potentiometer:max5432: Drop of_match_ptr and use generic fw
    accessors
  iio:potentiometer:max5481: Drop of_match_ptr and CONFIG_OF
    protections.
  iio:potentiometer:max5481: Drop invalid ACPI binding.
  iio:potentiometer:mcp4018: Drop of_match_ptr and CONFIG_OF
    protections.
  iio:potentiometer:mcp4131: Drop of_match_ptr and use generic fw
    interfaces.
  iio:potentiometer:mcp4531: Drop of_match_ptr and CONFIG_OF
    protections.
  iio:dac:ad5446: Drop of_match_ptr and CONFIG_OF protections
  iio:dac:ad5592r: Drop of_match_ptr and ACPI_PTR protections.
  iio:dac:ad5593r: Drop of_match_ptr and ACPI_PTR protections.
  iio:dac:ad7303: Drop of_match_ptr protection
  iio:dac:mcp4725: drop of_match_ptr and use generic fw properties
  iio:dac:ti-dac082s085: Drop of_match_ptr and CONFIG_OF protections
  iio:dac:ti-dac5571: Drop of_match_ptr and CONFIG_OF protections
  iio:potentiostat:lmp91000: Drop of_match_ptr and use generic fw
    accessors
  iio:pressure:icp10100: Drop of_match_ptr and CONFIG_OF protections
  iio:pressure:ms5611: Drop of_match_ptr and CONFIG_OF protections
  iio:pressure:ms5637: Drop of_match_ptr protection
  iio:pressure:zpa2326: Drop of_match_ptr protection
  iio:temperature:tsys01: Drop of_match_ptr protection
  iio:temperature:tmp007: Drop of_match_ptr protection
  iio:resolver:ad2s1200: Drop of_match_ptr protection
  iio:chemical:ams-iaq-core: Drop of_match_ptr protection
  iio:chemical:atlas-sensor: Drop of_match_ptr and use generic fw
    accessors
  iio:chemical:sgp30: Use local variable dev to simplify code
  iio:chemical:sgp30: Drop of_match_ptr and use generic fw accessors
  iio:chemical:vz89x: Introduce local struct device pointer.
  iio:chemical:vz89x: Drop of_match_ptr protection and use generic fw
    accessors
  iio:humidity:hdc100x: Drop of_match_ptr protection.
  iio:proximity:as3935: Use local struct device pointer to simplify
    code.
  iio:proximity:as3935: Drop of_match_ptr and use generic fw accessors
  iio:proximity:pulsedlight: Drop of_match_ptr protection
  iio:magn:ak8975: Drop of_match_ptr and ACPI_PTR protections.
  iio:magn:ak8974: Drop of_match_ptr protection
  iio:humidity:htu21: Drop of_match_ptr protection
  iio:humidity:si7020: Drop of_match_ptr protection
  iio:health:max30102: Drop of_match_ptr and use generic fw accessors

 drivers/iio/chemical/ams-iaq-core.c           |  3 +-
 drivers/iio/chemical/atlas-sensor.c           | 10 ++---
 drivers/iio/chemical/sgp30.c                  | 28 ++++++------
 drivers/iio/chemical/vz89x.c                  | 18 ++++----
 drivers/iio/dac/ad5446.c                      |  5 +--
 drivers/iio/dac/ad5592r.c                     |  7 ++-
 drivers/iio/dac/ad5593r.c                     |  7 ++-
 drivers/iio/dac/ad7303.c                      |  3 +-
 drivers/iio/dac/mcp4725.c                     | 29 +++---------
 drivers/iio/dac/ti-dac082s085.c               |  5 +--
 drivers/iio/dac/ti-dac5571.c                  |  7 +--
 drivers/iio/health/max30102.c                 | 11 +++--
 drivers/iio/humidity/hdc100x.c                |  3 +-
 drivers/iio/humidity/htu21.c                  |  3 +-
 drivers/iio/humidity/si7020.c                 |  3 +-
 drivers/iio/magnetometer/ak8974.c             |  3 +-
 drivers/iio/magnetometer/ak8975.c             |  8 ++--
 drivers/iio/potentiometer/ad5272.c            |  5 +--
 drivers/iio/potentiometer/ds1803.c            |  6 +--
 drivers/iio/potentiometer/max5432.c           |  8 ++--
 drivers/iio/potentiometer/max5481.c           | 23 ++--------
 drivers/iio/potentiometer/mcp4018.c           | 12 ++---
 drivers/iio/potentiometer/mcp4131.c           |  8 ++--
 drivers/iio/potentiometer/mcp4531.c           | 11 ++---
 drivers/iio/potentiostat/lmp91000.c           | 11 +++--
 drivers/iio/pressure/icp10100.c               |  3 +-
 drivers/iio/pressure/ms5611_i2c.c             |  6 +--
 drivers/iio/pressure/ms5611_spi.c             |  6 +--
 drivers/iio/pressure/ms5637.c                 |  3 +-
 drivers/iio/pressure/zpa2326_i2c.c            |  6 +--
 drivers/iio/pressure/zpa2326_spi.c            |  6 +--
 drivers/iio/proximity/as3935.c                | 44 +++++++++----------
 .../iio/proximity/pulsedlight-lidar-lite-v2.c |  3 +-
 drivers/iio/resolver/ad2s1200.c               |  3 +-
 drivers/iio/temperature/tmp007.c              |  4 +-
 drivers/iio/temperature/tsys01.c              |  3 +-
 36 files changed, 134 insertions(+), 190 deletions(-)

-- 
2.28.0

