Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1EA33A776
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhCNSSU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234046AbhCNSSG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:18:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A71B64E31;
        Sun, 14 Mar 2021 18:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745886;
        bh=tBFFcoLPW9gF6RHgcVOsan/jaW0Ukp1GHSb048G1YEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B4C+8LMN0C5nlup6TVTqVdkqc+J++pHp62Bgz+NXNoi0z5GfIqN06EsWzVyye3eCy
         1TmmdJzaBaAt5IaJK/6JfJ1xJLmPhrheQlWTdAHabBzcJxQIGOGGV+9SuI6oQ+Zscs
         DClhypHiTMyQJMIqTq9lUJBn5k3D/zuL0Mg7/LGPV/o6TMoZZf2vOVhFhftlIzc4yz
         dVyOpnvpcDp2VrNp2Mn3nAjratH1XNrGKlCby673683IsES/psEhmAcfP66POBzMJC
         YcMnupWWjP0G1l8OTt5g+QD6aD09o+77SHEKZDOcFn6R7hK4LKoYr/K6yOBTKn3YoA
         Qaa0Zg5cAEp+g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 22/24] staging:iio:cdc:ad7150: Add copyright notice given substantial changes.
Date:   Sun, 14 Mar 2021 18:15:09 +0000
Message-Id: <20210314181511.531414-23-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

It seems to me that the changes made to get this ready to move out of
staging are substantial enough to warant a copyright notice addition.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20210207154623.433442-24-jic23@kernel.org
---
 drivers/staging/iio/cdc/ad7150.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 0afad49bcddc..b6d2c02fa39d 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -3,6 +3,7 @@
  * AD7150 capacitive sensor driver supporting AD7150/1/6
  *
  * Copyright 2010-2011 Analog Devices Inc.
+ * Copyright 2021 Jonathan Cameron <Jonathan.Cameron@huawei.com>
  */
 
 #include <linux/bitfield.h>
-- 
2.30.2

