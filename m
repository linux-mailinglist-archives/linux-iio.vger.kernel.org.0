Return-Path: <linux-iio+bounces-13511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666499F254E
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4B8163D91
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DD01B4F21;
	Sun, 15 Dec 2024 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b96jUKU5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D1A13C8FF
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287388; cv=none; b=Krkw40/E8n90r54Eo7gKoeXx/kpxWQAkhzfutrm/e7c6gnYVzkgBjFy0i9m+itmhLfe5Sr7tPXeHRsNsci/p8wW5+aRRr8SVWbvBtXOigdqujjN4zRkE5afWMswL9a3c2puWxqftcCuFJDfhJC+eQWM8o/nnO+LM5i6Up035Nq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287388; c=relaxed/simple;
	bh=+QSUAQf5K7CbQR9jUqyMbTBvWWZB1GJ6Buqr4USL0qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApKNwWeiF1oF+Dqu/FDZkmd6Fiq9gOmzdkG4l+PudFH76Qntx/9JHyYVT16Pco+rTWe3IfaGLYVNEy4AE0fwiOWwRXKZZ6UHtwRH4Q1+6EgfeySXTSH0O55X8i4d+zKZAQ2qx4FUMsWLwRlYiA9vHCAbRZ05Vrc2qq84RFHe6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b96jUKU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D9EC4CECE;
	Sun, 15 Dec 2024 18:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287388;
	bh=+QSUAQf5K7CbQR9jUqyMbTBvWWZB1GJ6Buqr4USL0qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b96jUKU5KYJUignZK3XevpPN7CH2G3geXezZK+ScrFzBG142r17Tc3W1jHfV47/x9
	 E1t9gsOR6o+ITkLWEnJx+2oeIdRQ83bIGn0VKEnQvbNdiPFMidJEqqqxTBeCAbs4xl
	 t/W5k3Sif4kpcxfKQSuFi6P4fhWmAfyzayY2nTLnTZmsokZZy1oZlmKXIV0rBk68H/
	 WJk9M918mw4/PNI64kXNjfU3r1jzzCW/AejqsSplfnQRLfs7AQ//tOszqhHcPU/AJE
	 1xcu7MnfIwGnQfgjRj/RYsqUnKjnoJ0GENEugS4EQkcrT4t1eqiy4Wsf2fn/9lPzp9
	 5l3f0Olin70NA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 06/20] iio: pressure: Use aligned_s64 instead of open coding alignment.
Date: Sun, 15 Dec 2024 18:28:57 +0000
Message-ID: <20241215182912.481706-7-jic23@kernel.org>
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
 drivers/iio/pressure/hsc030pa.h    | 2 +-
 drivers/iio/pressure/ms5611_core.c | 2 +-
 drivers/iio/pressure/rohm-bm1390.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/hsc030pa.h b/drivers/iio/pressure/hsc030pa.h
index 9b40f46f575f..5db46784f4c6 100644
--- a/drivers/iio/pressure/hsc030pa.h
+++ b/drivers/iio/pressure/hsc030pa.h
@@ -58,7 +58,7 @@ struct hsc_data {
 	s32 p_offset_dec;
 	struct {
 		__be16 chan[2];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	u8 buffer[HSC_REG_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
 };
diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 056c8271c49d..00c077b2a2a4 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -213,7 +213,7 @@ static irqreturn_t ms5611_trigger_handler(int irq, void *p)
 	/* Ensure buffer elements are naturally aligned */
 	struct {
 		s32 channels[2];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 	int ret;
 
diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
index 6cdb2820171a..9c1197f0e742 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -139,7 +139,7 @@ enum {
 struct bm1390_data_buf {
 	u32 pressure;
 	__be16 temp;
-	s64 ts __aligned(8);
+	aligned_s64 ts;
 };
 
 /* BM1390 has FIFO for 4 pressure samples */
-- 
2.47.1


