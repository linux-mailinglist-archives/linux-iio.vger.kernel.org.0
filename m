Return-Path: <linux-iio+bounces-22208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 229AEB18F75
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 18:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D415EAA1BD2
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2C824888A;
	Sat,  2 Aug 2025 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTRC/4Hh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0679256D
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153159; cv=none; b=YT+z661baj1+sMJ985kce1ddbmIa7TWrWPen7BqN+xOy+4KMnMrbVJRMPgg0j50X2zNeVMKqlloTp9itcSGK+a9ixCbP73k1ptvZfu6ugEuQr+7hvM9r6gHS3FRlLeWfeV1IW+cuzqwJXEPWS/7NygHWKkoKHraYKEChtatb84I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153159; c=relaxed/simple;
	bh=K+lB4kuj/ZKl7e+8dD70ut5VPGwdBOfVsssacHkfazo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTRmxi/X1DT1U+w7PDGr5fpCzKlgLbL5OitLdJ24hyLbReuKSkuMQEB+4QDypoNHvuLm2QM5jPULt70sEX2PEq0jnBkh8JRjQBoDLM6kRwApbEm1JYbiEKbWgzEgei4Dt1NWqxX4wh1B26SpzUsob43PHdi6JUngNoEAmLdfFBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTRC/4Hh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F00C4CEEF;
	Sat,  2 Aug 2025 16:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153159;
	bh=K+lB4kuj/ZKl7e+8dD70ut5VPGwdBOfVsssacHkfazo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gTRC/4HhmJ89RFxzdJh0UZj3Wk5+bZCMXflImz5ZYslY/+wWhmiUbwG4MR9/0h6Ea
	 ctJasrUHNmYmifjPAMuLjFOkVjjTHysEl/2l3HnSx3/H0YpsfZGv8IxnmI34tegEke
	 w77qQVCQfzwC4G1Jxf5mEpRAAPGGD01Dtlck8jpSEsV1br7XPotdhs4UDSXmLhCTRs
	 0HIN6KOKTc30CkpREtK2jVufHH2r3PTfbyuTMbTnSIGkZx1lMXtD8Vzy6KXw85lUeu
	 VpjkatHWOGj/7twLMXb8z5bc9AxpUK8dgSgrG0z8KRUo9/nrWtkjbLSSdPvYcRRPCn
	 xLCoBIh6Iscvw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	=?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Christian Eggers <ChristianEggersceggers@arri.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 10/16] iio: light: max44000: Use iio_push_to_buffers_with_ts() to allow source size runtime check
Date: Sat,  2 Aug 2025 17:44:30 +0100
Message-ID: <20250802164436.515988-11-jic23@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802164436.515988-1-jic23@kernel.org>
References: <20250802164436.515988-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Also move the structure used as the source to the stack as it is only 16
bytes and not the target of an DMA or similar.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/max44000.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index e8b767680133..039d45af3a7f 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -75,11 +75,6 @@
 struct max44000_data {
 	struct mutex lock;
 	struct regmap *regmap;
-	/* Ensure naturally aligned timestamp */
-	struct {
-		u16 channels[2];
-		aligned_s64 ts;
-	} scan;
 };
 
 /* Default scale is set to the minimum of 0.03125 or 1 / (1 << 5) lux */
@@ -496,24 +491,29 @@ static irqreturn_t max44000_trigger_handler(int irq, void *p)
 	int index = 0;
 	unsigned int regval;
 	int ret;
+	struct {
+		u16 channels[2];
+		aligned_s64 ts;
+	} scan = { };
+
 
 	mutex_lock(&data->lock);
 	if (test_bit(MAX44000_SCAN_INDEX_ALS, indio_dev->active_scan_mask)) {
 		ret = max44000_read_alsval(data);
 		if (ret < 0)
 			goto out_unlock;
-		data->scan.channels[index++] = ret;
+		scan.channels[index++] = ret;
 	}
 	if (test_bit(MAX44000_SCAN_INDEX_PRX, indio_dev->active_scan_mask)) {
 		ret = regmap_read(data->regmap, MAX44000_REG_PRX_DATA, &regval);
 		if (ret < 0)
 			goto out_unlock;
-		data->scan.channels[index] = regval;
+		scan.channels[index] = regval;
 	}
 	mutex_unlock(&data->lock);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
 
-- 
2.50.1


