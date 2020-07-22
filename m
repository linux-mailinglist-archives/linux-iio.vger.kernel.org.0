Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0007229BF3
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 17:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbgGVPxs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 11:53:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732624AbgGVPxs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 11:53:48 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCF5320717;
        Wed, 22 Jul 2020 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595433228;
        bh=dkvt+oaphgkTDUnzSW8KJtLMYyCSAN74BaQkzRu7QWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5T7Sps7jm+JVRfwvn7PtYKDI9gSbAT2mb9e+LA+OFTop2O/C/sU2hRwFLxcjCud3
         ePxJSkDUOCUzVH9MpsebHL9j4UJTrNU9dYGVXUhIlhrpBnBe8lcbd7k/LbfTL5vE03
         brIiem1If4E2r6jXExr+5bKcQEsWnr1Rl9uwkXY0=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
        Marc Titinger <mtitinger@baylibre.com>
Subject: [PATCH v3 26/27] iio:adc:ina2xx Fix timestamp alignment issue.
Date:   Wed, 22 Jul 2020 16:51:02 +0100
Message-Id: <20200722155103.979802-27-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722155103.979802-1-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One of a class of bugs pointed out by Lars in a recent review.
iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
to the size of the timestamp (8 bytes).  This is not guaranteed in
this driver which uses a 32 byte array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable structure in the iio_priv() data with alignment
explicitly requested.  This data is allocated with kzalloc so no
data can leak apart from previous readings. The explicit alignment
isn't technically needed here, but it reduced fragility and avoids
cut and paste into drivers where it will be needed.

If we want this in older stables will need manual backport due to
driver reworks.

Fixes: c43a102e67db ("iio: ina2xx: add support for TI INA2xx Power Monitors")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Stefan Brüns <stefan.bruens@rwth-aachen.de>
Cc: Marc Titinger <mtitinger@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ina2xx-adc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 5ed63e874292..b573ec60a8b8 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -146,6 +146,11 @@ struct ina2xx_chip_info {
 	int range_vbus; /* Bus voltage maximum in V */
 	int pga_gain_vshunt; /* Shunt voltage PGA gain */
 	bool allow_async_readout;
+	/* data buffer needs space for channel data and timestamp */
+	struct {
+		u16 chan[4];
+		u64 ts __aligned(8);
+	} scan;
 };
 
 static const struct ina2xx_config ina2xx_config[] = {
@@ -738,8 +743,6 @@ static int ina2xx_conversion_ready(struct iio_dev *indio_dev)
 static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 {
 	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
-	/* data buffer needs space for channel data and timestap */
-	unsigned short data[4 + sizeof(s64)/sizeof(short)];
 	int bit, ret, i = 0;
 	s64 time;
 
@@ -758,10 +761,10 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 		if (ret < 0)
 			return ret;
 
-		data[i++] = val;
+		chip->scan.chan[i++] = val;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data, time);
+	iio_push_to_buffers_with_timestamp(indio_dev, &chip->scan, time);
 
 	return 0;
 };
-- 
2.27.0

