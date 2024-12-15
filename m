Return-Path: <linux-iio+bounces-13510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE129F254D
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13110163DC2
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972EA1B6CE0;
	Sun, 15 Dec 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSsC1Diq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DF013C8FF
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287385; cv=none; b=YGRtb3weGVvkzMXynjKV7rjOwF9gd/tWxnzC2Ns/tMAH+VnYTmLIaX1OeOgIONcBUpyuYaO/WAR7jtjOCRWgSahOvhZKazRXoQe0ThdVUuxSMg4cUiCQ4+zTdTYRsY6TX2dhQlAespyChFscaExap3nDawhUiQ43S/aVbpAAOtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287385; c=relaxed/simple;
	bh=ZY6Ge5XFAfx+PwOfwawtOirybKhWZFqSUbvMUDsBvAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXB4jHBbgq1dh2iJ7sgqNJovbhwXWG3/FHp/NPzCtDvXgRFpqOcfxb4u/g8MNfqd+e7Nf32dWdltpgwXWNMfFNIjY/4r3OAvDInbJZUNRCsui0QYrSoD8bRZw2ENqCVA+0q1B+7SFpTvLssPYQljraI+h1R006up1AId9sarrwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSsC1Diq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1C3C4CED3;
	Sun, 15 Dec 2024 18:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287384;
	bh=ZY6Ge5XFAfx+PwOfwawtOirybKhWZFqSUbvMUDsBvAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PSsC1DiqjZT2isgPMGZngh6kfATvB7vfaCuk0UlSsdOAirOmHsKxZdkg/p+BwnHhl
	 D5eicPWqB8Zj/G4WsaWSGVDNgiiCWKCQhFmxgnShIgGAmqw+zBFdU6eEYN7aPejnRy
	 yEhBxejqhIdX8icVffdGwj55LDVnLj7vrChqFrHW59Qobg3YgNary5N4EzJmlUYVWa
	 K8eQcIjRJksKL0Dt+yJeRok8aSN6NBPsZRDsHCfRxBBgvUQ/zI/MpqP56cF4pYqYig
	 hOlXdvgsjgmDHQR3h0QLu+GtPfqoXzo53NfWQGE7kQApIXJNdPB2d8WW61sdEYW5K9
	 8knDSgKSXS/Pg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 05/20] iio: proximity: Use aligned_s64 instead of open coding alignment.
Date: Sun, 15 Dec 2024 18:28:56 +0000
Message-ID: <20241215182912.481706-6-jic23@kernel.org>
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
 drivers/iio/proximity/as3935.c                    | 2 +-
 drivers/iio/proximity/hx9023s.c                   | 2 +-
 drivers/iio/proximity/mb1232.c                    | 2 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 2 +-
 drivers/iio/proximity/srf08.c                     | 2 +-
 drivers/iio/proximity/sx_common.h                 | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index 96fa97451cbf..9d3caf2bef18 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -63,7 +63,7 @@ struct as3935_state {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		u8 chan;
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	u8 buf[2] __aligned(IIO_DMA_MINALIGN);
 };
diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 4021feb7a7ac..99788c116c85 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -134,7 +134,7 @@ struct hx9023s_data {
 
 	struct {
 		__le16 channels[HX9023S_CH_NUM];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} buffer;
 
 	/*
diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
index 614e65cb9d42..cfc75d001f20 100644
--- a/drivers/iio/proximity/mb1232.c
+++ b/drivers/iio/proximity/mb1232.c
@@ -45,7 +45,7 @@ struct mb1232_data {
 	/* Ensure correct alignment of data to push to IIO buffer */
 	struct {
 		s16 distance;
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 5c959730aecd..f3d054b06b4c 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -47,7 +47,7 @@ struct lidar_data {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		u16 chan;
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 };
 
diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index a75ea5042876..86cab113ef3d 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -66,7 +66,7 @@ struct srf08_data {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		s16 chan;
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 
 	/* Sensor-Type */
diff --git a/drivers/iio/proximity/sx_common.h b/drivers/iio/proximity/sx_common.h
index fb14e6f06a6d..259b5c695233 100644
--- a/drivers/iio/proximity/sx_common.h
+++ b/drivers/iio/proximity/sx_common.h
@@ -125,7 +125,7 @@ struct sx_common_data {
 	/* Ensure correct alignment of timestamp when present. */
 	struct {
 		__be16 channels[SX_COMMON_MAX_NUM_CHANNELS];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} buffer;
 
 	unsigned int suspend_ctrl;
-- 
2.47.1


