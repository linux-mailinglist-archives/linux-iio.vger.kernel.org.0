Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C085F33A768
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhCNSRn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233560AbhCNSRh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:17:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EABB364EE5;
        Sun, 14 Mar 2021 18:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745857;
        bh=w1x4gJMw5apcvIxY6adbF7oo62IwpZuDzsW6SDLQsLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rgjh61OrMzWMKgcEdIxJfSAWYF67C63UUmWnOkGRDwN9gD9dMhDkt3aioexjMCJRu
         q71v3qeLNdbUy/YwS3E48Uh+XMG8l6erqxA8Ax0cyuiphx3y5i7GkGt994rjaWHwka
         epIezxwxab25W7BpHZuDu031Hke6wgb3n8VfL1+BE0zhWWTPxeregp9/4oStmITxsv
         VLIyI68zcWrNS5JpsJl7x0uJ9K/snpcCwAR8pa3IWBtSERd3XmALc4t9CF5aEFuK8w
         o66Zrs4LXkIH307EYSAxqUEr+lA8+012LTD0Ge+LuStW/QSCJZdbKTP1H/XAfo9YaU
         2r9MiRw628Fbg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 07/24] staging:iio:cdc:ad7150: Simplify event handling by only using rising direction.
Date:   Sun, 14 Mar 2021 18:14:54 +0000
Message-Id: <20210314181511.531414-8-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The event line is active high and not maskable within the device.
It indicates current state directly.

The device supports separate rising and falling thresholds so rather
than trying to using each bound to detect in both directions just use
IRQF_TRIGGER_RISING.  If a user wants to detect the value falling
back below the threshold, then set the falling threshold appropriately.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20210207154623.433442-8-jic23@kernel.org
---
 drivers/staging/iio/cdc/ad7150.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 539beed1a511..34e6afe52f0e 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -603,7 +603,6 @@ static int ad7150_probe(struct i2c_client *client,
 						NULL,
 						&ad7150_event_handler,
 						IRQF_TRIGGER_RISING |
-						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
 						"ad7150_irq1",
 						indio_dev);
-- 
2.30.2

