Return-Path: <linux-iio+bounces-19541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7171AAB81A0
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC6C1652DC
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 08:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B978929373E;
	Thu, 15 May 2025 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b="fc5xdrN/"
X-Original-To: linux-iio@vger.kernel.org
Received: from clean105.mxserver.ro (clean105.mxserver.ro [92.114.95.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B3A292938;
	Thu, 15 May 2025 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.114.95.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299367; cv=none; b=jvnd1WD5MgGyOoujY91ZDB4lBUmqVfEnDv586ut61VRfPAirCK4iJmNlyU+hKyYYDf5r20DHK5akLu8vpgAOPKrQVGeG3L5y5c5h9tY/7t89gJvE8xtvkHiwNTsiRhD8HSyBDFm36d4GhUzYRX9zhSeElmxoDEqIf1aC9k1Pumk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299367; c=relaxed/simple;
	bh=Xta5vcw4KkmzpWriNGlKcNZL5QsXdN8++O/8iPTi9yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYK86UpsvrmKpUtO+NQtgh+GP4qs+St7yMYBhTAVjzrYGlMTbkFENh2coYmTbcAZ+Jg/IDUU6TNp7zLDWNpjAfG8Cd5sIZQBoyLAkHgnxorG9P4QPBybgZu540mUwAeYIX7ZuXWhjDAg1jt3aLUrR9qAwvf4/3BNDWfo/Ms6o9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro; spf=pass smtp.mailfrom=taladin.ro; dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b=fc5xdrN/; arc=none smtp.client-ip=92.114.95.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Received: from cloud347.c-f.ro ([185.236.86.218])
	by cleanserver1.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTm0-00H1KA-At; Thu, 15 May 2025 04:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xkeLCaU/1+RII/gYEEzfRuhF0PH8h1Fme+aEOtr3w4c=; b=fc5xdrN/aHIgDLVyLNWcS3Q1ye
	knmPHqwhGe39WTmWOpDau2kNRjMB5WmJlSyE/2wHWP8Logl2EwV564S/qliwFXTnT7ntDD470pEX+
	zYEWcd1a77nSRSdtB2fHJgP2fxjctp9yV/5n9DkaND1wMDYq58rw5gw/e9tp1yzZWb8+Dcik+2p59
	x1KOtfkXIri9sc6tJ7inR/shhIOzhwkqohm0lttOY13qTiS5vkU3pgqsNtx85em7zmwVb9PoMx3Y8
	gInxGGyRnfolsMkHdNd1m33wQTxbPeAUvlGv/+OmzC0PZtHWVCBlXWoV3ol//QYUaj+Skgcmi2hXU
	yT+K09Nw==;
Received: from [109.166.137.172] (port=38988 helo=localhost)
	by cloud347.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTlq-00000006qAM-1kw1;
	Thu, 15 May 2025 11:16:59 +0300
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
Subject: [PATCH 07/16] hwmon: ltc4282: Fix type incompatibility with non-macro find_closest
Date: Thu, 15 May 2025 11:13:23 +0300
Message-ID: <20250515081332.151250-8-asoponar@taladin.ro>
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
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+kbbgtt6YqFbUOBNVEWJXWPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5TSx
 S75yz9IFZiY7BarU/NrpK8SEOwGmfn6ucAKqn/OHRh3BqzFaEnAEj4UixLJBjVNiLZt/QXQnOBRD
 +jq1HsIBmHTFdhqXZEtguZY7iGKpkcJnJKaJfT+dw1udmv00tbIRNtoyOobb3xnDyRRylAVTYi2b
 f0F0JzgUQ/o6tR7C8pLPCtTiVLo0r89ClJHDKhDGKgJ+T00JeCnHBmMdB1eMZAyYlfUtEN4pUyes
 jVRntA/J5DcfwvG53FyVviDO9UET3GKmqv1jT0lY+AQz8YX4CVph7ctC7tRH2SPTQJ/0klTuXKq/
 B9rqRWsYzNfBLt79i78aPHyWnIqxGMxPZotYvH/es1vXuByXo2bkrYMqq0x5CzaUoJIoBUQayHle
 UvbvCQmh9x4kn6NeQcRkc6G+OgAcq5x+BzhRyg9rYO6I0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X
 +u7aTqYHtT2CBuxNPBc9JM2jck1NnIBf0tvflhq7Xjhll72AYgnW/6M0ftSpvLIx+X1vKami8KF6
 jWQ71uVNIY/EFPWeDmcZuFRQy1vmjjPiYw8fUCp0/qY6cmSW9oUDdvKuTRfTGZ6f8nTXoYFaQ71l
 mMti8uxA0gKVmIzBXtbLDVvAQ/KVNXa0zN3wkTScLqeN/X1xpXiSAN5VcIfsMVILjVAz6RZsCHxD
 lgOJwEwCFaF+62b2lf1UUDu9jECN1V/lwmsioRLmNJoHOZOE/9e5UD715p61XAQw85DCXa0iAPEd
 fYyrF5wMRSLGyY+i0m2IxQLxQUxLMkCVXN63lz38Up+2UgeFSDBPqdRoFsq0hfzdx0oxkgNI/jhY
 WFhu7VV+HdWjdZLlmQ5z83qEVVG/6RJ+BW7FmGcwL889DSW2cZWGkIYVQAbHnYkWUz1gRIjAiMvi
 vM7um7t0SVa5NVZ2g1u6DnOpQHYV3TsOFMmdrwGhqQDw/U3WHzWVE9linvPYkk5EbvNSKMKZZKIm
 pSRiVj3Z6FeYyEA/4qyBWyM8TTC6Mg9RWQhL+FDRQ14qhQ8eQiedscRlw3yFXNuLqAW9V7zLFic5
 yLycIETNRAvUQf+piJ7sPxqZR3KVQgqF/fPYYAfEfsiDGp7i4K9gmqREIfOEHv/AIZm2yoKIH61n
 a1iNI9sJnrdnfez/EoAkHCogqF44Avfl9XC1Cx34YL7X+JLwYAm5ypSliZ75kJ0rTza8+YFWM4S1
 7lffY/fLNHsH8DeB1ciz42LgJIaeGQmuwKFVmHrkHiEGmnBHWv4Gh/0pmoIxCd7Wl7bcZf/Yjlgk
 C5/TshWi/jhyVxmU68POz+7IAL/WcTQDm0YvDLW6j0ztAyPgv56IZdRxyG8ZeWMbNPZiNWdBqyRc
 AYMRiF/tTJMpgiPRIHs6CS/Wfz+lGlAmDqpSODMqRVTYPdDe9fNkDTBGwLS7dfE8OG6V00DpgPHh
 UdfSfqIJ3VUm2y3pNa2dBD3F+DFlJQxAtZlYB2ywONOJP1ekyl6c7Cq2HuJSCRWhvBtVdoCRStPj
 NlKN8tqRiXqTYOVbu7qFs1k1cwrc0cM1w7Y=
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro
X-Complaints-To: abuse@cleanserver1.mxserver.ro

The ltc4282_out_rates array was previously declared as unsigned int but
used with find_closest(). With find_closest() now implemented as a function
taking signed int parameters instead of a macro, passing unsigned arrays
causes type incompatibility errors. This patch changes the array type from
unsigned int to int to ensure compatibility with the function signature and
prevent compilation errors.

Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
---
 drivers/hwmon/ltc4282.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ltc4282.c b/drivers/hwmon/ltc4282.c
index 4f608a3790fb..1908a998feb1 100644
--- a/drivers/hwmon/ltc4282.c
+++ b/drivers/hwmon/ltc4282.c
@@ -173,7 +173,7 @@ static int ltc4282_set_rate(struct clk_hw *hw,
  * Note the 15HZ conversion rate assumes 12bit ADC which is what we are
  * supporting for now.
  */
-static const unsigned int ltc4282_out_rates[] = {
+static const int ltc4282_out_rates[] = {
 	LTC4282_CLKOUT_CNV, LTC4282_CLKOUT_SYSTEM
 };
 
-- 
2.49.0


