Return-Path: <linux-iio+bounces-26488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D68CC8B234
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 18:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EED034E5A57
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 17:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C32F296BD6;
	Wed, 26 Nov 2025 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHPWC22W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9857333EB1A
	for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176946; cv=none; b=M8ZMuxC3Sjp8JR1mRLLCnrQqeM2NxC6D1OJV6wINK1wVIDacKbd/fxviTstf+R+8wmE9KOZRGjaFVCN0tBB8TRAJ5ClE1Bt+vBygw0b4JLQYCqDM7smL8QKzYndExPhGQVEsfAGkhvrTml7idk0xYxkLZDCECm6wz3T6gqW+91M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176946; c=relaxed/simple;
	bh=qW8tXLd5ShzzTpoCm8nCDEciNAWHdo0iHMDw1njRAGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxbgAGFE0RKyGrzUwCrc9I22GdOk/8haOVCPZO+lZyzRPLYTfZe66NmGneoIdOOvuiDjfHE4x/l1+Ub/5ouc6ef4grrAAd5/EPvZ5Ce29zUS0sQib6/Dt0kXb2nxIdFjvtOid1a1BTIR4S7QSZXZjPi7aYZSliyImwa1PjgBozw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHPWC22W; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9371aca0a4dso3979015241.1
        for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 09:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764176942; x=1764781742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bOYQXBQKRt84sB6fxzpQlCXOZpHVd0saT5GpBPC3gs4=;
        b=nHPWC22WL7Y8PnzKIQt6vTtr21N8imil1s74NpL6ZyH+NAYg9f+yn9+gxC/Eha6u6I
         EwXHWRIOn5Tqjd4xx+v7W7OTDUaW+OlI3s785T26I4AsSAV6Iql3i8vt+B2MSBH55EMb
         MlY59Hem1ExzipDrIi0YuuNyCWwlU26ujdKhIzkXy1PhYWYIEKfCqtT3CLXmKccY5rUR
         2pEnABPaECIXc74X8v6nusnvMJGZ11Y3mgGZ7nQPGhfIgX4/hsuc0iDEq3ApH9mwyXLH
         sDzHTvIb8fqPmU9k+SKQsZnwf8mI93Ja9tGemFSlk5IVMe5gP8ZoX5pGEJzDjkFY0ENJ
         wzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764176942; x=1764781742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOYQXBQKRt84sB6fxzpQlCXOZpHVd0saT5GpBPC3gs4=;
        b=E1/m2J0KynCwB7HES87e0dRjZ2OHCou8+fUiViq9TI7rFAygMElavcOjfOrh1kpqkR
         aNS8PDHy8OXlp+sku80dvORW40g0K51ZK4yxQY+vIx9oL3ArgUu4Mpk358aJborSiJXd
         MNtyQj5Ke+KzonTUNWUXCvjs2ZkT2OaFBrNV8p/UiQmp6XqqqkvRh4v3ZdXUTqNZbBYB
         BLHEXddPQ7wLx0WB9GCMIVjiKoIexZzikqeBn/9b3BO/whGP0FC1HEsV1C11/e9nEY8t
         OmycEGycYu1baKQXLf4bHPWHtr6fy3OXcYerknzdNVvmbnEuhSxxOsf4WlueEJnvNWn8
         sLCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4uFMNjFwHM4jFclbJPDmun68hrAeMNUyG0pu2tjDzwddn7LqtNOEQEpUxZMBuJqMA6JH8svKbFuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4QmSGuYQmg1+YHiiko7mKXMBGAz8v+wYWIPYAFyBj1Kfg6u0
	ir1AN0lzZq6zw0G+Q5BQPc98knBPBEj8AQcg9EUJy4t6nrzxz5nGBrnt
X-Gm-Gg: ASbGncsiiUMUzWB6FAk05ILarQv4QFTvDDkjE/1IFb4LhJ5oEYnpRzy3ncsdv1Kfi+7
	FBqz4gxFAIUCIjalGQjJI+Ctw0KZRB+e0MwYX2bl59XHRmZ0lRhzppitqLcrCRZaiHBEgYppMsC
	FlZ277J++l1TuABms+yeKbYfqtbHlG0fqxl+w+ecN6kMcESpJxN9V+MXjDa8fGC4DxjVxf7d2tx
	JqLjsRC3LUJcsQmvk4vAKwDGWntKWQacwJZJGqAFmp/NyEo9/cMUHQFObpY8oGQ6zJ726vmehZK
	8cP+LIjInP10pbJpz+nGteaI0wVbSVFaoTuMHgVtt5qwV5OjQinkljiZfDoJ1RUZCUgBk2Fn3nL
	D5hb6XtCk+aR+D8j7U+f2r7Fz8+URjIb3gl9feScvkcInCjyb5MLIFqPIyeRdTGfi/SE3Z0NhM7
	WoqYT/8Y5GBC1zv6jYZUIxLOE9PNnpc1lCuW7A4OpH7TcydmthBczFYmUJtgrh4CqjrEFHUtDj/
	BBsrD3BncleNP3xlOlADetRrLaufh8FYP42oVVOMhrfWAbEGbxRRTL8e8/PYH3qSOKDmLxfxJww
	loAYci/C
X-Google-Smtp-Source: AGHT+IGHuJouF9UR6xqnI02GMUOGYe7k7wq+oVegGncp2NT/BhHgaVnFptWB1QP50nLtgdS1L3j8Vg==
X-Received: by 2002:a05:6102:5a8f:b0:5df:af0f:308c with SMTP id ada2fe7eead31-5e1de345e11mr7307462137.38.1764176941718;
        Wed, 26 Nov 2025 09:09:01 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.230])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e1bd9687b0sm7890263137.6.2025.11.26.09.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 09:09:01 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: jic23@kernel.org (maintainer:IIO SUBSYSTEM AND DRIVERS,added_lines:860/863=100%),
	tomasborquez13@gmail.com (authored:1/1=100%,added_lines:860/863=100%,removed_lines:3/3=100%),
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Tomas Borquez <tomasborquez13@gmail.com>,
	jic23@kernel.org (maintainer:IIO SUBSYSTEM AND DRIVERS,added_lines:860/863=100%),
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: isl29018.c: replace sprintf with safer alternatives
Date: Wed, 26 Nov 2025 14:08:13 -0300
Message-ID: <20251126170814.4827-1-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch replaces sprintf with sysfs_emit and sysfs_emit_at safer alternative
with no functional changes.

Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
---
 drivers/iio/light/isl29018.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index 1b4c18423..d00e951c5 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -273,7 +273,7 @@ static ssize_t in_illuminance_scale_available_show
 
 	mutex_lock(&chip->lock);
 	for (i = 0; i < ARRAY_SIZE(isl29018_scales[chip->int_time]); ++i)
-		len += sprintf(buf + len, "%d.%06d ",
+		len += sysfs_emit_at(buf, len, "%d.%06d ",
 			       isl29018_scales[chip->int_time][i].scale,
 			       isl29018_scales[chip->int_time][i].uscale);
 	mutex_unlock(&chip->lock);
@@ -293,7 +293,7 @@ static ssize_t in_illuminance_integration_time_available_show
 	int len = 0;
 
 	for (i = 0; i < ARRAY_SIZE(isl29018_int_utimes[chip->type]); ++i)
-		len += sprintf(buf + len, "0.%06d ",
+		len += sysfs_emit_at(buf, len, "0.%06d ",
 			       isl29018_int_utimes[chip->type][i]);
 
 	buf[len - 1] = '\n';
@@ -330,7 +330,7 @@ static ssize_t proximity_on_chip_ambient_infrared_suppression_show
 	 * Return the "proximity scheme" i.e. if the chip does on chip
 	 * infrared suppression (1 means perform on chip suppression)
 	 */
-	return sprintf(buf, "%d\n", chip->prox_scheme);
+	return sysfs_emit(buf, "%d\n", chip->prox_scheme);
 }
 
 static ssize_t proximity_on_chip_ambient_infrared_suppression_store
-- 
2.43.0


