Return-Path: <linux-iio+bounces-19535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09721AB815E
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1F318884AC
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 08:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2691228AB11;
	Thu, 15 May 2025 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b="Qv8AGPej"
X-Original-To: linux-iio@vger.kernel.org
Received: from clean210.mxserver.ro (clean210.mxserver.ro [176.223.125.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21CF2797A1;
	Thu, 15 May 2025 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.223.125.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298950; cv=none; b=Uok8MLWrLsw9wNwDEPg6v7iy/wY0QUA5BeMvzZNZBix0rZXx7tNSGurZ7KuA7Yoe8v+hOu7JmxwUwV56hIBwiJhf8rGukOnSYRVneDorTcSfCsSjwHips/bUjcG12qDUbmqfx80jGDUYRqu8Z0Yh052ev/cIY8sx+63XVrA0aQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298950; c=relaxed/simple;
	bh=afSHaI5eP32dQE5fXMwmOmDmg8JFKckh+LAOUTVscFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pd1rCwZjMbgjpL2TTnZR+nHlaIEVbxLshTZmkP6e08JxO/P+MPh/37RqIm/PIbwT2SOdzVALz2piQ+H30WgOSFa9kXgzgZISL8DHMzsvKteUTK6aet62KUeBKPY5fstiRS2TmF8UHJuvrhMXYcmiWipWRYm/neryjJGia159NjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro; spf=pass smtp.mailfrom=taladin.ro; dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b=Qv8AGPej; arc=none smtp.client-ip=176.223.125.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Received: from cloud347.c-f.ro ([185.236.86.218])
	by cleanserver2.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTm4-001W25-Vt; Thu, 15 May 2025 04:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IcwQOeAopjJk4D833aLWPS/i3EpXTNhJ5OpQyTYtqcU=; b=Qv8AGPejwyTt2HEAh8UKzOQGTy
	gPmmaCA6DYGC/iC13lIUwKL1zddUJLqr6qnYqcMa5WfG5C6/b5OpxTtI5c8Bg5G28qqqnG/UGqpZq
	vZLFJuAnLQaSk9Xc5ch9k9vWGl65OTWWC4nA+z1V8At6CP3LzjtL+EB6CfaDvEFNr4gqH9058lkgX
	yMoGouH1h0fVjeH8fCnx+1FJzPFaHFBqSmMx33ieECLYMW+ZEoTJxQ+8v2ywGHWpTRvf4CCSni/yT
	5f/uXagpUd8Q5h+mjQlYae8yG7bC6um6cJPuPgse3acq9LZoEMEqDYSGhvF4NEgk3SZxEVRQ6N96n
	AXOLwhqw==;
Received: from [109.166.137.172] (port=39024 helo=localhost)
	by cloud347.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTlt-00000006qFv-0sEf;
	Thu, 15 May 2025 11:17:02 +0300
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
Subject: [PATCH 10/16] iio: ad7606: Fix type incompatibility with non-macro find_closest
Date: Thu, 15 May 2025 11:13:26 +0300
Message-ID: <20250515081332.151250-11-asoponar@taladin.ro>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00322122345698)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+K+F6pHTdOPZZqI+fEkVaAPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5TSx
 S75yz9IFZiY7BarU/NrpK8SEOwGmfn6ucAKqn/OHRh3BqzFaEnAEj4UixLJBjVNiLZt/QXQnOBRD
 +jq1HsIBmHTFdhqXZEtguZY7iGKpkcJnJKaJfT+dw1udmv00tbIRNtoyOobb3xnDyRRylAVTYi2b
 f0F0JzgUQ/o6tR7C8pLPCtTiVLo0r89ClJHDKhDGKgJ+T00JeCnHBmMdB1eMZAyYlfUtEN4pUyes
 jVRntA/J5DcfwvG53FyVviDO9UET3GKmqv1jT0lY+AQz8YX4CVph7ctC7tRH2SPTQJ/0klTuXKq/
 B9rqRWsYzNfBLt79i78aPHyWnIqxGMxPZotYvH/es1vXuByXo2bkrYMqq0x5CzaUoJIoBUQayHle
 UvbvCQmh9x4kn6NeQcRkc6G+OgAcq5x+BzhRyg9rYO6I0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X
 +u7aTqYHtT2CBuxNPBc9JM2jck1NnIBf0tvflhq7Xjhll72AYgnW/6M0ftSpvLIx+X1vKami8KF6
 jWQ71uVNIY/EFPWeDmcZuFRQy1vmjjPiYw8fUCp0/qY6cmSW9oUDdvKuTRfTGZ6f8nTXoYFaQ71l
 mMti8uxA0gKVmIzBXtbLDVvAQ/KVNa6nAbYGixTbx4sXUH4WPL6SAN5VcIfsMVILjVAz6RZsCHxD
 lgOJwEwCFaF+62b2lf1UUDu9jECN1V/lwmsioRLmNJoHOZOE/9e5UD715p61XAQw85DCXa0iAPEd
 fYyrF5wMRSLGyY+i0m2IxQLxQUzTb3Mji+CrO1+NTWs5OBXbSDBPqdRoFsq0hfzdx0oxkgNI/jhY
 WFhu7VV+HdWjdZLlmQ5z83qEVVG/6RJ+BW7FmGcwL889DSW2cZWGkIYVQAbHnYkWUz1gRIjAiMvi
 vM7um7t0SVa5NVZ2g1u6DnOpqk1nwAzTSgytNKIH5lfAuQc8I07FTFcjpdfX/Jcr87en7cKbI0NU
 afdkQMG+6qjtXoANVR89VM6f75a5kmRIbungV7ywXD8VtmM8wef5C6IkqMFhROX1HYRo9Sm1kZOW
 saz62DSUUd/fn3Ix/aSqJVglEtnFggTvi4y/qO0sxBxzHDeqqFz43py4SDhdaHkWOGxZQgSAzbb+
 OB/nFYi5VbOv2oY4HXLSfAUu3sMpupagJz67c6+2AaKYGhiMiXWGMvYnkNWjwSQDaUU9MqYUCeef
 0nlkmUPzlfoLUG4g/XHuva4NQ7gH1kLtR+dZ31Wj92PNDpgLsd6Ddd/s7VM53twrVC8K+lj1c6e/
 tTmd6eMo8njYQeCXryE9YzCFXixhT7FVIMQwRWLn0yVyqUMOeb6+5/5oQUTrIe1XMSXJ58tr/yiP
 gGFyxS1LuwmPRAQzaEJVYkfhZXq/u54kZVCWtfUf9oDBqtClgM5jH/om1Q6gjkapWNvVA5HRyb3X
 trWYR6vnFpUUmgU46LTsHtrjRqVe/ojyw7bapws3danDDsxD6gvvWu5/Lf1bKbM1VroDfVYPkwIu
 /8x7KhILIr1IfwgT9kxT5f4reZBSMLp/jH4zvQRYQJnl3XNqRK2lK/zP
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro
X-Complaints-To: abuse@cleanserver1.mxserver.ro

The ad7606_oversampling_avail and ad7616_oversampling_avail arrays were
previously declared as unsigned int but used with find_closest(). With
find_closest() now implemented as a function taking signed int parameters
instead of a macro, passing unsigned arrays causes type incompatibility
errors. This patch changes the arrays type from unsigned int to int to
ensure compatibility with the function signature and prevent compilation
errors.

Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
---
 drivers/iio/adc/ad7606.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index d8e3c7a43678..41b477ea386d 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -81,11 +81,11 @@ static const unsigned int ad7609_hw_scale_avail[2][2] = {
 	{ 0, 152588 }, { 0, 305176 }
 };
 
-static const unsigned int ad7606_oversampling_avail[7] = {
+static const int ad7606_oversampling_avail[7] = {
 	1, 2, 4, 8, 16, 32, 64,
 };
 
-static const unsigned int ad7616_oversampling_avail[8] = {
+static const int ad7616_oversampling_avail[8] = {
 	1, 2, 4, 8, 16, 32, 64, 128,
 };
 
@@ -835,7 +835,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	unsigned int scale_avail_uv[AD760X_MAX_SCALES];
+	int scale_avail_uv[AD760X_MAX_SCALES];
 	struct ad7606_chan_scale *cs;
 	int i, ret, ch = 0;
 
@@ -884,7 +884,7 @@ static ssize_t ad7606_oversampling_ratio_avail(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
-	const unsigned int *vals = st->oversampling_avail;
+	const int *vals = st->oversampling_avail;
 	unsigned int i;
 	size_t len = 0;
 
-- 
2.49.0


