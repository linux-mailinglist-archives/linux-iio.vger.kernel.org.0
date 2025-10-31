Return-Path: <linux-iio+bounces-25728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6341EC24593
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 11:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE81434FAF2
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 10:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0248331E0E4;
	Fri, 31 Oct 2025 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="e7gHZAyD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DC72C1593;
	Fri, 31 Oct 2025 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905142; cv=none; b=JAXUEK7Cf8YydwMPa5YvDWskx3LxL2AWn0M4oraSnGrbs0LwBvqnLX+B87Q3SexxeGf5hGpBtPeUivscm/SWq74UzfIy/wThyODJyn4jwmRLHhtbRj4VyGUJATMqzezZEIZO1QlVFxEgNOhCCFO5SecsuEBTxcqH3+1o+AJyJGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905142; c=relaxed/simple;
	bh=SmFtkezBCQONedPbSJlI7/0/OSQxRpCSyqIZ/YasEB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=YyqhinOnayQ6d/z7E0oZjLI1jAtgha4Ke2lQYjv1hrAidnobKoH0f9ft0+PqkFXfuW+9j03rR3kDzNYRgpS5MJMtHxwe5KI8okScSGD5pQ+G0UGLDPuxAGHU4ALYvawP7TSSa9jy5vLSqe3+XeKIGmqxoJs87FvxHYdktPdQ2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=e7gHZAyD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V98Z4j3800267;
	Fri, 31 Oct 2025 06:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=KNubBh+pEP5Aks0jk1YbhR4kQ01
	wZoMvExwFOVSq0/s=; b=e7gHZAyD5PyY18JA4M13ctBGSzhmHla6WWX5Z8/ArDD
	w7LOanukzjXshrwwaDyvUdHZTCyxJypc5MWN/wBXMqhCA/b9t96fYeeGgYTAp0/S
	OAZ+JOMbKCCA4O4kSItFbSNAUOptcxbrUvXyKe91qQ8JHVk/P2RPwc6XW1qNdpb7
	L7Hog5bA61YwZRV9AUsVresO8STxTxwDie/exlouTEoFD5IcbVmogmjjp1L/tDR3
	jJmTYg51TS7gPBO+9BjyFM6OL4CQPwrxEV1aerElD+WFdjz1yBGR6Va9fZhqrMBA
	5VvVHoMCIMGUZ2xs3zj7O47zLEwG+0o7ioXU1RGyerw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4a415k83ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 06:05:23 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59VA5L0U027386
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 Oct 2025 06:05:21 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 31 Oct
 2025 06:05:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 31 Oct 2025 06:05:21 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.80])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59VA59Zw007142;
	Fri, 31 Oct 2025 06:05:12 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Fri, 31 Oct 2025 11:05:08 +0100
Subject: [PATCH] iio: accel: Change adxl345 depend to negate adxl35x
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251031-adxl345-allow-adxl34x-mod-v1-1-cd65749ba89c@analog.com>
X-B4-Tracking: v=1; b=H4sIANOJBGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA2ND3cSUihxjE1PdxJyc/HIor0I3Nz9F1yLZOMnQMDnJ1CTZTAmov6A
 oNS2zAmx2dGxtLQA80ctuawAAAA==
X-Change-ID: 20251031-adxl345-allow-adxl34x-mod-8c3b11cb54c6
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gastmaier@gmail.com>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761905109; l=1959;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=SmFtkezBCQONedPbSJlI7/0/OSQxRpCSyqIZ/YasEB0=;
 b=aSPC/DecSOh2zpt/uHoCuJzYj/3chlJhO7vu6XOV94MYADp1XicgFXJKXnPvMFUUm0OA5ApFz
 fSSSohrXHP0CqL1RARxL5rRDeea1x0O/J2DylXp8SNe1bQHbVFwhCv5
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=M7RA6iws c=1 sm=1 tr=0 ts=690489e3 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=UVbCYZ_N73605r1Wr8sA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: XWTt9RcQcvMmrlH9nkouY8Yuv9jdnZvJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA5MSBTYWx0ZWRfX74kQf89ybUdR
 m5x0RBdYxwkfQGtyMo1kQNbf7mA3H4qWVMUFO6TAvNheuv1WKxIuu+0rG+AFP/elJXfM/IBS3Sb
 bnStZESMARQwa+qnR6jUQwNSEC6NAkxlIZOaPGlMRVQ92Tes+sR2uLRCIoRCfZD1eLS3OTF6s7u
 ottDFcd4cB7qfEIGrHBLvVFpQCJeJl6kc0zNtn8IphX5SgNw9F1ILgSQxFopHgpTmV2vMBukpk9
 Ntz1iGT6tY3UBBkKsVOEOfBakv0953j9vzzWpkWDOKtLIFa6PxxJ8x4ciSbfhVlwBnPSzS6yzXw
 DwY9gZkMpU0X6KQ/lBfQSnFGrseJtprEAoFT9muEHu4GhfGp5L3pWusncklS9RZEadLtBHbFNB/
 DQ99Ah6BoBAZqOafAA5ub7dglKGk7A==
X-Proofpoint-ORIG-GUID: XWTt9RcQcvMmrlH9nkouY8Yuv9jdnZvJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310091

Change 'depends on INPUT_ADXL34X=n' to '!(INPUT_ADXL34X)' to allow both
drivers to be compiled as modules. The user then can use the blacklist
to block loading one.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
There are two drivers for the compatible:

- adi,adxl345

* IIO: 
  drivers/iio/accel/adxl345_core.c
  drivers/iio/accel/adxl345_spi.c
  drivers/iio/accel/adxl345_i2c.c
* Inputs:
  drivers/input/misc/adxl34x-spi.c
  drivers/input/misc/adxl34x-i2c.c

To disallows both being complied, the depends INPUT_ADXL34X=n
was added to ADXL345 symbols. However, it should be possible to compile
both as modules, then blacklist one of them in the /etc/modprobe.d/blacklist.conf
file. This patch changes the rule to !(INPUT_ADXL34X) to allow both as
modules, but still disallow INPUT_ADXL34X to be built-in and ADXL345 as
module.

The following compatibles are not shared between both drivers:

* IIO:
  adi,adxl375 spi/i2c
* Inputs:
  adi,adxl34x i2c
---
 drivers/iio/accel/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 76911278fb217..f657acba5ab7d 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -64,7 +64,7 @@ config ADXL345
 
 config ADXL345_I2C
 	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer I2C Driver"
-	depends on INPUT_ADXL34X=n
+	depends on !INPUT_ADXL34X
 	depends on I2C
 	select ADXL345
 	select REGMAP_I2C
@@ -78,7 +78,7 @@ config ADXL345_I2C
 
 config ADXL345_SPI
 	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer SPI Driver"
-	depends on INPUT_ADXL34X=n
+	depends on !INPUT_ADXL34X
 	depends on SPI
 	select ADXL345
 	select REGMAP_SPI

---
base-commit: 70437bbd7529e9860fb7f0c92a89e0e6abaa994e
change-id: 20251031-adxl345-allow-adxl34x-mod-8c3b11cb54c6

Best regards,
-- 
Jorge Marques <jorge.marques@analog.com>


