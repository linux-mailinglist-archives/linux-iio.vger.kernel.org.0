Return-Path: <linux-iio+bounces-13518-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B668D9F2555
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF989163D97
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BDA1B6D1A;
	Sun, 15 Dec 2024 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njLiJmUi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037AD1B4156
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287405; cv=none; b=jfQFGbOWGmRXPAwWENaz+NfjbOVqx1LGeTVx1GQbPZ1MOilxDvJJkYCoLvAI3+G4to1xuBXHEECV4FUTHgms94pTbe8SxXCuFQ0K2ZKwFtuA5xY9Ol0lGmfnkeQtPqbyVp2eqNbAgMRA5WZGuTIpniJBDUVlpJGRi6ZGt+aGzqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287405; c=relaxed/simple;
	bh=Tz2kIHXNsR7NLtjotoHtDO1LS6m1woxE6fmK93UoYXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZAUU0PjH9NraXghEcMHXJ6LegrY9D+eTV/ZhNc8ImrmQWqhtzBNdG5lRvI6uNW6u3dThACxc5K5zp+uSOVPnTL0EbRjaLlc1fivI9yZdkTVYxm/qFUEShzvSQJnKY9jE0IhqTy6K2ELrjXlee2NueXmwA62kNDZZ9yQvRZ4GBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njLiJmUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D5CC4CECE;
	Sun, 15 Dec 2024 18:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287404;
	bh=Tz2kIHXNsR7NLtjotoHtDO1LS6m1woxE6fmK93UoYXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=njLiJmUisl8BYS3NgAZfrCjwMVIoZxDuETMT7R2TYwaoyECJP3CsDoO0YL/K3toDw
	 Os3BA1VOG0gacWO12UyVncG+1mRz1w2ZwCn7nycBthl6+6tIBPPpsjEdz9UYdqS1k7
	 v0rZWx6tN2UW7VentIfotZnka3I5ez5PWYWtJVilCFJviXB2NYH3L4aebCFjABn5ic
	 jZVBvgCyzUbChFxbUYh9rhcRQ2acpksaSq5ToyS7Zi5nTO/UyHuLqi5MGNe2sQh1vJ
	 JAKlXkdBmda4IKBZvqF4G9H0sewgVlHBafdTjxz+UYjZu0pXGgb8ubEYmo4ZjWLMK0
	 IergUF/oLPMAQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 13/20] iio: adc: Use aligned_s64 instead of open coding alignment.
Date: Sun, 15 Dec 2024 18:29:04 +0000
Message-ID: <20241215182912.481706-14-jic23@kernel.org>
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
 drivers/iio/adc/ad4000.c        | 2 +-
 drivers/iio/adc/max1118.c       | 2 +-
 drivers/iio/adc/max11410.c      | 2 +-
 drivers/iio/adc/mcp3911.c       | 2 +-
 drivers/iio/adc/pac1921.c       | 2 +-
 drivers/iio/adc/rtq6056.c       | 2 +-
 drivers/iio/adc/ti-adc081c.c    | 2 +-
 drivers/iio/adc/ti-adc084s021.c | 2 +-
 drivers/iio/adc/ti-ads1015.c    | 2 +-
 drivers/iio/adc/ti-ads1119.c    | 2 +-
 drivers/iio/adc/ti-ads131e08.c  | 2 +-
 drivers/iio/adc/ti-tsc2046.c    | 2 +-
 drivers/iio/adc/vf610_adc.c     | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index c6149a855af3..1d556a842a68 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -414,7 +414,7 @@ struct ad4000_state {
 			__be16 sample_buf16;
 			__be32 sample_buf32;
 		} data;
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan __aligned(IIO_DMA_MINALIGN);
 	u8 tx_buf[2];
 	u8 rx_buf[2];
diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
index 3d0a7d0eb7ee..565ca2e21c0c 100644
--- a/drivers/iio/adc/max1118.c
+++ b/drivers/iio/adc/max1118.c
@@ -39,7 +39,7 @@ struct max1118 {
 	/* Ensure natural alignment of buffer elements */
 	struct {
 		u8 channels[2];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 
 	u8 data __aligned(IIO_DMA_MINALIGN);
diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
index f0dc4b460903..76abafd47404 100644
--- a/drivers/iio/adc/max11410.c
+++ b/drivers/iio/adc/max11410.c
@@ -143,7 +143,7 @@ struct max11410_state {
 	int irq;
 	struct {
 		u32 data __aligned(IIO_DMA_MINALIGN);
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index b097f04172c8..6748b44d568d 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -122,7 +122,7 @@ struct mcp3911 {
 	const struct mcp3911_chip_info *chip;
 	struct {
 		u32 channels[MCP39XX_MAX_NUM_CHANNELS];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 
 	u8 tx_buf __aligned(IIO_DMA_MINALIGN);
diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index 9f7b3d58549d..90f61c47b1c4 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -209,7 +209,7 @@ struct pac1921_priv {
 
 	struct {
 		u16 chan[PAC1921_NUM_MEAS_CHANS];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 };
 
diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index 56ed948a8ae1..337bc8b31b2c 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -634,7 +634,7 @@ static irqreturn_t rtq6056_buffer_trigger_handler(int irq, void *p)
 	struct device *dev = priv->dev;
 	struct {
 		u16 vals[RTQ6056_MAX_CHANNEL];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} data;
 	unsigned int raw;
 	int i = 0, bit, ret;
diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 6c2cb3dabbbf..1af9be071d8d 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -37,7 +37,7 @@ struct adc081c {
 	/* Ensure natural alignment of buffer elements */
 	struct {
 		u16 channel;
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index bf98f9bf942a..da16876c32ae 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -29,7 +29,7 @@ struct adc084s021 {
 	/* Buffer used to align data */
 	struct {
 		__be16 channels[4];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 47fe8e16aee4..4355726b373a 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -448,7 +448,7 @@ static irqreturn_t ads1015_trigger_handler(int irq, void *p)
 	/* Ensure natural alignment of timestamp */
 	struct {
 		s16 chan;
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	int chan, ret, res;
 
diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index e9d9d4d46d38..0a68ecdea4e6 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -501,7 +501,7 @@ static irqreturn_t ads1119_trigger_handler(int irq, void *private)
 	struct ads1119_state *st = iio_priv(indio_dev);
 	struct {
 		unsigned int sample;
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	unsigned int index;
 	int ret;
diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index 31f1f229d97a..91a79ebc4bde 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -102,7 +102,7 @@ struct ads131e08_state {
 	struct completion completion;
 	struct {
 		u8 data[ADS131E08_NUM_DATA_BYTES_MAX];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} tmp_buf;
 
 	u8 tx_buf[3] __aligned(IIO_DMA_MINALIGN);
diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index b56f2503f14c..7dde5713973f 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -157,7 +157,7 @@ struct tsc2046_adc_priv {
 		/* Scan data for each channel */
 		u16 data[TI_TSC2046_MAX_CHAN];
 		/* Timestamp */
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan_buf;
 
 	/*
diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 61bba39f7e93..513365d42aa5 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -173,7 +173,7 @@ struct vf610_adc {
 	/* Ensure the timestamp is naturally aligned */
 	struct {
 		u16 chan;
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 };
 
-- 
2.47.1


