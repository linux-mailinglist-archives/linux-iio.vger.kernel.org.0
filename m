Return-Path: <linux-iio+bounces-20476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1848AD5D61
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 19:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21AE17A2DFF
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 17:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC70221FAC;
	Wed, 11 Jun 2025 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJoUg9EY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7B413CA97
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749663802; cv=none; b=jPoPgqBfoopg8inCTyZCrKdmqQrumluCapk1kN3SLFzfZ8xkodlqHVd6fwGqwYoxxhZjnfu6o1bAfYUarI0CwGRqhpi2qZKyYCOtbQLmJ9cVCsvIMkNWRCEciRBu0FRPJUrqHckNtSFi+Z9w4TFfYT0D5a42hLnzanjC2Z0d4Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749663802; c=relaxed/simple;
	bh=3AOFFRjsHG5uqaAONWK42MBEBNvD+Kcggna9rSd6CKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JVPFk7B60VK9T0o9Vraegts4hKm7qwbKZ6EByHC/LSYXgLqnbaxhXjt4xScFTeT0WPplAS+lTpn83sw3YAhI72y90Rc44Ienb2qshhOx2w0BwNEOp67YIkSYxTwkP7u1XbSdpfG72WrVieFKEtGnElkJdq+HtTSB7S3MArU8ti8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJoUg9EY; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e5d953c0bso531607b3.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749663798; x=1750268598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5VFf2G5/t0VEq6hrrKlDY76UjCAzz6yxC3wiaGZnHsc=;
        b=bJoUg9EYkvtRDrMw5i9Y7kmCaXshqJhUkFMpuKRqhihFcWMFHhjiJLEmC9+msDzAoQ
         NhU+dmylg73ZILvK1BgxBCPngm+yi8rqcXb7HgUcmQEuGnLrMzHrYFhr19ZF74ogl0td
         7uORttaJV3nrieHcNaTptq60yKMMGRhItUICf5HMktbrr8HbHu3BFeutwOf/rTVwfFsQ
         Wajb26cO+de29ad4Li3nF0GeJXXxNhoOpXXG3w12hva6t7Nf5sk3i6h/z3OcDgTHVDy/
         ChBO3na5jBQZDi2MbORspWj5My0OXbxqkASq0SEm985sdl5C2TkJRc5o4VduzD3QujN5
         kkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749663798; x=1750268598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VFf2G5/t0VEq6hrrKlDY76UjCAzz6yxC3wiaGZnHsc=;
        b=erUowKDIiv0cjPstWbC9vjymaaObT4Wj1/u8BCgG0iJ0D5AH8ZwYBTpFQs/i9EVOj4
         iSS5FCXkecdqTh3oYJyHT/aysj5YYyexOxfLtmZu0IelNKOZ2LIWpwyPttk8zVCG4KD3
         K85aK629bueVE78dKlI6/lp9Gb/DM2m2NxYZSbjMn4aaUb1aDqycCYIlchUxMt50Aq/f
         F/zbxAKsXpcEFLnMiHN1pjxlUXBK5KIdyw+YpGjoM9AxCXz3E8gcSPOUK5kfbDXHdV+F
         2VH5zX0FGrruZOOwvxBXEWu1vPYEhVIobqDQdIVB7cNGCTS7ZykUJPF+ds38JV9Fo2hj
         LmKA==
X-Forwarded-Encrypted: i=1; AJvYcCVSyisuChzZ4+yzXbU/IZp+Zq+PFhHBndZbgBwZZ9I2dlzrHTxjw7BUs4nDHb6lXJLfnmzQydYVwhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN3g12WORnfuA3tPPfBFzt/CPRURBP9zG91rm8HO011rHXG5ys
	Kx1THJX8oYeAivyS1kahCEKVAmv3489pY/xfvlyjx32BTVlxstaO8xkD
X-Gm-Gg: ASbGncuO8Z5nwtitjiqX3ZDvDRkc0xxIcyrU2vbpoGv15uIRDO1FkaMVhDHBq2ZO0Rk
	O1cf8OYPR8+RZhxVhcN92Kg/ydYXV7wcthiT5JC53MTurQhshtCsjIjwzPhAwhpDSPZF6SjjFfO
	kxWRNML3meKkpaB3pSmsfn1iIXjXzgAsFgj3Mb1TGeFpYBVn7LTsVHr00pnJmQ/BvGrTG7mHxvM
	uMsJ+t1s7zi83IZf7y16v46OOLymaXfuswbcOpJHUdpLh/8T+ibyN+30Jd0C7j9wuKeO96pE3OI
	HpMO4zXb/yB5f+k/8uYUgmwduZ/uDhGomwzn3UAhATXoRxz1aGBR9N9AHkvu6wg0DhjYp5KifuL
	zdbMKlFQ/yQ==
X-Google-Smtp-Source: AGHT+IH7jj/IfHLB3fAcxAnaf/mMSCyuoAs8Zw8pOtdNkP/Pv7r0d38biLrY+Z89+45yJY3fNuz51A==
X-Received: by 2002:a05:690c:f84:b0:710:edf9:d92e with SMTP id 00721157ae682-7114edbd0ffmr8924407b3.33.1749663797722;
        Wed, 11 Jun 2025 10:43:17 -0700 (PDT)
Received: from mintNaitss.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-710f9a0fc34sm20757847b3.97.2025.06.11.10.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 10:43:17 -0700 (PDT)
From: nattan <nattanferreira58@gmail.com>
To: subhajit.ghosh@tweaklogic.com,
	jic23@kernel.org
Cc: lucasantonio.santos@usp.br,
	Nattan Ferreira <nattanferreira58@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v4] iio: light: apds9306: Refactor threshold get/set functions to use helper
Date: Wed, 11 Jun 2025 14:42:53 -0300
Message-Id: <20250611174253.16578-1-nattanferreira58@gmail.com>
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
functions to use a helper function (apds9306_get_thresh_reg) for
obtaining the correct register based on the direction of the event. This
improves code readability and maintains consistency in accessing
threshold registers.

Signed-off-by: Nattan Ferreira <nattanferreira58@gmail.com>
Co-developed-by: Lucas Antonio <lucasantonio.santos@usp.br>
Signed-off-by: Lucas Antonio <lucasantonio.santos@usp.br>

---

Changes in v4:
- Noted that the change actually adds four more lines to the driver file,
  so rephrased description to avoid claiming code line reduction.
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


