Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB338468D35
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 21:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbhLEU0B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbhLEU0B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:26:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC04C061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 12:22:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B576AB80EE1
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 20:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD11C341C4;
        Sun,  5 Dec 2021 20:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638735751;
        bh=2ibn75mYvWsIgdONmPWeSmE4cVU6+wj8hGjIlj1XNRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aNsS8toaLSnEb5XT57XB1eGecQCpziWZW0iWKRulaB0WMj7+PQRMX5oYOB1325ONb
         LpfNGXBnfGh7MsHcZpM/YV0rbly3M4AMUso1yFvSzAh1GMjbDx5JS06EF2iS3a40Jm
         MwG4epjJWTgLKkijr3bBOjU9TrFD8/hpGPAPa3+uy7Ccc1aWRhBzeZqIxNzZOnzzto
         hnEHIDN/b/VepCNKyDOooTBTQlC965BoDR/vpkhpvrn2umNt4kAmioZeUhQRMAvyc5
         t3gRJW+jb2QfoDcLgft6ud90xrylndFDfjol2bEXD1NKJa5ZV5R1KDN7S/aDUzleF4
         ukEPorfOh3+4g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 11/17] staging:iio:adc:ad7280a: Cleanup includes
Date:   Sun,  5 Dec 2021 20:27:04 +0000
Message-Id: <20211205202710.2847005-12-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205202710.2847005-1-jic23@kernel.org>
References: <20211205202710.2847005-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Drop used includes, add a few missing ones and reorder.
The include-what-you-use tool output was considered in making this
change.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7280a.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 90241560f5cf..7f9e2276e41a 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -5,21 +5,23 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/crc8.h>
+#include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/spi/spi.h>
-#include <linux/bitfield.h>
-#include <linux/err.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/module.h>
 
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
+#include <linux/iio/iio.h>
 
 #include "ad7280a.h"
 
-- 
2.34.1

