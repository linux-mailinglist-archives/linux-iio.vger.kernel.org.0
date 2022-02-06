Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41B34AB17E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242266AbiBFS5t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244837AbiBFS5q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:57:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CC6C0401C0
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:57:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFB3FB80E66
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FA7C340F0;
        Sun,  6 Feb 2022 18:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173863;
        bh=j4K18/dNuLQEFTpn74M+mWho4KEmR0J54ZLSWv8m1BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ROqtP017VpvDIvpig+KgRbJoGlqCUIR+ssQLyPRCs2V8Jzrb48KJSCwYPq05/p1Z9
         WiT0SYWlVDREL1DVbJ1WrpJOyjSPkFPpBFHJNxdNrovazj25KWbvNIEkzT2gGwZpBj
         G8+T/wyjCJ3E4a3B2gI8WqUJ/hNHWZCBnzgOrPD8LjITRFsHk3v35jhgPLUfxzf4DR
         M0ZpgSlKcsU39Cwf1qTg3HQOYGFQ5W3TvRr6SUBf8WZzHbPAR0gtMl6KxzjylUk0Mj
         odHheAbUtZKkh/K87VOXtXOPIYTyT37wqan6zWqmo6Yl0zpfH9WYqZqkVYKSehELgi
         QaEwHG6RWKJnA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Hennerich@vger.kernel.org, Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 11/20] staging:iio:adc:ad7280a: Cleanup includes
Date:   Sun,  6 Feb 2022 19:03:19 +0000
Message-Id: <20220206190328.333093-12-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206190328.333093-1-jic23@kernel.org>
References: <20220206190328.333093-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Drop used includes, add a few missing ones and reorder.
The include-what-you-use tool output was considered in making this
change.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 2ba9379ce0a7..d408974c848c 100644
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
2.35.1

