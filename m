Return-Path: <linux-iio+bounces-20391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BBAAD4567
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 00:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214CA171C5A
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B730289802;
	Tue, 10 Jun 2025 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2rvy+pj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC58288C0C;
	Tue, 10 Jun 2025 21:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592792; cv=none; b=nN1tzJjsDbWjj399Ml5NKm70p0lQQdhAmGaB1nPjXg9jGvnJhmgzUoiLCIaDZ2wioJlgq8tq0S8cBeregB4IyDJpZyapWhELSztUS58KjRoHpovKCvbdGjyREB55Mk4eMyTq2QrKZXT7Vx0FlQYc6Uy9dKes/zOG7cCMrlSesvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592792; c=relaxed/simple;
	bh=54bn4lQ7mU/PAKH83cOXrL5Q+ZOVpicKVQAuJhn6SaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iq5XqcPl+nYvazWPz9+p6NRb7DlT7WkJ4bjx4HB56DNRA9l+sNZnXNO0A6fX3R0AhfMb4xEzqyNUwGm/9JqQ5VrXyTqA3EnA3uvJdwXlUPPlNra6/vKIvTnx9si8slkHjLWPVWruU3ML7gg7sMZ4+W8KGTFtDxbjhB3t7ZUHvFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2rvy+pj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a524caf77eso796639f8f.3;
        Tue, 10 Jun 2025 14:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749592789; x=1750197589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+p92P536pnFRq0gbfd6NRDeuq5jfHDQEUuWlYeMLe8=;
        b=M2rvy+pjLml4NhruD18O9uazM/E7flfTM8nc20CW4DoB+63nftXKui7kSwDg+WT2AE
         E49YSeRH4q4KRK0d78ZLbq5ogukOrn0qgEwXxR0R0ZqzrHh1NLBW7lOr7kVT2qVzv0qt
         qvVl7RWGyKBl6BVCV+NmJrJKbW6nzehSVi+70bVpFb5Z3llqw26fjUxdW/yczdsANgfM
         E1F9OhWWBgyk0VcdwSHeo6YlrnuNV3EYZj5QSpS5S056n2pQp6WBUt1tb4KwRqKOgnce
         iZ2DMvTMHYaOeUt2JuNtJ0BBF+9leAlh7vTHF1v8QavZ7EUAiXOt358xyWgLkhlJIXN/
         1zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749592789; x=1750197589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+p92P536pnFRq0gbfd6NRDeuq5jfHDQEUuWlYeMLe8=;
        b=MA+GFt4YROWrOUlEt3SA581hnkm7QVEXaXclBAZcHwcLqaXBlRmY36mMWMIYpIpCX+
         7Z5mDE/r7IGdVaHbrffkSQh/SE8aTt7O+1E8u3sIbPC+4Kzx4zgl2pQTqNkVhP/0+MgZ
         a3NWYL7K/+J+3YwrQhcXOMJUhyCqj8bbq6tRikKJdwbXEVW2F7MDJkgPa508tKFx1Qs9
         rhyi1fgW0EwYMmBrXMt0eag3FH2mP9cWFZjHmzSpczw8Z1talK584XD8GDEMYl3zingd
         EvMP6bz4nK4VIMKRc7i/dm8WqazUboFWr2TxZD/gTgcWF0z1Db3DxX5ST7QR/CYBuI08
         2FDg==
X-Forwarded-Encrypted: i=1; AJvYcCWq7B25sqZ9Xi0KvcWJSnHXx/t2kcckxBhEGD6jXwun4vxqoYIDfiSMSHhw1wF4qCFesPupTeTKJYE=@vger.kernel.org, AJvYcCXf9/g83Q9fgjbmKP/6nLi8i2Brc+sycShvbrupVV7nfCQiM1GX1PtqJ9Jd/wOqoXlMLLqAb1KAEJBxeWNV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/S4SEQL9qIEAdF//CY9yQ1jR9agTJaafMCS4uGhFWAtkJOx49
	/CaTombbYwNhBNi6PCjr/H8RVO4spnr9nELjTAvTy2PXjv4Ho/s2zj5W
X-Gm-Gg: ASbGncuzqFjOSnYp2LmnAG+yinXk2um1mRDHJdeLDcqVyUqcRWpBQ2+qNKqZMXVAaBK
	vfeN8bZtVefb6nqdXcaru0JUX9Zdn+G88qUq27mULN3VUIFwtGbhD/hKiktn0j1r0N2t3W/X3H3
	3gYjdDvkIC0RvnS+JVS5fhqTGX1YIsTioUBB2shw/KM4OZ1IVjOct7wiHscXHiwVSlD4qhdlLsG
	ddTXgKoQQ8L2IzQa25p88SmZjnDz/QFTuTN6mynfhpjbOI3V3fGnJ82W+yzd6FTTIQ6ZLErpfBt
	4S2v3fL0uSMoP/Mf3saD7enOWMWe9EAPMCg3lyu4YQJL9z38wiohwi8jvtY19BUwnJjIwLstFVY
	IxRDuICSQ9pHIgNoMyI4z0D1Rw6G7WK9E
X-Google-Smtp-Source: AGHT+IFzln4u1I7lP7661yh4U+ZYHN37VdTCF6E6HlOX5FAG1Dy9xh/dbtGtPsSNekH1Ye1JoMq5Sg==
X-Received: by 2002:a05:6000:1a8e:b0:3a4:f744:e019 with SMTP id ffacd0b85a97d-3a558a1f200mr168473f8f.16.1749592788963;
        Tue, 10 Jun 2025 14:59:48 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f04dsm13312647f8f.73.2025.06.10.14.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:59:48 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v9 05/11] iio: accel: adxl345: simplify reading the FIFO
Date: Tue, 10 Jun 2025 21:59:27 +0000
Message-Id: <20250610215933.84795-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610215933.84795-1-l.rubusch@gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bulk reading from the FIFO can be simplified. Remove unnecessary
variables and simplify reading sets of x-, y- and z-axis measurements.

This is a refactoring change and should not impact functionality.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 18c625d323ba..dcfbfe4cac0f 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -884,15 +884,13 @@ static int adxl345_get_samples(struct adxl345_state *st)
  */
 static int adxl345_fifo_transfer(struct adxl345_state *st, int samples)
 {
-	size_t count;
 	int i, ret = 0;
 
-	/* count is the 3x the fifo_buf element size, hence 6B */
-	count = sizeof(st->fifo_buf[0]) * ADXL345_DIRS;
 	for (i = 0; i < samples; i++) {
 		/* read 3x 2 byte elements from base address into next fifo_buf position */
 		ret = regmap_bulk_read(st->regmap, ADXL345_REG_XYZ_BASE,
-				       st->fifo_buf + (i * count / 2), count);
+				       st->fifo_buf + (i * ADXL345_DIRS),
+				       2 * ADXL345_DIRS);
 		if (ret)
 			return ret;
 
-- 
2.39.5


