Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7502AD523C
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 21:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbfJLTkg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 12 Oct 2019 15:40:36 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17418 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbfJLTkg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2019 15:40:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570909225; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=S0wQqpZk8NAZnjTgki3Q6Bfd/eeCduh9YaeoYrbCd4IRfHgDS1CVhOSZMSz71sh7fQfPWCf9/u6sRuirzhfsjgIrTROndJwXjw1VXiOucOJlCrqM6M3ew/Y+R08PebIh+M/w715xRmgFmg9qzr6G3wfjAeS1lC5tYyKfzXG2F+c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1570909225; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=DOS/NudUiknsAbT7xTUrpQE0GPqL0XnW+UVisungjnw=; 
        b=WZHVfiyclhDY6XS41IAtoEgFuBTpM+O6/5A9Is68TSNK1aMu4TTzJsafj2Wa+Inle2xUMGXt++CDph+gZ5Q9vAfXhwhmohLzohN46EHsUwE/AhMk7y1m/jSENhI4EIfXnMzqz+jSRpa7aWNnJIudDvK+wWzTK3nDEC+hy8Uqo44=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie.verizon.net (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 1570909224991415.13001537411003; Sat, 12 Oct 2019 12:40:24 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Dan Robertson <dan@dlrobertson.com>
Message-ID: <20191012192525.21040-1-dan@dlrobertson.com>
Subject: [PATCH v3 0/2] iio: add driver for Bosch BMA400 accelerometer
Date:   Sat, 12 Oct 2019 19:25:23 +0000
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
accelerometer.  The initial implementation of the driver adds read support for
the acceleration and temperature data registers. The driver also has support
for reading and writing to the output data rate, oversampling ratio, and scale
configuration registers.

Version 3 implements the feedback from reviewers of the v2 patchset.

Cheers,

 - Dan

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
 drivers/iio/accel/bma400.h                    |  80 ++
 drivers/iio/accel/bma400_core.c               | 788 ++++++++++++++++++
 drivers/iio/accel/bma400_i2c.c                |  60 ++
 6 files changed, 987 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bma400.yaml
 create mode 100644 drivers/iio/accel/bma400.h
 create mode 100644 drivers/iio/accel/bma400_core.c
 create mode 100644 drivers/iio/accel/bma400_i2c.c

-- 
2.23.0



