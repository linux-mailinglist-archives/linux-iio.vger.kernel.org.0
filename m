Return-Path: <linux-iio+bounces-21906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708A0B0F504
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 16:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC04582AE4
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 14:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6825E2E88A5;
	Wed, 23 Jul 2025 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+nA1J2C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E2E2E54A1;
	Wed, 23 Jul 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280053; cv=none; b=WHxqMQmb9lrwm2YfzuQbWPS9aM/s9aVZMY0bp1vF67n1pP1fFFMrd2L+cNVaHxUjBVaeL7XPak+6dslCWRRIYpLDjc/b4IyRAGCEvle26a3Tu9OOP/axxHdOthkaCj1PPvArTxQMJbKFnEBK7xcn9URZ+2IP4Jss1dEtMkpOJIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280053; c=relaxed/simple;
	bh=HGX2VLgyyt0GtxeLZpC1unio0AwmsC5hJT7R2JwR87U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ST/EMF1I9Prt5dwJ/4d1lbMn3Q2Iz4/eGx8xkeo8kqpmkiH4aJl/ym3aLxoEhqUtklcLNDLg++uf/FuykHrdCn63u6OLHKps1CgT8MgoAnaX0w0qrypb/qYfs5e5YEe2rclj3OZEVNzMl9eM48dC3ydv+ga/cjw/iP/iu9Fl5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+nA1J2C; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748e378ba4fso7887393b3a.1;
        Wed, 23 Jul 2025 07:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753280051; x=1753884851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGCHphQckRxgoSh5w4iIxG/Rjxd4ND4u2+j5qV3kR94=;
        b=E+nA1J2C9zDw5eCWa93hrNYk/1/zq45CoMTFtEUHkx0Rj3BZgZ4b9En6A8Lu1OBSYz
         8iI9Sihn+HlRz+RiKNo0qWtnqxdfgcJ0IJtFyV2A0+BSYIGTGAufUGUiJuyB1KuwzqjE
         VKmQEuD13FavC+T1NzJBp5O3Szh3bUriFp7ualOcc3Em7cYlymafChWga4sPcsgt/P1f
         OH6ag7TsmcH9Y779UeswqeGrbOWTxJPE46+ibVl6Dy67KT4ZTj5CQByvbAhp+VN19H5/
         lVKJATEhK2DHtaUNwOgZ0aD1Q1+w3jic/MLjRkEClPcmy2Jcv5/VFb9fnH9KxuqU8aeV
         e2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753280051; x=1753884851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGCHphQckRxgoSh5w4iIxG/Rjxd4ND4u2+j5qV3kR94=;
        b=Gmv+t+L666xHT2hw6wOLMaHJAhm5Fvzf7eV0+fFlVqqqREG3CykfKMauQY1XmEOpsx
         CQuRkNizbqbUfBNAlq4HRy+KtHIh6bMWirTsBljX4mmfd9KpFTBSDnaOUK8EAxXEJadU
         WfB5+wQCAy5vjtH2N0YeTycOVIRq3JFk3u25rlY5Q6dW7WdtxrOxMI3dCEUmEKHwtW/j
         EPKRqBs4hpCa5vs1JKKLx1+GijVljuLyhAHFEeqCWFHqyiErhZb9VUW+txq2zFqwDkCf
         Psx1FTDgPYvoGtNMEdA9B0HSlke5GgGd7vE60LRmDmc06Z7vc8t6TyDN9wORKt9G+vHw
         ZufQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcJhsizbAvyjS2YYYWh1a9kPJ/U6gDPqGJM9zJOqOHTVjl1FFvW/0kUX3H/uCX1ONY1JzDBF5+DLXFClkW@vger.kernel.org, AJvYcCX1CCnpdKnbBP2rsDUDAiAXXlV/uKwoeOfjON2NnW/sIariPJjnbf/mCnHwpU9of1gvRWI4LpiSH3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyGKpeQWtgAtzoFVusluKiyFH77eza0rG/CTHnkEIgXua0SHAs
	wgj1KYk92dj/JEHsvXGnxufpFK7Hh5ez32PfAD3D6vOgOPxYDBaS2a43
X-Gm-Gg: ASbGncu2oFbkwv8EkDeznh89vcSAW/PBsv4ihLvN3afbKfIYwUpym1kErhpeL0lxTOu
	G6JYX8P6nFA+JTkeuWYwh+mKJI154CeQ+1lLLfnIXfVfYZHVmfweIVtNq6P/b1KS0ivzmJfJf7k
	oZldRKLOxkSg/80Qr2uQCdXMu36osnFvnjuSFgXEpiLXSHo8pjP/XWuhvMIWc3vLhDc3R35WTWD
	7N381/R5XOYN3WlfLYkcPlJqwpJUZPQ1wT5wc4qE+xjRfafQZiPaAr6QpYIO4oWY8Jf2D8rktn4
	abAc9mWLW7WqlqbkPnO5BTxEqRnwlt972fpNz6NroerfmKS/SGN/Qq0oRH6531nWIm91oflbcbh
	zKhPSJS95mN0LM7cCzILQ4KW/BGJSZek=
X-Google-Smtp-Source: AGHT+IE4qt3w/6LB9AAk6kh3kI6NFSk1U9uQtp2nJwSH2r8ih8tpWOApCnByotT7eWt9IywTghyJwA==
X-Received: by 2002:a05:6a00:138f:b0:74e:ac15:10ff with SMTP id d2e1a72fcca58-76034c57330mr5352435b3a.4.1753280050818;
        Wed, 23 Jul 2025 07:14:10 -0700 (PDT)
Received: from localhost.localdomain ([103.49.233.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb154006sm9655287b3a.76.2025.07.23.07.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:14:10 -0700 (PDT)
From: Akshay Bansod <akbansd@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
Date: Wed, 23 Jul 2025 19:43:59 +0530
Message-ID: <20250723141359.11723-1-akbansd@gmail.com>
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
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c65ad4982..f0aab41f3 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2035,10 +2035,10 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev,
 
 	odr_table = &sensor->hw->settings->odr_table[sensor->id];
 	for (i = 0; i < odr_table->odr_len; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
-				 odr_table->odr_avl[i].milli_hz / 1000,
-				 odr_table->odr_avl[i].milli_hz % 1000);
-	buf[len - 1] = '\n';
+		len += sysfs_emit_at(buf, len, "%d.%03d ",
+				     odr_table->odr_avl[i].milli_hz / 1000,
+				     odr_table->odr_avl[i].milli_hz % 1000);
+	sysfs_emit_at(buf, len - 1, "\n");
 
 	return len;
 }
@@ -2054,9 +2054,10 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *dev,
 
 	fs_table = &hw->settings->fs_table[sensor->id];
 	for (i = 0; i < fs_table->fs_len; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
-				 fs_table->fs_avl[i].gain);
-	buf[len - 1] = '\n';
+		len += sysfs_emit_at(buf, len, "0.%09u ",
+				     fs_table->fs_avl[i].gain);
+
+	sysfs_emit_at(buf, len - 1, "\n");
 
 	return len;
 }
-- 
2.49.0


