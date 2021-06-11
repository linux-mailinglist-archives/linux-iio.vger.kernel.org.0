Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083423A4795
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhFKRO0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231455AbhFKROW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 13:14:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52A01613F9;
        Fri, 11 Jun 2021 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623431544;
        bh=NsStrQpdCl3lSFsJL4Xb/35jCmMB91Ypo/+Qh5IpW84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRSQBtLRaoJIw7aFxjC7texGEPx1xfdDRmBCBrxqcEK/Pm/fRWLxbbY3QyR1Awcm8
         +Eu9w0FbOmlCvx1hDvW41Zd9hBDQIoRBx6G4MTw4H58BfwHadcayDZ7dKaKiwe20Ne
         KflbAbS9Dy/nE0xiBIYiI//yRa/kufkDD7zAXkg4l+lZR8eGYeGyiv1ahcpnI5AVMp
         7E5Yu9O9ZgA3KLQfrCV2sx8aK8patgfV4OAJXS/YTudzflewkDO51MoZoN6JsElBxt
         Ioq3bsYfz/m/qrLN15fLs1kOiBKaTXgqSuQrFLvdWNj9hAHG947mMdZApMe1DE4guz
         UaTTLODjySwFg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH 11/12] iio:accel:murata/vti drivers: Include cleanups for the sca**** parts.
Date:   Fri, 11 Jun 2021 18:13:53 +0100
Message-Id: <20210611171355.202903-12-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611171355.202903-1-jic23@kernel.org>
References: <20210611171355.202903-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Based on consideration of the output of include-what-you-use.
Some unused includes dropped and some that are directly used in the
files added.

There are no hard rules for when we should rely on includes being
there as part of including another header and when we should do them
directly.  This is part of an attempt to be more consistent on that
in IIO.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/accel/sca3000.c | 5 ++---
 drivers/iio/accel/sca3300.c | 3 ++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index cb753a43533c..9f4bbf23834f 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -8,14 +8,13 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/fs.h>
 #include <linux/device.h>
-#include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
 #include <linux/module.h>
-#include <linux/uaccess.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index f7ef8ecfd34a..2042d8baf7b8 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -10,13 +10,14 @@
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/spi/spi.h>
 
 #include <asm/unaligned.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-- 
2.31.1

