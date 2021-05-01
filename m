Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145AA370820
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhEARQW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhEARQV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:16:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B52A61606;
        Sat,  1 May 2021 17:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619889331;
        bh=KvP2G+zbo2Jhbu7xynUgrJA23NE6FxeyqETBqh+9DYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C3AgqDCXqpdv+RWS1+Z+ecV0900ZxXpuyZHH1uvVBU+axLHTmZtRjjVG/Liu5p8LH
         VQ6VcAeZFt9xSuQL51jjIlIorQeCxOMBpKaJmQ3oN9rsqBgG8p80G2ocpuV3CEHgvk
         Uw1xa9iayxN3mE5AgEijjPe6/X+qfhAAlWMxhzDeOaalKZ1jnYtUlt0L5qGYIkLncL
         pcMZ6YLbjUl5hZBewXmycF6CrzGE9Jh8ZkkeskCZ1887U3h8p6s3LURGDnZS+LguUM
         /iizG2sU3Xas4tEwwf+YwZmQoV6KgIc31tgjepvffKhbzuHUhDURydQU88s45Qt+mC
         VlLVSiZkhb5dA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 05/11] iio: chemical: atlas: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:13:46 +0100
Message-Id: <20210501171352.512953-6-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501171352.512953-1-jic23@kernel.org>
References: <20210501171352.512953-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Variable location for the timestamp, so just use __aligned(8)
to ensure it is always possible to naturally align it.

Found during an audit of all calls of uses of
iio_push_to_buffers_with_timestamp()

Fixes tag is not accurate, but it will need manual backporting beyond
that point if anyone cares.

Fixes: 0d15190f53b4 ("iio: chemical: atlas-ph-sensor: rename atlas-ph-sensor to atlas-sensor")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-sensor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 56ba6c82b501..6795722c68b2 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -91,8 +91,8 @@ struct atlas_data {
 	struct regmap *regmap;
 	struct irq_work work;
 	unsigned int interrupt_enabled;
-
-	__be32 buffer[6]; /* 96-bit data + 32-bit pad + 64-bit timestamp */
+	/* 96-bit data + 32-bit pad + 64-bit timestamp */
+	__be32 buffer[6] __aligned(8);
 };
 
 static const struct regmap_config atlas_regmap_config = {
-- 
2.31.1

