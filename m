Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2E5818DEF3
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 10:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgCUJFE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 05:05:04 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:64836 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728071AbgCUJFE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 05:05:04 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02L94wMr023271;
        Sat, 21 Mar 2020 05:05:03 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywcs5re62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Mar 2020 05:05:02 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 02L950HN050563
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 21 Mar 2020 05:05:01 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 21 Mar 2020 02:05:00 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 21 Mar 2020 02:05:00 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sat, 21 Mar 2020 02:05:00 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02L94vRt009649;
        Sat, 21 Mar 2020 05:04:58 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH v2] MAINTAINERS: remove Stefan Popa's email
Date:   Sat, 21 Mar 2020 11:04:42 +0200
Message-ID: <20200321090442.11383-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200317143336.6098-1-alexandru.ardelean@analog.com>
References: <20200317143336.6098-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-21_02:2020-03-20,2020-03-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003210053
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The email is no longer active. This change removes Stefan's email from the
MAINTAINERS list and replaces it with Michael Hennerich's.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* re-send + change author @analog.com; GMail messed it up

 MAINTAINERS | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8fa40c3eb72a..72e8960c4f4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -552,7 +552,7 @@ F:	drivers/input/misc/adxl34x.c
 F:	Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
 
 ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
-M:	Stefan Popa <stefan.popa@analog.com>
+M:	Michael Hennerich <michael.hennerich@analog.com>
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/accel/adxl372.c
@@ -900,7 +900,7 @@ F:	drivers/net/ethernet/amd/xgbe/
 F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
 
 ANALOG DEVICES INC AD5686 DRIVER
-M:	Stefan Popa <stefan.popa@analog.com>
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-pm@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
@@ -908,7 +908,7 @@ F:	drivers/iio/dac/ad5686*
 F:	drivers/iio/dac/ad5696*
 
 ANALOG DEVICES INC AD5758 DRIVER
-M:	Stefan Popa <stefan.popa@analog.com>
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
@@ -924,7 +924,7 @@ F:	drivers/iio/adc/ad7091r5.c
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
 
 ANALOG DEVICES INC AD7124 DRIVER
-M:	Stefan Popa <stefan.popa@analog.com>
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
@@ -948,7 +948,7 @@ F:	drivers/iio/adc/ad7292.c
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
 
 ANALOG DEVICES INC AD7606 DRIVER
-M:	Stefan Popa <stefan.popa@analog.com>
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
 M:	Beniamin Bia <beniamin.bia@analog.com>
 L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
@@ -957,7 +957,7 @@ F:	drivers/iio/adc/ad7606.c
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
 
 ANALOG DEVICES INC AD7768-1 DRIVER
-M:	Stefan Popa <stefan.popa@analog.com>
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
@@ -1018,7 +1018,7 @@ F:	drivers/hwmon/adm1177.c
 F:	Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
 
 ANALOG DEVICES INC ADP5061 DRIVER
-M:	Stefan Popa <stefan.popa@analog.com>
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-pm@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
@@ -1078,7 +1078,6 @@ F:	drivers/dma/dma-axi-dmac.c
 ANALOG DEVICES INC IIO DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
-M:	Stefan Popa <stefan.popa@analog.com>
 W:	http://wiki.analog.com/
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
-- 
2.17.1

