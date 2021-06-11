Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915393A4794
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhFKRO0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231477AbhFKROY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 13:14:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E7DD613E9;
        Fri, 11 Jun 2021 17:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623431545;
        bh=+Y4ZKYWEP6DpEAC0SgA+8Jzd8tB7DWOTVozyLj61PwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEYFkt5laAm3tnF0TSIUdRlJdIr4A1IiHwqnCv9LtkoV6xvVv9BPDldkuaPePT009
         z+Zjgsu2p6bYr4lPUBKCQQrSlL1F2TvdTPKhikH/d2xpuc4DlfICGePDlFkOQii7mq
         hB7IsoLc5Mgu61kTKT4+7FP3kWkCBUpNWrnjb7zlNyoAkCPLral71LMlUSB4wKqVrq
         eH25QZ8HNvJsAosD/Tg0RHUP1dHhnGrigslCRaxzCaKhkyvykKIk8bygCrLEU15E76
         d1npzhGBBKA527pT7nlrOmlDAC5DxDLNNFZ5Rzf4P96q6DbuHJBWpbTcCh/WEDVsUZ
         cHbTBrCMyOytA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 12/12] iio:accel:sensortek drivers: Add some includes
Date:   Fri, 11 Jun 2021 18:13:54 +0100
Message-Id: <20210611171355.202903-13-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611171355.202903-1-jic23@kernel.org>
References: <20210611171355.202903-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Based on consideration of the output of the include-what-you-use tool.
Include a few more headers for things directly used in these files.
Note that there are no hard rules for when to include a header directly
vs rely on it coming in via another include.  This is an attempt
to improve consistency on this decision in IIO.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/stk8312.c  | 3 +++
 drivers/iio/accel/stk8ba50.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 43c621d0f11e..1f4cab0e31bf 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -7,10 +7,13 @@
  * IIO driver for STK8312; 7-bit I2C address: 0x3D.
  */
 
+#include <linux/device.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index e137a34b5c9a..9049f1a5ace4 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -12,6 +12,8 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.31.1

