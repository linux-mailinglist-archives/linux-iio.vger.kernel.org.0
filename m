Return-Path: <linux-iio+bounces-19543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEBCAB8234
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 11:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD51216C9EF
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 09:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C57D293B5F;
	Thu, 15 May 2025 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b="MWI1dMT3"
X-Original-To: linux-iio@vger.kernel.org
Received: from clean110.mxserver.ro (clean110.mxserver.ro [89.46.7.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB371C4A20;
	Thu, 15 May 2025 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.46.7.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300421; cv=none; b=S/FyFf0+DTKSO5h/xdrKy2gFXdq/cD9RqPZLm8MYyQHEnx9kJVf3jwKuHY+tBl8t4/ljpqbgH71i3WJXdKiAZzg+WQD7iCEPjwqrF+KTk2S8XLgqpJPKhfPCH4MQaWmZQCEMqwiqj7LK0TDD6vS3sSj0+2IxwSpL+ADrxShFYqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300421; c=relaxed/simple;
	bh=SFsEIdrP6hHN6X/ZQ+xkzbfpWgoSLqIaX+iq6UcXdr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWewFuXZLi61Ory/Kyz6D+pwYJOjVap25g1m/NU9EG/xRy5f6rimoV9ye1f4eji5zcfgbXlzIjdyK6Gv90KNThpghzbMZiuPpOICuan51Kw0bfrR3k+TKDpYf2I7WETyLMZaVeOXF4/VEL/LQs/aFk/gspjgA1DF5YmSid1QAX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro; spf=pass smtp.mailfrom=taladin.ro; dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b=MWI1dMT3; arc=none smtp.client-ip=89.46.7.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Received: from cloud347.c-f.ro ([185.236.86.218])
	by cleanserver1.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTly-00H1IU-5p; Thu, 15 May 2025 04:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sEpO7OpjVT0XSxus/yyrP/Dip45qs8iHo0xmypk/VOA=; b=MWI1dMT3PBKFALb4aPj0hQnWaA
	PZBTh3wNFli8mSt049q7OxBdbs7loxwvP3flPpdNU9gOVM9BtwbhPNdGx73i7VFtTtIBgkHirHoIA
	wFQHuOLy1hbVTXrxqwvIBM+zRlfSf0dyIqoMn3NDl4DIAqf13bMUXFeqYZE1/oHQOVqVOqSda2Y8D
	2GS1pjNaDHkSoRdhzvfotTMzLOiun1mYJIy56yM9BlVQwRtPFeryON03ZfriMbIqCf/8OVKiPl25q
	x1UcSV9QkoabAWeP99RaVXBZmjtxttsWHzQfZsa5dNRhP9/accGab9XAwueGTVWYl0jZbIZiQLDVT
	glChjVsQ==;
Received: from [109.166.137.172] (port=37876 helo=localhost)
	by cloud347.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTll-00000006q85-3vHx;
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
Subject: [PATCH 02/16] hwmon: emc1403: Fix type incompatibility with non-macro find_closest
Date: Thu, 15 May 2025 11:13:18 +0300
Message-ID: <20250515081332.151250-3-asoponar@taladin.ro>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00463308261943)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT/AbQevlWAh+RflL9yAhNbrPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5TSx
 S75yz9IFZiY7BarU/NrpK8SEOwGmfn6ucAKqn/OHRh3BqzFaEnAEj4UixLJBjVNiLZt/QXQnOBRD
 +jq1HsIBmHTFdhqXZEtguZY7iGKpkcJnJKaJfT+dw1udmv00tbIRNtoyOobb3xnDyRRylAVTYi2b
 f0F0JzgUQ/o6tR7C8pLPCtTiVLo0r89ClJHDKhDGKgJ+T00JeCnHBmMdB1eMZAyYlfUtEN4pUyes
 jVRntA/J5DcfwvG53FyVviDO9UET3GKmqv1jT0lY+AQz8YX4CVph7ctC7tRH2SPTQJ/0klTuXKq/
 B9rqRWsYzNfBLt79i78aPHyWnIqxGMxPZotYvH/es1vXuByXo2bkrYMqq0x5CzaUoJIoBUQayHle
 UvbvCQmh9x4kn6NeQcRkc6G+OgAcq5x+BzhRyg9rYO6I0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X
 +u7aTqYHtT2CBuxNPBc9JM2jck1NnIBf0tvflhq7Xjhll72AYgnW/6M0ftSpvLIx+X1vKami8KF6
 jWQ71uVNIY/EFPWeDmcZuFRQy1vmjjPiYw8fUCp0/qY6cmSW9oUDdvKuTRfTGZ6f8nTXoYFaQ71l
 mMti8uxA0gKVmIzBXtbLDVvAQ/KVNTWALGJzCrBoi/4ByzWCdrOSAN5VcIfsMVILjVAz6RZsCHxD
 lgOJwEwCFaF+62b2lf1UUDu9jECN1V/lwmsioRLmNJoHOZOE/9e5UD715p61XAQw85DCXa0iAPEd
 fYyrF5wMRSLGyY+i0m2IxQLxQUxLMkCVXN63lz38Up+2UgeFSDBPqdRoFsq0hfzdx0oxkgNI/jhY
 WFhu7VV+HdWjdZLlmQ5z83qEVVG/6RJ+BW7FmGcwL889DSW2cZWGkIYVQAbHnYkWUz1gRIjAiMvi
 vM7um7t0SVa5NVZ2g1u6DnOpqk1nwAzTSgytNKIH5lfAuQc8I07FTFcjpdfX/Jcr87en7cKbI0NU
 afdkQMG+6qjtXoANVR89VM6f75a5kmRIbungV7ywXD8VtmM8wef5C6IkqMFhROX1HYRo9Sm1kZOW
 saz62DSUUd/fn3Ix/aSqJVglEtnFggTvi4y/qO0sxBxzHDeqqFz43py4SDhdaHkWxEWqfohU+1d2
 sh7IKZpXLgBCJ476nn5Gmr/PK603nEEcf1B7S/Q5Y1x9OERLjlo/xJYqN+GmyxwR+V15PgePOPPI
 vtB/lrJsWW29FRnUbXCk3//yGA2OaEkyEoP0Kl1YERWeKKG4PAQYNyavp7c49JwbmBalBK3QvTzZ
 aymz/kAx9sNOIdFDvUNZLdaRhCZaLQiUCt7lLFd4QEmyiHT3nyoAiv3KW15o855pU/4uCclZj2VA
 3aW/vPi2AMAbWLs/EIKEbeDIxNYIJ7Ews1OEan6m+UeFXprlCOm3BAEbJtATHIdhc/Osc/lXM+l8
 06U7GxUAPGlXms+D1TI22+vIvtmOpB8mDzWv8vBwVi5XkC8ewLVRqANj6mzlzL3VH5WM/aCyI5/o
 yhoezeIJy3L+cB4hBppwR1r+Bof9KZqCMQkUV4VT4TerS/vbL3R5w07g
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro
X-Complaints-To: abuse@cleanserver1.mxserver.ro

The ina3221_conv_time array was previously declared as u16 but used with
find_closest_descending(). With find_closest_descending() now implemented
as a function taking 'int' parameters instead of a macro, passing unsigned
arrays causes type incompatibility errors. Change the array type from u16
to int to ensure compatibility with the new function signature.

Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
---
 drivers/hwmon/emc1403.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index eca33220d34a..41590b44b162 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -517,7 +517,7 @@ static int emc1403_temp_write(struct thermal_data *data, u32 attr, int channel,
 }
 
 /* Lookup table for temperature conversion times in msec */
-static const u16 ina3221_conv_time[] = {
+static const int ina3221_conv_time[] = {
 	16000, 8000, 4000, 2000, 1000, 500, 250, 125, 62, 31, 16
 };
 
-- 
2.49.0


