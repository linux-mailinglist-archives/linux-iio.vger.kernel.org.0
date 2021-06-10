Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8D83A2B68
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFJM0P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:26:15 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:19039 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhFJM0P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 08:26:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623327847; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Oz9Xgt5RWiYi2mzUK2wEGjZXyu4OM7W6+RORbOf8Wp9ey7maI/ryPMzUxoo5GQiVxR
    NF2ecoaGzF7E1+fgEd5AlileKakzAgvBlCx/VAfCsrW29tePDHWBFtQh/7C9Ug6WcTE6
    GCN8+cU6DTv8W2ECj4apxpdkcCBgqI7vWoUy/S3sKDcTunlPKdvkgoiHnR/XgZNhLPHk
    KFA573kuri1EMP4OyVEHZHqlBrILh4a9BKlBhhCGEPSwBEDmXsjbLOUzNBdIYVDnhdN6
    z9dM9Vdh3x9PEq4ZUczPhAQyyOCf1YFgvhglo9pNHGRimHZ73r+OVU4xGT4/mgANw+Eg
    ZX0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327847;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=A24UVyz140TpBvsuyBtwZejZRIcnrKYlIvJOfsBlnjQ=;
    b=bgrk1OQteF1P0499obcbuU0n+UKba4jjbLvqF6qEDrjcgePbo68uYKbvt/egawtbaM
    DsrF0HkK8EZfJFidpMdaIXQVOqp60mMPvloZkRsXJ+m2ftJbNuR0AaGwwiQ0RZ958dze
    zEYfYin8zNEksQmJVBIkQR0LZoOtWw4UISmes/eReAsFk3A7/pgleBlPKB+VZ0phm9BH
    idNcDUhVJsptxCLNyqc67anPfsSkwFOPARTrqTtJiGIKRNDqm24QPs7ea3YG30GO6erz
    e6g83htMe3F4DkN3wuVEORQbd8r+dIY2Kb4xKTORiSwDRau9E6AqHI/DB5rzseFPGRVL
    tlow==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327847;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=A24UVyz140TpBvsuyBtwZejZRIcnrKYlIvJOfsBlnjQ=;
    b=XACzzH/z02romuxLmUD2e3KycrSIDoJSfoCqhso4HiNWyGtNQGyvQ1b8IYNOPWSENd
    ZWV0LDCtIiRFcWDsT/YFjV4s+kkBQO431dwstrU3AuqCl6azX1ZMLI82Mfy35FehIvra
    RJMhrqqFrS05QQ+5/Rwxo6ImpX/tVlXekdNROKRXvcpqPXrfxMczBZ6sDNnJUjXJcax4
    YW2oYzfz40DLaOiCoO7a+929lr9XLvd21hxOWnCUzqvmLuvUlocGVaA+aBA8G6EtSOgX
    1KcwIglW1DGidJQo9qzvbVo3Iu8tkSE2Jj2EEf+tYvKPvwrXldxnRLNWc6BKH+qFzbaf
    No0g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA626NTAM6"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5ACO7tzu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 14:24:07 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 3/9] iio: accel: bmc150: Drop duplicated documentation of supported chips
Date:   Thu, 10 Jun 2021 14:21:20 +0200
Message-Id: <20210610122126.50504-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610122126.50504-1-stephan@gerhold.net>
References: <20210610122126.50504-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The chips supported by the bmc150-accel driver are clearly documented
in Kconfig, in the bmc150_accel_chip_info_tbl as well as in all the
device ID tables in the I2C/SPI drivers. It's easy to forget to update
the lists in the file header. Drop those entirely to reduce the amount
of changes required to add new chip variants.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
New patch in v2. Originally I tried to reorder those too but then it
caused conflicts in all my following patches so I'm not convinced
it's worth to try and keep those up to date.
---
 drivers/iio/accel/bmc150-accel-core.c | 10 +---------
 drivers/iio/accel/bmc150-accel-i2c.c  | 10 +---------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index a0df704730ee..6fb025b4228f 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1,14 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
- *  - BMC150
- *  - BMI055
- *  - BMA255
- *  - BMA250E
- *  - BMA222
- *  - BMA222E
- *  - BMA280
- *
+ * 3-axis accelerometer driver supporting many Bosch-Sensortec chips
  * Copyright (c) 2014, Intel Corporation.
  */
 
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index b8bda0dfb495..a0e2782580b7 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -1,14 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * 3-axis accelerometer driver supporting following I2C Bosch-Sensortec chips:
- *  - BMC150
- *  - BMI055
- *  - BMA255
- *  - BMA250E
- *  - BMA222
- *  - BMA222E
- *  - BMA280
- *
+ * 3-axis accelerometer driver supporting many I2C Bosch-Sensortec chips
  * Copyright (c) 2014, Intel Corporation.
  */
 
-- 
2.32.0

