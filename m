Return-Path: <linux-iio+bounces-19620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F155ABAFC4
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 13:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338181898473
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 11:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0426421B9CA;
	Sun, 18 May 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeKFdADx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6F821A955;
	Sun, 18 May 2025 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747566823; cv=none; b=VJyl6ol8JOvBCKvxp13chWQrnqsBdWLCFZlp/OiIpmR6fGHr3pI8nCcNWJKw/YH8fs4fqMdne7uTSUBVqkRq62EdmzL4oFZw3ZzFgkRu9GPy1wN87Y07DipuOvLIFr5sPhOpM5EpdD61C803hWQlok6R2TjiAdSvkIK9GG1S9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747566823; c=relaxed/simple;
	bh=PmJxDo9TiOpqEIT6q7Zx0RUsErYuI5OTsk7uxONCapg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GHHGvcBZ0FrxFJXKfW4gKsZHsZdl6EmLGuEUi7FQb4lIqKGSGLgsIIpsG0MhI8ZheKrsh2TOw4V8bfdJ7lIEcyOjSJsXyKh2rT5pGPoCfw++2ya9VpLwshPu06CMrX+tJ+t3t+41HtW0/G5Z+F4BvqPdqEixdPQ2icoX3tt2exg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeKFdADx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a364d442e0so243176f8f.2;
        Sun, 18 May 2025 04:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747566820; x=1748171620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YStK8Dtx9JjnBfpPsrheapl31u4kp0BLcubjEdMAHog=;
        b=KeKFdADx7NimA+CEefT+OeUhE3SkrpMrEj9ANbx/aXAQcbV0jpkJXfzFn/IFmEJxqf
         +X8dmJbGpMiN78o4bfm6Pvrkb18xEk9LzAgRqqfSLlZy9i0niNilJlX6btn6xAsl5v7u
         bYHFOyDvkQMdK+WGKvZTlbc9jA6kYOL5jM25nMQfSD8mERdj0j9aKYcsHIMLM+N+fA14
         Tblx6RkHiFP3KaMYZ/qJLpp5gxoxes3sDNk3+mE/0gqtz+DE/8hJDNruatm5Xx5WuPSL
         dBeh6VHTAckuqlUK51hvOgytxutkKemExq+TXs4Y7hG/R7RbLj65u+dHpC9kYqRNsudF
         6Wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747566820; x=1748171620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YStK8Dtx9JjnBfpPsrheapl31u4kp0BLcubjEdMAHog=;
        b=vMMnK4lx6wPb+ebl1u8uEZIJm4Z7itUKGMuHhHqlCuzNqcLZJ7xWOEOdw07g61Ey4O
         /hQeJaO6sYPF3kyXGkbn9YqM0SgfFNWYjQs1WEf7F8sRAE1P+Izcw2Ta/gFrxahj5rsF
         IKahxjZI1/ng7uw3pt9vSUbpPKH7ltKIvlrnEdYPD2WQk5xUkxcJhTiYdxUu4Qy2fW0D
         liFnpsPIUKfQalqxE5/IrtFeAqwpoX3OjV+axwJ+w/7slORUfAwp8fFuPFn2RQAdPhRQ
         YKP7DMYayv3zg1bviRjft2awLhv0e3IF4j43qXYmxBKTuwHst+AHC6fz6mLJifNjreCM
         2W/g==
X-Forwarded-Encrypted: i=1; AJvYcCVISRad4peMrAOuednjK8aJ2KhJJumK3ieAACSeSQzUnFHF8ZVAFGF6xTnngOsBSk5gT54XMJvR+N3WA9e0@vger.kernel.org, AJvYcCWo6ITjLuryRwmqY96Xc3q7QhIUJj9Auw9OgD4tj1+a4ILm8J6TyeZR/OBgRzLeM/cL1SR7DloM3aM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz48kCs9yqRzOBTaLzS5admTWhTOqnFUO9KCJkfWVGWOTybpHu
	nZ4TJszTIT5E0lsIof6Z/m/dNaRv5XXbUOcok7JhmTcp5gaVBQRmHa6l
X-Gm-Gg: ASbGncuW56f89ycL0hlK1h7XWYbDPjfIvhUx4WVyB8bYeo2ByboUDDFk7/IDOFflF8m
	waS5+C/QHKJm5V19ErImkn3eXWsY40pJXdxdf0srASbiVJPVnwX0gwMbTXDxWQKTNs2pXUOoDZi
	rRCrGlj8NG7ndQxDXJEUjK09mMEB+AcT/8XKeK1xx+F6BFm9igIFAm/FmIuEdNGWEd5CKK+x5fn
	T8PbzYnlC7uXX69wYBlYJsmQNHeZTD1ho2u2Q/hyo8aFkLJjAvLhejW0q4aYxiNpmXo3UyX1FAd
	m5Q4CW9yZtRNGNq1PZEM+IbdM9/c3o60hTtLjNPeoUHEU9HR+6BYsdee//KF+QoVZSlIqiaxuzv
	jLTBvBlkPw2jTurkhsSrWRA==
X-Google-Smtp-Source: AGHT+IEfd82sWBV8hdIaloU2Bh/nJb6GjQdqxEUbilkqNd2VHnuz9DcDBoqre2NbHhhuhB1nJYLusQ==
X-Received: by 2002:a05:600c:4f8e:b0:43b:cab3:1fd1 with SMTP id 5b1f17b1804b1-442fd60e89bmr26350745e9.1.1747566820090;
        Sun, 18 May 2025 04:13:40 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1dfsm9287446f8f.18.2025.05.18.04.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 04:13:39 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH v1 05/12] iio: accel: adxl313: add function to enable measurement
Date: Sun, 18 May 2025 11:13:14 +0000
Message-Id: <20250518111321.75226-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250518111321.75226-1-l.rubusch@gmail.com>
References: <20250518111321.75226-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl313.h      |  3 ++-
 drivers/iio/accel/adxl313_core.c | 12 +++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index fc937bdf83b6..ba5b5d53a0ea 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -36,8 +36,9 @@
 #define ADXL313_RATE_MSK		GENMASK(3, 0)
 #define ADXL313_RATE_BASE		6
 
-#define ADXL313_POWER_CTL_MSK		GENMASK(3, 2)
+#define ADXL313_POWER_CTL_MSK		BIT(3)
 #define ADXL313_MEASUREMENT_MODE	BIT(3)
+#define ADXL313_MEASUREMENT_STANDBY	0x00
 
 #define ADXL313_RANGE_MSK		GENMASK(1, 0)
 #define ADXL313_RANGE_MAX		3
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 6e0c5704e333..244fb2ec0b79 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -63,6 +63,14 @@ bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
 }
 EXPORT_SYMBOL_NS_GPL(adxl313_is_volatile_reg, "IIO_ADXL313");
 
+static int adxl313_set_measure_en(struct adxl313_data *data, bool en)
+{
+	unsigned int val = en ? ADXL313_MEASUREMENT_MODE : ADXL313_MEASUREMENT_STANDBY;
+
+	return regmap_update_bits(data->regmap, ADXL313_REG_POWER_CTL,
+				  ADXL313_POWER_CTL_MSK, val);
+}
+
 static int adxl312_check_id(struct device *dev,
 			    struct adxl313_data *data)
 {
@@ -410,9 +418,7 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
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


