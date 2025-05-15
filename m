Return-Path: <linux-iio+bounces-19528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC94FAB80EC
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3224E2868
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 08:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B3A28688B;
	Thu, 15 May 2025 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b="oZg/9LFI"
X-Original-To: linux-iio@vger.kernel.org
Received: from clean236.mxserver.ro (clean236.mxserver.ro [46.102.249.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9193E21773F;
	Thu, 15 May 2025 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.102.249.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298076; cv=none; b=OCkuSAX43dEIA4gJT27r0W28p5ESutgh5mMRfvaRVBiZDD9w6+4wZpfVFF5CgJz/QNAapf+rW9dZspRXS7QGoyiSpmRX7Js9fzMlQNeUa3+buUJ64zmKe3ICHxqcWe/KaCs6S1yRhSKx32KlkmX6Aav0VFuzBzenl4xeXfQY+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298076; c=relaxed/simple;
	bh=sbh2TgozFx82F6G8POWcV7D4BCUYqhDfLYv1kZRr97c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYa4bMjpSHUmrp9G060h6lOMdEHwq0nOPIR1Ea+w2K8set2ODwHCVLefRR2XpdTNj4JzJKg8W17qSmM1iPZRZWlA835ditDpf9juXLhxlcVVXpi2YQhvIYV08HwO78upA/bOCCJW4G/6dJYsR7aPiwVQcDLZPFvCfGmSo6u1YkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro; spf=pass smtp.mailfrom=taladin.ro; dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b=oZg/9LFI; arc=none smtp.client-ip=46.102.249.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Received: from cloud347.c-f.ro ([185.236.86.218])
	by cleanserver2.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTly-001Vuu-IH; Thu, 15 May 2025 04:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UFB0QqKFqo4QjZyGDVXEQR2DAdpo2Z7EMAgmApIGyy8=; b=oZg/9LFIGexOaI/olQutKUJGjM
	3zhKyPZnp28xMCRBMmLuUYYr9Im60xxOlEfSk62kgrAG3mkQzjJWRZfAIjWR5JyUxonfcYqrOgwp3
	3qqRUT/wkjAWJZf+9bRMvkYJT+wjQ6XTZGYC9nQjjmoAWqUZvk4lhLZs3f4upuCG4D5YTi5+h9mJP
	nd2APBW7mPfOklJ/mj7OCvxlVrH8NChL+W7MRDwo+tV+vDXvieeu7ZFEGc34AG0tXpuCyYl36k7ys
	LNdJYnY61Iyi03h0lCHKQBKdZpBF3I9WI8SkJ7qan8l7i3ogfaoMgeAKcwiv1wNpEOAQ26b245CgD
	337agYew==;
Received: from [109.166.137.172] (port=37888 helo=localhost)
	by cloud347.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTlm-00000006q8Q-3e7Y;
	Thu, 15 May 2025 11:16:55 +0300
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
Subject: [PATCH 03/16] hwmon: ina3221: Fix type incompatibility with non-macro find_closest
Date: Thu, 15 May 2025 11:13:19 +0300
Message-ID: <20250515081332.151250-4-asoponar@taladin.ro>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00179392393933)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8YP3XPz971hchIDSqEbakuPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5TSx
 S75yz9IFZiY7BarU/NrpK8SEOwGmfn6ucAKqn/OHRh3BqzFaEnAEj4UixLJBjVNiLZt/QXQnOBRD
 +jq1HsIBmHTFdhqXZEtguZY7iGKpkcJnJKaJfT+dw1udmv00tbIRNtoyOobb3xnDyRRylAVTYi2b
 f0F0JzgUQ/o6tR7C8pLPCtTiVLo0r89ClJHDKhDGKgJ+T00JeCnHBmMdB1eMZAyYlfUtEN4pUyes
 jVRntA/J5DcfwvG53FyVviDO9UET3GKmqv1jT0lY+AQz8YX4CVph7ctC7tRH2SPTQJ/0klTuXKq/
 B9rqRWsYzNfBLt79i78aPHyWnIqxGMxPZotYvH/es1vXuByXo2bkrYMqq0x5CzaUoJIoBUQayHle
 UvbvCQmh9x4kn6NeQcRkc6G+OgAcq5x+BzhRyg9rYO6I0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X
 +u7aTqYHtT2CBuxNPBc9JM2jck1NnIBf0tvflhq7Xjhll72AYgnW/6M0ftSpvLIx+X1vKami8KF6
 jWQ71uVNIY/EFPWeDmcZuFRQy1vmjjPiYw8fUCp0/qY6cmSW9oUDdvKuTRfTGZ6f8nTXoYFaQ71l
 mMti8uxA0gKVmIzBXtbLDVvAQ/KVNTP+CYrCDLMKtbUjADVLUfiSAN5VcIfsMVILjVAz6RZsCHxD
 lgOJwEwCFaF+62b2lf1UUDu9jECN1V/lwmsioRLmNJoHOZOE/9e5UD715p61XAQw85DCXa0iAPEd
 fYyrF5wMRSLGyY+i0m2IxQLxQUzTb3Mji+CrO1+NTWs5OBXbSDBPqdRoFsq0hfzdx0oxkgNI/jhY
 WFhu7VV+HdWjdZLlmQ5z83qEVVG/6RJ+BW7FmGcwL889DSW2cZWGkIYVQAbHnYkWUz1gRIjAiMvi
 vM7um7t0SVa5NVZ2g1u6DnOpqk1nwAzTSgytNKIH5lfAuQc8I07FTFcjpdfX/Jcr87en7cKbI0NU
 afdkQMG+6qjtXoANVR89VM6f75a5kmRIbungV7ywXD8VtmM8wef5C6IkqMFhROX1HYRo9Sm1kZOW
 saz62DSUUd/fn3Ix/aSqJVglEtnFggTvi4y/qO0sxBxzHDeqqFz43py4SDhdaHkWOGxZQgSAzbb+
 OB/nFYi5VbOv2oY4HXLSfAUu3sMpupZGSAJZedccoId9/9sBGfwPMvYnkNWjwSQDaUU9MqYUCeef
 0nlkmUPzlfoLUG4g/XHuva4NQ7gH1kLtR+dZ31Wj92PNDpgLsd6Ddd/s7VM53twrVC8K+lj1c6e/
 tTmd6eMo8njYQeCXryE9YzCFXixhwvxmPq7Q0oK0JlkJQ2noHi2tPmCjLtpYrURqjuMqXHdr/yiP
 gGFyxS1LuwmPRAQzaEJVYkfhZXq/u54kZVCWtfUf9oDBqtClgM5jH/om1Q6gjkapWNvVA5HRyb3X
 trWYR6vnFpUUmgU46LTsHtrjRqVe/ojyw7bapws3danDDsxD6gvvWu5/Lf1bKbM1VroDfVYPkwIu
 /8x7KhILIr1IfwgT9kxT5f4reZBSMLp/jH4zvQRYQJnl3XNqRK2lK/zP
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro
X-Complaints-To: abuse@cleanserver1.mxserver.ro

The ina3221_conv_time array was previously declared as u16 but used with
find_closest(). With find_closest() now implemented as a function taking
signed int parameters instead of a macro, passing unsigned arrays causes
type incompatibility errors. This patch changes the array type from
u16 to int to ensure compatibility with the function signature and
prevent compilation errors.

Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
---
 drivers/hwmon/ina3221.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 1bf479a0f793..482ab8e53d5c 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -178,7 +178,7 @@ static inline int ina3221_summation_shunt_resistor(struct ina3221_data *ina)
 }
 
 /* Lookup table for Bus and Shunt conversion times in usec */
-static const u16 ina3221_conv_time[] = {
+static const int ina3221_conv_time[] = {
 	140, 204, 332, 588, 1100, 2116, 4156, 8244,
 };
 
@@ -192,7 +192,7 @@ static inline u32 ina3221_interval_ms_to_conv_time(u16 config, int interval)
 {
 	u32 channels = hweight16(config & INA3221_CONFIG_CHs_EN_MASK);
 	u32 samples_idx = INA3221_CONFIG_AVG(config);
-	u32 samples = ina3221_avg_samples[samples_idx];
+	int samples = ina3221_avg_samples[samples_idx];
 
 	/* Bisect the result to Bus and Shunt conversion times */
 	return DIV_ROUND_CLOSEST(interval * 1000 / 2, channels * samples);
@@ -204,8 +204,8 @@ static inline u32 ina3221_reg_to_interval_us(u16 config)
 	u32 channels = hweight16(config & INA3221_CONFIG_CHs_EN_MASK);
 	u32 vbus_ct_idx = INA3221_CONFIG_VBUS_CT(config);
 	u32 vsh_ct_idx = INA3221_CONFIG_VSH_CT(config);
-	u32 vbus_ct = ina3221_conv_time[vbus_ct_idx];
-	u32 vsh_ct = ina3221_conv_time[vsh_ct_idx];
+	int vbus_ct = ina3221_conv_time[vbus_ct_idx];
+	int vsh_ct = ina3221_conv_time[vsh_ct_idx];
 
 	/* Calculate total conversion time */
 	return channels * (vbus_ct + vsh_ct);
-- 
2.49.0


