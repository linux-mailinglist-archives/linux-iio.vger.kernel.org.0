Return-Path: <linux-iio+bounces-22204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FFAB18F71
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 18:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F018217EEDB
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 16:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314DE24678D;
	Sat,  2 Aug 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZNmRwwY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D7C15ADB4
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153135; cv=none; b=bETgFA+9KP4Z0hVxtxbLYFU7Xk+fdKA34cBPlR+lnC95jKLxeouZrv3zxef96rvdg2NCdth5HKD8m7pLkdO5s/MG7aAvUaecP/5y1vLx+SYZv8+l+UukH3bv4EL/v0nobpdSCusGWwID1uqFChHi1nMlKBwdEsS5uWgSaBYqY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153135; c=relaxed/simple;
	bh=PlvA4lZMueGFlGq1Mg/UzS4YChjX2kngz+g0gj7EFZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEVPbY1fHW1d03D0PQ56a+2/+RCFPSYNNLZ5IbPJhv/kJwpt1HDTAKahioFNx7vuajon5pSX8kC4Stm42Os5Pg/6TNHbGLtAxiNpcwdrf/m6H5ftVrj0YAZ8dOVNQjffORytP2uCUnIV/m4X0VtBj9rxinZRG8OZdYpjaVLWQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZNmRwwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DF7C4CEEF;
	Sat,  2 Aug 2025 16:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153134;
	bh=PlvA4lZMueGFlGq1Mg/UzS4YChjX2kngz+g0gj7EFZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZNmRwwYdA8jMxmBF7tX00KQ/ZOGBf+JoVvA/5Cq+knB7EeddqC4ERyqQt2gVtdeF
	 NuiJXSYdltmEp20rX22Z05Q6eHoRJBWhulpkYNV4Y/BVUnIDMwn7NpLI+ZVmipe0hu
	 fA8TgGQKEG9YLgZlYO8SqPKnP+drSpeG288/0igYwKIo3QAE1WAqjs3NJvx1Dh/kHR
	 7/N7M5LXeL3NqEI5qb6rfmCT4cSAmq41qY1Cg/n70qq0Y04fWk51ZcFDLKdYvGNcdE
	 BSdfbFYCEXWasNhbXlQkbtoRy/mg7+npUA/mqyVYof61x2Fy2o2BSbLxRRTaGKsdEq
	 GMySnwyoLhlng==
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
Subject: [PATCH 06/16] iio: light: acpi-als: Use a structure for layout of data to push to buffer.
Date: Sat,  2 Aug 2025 17:44:26 +0100
Message-ID: <20250802164436.515988-7-jic23@kernel.org>
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

Using a structure makes the padding and alignment rules explicit,
removing the need for a comment.

Also move the storage to the stack as it is only 16 bytes.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/light/acpi-als.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 032e6cae8b80..511ed37e783e 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -49,20 +49,10 @@ static const struct iio_chan_spec acpi_als_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
-/*
- * The event buffer contains timestamp and all the data from
- * the ACPI0008 block. There are multiple, but so far we only
- * support _ALI (illuminance): One channel, padding and timestamp.
- */
-#define ACPI_ALS_EVT_BUFFER_SIZE		\
-	(sizeof(s32) + sizeof(s32) + sizeof(s64))
-
 struct acpi_als {
 	struct acpi_device	*device;
 	struct mutex		lock;
 	struct iio_trigger	*trig;
-
-	s32 evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE / sizeof(s32)]  __aligned(8);
 };
 
 /*
@@ -152,7 +142,10 @@ static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct acpi_als *als = iio_priv(indio_dev);
-	s32 *buffer = als->evt_buffer;
+	struct {
+		s32 light;
+		aligned_s64 ts;
+	} scan = { };
 	s32 val;
 	int ret;
 
@@ -161,7 +154,7 @@ static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
 	ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
 	if (ret < 0)
 		goto out;
-	*buffer = val;
+	scan.light = val;
 
 	/*
 	 * When coming from own trigger via polls, set polling function
@@ -174,7 +167,7 @@ static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
 	if (!pf->timestamp)
 		pf->timestamp = iio_get_time_ns(indio_dev);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
 out:
 	mutex_unlock(&als->lock);
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.50.1


