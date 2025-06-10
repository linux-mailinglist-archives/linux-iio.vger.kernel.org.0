Return-Path: <linux-iio+bounces-20389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E9FAD4554
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 00:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0781899662
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B5428850C;
	Tue, 10 Jun 2025 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRcal9Ye"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A345C286D62;
	Tue, 10 Jun 2025 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592789; cv=none; b=MdU8mij5lvwbcqfCrV5leH5+cPOPL2LcFtJH9beDeYyGiUl69O4OCfOA1iYaFz11OepheGtVhzDuLbnU/ArATo+nrIJQJ1kliTpG+Mrl6v2NgfAvfcvVmpI2WkKpVQFkFO1u5Q+3Icc5Jd7NO300p+D4Wz/+LL87s+Hy/HMj2XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592789; c=relaxed/simple;
	bh=ix3pF4nDjDULKTSRXDO4PMOHHFtggSVSx9q/iho6mEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3BJgqtb9YgQkEcuquKNwUHJ8o9E7hOn+QPRRhqiZCl9FY/cOFoT5RMdFpznqtWD/M870hT7qyETFaZtx2i06G2hmU1uwFzcbFWAUiT265AeUvtmxCVsjv3N7Ybql1sTfm2ntS5hOlYTd01WPxv68++mzBzU6cBa33cJEcLKhM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRcal9Ye; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4ebbfb18fso528355f8f.3;
        Tue, 10 Jun 2025 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749592786; x=1750197586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZihwrESiDdk0o7BFmuednPt2Ppfv/QodaVRhK+kps8=;
        b=FRcal9Ye0jtIBdLY9elEVK1QIYhQej8JjpKwoWM+sfhjgWcSIDVTod/q5bvdwh8BWh
         xPeqWZm7dvcTW23qJqoILLvQQd7gH8Vjkkmrl82Nt2KDNyHc4LSGL8pObiR9ktLYYcNC
         yvkIUvERmE+cyQ1zfRbZWVrrN42qThsrima28QEWHtE66NSlSZ9VDPJJMQjVjrCmacIu
         CfBJCnNlPsmBUgMvG62mL/uVGGQUi6o/XOKiIx40165/dqexajDZbhc6iRBacJVWmC9K
         gHUtaNG+Mx3REIcXjPrmW+v5L59Y64rNPbZPkXvpz4DCdgYQvrroketAcyxVM+ncY72w
         KTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749592786; x=1750197586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZihwrESiDdk0o7BFmuednPt2Ppfv/QodaVRhK+kps8=;
        b=MJhKptXc1Kl3m65Fj4Uj3UDUBHwPofSVh3TOXVa4Kt/TgPe8I1/6Y4DPvAVVStyk3P
         cOFMU1RDAVaK6SUzgqEYrOdBdR2oOrCBUTu1qi2hkBETVJdmkxX4pvJOi+Xo1UJ2TV6M
         ix5IVRNm1VrwAnR0e58uKoOynu1ShCXV6Z3Hxoh8GKYdvaGjqCAH35v1G5gW9P05k8hZ
         MbeQGGJDnqoJReycaHFOkbVYs8YTsxeTn7+WSBi6hgksCYUjxIYiAwFAmhP+tTtjHhUN
         4MR4pz2qNncdS8leDzfacWnV1PvBEailAvpDL9mghmpgdTAIidUwoI6ug8Z1TTRwEvtr
         o4zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK16JNYMcFU6Au2BFdTME5zAfRrOx0HthcG1nPaLrUxCQDQS0CMRp1DTkHd0GXa733+VI9IcBeH8o=@vger.kernel.org, AJvYcCVfJx1p9rlcvMGt4CsePXTZymQLUrUUXgn7DWq4xVmtW6b7qdJyMyYwHQ4siL5/djgXKLvKzYlfTBTzIL5w@vger.kernel.org
X-Gm-Message-State: AOJu0YwHckA6l0QhSxM9zkl8Vo/AobE5zmFENpIcP3+Uz4rJKugI41Lw
	Ce63XlT2YgRy90rg/89ahym0lWaQTseDtFZBm83xYK82xjQOOHd7mT+q
X-Gm-Gg: ASbGncuPr1NW2XUgBAGRHjT8FO3vwuBm0t5Xb7Y1A9Exnw6qqVGVeK0UUtOlW1Ue7OO
	/EpD/uyS8RePrRG6Q+K9PylwUWII9oh6oEf/t0wiq3gV6ybyA+U7V402/2LIazw1XEfCtA3ODjS
	0nc1My+qOcRqeVXHXyAAHTugMHBGIx4zE6ct1K+KNoGRa+Ce9Eg/pK8h+W4ZAFlzZMLAXqjtCwJ
	gnop5tEAb33KpteG9cWjmYwR8zNayroFMFcNmLcFP7P95Il7VNr09ej0DQMRw6w4bv5VN6sgyi2
	fquBtGpjcCxwz3G+yz69P5QuNi6AhPl/AxKd2v5oHxPh+ycYA+G8L28BTV69g1gTrQB2RpN2jm/
	XsVb34rQNvFpyp+L28IPNdOutkmznVobF
X-Google-Smtp-Source: AGHT+IHemCnKV+zCoQj9ZCH0kIyA00khi+iNc6zWGNxAwyW8NoqG5fnpY+G85f+UPPqdY36d/eaz4g==
X-Received: by 2002:a05:6000:438a:b0:3a4:eed9:755b with SMTP id ffacd0b85a97d-3a5586c414dmr221554f8f.4.1749592785662;
        Tue, 10 Jun 2025 14:59:45 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f04dsm13312647f8f.73.2025.06.10.14.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:59:45 -0700 (PDT)
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
Subject: [PATCH v9 03/11] iio: accel: adxl345: simplify measure enable
Date: Tue, 10 Jun 2025 21:59:25 +0000
Message-Id: <20250610215933.84795-4-l.rubusch@gmail.com>
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

Simplify the function to enable or disable measurement. Replace the
separate decision logic and call to regmap_update_bits() by a single
call to regmap_assign_bits() taking a boolean argument directly.

This is a refactoring change and should not impact functionality.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      | 1 -
 drivers/iio/accel/adxl345_core.c | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 6c1f96406136..9385affdefe3 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -73,7 +73,6 @@
 #define ADXL345_BW_LOW_POWER		BIT(4)
 #define ADXL345_BASE_RATE_NANO_HZ	97656250LL
 
-#define ADXL345_POWER_CTL_STANDBY	0x00
 #define ADXL345_POWER_CTL_WAKEUP	GENMASK(1, 0)
 #define ADXL345_POWER_CTL_SLEEP	BIT(2)
 #define ADXL345_POWER_CTL_MEASURE	BIT(3)
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 07abab82d093..cae9e37e216f 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -233,9 +233,8 @@ EXPORT_SYMBOL_NS_GPL(adxl345_is_volatile_reg, "IIO_ADXL345");
  */
 static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 {
-	unsigned int val = en ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
-
-	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
+	return regmap_assign_bits(st->regmap, ADXL345_REG_POWER_CTL,
+				  ADXL345_POWER_CTL_MEASURE, en);
 }
 
 /* tap */
-- 
2.39.5


