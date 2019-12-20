Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A1B12806E
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2019 17:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfLTQQp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 20 Dec 2019 11:16:45 -0500
Received: from sender4-op-o11.zoho.com ([136.143.188.11]:17107 "EHLO
        sender4-op-o11.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfLTQQp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Dec 2019 11:16:45 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1576858590; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=cwELt0bUFRAISzp+utjX49o116gaJzcoAgIdVaidRii3F2f5IJsJhPFg12THAD3av2iID4UDFeDcOglHHcetez6tb5AiQeTnuBuHPKImbpJ227JbwcmLHqviWKISjrx5Ix5cm/9F8bhBS2AhSB9d5/WVQJ4j0o7vsJe36WaH9n0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1576858590; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=AaT03GYlto89xDiCdH3WCjerKcBnYWeAplz3CO2IaIU=; 
        b=XP6w1HS43rnX2tdqv6iqZVGzXEQqHDdkCvbWvakfJABB2ujdv0hPtkIoIi9MoPs0I/fQxf0sDCPKpyb2jOlTethTG7jI/KFdg2PgjzuMsFwuo40hmS/2r9n8JMFAiEidmpeWubaObCVQkcLEmYYaClroMeG9WdcfEnSkYnAtCeE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie.verizon.net (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 1576858589287435.38899860347146; Fri, 20 Dec 2019 08:16:29 -0800 (PST)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dan Robertson <dan@dlrobertson.com>
Message-ID: <20191220160051.26321-1-dan@dlrobertson.com>
Subject: [PATCH v8 0/3] iio: add driver for Bosch BMA400 accelerometer
Date:   Fri, 20 Dec 2019 16:00:48 +0000
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I made basic improvements based on the previous code including removing
the use of division when setting the scale and setting the sample
frequency and using devm_regulator_bulk_get.

Cheers,

 - Dan

Changes in v8:
 * Fixup MAINTAINERS entry
 * Remove the use od division when setting scale and sample frequency
 * Use devm_regulator_bulk_get

Changes in v7:

 * Added MAINTAINERS entry
 * Added basic vddio and vdd regulator support
 * Added vddio and vdd supply to devicetree bindings
 * Added interrupts to devicetree bindings

Changes in v6:

 * Improve readability Kconfig options

Changes in v5:

 * Move to using a function instead of lookup tables for scale and
   frequency conversions.
 * Rename DT bindings to bosch,bma400.yaml
 * Fixed other errors and improvements found by reviewers

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

Dan Robertson (3):
  dt-bindings: iio: accel: bma400: add bindings
  iio: (bma400) add driver for the BMA400
  iio: (bma400) basic regulator support

 .../bindings/iio/accel/bosch,bma400.yaml      |  54 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/accel/Kconfig                     |  17 +
 drivers/iio/accel/Makefile                    |   2 +
 drivers/iio/accel/bma400.h                    |  99 ++
 drivers/iio/accel/bma400_core.c               | 849 ++++++++++++++++++
 drivers/iio/accel/bma400_i2c.c                |  61 ++
 7 files changed, 1089 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
 create mode 100644 drivers/iio/accel/bma400.h
 create mode 100644 drivers/iio/accel/bma400_core.c
 create mode 100644 drivers/iio/accel/bma400_i2c.c



