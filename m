Return-Path: <linux-iio+bounces-27494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8131CF7492
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 09:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4172A314E080
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 08:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623DC3195EC;
	Tue,  6 Jan 2026 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBRC4IUU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7649B318138
	for <linux-iio@vger.kernel.org>; Tue,  6 Jan 2026 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767686837; cv=none; b=giZx+ZyuwA/kqLVxFTlqsn1vI9imRjvCp6Iuz8LmK0idfqYVUxH9xmIMGgex40Mlxrse509FakVKlPH5UqFHPXH119AcvZNiERbtCgNneV2mq0mJGkRY4wPe8YPMUP8YKTaWDPTtDFzuq91KeOEJRStKU596ADwnNhXRzw6QqFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767686837; c=relaxed/simple;
	bh=SDNvhXmYISbhRSNXw7cDf8FAaBgXfpTb+CF9dLnc7po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TwnNQ6yYWQyHeMB1VOc7RlBDkLU/0BvxKYspwnYymsDgVxi3v7ZBjoNPGfCklSteI1FI141R3h3Vjr0y38B+IibAu0m1mtctIAEDc6ffL+tY4ZqUSwAzv3vrtHQ564QiJolSLRbmwnY9VG36jMiy1B39ctuSJ4OzULvmaYogAJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBRC4IUU; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5dbd1421182so520884137.1
        for <linux-iio@vger.kernel.org>; Tue, 06 Jan 2026 00:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767686834; x=1768291634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWotJTEaFvNIekml25wC2h7Cy6W17ZOWtBn2DgmBWDc=;
        b=HBRC4IUUrrdDJht2b+PqFpoOs/BgMY/rkAXZp8PfxYRnG0Tv/C2ceAooh1G7Nb/01f
         lKnlehvXn+hp2Wk4TE7jzOo7ElEOWmPdIVs19p/j6PEU/2Z56wPBV2zloILZOEaPupIk
         hDRmYhbvE6Y/xGTMa14RBdOzLgDlW28GY4KRWXAb/MOGArxLTPJyjlitwDBQP8mpG/C2
         VJHSazBoPkqpLvZwPBAAze2FHMioV8ypUwiSskRAD+ckI5NxWQRO0LESlO5+8OyzRN9N
         ZBeePGuFp/MAHcfbZrhabelyE4CyZ5F0Pd1wpzMPxY7ps5NkwPKZBpdboLvhCaGP2Ujg
         Z5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767686834; x=1768291634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DWotJTEaFvNIekml25wC2h7Cy6W17ZOWtBn2DgmBWDc=;
        b=NI3jMWJa9EweAH2M2w5c4nIB2fBPWYTVoyLJPV2wXmG4GZobHWgK5U6NKnUrLm3cWv
         YrQjHiNh/ro2Yz6He7dhzbk0qlOXiCUoKLMyNmlXGxGSLw2U8XcwQZGLIG4SEFJo6qZV
         bh6otOztAM4W/zYa0gNt1Qhh3p+vdEH9DfxfYrSCA/nQGpqZhPvaEjvw8Al+jVM5EAhU
         sSMYEVTMwqHvSiMweqJqtUX73Uy8t1xQj7RKmix7wSnaca5myVpYDtvPU19u+FwWksbd
         nvK3WxAMGDLsbmeKWNsjTNxl/WqxP6sH49exF6QJAcEZVGKuh7VKPdy1XT2FuX2Z4O/F
         cdKg==
X-Forwarded-Encrypted: i=1; AJvYcCXdlgcpWXjFsjATWw5BYRHCQFnoTGb3yWpO3WhaA9aBsQQRV0QpncjXZjWZFglr5FCZalZCRqJaPZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqIDsl6+xMypvRP1fxwwVaWZcnvugl/UyZnuxYU+RQFJaOMsGZ
	uGJwMSCi63qKccGKkRrK0KdjGKEhM8pjTMvoyBYOwq0EnfNZPhaeT1SH
X-Gm-Gg: AY/fxX6/REyCabwQcI5zQmvbTDNm8HvHloRAlONSz2N9LUvZUwESnN5wOJUb9XoSFfd
	YNIg9OpVgVOkaGbCEmHWH89+RuqErZME8FsIU7/0FyVEl8+ck2+GhmdfveXSVRGuyTQ91MqDooR
	MvXIMJCoKliE858msEHMxUp4SaaldxT+6zp+8fKqz0E4NlWIVA+nfjKDd5N9f/p643fZ96C2Yv4
	+sAvVoIqwZ5WCZ51H3e95lTlEa8viaokIVOLVu8CGDM0VGqv/IIAdZmei5qTv9oT6xqqFCcDY8k
	QJDRCFqxY5z6xDXpvtsNoYGHGJnOCNtmuz56CjzUtBVM/aAeybWNy0/h7mNRFVseUyM2si+qbvw
	/ssqs7vXjSaOag76IVwW+Tu6+sYwLAfggpxV/yf21E33x1aUGpj/SmJxqYxeahzC4qJYCrqMxfW
	x6M1tUJOobKLin
X-Google-Smtp-Source: AGHT+IGdGpTqIyt6hEQbsRf4knYcrGeXLv4/KWJlDSNjEZ82/dMx8V7fOF7A+vNwmyfIMdeELVkxhg==
X-Received: by 2002:a05:6102:291e:b0:5db:e851:9395 with SMTP id ada2fe7eead31-5ec74324f6dmr661509137.7.1767686834136;
        Tue, 06 Jan 2026 00:07:14 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944124a3386sm457615241.11.2026.01.06.00.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 00:07:13 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 06 Jan 2026 03:06:57 -0500
Subject: [PATCH v3 2/7] iio: core: Refactor iio_device_claim_direct()
 implementation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-lock-impr-v3-2-1db909b192c0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4435; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=SDNvhXmYISbhRSNXw7cDf8FAaBgXfpTb+CF9dLnc7po=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkxh1btC1q6hjGk42Uke1pnXlPVg7KrLTkBMuk3Q7Ib2
 j+X5J3qKGVhEONikBVTZGlPWPTtUVTeW78Dofdh5rAygQxh4OIUgIlksTP8TzaYnGAXZF+be6jZ
 yFJsZl76M5nDz74/DuOy5ZuyuGp/OyPDmYz/MY8n3by1wvHTzz+SvEobm4ItvR9u3v3ZJGDHLf8
 PXAA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

In order to eventually unify the locking API, implement
iio_device_claim_direct() fully inline, with the use of
__iio_dev_mode_lock(), which takes care of sparse annotations.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/industrialio-core.c | 44 -----------------------------------------
 include/linux/iio/iio.h         | 40 ++++++++++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 56 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 34867a860a84..550d100d9cfa 100644
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
index aecda887d833..3cf340208694 100644
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
+ * can see the __acquires() and __releases() markings.
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


