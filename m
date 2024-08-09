Return-Path: <linux-iio+bounces-8343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB6B94CD25
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 11:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AB5281002
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 09:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF021917C2;
	Fri,  9 Aug 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozGCJuPF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED2518E77E
	for <linux-iio@vger.kernel.org>; Fri,  9 Aug 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195074; cv=none; b=fJyp5ByRfLT7VrcPfMm4Yvo7xJUVJvhoP4v7SN37QA9FStr9gae55mf4ChTYcN1NSu339NFkHAkPXeYDjDA5jdk55ogkGlPcLqPRFdaX4KbJOdfMiNK2zIyKOJsIqBZ47NhXQWX53yLmb2pW1TfxfoYUZWqrfeG57KzLOxj9K1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195074; c=relaxed/simple;
	bh=ywvSYruu5A8rEsAGlzTFsi9xFpwfkvf469P5az4k1yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RA590Cq6r28yuT0HFcK9QwN11YAImsPw7aB7ElE4xz/1qM1RxnsH09jBG6ZuV9qJo23oO5cAWlNwuMShzhOJlTN8AW+0MezFnpmxymP8KdMX8y3MErKeTVc/qLtHv+NSCq8worwBXe2u/KCySucckLRjO4VY1LKCZ7XtyB6tO6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozGCJuPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75284C4AF0E;
	Fri,  9 Aug 2024 09:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723195074;
	bh=ywvSYruu5A8rEsAGlzTFsi9xFpwfkvf469P5az4k1yw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ozGCJuPF9VTxbXnNN1k0muhO2FbBd15cyY+YqgAIEg2XSxOeYyEp1eryRfjeqkJAu
	 BUUeF4rJd9P7/xmnQqeo5Ihb60ydcSfdq0I6gNC+VB7K47ZbZxXlbYd4Nx6hThKWGD
	 qssxCcoJ+OeQKE9PJY1CTD4ZIkeHXTKCOTn4Re6JG06n4LNk+dgd9hLhTdYw9izbs5
	 TDLi39AwXvjkf2bDEhpCOg1RBIfdcfYX+m5DzJLTQyKKlnqXJk/1Z+T7sVriXirXXF
	 VALeRFZoOPNlEbjaO5Qlhi6K1LpgXws0YI4u+/ZRx2tXVLfnG+QoHUBTuvKpVlhBAz
	 wDJkdRG/Lhtag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BD8C531DB;
	Fri,  9 Aug 2024 09:17:54 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 09 Aug 2024 11:17:08 +0200
Subject: [PATCH 3/4] iio: imu: adis16400: drop ifdef around CONFIG_DEBUG_FS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-dev-adis-debugfs-improv-v1-3-d3adb6996518@analog.com>
References: <20240809-dev-adis-debugfs-improv-v1-0-d3adb6996518@analog.com>
In-Reply-To: <20240809-dev-adis-debugfs-improv-v1-0-d3adb6996518@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Dragos Bogdan <dragos.bogdan@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723195072; l=1916;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=6Q00KFDp8vSfMOy9SOdSB2hurveB/47INrxlbxbqT6k=;
 b=MOe2m3mRxxYVT4dKXrTL7w9TeT5oxgHTj8VgX43Gt9YlBbwhopa21a5uQF45NtrIp2p6KBmTo
 xIZDDiTEo38CYmW1+rCWg6QmF2GTb/WqFoYp+BfYarWftjWPX1Z5PdA
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

While at it make adis16400_debugfs_init() void as the return code is
ignored.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16400.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 0bfd6205f5f6..6484ab8aff55 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -202,8 +202,6 @@ enum {
 	ADIS16400_SCAN_TIMESTAMP,
 };
 
-#ifdef CONFIG_DEBUG_FS
-
 static ssize_t adis16400_show_serial_number(struct file *file,
 		char __user *userbuf, size_t count, loff_t *ppos)
 {
@@ -273,11 +271,14 @@ static int adis16400_show_flash_count(void *arg, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(adis16400_flash_count_fops,
 	adis16400_show_flash_count, NULL, "%lld\n");
 
-static int adis16400_debugfs_init(struct iio_dev *indio_dev)
+static void adis16400_debugfs_init(struct iio_dev *indio_dev)
 {
 	struct adis16400_state *st = iio_priv(indio_dev);
 	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
 
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return;
+
 	if (st->variant->flags & ADIS16400_HAS_SERIAL_NUMBER)
 		debugfs_create_file_unsafe("serial_number", 0400,
 				d, st, &adis16400_serial_number_fops);
@@ -286,19 +287,8 @@ static int adis16400_debugfs_init(struct iio_dev *indio_dev)
 				d, st, &adis16400_product_id_fops);
 	debugfs_create_file_unsafe("flash_count", 0400,
 			d, st, &adis16400_flash_count_fops);
-
-	return 0;
 }
 
-#else
-
-static int adis16400_debugfs_init(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-#endif
-
 enum adis16400_chip_variant {
 	ADIS16300,
 	ADIS16334,

-- 
2.45.2



