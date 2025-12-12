Return-Path: <linux-iio+bounces-27032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86353CB7B34
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 03:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08C4B300F9EB
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 02:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA63224B15;
	Fri, 12 Dec 2025 02:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NG0Kw3f8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570A226CF1
	for <linux-iio@vger.kernel.org>; Fri, 12 Dec 2025 02:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765507542; cv=none; b=H3oF4PnLnFum0Sq/5ZIpYWLoXPeLS3B9IUs5+g91eOxgQsf7ItBofF26GzxSV15yvaP6PvuIe9AI8c7ImDwWPxGVjqD0x+sRYIpWrc3QA8gRIw4xC2DLJMrV4k/d5ac6vhtALqFDI0Uh/LJQjvWbgtY6yfxKwEBp+TDEywSu8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765507542; c=relaxed/simple;
	bh=xuoFXNcX9352+zDpLuF2INoY/VIUhah2IZAk6lwdq+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f9HvcCEFLQxCq6cyptRMfIxsFEcaGYd5IcmcYDuQWXUERxcUVlpMYqcrjpMZMQ2dxFaqUrsA2d6gtu0zmemUpuyvJ2pvyVXvcDddb5oUTgu17IA6cD9kwX68KC2t8vf+BNi5GRQnxEj0KJFmoNzC+dFQYqhkgBHVXdbOuAc3a6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NG0Kw3f8; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-93f69720a7cso480488241.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Dec 2025 18:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765507539; x=1766112339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jQ9+TRZtERAxrcgbRGbta7XSR16A+/nWPnuc93YP1Y=;
        b=NG0Kw3f8RvaT4agKnNx7dAAEKfmtRlFqSDxg4bEk67QQPUQn8XTEXagufLBw6dxZpI
         HfZOxzqiCD3xkeTrAgw8QOrajhFyxN1bBQmxxsl+rlRm2HGdvnltqpF45/x6jDCZ1lwK
         yHoQ5EDSghtfHemM+0hWYZcATBvUY95QGunQqOjhXlPTaf4t7ImxYLzAtRLdVE5TsN3I
         srYvgjx32URvykRGeYdJNl2Q1rL0KZlnYesbEmA+o+r/YaxQXlCKbY0CUKiKbgWCn0+K
         jqA7Nndj4fUhCe55REObEgR9qIu+LBze/vq/vi8xklFOmPfjham159UdvWlCWheU1UTn
         j4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765507539; x=1766112339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9jQ9+TRZtERAxrcgbRGbta7XSR16A+/nWPnuc93YP1Y=;
        b=E9dMXzdVtBFBUKD/xyhKI1omd4MguKfBsYYR9SerHNgvt6pI4GaXJvKuUF9vjpi+Ev
         KYweIthXlqV5Pt9Hkeg22kKfqqinW5G/Odz0SehyrybWLh5mHtrz9r0uoMtbo34Zd8yh
         Jfrxu9ISmk1w59OindT+mhQNusHtpN9heW8agxhp1PFMTFN1Z69LdkEIHIGHbl7ziTd/
         ITVnU8/rTUzwcahX4AN6zW3cEVO14CpASQN5evyiiOYZjSzKc9SGKIfpibrNjFfx6vbQ
         VkJfJiwSOUjz7b5Cza4EfyMNcgFBVKpX0PiJvrcnCUYDhDQVPyK8kzRM57FYxQ3xhDyE
         CEZg==
X-Forwarded-Encrypted: i=1; AJvYcCVTmNJRJUjyjfhKByo3QjIhnSqVoY1kSqxgBS3TOpa52Ow3a7cyl9G0bEcoeKHVZSelwVn3vBz61ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVk0XigjGeZYYDwiP3z6eF4K1BmctFjdThFfeCfbEswMHIvf12
	PL8sWBsSDQN/xE8xh3ibxwjTeHs+dMIHqlQqxU3nloVBwRCqIgc9vfhF
X-Gm-Gg: AY/fxX7yQDzcGgzngdlrCOLm1szXwxEl+zJayvpvxH8qLLfTaV/xh2iCK69Ars5GHMV
	8IfUp4qzHNTVYmGTnSfj/NWZ9GUeTMxyBO2QmtSchQ5GdlVMkhzD61U4CIToxy5piYgCBR86IhX
	I+dls7TgC1KBPSOM3W1cuDv5uKpx1VCjhRej4/xXt3D6bL74hbYiIpX9VI7JZRmqg74LDZNOEXG
	fKgYkqhJz8SuH/GDONWPXmI8aGBBcL166qAAeXpw5IpUjWbCk4tsSxQfkff7BlwF656yUKxEBAq
	G7opC5oUKM+E0mqKIL1A1Eh+I70oUYSHuyaSyjqg5BXc81tYMy33fKMdlEZ6mvxORO4AutXrlFr
	qmGVrbobVQ8L/GDqSQJeBSyDgfs3QrlMT2U4PGI2FbRnVQDkEouW2iOq2THG7vct1eNqAJFyiOq
	esxdu+FFM1O/1w
X-Google-Smtp-Source: AGHT+IFvijIh/JBzdNfBl3mEo+Gb8lgHDN+9CYOvDdFsaG5gcfvOjev6Lzz7YJQv5lA1d4e2C4rvSw==
X-Received: by 2002:a05:6102:2c85:b0:5db:34b5:318c with SMTP id ada2fe7eead31-5e827868cf6mr130137137.45.1765507539396;
        Thu, 11 Dec 2025 18:45:39 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e7d0f25ce2sm1693762137.8.2025.12.11.18.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 18:45:39 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 11 Dec 2025 21:45:21 -0500
Subject: [PATCH v2 3/7] iio: core: Match iio_device_claim_*() semantics and
 implementation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-lock-impr-v2-3-6fb47bdaaf24@gmail.com>
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
In-Reply-To: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7102; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=xuoFXNcX9352+zDpLuF2INoY/VIUhah2IZAk6lwdq+8=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJnWjSdj9b+aVi+ynfyiyiVyOu+RQ6vCTFl6and0mmfeZ
 3p5MbSio5SFQYyLQVZMkaU9YdG3R1F5b/0OhN6HmcPKBDKEgYtTACbS3cbIsO1bfIo0m2TnifD4
 W4uPnZK9UfN/aU1ADHc6/2q3uQsnizMyXPFrcFabw7/ril7hLevZbowqn8+ynJSf3lxuPemBw35
 LVgA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Implement iio_device_claim_buffer_mode() fully inline with the use of
__iio_dev_mode_lock(), which takes care of sparse annotations.

To completely match iio_device_claim_direct() semantics, we need to
also change iio_device_claim_buffer_mode() return semantics to usual
true/false conditional lock semantics.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ade9000.c                          |  2 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  5 +--
 drivers/iio/health/max30100.c                      |  2 +-
 drivers/iio/health/max30102.c                      |  2 +-
 drivers/iio/industrialio-core.c                    | 40 ----------------------
 drivers/iio/light/opt4060.c                        |  2 +-
 include/linux/iio/iio.h                            | 38 ++++++++++++++++++--
 7 files changed, 41 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 2de8a718d62a..b345c4d1ef24 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -964,7 +964,7 @@ static irqreturn_t ade9000_dready_thread(int irq, void *data)
 	struct iio_dev *indio_dev = data;
 
 	/* Handle data ready interrupt from C4/EVENT/DREADY pin */
-	if (!iio_device_claim_buffer_mode(indio_dev)) {
+	if (iio_device_claim_buffer_mode(indio_dev)) {
 		ade9000_iio_push_buffer(indio_dev);
 		iio_device_release_buffer_mode(indio_dev);
 	}
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 9ac80e4b7d75..8ed4b2e410c8 100644
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
+	if (!iio_device_claim_buffer_mode(indio_dev))
 		return 0;
 
 	out = (s16 *)st->samples;
diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 3d441013893c..3f3680c4b42f 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -417,7 +417,7 @@ static int max30100_read_raw(struct iio_dev *indio_dev,
 		 * Temperature reading can only be acquired while engine
 		 * is running
 		 */
-		if (iio_device_claim_buffer_mode(indio_dev)) {
+		if (!iio_device_claim_buffer_mode(indio_dev)) {
 			/*
 			 * Replacing -EBUSY or other error code
 			 * returned by iio_device_claim_buffer_mode()
diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index a48c0881a4c7..288c2f37a4a2 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -476,7 +476,7 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
 		 * shutdown; leave shutdown briefly when buffer not running
 		 */
 any_mode_retry:
-		if (iio_device_claim_buffer_mode(indio_dev)) {
+		if (!iio_device_claim_buffer_mode(indio_dev)) {
 			/*
 			 * This one is a *bit* hacky. If we cannot claim buffer
 			 * mode, then try direct mode so that we make sure
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index cffc6efb6617..46e336bff64c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
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
index 981c704e7df5..8cb3fa38077e 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -304,7 +304,7 @@ static int opt4060_set_driver_state(struct iio_dev *indio_dev,
 	struct opt4060_chip *chip = iio_priv(indio_dev);
 	int ret = 0;
 any_mode_retry:
-	if (iio_device_claim_buffer_mode(indio_dev)) {
+	if (!iio_device_claim_buffer_mode(indio_dev)) {
 		/*
 		 * This one is a *bit* hacky. If we cannot claim buffer mode,
 		 * then try direct mode so that we make sure things cannot
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 76398dbfa5ca..f8a7ef709210 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -702,8 +702,42 @@ static inline void iio_device_release_direct(struct iio_dev *indio_dev)
 	__iio_dev_mode_unlock(indio_dev);
 }
 
-int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
-void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
+/**
+ * iio_device_claim_buffer_mode - Keep device in buffer mode
+ * @indio_dev:	the iio_dev associated with the device
+ *
+ * If the device is in buffer mode it is guaranteed to stay
+ * that way until iio_device_release_buffer_mode() is called.
+ *
+ * Use with iio_device_release_buffer_mode().
+ *
+ * Returns: true on success, false on failure.
+ */
+static inline bool iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
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
+ * Use with iio_device_claim_buffer_mode().
+ */
+static inline void iio_device_release_buffer_mode(struct iio_dev *indio_dev)
+{
+	__iio_dev_mode_unlock(indio_dev);
+}
 
 extern const struct bus_type iio_bus_type;
 

-- 
2.52.0


