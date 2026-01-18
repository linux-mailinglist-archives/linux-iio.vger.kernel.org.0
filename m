Return-Path: <linux-iio+bounces-27913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5507FD397A0
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 16:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B2B53021F9B
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51B62C0F8C;
	Sun, 18 Jan 2026 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+m9xQrp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65104339719
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768751105; cv=none; b=l8rqYWKq+cDQ/Ql/JaF0fAREKig8TgakjVUeDg0RpYkShRAFdP0L5VkezJVElpV29jqYoXh4JRNJjDYn7ogw96aO+TdG+LwFz3iW9YA/t5LfAn9S47LhXpzgGqNDUwluTa1/Yk6WbCo1fwy1pEj7AlcEsu9loiptImrJ6l7iXEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768751105; c=relaxed/simple;
	bh=BtNIOm3WFxuBN0I59Ylb15JT2dcPZJy+ODhgAT4Nc5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=meka0nADev1rpvLcgVp+MtIOMJXNQyr98obwflY3lOZWqfyQr37T2Xf5Cs7XWfJpIPZutM+YjJyulImQN7J/HTpEqOPAFjD/U13J2N4i8N8SLmoDpp3XZvgsR2UGskcyt5SZQk/X2QR+kZ110efgS/+d0dGH+bqCby8PqfQJ/tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+m9xQrp; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5eea2b345fbso1113620137.2
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 07:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768751096; x=1769355896; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ml0Pxh1qVbQteTW8hQLYuo6bKN3PZO7AtXRgiPy9iHM=;
        b=C+m9xQrpiMphSENRXz8B9ivFS/QWpj+7XOa1X2QDYjFN7h20DxJtwTs+V5IyiQSrU/
         cUOkYVg3X/+V5t7PSruGU47aapIZPfuBjfvRVXkN7JT6RkxiNB+OaErF3jmOau94tpP1
         UQzqrm5XBvCqWQZrcPowWlyhxulOtdZKGMe8uQ5hzOndcjV1NNJVraPSDm35ud3XIuS5
         DrezawrlarMAkbvmbjY46OAGErEzsxvrdVxDAFKnqm2r7wuDuuDdDIg8dpRapLJstRul
         gq76Jk7Sh8JDvj+KgIWitOByafBP8L6T+872MX3+IcZRSS5KTsGc0moWjP5Ha75lZgJl
         7H9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768751096; x=1769355896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ml0Pxh1qVbQteTW8hQLYuo6bKN3PZO7AtXRgiPy9iHM=;
        b=orU4Ns90yI37k+Rv1T1khu+SPr0x+KYGo734knycBSOUrfgPJofwBUQhKut/YfJxng
         a2hk3pEZ9GUrxLUCuVWe7ZRygmf2CDHdePqDYS6dyGgsH/7VyhTlKxnSZtdc09VnepFh
         mJmZj8Szg4fnzYEwC1lNWf32qKlKSzVR/GU9tAB2GKWcrMnsT7c1k+lCUnOhAm+2jrAE
         E0C2Ca2qUB5Mkq7NAypOfQ8UwnceV7Ob/1zVxqfaMWHnTmXCCEP76VXYhm9Bgtepz3tZ
         vpopavvuy6aQTKa4L/N4M0+XXyEYENThUpX9b1gKT1L0VsoKrxjjcN1BXuJIJKpsGRnA
         sINg==
X-Forwarded-Encrypted: i=1; AJvYcCWbDMA7e7207tGAUHUYLAmFMjus1BONLASacjl2sqhLNIGwjDc7CwGZQEekJbozGHfxExs56lvKXgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE+BcXcmIvQUHBmoUMZqrbycKQSIqJnD8l81RPV2pj72NyC1Vz
	qxoFIQwKrm3K9o74L4jWvXZ50PXMoOUtZvClll7lODKACfCp+MpwC+Uc
X-Gm-Gg: AY/fxX4GatggdL1Fi5fLdKqlovG9JGCjGaskOauCmpafIxD9QpL6ke3tTPVG4vrk+lj
	giaQbYTOjrWDrRY41Ob/gdRNOeCgiZKy6LxXxhBwPY3QvJfmoASrYqVWMMSMotdj/UAbFf8dXgr
	FrP6rSTBf0THq0/Zef0ftyFC9zAWBGS9zLETJeXai4ipWhGWCVGm0oDj7a0J4qBLdlj5OupvGj0
	UZwQnCiDe5vnqoTobfcTJF2eFK43aQG6o+S1rKQrtOPSNYpM4tNM6VQpbZeim+RuFbubhBUlFYR
	MjU3hWRWNTGRkO/Dyn/Go9Wkz/AVADvAeNckYB2cBCn15KAqsM/rZlooby+7y/zWtNrZduM+mlY
	gLUltIBZZubl/CEBmCxnOlw3bT+4p52F/6H1OqiDlNlVQ8hBhJ/HumOXvPbGSHMzRC72+0jynGW
	7YYvhrY3mUUv5D
X-Received: by 2002:a05:6102:cc6:b0:5db:20ea:2329 with SMTP id ada2fe7eead31-5f1a55a32demr2588543137.35.1768751096351;
        Sun, 18 Jan 2026 07:44:56 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6d3ca2esm2832731137.10.2026.01.18.07.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 07:44:56 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 18 Jan 2026 10:44:29 -0500
Subject: [PATCH v4 2/7] iio: core: Refactor iio_device_claim_direct()
 implementation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260118-lock-impr-v4-2-6c8d0aee8ed2@gmail.com>
References: <20260118-lock-impr-v4-0-6c8d0aee8ed2@gmail.com>
In-Reply-To: <20260118-lock-impr-v4-0-6c8d0aee8ed2@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4534; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=BtNIOm3WFxuBN0I59Ylb15JT2dcPZJy+ODhgAT4Nc5Q=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJk5/z+wxcZe++GxJsk/YC7XGpWXe/l+8zZ+cni59h2ru
 cn1xMa/HaUsDGJcDLJiiiztCYu+PYrKe+t3IPQ+zBxWJpAhDFycAjCRmE2MDKfmP7TTmsjW0fV8
 R6zIjPcvp3xqLEyqEp6TzXadVUiJsZLhn+ZPKzel0o8i9Ztd1JdkLHWIk2hWqrXgU3izrkA+VOU
 pJwA=
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
index 9693a6bb3917..83078285cd97 100644
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
index aecda887d833..f6d494065efe 100644
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
+ * iio_device_claim_direct - Keep device in direct mode
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
+ * iio_device_release_direct - Releases claim on direct mode
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


