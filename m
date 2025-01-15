Return-Path: <linux-iio+bounces-14370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E62A11969
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 07:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF63167EC9
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 06:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D8D22E419;
	Wed, 15 Jan 2025 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klriy1RE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD3829A5;
	Wed, 15 Jan 2025 06:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736921241; cv=none; b=CINvkzoI2EsTMgOocIlM18yY3Kcohapg7p32+g/brYFlHLbOGZjFRZZi5dVYEocGw/l/Q+Jp8t5fFndccIaYxuOWLkDCUcWAPPkSIIMFE7zgWfSO3HLRYfptwZ/LpZjnCP/Xi1KbrXLO6JomDSqVjTs6Rnh2VRHg9XvAR/3KLKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736921241; c=relaxed/simple;
	bh=G3pI6qrl347DsNrfhtfFcgfX1IdLc/pFN8Nj/vWwpR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UELe35pHQIUG7e3eSs2gSSCE2sJFy1QS7VAaJzr06MamRRNDqcobJyM/eThLJ+w6eW8VGsINLfvwPT3qLwH9nTQlvytri5UeNmRB7H/ByhnPx1FE2SWr9j0LfhZ0dl4Ii8n1/vTMpek7BngBhraknxyAVL8CI632Uou5OFK59uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klriy1RE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B7E2C4CEDF;
	Wed, 15 Jan 2025 06:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736921239;
	bh=G3pI6qrl347DsNrfhtfFcgfX1IdLc/pFN8Nj/vWwpR8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=klriy1REuwnjgEjUpd4kQzTmN/IFdWD+qqyndBOME7ligMCRkrPtUMr+RLQrpM/Y/
	 AKSMT9e41yvkSB512aR+U/Xc+5f3ZVT98rP9LdyqEGfXCZ/4zZ3krXWlbMQv62RPsc
	 9aKFu0LtNnh2sgqvzvrNFf77jWoGiP14yK3FmmO5FYuGwpnY5aBKOcujxZJI8YQVyl
	 zvhBcX6eqgOTC2dhi9ouVGMx8cgaEQkPjREc0UmOmGEuO2ZYLxqxs9o8t2f6DyZ8bw
	 tfjFE8a34M+OQxCe+10E6j4wC8zo/GE/8fNXVxOHH0cVfd82KgUwmqNRNMduBFBJ7r
	 XYYVcZYA+aj2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0DEC02180;
	Wed, 15 Jan 2025 06:07:19 +0000 (UTC)
From: Nayab Sayed via B4 Relay <devnull+nayabbasha.sayed.microchip.com@kernel.org>
Date: Wed, 15 Jan 2025 11:37:04 +0530
Subject: [PATCH v2] iio: adc: at91-sama5d2_adc: fix sama7g5 realbits value
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-fix-sama7g5-adc-realbits-v2-1-58a6e4087584@microchip.com>
X-B4-Tracking: v=1; b=H4sIAIdQh2cC/42NTQ7CIBCFr9LM2jF0CEVdeQ/TBQJtJ5HSQEM0T
 e8u9gTmrb6X97NB9ol9hluzQfKFM8e5Ap0asJOZR4/sKgMJUqIVEgd+YzbB6FGhcRaTN68nrxm
 lHjoaLldSTkOtL8nX7DH96CtPnNeYPsdTaX/uH6OlxSotyVGnrOzMPbBN0U68nG0M0O/7/gXV7
 YAwxAAAAA==
To: Eugen Hristev <eugen.hristev@linaro.org>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Nayab Sayed <nayabbasha.sayed@microchip.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5233;
 i=nayabbasha.sayed@microchip.com; h=from:subject:message-id;
 bh=akVlIDY4JEv/jdH/CBhdCc65c1LeP0Vt27jvi+Wz5GY=;
 b=owGbwMvMwCEmfMj/xNz7ei8ZT6slMaS3B0ztTL3+/4ne+5WfzKxz1uR8cRVatqDx6tM5NQ4Xf
 6QoZlz43FHKwiDGwSArpsjSvXn+bMOiP52ZPzlXwMxhZQIZwsDFKQATCcpnZLi+d2a14iT/0BXJ
 Ygetert3/pn4Ud7br0Hn3d2WXL+8S0EM/0wCK3JU26IZYuV1Hjubn467ILAm/u6Ue3qZZ4MyGgR
 ucgEA
X-Developer-Key: i=nayabbasha.sayed@microchip.com; a=openpgp;
 fpr=E108A58C09FB2280B0AB41DAE24318EF3B3861A3
X-Endpoint-Received: by B4 Relay for nayabbasha.sayed@microchip.com/default
 with auth_id=304
X-Original-From: Nayab Sayed <nayabbasha.sayed@microchip.com>
Reply-To: nayabbasha.sayed@microchip.com

From: Nayab Sayed <nayabbasha.sayed@microchip.com>

The number of valid bits in SAMA7G5 ADC channel data register are 16.
Hence changing the realbits value to 16

Fixes: 840bf6cb983f ("iio: adc: at91-sama5d2_adc: add support for sama7g5 device")
Signed-off-by: Nayab Sayed <nayabbasha.sayed@microchip.com>
---
Changes in v2:
- Add `Fixes:` tag in commit message.
- Link to v1: https://lore.kernel.org/r/20250103-fix-sama7g5-adc-realbits-v1-1-1732d265c36a@microchip.com
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
base-commit: 619f0b6fad524f08d493a98d55bac9ab8895e3a6
change-id: 20250103-fix-sama7g5-adc-realbits-37f62f8925d7

Best regards,
-- 
Nayab Sayed <nayabbasha.sayed@microchip.com>



