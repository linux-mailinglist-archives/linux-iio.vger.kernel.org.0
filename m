Return-Path: <linux-iio+bounces-27836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F815D24EC6
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 15:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E501303F36A
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105293A1E75;
	Thu, 15 Jan 2026 14:24:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4BD327C05;
	Thu, 15 Jan 2026 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487062; cv=none; b=O4OM5bQ5ZV4Xm3sOfTYpgchS7Z9un4z2Rcmu0BzEdRbaKUR+EtyUm3J1pmr1OWxf7iFx5hVL5Ac71FgL9kPlSmrOzeAY0OacpNq6Ij4ujQaDcQcjGlAMar1OnDlNSy/fAjhZ4dmV3j855YVwccUFXaAMGLx+9vOqRzw4fkqtjpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487062; c=relaxed/simple;
	bh=/L5OJ+o2n2S88EYBEj/FdhgABfG6TvZnLCTytKVWUD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N1KhWQersg8CqkLMcZMI0qnjPO6gCoPPtvVvWG58GyJnf+qb7LrVDVmQWpzjSeROx4hEh12F/mpGJe5991+L4+mFotnp+tDM4IPVcElW4Q9TRqog+HUA1ke7hchptg1ldZpNlbzQCs2ayUZvO0uki6/pHZ0wGF0cbW6sykhGVD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06683C116D0;
	Thu, 15 Jan 2026 14:24:20 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jianping Shen <Jianping.Shen@de.bosch.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v7] iio: imu: smi330: Convert to common field_{get,prep}() helpers
Date: Thu, 15 Jan 2026 15:24:16 +0100
Message-ID: <275b806d25a57cb538b3db2a7490e1570175f6a1.1768486991.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the driver-specific smi330_field_get() and smi330_field_prep()
macros, in favor of the globally available variants from
<linux/bitfield.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v7:
  - Update for the renamed smi330_field_{get,prep}() helpers,

v6:
  - No changes,

v5:
  - New.
---
 drivers/iio/imu/smi330/smi330_core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
index 7564f12543e0ca04..83e0dff5d973d046 100644
--- a/drivers/iio/imu/smi330/smi330_core.c
+++ b/drivers/iio/imu/smi330/smi330_core.c
@@ -67,10 +67,6 @@
 #define SMI330_CHIP_ID 0x42
 #define SMI330_SOFT_RESET_DELAY 2000
 
-/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
-#define smi330_field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#define smi330_field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
-
 #define SMI330_ACCEL_CHANNEL(_axis) {					\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
@@ -361,7 +357,7 @@ static int smi330_get_sensor_config(struct smi330_data *data,
 	if (ret)
 		return ret;
 
-	reg_val = smi330_field_get(attr->mask, reg_val);
+	reg_val = field_get(attr->mask, reg_val);
 
 	if (attr->type == IIO_VAL_INT) {
 		for (i = 0; i < attr->len; i++) {
@@ -410,7 +406,7 @@ static int smi330_set_sensor_config(struct smi330_data *data,
 	if (ret)
 		return ret;
 
-	reg_val = smi330_field_prep(attr->mask, reg_val);
+	reg_val = field_prep(attr->mask, reg_val);
 	ret = regmap_update_bits(data->regmap, reg, attr->mask, reg_val);
 	if (ret)
 		return ret;
-- 
2.43.0


