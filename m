Return-Path: <linux-iio+bounces-13516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F589F2553
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8AE18854F6
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFD41B6CFB;
	Sun, 15 Dec 2024 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq9SxiBN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63013C8FF
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287400; cv=none; b=fbBm/d/ZK+TsmbRoGz34C9FUNdoc3HRH2xYD8tgTb4laFSots4//WxPi8/LJ1c9u+r0QdqYHjKHvPVNfAtQDrfzAkUJ5EPtQAyvjc8iNP09GDw6Eh3wRmFIaxdRhT/UsAlAhX259B2Elxi8CJdwcMaZCK/C20BAX+6Z5X8TsCeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287400; c=relaxed/simple;
	bh=LhETy10JQBo3cEySUrTFG8l8CIbO3yNgAUzDxGtc02g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwRPjKl3Wo+zukqEqC3kVBAs2lWLX9XXwwgiCN99QuCVDF3l+zkZMjkKTX+xfZmWPr4IOQLm/PkXNYuNfEHVUylHFVsClYyyPPZENeMbBJ8yLtsD0todcjTPlkEiZRNhvkN2lQNuAFCA90DRBN3HdcJgAc8LVLyW7nQ0bNu4C+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq9SxiBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88353C4CECE;
	Sun, 15 Dec 2024 18:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287400;
	bh=LhETy10JQBo3cEySUrTFG8l8CIbO3yNgAUzDxGtc02g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eq9SxiBNcYMYZ5KCHBL39EtiJmCoNzF5weWt0WA0duezWF/jYK1h9SUO+zX5akAyI
	 1JYdE0AEhDN0iZTh3+3WbjuOMoPLyEmbTc0FVRlyBp7V+EDP7bRDOgq2v0VEmTRjrI
	 phaohiLZ38P4UzrKZdztjAmHE49sNFvxrAMD2E48H5+Zgaar8sZrVucknezOqUT1Gl
	 zJ5zZI9PHsGA4Es7E81IrcCncE5MeSQ9VxZtiIBgvu+n4plsErRJGd0NVtn+GG7P+/
	 B/oL2KQtcHVdtlB/TVfzyVtp3IDckxDyuO9X9vhOgfcyidm9LmT8QLTMZu09QB8aTv
	 BxEsQe+0aaCGA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 11/20] iio: gyro: Use aligned_s64 instead of open coding alignment.
Date: Sun, 15 Dec 2024 18:29:02 +0000
Message-ID: <20241215182912.481706-12-jic23@kernel.org>
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
 drivers/iio/gyro/adxrs290.c       | 2 +-
 drivers/iio/gyro/bmg160_core.c    | 2 +-
 drivers/iio/gyro/itg3200_buffer.c | 2 +-
 drivers/iio/gyro/mpu3050-core.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index 600e9725da78..223fc181109c 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -75,7 +75,7 @@ struct adxrs290_state {
 	/* Ensure correct alignment of timestamp when present */
 	struct {
 		s16 channels[3];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} buffer;
 };
 
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index ba877d067afb..deb3c6459dde 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -99,7 +99,7 @@ struct bmg160_data {
 	/* Ensure naturally aligned timestamp */
 	struct {
 		s16 chans[3];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	u32 dps_range;
 	int ev_enable_state;
diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index 4cfa0d439560..a624400a239c 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -52,7 +52,7 @@ static irqreturn_t itg3200_trigger_handler(int irq, void *p)
 	 */
 	struct {
 		__be16 buf[ITG3200_SCAN_ELEMENTS];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 
 	int ret = itg3200_read_all_channels(st->i2c, scan.buf);
diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index b6883e8b2a8b..d66224bed8e3 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -474,7 +474,7 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
 	int ret;
 	struct {
 		__be16 chans[4];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	s64 timestamp;
 	unsigned int datums_from_fifo = 0;
-- 
2.47.1


