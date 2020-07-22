Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B496E229BDA
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 17:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGVPxK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 11:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgGVPxK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 11:53:10 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB29E20717;
        Wed, 22 Jul 2020 15:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595433189;
        bh=wuvjViPkxYN+MygFOS8mGclaAqsSpkro5stAKw7+5AQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIi2hgoeUPynoiTJlozJQD0uohod0vh0puXLgHqelGivf8knwsrqInMg6UkkhNjbc
         P6ZzLDTBs+uBJyKIsitCyzZulPImSsytbWvmwIuIgFxsC5mRELdbX0Kl7qTjwhBZIa
         dDRhfjZUSVmgLOoiWjaPyhcNf8QwMRqUknctFDZA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 01/27] iio: accel: kxsd9: Fix alignment of local buffer.
Date:   Wed, 22 Jul 2020 16:50:37 +0100
Message-Id: <20200722155103.979802-2-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722155103.979802-1-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

iio_push_to_buffers_with_timestamp assumes 8 byte alignment which
is not guaranteed by an array of smaller elements.

Note that whilst in this particular case the alignment forcing
of the ts element is not strictly necessary it acts as good
documentation.  Doing this where not necessary should cut
down on the number of cut and paste introduced errors elsewhere.

Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/kxsd9.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 66b2e4cf24cf..0e18b92e2099 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -209,14 +209,20 @@ static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
 	const struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct kxsd9_state *st = iio_priv(indio_dev);
+	/*
+	 * Ensure correct positioning and alignment of timestamp.
+	 * No need to zero initialize as all elements written.
+	 */
+	struct {
+		__be16 chan[4];
+		s64 ts __aligned(8);
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
@@ -224,7 +230,7 @@ static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev,
-					   hw_values,
+					   &hw_values,
 					   iio_get_time_ns(indio_dev));
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.27.0

