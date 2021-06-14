Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D54C3A65B8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 13:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbhFNLmC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 07:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233533AbhFNLh1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 07:37:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED1B16124B;
        Mon, 14 Jun 2021 11:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623670426;
        bh=xT98V8a3SwZ+3ZQlFpw0Og2o/hKPlOM2ANJybtdORzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=adVlvRPJbjaZ56FjLvbTS7s8xMvcZVZgfAUpHhMhoopNX4TUafUrIn68be8Nsr+N+
         S05b+g1F4pgq/ssFcVQO7/ueZsCX9drevMsAfJj56ca2W1IRsQu0TMKwEZBr0xHutO
         hGcsXWX0p9//q5+O5XBYebSEBvvXxJUvTh9Te9k0hUfDqSaghEqhqlqkEkzAiUfzH/
         16zDTq7bsIlVeL0SLnVeCfNd4Nc+2KjIi+Jk3wGjcmuYFBBjjNki/KYJD0KHaIRzfO
         /8vEMgkftdr2c4Zp/4G+h1aTK2zOlJmJyBeaqJLNzk41P/jVFyNzlsL0Ts25xxsCYU
         I6qWwKfOzK/rQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Michael.Hennerich@analog.com, lars@metafoo.de,
        devicetree@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 11/17] staging:iio:adc:ad7280a: Cleanup includes
Date:   Mon, 14 Jun 2021 12:35:01 +0100
Message-Id: <20210614113507.897732-12-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614113507.897732-1-jic23@kernel.org>
References: <20210614113507.897732-1-jic23@kernel.org>
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
2.32.0

