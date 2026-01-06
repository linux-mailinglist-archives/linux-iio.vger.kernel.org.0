Return-Path: <linux-iio+bounces-27495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB12CF7489
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 09:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4329E30F4D75
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 08:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C0B31AA96;
	Tue,  6 Jan 2026 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4kDfZYy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0376319608
	for <linux-iio@vger.kernel.org>; Tue,  6 Jan 2026 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767686840; cv=none; b=d3vhXqm0rJ1+SHpWJCUAT0m20r1nnFRpqkRVQIrqIA2b0lSauSqWC8kZVWSzZs6ZH8PECCjVoKRVVb0QiJ9xriwUhZ1Uz7lqwS7RIvW+pK5rraPU7kxjqXWyLIuSrR9LIx24vKNG7RkleSkw0+TKIKPAlv1VnrufT16mouizd2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767686840; c=relaxed/simple;
	bh=trpCuQxaVUO34hXycd5YZlSez0HGPWnWhu1Fv3Ai43w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kIHcOEtjqLBJFFW1BH87pFF6vxQRCmXTBAwiaS06bqCpUabddKeqaYim1bQs8yhmsZY2zx8z71J4Tw0WcPUKz6pKl0S9TrNnkd8AII+FoTeq4jwTG4jHwjBeCNOD6pgDP//xTWjn/lYZ+asADZm+HllUz1GbgutSK9BGrhQJ/Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4kDfZYy; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5599688d574so223962e0c.2
        for <linux-iio@vger.kernel.org>; Tue, 06 Jan 2026 00:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767686837; x=1768291637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0p+zjCRTkVwkR72MimreHnHFD6yBR7Iq/PnOEe7z0Ro=;
        b=Y4kDfZYyAiA51NfhMymyi1JoMqcqHh+dfis8UIl3WcTA1g8RKAKhHXyqQaXZFbzqsM
         4xbYnHKk8vnS3rHl0UstL7KbBrmNRVMO/VtmSdE+ePUhxETabmFuZCT17TxIqItZ70ux
         yC2OhDLQFlzPDSPNYre06S+0Y7jL65jR+LAcQhj4wZcAArQIkf3UJd1WURTdSQjKDS1c
         LOzkI6oGCCaU25bmn9JPTItwwQtXRn/HkqlMRcbiwFRxULILDsFhVvza6GXbeZN75J/4
         thQdcz+w4m9lNEAZBaSJclsuGm+87pYyfMs5lbQM9j6mRaVdpkXyjArhQl2x3klwBPva
         va0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767686837; x=1768291637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0p+zjCRTkVwkR72MimreHnHFD6yBR7Iq/PnOEe7z0Ro=;
        b=k6ztGr0dJWWyOmQ3DCc2NSKfUOuBsAcEJwBOT4FkZpQ66vtTMlAsWKlE3UbxGb8Ymm
         88sq1gHzT0la4HJ6OYAdxdcINtiJM/5p1Z56nypGik8t/4glfU2nhsD3n3ZhwGvQxmeu
         FRrwXSNtZYC4C8qQu1jhUPkYUCqb8oILe10DbiAt3B/vCLDQzL2jWK/QRmsV63evEuqH
         81WOjBKL19u77/EeSKkhl/IrpdW/48v4ymzHq0it7F8u9Ua487CFTHxmvEgOspWSdUmp
         Qj2T2ia1zwr+hlCZ07rRV2o/DFK1/IwRPxNDWkpzC7IdA5WPx6PY4cWcKiT0dJfOs78t
         4rVA==
X-Forwarded-Encrypted: i=1; AJvYcCWjFx3iJLH99edgcBxxATpWQQbwXdrNgmREvx/FLPtpgwRSvFB+SBVvsPAojB0yEKFsT2JRUp3+iJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8pSVee6G2gQB9n4OeYvyIUhC1Ab/OEq6hk7HJxlYYmCe4PPmf
	mXbS3895iHLzMxYgtOCSuAYMHgMezoV603oqHGxljuhUqSK6F64Wsl3j
X-Gm-Gg: AY/fxX6ccO7Oo7WgW3jHjKzMyQ9t4LDgtJ9xMWbMb5EB66cp8jFwBnT9gWyFexUDuwN
	VuzmZOVwXICPn/lBmdndyxeqoFtYRztfmgtoDVVMFQ+WUDKFEI8EbEtJugOSXM5TvfxmvUBib2T
	j3tF/DFI3d8e45d6UkJp0IrA94K3F12+cPY41aKhcGUNAL1wNML/3R+JIysldMBh0e0uxVG4/2g
	/pbJr5DF3+OCTOHBBuhmb2XuiA9RWKifMs3TAXLSg1pcoPiDbiSO8kCAufktZT+1vJyuQTD2iRB
	OmZOv9WT/0zyiLjXZzMf41jyLAqu8TE7+opVCos8HvuWJBDvwFJQP4Qcw1/0jqRZaOpft5R6pwv
	Ea3vzLfp2z5FaJ2gEx2cqNELqqITkk6Gi5BgPX5eghrB3+ttx2gRs4i5/R+hQyE/WhcUfh0qv18
	7sn+yZ17wY0JIeVMZ6SpCO90o=
X-Google-Smtp-Source: AGHT+IHTIrvzVwfKQKJfyQacMro9d9cPsBkUSewIK7U13n8RWIAnR8FsTjt0MIQppCsbymPLPJiYIA==
X-Received: by 2002:a05:6122:d82:b0:559:6e78:a43a with SMTP id 71dfb90a1353d-5633949058bmr606543e0c.9.1767686836506;
        Tue, 06 Jan 2026 00:07:16 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944124a3386sm457615241.11.2026.01.06.00.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 00:07:16 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 06 Jan 2026 03:06:58 -0500
Subject: [PATCH v3 3/7] iio: core: Match iio_device_claim_*() semantics and
 implementation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-lock-impr-v3-3-1db909b192c0@gmail.com>
References: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
In-Reply-To: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Gwendal Grignou <gwendal@chromium.org>, 
 Shrikant Raskar <raskar.shree97@gmail.com>, 
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7873; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=trpCuQxaVUO34hXycd5YZlSez0HGPWnWhu1Fv3Ai43w=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkxh1YVa9+N3X/lqc/P+1VnXb8ve/u3vDN5b+qNhVUpm
 2Itg4JedZSyMIhxMciKKbK0Jyz69igq763fgdD7MHNYmUCGMHBxCsBEjv9g+B+8pK6nOcE/K0e0
 etb9huCJi1yv3JA7Lva/TCmaozN4UgnDP4WjTHkXWI5elGCr/pxwed0ijwMHrqdPmrVD0nf+p0m
 h09kB
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Implement iio_device_claim_buffer_mode() fully inline with the use of
__iio_dev_mode_lock(), which takes care of sparse annotations.

To completely match iio_device_claim_direct() semantics, we need to
also change iio_device_claim_buffer_mode() return semantics to usual
true/false conditional lock semantics.

Additionally, to avoid silently breaking out-of-tree drivers, rename
iio_device_claim_buffer_mode() to iio_device_claim_try_buffer_mode().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ade9000.c                          |  2 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  5 +--
 drivers/iio/health/max30100.c                      |  8 +----
 drivers/iio/health/max30102.c                      |  2 +-
 drivers/iio/industrialio-core.c                    | 42 +---------------------
 drivers/iio/light/opt4060.c                        |  2 +-
 include/linux/iio/iio.h                            | 35 ++++++++++++++++--
 7 files changed, 39 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 2de8a718d62a..db085dc5e526 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -964,7 +964,7 @@ static irqreturn_t ade9000_dready_thread(int irq, void *data)
 	struct iio_dev *indio_dev = data;
 
 	/* Handle data ready interrupt from C4/EVENT/DREADY pin */
-	if (!iio_device_claim_buffer_mode(indio_dev)) {
+	if (iio_device_try_claim_buffer_mode(indio_dev)) {
 		ade9000_iio_push_buffer(indio_dev);
 		iio_device_release_buffer_mode(indio_dev);
 	}
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 9ac80e4b7d75..ef53066b1735 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -188,11 +188,8 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
 	/*
 	 * Ignore samples if the buffer is not set: it is needed if the ODR is
 	 * set but the buffer is not enabled yet.
-	 *
-	 * Note: iio_device_claim_buffer_mode() returns -EBUSY if the buffer
-	 * is not enabled.
 	 */
-	if (iio_device_claim_buffer_mode(indio_dev) < 0)
+	if (!iio_device_try_claim_buffer_mode(indio_dev))
 		return 0;
 
 	out = (s16 *)st->samples;
diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 3d441013893c..7dfdb5eb305e 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -417,13 +417,7 @@ static int max30100_read_raw(struct iio_dev *indio_dev,
 		 * Temperature reading can only be acquired while engine
 		 * is running
 		 */
-		if (iio_device_claim_buffer_mode(indio_dev)) {
-			/*
-			 * Replacing -EBUSY or other error code
-			 * returned by iio_device_claim_buffer_mode()
-			 * because user space may rely on the current
-			 * one.
-			 */
+		if (!iio_device_try_claim_buffer_mode(indio_dev)) {
 			ret = -EAGAIN;
 		} else {
 			ret = max30100_get_temp(data, val);
diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index a48c0881a4c7..6918fcb5de2b 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -476,7 +476,7 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
 		 * shutdown; leave shutdown briefly when buffer not running
 		 */
 any_mode_retry:
-		if (iio_device_claim_buffer_mode(indio_dev)) {
+		if (!iio_device_try_claim_buffer_mode(indio_dev)) {
 			/*
 			 * This one is a *bit* hacky. If we cannot claim buffer
 			 * mode, then try direct mode so that we make sure
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 550d100d9cfa..52a16ce87e02 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2183,7 +2183,7 @@ EXPORT_SYMBOL_GPL(__devm_iio_device_register);
  *
  * There are very few cases where a driver actually needs to lock the current
  * mode unconditionally. It's recommended to use iio_device_claim_direct() or
- * iio_device_claim_buffer_mode() pairs or related helpers instead.
+ * iio_device_try_claim_buffer_mode() pairs or related helpers instead.
  */
 void __iio_dev_mode_lock(struct iio_dev *indio_dev)
 {
@@ -2201,46 +2201,6 @@ void __iio_dev_mode_unlock(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(__iio_dev_mode_unlock);
 
-/**
- * iio_device_claim_buffer_mode - Keep device in buffer mode
- * @indio_dev:	the iio_dev associated with the device
- *
- * If the device is in buffer mode it is guaranteed to stay
- * that way until iio_device_release_buffer_mode() is called.
- *
- * Use with iio_device_release_buffer_mode().
- *
- * Returns: 0 on success, -EBUSY on failure.
- */
-int iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
-{
-	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-
-	mutex_lock(&iio_dev_opaque->mlock);
-
-	if (iio_buffer_enabled(indio_dev))
-		return 0;
-
-	mutex_unlock(&iio_dev_opaque->mlock);
-	return -EBUSY;
-}
-EXPORT_SYMBOL_GPL(iio_device_claim_buffer_mode);
-
-/**
- * iio_device_release_buffer_mode - releases claim on buffer mode
- * @indio_dev:	the iio_dev associated with the device
- *
- * Release the claim. Device is no longer guaranteed to stay
- * in buffer mode.
- *
- * Use with iio_device_claim_buffer_mode().
- */
-void iio_device_release_buffer_mode(struct iio_dev *indio_dev)
-{
-	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
-}
-EXPORT_SYMBOL_GPL(iio_device_release_buffer_mode);
-
 /**
  * iio_device_get_current_mode() - helper function providing read-only access to
  *				   the opaque @currentmode variable
diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index 981c704e7df5..8c4a1f562a83 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -304,7 +304,7 @@ static int opt4060_set_driver_state(struct iio_dev *indio_dev,
 	struct opt4060_chip *chip = iio_priv(indio_dev);
 	int ret = 0;
 any_mode_retry:
-	if (iio_device_claim_buffer_mode(indio_dev)) {
+	if (!iio_device_try_claim_buffer_mode(indio_dev)) {
 		/*
 		 * This one is a *bit* hacky. If we cannot claim buffer mode,
 		 * then try direct mode so that we make sure things cannot
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 3cf340208694..d8af0456f966 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -706,8 +706,39 @@ static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
  */
 #define iio_device_release_direct(indio_dev) __iio_dev_mode_unlock(indio_dev)
 
-int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
-void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
+/**
+ * iio_device_try_claim_buffer_mode - Keep device in buffer mode
+ * @indio_dev:	the iio_dev associated with the device
+ *
+ * If the device is in buffer mode it is guaranteed to stay
+ * that way until iio_device_release_buffer_mode() is called.
+ *
+ * Use with iio_device_release_buffer_mode().
+ *
+ * Returns: true on success, false on failure.
+ */
+static inline bool iio_device_try_claim_buffer_mode(struct iio_dev *indio_dev)
+{
+	__iio_dev_mode_lock(indio_dev);
+
+	if (!iio_buffer_enabled(indio_dev)) {
+		__iio_dev_mode_unlock(indio_dev);
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * iio_device_release_buffer_mode - releases claim on buffer mode
+ * @indio_dev:	the iio_dev associated with the device
+ *
+ * Release the claim. Device is no longer guaranteed to stay
+ * in buffer mode.
+ *
+ * Use with iio_device_try_claim_buffer_mode().
+ */
+#define iio_device_release_buffer_mode(indio_dev) __iio_dev_mode_unlock(indio_dev)
 
 extern const struct bus_type iio_bus_type;
 

-- 
2.52.0


