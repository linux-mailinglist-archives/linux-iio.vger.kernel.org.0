Return-Path: <linux-iio+bounces-26706-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 530DCCA1562
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 20:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADB5430039B1
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 19:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ABF3328F7;
	Wed,  3 Dec 2025 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrmWeBLV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADD43321C0
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789581; cv=none; b=GMg6saxkMZnj7CCZ7S30ElFY6UpFanNHHtxrl5AMsssM+KYuBClwVMr/P1ULraTEyPklDHhadEyAnp+KCdFASWW+GgaXmlGHhs7x0J/zmV9lrSTdc917Ysy9/q04QNkbcLcZfNv6xsyk98djZ6TTN3BbtNFOHuci3f8XGjUkc7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789581; c=relaxed/simple;
	bh=tgg4Jta3JWOQIYugusdzOpEO62AZmmgPzzdm9FOULNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rEvmygZpBwn44aY9Q7KqIAMDMTdnAE6NaH2hpsutThdkycLIJw4da3IRmCCU4rBRArfbFxF8NvmT7DD5lE6/5KtWxY/bE6lYIYd0kEdUZTHTV8PO37UdSObAi/OJYhmHkOZ0GSeXrspq6IFQeou9XKc2V8jUeVmeXnkQmd2DcDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrmWeBLV; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-55b0d4b560aso873996e0c.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 11:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764789578; x=1765394378; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYgcHkkiVH7bWdjqtn/9Y8/vTFxsajXbkTNsCCHFasY=;
        b=BrmWeBLVrAOqV+oK8egWk8d9hgko2bimDM54GRT1tvaWuEvZye8VZIDfsILryEemh+
         7tvub+zo+Bo/kMJSBeKgiYWD19murtOD+qxDO/ldAQNyR9v8mFJpKYdQa+EOGgxZ8Tfk
         IGHKFd8QkHFRk7hN/X+/t0ZlD3Juu+5cbAYJjO2epEoAvDFkA9cnrqrWL+aN/xbxq+Rl
         J4bG+fKBZ936SFpRIH2e1yUZUNjb96RpX3vxC+3F2ex9J72/3L/7lgHsQwpreZUj730C
         3X0jSZPu9HAeG3yZeojtxOmNCZeOKHdc/LqDS38rqv3W2KPSYDwqFmwoZLwzwhILMZc+
         X2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764789578; x=1765394378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DYgcHkkiVH7bWdjqtn/9Y8/vTFxsajXbkTNsCCHFasY=;
        b=UJoAtaJuYujprti26r+2eP0tJWK8Bol6L7lEvd7UlP5bnKI+TraPxe5c9bxmLQzSxW
         po9dkuSVR9fJazx0vUNbi2vxyiuPVlagSFotjyFvvcb8WEBU72k890YnvSacRtWaV3aP
         mprsLUubN0Ets6OeLOFukn0QNrWHzJyO1pWEMx2yzO1mMyLq3Ofmt4R3vC71Ygr2t+E3
         c6SkPvP9gRvmhjavLk/hyeBHjlO568wi4Qwx7aHrCWGZx32iyxdbc5nWhOAv7cD/7M1k
         DSA+Se+rnwBrlClfVtB+gojaPVgm0BxnxYVOe9RH0c2bx6I5BFwo6hv29IoUlSZ/AmrV
         J2Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXk9Xkk5d25Rqdik5prAmMoDKJDR2uP5HBz7eHdGUT1jBXmNaKhxCV2iljM8oW2UTQ2O9TowtrADXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL4Hci/nC6xnghrB4HvDNOm0Ky8Tku8qPgbLQx+X06978HKGnQ
	AdCjPTdanQAcM09/DTKDQETIjniYHFuMkNOI4+JPCDl3sn4NTArCX9F4zrdd1Q==
X-Gm-Gg: ASbGncvLhAVW3ZiYmFSJkPaUozc6IRBQjrDNvNTTbxnv+CqnnYOkgNQwIUDSia0gRY0
	PLwtOc5vNDE/Fewur1b9Cw1DTGi6LdcVdQN68z5boQ0ExA8iVWPc5+FDH3chrpOYfxSxC9I6g9s
	9o26ZJOeRp55Eb8BbCJPU9Ze6rWS09Qmlknzwg0NxIRHv/1wzlgKkZWs2B7jJGbCKTq6hJzn3Wk
	883UT+fj76rvTTDu168W/3TnSSwyLmPU3/GZeIwQFnaX3VJ5s242oMYONiNmVvVGn0uvCfR9sEG
	GbFMR8tu8u3weqSmbd3GlaRGBdRS4d0UGix5WA00+xM6X6cs9cMyK+bCTavlQk8hq3LBKDHBJIY
	Sgyb/5BYvjdn97a1xDZVjOkYg4XUYkdZ5gBdh8Wq9ZcgeOj2wLCij+p0+QMdnMaL/zKr3P2xB9i
	OpQTOXd/WpCAdn
X-Google-Smtp-Source: AGHT+IHIiBtoxiWK925hSxHAPVRWkl2NIGmNzv1AKWw3sm12bMPKmIWfnLEd+xUJrnD5Mi3qB7c38Q==
X-Received: by 2002:a05:6122:2903:b0:55e:4f9a:103f with SMTP id 71dfb90a1353d-55e686ef2a0mr301597e0c.8.1764789578219;
        Wed, 03 Dec 2025 11:19:38 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55cf4e1d56asm8121346e0c.4.2025.12.03.11.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 11:19:37 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 03 Dec 2025 14:18:15 -0500
Subject: [PATCH RFC 1/6] iio: core: Match iio_device_claim_*() return
 semantics
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-lock-impr-v1-1-b4a1fd639423@gmail.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
In-Reply-To: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5265; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=tgg4Jta3JWOQIYugusdzOpEO62AZmmgPzzdm9FOULNc=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkGvS73xF/6/P11pIZ/Gcds7XOOH9v93S6dO/Wl7ua/Z
 d+kfkuadZSyMIhxMciKKbK0Jyz69igq763fgdD7MHNYmUCGMHBxCsBEyg8wMqw+ylatl7xJ7z5n
 i94J293rNv58vPFN6Msp7A19glMblDwYGbprGOt8U+1ObblbI60/ezffdIsGken/wzQP6l7/ox1
 9iQMA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

In order to improve API consistency with conditional locks, use
true/false return semantics in iio_device_claim_buffer_mode().

This also matches iio_device_claim_direct() return semantics.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ade9000.c                                 | 2 +-
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 +----
 drivers/iio/health/max30100.c                             | 2 +-
 drivers/iio/health/max30102.c                             | 2 +-
 drivers/iio/industrialio-core.c                           | 8 ++++----
 drivers/iio/light/opt4060.c                               | 2 +-
 include/linux/iio/iio.h                                   | 2 +-
 7 files changed, 10 insertions(+), 13 deletions(-)

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
index f69deefcfb6f..a10590ac4e17 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2224,19 +2224,19 @@ EXPORT_SYMBOL_GPL(__iio_device_release_direct);
  *
  * Use with iio_device_release_buffer_mode().
  *
- * Returns: 0 on success, -EBUSY on failure.
+ * Returns: true on success, false on failure.
  */
-int iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
+bool iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
 	mutex_lock(&iio_dev_opaque->mlock);
 
 	if (iio_buffer_enabled(indio_dev))
-		return 0;
+		return true;
 
 	mutex_unlock(&iio_dev_opaque->mlock);
-	return -EBUSY;
+	return false;
 }
 EXPORT_SYMBOL_GPL(iio_device_claim_buffer_mode);
 
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
index 872ebdf0dd77..bf7b7337ff1b 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -687,7 +687,7 @@ static inline void iio_device_release_direct(struct iio_dev *indio_dev)
 	__release(indio_dev);
 }
 
-int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
+bool iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
 void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
 
 extern const struct bus_type iio_bus_type;

-- 
2.52.0


