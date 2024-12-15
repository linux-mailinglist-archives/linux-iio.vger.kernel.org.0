Return-Path: <linux-iio+bounces-13514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB4D9F2551
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35CA5188544E
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B931B6CFF;
	Sun, 15 Dec 2024 18:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKc1jYvx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5BC13C8FF
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287395; cv=none; b=leV9lh0RgS+moqLzJg0RhgvMWaTOqfW+E8NwwHlv35nsoHo9fXbCCNwJ8AF4fH7C2NhXQxl49OxSlUGc9BZtpdkoFkAFpPRIoGE5tY3ZbGYsGGWbxwhyou4k7ebrcL9p2kEy+s37p6OES19TwLVBDu9HfqzQlbUZs7CmM820oMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287395; c=relaxed/simple;
	bh=OcKBTEchoSIypF3lOEOIgJC6VVJb2zQtWYnZriN2cGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAggphs6TNobl02S15twVoWGkHkxf4FGiDX063bF9AbZZtWCUBtKvc+Mues4Cyo3/q5t+3vobvNQPU2EtGXaJjgDiMnHAEfWb27tKk+9Q4S4jRbk6+ZvPlUCOetoGEl8TDTx+0AhX3tqRDOnhV8AseYYP92DafpzP9W7sp9CKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKc1jYvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E801CC4CECE;
	Sun, 15 Dec 2024 18:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287395;
	bh=OcKBTEchoSIypF3lOEOIgJC6VVJb2zQtWYnZriN2cGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKc1jYvxUJ/ZN+b0Oq0KUoCNdXjEFk0OqeFPXk1yuY+CJufkdDOnqi4CjDHHCwLms
	 vLB1NDB4Za2wwWYFm9YTlKWPZATjDRQrQ0kDrS52MOOvM5fDev/j+caNwJ1oZRcXaz
	 T9UcVR+O+W94R9QlVLnHoEknTkGHCSPAd3NUA9vOfwJjbV9lNJBff0UCJJMw26Nc25
	 f/GzZxWep9C8bo5ojqXpzTSM+mDJ1kE7H4eoXlzTLTpq9TfqjEbzQWqQCwBZ3hCGUJ
	 Wr9+0vJG9vCDuhb5NHw7OJCZmFI+P9+hRblVA6QS9rrxCsXZjoXqqtOnbCg7AB+Tco
	 WeCqwPV+4VFug==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 09/20] iio: imu: Use aligned_s64 instead of open coding alignment.
Date: Sun, 15 Dec 2024 18:29:00 +0000
Message-ID: <20241215182912.481706-10-jic23@kernel.org>
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
 drivers/iio/imu/bmi323/bmi323_core.c | 2 +-
 drivers/iio/imu/bno055/bno055.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index f7d7f4442e65..7f386c5e58b4 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -174,7 +174,7 @@ struct bmi323_data {
 	__le16 fifo_buff[BMI323_FIFO_FULL_IN_WORDS] __aligned(IIO_DMA_MINALIGN);
 	struct {
 		__le16 channels[BMI323_CHAN_MAX];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} buffer;
 	__le16 steps_count[BMI323_STEP_LEN];
 };
diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 0728d38260a1..f5c43666609d 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -207,7 +207,7 @@ struct bno055_priv {
 	bool sw_reset;
 	struct {
 		__le16 chans[BNO055_SCAN_CH_COUNT];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} buf;
 	struct dentry *debugfs;
 };
-- 
2.47.1


