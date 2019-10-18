Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65AFBDBD00
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 07:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391547AbfJRF2v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 18 Oct 2019 01:28:51 -0400
Received: from sender4-op-o19.zoho.com ([136.143.188.19]:17939 "EHLO
        sender4-op-o19.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbfJRF2v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Oct 2019 01:28:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571370204; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=oDQi8/xhQkWTTInmD3AzONR1BVYPjR9bNxSR6TsXAjPdO3UEdjGm/MucLUFLOcLvwXlJC0cX87KXGHXXwD5a34zmJtwEYVX16xHUTd2Xz8GLyUaZwkWlkOD1vU/1ZtU5TSuag6sq40b2ftkoxmZLc6O4xKKfqFIwOYiOV++YlIw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1571370204; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=hMiiW4t4j8256RwQSELEvYtzVLJKHMwLX3bMX/7RPkU=; 
        b=XdhItdsKdSODfGiX++roAsiJbn2N9LHPpL+33IHwn7hXL4h/GaIxtTyfHupWMqXmFsX+z95MzPkKqsW7OYV5nQaKhCJ0MJC6KcdIZuMEaOdYzfLamBFTbi7PrhS+dGNYT7Wk0owBDgBF7nIfbF9QMnPEmeWAvfQdX7THtqBAfKQ=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie.verizon.net (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 1571370203411431.43176717063875; Thu, 17 Oct 2019 20:43:23 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Dan Robertson <dan@dlrobertson.com>
Message-ID: <20191018031848.18538-1-dan@dlrobertson.com>
Subject: [PATCH v3 0/2] iio: add driver for Bosch BMA400 accelerometer
Date:   Fri, 18 Oct 2019 03:18:46 +0000
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds a IIO driver for the Bosch BMA400 3-axes ultra low-power
accelerometer. The initial implementation of the driver adds read support for
the acceleration and temperature data registers. The driver also has support
for reading and writing to the output data rate, oversampling ratio, and scale
configuration registers.

I've ran some basic tests with libiio and I've run the device tree checks. Are
there other tests that are recommended to be run for a new device?

Thanks again for the reviews!

Cheers,

 - Dan


Changes in v4:

 * Fix error in DT bindings
 * Fix typo when setting the OSR
 * Simplified the cached sample frequency
 * Fix the MODULE_LICENSE

Changes in v3:

 * Use yaml format for DT bindings
 * Remove strict dependency on OF
 * Tidy Kconfig dependencies
 * Stylistic changes
 * Do not soft-reset device on remove

Changes in v2:

 * Implemented iio_info -> read_avail
 * Stylistic changes
 * Implemented devicetree bindings


Dan Robertson (2):
  dt-bindings: iio: accel: bma400: add bindings
  iio: (bma400) add driver for the BMA400

 .../devicetree/bindings/iio/accel/bma400.yaml |  39 +
 drivers/iio/accel/Kconfig                     |  18 +
 drivers/iio/accel/Makefile                    |   2 +
 drivers/iio/accel/bma400.h                    |  85 ++
 drivers/iio/accel/bma400_core.c               | 796 ++++++++++++++++++
 drivers/iio/accel/bma400_i2c.c                |  60 ++
 6 files changed, 1000 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bma400.yaml
 create mode 100644 drivers/iio/accel/bma400.h
 create mode 100644 drivers/iio/accel/bma400_core.c
 create mode 100644 drivers/iio/accel/bma400_i2c.c



