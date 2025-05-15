Return-Path: <linux-iio+bounces-19539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E035AB818E
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C351885368
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 08:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28949296716;
	Thu, 15 May 2025 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b="uvuNDQts"
X-Original-To: linux-iio@vger.kernel.org
Received: from clean305.mxserver.ro (clean305.mxserver.ro [89.46.7.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8FA28DF03;
	Thu, 15 May 2025 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.46.7.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299182; cv=none; b=P03KyL6xEiIWk62jQESapQaSddUDETkTaUW3p5JVK11BGbH1Rv6z5t7Q1JBOqiYLoNLnbNpzwNIulWJo6/IUt2TTf/RfwNOfhzye5p56Cp4xpBzl7hOfClXYv4mou3a9QFruVu5iEIjXsxMEruzGzp0BBjW+F6d7sf4eqjI92S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299182; c=relaxed/simple;
	bh=cUhXfE0teahU2ww6EIn0nqXfWhkzFFEyzjETfkiZ7W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgvZFMfybdOp/DqebM5ZtP7a87YofEajm43iR4rmOUh2gUVUymdOvz6e948nwXOILzLEhwyis0P41UlbxXrnrCvriYXKTALOGqBVVtTEcBOTcbv22Vyw9of56QuLV9vvfeMex72QGceZa2hamejawXc5KhmPkdpU59mdZFFBUK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro; spf=pass smtp.mailfrom=taladin.ro; dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b=uvuNDQts; arc=none smtp.client-ip=89.46.7.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Received: from cloud347.c-f.ro ([185.236.86.218])
	by cleanserver3.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTm3-00CMcl-2s; Thu, 15 May 2025 04:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TfYvbooBJpGFwd30gpTbaChn3Y/B5jOh5zocpZWBp90=; b=uvuNDQtsUu0l5/gDrSrjcmTwy8
	7cuiYtU+wtm1CUfY/wL1sz0/cXFuAd8o7RSi9ZzPGJDZ3WKW4pm1G+LM2Mnj/Gyz5JwNswjTzLVqC
	9tr/xIACDoU+s0wgWrjg/z14eOjAQDfv2msapiqQdd7qEM8rco4VJ19HOAhFHGDLsccNzIVBK6YlM
	cVbprVgE5kbI5IAx1L1TnnLZ+Fmpv30Uad64iXa7qG48ZHBwENWkE3XlNUXSlnvfOV4vJr8xFPGjH
	auqrBBEQAeuTEUK8qKPIevLbDmUVfGvxKk3ycJ0yAmCYhtdfa792vEiah0AItUwrWmyHdBKBS5+PM
	ae5PZWSw==;
Received: from [109.166.137.172] (port=39012 helo=localhost)
	by cloud347.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTls-00000006qBK-0uWI;
	Thu, 15 May 2025 11:17:01 +0300
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
Subject: [PATCH 09/16] hwmon: max20740: Fix type incompatibility with non-macro find_closest
Date: Thu, 15 May 2025 11:13:25 +0300
Message-ID: <20250515081332.151250-10-asoponar@taladin.ro>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00126298370281)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9HrjyttcYZsZ1qAKfxRRdrPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5TSx
 S75yz9IFZiY7BarU/NrpK8SEOwGmfn6ucAKqn/OHRh3BqzFaEnAEj4UixLJBjVNiLZt/QXQnOBRD
 +jq1HsIBmHTFdhqXZEtguZY7iGKpkcJnJKaJfT+dw1udmv00tbIRNtoyOobb3xnDyRRylAVTYi2b
 f0F0JzgUQ/o6tR7C8pLPCtTiVLo0r89ClJHDKhDGKgJ+T00JeCnHBmMdB1eMZAyYlfUtEN4pUyes
 jVRntA/J5DcfwvG53FyVviDO9UET3GKmqv1jT0lY+AQz8YX4CVph7ctC7tRH2SPTQJ/0klTuXKq/
 B9rqRWsYzNfBLt79i78aPHyWnIqxGMxPZotYvH/es1vXuByXo2bkrYMqq0x5CzaUoJIoBUQayHle
 UvbvCQmh9x4kn6NeQcRkc6G+OgAcq5x+BzhRyg9rYO6I0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X
 +u7aTqYHtT2CBuxNPBc9JM2jck1NnIBf0tvflhq7Xjhll72AYgnW/6M0ftSpvLIx+X1vKami8KF6
 jWQ71uVNIY/EFPWeDmcZuFRQy1vmjjPiYw8fUCp0/qY6cmSW9oUDdvKuTRfTGZ6f8nTXoYFaQ71l
 mMti8uxA0gKVmIzBXtbLDVvAQ/KVNZ5qHeAijuf8P+TKZ2Hcpe+SAN5VcIfsMVILjVAz6RZsCHxD
 lgOJwEwCFaF+62b2lf1UUDu9jECN1V/lwmsioRK+Y6c+J2XawkXUwNqmNMJsXAQw85DCXa0iAPEd
 fYyrF5wMRSLGyY+i0m2IxQLxQUz5rOsCgWfUk8oCCEJC9L2lSDBPqdRoFsq0hfzdx0oxkgNI/jhY
 WFhu7VV+HdWjdZLlmQ5z83qEVVG/6RJ+BW7FmGcwL889DSW2cZWGkIYVQAbHnYkWUz1gRIjAiMvi
 vM7um7t0SVa5NVZ2g1u6DnOpqk1nwAzTSgytNKIH5lfAuQc8I07FTFcjpdfX/Jcr87en7cKbI0NU
 afdkQMG+6qjtXoANVR89VM6f75a5kmRIbungV7ywXD8VtmM8wef5C6IkqMFhROX1HYRo9Sm1kZOW
 saz62DSUUd/fn3Ix/aSqJVglEtnFggTvi4y/qO0sxBxzHDeqqFz43py4SDhdaHkWkQILQXDyW9dm
 jNKonZjYWHRTR+H6+2RiNcUwzTu30W1KFmaCL65ELqp8rJqsdffFaItdoEjZybQVqqiDgYguI1bG
 7m9C/1crfxEQ+RMIu45TjrXtoQVWRmJMAe+fcJPd0z6bhalFEM/pjPCQA+BAlnDfxF+P4qUdmrCV
 Jcb6keE4kn354Ur/DPbOVK8U1h7+QJdMBlWCuejtbh4f46dJ9KHgVozBLsX5yKA3Fz74hlciSRWm
 1WkKsmdoBm6E4S2NuN/NBTe2/ULqDAwOt9zqr+uO5TcDeKjrEmYPn2IVWRtXQGd2K9wEqsPdlH9+
 YnMU5dPhUFL9snxfLwyUh0hPsPhVGdemay+RORAW9d0tvzdLMkCVXN63lz38Up+2UgeFcpE+PmUA
 j1PxNMRErSYM7n8DxBG3VLDRB+maCRTs466AUT31X+L1qXgiXZeLdQiA
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro
X-Complaints-To: abuse@cleanserver1.mxserver.ro

The max_current array was previously declared as u32 but used with
find_closest(). With find_closest() now implemented as a function taking
signed int parameters instead of a macro, passing unsigned arrays causes
type incompatibility errors. This patch changes the array type from u32
to int to ensure compatibility with the function signature and prevent
compilation errors.

Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
---
 drivers/hwmon/pmbus/max20730.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
index 95869d198ecf..0e8d292e9ff4 100644
--- a/drivers/hwmon/pmbus/max20730.c
+++ b/drivers/hwmon/pmbus/max20730.c
@@ -436,7 +436,7 @@ static long direct_to_val(u16 w, enum pmbus_sensor_classes class,
 	return d;
 }
 
-static u32 max_current[][5] = {
+static int max_current[][5] = {
 	[max20710] = { 6200, 8000, 9700, 11600 },
 	[max20730] = { 13000, 16600, 20100, 23600 },
 	[max20734] = { 21000, 27000, 32000, 38000 },
@@ -449,7 +449,7 @@ static int max20730_read_word_data(struct i2c_client *client, int page,
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
 	const struct max20730_data *data = to_max20730_data(info);
 	int ret = 0;
-	u32 max_c;
+	int max_c;
 
 	switch (reg) {
 	case PMBUS_OT_FAULT_LIMIT:
-- 
2.49.0


