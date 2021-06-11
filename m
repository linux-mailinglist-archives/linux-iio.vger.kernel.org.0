Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC80C3A478F
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFKROR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:14:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231448AbhFKROQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 13:14:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E042D613D3;
        Fri, 11 Jun 2021 17:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623431538;
        bh=hl3Ok/tYQp59dkkTwxSpbiLqgXO2JvZYu3kH1tt6dd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+lDVrySOHr0SMTr5eVeUaVs8URjxYXp7cmYSMn0HrDht4YoTbqzSxRRitjyV7HpD
         /M4PW96nhKGr0J6p/FN7TLYRIMjh+w4BctraD4s+GalABoEqsJGXk5CO9cfj4Gq7oc
         KHxW7itua/6UtRP5e8WeSJFCB3TK8uEI+Q2UEr5RsEkJSMBuEIiv3IclRgjjU6bZCW
         WANKohsUlDhfZqgWYbVtAQkzp9TIOqu14+Hkaw3Bi5lra0WCtpvj0F4KOXCKBEzY5T
         pYO4MEm/3wu+IIbUbL/i1YzZzaszj2tjW3pwZKHpafDz/fjurEV3fynFpOmH/SDB5B
         2/TkvBlf68PHw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 06/12] iio:accel:fxls8962af: Add a few missing includes.
Date:   Fri, 11 Jun 2021 18:13:48 +0100
Message-Id: <20210611171355.202903-7-jic23@kernel.org>
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
Note that in this driver the main reason to do this is to ensure
consistency across IIO.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/accel/fxls8962af-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 078d87865fde..6882f082d581 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -15,16 +15,17 @@
 #include <linux/bits.h>
 #include <linux/bitfield.h>
 #include <linux/i2c.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
-#include <linux/iio/sysfs.h>
 
 #include "fxls8962af.h"
 
-- 
2.31.1

