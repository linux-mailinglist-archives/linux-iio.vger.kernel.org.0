Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B623A478D
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhFKROO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhFKROO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 13:14:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 816CC613DF;
        Fri, 11 Jun 2021 17:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623431536;
        bh=WJHMBM4T9UOF5tTQKoW6YGEjcHubXL/EgoTZGE5ik0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lO8QHwG8tFLrLb1liqMQlpfnpSwCVBjgryR1LZ3levi6jhE3pAOrXKFFJXWOM9UM5
         8y3kg58fixDPqqUDrTFoOHFjn5nc9DdBl2QOh5smZGbFiwlKq3LAliZ8EfUflR5All
         7o7AbXAPYvLkmPSee4FUfUp4fEwX4ofgBH+Gz7qnHtY4tIxVaXsLkE8nvVLpp82DMI
         TVBVCoTCPBtlbVaawNMJuifl2zDugWctADFGWDXBHmYTpkC+osHTEh0jAznftSNZ8Q
         iTWEffPldhOs6z9xVci/mjnAOg/jIUInT2gnfxUpMoFxLGwiXLUwjm8lMTxrJ0Jf8g
         z9BfPnUlN56cg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 04/12] iio:accel:miramems drivers: Cleanup headers
Date:   Fri, 11 Jun 2021 18:13:46 +0100
Message-Id: <20210611171355.202903-5-jic23@kernel.org>
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
Drop unused headers and include some that are directly used inside
the files.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/da280.c | 3 +--
 drivers/iio/accel/da311.c | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index 5edff9ba72da..0fb20dbde49b 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -7,11 +7,10 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/acpi.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/byteorder/generic.h>
 
 #define DA280_REG_CHIP_ID		0x01
 #define DA280_REG_ACC_X_LSB		0x02
diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
index 92593a1cd1aa..c944e18c97f0 100644
--- a/drivers/iio/accel/da311.c
+++ b/drivers/iio/accel/da311.c
@@ -6,11 +6,11 @@
  * Copyright (c) 2011-2013 MiraMEMS Sensing Technology Co., Ltd.
  */
 
+#include <linux/bits.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/byteorder/generic.h>
 
 #define DA311_CHIP_ID			0x13
 
-- 
2.31.1

