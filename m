Return-Path: <linux-iio+bounces-24477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B05BA5480
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 00:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02BD67B50D0
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 22:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6EC28C84F;
	Fri, 26 Sep 2025 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSYZFPKY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D7A2F99AD
	for <linux-iio@vger.kernel.org>; Fri, 26 Sep 2025 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758924147; cv=none; b=hQJZhtD7dBvM1NOa1xOX0BrQ7q0DypTO4ySqT314fkz49kENsWIuqeTO1lRjR5snwfF+7i33IT1E3tkeMsg1dDTXoPVcO+K4/JsFKXwzcHz5cXAOe4yrePT9sUEfgfcfh/G7ceYcQ8fj2csrqV0leDWulXFqnzHhYCC3Zft13Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758924147; c=relaxed/simple;
	bh=QZYLwLOu9FwUcgSKVi5UCynvL+ZAZTQpQ8/aAvYckS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F5rhOnBrqhRtJQ68BmgAvM97PsnFhy1k3kWgnlsCRKWZIhGCA9N4FlaJsSOEvSiCV0Xj15ZHeiOroaDwAftmCbSf4pYRGUpu6XKy32S9sTJwuHW6ITQT393hLr9DnVPX+FO2SYXc+ykyYTTojOGbeAQSspMDvtOGJtG9ZnGJph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSYZFPKY; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3fa528f127fso1974266f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Sep 2025 15:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758924144; x=1759528944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzGFgAL4kFJpF+2U2ML/HycqoaNqqsEROO0epHyQA0k=;
        b=iSYZFPKYLrgulfqG/D9FE4V34XHQ/0XaHVmmF9fvuBzKPAs5gLvx8nDgNtIHpSkrfG
         FiszWHkRBMutcCNW87RpBOWKlZI9PBJ6tx9VPn9J3aTKcNy9FdccSf/oEsM0m7ZexRnM
         slZ09RdN7rNJItJKYNNgLLDUH62Jk/TYnOe5J8qKZnnOFtW3fcAotLoiTLk8CFxV6nZp
         HHQBrdQsasq2FYE0wZQTKuEkb6/Xpy9ZoxsIqg0ZLwcR88PYlPqhVqfhxIWBOkzRVmy5
         bjwngvyY6plgO1KlRUrtygAvu01ZHDBGz0XfYE/JjEZxoE8EwrdBOBHDC2YiMQg0KOKj
         6JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758924144; x=1759528944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzGFgAL4kFJpF+2U2ML/HycqoaNqqsEROO0epHyQA0k=;
        b=Km3qZfM/1EO1IYe96FyuhrKJriFxXffGgJHqZUtYLN2uRPWbdXPeRlgTEEBVgDE/2C
         MldHDI8Sh+QkUzFiu1kZF5yA/SQhVbcIXDyI9cfBKGmgP1rtPgMQAUrlahAdjzYbHLS1
         j0I6mflaRhAVqajACDIq4h7buK76QxkMRQBPQS4XjTl9ysR7/mOelxQFXPCyqo1/E04e
         Rv5WU1SaE3JpUrvLverKgQ7+9RjYyFrpWAorbaSH70O+l/EtZAhw+uNXjTjAOE7jSOFv
         5/tWmbKtJtO69vqMwy6APK9Uq6T6sUdtB4G+/rjuljKF1Fir3EQ3BYE127Ymq1B9w4nq
         dgLA==
X-Forwarded-Encrypted: i=1; AJvYcCUVwVOgDYGOFuzZqK7MikY7qZtQYaADwfZplB313UpVBe/UYO69K3EXQXrnG+eUPeDuwiDzj/gCGgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+ayehPHg6BQohuW/Mn0Xy4QwJL1roGF63n0hCvvU0DFMFX8G
	wPjzt7H5V4blsycSXu50NHjaNiFkg3Hw5WuVif9iz6oywOUR0NdFMPqR
X-Gm-Gg: ASbGncvQJShY5bLXDtkk0Y4LVc4WnpG+mkw1FOenLCtAUlZ3HWMmRBR5NgPBx4BcKk9
	HDWvDbYOqz/lDIW4aPfEJFhs7zyCYq6TadFS7DS5hH/6+PgaqDHCXJR4rhZRl+XfP0T7/lxlfOb
	zu44oi+rBTbe+Yd0W+F8owHrJdY9TvzlJlwzREDuG4RQoZQmigF5aGNVH1+u1nc/WMs+JWgIltX
	2kanDn2l2As0IdkKPgm4nqAQbOf6dMj25B5RvehWHqM7j1fI13g4OqeztmllwoI7ZDkZNgEJaL3
	tk4c3Zs5hCY60kjvdUk7wFI7E7fq+0jGzTXKEx5MScr6ObI3fN7NMq78wz3tI595EtWmr1Pa/J5
	4FgMdkn2BuqDqiBqQfNab6wqOMe7QOAg488DCP9DT+iVSB9LYjQk=
X-Google-Smtp-Source: AGHT+IEdmGEYGI/H69HniS7cB0ahGFtHyM85fnqKZIEnyyV2R6F1Gk45uwDld+P0FJLHi5vnddBzTg==
X-Received: by 2002:a05:6000:310e:b0:3ee:11d1:2a1e with SMTP id ffacd0b85a97d-418006e9436mr833697f8f.10.1758924143833;
        Fri, 26 Sep 2025 15:02:23 -0700 (PDT)
Received: from localhost.localdomain ([37.163.230.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc82f2965sm8410236f8f.55.2025.09.26.15.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:02:23 -0700 (PDT)
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
Subject: [PATCH v3 2/4] iio: mpl3115: use guards from cleanup.h
Date: Sat, 27 Sep 2025 00:01:48 +0200
Message-Id: <20250926220150.22560-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250926220150.22560-1-apokusinski01@gmail.com>
References: <20250926220150.22560-1-apokusinski01@gmail.com>
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


