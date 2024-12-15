Return-Path: <linux-iio+bounces-13512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 455789F254F
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0ED163D81
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4241B6CE6;
	Sun, 15 Dec 2024 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HO9yItQC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981413C8FF
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287390; cv=none; b=UauGWvD9bD7bvdAXXGLdhsM1MZfLo/lt1XJXhiTWgGEeX6JsGAWa+7Xs3DibhpnAt4bOCz7g4BHjLo+ZiR4+pv1Re9F8i+GDTSTMNIglzNhCqaA8QLk7Yk9tY7ePSiTca26Y9YkecuFIe67lRNCWl9HZWriOJJQByb6TRlrXKwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287390; c=relaxed/simple;
	bh=m+y6w6GIvbKIegYZ22Jc1OL6DhIg6Z/Nd+M51osfJ6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKUtyMRsPeRboZd3/Hpk0ACM97FGaizrdd+f4xsqC3YUxPstQwYziP5uQsruU48qhFK2kFGRfjd7LnTMdKDTr+tDj76JZMJV84ESm3OFFLTFexs5urHGsM/KglBj4JWvLE8C0NgtGONmaUApH2/0OqfpdVHOxkXpLcfiu9h7fsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HO9yItQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D68C4CED3;
	Sun, 15 Dec 2024 18:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287389;
	bh=m+y6w6GIvbKIegYZ22Jc1OL6DhIg6Z/Nd+M51osfJ6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HO9yItQCPE+l024lxtTGfWi6yORj2/RBB592+ZyzthEwr6dYRyWrHMxBzhLwSVdcE
	 5yXUdnNoWCQTo966ayOh4WTnGKV+LSOqJQ0RB/ctpoNIZV3H+ryzRi9ehpSyhYiMKN
	 DDssuiotAZQ6hvLrezznoP7WIPyDNW0aOoigus/bk5sGY116KRrVZN5XhBCdhOCwt+
	 AeZPzixWZLDKJFqczj1d7YhieWFIMd+5f6IdKXZtJQl4OrXYSENTpEui7VHwQdvvHV
	 kCEjMV7bsnDPq1gUsy+aqOTuSjq6Z+GPefl7QM8/75zvGDnCCDgDXGK5VSYykZo7Cu
	 4vVlqP4QwtSCA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 07/20] iio: magnetometer: Use aligned_s64 instead of open coding alignment.
Date: Sun, 15 Dec 2024 18:28:58 +0000
Message-ID: <20241215182912.481706-8-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215182912.481706-1-jic23@kernel.org>
References: <20241215182912.481706-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Use this new type to both slightly simplify the code and avoid
confusing static analysis tools. Mostly this series is about consistency
to avoid this code pattern getting copied into more drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/af8133j.c       | 2 +-
 drivers/iio/magnetometer/ak8974.c        | 2 +-
 drivers/iio/magnetometer/ak8975.c        | 2 +-
 drivers/iio/magnetometer/bmc150_magn.c   | 2 +-
 drivers/iio/magnetometer/hmc5843.h       | 2 +-
 drivers/iio/magnetometer/mag3110.c       | 2 +-
 drivers/iio/magnetometer/yamaha-yas530.c | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetometer/af8133j.c
index acd291f3e792..a70bf8a3c73b 100644
--- a/drivers/iio/magnetometer/af8133j.c
+++ b/drivers/iio/magnetometer/af8133j.c
@@ -360,7 +360,7 @@ static irqreturn_t af8133j_trigger_handler(int irq, void *p)
 	s64 timestamp = iio_get_time_ns(indio_dev);
 	struct {
 		__le16 values[3];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} sample;
 	int ret;
 
diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 8306a18706ac..08975c60e325 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -197,7 +197,7 @@ struct ak8974 {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		__le16 channels[3];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 18077fb463a9..ef1363126cc2 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -426,7 +426,7 @@ struct ak8975_data {
 	/* Ensure natural alignment of timestamp */
 	struct {
 		s16 channels[3];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 7f545740178e..88bb673e40d8 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -140,7 +140,7 @@ struct bmc150_magn_data {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		s32 chans[3];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	struct iio_trigger *dready_trig;
 	bool dready_trigger_on;
diff --git a/drivers/iio/magnetometer/hmc5843.h b/drivers/iio/magnetometer/hmc5843.h
index 60fbb5431c88..ffd669b1ee7c 100644
--- a/drivers/iio/magnetometer/hmc5843.h
+++ b/drivers/iio/magnetometer/hmc5843.h
@@ -44,7 +44,7 @@ struct hmc5843_data {
 	struct iio_mount_matrix orientation;
 	struct {
 		__be16 chans[3];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 };
 
diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index 5295dc0100e4..2fe8e97f2cf8 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -60,7 +60,7 @@ struct mag3110_data {
 	struct {
 		__be16 channels[3];
 		u8 temperature;
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 65011a8598d3..bba9f4d7c90a 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -236,7 +236,7 @@ struct yas5xx {
 	 */
 	struct {
 		s32 channels[4];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
-- 
2.47.1


