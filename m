Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD50351E92
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbhDASnp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 14:43:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237199AbhDASdC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 14:33:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2C636135E;
        Thu,  1 Apr 2021 14:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617288964;
        bh=9nGCAXDp6OelbE7tz1e6xJ0PqioU1rqkdi7vdNwhnHs=;
        h=From:To:Cc:Subject:Date:From;
        b=DFO+KLWc6v1piMLn8m7vsnNF6kl0O39zoVez/n6cI2DT7ixcAxdSDyfJW8hUUNmRI
         IOox1YjvwF5Ihj0O5GyaS3vOMBg1lTptaIc9Rf0bSm0zJqA1uwoyuv+RVlZXqCVsvL
         xmDHRKlnSxtmNdaSJv84qiXlzFYhhtSoEXX1io9nXfujiQZAZY4cf5R39v3gV0aSF4
         vue3FBomsJvf/lCYbGzYDwABlftwFMNxUv0hlgqJg8LpVYpSfrbUvQIO815mQMR8Ct
         hMVmiMdm5Lr6PM27XURFes6sTkw/k7sqpxoP0JUEGAbLgIdqENzuaArnvtr8Af71i9
         VssIW+/kyxxKw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH] iio:adc: Drop false comment about lack of timestamp control
Date:   Thu,  1 Apr 2021 15:54:10 +0100
Message-Id: <20210401145410.226917-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The timestamp control has been a function implemented in the core of
IIO for a long time, so this comment is incorrect and has clearly been
cut and paste into all these drivers.

The remainder of the comment added nothing and was confusing so dropped
that as well.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>

---
 drivers/iio/adc/ad7298.c | 6 ------
 drivers/iio/adc/ad7887.c | 6 ------
 drivers/iio/adc/ad7923.c | 6 ------
 drivers/iio/adc/ad799x.c | 6 ------
 4 files changed, 24 deletions(-)

diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 689ecd5dd563..d2163cb62f4f 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -142,12 +142,6 @@ static int ad7298_update_scan_mode(struct iio_dev *indio_dev,
 	return 0;
 }
 
-/*
- * ad7298_trigger_handler() bh of trigger launched polling to ring buffer
- *
- * Currently there is no option in this driver to disable the saving of
- * timestamps within the ring.
- */
 static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 4f6f0e0e03ee..9b3cbe1ddc6f 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -109,12 +109,6 @@ static int ad7887_ring_postdisable(struct iio_dev *indio_dev)
 	return spi_sync(st->spi, &st->msg[AD7887_CH0]);
 }
 
-/*
- * ad7887_trigger_handler() bh of trigger launched polling to ring buffer
- *
- * Currently there is no option in this driver to disable the saving of
- * timestamps within the ring.
- **/
 static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 287f4c13194e..9a649745cd0a 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -192,12 +192,6 @@ static int ad7923_update_scan_mode(struct iio_dev *indio_dev,
 	return 0;
 }
 
-/*
- * ad7923_trigger_handler() bh of trigger launched polling to ring buffer
- *
- * Currently there is no option in this driver to disable the saving of
- * timestamps within the ring.
- */
 static irqreturn_t ad7923_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 1575b7670207..18bf8386d50a 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -182,12 +182,6 @@ static int ad799x_update_config(struct ad799x_state *st, u16 config)
 	return 0;
 }
 
-/*
- * ad799x_trigger_handler() bh of trigger launched polling to ring buffer
- *
- * Currently there is no option in this driver to disable the saving of
- * timestamps within the ring.
- **/
 static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-- 
2.31.1

