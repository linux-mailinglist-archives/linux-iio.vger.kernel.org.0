Return-Path: <linux-iio+bounces-19540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83727AB8199
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD2818887F1
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 08:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2043628C843;
	Thu, 15 May 2025 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b="HCTxtc1U"
X-Original-To: linux-iio@vger.kernel.org
Received: from clean202.mxserver.ro (clean202.mxserver.ro [89.46.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082EF1ADFFE;
	Thu, 15 May 2025 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.46.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299230; cv=none; b=VZdl+Y++jahwozZtIXgh9mBVoD7+K9ZNIGXOrP+7v+ALT59WD2vobQkaGNbUMLdaBwn9cK7Zaj9e0N+kAo4AwqeKUMARpomW7ZUbgdQqyBxG1oJ8hT4uTzSfZ+vwEsu5WgvZYnIA7DT857Q4UFuMrTBmRrDr6Xg3IeehEcM4FX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299230; c=relaxed/simple;
	bh=qaN3sNCyLFEQxYt6b3T2rChPKqYchJ51Y/kaeDzdX7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmX3InJc6Ll7WLiY0CZMbifjkxVViHtjraMNAXbMfXCpgtJBH0TIZS3cD5D6smtPYpK6RmS03/+a67onhtiRv0uxWOSdQP5pHv92VG14oHUAQmR6Z1sfXAiuZbtqvxII7MDa6maYPkL5KXU0Bmt58+ke0/2TUkwrUTQJSNw1RPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro; spf=pass smtp.mailfrom=taladin.ro; dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b=HCTxtc1U; arc=none smtp.client-ip=89.46.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Received: from cloud347.c-f.ro ([185.236.86.218])
	by cleanserver2.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTmD-001W8f-9v; Thu, 15 May 2025 04:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Tf84gVqj0tGGaREDsyyKj4PxnmF+1JNB072X3oHVgkA=; b=HCTxtc1U1gQ0c+BKWNG3vGyjBW
	awwWM0fmrlmfTEKtVjTy9Hczk+h8PBIOPwkBowqxpHSz24ye/lIXddJcMgkfKreGXCZhkadBWF9DK
	2xVFLjAAmLSLp6B5e4GcLwffRYVDC8QBR20DpoO1qHuX9ImkMTVW783wEo2vMjKpo/K1cvuxB7uc5
	f5euZWIjV+EU4/cIIvfvWzSi8QPlnUZF/7dt0uMMvHCR5RV4hJUdXoN00KyhwRh87YJD4vV+f7AVp
	zt1lVlIEFjlVhHeRBBlvGrqt+Ar3sBJej6chfvbNbziSfAA86hIwq/v8w0qvq5TZuejdQz1am5+/F
	TuH6hxrA==;
Received: from [109.166.137.172] (port=55928 helo=localhost)
	by cloud347.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTm1-00000006qLV-1PG1;
	Thu, 15 May 2025 11:17:10 +0300
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
Subject: [PATCH 15/16] watchdog: simatic-ipc-wdt: Fix type incompatibility with find_closest()
Date: Thu, 15 May 2025 11:13:31 +0300
Message-ID: <20250515081332.151250-16-asoponar@taladin.ro>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9JEhNQgksodpkE3SFzsKIFPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5TSx
 S75yz9IFZiY7BarU/NrpK8SEOwGmfn6ucAKqn/OHRh3BqzFaEnAEj4UixLJBjVNiLZt/QXQnOBRD
 +jq1HsIBmHTFdhqXZEtguZY7iGKpkcJnJKaJfT+dw1udmv00tbIRNtoyOobb3xnDyRRylAVTYi2b
 f0F0JzgUQ/o6tR7C8pLPCtTiVLo0r89ClJHDKhDGKgJ+T00JeCnHBmMdB1eMZAyYlfUtEN4pUyes
 jVRntA/J5DcfwvG53FyVviDO9UET3GKmqv1jT0lY+AQz8YX4CVph7ctC7tRH2SPTQJ/0klTuXKq/
 B9rqRWsYzNfBLt79i78aPHyWnIqxGMxPZotYvH/es1vXuByXo2bkrYMqq0x5CzaUoJIoBUQayHle
 UvbvCQmh9x4kn6NeQcRkc6G+OgAcq5x+BzhRyg9rYO6I0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X
 +u7aTqYHtT2CBuxNPBc9JM2jck1NnIBf0tvflhq7Xjhll72AYgnW/6M0ftSpvLIx+X1vKami8KF6
 jWQ71uVNIY/EFPWeDmcZuFRQy1vmjjPiYw8fUCp0/qY6cmSW9oUDdvKuTRfTGZ6f8nTXoYFaQ71l
 mMti8uxA0gKVmIzBXtbLDVvAQ/KVNcVK5WbIioCrtPoxxxhtKEKSAN5VcIfsMVILjVAz6RZsCHxD
 lgOJwEwCFaF+62b2lf1UUDu9jECN1V/lwmsioRLmNJoHOZOE/9e5UD715p61XAQw85DCXa0iAPEd
 fYyrF5wMRSLGyY+i0m2IxQLxQUzTb3Mji+CrO1+NTWs5OBXbSDBPqdRoFsq0hfzdx0oxkgNI/jhY
 WFhu7VV+HdWjdZLlmQ5z83qEVVG/6RJ+BW7FmGcwL889DSW2cZWGkIYVQAbHnYkWUz1gRIjAiMvi
 vM7um7t0SVa5NVZ2g1u6DnOpQHYV3TsOFMmdrwGhqQDw/U3WHzWVE9linvPYkk5EbvNSKMKZZKIm
 pSRiVj3Z6FeYyEA/4qyBWyM8TTC6Mg9RWQhL+FDRQ14qhQ8eQiedscRlw3yFXNuLqAW9V7zLFic5
 yLycIETNRAvUQf+piJ7sPxqZR3KVQgqF/fPYYAfEfsjj4DVdduR90H5McQ+8O8hgib5B6Ms3Nsv9
 mI56gYdHsmk4pgeqpG1btt8vQ86IDdbb7qTcIFz1nk+0s72r53zOJqmiissvM9owPzYAr89vN4Ty
 64Hw6o+zALSa0P9i1hWLBDMrD7q/cJogwbqzsuokqiEHDvNJ9dv4vz04yOn51wregXgdeECyTJU5
 oHafInZjQGBU7N8R6REbba8k1Qc6J2k7yh+XwGnYB3p7GBr7wAlbv5uSE8iz9IIumhIhFIfECWQj
 OJcjm5IBgwnLvYxWZUtT1DfHQ/HkqSkOfQ8NAR4hBppwR1r+Bof9KZqCMQkyL2PwO4ub1qMH++eM
 jnOnV9LO1ghGh/DUNuB/g2OV987SVK+CeGpRwqUJT500pacqW637mIaQpIIazbKBmghZMypFVNg9
 0N7182QNMEbAtB23JpYTnB2HqfPoGtp9xnk=
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro
X-Complaints-To: abuse@cleanserver1.mxserver.ro

The wd_timeout_table array was previously declared as unsigned int
but used with find_closest(), which takes signed int parameters. Change
this array from unsigned int to int to maintain type compatibility with
the find_closest() function signature and prevent compilation errors.

Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
---
 drivers/watchdog/simatic-ipc-wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/simatic-ipc-wdt.c b/drivers/watchdog/simatic-ipc-wdt.c
index 1e91f0a560ff..36c68d2ed409 100644
--- a/drivers/watchdog/simatic-ipc-wdt.c
+++ b/drivers/watchdog/simatic-ipc-wdt.c
@@ -59,7 +59,7 @@ static struct resource io_resource_trigger =
 static struct resource mem_resource =
 	DEFINE_RES_MEM_NAMED(0, 0, "WD_RESET_BASE_ADR");
 
-static u32 wd_timeout_table[] = {2, 4, 6, 8, 16, 32, 48, 64 };
+static int wd_timeout_table[] = {2, 4, 6, 8, 16, 32, 48, 64 };
 static void __iomem *wd_reset_base_addr;
 
 static int wd_start(struct watchdog_device *wdd)
-- 
2.49.0


