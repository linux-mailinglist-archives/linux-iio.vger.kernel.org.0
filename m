Return-Path: <linux-iio+bounces-16012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C30DA42A56
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 18:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF47D18911DB
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 17:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E84825B667;
	Mon, 24 Feb 2025 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="IC+lekd2"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-11.pe-b.jellyfish.systems (out-11.pe-b.jellyfish.systems [198.54.127.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2452747B;
	Mon, 24 Feb 2025 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419514; cv=none; b=b+bHNv8PiSez0jofS5/GgsZHxR+jMipoWzBsyBCjwnl4oPJv1Q36K6C7I7SBWzloJSOAdbwslCCIbKeqiYpLzccZYQEDq9+8UywkdF9ShYJpcoq527521v6i/MELUFiEMjiFG6J8LbqCib7OVBOMspfqtWyUuptsQZhYW/AX+Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419514; c=relaxed/simple;
	bh=GeY7RDoBx5n2VJ6Uz1KBtduejayxCeIDtXYMAhNl5tE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WF9L9T7vda+PnFk/eT+13XSR44hLaQZo027sFmK8q81oWLDJtqlbM9+w3jS9Z53B/ok1a8LZMcuo9m/OG0NagSXboJ2tsOB0MOsZ4FmTDC2b0uqbYNzR3xZlkKV7CY0E7lCWj5uOAc10y0YvRCjr3GY1PefDMvHm6SEjgVs3zDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=IC+lekd2; arc=none smtp.client-ip=198.54.127.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01.privateemail.com [198.54.118.220])
	by pe-b.jellyfish.systems (Postfix) with ESMTPA id 4Z1pFs2ZLtzFqDp;
	Mon, 24 Feb 2025 17:51:45 +0000 (UTC)
Received: from MTA-13.privateemail.com (unknown [10.50.14.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01.privateemail.com (Postfix) with ESMTPS id 4Z1pFs1cW7z3hhVd;
	Mon, 24 Feb 2025 12:51:45 -0500 (EST)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
	by mta-13.privateemail.com (Postfix) with ESMTP id 4Z1pFs0Rhrz3hhVT;
	Mon, 24 Feb 2025 12:51:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1740419505;
	bh=GeY7RDoBx5n2VJ6Uz1KBtduejayxCeIDtXYMAhNl5tE=;
	h=From:To:Cc:Subject:Date:From;
	b=IC+lekd2L4pwCU4ED/uJ5TjdkLjAF2uSqC6aa6Q5QqbJ/xqgAJQj4la6sejmU1HGP
	 qQOqF3lnrIXeLeR5YHp1CGAlesHVwDz6Cwl3fxlcDhqzy48j0ijrwEIaIEzubaL0FR
	 PtM7eSDiF8Xq3pJf1i42YVcl4VojBBi+ImvTpA0w6ZFSgeLEmFofUb5eH3rGH3GVSt
	 4ADp+PUvzyLNLUbhgoHPPmYmgxws4DlgQTNr81PCq/VXJzJoImcMA7VygnJRdT9wOS
	 tvB4INjFQiflzeQAAlyOUztfaN1uJLjy0iyabctjLrjU7/cMYIluPt8bFQkpfMQU11
	 FVeaBEpIphd1g==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-13.privateemail.com (Postfix) with ESMTPA;
	Mon, 24 Feb 2025 12:51:37 -0500 (EST)
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org,
	antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	sam.winchenbach@framepointer.org
Subject: [PATCH v3 1/2] iio: filter: admv8818: fix range calculation
Date: Mon, 24 Feb 2025 12:50:55 -0500
Message-ID: <20250224175056.560111-1-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Corrects the upper range of LPF Band 4 from 18.5 GHz to 18.85 GHz per
the ADMV8818 datasheet

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
Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
---
V1 -> V2: Cleaned up the wording of the commit message
V2 -> V3: Add DTS properties to control corner frequency margins
---
 drivers/iio/filter/admv8818.c | 136 ++++++++++++++++++++++++++--------
 1 file changed, 105 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 848baa6e3bbf..a446d8d421ae 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -90,6 +90,8 @@ struct admv8818_state {
 	struct mutex		lock;
 	unsigned int		filter_mode;
 	u64			cf_hz;
+	u64			lpf_margin_hz;
+	u64			hpf_margin_hz;
 };
 
 static const unsigned long long freq_range_hpf[4][2] = {
@@ -103,7 +105,7 @@ static const unsigned long long freq_range_lpf[4][2] = {
 	{2050000000ULL, 3850000000ULL},
 	{3350000000ULL, 7250000000ULL},
 	{7000000000, 13000000000},
-	{12550000000, 18500000000}
+	{12550000000, 18850000000}
 };
 
 static const struct regmap_config admv8818_regmap_config = {
@@ -122,43 +124,59 @@ static const char * const admv8818_modes[] = {
 static int __admv8818_hpf_select(struct admv8818_state *st, u64 freq)
 {
 	unsigned int hpf_step = 0, hpf_band = 0, i, j;
+	u64 freq_error;
+	u64 min_freq_error;
+	u64 freq_corner;
 	u64 freq_step;
 	int ret;
 
 	if (freq < freq_range_hpf[0][0])
 		goto hpf_write;
 
-	if (freq > freq_range_hpf[3][1]) {
+	if (freq >= freq_range_hpf[3][1]) {
 		hpf_step = 15;
 		hpf_band = 4;
 
 		goto hpf_write;
 	}
 
+	/* Close HPF frequency gap between 12 and 12.5 GHz */
+	if (freq >= 12000 * HZ_PER_MHZ && freq < 12500 * HZ_PER_MHZ) {
+		hpf_step = 15;
+		hpf_band = 3;
+
+		goto hpf_write;
+	}
+
+	min_freq_error = U64_MAX;
 	for (i = 0; i < 4; i++) {
+		/* This (and therefore all other ranges) have a corner
+		 * frequency higher than the target frequency.
+		 */
+		if (freq_range_hpf[i][0] > freq)
+			break;
+
 		freq_step = div_u64((freq_range_hpf[i][1] -
 			freq_range_hpf[i][0]), 15);
 
-		if (freq > freq_range_hpf[i][0] &&
-		    (freq < freq_range_hpf[i][1] + freq_step)) {
-			hpf_band = i + 1;
+		for (j = 0; j <= 15; j++) {
+			freq_corner = freq_range_hpf[i][0] + (freq_step * j);
+
+			/* This (and therefore all other steps) have a corner
+			 * frequency higher than the target frequency.
+			 */
+			if (freq_corner > freq)
+				break;
 
-			for (j = 1; j <= 16; j++) {
-				if (freq < (freq_range_hpf[i][0] + (freq_step * j))) {
-					hpf_step = j - 1;
-					break;
-				}
+			freq_error = freq - freq_corner;
+			if (freq_error < min_freq_error) {
+				min_freq_error = freq_error;
+				hpf_step = j;
+				hpf_band = i + 1;
 			}
-			break;
 		}
 	}
 
-	/* Close HPF frequency gap between 12 and 12.5 GHz */
-	if (freq >= 12000 * HZ_PER_MHZ && freq <= 12500 * HZ_PER_MHZ) {
-		hpf_band = 3;
-		hpf_step = 15;
-	}
-
 hpf_write:
 	ret = regmap_update_bits(st->regmap, ADMV8818_REG_WR0_SW,
 				 ADMV8818_SW_IN_SET_WR0_MSK |
@@ -186,7 +204,11 @@ static int admv8818_hpf_select(struct admv8818_state *st, u64 freq)
 
 static int __admv8818_lpf_select(struct admv8818_state *st, u64 freq)
 {
-	unsigned int lpf_step = 0, lpf_band = 0, i, j;
+	int i, j;
+	unsigned int lpf_step = 0, lpf_band = 0;
+	u64 freq_error;
+	u64 min_freq_error;
+	u64 freq_corner;
 	u64 freq_step;
 	int ret;
 
@@ -199,18 +221,34 @@ static int __admv8818_lpf_select(struct admv8818_state *st, u64 freq)
 		goto lpf_write;
 	}
 
-	for (i = 0; i < 4; i++) {
-		if (freq > freq_range_lpf[i][0] && freq < freq_range_lpf[i][1]) {
-			lpf_band = i + 1;
-			freq_step = div_u64((freq_range_lpf[i][1] - freq_range_lpf[i][0]), 15);
-
-			for (j = 0; j <= 15; j++) {
-				if (freq < (freq_range_lpf[i][0] + (freq_step * j))) {
-					lpf_step = j;
-					break;
-				}
-			}
+	min_freq_error = U64_MAX;
+	for (i = 3; i >= 0; --i) {
+		/* At this point the highest corner frequency of
+		 * all remaining ranges is below the target.
+		 * LPF corner should be >= the target.
+		 */
+		if (freq > freq_range_lpf[i][1])
 			break;
+
+		freq_step = div_u64((freq_range_lpf[i][1] - freq_range_lpf[i][0]), 15);
+
+		for (j = 15; j >= 0; --j) {
+
+			freq_corner = freq_range_lpf[i][0] + j*freq_step;
+
+			/* At this point all other steps in range will
+			 * place the corner frequency below the target
+			 * LPF corner should >= the target.
+			 */
+			if (freq > freq_corner)
+				break;
+
+			freq_error = freq_corner - freq;
+			if (freq_error < min_freq_error) {
+				min_freq_error = freq_error;
+				lpf_step = j;
+				lpf_band = i + 1;
+			}
 		}
 	}
 
@@ -242,16 +280,28 @@ static int admv8818_lpf_select(struct admv8818_state *st, u64 freq)
 static int admv8818_rfin_band_select(struct admv8818_state *st)
 {
 	int ret;
+	u64 hpf_corner_target, lpf_corner_target;
 
 	st->cf_hz = clk_get_rate(st->clkin);
 
+	// Check for underflow
+	if (st->cf_hz > st->hpf_margin_hz)
+		hpf_corner_target = st->cf_hz - st->hpf_margin_hz;
+	else
+		hpf_corner_target = 0;
+
+	// Check for overflow
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
+	ret = __admv8818_lpf_select(st, lfp_corner_target);
 exit:
 	mutex_unlock(&st->lock);
 	return ret;
@@ -647,6 +697,26 @@ static int admv8818_clk_setup(struct admv8818_state *st)
 	return devm_add_action_or_reset(&spi->dev, admv8818_clk_notifier_unreg, st);
 }
 
+static int admv8818_read_properties(struct admv8818_state *st)
+{
+	struct spi_device *spi = st->spi;
+	int ret;
+
+	ret = device_property_read_u64(&spi->dev, "adi,lpf-margin-hz", &st->lpf_margin_hz);
+	if (ret == -EINVAL)
+		st->lpf_margin_hz = 0;
+	else if (ret < 0)
+		return ret;
+
+	ret = device_property_read_u64(&spi->dev, "adi,hpf-margin-hz", &st->hpf_margin_hz);
+	if (ret == -EINVAL)
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
@@ -678,6 +748,10 @@ static int admv8818_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
+	ret = admv8818_read_properties(st);
+	if (ret)
+		return ret;
+
 	ret = admv8818_init(st);
 	if (ret)
 		return ret;
-- 
2.48.1


