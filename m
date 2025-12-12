Return-Path: <linux-iio+bounces-27033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C16CB7B3A
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 03:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28B0E305BC78
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 02:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAB922579E;
	Fri, 12 Dec 2025 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz9eQ6Ft"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9F322D7B9
	for <linux-iio@vger.kernel.org>; Fri, 12 Dec 2025 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765507545; cv=none; b=jxP7VyEHWMkUY+xKmayF3fhDxlg8/z4fmwXhYU44lZn4hWul1n/JJZjUsDSe/oUte7E+z+ncFmwiisRy9vakMh2om54T3hQ988mPn6qkoNUM8xhPKTi5Rce8iCF65JYfsE7kiZXlUeuhKfe9cYrl5KibiLe03E8FuVLCEHMazHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765507545; c=relaxed/simple;
	bh=6RuhgjKQZQBu1gVOM1UJ1b8RuzOWlkNhUsVE6an3+VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQcf/qz9yEmtVhGQxR/i3BtNqLvfsp/iyLKNHfw6KpkPuYERZqtV1g8Ny4AhrDB9xj1DV8HCufrqeIcItZnKhEiyd5h0iWNI5OmcIFdKHOGN/H6U5P8aisdey2GFENnCIcoxudEXYsJ+3JCq2AqedA1694t5HnbTmFvGc1E3IHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iz9eQ6Ft; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5dbd9c7e468so347473137.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Dec 2025 18:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765507542; x=1766112342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7teUlQNakpyBekbyBa3L6SiOmkc3TRpBucnHceeLxnk=;
        b=Iz9eQ6FtGkzEi4SWvsGCSS8oq+1MRfMrm04dUqbrlggExKoGM2GcPGFWdo/J0lDDo6
         ZQ+H7OwNaRKvE/izDQgvU3G0bmgl0bRIOZ12d2YL4y6eRgw4DcFN7sTdyn/sZ1fe+Qbu
         tfU9uRRCmbqeBtNB2JzH+a7Mjv081nwoCLNU9kRWICcl7+12tUTP7h1Knz9DpDSR3V0O
         wPIfvdl6Y57mdMesyHi7LyPM03XRw8Jf2ewnc4RqSVAH9CAokjfpxv3pAvio/T4mJRhM
         uTNd3krzNapcvU8mGVu9KVLfbdV/jfAps2cdnM3qcL6Y3zckfA6I4LEGALY85z7c4fwg
         61+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765507542; x=1766112342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7teUlQNakpyBekbyBa3L6SiOmkc3TRpBucnHceeLxnk=;
        b=l7AgvYLUzq1X2NqMMyCMmbCS05c6oZTcnqYSbDzERNAHBNkCy2XD3c/+u6huJFyhvd
         rd44IN2BNPn8v2M6VozfoCdOSsQCxrDs8pfZIj7q+hwozaUTb9R/BONOTdOpOfIy4Atu
         prqk4wo8E9pcVMRVACGIrifjmPHeOV1dbu8NqeLNLUPtdxAGzI+J/+0i6PAYGTgSTXHP
         uURyW/t4Zqxb77l3Dcm2kYAcXdCNCAcc4KV64T7k+0zCNzs/g3dk6HBLHNX/X4kw5+qk
         HO2h3Pxi/a2PUAUOWqhoJQ1ST4VcV9C4phaCB5vTTIVcP5iYdoa1tI7lPvFvMKV+mOMI
         GrtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA71wc+3/mfU1pSplQoE0WsowSfPagh/OamynI1Gk34RmH+HBhXJxmMGgplA1GYWYyC8lp5hOnJHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi1bNtjynksS3FRXDyinjKv7aqqDP0ANJ8wqumac1Q1zjd77Ca
	xQhU1ewr7uSkyGW+GXgH2sSJ+5SF00dHFpF6IqAgP2VqWzT2rMFDMADm
X-Gm-Gg: AY/fxX4wdkY4/zvnb0QPHQBIkljRV9mCXvHATeE9OdRWbjSS58SvfYQpUBAlE2StyoA
	d2Noa4coodDuPThzOETXjszAP+xaKhWMbSHoJYL2iLxNcrPnkz9ViCMV8tjDH3kOJmp1t20DA+I
	XoQWyY+D4fWv5BEeyfMxNFNVcDRoK1HD0qgktjtc+9m/vFLgepPsuYdOERq2b8ZPK4Jmst8iiS+
	fp3ydGt5G6XKhD8ayzP4HRy+hbhELW2hk1NQfYbUKM7qdEOYqTkgoIqvG73dAFVUIiPbesd1une
	ghLnwixlHRzsbsSN84Gp/DermppBSkqL7fvduonS49PL2OcWsoWdpeG8M0DfE5E24oOtaYn+99g
	WcBMfLLsoaCXI4gT0iETlIfmmJ6w240oYX7dTGhr8AXMSnuge1oehzz3aCo0/GOwZ22dkR+SJSr
	Kl+5c0WmHl9QJc
X-Google-Smtp-Source: AGHT+IFCbSwjQx+j26I4gFkKKi2c2VWed7wiEapgwj8ZJoFsVfh4kg25ChAQAYsyJ44hwmfrSbsVtw==
X-Received: by 2002:a05:6102:94d:b0:5db:3cda:cc3b with SMTP id ada2fe7eead31-5e827835ad9mr109640137.34.1765507541686;
        Thu, 11 Dec 2025 18:45:41 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e7d0f25ce2sm1693762137.8.2025.12.11.18.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 18:45:41 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 11 Dec 2025 21:45:22 -0500
Subject: [PATCH v2 4/7] iio: core: Add cleanup.h support for
 iio_device_claim_*()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-lock-impr-v2-4-6fb47bdaaf24@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4071; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=6RuhgjKQZQBu1gVOM1UJ1b8RuzOWlkNhUsVE6an3+VI=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJnWjSc/Hl3I+GE9k2n2i5kNa865/P+6+/tGXw6FlycLw
 jQLr7bydZSyMIhxMciKKbK0Jyz69igq763fgdD7MHNYmUCGMHBxCsBEJnxjZNixR9ri+uLDqi0N
 LAdafz789yXIbGnsF9nHl3sDpNiYjQIYGY6cbI257HOhf+2N1YdvT3Zi1Gz7z3LD/Q33evbQ7F6
 B6ywA
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
 include/linux/iio/iio.h | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index f8a7ef709210..c84853c7a37f 100644
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
@@ -739,6 +740,88 @@ static inline void iio_device_release_buffer_mode(struct iio_dev *indio_dev)
 	__iio_dev_mode_unlock(indio_dev);
 }
 
+DEFINE_GUARD(__priv__iio_dev_mode_lock, struct iio_dev *,
+	     __iio_dev_mode_lock(_T), __iio_dev_mode_unlock(_T));
+DEFINE_GUARD_COND(__priv__iio_dev_mode_lock, _try_buffer,
+		  iio_device_claim_buffer_mode(_T));
+DEFINE_GUARD_COND(__priv__iio_dev_mode_lock, _try_direct,
+		  iio_device_claim_direct(_T));
+
+/**
+ * IIO_DEV_ACQUIRE_DIRECT_MODE(_dev, _var) - Tries to acquire the direct mode
+ *                                           lock with automatic release
+ * @_dev: IIO device instance
+ * @_var: Dummy variable identifier to store acquire result
+ *
+ * Tries to acquire the direct mode lock with cleanup ACQUIRE() semantics and
+ * automatically releases it at the end of the scope. It most be always paired
+ * with IIO_DEV_ACQUIRE_ERR(), for example::
+ *
+ *	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+ *	if (IIO_DEV_ACQUIRE_ERR(&claim))
+ *		return -EBUSY;
+ *
+ * ...or a more common scenario (notice scope the braces)::
+ *
+ *	switch() {
+ *	case IIO_CHAN_INFO_RAW: {
+ *		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+ *		if (IIO_DEV_ACQUIRE_ERR(&claim))
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
+#define IIO_DEV_ACQUIRE_DIRECT_MODE(_dev, _var) \
+	ACQUIRE(__priv__iio_dev_mode_lock_try_direct, _var)(_dev)
+
+/**
+ * IIO_DEV_ACQUIRE_BUFFER_MODE(_dev, _var) - Tries to acquire the buffer mode
+ *                                           lock with automatic release
+ * @_dev: IIO device instance
+ * @_var: Dummy variable identifier to store acquire result
+ *
+ * Tries to acquire the direct mode lock and automatically releases it at the
+ * end of the scope. It most be paired with IIO_DEV_ACQUIRE_ERR(), for example::
+ *
+ *	IIO_DEV_ACQUIRE_BUFFER_MODE(indio_dev, claim);
+ *	if (IIO_DEV_ACQUIRE_ERR(&claim))
+ *		return IRQ_HANDLED;
+ *
+ * Context: Can sleep
+ */
+#define IIO_DEV_ACQUIRE_BUFFER_MODE(_dev, _var) \
+	ACQUIRE(__priv__iio_dev_mode_lock_try_buffer, _var)(_dev)
+
+/**
+ * IIO_DEV_ACQUIRE_ERR() - ACQUIRE_ERR() wrapper
+ * @_var: Dummy variable passed to IIO_DEV_ACQUIRE_*_MODE()
+ *
+ * Return: true on success, false on error
+ */
+#define IIO_DEV_ACQUIRE_ERR(_var_ptr) \
+	ACQUIRE_ERR(__priv__iio_dev_mode_lock_try_buffer, _var_ptr)
+
+/**
+ * IIO_DEV_GUARD_ANY_MODE - Acquires the mode lock with automatic release
+ * @_dev: IIO device instance
+ *
+ * Acquires the mode lock with cleanup guard() semantics. It is usually paired
+ * with iio_buffer_enabled().
+ *
+ * This should *not* be used to protect internal driver state and it's use in
+ * general is *strongly* discouraged. Use any of the IIO_DEV_ACQUIRE_*_MODE()
+ * variants.
+ */
+#define IIO_DEV_GUARD_ANY_MODE(_dev) \
+	guard(__priv__iio_dev_mode_lock)(_dev)
+
 extern const struct bus_type iio_bus_type;
 
 /**

-- 
2.52.0


