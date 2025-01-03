Return-Path: <linux-iio+bounces-13879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA221A0088C
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jan 2025 12:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56C73A479A
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jan 2025 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A2D1F9A8A;
	Fri,  3 Jan 2025 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rz5rGoTU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A01527AC;
	Fri,  3 Jan 2025 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735903243; cv=none; b=S3L0jjqZJZwCtMOZIVDbB4EeqQ9m3PnYR6psjtFAtDBoeJ7yMh0invbi03ZAkNZgK0T/TZS2ZehUDkS+SlDDi0zZyXvHu8NA0um9PvBZdIZ09p13Vyu0+VNgZCqi2W3RkLhsmSdgJe/GHi/bXtGyQ5i9GZYTN8sN+/nwHsdGciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735903243; c=relaxed/simple;
	bh=uyrlwtQE4rMHn9I5GAmKy1khgpbtrM6HHWX2r3idiWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bbYQd06vzXguJAyd9p1D2bhMQXeFSIud2XrlOQ2H8Xt43vqb3OlYNS9D1mNpYv6dFcEDNATqgkVDLwVTso/ybsvoNhI80rks0r0TYnjTXFfonYpqFy9lRW4vt0dWKGaUw4UyqgGLs+HHy310FH6u1V4nlhXGYo7U1xVlShMDhpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rz5rGoTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C336C4CECE;
	Fri,  3 Jan 2025 11:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735903242;
	bh=uyrlwtQE4rMHn9I5GAmKy1khgpbtrM6HHWX2r3idiWo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Rz5rGoTUUIqZ5wPBXjA5r5mG8d+j9sK8RKMUabtBOHXlDUpL6dzaUo0Od9KSyF3dL
	 nG8KZrUTPySd/ef4wrD0fwGZz2RDAj/T+PWQTbwyxAQjPuqpefSgkEpTOwC/Gk5QuO
	 75IYhzAXie2UxYKtQEbafKMHN49LKT+Gutgt70HIE9WqtMQ/CKi1Oo3L6umxRPf0UC
	 kBbhpX8bBNvhorqs6n5cx4JI4n2Wt0oHejIjEZzUwj1dTicWN8/azjw2BmGNBTsoMB
	 l2R70IGcKj4q5v3jQ/gXLmUOAhcxBd77A38cORiN4WOeH6tcjPXIsBvUkep062DOnR
	 3c8Gsd1LvHeKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662ADE77188;
	Fri,  3 Jan 2025 11:20:42 +0000 (UTC)
From: Nayab Sayed via B4 Relay <devnull+nayabbasha.sayed.microchip.com@kernel.org>
Date: Fri, 03 Jan 2025 16:50:40 +0530
Subject: [PATCH] iio: adc: at91-sama5d2_adc: fix sama7g5 realbits value
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-fix-sama7g5-adc-realbits-v1-1-1732d265c36a@microchip.com>
X-B4-Tracking: v=1; b=H4sIAAfId2cC/x2MQQqDMBAAvyJ77kISSaN+pfSwmo0uaJRsKQXx7
 4YeB2bmBOUirDA0JxT+isqeK9hHA9NCeWaUWBmccd5Y02KSHyptFGaPFCcsTOsoH8U2pKdLXe9
 8DFDzo3B1/+vX+7puS12KlmoAAAA=
To: Eugen Hristev <eugen.hristev@linaro.org>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Nayab Sayed <nayabbasha.sayed@microchip.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4982;
 i=nayabbasha.sayed@microchip.com; h=from:subject:message-id;
 bh=Za46OdRtTJEi9yRlw0XaUeuB5ttTzM/pmijAikNetGo=;
 b=owGbwMvMwCEmfMj/xNz7ei8ZT6slMaSXn+BIC/gt+P2Y6tTyP2WJ29d7aRSpWzVubtHgv3msc
 eNklUMtHaUsDGIcDLJiiizdm+fPNiz605n5k3MFzBxWJpAhDFycAjARw8UM/3OvJDdr7fi0+UnW
 ux0repqMJm/g5Ha9nsjNX7jxS5e2xBGG/2Vmf8N3/kj4q+227CqX+Yk1Z0oL5pyznaFgyOK57uZ
 BH04A
X-Developer-Key: i=nayabbasha.sayed@microchip.com; a=openpgp;
 fpr=E108A58C09FB2280B0AB41DAE24318EF3B3861A3
X-Endpoint-Received: by B4 Relay for nayabbasha.sayed@microchip.com/default
 with auth_id=304
X-Original-From: Nayab Sayed <nayabbasha.sayed@microchip.com>
Reply-To: nayabbasha.sayed@microchip.com

From: Nayab Sayed <nayabbasha.sayed@microchip.com>

The number of valid bits in SAMA7G5 ADC channel data register are 16.
Hence changing the realbits value to 16

Signed-off-by: Nayab Sayed <nayabbasha.sayed@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 68 ++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 8e5aaf15a921..c3a1dea2aa82 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -329,7 +329,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 #define AT91_HWFIFO_MAX_SIZE_STR	"128"
 #define AT91_HWFIFO_MAX_SIZE		128
 
-#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
+#define AT91_SAMA_CHAN_SINGLE(index, num, addr, rbits)			\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.channel = num,						\
@@ -337,7 +337,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.scan_index = index,					\
 		.scan_type = {						\
 			.sign = 'u',					\
-			.realbits = 14,					\
+			.realbits = rbits,				\
 			.storagebits = 16,				\
 		},							\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
@@ -350,7 +350,13 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.indexed = 1,						\
 	}
 
-#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)			\
+#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
+	AT91_SAMA_CHAN_SINGLE(index, num, addr, 14)
+
+#define AT91_SAMA7G5_CHAN_SINGLE(index, num, addr)			\
+	AT91_SAMA_CHAN_SINGLE(index, num, addr, 16)
+
+#define AT91_SAMA_CHAN_DIFF(index, num, num2, addr, rbits)		\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.differential = 1,					\
@@ -360,7 +366,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.scan_index = index,					\
 		.scan_type = {						\
 			.sign = 's',					\
-			.realbits = 14,					\
+			.realbits = rbits,				\
 			.storagebits = 16,				\
 		},							\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
@@ -373,6 +379,12 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.indexed = 1,						\
 	}
 
+#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)			\
+	AT91_SAMA_CHAN_DIFF(index, num, num2, addr, 14)
+
+#define AT91_SAMA7G5_CHAN_DIFF(index, num, num2, addr)			\
+	AT91_SAMA_CHAN_DIFF(index, num, num2, addr, 16)
+
 #define AT91_SAMA5D2_CHAN_TOUCH(num, name, mod)				\
 	{								\
 		.type = IIO_POSITIONRELATIVE,				\
@@ -666,30 +678,30 @@ static const struct iio_chan_spec at91_sama5d2_adc_channels[] = {
 };
 
 static const struct iio_chan_spec at91_sama7g5_adc_channels[] = {
-	AT91_SAMA5D2_CHAN_SINGLE(0, 0, 0x60),
-	AT91_SAMA5D2_CHAN_SINGLE(1, 1, 0x64),
-	AT91_SAMA5D2_CHAN_SINGLE(2, 2, 0x68),
-	AT91_SAMA5D2_CHAN_SINGLE(3, 3, 0x6c),
-	AT91_SAMA5D2_CHAN_SINGLE(4, 4, 0x70),
-	AT91_SAMA5D2_CHAN_SINGLE(5, 5, 0x74),
-	AT91_SAMA5D2_CHAN_SINGLE(6, 6, 0x78),
-	AT91_SAMA5D2_CHAN_SINGLE(7, 7, 0x7c),
-	AT91_SAMA5D2_CHAN_SINGLE(8, 8, 0x80),
-	AT91_SAMA5D2_CHAN_SINGLE(9, 9, 0x84),
-	AT91_SAMA5D2_CHAN_SINGLE(10, 10, 0x88),
-	AT91_SAMA5D2_CHAN_SINGLE(11, 11, 0x8c),
-	AT91_SAMA5D2_CHAN_SINGLE(12, 12, 0x90),
-	AT91_SAMA5D2_CHAN_SINGLE(13, 13, 0x94),
-	AT91_SAMA5D2_CHAN_SINGLE(14, 14, 0x98),
-	AT91_SAMA5D2_CHAN_SINGLE(15, 15, 0x9c),
-	AT91_SAMA5D2_CHAN_DIFF(16, 0, 1, 0x60),
-	AT91_SAMA5D2_CHAN_DIFF(17, 2, 3, 0x68),
-	AT91_SAMA5D2_CHAN_DIFF(18, 4, 5, 0x70),
-	AT91_SAMA5D2_CHAN_DIFF(19, 6, 7, 0x78),
-	AT91_SAMA5D2_CHAN_DIFF(20, 8, 9, 0x80),
-	AT91_SAMA5D2_CHAN_DIFF(21, 10, 11, 0x88),
-	AT91_SAMA5D2_CHAN_DIFF(22, 12, 13, 0x90),
-	AT91_SAMA5D2_CHAN_DIFF(23, 14, 15, 0x98),
+	AT91_SAMA7G5_CHAN_SINGLE(0, 0, 0x60),
+	AT91_SAMA7G5_CHAN_SINGLE(1, 1, 0x64),
+	AT91_SAMA7G5_CHAN_SINGLE(2, 2, 0x68),
+	AT91_SAMA7G5_CHAN_SINGLE(3, 3, 0x6c),
+	AT91_SAMA7G5_CHAN_SINGLE(4, 4, 0x70),
+	AT91_SAMA7G5_CHAN_SINGLE(5, 5, 0x74),
+	AT91_SAMA7G5_CHAN_SINGLE(6, 6, 0x78),
+	AT91_SAMA7G5_CHAN_SINGLE(7, 7, 0x7c),
+	AT91_SAMA7G5_CHAN_SINGLE(8, 8, 0x80),
+	AT91_SAMA7G5_CHAN_SINGLE(9, 9, 0x84),
+	AT91_SAMA7G5_CHAN_SINGLE(10, 10, 0x88),
+	AT91_SAMA7G5_CHAN_SINGLE(11, 11, 0x8c),
+	AT91_SAMA7G5_CHAN_SINGLE(12, 12, 0x90),
+	AT91_SAMA7G5_CHAN_SINGLE(13, 13, 0x94),
+	AT91_SAMA7G5_CHAN_SINGLE(14, 14, 0x98),
+	AT91_SAMA7G5_CHAN_SINGLE(15, 15, 0x9c),
+	AT91_SAMA7G5_CHAN_DIFF(16, 0, 1, 0x60),
+	AT91_SAMA7G5_CHAN_DIFF(17, 2, 3, 0x68),
+	AT91_SAMA7G5_CHAN_DIFF(18, 4, 5, 0x70),
+	AT91_SAMA7G5_CHAN_DIFF(19, 6, 7, 0x78),
+	AT91_SAMA7G5_CHAN_DIFF(20, 8, 9, 0x80),
+	AT91_SAMA7G5_CHAN_DIFF(21, 10, 11, 0x88),
+	AT91_SAMA7G5_CHAN_DIFF(22, 12, 13, 0x90),
+	AT91_SAMA7G5_CHAN_DIFF(23, 14, 15, 0x98),
 	IIO_CHAN_SOFT_TIMESTAMP(24),
 	AT91_SAMA5D2_CHAN_TEMP(AT91_SAMA7G5_ADC_TEMP_CHANNEL, "temp", 0xdc),
 };

---
base-commit: 0bc21e701a6ffacfdde7f04f87d664d82e8a13bf
change-id: 20250103-fix-sama7g5-adc-realbits-37f62f8925d7

Best regards,
-- 
Nayab Sayed <nayabbasha.sayed@microchip.com>



