Return-Path: <linux-iio+bounces-8346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF48494CD29
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 11:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D741C21267
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 09:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA801917DD;
	Fri,  9 Aug 2024 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY7HJeQJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27681917C8
	for <linux-iio@vger.kernel.org>; Fri,  9 Aug 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195075; cv=none; b=F5QLMEOB1FAiAt/8U/6tc5iAoFwJ77GjiIXs1sKPVHcflPKx+ZSk6EhARFFyh8uwjhZp7mxf46gjK6Ik3bStHGr1je+JSQWPzn/Ub3P8hy8XCQoUgAuwrzIYn7DhbMLOX99iezeRwLqpmMlZEHmlaLXF/LRzdMPrE3XGQlvaPDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195075; c=relaxed/simple;
	bh=O3PAu0KPnew2Lsasy7spSd9UaaYSvDcIXFjbnnwYTtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IbTwB0w90z4ekP1uBAmJ88gFL/zqLUSUQa9LcJtJvmya/wnNNdROC9I7X+Yq7ZOS0FULvHjhaMOvPPmwebGXG+mrY/Dq4yUD+D7p8aoTneHEG2P6NfqBCvkXM5gIP5VpVrubgDT+0iwtskfJd0ahy8UGYEqwc5VjnSPBscuR8tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY7HJeQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F6D0C4AF10;
	Fri,  9 Aug 2024 09:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723195074;
	bh=O3PAu0KPnew2Lsasy7spSd9UaaYSvDcIXFjbnnwYTtY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LY7HJeQJou/vkZ03InvMHQIAJDgDy//KYWFliDilaMCxPx4oDRr7URFKhF0gEarqk
	 +8c5NdYZzFMPJMDFObwbSZtB34v1L3EIJAI6oA+Q30ypuC7oeXWQTQGCVkUUKPJViM
	 Op2mLOJw0hpHQWkTP7G8yl3FeD72XCehjUKgsqPz2xYNTTn/f+0bERF9DyMoRidrbu
	 xIpIyfJ3Us+oaTOIf+rBsO25tJdNsWY7xRCUaFiqHPEUmKuo4ggb9y8fTjXUb6/jSG
	 w7QpVINJEEVipU66GOb4uMq1WCDZAe8Msp739R4GMyiVzkaQZ8+Bj0RJgRcLzh7C4b
	 xBYCY0EQygyWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73688C531DA;
	Fri,  9 Aug 2024 09:17:54 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 09 Aug 2024 11:17:09 +0200
Subject: [PATCH 4/4] iio: imu: adis16460: drop ifdef around CONFIG_DEBUG_FS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-dev-adis-debugfs-improv-v1-4-d3adb6996518@analog.com>
References: <20240809-dev-adis-debugfs-improv-v1-0-d3adb6996518@analog.com>
In-Reply-To: <20240809-dev-adis-debugfs-improv-v1-0-d3adb6996518@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Dragos Bogdan <dragos.bogdan@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723195072; l=1899;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=n1Jglfa5iy92BkrwrPeTAXoPaCMzOj6zVbu4oTIXimA=;
 b=YfrAyimaJSeHI23eRNfs1lZQ0nIiSOL9ap+I5hl9chdkqZ/VbhqCiSUyTIf/q+ZA1gNUvTKyK
 /NjwlK4wDF9DL3kuBfA3BzQrjMedsxEXNFhQXG0qzhn8CRRoP5ZMWLw
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

While at it make adis16460_debugfs_init() void as the return code is
ignored.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16460.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index 69facd72bd7d..eaa38dd6201f 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -69,8 +69,6 @@ struct adis16460 {
 	struct adis adis;
 };
 
-#ifdef CONFIG_DEBUG_FS
-
 static int adis16460_show_serial_number(void *arg, u64 *val)
 {
 	struct adis16460 *adis16460 = arg;
@@ -125,30 +123,22 @@ static int adis16460_show_flash_count(void *arg, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(adis16460_flash_count_fops,
 		adis16460_show_flash_count, NULL, "%lld\n");
 
-static int adis16460_debugfs_init(struct iio_dev *indio_dev)
+static void adis16460_debugfs_init(struct iio_dev *indio_dev)
 {
 	struct adis16460 *adis16460 = iio_priv(indio_dev);
 	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
 
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return;
+
 	debugfs_create_file_unsafe("serial_number", 0400,
 			d, adis16460, &adis16460_serial_number_fops);
 	debugfs_create_file_unsafe("product_id", 0400,
 			d, adis16460, &adis16460_product_id_fops);
 	debugfs_create_file_unsafe("flash_count", 0400,
 			d, adis16460, &adis16460_flash_count_fops);
-
-	return 0;
 }
 
-#else
-
-static int adis16460_debugfs_init(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-#endif
-
 static int adis16460_set_freq(struct iio_dev *indio_dev, int val, int val2)
 {
 	struct adis16460 *st = iio_priv(indio_dev);

-- 
2.45.2



