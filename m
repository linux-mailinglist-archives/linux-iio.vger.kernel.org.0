Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397E846866A
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 18:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355578AbhLDRLG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 12:11:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58648 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355591AbhLDRLF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 12:11:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 181E660ECE
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 17:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96370C341C3;
        Sat,  4 Dec 2021 17:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638637659;
        bh=quLJu8u6MXylRG6RH4GxiYY4a5dmIQ5s3XMB0MtohOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvZOflfkMUJwfeOYPUu0k+6eash8snXasW2NrdEhYfOv3/WMuN+JHJtx4gMOOV2lT
         msYRJ0QHyeIbN2pH7+9pfhx+qIDZvJaAHkt9gPL1ABRcR8dUzEWPLfVBYxakjY2QlY
         ocO71PMG2n/BphqUnR1uKDgs/wyfQgpUBkhVqiYJodUr1Z2u924EtDYAC2gYfuDnHj
         7kL3HkySOASlobDbL3IFhzKpG+I9QXRhCcqTaTgSpI7m8rYkenNWOoDzlEWvjvNIbs
         Z8fqjJD/zjPSrc5pvFAyO9lBzieWCqWUGQiEDCgGkPdImsxFHltzbYCOGY6HqGzJYw
         O0K9fGeUbbYJw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 03/12] iio:dac:dpot-dac: Swap of.h for mod_devicetable.h
Date:   Sat,  4 Dec 2021 17:12:28 +0000
Message-Id: <20211204171237.2769210-4-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204171237.2769210-1-jic23@kernel.org>
References: <20211204171237.2769210-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This driver never used anything in the of specific header.
It just wants the struct of_device_id from mod_devicetable.h.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/dac/dpot-dac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index 5d1819448102..83ce9489259c 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -30,7 +30,7 @@
 #include <linux/iio/consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
-- 
2.34.1

