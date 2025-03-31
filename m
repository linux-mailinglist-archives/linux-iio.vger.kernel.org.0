Return-Path: <linux-iio+bounces-17467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF70A765A2
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1ED33AA081
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF971E51F3;
	Mon, 31 Mar 2025 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu8OROTx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD8E13B59B
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423448; cv=none; b=BmJpnhgSUa5myQVBm4MqwIO4CNlo/g0UwtOXzvj/PM1+jMtpx3pkexfdHlqL5jS2n1QZWKkDr9fWe5/tQvgZsrTatvphHv6U3qaoyqtjZ4dSoK70LIrQH5k6Gtc5bM9cGDbccoahYG5FqKCxbePpGqWt77vdvysNPM3eoSkpOGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423448; c=relaxed/simple;
	bh=gyRG0WSpnGxX1JfNmcWVKw7XM9R86VTb7f+w/nMow0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u77Ts/0NIBqR2MoJ9YU0Vv/X597k+Z4NgvJ9JppwCGol6nghbQigBgQ8FAfqcDPUvQX/0CSl6D1xiaiitIWxHxXovGPC4xJ1oag3alCzsJCerb1YMBUHDkp5yxNcAvAPTfwNLBcnHHqAsnv2OHEo9nJZaaka0cv5ytv8aOO6Rxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu8OROTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69F2C4CEE3;
	Mon, 31 Mar 2025 12:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423447;
	bh=gyRG0WSpnGxX1JfNmcWVKw7XM9R86VTb7f+w/nMow0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lu8OROTxQAh45oFcKsuL5TlJ3+XeQMY8SWpD9e7QCH2hoOCcREpY3QhQhbcXIqnhq
	 jYn1fYwMk6cvJ/dvU97HgqTit37xof/iqxGYCL5SFGRB6J3tboCD4VGNIlIL2WlsA5
	 I1gBJAV0h0AnzaKw7p+xE97nXzB2z80+8b88Fp6me8stKz4uyEe8TOXvy897XT0Duj
	 KN9+4OqZZ+DU4xLPNY8tzUIsHBOeKL/aXlHt0bKhNeb1+pD2K/kFB+qdOa5iDDYhbn
	 LinJnQ29wNSS7Vwww8JaUlhH+AVWwfgdmkj0tZCYvCRosmSsmYAatnqVmu+KJN+0+Y
	 UPwzj1ur583HA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Roan van Dijk <roan@protonic.nl>,
	Jyoti Bhayana <jbhayana@google.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Shen Jianping <Jianping.Shen@de.bosch.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 37/37] iio: Adjust internals of handling of direct mode claiming to suit new API.
Date: Mon, 31 Mar 2025 13:13:17 +0100
Message-ID: <20250331121317.1694135-38-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331121317.1694135-1-jic23@kernel.org>
References: <20250331121317.1694135-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Now there are no remaining callers of iio_device_claim_direct_mode()
and iio_device_release_direct_mode() rename those functions to ensure
they are no used in new drivers. Also make them now return booleans
in line with the sparse friendly static inline wrappers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-core.c | 28 ++++++++++++++++------------
 include/linux/iio/iio.h         | 10 ++++------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index c9955a1c1090..c1921b55cfc5 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2157,17 +2157,19 @@ int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 EXPORT_SYMBOL_GPL(__devm_iio_device_register);
 
 /**
- * iio_device_claim_direct_mode - Keep device in direct mode
+ * __iio_device_claim_direct - Keep device in direct mode
  * @indio_dev:	the iio_dev associated with the device
  *
  * If the device is in direct mode it is guaranteed to stay
- * that way until iio_device_release_direct_mode() is called.
+ * that way until __iio_device_release_direct() is called.
  *
- * Use with iio_device_release_direct_mode()
+ * Use with __iio_device_release_direct().
  *
- * Returns: 0 on success, -EBUSY on failure.
+ * Drivers should only call iio_device_claim_direct()
+ *
+ * Returns: true on success, false on failure.
  */
-int iio_device_claim_direct_mode(struct iio_dev *indio_dev)
+bool __iio_device_claim_direct(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
@@ -2175,26 +2177,28 @@ int iio_device_claim_direct_mode(struct iio_dev *indio_dev)
 
 	if (iio_buffer_enabled(indio_dev)) {
 		mutex_unlock(&iio_dev_opaque->mlock);
-		return -EBUSY;
+		return false;
 	}
-	return 0;
+	return true;
 }
-EXPORT_SYMBOL_GPL(iio_device_claim_direct_mode);
+EXPORT_SYMBOL_GPL(__iio_device_claim_direct);
 
 /**
- * iio_device_release_direct_mode - releases claim on direct mode
+ * __iio_device_release_direct - releases claim on direct mode
  * @indio_dev:	the iio_dev associated with the device
  *
  * Release the claim. Device is no longer guaranteed to stay
  * in direct mode.
  *
- * Use with iio_device_claim_direct_mode()
+ * Drivers should only call iio_device_release_direct()
+ *
+ * Use with __iio_device_claim_direct()
  */
-void iio_device_release_direct_mode(struct iio_dev *indio_dev)
+void __iio_device_release_direct(struct iio_dev *indio_dev)
 {
 	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
 }
-EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
+EXPORT_SYMBOL_GPL(__iio_device_release_direct);
 
 /**
  * iio_device_claim_buffer_mode - Keep device in buffer mode
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 07a0e8132e88..638cf2420fbd 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -659,8 +659,8 @@ void iio_device_unregister(struct iio_dev *indio_dev);
 int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 			       struct module *this_mod);
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
-int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
-void iio_device_release_direct_mode(struct iio_dev *indio_dev);
+bool __iio_device_claim_direct(struct iio_dev *indio_dev);
+void __iio_device_release_direct(struct iio_dev *indio_dev);
 
 /*
  * Helper functions that allow claim and release of direct mode
@@ -671,9 +671,7 @@ void iio_device_release_direct_mode(struct iio_dev *indio_dev);
  */
 static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
 {
-	int ret = iio_device_claim_direct_mode(indio_dev);
-
-	if (ret)
+	if (!__iio_device_claim_direct(indio_dev))
 		return false;
 
 	__acquire(iio_dev);
@@ -683,7 +681,7 @@ static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
 
 static inline void iio_device_release_direct(struct iio_dev *indio_dev)
 {
-	iio_device_release_direct_mode(indio_dev);
+	__iio_device_release_direct(indio_dev);
 	__release(indio_dev);
 }
 
-- 
2.48.1


