Return-Path: <linux-iio+bounces-21182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 164BEAEF6BE
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 13:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE931BC34AB
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 11:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C4D27147E;
	Tue,  1 Jul 2025 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCZcAFK/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F981DE2CC;
	Tue,  1 Jul 2025 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370003; cv=none; b=oLqDeUw36AKAf/GPO0hH8POEMDTc5xqiLvuxL4a6Bq/h8fvGiKN1w3czUD9VETAzpjBMnJ7FhUfDtpb0CluXt+mhlMKBWCIIQ1Jk+wMNEkF26tM9S+5KB7bx4vQE6yivk54inShU1nqD8JcNZhiNpw+QeR0tE4g0PLgNy5ayWh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370003; c=relaxed/simple;
	bh=9l5vg0GcY01Co1kq0+/y9vh1cnqTAz/iJtRkZx1AFX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HyJe6kl/MvsJYfmfvXc8rn2V+VUfKIeRHF43NFFf6o+3LahLvx1RL8mFwpdnhtelmQVrrIsOw+2NmC9qdSczRnnKv1ptV5loi28NAnTG2cGO9OGA4rRm4ZCQZ0KbvQ56j701LaTyQ2k5ZSDC8wmUn/bVFZCI4MTVVuofifh6hYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCZcAFK/; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d3efcb9bd6so543596285a.1;
        Tue, 01 Jul 2025 04:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751370001; x=1751974801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2X+UMdFXLhLHHKVoJF6IPHYW34klFV8joXsxwqaFG9w=;
        b=hCZcAFK/V6zmHck4Ceg16pMvK+gkdWYI4nWb5nxyIVSNpkPc+Y+t6o47kGQ/kw1M9A
         6ad3evqEOJgdmO60Wkq/q8QRe/X4IAMXfCpgrO2ia7dhLx1/882k/pPo5gQK4wW0BnGc
         IYaMLQ7EqV0DasRudZqpXCFqNh4XH1GGY7DED/QJmPrIkG6SeVanOvSne9niGDFsKa3X
         oBsNQCzHyuZBUXh9xXVVRsSqgrEBweMBjCad3Cw9dcwOdpIC7WGw5ck1dt1Ri5F1gSI0
         ZLW23Klun87tQeN/c0ITBw9YMWoeYUk7Uk2cS+XoXosZEkqgJMsyEu0Cx0txjeaGBn9x
         pFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370001; x=1751974801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2X+UMdFXLhLHHKVoJF6IPHYW34klFV8joXsxwqaFG9w=;
        b=BlOTV0rOLEy47IFVRYcVzGzNZwqTn521wgqyhmOKWFO3/b6SePfcxGZaxFYu1s4uEw
         nCF3is4dfUzkPwWGwaAcFV6VtOrEi8jc4SoQUtTQtY7mq2+qsqLVYKSuxdjm0LQpPH8a
         HU6EASPbJ4AH5SSqv0JM0tNAsbLizA7TttrnK5WowWPH2aEk30pvuNmVsD2D2AWB4GN3
         3yxAfkVx7Jep8jqxluX3P343SxdDxFEh1V3ZspPwQt4Oj2MrFqQsOGBrWzH9ZQyhxlMS
         GxElJvIPjZSIk/vAM72ykFQdk5WZuIU30P1MpLU0P3Lj3qWnfSGKCSw4x9mr1vHJK3AN
         cxYg==
X-Forwarded-Encrypted: i=1; AJvYcCVb4J/kcNxgaxiNGPwuh92tPGUjOIf0ZymMC+dIGTUbOuFW457pfxuRyI9a1Mg3hwSRQ0A4brmbbSr0GeR7@vger.kernel.org, AJvYcCXPASLbdKNJELxCvwXHo0cj2FbGlDYOI/yYoPUXs3rIv2enAPxTr2N5yX7FZ5OoXtfeQZd44j9Snh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0iB9G4XC0SuYWW125s9jchjGLsETGjWvyX2AKJTACpebrm5h
	VeCjdoOV41ObkenPAXYb6oCOSMyEM0HGr2kOysP5KF45Ai2vawz/6FIu
X-Gm-Gg: ASbGncvexTjPHlypT3Z8V5mHNyjTpNuw3Cv3bT9ynhvLlx7NxTsNgBSlcHtXlWDhHxo
	aEayJmjER6GNTLKlUnMxb24Pr92Qb+Mi9RPnSEgRo2mXZtRKVGqa0Lb/MJiPL76R64Q6qNAvVrO
	OPiwmdzvjUvAsVryKyyBuqQ6+MlsCH41si/Wel2cnDkwKE7Ym6hVJxzvnajB2W/+ktYZzSUdKt9
	3q0OwS3rbd4O9on+0a3fgxm5crOtUFQXwjng6vnnZZISwACH3RJ6RuWsWHuc5Mx9PEzOd+xzfd+
	p3mvosUaCh95JqeWrtX6kF9IROQANUhqBsnAxmSowY2mgGffWOVLm9I/AJrSvbUZQQOVLBADTAE
	nCsXe4nD008k/KjocTtO0m3hgvIhs
X-Google-Smtp-Source: AGHT+IFJGHJwcNYFSBcCJikH1RuT+bxOvtc8ok6CVLg0qtxrh65lv65EtNaW0sGPVup7EFrdNFxrWw==
X-Received: by 2002:a05:620a:3709:b0:7d3:f4d7:a583 with SMTP id af79cd13be357-7d4439b745amr2680715885a.49.1751370001144;
        Tue, 01 Jul 2025 04:40:01 -0700 (PDT)
Received: from fyre-x-redhat96-client-2.fyre.ibm.com ([129.41.87.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44324e1e5sm751087185a.117.2025.07.01.04.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:40:00 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: jean-baptiste.maneyrol@tdk.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH] iio: imu: inv_mpu6050: Replace scnprintf with sysfs_emit
Date: Tue,  1 Jul 2025 04:39:45 -0700
Message-ID: <20250701113945.6865-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/filesystems/sysfs.rst mentions that show() should only
use sysfs_emit() or sysfs_emit_at() when formating the value to be
returned to user space. So replace scnprintf() with sysfs_emit().

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index b8656c02354a..53a315fd0c34 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1382,7 +1382,7 @@ inv_fifo_rate_show(struct device *dev, struct device_attribute *attr,
 	fifo_rate = INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
 	mutex_unlock(&st->lock);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", fifo_rate);
+	return sysfs_emit(buf, "%u\n", fifo_rate);
 }
 
 /*
@@ -1409,7 +1409,7 @@ static ssize_t inv_attr_show(struct device *dev, struct device_attribute *attr,
 	case ATTR_ACCL_MATRIX:
 		m = st->plat_data.orientation;
 
-		return scnprintf(buf, PAGE_SIZE,
+		return sysfs_emit(buf,
 			"%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
 			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);
 	default:
-- 
2.47.1


