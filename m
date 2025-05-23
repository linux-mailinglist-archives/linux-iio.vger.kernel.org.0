Return-Path: <linux-iio+bounces-19841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 977F7AC2BCE
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 00:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF954E50D5
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 22:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5F221D3C7;
	Fri, 23 May 2025 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyjFhA8d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217CA21A45D;
	Fri, 23 May 2025 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748039760; cv=none; b=F1jVF3+ng5kQy90P96W7Fi7DLHukwoQC9t0jvWwFswqd51DJCbqrhpTnVp/7A6g5IbusOGKn5ov0dxITNsMuZM/J8xvYHS3BmpcL0BZpqaUIz0YDkdY/l2zW1BCC6OWTny9LmHRa/iVyUZ4claG0PzpBf6nM/rYg7/A5/YVFab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748039760; c=relaxed/simple;
	bh=vJ/8rMeyIi1bRVEcaZendCDBuwqXRlAolkdgA8duC38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tUZkjyyyLFJ3c0qIhI4EiKxyi37ubWpzQJPlGT3TDj80PQos9OxcYwkQwxjWuNehAjOHnKBQ3FfBiBw6AJP4DwsFoBvbU2JCMkZEK5Gj+IO2kaccYgsrYoGXJX6Uod73mAnScjHkJTbEvnzWkxfmwY6lLq5TJ0QuF9a3E9YYxiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyjFhA8d; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d4ff56136so359565e9.3;
        Fri, 23 May 2025 15:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748039757; x=1748644557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhBiTKknxfnB+PZ8TAf2iEXT71M+j5r93pB6ZoGib7Y=;
        b=AyjFhA8dyDaTBx+d92nRYRBgB8WZzeb8nbLY3FIHtRppBXmoezUcdAtE4Iux+/NlCc
         FY6f3SUIuWWNWE6Nm1neWoD8mCpr3l1xc3JrOu1dBx94HOfWNFP5/LaBESQg0KxiQVmx
         AQkXHoIpDgs4dxs1go1hTaLW79McyR3o8RxcrFM10n/btyiEL4bAFUwWcdHUpwH3Br8c
         TlBzHlJma81/3uWnQz22ve6ghefXupMI0XRP2XwH9e6PCq7OQHnVWQKZpQH/8RfPp6dL
         bb9/E53hM0fxIoiMh5g2MSza3rxugPJssW6rxEfxVZJhAru1OMQ2uqqJgRsSO+2FiDCd
         60lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748039757; x=1748644557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhBiTKknxfnB+PZ8TAf2iEXT71M+j5r93pB6ZoGib7Y=;
        b=ngZZbSSZWzZdaZNJjFjAbeLTaGy7qDKfYxQKIb4zfsWaB+plTlOJY2ga0JxBODrAS8
         lBtjTnBFWQsFXQ1Pt7qVbtagttmewXmTgULeNtkjCI27kYokkGf8zDfO7FIyP0l9Lo6L
         OBXUxrh3XBOdy4qgBN8v4QHcMzNUGIz1wXnpaZgKmsvs8hYGFlMqhba+yE1TeKhcYKfX
         X4gI1ysTx0NaLakm4wlXlBHEEBk6AsFKG9OvrK3HMe+tuN/5IJ0++jrGPEnDfYi5NeVD
         ZjtqXBoWPqcV32f6Tp4U51A1sz81Rc5qyz8f8jCfTfA0LUOLvLuoHYTWPJ9qyU3klkIZ
         5Tug==
X-Forwarded-Encrypted: i=1; AJvYcCWk+DtmUEa7WYeUwXRXscN7S9Z44YyhNMIyERz/4T6kPe2NyWAlMBAyY/1Kn5OYmrEJS42NqjBZ/ns=@vger.kernel.org, AJvYcCX49vySZ8rKjoziDGszeUg3WWu+IC/qNq8DyQu+KxGwHl2klAkfp6gaPQLSo8fjJT7A9vtYQAiYvn+ax5y4@vger.kernel.org, AJvYcCXyI5xBdsmTyIv6eNAiUCzWqeGVaaHmWopJymg//nf1kh63zOKg4YNyxbnYy6nbcDYhwGA6B+XVtIFE@vger.kernel.org
X-Gm-Message-State: AOJu0YwUKdViIhf/9KAU6bK6QnzPBvaWwZ6J5OaiYxAL6HU0psQHVDh0
	vKsnFLYmvJFe1G26cFC0csb/IbwCMVU/u4fzFLDjN36HDDUPvxqbbFL1
X-Gm-Gg: ASbGncsYGBF75rlcPmOM5/UcON2LOWD7LY9LshojP/49RBzAcC5z9wnjq4WgAakMR/e
	JuUuuC4RYg6GsTyAyQKwFt9YimrGW9tU/SyM9rmE/Gdeb3FNJ5FsYeV9U+qKDsnU1RBQoSkAy34
	4LzYjY9VF5H1OfgMZF7FuVhjoxLyH/31tEqLwz6oJEbYOWnmwT3j4saLiC3KuQk5HkI/4neOjuk
	XJteGhm5flOr9e/qntiVGcG5a3jMIzqFaTiiHt/GiC6yQb0ko3QWFKwD2WanWx/LKkOe9A1s56Y
	6MVOn6tkYCy5eR6yxHcNAQ8CZOGxoPCQqqRldNmOtyGpXbsDBYiP1dq/fK+LhJAottpAaSY4a1P
	uIQ3LtTkSHRhALGjiZDXKBw==
X-Google-Smtp-Source: AGHT+IHnQP6hEToES8acCUU9ioSjSRksNxCFPn6G2r1nShG2g3RM1aNP8gFFDcU2rpF4DIC0srxIMQ==
X-Received: by 2002:a05:600c:4fcd:b0:43b:c0fa:f9bf with SMTP id 5b1f17b1804b1-44c919e1fa0mr2077675e9.3.1748039757035;
        Fri, 23 May 2025 15:35:57 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29672sm165202375e9.3.2025.05.23.15.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 15:35:56 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/12] iio: accel: adxl313: add function to enable measurement
Date: Fri, 23 May 2025 22:35:16 +0000
Message-Id: <20250523223523.35218-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250523223523.35218-1-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function to enable measurement. The data-sheet recomments turning of
measurement while modifying certain config registers. This is a preparatory
step.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |  3 +--
 drivers/iio/accel/adxl313_core.c | 10 +++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index fc937bdf83b6..9bf2facdbf87 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -36,8 +36,7 @@
 #define ADXL313_RATE_MSK		GENMASK(3, 0)
 #define ADXL313_RATE_BASE		6
 
-#define ADXL313_POWER_CTL_MSK		GENMASK(3, 2)
-#define ADXL313_MEASUREMENT_MODE	BIT(3)
+#define ADXL313_POWER_CTL_MSK		BIT(3)
 
 #define ADXL313_RANGE_MSK		GENMASK(1, 0)
 #define ADXL313_RANGE_MAX		3
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 0c893c286017..6170c9daa30f 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -63,6 +63,12 @@ bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
 }
 EXPORT_SYMBOL_NS_GPL(adxl313_is_volatile_reg, "IIO_ADXL313");
 
+static int adxl313_set_measure_en(struct adxl313_data *data, bool en)
+{
+	return regmap_assign_bits(data->regmap, ADXL313_REG_POWER_CTL,
+				  ADXL313_POWER_CTL_MSK, en);
+}
+
 static int adxl312_check_id(struct device *dev,
 			    struct adxl313_data *data)
 {
@@ -410,9 +416,7 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
 	}
 
 	/* Enables measurement mode */
-	return regmap_update_bits(data->regmap, ADXL313_REG_POWER_CTL,
-				  ADXL313_POWER_CTL_MSK,
-				  ADXL313_MEASUREMENT_MODE);
+	return adxl313_set_measure_en(data, true);
 }
 
 /**
-- 
2.39.5


