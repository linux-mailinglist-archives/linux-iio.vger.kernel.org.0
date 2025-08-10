Return-Path: <linux-iio+bounces-22527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BD3B1FBD0
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 20:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6DC3B33F8
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 18:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BFF1FE46D;
	Sun, 10 Aug 2025 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="nEdEbzfS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp4.goneo.de (smtp4.goneo.de [85.220.129.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23431FDA82
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754852364; cv=none; b=MpbUBI8cfnIYK9YfQ7SxFJxmv7jXlWC+wWVCmWavG0+oHdkktmzBbYquaIRyf4tETHRchiegQvh1nGac0MdHW5GpAtQmfXaff8aXabr0UTsfoXa4WamAy8S+aovwJXlGMyc8RwaD94YUjJKv8E764ReqcygAkNKna69F6pOqPMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754852364; c=relaxed/simple;
	bh=d0yU1tt7uQLIT6eLW9eWC7ZLt0OU4BxM6uyRNqjSzB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THt9VW3fJgNPkasnvwaOoFM9V9HISmpgs/i9leLYdLZ2lsirC5GffTpPV+vQhJ9BXoENU4qDwWB+8Fq89BIpFs0mdbfNS5RMWfO1jfuXnghF7Sekba7roj8sJcROhohH8Oz+6AahnfSXKegIu2+kZH8JNJKAum0AduEAnWplGIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=nEdEbzfS; arc=none smtp.client-ip=85.220.129.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp4.goneo.de (Postfix) with ESMTPS id 5A0C2240854;
	Sun, 10 Aug 2025 20:59:15 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 7A2AC240195;
	Sun, 10 Aug 2025 20:59:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1754852353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8AxKzIIgZVtdgTTYx3zC/bFoq5UORAktnNm86UWVju0=;
	b=nEdEbzfSFbucCT3Gckf9jyUppfWTAAEUtLMsHpoX1DBR/AtcWmGtR9k27uXZ65KBIUSON+
	7RxvUx8BmOxxEqR0u6YZEsLSPM8xg7R6U0Td6YV2Eqi4BRpl8bttwzMDyssubpIZsnc9La
	H1//05ToNnLSEVMF6pO77IhBNRGB0/xYCUc23wEElGUJ0ExzAAFvCHyayXJVwcLEnmvaHl
	6kqzaNBIHNDSPrW8P/1zW2b0qewmpmYlmswUDPQzNT7UyMqgcPfszPh8nJ+hFBmta7dQt3
	aacvicXBTVOnuoXFjFiTmiXsyEA2/F2iy22a4dmzZ0FtcCTv9T8eiF+vB50YOA==
Received: from Gerda.fritz.box (p54a0c448.dip0.t-ipconnect.de [84.160.196.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 2C156240159;
	Sun, 10 Aug 2025 20:59:13 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v2 1/9] iio: pressure: bmp280: correct meas_time_us calculation
Date: Sun, 10 Aug 2025 20:58:38 +0200
Message-ID: <20250810185846.114355-2-Achim.Gratz@Stromeko.DE>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
 <20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: cb5233
X-Rspamd-UID: 0dd769

Correction of meas_time_us initialization based on an observation and
partial patch by David Lechner.

There was also a thinko in bmp280_wait_conv: data->oversampling_humid
can actually be 0 (for an oversampling_ratio of 1), so it can not be
used to detect the presence of the humidity measurement capability.
Use data->chip_info->oversampling_humid_avail instead, which is NULL
for chips that cannot measure humidity and therefore need to skip that
part of the calculation.

Closes: https://lore.kernel.org/linux-iio/875xgfg0wz.fsf@Gerda.invalid/
Fixes: 26ccfaa9ddaa ("iio: pressure: bmp280: Use sleep and forced mode for oneshot captures")
Suggested-by: David Lechner <dlechner@baylibre.com>
Tested-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>

---

Notes
=====

Since the BMx280 device support was added, oversampling=0
actually is a valid setting (meaning that measurement channel is off),
but actually allowing that setting to be used by changing the data
structure to hold the actual value instead of its ilog2 would require
more extensive changes elsewhere in the code.

Further changes would be necesary to avoid the awkward use of -1 as
the value that would currently be necessary to achieve a setting of 0
in the register.

Datasheet values and median actual measurement times through sysfs for
a single reading with my BME280 connected to a 400kHz I²C bus provided
by the i915 IGP VGA port:

|--------------+---------+---------+----------+----------|
| Oversampling | Typical | Maximum | Measured | Overhead |
|        Ratio |    [ms] |    [ms] |     [ms] |     [ms] |
|--------------+---------+---------+----------+----------|
|           16 |    98.0 |   112.8 |    122.1 |      9.3 |
|            8 |    50.0 |    57.6 |     63.6 |      6.0 |
|            4 |    26.0 |    30.0 |     34.6 |      4.6 |
|            2 |    14.0 |    16.2 |     21.7 |      5.5 |
|            1 |     8.0 |     9.3 |     14.8 |      5.5 |
|--------------+---------+---------+----------+----------|

Reading all three channels via sysfs triples those times, including
the overhead of course.

It is also impossible to obtain all three values from
the same measurement with MODE_FORCED, which is in a way a limitation
of the sysfs interface AFAIU.
---
 drivers/iio/pressure/bmp280-core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index f37f20776c89..5bec63c1bc11 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1042,13 +1042,16 @@ static int bmp280_wait_conv(struct bmp280_data *data)
 	unsigned int reg, meas_time_us;
 	int ret;
 
-	/* Check if we are using a BME280 device */
-	if (data->oversampling_humid)
-		meas_time_us = BMP280_PRESS_HUMID_MEAS_OFFSET +
-				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
+	/* Constant part of the measurement time */
+	meas_time_us = BMP280_MEAS_OFFSET;
 
-	else
-		meas_time_us = 0;
+	/*
+	 * Check if we are using a BME280 device,
+	 * Humidity measurement time
+	 */
+	if (data->chip_info->oversampling_humid_avail)
+		meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
+				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
 
 	/* Pressure measurement time */
 	meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
-- 
2.50.1


