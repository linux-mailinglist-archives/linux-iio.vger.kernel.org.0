Return-Path: <linux-iio+bounces-22222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E19B19434
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 16:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59403B4E41
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40646242D89;
	Sun,  3 Aug 2025 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="QpHicRew"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp3.goneo.de (smtp3.goneo.de [85.220.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C71F582E
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754230721; cv=none; b=GD7B+zMkp/VEER0G558FTZyb3v6EceEmTMAC0RlJ3nLUhY+36639qezdDSfikSf0YJOr/55wDV86wWAXwUaP1w7EtkglItE9XvtGdS3/u/tdpQcH2VYEIbV35237uvgjYYY0xsve2dnWfRQzWo6QWUMPkCIxqJckHc/1AScAYfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754230721; c=relaxed/simple;
	bh=L8ahoyp/hgegjnfGmbgqey/OwdolDOuNp9Bc6I4Ksvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyJhDFDbaK1BY/CayDOm3LaYwczHJPignQo7yo0vZXs2WE9kzKzKq0YH2UU2h85Fw7BkiwDaqGkY2S4Pq7YCNqngP7NfWZf5K/oAA4uwN7iOKQndHNjJVV+W369osB/bS+M+5+fb4EuC0+hY+rQxTAh6q63wsM59KWOCrrofhA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=QpHicRew; arc=none smtp.client-ip=85.220.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp3.goneo.de (Postfix) with ESMTPS id 819D5240268;
	Sun,  3 Aug 2025 16:08:56 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id E8C3A240206;
	Sun,  3 Aug 2025 16:08:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1754230135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvQSkFOCJLqteBtQsrqOKbQLdyLI6KLm2x3evTMBp+M=;
	b=QpHicRewEKaVV3r1xInQuEvLfsNoifbEnOTfjWTW027gARwjdWMGkKGITbR5qjNnMHMD+r
	VThrryp7UFll5hWUXXe4/m2zYGK5ZWVr8VdbBAJk0v+qk8I4udGi+gQ1fQZMM6K7EKy32a
	FtcZrkdmZgqlgM9egkuWvPrKwrzthGK//N8Ypy922TRE+CccCTpVU0n7WFVLoxt6Gw8fnP
	qQtLpd0kqstKie54fw3samxnhmuzkgQ78UwzD4aMYVXA4igFGBHBnrap+IdBb1r0Pi2Vga
	boj0hhNSPZf5e4id9F1M5MwM6QNzVdIcXH2Pe7MQLiY0DAuOgh33S9UR0DwNUA==
Received: from Gerda.fritz.box (p54a0c634.dip0.t-ipconnect.de [84.160.198.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id AA73F240165;
	Sun,  3 Aug 2025 16:08:54 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [bmp280 v1 1/6] iio: pressure: bmp280: correct meas_time_us calculation
Date: Sun,  3 Aug 2025 16:07:57 +0200
Message-ID: <20250803140802.36888-2-Achim.Gratz@Stromeko.DE>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
 <20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 7bc2da
X-Rspamd-UID: af83dc

Based on an observation and partial patch by David Lechner.

There was also a thinko in bmp280_wait_conv: data->oversampling_humid
can actually be 0 (for an oversampling_ratio of 1), so it can not be
used to detect the presence of the humidity measurement capability.
Use data->chip_info->oversampling_humid_avail instead, which is NULL
for chips that cannot measure humidity and therefore need to skip that
part of the calculation.

Note: Since the BMx280 device support was added, oversampling=0
actually is a valid setting (that channels measurement is off), but
allowing that setting by changing the data structure to hold the
actual value instead of its ilog2 would require more extensive changes
elsewhere in the code.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
---
 drivers/iio/pressure/bmp280-core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 74505c9ec1a0..3213dcadba28 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1042,14 +1042,13 @@ static int bmp280_wait_conv(struct bmp280_data *data)
 	unsigned int reg, meas_time_us;
 	int ret;
 
+	meas_time_us = BMP280_MEAS_OFFSET;
+
 	/* Check if we are using a BME280 device */
-	if (data->oversampling_humid)
-		meas_time_us = BMP280_PRESS_HUMID_MEAS_OFFSET +
+	if (data->chip_info->oversampling_humid_avail)
+		meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
 				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
 
-	else
-		meas_time_us = 0;
-
 	/* Pressure measurement time */
 	meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
 			BIT(data->oversampling_press) * BMP280_MEAS_DUR;
-- 
2.50.1


