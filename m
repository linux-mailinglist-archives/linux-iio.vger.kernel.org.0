Return-Path: <linux-iio+bounces-22526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E655B1FBCF
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 20:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450A51754E3
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 18:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD131FA15E;
	Sun, 10 Aug 2025 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="LhlAQrm7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp4.goneo.de (smtp4.goneo.de [85.220.129.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B071F8AD3
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754852364; cv=none; b=af4rn3rA7WEdBHLizGO+I0RIMeydiAzTIyWfEN5/Fn/WXZA5fJKzhS6bxEgKAiv+Ut7swen08v35Qd7Eatdf5lNQGu36BAOWKEJrENT6mVV2nqa2sIW05c/5M44mMtcz9fh4SBa8xo8ZXLtoPVBAgwV96VBJfJNz/1pDJL4ZEoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754852364; c=relaxed/simple;
	bh=UXYGqsD/DFDQ65glgGLyjnG1qOOQvDO/mG0mTnA6yv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5ScOUni0+06Dn5ACmEghhDyGWh7OjmCXPzm/mDs0f5uEcQP+x9MDHLXZFO8gl0VBJxV6saQufDV3WVKi3HGGT5pTeb0b9/T4AGp9FsIPt8c0DRwsU/fzgRIw5HJ3UjrNLy7sA7EJI0UiJHzc9niUBWEOyemqJCqfYQYPMOTilc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=LhlAQrm7; arc=none smtp.client-ip=85.220.129.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp4.goneo.de (Postfix) with ESMTPS id 16CA0240A04;
	Sun, 10 Aug 2025 20:59:17 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 38BCB2403B8;
	Sun, 10 Aug 2025 20:59:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1754852355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWZJxHVA7aXvbinlEoAE69QCAltNT1S/jTNmjFSTXmw=;
	b=LhlAQrm7BMSvculg+5DcZ616ZK1ztD2YPXPO7SY6MjHXVrglk8xa4H7KTKGIOff7H8t0Jo
	WAzDoQ+qHt0htiATYldGbV6351wu+PhfciONmkNk7sAs4yt3rj0uLu0jWIha7imEaUU4ld
	LM3ov4a/gI1J+xd8Tr3BcRAfnW1/JsR8MY7lvlt//oKJNw+m5X92MRvnxtkagVb/KiMEyu
	jVaZAwdtJEgu3Vd2bb8IpCOE0/j1ZL1pvXHNzAGZ3iGYXbeFSr1PTY0aOAiZ/sb66GFGq7
	qldhTXp4PW26qM/uUSuaVWB0dIyPm0VDQDLLyyEOnTSiJWeiX/uQkV43b+1bXQ==
Received: from Gerda.fritz.box (p54a0c448.dip0.t-ipconnect.de [84.160.196.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id F1CAE240270;
	Sun, 10 Aug 2025 20:59:14 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v2 2/9] iio: pressure: bmp280: implement adaptive wait for BMx280 devices
Date: Sun, 10 Aug 2025 20:58:39 +0200
Message-ID: <20250810185846.114355-3-Achim.Gratz@Stromeko.DE>
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
X-Rspamd-UID: 8c3b07
X-Rspamd-UID: 72eb32

Currently the measurement wait time is fixed at the maximum value
according to the datasheet, resulting in about 15% overhead compared
the typical values.  Implement an adaptive wait that uses
regmap_read_poll_timeout() and optimize the polling parameters so that
the overhead is reduced.

Link: https://lore.kernel.org/linux-iio/CAHp75VfQxSgQwJQsym9X58G6o4UUgz6EQ4ouhhx82aOHv_if2g@mail.gmail.com/
Suggested-by: Andy Shevchenko <andy@kernel.org>
Tested-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>

---

Notes
=====

Datasheet values and median actual measurement times through sysfs for
a single reading with my BME280 connected to a 400kHz I²C bus provided
by the i915 IGP VGA port:

|--------------+---------+---------+-----------+----------+---------+----------+--------+----------+--------+----------|
| Oversampling | Typical | Maximum | Wait Full | Overhead | 2x@20ms | Overhead | 2x@4ms | Overhead | 2x@2ms | Overhead |
|        Ratio |    [ms] |    [ms] |      [ms] |     [ms] |    [ms] |     [ms] |   [ms] |     [ms] |   [ms] |     [ms] |
|--------------+---------+---------+-----------+----------+---------+----------+--------+----------+--------+----------|
|           16 |    98.0 |   112.8 |     122.1 |      9.3 |   106.2 |     -6.6 |  102.8 |    -10.0 |  103.0 |     -9.8 |
|            8 |    50.0 |    57.6 |      63.6 |      6.0 |    58.7 |      1.1 |   55.8 |     -1.8 |   54.0 |     -3.6 |
|            4 |    26.0 |    30.0 |      34.6 |      4.6 |    31.8 |      1.8 |   30.8 |      0.8 |   30.6 |      0.6 |
|            2 |    14.0 |    16.2 |      21.7 |      5.5 |    19.3 |      3.1 |   18.9 |      2.7 |   18.7 |      2.5 |
|            1 |     8.0 |     9.3 |      14.8 |      5.5 |    12.9 |      3.6 |   13.3 |      4.0 |   12.9 |      3.6 |
|--------------+---------+---------+-----------+----------+---------+----------+--------+----------+--------+----------|
---
 drivers/iio/pressure/bmp280-core.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 5bec63c1bc11..e09e6b396a6f 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1039,7 +1039,7 @@ static int bmp280_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
 
 static int bmp280_wait_conv(struct bmp280_data *data)
 {
-	unsigned int reg, meas_time_us;
+	unsigned int reg, meas_time_us, initial_wait;
 	int ret;
 
 	/* Constant part of the measurement time */
@@ -1060,10 +1060,23 @@ static int bmp280_wait_conv(struct bmp280_data *data)
 	/* Temperature measurement time */
 	meas_time_us += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
 
-	/* Waiting time according to the BM(P/E)2 Sensor API */
-	fsleep(meas_time_us);
-
-	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
+	/*
+	 * Split the wait into an initial wait of ~94% of the typical
+	 * measurement time (which is ~87% of the maximum measurement
+	 * time we have calculated) and then use a polling wait until
+	 * the measurement finishes. Provide 2ms extra slack in the
+	 * timeout value to compensate for any error in accumulated
+	 * actual wait time.  Minimum two poll cycles, but maximum 2ms
+	 * duration where found to be the best compromise in overhead
+	 * over a range of oversampling settings.
+	 */
+	initial_wait = (13 * meas_time_us) / 16;
+	fsleep(initial_wait);
+	meas_time_us -= initial_wait;
+	ret = regmap_read_poll_timeout(data->regmap, BMP280_REG_STATUS, reg,
+				       !(reg & BMP280_REG_STATUS_MEAS_BIT),
+				       MIN((2 * USEC_PER_MSEC), (meas_time_us >> 1)),
+				       (2 * USEC_PER_MSEC + meas_time_us));
 	if (ret) {
 		dev_err(data->dev, "failed to read status register.\n");
 		return ret;
-- 
2.50.1


