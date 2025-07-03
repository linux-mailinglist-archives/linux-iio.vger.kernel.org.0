Return-Path: <linux-iio+bounces-21281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAF6AF69D5
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 07:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E071616A6B4
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 05:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C55A28F51A;
	Thu,  3 Jul 2025 05:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZfhQrLJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3D82DE716;
	Thu,  3 Jul 2025 05:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751521154; cv=none; b=DnnSWnA6vk0BR3T8uDLnbsl3hLehzSWThFKi9N4D5u0Mo0aFyups+TEiK2L7yKuWIHGdFQd3RAnU4AyxcWWsC3CTMfkzzTGBU0xaUMIvmfgt73VZiCcKa8jsP9xUpWivOv93ZA5fO60ND7x2lfQG+/EuLo7ybG4gCM6cPKsDZ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751521154; c=relaxed/simple;
	bh=voxJZHqltY56Ox9RRMfA577Eifwyg8mdiTW3GT0aRTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0QqRRGH6Q868d9SwPU8qF1lBlxrEBKtmm5uY2bVo+2/0U+XKsu19EaZOWUGCL2arbpr8fCbdMwFaeRwEJoru3GiFaJ+O87v8Sy5o4eZzzyH8vZorf6cklaJxsGt7Qmxepp1npjCeGCNdwuzLOoYzl9Swzuo9JcgKM9l0jVLGsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZfhQrLJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234b440afa7so77583165ad.0;
        Wed, 02 Jul 2025 22:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751521152; x=1752125952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0IrjhUcneeUdhM9TWLddICq65bCdlGpr1v8MgRUFY40=;
        b=XZfhQrLJuPX/Pgac0BXAzm6ep8wgdZfVSqm9H0XGBijE6WzWUZHiSaRRRPnQ5rNa+Q
         NVVpHvs8EjBQdLggA72fqXGfsMOW6VYI2aAvHoZD23RZ0uGKL1NaSEw3j7Jyr4EKx7Vn
         IYH9xzrVEpjdDGUkmmTmcMwBHcNDmWXvJbEjC9K4maQKEq/uVa8JZckZoKjjnAHRjnjL
         wXX7OZWaTwv+0GhzIXt+OtVjIVsv16aWAuNkfUMDrXlhWDev8iLlbSs7ihwGbyv9mXps
         TzzdpQdksia/yKllf/zqGfaqV3d/9I5OrwoauSArhlWyG18WSOkvitvmuwAjuiJkcPoT
         YTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751521152; x=1752125952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IrjhUcneeUdhM9TWLddICq65bCdlGpr1v8MgRUFY40=;
        b=NX1ayX+RaB/YgrrubqUzcTYWNeCPod5XUiILsDHuYHShgHB75akX602+X/He8pGFTE
         JdVo7EmW6Py2LNpB0/dr5I5fmydTa/MsSiWK00DipG/a+NLCchlek86csj/I75sUCLIC
         obxd2FIfeLKUb4OU3q8tp7l3cHL5iYGCPy4UJyipYP4LsGIxMF3XB8z2IXkZ0lPkWmMA
         nW9oUn2R3lL7r/j1xBgM8EaiEQDOn/9gkkr3yILJ3RunTBZK/Vv2P+LULGIPyLdw+5r/
         bhyDGNmTPW99NT9zy7oA1buCjwzIa/DsYXx1o/GYcpQRT3rx3wt/ex3R1DnPmMc3h8zA
         A1kQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1vaOsnHZ2rTp9oin7iWIQ+0mE8pB+nuq0JNW8s5GVPT2aPq3gqvKxmE78wqZ1tQaipMkEDEyI8FqqDCOP@vger.kernel.org, AJvYcCXmcPUm87gFu9h9t5ZVzA9hc5S+pyqx0RidQMMp0t+sqf3ibeRaOvC1AjZXFwaXBeAk/WJZw9tPDOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7AZOC1ZrIhnJ8rPh6B0Od5PSNeKgc+QAtcPzYV3MCs58bo6Jh
	EeuD0wJAtxDbmlc6EHOOVlM3mL6I21MH2hWO6obzWtzzOjQcsuX4V/Lc50TKkA==
X-Gm-Gg: ASbGncvw4pMEEduLU7f7RcSQoOs5yiin3HRN/yGpZb924z4lqgk9tzWUGnAcHAmgXok
	p9T5QpJFIez/B+Al7occc/4Wa9hi+3YlwvySrC8bc0PRzI2cxzT/Q+phvk2rEIOn7wNHu+RkmSZ
	2sjzR9sBoObxseevGlepVaem9XOOx1YmzX2qj2INesXbpJEmLsKxNEFX59nuf1b8N9/EaYwoXhL
	IHqfRPALaaOIfPe7T9+kvuQafLOo/AZ7NMHHuIzIZHqYrrA2QMQoVTaGf843b5YM928mdmUyoUv
	QC7yZqKGrxjcdWmhhV1wmYWF7dcSPGkqM1ED7pe/eqjDd6Kq3ZNmSmx6ExiszZvg9NSpoyk=
X-Google-Smtp-Source: AGHT+IHoh6t/sQ++4eoZ53OHZp5DSnQdMVsEROn6XefgxlvjoM2122L64NtRIINhq6KoVx3i32clcQ==
X-Received: by 2002:a17:902:db10:b0:236:15b7:62e8 with SMTP id d9443c01a7336-23c6e591e5bmr83382435ad.25.1751521151702;
        Wed, 02 Jul 2025 22:39:11 -0700 (PDT)
Received: from localhost.localdomain ([36.50.162.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f1d72sm153629405ad.66.2025.07.02.22.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 22:39:11 -0700 (PDT)
From: Akshay Bansod <akbansd@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
Date: Thu,  3 Jul 2025 11:08:59 +0530
Message-ID: <20250703053900.36530-1-akbansd@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the sysfs interface for sampling frequency and scale attributes.
Replace `scnprintf()` with `sysfs_emit_at()` which is PAGE_SIZE-aware
and recommended for use in sysfs.

Signed-off-by: Akshay Bansod <akbansd@gmail.com>
---
changes in v2:
- Fixed indentation for line wrap
- Link to v1: https://lore.kernel.org/linux-iio/20250702135855.59955-1-akbansd@gmail.com/

Testing:
- Built the driver (`st_lsm6dsx_i2c`) as a module.
- Tested using `i2c-stub` to mock the device.
- Verified that reading sysfs attributes like `sampling_frequency_available`
  works correctly and shows no change in functionality.


---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c65ad4982..7689ca39a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2035,9 +2035,9 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev,
 
 	odr_table = &sensor->hw->settings->odr_table[sensor->id];
 	for (i = 0; i < odr_table->odr_len; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
-				 odr_table->odr_avl[i].milli_hz / 1000,
-				 odr_table->odr_avl[i].milli_hz % 1000);
+		len += sysfs_emit_at(buf, len, "%d.%03d ",
+				     odr_table->odr_avl[i].milli_hz / 1000,
+				     odr_table->odr_avl[i].milli_hz % 1000);
 	buf[len - 1] = '\n';
 
 	return len;
@@ -2054,8 +2054,8 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *dev,
 
 	fs_table = &hw->settings->fs_table[sensor->id];
 	for (i = 0; i < fs_table->fs_len; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
-				 fs_table->fs_avl[i].gain);
+		len += sysfs_emit_at(buf, len, "0.%09u ",
+				     fs_table->fs_avl[i].gain);
 	buf[len - 1] = '\n';
 
 	return len;
-- 
2.49.0


