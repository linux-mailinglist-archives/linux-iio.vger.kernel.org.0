Return-Path: <linux-iio+bounces-27493-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D2ACF741E
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 09:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B4633012658
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 08:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0D23191A4;
	Tue,  6 Jan 2026 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSZ2NtGm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E583168E1
	for <linux-iio@vger.kernel.org>; Tue,  6 Jan 2026 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767686835; cv=none; b=PN2FjF9w/bUCpd88ZeIFLNrxDpTrFUtU+KyOPoLRzxEbXvtlpWbQhXJB1MxOLLjCpEJC+UlmLfPS6wRJkBKcB6yChvyC5flLysnzjlEfyhnRh1mkpRpj8TZADllDkqmupM3rvaQgPdpfDiTrSnSNdrdJse509RYfoqpR682UpoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767686835; c=relaxed/simple;
	bh=e8dx5+Y9ZmFmdYVxk3+rCPDes2YyZRYOQmPuTiqxJtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nuQUaGQaCXTClQmGqInAkinlTmHZ+1iUKp4NvbFoCD9N6Rei6yZ4FP1da0zbdtGPhDsR/XztvlifocXVdmBh5AtfKbDSBB8udqeE/EWJx+YIyuovzm8uFZ1z43b8Jrs5wtH1DZ/qXgsNe0CkEiCw0/dquS7uJTeFXLqVKIt3sNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSZ2NtGm; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5dbd8bb36fcso520041137.1
        for <linux-iio@vger.kernel.org>; Tue, 06 Jan 2026 00:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767686832; x=1768291632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eBw/siTkOPKNQywL34hEvRzPDZoJwcT16i1sK8KTFc=;
        b=jSZ2NtGmvHscxoqven2T0jhQKtYYAUh3i7OcEmuH/dWL6XcDDKFJkSaq2aRdReVGv7
         7uwfbRZVZVZuIGIwBaLFJ1OnzxQ2Jo3D68sCNXOgZGBgvqpj4LGIY5M2zBIzu7v0kAh2
         KHPkSovbjLHHM7Hc/MmHyGNp/lLU5IFbZ3z8G5T6Nc/MKa99Cn3lwa1C8j7Awx0JYI+X
         UaP04ICZ54oB06VuL11GGSqhcidT02VRZbab2zaMTmcge1/sEiJKjGKppwIudy4Ph4sR
         NDTQ0n8ZODrgd+CD6VpEbjzVzeNNRhKiLD5mwOQ5/yXb5Pqy8tLJpNhgNB8FaSoQ1inn
         yq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767686832; x=1768291632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0eBw/siTkOPKNQywL34hEvRzPDZoJwcT16i1sK8KTFc=;
        b=JU0yMVJz1F54lG+FPG3YyWeia5VRqicxdC/zjsG+ff8bih+UhuVQo9AzWYGvmfJzwR
         AmvxCUc6DYyY12GXN3btJk/sfAHpmwxTHiDMR1QWjXMW65ye0IYRnOe7/mlqGe5beKe6
         r1JpFYtSBwCgzxBl47mCAfLjojfM16/PbAZ7bLIV76vW7NYsg99eeRrTlrRSXbig6a0I
         GI5q4fwoM09aHPeL+5Coiyo62aSXKO5vK/FxsYypV44QRsfjEw7ECMc/AmHyB7/BK1Zj
         POstAQG+7p0F2NRxuDYWch6T5klNXLU8VZEiBaGGT7crS6CLTo6ww0UOzcotyv/wBBjj
         pwJw==
X-Forwarded-Encrypted: i=1; AJvYcCWNeeoHiQW6XHVhyCkmlSpV6h8224xoqvHmfM8ilnHd5EbptoU/AcZS30NAvFzUtcfOD44wRF/m3zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX4Fr2uIXCUHyG/+urNUfQEjpQjPC9uQE3WcDPb1bGzBHl7g+j
	0J92jnKvtEFPvwQ+ovGyK+uijZfeBgV9YzOjTsnIsGEo7ViYVG70Di4V
X-Gm-Gg: AY/fxX4Bcuxeo7XOERoqybaVgrsSwqgp2hcweJR3rOjo7FobEHUM5Pmrwadcv4IAb14
	o67N61B+8cfAhPdiygAAe6qzmaYJPS3Ku6MDd8vaSAC4l+YT5aQLZqifsaIsBXw9B3jvzDbXaNc
	vE3tNaZa6flUO5S+gRhNvH64Yohg3HorRiHMQ14PvO+wVZv6KUSRUCuDrAIjDRI59Ag5XWUqROv
	InWdeW6cyr1zr5kHNt7Ls86VePvobzD9SpHbTdu4yXQQ3e+RGTOzZcW2BMPpvoCyXj1HOjsc2lP
	EYaeFXO4C2js1E/FEi5xp5aPjyG4d64ki3jZYbe7/3mhmFp1WEi/AzAKlF9Ha5rlX9YstrZptFs
	fb20+bm8QaM+rLrQrsPaip8lBmF39Eu7G8KnLM4sjTn9OUNh/fb9O/2C415tbE+AjHkKGZ4tFMg
	KSFqpJdtZoLlIS
X-Google-Smtp-Source: AGHT+IHHKonWi1vsrR/n1XZBjsbDP55NV5Xe9+c0ckwEjkAwo2rnLjn1/pCor3jNViJDrOIb50kazQ==
X-Received: by 2002:a05:6102:2b92:b0:5dd:a0bf:8c89 with SMTP id ada2fe7eead31-5ec755c2d49mr614154137.7.1767686831757;
        Tue, 06 Jan 2026 00:07:11 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944124a3386sm457615241.11.2026.01.06.00.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 00:07:11 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 06 Jan 2026 03:06:56 -0500
Subject: [PATCH v3 1/7] iio: core: Add and export __iio_dev_mode_lock()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-lock-impr-v3-1-1db909b192c0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2778; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=e8dx5+Y9ZmFmdYVxk3+rCPDes2YyZRYOQmPuTiqxJtU=;
 b=kA0DAAoWFmBDOPSf1GYByyZiAGlcwqqjZwbxqPT+UWyr0W5p1s4jwhOEeBscxXhqeG+P1mNAp
 Ih1BAAWCgAdFiEEh2Ci9uJabu1OwFXfFmBDOPSf1GYFAmlcwqoACgkQFmBDOPSf1GahEgEAlT9h
 g6slgdmAiTQIy6zdPTsuhWstAvX3SBgp6nErrG4A/3neXrHJ00Sk5c0p56ySv4ZOG1G6UmX6SPl
 lz5t/JBUG
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add unconditional wrappers around the internal IIO mode lock.

As mentioned in the documentation, this is not meant to be used by
drivers, instead this will aid in the eventual addition of cleanup
classes around conditional locks.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/industrialio-core.c | 30 ++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f69deefcfb6f..34867a860a84 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2171,6 +2171,36 @@ int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_GPL(__devm_iio_device_register);
 
+/**
+ * __iio_dev_mode_lock - Locks the current IIO device mode
+ * @indio_dev: the iio_dev associated with the device
+ *
+ * If the device is either in direct or buffer mode, it's guaranteed to stay
+ * that way until __iio_dev_mode_unlock() is called.
+ *
+ * This function is not meant to be used directly by drivers to protect internal
+ * state, a driver should have it's own mechanisms for that matter.
+ *
+ * There are very few cases where a driver actually needs to lock the current
+ * mode unconditionally. It's recommended to use iio_device_claim_direct() or
+ * iio_device_claim_buffer_mode() pairs or related helpers instead.
+ */
+void __iio_dev_mode_lock(struct iio_dev *indio_dev)
+{
+	mutex_lock(&to_iio_dev_opaque(indio_dev)->mlock);
+}
+EXPORT_SYMBOL_GPL(__iio_dev_mode_lock);
+
+/**
+ * __iio_dev_mode_unlock - Unlocks the current IIO device mode
+ * @indio_dev: the iio_dev associated with the device
+ */
+void __iio_dev_mode_unlock(struct iio_dev *indio_dev)
+{
+	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
+}
+EXPORT_SYMBOL_GPL(__iio_dev_mode_unlock);
+
 /**
  * __iio_device_claim_direct - Keep device in direct mode
  * @indio_dev:	the iio_dev associated with the device
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 872ebdf0dd77..aecda887d833 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -661,6 +661,9 @@ void iio_device_unregister(struct iio_dev *indio_dev);
 int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 			       struct module *this_mod);
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
+
+void __iio_dev_mode_lock(struct iio_dev *indio_dev) __acquires(indio_dev);
+void __iio_dev_mode_unlock(struct iio_dev *indio_dev) __releases(indio_dev);
 bool __iio_device_claim_direct(struct iio_dev *indio_dev);
 void __iio_device_release_direct(struct iio_dev *indio_dev);
 

-- 
2.52.0


