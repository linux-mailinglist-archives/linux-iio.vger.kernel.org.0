Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2A03A3DCD
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 10:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhFKIN5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 04:13:57 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:13323 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhFKINy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 04:13:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623399111; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ndm1+A433l7jmzVfIfc+7Xnlkj8bU6DaiIWyq98QbWdsCc3AudKXzWH+BtByYviBWC
    Fq3bGjJH+7WjhEC5h2ofm+hvMmLwSmQFxEzcoVOKcTQUbyFehmLy7rwhH5IKbH+uf6nj
    JvRCjVchXqckR3FtrRcfcoaTnCK1+t7EgK16p8j3U1Q7Drs6HoWx9Fp8cYSI2GMw5Jl0
    NlRIHiVMBBTtNYCxj76/fQcE3bYprzzPTCPhsaTsU9bxJkGLie7VKdMpONNK9FlZX1NJ
    3AN/XwXMg8S9vqIt5E4kD/i0e2bPP2A+DWl+HVPaLDFJBN5Oar2Z3rZ9WCBG+OplkEIk
    p9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399111;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=YsRVRxp+47703gIvv1C/lpKrQ3eC8Q5Wgd2GCgDRPm0=;
    b=LPI3OLZVdATQCqforqYE26WPcdNeppX4XJi5NpJBi9m3p2WMgyi5qJIJGi1T5gxvz4
    gt2eQvUz7M0JMDRFVlZ98C/E1a7RCgUOyygDiXyKSJRGnyiAuWKAUttOS6zvdcCrJ1z0
    FXl1UtmdgADGxnwpKpoThn3DoJVLHfD5osybi5zdwL47ppVdPnyziRHp7iTx80/NUucU
    FqEa3J39zvjUKymimlw/xegzkpSjOMQXoAlEBXiOPDDEtYQ7LeD2NE6O7ZV5lIBg8L6U
    h4kxf7AW0ibBr7TMA0Bb1ac8A1TdwmJ1O3L0W195PlEugYTjrQVixJDPi0GrWoDCHbVs
    2sug==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399111;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=YsRVRxp+47703gIvv1C/lpKrQ3eC8Q5Wgd2GCgDRPm0=;
    b=hUZzD4IjIiBG2hQOktTUkdcD5Y2evS9FjDq444LHMEv+wTJq7XLJoKmc7iTSkk1mjg
    jCR8nUzZUV7wDlt0WALrXaLKQ8KSJLJWcXG7FlAp54iHDuf0K6YZ4lbv9IBH2mriXYBg
    q7UMt15IFpIzgi35NA9EpiYmE8iXJoeh9sSeN1JeenVkft3CAkuwRqiGwBGcYGu7mj/m
    H1s0HVoX+LhthjyZ5TMtDThNQVq89h+lUgsQgaBHUcZiI3YGPOpZHTdBKfPBwgcaoBRb
    MfW0G6YO4Z3dDB1J4cUeWDi4KHr9wjdF/aNgJ/XxdDNXWDhjkeXQ+07sFVT+tTD4LZir
    MM3g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA6m6PrPw="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5B8Bo02h
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 11 Jun 2021 10:11:50 +0200 (CEST)
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
Subject: [PATCH v3 04/10] iio: accel: bmc150: Drop duplicated documentation of supported chips
Date:   Fri, 11 Jun 2021 10:08:57 +0200
Message-Id: <20210611080903.14384-5-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611080903.14384-1-stephan@gerhold.net>
References: <20210611080903.14384-1-stephan@gerhold.net>
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

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v3: Add Andy's Reviewed-by

New patch in v2. Originally I tried to reorder those too but then it
caused conflicts in all my following patches so I'm not convinced
it's worth to try and keep those up to date.
---
 drivers/iio/accel/bmc150-accel-core.c | 10 +---------
 drivers/iio/accel/bmc150-accel-i2c.c  | 10 +---------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 9ecbd3769593..4b5caa89a3b4 100644
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

