Return-Path: <linux-iio+bounces-5164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B82E8CB174
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D901F23025
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 15:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7D3145B21;
	Tue, 21 May 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HswmumZI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFBD144D24;
	Tue, 21 May 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305701; cv=none; b=YsTDCC5MVRIPMveNumQHAi9uBEXXWTaUD/8LZkk0UwJIVDfLMaMBWJ/O+lOyOMmhDMi9a896Ru1bpxQFfNAddc01hL44iUT5b/2kcSmUb7yraft8NZbyvMXd3yHubpfJDhzyQWXW5JiCTgNGj0VOYPIelHh9Jk+yvkqV8fWAjYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305701; c=relaxed/simple;
	bh=yVca4Azo07IIKs/CnJ5EUgKmSD62PNWM3PW3gtNBLNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h6M7DyCn873I1/1CcxXtTQ0SHXPFkIaa0WzB4AOvAGBvgUNyt/bz4wFzOZhB7SkiWUp5zji6aGbvibuD4YrSdur32LF0EL9GPSvPg9tj0339jhBRXPBXBe8gVPHX/Qgr6++7idc6oVYdaGTDGT8dGHDhjDejrNtT2CG7rt+4R4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HswmumZI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e716e302bdso34218211fa.1;
        Tue, 21 May 2024 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716305697; x=1716910497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lvgbq91/6HEHU1LdvaNMtkZEi5kvFS6+7y61hOHHWTM=;
        b=HswmumZIjqP8t9CrOwHZxyQ5NAQoTTDDYV1QF4XJIJhMwd/OhtFAaTAdHSxs0m8QVa
         T/7qC5+JYa/0IJUBArZnl5K2eFLM82HpOD9+y/rz5ROamyormeldOb9STmJkDrrNEWgI
         +m9bIvKiwg+h2Ww9hgxdO5IT7aGg59P3fU85yJ9b+GrmrfWQF73RIwn76q6VulUHQfcz
         9NUeLRT9JGwvDG1I7PzBJf5vJJnU1sohcUrt6/QReE2PBTlOgQR8ap3vxFzN3QhIXA1I
         JF0jfivLOkompPjIX6A3Tiizs46rBP5WY7AUDJl6lZ0ZzrS+UrSfxCgiB11En9Yu828u
         mtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716305697; x=1716910497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lvgbq91/6HEHU1LdvaNMtkZEi5kvFS6+7y61hOHHWTM=;
        b=biRK8IRWPp66NoZatkzJMwOzRf36z5MRbkVk3giL0nmW+Wo2/tOPgzC6bRnrD2CBKU
         D55jugXj4FRnOEiTDErDyvwmOBRXb+f0H4tfnMvYOn2DkiOOEvYkO3oILo0MzQqVJ750
         XQthFSUYRqqgWrY4YrFJRSj4TUUTSpCbFfDMyX6Q68RWEjXFoMbHF6ftkNkQ3qn5Ee/q
         ZYtKXyhWZ0tclhdHPJbNZLCn7DwigfqKHuErlB38FTUgm6LH05cg+ebhSb+V4lIWUeTM
         cQI37I5TLfKF6SVFOQOMxQxHBo2vgilIVd9ZIgHRupA8bu4DSNX1izPmcfLsqE2zUv5+
         Ci6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXx10E8WiuZ6I1AF2ghANpriQJ49V3QHfd5Nf84U3f06TP/cgM+KqO/IKvGjd+CO4bMyhy/l+kdS6T3vs9p8edomBC8RVNHBrA9XR8J
X-Gm-Message-State: AOJu0Yy6NI3q0zI5Tli5dY1wFkfL1ef3jR2cqlrYLboMbYe2MXe0+78K
	g0bMpwCRXppzciBndeVkyUY0vg8fdn5DJhHX5OkOOX0eyh3Lu6bTEe103NO5
X-Google-Smtp-Source: AGHT+IEHfUlVmZ0akfqu2R79FCpHCIRSlYLhug7s9ZU2T7tLnmzRnUUrHpFQ36wnEy+KiN5beUdzfg==
X-Received: by 2002:a2e:be13:0:b0:2de:25e2:6187 with SMTP id 38308e7fff4ca-2e51fe57b06mr231624511fa.23.1716305697265;
        Tue, 21 May 2024 08:34:57 -0700 (PDT)
Received: from [192.168.1.130] (51B6D146.unconfigured.pool.telekom.hu. [81.182.209.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42013c5fa61sm368737285e9.40.2024.05.21.08.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:34:56 -0700 (PDT)
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Date: Tue, 21 May 2024 17:34:52 +0200
Subject: [PATCH 2/3] iio: light: stk3310: make chip id check expandable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240521-stk3311-v1-2-07a4966b355a@gmail.com>
References: <20240521-stk3311-v1-0-07a4966b355a@gmail.com>
In-Reply-To: <20240521-stk3311-v1-0-07a4966b355a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
X-Mailer: b4 0.13.0

Modify chip id check for support easier additions
for compatible variants.

Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
---
 drivers/iio/light/stk3310.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 7cae261541c6..5b3fe98af9c9 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -81,6 +81,13 @@ static const struct reg_field stk3310_reg_field_flag_psint =
 static const struct reg_field stk3310_reg_field_flag_nf =
 				REG_FIELD(STK3310_REG_FLAG, 0, 0);
 
+static const u8 stk3310_chip_ids[] = {
+	STK3310_CHIP_ID_VAL,
+	STK3311X_CHIP_ID_VAL,
+	STK3311_CHIP_ID_VAL,
+	STK3335_CHIP_ID_VAL,
+};
+
 /* Estimate maximum proximity values with regard to measurement scale. */
 static const int stk3310_ps_max[4] = {
 	STK3310_PS_MAX_VAL / 640,
@@ -197,6 +204,16 @@ static const struct attribute_group stk3310_attribute_group = {
 	.attrs = stk3310_attributes
 };
 
+static int stk3310_check_chip_id(const u8 chip_id)
+{
+	for (int i = 0; i < ARRAY_SIZE(stk3310_chip_ids); i++) {
+		if (chip_id == stk3310_chip_ids[i])
+			return 0;
+	}
+
+	return -ENODEV;
+}
+
 static int stk3310_get_index(const int table[][2], int table_size,
 			     int val, int val2)
 {
@@ -473,12 +490,9 @@ static int stk3310_init(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
-	if (chipid != STK3310_CHIP_ID_VAL &&
-	    chipid != STK3311_CHIP_ID_VAL &&
-	    chipid != STK3311X_CHIP_ID_VAL &&
-	    chipid != STK3335_CHIP_ID_VAL) {
+	ret = stk3310_check_chip_id(chipid);
+	if (ret < 0)
 		dev_warn(&client->dev, "unknown chip id: 0x%x\n", chipid);
-	}
 
 	state = STK3310_STATE_EN_ALS | STK3310_STATE_EN_PS;
 	ret = stk3310_set_state(data, state);

-- 
2.45.1


