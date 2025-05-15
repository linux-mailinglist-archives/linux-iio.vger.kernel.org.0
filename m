Return-Path: <linux-iio+bounces-19536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D86F1AB816C
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5BA18869E4
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 08:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4922920AD;
	Thu, 15 May 2025 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b="IOFKTbyL"
X-Original-To: linux-iio@vger.kernel.org
Received: from clean306.mxserver.ro (clean306.mxserver.ro [46.102.249.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A38A28C849;
	Thu, 15 May 2025 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.102.249.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299020; cv=none; b=oSqSn3E6cK2SEOeZPWS3wJiVXy2SWct1WwAGS+Jd+oSt3ADbKwUV8sQm/uIb6y4qtUkLcTSxcxacYrUU9yALpnibqo8oLk8OWeuVv0jRjtki1UXx4wqKdc4e/eRv/mftyRrgedJ/8q2+Uci4LQOzNyHlC7rrFHL07u4KLDpQVgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299020; c=relaxed/simple;
	bh=UrsXN5BvsiqE04f7YeDfQT3UuNVswVmTBvR9lCi358Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbBeVIo/Ry0jGz8gmfKbFWpZXTgD2Se5tsdv9yl6W7cf8Y/Dd9I8QE/qt2STtKXZfbGNIBoo9azCH+mdbaKGiCWlkcTxtcWnqDzxeU+kpOjHPfK4k9GwhEWZ1UIBtKhU4oQDQzcDW+73WU+ifiyK3YJn3xdZ974W6CH/1LcZN8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro; spf=pass smtp.mailfrom=taladin.ro; dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b=IOFKTbyL; arc=none smtp.client-ip=46.102.249.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Received: from cloud347.c-f.ro ([185.236.86.218])
	by cleanserver3.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTm5-00CMeD-05; Thu, 15 May 2025 04:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Dd/1uGlxOGQIWLy+UQQMfzF+0rkvA0dOH5y9zGsb3zc=; b=IOFKTbyLNpmAaSCGKgbdGUACMy
	QLyJvOxILHppGYla0i7JPpcYcC/MTnxS1UiLI/6yAabY5k0zQjcHmiFY1Dp8vF5Qgna/mmjZSNZtS
	2E3QPHXZxioGcaBINNmCkUigXU/2IJCeSmwh9lyDKbh3ljERZgo/3fKlD11u6m0ZPZeGq4nW9o7SI
	VhBGldBnTT7eCEt6czKy3/Fl3G6bF3gm9Hdb6hEKWIm71tgwwp6ufmDEq428nHRN1V+r3ql/peWvz
	KZ5EgMTh2q1C8OUGDV2t1v41cx49lhtAoyvGrOaUVNSwdo76hO8BpfEPiTRzw7riNXzkD0jiLW7je
	eA/K0j9g==;
Received: from [109.166.137.172] (port=39036 helo=localhost)
	by cloud347.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTlu-00000006qHm-0oO8;
	Thu, 15 May 2025 11:17:03 +0300
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
Subject: [PATCH 11/16] iio: mcp3564: Fix type incompatibility with non-macro find_closest
Date: Thu, 15 May 2025 11:13:27 +0300
Message-ID: <20250515081332.151250-12-asoponar@taladin.ro>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00594371703284)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+SpUDVgxhRP0tE3SZ/aeXbPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5TSx
 S75yz9IFZiY7BarU/NrpK8SEOwGmfn6ucAKqn/OHRh3BqzFaEnAEj4UixLJBjVNiLZt/QXQnOBRD
 +jq1HsIBmHTFdhqXZEtguZY7iGKpkcJnJKaJfT+dw1udmv00tbIRNtoyOobb3xnDyRRylAVTYi2b
 f0F0JzgUQ/o6tR7C8pLPCtTiVLo0r89ClJHDKhDGKgJ+T00JeCnHBmMdB1eMZAyYlfUtEN4pUyes
 jVRntA/J5DcfwvG53FyVviDO9UET3GKmqv1jT0lY+AQz8YX4CVph7ctC7tRH2SPTQJ/0klTuXKq/
 B9rqRWsYzNfBLt79i78aPHyWnIqxGMxPZotYvH/es1vXuByXo2bkrYMqq0x5CzaUoJIoBUQayHle
 UvbvCQmh9x4kn6NeQcRkc6G+OgAcq5x+BzhRyg9rYO6I0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X
 +u7aTqYHtT2CBuxNPBc9JM2jck1NnIBf0tvflhq7Xjhll72AYgnW/6M0ftSpvLIx+X1vKami8KF6
 jWQ71uVNIY/EFPWeDmcZuFRQy1vmjjPiYw8fUCp0/qY6cmSW9oUDdvKuTRfTGZ6f8nTXoYFaQ71l
 mMti8uxA0gKVmIzBXtbLDVvAQ/KVNVsSl4ozgMW8/m/uGVZycIKSAN5VcIfsMVILjVAz6RZsCHxD
 lgOJwEwCFaF+62b2lf1UUDu9jECN1V/lwmsioRK+Y6c+J2XawkXUwNqmNMJsXAQw85DCXa0iAPEd
 fYyrF5wMRSLGyY+i0m2IxQLxQUz5rOsCgWfUk8oCCEJC9L2lSDBPqdRoFsq0hfzdx0oxkgNI/jhY
 WFhu7VV+HdWjdZLlmQ5z83qEVVG/6RJ+BW7FmGcwL889DSW2cZWGkIYVQAbHnYkWUz1gRIjAiMvi
 vM7um7t0SVa5NVZ2g1u6DnOpqk1nwAzTSgytNKIH5lfAuQc8I07FTFcjpdfX/Jcr87en7cKbI0NU
 afdkQMG+6qjtXoANVR89VM6f75a5kmRIbungV7ywXD8VtmM8wef5C6IkqMFhROX1HYRo9Sm1kZOW
 saz62DSUUd/fn3Ix/aSqJVglEtnFggTvi4y/qO0sxBxzHDeqqFz43py4SDhdaHkWkQILQXDyW9dm
 jNKonZjYWHRTR+H6+2RiNcUwzTu30W3aAMyZU+AFpdcwj1rCWKtoaItdoEjZybQVqqiDgYguI1bG
 7m9C/1crfxEQ+RMIu45TjrXtoQVWRmJMAe+fcJPd0z6bhalFEM/pjPCQA+BAlnDfxF+P4qUdmrCV
 Jcb6keE4kn354Ur/DPbOVK8U1h7+CQ9zHshHNhAtXYb18nfCRRlJFBHB+of+uXRa0S3mFIoiSRWm
 1WkKsmdoBm6E4S2NuN/NBTe2/ULqDAwOt9zqr+uO5TcDeKjrEmYPn2IVWRtXQGd2K9wEqsPdlH9+
 YnMU5dPhUFL9snxfLwyUh0hPsPhVGdemay+RORAW9d0tvzdLMkCVXN63lz38Up+2UgeFcpE+PmUA
 j1PxNMRErSYM7n8DxBG3VLDRB+maCRTs466AUT31X+L1qXgiXZeLdQiA
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro
X-Complaints-To: abuse@cleanserver1.mxserver.ro

The mcp3564_oversampling_avail array was previously declared as unsigned
int but used with find_closest(). With find_closest() now implemented as
a function taking signed int parameters instead of a macro,  passing
unsigned arrays causes type incompatibility errors. This patch changes the
arrays type from unsigned int to int to ensure compatibility with the
function signature and prevent compilation errors.

Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
---
 drivers/iio/adc/mcp3564.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index a68f1cd6883e..01efc77f710a 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -253,7 +253,7 @@ enum mcp3564_oversampling {
 	MCP3564_OVERSAMPLING_RATIO_98304
 };
 
-static const unsigned int mcp3564_oversampling_avail[] = {
+static const int mcp3564_oversampling_avail[] = {
 	[MCP3564_OVERSAMPLING_RATIO_32] = 32,
 	[MCP3564_OVERSAMPLING_RATIO_64] = 64,
 	[MCP3564_OVERSAMPLING_RATIO_128] = 128,
-- 
2.49.0


