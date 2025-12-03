Return-Path: <linux-iio+bounces-26707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA218CA1573
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 20:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63A60301F386
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 19:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918492FE045;
	Wed,  3 Dec 2025 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgZa6yzt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FF4331A7F
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789584; cv=none; b=tHwp7UOJZPOeu4JcG/bzr2ItsRyeZc/xMQHgqoetT6W19RskcRzLIYu9n724QJ0mC++VEnYafZe5cAFlNTJfjwutziRhovLBez6w7r0+0TkCWMWSEqbipYCG17z0NtX9kU1ExlWk+75uJUqBKkTSCKZZfwyL0Jkm50+NE69zrkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789584; c=relaxed/simple;
	bh=tn/w/6QgqKcoYMi5mFWRyn+5w4UqZC+LPfsJulBKPJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DRwx9Aae/DHm1z5awdDjJ59KwXAcvhe3uGzV2MtgvaxN8Sj+xXoKWJPewnXlti7zfArHojjAQP95XO5Gp9ekFYEU2HLsOLsyofI5c6ONKUoGRAFM0Zq9IALqi7tNw7R0zjZuGiLVL85qESoJbq58aHNF/J0M6Z1fC6rkpY7C/N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgZa6yzt; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-55b2a09ff61so33877e0c.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 11:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764789581; x=1765394381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZihbaTpfvHiUVwOxJ/ox+Rr5XJYqm2BGakDi80e4wx4=;
        b=ZgZa6yzttFFQ1R7lLt1Iz0TINniPu19Rw4ptN3ZybLLoFzJ8t5h3CPKogv0vGQATPL
         +wxNROcKfS/YrNj+MjQmWosGt4DMIm/2LxIwZmjrxgac5Xrc9/5s2ANm8KbiEOokaWvo
         OjMV7nuI3j0UgTABKKgaU846xLD47RDncOPyMMxTgS+zAXPrl/nc/gOUKN8wiLn0r7u9
         YiT1Gm9jjd8zAb5967HPKU2ttCghiedP+qpqxhAFZMyXULHrIDxE51AojInhfSwK+ngH
         5Q/tB48391CrohxNsnh+EYXAdzlLN8U8pIlF1PTYlTe/Q5TrcTHuJlddBUVTvipZIYx6
         rEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764789581; x=1765394381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZihbaTpfvHiUVwOxJ/ox+Rr5XJYqm2BGakDi80e4wx4=;
        b=PkcmkWCf8uhCERxOe2LQuai16ASze/Sj0maUJg3VG60S14qk73BpgUtd3E36EIQXdO
         0CK77PgAuPyn/r/AcDUfKgtK1Izv/UB554TbI8YmRKT5Fp1nff7c8pBNizwHq58F+kBU
         sY3Rs6SBExGMv4xl1Opw4aWI8Ccpf7r4aHyDlhNt7ctl+QiL0y13LkjQR3n0SFMfgz53
         J5hSoNzmGBHuuZsrRWy//pSMOQCIAN/uphMlupNbBYPBCRl+pxHKHcwjuLwkYjoPgZ9V
         ugdbaaYqbq3wIWVkZqZ9xUo5NzsJs/mt6zRpm0oktt6ZisHLeHVlntz7QofJeo2506vG
         g9PA==
X-Forwarded-Encrypted: i=1; AJvYcCXhIegHkUzz+TTxW4JdBCPZrDjAZ4upr3SyI2aQst+weuQWrIpcphbcp5krCa7ARHtZ+QrLjWl3nsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWWF/Cjsspyho/JLJvNZSO/f1yOoUODmix/YpNWyu8kelK0lx1
	/sFk94eqjHGJJgGDQUj5hkot/9i7m2+sP6QSVcZ2tA9UyqjjCixX5M6/
X-Gm-Gg: ASbGncvU7GU+NHTCg8lLxfRARRMOpMLlnZPp0ZImixCjl3ViUy3enGma4tleel2uwaV
	SvWeTvJwCn/VNbXzYhAlYzgx22ddBle061/XG9C7hcV/ZNLM8pgJ4lEpmwsRtpgv6rW2L4F0qZ4
	7DX7nBZPOmrCUrIRV5C3jCqIkqkIo5yUInmWA+CZAbk799osZjREOSp7qkeASDgmQmXbj+9Ditz
	4Yjr3Aov7WNrKUqK77mQAsAHxd+KwGEkqiaBNS16Ywf1hqBGwdtHpmrcAXWbOf7QKnNq46awJGb
	8wqMq+jWWeHS5e0o/nRmZL3oc1U7PIK+xB3Rd2u9qJkOhqZ28AT5zhkRWLfnjcIIzVEFwoyO0mV
	bs+PhxR2NnBYj765HopF+APaGM/XaefC4DQfKlL0FJBMiIBoB/VqW5VWwAUojPq2p4hLu0ZFVkD
	5glZW6Cz1vLOAM
X-Google-Smtp-Source: AGHT+IHIIOGfjLqow7vHKF+fitdQAN2rgcc4rulzr9Bq5lFoVmnhAntXIt64BljLbfx8DEKHjNIF9Q==
X-Received: by 2002:a05:6122:1ac1:b0:559:6723:628c with SMTP id 71dfb90a1353d-55e5c027d2emr1188996e0c.16.1764789580613;
        Wed, 03 Dec 2025 11:19:40 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55cf4e1d56asm8121346e0c.4.2025.12.03.11.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 11:19:40 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 03 Dec 2025 14:18:16 -0500
Subject: [PATCH RFC 2/6] iio: core: Match iio_device_claim_*() naming
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-lock-impr-v1-2-b4a1fd639423@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7511; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=tn/w/6QgqKcoYMi5mFWRyn+5w4UqZC+LPfsJulBKPJE=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkGva6Hz57/WJLZVP9aeYu3rO/aOXpnOn+LrVme9k055
 Kr0lF85HaUsDGJcDLJiiiztCYu+PYrKe+t3IPQ+zBxWJpAhDFycAjARuTSGv+LGV6NdWT5Ofbv1
 zJFbUZfYUkTmr5p99yTH31OBu35/71Zl+F8tEe/6SOzs6hy75x5pe7Sj24pWq781UW93OtEcYFQ
 tyw4A
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Rename iio_device_claim_buffer_mode() -> iio_device_claim_buffer() to
match iio_device_claim_direct().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ade9000.c                                |  4 ++--
 .../iio/common/cros_ec_sensors/cros_ec_sensors_core.c    |  4 ++--
 drivers/iio/health/max30100.c                            |  4 ++--
 drivers/iio/health/max30102.c                            |  4 ++--
 drivers/iio/industrialio-core.c                          | 16 ++++++++--------
 drivers/iio/light/opt4060.c                              |  4 ++--
 include/linux/iio/iio.h                                  |  4 ++--
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index b345c4d1ef24..b0bc75999f40 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -964,9 +964,9 @@ static irqreturn_t ade9000_dready_thread(int irq, void *data)
 	struct iio_dev *indio_dev = data;
 
 	/* Handle data ready interrupt from C4/EVENT/DREADY pin */
-	if (iio_device_claim_buffer_mode(indio_dev)) {
+	if (iio_device_claim_buffer(indio_dev)) {
 		ade9000_iio_push_buffer(indio_dev);
-		iio_device_release_buffer_mode(indio_dev);
+		iio_device_release_buffer(indio_dev);
 	}
 
 	return IRQ_HANDLED;
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 8ed4b2e410c8..b1c50139ea92 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -189,7 +189,7 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
 	 * Ignore samples if the buffer is not set: it is needed if the ODR is
 	 * set but the buffer is not enabled yet.
 	 */
-	if (!iio_device_claim_buffer_mode(indio_dev))
+	if (!iio_device_claim_buffer(indio_dev))
 		return 0;
 
 	out = (s16 *)st->samples;
@@ -206,7 +206,7 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
 	iio_push_to_buffers_with_timestamp(indio_dev, st->samples,
 					   timestamp + delta);
 
-	iio_device_release_buffer_mode(indio_dev);
+	iio_device_release_buffer(indio_dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_push_data);
diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 3f3680c4b42f..6aefe9c4a8f6 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -417,7 +417,7 @@ static int max30100_read_raw(struct iio_dev *indio_dev,
 		 * Temperature reading can only be acquired while engine
 		 * is running
 		 */
-		if (!iio_device_claim_buffer_mode(indio_dev)) {
+		if (!iio_device_claim_buffer(indio_dev)) {
 			/*
 			 * Replacing -EBUSY or other error code
 			 * returned by iio_device_claim_buffer_mode()
@@ -430,7 +430,7 @@ static int max30100_read_raw(struct iio_dev *indio_dev,
 			if (!ret)
 				ret = IIO_VAL_INT;
 
-			iio_device_release_buffer_mode(indio_dev);
+			iio_device_release_buffer(indio_dev);
 		}
 		break;
 	case IIO_CHAN_INFO_SCALE:
diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 288c2f37a4a2..678720102f2b 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -476,7 +476,7 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
 		 * shutdown; leave shutdown briefly when buffer not running
 		 */
 any_mode_retry:
-		if (!iio_device_claim_buffer_mode(indio_dev)) {
+		if (!iio_device_claim_buffer(indio_dev)) {
 			/*
 			 * This one is a *bit* hacky. If we cannot claim buffer
 			 * mode, then try direct mode so that we make sure
@@ -490,7 +490,7 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
 			iio_device_release_direct(indio_dev);
 		} else {
 			ret = max30102_get_temp(data, val, false);
-			iio_device_release_buffer_mode(indio_dev);
+			iio_device_release_buffer(indio_dev);
 		}
 		if (ret)
 			return ret;
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a10590ac4e17..adf0142d0300 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2216,17 +2216,17 @@ void __iio_device_release_direct(struct iio_dev *indio_dev)
 EXPORT_SYMBOL_GPL(__iio_device_release_direct);
 
 /**
- * iio_device_claim_buffer_mode - Keep device in buffer mode
+ * iio_device_claim_buffer - Keep device in buffer mode
  * @indio_dev:	the iio_dev associated with the device
  *
  * If the device is in buffer mode it is guaranteed to stay
  * that way until iio_device_release_buffer_mode() is called.
  *
- * Use with iio_device_release_buffer_mode().
+ * Use with iio_device_release_buffer().
  *
  * Returns: true on success, false on failure.
  */
-bool iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
+bool iio_device_claim_buffer(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
@@ -2238,22 +2238,22 @@ bool iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
 	mutex_unlock(&iio_dev_opaque->mlock);
 	return false;
 }
-EXPORT_SYMBOL_GPL(iio_device_claim_buffer_mode);
+EXPORT_SYMBOL_GPL(iio_device_claim_buffer);
 
 /**
- * iio_device_release_buffer_mode - releases claim on buffer mode
+ * iio_device_release_buffer - releases claim on buffer mode
  * @indio_dev:	the iio_dev associated with the device
  *
  * Release the claim. Device is no longer guaranteed to stay
  * in buffer mode.
  *
- * Use with iio_device_claim_buffer_mode().
+ * Use with iio_device_claim_buffer().
  */
-void iio_device_release_buffer_mode(struct iio_dev *indio_dev)
+void iio_device_release_buffer(struct iio_dev *indio_dev)
 {
 	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
 }
-EXPORT_SYMBOL_GPL(iio_device_release_buffer_mode);
+EXPORT_SYMBOL_GPL(iio_device_release_buffer);
 
 /**
  * iio_device_get_current_mode() - helper function providing read-only access to
diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index 8cb3fa38077e..500899d7bd62 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -304,7 +304,7 @@ static int opt4060_set_driver_state(struct iio_dev *indio_dev,
 	struct opt4060_chip *chip = iio_priv(indio_dev);
 	int ret = 0;
 any_mode_retry:
-	if (!iio_device_claim_buffer_mode(indio_dev)) {
+	if (!iio_device_claim_buffer(indio_dev)) {
 		/*
 		 * This one is a *bit* hacky. If we cannot claim buffer mode,
 		 * then try direct mode so that we make sure things cannot
@@ -334,7 +334,7 @@ static int opt4060_set_driver_state(struct iio_dev *indio_dev,
 		else
 			ret = opt4060_set_state_common(chip, continuous_sampling,
 						       continuous_irq);
-		iio_device_release_buffer_mode(indio_dev);
+		iio_device_release_buffer(indio_dev);
 	}
 	return ret;
 }
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index bf7b7337ff1b..27da9af67c47 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -687,8 +687,8 @@ static inline void iio_device_release_direct(struct iio_dev *indio_dev)
 	__release(indio_dev);
 }
 
-bool iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
-void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
+bool iio_device_claim_buffer(struct iio_dev *indio_dev);
+void iio_device_release_buffer(struct iio_dev *indio_dev);
 
 extern const struct bus_type iio_bus_type;
 

-- 
2.52.0


