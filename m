Return-Path: <linux-iio+bounces-21075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7ECAEC97E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62946189C701
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD231A704B;
	Sat, 28 Jun 2025 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QWqlaoeT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853B2155CB3
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751131916; cv=none; b=BBsQRAd5sC1MdWrlEfFsaYS6MzW017FLt12PRtatFHqt6fDUDp3dU07QlTsOepoZAWZvvM7ip83FamS4Kclx9b6B6Zzrq2VTZGQZJ6bOEoubWGhLjYWItHQw9YXdGfxS0k93r4TLXZmk7nUQuS+Wm4TK7zOmkwFja9ltxFx5PuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751131916; c=relaxed/simple;
	bh=mNlNcIDpJOuFxOzfuo0nWQ2Cmf1deme4AEktqDh7bL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UMhsGP+GV/3YVRKOMDu9SHyiyupWXU6WhAbc27Uugq1+0QiAi4HDg+99B5Yl3Qx2oNLeq35Bxr3pczLbPGxMyqyvzcTyMCrS4T7kRltT/xIcEvz8Nx/HpY3v/fUWfvWgYbMnXpi9PVGjx2+8bLIfkxfSIAZb1IcCYoFb2pD/WjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QWqlaoeT; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-401c43671ecso1707047b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 10:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751131913; x=1751736713; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a/rZ/BZZ6dj3yKfppO+1iRMMiSpP3Dh4QhplfHbi68c=;
        b=QWqlaoeTQJHcnj4eDY76pzJRKM2QwFBfAXw3iUHslMnRmiT1577+AR/DWAv0IGQnV1
         S9TnB60KWA6rJEYSQb5W5cVLjZkrhJuhsoQXZQfmsLdqtSUZ7HQnpp/p4G2NXCn+NSU6
         v+AcfOBe38SaqbyYNlZ0Syum6BcWqqImebglksDNIcHJ71FWjxZupawvCRp7FCvWdy4h
         E2RX1TFuMnzltj8riSQunfpGhaFN7TGuHE6AjK5KHNAoRYjS0KYRIL0aklOMQl7ckRLH
         4RD3UNg3hZ+Jmeev3G8gSCm+/I5HtaSYsp1GV8tSEZcET4gwV3+ugp8iL+FxCZ+s24zx
         xW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751131913; x=1751736713;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/rZ/BZZ6dj3yKfppO+1iRMMiSpP3Dh4QhplfHbi68c=;
        b=jlvGIxfZ2oQdxCPkR4Vo2UhYUrJAbpMSvE1XJJDWj1jcqVsSCkv6figapKuCYKXnn5
         ezDKHU7Oq58RiwP+PPQJxjyT6MpO+Zm/o8tK07azolF+ZAElnoCgI4MZo0mquoayZS/5
         xj7wD5GfdqcfT/mhqal8mpfa8eqT30EoZv8m//GZPRPjPDq9qtp8eo3VPPhoHuDOVDqt
         sxpSOi32f5P4w5F72W6Y3pGaoBfPFfJh8cojWResm/lOHh/A85vQZbjLnVAjdKQo+iKg
         5dfqbD/eYkUrHZhPKf2q29KGEPMEsvPKGacKgBQS4AFqHT83exuWzFn7khoMx+PPJVhd
         +mDw==
X-Gm-Message-State: AOJu0YzJgRmDn+LHP3vDP3+et8yY9rHqGVL2y688rdDWQjaB7EZqWzMs
	LP16E1KquxqZ/LwrXrrlR6728Hbk87wIVu8lm1L/aGHmYMC75K/xJv8nMzFCwYoRfgE=
X-Gm-Gg: ASbGncs2AFqcv6jUJYntRNPSilFASq1ZT13eHdbVz4gfIItQHT9F9hHP1mkBT8LF2sM
	1FFgwMY0FDkcTN4tF121EkX8+B4EQu3DRafX9fJ/DrxuIQR8/Y1XtQLsPhuNHxuAlFlqAXku2Pu
	EqofQ/q+dzeu3VDDho6pcjpUC7StpCPnGF4vV98RbhryrKw/sHQeuMenf6QgQ8CTiRFi53x55F5
	a1G8Z4O4ux8de7O1GIZ/tcoaI5P2uJj///EXcNXEP794J0ZLHYpJiWpbL7tW/NWnqdB2tY+ZePH
	AOs7FicSyw7zNv3DQjZcTvy78rpIl/h7JhWTg/Td/0cLrLIMGXblGNz3bT5NbZxKcUCh
X-Google-Smtp-Source: AGHT+IHN6ojHQDxt1Bx0mZTR0H0cL5vmfW7pJKbLefP/CkbpptVvu96oSnp+TX4rwF0z98uc0D6FGw==
X-Received: by 2002:a05:6808:48cc:b0:40b:52ff:7a62 with SMTP id 5614622812f47-40b52ff7af1mr997475b6e.8.1751131913560;
        Sat, 28 Jun 2025 10:31:53 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322ae4e9sm895241b6e.17.2025.06.28.10.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 10:31:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 12:31:43 -0500
Subject: [PATCH] iio: imu: bmi160: make bmi160_regs const
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-18-v1-1-dad85ac392ae@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAP4mYGgC/x3MTQqAIBBA4avIrBswrZCuEi38mWo2GioRRHdPW
 n6L9x4olJkKzOKBTBcXTrGh7wT4w8adkEMzKKlGOSmDzAl9iqVisNVib9AZ7YLTNAQ5QuvOTBv
 f/3NZ3/cDfG7BrGMAAAA=
X-Change-ID: 20250628-iio-const-data-18-b83bdb3e4d05
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=mNlNcIDpJOuFxOzfuo0nWQ2Cmf1deme4AEktqDh7bL0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYCcB/CkRqcoJ0X+ucTtszV8cbkFH/qYauTxfa
 PkNJhg+/KyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAnAQAKCRDCzCAB/wGP
 wFtyCACfsx4BEqaYVAkiPaTJ/aV9allSyiIY1u09Zfcyt1QNyg1WaTEVlYCyoGvB4WM+09mtHNa
 jsN9iRfbZKKHQNedart11F1+LpEIOgVbNNUPlUvPKHHVEdx3VKiOwtrNTatcW2hYbC5Tj8Mcsm0
 DRAWH6atLgJrP5ZSaK927EM5aTgb6gdKdgtqDtAXne7AFMS2PGazauN6KqS/KhlOYlP3fHzSBm6
 fvmELEftOg9FgEtwMIiOT+HNsRECXN3HWZPkJbkNVM55rFKbzB7Jvxc4E2fWlaxi2qSDmdqb888
 P9yuxCGXaFglspAWFFxznyh07YGFxOaHPuWvF/9Ew2Iu7LI2
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add const qualifier to struct bmi160_regs bmi160_regs[]. This is
read-only data so it can be made const.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 9aa54b95b89f96299e65b9cc00149bffe5f2e56a..5f47708b4c5dc5b2eb139b1c36542aae22a4cf43 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -161,7 +161,7 @@ struct bmi160_regs {
 	u8 pmu_cmd_suspend;
 };
 
-static struct bmi160_regs bmi160_regs[] = {
+static const struct bmi160_regs bmi160_regs[] = {
 	[BMI160_ACCEL] = {
 		.data	= BMI160_REG_DATA_ACCEL_XOUT_L,
 		.config	= BMI160_REG_ACCEL_CONFIG,

---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-18-b83bdb3e4d05

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


