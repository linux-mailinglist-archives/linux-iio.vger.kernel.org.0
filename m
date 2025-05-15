Return-Path: <linux-iio+bounces-19530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B291AB8128
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7BC3AB455
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 08:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29892288508;
	Thu, 15 May 2025 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b="ULV8Zk2b"
X-Original-To: linux-iio@vger.kernel.org
Received: from clean306.mxserver.ro (clean306.mxserver.ro [46.102.249.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182552882CC;
	Thu, 15 May 2025 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.102.249.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298501; cv=none; b=EZWAuRxh5UKE4GssmY/zfhZUMXZo4ZTYrso6dd1iIeeao65/5Bv1cGsYYW1ggoAZzSYQpIvUhQmOgf10MEUyPGZd/9p8KPwld7sZ4+lIPzESC5h6FYjNnsVpfHVcgY9uQBsp7l1WbzwiqsTtc6J4s7fze9OIFFyc5iE1Cfz4REI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298501; c=relaxed/simple;
	bh=aTuWdoGv7LUb4Yp/wJTv34/q5leVNhtCtYL5kySLpqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLS2HG/kmQX3ODN7N0Ymj6wKBEId9nq75OmCB8is0wNbalUzvd3GnJaz2qbUVBN0q730mEN8mT6qDk7hutO1dCkb7pU4oypH/VIy6RGh/3cBi2xj7x7G4WvOVaSIpjpB7+RbyJGjM1zYF6vW4wjcXBUkHoXj9cbb58kud4a8Ppc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro; spf=pass smtp.mailfrom=taladin.ro; dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b=ULV8Zk2b; arc=none smtp.client-ip=46.102.249.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Received: from cloud347.c-f.ro ([185.236.86.218])
	by cleanserver3.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTm1-00CMWx-8J; Thu, 15 May 2025 04:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5FMpxjjwSwihEUiw3F3iPHFipckrMTR33+D+UDPzc/M=; b=ULV8Zk2b+j64HWF+Fm9p5z4VxY
	u02aF+in0bcsAtjr9i8qPlQLFWQ931cNbPOxSKAjAQoIGZO1GPnZCadAEgOLbW++j+YxL2Qru+Tr0
	+Ro2szQbFlX6bc0nECFjxJgaJ0xgA+yczRec0zWqLFw2ikb+mhVjpOckA8nOCc4v8qht/7gTcZBwm
	E/BX0tol6PKbwQD1R0FoD4RzsXzwf0/GzHrgToU/5VMThIvsPYCzMbpT+4+uWhYdKwtrue9TWWSsc
	LvR3PSrdCgi0Wv+DYrHiCsmMV+9VUJ0v1NqHTUD09h77D6aT5/iX9fEGWunxiclv7Cq7bW/i14GHN
	dohJCevg==;
Received: from [109.166.137.172] (port=38968 helo=localhost)
	by cloud347.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTlo-00000006q9A-2Xuu;
	Thu, 15 May 2025 11:16:57 +0300
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
Subject: [PATCH 05/16] hwmon: max1619: Fix type incompatibility with non-macro find_closest
Date: Thu, 15 May 2025 11:13:21 +0300
Message-ID: <20250515081332.151250-6-asoponar@taladin.ro>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00514582746137)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9MyhWT26neQukrQep649OxPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5TSx
 S75yz9IFZiY7BarU/NrpK8SEOwGmfn6ucAKqn/OHRh3BqzFaEnAEj4UixLJBjVNiLZt/QXQnOBRD
 +jq1HsIBmHTFdhqXZEtguZY7iGKpkcJnJKaJfT+dw1udmv00tbIRNtoyOobb3xnDyRRylAVTYi2b
 f0F0JzgUQ/o6tR7C8pLPCtTiVLo0r89ClJHDKhDGKgJ+T00JeCnHBmMdB1eMZAyYlfUtEN4pUyes
 jVRntA/J5DcfwvG53FyVviDO9UET3GKmqv1jT0lY+AQz8YX4CVph7ctC7tRH2SPTQJ/0klTuXKq/
 B9rqRWsYzNfBLt79i78aPHyWnIqxGMxPZotYvH/es1vXuByXo2bkrYMqq0x5CzaUoJIoBUQayHle
 UvbvCQmh9x4kn6NeQcRkc6G+OgAcq5x+BzhRyg9rYO6I0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X
 +u7aTqYHtT2CBuxNPBc9JM2jck1NnIBf0tvflhq7Xjhll72AYgnW/6M0ftSpvLIx+X1vKami8KF6
 jWQ71uVNIY/EFPWeDmcZuFRQy1vmjjPiYw8fUCp0/qY6cmSW9oUDdvKuTRfTGZ6f8nTXoYFaQ71l
 mMti8uxA0gKVmIzBXtbLDVvAQ/KVNZQWDAQDKjS+OuH9B8Wt/YOSAN5VcIfsMVILjVAz6RZsCHxD
 lgOJwEwCFaF+62b2lf1UUDu9jECN1V/lwmsioRK+Y6c+J2XawkXUwNqmNMJsXAQw85DCXa0iAPEd
 fYyrF5wMRSLGyY+i0m2IxQLxQUz5rOsCgWfUk8oCCEJC9L2lSDBPqdRoFsq0hfzdx0oxkgNI/jhY
 WFhu7VV+HdWjdZLlmQ5z83qEVVG/6RJ+BW7FmGcwL889DSW2cZWGkIYVQAbHnYkWUz1gRIjAiMvi
 vM7um7t0SVa5NVZ2g1u6DnOpqk1nwAzTSgytNKIH5lfAuQc8I07FTFcjpdfX/Jcr87en7cKbI0NU
 afdkQMG+6qjtXoANVR89VM6f75a5kmRIbungV7ywXD8VtmM8wef5C6IkqMFhROX1HYRo9Sm1kZOW
 saz62DSUUd/fn3Ix/aSqJVglEtnFggTvi4y/qO0sxBxzHDeqqFz43py4SDhdaHkWkQILQXDyW9dm
 jNKonZjYWHRTR+H6+2RiNcUwzTu30W1RX0+3J1oiHT1UCdffPXEWaItdoEjZybQVqqiDgYguI1bG
 7m9C/1crfxEQ+RMIu45TjrXtoQVWRmJMAe+fcJPd0z6bhalFEM/pjPCQA+BAlnDfxF+P4qUdmrCV
 Jcb6keE4kn354Ur/DPbOVK8U1h7+iyXoLo8Pd7ROcGquteNrNVAE9sdk8xREiFzSUHMNtZciSRWm
 1WkKsmdoBm6E4S2NuN/NBTe2/ULqDAwOt9zqr+uO5TcDeKjrEmYPn2IVWRtXQGd2K9wEqsPdlH9+
 YnMU5dPhUFL9snxfLwyUh0hPsPhVGdemay+RORAW9d0tvzdLMkCVXN63lz38Up+2UgeFcpE+PmUA
 j1PxNMRErSYM7n8DxBG3VLDRB+maCRTs466AUT31X+L1qXgiXZeLdQiA
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro
X-Complaints-To: abuse@cleanserver1.mxserver.ro

The update_intervals array was previously declared as u16 but used with
find_closest_descending(). With find_closest_descending() now implemented
as a function taking signed int parameters instead of a macro, passing
unsigned arrays causes type incompatibility errors. This patch changes
the array type from u16 to int to ensure compatibility with the function
signature and prevent compilation errors.

Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
---
 drivers/hwmon/max1619.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
index 9b6d03cff4df..0bd9fbb2517c 100644
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -103,7 +103,7 @@ static int max1619_temp_read(struct regmap *regmap, u32 attr, int channel, long
 	return 0;
 }
 
-static u16 update_intervals[] = { 16000, 8000, 4000, 2000, 1000, 500, 250, 125 };
+static int update_intervals[] = { 16000, 8000, 4000, 2000, 1000, 500, 250, 125 };
 
 static int max1619_chip_read(struct regmap *regmap, u32 attr, long *val)
 {
-- 
2.49.0


