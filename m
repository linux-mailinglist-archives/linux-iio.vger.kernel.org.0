Return-Path: <linux-iio+bounces-21189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C20AEFEA3
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 17:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866991886DC2
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACAE2777EA;
	Tue,  1 Jul 2025 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsINdp0s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A76A1946AA;
	Tue,  1 Jul 2025 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751384860; cv=none; b=dehFds+qZ3mWZBu+1+oxipo4PFqUOVVb1K5Q7hObooaOTLN4CDmdJUhko5CCIARCeYCScVm0YDzPgGheIf8+Aac+LffMnaTZ2lZ+JB258+38d1GN5dpuGUryN7fkmZCjiwdTZkrx64ODHKmOEI4JjXLkywXRj4D1WSkiSs41GOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751384860; c=relaxed/simple;
	bh=cqyPGYLblfVYj6BPqlBZMS2JvqAo/vGxsJgem4AIE3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DdLhQ5M0i+0LBJGP0tU/ywlnL2RItPJBO7UUi5hW4f4kRM3xe5bnFishbD51nMF4J0XYe31pCZCtsSUiuUHMqEf9sK9IratErF8V7iVAAG6snVfW+ewCyeqeGAJIJx7cFYk8eqzMsj9MZbDdrjYaaG1+c31pR4O7SjURyJFlbjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsINdp0s; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d21cecc11fso966168285a.3;
        Tue, 01 Jul 2025 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751384858; x=1751989658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QOTjSR8K92o8+5zySVJbuCZzgEc68E05xLIa5iJk2bQ=;
        b=BsINdp0slVMLU0dZEqcuNyhzOBOT2bpVhXc2tskvj06/7AwE73QK5BDofwgc3MZvux
         52+U34xHvTbLb+jfgH53NzIlCuUK9dSSQGVxaoHPIvXPinV6Zkp+PA5YPsL1Xutq3S4u
         W5YmhrUDJ0jT5HAtWO7yglp+qKTs/SOHYlFWrOsWXgAD4rGwS2+K4NQkNT7QJsXohMw1
         fd4Y/x3Gxenn0IiAQpbMWy9ml4fKW+KgLFiKqechl/qm+TprjsLn5Oc6Kxg7WyebAiU0
         HUTJaov9wxt8sM5X0GmSyCBUhn5RSrcAtxdiqD68wxAO7PUQVR2MYCAVIu/w4zIBPQCC
         6pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751384858; x=1751989658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOTjSR8K92o8+5zySVJbuCZzgEc68E05xLIa5iJk2bQ=;
        b=LCbz8gZwBgKeFYBKlkZJ3tRYFpfRXnTegWTZrZTVuzFH0qC/+OdW66CI9kKlTjJPvZ
         6MOCHBssbJTN65BucwaLSnOjPGQ2PCIseR8u46rQf6skSNfSZLBMfvICzjFgSq5gWVDz
         lOkpJ+dj1k+scVmW7PguVSiGVOKvLoMbAM70iP1FLWxTvuIyUqIMp3pUm37weJbSR77l
         +HIa4OrBDt6T28Xgb6HUP3r91COzZ+lsZ392qMPLabvK6ZYglCb3FJ0KrTiTMDR5qvhf
         I7XcNulLeJqJ8il7VoF5xbk0lWfIIDmgRCPcLy1U5k68dKshiiIhJtTlGXo1SuXULMlI
         DPcw==
X-Forwarded-Encrypted: i=1; AJvYcCVyR3H9tc+B9zQbQmMjE7Y+Z7B4Mk70Af0P8HllMOMBu9RhBs46xBe9tj1hgz60AJNuLQ0qTWyn3zQ=@vger.kernel.org, AJvYcCXFAA9zJ8o07llEANf/PbZhz1Bs2oc79ag2ihdtJ9qlkYtk4ynipI9NhEVGS/AQfVHALleWaHwJrcDlm1/7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4CDXL+UazIAyEMvYEKQU5cKULJUMJ038LIE7yu+77a80zyJvE
	vC/d6C9flW2XEdSfEeto/CEXUeBG4tE22VvYOHPJyS9VClJGcp0TtDyE
X-Gm-Gg: ASbGnctAeI1XfTA8/feM0iYGUjaLwvSFXnHMz9Tgkqe2GXX7LwU0DzkbvrJ6ujFMEav
	auOpy1ZMHle4B8NuUbOTWfkDhsXt67bJ9sli/uisg+AgK6xcEFlRuZ3EOaoY1qw89lGJ+8NbvDx
	I5QtVyUjy3UW1wCqqKfBURoCwgr6UOdS4fMR98RW2jrdIn0l/2K8uKcsj2d9VOWaLRo2IlNlChP
	Wn08Kvjcni10xFyikzFJT6fSlYtaR94qSVehjXAQuS1VRlYiWgGU2lYL4/WT0FMDKf8JUxUNuwf
	pdSlVYBG5qQMjW26rmNyUx4lOZ6JAv93wreBpoKIWYIzoH2AJUKMh6+hUvHhToYCgB4pv8gFJdG
	Y3C491F3PhHjx3fOBIBA7UowLDC1R
X-Google-Smtp-Source: AGHT+IFib9TmmWC/xoES4S07N3qB+mzz6Jxd+1uQL5NGHKBKtwtcEj24/dbm3XlySIoRpgk/Nc5XyQ==
X-Received: by 2002:a05:620a:1917:b0:7d2:26e8:e91b with SMTP id af79cd13be357-7d4439a6503mr2190905785a.38.1751384857643;
        Tue, 01 Jul 2025 08:47:37 -0700 (PDT)
Received: from fyre-x-redhat96-client-2.fyre.ibm.com ([129.41.87.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771bc01bsm85230876d6.40.2025.07.01.08.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:47:37 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: jean-baptiste.maneyrol@tdk.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH v2] iio: imu: inv_mpu6050: Replace scnprintf with sysfs_emit
Date: Tue,  1 Jul 2025 08:47:20 -0700
Message-ID: <20250701154720.54276-1-chelsyratnawat2001@gmail.com>
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
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index b8656c02354a..39eb516acc73 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1382,7 +1382,7 @@ inv_fifo_rate_show(struct device *dev, struct device_attribute *attr,
 	fifo_rate = INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
 	mutex_unlock(&st->lock);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", fifo_rate);
+	return sysfs_emit(buf, "%u\n", fifo_rate);
 }
 
 /*
@@ -1409,8 +1409,7 @@ static ssize_t inv_attr_show(struct device *dev, struct device_attribute *attr,
 	case ATTR_ACCL_MATRIX:
 		m = st->plat_data.orientation;
 
-		return scnprintf(buf, PAGE_SIZE,
-			"%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
+		return sysfs_emit(buf, "%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
 			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);
 	default:
 		return -EINVAL;
-- 
2.47.1


