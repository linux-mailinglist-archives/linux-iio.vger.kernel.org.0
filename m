Return-Path: <linux-iio+bounces-20755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC93DADE199
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 05:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080E9189A0D8
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 03:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D895A1D7E42;
	Wed, 18 Jun 2025 03:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6y93rDz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6941E570B;
	Wed, 18 Jun 2025 03:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750216659; cv=none; b=FmUgZ+NEja2PJhU5F1YZWlkalz67oY2IIebTr4u/gXD/4hVGRq1jRilDNsHj/Pmx+8fCa8dd5i7nUGlOkCIoaoiQCMuLLvgchDsKsqBCuFzc//DaUOMpk0hYvZzDbtUfdpoPzrBJUhudSXrsKaOahr0kCdIcKp0OhbOEC6w+rTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750216659; c=relaxed/simple;
	bh=frXSwGyAwc4d5PustjEWkRKMKwS0wTKpGhI/9vpq8RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nU6d8uJZWfIyFDwxLqpqohxc1TN3wkBas/xwHdl4xGaOq1S7T+Ji5EH13gvBWeiqPgpPnaUFkDfjsKMfac4GSabDsCu3h2mhRi+vGDD58SeLb9l0yKagA7QCQMZf345MHh9bkIyv6jgz5zmN6btomHQlx3V0bA0hytfQdSag7Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6y93rDz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23602481460so63371835ad.0;
        Tue, 17 Jun 2025 20:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750216657; x=1750821457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmGxDv3sNPfFZwxb3O8lpt0uVGYhHyGdSY0M4odFR0E=;
        b=U6y93rDzn46lNezgRat+FonPqT7/eN7UIQ/0kehPUgsw0zoEJ+Gmb1BfBmN1NU32rA
         cCDap6WxTFxX8wjE6gBGdoyZtILjJpmxlus3NUyxNXtPNByrl0Htw/cYpyaAReY8Muqv
         F1kceEzpCPJuZxr93vvUKHosJj7bD+1cb+2lF1DALVeLkQBCZ8S/uBIBIBDpxPeF8QCd
         Kt91k11DRsIeb33966iLbcla6k2OYnMJSaxCUpwUHdNpyZdTD3aLW41YN8PkbvvD+h5n
         8Q4iv7pUvtF4jNofGYUlVwTlHInuXjbwoNP23X1cNKcryzDCr+rMyCItuAXe2D5CbV45
         ef8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750216657; x=1750821457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmGxDv3sNPfFZwxb3O8lpt0uVGYhHyGdSY0M4odFR0E=;
        b=SGCeFWLXwu4n+HnuCM1oVrSDEKkk1wNQ/k7YaWLNevJ8sx+F/SJnpAtgOopktpJgtv
         LpfSeJiCj7SP3lxYZ3sI0z533h0jN6JiPuIxyTBvEn5aqV92ELe3ZB8l3UcNkiqLG65p
         F7Z1RHO9bTnIGPUc1gnJgJOnOw+GjqZTjI6kNvUdWuUqJgsY5QCik0H/luFqq3VHsll0
         6SBh0kVK74NYcGL//4pTm0ylA/buVEsagiORAr6MyMQp+i9QCtsIHwlDEvNtIhAZ/0s7
         OJB7MxikNOtjLrbXjDYa9A2axRR1ok5efA8CdR97M4hEgphftXsp55EeP95VnE/Lvr5Q
         K7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/AHwEgCmYqM1NuExrY50uieGWWHkykPJoG9zqGjHweuTwhSHg0j42FVruNXx/hx75k9LLLYBwIns=@vger.kernel.org, AJvYcCWG+yrNYsVUtTQhcg2QmIvnrO1NXHUGISlzx9+Kil7N7AjfR09XbKraNMLXA04Va2VBNGq3A+1zqTFyXgJd@vger.kernel.org
X-Gm-Message-State: AOJu0YyUH/I3kz864h9mLpCVVDuC3K0WeCn0basHsMuElyUa96nV423X
	vyh2Qgbe6ka91bdkZZMFf1IUlRS24UW0yh+aq0Cf7GCvsCaPrJ83HyEH
X-Gm-Gg: ASbGncuwMYy9Fmm+2875Gf9NAFBDsx35jpVZ9z6A8fRZuYv/cpkhv0gmYULLcBbQZjF
	T8o+bz5D0YVLjy+r/8ECUhNbdTm+Qyjsqrit2M+W725rKZAFWTmnTGdUDRa/qIDN2m7JLkDZcAx
	4KyKml6HfFS1kqpOMPAPx0BB2QbgKq4qJADPEFNiQVSp1h/NrbULlzO66Q49ujkwXbnxX9QQncW
	h3hFKWS9tdAGfa8oZQ8Xtfy9ds5bGqlV+xNyHhakSyxZv3wmXSxWJ72SErVqV8Dcj8PQ9bN7SYo
	uKLfuWjJZg7uPduEZjDX8J902gyjnVA8XduwIH8qZKYNlkLqm1hnzFqa1LNodOUi2Q==
X-Google-Smtp-Source: AGHT+IEnOivJGUDWqVyOIV9MXtZf3Bc3o1rhJEC9EwSqChNJtE1AmlhKQp6mD4GytzYsZ/GtITfOGg==
X-Received: by 2002:a17:902:f68e:b0:234:cf24:3be8 with SMTP id d9443c01a7336-2366b12f541mr264432915ad.28.1750216657570;
        Tue, 17 Jun 2025 20:17:37 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:31:2ce1::1005])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dfdb9a0sm89179545ad.239.2025.06.17.20.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 20:17:37 -0700 (PDT)
From: Andrew Ijano <andrew.ijano@gmail.com>
X-Google-Original-From: Andrew Ijano <andrew.lopes@alumni.usp.br>
To: jic23@kernel.org
Cc: andrew.lopes@alumni.usp.br,
	gustavobastos@usp.br,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	jstephan@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] iio: accel: sca3000: use sysfs_emit_at() instead of sprintf()
Date: Wed, 18 Jun 2025 00:12:19 -0300
Message-ID: <20250618031638.26477-5-andrew.lopes@alumni.usp.br>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use sysfs_emit_at() instead of sprintf() for sysfs operations as
suggested in the documentation, since it is aware of PAGE_SIZE buffer.

Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/sca3000.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 058a2d67c91c..bc0046b19511 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -423,16 +423,16 @@ sca3000_show_available_3db_freqs(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct sca3000_state *st = iio_priv(indio_dev);
-	int len;
+	unsigned int len = 0;
 
-	len = sprintf(buf, "%d", st->info->measurement_mode_3db_freq);
+	len = sysfs_emit_at(buf, len, "%d", st->info->measurement_mode_3db_freq);
 	if (st->info->option_mode_1)
-		len += sprintf(buf + len, " %d",
+		len += sysfs_emit_at(buf, len, " %d",
 			       st->info->option_mode_1_3db_freq);
 	if (st->info->option_mode_2)
-		len += sprintf(buf + len, " %d",
+		len += sysfs_emit_at(buf, len, " %d",
 			       st->info->option_mode_2_3db_freq);
-	len += sprintf(buf + len, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
 
 	return len;
 }
@@ -783,7 +783,6 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct sca3000_state *st = iio_priv(indio_dev);
-	unsigned int len = 0;
 	int ret;
 
 	scoped_guard(mutex, &st->lock) {
@@ -794,25 +793,22 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
 
 	switch (ret & SCA3000_REG_MODE_MODE_MASK) {
 	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
-		len += sprintf(buf + len, "%d %d %d\n",
+		return sysfs_emit(buf, "%d %d %d\n",
 			       st->info->measurement_mode_freq,
 			       st->info->measurement_mode_freq / 2,
 			       st->info->measurement_mode_freq / 4);
-		break;
 	case SCA3000_REG_MODE_MEAS_MODE_OP_1:
-		len += sprintf(buf + len, "%d %d %d\n",
+		return sysfs_emit(buf, "%d %d %d\n",
 			       st->info->option_mode_1_freq,
 			       st->info->option_mode_1_freq / 2,
 			       st->info->option_mode_1_freq / 4);
-		break;
 	case SCA3000_REG_MODE_MEAS_MODE_OP_2:
-		len += sprintf(buf + len, "%d %d %d\n",
+		return sysfs_emit(buf, "%d %d %d\n",
 			       st->info->option_mode_2_freq,
 			       st->info->option_mode_2_freq / 2,
 			       st->info->option_mode_2_freq / 4);
-		break;
 	}
-	return len;
+	return 0;
 }
 
 /*
-- 
2.49.0


