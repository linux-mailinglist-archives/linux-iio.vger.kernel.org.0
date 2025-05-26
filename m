Return-Path: <linux-iio+bounces-19959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D466EAC459D
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 01:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509C3189C794
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 23:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE711F4E34;
	Mon, 26 May 2025 23:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clfa0fzB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CEF2566
	for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 23:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748303964; cv=none; b=pNr5nkOSsuzmxIBsVnE/od7XNNrDL5vOgCp5G3rcbQIsipvLLgLIwZqFZYCumMtXQVZeu29zamufepp6cqBEIOlFm4oioJM4puPFodSnEmJJjRSsvf5bLQUC+GMquHFp3IZKvRNrI7J1frK7lFcqPbrC00Y2QDYEBSnQrLowtUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748303964; c=relaxed/simple;
	bh=IAybVV3PdDkzoJWj0UEoSrMSfg/7CtpbHOtf7EF4nkU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UcLS5tGbXews8jOqW3eBeO+n9eiDren1GGp+sG9O4JyKFYUvEEUvGtivvyO1FMzvQJB0j3x2GXyVktxitT+cCHl1TglRMDgZHcCCHGerE2XsREqR/dkPSJFsgwiKKzWDKirz1ZW5RcexS3K/88XJ+9sHZpjBZUoQiBbsgZsTJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clfa0fzB; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5240a432462so1705659e0c.1
        for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 16:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748303961; x=1748908761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+f4ntwhHjGj0BHi39HIj2cTB6hRtWEn2silGedZWh8=;
        b=clfa0fzBZM62Ic28H7Qz9O5TWrCKftbyd8bHd/SKrFIS4HlmU6VDoNIrAwZhYX0Gtl
         DCn23zp6bEG6z5ASbHNCqa1pcrFzAY6ztMzE0ux/niV1O4RtrM/e8dLUcaU2yNBQnuka
         Wi5V8FBy+UqK++LxHiANhXJUQtaefO+jGg1Ys5LcelXT0oX45S1jMCBdaPyVOsL2vIWe
         pHWb2TRzEeSwQzqcP/F9yzoV1XYKEEeblW4mWKNjZXFsYyazIz4+god0valPPhvKvv6b
         myXXxejroLaUlX5DhqAUalI0HtIk1AUGQbi3U9bSGiav9BXtWkXWc/+sxNK7kh7GI5zO
         T7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748303961; x=1748908761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+f4ntwhHjGj0BHi39HIj2cTB6hRtWEn2silGedZWh8=;
        b=gdAvkE/wO3WkpML9wJQM7fmatEc9F2IfjJRD4b+zFT4HLLRz/H2bTETZMDQMweGpP7
         SMKesTPsduu3tzQkRGqEaR1gdmYIVJJJj6bnw1Kixhp/O/10mItghx8+Jz9HBYOjht0P
         6Xm4X8oo+g1t8IUCb+gkIoXy4dfMimP1jEl+ZMFFRxQ+5QoZ4DBQfLvrQhju1bSaKhJw
         Ey0KRXJyM7rVG/VzSSHp4OP9O8Ubo5nEUKdUmHvf2vhSwkDRgJRb0FsaOBQOtulAoRUi
         sYLdeP8TXpucVBuRe6BQBvgRHf0CAuaQQBACPXV6oe9TNTcEML2FeTqfSvh2VdsEipOC
         yLOg==
X-Forwarded-Encrypted: i=1; AJvYcCVKhlbnTDo0TazuNlmTxn56If7tW7PTmpHFeeuGrJ2Kur9GlkhIsczONoUhOld9p7ig8y0IyPZzOhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz694Q5EQq0RS7xzOTpqpKOeRWd9lhqZcrhUpfaOSdqFGgrHg6y
	bGGNl7OjEnlaaBrNhzEzxJi9IfcpuUz8UZPEjITcQJuWowCpbZQ5Csvc
X-Gm-Gg: ASbGncvW7wn/l4CcAzaokOOn5OaNp2tq52chQGRUcancJWuJdXZygJRv3SahlHYLjkJ
	fDr+2ZzDAE55Zu2q20lOO4KHU7TtW3NlfnsECrUIOB9l01jIg1aTEsQ2I5ivnkVDJIgEXxPPvBm
	vNTB6o4Gijlxvv7wsQ//46yYtZL9fxvPP23K5M71DUohcng8MsJhWFOPIBmItMwlEK8L77ZsSPz
	TUAdqzfUso8k5c7z3SvzVfNQgTB00qmwD2ODSl+2GcEls5g6qcZbv3CtZN4VVKpdalxVaI+BQTs
	r4R/TdWiYo7+/cr3ieqbimrj85bm9Co5h6XyL3AzgqXL0fIXyaBIRKyqdnz5pqK78IgmlYDReNr
	jaWAsid4B+AarSgJ3j0bzlACTg8rq+O/EuBU/FpWl+BViblk=
X-Google-Smtp-Source: AGHT+IFXealT8//2E8ZoSsPWIh/puLduIDcVNEGZ5RuDPDKM/9PekN0OouR9XtYJi3JYpo1bs9Gptg==
X-Received: by 2002:a05:6122:4f9d:b0:524:2fe0:61bc with SMTP id 71dfb90a1353d-52f2c01b1fbmr8474131e0c.5.1748303961374;
        Mon, 26 May 2025 16:59:21 -0700 (PDT)
Received: from mintNaitss.meuintelbras.local (187.103.56.177.redfoxtelecom.com.br. [187.103.56.177])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87dff459239sm2393594241.14.2025.05.26.16.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 16:59:20 -0700 (PDT)
From: nattan <nattanferreira58@gmail.com>
To: subhajit.ghosh@tweaklogic.com,
	jic23@kernel.org
Cc: Nattan Ferreira <nattanferreira58@gmail.com>,
	Lucas Antonio <lucasantonio.santos@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3] iio: light: apds9306: Refactor threshold get/set functions to use helper
Date: Mon, 26 May 2025 20:59:06 -0300
Message-Id: <20250526235906.6598-1-nattanferreira58@gmail.com>
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
readability and maintains consistency
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


