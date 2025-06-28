Return-Path: <linux-iio+bounces-21053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FCBAEC89E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 18:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F706E0D06
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 16:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB69F2512E6;
	Sat, 28 Jun 2025 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R7wB8F/G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199E81FE47C
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751127424; cv=none; b=VKq3m2UlUCQqOmAT655F2pSPpzF6pHUhG5yZv/rrBv2gs9eOAP8hxTRRwAnwXP6D57GvGLc1eHizDpiEazumSuJX6OREsu+pOAdDap5MEAnP53anN7SnsjoyZHR3VCBST9bUgn7xaoMCV2MqhPS4wJDZ90ty47CdmTWsRCPpeJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751127424; c=relaxed/simple;
	bh=2/LbAe1qTum5Phb6CpzNWW+MODEYy9nt7TeYWzbG/I8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iO6ExmOyG4VRszVk52/oy/8/RoHOP4Ra172/AQQcTAlweZlNlEXxI9dAx34Z4J5WExJqhb2Qz/bmjnVU82UNvOo+yyaQAWfU90AFLwJ+Lx/UTYIDPNa1mWZOuH4IuLhp3X4dDwZUoDCIhEcdAM5qjdulUcj2Yuha4ID71BV/oQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R7wB8F/G; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-40a4de1753fso1925346b6e.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 09:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751127420; x=1751732220; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3TdZuCTZuT2e9KCAtNzZV7eXEZJGCtDgsXkSv6gcJjA=;
        b=R7wB8F/G3wnUL35ITKEYioKBnDusZIGBuunC7SbtNBYSywrkPkkmSSaVwGvP9XiF7o
         9ccRshnIwiiEvP7Kl0WJ4vKxpLL2/g2bK4uoFDa9t6yij+dfcqFv4kMy124N2w92osGz
         VTBc9vthcVYMDeV9Jwe6UBAu2tPDRogGsEwqWC5WjU0QJysyg1WWyOU/9DFxjEW/uBM7
         fTFwMveETIo0JDpprVNrSdZE5tBuaQ2e0UtaEEvcHCNI6KiLHeKwLaAJPhmTf2Az0Bae
         B4j6ikerK2Hytq4dW1CoCAJQo0Knf+vgYDeRZ7Z/576FwygPsJb5hqE0GE1A0ErynvN0
         e1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751127420; x=1751732220;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TdZuCTZuT2e9KCAtNzZV7eXEZJGCtDgsXkSv6gcJjA=;
        b=TlFksN1UGyrAUiL4aUVJXlJWhQTX2iBCH9Nj7b3gsWfkAfSltXQnPkp6ZHRl9T2td8
         76aZiCIwFvPR2dbXyR5tj+U3hL8dTJXxHcH7tAPQnGXmUcmk5yUzCNpHSOWIvqeuSDIO
         9fAMJUK1FXwncFash4P4aX3/StEZIARKiU8azpbVtGNrINocCBxOTBfgc/nAKYKnWrcf
         0jjQ69usjgkAsA5iJpHkJVlHoc7mh6kAqZbpLFyvpurILSy0Gtj/HJTa3q95yXsw1gxO
         6L3kA5YAXaGJRbUYDzrk/2vSk1MyZ8QGor2HmXPIu1CwCBfr4exZgke+3lKviBJbk0F1
         GOpw==
X-Gm-Message-State: AOJu0Yw75lqCC2BLD3gGB2drZ0kOXlbG2gkO/EA1XU/EPM6BLzcKubbM
	KU9XjHUvAs3Y1i0RW8on2xnq9c6gNwqqUc1aINrmhC7qH5aPgw9ExRj/3LSPHVDADtXkrUNEBYQ
	ZVWQJ0eQ=
X-Gm-Gg: ASbGnctp2fh8K3erb17LKhC1Z3b04zTWf/OItHKzilUgjf8LtRHmCRe2enLniIoIbzP
	yjKQ/XzcU4imK17jLyV+ZOktSedqGM2RUBXbZx/UYyd8KBM+MGmM/CzLwMSfXaw8hL2m7U1Y88B
	YpJyK9iEjo7OTzcRDjWDhXoBiyyqGYUviKl/aCYF/GMfhAlaJMn7shbd1Y/sNt79AsBfc1lCqLH
	jJqGcro1S+xLJxRldRNgtonJSZCqw6XavGDQ/j9aIIjQmI3rsmNyhJshm/RQfAg7kDUaBOtppDZ
	Wp8thE9OHB54OsuXUtwzkycka5++v1eVUvEvVVcJuSD03q7jD80Qzgi2gX0o4IyTlcqQ
X-Google-Smtp-Source: AGHT+IFcd/unK73GieITz7gj76ABkkquZ2Hzl/N6VWClFbcoMQjmjVOBO/l6Nb5ZZrGDpmT6Xz3g6g==
X-Received: by 2002:a05:6808:1827:b0:3f8:bbf3:3a18 with SMTP id 5614622812f47-40b1caee65fmr8876602b6e.16.1751127420129;
        Sat, 28 Jun 2025 09:17:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b32438b5bsm865081b6e.44.2025.06.28.09.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 09:16:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 11:16:51 -0500
Subject: [PATCH] iio: adc: ad7124: drop use of chip info array
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-5-v1-1-9e56c2f77979@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAHIVYGgC/x3MTQqAIBBA4avErBtQ8Y+uEi3EppqNhkYE4d2Tl
 t/ivRcqFaYK0/BCoZsr59QhxwHiEdJOyGs3KKGMsMojc8aYU71wDVdAgzpGL53VTgsHPTsLbfz
 8y3lp7QOb3UzOYgAAAA==
X-Change-ID: 20250628-iio-const-data-5-4cc817647407
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2626; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=2/LbAe1qTum5Phb6CpzNWW+MODEYy9nt7TeYWzbG/I8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYBV0GumZh+oLDP6uj0emzgxiCE4kMIRIQOesi
 +7I+H+b+kyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAVdAAKCRDCzCAB/wGP
 wLMhB/9qSQSj3PJ32vkzUjaYEfsPmlvCrlMYqMEpDp3qq6M0+Cojl9Sj7TrVIeTB1p/4y11agp+
 eCitSaCvyEpGxPP+Hgn5uQKTqFYgewxZy3Chd2UsehhTQUC7hmwdRF6ECF1sy08EXQsTrq3ZLsy
 HF1bszLciyyc44w9SMbCV9ZriiHGEACSU9uTXDVyPFWExnI+dLfyEl57bDliYbLtHb6pJOKHWiH
 TFTSOM4OTis7xEENJOigo/YBrmR8dx38HtYZOmVO9YwbOff40fjiYn7oQF09V6nDPlWugKZL2ER
 0lQ//q4vdFGJuGEd42sOWGriJZuUK8gHJHF8PlBFdYau+1xG
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Change the ad7124 driver to use individual chip info structures instead
of an array. This reduces the verbosity of the code. Also, the data is
now const as it should have been in the first place.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 92596f15e797378329d2072bff71e392664c69db..9808df2e92424283a86e9c105492c7447d071e44 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -94,11 +94,6 @@
 
 /* AD7124 input sources */
 
-enum ad7124_ids {
-	ID_AD7124_4,
-	ID_AD7124_8,
-};
-
 enum ad7124_ref_sel {
 	AD7124_REFIN1,
 	AD7124_REFIN2,
@@ -193,17 +188,16 @@ struct ad7124_state {
 	DECLARE_KFIFO(live_cfgs_fifo, struct ad7124_channel_config *, AD7124_MAX_CONFIGS);
 };
 
-static struct ad7124_chip_info ad7124_chip_info_tbl[] = {
-	[ID_AD7124_4] = {
-		.name = "ad7124-4",
-		.chip_id = AD7124_ID_DEVICE_ID_AD7124_4,
-		.num_inputs = 8,
-	},
-	[ID_AD7124_8] = {
-		.name = "ad7124-8",
-		.chip_id = AD7124_ID_DEVICE_ID_AD7124_8,
-		.num_inputs = 16,
-	},
+static const struct ad7124_chip_info ad7124_4_chip_info = {
+	.name = "ad7124-4",
+	.chip_id = AD7124_ID_DEVICE_ID_AD7124_4,
+	.num_inputs = 8,
+};
+
+static const struct ad7124_chip_info ad7124_8_chip_info = {
+	.name = "ad7124-8",
+	.chip_id = AD7124_ID_DEVICE_ID_AD7124_8,
+	.num_inputs = 16,
 };
 
 static int ad7124_find_closest_match(const int *array,
@@ -1341,17 +1335,15 @@ static int ad7124_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad7124_of_match[] = {
-	{ .compatible = "adi,ad7124-4",
-		.data = &ad7124_chip_info_tbl[ID_AD7124_4], },
-	{ .compatible = "adi,ad7124-8",
-		.data = &ad7124_chip_info_tbl[ID_AD7124_8], },
+	{ .compatible = "adi,ad7124-4", .data = &ad7124_4_chip_info },
+	{ .compatible = "adi,ad7124-8", .data = &ad7124_8_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7124_of_match);
 
 static const struct spi_device_id ad71124_ids[] = {
-	{ "ad7124-4", (kernel_ulong_t)&ad7124_chip_info_tbl[ID_AD7124_4] },
-	{ "ad7124-8", (kernel_ulong_t)&ad7124_chip_info_tbl[ID_AD7124_8] },
+	{ "ad7124-4", (kernel_ulong_t)&ad7124_4_chip_info },
+	{ "ad7124-8", (kernel_ulong_t)&ad7124_8_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad71124_ids);

---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-5-4cc817647407

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


