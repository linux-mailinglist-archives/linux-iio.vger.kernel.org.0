Return-Path: <linux-iio+bounces-28029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DBED3BF13
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 07:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAE1C4F127D
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 06:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5607374180;
	Tue, 20 Jan 2026 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsZOHxUh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A543374177
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890078; cv=none; b=AsByjVoNDqQSc6wwMcnru9yn3+IEuf4Y//SH+LlbqUBUOcPZVTxqMbiVcT4Hk0YNJU7FZAhMUdOq8RnpsuCkvzvKkbmxVcrzcyox5bsLBSR5twGcEX1uyAmP6m7Z3lWtLHvGMp+w/DGoKQnbQBNmGRZKBWi6RlIOrtZV+d5x83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890078; c=relaxed/simple;
	bh=vf6b08yM9ZBa2hmugn0zaME77U5lLecJX0FGGC0bIPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RuK+JLRUwUEeEsWukv/Rj9xJ4RSQzRFnSEIENSmGivOtJXd/fcZ0564uvzokIcVoLwXKN+QZf1cMq1njK+RXBK3ZO5IT34p8kzewtK0RYiwgz3nx1FO8HP//sUK4FYhYbwJ1+yqqS7yNX2lm3d/JsnNRuYjLJcZpxhVvjidFuMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsZOHxUh; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5eea6f90d7fso3533429137.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 22:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890075; x=1769494875; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKZCOUdlyM96S2jf/HyAYyFcxZYAitp5mesgIJsfK4E=;
        b=WsZOHxUhnXFH2GwCloPOTOSdNG2QYdQB7NzZOt5fJpnvA3Jy4BmYcPIm5nhCzdqUPx
         sfmD6LZitwZccev2CJZEKtxee+MJLiD6CxPXoBuosl3dsiozzpI2z7JKxunMETxoJN4V
         yQsHPs5LmiUlZRP1pHlSjpyh6YZvtb8Gq7BluhSqknA7Xgq9mVjLQVQEsZWMmOW+9SbD
         r+nP/+aVBLO3yicSmG2I4btYEVQyh1QYvNMU4gFgOsL7TSXYurzpFTFntGtqTKVG9ixn
         rXVMr4h6MxalFzKy3mScxSHJ/e1R72PQhGZJuZ6F8a7XjpC944dxAsx5DalmD1p/QAPK
         lJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890075; x=1769494875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UKZCOUdlyM96S2jf/HyAYyFcxZYAitp5mesgIJsfK4E=;
        b=UORweXiDLjyfd4TaI/OumStJxdLO46kXl1PSVYQG1SqRalPOGHozexKkK8jif0sEPG
         o9o8xVL5+kjVbTHXevBmjY54h4HwiukQrJCcSpUi2SZrSKzuEyfwaFtVPM2HXGU1Jsnc
         CAq4neFtBiMTjBIT4E49BnRBtItOk0niJtWGgm9VtFDrgX0ZqhzcxFxW9++B/BCAFH18
         LrjZh8SQKVY+eoo5kDMS7DjxHaBHIbLoGzHIrZkwJR2faAKW2YcSOgonH7p7Iw4ROHrJ
         fxiUsk6kJ3cXf0fYmQdehoBtQ/k29Cl5pv1ogSq9G27aQKw9/5YsOhmJKhnPB1hu/9kA
         Uq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5wFndxlajdRAEN04kIjo1xCcZ0nevmJOdwG2hkzNBwfONmkL6v7aFloMdPLlugHkfztvbv94bkQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDlott1jt1QVwYN9KRk/Wnz//uxoOvWkx3wT6xcxkmZCjA2eOt
	/CU0Rn/Rk4lyteWqnedtvVC8Db6N5ppaLQDhQ0uE6JOpw2spiVfjhJnD
X-Gm-Gg: AZuq6aJ5Fy5V7Dgz289XcKxDmJ6WVdn17kHwLpFClq8h8Wb1k6BYBcEVmDPlyCtwr/J
	iL3vG9XvCPR9xQTLtW5fW26+wru/cTtb2pvKb5gGSUBXeO9sbKwll4Md2pVveZoaiPj+HoL+YdW
	4kPB2sZloujZwQ73UwaGi1TG4oG6WQFtpiSBKusULtnX4WFK5WU8L8q9r+nhSB4AqibcaHcugjB
	KWEH8OUiQnZNJat/QpoOE8Gq1jcZXHX0N1sloWdBajanKzLf3N+m+WV9x27wGbPcmvsIVtP3RwO
	uwU/b+iVzlXiBDf/cN/OMUIE9hGC9nUaRaT56gP4t0luMf7SUxZRZ8ujwET5BquhM/CWxwM1LsT
	ca3X5iu/Zaja/lry6la5VyAIFkGcTwZxIVDwOtb7/q+frIpvrWJT9RQhmGlbwKWiwIOsFeom2Oa
	PR5ZHpKUNc+Sd4
X-Received: by 2002:a05:6102:d8a:b0:5ef:a67d:e957 with SMTP id ada2fe7eead31-5f1a53b38c0mr4505673137.17.1768890075189;
        Mon, 19 Jan 2026 22:21:15 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6900c1esm4057944137.3.2026.01.19.22.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:21:14 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 20 Jan 2026 01:20:42 -0500
Subject: [PATCH v5 2/7] iio: core: Refactor iio_device_claim_direct()
 implementation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260120-lock-impr-v5-2-d4d22347041f@gmail.com>
References: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
In-Reply-To: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4538; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=vf6b08yM9ZBa2hmugn0zaME77U5lLecJX0FGGC0bIPo=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJn5cpf5LG6/EohJOP3nqa3Td73uF36+G0KMD15gvxJ8+
 csh01lbO0pZGMS4GGTFFFnaExZ9exSV99bvQOh9mDmsTCBDGLg4BWAi91MYGe5Onsm47XqjXF9l
 xaefDEfazxfP+84wKevVtQmG/Ptq3kxj+MM5y0bhrKqgoPmVx/JSklkXvVvOczI0r3o+ce7yRwE
 /WBkB
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

In order to eventually unify the locking API, implement
iio_device_claim_direct() fully inline, with the use of
__iio_dev_mode_lock(), which takes care of sparse annotations.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/industrialio-core.c | 44 -----------------------------------------
 include/linux/iio/iio.h         | 40 ++++++++++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 56 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index db803267df6e..0f8e3aa98b72 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2201,50 +2201,6 @@ void __iio_dev_mode_unlock(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(__iio_dev_mode_unlock);
 
-/**
- * __iio_device_claim_direct - Keep device in direct mode
- * @indio_dev:	the iio_dev associated with the device
- *
- * If the device is in direct mode it is guaranteed to stay
- * that way until __iio_device_release_direct() is called.
- *
- * Use with __iio_device_release_direct().
- *
- * Drivers should only call iio_device_claim_direct().
- *
- * Returns: true on success, false on failure.
- */
-bool __iio_device_claim_direct(struct iio_dev *indio_dev)
-{
-	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-
-	mutex_lock(&iio_dev_opaque->mlock);
-
-	if (iio_buffer_enabled(indio_dev)) {
-		mutex_unlock(&iio_dev_opaque->mlock);
-		return false;
-	}
-	return true;
-}
-EXPORT_SYMBOL_GPL(__iio_device_claim_direct);
-
-/**
- * __iio_device_release_direct - releases claim on direct mode
- * @indio_dev:	the iio_dev associated with the device
- *
- * Release the claim. Device is no longer guaranteed to stay
- * in direct mode.
- *
- * Drivers should only call iio_device_release_direct().
- *
- * Use with __iio_device_claim_direct()
- */
-void __iio_device_release_direct(struct iio_dev *indio_dev)
-{
-	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
-}
-EXPORT_SYMBOL_GPL(__iio_device_release_direct);
-
 /**
  * iio_device_claim_buffer_mode - Keep device in buffer mode
  * @indio_dev:	the iio_dev associated with the device
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index aecda887d833..e263ab5eeccf 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -664,31 +664,47 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
 
 void __iio_dev_mode_lock(struct iio_dev *indio_dev) __acquires(indio_dev);
 void __iio_dev_mode_unlock(struct iio_dev *indio_dev) __releases(indio_dev);
-bool __iio_device_claim_direct(struct iio_dev *indio_dev);
-void __iio_device_release_direct(struct iio_dev *indio_dev);
 
 /*
  * Helper functions that allow claim and release of direct mode
  * in a fashion that doesn't generate many false positives from sparse.
  * Note this must remain static inline in the header so that sparse
- * can see the __acquire() marking. Revisit when sparse supports
- * __cond_acquires()
+ * can see the __acquires() and __releases() annotations.
+ */
+
+/**
+ * iio_device_claim_direct() - Keep device in direct mode
+ * @indio_dev:	the iio_dev associated with the device
+ *
+ * If the device is in direct mode it is guaranteed to stay
+ * that way until iio_device_release_direct() is called.
+ *
+ * Use with iio_device_release_direct().
+ *
+ * Returns: true on success, false on failure.
  */
 static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
 {
-	if (!__iio_device_claim_direct(indio_dev))
-		return false;
+	__iio_dev_mode_lock(indio_dev);
 
-	__acquire(iio_dev);
+	if (iio_buffer_enabled(indio_dev)) {
+		__iio_dev_mode_unlock(indio_dev);
+		return false;
+	}
 
 	return true;
 }
 
-static inline void iio_device_release_direct(struct iio_dev *indio_dev)
-{
-	__iio_device_release_direct(indio_dev);
-	__release(indio_dev);
-}
+/**
+ * iio_device_release_direct() - Releases claim on direct mode
+ * @indio_dev:	the iio_dev associated with the device
+ *
+ * Release the claim. Device is no longer guaranteed to stay
+ * in direct mode.
+ *
+ * Use with iio_device_claim_direct().
+ */
+#define iio_device_release_direct(indio_dev) __iio_dev_mode_unlock(indio_dev)
 
 int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
 void iio_device_release_buffer_mode(struct iio_dev *indio_dev);

-- 
2.52.0


