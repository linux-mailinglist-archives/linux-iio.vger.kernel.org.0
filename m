Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D017746866B
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 18:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355594AbhLDRLK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 12:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355591AbhLDRLJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 12:11:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9EDC061751
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 09:07:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5CC2B80D36
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 17:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A51EC341C0;
        Sat,  4 Dec 2021 17:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638637661;
        bh=d8pMIP0ALW68m60IvtWGic1c6QVE2F82TtJyPirEqeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PandSBNuJycvn4LdBu3QitQdAhbi1b36KgZiIs8+c3dDqSaqXzGC/wn1liXgyeDta
         Z3mjtz7cImZ6GtMiOATTVb7MxbQ4DJSp1teUvtKYSZj2Ij9JsiOHDJqHGjDupsDm8p
         yxeM3rv823UpFEZvkQsWQeOvfwT5kQ5crmVL0uHxRlM/J2sHkA8ebSGoMbC458mIR9
         2Fyg3eIVGtsMdBLwWR4cTBgGOr4Zvb7g0IGoUtnRJ0YYU07Oy8y/yEvVTbszqctogc
         mo59WU9fxXq9jOKJjCmU8EiiJL6DRauqBJioH4g9peFb3Fj5frQlhiqF4T5vZWPe70
         awYzeCbRYOYeA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 04/12] iio:dac:lpc18xx_dac: Swap from of* to mod_devicetable.h
Date:   Sat,  4 Dec 2021 17:12:29 +0000
Message-Id: <20211204171237.2769210-5-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204171237.2769210-1-jic23@kernel.org>
References: <20211204171237.2769210-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This driver never used anything from the of specific headers.
mod_devicetable.h provides the struct of_device_id definition.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/lpc18xx_dac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/lpc18xx_dac.c b/drivers/iio/dac/lpc18xx_dac.c
index 5502e4f62f0d..60467c6f2c6e 100644
--- a/drivers/iio/dac/lpc18xx_dac.c
+++ b/drivers/iio/dac/lpc18xx_dac.c
@@ -16,9 +16,8 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
-- 
2.34.1

