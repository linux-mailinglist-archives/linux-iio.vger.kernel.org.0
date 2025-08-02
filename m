Return-Path: <linux-iio+bounces-22214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B60BEB18F7B
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 18:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6770163A65
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE9524EF6B;
	Sat,  2 Aug 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzhlqAsi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F16124DCF6
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153197; cv=none; b=NtJ2iG5aZ8I/BHXVdUJ7L361GKrsiv+uDRtr9JoU2rpMd1ZDaBQAIPKxVa5XaF7mQjF86G5N4JNVCZ5QOoERbuvnE/d1SN9ertM76TzKjxd0QkpwmekstZZFZXc1cTfyASx/85hOrMRlXzvD8dU2oFxkUgbTbb+/gv2hWIdc388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153197; c=relaxed/simple;
	bh=MLj7mIeLjc5a5EhQQA9CSg2c7Hh4BgY2u2a20mPeBaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtlwwChsScddgvfLd3FHyqs6hcOT7+ewl7Xo9QEQnhQyvQVNX9TjPAg1tGbXmRJ/e76o60hSCAaH+QiNh9UxTB/toHbYIQg7qw0fQrMfJ6cnwETNjUvzyMOiasXtmlA1FnV+WDB4S9KD6e6qHFMVihVrB5uRj6+THvWViCC+D9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzhlqAsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CF2C4CEF4;
	Sat,  2 Aug 2025 16:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153197;
	bh=MLj7mIeLjc5a5EhQQA9CSg2c7Hh4BgY2u2a20mPeBaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SzhlqAsi1ZYj9rzHt1WIia1KJdhGtXgPRV8EfRfcS2D4A12xm1PQKBNd7/RACdpV0
	 h94qQy+HKxUPpetNMH5nH6uTHCnom1XKhsKfQwKJWC5TiJgP0BNAUzNTG1LozCW+7P
	 VQko8jVKRmqxBDmHOY5AA8sYDEl4X7Kzrk2nxor6//DW4czDbSNT29MxeQSDYefW6L
	 wmONFNtc+t72XgGmbIbdy9SJCednIHpLhhdlzQy/bmqO6HxaxuO8ZlhF8ccrlvXIHu
	 PxI7Pb9paaXatmSiLjJdU+Hx3ouH8++1xRFhmy4E7VrKn5yRwJlYakwJ7gBCm9wsad
	 zGOd9wvJnxT0g==
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
Subject: [PATCH 16/16] iio: light: Simple conversions to iio_push_to_buffers_with_ts()
Date: Sat,  2 Aug 2025 17:44:36 +0100
Message-ID: <20250802164436.515988-17-jic23@kernel.org>
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

This new function allows for runtime checks on the provided source buffer
being of sufficient size to accommodate the enabled channel data layout and
the naturally aligned s64 timestamp (which is non obvious and a frequent
source of bugs in the past).

This patch includes the remaining simple cases for light sensor drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mudit Sharma <muditsharma.info@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/light/bh1745.c         | 4 ++--
 drivers/iio/light/hid-sensor-als.c | 5 +++--
 drivers/iio/light/ltr501.c         | 4 ++--
 drivers/iio/light/opt4060.c        | 2 +-
 drivers/iio/light/rohm-bu27034.c   | 3 ++-
 drivers/iio/light/rpr0521.c        | 4 ++--
 drivers/iio/light/si1145.c         | 5 +++--
 drivers/iio/light/vcnl4000.c       | 4 ++--
 drivers/iio/light/veml6030.c       | 2 +-
 9 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index 4e9bd8f831f7..74a7bf9d610d 100644
--- a/drivers/iio/light/bh1745.c
+++ b/drivers/iio/light/bh1745.c
@@ -755,8 +755,8 @@ static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
 		scan.chans[j++] = value;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 
 err:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 830e5ae7f34a..384572844162 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -262,8 +262,9 @@ static int als_proc_event(struct hid_sensor_hub_device *hsdev,
 		if (!als_state->timestamp)
 			als_state->timestamp = iio_get_time_ns(indio_dev);
 
-		iio_push_to_buffers_with_timestamp(indio_dev, &als_state->scan,
-						   als_state->timestamp);
+		iio_push_to_buffers_with_ts(indio_dev, &als_state->scan,
+					    sizeof(als_state->scan),
+					    als_state->timestamp);
 		als_state->timestamp = 0;
 	}
 
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index debf57a52d1c..022e0693983b 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1315,8 +1315,8 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
 		scan.channels[j++] = psdata & LTR501_PS_DATA_MASK;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index 566f1bb8fe2a..3c8d34b97dc8 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -1104,7 +1104,7 @@ static irqreturn_t opt4060_trigger_handler(int irq, void *p)
 		}
 	}
 
-	iio_push_to_buffers_with_timestamp(idev, &raw, pf->timestamp);
+	iio_push_to_buffers_with_ts(idev, &raw, sizeof(raw), pf->timestamp);
 err_read:
 	iio_trigger_notify_done(idev->trig);
 	return IRQ_HANDLED;
diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
index 7cec5e943373..28d111ac8c0a 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -1193,7 +1193,8 @@ static int bu27034_buffer_thread(void *arg)
 			 */
 			data->scan.mlux = (u32)mlux;
 		}
-		iio_push_to_buffers_with_timestamp(idev, &data->scan, tstamp);
+		iio_push_to_buffers_with_ts(idev, &data->scan,
+					    sizeof(data->scan), tstamp);
 	}
 
 	return 0;
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index c50183f07240..fbd116272921 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -457,8 +457,8 @@ static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
 		data->scan.channels,
 		(3 * 2) + 1);	/* 3 * 16-bit + (discarded) int clear reg. */
 	if (!err)
-		iio_push_to_buffers_with_timestamp(indio_dev,
-						   &data->scan, pf->timestamp);
+		iio_push_to_buffers_with_ts(indio_dev, &data->scan,
+					    sizeof(data->scan), pf->timestamp);
 	else
 		dev_err(&data->client->dev,
 			"Trigger consumer can't read from sensor.\n");
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 4aa02afd853e..f8eb251eca8d 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -494,8 +494,9 @@ static irqreturn_t si1145_trigger_handler(int irq, void *private)
 			goto done;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-		iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, data->buffer,
+				    sizeof(data->buffer),
+				    iio_get_time_ns(indio_dev));
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index eccf690eae8c..cc81a30b7c70 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1698,8 +1698,8 @@ static irqreturn_t vcnl4010_trigger_handler(int irq, void *p)
 	if (!data_read)
 		goto end;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 
 end:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 0945f146bedb..6bcacae3863c 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -903,7 +903,7 @@ static irqreturn_t veml6030_trigger_handler(int irq, void *p)
 		scan.chans[i++] = reg;
 	}
 
-	iio_push_to_buffers_with_timestamp(iio, &scan, pf->timestamp);
+	iio_push_to_buffers_with_ts(iio, &scan, sizeof(scan), pf->timestamp);
 
 done:
 	iio_trigger_notify_done(iio->trig);
-- 
2.50.1


