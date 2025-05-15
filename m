Return-Path: <linux-iio+bounces-19531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFAAAB8111
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC5216BBAE
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 08:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED46A218AB9;
	Thu, 15 May 2025 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b="l/udhzI3"
X-Original-To: linux-iio@vger.kernel.org
Received: from clean44.mxserver.ro (clean44.mxserver.ro [46.102.249.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F021DF97D;
	Thu, 15 May 2025 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.102.249.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298519; cv=none; b=Bfodo4NdEQ3kwi1zgXdsCjywJwQ/Uh38c9qs4zf+1lMZY28oIScFURP4xAEwfL7SiRtAuqlqKA3t3j5mAAiaJJm3T0yI1qaq8v1pv12WBw7avq8VyOTwDdYtf469G40S0mzyiCv89UG0EK6IhfDKRbGHNpHldccLRlZUh3P8o5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298519; c=relaxed/simple;
	bh=2RJ05QYWlGpPBona4V2E0mGiXYjGrmIWzfB7WgDTLN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qt/6LRf6DrP2FoC9k/gXt+KQkYBVyTXGVnmHkD9hA2WlFuAzvQPsuAuDwPd8iuCvL4V5rM7N7adMwCAShJ5jua8+MTVtmaiFjzQ4sgz88UWOq7E1urJrSr3uWUx8dNjBZHNVph+3fptcnC5/7Ze+SOdxnspsUak5oxfXW3JXUnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro; spf=pass smtp.mailfrom=taladin.ro; dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b=l/udhzI3; arc=none smtp.client-ip=46.102.249.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Received: from cloud347.c-f.ro ([185.236.86.218])
	by cleanserver3.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTm1-00CMWO-8J; Thu, 15 May 2025 04:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ElJjcPIsuFJqDHYBIsWaMACAaQb+tSYvc1+ymkQdpuM=; b=l/udhzI3OwGAgR5kVTF0/E9+DD
	0vExAedxbR5HzEAUXPV3jqUmb5s5sFVvIcqTytJog2q+FMgaxknj+GoHh6Zx+B2iFkx5Myzi+3roW
	LfkTOnN5z9vbttEnkpGx6f6D4NgdDHHAee94oe1fLVlt+5y4QbyOfW4nGFLnpmoyfkMNoQJrG9kfh
	il2KCd9hsIE2d7MAY+NOGIW6nZA9D/s1NR2pL1ovWqLDIQs0g4ucs/dDxcyKAqXQGrcxFazxS2mCO
	eHM2apWwM7bNY8OX98Mv7TnLCN6YGpViJiLdMA42hrdxusOm/PcN9TRtXR5Xu9A49nEUXmT2rc6VX
	LRjPnNEQ==;
Received: from [109.166.137.172] (port=38960 helo=localhost)
	by cloud347.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTln-00000006q8r-33FL;
	Thu, 15 May 2025 11:16:56 +0300
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
Subject: [PATCH 04/16] hwmon: lm95234: Fix type incompatibility with non-macro find_closest
Date: Thu, 15 May 2025 11:13:20 +0300
Message-ID: <20250515081332.151250-5-asoponar@taladin.ro>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00542706905372)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8ey1Mt24Tab3j5gc1T8HJWPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5TSx
 S75yz9IFZiY7BarU/NrpK8SEOwGmfn6ucAKqn/OHRh3BqzFaEnAEj4UixLJBjVNiLZt/QXQnOBRD
 +jq1HsIBmHTFdhqXZEtguZY7iGKpkcJnJKaJfT+dw1udmv00tbIRNtoyOobb3xnDyRRylAVTYi2b
 f0F0JzgUQ/o6tR7C8pLPCtTiVLo0r89ClJHDKhDGKgJ+T00JeCnHBmMdB1eMZAyYlfUtEN4pUyes
 jVRntA/J5DcfwvG53FyVviDO9UET3GKmqv1jT0lY+AQz8YX4CVph7ctC7tRH2SPTQJ/0klTuXKq/
 B9rqRWsYzNfBLt79i78aPHyWnIqxGMxPZotYvH/es1vXuByXo2bkrYMqq0x5CzaUoJIoBUQayHle
 UvbvCQmh9x4kn6NeQcRkc6G+OgAcq5x+BzhRyg9rYO6I0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X
 +u7aTqYHtT2CBuxNPBc9JM2jck1NnIBf0tvflhq7Xjhll72AYgnW/6M0ftSpvLIx+X1vKami8KF6
 jWQ71uVNIY/EFPWeDmcZuFRQy1vmjjPiYw8fUCp0/qY6cmSW9oUDdvKuTRfTGZ6f8nTXoYFaQ71l
 mMti8uxA0gKVmIzBXtbLDVvAQ/KVNQ/J7jYm7rAETb4yCniLIs6SAN5VcIfsMVILjVAz6RZsCHxD
 lgOJwEwCFaF+62b2lf1UUDu9jECN1V/lwmsioRK+Y6c+J2XawkXUwNqmNMJsXAQw85DCXa0iAPEd
 fYyrF5wMRSLGyY+i0m2IxQLxQUz5rOsCgWfUk8oCCEJC9L2lSDBPqdRoFsq0hfzdx0oxkgNI/jhY
 WFhu7VV+HdWjdZLlmQ5z83qEVVG/6RJ+BW7FmGcwL889DSW2cZWGkIYVQAbHnYkWUz1gRIjAiMvi
 vM7um7t0SVa5NVZ2g1u6DnOpqk1nwAzTSgytNKIH5lfAuQc8I07FTFcjpdfX/Jcr87en7cKbI0NU
 afdkQMG+6qjtXoANVR89VM6f75a5kmRIbungV7ywXD8VtmM8wef5C6IkqMFhROX1HYRo9Sm1kZOW
 saz62DSUUd/fn3Ix/aSqJVglEtnFggTvi4y/qO0sxBxzHDeqqFz43py4SDhdaHkWkQILQXDyW9dm
 jNKonZjYWHRTR+H6+2RiNcUwzTu30W1XJw5pZ9246w6+kmPpc4S3aItdoEjZybQVqqiDgYguI1bG
 7m9C/1crfxEQ+RMIu45TjrXtoQVWRmJMAe+fcJPd0z6bhalFEM/pjPCQA+BAlnDfxF+P4qUdmrCV
 Jcb6keE4kn354Ur/DPbOVK8U1h7+iyXoLo8Pd7ROcGquteNrNUlZaIFOtmyUS8NF60tuSxYiSRWm
 1WkKsmdoBm6E4S2NuN/NBTe2/ULqDAwOt9zqr+uO5TcDeKjrEmYPn2IVWRtXQGd2K9wEqsPdlH9+
 YnMU5dPhUFL9snxfLwyUh0hPsPhVGdemay+RORAW9d0tvzdLMkCVXN63lz38Up+2UgeFcpE+PmUA
 j1PxNMRErSYM7n8DxBG3VLDRB+maCRTs466AUT31X+L1qXgiXZeLdQiA
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro
X-Complaints-To: abuse@cleanserver1.mxserver.ro

The update_intervals array was previously declared as u16 but used with
find_closest(). With find_closest() now implemented as a function taking
signed int parameters instead of a macro, passing unsigned arrays causes
type incompatibility errors. This patch changes the array type from
u16 to int to ensure compatibility with the function signature and
prevent compilation errors.

Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
---
 drivers/hwmon/lm95234.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm95234.c b/drivers/hwmon/lm95234.c
index 7da6c8f07332..e808fd7d5587 100644
--- a/drivers/hwmon/lm95234.c
+++ b/drivers/hwmon/lm95234.c
@@ -240,7 +240,7 @@ static int lm95234_temp_read(struct device *dev, u32 attr, int channel, long *va
 	return 0;
 }
 
-static u16 update_intervals[] = { 143, 364, 1000, 2500 };
+static int update_intervals[] = { 143, 364, 1000, 2500 };
 
 static int lm95234_chip_write(struct device *dev, u32 attr, long val)
 {
-- 
2.49.0


