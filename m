Return-Path: <linux-iio+bounces-19533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2011FAB813C
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F5D171D2F
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 08:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53DA28C845;
	Thu, 15 May 2025 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b="fenBMFXb"
X-Original-To: linux-iio@vger.kernel.org
Received: from clean203.mxserver.ro (clean203.mxserver.ro [176.223.127.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CE828A1ED;
	Thu, 15 May 2025 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.223.127.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298835; cv=none; b=UHnmHdJaK6z9rXtbex6XF3fx23Eaf43QcH5tzwuP734yKyxk9LbMwlG7JSNnGPWkI5V0YaTPUAaKSJU386xXBhHJan7IBU9ExGyuaEJBAMc1t1QesSu692trGYnI5JFD99nCIVUy+E9vRY9ov91YaF5k4EFKgVKa80S71O4fX5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298835; c=relaxed/simple;
	bh=BcQ7dOGMy2G6f074qdjFwf6ztnYAuEy9X4leTqnduAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOKsNz/2jE+dftqruXHsFHpd3kNBZX4YaGPckieNUlofQHtLgW27/lcel63sLbWGXvh4FXwc1mRuF9s+F6MTg/xuU+tSFw58LCPJzU4FDGybRz7oJniug4WKc/ND0Ely9Ovka+s8YEeKCusY+mw78AE2lLnCtWKF43yiIhQNTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro; spf=pass smtp.mailfrom=taladin.ro; dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b=fenBMFXb; arc=none smtp.client-ip=176.223.127.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Received: from cloud347.c-f.ro ([185.236.86.218])
	by cleanserver2.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTlx-001Vt8-Ds; Thu, 15 May 2025 04:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kA8DKQFtSt4jcUAuOIp1O8zgOjmBlKqw0lLnqHTc59w=; b=fenBMFXbembk3toPDrviTqAU9G
	ORJ4AR0BA6Ba6Swva8vCMHx4ghdyXMQtA1sMAWC6Uu0Vo9Q278jCOsTwFWpfBBJeAuixYi12c2Hdm
	VA+gcgC9/Kb42N6CD3J/C6MoZsKKWM4QxNR5upmOH8jUDBGiHYZmcG+8r6FP4UN9pLW3FZ6XkxKX+
	aWiXx45iEzZmkLVyPexI4x8U0XR5C2uRxND6+cPlWsKr7HwcbUzYNWsndFDvctUjD/M9b7qzLTlnm
	BPI5leadzWC+y/edqiC48/HZGsvqB/9FXk+rofE8hNdmTvSR6+IuIvUzzX2yXt4/IfSdANlztKrOc
	f00EdStg==;
Received: from [109.166.137.172] (port=37864 helo=localhost)
	by cloud347.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTll-00000006q7R-0Bbp;
	Thu, 15 May 2025 11:16:54 +0300
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
Subject: [PATCH 01/16] hwmon: w83795: Fix type incompatibility with non-macro find_closest
Date: Thu, 15 May 2025 11:13:17 +0300
Message-ID: <20250515081332.151250-2-asoponar@taladin.ro>
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
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT/O7UgxM56v2QHekgcNkOkZPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5TSx
 S75yz9IFZiY7BarU/NrpK8SEOwGmfn6ucAKqn/OHRh3BqzFaEnAEj4UixLJBjVNiLZt/QXQnOBRD
 +jq1HsIBmHTFdhqXZEtguZY7iGKpkcJnJKaJfT+dw1udmv00tbIRNtoyOobb3xnDyRRylAVTYi2b
 f0F0JzgUQ/o6tR7C8pLPCtTiVLo0r89ClJHDKhDGKgJ+T00JeCnHBmMdB1eMZAyYlfUtEN4pUyes
 jVRntA/J5DcfwvG53FyVviDO9UET3GKmqv1jT0lY+AQz8YX4CVph7ctC7tRH2SPTQJ/0klTuXKq/
 B9rqRWsYzNfBLt79i78aPHyWnIqxGMxPZotYvH/es1vXuByXo2bkrYMqq0x5CzaUoJIoBUQayHle
 UvbvCQmh9x4kn6NeQcRkc6G+OgAcq5x+BzhRyg9rYO6I0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X
 +u7aTqYHtT2CBuxNPBc9JM2jck1NnIBf0tvflhq7Xjhll72AYgnW/6M0ftSpvLIx+X1vKami8KF6
 jWQ71uVNIY/EFPWeDmcZuFRQy1vmjjPiYw8fUCp0/qY6cmSW9oUDdvKuTRfTGZ6f8nTXoYFaQ71l
 mMti8uxA0gKVmIzBXtbLDVvAQ/KVNXkmpgMJXtFKnSRCnUwZAiqSAN5VcIfsMVILjVAz6RZsCHxD
 lgOJwEwCFaF+62b2lf1UUDu9jECN1V/lwmsioRLmNJoHOZOE/9e5UD715p61XAQw85DCXa0iAPEd
 fYyrF5wMRSLGyY+i0m2IxQLxQUzTb3Mji+CrO1+NTWs5OBXbSDBPqdRoFsq0hfzdx0oxkgNI/jhY
 WFhu7VV+HdWjdZLlmQ5z83qEVVG/6RJ+BW7FmGcwL889DSW2cZWGkIYVQAbHnYkWUz1gRIjAiMvi
 vM7um7t0SVa5NVZ2g1u6DnOpQHYV3TsOFMmdrwGhqQDw/U3WHzWVE9linvPYkk5EbvNSKMKZZKIm
 pSRiVj3Z6FeYyEA/4qyBWyM8TTC6Mg9RWQhL+FDRQ14qhQ8eQiedscRlw3yFXNuLqAW9V7zLFic5
 yLycIETNRAvUQf+piJ7sPxqZR3KVQgqF/fPYYAfEfsjj4DVdduR90H5McQ+8O8hgib5B6Ms3Nsv9
 mI56gYdHslb3ihTmJP9jABr7eHobRpHb7qTcIFz1nk+0s72r53zOJqmiissvM9owPzYAr89vN4Ty
 64Hw6o+zALSa0P9i1hWLBDMrD7q/cJogwbqzsuokqiEHDvNJ9dv4vz04yOn51wregXgdeECyTJU5
 oHafInY99O+tX7duRqh2ecfBGkdqDgvfw4SrWEZKgGCi9nibUQlbv5uSE8iz9IIumhIhFIfECWQj
 OJcjm5IBgwnLvYxWZUtT1DfHQ/HkqSkOfQ8NAR4hBppwR1r+Bof9KZqCMQkyL2PwO4ub1qMH++eM
 jnOnV9LO1ghGh/DUNuB/g2OV987SVK+CeGpRwqUJT500pacqW637mIaQpIIazbKBmghZMypFVNg9
 0N7182QNMEbAtB23JpYTnB2HqfPoGtp9xnk=
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro
X-Complaints-To: abuse@cleanserver1.mxserver.ro

The pwm_freq_cksel0 array was previously declared as u16 but used with
find_closest_descending(). Now that find_closest_descending() is
implemented as a function with 'int' parameters instead of a macro,
passing unsigned arrays causes type incompatibility errors. This patch
changes the array type from u16 to int to match the function's signature
and prevent compilation errors.

Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
---
 drivers/hwmon/w83795.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
index 5174db69db5e..1b63bd540f6c 100644
--- a/drivers/hwmon/w83795.c
+++ b/drivers/hwmon/w83795.c
@@ -273,7 +273,7 @@ static inline s8 temp_to_reg(long val, s8 min, s8 max)
 	return clamp_val(val / 1000, min, max);
 }
 
-static const u16 pwm_freq_cksel0[16] = {
+static const int pwm_freq_cksel0[16] = {
 	1024, 512, 341, 256, 205, 171, 146, 128,
 	85, 64, 32, 16, 8, 4, 2, 1
 };
-- 
2.49.0


