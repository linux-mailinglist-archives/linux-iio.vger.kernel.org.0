Return-Path: <linux-iio+bounces-26188-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD6AC54B1D
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 23:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAE254E231B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 22:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1DB28CF56;
	Wed, 12 Nov 2025 22:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OpM7dkA7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48227E1D7;
	Wed, 12 Nov 2025 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762985228; cv=none; b=afGslvTSgTM79/fJZx+D2uOD909UC4XQYvxncXKies0Qc8Y1badMYQmrtSmxxBz97+jXfpQwxYvkpSMcfYKeFK7xN/0h1c4LUuRO9nCX3hXPTQeaGiD45f6AkCimoUpbDK2LDllQNfnbtq7QyVrY1+qi0WaaZI78Z9QutUB7C2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762985228; c=relaxed/simple;
	bh=NWNQWQtgXB9lxG6Z3RvO1fP1+VWNeupgLceuYxPJYoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Y11F9gaNxDGRJOQDBfEHmRuahuTPNcZxbgckbwfdOjvbP9vFxTSMxyh4Sg8J5KX7CgMJbaL0NZ9XxeK2WAK8uARzmGaAa5b6Gt6i1JIO8GgI4G2N+pArm+JgPeGuAfdfsxp4/g1jE8a1dlP6rpgrdZrpaAP0gahxqnyP0ZjScrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OpM7dkA7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACLfvWU2822525;
	Wed, 12 Nov 2025 17:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=p3dYgZtyFgq3UP4PJjCI8l8uT2E
	rSdGDa8/dxkqVwpE=; b=OpM7dkA70d3wrXShTxiU+5gFcuiFu1Mvehx4DT3KR5b
	JwdNxMU5tzoZRxEIwWadF1ypBS7lEGSrlM89KXa4SA7Olehg6nafCMeEr1WSkJVO
	VnngNLyu80u5GWCj8+fq8OCoUsESHNjSeRCqUrtdcl7EIBOO1voygHUpXSIdJevP
	Bqvql9vW6fY+EGL5Buve7828JmsgI5ZlZ1YQJlwaQanXs6WKe/JVyS5YEN/ejSS/
	0ZSZCFAqKHDcJk9NmRMNJnkd2Uh56nf9a7wjOGXi6pvfF4mGOX3DFJfus3c8sWEw
	maM2uQ/X4JR6TKJkE7pFPzVGMiaQut1KMu+CGwneUyw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4acpk2kxkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 17:06:56 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5ACM6tVP029738
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Nov 2025 17:06:55 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 12 Nov 2025 17:06:55 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 12 Nov 2025 17:06:55 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 12 Nov 2025 17:06:55 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5ACM6jSq001880;
	Wed, 12 Nov 2025 17:06:47 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Wed, 12 Nov 2025 23:06:38 +0100
Subject: [PATCH v2] iio: accel: Change adxl345 depend to negate adxl35x
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-adxl345-allow-adxl34x-mod-v2-1-5b1561eae5a0@analog.com>
X-B4-Tracking: v=1; b=H4sIAO0EFWkC/43NQQ6CMBAF0KuQWTuGAYrgynsYFu20QpNCSWsQQ
 7i7lXgAl+8n//8NognWRLhmGwSz2Gj9lFCcMuBBTr1Bq5OhyAtBeUko9erKSqB0zr9+WnH0Ghs
 uFRErUXENqT8H87DrsX3vkgcbnz68j6uFvuk/qwshIetaXKpWyablm5yk8/2Z/Qjdvu8fmNrAG
 8MAAAA=
X-Change-ID: 20251031-adxl345-allow-adxl34x-mod-8c3b11cb54c6
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Andy
 Shevchenko" <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gastmaier@gmail.com>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762985205; l=2855;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=NWNQWQtgXB9lxG6Z3RvO1fP1+VWNeupgLceuYxPJYoY=;
 b=iwA6ZQ8hNbOvjo2wvoTVgEREQYY2kjehG6fD7z6+9dNYQSvftlQrVczEBsrJKkyqFZhYo6K5V
 uW6x9qosEppDW1q4HjuNoERePzd78t2JL221p4101SpoFgMJnEF4RrK
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=d8D4CBjE c=1 sm=1 tr=0 ts=69150501 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=mWDnpkxqepvMiBNsm70A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: jFNvueJ5ppIMI9ZCVV6RFPxBg6yUEMGG
X-Proofpoint-ORIG-GUID: jFNvueJ5ppIMI9ZCVV6RFPxBg6yUEMGG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE3OCBTYWx0ZWRfX98L1ZnU4TWQk
 6FQSJy2r+vLIRbxGYJ7fWYDjr/FuRaKsLois2ZJlDaKkMSi5VtvZKAJatKQXlKgu7fSQZSFmYqk
 LbFmwVFwPV2XibfZEatYBZg6MDPN6xBulAk+95YzA7T0RxVEtPi9+r9QswO9GPNkh0P7T5H7h1Z
 8EDX00ilUY6zJWbqt4A9MLuD4SrmCr0nb0wuR5bq32Xm2YnoCERxdJna7j2Uum0yJBK41wW+1FD
 Y0yiNsKpDPMTjnwzvGBC1HeTqKcYe4r833QmzRjONhRwvXh1x2nmEMy1zICT88/LWgAAfaTRs9u
 yc6nGNdSjFpAgORFulnp/3jMNxCV7clkf3/1FZrFlKHeBPqAwO1Aq7icLO9bgBpeOMnaS6r7HTw
 OSk0eVoj02ekWy632RqfF60M1YA3iQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120178

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
Changes in v2:
- Added warning to Kconfig for users to not add both to the kernel.
  A similar patch will be sent to the input subsystem.
- Link to v1: https://lore.kernel.org/r/20251031-adxl345-allow-adxl34x-mod-v1-1-cd65749ba89c@analog.com
---
 drivers/iio/accel/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 76911278fb217..3d3f8d8673dde 100644
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
@@ -74,11 +74,12 @@ config ADXL345_I2C
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called adxl345_i2c and you will also get adxl345_core
-	  for the core module.
+	  for the core module. INPUT_ADXL34X share compatibles with this
+	  driver, do not add both modules to the kernel.
 
 config ADXL345_SPI
 	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer SPI Driver"
-	depends on INPUT_ADXL34X=n
+	depends on !INPUT_ADXL34X
 	depends on SPI
 	select ADXL345
 	select REGMAP_SPI
@@ -88,7 +89,8 @@ config ADXL345_SPI
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called adxl345_spi and you will also get adxl345_core
-	  for the core module.
+	  for the core module. INPUT_ADXL34X share compatibles with this
+	  driver, do not add both modules to the kernel.
 
 config ADXL355
 	tristate

---
base-commit: 70437bbd7529e9860fb7f0c92a89e0e6abaa994e
change-id: 20251031-adxl345-allow-adxl34x-mod-8c3b11cb54c6

Best regards,
-- 
Jorge Marques <jorge.marques@analog.com>


