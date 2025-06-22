Return-Path: <linux-iio+bounces-20875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D14AE3097
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 17:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7043B14FF
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 15:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389FE1F428F;
	Sun, 22 Jun 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL9Rc4Cz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1AAC2E0;
	Sun, 22 Jun 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750607420; cv=none; b=AFcLm0dz+VEuDvqAI5YqYRkNlAYFVynTLtGp9J6VkCARxEY41r7jowCgefq1s9CJvatsWBcd2gC9xbRclrakaa/gS3j6ulCXsryjnsSpcUfq7Gh3zJjOhSkAU23Wgwl9qBjy3pBdheX2zrHDkxQ+icVHBLGwdWEqJZBkscipFFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750607420; c=relaxed/simple;
	bh=8JgwxSBZXFoj3NKhuJ2CDWykIX5RT2GyeWaZPnsk7O0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=utDQjscosSDtygMqPmD8Wy++00y+JuivZK9drR6Fo4wvFyVPpNX/1gjpFrTBb+pu13AlLfuGmdd3wiSxDjEJsA+zaBIzpDXRHPXyaW25iQGYG+CLpxe15xjI4g1gFb0JThPt7CKfaBvzLYtjuVRi3BelGQ0FHrqd+rJGeIDftKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nL9Rc4Cz; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6089c0d376eso857298a12.2;
        Sun, 22 Jun 2025 08:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750607415; x=1751212215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsk3ey7Q/lVDjbcoHhjW9BfkWYV4mX2YlldODKWQEY8=;
        b=nL9Rc4CzK1m+C45BreyRtGKHb+XZ+Kqc5io0ng+FOlNDCgWwYkHgUJb/0vZlymOozY
         kUB8GhWL8nRJuDkvpd2GfHoS1QT/ypR4iY04jN4fk4ppooqne7GteTBW+xUJ6VEkVtYh
         Md3Sj0uGffu0W5cjSIltEmCNV+jmZHyCw+HFsMRqAg8M6GAmBRTRk6K+4SyMN4PqXL5b
         Zj639Cn5auMeccGgaezZldB6Phvkq1YstjEmI9ByW/fJ6tPULKvjxGVW3ZGN0NIvgZGP
         viKadH3ANM+p9Wn9HsBoG7PiMIgpTUC1KVEb+iQFmPeqJRpDhnixAFfyd+F+zwMNoafs
         dWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750607415; x=1751212215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsk3ey7Q/lVDjbcoHhjW9BfkWYV4mX2YlldODKWQEY8=;
        b=p/q0u9a9jbBfOTragoYL/EUTJimM3go/8plA4KJwaWsRei1qSHdLu7eKtSJ5zjYHld
         KMWYWKvH/V2u6KJXVZTxbcsM0BCwghTsKZwdc37FfSnOChJtPGOadhZ/f7uoVEgu9kaJ
         LxYu3cIzffLB2moNdMfjlnDiJBm2FYccr6agsgfoVSdOpwz+lytBtOXkG9jJqlGlJJMI
         s0AOyUTH5cIPAI9wVwk/mfbCg3gee3o2EKasPRoM2Pmkoe7LlmNDM/XwB4zybwag55vZ
         0sk8yY8tyj8y97+Unqkb/H8896JFTfqhibWIQPAhnzFcMDSDFwKEiIQB3CrGAl93Wfjg
         nMyw==
X-Forwarded-Encrypted: i=1; AJvYcCVS70Cx/paO6FNMeWQCnD9EBxzJpp4Tp42OXp74K3E22asCikUTlaGRSVmZ9BvZ6y4G2xiUF1k+42KZv0Sj@vger.kernel.org, AJvYcCXYWy76dx5FEQFXXtWsY6cediz0y/F6s+LOSSsX1HbjjB4RerallFtyyhto+MSLZ/095x/UKreaoJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQko+HYMBqIEtXF7Zhn27HwlTJ+x+/AsLAFjpDrpoLWHN5NeJN
	nrp89YZi280Q3XXF2ea7VW3dNPV/x6Hnd2gD+COIGmZ0EZOh3sfsCJW6
X-Gm-Gg: ASbGnct6V61A6ajpr7LwIR0l10i6BZfhoYPgcCvJ2PUrxZurG8uc0dSYt2Szn5chJ2I
	VAtTYcYVGgWtLpRWR6x5F3AZjMTxOaIjn0FE6JbYw+V/6y9Xsc5Ng4w/DK9vzASlJT74h0z3yW+
	nY6zJsRJi7B5X0Al8Kgd6hBem+4uHAVJ9HPoth7aYfVmursdhMC/t8BRqNU5iYktSFbosewTpC8
	k9t/ADp/YYqesGgC4rlhzCQ+LvpH2MlpOghGxcH4q63o8w3WtAfEeli+FhSXEODSecwahcS61eq
	//ElxkDoAPPJnBW+MeJ5QMIyUk2Ld/JVX89sQHviw9m4EalMqSoxn+foV7ByA5er3WZO+OAkfKs
	uO/9NJ7vd5IHZksI7Fd4ztFRF2H5Dt7A+
X-Google-Smtp-Source: AGHT+IFtNx686irHeTeBPbDd+cvGF6IAP7Iwv96BOYOicP1ZCv4uXs0KBIuWcz9X+yX+ovofEEJldw==
X-Received: by 2002:a17:906:dc8d:b0:ade:7f2:a17b with SMTP id a640c23a62f3a-ae0578e0010mr310317966b.4.1750607415215;
        Sun, 22 Jun 2025 08:50:15 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ecbd9esm552781966b.38.2025.06.22.08.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 08:50:14 -0700 (PDT)
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
Subject: [PATCH v10 1/7] iio: accel: adxl345: simplify interrupt mapping
Date: Sun, 22 Jun 2025 15:50:04 +0000
Message-Id: <20250622155010.164451-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622155010.164451-1-l.rubusch@gmail.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the sensor interrupt mapping by utilizing regmap_assign_bits(),
which accepts a boolean value directly. Introduce a helper function to
streamline the identification of the configured interrupt line pin. Also,
use identifiers from units.h to represent the full 8-bit register when
setting bits.

This is a purely refactoring change and does not affect functionality.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 34 +++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index b60794812738..6c493272a5b0 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -1088,6 +1088,19 @@ static const struct iio_info adxl345_info = {
 	.hwfifo_set_watermark = adxl345_set_watermark,
 };
 
+static int _get_int_line(struct device *dev, int *irq)
+{
+	*irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
+	if (*irq > 0)
+		return ADXL345_INT1;
+
+	*irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
+	if (*irq > 0)
+		return ADXL345_INT2;
+
+	return ADXL345_INT_NONE;
+}
+
 /**
  * adxl345_core_probe() - Probe and setup for the accelerometer.
  * @dev:	Driver model representation of the device
@@ -1203,23 +1216,16 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return ret;
 
-	irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
-	if (irq < 0) {
-		intio = ADXL345_INT2;
-		irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
-		if (irq < 0)
-			intio = ADXL345_INT_NONE;
-	}
-
+	intio = _get_int_line(dev, &irq);
 	if (intio != ADXL345_INT_NONE) {
 		/*
-		 * Any bits set to 0 in the INT map register send their respective
-		 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
-		 * interrupts to the INT2 pin. The intio shall convert this accordingly.
+		 * In the INT map register, bits set to 0 route their
+		 * corresponding interrupts to the INT1 pin, while bits set to 1
+		 * route them to the INT2 pin. The intio should handle this
+		 * mapping accordingly.
 		 */
-		regval = intio ? 0xff : 0;
-
-		ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, regval);
+		ret = regmap_assign_bits(st->regmap, ADXL345_REG_INT_MAP,
+					 U8_MAX, intio);
 		if (ret)
 			return ret;
 
-- 
2.39.5


