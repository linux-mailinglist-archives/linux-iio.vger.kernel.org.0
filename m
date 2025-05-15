Return-Path: <linux-iio+bounces-19532-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CB5AB8133
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2AF53B5AAB
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 08:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D93E283FDE;
	Thu, 15 May 2025 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b="e9fM/j4t"
X-Original-To: linux-iio@vger.kernel.org
Received: from clean134.mxserver.ro (clean134.mxserver.ro [185.92.194.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5E1F461A;
	Thu, 15 May 2025 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.92.194.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298579; cv=none; b=GBRjPReOEK7efjydxI/tauJSXi0GeFFhjmaOHfkE/2px0AeG3bRxSzWTWaV5TDbwzvWEQkisYXH99TYmmJLxTd8+fRVv0KXOCQNEGnGID5ZjhXGVYES6IST0/aphdzrOybGaUMNl+dFmSl7bMPR/ArZLUjvyxiYVmywIWZ21v/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298579; c=relaxed/simple;
	bh=i/vzRKjxd8txmhCKxwejRYetCVU9QJNjyjUjOeXWCwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSVjC0MMLglxFcjcyF9tlE8nmRr7LaLZ+wHuiqDyRB7XlLh+qJT24R1S9Nz0TEBOgLVLGGXOzAKQ5IopsJprz+qkpVwC/kaTEHn6cucg5agxxJ8kgWQu8Cby/mBGA7YTs/6H21oS2wx8J40Hdb0lxkn/CxsNdwQQt9HvDPu5Pok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro; spf=pass smtp.mailfrom=taladin.ro; dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b=e9fM/j4t; arc=none smtp.client-ip=185.92.194.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Received: from cloud347.c-f.ro ([185.236.86.218])
	by cleanserver3.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTm2-00CMaz-40; Thu, 15 May 2025 04:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vHKKhlosxKGDbCAuvxtDbDAGGL1kot1tdpFPo/6AsYU=; b=e9fM/j4ta67Put5ZPL+/Q9lpHf
	jYZVJkKQOg3xP9mDpPgatmKWHaFrawhnSpGBN32jaa8H4KDo4JEAx4CBVPkyFW0HkaOUIXF6N/1DC
	bdAZ7uF/EeGj7s7wW8yot8lKhH4cTKBkHlYCbvTo1ldGxXEHiEgTkRGtkSEZcR2zXcBXu3ZMp5sqC
	SX64YrLGGsxETnXFODDe7yiWdWCipI0bAdHrdcNjLqnjQlAMCq+abFVyqkX2F2eHdnSguD6qzHTCf
	JS1dA2Zzctiv/J/DoGXxOf55/QmGRgUJuYISeNcho6v66OL+1EefkQFwtqbikuGfkfsmDOveZ9HOn
	Y4AyJKSQ==;
Received: from [109.166.137.172] (port=38998 helo=localhost)
	by cloud347.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTlr-00000006qAi-18NQ;
	Thu, 15 May 2025 11:17:00 +0300
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
Subject: [PATCH 08/16] hwmon: max6639: Fix type incompatibility with non-macro find_closest
Date: Thu, 15 May 2025 11:13:24 +0300
Message-ID: <20250515081332.151250-9-asoponar@taladin.ro>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00945865962282)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8dAJjXAj4NfW1oK4/8ICdkPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5TSx
 S75yz9IFZiY7BarU/NrpK8SEOwGmfn6ucAKqn/OHRh3BqzFaEnAEj4UixLJBjVNiLZt/QXQnOBRD
 +jq1HsIBmHTFdhqXZEtguZY7iGKpkcJnJKaJfT+dw1udmv00tbIRNtoyOobb3xnDyRRylAVTYi2b
 f0F0JzgUQ/o6tR7C8pLPCtTiVLo0r89ClJHDKhDGKgJ+T00JeCnHBmMdB1eMZAyYlfUtEN4pUyes
 jVRntA/J5DcfwvG53FyVviDO9UET3GKmqv1jT0lY+AQz8YX4CVph7ctC7tRH2SPTQJ/0klTuXKq/
 B9rqRWsYzNfBLt79i78aPHyWnIqxGMxPZotYvH/es1vXuByXo2bkrYMqq0x5CzaUoJIoBUQayHle
 UvbvCQmh9x4kn6NeQcRkc6G+OgAcq5x+BzhRyg9rYO6I0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X
 +u7aTqYHtT2CBuxNPBc9JM2jck1NnIBf0tvflhq7Xjhll72AYgnW/6M0ftSpvLIx+X1vKami8KF6
 jWQ71uVNIY/EFPWeDmcZuFRQy1vmjjPiYw8fUCp0/qY6cmSW9oUDdvKuTRfTGZ6f8nTXoYFaQ71l
 mMti8uxA0gKVmIzBXtbLDVvAQ/KVNYAgpWt+qkyDk8+YD4ob/42SAN5VcIfsMVILjVAz6RZsCHxD
 lgOJwEwCFaF+62b2lf1UUDu9jECN1V/lwmsioRK+Y6c+J2XawkXUwNqmNMJsXAQw85DCXa0iAPEd
 fYyrF5wMRSLGyY+i0m2IxQLxQUz5rOsCgWfUk8oCCEJC9L2lSDBPqdRoFsq0hfzdx0oxkgNI/jhY
 WFhu7VV+HdWjdZLlmQ5z83qEVVG/6RJ+BW7FmGcwL889DSW2cZWGkIYVQAbHnYkWUz1gRIjAiMvi
 vM7um7t0SVa5NVZ2g1u6DnOpqk1nwAzTSgytNKIH5lfAuQc8I07FTFcjpdfX/Jcr87en7cKbI0NU
 afdkQMG+6qjtXoANVR89VM6f75a5kmRIbungV7ywXD8VtmM8wef5C6IkqMFhROX1HYRo9Sm1kZOW
 saz62DSUUd/fn3Ix/aSqJVglEtnFggTvi4y/qO0sxBxzHDeqqFz43py4SDhdaHkWkQILQXDyW9dm
 jNKonZjYWHRTR+H6+2RiNcUwzTu30W3Ni3ZF+6ZH9NeE92ciAHcfaItdoEjZybQVqqiDgYguI1bG
 7m9C/1crfxEQ+RMIu45TjrXtoQVWRmJMAe+fcJPd0z6bhalFEM/pjPCQA+BAlnDfxF+P4qUdmrCV
 Jcb6keE4kn354Ur/DPbOVK8U1h7+l92l2DfNCecwYAX//Yb5bTrhhFdNH2fNvCBVKgCCAeEiSRWm
 1WkKsmdoBm6E4S2NuN/NBTe2/ULqDAwOt9zqr+uO5TcDeKjrEmYPn2IVWRtXQGd2K9wEqsPdlH9+
 YnMU5dPhUFL9snxfLwyUh0hPsPhVGdemay+RORAW9d0tvzdLMkCVXN63lz38Up+2UgeFcpE+PmUA
 j1PxNMRErSYM7n8DxBG3VLDRB+maCRTs466AUT31X+L1qXgiXZeLdQiA
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro
X-Complaints-To: abuse@cleanserver1.mxserver.ro

The freq_table array was previously declared as unsigned int but used
with find_closest(). With find_closest() now implemented as a function
taking signed int parameters instead of a macro, passing unsigned arrays
causes type incompatibility errors. This patch changes the array type from
unsigned int to int to ensure compatibility with the function signature and
prevent compilation errors.

Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
---
 drivers/hwmon/max6639.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 32b4d54b2076..b6942b406880 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -63,7 +63,7 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
 static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
 
 /* Supported PWM frequency */
-static const unsigned int freq_table[] = { 20, 33, 50, 100, 5000, 8333, 12500,
+static const int freq_table[] = { 20, 33, 50, 100, 5000, 8333, 12500,
 					   25000 };
 
 #define FAN_FROM_REG(val, rpm_range)	((val) == 0 || (val) == 255 ? \
-- 
2.49.0


