Return-Path: <linux-iio+bounces-27103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D68F2CBF7CA
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 20:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF1D1302EA2A
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 19:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8D3326D57;
	Mon, 15 Dec 2025 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/WXt8io"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDDE325728
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765825707; cv=none; b=j0U6PHnPpwgTqkH6mQ7hDFfYlj3r7PWxDqu6rQIl2Keo5qoHqFKEqD298O9mgkIc9/mdmweKnD23e7s7cxmFn+PLUwcDLgYX9Nafu8C2h0QPXbo9T3VsuEr/1838te/rWaMM4SZQ8ECIMNas02u0I+ieA02jqmpxJLCha9WEkzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765825707; c=relaxed/simple;
	bh=8Ywqlv27SE1AVx+U7diS5Q+GgCHCjgIT5HGMYTgOf08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObWLs410nf+d7HZSVOYpzZPfun30GHIgsySGdreb9gmxNXvoQopcZn6oxw/+O5Z+sBpVokezee6kzq/PJZnFKQBB98/K+jVj6D9srXtOi52nUwgM5bBTbGRpb57CKf3raCWBYGaC9B0Fy4wCiQ6fvS28+a628XPhJiv/giWyheM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/WXt8io; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c902f6845so1721360a91.2
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 11:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765825704; x=1766430504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/Vlev60lRDarHuqvumMkRznWDtRoDHrSo51IVlDT98=;
        b=Y/WXt8ioVNTyKF1ll/xPgecSkFCAnqEenf+bEpASfbpbdBMsJYwMiiza6N6AU5yiU/
         c2iI1cme23zklZZEULZYTmyCwuhhJF1nbWB1SAllr9hYCFId2SXrPNNWZcmuy0dDdYet
         iZwZwJWrzt6q0waHz7aqporGTPjgFtmGVNDM7UiE6i5mV3bg/610aS8k6iiZ857jEGhH
         eoWCvhD9RqqknDnPe29AZuDKw+0nImA4LS7rlwn5Gm5s9lOgh7kEHb/wQG9KUYErFMhk
         M1V9/I4esJ+NxSII3r5q6MbwoQ/iFy+STfEumbEUNGE3F33Z2Bzw++KHhzhGmlpB3Ka+
         6hiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765825704; x=1766430504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L/Vlev60lRDarHuqvumMkRznWDtRoDHrSo51IVlDT98=;
        b=CJgAaTxB6TJNp7Cg0Hvq4o6paMnBe01qvbtcPp4JilUyKuSEAxcFq2vtVfUMyZBBXi
         7RXff51wlF/9igr/M0IEn12weHBnOLE4l/3MShPlvL4Y9BKYNEx3cpdlHtQN1jpwX90T
         ILyKcvhQOAy7wVIy/GYcEw10ztxz26+co9tDRo7N1a6fRSCon+DLg0ZbCETNKzm+UxcH
         aMUhZ8SIVlP0CiMY/U7Z58Bzef7snWnJSv37dR1Mw/j9G76VvtYjjbq1gmHDnTWKEB2l
         UVKM7ktVnxjWfE6gy7FFT9+DHunJN+A3fNMBf3r1hhHbaIHFUGf7ymE7dd9OR5zyrZdT
         N12w==
X-Forwarded-Encrypted: i=1; AJvYcCWRAZzVaxzAhgm43fD3j9l2bRI6IUjzTqbeXKByCHPgzg3ctpCtvD0Juj0hctca7KWap+bx8+VNRLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUTYHkR5JaJ79gN7VvL5PIt7PYlguA5WHssVbWWnPvqVy2e8L5
	wiyyqU6xzD1F1VGMWvDo0+YuvteMH8ayzvlhbIkZGXCI2nMbbV7gwkjloZasu6C+b3g=
X-Gm-Gg: AY/fxX7wwAAO5N2f+15Vnx+s8PbDv1iZB7suQvlwN3UtVHOM5udkElyXao3Z5geQb+g
	EP5SD3SdIbll3sUwk3GaId+Af3bktqgv8NSMD+rwM9p2a8zQo04cxlynuXJkcv2ts7atmOTPpVq
	MoDnvFuuWHgt9+Te4XTtW1SpXPTn5tVS8Iz/A2T4GlILcYSVHjwDKcOmUEABdw/r4v77ZFAoTUi
	KTwfjbVS8BAnYjjCeM+M+G49CJRg7QROG1q9J/ikX4/WWD8WlAmE7hRtNVxDFYipMz696q1wJrm
	DGHos0QLNti8HONUz5+K90PZEWctJ3MlwVbW9sGQdm6VUiuOHA3QuwOlA1Jvld67ndmig29zCFx
	rTDim+hwHQS7d3WHtSGveiVGQmeHPN6kRZz2baQ2YUbhCmGoet/6/2vv8UfOZ8zg6veUga759B1
	S+julQHBmTTt0HHcxIYWp9lsGO32Am25ZoI8ZMJZ5RcYhGiZq0RtN7KsW2YgIXjSDxBvkN32IH4
	Ko32Vnmgc7PdWBrH97O9hb7rz2eO3JF0Bq+/oyE4Ea630q7vOL3SxCJon5MsTsRtVAtdUNl
X-Google-Smtp-Source: AGHT+IHBF5A4JZB5+K4+/QTT0muHdjH1nsLZLkU3qoa/JQPWQRtUpiTd6RkM6KZvMTbmdqoKOdRXeg==
X-Received: by 2002:a17:90a:d884:b0:34c:9cf7:60a0 with SMTP id 98e67ed59e1d1-34c9cf7620bmr2870747a91.5.1765825704418;
        Mon, 15 Dec 2025 11:08:24 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe2948d1sm9958875a91.9.2025.12.15.11.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 11:08:24 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: [PATCH 2/5] staging: iio: ad9832: convert to guard(mutex)
Date: Mon, 15 Dec 2025 16:08:03 -0300
Message-ID: <20251215190806.11003-3-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215190806.11003-1-tomasborquez13@gmail.com>
References: <20251215190806.11003-1-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard(mutex) for cleaner lock handling and simpler error paths.

Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 28 +++++++++++---------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 00813dab7c..f9ef3aede4 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -9,6 +9,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -180,9 +182,9 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 
 	ret = kstrtoul(buf, 10, &val);
 	if (ret)
-		goto error_ret;
+		return ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	switch ((u32)this_attr->address) {
 	case AD9832_FREQ0HM:
 	case AD9832_FREQ1HM:
@@ -203,22 +205,18 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		ret = spi_sync(st->spi, &st->msg);
 		break;
 	case AD9832_FREQ_SYM:
-		if (val == 1 || val == 0) {
-			st->ctrl_fp &= ~AD9832_FREQ;
-			st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);
-		} else {
-			ret = -EINVAL;
-			break;
-		}
+		if (val != 1 && val != 0)
+			return -EINVAL;
+
+		st->ctrl_fp &= ~AD9832_FREQ;
+		st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
 						  st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
 		break;
 	case AD9832_PHASE_SYM:
-		if (val > 3) {
-			ret = -EINVAL;
-			break;
-		}
+		if (val > 3)
+			return -EINVAL;
 
 		st->ctrl_fp &= ~AD9832_PHASE_MASK;
 		st->ctrl_fp |= FIELD_PREP(AD9832_PHASE_MASK, val);
@@ -238,11 +236,9 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		ret = spi_sync(st->spi, &st->msg);
 		break;
 	default:
-		ret = -ENODEV;
+		return -ENODEV;
 	}
-	mutex_unlock(&st->lock);
 
-error_ret:
 	return ret ? ret : len;
 }
 
-- 
2.43.0


