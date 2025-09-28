Return-Path: <linux-iio+bounces-24544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB23BA7584
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 19:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A726B3B0617
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 17:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF52323BCF5;
	Sun, 28 Sep 2025 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="s8HkdEU7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp3.goneo.de (smtp3.goneo.de [85.220.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D384C1E260A
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080940; cv=none; b=ndjI1llbbV4vHrBU+bcMPXhy241b0KOhM4nUdBILGyOM584WLXlt73QNFRYyeWTtpucF2KqyPIJdzKfMk6MsrF6c3pPKn75bNDAbcudre/4qQDKxfjXZia0NruNiwLdcJ59kKaqAA/s56ou+dDfSIn+Q8ulkV1LoyBMirhy0QBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080940; c=relaxed/simple;
	bh=GlzodNpOqBIB7IpEh7N9NOfvLVzoOw2h44u4AFlISRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORQIMhyty+/+DEDFZNjGc4fYGVmeAYq4coF1ENWbOd5mV76WSkBuIQyP3mpXIDMpPOmzAXddu84HSo52S7OwgF/mgLKic9PYusq+4Ez8UP5VS240WXLxUFWsszct64vFo3WftEehOyUwdLttq6m3GlFZZ//YErJyutlLYTpHWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=s8HkdEU7; arc=none smtp.client-ip=85.220.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp3.goneo.de (Postfix) with ESMTPS id 82CA62408BF;
	Sun, 28 Sep 2025 19:27:21 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 9A0042405DE;
	Sun, 28 Sep 2025 19:27:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1759080439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABKbB65MYCaje8WKWAap7nA43ly31qblsqBOPwGc3/0=;
	b=s8HkdEU7jCrXgAuzhJJq6G6sNjgQc8mRC7swqVE+UMCCUKqdLOD8gdVv27OC9/ErgYoG//
	83U6/WcU6Ys5g29sODZDVspemYnF7fRJNe+5aLfD1pqAwlNHBu5tDcYu+05QdwbxTHvZy6
	Zi2ak1Cqa+Z041RNUwSuQ5Fwvny8lxsM3u0xXy6HKkhXIMyXV7HGG5Ivm1aEtw4ZVHBX9P
	Oqq2HfrpYvLSsgoscJWv/b4URKLXxJxm8MRPJ2OyV7zm2AsajEg/m43zYDYthMADJlu6Zd
	xfTPvvVYtEvLB3y5KEGbTH17/INhxC6YYIsnDn9kFxe8WxoD7kee23udvudnkg==
Received: from Gerda.fritz.box (p5b2f36f7.dip0.t-ipconnect.de [91.47.54.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 505F0240491;
	Sun, 28 Sep 2025 19:27:19 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v3 2/9] iio: pressure: bmp280: implement adaptive wait for BMx280 devices
Date: Sun, 28 Sep 2025 19:26:30 +0200
Message-ID: <20250928172637.37138-4-Achim.Gratz@Stromeko.DE>
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
X-Rspamd-UID: 393791
X-Rspamd-UID: 6e9045

Currently the measurement wait time is fixed at the maximum value
according to the datasheet, resulting in about 15% overhead compared
the typical values.  Implement an adaptive wait that uses
regmap_read_poll_timeout() and optimize the polling parameters so that
the overhead is reduced.

Link: https://lore.kernel.org/linux-iio/CAHp75VfQxSgQwJQsym9X58G6o4UUgz6EQ4ouhhx82aOHv_if2g@mail.gmail.com/

Tested-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>

---

Use of regmap_read_poll_timeout was suggested by Andy Shevchenko.

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
 drivers/iio/pressure/bmp280-core.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 2078b810745b..b413f1949952 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1039,7 +1039,7 @@ static int bmp280_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
 
 static int bmp280_wait_conv(struct bmp280_data *data)
 {
-	unsigned int reg, meas_time_us;
+	unsigned int reg, meas_time_us, initial_wait;
 	int ret;
 
 	/* Constant part of the measurement time */
@@ -1060,10 +1060,28 @@ static int bmp280_wait_conv(struct bmp280_data *data)
 	/* Temperature measurement time */
 	meas_time_us += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
 
-	/* Waiting time according to the BM(P/E)2 Sensor API */
-	fsleep(meas_time_us);
-
-	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
+	/*
+	 * Split the waiting time into an initial part of ~94% of the
+	 * typical measurement time (which is ~87% of the maximum
+	 * measurement time we have calculated) and then use polling
+	 * until the measurement finishes. Provide 2ms extra slack in
+	 * the timeout value to compensate for any error in
+	 * accumulated actual waiting time.  Minimum two poll cycles,
+	 * but maximum 2ms duration were found to be the best
+	 * compromise in overhead over a range of oversampling
+	 * settings.
+	 *
+	 * Measurement time can not be smaller than
+	 * BMP280_MEAS_OFFSET, so the fsleep will always receive a
+	 * strictly positive argument.
+	 */
+	initial_wait = (13 * meas_time_us) / 16;
+	fsleep(initial_wait);
+	meas_time_us -= initial_wait;
+	ret = regmap_read_poll_timeout(data->regmap, BMP280_REG_STATUS, reg,
+				       !(reg & BMP280_REG_STATUS_MEAS_BIT),
+				       min(2 * USEC_PER_MSEC, meas_time_us >> 1),
+				       2 * USEC_PER_MSEC + meas_time_us);
 	if (ret) {
 		dev_err(data->dev, "failed to read status register.\n");
 		return ret;
-- 
2.51.0


