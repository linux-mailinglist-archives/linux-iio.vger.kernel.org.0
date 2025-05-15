Return-Path: <linux-iio+bounces-19538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE61AB8183
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8D418882DC
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 08:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4ED295D89;
	Thu, 15 May 2025 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b="I5GISWNL"
X-Original-To: linux-iio@vger.kernel.org
Received: from clean103.mxserver.ro (clean103.mxserver.ro [176.223.125.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7042949F9;
	Thu, 15 May 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.223.125.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299133; cv=none; b=CdLvXfC7jLBVM3xPnmw86pAhzDWDdk1ftxcm3U4Pd6cz7FaR7UP8OZFKXaTdtBrZe+NoPdr1weAFw8/Y1c5c9vLrW8t+JeiLWRm0f+wKs7Iq3g3iKBarB3IupxuUu4bNGsMUUlJqlOSBhxMEjjJPZxNwbfRZ4+FCuA0h0MuBHi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299133; c=relaxed/simple;
	bh=q/hTLxGkevrKMP4/fm1sZBbPK6IIoosv/EPhSqzLYSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnhyiIM/5nOJqKCztLqClJVyaCmFjxhDKdaEGV2k5pQ1WBxRz1aDdC6wlXKjQCh3Yv0YShTwqKS2M3zx8XiJV5ZXqmt5kwEEcuI+mHyvNX2e4E2E7IB4bPufOepJ/1wd5bcJ+VeyakpiozjaT+bDQ53n6Md8l2t0y14kwDk8WFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro; spf=pass smtp.mailfrom=taladin.ro; dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b=I5GISWNL; arc=none smtp.client-ip=176.223.125.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Received: from cloud347.c-f.ro ([185.236.86.218])
	by cleanserver1.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTm5-00H1Ro-65; Thu, 15 May 2025 04:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=koakyKDUeUIeXFkt5kHFcp8R9b8v4EKGe5vzuuktP7U=; b=I5GISWNLK58PKla/LyJdEMylzb
	pnP5NkUlRT1ZxS0cdp67LfIcRRV9pkS2JRrg1B9np0hpEU90qPExPVJck7HACbC0P21pKzfn95JvD
	iiJmRVa6Qtj/X2PP24tJr/JcXtaicxxKbfQW1Nw6I7gCL66WHBdX9k2Q9GDv915sM4WAqXdxumagh
	vzBUTzS8oNgaY9awb/miMx2SX8+Kn3W/43KA1KPzOfS+05huC60U0Gs6fvnkEaBmO2zB+/6Csi3xW
	fLBhE29dkoUzDBtALBhlQe6WauOdpgVtc6Vp0Jdzek5ai4JrYNjUQGeEa9ILM+PaYABztHTb/HHOe
	HsT64JgA==;
Received: from [109.166.137.172] (port=39050 helo=localhost)
	by cloud347.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTlv-00000006qIN-0WJA;
	Thu, 15 May 2025 11:17:04 +0300
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
Subject: [PATCH 12/16] iio: max44009: Fix type incompatibility with non-macro find_closest
Date: Thu, 15 May 2025 11:13:28 +0300
Message-ID: <20250515081332.151250-13-asoponar@taladin.ro>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00920917721819)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9LmVb6q1/FaccTvM3orKErPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5TSx
 S75yz9IFZiY7BarU/NrpK8SEOwGmfn6ucAKqn/OHRh3BqzFaEnAEj4UixLJBjVNiLZt/QXQnOBRD
 +jq1HsIBmHTFdhqXZEtguZY7iGKpkcJnJKaJfT+dw1udmv00tbIRNtoyOobb3xnDyRRylAVTYi2b
 f0F0JzgUQ/o6tR7C8pLPCtTiVLo0r89ClJHDKhDGKgJ+T00JeCnHBmMdB1eMZAyYlfUtEN4pUyes
 jVRntA/J5DcfwvG53FyVviDO9UET3GKmqv1jT0lY+AQz8YX4CVph7ctC7tRH2SPTQJ/0klTuXKq/
 B9rqRWsYzNfBLt79i78aPHyWnIqxGMxPZotYvH/es1vXuByXo2bkrYMqq0x5CzaUoJIoBUQayHle
 UvbvCQmh9x4kn6NeQcRkc6G+OgAcq5x+BzhRyg9rYO6I0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X
 +u7aTqYHtT2CBuxNPBc9JM2jck1NnIBf0tvflhq7Xjhll72AYgnW/6M0ftSpvLIx+X1vKami8KF6
 jWQ71uVNIY/EFPWeDmcZuFRQy1vmjjPiYw8fUCp0/qY6cmSW9oUDdvKuTRfTGZ6f8nTXoYFaQ71l
 mMti8uxA0gKVmIzBXtbLDVvAQ/KVNQByWRrgu16SD9QRg+25pqKSAN5VcIfsMVILjVAz6RZsCHxD
 lgOJwEwCFaF+62b2lf1UUDu9jECN1V/lwmsioRLmNJoHOZOE/9e5UD715p61XAQw85DCXa0iAPEd
 fYyrF5wMRSLGyY+i0m2IxQLxQUxLMkCVXN63lz38Up+2UgeFSDBPqdRoFsq0hfzdx0oxkgNI/jhY
 WFhu7VV+HdWjdZLlmQ5z83qEVVG/6RJ+BW7FmGcwL889DSW2cZWGkIYVQAbHnYkWUz1gRIjAiMvi
 vM7um7t0SVa5NVZ2g1u6DnOpqk1nwAzTSgytNKIH5lfAuQc8I07FTFcjpdfX/Jcr87en7cKbI0NU
 afdkQMG+6qjtXoANVR89VM6f75a5kmRIbungV7ywXD8VtmM8wef5C6IkqMFhROX1HYRo9Sm1kZOW
 saz62DSUUd/fn3Ix/aSqJVglEtnFggTvi4y/qO0sxBxzHDeqqFz43py4SDhdaHkWxEWqfohU+1d2
 sh7IKZpXLgBCJ476nn5Gmr/PK603nEEtNszXdIHFite8wCT/ojMvxJYqN+GmyxwR+V15PgePOPPI
 vtB/lrJsWW29FRnUbXCk3//yGA2OaEkyEoP0Kl1YERWeKKG4PAQYNyavp7c49JwbmBalBK3QvTzZ
 aymz/kAx9sNOIdFDvUNZLdaRhCZanVD8rWRXHFnkJJ9VGpuX4LTQYyCuF2Axy3+5ga4Wzl9Zj2VA
 3aW/vPi2AMAbWLs/EIKEbeDIxNYIJ7Ews1OEan6m+UeFXprlCOm3BAEbJtATHIdhc/Osc/lXM+l8
 06U7GxUAPGlXms+D1TI22+vIvtmOpB8mDzWv8vBwVi5XkC8ewLVRqANj6mzlzL3VH5WM/aCyI5/o
 yhoezeIJy3L+cB4hBppwR1r+Bof9KZqCMQkUV4VT4TerS/vbL3R5w07g
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro
X-Complaints-To: abuse@cleanserver1.mxserver.ro

The max44009_int_time_ns_array array was previously declared as u32 but
used with find_closest(). With find_closest() now implemented as a
function taking signed int parameters instead of a macro, passing unsigned
arrays causes type incompatibility errors. This patch changes the arrays
type from u32 to int to ensure compatibility with the function signature
and prevent compilation errors.

Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
---
 drivers/iio/light/max44009.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
index 8cd7f5664e5b..d274224fc210 100644
--- a/drivers/iio/light/max44009.c
+++ b/drivers/iio/light/max44009.c
@@ -55,7 +55,7 @@
 /* The fixed-point fractional multiplier for de-scaling threshold values */
 #define MAX44009_FRACT_MULT 1000000
 
-static const u32 max44009_int_time_ns_array[] = {
+static const int max44009_int_time_ns_array[] = {
 	800000000,
 	400000000,
 	200000000,
-- 
2.49.0


