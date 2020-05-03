Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DA61C2E57
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 19:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgECRWw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 13:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729055AbgECRWs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 13:22:48 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32CD9206D9;
        Sun,  3 May 2020 17:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588526567;
        bh=H5DRm8kRjmWsw/shw3xhMImAae+jgiKRFKbQATAq3q4=;
        h=From:To:Cc:Subject:Date:From;
        b=wu8nyXlqf0Uv5NWfq1aeKqEXKgALC/818T6eCWOm0guoKvaIBqZZX+BXhN86JaK79
         hFBulFLJ7M/RCmTcdBBY07gS52z+gKmz5i5cP/2VFFNCvaJw0k2PbqiiYXD3+rXiyd
         e0M/51uZ83BYxgNZoCBmVqjNpZqkwd9HF7lUA0mg=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: accel: kxsd9: Fix alignment of local buffer.
Date:   Sun,  3 May 2020 18:22:35 +0100
Message-Id: <20200503172235.207632-1-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

iio_push_to_buffers_with_timestamp assumes 8 byte alignment which
is not guaranteed by an array of 8 __be16.

Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/kxsd9.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 0b876b2dc5bd..4c42d1200914 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -209,14 +209,16 @@ static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
 	const struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct kxsd9_state *st = iio_priv(indio_dev);
+	struct {
+		__be16 chan[4];
+		u64 ts;
+	} hw_values;
 	int ret;
-	/* 4 * 16bit values AND timestamp */
-	__be16 hw_values[8];
 
 	ret = regmap_bulk_read(st->map,
 			       KXSD9_REG_X,
-			       &hw_values,
-			       8);
+			       hw_values.chan,
+			       sizeof(hw_values.chan));
 	if (ret) {
 		dev_err(st->dev,
 			"error reading data\n");
@@ -224,7 +226,7 @@ static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev,
-					   hw_values,
+					   &hw_values,
 					   iio_get_time_ns(indio_dev));
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.26.2

