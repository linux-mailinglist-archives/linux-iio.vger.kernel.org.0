Return-Path: <linux-iio+bounces-709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1086E808801
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 13:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334841C21EEA
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 12:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D7F3D0AF;
	Thu,  7 Dec 2023 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa8LrPQv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E5539AEC
	for <linux-iio@vger.kernel.org>; Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44D8DC433CA;
	Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701952769;
	bh=I46x+Q6cS1JwJI4Vzol1UNr3HKANv6YdPVp0kp3qLQc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fa8LrPQv1XE6LV+9SffshCSy7H8E98WfIpsZYogiEOvIhOGQ73HsRp7GchdZvLXIT
	 gXmzmAy/oWA+W/ap615g58OpBZDsMxRl4EQiO0fTQcI94n4O8Fmz+mb/FG71xik8KR
	 HNecrrfRiLHy2b610bODZs9bWj18DTXVvotBM8HGHzFn3KvZizZoGR31p9Frd20yCQ
	 cJw3v/PcxcDk3ze1UdTV/1S+MKhLzntKMG9guVMFLHOx80tubeKureVM32ypLqVUNx
	 UHtbUtM1ozR4EM25VS7CnH2K4FGXPASHISNoevsWjn3DJLs93g4uUdXjvV/VAZbnbb
	 X3wS199R8SHZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D880C10F04;
	Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 07 Dec 2023 13:39:25 +0100
Subject: [PATCH v2 2/8] iio: adc: ad9467: don't ignore error codes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-iio-backend-prep-v2-2-a4a33bc4d70e@analog.com>
References: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
In-Reply-To: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701952767; l=2421;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=TTJeddt+uQ4LdUNd3Li2fz6xciLFTl3Pxyuj2F+94eU=;
 b=I+rA/LFl1wAmX+tO4S5Pe4DRI2TNTdGunbSGfke0fWE8YoKoaB72q0A2T/PHQL4o3GQJ2GjjB
 79hRIngIxpxDg2p0IKfPSvkvqspHO7TXA/iMzKEiEZ3I1Yqw2HOZHcw
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Make sure functions that return errors are not ignored.

Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 4fb9e48dc782..d3c98c4eccd3 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -162,9 +162,10 @@ static int ad9467_reg_access(struct adi_axi_adc_conv *conv, unsigned int reg,
 
 	if (readval == NULL) {
 		ret = ad9467_spi_write(spi, reg, writeval);
-		ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
-				 AN877_ADC_TRANSFER_SYNC);
-		return ret;
+		if (ret)
+			return ret;
+		return ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
+					AN877_ADC_TRANSFER_SYNC);
 	}
 
 	ret = ad9467_spi_read(spi, reg);
@@ -272,10 +273,13 @@ static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
 	const struct ad9467_chip_info *info1 = to_ad9467_chip_info(info);
 	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
 	unsigned int i, vref_val;
+	int ret;
 
-	vref_val = ad9467_spi_read(st->spi, AN877_ADC_REG_VREF);
+	ret = ad9467_spi_read(st->spi, AN877_ADC_REG_VREF);
+	if (ret < 0)
+		return ret;
 
-	vref_val &= info1->vref_mask;
+	vref_val = ret & info1->vref_mask;
 
 	for (i = 0; i < info->num_scales; i++) {
 		if (vref_val == info->scale_table[i][1])
@@ -296,6 +300,7 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
 	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
 	unsigned int scale_val[2];
 	unsigned int i;
+	int ret;
 
 	if (val != 0)
 		return -EINVAL;
@@ -305,11 +310,13 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
 		if (scale_val[0] != val || scale_val[1] != val2)
 			continue;
 
-		ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
-				 info->scale_table[i][1]);
-		ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
-				 AN877_ADC_TRANSFER_SYNC);
-		return 0;
+		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
+				       info->scale_table[i][1]);
+		if (ret < 0)
+			return ret;
+
+		return ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
+					AN877_ADC_TRANSFER_SYNC);
 	}
 
 	return -EINVAL;

-- 
2.43.0


