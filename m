Return-Path: <linux-iio+bounces-27496-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A90CF749E
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 09:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB6D331765D5
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 08:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FD631A7FB;
	Tue,  6 Jan 2026 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH4D2U6j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3034E31A7F9
	for <linux-iio@vger.kernel.org>; Tue,  6 Jan 2026 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767686841; cv=none; b=GhR1sdHPJrpg8DPmUxVMwZKXG/yi/F3pX+hpFMnhVwbdobJgqCFKQEH5o2vT7za0y7F8DAJFT04JLUZPkF0l8wqv4zzpBYHIS8QkusUClgTNb7w0JbiD48GLhDbf0KvYuIwKIQCnj6Q+0b9WXGyJmefzTEE9Vd2kZi9kDAM3ltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767686841; c=relaxed/simple;
	bh=Pzl04Z/f7G9BuXHblYf8c17cgor4qrSf/5Wv2Bzp4O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cl0BtoMB7Q0nva3ieuQWzQbMRUizeWhSakNVp1xa7hivLDnnzE/BYP6BFruSHhdBctxNjaQ6j1YRen7WviEhEgSRF5Ktn/N9TIefhwYk3Dld/WSaTDFGecAHwGyZcsHHPtI5GnprDTDXSd48HUorgVXf1D0gSJRizop3+Yxmr0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MH4D2U6j; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5e186858102so245326137.0
        for <linux-iio@vger.kernel.org>; Tue, 06 Jan 2026 00:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767686839; x=1768291639; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QROS04KwedxjJOENCLLDXjHHa0xV8qTJ7XV/vfD/RD4=;
        b=MH4D2U6jMGQiAHe2vszsXYT6BCWdgTcT90xuO/2NV12K/lFZYioNtqwuEXg/iZVuGh
         H/wNBHnMszxqX/NJOnczuWt9419N3fRuPIRqGjj836awdeXfVz3nBplCMo0YnKwejJZJ
         4EDacqQG4wgdwm9xhjC71YIapjvr5cchXCGn3Vf+p8XjcafBejX7hjvy3zQMR+4ZGlGQ
         RUe+zxY/pLRITYekweXPGnKc6C8GSv2NhvGKtx3MdZKx4SF03XFPrkOS+5yk0Xz7t7OO
         DGMF+Zq/NiL+mczVYPYiWrJkKMsgFD5lhyLg54jvbIgqtsc1ONxojufV0hVHFcsj9zaa
         Rp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767686839; x=1768291639;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QROS04KwedxjJOENCLLDXjHHa0xV8qTJ7XV/vfD/RD4=;
        b=rBAOAJSsbF1BRNRQaY6x339Kkj/uNkYslyZnq9a46UNK/NTXYR6ppi50KvgJqStjoK
         /OP3tkwam1Bt8yhRalsZoweAxEhiiOxrjBl2skziwSLFsGf7kz6CC1HOHBcH/TesKmAo
         5oXmXI8Wl6C6Qm/DS7i1FHhHmcFJ+X4nKy+u/jYxu/ThqpiC7oirBvXx9/hlRbEKsH1W
         AFx4akANpsPC4xnzV1saEZtSiLaMrYUKOSnzUF/oMZGb7LgTJK0BKPCyX3yuroQ2k86l
         +Nzo99puC5t1okNVrJzAkJUjmoqlWZgYeAGs7GEJgD4C3dv4ClNjaj62EZ5l+m1UfI4z
         eW6w==
X-Forwarded-Encrypted: i=1; AJvYcCWGXa6EzhKXLU3+2vpB7srIBC6qVdRjcLD4HVkltR7hBrfSJB4Wqkbbx9KhwkRWj6JQczR8MRbAvTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYyY1hY1Q88bm8nrzfflcHo1eaqbvTxyhTtmbylaf+R3DY0oXP
	qeBptzlKjsi1XH5F2i6uKvyEO4PEF9sQ+YaNyXaO6yA7Iktpev4VdFtY
X-Gm-Gg: AY/fxX4XaIYfDMTWOzL75U5IBWX88DceeXto8ZkOeeejJJfayo0qz39yuR8aP5cjoUU
	ucbh4ZvurLfBV1q46j6gPmL43qGzSm/3Q0TGovAtzzyy9w+0VHb9UZrjSypADm02hHCCW2wiIwt
	8VvEeTFKCRCfKiSXM7wLTznEgZctbNxtADWrGnOMkNNFQ6yG6DqqW8wDdB056VzLG6TvRrMV0SD
	4xtMPAt/dNUQQLAT0WgWe0YpW/BoW9u4K0K75kIf5SE8sxWGjNGX0qoLzch2Q87h5/rWrsPIVKd
	s57euznuTCZfSLow8O2iwvMPxWK/XoD64DRx4u1wxOK3TG0CQfH3XqFtFxRfDMwSFK/M9U1uU6+
	aMmYo/yVOVfRaIxy0pti9EExsgyd0bflBvLQQWJY8il6Y9N9Re1S11H+jc3xLCgmYMRpQ0PapJR
	KeoGRtRPbYnvE7YSJjPj1dOgI=
X-Google-Smtp-Source: AGHT+IHcK8ji32sCIat7H2xKucoKdh58wxd0RlCa758Zauf5a9oF4zVD5I+zYwQ45lypy7m4v6Nizw==
X-Received: by 2002:a05:6102:2908:b0:5d5:f6ae:38c4 with SMTP id ada2fe7eead31-5ec74598e62mr521625137.45.1767686839040;
        Tue, 06 Jan 2026 00:07:19 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944124a3386sm457615241.11.2026.01.06.00.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 00:07:18 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 06 Jan 2026 03:06:59 -0500
Subject: [PATCH v3 4/7] iio: core: Add cleanup.h support for
 iio_device_claim_*()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-lock-impr-v3-4-1db909b192c0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3685; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=Pzl04Z/f7G9BuXHblYf8c17cgor4qrSf/5Wv2Bzp4O4=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkxh1ZJfdTQqWUKNpvNntYjcOZ4IUuhqvinZ9Ou1nP+e
 Kort7K5o5SFQYyLQVZMkaU9YdG3R1F5b/0OhN6HmcPKBDKEgYtTACYSW8Dwv2zOqk/z+d/OvOiq
 bXHn7oXz5lt1+ZaeTBXcxfj9QLje94+MDI3NDoEKG/Mdwzqn/nzc0HVkx+JQg9jgiGc9d5ySCt7
 fZgYA
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
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 include/linux/iio/iio.h | 71 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index d8af0456f966..c795f731f2d8 100644
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
@@ -740,6 +741,76 @@ static inline bool iio_device_try_claim_buffer_mode(struct iio_dev *indio_dev)
  */
 #define iio_device_release_buffer_mode(indio_dev) __iio_dev_mode_unlock(indio_dev)
 
+/*
+ * These classes are not meant to be used directly by drivers (hence the
+ * __priv__ prefix). Instead, documented wrapper macros are provided bellow to
+ * enforce the use of ACQUIRE() or guard() semantics and avoid the problematic
+ * scoped guard variants.
+ */
+DEFINE_GUARD(__priv__iio_dev_mode_lock, struct iio_dev *,
+	     __iio_dev_mode_lock(_T), __iio_dev_mode_unlock(_T));
+DEFINE_GUARD_COND(__priv__iio_dev_mode_lock, _try_direct,
+		  iio_device_claim_direct(_T));
+
+/**
+ * IIO_DEV_ACQUIRE_DIRECT_MODE(_dev, _var) - Tries to acquire the direct mode
+ *                                           lock with automatic release
+ * @dev: IIO device instance
+ * @claim: Variable identifier to store acquire result
+ *
+ * Tries to acquire the direct mode lock with cleanup ACQUIRE() semantics and
+ * automatically releases it at the end of the scope. It most be always paired
+ * with IIO_DEV_ACQUIRE_ERR(), for example::
+ *
+ *	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+ *	if (IIO_DEV_ACQUIRE_FAILED(&claim))
+ *		return -EBUSY;
+ *
+ * ...or a more common scenario (notice scope the braces)::
+ *
+ *	switch() {
+ *	case IIO_CHAN_INFO_RAW: {
+ *		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+ *		if (IIO_DEV_ACQUIRE_FAILED(&claim))
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
+ * @claim_ptr: Pointer to the claim variable passed to IIO_DEV_ACQUIRE_*_MODE()
+ *
+ * Return: true if acquired the mode failed, otherwise false.
+ */
+#define IIO_DEV_ACQUIRE_FAILED(claim_ptr) \
+	ACQUIRE_ERR(__priv__iio_dev_mode_lock_try_direct, claim_ptr)
+
+/**
+ * IIO_DEV_GUARD_CURRENT_MODE - Acquires the mode lock with automatic release
+ * @_dev: IIO device instance
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


