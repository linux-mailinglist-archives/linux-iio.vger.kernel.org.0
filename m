Return-Path: <linux-iio+bounces-28031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C52AD3BF16
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 07:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1ACA36378C
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 06:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E1536C5B8;
	Tue, 20 Jan 2026 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7Y3FEH2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE20437418D
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890083; cv=none; b=uv3vkbWsj/185cSJWXJb3d5olOdhQezw70ZAdgTtoxWYhpYSoQ5EDQhHrLkIe85kgbRzGpNwGfLhE7MQ2S6+tc16Q+qa/WfBhcUHKsu8RA02Y9X3Wzrms73vWUhCjG5nyYjOQykfcDKR6VbFA92NNbXe3FNdiO5DZFZmzqBxe9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890083; c=relaxed/simple;
	bh=gk4uEOkebbeY+cZwYTy+/3fKoRkuSLvWkzrfvmHqOLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a+7IRz9rQKy4e8B54bKtdla59x+aB0CwD6QjtBGZAaBiQvZpJQAlJCh6YR/w9jDnei6yH4Cx80XThSYMB1HN+XS915VAGIhvKt9ifr7UgsfcMaXsbbrgmkPgo9QcFb8ah9B9iGmRU72zf2jPMyJ6/7u5HePkcWaC5YBFH/cpQ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7Y3FEH2; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5eea2b345fbso1571270137.2
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 22:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890080; x=1769494880; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILl543DXo8pvw93JPMvlHELZN9bV6WaivIpMWAbJAoM=;
        b=D7Y3FEH2Oc7aXQcA+SAcaWUJs6lsWXG4IFcYPBrizcDTQKcUqu72Qp+tt7HRctOyux
         iHTy2h4dJFZXaXWGnQtR7SY8LXsd0qAwERiCCfoS5pXUHoo7SZVcXqCGdst1DbToZJNR
         dBPwdtY55nEP32L67UQAjg441RfNlxYKLoUF2csNlzDu0ILTyiMtnJTVe54q9lFqgx0p
         PEy4PI6aWe/PXOKYQrJt29yO/8s/ZjJ3yODNnEu1yrwN6qIzGYKI8cHrFraXdmjPDM4J
         GhmYx8EqKyt2sPFoEOdQKwO0Kcecdcr/AYMfCLjI6ILNtGA4pEUsmHId1rNxMCoGvktb
         Ek9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890080; x=1769494880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ILl543DXo8pvw93JPMvlHELZN9bV6WaivIpMWAbJAoM=;
        b=o1y0mqd+qOBj6OKtaNZIZHykm32h9FV8EexoNFpVRPAL7EbOLZnnzd9hmMEp7kAOfZ
         wUV07SeM1BbBXbyYFKMD4ikutwQ2a6OnN8U7TJFcLvlM/8ZWyADyTA5IzVse1mk/kwHK
         oGwl1nbq9SPxqZCrnNm3j2BkY9sCuVBnLu7koXIdSTQHlD2A8+lIQCTU/9OQY2nqbqAg
         LfTeWpNJhpoRqyMIpSv3Gm9+IOE5HX0rXWntxbmyASzndr9Vq1BlLLUzGBllJzaRyeXm
         6kVARm9sogPVBE+oRCRuaxZTmcZEkwYiYFUKCWj9atRWpOthupmxxDFCbnFo6c+mmNd+
         1XcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlAIJMyG3IZnq0kxOY05u4ccvCnrqDPCvq1qYybhGq1iTRwB6VsjcpXEvmx/apRd0G6co+P1Dm+ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBWzjmB2M2Y+tVtZkEESyo3Ixp/c8S66qCgzqg0lTI3+y/gzQB
	MTXR/YHOEK7OPTnoHcQg0ho85h1heSbFjLt2jHbpD70BIVZwuzfvU7Um
X-Gm-Gg: AZuq6aJQANHTZir1Fwumez0C48xmNAH06m5hu1B7Aj1mWfRdx31zs9PQFBz/+SozxCU
	bj6sxcwHsQo7omHfroCg9daMDXAe0eEHTyhoMAQSuaBl6G3enuiBL0dqYVRENrloat8ov9Uuxg0
	elU80DNrxhtp6gZ3VQmYAJYe7SG/7rK/HTokaloZSfmOkEKGUGZ+yz8zqVZZpwRlnTpeS8tJQrQ
	fHC9lKH6mUalhjeWuGzbX4ElSUxyPZv9+7U23Sfg204aFuDv3WgCGwHOlWT9lxOZUOy1biOrSOm
	Io2+go0MZAnUEH3k108e28abOr1goVkW3AW9fbxI6zhyyyNNzQ+c4+Mxoi5eWTtBq+HeC25YH7b
	jkwhX5jDWTwI9gS56x6SDvQ8UV4cq5q67NXW7TsAIUR3OXc+JfCE/cTthnM575y8c4lIfF66eaq
	CI5yXgklYXLyo4
X-Received: by 2002:a05:6102:c94:b0:5db:3cda:cc3b with SMTP id ada2fe7eead31-5f1a55a2fddmr4131087137.34.1768890079962;
        Mon, 19 Jan 2026 22:21:19 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6900c1esm4057944137.3.2026.01.19.22.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:21:19 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 20 Jan 2026 01:20:44 -0500
Subject: [PATCH v5 4/7] iio: core: Add cleanup.h support for
 iio_device_claim_*()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260120-lock-impr-v5-4-d4d22347041f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3613; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=gk4uEOkebbeY+cZwYTy+/3fKoRkuSLvWkzrfvmHqOLM=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJn5cpd9jkpauCy8c6Mr7FDbP7X+bXcND+wMvSkQ6RpVG
 ihSwDyvo5SFQYyLQVZMkaU9YdG3R1F5b/0OhN6HmcPKBDKEgYtTACZS8J7hn+oz17uT5/z/GWBk
 0ccgsO+oyKal69KrXsRZn+p/MMMsYikjw+8dyw7LRUv+mJujZuS5yCbm46LESNWlYXrNHxM21u1
 l4QcA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add guard classes for iio_device_claim_*() conditional locks. This will
aid drivers write safer and cleaner code when dealing with some common
patterns.

These classes are not meant to be used directly by drivers (hence the
__priv__ prefix). Instead, documented wrapper macros are provided to
enforce the use of ACQUIRE() or guard() semantics and avoid the
problematic scoped guard.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 include/linux/iio/iio.h | 65 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 36bd14e93a75..a9ecff191bd9 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -10,6 +10,7 @@
 #include <linux/align.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/cleanup.h>
 #include <linux/compiler_types.h>
 #include <linux/minmax.h>
 #include <linux/slab.h>
@@ -740,6 +741,70 @@ static inline bool iio_device_try_claim_buffer_mode(struct iio_dev *indio_dev)
  */
 #define iio_device_release_buffer_mode(indio_dev) __iio_dev_mode_unlock(indio_dev)
 
+/*
+ * These classes are not meant to be used directly by drivers (hence the
+ * __priv__ prefix). Instead, documented wrapper macros are provided below to
+ * enforce the use of ACQUIRE() or guard() semantics and avoid the problematic
+ * scoped guard variants.
+ */
+DEFINE_GUARD(__priv__iio_dev_mode_lock, struct iio_dev *,
+	     __iio_dev_mode_lock(_T), __iio_dev_mode_unlock(_T));
+DEFINE_GUARD_COND(__priv__iio_dev_mode_lock, _try_direct,
+		  iio_device_claim_direct(_T));
+
+/**
+ * IIO_DEV_ACQUIRE_DIRECT_MODE() - Tries to acquire the direct mode lock with
+ *				   automatic release
+ * @dev: IIO device instance
+ * @claim: Variable identifier to store acquire result
+ *
+ * Tries to acquire the direct mode lock with cleanup ACQUIRE() semantics and
+ * automatically releases it at the end of the scope. It most be always paired
+ * with IIO_DEV_ACQUIRE_ERR(), for example (notice the scope braces)::
+ *
+ *	switch() {
+ *	case IIO_CHAN_INFO_RAW: {
+ *		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+ *		if (IIO_DEV_ACQUIRE_FAILED(claim))
+ *			return -EBUSY;
+ *
+ *		...
+ *	}
+ *	case IIO_CHAN_INFO_SCALE:
+ *		...
+ *	...
+ *	}
+ *
+ * Context: Can sleep
+ */
+#define IIO_DEV_ACQUIRE_DIRECT_MODE(dev, claim) \
+	ACQUIRE(__priv__iio_dev_mode_lock_try_direct, claim)(dev)
+
+/**
+ * IIO_DEV_ACQUIRE_FAILED() - ACQUIRE_ERR() wrapper
+ * @claim: The claim variable passed to IIO_DEV_ACQUIRE_*_MODE()
+ *
+ * Return: true if failed to acquire the mode, otherwise false.
+ */
+#define IIO_DEV_ACQUIRE_FAILED(claim) \
+	ACQUIRE_ERR(__priv__iio_dev_mode_lock_try_direct, &(claim))
+
+/**
+ * IIO_DEV_GUARD_CURRENT_MODE() - Acquires the mode lock with automatic release
+ * @dev: IIO device instance
+ *
+ * Acquires the mode lock with cleanup guard() semantics. It is usually paired
+ * with iio_buffer_enabled().
+ *
+ * This should *not* be used to protect internal driver state and it's use in
+ * general is *strongly* discouraged. Use any of the IIO_DEV_ACQUIRE_*_MODE()
+ * variants.
+ *
+ * Context: Can sleep
+ */
+#define IIO_DEV_GUARD_CURRENT_MODE(dev) \
+	guard(__priv__iio_dev_mode_lock)(dev)
+
 extern const struct bus_type iio_bus_type;
 
 /**

-- 
2.52.0


