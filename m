Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22524A728E
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 15:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344737AbiBBOCU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 09:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344483AbiBBOCT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2022 09:02:19 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C56DC061714
        for <linux-iio@vger.kernel.org>; Wed,  2 Feb 2022 06:02:18 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 24490200017;
        Wed,  2 Feb 2022 14:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643810537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MQJziaSz3ESkGbbljr98GLBOtxwo4x1WqWerH7zsyMI=;
        b=A5/bp4+IfxaYAMPfV06xKFyQmIlCOpMfgwRfvnNAhrfRH/SRpeRCz3tn0tLA02PRVCkgO4
        MVsCXnPvdoutp7YF7Tj/Pxk0YfFzE9ioTwTiFh0KFXxvy2pLtnbJZDILulcz8xcsjPFcWn
        poA+ynaYxGF+M8WqVdaZsHtWCp1F/Swo2XCY1d7CMvduzcPnsgJ+6HHBf2vOBz/mJJ1KRj
        bP13v9bo76rKTgMXj9rt+CZ29Xx3kbgsbUP223DVTJyty897jHjp3UFZBwE/LqB5/cs8D1
        7qiUBsSegessvVm1CZxNLQosBwx8VuP676CXmg4P5kfOGFfxozxNVhqNWA23YA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 08/12] iio: Un-inline iio_buffer_enabled()
Date:   Wed,  2 Feb 2022 15:02:04 +0100
Message-Id: <20220202140208.391394-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220202140208.391394-1-miquel.raynal@bootlin.com>
References: <20220202140208.391394-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As we are going to hide the currentmode inside the opaque structure,
this helper would soon need to call a non-inline function which would
simply drop the benefit of having the helper defined inline in a header.

One alternative is to move this helper in the core as there is no more
interest in defining it inline in a header. We will pay the minor cost
either way.

Let's do like the iio_device_id() helper which also refers to the opaque
structure and gets defined in the core.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/industrialio-core.c | 12 ++++++++++++
 include/linux/iio/iio.h         | 11 +----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 409c278a4c2c..64381d0a3d01 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -184,6 +184,18 @@ int iio_device_id(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(iio_device_id);
 
+/**
+ * iio_buffer_enabled() - helper function to test if the buffer is enabled
+ * @indio_dev:		IIO device structure for device
+ */
+bool iio_buffer_enabled(struct iio_dev *indio_dev)
+{
+	return indio_dev->currentmode
+		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
+		   INDIO_BUFFER_SOFTWARE);
+}
+EXPORT_SYMBOL_GPL(iio_buffer_enabled);
+
 /**
  * iio_sysfs_match_string_with_gaps - matches given string in an array with gaps
  * @array: array of strings
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index f191b80466cd..faabb852128a 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -550,6 +550,7 @@ struct iio_dev {
 };
 
 int iio_device_id(struct iio_dev *indio_dev);
+bool iio_buffer_enabled(struct iio_dev *indio_dev);
 
 const struct iio_chan_spec
 *iio_find_channel_from_si(struct iio_dev *indio_dev, int si);
@@ -679,16 +680,6 @@ struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv);
 __printf(2, 3)
 struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
 					   const char *fmt, ...);
-/**
- * iio_buffer_enabled() - helper function to test if the buffer is enabled
- * @indio_dev:		IIO device structure for device
- **/
-static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
-{
-	return indio_dev->currentmode
-		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
-		   INDIO_BUFFER_SOFTWARE);
-}
 
 /**
  * iio_get_debugfs_dentry() - helper function to get the debugfs_dentry
-- 
2.27.0

