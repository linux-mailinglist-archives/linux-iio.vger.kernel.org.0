Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D317A468671
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 18:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377232AbhLDRLZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 12:11:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53720 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355645AbhLDRLZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 12:11:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB71FB80D34
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 17:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A89C341C0;
        Sat,  4 Dec 2021 17:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638637677;
        bh=G01zsLxI1sBGwaylMI6xF+pRYqYRVOEe44QDRQ0Tm2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9klerjsTwpnA/OJFJv6T1Lrt4ijI5C0uuEkGZmKbM5oZlK7p+K42ASIe6dgZHuud
         syyyPGIAnefyfRJ5EDH+NizJVcn5kw313GU+bNZ6oTe6iPwAnjydgRNiQNjJKlPwmo
         44cJSJVuYP/QyWSUU27NqRHac7pcMuKi+UF1sQbXUt1bcXDPyQ5gX6j4s6/GOqBOmK
         F0Y2sL0BTLpmfMhk74p94IgPJtiqSyDxZX5tYyw6ytFTnBN6VVn1XL/D+C2EMQ6cTr
         n8+hTKfchPDHnt+PZzR9pSTXHZBrAdDAv1jviVGQN4t4OiF2SQTWWK0Xa9G8x+36Yr
         af2HD14i4NkYQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 10/12] iio:adc:envelope-detector: Switch from of headers to mod_devicetable.h
Date:   Sat,  4 Dec 2021 17:12:35 +0000
Message-Id: <20211204171237.2769210-11-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204171237.2769210-1-jic23@kernel.org>
References: <20211204171237.2769210-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There is nothing directly using of specific interfaces in this driver,
so lets not include the headers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/adc/envelope-detector.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
index d73eac36153f..e911c25d106d 100644
--- a/drivers/iio/adc/envelope-detector.c
+++ b/drivers/iio/adc/envelope-detector.c
@@ -31,14 +31,13 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/iio/consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
-- 
2.34.1

