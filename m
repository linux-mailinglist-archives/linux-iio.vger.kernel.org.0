Return-Path: <linux-iio+bounces-8345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0670094CD28
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 11:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD85E2811E2
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 09:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACCE1917D2;
	Fri,  9 Aug 2024 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4sZQ4pw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0724190667
	for <linux-iio@vger.kernel.org>; Fri,  9 Aug 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195074; cv=none; b=Q5aMwhZ342NxDNCNt3/CPsMyqtX+fw6AvoTBb2CLfFhdoYxShQeWQDkJWxxw7pVzGYiDciaDdKdnJBiTfLoijG5ofSBWElQoYZUojGDv75CHpsZxKaceGCpeH3JXjZmkdiqF+qOVjCTibjoTqkDo1EkPNJMfE3JweRc5qBOf8Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195074; c=relaxed/simple;
	bh=k9XeVU+Qz+5SqWg/rg+fJVsVyn38I2pXzjxtsY7aaBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNDYGtOp/EtshPypWYsQlhwJ6MKuB+GqyEBuHpoA1dOC23gj7aW/xFsUoZDAHjC9XE68cT01HRCI2mcVocCn/hByJo07nQbKMxGtQFoU4bpdZdfxNalAwKt1gXRj500Pt97xuKUG5OdqUKphXMyfxBWLxWNHdW8J9FoFQBgPjDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4sZQ4pw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A06CC4AF09;
	Fri,  9 Aug 2024 09:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723195074;
	bh=k9XeVU+Qz+5SqWg/rg+fJVsVyn38I2pXzjxtsY7aaBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=D4sZQ4pwnflYX4tzUGB5o9aEtdV3SnTJcsGNQpxCSAeD7FIKblRcZFHbW0RB9LxPZ
	 4lP2m26frpQwS8+LW8SKSa8OpjE/AEjHn1G0TO1k4UxFem5ldw5El+Gco3V2se4OgF
	 ANheDZLM2vWmNeAstVfM8Abohtae1daP0JQ0Ch69fIDjzzPwTy9Im7gD1DE4R8VOlT
	 gZjhfWeY09K6tbyxkNUc2bSmqUAl/rphtFe7ahi5mfuBUxIEmexNoUiAhRBiyYZ5tY
	 yyYuYsQem27JXL8NGWogH/f9wMjlF+do4QKOiyIQeI3G7qdeFXgvh0KfmeNuahA/jG
	 fVTIBOk/kv4Mg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A48FC3DA4A;
	Fri,  9 Aug 2024 09:17:54 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 09 Aug 2024 11:17:07 +0200
Subject: [PATCH 2/4] iio: imu: adis16480: drop ifdef around CONFIG_DEBUG_FS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-dev-adis-debugfs-improv-v1-2-d3adb6996518@analog.com>
References: <20240809-dev-adis-debugfs-improv-v1-0-d3adb6996518@analog.com>
In-Reply-To: <20240809-dev-adis-debugfs-improv-v1-0-d3adb6996518@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Dragos Bogdan <dragos.bogdan@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723195072; l=2149;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=INFkT1lRAs5IyvgBIQdTgiDQKkEI3o5fQR1S25bTHBw=;
 b=6828GMXZGnzXAeFZtJBinSMrhhGokbIYSPO3VCzNOvrTsjgZWX/o1N3YM4xhXNtryjdeBSeYM
 nN/j0EloDTlAy718KiYB4IyUjuC1t1SdXHE9AwMK7g6RxOEvZGIHVpV
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use IS_ENABLED(CONFIG_DEBUG_FS) to return in case debugfs is not present.
Since this is known at compile time, it allows the compiler to drop any
unused code. Therefore no need to wrap the code with #ifdef.

While at it make adis16480_debugfs_init() void as the return code is
ignored.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16480.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 4e31503d512e..294181f2fcb3 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -193,8 +193,6 @@ module_param(low_rate_allow, bool, 0444);
 MODULE_PARM_DESC(low_rate_allow,
 		 "Allow IMU rates below the minimum advisable when external clk is used in PPS mode (default: N)");
 
-#ifdef CONFIG_DEBUG_FS
-
 static ssize_t adis16480_show_firmware_revision(struct file *file,
 		char __user *userbuf, size_t count, loff_t *ppos)
 {
@@ -304,11 +302,14 @@ static int adis16480_show_flash_count(void *arg, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(adis16480_flash_count_fops,
 	adis16480_show_flash_count, NULL, "%lld\n");
 
-static int adis16480_debugfs_init(struct iio_dev *indio_dev)
+static void adis16480_debugfs_init(struct iio_dev *indio_dev)
 {
 	struct adis16480 *adis16480 = iio_priv(indio_dev);
 	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
 
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return;
+
 	debugfs_create_file_unsafe("firmware_revision", 0400,
 		d, adis16480, &adis16480_firmware_revision_fops);
 	debugfs_create_file_unsafe("firmware_date", 0400,
@@ -319,19 +320,8 @@ static int adis16480_debugfs_init(struct iio_dev *indio_dev)
 		d, adis16480, &adis16480_product_id_fops);
 	debugfs_create_file_unsafe("flash_count", 0400,
 		d, adis16480, &adis16480_flash_count_fops);
-
-	return 0;
 }
 
-#else
-
-static int adis16480_debugfs_init(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-#endif
-
 static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
 {
 	struct adis16480 *st = iio_priv(indio_dev);

-- 
2.45.2



