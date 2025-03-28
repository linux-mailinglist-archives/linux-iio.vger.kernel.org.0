Return-Path: <linux-iio+bounces-17317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66727A74FB7
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 18:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F7D1896A5D
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE831DB131;
	Fri, 28 Mar 2025 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="AL/mwhZm"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-10.pe-a.jellyfish.systems (out-10.pe-a.jellyfish.systems [198.54.127.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D5D1ACEBE;
	Fri, 28 Mar 2025 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184203; cv=none; b=N0q9ihuSbbSIEAq5ERF5XADu60UMEI3B3dTervfYMay4tqPEnb7JhML34dU0uLFUglfjW+klaBS8gQU9fcOXNKKwdDBSiw7OZ1ZPNbtWfNwNteVVIpf68+dQaDbO9cfcBIDSoPv9PZZXF9XIo4C7Nlv/Oqhfn7d6S13QuTRucIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184203; c=relaxed/simple;
	bh=zlS0hDX1MkjlpFPN3w2f1JUwvGzTVsVK5rYytkS2jsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYYfQ5cjhZSFROgtmZdBl9vWbIgiGCXOPNucEXNbbr2JD5vj1dCcSYeinWlMsaCtK6e9yr8WmvMB83D8C+yNnL+4eJbkHfhb4IbM6om4SgQHgueY5aMQUFWDhRYczqBFb6Jhp30V0Y9IO7y9vc5yTpVI3UBIcRELPMDrYskEXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=AL/mwhZm; arc=none smtp.client-ip=198.54.127.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZPSj36PxDz9sXK;
	Fri, 28 Mar 2025 17:49:59 +0000 (UTC)
Received: from MTA-14.privateemail.com (unknown [10.50.14.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZPSj35Mp8z2Sd0Q;
	Fri, 28 Mar 2025 13:49:59 -0400 (EDT)
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
	by mta-14.privateemail.com (Postfix) with ESMTP id 4ZPSj341b7z3hhTj;
	Fri, 28 Mar 2025 13:49:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1743184199;
	bh=zlS0hDX1MkjlpFPN3w2f1JUwvGzTVsVK5rYytkS2jsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AL/mwhZmYD6U2Ci8wIj8Up95qIAe201wgRczTQBuc8LmXJ8/ZWJfg8oyXxd+J3dv8
	 vmPQ2tmmaWM+ZOLGfq+m4QxvW6UO1jcAtT/BgBINPccFs6YX5ERq8KSVriGydYiGH0
	 h2V+6+qFxcKCpzBUVJ8qPlaiGP7xrtRsjo84UYdXKP+T2CKmFHXsY9KtAh577E3Ec9
	 e7pwwqhwQMigLx8dBluPdkas0Zn6JeUGIAfHPdsPho2Ig8DPlO9akor+zn3zk7aJPo
	 ea6MVODEDGG9QelxyA4Un+rM96nJ9IOzKYKBwd5vflSU3LLkqEZPAtdw3y1ojitzdD
	 Ol++akfyEeuEA==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-14.privateemail.com (Postfix) with ESMTPA;
	Fri, 28 Mar 2025 13:49:43 -0400 (EDT)
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	antoniu.miclaus@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	sam.winchenbach@framepointer.org,
	bpellegrino@arka.org,
	Sam Winchenbach <swinchenbach@arka.org>
Subject: [PATCH v8 4/6] iio: filter: admv8818: fix range calculation
Date: Fri, 28 Mar 2025 13:48:29 -0400
Message-ID: <20250328174831.227202-5-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328174831.227202-1-sam.winchenbach@framepointer.org>
References: <20250328174831.227202-1-sam.winchenbach@framepointer.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

From: Sam Winchenbach <swinchenbach@arka.org>

Search for the minimum error while ensuring that the LPF corner
frequency is greater than the target, and the HPF corner frequency
is lower than the target

This fixes issues where the range calculations were suboptimal.

Add two new DTS properties to set the margin between the input frequency
and the calculated corner frequency

Below is a generated table of the differences between the old algorithm
and the new. This is a sweep from 0 to 20 GHz in 10 MHz steps.
=== HPF ===
freq = 1750 MHz, 3db: bypass => 1750 MHz
freq = 3400 MHz, 3db: 3310 => 3400 MHz
freq = 3410 MHz, 3db: 3310 => 3400 MHz
freq = 3420 MHz, 3db: 3310 => 3400 MHz
freq = 3660 MHz, 3db: 3550 => 3656 MHz
freq = 6600 MHz, 3db: 6479 => 6600 MHz
freq = 6610 MHz, 3db: 6479 => 6600 MHz
freq = 6620 MHz, 3db: 6479 => 6600 MHz
freq = 6630 MHz, 3db: 6479 => 6600 MHz
freq = 6640 MHz, 3db: 6479 => 6600 MHz
freq = 6650 MHz, 3db: 6479 => 6600 MHz
freq = 6660 MHz, 3db: 6479 => 6600 MHz
freq = 6670 MHz, 3db: 6479 => 6600 MHz
freq = 6680 MHz, 3db: 6479 => 6600 MHz
freq = 6690 MHz, 3db: 6479 => 6600 MHz
freq = 6700 MHz, 3db: 6479 => 6600 MHz
freq = 6710 MHz, 3db: 6479 => 6600 MHz
freq = 6720 MHz, 3db: 6479 => 6600 MHz
freq = 6730 MHz, 3db: 6479 => 6600 MHz
freq = 6960 MHz, 3db: 6736 => 6960 MHz
freq = 6970 MHz, 3db: 6736 => 6960 MHz
freq = 6980 MHz, 3db: 6736 => 6960 MHz
freq = 6990 MHz, 3db: 6736 => 6960 MHz
freq = 7320 MHz, 3db: 7249 => 7320 MHz
freq = 7330 MHz, 3db: 7249 => 7320 MHz
freq = 7340 MHz, 3db: 7249 => 7320 MHz
freq = 7350 MHz, 3db: 7249 => 7320 MHz
freq = 7360 MHz, 3db: 7249 => 7320 MHz
freq = 7370 MHz, 3db: 7249 => 7320 MHz
freq = 7380 MHz, 3db: 7249 => 7320 MHz
freq = 7390 MHz, 3db: 7249 => 7320 MHz
freq = 7400 MHz, 3db: 7249 => 7320 MHz
freq = 7410 MHz, 3db: 7249 => 7320 MHz
freq = 7420 MHz, 3db: 7249 => 7320 MHz
freq = 7430 MHz, 3db: 7249 => 7320 MHz
freq = 7440 MHz, 3db: 7249 => 7320 MHz
freq = 7450 MHz, 3db: 7249 => 7320 MHz
freq = 7460 MHz, 3db: 7249 => 7320 MHz
freq = 7470 MHz, 3db: 7249 => 7320 MHz
freq = 7480 MHz, 3db: 7249 => 7320 MHz
freq = 7490 MHz, 3db: 7249 => 7320 MHz
freq = 7500 MHz, 3db: 7249 => 7320 MHz
freq = 12500 MHz, 3db: 12000 => 12500 MHz

=== LPF ===
freq = 2050 MHz, 3db: bypass => 2050 MHz
freq = 2170 MHz, 3db: 2290 => 2170 MHz
freq = 2290 MHz, 3db: 2410 => 2290 MHz
freq = 2410 MHz, 3db: 2530 => 2410 MHz
freq = 2530 MHz, 3db: 2650 => 2530 MHz
freq = 2650 MHz, 3db: 2770 => 2650 MHz
freq = 2770 MHz, 3db: 2890 => 2770 MHz
freq = 2890 MHz, 3db: 3010 => 2890 MHz
freq = 3010 MHz, 3db: 3130 => 3010 MHz
freq = 3130 MHz, 3db: 3250 => 3130 MHz
freq = 3250 MHz, 3db: 3370 => 3250 MHz
freq = 3260 MHz, 3db: 3370 => 3350 MHz
freq = 3270 MHz, 3db: 3370 => 3350 MHz
freq = 3280 MHz, 3db: 3370 => 3350 MHz
freq = 3290 MHz, 3db: 3370 => 3350 MHz
freq = 3300 MHz, 3db: 3370 => 3350 MHz
freq = 3310 MHz, 3db: 3370 => 3350 MHz
freq = 3320 MHz, 3db: 3370 => 3350 MHz
freq = 3330 MHz, 3db: 3370 => 3350 MHz
freq = 3340 MHz, 3db: 3370 => 3350 MHz
freq = 3350 MHz, 3db: 3370 => 3350 MHz
freq = 3370 MHz, 3db: 3490 => 3370 MHz
freq = 3490 MHz, 3db: 3610 => 3490 MHz
freq = 3610 MHz, 3db: 3730 => 3610 MHz
freq = 3730 MHz, 3db: 3850 => 3730 MHz
freq = 3850 MHz, 3db: 3870 => 3850 MHz
freq = 3870 MHz, 3db: 4130 => 3870 MHz
freq = 4130 MHz, 3db: 4390 => 4130 MHz
freq = 4390 MHz, 3db: 4650 => 4390 MHz
freq = 4650 MHz, 3db: 4910 => 4650 MHz
freq = 4910 MHz, 3db: 5170 => 4910 MHz
freq = 5170 MHz, 3db: 5430 => 5170 MHz
freq = 5430 MHz, 3db: 5690 => 5430 MHz
freq = 5690 MHz, 3db: 5950 => 5690 MHz
freq = 5950 MHz, 3db: 6210 => 5950 MHz
freq = 6210 MHz, 3db: 6470 => 6210 MHz
freq = 6470 MHz, 3db: 6730 => 6470 MHz
freq = 6730 MHz, 3db: 6990 => 6730 MHz
freq = 6990 MHz, 3db: 7250 => 6990 MHz
freq = 7000 MHz, 3db: 7250 => 7000 MHz
freq = 7250 MHz, 3db: 7400 => 7250 MHz
freq = 7400 MHz, 3db: 7800 => 7400 MHz
freq = 7800 MHz, 3db: 8200 => 7800 MHz
freq = 8200 MHz, 3db: 8600 => 8200 MHz
freq = 8600 MHz, 3db: 9000 => 8600 MHz
freq = 9000 MHz, 3db: 9400 => 9000 MHz
freq = 9400 MHz, 3db: 9800 => 9400 MHz
freq = 9800 MHz, 3db: 10200 => 9800 MHz
freq = 10200 MHz, 3db: 10600 => 10200 MHz
freq = 10600 MHz, 3db: 11000 => 10600 MHz
freq = 11000 MHz, 3db: 11400 => 11000 MHz
freq = 11400 MHz, 3db: 11800 => 11400 MHz
freq = 11800 MHz, 3db: 12200 => 11800 MHz
freq = 12200 MHz, 3db: 12600 => 12200 MHz
freq = 12210 MHz, 3db: 12600 => 12550 MHz
freq = 12220 MHz, 3db: 12600 => 12550 MHz
freq = 12230 MHz, 3db: 12600 => 12550 MHz
freq = 12240 MHz, 3db: 12600 => 12550 MHz
freq = 12250 MHz, 3db: 12600 => 12550 MHz
freq = 12260 MHz, 3db: 12600 => 12550 MHz
freq = 12270 MHz, 3db: 12600 => 12550 MHz
freq = 12280 MHz, 3db: 12600 => 12550 MHz
freq = 12290 MHz, 3db: 12600 => 12550 MHz
freq = 12300 MHz, 3db: 12600 => 12550 MHz
freq = 12310 MHz, 3db: 12600 => 12550 MHz
freq = 12320 MHz, 3db: 12600 => 12550 MHz
freq = 12330 MHz, 3db: 12600 => 12550 MHz
freq = 12340 MHz, 3db: 12600 => 12550 MHz
freq = 12350 MHz, 3db: 12600 => 12550 MHz
freq = 12360 MHz, 3db: 12600 => 12550 MHz
freq = 12370 MHz, 3db: 12600 => 12550 MHz
freq = 12380 MHz, 3db: 12600 => 12550 MHz
freq = 12390 MHz, 3db: 12600 => 12550 MHz
freq = 12400 MHz, 3db: 12600 => 12550 MHz
freq = 12410 MHz, 3db: 12600 => 12550 MHz
freq = 12420 MHz, 3db: 12600 => 12550 MHz
freq = 12430 MHz, 3db: 12600 => 12550 MHz
freq = 12440 MHz, 3db: 12600 => 12550 MHz
freq = 12450 MHz, 3db: 12600 => 12550 MHz
freq = 12460 MHz, 3db: 12600 => 12550 MHz
freq = 12470 MHz, 3db: 12600 => 12550 MHz
freq = 12480 MHz, 3db: 12600 => 12550 MHz
freq = 12490 MHz, 3db: 12600 => 12550 MHz
freq = 12500 MHz, 3db: 12600 => 12550 MHz
freq = 12510 MHz, 3db: 12600 => 12550 MHz
freq = 12520 MHz, 3db: 12600 => 12550 MHz
freq = 12530 MHz, 3db: 12600 => 12550 MHz
freq = 12540 MHz, 3db: 12600 => 12550 MHz
freq = 12550 MHz, 3db: 12600 => 12550 MHz
freq = 12600 MHz, 3db: 13000 => 12600 MHz
freq = 12610 MHz, 3db: 13000 => 12970 MHz
freq = 12620 MHz, 3db: 13000 => 12970 MHz
freq = 12630 MHz, 3db: 13000 => 12970 MHz
freq = 12640 MHz, 3db: 13000 => 12970 MHz
freq = 12650 MHz, 3db: 13000 => 12970 MHz
freq = 12660 MHz, 3db: 13000 => 12970 MHz
freq = 12670 MHz, 3db: 13000 => 12970 MHz
freq = 12680 MHz, 3db: 13000 => 12970 MHz
freq = 12690 MHz, 3db: 13000 => 12970 MHz
freq = 12700 MHz, 3db: 13000 => 12970 MHz
freq = 12710 MHz, 3db: 13000 => 12970 MHz
freq = 12720 MHz, 3db: 13000 => 12970 MHz
freq = 12730 MHz, 3db: 13000 => 12970 MHz
freq = 12740 MHz, 3db: 13000 => 12970 MHz
freq = 12750 MHz, 3db: 13000 => 12970 MHz
freq = 12760 MHz, 3db: 13000 => 12970 MHz
freq = 12770 MHz, 3db: 13000 => 12970 MHz
freq = 12780 MHz, 3db: 13000 => 12970 MHz
freq = 12790 MHz, 3db: 13000 => 12970 MHz
freq = 12800 MHz, 3db: 13000 => 12970 MHz
freq = 12810 MHz, 3db: 13000 => 12970 MHz
freq = 12820 MHz, 3db: 13000 => 12970 MHz
freq = 12830 MHz, 3db: 13000 => 12970 MHz
freq = 12840 MHz, 3db: 13000 => 12970 MHz
freq = 12850 MHz, 3db: 13000 => 12970 MHz
freq = 12860 MHz, 3db: 13000 => 12970 MHz
freq = 12870 MHz, 3db: 13000 => 12970 MHz
freq = 12880 MHz, 3db: 13000 => 12970 MHz
freq = 12890 MHz, 3db: 13000 => 12970 MHz
freq = 12900 MHz, 3db: 13000 => 12970 MHz
freq = 12910 MHz, 3db: 13000 => 12970 MHz
freq = 12920 MHz, 3db: 13000 => 12970 MHz
freq = 12930 MHz, 3db: 13000 => 12970 MHz
freq = 12940 MHz, 3db: 13000 => 12970 MHz
freq = 12950 MHz, 3db: 13000 => 12970 MHz
freq = 12960 MHz, 3db: 13000 => 12970 MHz
freq = 12970 MHz, 3db: 13000 => 12970 MHz
freq = 13000 MHz, 3db: 13390 => 13000 MHz
freq = 13390 MHz, 3db: 13810 => 13390 MHz
freq = 13810 MHz, 3db: 14230 => 13810 MHz
freq = 14230 MHz, 3db: 14650 => 14230 MHz
freq = 14650 MHz, 3db: 15070 => 14650 MHz
freq = 15070 MHz, 3db: 15490 => 15070 MHz
freq = 15490 MHz, 3db: 15910 => 15490 MHz
freq = 15910 MHz, 3db: 16330 => 15910 MHz
freq = 16330 MHz, 3db: 16750 => 16330 MHz
freq = 16750 MHz, 3db: 17170 => 16750 MHz
freq = 17170 MHz, 3db: 17590 => 17170 MHz
freq = 17590 MHz, 3db: 18010 => 17590 MHz
freq = 18010 MHz, 3db: 18430 => 18010 MHz
freq = 18430 MHz, 3db: 18850 => 18430 MHz
freq = 18850 MHz, 3db: bypass => 18850 MHz

Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
---
 drivers/iio/filter/admv8818.c | 205 +++++++++++++++++++++++++---------
 1 file changed, 152 insertions(+), 53 deletions(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index cd3aff9a2f7bf..380e119b3cf54 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -14,6 +14,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 #include <linux/units.h>
@@ -70,6 +71,16 @@
 #define ADMV8818_HPF_WR0_MSK			GENMASK(7, 4)
 #define ADMV8818_LPF_WR0_MSK			GENMASK(3, 0)
 
+#define ADMV8818_BAND_BYPASS       0
+#define ADMV8818_BAND_MIN          1
+#define ADMV8818_BAND_MAX          4
+#define ADMV8818_BAND_CORNER_LOW   0
+#define ADMV8818_BAND_CORNER_HIGH  1
+
+#define ADMV8818_STATE_MIN   0
+#define ADMV8818_STATE_MAX   15
+#define ADMV8818_NUM_STATES  16
+
 enum {
 	ADMV8818_BW_FREQ,
 	ADMV8818_CENTER_FREQ
@@ -90,16 +101,20 @@ struct admv8818_state {
 	struct mutex		lock;
 	unsigned int		filter_mode;
 	u64			cf_hz;
+	u64			lpf_margin_hz;
+	u64			hpf_margin_hz;
 };
 
-static const unsigned long long freq_range_hpf[4][2] = {
+static const unsigned long long freq_range_hpf[5][2] = {
+	{0ULL, 0ULL}, /* bypass */
 	{1750000000ULL, 3550000000ULL},
 	{3400000000ULL, 7250000000ULL},
 	{6600000000, 12000000000},
 	{12500000000, 19900000000}
 };
 
-static const unsigned long long freq_range_lpf[4][2] = {
+static const unsigned long long freq_range_lpf[5][2] = {
+	{U64_MAX, U64_MAX}, /* bypass */
 	{2050000000ULL, 3850000000ULL},
 	{3350000000ULL, 7250000000ULL},
 	{7000000000, 13000000000},
@@ -121,44 +136,59 @@ static const char * const admv8818_modes[] = {
 
 static int __admv8818_hpf_select(struct admv8818_state *st, u64 freq)
 {
-	unsigned int hpf_step = 0, hpf_band = 0, i, j;
-	u64 freq_step;
-	int ret;
+	int band, state, ret;
+	unsigned int hpf_state = ADMV8818_STATE_MIN, hpf_band = ADMV8818_BAND_BYPASS;
+	u64 freq_error, min_freq_error, freq_corner, freq_step;
 
-	if (freq < freq_range_hpf[0][0])
+	if (freq < freq_range_hpf[ADMV8818_BAND_MIN][ADMV8818_BAND_CORNER_LOW])
 		goto hpf_write;
 
-	if (freq > freq_range_hpf[3][1]) {
-		hpf_step = 15;
-		hpf_band = 4;
-
+	if (freq >= freq_range_hpf[ADMV8818_BAND_MAX][ADMV8818_BAND_CORNER_HIGH]) {
+		hpf_state = ADMV8818_STATE_MAX;
+		hpf_band = ADMV8818_BAND_MAX;
 		goto hpf_write;
 	}
 
-	for (i = 0; i < 4; i++) {
-		freq_step = div_u64((freq_range_hpf[i][1] -
-			freq_range_hpf[i][0]), 15);
+	/* Close HPF frequency gap between 12 and 12.5 GHz */
+	if (freq >= 12000ULL * HZ_PER_MHZ && freq < 12500ULL * HZ_PER_MHZ) {
+		hpf_state = ADMV8818_STATE_MAX;
+		hpf_band = 3;
+		goto hpf_write;
+	}
 
-		if (freq > freq_range_hpf[i][0] &&
-		    (freq < freq_range_hpf[i][1] + freq_step)) {
-			hpf_band = i + 1;
+	min_freq_error = U64_MAX;
+	for (band = ADMV8818_BAND_MIN; band <= ADMV8818_BAND_MAX; band++) {
+		/*
+		 * This (and therefore all other ranges) have a corner
+		 * frequency higher than the target frequency.
+		 */
+		if (freq_range_hpf[band][ADMV8818_BAND_CORNER_LOW] > freq)
+			break;
 
-			for (j = 1; j <= 16; j++) {
-				if (freq < (freq_range_hpf[i][0] + (freq_step * j))) {
-					hpf_step = j - 1;
-					break;
-				}
+		freq_step = freq_range_hpf[band][ADMV8818_BAND_CORNER_HIGH] -
+			    freq_range_hpf[band][ADMV8818_BAND_CORNER_LOW];
+		freq_step = div_u64(freq_step, ADMV8818_NUM_STATES - 1);
+
+		for (state = ADMV8818_STATE_MIN; state <= ADMV8818_STATE_MAX; state++) {
+			freq_corner = freq_range_hpf[band][ADMV8818_BAND_CORNER_LOW] +
+				      freq_step * state;
+
+			/*
+			 * This (and therefore all other states) have a corner
+			 * frequency higher than the target frequency.
+			 */
+			if (freq_corner > freq)
+				break;
+
+			freq_error = freq - freq_corner;
+			if (freq_error < min_freq_error) {
+				min_freq_error = freq_error;
+				hpf_state = state;
+				hpf_band = band;
 			}
-			break;
 		}
 	}
 
-	/* Close HPF frequency gap between 12 and 12.5 GHz */
-	if (freq >= 12000ULL * HZ_PER_MHZ && freq < 12500ULL * HZ_PER_MHZ) {
-		hpf_band = 3;
-		hpf_step = 15;
-	}
-
 hpf_write:
 	ret = regmap_update_bits(st->regmap, ADMV8818_REG_WR0_SW,
 				 ADMV8818_SW_IN_SET_WR0_MSK |
@@ -170,7 +200,7 @@ static int __admv8818_hpf_select(struct admv8818_state *st, u64 freq)
 
 	return regmap_update_bits(st->regmap, ADMV8818_REG_WR0_FILTER,
 				  ADMV8818_HPF_WR0_MSK,
-				  FIELD_PREP(ADMV8818_HPF_WR0_MSK, hpf_step));
+				  FIELD_PREP(ADMV8818_HPF_WR0_MSK, hpf_state));
 }
 
 static int admv8818_hpf_select(struct admv8818_state *st, u64 freq)
@@ -186,31 +216,52 @@ static int admv8818_hpf_select(struct admv8818_state *st, u64 freq)
 
 static int __admv8818_lpf_select(struct admv8818_state *st, u64 freq)
 {
-	unsigned int lpf_step = 0, lpf_band = 0, i, j;
-	u64 freq_step;
-	int ret;
+	int band, state, ret;
+	unsigned int lpf_state = ADMV8818_STATE_MIN, lpf_band = ADMV8818_BAND_BYPASS;
+	u64 freq_error, min_freq_error, freq_corner, freq_step;
 
-	if (freq > freq_range_lpf[3][1])
+	if (freq > freq_range_lpf[ADMV8818_BAND_MAX][ADMV8818_BAND_CORNER_HIGH])
 		goto lpf_write;
 
-	if (freq < freq_range_lpf[0][0]) {
-		lpf_band = 1;
-
+	if (freq < freq_range_lpf[ADMV8818_BAND_MIN][ADMV8818_BAND_CORNER_LOW]) {
+		lpf_state = ADMV8818_STATE_MIN;
+		lpf_band = ADMV8818_BAND_MIN;
 		goto lpf_write;
 	}
 
-	for (i = 0; i < 4; i++) {
-		if (freq > freq_range_lpf[i][0] && freq < freq_range_lpf[i][1]) {
-			lpf_band = i + 1;
-			freq_step = div_u64((freq_range_lpf[i][1] - freq_range_lpf[i][0]), 15);
+	min_freq_error = U64_MAX;
+	for (band = ADMV8818_BAND_MAX; band >= ADMV8818_BAND_MIN; --band) {
+		/*
+		 * At this point the highest corner frequency of
+		 * all remaining ranges is below the target.
+		 * LPF corner should be >= the target.
+		 */
+		if (freq > freq_range_lpf[band][ADMV8818_BAND_CORNER_HIGH])
+			break;
+
+		freq_step = freq_range_lpf[band][ADMV8818_BAND_CORNER_HIGH] -
+			    freq_range_lpf[band][ADMV8818_BAND_CORNER_LOW];
+		freq_step = div_u64(freq_step, ADMV8818_NUM_STATES - 1);
+
+		for (state = ADMV8818_STATE_MAX; state >= ADMV8818_STATE_MIN; --state) {
 
-			for (j = 0; j <= 15; j++) {
-				if (freq < (freq_range_lpf[i][0] + (freq_step * j))) {
-					lpf_step = j;
-					break;
-				}
+			freq_corner = freq_range_lpf[band][ADMV8818_BAND_CORNER_LOW] +
+				      state * freq_step;
+
+			/*
+			 * At this point all other states in range will
+			 * place the corner frequency below the target
+			 * LPF corner should >= the target.
+			 */
+			if (freq > freq_corner)
+				break;
+
+			freq_error = freq_corner - freq;
+			if (freq_error < min_freq_error) {
+				min_freq_error = freq_error;
+				lpf_state = state;
+				lpf_band = band;
 			}
-			break;
 		}
 	}
 
@@ -225,7 +276,7 @@ static int __admv8818_lpf_select(struct admv8818_state *st, u64 freq)
 
 	return regmap_update_bits(st->regmap, ADMV8818_REG_WR0_FILTER,
 				  ADMV8818_LPF_WR0_MSK,
-				  FIELD_PREP(ADMV8818_LPF_WR0_MSK, lpf_step));
+				  FIELD_PREP(ADMV8818_LPF_WR0_MSK, lpf_state));
 }
 
 static int admv8818_lpf_select(struct admv8818_state *st, u64 freq)
@@ -242,16 +293,28 @@ static int admv8818_lpf_select(struct admv8818_state *st, u64 freq)
 static int admv8818_rfin_band_select(struct admv8818_state *st)
 {
 	int ret;
+	u64 hpf_corner_target, lpf_corner_target;
 
 	st->cf_hz = clk_get_rate(st->clkin);
 
+	/* Check for underflow */
+	if (st->cf_hz > st->hpf_margin_hz)
+		hpf_corner_target = st->cf_hz - st->hpf_margin_hz;
+	else
+		hpf_corner_target = 0;
+
+	/* Check for overflow */
+	lpf_corner_target = st->cf_hz + st->lpf_margin_hz;
+	if (lpf_corner_target < st->cf_hz)
+		lpf_corner_target = U64_MAX;
+
 	mutex_lock(&st->lock);
 
-	ret = __admv8818_hpf_select(st, st->cf_hz);
+	ret = __admv8818_hpf_select(st, hpf_corner_target);
 	if (ret)
 		goto exit;
 
-	ret = __admv8818_lpf_select(st, st->cf_hz);
+	ret = __admv8818_lpf_select(st, lpf_corner_target);
 exit:
 	mutex_unlock(&st->lock);
 	return ret;
@@ -278,8 +341,11 @@ static int __admv8818_read_hpf_freq(struct admv8818_state *st, u64 *hpf_freq)
 
 	hpf_state = FIELD_GET(ADMV8818_HPF_WR0_MSK, data);
 
-	*hpf_freq = div_u64(freq_range_hpf[hpf_band - 1][1] - freq_range_hpf[hpf_band - 1][0], 15);
-	*hpf_freq = freq_range_hpf[hpf_band - 1][0] + (*hpf_freq * hpf_state);
+	*hpf_freq = freq_range_hpf[hpf_band][ADMV8818_BAND_CORNER_HIGH] -
+		    freq_range_hpf[hpf_band][ADMV8818_BAND_CORNER_LOW];
+	*hpf_freq = div_u64(*hpf_freq, ADMV8818_NUM_STATES - 1);
+	*hpf_freq = freq_range_hpf[hpf_band][ADMV8818_BAND_CORNER_LOW] +
+		    (*hpf_freq * hpf_state);
 
 	return ret;
 }
@@ -316,8 +382,11 @@ static int __admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
 
 	lpf_state = FIELD_GET(ADMV8818_LPF_WR0_MSK, data);
 
-	*lpf_freq = div_u64(freq_range_lpf[lpf_band - 1][1] - freq_range_lpf[lpf_band - 1][0], 15);
-	*lpf_freq = freq_range_lpf[lpf_band - 1][0] + (*lpf_freq * lpf_state);
+	*lpf_freq = freq_range_lpf[lpf_band][ADMV8818_BAND_CORNER_HIGH] -
+		    freq_range_lpf[lpf_band][ADMV8818_BAND_CORNER_LOW];
+	*lpf_freq = div_u64(*lpf_freq, ADMV8818_NUM_STATES - 1);
+	*lpf_freq = freq_range_lpf[lpf_band][ADMV8818_BAND_CORNER_LOW] +
+		    (*lpf_freq * lpf_state);
 
 	return ret;
 }
@@ -641,6 +710,32 @@ static int admv8818_clk_setup(struct admv8818_state *st)
 	return devm_add_action_or_reset(&spi->dev, admv8818_clk_notifier_unreg, st);
 }
 
+static int admv8818_read_properties(struct admv8818_state *st)
+{
+	struct spi_device *spi = st->spi;
+	u32 mhz;
+	int ret;
+
+	ret = device_property_read_u32(&spi->dev, "adi,lpf-margin-mhz", &mhz);
+	if (ret == 0)
+		st->lpf_margin_hz = (u64)mhz * HZ_PER_MHZ;
+	else if (ret == -EINVAL)
+		st->lpf_margin_hz = 0;
+	else
+		return ret;
+
+
+	ret = device_property_read_u32(&spi->dev, "adi,hpf-margin-mhz", &mhz);
+	if (ret == 0)
+		st->hpf_margin_hz = (u64)mhz * HZ_PER_MHZ;
+	else if (ret == -EINVAL)
+		st->hpf_margin_hz = 0;
+	else if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int admv8818_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -672,6 +767,10 @@ static int admv8818_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
+	ret = admv8818_read_properties(st);
+	if (ret)
+		return ret;
+
 	ret = admv8818_init(st);
 	if (ret)
 		return ret;
-- 
2.49.0


