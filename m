Return-Path: <linux-iio+bounces-13523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE6F9F255A
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041DE1885486
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C0D1B6CFF;
	Sun, 15 Dec 2024 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8ODDzUg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48B0191461
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287418; cv=none; b=NeEk0zaqLlDJ6PMkclRlf96e59yE+X/7LmrhB8z2IzmGNLa+Jfcu4Z3vMvipl3Gt7fcyk+C0ZV1kL2QQoMdGcYe2acFnGLxh8k7RevUHJiObLI0SdF0OoHBJXC1tqr3IhI8k2rjr4SMa7We8VERUYiLwBz7U3fjcoli649+YoxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287418; c=relaxed/simple;
	bh=a4p6HEQC5fDWXHkQFSRalHiulrtIRFusvcYmrHnSD8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZWb3j0Iv6VxNm9VqqzdE1HCsIEg6PP5mwVx+W3oa1OL+Z4AZlFTo/ArMH4ZaYIsBkfU+RvYuvaSy1M5nIee+/3oMigr0iNXkbwwh8kAarBfwGd0HIEKltYlK2bhXEyQRRRZxjxwaj4j2Q9LCyu77tg7eh64BGPJ45OjFRyAUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8ODDzUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49843C4CECE;
	Sun, 15 Dec 2024 18:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287418;
	bh=a4p6HEQC5fDWXHkQFSRalHiulrtIRFusvcYmrHnSD8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8ODDzUgJmX0XZe32tSdimRN6PwOidKfmBPVcPfjDQgzFIl4Niad35phjPflEgumi
	 vbUautZYnMl2R4Koytq7/x5uoNYNVfUyM0/w6Ix6qXgPryGs0jtZ2FF4jVovz32upl
	 u6hNem+r0wl6QyEKpcTYQoX7/r4LdqxcWIvnV2L2lQRJKb26Qpnwq9cwjuncX28xd+
	 2d+wDW+zyB06moLUtzvB46Hj2AgMurcD4jOGdS8w8z8/HPrmpBzEIfKxu0P58hNOhI
	 SdkR7Wykm2RhlQIn8H+IEE1t1Ka5dp5k2WfYSyWffJelwv+GBPL+XIWxzfPLJ5yDFx
	 ZVy927k+Op2SQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 18/20] iio: imu: inv_icm42600: switch timestamp type from int64_t __aligned(8) to aligned_s64
Date: Sun, 15 Dec 2024 18:29:09 +0000
Message-ID: <20241215182912.481706-19-jic23@kernel.org>
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

The vast majority of IIO drivers use aligned_s64 for the type of the
timestamp field.  It is not a bug to use int64_t and until this series
iio_push_to_buffers_with_timestamp() took and int64_t timestamp, it
is inconsistent.  This change is to remove that inconsistency and
ensure there is one obvious choice for future drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 7968aa27f9fd..388520ec60b5 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -178,7 +178,7 @@ static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 struct inv_icm42600_accel_buffer {
 	struct inv_icm42600_fifo_sensor_data accel;
 	int16_t temp;
-	int64_t timestamp __aligned(8);
+	aligned_s64 timestamp;
 };
 
 #define INV_ICM42600_SCAN_MASK_ACCEL_3AXIS				\
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index c6bb68bf5e14..591ed78a55bb 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -78,7 +78,7 @@ static const struct iio_chan_spec inv_icm42600_gyro_channels[] = {
 struct inv_icm42600_gyro_buffer {
 	struct inv_icm42600_fifo_sensor_data gyro;
 	int16_t temp;
-	int64_t timestamp __aligned(8);
+	aligned_s64 timestamp;
 };
 
 #define INV_ICM42600_SCAN_MASK_GYRO_3AXIS				\
-- 
2.47.1


