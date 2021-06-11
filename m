Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21CE3A478E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhFKROP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhFKROP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 13:14:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76F23613E9;
        Fri, 11 Jun 2021 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623431537;
        bh=A+lbXcqxH4WuaYciOdHNZSt65MQry63DGvw7a4M0naI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6zk83Zw7i0vD6c7i8X3xav8r+tLNQqspLPk8fGd8UiJigftslb3mW2CrFkAW1GgK
         59/Kt9BFT2w1+2I1ZE1opV6wMq/3TMLuhWns5wW/WaLSX1wvKCvFNgF4D7afzMz7i5
         sINokLudzkSaQg7OAJwM7xEOC/N6mUe9+FbMjtccdY9kXDSg1nYwTueZZyHcvEtwaA
         6CAjI6Gih5/VUvsNqYFzxakQtILvH2pP079U14ZIt7lJFKcK1dl0TpaC2voJCHMsFi
         LNcEf7khMgwRsTmR06klYhXxeA+F1kQijd7Hhszu1D7LFPBJghaRzaA0gYZGLgTi2d
         fgf8yF3yHXOfA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jelle van der Waa <jelle@vdwaa.nl>,
        Aleksei Mamlin <mamlinav@gmail.com>
Subject: [PATCH 05/12] iio:accel:domintech: Cleanup includes.
Date:   Fri, 11 Jun 2021 18:13:47 +0100
Message-Id: <20210611171355.202903-6-jic23@kernel.org>
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
In this case, mostly additions of includes.  A lot of this is about
consistency across IIO rather than them being strictly required.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jelle van der Waa <jelle@vdwaa.nl>
Cc: Aleksei Mamlin <mamlinav@gmail.com>
---
 drivers/iio/accel/dmard06.c | 4 +++-
 drivers/iio/accel/dmard09.c | 2 ++
 drivers/iio/accel/dmard10.c | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/dmard06.c b/drivers/iio/accel/dmard06.c
index de2868c28d95..6edc474f51c1 100644
--- a/drivers/iio/accel/dmard06.c
+++ b/drivers/iio/accel/dmard06.c
@@ -5,9 +5,11 @@
  * Copyright (C) 2016 Aleksei Mamlin <mamlinav@gmail.com>
  */
 
+#include <linux/bitops.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
-#include <linux/i2c.h>
 #include <linux/iio/iio.h>
 
 #define DMARD06_DRV_NAME		"dmard06"
diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
index e6e28c964777..9155b3a232f4 100644
--- a/drivers/iio/accel/dmard09.c
+++ b/drivers/iio/accel/dmard09.c
@@ -6,7 +6,9 @@
  */
 
 #include <asm/unaligned.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 
diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
index e84bf8db1e89..c928c67c0857 100644
--- a/drivers/iio/accel/dmard10.c
+++ b/drivers/iio/accel/dmard10.c
@@ -7,9 +7,9 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/byteorder/generic.h>
 
 #define DMARD10_REG_ACTR			0x00
-- 
2.31.1

