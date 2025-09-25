Return-Path: <linux-iio+bounces-24442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D80EBA1693
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 22:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381A6560FF7
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 20:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23AE3218B8;
	Thu, 25 Sep 2025 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XscQm0C9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F5F321438
	for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833166; cv=none; b=XbjQWyi2po8QxbBelBc8bcRV+8lUlCeaVPCNoheR2X0Z8Uz+nzI9J7ib8yzBB4QYklxfLz7aRdaWLCsC9UWV4uXG18V+SCIxIBYcUnpIRdiBNV1yaPOkyakeSKN6ceF6kiOtrKml/ESsjN3jnydO6n7CBsBTTzOSlrh0srtrOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833166; c=relaxed/simple;
	bh=QZYLwLOu9FwUcgSKVi5UCynvL+ZAZTQpQ8/aAvYckS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kh/RUEVgg5RWFtNasCpRwjgVoENB8Fohn9MbhMYm1ScWDWH0gpD4qMfvgRJhZaMsdI3GCZUfsfHkafBOQFCG25XtUhmqJ/b9TNG/sf5LmnnDvbechU0k0ns18vzDRnM18+JiHjwvHAvVOX1KH/MPKsN3MydwODpUquENB8Px/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XscQm0C9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e30ef74b0so10254695e9.0
        for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 13:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758833163; x=1759437963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzGFgAL4kFJpF+2U2ML/HycqoaNqqsEROO0epHyQA0k=;
        b=XscQm0C9pMGlvK8V/vNa+cpWOjgXjN+4W2+l6WKSSaNvDWzZRRN/+k0JutDmXxpgI2
         ksz1RfSaTRR4sTNqIaTwZsN6bnOZH7BFXw8PXgTgIDZ5mWvnpdICePTSWxW1zcKblB4h
         pYXDuUW2dtMpMU8sDOxlK84oHvyDEp/C0ZWleZXj1PKL3Q9NP5ipKP/29fbkRcnXzsIg
         wi5Pii+sepieEGRwMJY90yzIdrDz+jI+lmjbIByaoNH4heQzld8H4UUpkZYQr9fNFDqp
         1loafMCrKn/wpjewRmWpDMYBA5c127Pcs//sXQcfQvuJ2m6aso3VCoo7ZdcwThje63S2
         aPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833163; x=1759437963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzGFgAL4kFJpF+2U2ML/HycqoaNqqsEROO0epHyQA0k=;
        b=dWWAmhzFjVZcFFBEjx+6X5C6wBypq9wkGTMk+DgpqH0PB96W04wCVZNnbRSzBgfLcR
         gkzYiwTetOlt1OaVSXTUlz8tcIxCwmKIu/2O9qDTX1oftgz4EZjWOgUJIIHevoSMsWHA
         3zb49ah0FNyu9wkO/LPXsl6j+QyMZRZGQJrVtRXNU0BLbHXMAXp3ARGh+ZkwYhN6qN95
         ZW38LC0cOCQ2hudZ9Cj3zCDHhMw1QZ7xVfDqQYfWeBTcdewR7vmqkJdfXy5CgIL+/T7q
         B67aFnqKPu0qG7yORS2R4fXbQCZMJJPJF1Qw/8wKsXpZGTclEygIfQWj/tkPgRlGkf/2
         cfhA==
X-Forwarded-Encrypted: i=1; AJvYcCU/+LdA95Y25zDPm0YNrk5OzFb76CxPDc48pEtiISwE2adwbp1xFQXHQgdvZzhGw6B7XgIDQubnl3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YysSouzLW5/usyHZlZmShaNqDpFcDGskOR+XlGqBfRg/o6qNuly
	Yme/kTVXSjOQzbtNjhHRSpbqF1HRh7d+BBEISDbrOSw74IcLYixYyLOp
X-Gm-Gg: ASbGncvY/cIpoi/nNe+hiJBGjjqvBrp4lO0a0GGcbBWn8k0+kcbfFjk560EPjrEI7cH
	wZFqVTu9b5odTavvVdX2Rl/Xcrpjhwt261JdXm4kNq6mgGPJ3hHDe1ACdOy13rXlbDs4WKG77ba
	G5Jrr3nTm1+r+cnpc1cOsNnuGOmqdbwmk6qxaN9OT9MhBfZrjFdbM7pDY6MdKDq9lbfhVnkgU42
	hKIb2oM+pnDiH7JmW2bxsXG4UsHZ8IScu/XqAo2oVK2B9q7k4860hL9w3yI70kchhH61sbYxnsS
	Aa2hFxK6/8a7ax5qdNCvbdE21vFO1sm11dLNYpKPqQdzuAz8smPsUFs4x+hqHTD7bGDjtRwo7fG
	llj01XZ2gs6+GDbOGadrBiD5AIDQeugtupL1C5cP3jAh359Tb8A==
X-Google-Smtp-Source: AGHT+IHHohFMXgIwk1CDdD+uJhrqIHjozKM/oy1Tn2dqyy7fv4EN0p48AORO2mEQxcWa0xSlEG+lFw==
X-Received: by 2002:a05:600c:5494:b0:46e:33a6:46b2 with SMTP id 5b1f17b1804b1-46e33a649a8mr42974005e9.12.1758833163236;
        Thu, 25 Sep 2025 13:46:03 -0700 (PDT)
Received: from localhost.localdomain ([78.209.201.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996bf1sm91201395e9.1.2025.09.25.13.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:46:02 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 2/4] iio: mpl3115: use guards from cleanup.h
Date: Thu, 25 Sep 2025 22:45:36 +0200
Message-Id: <20250925204538.63723-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250925204538.63723-1-apokusinski01@gmail.com>
References: <20250925204538.63723-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include linux/cleanup.h and use the scoped_guard() to simplify the code.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 42 +++++++++++++++-------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 579da60ef441..80af672f65c6 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -10,14 +10,16 @@
  * interrupts, user offset correction, raw mode
  */
 
-#include <linux/module.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/module.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
-#include <linux/delay.h>
 
 #define MPL3115_STATUS 0x00
 #define MPL3115_OUT_PRESS 0x01 /* MSB first, 20 bit */
@@ -163,32 +165,26 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
 	u8 buffer[16] __aligned(8) = { };
 	int ret, pos = 0;
 
-	mutex_lock(&data->lock);
-	ret = mpl3115_request(data);
-	if (ret < 0) {
-		mutex_unlock(&data->lock);
-		goto done;
-	}
-
-	if (test_bit(0, indio_dev->active_scan_mask)) {
-		ret = i2c_smbus_read_i2c_block_data(data->client,
-			MPL3115_OUT_PRESS, 3, &buffer[pos]);
-		if (ret < 0) {
-			mutex_unlock(&data->lock);
+	scoped_guard(mutex, &data->lock) {
+		ret = mpl3115_request(data);
+		if (ret < 0)
 			goto done;
+
+		if (test_bit(0, indio_dev->active_scan_mask)) {
+			ret = i2c_smbus_read_i2c_block_data(data->client,
+				MPL3115_OUT_PRESS, 3, &buffer[pos]);
+			if (ret < 0)
+				goto done;
+			pos += 4;
 		}
-		pos += 4;
-	}
 
-	if (test_bit(1, indio_dev->active_scan_mask)) {
-		ret = i2c_smbus_read_i2c_block_data(data->client,
-			MPL3115_OUT_TEMP, 2, &buffer[pos]);
-		if (ret < 0) {
-			mutex_unlock(&data->lock);
-			goto done;
+		if (test_bit(1, indio_dev->active_scan_mask)) {
+			ret = i2c_smbus_read_i2c_block_data(data->client,
+				MPL3115_OUT_TEMP, 2, &buffer[pos]);
+			if (ret < 0)
+				goto done;
 		}
 	}
-	mutex_unlock(&data->lock);
 
 	iio_push_to_buffers_with_ts(indio_dev, buffer, sizeof(buffer),
 				    iio_get_time_ns(indio_dev));
-- 
2.25.1


