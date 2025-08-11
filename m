Return-Path: <linux-iio+bounces-22590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAE0B212A3
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 18:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8777AED5D
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 16:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA502BE637;
	Mon, 11 Aug 2025 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewtr+5PJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E96296BD7;
	Mon, 11 Aug 2025 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931430; cv=none; b=I0yDShs2kopJLrTOa3jB9b7Vd+k0BlCJHuAdvTeJR/bSX2mNCufIg1ucwook0Po18wlIbvfopq5ebP1uwG3Nftn9pOveu5PlDZhPcI/C1MXuBU2MYjMUNvnVkmOLapoMTN24l5+vXrB3RDOI+z3Z8f9XevY5YyfAEun14aZMGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931430; c=relaxed/simple;
	bh=9zPnPHkgpiU4tEsuYcbnxA/jyHS4x3gGPa24HIh889k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UpLZL4HeYbOQWUFwAK5urKvCFfK6bapigV7kuQ+7HYePxMFGcncrUi6rVQmPMTX/fCYcHw07f7MPYa5qC18AuJ1/xkIAJ/WsqS/JELZLhe9V2GbbDRlVY/7LfCV0r7+iIcSBi1i0kU60dSor9WRgIXLcudgstBfZS+pjjD3XU6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewtr+5PJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2406fe901fcso47864745ad.3;
        Mon, 11 Aug 2025 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754931428; x=1755536228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W1Yi7C8gEQP4bWpuAGELa858nfVqle4iUeljO1dFUIw=;
        b=ewtr+5PJPdit4yk3D9ruK+QSIWKE1EIXZ+oNwfA76CySGSiyUqF2krwpsnNOpNboLv
         l3D2vplqkdlM6kwD1Iz6CZr+mjQc84UhmwDSba4qA+MwuO9i3WjVJ5bhDIrkB08WUghL
         Y1WcnlylZzUKPAcdtIgfj7I/VywIpMH+TN8oIJopR+7g2fN4U1fdnd7GqH0ioXFZ5SGP
         cphmDqzUpQiXcG1dS2rQ/LCks5h1axbcJJqkqipzB3BSvrv4fhoIAnOske+5f8q23XDb
         l38bIo1sliaPegrh3ydRjCGISnz2Vh4axXg/GWno63426q+dVfroPt/50OzbpOu66oxN
         /4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754931428; x=1755536228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1Yi7C8gEQP4bWpuAGELa858nfVqle4iUeljO1dFUIw=;
        b=JEBPNqppqGHWUGeE6KLWRHJwjoYtCz751vckr9ttuSlaz4L2Ei9VfdcGiFanMvxsPX
         48yHP6MAs95tuLXCsZCzULu2SjrTCVKdO49sge+FbZiDNweVPyBWz3Anw3OwdE5hGpIA
         MxTK9osKhjdkZcDsKPCtP7Xpjfx8rQXKoQetBtTfuZwB2jKmFurOrdUXFHBaqP3dS8ep
         aod6ktVR+MsaIzr1QZ0IQwtiQEvQYmpux48cMl+Ixe0FloCEBv2EOgSmzfhdBjjva/MJ
         oEL4RympFxg4FsSIasWy/OcUTiyb8cEBvfxrAZaH4jOfX2/o1512G5ssI1+59pe860m8
         9QUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnLEIXxeH36FFPi29wO2/0qx7dpD+Xo1oTQElxWSpVyfBrhFjK05j4Pax+6HsveSYSy3APPidxVns=@vger.kernel.org, AJvYcCVvLhfFoWUXsTDaPnToC9s0ktkK/ChZP2V9pSSuUvg2C+gtdjXX1JZNdDXSARou43CxuMA3wevII2WLl1l5@vger.kernel.org
X-Gm-Message-State: AOJu0YyipXIUgBtDkeo+JbxWiqTg/m8D28veFSDHYcJ5thNQC7Pa+oAD
	F2W4irE9T+/bzyOviMBidxa5ohF7yypQs+Oz2/3jneIHcka76QKz3wMW
X-Gm-Gg: ASbGncvOIuYtzSBMON097JQ7agEKxRDHL1GcIaZnVk+sinYjdcwvf8hQFTAeD5aHAvW
	rTyNUCuDCtXzt1KWl/mOst0NZOVrTb00VxkIaSJ8mn9o8ijbdx4wQ7aJ+jn2fUWRaXEevNY31lT
	HAbOAfbBiVuYsA3ZuzuuklRDEMh4RqkLUkXHel8wWneXau3e07OHFEFQ6KJSLo7iol7U8RVlTFb
	m7+04N45BfgNjEx4cMvgzcL1904C+yMhCuwQcymtTeFhL7ORe1oXcs6d981gPIqoKzaPcfFi9I/
	gBW+opcgMoYQj2pPC/AWA9squaIVWW3kAYx7pYV3u5SNBdrw0d7lE16g0xKciq3O79+Eb1mqNJ8
	U4bx2boUGzhZ/rvjIevCjfRH0jC5qzWF5wVeu
X-Google-Smtp-Source: AGHT+IEkqrWoNzQeigT/AEoxekcMwPOO3clsp9fVXxpzh+JPN0nMFS0LQhGp/ytq+YFsSTqg1y1bFQ==
X-Received: by 2002:a17:902:fc8f:b0:242:b42b:1335 with SMTP id d9443c01a7336-242c2059ca6mr223948205ad.22.1754931428119;
        Mon, 11 Aug 2025 09:57:08 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3a:31cb:81d4:471d:6f8e:380b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89a6ec2sm277124085ad.145.2025.08.11.09.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:57:07 -0700 (PDT)
From: Akshay Bansod <akbansd@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
Date: Mon, 11 Aug 2025 22:26:40 +0530
Message-ID: <20250811165641.1214347-1-akbansd@gmail.com>
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

changes in v4:
- reformatted as per sugessions, used ternary operator
- Link to v3: https://lore.kernel.org/linux-iio/20250723141359.11723-1-akbansd@gmail.com/

changes in v3:
- Use `sysfs_emit_at(buf, len - 1, "\n")` instead of directly modifying `buf[len - 1]`
  for newline termination, aligning with `sysfs_emit_at()` usage.
- Link to v2: https://lore.kernel.org/linux-iio/20250703053900.36530-1-akbansd@gmail.com/

changes in v2:
- Fixed indentation for line wrap
- Link to v1: https://lore.kernel.org/linux-iio/20250702135855.59955-1-akbansd@gmail.com/

Testing:
- Built the driver (`st_lsm6dsx_i2c`) as a module.
- Tested using `i2c-stub` to mock the device.
- Verified that reading sysfs attributes like `sampling_frequency_available`
  works correctly and shows no change in functionality.
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c65ad4982..d8cb4b021 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2035,10 +2035,10 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev,
 
 	odr_table = &sensor->hw->settings->odr_table[sensor->id];
 	for (i = 0; i < odr_table->odr_len; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
-				 odr_table->odr_avl[i].milli_hz / 1000,
-				 odr_table->odr_avl[i].milli_hz % 1000);
-	buf[len - 1] = '\n';
+	     len += sysfs_emit_at(buf, len, "%d.%03d%c",
+				  odr_table->odr_avl[i].milli_hz / 1000,
+				  odr_table->odr_avl[i].milli_hz % 1000,
+				  (i == odr_table->odr_len - 1) ? '\n' : ' ');
 
 	return len;
 }
@@ -2054,9 +2054,9 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *dev,
 
 	fs_table = &hw->settings->fs_table[sensor->id];
 	for (i = 0; i < fs_table->fs_len; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
-				 fs_table->fs_avl[i].gain);
-	buf[len - 1] = '\n';
+	     len += sysfs_emit_at(buf, len, "0.%09u%c",
+				  fs_table->fs_avl[i].gain,
+				  (i == fs_table->fs_len - 1) ? '\n' : ' ');
 
 	return len;
 }
-- 
2.49.0


