Return-Path: <linux-iio+bounces-27912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5E9D3979B
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 16:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48B063009867
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24FB262FC0;
	Sun, 18 Jan 2026 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6/ZCnhL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DBF2101AE
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768751105; cv=none; b=dInv7jD07ICGR+GspapNF3E82Kkk1Nhwr5VQe9h8jUEVHus+Nl7nGUBAlDpNGbFbe43mErVe3X8+j5XMuYbx3Zcn2Vs024rBI9aoFHENhfFZ1v3zEVDt5kJ+/zrfG7PS3D3hktg2TZVEjxtyxvHyVFQZ/WHFQtGXB9klZI3ga6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768751105; c=relaxed/simple;
	bh=Bt3F/lHb6LI1N+BCX9VGngIeBqcSWQC3l35PbzVvVCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QxSfavi9r1gqwcLUQ8Aym4dzofN9oXqKrdLDOmTv6i61LhXBRpwknvhhO36cWZdbEp7L+g0AkiJ4a5rPDl1ZNItKRpyxIA2YXwMKA/tC/fDQiWlvBCRWCPd5tZi26juvOx6+wRHwBjpOtb6qibxOSEaIdxRF5EJitrY9iRVxwhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6/ZCnhL; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5eef115c7d8so1150586137.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 07:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768751101; x=1769355901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGdTfbPm6m/cN0XbYhh/ArH4Gt5W4bmHVBdR2RxVxHc=;
        b=g6/ZCnhL2VuK3YHY1zHho5axxQPApJjnUe+UGvYZ8313wbUsdBgaSviWW2y/taSmEc
         kfe5q3yMNrJGt8c+4Oj+7F3M6EwWc31jCB56jxT6kEg1wcuAwNPs8YYrIgVLuwGy7UfL
         vrIliTxYTP/bD6W1lLA8mWdB3QZsU7GFAm5PqmcZUL1Nt27Rozh23P1qC0u/Po6eH3N1
         VAu6AixxxUKkG2Fc+iN6DgZ7PWD3yuvfxj3Gq6ujbtdF1Gco5XFmvb1E56lApuq23fBX
         WbEk1enYlf30/fTo92rdmM+nCauvciY9yuO4C0vn5D/nkmIoaZBvBNLWbo7I9+YbJhou
         SXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768751101; x=1769355901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XGdTfbPm6m/cN0XbYhh/ArH4Gt5W4bmHVBdR2RxVxHc=;
        b=nwlXkbbao/Xo6eWbImGZKbbIwM2ZD26rc1hchwqwYbdOGrMRRzsDfaAJZqL7Mx4TPy
         FA/cuTmrBUe2hC/s19bjbM3fG1Hll49tjgvGEfB/ZjnfRL8E/IsrIkk/s1pX9F/4vEZi
         UhhKt80jBKr5f55J9TFiBPoUbDUJzmX4nGNQ/UuXOEFt4nTKfFnRT46GvLJMdDduZXA9
         BuIG3T6xq+fHcHgL//GxbcCFNc8CPwmDy/7d1z6ej6+gsZYF+gFSfgCrbkQEfqLirQan
         CczM2YyfGBl0ioq0kt+V8wjiE/03GXpxSMAJhAFBnStMx2Ot6a/KTpcAF/AZPXQ8VTtp
         xyzA==
X-Forwarded-Encrypted: i=1; AJvYcCVOja2G1ypEqyHlUDO/ywbR4RAmT0lIHlV1Ci+dIHsmkyeJwrJcvsXG68JXBUayAy8nQuOLFmIcBwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR7UEoa6yWutMdu5aQHSNDCcLBlvqaQJ6EPMMXzkAab7RgCo95
	r2rNRLuvgBC0rETeIZcNkG91oeIXiv/64vu0ytrR6KL9c2NQZqJnpFYO
X-Gm-Gg: AY/fxX7N9G0Rl9t+Z3z85xRocoNGyyoXIE/kPwiVSNX1+Lg0iKykCkDmOUCreVlXJ3M
	RkU6YkH6dRJ02Oe5bBfx7gEcZZMbM4QdOPfeNisneBt2hTv9XaVesY/SnckkXXTasH9Dsv03Gpq
	hbCGZdbA/qoyBWgF2odQUhZA2h4OKYsywRUR+U2J21GUWjgyS7kj14g5zZDPSMtsCqMF9M1vUCL
	ZtSwxPU3G63IjFEbYfSul3KGaEHCHME5/849H4cWfqU23/iYvQTahdpb9XcNl/eUpzf8QEQgMQG
	KVM9gHHDqH/mg7bvoyhR1cRRpkV5tk9lhbCEm71sxEnVS97iks524MgdQPYovixMwB2KK5K3J2v
	X5xKy3qWXVfqMHAb5LyFY4SNTA06S5Xq3WWQBdPtsKPGpuUOU/iWmFbmrRBdrWc26FP2bE/KUvx
	DmrXbWYysbR00I
X-Received: by 2002:a05:6102:dcc:b0:5db:f031:84c7 with SMTP id ada2fe7eead31-5f1a717ed4emr2752450137.30.1768751100866;
        Sun, 18 Jan 2026 07:45:00 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6d3ca2esm2832731137.10.2026.01.18.07.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 07:45:00 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 18 Jan 2026 10:44:31 -0500
Subject: [PATCH v4 4/7] iio: core: Add cleanup.h support for
 iio_device_claim_*()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260118-lock-impr-v4-4-6c8d0aee8ed2@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3563; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=Bt3F/lHb6LI1N+BCX9VGngIeBqcSWQC3l35PbzVvVCs=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJk5/z/eZhPNcLLkddP59UGR49r002tzUzdNjdqo2JfJW
 3O1JGlhRykLgxgXg6yYIkt7wqJvj6Ly3vodCL0PM4eVCWQIAxenAEzEtomR4cuUHvZdLO4rD//d
 OF+kpG/y8dPXpjw71f91z99lwi8/bVjKyDCfY9uReJ37ehPnBBxm7NIxvvZq4s0F+97uz85dN8l
 J9wkzAA==
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
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 include/linux/iio/iio.h | 65 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index fa671e120e95..4a0a77fcfa8d 100644
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
+ * IIO_DEV_ACQUIRE_DIRECT_MODE(dev, var) - Tries to acquire the direct mode
+ *					   lock with automatic release
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
+ * IIO_DEV_GUARD_CURRENT_MODE - Acquires the mode lock with automatic release
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


