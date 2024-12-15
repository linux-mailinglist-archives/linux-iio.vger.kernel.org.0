Return-Path: <linux-iio+bounces-13517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1D49F2554
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA47818854E7
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED281B6CE0;
	Sun, 15 Dec 2024 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oxz8SLFS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6601B6D1B
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287402; cv=none; b=JfP3/W3DMHWu1u7iGZ0ljINcCKJdi9KR/wnnkhM9BiieC5bkprPWGkWpLjf1Kt4F4RdYSWbUH5dLumMtV/iGxKwwnzZH8kC0NifHsile6sslIAYvPSvAN7l1+OkC+6Piffz8jhx8b49dloQOedJxWoNiCTJdi/F6J3fshbTuXPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287402; c=relaxed/simple;
	bh=JoGWBtbWZbHBiA651Caqi7N3fAt5Jfd75roAxvAVrK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZmHV1ZGvgk4i3U33QsDPvmLvDhNdLdK1z+t5vpImtu/+JOxe2Bnwa64XnaqT5SwI45wUZ0L+gGqR7RQkc0kiL8PX/Kp89irZFgCIgNP+Y+lBjlxDK632hhUXviPUzJR1XZ8J183zmjS/QxxU27WtVkCUFPsg6g/EW3pSdpq2Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oxz8SLFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985C3C4CED3;
	Sun, 15 Dec 2024 18:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287402;
	bh=JoGWBtbWZbHBiA651Caqi7N3fAt5Jfd75roAxvAVrK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oxz8SLFSfRE1u9SDLgQiMVvwY+5I2VwCPB/l2p/Sq2SAz5iEeukWltzOOQELUE6N7
	 jA0W9PhA9Yh79rlcOX9g2syEDvsBns6+AiBgoOfxsbXoj7mCLjy6WM6QoHRgptBLN3
	 6fEY8VTBKTZ4avtGVIS92B+7NsYVm8G+zXAIBqzq+Pds2UkMtNbeFyoL+i3yXMXTNL
	 ZCi7bcNUm9YvdgamoxMZ4vamWjg0k/FAr84jJNx0nVyNR0fxw8eDJvfL0e2KGihWIJ
	 SRCOnCMc3VcxolfFoFOSIC0yPjV3vY1WzjUIs9AbAzYTH5VkZJgOpdJuhfKHnyEHdt
	 MDq1aZCAGT9zA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 12/20] iio: chemical: Use aligned_s64 instead of open coding alignment.
Date: Sun, 15 Dec 2024 18:29:03 +0000
Message-ID: <20241215182912.481706-13-jic23@kernel.org>
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
 drivers/iio/chemical/ccs811.c      | 2 +-
 drivers/iio/chemical/ens160_core.c | 2 +-
 drivers/iio/chemical/scd30_core.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 17d1bc518bf2..451fb65dbe60 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -81,7 +81,7 @@ struct ccs811_data {
 	/* Ensures correct alignment of timestamp if present */
 	struct {
 		s16 channels[2];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
index 4a89cd5894d9..48d5ad2075b6 100644
--- a/drivers/iio/chemical/ens160_core.c
+++ b/drivers/iio/chemical/ens160_core.c
@@ -60,7 +60,7 @@ struct ens160_data {
 	struct mutex mutex;
 	struct {
 		__le16 chans[2];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan __aligned(IIO_DMA_MINALIGN);
 	u8 fw_version[3];
 	__le16 buf;
diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index ac3080929f0b..d613c54cb28d 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -594,7 +594,7 @@ static irqreturn_t scd30_trigger_handler(int irq, void *p)
 	struct scd30_state *state = iio_priv(indio_dev);
 	struct {
 		int data[SCD30_MEAS_COUNT];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 	int ret;
 
-- 
2.47.1


