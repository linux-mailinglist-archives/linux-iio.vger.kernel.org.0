Return-Path: <linux-iio+bounces-24540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9847ABA7576
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 19:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 664117A6CB6
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 17:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12259238C3A;
	Sun, 28 Sep 2025 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="hTjm3EU9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp4.goneo.de (smtp4.goneo.de [85.220.129.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F4221DAE
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080939; cv=none; b=lb08eZZ7ioTUeylI4ZaR/33a35jT/nPFus4oUNXhJnjwyyPclr6jAUjU9RQ7tnDfCNPoB0qcUXyPy3RyQOAfhhVLymSwy8koS3ibpS6ToQm4Hh5b0y3aUpTFqB0aXsPEnfoHro1Cg740B8wEiFD8hVbinCFC1W2eksMRHb5cxY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080939; c=relaxed/simple;
	bh=Qy9oXXi+4/u7B7twRsOsWRIsThzoMRTWMkUST1WJJak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6XrXRT0y4IYhV0XPyheC22cjwQA3HpxNzIUDrYoysufI9mRfhXzIt7ixdRQRT8ki/AIj4AwfD4OOqrpESlndE+TKiq2TEB5qLhlzan0jq7CVnuwmDGoXI29fq45DGRDTuhb6hFr8EnGuPfcOUzdEwikHm1rMKfN5HhP1U4slgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=hTjm3EU9; arc=none smtp.client-ip=85.220.129.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp4.goneo.de (Postfix) with ESMTPS id 7869B240BF1;
	Sun, 28 Sep 2025 19:27:21 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id D381F240752;
	Sun, 28 Sep 2025 19:27:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1759080439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zO+3SWWsLgZ6yIsjzdwUGlKOouMzNx9k5edIEri3BYs=;
	b=hTjm3EU9M+Nzyl/rv356UWlLLygCEOS3Wml9k0D3IEptOU7naIDnD+tJ8+2Xt3h0cKcFLO
	5Up90ABn3VzYAcyCgmE19PgCQMtcHjgr1UZGJD4KVUjooMBD/24+aRmdflfTrosyXwP8ct
	+mPtuo8Rv4BIrQ0AU/vMyyW+NvHc22+HQelIkTKA3ZG166fd214d6/nLm3/lA7FGJkj/cC
	dzQ5qTb9MEkD95Oephd6VY/6yv9PSuDRF58yN6K3ePlkrK82QjXV+gX531DUCgDFHBsfXH
	R0PoG2U52H74R+R6dA0GLc1JnLUrTQHIy9S0RKZVh4nfl83TjQ3lsXsd/qV1Lw==
Received: from Gerda.fritz.box (p5b2f36f7.dip0.t-ipconnect.de [91.47.54.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 953DA240562;
	Sun, 28 Sep 2025 19:27:19 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v3 3/9] iio: pressure: bmp280: implement adaptive wait for BMP380 devices
Date: Sun, 28 Sep 2025 19:26:31 +0200
Message-ID: <20250928172637.37138-5-Achim.Gratz@Stromeko.DE>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
References: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: e613e2
X-Rspamd-UID: 3bff02

Use same solution as for BMx280 devices. The variable meas_time_us is
changed to unsigned int in all *_wait_conv() implementations.

Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
---
 drivers/iio/pressure/bmp280-core.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index b413f1949952..cd305b6f022d 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1716,8 +1716,8 @@ static int bmp380_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
 
 static int bmp380_wait_conv(struct bmp280_data *data)
 {
-	unsigned int reg;
-	int ret, meas_time_us;
+	unsigned int reg, meas_time_us, initial_wait;
+	int ret;
 
 	/* Offset measurement time */
 	meas_time_us = BMP380_MEAS_OFFSET;
@@ -1730,10 +1730,15 @@ static int bmp380_wait_conv(struct bmp280_data *data)
 	meas_time_us += BMP380_TEMP_MEAS_OFFSET +
 		     BIT(data->oversampling_temp) * BMP380_MEAS_DUR;
 
-	/* Measurement time defined in Datasheet Section 3.9.2 */
-	fsleep(meas_time_us);
-
-	ret = regmap_read(data->regmap, BMP380_REG_STATUS, &reg);
+	/* See bmp280_wait_conv() */
+	initial_wait = (13 * meas_time_us) / 16;
+	fsleep(initial_wait);
+	meas_time_us -= initial_wait;
+	ret = regmap_read_poll_timeout(data->regmap, BMP280_REG_STATUS, reg,
+				       !((reg & BMP380_STATUS_DRDY_PRESS_MASK) &&
+					 (reg & BMP380_STATUS_DRDY_TEMP_MASK)),
+				       min(2 * USEC_PER_MSEC, meas_time_us >> 1),
+				       2 * USEC_PER_MSEC + meas_time_us);
 	if (ret) {
 		dev_err(data->dev, "failed to read status register.\n");
 		return ret;
@@ -2444,15 +2449,15 @@ static int bmp580_wait_conv(struct bmp280_data *data)
 	 * Taken from datasheet, Section 2 "Specification, Table 3 "Electrical
 	 * characteristics.
 	 */
-	static const int time_conv_press[] = {
+	static const unsigned int time_conv_press[] = {
 		0, 1050, 1785, 3045, 5670, 10920, 21420, 42420,
 		84420,
 	};
-	static const int time_conv_temp[] = {
+	static const unsigned int time_conv_temp[] = {
 		0, 1050, 1105, 1575, 2205, 3465, 6090, 11340,
 		21840,
 	};
-	int meas_time_us;
+	unsigned int meas_time_us;
 
 	meas_time_us = 4 * USEC_PER_MSEC +
 		       time_conv_temp[data->oversampling_temp] +
-- 
2.51.0


