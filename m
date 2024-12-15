Return-Path: <linux-iio+bounces-13513-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 575A59F2550
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C120D1885483
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEC91B6CE0;
	Sun, 15 Dec 2024 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5zHw8fA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95F713C8FF
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287392; cv=none; b=qRdUOidMhWf9AaO0frVYs6DKr8jT34LFwpUTba9AvtzwgvH4R//f9F7oXse74TlaE/uOqL3qB8ahPVtJ9ZRKZc1Ad6WG9vpfKXF/MEEeoQl2jNV2hDmOXE/hCHF5wHcEtKJ1niqYP/EFXjreqHylA67qMp4LHPFmPm4g88eaa4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287392; c=relaxed/simple;
	bh=RnWFaqvQpNM8CAPFk2rcMnaC7d6LYv68VRpgYd5lG1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTCnQ/z89x99WibwSluJzSOlKE3AAdwUlB6XCXc3CxzSRJC4mSSrnVpUvTu3wEUR/RvWVvg4u1gQUZv5y6vClA8mnPqAxIlFjoIA90wT5HEXHIehRG0lrhVP5lxm6Wyrw8L0V0G4SF/mTngtX5jwqeHyLI+aBLpFTqe3i/BvxQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5zHw8fA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2803BC4CEDD;
	Sun, 15 Dec 2024 18:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287392;
	bh=RnWFaqvQpNM8CAPFk2rcMnaC7d6LYv68VRpgYd5lG1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C5zHw8fAKhB7yqvPa7o2Ds9IvszjwX5FEzhQaZGnL8x0kcaWzKx8wu8/tREXQ+1xa
	 EEiTStTbQWWrS/6X+o45jArlsdzxRq72yR8oYO/3NAiQAxLZHyKt6EVmoZqXKXHkwM
	 fcUe7AeU0c0nfGM4cFhYh6fh3VKjM7QR3IFgE8hnDyQ13AurNI1l3dboNqANbFESsY
	 JN+ia2nxITMca/FIehS8wAPTD240Vh2vT8BibVYBOGzKBetasINT5b7YXApdFwnu0A
	 UURr82it8GuZK2qnFvEbX0g1hUDGecal/p6TnjZ2dysNEMuW+h/DPN2n5i/HXkQN52
	 yWBOkF5hYda2Q==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 08/20] iio: light: Use aligned_s64 instead of open coding alignment.
Date: Sun, 15 Dec 2024 18:28:59 +0000
Message-ID: <20241215182912.481706-9-jic23@kernel.org>
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
 drivers/iio/light/adjd_s311.c    | 2 +-
 drivers/iio/light/as73211.c      | 2 +-
 drivers/iio/light/bh1745.c       | 2 +-
 drivers/iio/light/isl29125.c     | 2 +-
 drivers/iio/light/ltr501.c       | 2 +-
 drivers/iio/light/max44000.c     | 2 +-
 drivers/iio/light/rohm-bu27034.c | 2 +-
 drivers/iio/light/rpr0521.c      | 2 +-
 drivers/iio/light/st_uvis25.h    | 2 +-
 drivers/iio/light/tcs3414.c      | 2 +-
 drivers/iio/light/tcs3472.c      | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index c1b43053fbc7..cf96e3dd8bc6 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -56,7 +56,7 @@ struct adjd_s311_data {
 	struct i2c_client *client;
 	struct {
 		s16 chans[4];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index be0068081ebb..e0d3f05fcfe7 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -636,7 +636,7 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 	struct as73211_data *data = iio_priv(indio_dev);
 	struct {
 		__le16 chan[4];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 	int data_result, ret;
 
diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index 56e32689bb97..00a33760893e 100644
--- a/drivers/iio/light/bh1745.c
+++ b/drivers/iio/light/bh1745.c
@@ -739,7 +739,7 @@ static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
 	struct bh1745_data *data = iio_priv(indio_dev);
 	struct {
 		u16 chans[4];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	u16 value;
 	int ret;
diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index b176bf4c884b..326dc39e7929 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -54,7 +54,7 @@ struct isl29125_data {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		u16 chans[3];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 };
 
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 604f5f900a2e..669da0840eba 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1280,7 +1280,7 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
 	struct ltr501_data *data = iio_priv(indio_dev);
 	struct {
 		u16 channels[3];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 	__le16 als_buf[2];
 	u8 mask = 0;
diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index b935976871a6..e8b767680133 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -78,7 +78,7 @@ struct max44000_data {
 	/* Ensure naturally aligned timestamp */
 	struct {
 		u16 channels[2];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
index 5a3515e47871..cc25596cb248 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -206,7 +206,7 @@ struct bu27034_data {
 	struct {
 		u32 mlux;
 		__le16 channels[BU27034_NUM_HW_DATA_CHANS];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 56f5fbbf79ac..2ba917c5c138 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -203,7 +203,7 @@ struct rpr0521_data {
 	struct {
 		__le16 channels[3];
 		u8 garbage;
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/light/st_uvis25.h b/drivers/iio/light/st_uvis25.h
index 283086887caf..1f93e3dc45c2 100644
--- a/drivers/iio/light/st_uvis25.h
+++ b/drivers/iio/light/st_uvis25.h
@@ -30,7 +30,7 @@ struct st_uvis25_hw {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		u8 chan;
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index 4fecdf10aeb1..884e43e4cda4 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -56,7 +56,7 @@ struct tcs3414_data {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		u16 chans[4];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 };
 
diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 4186aac04902..2bd36a344ea5 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -67,7 +67,7 @@ struct tcs3472_data {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		u16 chans[4];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 };
 
-- 
2.47.1


