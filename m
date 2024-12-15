Return-Path: <linux-iio+bounces-13503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E289F2497
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 16:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5444F1885E11
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 15:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A53E18CC13;
	Sun, 15 Dec 2024 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="EOTZ+d9Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB5A937;
	Sun, 15 Dec 2024 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734276101; cv=none; b=JcEPuyk+CXsd683ma3hgIkB5e+WK24D0YN4Mq4GcTqHiysGw1UjEd2RIbTQhd8kb2WXu9dL1b/0uV6EzMw5ZFyXZtQSTAhKdIYFd6CNAwJZwrzc3+KbjxSD6P4F3taET8Ei8v6n0k2PQ/v97KjBU+sJTvvrOZ4y9W4QTlaMaMMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734276101; c=relaxed/simple;
	bh=qShK9F1Wh2aE1QIaJsa9IAity+PaAJ8AZds5D1NyDoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LQy+TESvbFnxPoBovb6BMCTXfIBx0NtV9ZPuj9yZLrYLnWpzmrF4PDyzBuR64Lny9pbIMUNKSRE8suICZfKs46l8dtJ5Sfuk2oQjAPLCApK6UI5eLNpKQbESFSz4DUjIPTvW0YSe82j2rVZTCBjzwQmX6E9KzyCU7lNCNgPjulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=EOTZ+d9Y; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734276096;
	bh=qShK9F1Wh2aE1QIaJsa9IAity+PaAJ8AZds5D1NyDoc=;
	h=From:Date:Subject:To:Cc:From;
	b=EOTZ+d9Yvz2UmFcCdts0JPoiJ55mrXHCWdQ4Krk9FjyFzyxMr/obWe99jztSFpG8s
	 Z6cqsWF9yM7TW632jvN5mB2+YrBvFbrUEm398afzL1QkpAMTLeb/o0qD8K1lPQmohz
	 wlcv0xfUMtPwlgsJ9xXHc351lHjKsBsa55bPhYVo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 15 Dec 2024 16:21:24 +0100
Subject: [PATCH] iio: imu: bno055: constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-sysfs-const-bin_attr-iio-v1-1-a5801212482e@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAPPzXmcC/x3MPQqAMAxA4atIZgM2VQevIiL+pJqllaaIIt7d4
 vgN7z2gHIUVuuKByKeoBJ9hygKWffIbo6zZQBXVhkyDeqtTXILXhLP4cUopokjAtp25IbK2chZ
 yfkR2cv3rfnjfD6LTwAVqAAAA
X-Change-ID: 20241215-sysfs-const-bin_attr-iio-66be522330f3
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734276093; l=1771;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=qShK9F1Wh2aE1QIaJsa9IAity+PaAJ8AZds5D1NyDoc=;
 b=Ky+nDDZAGVjQVsBt0gACt1SRrVHpBdNMTKY7tyqtFt1ik1b36thq/d/LPHitMR/4VsRdbvkw1
 z5Q61/7Ced0Ca7x/XrcrJGrEkCsgDXx/Tn0CV4nIj0mYTIvSfKx4Zow
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/iio/imu/bno055/bno055.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 0728d38260a1c9dd218569ee870bd62c833e9906..59814de042c7d6d69547eb2adc9e1174a7e0c324 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -1193,7 +1193,7 @@ static ssize_t serialnumber_show(struct device *dev,
 }
 
 static ssize_t calibration_data_read(struct file *filp, struct kobject *kobj,
-				     struct bin_attribute *bin_attr, char *buf,
+				     const struct bin_attribute *bin_attr, char *buf,
 				     loff_t pos, size_t count)
 {
 	struct bno055_priv *priv = iio_priv(dev_to_iio_dev(kobj_to_dev(kobj)));
@@ -1348,16 +1348,16 @@ static struct attribute *bno055_attrs[] = {
 	NULL
 };
 
-static BIN_ATTR_RO(calibration_data, BNO055_CALDATA_LEN);
+static const BIN_ATTR_RO(calibration_data, BNO055_CALDATA_LEN);
 
-static struct bin_attribute *bno055_bin_attrs[] = {
+static const struct bin_attribute *const bno055_bin_attrs[] = {
 	&bin_attr_calibration_data,
 	NULL
 };
 
 static const struct attribute_group bno055_attrs_group = {
 	.attrs = bno055_attrs,
-	.bin_attrs = bno055_bin_attrs,
+	.bin_attrs_new = bno055_bin_attrs,
 };
 
 static const struct iio_info bno055_info = {

---
base-commit: 2d8308bf5b67dff50262d8a9260a50113b3628c6
change-id: 20241215-sysfs-const-bin_attr-iio-66be522330f3

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


