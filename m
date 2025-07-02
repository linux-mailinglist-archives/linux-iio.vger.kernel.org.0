Return-Path: <linux-iio+bounces-21238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AA5AF5A50
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 15:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B004A5244
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 13:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9039283FD9;
	Wed,  2 Jul 2025 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA+UVhQd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B9F275846;
	Wed,  2 Jul 2025 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464775; cv=none; b=mOYt07s4T2ujVL7wkqoQGt1/Jvj/CRI9NJJw1am4ZgKIXIooDmaf5ZNo2O6XdKlVu/mtVzvVsqcm2NmBbU+A3Ak4a7EaaVyXo9z5zBnHzjvIsYNeQmcbelcxv1URsesKPHPBNlDiQwaDX3+Q+/F8/pyvf3JMZl32LotcVQSP1/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464775; c=relaxed/simple;
	bh=+z/pyj4SUuWOCUUWNHIbttFGlxzh7+YiGzzHAMi1ArA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PyaXo9WDzdxFaWOYg7ifd88Egd9t39+nRdu3jApTehyoQLnW7QkmhGfJ3DKPToc5RqL9W/j92pyNHu/kycdJq3LqL8ZJD50QsQ2heC9frmNg3DELXEG5tBTyLVSVD0bxZ0XjaHuB2I3a5FALNxEoyUAihjV9JA3+BoP/Uu3zOc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MA+UVhQd; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-748feca4a61so2561499b3a.3;
        Wed, 02 Jul 2025 06:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751464773; x=1752069573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uG2cVUfdVKK+VnskBFnudLceDCCRLKIh6XoDBmMRx/Y=;
        b=MA+UVhQdEHlnNI3lQlYQMy69278oVDs6J/JeMutUp40HcpdNYau5s0sWFOnHIWyu9m
         S/0hu2vJKd1Gbnguk+qJi/c9tzLTSqyg4GUDPytsM0bdRTiBIBr2n/1ABontXG7t16Pw
         rOwF2aEBNq+VmgKu5anZ05JfoAQGKaNWfK9AnGqmyrP0vAy1AMK67Kt1g8v9FueoVBm6
         +w7kMKcsUKv92WBTlmw5EalhuoYGpXJtcS6QUjxJK4R8Bvf10l3YUmhe8/HTw1xFc3X/
         m7qbqhZAQJg7uqwGv70CfgkBU1BpRPkB0M+LgfM1ogT+6FB5Fkv5a2VO2+zARcvsPeBB
         Ss8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751464773; x=1752069573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uG2cVUfdVKK+VnskBFnudLceDCCRLKIh6XoDBmMRx/Y=;
        b=crOxM7OjM8moeTBXkbzLznYJjCpsMdq+25uqLjzILDSeY+MBOIdxIuuQ737cF6WyKI
         Vh3737wAKjhrTB2VXGqpXHQ+Z1+eOLIfNFEa9pM3myudM5PxWb6f5VV4HXT9awA+ukba
         GDzs/oGRsDIKFdwmHblx2lD778/6ojMiWfXzXOv6MXZ0QWSsh7xh0r6dPNROQka1AOve
         Huzdp0Q63boS8Y7wDNAGOhxyr2Z6ntTCGo8MoohaQwAnRk0Pub+JBwm2+TKDm14APvgT
         EH1D1DsifdpLssIjszgYcZ9KEfX25olFCexTQFwVtI64r9eWFEo9huCv5SASCVt86EI1
         caHA==
X-Forwarded-Encrypted: i=1; AJvYcCVfcA18rFLFGvtCINANtIsb+LacnYxmVBa1eZwfrhCD33wo9C9/u/YvcDIVl9Vu5sa8jpaMvvC8N8QfgdDc@vger.kernel.org, AJvYcCW9g2+whSc67hMM4KAMUPs+Cy1IPfzsQtdtD9b9UGfG5oxRFwuKeS2IkTOtNcjWwoSwBCrjqhZp3k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxIWez5TmpWUxUxOVkwCWoMlz/3MOh+M2t0lgUvXpOUBANDMq6
	9bDiF8dndET+Ir4Ii4E8k8rU+0A+rEeQGAbcSHzDFmhxYodGlC69D8FKm3YxQQ==
X-Gm-Gg: ASbGncv5S6yHZcq0vf92pd866AIq+Vu0esB7PE7r0gMdhTi+cb+4Tacc0RM4a5oZZfr
	5WplwiLxQsCyGwPUKVdsH1FfweG4InbabIw4ML3DGEmjRe4hki3DQig7IhxBY6skW7GGeg9Qpwt
	NvtANLir0/0nH8Ka3vX4XY/jtzCzUHUvvwhaKrLhB9qrxlFtya5IEKJ7ovxS3PfNyvaWenLLGzq
	qv0MgSTamemiuwCeSGAdyY9CpWM3Bdt/6dUHw4tVkfE8M+6m+FRBmju0RhmcyzQHRThuHbMCYLh
	WS+KoiWyXl4uBTYQ7S4OFEUGvCYxZAolUfFW9kwnTimzS5ntLgKZJbRuCNdNKUPQRx8kZHE=
X-Google-Smtp-Source: AGHT+IGoIJTyN7a6y/nAlqjM8UO2CTT19q+9ZhHui8cXpmy25QIZ9nb0qQ0kk3cJnPI4P2Bm/a0WuA==
X-Received: by 2002:a05:6a21:6b16:b0:21f:d0f6:13ba with SMTP id adf61e73a8af0-222d7dc4f84mr4825622637.1.1751464773339;
        Wed, 02 Jul 2025 06:59:33 -0700 (PDT)
Received: from localhost.localdomain ([36.50.162.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af541c38esm14459329b3a.46.2025.07.02.06.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 06:59:32 -0700 (PDT)
From: Akshay Bansod <akbansd@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
Date: Wed,  2 Jul 2025 19:28:54 +0530
Message-ID: <20250702135855.59955-1-akbansd@gmail.com>
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

Testing:
- Built the driver (`st_lsm6dsx_i2c`) as a module.
- Tested using `i2c-stub` to mock the device.
- Verified that reading sysfs attributes like `sampling_frequency_available`
  works correctly and shows no change in functionality.

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c65ad4982..1cef10919 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2035,7 +2035,7 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev,
 
 	odr_table = &sensor->hw->settings->odr_table[sensor->id];
 	for (i = 0; i < odr_table->odr_len; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
+		len += sysfs_emit_at(buf, len, "%d.%03d ",
 				 odr_table->odr_avl[i].milli_hz / 1000,
 				 odr_table->odr_avl[i].milli_hz % 1000);
 	buf[len - 1] = '\n';
@@ -2054,7 +2054,7 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *dev,
 
 	fs_table = &hw->settings->fs_table[sensor->id];
 	for (i = 0; i < fs_table->fs_len; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
+		len += sysfs_emit_at(buf, len, "0.%09u ",
 				 fs_table->fs_avl[i].gain);
 	buf[len - 1] = '\n';
 
-- 
2.49.0


