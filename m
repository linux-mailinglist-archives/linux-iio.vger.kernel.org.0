Return-Path: <linux-iio+bounces-2742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CE0859832
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2229F281339
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72E46EB7F;
	Sun, 18 Feb 2024 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imQLTuAq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A905D1E898
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277624; cv=none; b=JRkxB/R6BjrJMoeBkm3ixkXsEOeN4D0zOY47GO4ABlDb8J185A1dLH+xgQ3Labooe0Ae5Gbcfus2lPDDQOyxDbBONZPe3OQW/RmHkLm8KtBRnXV8sycNIkRlAC4Z5L1q7bqdrRMb1v4qIVMxIMaH+zUQ1RrI/hlnXYtXJBrE2XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277624; c=relaxed/simple;
	bh=DQGfkzVDShCIbJSnpPUPNQ0Hfaky+c6j90wy6nZJRxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmQA7QFDpNOmea6es3DI4ml0OB7EYfv5hBqW+IQY7l7nP5djD2xWVAyaoEpx8nxeQA0UIF2bdNtYN8efrEZPbVL8kk/wfTq1xKD1r7JyGwCjPC1Thbl8C7N4mRc7OD6t18JVejKrPxnM9DYlr2s9Or5WQyXfSvBuHCh4FqDUKhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imQLTuAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E582C433F1;
	Sun, 18 Feb 2024 17:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277624;
	bh=DQGfkzVDShCIbJSnpPUPNQ0Hfaky+c6j90wy6nZJRxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=imQLTuAq7Z+YCKiiW1Bow5I6CygdsDbqTYUdZdxYrbBsagPvNx+GSli84cL6vZ0XL
	 iRhl+spzDC+wUalMpa9Mt3pz632KY2EDXie7B8OEU39+S/cpTuJZnAYKjqk6CEgOk+
	 /ehXLQixN77mbSyleZeu9KMiVMM5pXw8ZcEGVlKVhGasuAbUX6cBLpjgANU6g3IIBj
	 2jZfPKGpzt6OsRpLJcTuhXCBG5pMyq1SJKK87wKvUJtWYk3V1wc+c9wEjPhUgN0Y1o
	 k1isanxle84DfeL6QMx0vTfimyPCto0QDOCTKstnGRnVi0GEghh0I6E8748VqgxMyS
	 a/6YV8VsUjLng==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6/8] iio: accel: bma180: Switch from linux/of.h to linux/mod_devicetable.h
Date: Sun, 18 Feb 2024 17:33:21 +0000
Message-ID: <20240218173323.1023703-7-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218173323.1023703-1-jic23@kernel.org>
References: <20240218173323.1023703-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The only of specific definition used is of_device_id table and that
is found in mod_devicetable.h not of.h

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/bma180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index ab4fccb24b6c..6581772cb0c4 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -13,10 +13,10 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-#include <linux/of.h>
 #include <linux/bitops.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
-- 
2.43.2


