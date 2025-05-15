Return-Path: <linux-iio+bounces-19529-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 692A4AB8122
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50A83A74A8
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 08:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC98212B18;
	Thu, 15 May 2025 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b="LHUUwW/G"
X-Original-To: linux-iio@vger.kernel.org
Received: from clean107.mxserver.ro (clean107.mxserver.ro [176.223.123.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDA0202F67;
	Thu, 15 May 2025 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.223.123.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298497; cv=none; b=aWFmn/znpOZeN+e2HRGd4oNw6pAUSwL7+Hqm9euIDHI+Y+x3IF71jU+6ysNLF1ZON2itzn1hYkwUO8VQ6C2sAZfcVXSu37L2gE36hGvsUxFAHaoOomkFvoE66lfacWOFe7FeRRDNTJwavo61J91vUa8GIJwprmpFGWdaKf4wvxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298497; c=relaxed/simple;
	bh=bCbjH+cBqaaixa9+TY8w+NZGMFvMQ38v6+3wrV3dMy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuoAhaVh9vGkMVKeCcV0S+8Z9CUGZF/yZEZNGqaAt+o2PdxMoao/JX8Ogb+jQ6j30kOJ5MjJjmzGjKnoZgLiTGAqBR0pdTcDbvI3TOlQBiStsAXxuln332kvFBRpvGk/+UIQKP7yb+Y+xpDHQfHNRXWYLQ2YEvEOYvroDq5AfHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro; spf=pass smtp.mailfrom=taladin.ro; dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b=LHUUwW/G; arc=none smtp.client-ip=176.223.123.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Received: from cloud347.c-f.ro ([185.236.86.218])
	by cleanserver1.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTm7-00H1Wf-8B; Thu, 15 May 2025 04:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1bK3x9Cf1janHuAyHMAjvkEWzTeVMVa5qbM6x9ETvWw=; b=LHUUwW/GPGI2EuBOSzr6OoZVt3
	6LUBS3+ZuTMuYWoLCQ1NrGQ3AMkyhn5O389VsX+/o+b741lWVzclDVAG+6U8XfDB7Imo0YT/dWTwa
	M8rM4ymvm6fSGQP/7mOp7glxAUPqBj2Wme73SgwS7hKA1ZxToPP5AfiXCrnPM1Uv/NikpxTrgtntC
	PwAbBZKsXShfC3ooMb9DtyJPUcdrjGjH3NY/Tfd1VCEG0WdPKd5Ml6e5NHUZA7nj6WBbOzL/nq8r+
	BpCyKGJHzw7v2G8+CfUE1/ov9D3OlC99QtSDKg8hLTm7lfTWCGBJo2Q5XCblWZglLagtWSDrOxh1L
	8nJswmrA==;
Received: from [109.166.137.172] (port=39052 helo=localhost)
	by cloud347.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTlx-00000006qJ7-0WAp;
	Thu, 15 May 2025 11:17:06 +0300
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
Subject: [PATCH 13/16] leds: eds-mt6370-rgb: Fix type incompatibility with find_closest()
Date: Thu, 15 May 2025 11:13:29 +0300
Message-ID: <20250515081332.151250-14-asoponar@taladin.ro>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT94YpnLF5SwLL9ehD3Nt/zePUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5TSx
 S75yz9IFZiY7BarU/NrpK8SEOwGmfn6ucAKqn/OHRh3BqzFaEnAEj4UixLJBjVNiLZt/QXQnOBRD
 +jq1HsIBmHTFdhqXZEtguZY7iGKpkcJnJKaJfT+dw1udmv00tbIRNtoyOobb3xnDyRRylAVTYi2b
 f0F0JzgUQ/o6tR7C8pLPCtTiVLo0r89ClJHDKhDGKgJ+T00JeCnHBmMdB1eMZAyYlfUtEN4pUyes
 jVRntA/J5DcfwvG53FyVviDO9UET3GKmqv1jT0lY+AQz8YX4CVph7ctC7tRH2SPTQJ/0klTuXKq/
 B9rqRWsYzNfBLt79i78aPHyWnIqxGMxPZotYvH/es1vXuByXo2bkrYMqq0x5CzaUoJIoBUQayHle
 UvbvCQmh9x4kn6NeQcRkc6G+OgAcq5x+BzhRyg9rYO6I0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X
 +u7aTqYHtT2CBuxNPBc9JM2jck1NnIBf0tvflhq7Xjhll72AYgnW/6M0ftSpvLIx+X1vKami8KF6
 jWQ71uVNIY/EFPWeDmcZuFRQy1vmjjPiYw8fUCp0/qY6cmSW9oUDdvKuTRfTGZ6f8nTXoYFaQ71l
 mMti8uxA0gKVmIzBXtbLDVvAQ/KVNV9SVEyB9ej05/cIY4vdt8eSAN5VcIfsMVILjVAz6RZsCHxD
 lgOJwEwCFaF+62b2lf1UUDu9jECN1V/lwmsioRLmNJoHOZOE/9e5UD715p61XAQw85DCXa0iAPEd
 fYyrF5wMRSLGyY+i0m2IxQLxQUxLMkCVXN63lz38Up+2UgeFSDBPqdRoFsq0hfzdx0oxkgNI/jhY
 WFhu7VV+HdWjdZLlmQ5z83qEVVG/6RJ+BW7FmGcwL889DSW2cZWGkIYVQAbHnYkWUz1gRIjAiMvi
 vM7um7t0SVa5NVZ2g1u6DnOpQHYV3TsOFMmdrwGhqQDw/U3WHzWVE9linvPYkk5EbvNSKMKZZKIm
 pSRiVj3Z6FeYyEA/4qyBWyM8TTC6Mg9RWQhL+FDRQ14qhQ8eQiedscRlw3yFXNuLqAW9V7zLFic5
 yLycIETNRAvUQf+piJ7sPxqZR3KVQgqF/fPYYAfEfsiDGp7i4K9gmqREIfOEHv/AIZm2yoKIH61n
 a1iNI9sJnsAUwzQCuiJPgIus2V/JZ5Ll9XC1Cx34YL7X+JLwYAm5ypSliZ75kJ0rTza8+YFWM4S1
 7lffY/fLNHsH8DeB1ciz42LgJIaeGQmuwKFVmHrkHiEGmnBHWv4Gh/0pmoIxCd7Wl7bcZf/Yjlgk
 C5/TshV6p4LXFVs/AS6Qchyrp0WYcTQDm0YvDLW6j0ztAyPgv56IZdRxyG8ZeWMbNPZiNWdBqyRc
 AYMRiF/tTJMpgiPRIHs6CS/Wfz+lGlAmDqpSODMqRVTYPdDe9fNkDTBGwLS7dfE8OG6V00DpgPHh
 UdfSfqIJ3VUm2y3pNa2dBD3F+DFlJQxAtZlYB2ywONOJP1ekyl6c7Cq2HuJSCRWhvBtVdoCRStPj
 NlKN8tqRiXqTYOVbu7qFs1k1cwrc0cM1w7Y=
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro
X-Complaints-To: abuse@cleanserver1.mxserver.ro

The common_tfreqs and mt6372_tfreqs arrays were previously declared as
unsigned int but used with find_closest(), which now takes signed int
parameters. Change these arrays from unsigned int to int to maintain type
compatibility with the find_closest() function signature and prevent
compilation errors.

Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
---
 drivers/leds/rgb/leds-mt6370-rgb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/rgb/leds-mt6370-rgb.c b/drivers/leds/rgb/leds-mt6370-rgb.c
index ebd3ba878dd5..6ce11432dd96 100644
--- a/drivers/leds/rgb/leds-mt6370-rgb.c
+++ b/drivers/leds/rgb/leds-mt6370-rgb.c
@@ -135,7 +135,7 @@ struct mt6370_led {
 };
 
 struct mt6370_pdata {
-	const unsigned int *tfreq;
+	const int *tfreq;
 	unsigned int tfreq_len;
 	u16 reg_rgb1_tr;
 	s16 reg_rgb_chrind_tr;
@@ -212,11 +212,11 @@ static const struct linear_range mt6372_led_ranges[R_MAX_RANGES] = {
 	[R_LED_TOFF]	= { 250, 0, 15, 500 },
 };
 
-static const unsigned int common_tfreqs[] = {
+static const int common_tfreqs[] = {
 	10000, 5000, 2000, 1000, 500, 200, 5, 1,
 };
 
-static const unsigned int mt6372_tfreqs[] = {
+static const int mt6372_tfreqs[] = {
 	8000, 4000, 2000, 1000, 500, 250, 8, 4,
 };
 
@@ -304,7 +304,8 @@ static int mt6370_set_led_freq(struct mt6370_priv *priv, unsigned int led_no, un
 	const struct mt6370_pdata *pdata = priv->pdata;
 	enum mt6370_led_field sel_field;
 	unsigned int tfreq_len = pdata->tfreq_len;
-	unsigned int tsum, sel;
+	unsigned int sel;
+	int tsum;
 
 	tsum = ton + toff;
 
-- 
2.49.0


