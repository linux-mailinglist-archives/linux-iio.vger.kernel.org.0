Return-Path: <linux-iio+bounces-18523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F82A97362
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 19:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E126B1B61A49
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 17:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CC0296152;
	Tue, 22 Apr 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4PzEYEy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CA012F5A5
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342112; cv=none; b=oGjT0kfbcXkivnQKq2Hjz+dFqj9OmFng0gVtwZ6uP9s+wFpP5XCyhqGyk0KPjt1vZMRb4zuQ8KPbeXNawOmq3n0QPZKZkW6NVuARnBJdNNRHZ1RsY8p0mCtkKybXKyVA/if9iGMG2Rqys/mP3iBJ97OyJpUNURc6flEhVZHFdOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342112; c=relaxed/simple;
	bh=+PzIQoUfmHf/VM2DzR+1OAT7+pyTn71H4wIj1RleTX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VN65G/RPtgvxZ3M5BwSga1V/9T0hcRGSGrKwTtpM2yivgaWN4r4b0aGXveRDgjMrSCgNN76cqWoa/RwDM7sd0CQhscfz6MfKbKcARxJ+g+DWh9seGLmcobnhg/W1CGh/8vkt/icLcB85Uu5lS0xM9sLLZB2NALqjvL+/oCocqZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4PzEYEy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736b0c68092so4657303b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745342110; x=1745946910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ynHq5ACIt0IyyhkPGdVhmsxm/Q9+wr56TRm/kxE8bIw=;
        b=F4PzEYEyzVeMGNj8l1Aw8PF1ODKELpV7bqbkC+1A2GjWB8tsRld8ETuhwkUzMQ2v8E
         wV+ilsuDNk3WXzK47tYdMnzSH12hWrKumig9Ysxw2ALP4MavquVnT6CceP8dfWGQzcIa
         loMhRFpCK93SS+E4XbC58yXvQRh9bDbKOVwW2jpim1bh1sXAHme9YidXKjjdrTc16awY
         PsA0qosS0ClYUNyPxjxV0JRwk0yw0DU00LOPGKe2huUk+S7QiiJyFO6nekakUWgbxCIf
         H1COUtwIal2oBH1LRU0xX0IYRb9ptlF+WTg3knbaxKy0I1FYTU8xdoM1C0k32tAeUyyr
         No7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745342110; x=1745946910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynHq5ACIt0IyyhkPGdVhmsxm/Q9+wr56TRm/kxE8bIw=;
        b=sGQqekiUFpn5vNEUQUhV8j1mQBmHSgP5DqwKx7J+DKJxdLWvqtzGxxjpchdtMjtHr8
         v6aiAVIbFxQrg6ZqLyWvmsnnX0NfvTOHhKCc/01yHhtHDmXInL8gl4ZouwcDbMbLRRIj
         xQNrH2QHCcxZCd0n0xT9IoQVkZH1G5XHTuBOUhTR7a5S/qiT7Je3I+SzCSyaiwmsHAKm
         m4/61+AtTrRhDIx13tiGskZI7XiQitdtVCoSVeYxYUuLqt0eY4CcVWDBX0Wa55jMaMtc
         iBhZ1IbVjv2m/M8GAjx2/AQIXuOZRON7hBN/OyBCVdnp9QKT76Ql4YFPQdvDAwk4EQxj
         f5Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWw2nK9xLmMpdp+BBG5WPr616LQjmsZlEkvdSPhKkPisZeEgZ4SWx6KVuSLuB0iyfBF4GnL/a6i4T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLF+FORJLat2U0ajN7Yh1/dqyoHkVDuXD63UsdaBL9abQEVqd4
	QOocRWB8uj1+aR1JqSDDffAJWqOQAZWyZEh6WpIUyXgr+aV/ilHr
X-Gm-Gg: ASbGncu1wWKBR0Oz6U/K6iXnBzGsDWfzd0tJ95M9GW7vRMP+n5CAAEdDF7nAhJtNGkR
	DDzWC4sSSV0Q1Af2HkUH/4kw1tSJ8Kt0Mo1Ghow/9UEkE9tzqi4RbKK7pzC3qxXWrmZ+OE048ZY
	tVy5OZfOGNbk5y56OA2dekjhobYu4NmbUE8vZ6FIKsLts5M4WiquI2KeID9GtQXJs1sX7+YNr9h
	SO95tp+AOp+IUxfhoiZnxW5ZXtvuc9cYR1lgrXMlnHeDoh5ooF8dJg73PJ97cNgfHPq0MjuZNAd
	JzXppy7vKBnFUGtp9Dz8pdz6KhycWO06ztZlJ6VyTA4sVY9xkOlR5NtdTcezTqJln+LraY8LBnk
	=
X-Google-Smtp-Source: AGHT+IECO7+LsRubs2OAJJ2jN90FTlrm315/DM/ujDpDpB8cQItMtL0PXBAyd69I/iV59H3xXrEZqA==
X-Received: by 2002:a05:6a20:c68e:b0:1f8:e0f5:846d with SMTP id adf61e73a8af0-203cbd21239mr29420259637.34.1745342110332;
        Tue, 22 Apr 2025 10:15:10 -0700 (PDT)
Received: from mintNaitss.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db13c8b1fsm7682728a12.37.2025.04.22.10.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 10:15:09 -0700 (PDT)
From: nattan <nattanferreira58@gmail.com>
To: subhajit.ghosh@tweaklogic.com,
	jic23@kernel.org
Cc: lucasantonio.santos@usp.br,
	Nattan Ferreira <nattanferreira58@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: light: apds9306: Refactor threshold get/set functions to use helper
Date: Tue, 22 Apr 2025 14:15:02 -0300
Message-Id: <20250422171503.26532-1-nattanferreira58@gmail.com>
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
index 69a0d609c..d46fb45ae 100644
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
+		return  APDS9306_ALS_THRES_UP_0_REG;
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
+	if (reg == -EINVAL)
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
+	if (reg == -EINVAL)
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


