Return-Path: <linux-iio+bounces-2843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D246385C6D3
	for <lists+linux-iio@lfdr.de>; Tue, 20 Feb 2024 22:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 628B4B21966
	for <lists+linux-iio@lfdr.de>; Tue, 20 Feb 2024 21:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812B8151CFC;
	Tue, 20 Feb 2024 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="12Ihv95s"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39508151CDC;
	Tue, 20 Feb 2024 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463110; cv=none; b=JopU+tfKImP/umflW4kTbrV/ICdtpzXfoEwvEnqvQrHHSxxlIUpgA6LDpscn1NItsp/eePH+0Pl5KZlTypET2MFvDpEVITkvSemGWL4hmPham8nfjBRYljzBB2UZZFf5Vskg25gWMEtnDp+foL6yRJ7aZme1mZNddlhejJ36rfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463110; c=relaxed/simple;
	bh=WwaN0wuruvLTBbUzTx3YtyzxLT4fLkzCVR6KRXwVu5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLkXo7rvXInLjSSgr+HwKSBg5RJX0cMv7diUwKN3Uy88Xm72dlWu1EK6+fMag3VUJh1T4MbvQnYZCgOAvV4t/d4w8Y9GVJbgEEx+O3FrQH0Sqgh5MfJPU1nr40FJpp1CGwwFzqgLnDTIXW2CWJvmi4XO9WJByNGe4LC5sj3SfQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=12Ihv95s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC94C433F1;
	Tue, 20 Feb 2024 21:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708463110;
	bh=WwaN0wuruvLTBbUzTx3YtyzxLT4fLkzCVR6KRXwVu5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=12Ihv95sX0z7E1qYF/gqDqaRRxST4rY1d1ICAjNyRFe1fPB4frtZod3m+5tChCW7X
	 740UzrLuKGp7EefLH2AJpt3Zs1gnDro87w+Rt0k7xjxA5mIQRKek4pqPOHYQZU+mWh
	 IwQYsE1U1snq60JyT6Kp45zdx/pKJOQm2uxVp4eg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrea Merello <andrea.merello@iit.it>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 108/197] iio: imu: bno055: serdev requires REGMAP
Date: Tue, 20 Feb 2024 21:51:07 +0100
Message-ID: <20240220204844.313708902@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220204841.073267068@linuxfoundation.org>
References: <20240220204841.073267068@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

commit 35ec2d03b282a939949090bd8c39eb37a5856721 upstream.

There are a ton of build errors when REGMAP is not set, so select
REGMAP to fix all of them.

Examples (not all of them):

../drivers/iio/imu/bno055/bno055_ser_core.c:495:15: error: variable 'bno055_ser_regmap_bus' has initializer but incomplete type
  495 | static struct regmap_bus bno055_ser_regmap_bus = {
../drivers/iio/imu/bno055/bno055_ser_core.c:496:10: error: 'struct regmap_bus' has no member named 'write'
  496 |         .write = bno055_ser_write_reg,
../drivers/iio/imu/bno055/bno055_ser_core.c:497:10: error: 'struct regmap_bus' has no member named 'read'
  497 |         .read = bno055_ser_read_reg,
../drivers/iio/imu/bno055/bno055_ser_core.c: In function 'bno055_ser_probe':
../drivers/iio/imu/bno055/bno055_ser_core.c:532:18: error: implicit declaration of function 'devm_regmap_init'; did you mean 'vmem_map_init'? [-Werror=implicit-function-declaration]
  532 |         regmap = devm_regmap_init(&serdev->dev, &bno055_ser_regmap_bus,
../drivers/iio/imu/bno055/bno055_ser_core.c:532:16: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
  532 |         regmap = devm_regmap_init(&serdev->dev, &bno055_ser_regmap_bus,
../drivers/iio/imu/bno055/bno055_ser_core.c: At top level:
../drivers/iio/imu/bno055/bno055_ser_core.c:495:26: error: storage size of 'bno055_ser_regmap_bus' isn't known
  495 | static struct regmap_bus bno055_ser_regmap_bus = {

Fixes: 2eef5a9cc643 ("iio: imu: add BNO055 serdev driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrea Merello <andrea.merello@iit.it>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
Cc: <Stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240110185611.19723-1-rdunlap@infradead.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/imu/bno055/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
index 83e53acfbe88..c7f5866a177d 100644
--- a/drivers/iio/imu/bno055/Kconfig
+++ b/drivers/iio/imu/bno055/Kconfig
@@ -8,6 +8,7 @@ config BOSCH_BNO055
 config BOSCH_BNO055_SERIAL
 	tristate "Bosch BNO055 attached via UART"
 	depends on SERIAL_DEV_BUS
+	select REGMAP
 	select BOSCH_BNO055
 	help
 	  Enable this to support Bosch BNO055 IMUs attached via UART.
-- 
2.43.2




