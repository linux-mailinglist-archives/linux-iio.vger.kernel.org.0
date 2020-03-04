Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCA51791C2
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 14:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgCDNwu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 08:52:50 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:33658 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728767AbgCDNwu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 08:52:50 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024Do7Q2013346;
        Wed, 4 Mar 2020 08:52:48 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ygm52bar4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 08:52:48 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 024DqkLe022266
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 4 Mar 2020 08:52:47 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 05:52:45 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 4 Mar 2020 05:52:45 -0800
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 024Dqg9q005240;
        Wed, 4 Mar 2020 08:52:43 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: dac: Kconfig: sort symbols alphabetically
Date:   Wed, 4 Mar 2020 15:55:44 +0200
Message-ID: <20200304135544.2538-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040106
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

While adding a new device, I noticed these aren't sorted alphabetically [as
in the Makefile], which messed my head-up.
This change sorts the devices alphabetically in the drivers/iio/dac/Kconfig
file as well.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/dac/Kconfig | 62 ++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 63916a6142ec..93744011b63f 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -121,27 +121,6 @@ config AD5624R_SPI
 	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
 	  AD5664R converters (DAC). This driver uses the common SPI interface.
 
-config LTC1660
-	tristate "Linear Technology LTC1660/LTC1665 DAC SPI driver"
-	depends on SPI
-	help
-	  Say yes here to build support for Linear Technology
-	  LTC1660 and LTC1665 Digital to Analog Converters.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ltc1660.
-
-config LTC2632
-	tristate "Linear Technology LTC2632-12/10/8 and LTC2636-12/10/8 DAC spi driver"
-	depends on SPI
-	help
-	  Say yes here to build support for Linear Technology
-	  LTC2632-12, LTC2632-10, LTC2632-8, LTC2636-12, LTC2636-10 and
-	  LTC2636-8 converters (DAC).
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ltc2632.
-
 config AD5686
 	tristate
 
@@ -240,16 +219,6 @@ config AD7303
 	  To compile this driver as module choose M here: the module will be called
 	  ad7303.
 
-config CIO_DAC
-	tristate "Measurement Computing CIO-DAC IIO driver"
-	depends on X86 && (ISA_BUS || PC104)
-	select ISA_BUS_API
-	help
-	  Say yes here to build support for the Measurement Computing CIO-DAC
-	  analog output device family (CIO-DAC16, CIO-DAC08, PC104-DAC06). The
-	  base port addresses for the devices may be configured via the base
-	  array module parameter.
-
 config AD8801
 	tristate "Analog Devices AD8801/AD8803 DAC driver"
 	depends on SPI_MASTER
@@ -260,6 +229,16 @@ config AD8801
 	  To compile this driver as a module choose M here: the module will be called
 	  ad8801.
 
+config CIO_DAC
+	tristate "Measurement Computing CIO-DAC IIO driver"
+	depends on X86 && (ISA_BUS || PC104)
+	select ISA_BUS_API
+	help
+	  Say yes here to build support for the Measurement Computing CIO-DAC
+	  analog output device family (CIO-DAC16, CIO-DAC08, PC104-DAC06). The
+	  base port addresses for the devices may be configured via the base
+	  array module parameter.
+
 config DPOT_DAC
 	tristate "DAC emulation using a DPOT"
 	depends on OF
@@ -289,6 +268,27 @@ config LPC18XX_DAC
 	  To compile this driver as a module, choose M here: the module will be
 	  called lpc18xx_dac.
 
+config LTC1660
+	tristate "Linear Technology LTC1660/LTC1665 DAC SPI driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Linear Technology
+	  LTC1660 and LTC1665 Digital to Analog Converters.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ltc1660.
+
+config LTC2632
+	tristate "Linear Technology LTC2632-12/10/8 and LTC2636-12/10/8 DAC spi driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Linear Technology
+	  LTC2632-12, LTC2632-10, LTC2632-8, LTC2636-12, LTC2636-10 and
+	  LTC2636-8 converters (DAC).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ltc2632.
+
 config M62332
 	tristate "Mitsubishi M62332 DAC driver"
 	depends on I2C
-- 
2.20.1

