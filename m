Return-Path: <linux-iio+bounces-24538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A95DBA7572
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 19:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B631C4E13E1
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 17:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AA82367D2;
	Sun, 28 Sep 2025 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="lhuQaFou"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp4.goneo.de (smtp4.goneo.de [85.220.129.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257C0222594
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080939; cv=none; b=L7j7Nb3GuY7RmrhOreESij88mSNRrAh72eQYhSOA3sHuoF2M6iPutxKStgnLAI+TRC0Q73+7iskHvov379jC7+bxmeR3X2FOIjSf3qzsaZa/cgvIbKHGDOO6qrPt3lLolrrAKgC5YpG9IM/eDMwEjENyR35l1+rK1A0ylWHZ7dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080939; c=relaxed/simple;
	bh=xJ2VdLzVtTjVsOPji2hDrlGeM7nU3G9qhGCSbC7BGfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9VTVkHJI97/0aSpQN/pnGvQRj8Oo0kqJDGbhf66lIc+9zwLvJoXWUPdzrkGroeymTROSaU/SIiLIWx+9XuaDYPyevd2VqTle9+C/Bx8FIB5FNcEU3MSTCgJX1gX2Njtk4Qdez+ul/6BipeTn2+o/m8CZqEZvqtakEZmNBOotyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=lhuQaFou; arc=none smtp.client-ip=85.220.129.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp4.goneo.de (Postfix) with ESMTPS id E1E2F240BE1;
	Sun, 28 Sep 2025 19:27:20 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 0F5D5240477;
	Sun, 28 Sep 2025 19:27:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1759080439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0y1EFLz63EJgM6zdAzrk9eZKIvkQ379uqi+QLpEQ11Y=;
	b=lhuQaFou6GW9J8bkGiOf6ED1R0kVSxg8opqX3bJ5TBZ7ZDybzRDe8c1jr+FerLz3uhs0t+
	fZBl4CgFs/fEN7X5RjKa6/egKfL8H4YxBIdb6rMb41D8mHdbIpCqqJTy4Dz4TyoBvY4gSO
	pJLQOzwRBiIKnV7OHH5PNIxnoEhSJeT+5efCXqrVsZVbBvk4vAOFVSAYNOfqOcKWa63+s4
	yBFtZlwY17KozA2JCwP5zRo/WJE69iEOYRlpwFBJcnSXw2d8XYihVgy9/XjKtXWePY8ByA
	SUvorA2HyP1mFJF4nbyMLL4PnD95DtP3afnObZz8yW4GkZaYozrPqppeMpAVIA==
Received: from Gerda.fritz.box (p5b2f36f7.dip0.t-ipconnect.de [91.47.54.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id C106924012F;
	Sun, 28 Sep 2025 19:27:18 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v3 1/9] iio: pressure: bmp280: correct meas_time_us calculation
Date: Sun, 28 Sep 2025 19:26:28 +0200
Message-ID: <20250928172637.37138-2-Achim.Gratz@Stromeko.DE>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
References: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: a2259b
X-Rspamd-UID: 18bd11

Correction of meas_time_us initialization based on an observation and
partial patch by David Lechner.

The constant part of the measurement time (as described in the
datasheet and implemented in the BM(P/E)2 Sensor API) was apparently
forgotten (it was already correctly applied for the BMP380) and is now
used.

There was also another thinko in bmp280_wait_conv:
data->oversampling_humid can actually have a value of 0 (for an
oversampling_ratio of 1), so it can not be used to detect the presence
of the humidity measurement capability.  Use
data->chip_info->oversampling_humid_avail instead, which is NULL for
chips that cannot measure humidity and therefore must skip that part
of the calculation.

Closes: https://lore.kernel.org/linux-iio/875xgfg0wz.fsf@Gerda.invalid/
Fixes: 26ccfaa9ddaa ("iio: pressure: bmp280: Use sleep and forced mode for oneshot captures")
Suggested-by: David Lechner <dlechner@baylibre.com>
Tested-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>

---

Notes
=====

Since the BMx280 device support was added, oversampling=0 actually is
a valid register setting (meaning that measurement channel is off),
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
the overhead of course as each read triggers a new measurement on all
enabled channels.  It is therefore also impossible to obtain all
channel values from the same measurement cycle with MODE_FORCED, which
is in a way a limitation of the sysfs interface and can only be
obtained by using buffered reads.
---
 drivers/iio/pressure/bmp280-core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6cdc8ed53520..2078b810745b 100644
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
2.51.0


