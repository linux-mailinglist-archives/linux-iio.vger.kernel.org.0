Return-Path: <linux-iio+bounces-8344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2B494CD26
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 11:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4A71C20FA8
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 09:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC6618C93C;
	Fri,  9 Aug 2024 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKyFZhZx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C076F19148A
	for <linux-iio@vger.kernel.org>; Fri,  9 Aug 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195074; cv=none; b=Ahjsj/Novgx1oITCzvwcKK4Kc4t342XxmlTL1uYPw0QUCKGjKGn0XyWiri3PHZPZ2c1Sv1vlQnx1GzJ86cbPwgt+HRB8bBEUjHoSXS0ScOGE1JPSzV5LQaZRGc+TULKoatlad1jnWfFCpO/n0cx0YMXM+vc9SpWCo0aKv4RSo2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195074; c=relaxed/simple;
	bh=Mn7RjGGWuvjkQHt2ztipxFe9+BNo9MPHRP/CXFbiDRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lZ4jQjJfct91s028j066lj/pqi/OFfSJvOV6OFwe30oPeeCboYsvihSXjP0Ssabwc0FlJ5bef/ZA+YI3bqJmkqZAyUw7GePlW4WSK1W56dsht7A8nW2qyJV/aK0fWElGXtyEFDMOg1/mEgHOCgCezLmP54FsRTh4jXe1M8geqmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKyFZhZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 658CCC4AF0D;
	Fri,  9 Aug 2024 09:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723195074;
	bh=Mn7RjGGWuvjkQHt2ztipxFe9+BNo9MPHRP/CXFbiDRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LKyFZhZxuXxfPlPNbJBlSlcZoVgimkNaoiVfH34fXhyZMsHwTg5CcJQ5KXGXA1S6F
	 fAvbhlS3eaSO6iOSF4xfaju+kTwKV0ETvIJfgZ30aTtzfaEtvlCfkI79JmkQgqY9cD
	 xPvr8cggcX5fsw8yK1Q3m4GiBq/KrlhHQdCI+9PD0wIlJtXH++boTVe07I3YL8mBUx
	 GXw8xJzG8IhNOSq349/KdvKiH4GF4EMV+5xgjdWA7qI9UgUzujcU2nqXGK3YLuhCmU
	 Ynds82TBJB8n7oOoQjBdfXvYx1KXqBif4U8ZPK5C43HsX3qoDZMVGk98Rby66oJP+Z
	 YVrdj7dSt5k1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE09C52D7F;
	Fri,  9 Aug 2024 09:17:54 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 09 Aug 2024 11:17:06 +0200
Subject: [PATCH 1/4] iio: imu: adis16475: drop ifdef around CONFIG_DEBUG_FS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-dev-adis-debugfs-improv-v1-1-d3adb6996518@analog.com>
References: <20240809-dev-adis-debugfs-improv-v1-0-d3adb6996518@analog.com>
In-Reply-To: <20240809-dev-adis-debugfs-improv-v1-0-d3adb6996518@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Dragos Bogdan <dragos.bogdan@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723195072; l=1666;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=a5jhUJNFvPeDN03HbwrRCzHfwF3/Z8tIkW6EAXbSqz8=;
 b=Xf2EZl8ZhihDhXkPLoO9pg0SjU/BW6E5MMPYQqoMU4FMYH4udPeTVUwKPv49DtCjA7308aac2
 othDecAsrIqCBPPhcPVH9yEEjBUNfzM/9PyruT06sELDL1zpXwDzT0e
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use IS_ENABLED(CONFIG_DEBUG_FS) to return early in case debugfs is not
present. Since this is known at compile time, it allows the compiler to
drop any unused code. Therefore no need to wrap the code with #ifdef.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16475.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index c094ae4ffcb2..88efe728b61b 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -164,7 +164,6 @@ module_param(low_rate_allow, bool, 0444);
 MODULE_PARM_DESC(low_rate_allow,
 		 "Allow IMU rates below the minimum advisable when external clk is used in SCALED mode (default: N)");
 
-#ifdef CONFIG_DEBUG_FS
 static ssize_t adis16475_show_firmware_revision(struct file *file,
 						char __user *userbuf,
 						size_t count, loff_t *ppos)
@@ -279,6 +278,9 @@ static void adis16475_debugfs_init(struct iio_dev *indio_dev)
 	struct adis16475 *st = iio_priv(indio_dev);
 	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
 
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return;
+
 	debugfs_create_file_unsafe("serial_number", 0400,
 				   d, st, &adis16475_serial_number_fops);
 	debugfs_create_file_unsafe("product_id", 0400,
@@ -290,11 +292,6 @@ static void adis16475_debugfs_init(struct iio_dev *indio_dev)
 	debugfs_create_file("firmware_date", 0400, d,
 			    st, &adis16475_firmware_date_fops);
 }
-#else
-static void adis16475_debugfs_init(struct iio_dev *indio_dev)
-{
-}
-#endif
 
 static int adis16475_get_freq(struct adis16475 *st, u32 *freq)
 {

-- 
2.45.2



