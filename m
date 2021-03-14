Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99A633A6F5
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 17:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhCNQtO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 12:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234668AbhCNQtG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 12:49:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 177F464E75;
        Sun, 14 Mar 2021 16:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615740546;
        bh=mW1ap7fHw3F6PGpp6ekV1Sw7n9hAcjlq/i2sNKzEttE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l7jaH0TGS8huwwXjPbZU045Zn6NH9uSnqdMngT6Qmm9ji64xWtltvR9aFn/3VjYDp
         ZENbHb0kDE0hsiPC5OXE3ZK/Cl3OYtkn4HbgqnM+mS/vPtupdgE9+NcdhH4v5DX60S
         oHP2PFfhRfJk2T4YTE0mzhse44THV6UXpzAbvEwcfQU/dZd6B9HrHa1Z0XIS5wy4Xp
         gvpq/SdEG7P07a+KaO2jShirjCq7XvV6S04EmFgxIw6ERVu2NHmRy88Ach+NEnTRsL
         PEJPu9YMMhqOMiKxmZAHeHOc+6/94y3t9cz4jhUhYmFfokNee0A5tYSNBj7b23oQtI
         IK7LOGpYVLM3g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/8] iio: pressure: zpa2326: kernel-doc fixes
Date:   Sun, 14 Mar 2021 16:46:48 +0000
Message-Id: <20210314164655.408461-2-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314164655.408461-1-jic23@kernel.org>
References: <20210314164655.408461-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Two comment blocks had wrong naming for function/structures that they
referred to.  Results in warnings when doing a W=1 build.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/zpa2326.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 70adff62cd20..a93411216aee 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -103,7 +103,7 @@ static const struct zpa2326_frequency *zpa2326_highest_frequency(void)
 }
 
 /**
- * struct zpa_private - Per-device internal private state
+ * struct zpa2326_private - Per-device internal private state
  * @timestamp:  Buffered samples ready datum.
  * @regmap:     Underlying I2C / SPI bus adapter used to abstract slave register
  *              accesses.
@@ -1382,7 +1382,7 @@ static const struct iio_trigger_ops zpa2326_trigger_ops = {
 };
 
 /**
- * zpa2326_init_trigger() - Create an interrupt driven / hardware trigger
+ * zpa2326_init_managed_trigger() - Create interrupt driven / hardware trigger
  *                          allowing to notify external devices a new sample is
  *                          ready.
  * @parent:    Hardware sampling device @indio_dev is a child of.
-- 
2.30.2

