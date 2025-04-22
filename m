Return-Path: <linux-iio+bounces-18529-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5374BA97528
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 21:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFFC17EA70
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 19:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B293F29898D;
	Tue, 22 Apr 2025 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZznjtLlF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2F296D32
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745349095; cv=none; b=DxlSTnLlYVUbkM8xcQmTrmHUbU4nP0ASBqPMyoeNWkltkcbDdbuz4aXIWa7gZb9jt00A/eiU8DJUMd9OcigVyMKk5u4Gc8/Zsdtw9HQSxfTMIypKzenfFl4oRfOYNL/nBpK3W7OkroXTaKQXabPHEElacWLv+bzJ6Mhq8DknPe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745349095; c=relaxed/simple;
	bh=REQ5mPPhJY1sKJmVk+5R7l4jiHYX3sCuXvRi3V4ZL6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uXCSDE8WcF1PCbzPMCosIPxnJhD54la4TGD1nRnGs1KEwImkxp9A5RjL6PbcksrkqG+p2JyG+IaHXTAHH+SZ/SJ+CyqljETG3zzebqlaFpqh4v37cjUVZiDqFoqyxrJSzXlkSj4twcULgGkGQ7YcmC6342a/r8E1qJEoGwAguGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZznjtLlF; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30384072398so4572896a91.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 12:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745349093; x=1745953893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zGpsdF/F/vsjt9oJmDLmx5SscJUBHmiKDM9FogXF71U=;
        b=ZznjtLlF5cWpgprRl5Febq0WgcnyroJ8KtGLhhneDZpnUxjMbOesFExqKT9aNMqdM+
         keP1CRX7M71bVo9Ob5J88jQ+nORuLI4+J3IqkPAz0Ks/DJXxbwXorRVnmsPDD5+ozbNC
         JLVnG4GhtVCBR3N18VXURRIEph5Yd633CXrX5iEhytC1oV1Va9fvMP+IYLoAJLLv+oOG
         VP1z2jLOrif/xdOv5nrAu7wjuwiFAnC73DuzuOqKZJrDwlhoJhG8kyP5OvrWslXIKXhH
         Ffm0C2BmB8ixJinRd8IUYC/p8wtCwDipHMyCP7fHehQuspjD3BBqi45JWJBxFEjc6L2c
         tEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745349093; x=1745953893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGpsdF/F/vsjt9oJmDLmx5SscJUBHmiKDM9FogXF71U=;
        b=YpBocMZDtYHL2kfiiOV8fO8Fnu+GL7Y+PpB1ctl/XYQ2rvumxQKLg3n8CY9jMHZ3UV
         fa8vIzzZSYEbhq/rhSYw7iFHwfEHN9JMJJm4zdmRJI2btyzn2+KYTFXmWrL9xYVK41OX
         dh+U0MmpMWYfT/vKy1RC4VBxeyKcHBXt45H8OKT3vcSqK41faw+dh0iRx+IctkfXE/+i
         CHk6RZeLq5pHxB+iEF19TB2na5UswuySgsLym7gHPAekgneZPz7D9OD+CgqYluL3JWWE
         5JiDeS+AvFZKkAaWrHUDNFbS66iGmSrvC+l85gBZ2OFpMpZHCsDzNeMtE/mciBVJ3HbW
         SvzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2t2PQqW9AIhXvZZZ+STTxZ0g/TirCXcDjZpficyTicTkGAkR+lguMx2QOs7u3amnXikN7Sa5GS1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8uRoAo1eB3w1QW6Gvb6QbpOr5dHdkADQacoBF7CICdxjcKuR2
	iCvJ2mSIkQuY6KMQBnS5GxwJMyWl2hEe1/PixD62gx1B77QaNrm8esqyxjuVQpM=
X-Gm-Gg: ASbGncvtFq+8ZOs2ocju5Eq1uXqdnbpRzvFV74i/h9og5z7RDX6Qx6WJYooYrTJ2u9G
	12J8TuXCeTMPHFjE0nZqIkUv/x40NTPS4p5HT/vP0EjcAcbNeJByGzahmxkBAZODGXM+Ewq82jh
	/47E8x9Z44Fwh9/ueyrZGuGbgImBEq5FkJTWqTGFJf70Rw1lGkXrZi4XTp9bx2OU0lBg3eBxuCd
	lK7B+izRp/LKKt1LD94ysAohFvdhQwgzvOCPQo2sjZCcuPDuXp6j7MOy9w/bZqG+HUiN2DsJoLS
	PraY8nSKBWTDn4HiUo78XrwvQkh8OR0xooHt+2wKfR5xQzr3JubErXhMyNsiGNQG
X-Google-Smtp-Source: AGHT+IHKKCVpKpBPBGqjzWE5pFqOKWp4MNq0qyn0Ir5WxYMHVUvnwqp5YKPKOfCjvwptQluYkC/zJg==
X-Received: by 2002:a17:90b:1c0a:b0:2fe:994d:613b with SMTP id 98e67ed59e1d1-3087bbcb45dmr22982356a91.35.1745349093099;
        Tue, 22 Apr 2025 12:11:33 -0700 (PDT)
Received: from mintNaitss.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df0acb6sm9093738a91.12.2025.04.22.12.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 12:11:32 -0700 (PDT)
From: nattan <nattanferreira58@gmail.com>
To: subhajit.ghosh@tweaklogic.com,
	jic23@kernel.org
Cc: lucasantonio.santos@usp.br,
	Nattan Ferreira <nattanferreira58@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3] iio: light: apds9306: Refactor threshold get/set functions to use helper
Date: Tue, 22 Apr 2025 16:11:14 -0300
Message-Id: <20250422191114.32832-1-nattanferreira58@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nattan Ferreira <nattanferreira58@gmail.com>

Refactor the apds9306_event_thresh_get and apds9306_event_thresh_set
functions to use a helper function (apds9306_get_thresh_reg) for obtaining the
correct register based on the direction of the event. This improves code
readability,minimize the number of lines  and maintains consistency
in accessing threshold registers.

Signed-off-by: Nattan Ferreira <nattanferreira58@gmail.com>
Co-developed-by: Lucas Antonio <lucasantonio.santos@usp.br>
Signed-off-by: Lucas Antonio <lucasantonio.santos@usp.br>
---
 drivers/iio/light/apds9306.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 69a0d609c..9216d4974 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -744,20 +744,27 @@ static int apds9306_event_period_set(struct apds9306_data *data, int val)
 	return regmap_field_write(rf->int_persist_val, val);
 }
 
-static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
-				     int *val)
+static int apds9306_get_thresh_reg(int dir)
 {
-	int var, ret;
-	u8 buff[3];
-
 	if (dir == IIO_EV_DIR_RISING)
-		var = APDS9306_ALS_THRES_UP_0_REG;
+		return APDS9306_ALS_THRES_UP_0_REG;
 	else if (dir == IIO_EV_DIR_FALLING)
-		var = APDS9306_ALS_THRES_LOW_0_REG;
+		return APDS9306_ALS_THRES_LOW_0_REG;
 	else
 		return -EINVAL;
+}
+
+static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
+				     int *val)
+{
+	int reg, ret;
+	u8 buff[3];
 
-	ret = regmap_bulk_read(data->regmap, var, buff, sizeof(buff));
+	reg = apds9306_get_thresh_reg(dir);
+	if (reg < 0)
+		return reg;
+
+	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
 	if (ret)
 		return ret;
 
@@ -769,22 +776,19 @@ static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
 static int apds9306_event_thresh_set(struct apds9306_data *data, int dir,
 				     int val)
 {
-	int var;
+	int reg;
 	u8 buff[3];
 
-	if (dir == IIO_EV_DIR_RISING)
-		var = APDS9306_ALS_THRES_UP_0_REG;
-	else if (dir == IIO_EV_DIR_FALLING)
-		var = APDS9306_ALS_THRES_LOW_0_REG;
-	else
-		return -EINVAL;
+	reg = apds9306_get_thresh_reg(dir);
+	if (reg < 0)
+		return reg;
 
 	if (!in_range(val, 0, APDS9306_ALS_THRES_VAL_MAX))
 		return -EINVAL;
 
 	put_unaligned_le24(val, buff);
 
-	return regmap_bulk_write(data->regmap, var, buff, sizeof(buff));
+	return regmap_bulk_write(data->regmap, reg, buff, sizeof(buff));
 }
 
 static int apds9306_event_thresh_adaptive_get(struct apds9306_data *data, int *val)
-- 
2.34.1


