Return-Path: <linux-iio+bounces-16634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6934DA58727
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9942816A4A7
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10241FF7CC;
	Sun,  9 Mar 2025 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0cE+iSI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6CE1FE460
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544518; cv=none; b=eVEMOogfWidIUYg+4kKUHMMRRnEQTQUMBoXXwxkWtXQImFr8ooEVhPdiC2cWPcRj9gUs/eLgWhiDpUVirw5bsEW+P2J3lTAwbqe60P/vNZ9sfvorTGYniN3UUPAWWSq7UPFikbSOMoxsEHgJABzIQshlkyExLAO4CWw+FwIzifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544518; c=relaxed/simple;
	bh=FP0MoQLbA7d6Nx2+V4jgjeOj12NVoGbzJLsbSlJpJRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9p+r7yO++cc0wGQkSQC1ENh5AYqTJX7vMdByIs2cjtJw6f8kBNycLdZXxC1xVLbCuqsnFgZ6CxnRoQj6yhGkIgufHZjj8Bo1m3iQigmoXuHtZSk91VqN+mMFrc0mt6z/vOOJV1JcRfVLPxD7K0bjAF2AebBcQs3qzXTXS9HcVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0cE+iSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9C4C4CEE3;
	Sun,  9 Mar 2025 18:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741544518;
	bh=FP0MoQLbA7d6Nx2+V4jgjeOj12NVoGbzJLsbSlJpJRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A0cE+iSIv91fyH4DDb8jz/FbW/uTihsgIEC8XukmrRtJlMebXXLn4nj0q5/jHuZ34
	 WMZYLxuKtwtQsMSnXcqAL6D51CgNB9FYkLf0X15LSIqHzsh/uZYs9Uz8BoW7rLtmnl
	 0pLYdFARQR7bLI3AW0Bv7Vo1XY019R5ueorpnrVL9LvZmv83EJXJpQECswOnhBu1gG
	 BwWJEjIhwbEX0e4TM9Dg4tIBSha6Hm3RfpA6jqIZjlEGxFfv07tHb1c0W4+HzQfb5Q
	 iCQVCJZMGPfb3ZEt7w2UtWFJgx0OTXlHrBY+Jk3wvQpr9QhZP6joK4eKF2Uw2TSsfi
	 VdvQYc9EBTMdA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 08/16] iio: chemical: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun,  9 Mar 2025 18:20:52 +0000
Message-ID: <20250309182100.1351128-9-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309182100.1351128-1-jic23@kernel.org>
References: <20250309182100.1351128-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This new function allows us to perform debug checks in the helper to ensure
that the overrun does not occur.  Use it in all the simple cases where
either a static buffer or a structure is used in the drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/atlas-sensor.c | 5 +++--
 drivers/iio/chemical/bme680_core.c  | 4 ++--
 drivers/iio/chemical/ccs811.c       | 4 ++--
 drivers/iio/chemical/ens160_core.c  | 4 ++--
 drivers/iio/chemical/pms7003.c      | 5 +++--
 drivers/iio/chemical/scd30_core.c   | 3 ++-
 drivers/iio/chemical/scd4x.c        | 3 ++-
 drivers/iio/chemical/sps30.c        | 4 ++--
 8 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 593b73ccbeb7..39181bb3e953 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -458,8 +458,9 @@ static irqreturn_t atlas_trigger_handler(int irq, void *private)
 			      &data->buffer, sizeof(__be32) * channels);
 
 	if (!ret)
-		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-				iio_get_time_ns(indio_dev));
+		iio_push_to_buffers_with_ts(indio_dev, data->buffer,
+					    sizeof(data->buffer),
+					    iio_get_time_ns(indio_dev));
 
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 9d73fd2cf52c..3e850562ab00 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -1120,8 +1120,8 @@ static irqreturn_t bme680_trigger_handler(int irq, void *p)
 	gas_range = FIELD_GET(BME680_GAS_RANGE_MASK, gas_regs_val);
 	data->scan.chan[3] = bme680_compensate_gas(data, adc_gas_res, gas_range);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 1eab256a1e00..998c9239c4c7 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -343,8 +343,8 @@ static irqreturn_t ccs811_trigger_handler(int irq, void *p)
 		goto err;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    iio_get_time_ns(indio_dev));
 
 err:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
index 152f81ff57e3..6cec60074827 100644
--- a/drivers/iio/chemical/ens160_core.c
+++ b/drivers/iio/chemical/ens160_core.c
@@ -267,8 +267,8 @@ static irqreturn_t ens160_trigger_handler(int irq, void *p)
 	if (ret)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    pf->timestamp);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index d0bd94912e0a..d268d05cdec9 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -126,8 +126,9 @@ static irqreturn_t pms7003_trigger_handler(int irq, void *p)
 		pms7003_get_pm(frame->data + PMS7003_PM10_OFFSET);
 	mutex_unlock(&state->lock);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &state->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &state->scan,
+				    sizeof(state->scan),
+				    iio_get_time_ns(indio_dev));
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 3fed6b63710f..8316720b1fa3 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -601,7 +601,8 @@ static irqreturn_t scd30_trigger_handler(int irq, void *p)
 	if (ret)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index 4877bd3e907b..2463149519b6 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -675,7 +675,8 @@ static irqreturn_t scd4x_trigger_handler(int irq, void *p)
 	if (ret)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index 6f4f2ba2c09d..2554ef74e141 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -117,8 +117,8 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
 	if (ret)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.48.1


