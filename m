Return-Path: <linux-iio+bounces-2734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA439859829
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9522D28167E
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D196EB6D;
	Sun, 18 Feb 2024 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNzSlVWR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E171E86B
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277285; cv=none; b=bRnxHsH5FxVZ3wjipbPu8X9e95W3nLBys1D1j3oiimWoVFGiX6xyntNMkBLUAqmUhZqdC5u9dcGh2gYXXl5YSOYTj1sqF8jhH+lmuHBnswbpFfdReszf4OPvho8cdKViRTet4cTb3exUjDtXd5ltw5K9Daecz3mVcfpmN2/fjSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277285; c=relaxed/simple;
	bh=QTbpVKmFLhiEslvymQ9zKVe0DLJQybzeT09yPDdwPBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukltTGNaYOlrWRUcBEmdcRIa8Wbb3x2G/RfcVoB7WMCE9srhFQwoPrALevKkqxKuAsmj0EdOtcBgaS6bwu+m4g2Pi2HxbnFlEndMS4sVLZhcRQpLjQoiw0bDnHeWLekKthytvhn9Skt6q4HIMv6CWOngvVuEwmzuK9zjppsFewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNzSlVWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0965EC43390;
	Sun, 18 Feb 2024 17:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277285;
	bh=QTbpVKmFLhiEslvymQ9zKVe0DLJQybzeT09yPDdwPBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNzSlVWRPe0CwPOP52Btu54tEtrn766HEtXX7tgk7Bt2EFMsVQLW7ORce+bdXEtHp
	 mkkpiKfxpNHy1Bh72oXgBiJZd7cvXhyeCwWYXZWlaO4NS087+6A3MA4QLrjiQQ9Uq7
	 KCL6894MMx40oTcaPHCgyDo96XBbCrUUDFyHb8V1Ar3eK7pBCLfUZ/Ftyf+LNjNg7h
	 ZAEqYRV5BeRw3VMdl4FN2/4GVBG2EZHunssezL3LVhBt373iET/t/TSW4Sl/IzgtTB
	 K/LJ1sS/l6t+1QlNpZFUqJpkwcEwFEaEs7CY6dykkx4zYAHSTXTm+M1jLoeZZ4eLuF
	 HernkD96b1ZzQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Sean Nyekjaer <sean@geanix.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 7/8] iio: accel: fxls8962af: Switch from of specific to fwnode based properties.
Date: Sun, 18 Feb 2024 17:27:30 +0000
Message-ID: <20240218172731.1023367-8-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218172731.1023367-1-jic23@kernel.org>
References: <20240218172731.1023367-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Only the irq was retrieved using an of specific accessor. Switch to the
fwnode equivalent and adjust headers. Also include missing mod_devicetable.h
and irq.h.

Cc: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/fxls8962af-core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index be8a15cb945f..4fbc01bda62e 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -15,9 +15,11 @@
 #include <linux/bits.h>
 #include <linux/bitfield.h>
 #include <linux/i2c.h>
+#include <linux/irq.h>
 #include <linux/module.h>
-#include <linux/of_irq.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
 
@@ -1062,12 +1064,12 @@ static void fxls8962af_pm_disable(void *dev_ptr)
 	fxls8962af_standby(iio_priv(indio_dev));
 }
 
-static void fxls8962af_get_irq(struct device_node *of_node,
+static void fxls8962af_get_irq(struct device *dev,
 			       enum fxls8962af_int_pin *pin)
 {
 	int irq;
 
-	irq = of_irq_get_byname(of_node, "INT2");
+	irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
 	if (irq > 0) {
 		*pin = FXLS8962AF_PIN_INT2;
 		return;
@@ -1086,7 +1088,7 @@ static int fxls8962af_irq_setup(struct iio_dev *indio_dev, int irq)
 	u8 int_pin_sel;
 	int ret;
 
-	fxls8962af_get_irq(dev->of_node, &int_pin);
+	fxls8962af_get_irq(dev, &int_pin);
 	switch (int_pin) {
 	case FXLS8962AF_PIN_INT1:
 		int_pin_sel = FXLS8962AF_INT_PIN_SEL_INT1;
-- 
2.43.2


