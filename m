Return-Path: <linux-iio+bounces-19537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8F0AB8177
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7A53AF03B
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 08:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C78B28C86F;
	Thu, 15 May 2025 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b="FAv7MVZG"
X-Original-To: linux-iio@vger.kernel.org
Received: from clean202.mxserver.ro (clean202.mxserver.ro [89.46.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C615289353;
	Thu, 15 May 2025 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.46.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299032; cv=none; b=PckjS9G4lOVC/HLzcc5FGgBeXpHzOUcRUmsdrMmdv/NUjAGyiBAuqeJr/VeOiouEAe53wOu80Ez8I45K/CM+nNAthV9QrKxSNhO7iYl5TL7jVTwnmtmELxvBfqfznDvrboAYjzGtNYJD6/ojw9OzBLn+n59CeOD5XT1G4KWjl8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299032; c=relaxed/simple;
	bh=+F3GEjAF0j288Hu/u1Rh7faH6UIyhfYfRKQ5JK9jKMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOoW8HpTjyTCvr1PoHVtblS5Dl0w+kH0UHsD476tDtrscIYaCSY8hOopb6NQpZ4bsVY/NAYhGA0PS++ENCkpCLNEM9qORej8vn62AUawoKTur3nn61OCzA7eP6OOgcRH8zvXzST90Ze7JnTbZUy1kBXBGkwKCnx4Yy38jYxb9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro; spf=pass smtp.mailfrom=taladin.ro; dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b=FAv7MVZG; arc=none smtp.client-ip=89.46.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Received: from cloud347.c-f.ro ([185.236.86.218])
	by cleanserver2.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTmB-001W6v-35; Thu, 15 May 2025 04:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Ix06/QOL6wpnp+HZ/UHWpCMD85bavxv8v526V4kgvec=; b=FAv7MVZGxzUZn0Rc79xo0h/bUI
	+XY9vXQOfXJhIrJCy1f8meMi2741g5k+J0awUmP0S25+XUG7IwW1rJSxRp//3dkZzp+EuPFO00q0r
	W7zEIHhJi8XH9OirRi6dAIyZaxTrDdQLVcBKfhQ5li2IfrnUJbWlAUAsmmesvNj/UTIuJonuF9gR5
	LWEVLtRl7u4N3AS4wOw9pV5Dw/Pq1RfLhr4jHwvada08vHgUTWqRCpma247IWFvrdE1vinkmslwke
	7XNvth/oAzkqsM13tfN43YHG6gLrK4c+Pe947qOkMKlnA7rXDXKxMB0ef+S0BI+etoLoM8VfYlfbu
	Mp1xXl1w==;
Received: from [109.166.137.172] (port=55912 helo=localhost)
	by cloud347.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTlz-00000006qK8-0iNP;
	Thu, 15 May 2025 11:17:08 +0300
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
Subject: [PATCH 14/16] regulator: max77857: Fix type incompatibility with find_closest()
Date: Thu, 15 May 2025 11:13:30 +0300
Message-ID: <20250515081332.151250-15-asoponar@taladin.ro>
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
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+4kn9BmLRKEepd6HjH4mcePUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5TSx
 S75yz9IFZiY7BarU/NrpK8SEOwGmfn6ucAKqn/OHRh3BqzFaEnAEj4UixLJBjVNiLZt/QXQnOBRD
 +jq1HsIBmHTFdhqXZEtguZY7iGKpkcJnJKaJfT+dw1udmv00tbIRNtoyOobb3xnDyRRylAVTYi2b
 f0F0JzgUQ/o6tR7C8pLPCtTiVLo0r89ClJHDKhDGKgJ+T00JeCnHBmMdB1eMZAyYlfUtEN4pUyes
 jVRntA/J5DcfwvG53FyVviDO9UET3GKmqv1jT0lY+AQz8YX4CVph7ctC7tRH2SPTQJ/0klTuXKq/
 B9rqRWsYzNfBLt79i78aPHyWnIqxGMxPZotYvH/es1vXuByXo2bkrYMqq0x5CzaUoJIoBUQayHle
 UvbvCQmh9x4kn6NeQcRkc6G+OgAcq5x+BzhRyg9rYO6I0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X
 +u7aTqYHtT2CBuxNPBc9JM2jck1NnIBf0tvflhq7Xjhll72AYgnW/6M0ftSpvLIx+X1vKami8KF6
 jWQ71uVNIY/EFPWeDmcZuFRQy1vmjjPiYw8fUCp0/qY6cmSW9oUDdvKuTRfTGZ6f8nTXoYFaQ71l
 mMti8uxA0gKVmIzBXtbLDVvAQ/KVNcldFZf6bV0vxqP1/2HbBTGSAN5VcIfsMVILjVAz6RZsCHxD
 lgOJwEwCFaF+62b2lf1UUDu9jECN1V/lwmsioRLmNJoHOZOE/9e5UD715p61XAQw85DCXa0iAPEd
 fYyrF5wMRSLGyY+i0m2IxQLxQUzTb3Mji+CrO1+NTWs5OBXbSDBPqdRoFsq0hfzdx0oxkgNI/jhY
 WFhu7VV+HdWjdZLlmQ5z83qEVVG/6RJ+BW7FmGcwL889DSW2cZWGkIYVQAbHnYkWUz1gRIjAiMvi
 vM7um7t0SVa5NVZ2g1u6DnOpQHYV3TsOFMmdrwGhqQDw/U3WHzWVE9linvPYkk5EbvNSKMKZZKIm
 pSRiVj3Z6FeYyEA/4qyBWyM8TTC6Mg9RWQhL+FDRQ14qhQ8eQiedscRlw3yFXNuLqAW9V7zLFic5
 yLycIETNRAvUQf+piJ7sPxqZR3KVQgqF/fPYYAfEfsjj4DVdduR90H5McQ+8O8hgib5B6Ms3Nsv9
 mI56gYdHsmhZZXGyJra/wRNsa9vDTSrb7qTcIFz1nk+0s72r53zOJqmiissvM9owPzYAr89vN4Ty
 64Hw6o+zALSa0P9i1hWLBDMrD7q/cJogwbqzsuokqiEHDvNJ9dv4vz04yOn51wregXgdeECyTJU5
 oHafInbqvXEdV1+eITpRvmstNRjcXozknvP3fsI6lNQ46i5iWQlbv5uSE8iz9IIumhIhFIfECWQj
 OJcjm5IBgwnLvYxWZUtT1DfHQ/HkqSkOfQ8NAR4hBppwR1r+Bof9KZqCMQkyL2PwO4ub1qMH++eM
 jnOnV9LO1ghGh/DUNuB/g2OV987SVK+CeGpRwqUJT500pacqW637mIaQpIIazbKBmghZMypFVNg9
 0N7182QNMEbAtB23JpYTnB2HqfPoGtp9xnk=
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro
X-Complaints-To: abuse@cleanserver1.mxserver.ro

The max77857_switch_freq array was previously declared as unsigned int
but used with find_closest(), which takes signed int parameters. Change
this array from unsigned int to int to maintain type compatibility with
the find_closest() function signature and prevent compilation errors.

Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
---
 drivers/regulator/max77857-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max77857-regulator.c b/drivers/regulator/max77857-regulator.c
index 1216cc3a6f72..5e64f5510601 100644
--- a/drivers/regulator/max77857-regulator.c
+++ b/drivers/regulator/max77857-regulator.c
@@ -289,7 +289,7 @@ static struct linear_range max77857_lin_ranges[] = {
 	REGULATOR_LINEAR_RANGE(4485000, 0x3D, 0xCC, 73500)
 };
 
-static const unsigned int max77857_switch_freq[] = {
+static const int max77857_switch_freq[] = {
 	1200000, 1500000, 1800000, 2100000
 };
 
-- 
2.49.0


