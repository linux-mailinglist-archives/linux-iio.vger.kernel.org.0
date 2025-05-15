Return-Path: <linux-iio+bounces-19542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D08AB81A3
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34C31689A9
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 08:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EF3293B63;
	Thu, 15 May 2025 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b="o2970clG"
X-Original-To: linux-iio@vger.kernel.org
Received: from clean64.mxserver.ro (clean64.mxserver.ro [89.44.139.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5EC28C843;
	Thu, 15 May 2025 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.44.139.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299376; cv=none; b=N2PHlS4nTQKsJc7Z+2Dkla3xjBKotybFxHwgR8k7hcGYleV/UPpy9scE+lQI95hx5n1Y6mJQRO6vUmz7nO1yVIxVcoEf5/f9Di61gHKOMhwk5aKxu/DPwftNXj9WhaY7+SqMNeEIXtA9U4hqqiGW1gcgYnVlsaSP+3DLyWtQHR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299376; c=relaxed/simple;
	bh=N8j4I4fkFCpIkznTeW9ldkHUN3alnXsC8Jw3boo96ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlF/k+FBcPk6F0ccLaKHo4Ewv8vJCdDo+x+bQaqNcFhSgUaWe+3/SUxReU9xMkg8EYRBJzEuHpjPQtOnkV637RoikhX/S9ilIYVRbNjJfo482y9toEmxp4LEt4YQgqUEKmISFfwBQiMvKPPdpIa0t12Il8G+ZjXDCifW9bf9tyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro; spf=pass smtp.mailfrom=taladin.ro; dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b=o2970clG; arc=none smtp.client-ip=89.44.139.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Received: from cloud347.c-f.ro ([185.236.86.218])
	by cleanserver2.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTm1-001Vxp-7f; Thu, 15 May 2025 04:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UUMeAh+/oO9zW+np+bm56HwIJA0Jn1VWd8Ucu5fYOxw=; b=o2970clGp6SX2iHSkiqWq4Fm2C
	YncD8/clKBN6Zz8Bl0r501793xsP2X3pn3mNu/zICtu9228CxLEfOZKZcMnK79u/HqQfhbmubjTqn
	CaAXp/bcFfOvbST12s3spEJW9vtZEvmQSSkDXdWXiT1jhc+mf4aa3ZZohojoUiCXlFoRUm2XaS9t+
	STmLNt3r1EwGhZTh0nqPdWMFI9/JIGJuUnUlBNvDLiQ0MmNSbFQ0oPZ15l6hvmaZd1gBgEKQ/q7Wi
	Od2X+yIGGFKFVGtkmKulF3jWn4+RkM2VllYoa0dSTTPH1I8SFZQgXMRmw/nA4b1ufv06esje/3YSv
	qQem1twQ==;
Received: from [109.166.137.172] (port=38974 helo=localhost)
	by cloud347.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTlp-00000006q9o-2C7u;
	Thu, 15 May 2025 11:16:58 +0300
From: Alexandru Soponar <asoponar@taladin.ro>
To: linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	jic23@kernel.org,
	pavel@ucw.cz,
	lee@kernel.org,
	baocheng.su@siemens.com,
	wim@linux-watchdog.org,
	tobias.schaffner@siemens.com,
	angelogioacchino.delregno@collabora.com,
	benedikt.niedermayr@siemens.com,
	matthias.bgg@gmail.com,
	aardelean@baylibre.com,
	contact@sopy.one,
	Alexandru Soponar <asoponar@taladin.ro>
Subject: [PATCH 06/16] hwmon: lm75: Fix type incompatibility with non-macro find_closest
Date: Thu, 15 May 2025 11:13:22 +0300
Message-ID: <20250515081332.151250-7-asoponar@taladin.ro>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515081332.151250-1-asoponar@taladin.ro>
References: <20250515081332.151250-1-asoponar@taladin.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SpamExperts-Domain: cloud347.c-f.ro
X-SpamExperts-Username: 185.236.86.218
Authentication-Results: mxserver.ro; auth=pass smtp.auth=185.236.86.218@cloud347.c-f.ro
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00944947725381)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9FfpFOLnuHlwgr/64pwLjPPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5TSx
 S75yz9IFZiY7BarU/NrpK8SEOwGmfn6ucAKqn/OHRh3BqzFaEnAEj4UixLJBjVNiLZt/QXQnOBRD
 +jq1HsIBmHTFdhqXZEtguZY7iGKpkcJnJKaJfT+dw1udmv00tbIRNtoyOobb3xnDyRRylAVTYi2b
 f0F0JzgUQ/o6tR7C8pLPCtTiVLo0r89ClJHDKhDGKgJ+T00JeCnHBmMdB1eMZAyYlfUtEN4pUyes
 jVRntA/J5DcfwvG53FyVviDO9UET3GKmqv1jT0lY+AQz8YX4CVph7ctC7tRH2SPTQJ/0klTuXKq/
 B9rqRWsYzNfBLt79i78aPHyWnIqxGMxPZotYvH/es1vXuByXo2bkrYMqq0x5CzaUoJIoBUQayHle
 UvbvCQmh9x4kn6NeQcRkc6G+OgAcq5x+BzhRyg9rYO6I0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X
 +u7aTqYHtT2CBuxNPBc9JM2jck1NnIBf0tvflhq7Xjhll72AYgnW/6M0ftSpvLIx+X1vKami8KF6
 jWQ71uVNIY/EFPWeDmcZuFRQy1vmjjPiYw8fUCp0/qY6cmSW9oUDdvKuTRfTGZ6f8nTXoYFaQ71l
 mMti8uxA0gKVmIzBXtbLDVvAQ/KVNd7rUq/n6fQuwtIkosTxaZqSAN5VcIfsMVILjVAz6RZsCHxD
 lgOJwEwCFaF+62b2lf1UUDu9jECN1V/lwmsioRLmNJoHOZOE/9e5UD715p61XAQw85DCXa0iAPEd
 fYyrF5wMRSLGyY+i0m2IxQLxQUzTb3Mji+CrO1+NTWs5OBXbSDBPqdRoFsq0hfzdx0oxkgNI/jhY
 WFhu7VV+HdWjdZLlmQ5z83qEVVG/6RJ+BW7FmGcwL889DSW2cZWGkIYVQAbHnYkWUz1gRIjAiMvi
 vM7um7t0SVa5NVZ2g1u6DnOpqk1nwAzTSgytNKIH5lfAuQc8I07FTFcjpdfX/Jcr87en7cKbI0NU
 afdkQMG+6qjtXoANVR89VM6f75a5kmRIbungV7ywXD8VtmM8wef5C6IkqMFhROX1HYRo9Sm1kZOW
 saz62DSUUd/fn3Ix/aSqJVglEtnFggTvi4y/qO0sxBxzHDeqqFz43py4SDhdaHkWOGxZQgSAzbb+
 OB/nFYi5VbOv2oY4HXLSfAUu3sMpupagPNAXGWDM/j1iXqKVmckXMvYnkNWjwSQDaUU9MqYUCeef
 0nlkmUPzlfoLUG4g/XHuva4NQ7gH1kLtR+dZ31Wj92PNDpgLsd6Ddd/s7VM53twrVC8K+lj1c6e/
 tTmd6eMo8njYQeCXryE9YzCFXixh6fB/PCFzQ6qBdOFXbBtHjzFRaJdtHxap1B2hSHfH7uFr/yiP
 gGFyxS1LuwmPRAQzaEJVYkfhZXq/u54kZVCWtfUf9oDBqtClgM5jH/om1Q6gjkapWNvVA5HRyb3X
 trWYR6vnFpUUmgU46LTsHtrjRqVe/ojyw7bapws3danDDsxD6gvvWu5/Lf1bKbM1VroDfVYPkwIu
 /8x7KhILIr1IfwgT9kxT5f4reZBSMLp/jH4zvQRYQJnl3XNqRK2lK/zP
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro
X-Complaints-To: abuse@cleanserver1.mxserver.ro

The default_sample_time and sample_times members of lm75_params were
previously declared as unsigned int but used withfind_closest(). With
find_closest() now implemented as a function taking signed int parameters
instead of a macro, passing unsigned arrays causes type incompatibility
errors. This patch changes the types from unsigned int and unsigned int*
to int respectively int* to ensure compatibility with the function
signature and prevent compilation errors.

Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
---
 drivers/hwmon/lm75.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index d95a3c6c245c..5c835ee189d4 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -89,9 +89,9 @@ struct lm75_params {
 	u8			default_resolution;
 	u8			resolution_limits;
 	const u8		*resolutions;
-	unsigned int		default_sample_time;
+	int			default_sample_time;
 	u8			num_sample_times;
-	const unsigned int	*sample_times;
+	const int		*sample_times;
 	bool			alarm;
 };
 
@@ -110,7 +110,7 @@ struct lm75_data {
 	struct regmap			*regmap;
 	u16				orig_conf;
 	u8				resolution;	/* In bits, 9 to 16 */
-	unsigned int			sample_time;	/* In ms */
+	int				sample_time;	/* In ms */
 	enum lm75_type			kind;
 	const struct lm75_params	*params;
 	u8				reg_buf[1];
@@ -139,7 +139,7 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 12,
 		.default_sample_time = 125,
 		.num_sample_times = 4,
-		.sample_times = (unsigned int []){ 125, 250, 1000, 4000 },
+		.sample_times = (int []){ 125, 250, 1000, 4000 },
 		.alarm = true,
 	},
 	[at30ts74] = {
@@ -147,7 +147,7 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 12,
 		.default_sample_time = 200,
 		.num_sample_times = 4,
-		.sample_times = (unsigned int []){ 25, 50, 100, 200 },
+		.sample_times = (int []){ 25, 50, 100, 200 },
 		.resolutions = (u8 []) {9, 10, 11, 12 },
 	},
 	[ds1775] = {
@@ -156,7 +156,7 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 11,
 		.default_sample_time = 500,
 		.num_sample_times = 4,
-		.sample_times = (unsigned int []){ 125, 250, 500, 1000 },
+		.sample_times = (int []){ 125, 250, 500, 1000 },
 		.resolutions = (u8 []) {9, 10, 11, 12 },
 	},
 	[ds75] = {
@@ -165,7 +165,7 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 11,
 		.default_sample_time = 600,
 		.num_sample_times = 4,
-		.sample_times = (unsigned int []){ 150, 300, 600, 1200 },
+		.sample_times = (int []){ 150, 300, 600, 1200 },
 		.resolutions = (u8 []) {9, 10, 11, 12 },
 	},
 	[stds75] = {
@@ -174,7 +174,7 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 11,
 		.default_sample_time = 600,
 		.num_sample_times = 4,
-		.sample_times = (unsigned int []){ 150, 300, 600, 1200 },
+		.sample_times = (int []){ 150, 300, 600, 1200 },
 		.resolutions = (u8 []) {9, 10, 11, 12 },
 	},
 	[stlm75] = {
@@ -186,7 +186,7 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 12,
 		.default_sample_time = 200,
 		.num_sample_times = 4,
-		.sample_times = (unsigned int []){ 25, 50, 100, 200 },
+		.sample_times = (int []){ 25, 50, 100, 200 },
 		.resolutions = (u8 []) {9, 10, 11, 12 },
 	},
 	[g751] = {
@@ -227,13 +227,13 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 12,
 		.default_sample_time = 55,
 		.num_sample_times = 4,
-		.sample_times = (unsigned int []){ 28, 55, 110, 220 },
+		.sample_times = (int []){ 28, 55, 110, 220 },
 	},
 	[pct2075] = {
 		.default_resolution = 11,
 		.default_sample_time = MSEC_PER_SEC / 10,
 		.num_sample_times = 31,
-		.sample_times = (unsigned int []){ 100, 200, 300, 400, 500, 600,
+		.sample_times = (int []){ 100, 200, 300, 400, 500, 600,
 		700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700,
 		1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700,
 		2800, 2900, 3000, 3100 },
@@ -245,7 +245,7 @@ static const struct lm75_params device_params[] = {
 		.resolution_limits = 9,
 		.default_sample_time = 240,
 		.num_sample_times = 4,
-		.sample_times = (unsigned int []){ 30, 60, 120, 240 },
+		.sample_times = (int []){ 30, 60, 120, 240 },
 		.resolutions = (u8 []) {9, 10, 11, 12 },
 	},
 	[tmp100] = {
@@ -254,7 +254,7 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 12,
 		.default_sample_time = 320,
 		.num_sample_times = 4,
-		.sample_times = (unsigned int []){ 40, 80, 160, 320 },
+		.sample_times = (int []){ 40, 80, 160, 320 },
 		.resolutions = (u8 []) {9, 10, 11, 12 },
 	},
 	[tmp101] = {
@@ -263,7 +263,7 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 12,
 		.default_sample_time = 320,
 		.num_sample_times = 4,
-		.sample_times = (unsigned int []){ 40, 80, 160, 320 },
+		.sample_times = (int []){ 40, 80, 160, 320 },
 		.resolutions = (u8 []) {9, 10, 11, 12 },
 	},
 	[tmp105] = {
@@ -272,7 +272,7 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 12,
 		.default_sample_time = 220,
 		.num_sample_times = 4,
-		.sample_times = (unsigned int []){ 28, 55, 110, 220 },
+		.sample_times = (int []){ 28, 55, 110, 220 },
 		.resolutions = (u8 []) {9, 10, 11, 12 },
 	},
 	[tmp112] = {
@@ -282,7 +282,7 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 12,
 		.default_sample_time = 125,
 		.num_sample_times = 4,
-		.sample_times = (unsigned int []){ 125, 250, 1000, 4000 },
+		.sample_times = (int []){ 125, 250, 1000, 4000 },
 		.alarm = true,
 	},
 	[tmp175] = {
@@ -291,7 +291,7 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 12,
 		.default_sample_time = 220,
 		.num_sample_times = 4,
-		.sample_times = (unsigned int []){ 28, 55, 110, 220 },
+		.sample_times = (int []){ 28, 55, 110, 220 },
 		.resolutions = (u8 []) {9, 10, 11, 12 },
 	},
 	[tmp275] = {
@@ -300,7 +300,7 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 12,
 		.default_sample_time = 220,
 		.num_sample_times = 4,
-		.sample_times = (unsigned int []){ 28, 55, 110, 220 },
+		.sample_times = (int []){ 28, 55, 110, 220 },
 		.resolutions = (u8 []) {9, 10, 11, 12 },
 	},
 	[tmp75] = {
@@ -309,14 +309,14 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 12,
 		.default_sample_time = 220,
 		.num_sample_times = 4,
-		.sample_times = (unsigned int []){ 28, 55, 110, 220 },
+		.sample_times = (int []){ 28, 55, 110, 220 },
 		.resolutions = (u8 []) {9, 10, 11, 12 },
 	},
 	[tmp75b] = { /* not one-shot mode, Conversion rate 37Hz */
 		.clr_mask = 1 << 7 | 3 << 5,
 		.default_resolution = 12,
 		.default_sample_time = MSEC_PER_SEC / 37,
-		.sample_times = (unsigned int []){ MSEC_PER_SEC / 37,
+		.sample_times = (int []){ MSEC_PER_SEC / 37,
 			MSEC_PER_SEC / 18,
 			MSEC_PER_SEC / 9, MSEC_PER_SEC / 4 },
 		.num_sample_times = 4,
@@ -331,7 +331,7 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 12,
 		.default_sample_time = 28,
 		.num_sample_times = 4,
-		.sample_times = (unsigned int []){ 28, 55, 110, 220 },
+		.sample_times = (int []){ 28, 55, 110, 220 },
 	}
 };
 
-- 
2.49.0


