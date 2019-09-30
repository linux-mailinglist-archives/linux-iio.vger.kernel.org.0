Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFB0C1F5A
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2019 12:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfI3KnP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Sep 2019 06:43:15 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7122 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730345AbfI3KnP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Sep 2019 06:43:15 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8UAXk6u008331;
        Mon, 30 Sep 2019 06:42:39 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2056.outbound.protection.outlook.com [104.47.44.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2va1c8yj69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 30 Sep 2019 06:42:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqSHqIEcGNLEFo47E7otxQWwJaRT31TYjamYmAThdGdvsjLuOZkMx1wJfHaWomwoOSFoYkEKabYMFzWzXl90enSV7Tje6IsK/oJ4f0KJb1KtwbAbfmW3eokb35sXa/50eekc8SjvrUrLJ6g2FObU/u/H6EV+GhXT+JUtXwTrpX/oZXL2quNVqbkp7mmSJWZL2im08numgvltWU1O481q1Q0SENJPtCODq3UzCO7yh7u2a0FS9JJjDIe0uNvXPCLacjYLHMOJKROhyhWiVkDaf4zA37cNQmYALakO5pttVYC2i9dyNAvZY28LAAOdVFOPmWG7iktgw6vD0ik+fdRfMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1p4mJCrMO6y31CB+sog5X6Z9dtb1SRYUcW5FmAwFko=;
 b=nfzDyjKITsCaDe5lV3P2jkg3Y8AqtgpyXKFrYATfb4sc4et/5QgoFyh8uGMqiRIUlJEykg7P4hi+cx8Zw6nu8qcLCD+/3BiGOkoMfaDF0BS49sRFrRrgZTNZVxT3N8zRDjXTCqWT0CQsMeykXinWJpML7kykD1OMw9roQ4MvuEmdtlH5BgkDtRY1i7jRvzym0OEYZvDVPDu/RZLVGhMwdORoQPI1IRh04BcfusroFpp6NUAAFJmgXnMfpzTJe7xFU2z/4KVgKxoxYLyazsCjlFTZ5/kJVIG1RiikD3FfOmlDyYxh5KEmKoycsDPffXfKFH5dh9dZvY8IY3ARY8WKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1p4mJCrMO6y31CB+sog5X6Z9dtb1SRYUcW5FmAwFko=;
 b=PxZhFvMb7yQR1opNYeAlrh+fkMaQN+7AqW6WH3x6O5pYradO6p3gaD+Mtgzmnd+SJcWm06z2yCRDRxV+eYaUgCCl7CR6GuDucSSOzF0V+1iu+LGWmO0mbsEzsrLgHHFGf32ybHgZ+Dw7Z0reKs2AOcMRAGUOt8W/AiSTMgnrulU=
Received: from BN8PR03CA0033.namprd03.prod.outlook.com (2603:10b6:408:94::46)
 by DM6PR03MB3546.namprd03.prod.outlook.com (2603:10b6:5:b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Mon, 30 Sep
 2019 10:42:34 +0000
Received: from BL2NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BN8PR03CA0033.outlook.office365.com
 (2603:10b6:408:94::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.19 via Frontend
 Transport; Mon, 30 Sep 2019 10:42:34 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT052.mail.protection.outlook.com (10.152.77.0) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2305.20
 via Frontend Transport; Mon, 30 Sep 2019 10:42:34 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8UAgSYh031419
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 30 Sep 2019 03:42:28 -0700
Received: from nsa.sphairon.box (10.44.3.90) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 30 Sep
 2019 06:42:29 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
Subject: [RESEND PATCH v2 1/2] iio: temperature: Add support for LTC2983
Date:   Mon, 30 Sep 2019 12:42:46 +0200
Message-ID: <20190930104247.21519-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.44.3.90]
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(478600001)(6116002)(70206006)(2870700001)(106002)(54906003)(316002)(2906002)(3846002)(50226002)(50466002)(8676002)(47776003)(246002)(110136005)(45776006)(70586007)(8936002)(2616005)(126002)(26005)(186003)(16526019)(966005)(23676004)(486006)(476003)(336012)(53416004)(4326008)(5820100001)(86362001)(36756003)(6306002)(30864003)(1076003)(356004)(5660300002)(7636002)(7736002)(14444005)(305945005)(6666004)(426003)(60764002)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3546;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3e29a2e-028c-4528-f266-08d74592e767
X-MS-TrafficTypeDiagnostic: DM6PR03MB3546:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM6PR03MB35461AB162F1AC5ABD9AF31999820@DM6PR03MB3546.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01762B0D64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0B/ISYXhS9i6JfU8pqJ90fc8jPjgXURqKxEFWo8R5W6qb45hmjowLty3wpgLBV9nIzLHuZDxA37ayIcNJAf1TGKXSHhRbSrPo0mTINEOZ4mgXh07TmGiHMjickDyBppDiSruFrALk4DdqbJw6EFzqNmjjmrQGdoOFYnwxTHas8rdUHG8BCT27WkutjPj2a3L1gV8P3hD9djs0XOmDa+T4Rf/zWzairiNI0OLBw+S3eOLNxLHFVYtY1o/g8bPAjKQLjalhNdu+U41V6+FidFiLLpGyZmUFX1Wl8AcA7Be4NDx8M3MVODCqPjcfHZg70gyBCumDr+H/l46uU3odYCqSpa3PS6as9v/yJxFqveYcxKXRYr+cOj3Lkzrejhhfd11dPj0nmzD2+GiE4zUQaEsrGePIBE2fgJsXwt0JUIudFVgEDuNizMy05MUsORLkjVc2Sefyvo+JWU6mKQrS27HPQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2019 10:42:34.5615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e29a2e-028c-4528-f266-08d74592e767
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3546
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-30_07:2019-09-25,2019-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909300115
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The LTC2983 is a Multi-Sensor High Accuracy Digital Temperature
Measurement System. It measures a wide variety of temperature sensors and
digitally outputs the result, in °C or °F, with 0.1°C accuracy and
0.001°C resolution. It can measure the temperature of all standard
thermocouples (type B,E,J,K,N,S,R,T), standard 2-,3-,4-wire RTDs,
thermistors and diodes.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Changes in v2:
 * Added some needed blank lines (for readability);
 * Allocate iio_chan in the setup() function;
 * Rename reset to sleep;
 * Remove unneeded dev_dbg calls;
 * Remove unneeded line wrapping;
 * Remove unneeded comments;
 * Remove extend_names. Use the standard ABI;
 * Adapt the scales to report in millivolt and milli degrees;
 * Adapt the of_property readings to the renaming of the properties;
 * For custom thermistors, excitation-current cannot be set to Auto range.

 MAINTAINERS                       |    7 +
 drivers/iio/temperature/Kconfig   |   10 +
 drivers/iio/temperature/Makefile  |    1 +
 drivers/iio/temperature/ltc2983.c | 1436 +++++++++++++++++++++++++++++
 4 files changed, 1454 insertions(+)
 create mode 100644 drivers/iio/temperature/ltc2983.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f0c03740b9fb..14a256e785ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9491,6 +9491,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/dac/ltc1660.txt
 F:	drivers/iio/dac/ltc1660.c
 
+LTC2983 IIO TEMPERATURE DRIVER
+M:	Nuno Sá <nuno.sa@analog.com>
+W:	http://ez.analog.com/community/linux-device-drivers
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/temperature/ltc2983.c
+
 LTC4261 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 737faa0901fe..04b5a67b593c 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -4,6 +4,16 @@
 #
 menu "Temperature sensors"
 
+config LTC2983
+	tristate "Analog Devices Multi-Sensor Digital Temperature Measurement System"
+	depends on SPI
+	help
+	  Say yes here to build support for the LTC2983 Multi-Sensor
+	  high accuracy digital temperature measurement system.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ltc2983.
+
 config MAXIM_THERMOCOUPLE
 	tristate "Maxim thermocouple sensors"
 	depends on SPI
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index baca4776ca0d..d6b850b0cf63 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -3,6 +3,7 @@
 # Makefile for industrial I/O temperature drivers
 #
 
+obj-$(CONFIG_LTC2983) += ltc2983.o
 obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
 obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
 obj-$(CONFIG_MAX31856) += max31856.o
diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
new file mode 100644
index 000000000000..7c159da9f183
--- /dev/null
+++ b/drivers/iio/temperature/ltc2983.c
@@ -0,0 +1,1436 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices LTC2983 Multi-Sensor Digital Temperature Measurement System
+ * driver
+ *
+ * Copyright 2019 Analog Devices Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+/* register map */
+#define LTC2983_STATUS_REG			0x0000
+#define LTC2983_TEMP_RES_START_REG		0x0010
+#define LTC2983_TEMP_RES_END_REG		0x005F
+#define LTC2983_GLOBAL_CONFIG_REG		0x00F0
+#define LTC2983_MULT_CHANNEL_START_REG		0x00F4
+#define LTC2983_MULT_CHANNEL_END_REG		0x00F7
+#define LTC2983_MUX_CONFIG_REG			0x00FF
+#define LTC2983_CHAN_ASSIGN_START_REG		0x0200
+#define LTC2983_CHAN_ASSIGN_END_REG		0x024F
+#define LTC2983_CUST_SENS_TBL_START_REG		0x0250
+#define LTC2983_CUST_SENS_TBL_END_REG		0x03CF
+
+#define LTC2983_DIFFERENTIAL_CHAN_MIN		2
+#define LTC2983_MAX_CHANNELS_NR			20
+#define LTC2983_MIN_CHANNELS_NR			1
+#define LTC2983_SLEEP				0x97
+#define LTC2983_CUSTOM_STEINHART_SIZE		24
+#define LTC2983_CUSTOM_SENSOR_ENTRY_SZ		6
+#define LTC2983_CUSTOM_STEINHART_ENTRY_SZ	4
+
+#define LTC2983_CHAN_START_ADDR(chan) \
+			(((chan - 1) * 4) + LTC2983_CHAN_ASSIGN_START_REG)
+#define LTC2983_CHAN_RES_ADDR(chan) \
+			(((chan - 1) * 4) + LTC2983_TEMP_RES_START_REG)
+#define LTC2983_THERMOCOUPLE_DIFF_MASK		BIT(3)
+#define LTC2983_THERMISTOR_DIFF_MASK		BIT(2)
+#define LTC2983_DIODE_DIFF_MASK			BIT(2)
+#define LTC2983_RTD_4_WIRE_MASK			BIT(3)
+#define LTC2983_RTD_ROTATION_MASK		BIT(1)
+#define LTC2983_RTD_KELVIN_R_SENSE_MASK		GENMASK(3, 2)
+
+#define LTC2983_COMMON_HARD_FAULT_MASK	GENMASK(31, 30)
+#define LTC2983_COMMON_SOFT_FAULT_MASK	GENMASK(27, 25)
+
+#define	LTC2983_STATUS_START_MASK	BIT(7)
+#define	LTC2983_STATUS_START(x)		FIELD_PREP(LTC2983_STATUS_START_MASK, x)
+
+#define	LTC2983_STATUS_CHAN_SEL_MASK	GENMASK(4, 0)
+#define	LTC2983_STATUS_CHAN_SEL(x) \
+				FIELD_PREP(LTC2983_STATUS_CHAN_SEL_MASK, x)
+
+#define LTC2983_TEMP_UNITS_MASK		BIT(2)
+#define LTC2983_TEMP_UNITS(x)		FIELD_PREP(LTC2983_TEMP_UNITS_MASK, x)
+
+#define LTC2983_NOTCH_FREQ_MASK		GENMASK(1, 0)
+#define LTC2983_NOTCH_FREQ(x)		FIELD_PREP(LTC2983_NOTCH_FREQ_MASK, x)
+
+#define LTC2983_RES_VALID_MASK		BIT(24)
+#define LTC2983_DATA_MASK		GENMASK(23, 0)
+#define LTC2983_DATA_SIGN_BIT		23
+
+#define LTC2983_CHAN_TYPE_MASK		GENMASK(31, 27)
+#define LTC2983_CHAN_TYPE(x)		FIELD_PREP(LTC2983_CHAN_TYPE_MASK, x)
+
+/* cold junction for thermocouples and rsense for rtd's and thermistor's */
+#define LTC2983_CHAN_ASSIGN_MASK	GENMASK(26, 22)
+#define LTC2983_CHAN_ASSIGN(x)		FIELD_PREP(LTC2983_CHAN_ASSIGN_MASK, x)
+
+#define LTC2983_CUSTOM_LEN_MASK		GENMASK(5, 0)
+#define LTC2983_CUSTOM_LEN(x)		FIELD_PREP(LTC2983_CUSTOM_LEN_MASK, x)
+
+#define LTC2983_CUSTOM_ADDR_MASK	GENMASK(11, 6)
+#define LTC2983_CUSTOM_ADDR(x)		FIELD_PREP(LTC2983_CUSTOM_ADDR_MASK, x)
+
+#define LTC2983_THERMOCOUPLE_CFG_MASK	GENMASK(21, 18)
+#define LTC2983_THERMOCOUPLE_CFG(x) \
+				FIELD_PREP(LTC2983_THERMOCOUPLE_CFG_MASK, x)
+#define LTC2983_THERMOCOUPLE_HARD_FAULT_MASK	GENMASK(31, 29)
+#define LTC2983_THERMOCOUPLE_SOFT_FAULT_MASK	GENMASK(28, 25)
+
+#define LTC2983_RTD_CFG_MASK		GENMASK(21, 18)
+#define LTC2983_RTD_CFG(x)		FIELD_PREP(LTC2983_RTD_CFG_MASK, x)
+#define LTC2983_RTD_EXC_CURRENT_MASK	GENMASK(17, 14)
+#define LTC2983_RTD_EXC_CURRENT(x) \
+				FIELD_PREP(LTC2983_RTD_EXC_CURRENT_MASK, x)
+#define LTC2983_RTD_CURVE_MASK		GENMASK(13, 12)
+#define LTC2983_RTD_CURVE(x)		FIELD_PREP(LTC2983_RTD_CURVE_MASK, x)
+
+#define LTC2983_THERMISTOR_CFG_MASK	GENMASK(21, 19)
+#define LTC2983_THERMISTOR_CFG(x) \
+				FIELD_PREP(LTC2983_THERMISTOR_CFG_MASK, x)
+#define LTC2983_THERMISTOR_EXC_CURRENT_MASK	GENMASK(18, 15)
+#define LTC2983_THERMISTOR_EXC_CURRENT(x) \
+			FIELD_PREP(LTC2983_THERMISTOR_EXC_CURRENT_MASK, x)
+
+#define LTC2983_DIODE_CFG_MASK		GENMASK(26, 24)
+#define LTC2983_DIODE_CFG(x)		FIELD_PREP(LTC2983_DIODE_CFG_MASK, x)
+#define LTC2983_DIODE_EXC_CURRENT_MASK	GENMASK(23, 22)
+#define LTC2983_DIODE_EXC_CURRENT(x) \
+				FIELD_PREP(LTC2983_DIODE_EXC_CURRENT_MASK, x)
+#define LTC2983_DIODE_IDEAL_FACTOR_MASK	GENMASK(21, 0)
+#define LTC2983_DIODE_IDEAL_FACTOR(x) \
+				FIELD_PREP(LTC2983_DIODE_IDEAL_FACTOR_MASK, x)
+
+#define LTC2983_R_SENSE_VAL_MASK	GENMASK(26, 0)
+#define LTC2983_R_SENSE_VAL(x)		FIELD_PREP(LTC2983_R_SENSE_VAL_MASK, x)
+
+#define LTC2983_ADC_SINGLE_ENDED_MASK	BIT(26)
+#define LTC2983_ADC_SINGLE_ENDED(x) \
+				FIELD_PREP(LTC2983_ADC_SINGLE_ENDED_MASK, x)
+
+enum {
+	LTC2983_SENSOR_THERMOCOUPLE = 1,
+	LTC2983_SENSOR_THERMOCOUPLE_CUSTOM = 9,
+	LTC2983_SENSOR_RTD = 10,
+	LTC2983_SENSOR_RTD_CUSTOM = 18,
+	LTC2983_SENSOR_THERMISTOR = 19,
+	LTC2983_SENSOR_THERMISTOR_STEINHART = 26,
+	LTC2983_SENSOR_THERMISTOR_CUSTOM = 27,
+	LTC2983_SENSOR_DIODE = 28,
+	LTC2983_SENSOR_SENSE_RESISTOR = 29,
+	LTC2983_SENSOR_DIRECT_ADC = 30,
+};
+
+#define to_thermocouple(_sensor) \
+		container_of(_sensor, struct ltc2983_thermocouple, sensor)
+
+#define to_rtd(_sensor) \
+		container_of(_sensor, struct ltc2983_rtd, sensor)
+
+#define to_thermistor(_sensor) \
+		container_of(_sensor, struct ltc2983_thermistor, sensor)
+
+#define to_diode(_sensor) \
+		container_of(_sensor, struct ltc2983_diode, sensor)
+
+#define to_rsense(_sensor) \
+		container_of(_sensor, struct ltc2983_rsense, sensor)
+
+#define to_adc(_sensor) \
+		container_of(_sensor, struct ltc2983_adc, sensor)
+
+struct ltc2983_data {
+	struct regmap *regmap;
+	struct spi_device *spi;
+	struct mutex lock;
+	struct completion completion;
+	struct iio_chan_spec *iio_chan;
+	struct ltc2983_sensor **sensors;
+	u32 mux_delay_config;
+	u32 filter_notch_freq;
+	u16 custom_table_size;
+	u8 num_channels;
+	u8 iio_channels;
+	bool temp_farenheit;
+	bool sleep;
+};
+
+struct ltc2983_sensor {
+	int (*fault_handler)(const struct ltc2983_data *st, const u32 result);
+	int (*assign_chan)(struct ltc2983_data *st,
+			   const struct ltc2983_sensor *sensor);
+	/* specifies the sensor channel */
+	u32 chan;
+	/* sensor type */
+	u32 type;
+};
+
+struct ltc2983_custom_sensor {
+	/* raw table sensor data */
+	u8 *table;
+	size_t size;
+	/* address offset */
+	s8 offset;
+	bool is_steinhart;
+};
+
+struct ltc2983_thermocouple {
+	struct ltc2983_sensor sensor;
+	struct ltc2983_custom_sensor *custom;
+	u32 sensor_config;
+	u32 cold_junction_chan;
+};
+
+struct ltc2983_rtd {
+	struct ltc2983_sensor sensor;
+	struct ltc2983_custom_sensor *custom;
+	u32 sensor_config;
+	u32 r_sense_chan;
+	u32 excitation_current;
+	u32 rtd_curve;
+};
+
+struct ltc2983_thermistor {
+	struct ltc2983_sensor sensor;
+	struct ltc2983_custom_sensor *custom;
+	u32 sensor_config;
+	u32 r_sense_chan;
+	u32 excitation_current;
+};
+
+struct ltc2983_diode {
+	struct ltc2983_sensor sensor;
+	u32 sensor_config;
+	u32 excitation_current;
+	u32 ideal_factor_value;
+};
+
+struct ltc2983_rsense {
+	struct ltc2983_sensor sensor;
+	u32 r_sense_val;
+};
+
+struct ltc2983_adc {
+	struct ltc2983_sensor sensor;
+	bool single_ended;
+};
+
+/*
+ * Convert to Q format numbers. These number's are integers where
+ * the number of integer and fractional bits are specified. The resolution
+ * is given by 1/@resolution and tell us the number of fractional bits. For
+ * instance a resolution of 2^-10 means we have 10 fractional bits.
+ */
+static u32 __convert_to_raw(const u64 val, const u32 resolution)
+{
+	u64 __res = val * resolution;
+
+	/* all values are multiplied by 1000000 to remove the fraction */
+	do_div(__res, 1000000);
+
+	return __res;
+}
+
+static u32 __convert_to_raw_sign(const u64 val, const u32 resolution)
+{
+	s64 __res = -(s32)val;
+
+	__res = __convert_to_raw(__res, resolution);
+
+	return (u32)-__res;
+}
+
+static int __ltc2983_fault_handler(const struct ltc2983_data *st,
+				   const u32 result, const u32 hard_mask,
+				   const u32 soft_mask)
+{
+	const struct device *dev = &st->spi->dev;
+
+	if (result & hard_mask) {
+		dev_err(dev, "Invalid conversion: Sensor HARD fault\n");
+		return -EIO;
+	} else if (result & soft_mask) {
+		/* just print a warning */
+		dev_warn(dev, "Suspicious conversion: Sensor SOFT fault\n");
+	}
+
+	return 0;
+}
+
+static int __ltc2983_chan_assign_common(const struct ltc2983_data *st,
+					const struct ltc2983_sensor *sensor,
+					u32 chan_val)
+{
+	u32 reg = LTC2983_CHAN_START_ADDR(sensor->chan);
+	__be32 __chan_val;
+
+	chan_val |= LTC2983_CHAN_TYPE(sensor->type);
+	dev_dbg(&st->spi->dev, "Assign reg:0x%04X, val:0x%08X\n", reg,
+								chan_val);
+	__chan_val = cpu_to_be32(chan_val);
+	return regmap_bulk_write(st->regmap, reg, &__chan_val,
+				 sizeof(__chan_val));
+}
+
+static int __ltc2983_chan_custom_sensor_assign(struct ltc2983_data *st,
+					  struct ltc2983_custom_sensor *custom,
+					  u32 *chan_val)
+{
+	u32 reg;
+	u8 mult = custom->is_steinhart ? LTC2983_CUSTOM_STEINHART_ENTRY_SZ :
+		LTC2983_CUSTOM_SENSOR_ENTRY_SZ;
+	const struct device *dev = &st->spi->dev;
+	/*
+	 * custom->size holds the raw size of the table. However, when
+	 * configuring the sensor channel, we must write the number of
+	 * entries of the table minus 1. For steinhart sensors 0 is written
+	 * since the size is constant!
+	 */
+	const u8 len = custom->is_steinhart ? 0 :
+		(custom->size / LTC2983_CUSTOM_SENSOR_ENTRY_SZ) - 1;
+	/*
+	 * Check if the offset was assigned already. It should be for steinhart
+	 * sensors. When coming from sleep, it should be assigned for all.
+	 */
+	if (custom->offset < 0) {
+		/*
+		 * This needs to be done again here because, from the moment
+		 * when this test was done (successfully) for this custom
+		 * sensor, a steinhart sensor might have been added changing
+		 * custom_table_size...
+		 */
+		if (st->custom_table_size + custom->size >
+		    (LTC2983_CUST_SENS_TBL_END_REG -
+		     LTC2983_CUST_SENS_TBL_START_REG) + 1) {
+			dev_err(dev,
+				"Not space left(%d) for new custom sensor(%zu)",
+							st->custom_table_size,
+							custom->size);
+			return -EINVAL;
+		}
+
+		custom->offset = st->custom_table_size /
+					LTC2983_CUSTOM_SENSOR_ENTRY_SZ;
+		st->custom_table_size += custom->size;
+	}
+
+	reg = (custom->offset * mult) + LTC2983_CUST_SENS_TBL_START_REG;
+
+	*chan_val |= LTC2983_CUSTOM_LEN(len);
+	*chan_val |= LTC2983_CUSTOM_ADDR(custom->offset);
+	dev_dbg(dev, "Assign custom sensor, reg:0x%04X, off:%d, sz:%zu",
+							reg, custom->offset,
+							custom->size);
+	/* write custom sensor table */
+	return regmap_bulk_write(st->regmap, reg, custom->table, custom->size);
+}
+
+static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
+						struct ltc2983_data *st,
+						const struct device_node *np,
+						const bool is_steinhart,
+						const u32 resolution,
+						const bool has_signed)
+{
+	struct ltc2983_custom_sensor *new_custom;
+	u8 index, n_entries, tbl = 0;
+	struct device *dev = &st->spi->dev;
+	/*
+	 * For custom steinhart, the full u32 is taken. For all the others
+	 * the MSB is discarded.
+	 */
+	const u8 n_size = (is_steinhart == true) ? 4 : 3;
+
+	n_entries = of_property_count_elems_of_size(np, "adi,custom-sensor",
+						sizeof(u64));
+	/* n_entries must be an even number */
+	if (!n_entries || (n_entries % 2) != 0) {
+		dev_err(dev, "Number of entries either 0 or not even\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	new_custom = devm_kzalloc(dev, sizeof(*new_custom), GFP_KERNEL);
+	if (!new_custom)
+		return ERR_PTR(-ENOMEM);
+
+	new_custom->size = n_entries * n_size;
+	/* check Steinhart size */
+	if (is_steinhart && new_custom->size != LTC2983_CUSTOM_STEINHART_SIZE) {
+		dev_err(dev, "Steinhart sensors size(%zu) must be 24",
+							new_custom->size);
+		return ERR_PTR(-EINVAL);
+	}
+	/* Check space on the table. */
+	if (st->custom_table_size + new_custom->size >
+	    (LTC2983_CUST_SENS_TBL_END_REG -
+	     LTC2983_CUST_SENS_TBL_START_REG) + 1) {
+		dev_err(dev, "No space left(%d) for new custom sensor(%zu)",
+				st->custom_table_size, new_custom->size);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* allocate the table */
+	new_custom->table = devm_kzalloc(dev, new_custom->size, GFP_KERNEL);
+	if (!new_custom->table)
+		return ERR_PTR(-ENOMEM);
+
+	for (index = 0; index < n_entries; index++) {
+		u64 temp = 0, j;
+
+		of_property_read_u64_index(np, "adi,custom-sensor", index,
+					   &temp);
+		/*
+		 * Steinhart sensors are configured with raw values in the
+		 * devicetree. For the other sensors we must convert the
+		 * value to raw. The odd index's correspond to temperarures
+		 * and always have 1/1024 of resolution. Temperatures also
+		 * come in kelvin, so signed values is not possible
+		 */
+		if (!is_steinhart) {
+			if ((index % 2) != 0)
+				temp = __convert_to_raw(temp, 1024);
+			else if (has_signed && (s64)temp < 0)
+				temp = __convert_to_raw_sign(temp, resolution);
+			else
+				temp = __convert_to_raw(temp, resolution);
+		}
+
+		for (j = 0; j < n_size; j++)
+			new_custom->table[tbl++] =
+				temp >> (8 * (n_size - j - 1));
+	}
+
+	new_custom->is_steinhart = is_steinhart;
+	/*
+	 * This is done to first add all the steinhart sensors to the table,
+	 * in order to maximize the table usage. If we mix adding steinhart
+	 * with the other sensors, we might have to do some roundup to make
+	 * sure that sensor_addr - 0x250(start address) is a multiple of 4
+	 * (for steinhart), and a multiple of 6 for all the other sensors.
+	 * Since we have const 24 bytes for steinhart sensors and 24 is
+	 * also a multiple of 6, we guarantee that the first non-steinhart
+	 * sensor will sit in a correct address without the need of filling
+	 * addresses.
+	 */
+	if (is_steinhart) {
+		new_custom->offset = st->custom_table_size /
+					LTC2983_CUSTOM_STEINHART_ENTRY_SZ;
+		st->custom_table_size += new_custom->size;
+	} else {
+		/* mark as unset. This is checked later on the assign phase */
+		new_custom->offset = -1;
+	}
+
+	return new_custom;
+}
+
+static int ltc2983_thermocouple_fault_handler(const struct ltc2983_data *st,
+					      const u32 result)
+{
+	return __ltc2983_fault_handler(st, result,
+				       LTC2983_THERMOCOUPLE_HARD_FAULT_MASK,
+				       LTC2983_THERMOCOUPLE_SOFT_FAULT_MASK);
+}
+
+static int ltc2983_common_fault_handler(const struct ltc2983_data *st,
+					const u32 result)
+{
+	return __ltc2983_fault_handler(st, result,
+				       LTC2983_COMMON_HARD_FAULT_MASK,
+				       LTC2983_COMMON_SOFT_FAULT_MASK);
+}
+
+static int ltc2983_thermocouple_assign_chan(struct ltc2983_data *st,
+				const struct ltc2983_sensor *sensor)
+{
+	struct ltc2983_thermocouple *thermo = to_thermocouple(sensor);
+	u32 chan_val;
+
+	chan_val = LTC2983_CHAN_ASSIGN(thermo->cold_junction_chan);
+	chan_val |= LTC2983_THERMOCOUPLE_CFG(thermo->sensor_config);
+
+	if (thermo->custom) {
+		int ret;
+
+		ret = __ltc2983_chan_custom_sensor_assign(st, thermo->custom,
+							  &chan_val);
+		if (ret)
+			return ret;
+	}
+	return __ltc2983_chan_assign_common(st, sensor, chan_val);
+}
+
+static int ltc2983_rtd_assign_chan(struct ltc2983_data *st,
+				   const struct ltc2983_sensor *sensor)
+{
+	struct ltc2983_rtd *rtd = to_rtd(sensor);
+	u32 chan_val;
+
+	chan_val = LTC2983_CHAN_ASSIGN(rtd->r_sense_chan);
+	chan_val |= LTC2983_RTD_CFG(rtd->sensor_config);
+	chan_val |= LTC2983_RTD_EXC_CURRENT(rtd->excitation_current);
+	chan_val |= LTC2983_RTD_CURVE(rtd->rtd_curve);
+
+	if (rtd->custom) {
+		int ret;
+
+		ret = __ltc2983_chan_custom_sensor_assign(st, rtd->custom,
+							  &chan_val);
+		if (ret)
+			return ret;
+	}
+	return __ltc2983_chan_assign_common(st, sensor, chan_val);
+}
+
+static int ltc2983_thermistor_assign_chan(struct ltc2983_data *st,
+					  const struct ltc2983_sensor *sensor)
+{
+	struct ltc2983_thermistor *thermistor = to_thermistor(sensor);
+	u32 chan_val;
+
+	chan_val = LTC2983_CHAN_ASSIGN(thermistor->r_sense_chan);
+	chan_val |= LTC2983_THERMISTOR_CFG(thermistor->sensor_config);
+	chan_val |=
+		LTC2983_THERMISTOR_EXC_CURRENT(thermistor->excitation_current);
+
+	if (thermistor->custom) {
+		int ret;
+
+		ret = __ltc2983_chan_custom_sensor_assign(st,
+							  thermistor->custom,
+							  &chan_val);
+		if (ret)
+			return ret;
+	}
+	return __ltc2983_chan_assign_common(st, sensor, chan_val);
+}
+
+static int ltc2983_diode_assign_chan(struct ltc2983_data *st,
+				     const struct ltc2983_sensor *sensor)
+{
+	struct ltc2983_diode *diode = to_diode(sensor);
+	u32 chan_val;
+
+	chan_val = LTC2983_DIODE_CFG(diode->sensor_config);
+	chan_val |= LTC2983_DIODE_EXC_CURRENT(diode->excitation_current);
+	chan_val |= LTC2983_DIODE_IDEAL_FACTOR(diode->ideal_factor_value);
+
+	return __ltc2983_chan_assign_common(st, sensor, chan_val);
+}
+
+static int ltc2983_r_sense_assign_chan(struct ltc2983_data *st,
+				       const struct ltc2983_sensor *sensor)
+{
+	struct ltc2983_rsense *rsense = to_rsense(sensor);
+	u32 chan_val;
+
+	chan_val = LTC2983_R_SENSE_VAL(rsense->r_sense_val);
+
+	return __ltc2983_chan_assign_common(st, sensor, chan_val);
+}
+
+static int ltc2983_adc_assign_chan(struct ltc2983_data *st,
+				   const struct ltc2983_sensor *sensor)
+{
+	struct ltc2983_adc *adc = to_adc(sensor);
+	u32 chan_val;
+
+	chan_val = LTC2983_ADC_SINGLE_ENDED(adc->single_ended);
+
+	return __ltc2983_chan_assign_common(st, sensor, chan_val);
+}
+
+static struct ltc2983_sensor *ltc2983_thermocouple_new(
+					const struct device_node *child,
+					struct ltc2983_data *st,
+					const struct ltc2983_sensor *sensor)
+{
+	struct ltc2983_thermocouple *thermo;
+	struct device_node *phandle;
+
+	thermo = devm_kzalloc(&st->spi->dev, sizeof(*thermo), GFP_KERNEL);
+	if (!thermo)
+		return ERR_PTR(-ENOMEM);
+
+	of_property_read_u32(child, "adi,sensor-config",
+				 &thermo->sensor_config);
+	/* validate channel index */
+	if (!(thermo->sensor_config & LTC2983_THERMOCOUPLE_DIFF_MASK) &&
+	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
+		dev_err(&st->spi->dev,
+			"Invalid chann:%d for differential thermocouple",
+								sensor->chan);
+		return ERR_PTR(-EINVAL);
+	}
+
+	phandle = of_parse_phandle(child, "adi,cold-junction-handle", 0);
+	if (phandle) {
+		int ret;
+
+		ret = of_property_read_u32(phandle, "reg",
+					   &thermo->cold_junction_chan);
+		if (ret) {
+			/*
+			 * This would be catched later but we can just return
+			 * the error right away.
+			 */
+			dev_err(&st->spi->dev, "Property reg must be given\n");
+			of_node_put(phandle);
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	/* check custom sensor */
+	if (sensor->type == LTC2983_SENSOR_THERMOCOUPLE_CUSTOM) {
+		thermo->custom = __ltc2983_custom_sensor_new(st, child, false,
+							     16384, true);
+		if (IS_ERR(thermo->custom)) {
+			of_node_put(phandle);
+			return ERR_CAST(thermo->custom);
+		}
+	}
+
+	/* set common parameters */
+	thermo->sensor.fault_handler = ltc2983_thermocouple_fault_handler;
+	thermo->sensor.assign_chan = ltc2983_thermocouple_assign_chan;
+
+	of_node_put(phandle);
+	return &thermo->sensor;
+}
+
+static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *child,
+					  struct ltc2983_data *st,
+					  const struct ltc2983_sensor *sensor)
+{
+	struct ltc2983_rtd *rtd;
+	int ret = 0;
+	struct device *dev = &st->spi->dev;
+	struct device_node *phandle;
+	u32 excitation_current = 0;
+
+	rtd = devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
+	if (!rtd)
+		return ERR_PTR(-ENOMEM);
+
+	phandle = of_parse_phandle(child, "adi,rsense-handle", 0);
+	if (!phandle) {
+		dev_err(dev, "Property adi,rsense-handle missing or invalid");
+		return ERR_PTR(-EINVAL);
+	}
+
+	ret = of_property_read_u32(phandle, "reg", &rtd->r_sense_chan);
+	if (ret) {
+		dev_err(dev, "Property reg must be given\n");
+		goto fail;
+	}
+
+	of_property_read_u32(child, "adi,sensor-config", &rtd->sensor_config);
+	/*
+	 * rtd channel indexes are a bit more complicated to validate.
+	 * For 4wire RTD with rotation, the channel selection cannot be
+	 * >=19 since the chann + 1 is used in this configuration.
+	 * For 4wire RTDs with kelvin rsense, the rsense channel cannot be
+	 * <=1 since chanel - 1 and channel - 2 are used.
+	 */
+	if (rtd->sensor_config & LTC2983_RTD_4_WIRE_MASK) {
+		/* 4-wire */
+		u8 min = LTC2983_DIFFERENTIAL_CHAN_MIN,
+			max = LTC2983_MAX_CHANNELS_NR;
+
+		if (rtd->sensor_config & LTC2983_RTD_ROTATION_MASK)
+			max = LTC2983_MAX_CHANNELS_NR - 1;
+
+		if (((rtd->sensor_config & LTC2983_RTD_KELVIN_R_SENSE_MASK)
+		     == LTC2983_RTD_KELVIN_R_SENSE_MASK) &&
+		    (rtd->r_sense_chan <=  min)) {
+			/* kelvin rsense*/
+			dev_err(dev,
+				"Invalid rsense chann:%d to use in kelvin rsense",
+							rtd->r_sense_chan);
+
+			ret = -EINVAL;
+			goto fail;
+		}
+
+		if (sensor->chan < min || sensor->chan > max) {
+			dev_err(dev, "Invalid chann:%d for the rtd config",
+								sensor->chan);
+
+			ret = -EINVAL;
+			goto fail;
+		}
+	} else {
+		/* same as differential case */
+		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
+			dev_err(&st->spi->dev,
+				"Invalid chann:%d for RTD", sensor->chan);
+
+			ret = -EINVAL;
+			goto fail;
+		}
+	}
+
+	/* check custom sensor */
+	if (sensor->type == LTC2983_SENSOR_RTD_CUSTOM) {
+		rtd->custom = __ltc2983_custom_sensor_new(st, child, false,
+							  2048, false);
+		if (IS_ERR(rtd->custom)) {
+			of_node_put(phandle);
+			return ERR_CAST(rtd->custom);
+		}
+	}
+
+	/* set common parameters */
+	rtd->sensor.fault_handler = ltc2983_common_fault_handler;
+	rtd->sensor.assign_chan = ltc2983_rtd_assign_chan;
+
+	ret = of_property_read_u32(child, "adi,excitation-current-microamp",
+				   &excitation_current);
+	if (ret) {
+		/* default to 5uA */
+		rtd->excitation_current = 1;
+	} else {
+		switch (excitation_current) {
+		case 5:
+			rtd->excitation_current = 0x01;
+			break;
+		case 10:
+			rtd->excitation_current = 0x02;
+			break;
+		case 25:
+			rtd->excitation_current = 0x03;
+			break;
+		case 50:
+			rtd->excitation_current = 0x04;
+			break;
+		case 100:
+			rtd->excitation_current = 0x05;
+			break;
+		case 250:
+			rtd->excitation_current = 0x06;
+			break;
+		case 500:
+			rtd->excitation_current = 0x07;
+			break;
+		case 1000:
+			rtd->excitation_current = 0x08;
+			break;
+		default:
+			dev_err(&st->spi->dev,
+				"Invalid value for excitation current(%u)",
+							excitation_current);
+			ret = -EINVAL;
+			goto fail;
+		}
+	}
+
+	of_property_read_u32(child, "adi,rtd-curve", &rtd->rtd_curve);
+
+	of_node_put(phandle);
+	return &rtd->sensor;
+fail:
+	of_node_put(phandle);
+	return ERR_PTR(ret);
+}
+
+static struct ltc2983_sensor *ltc2983_thermistor_new(
+					const struct device_node *child,
+					struct ltc2983_data *st,
+					const struct ltc2983_sensor *sensor)
+{
+	struct ltc2983_thermistor *thermistor;
+	struct device *dev = &st->spi->dev;
+	struct device_node *phandle;
+	u32 excitation_current = 0;
+	int ret = 0;
+
+	thermistor = devm_kzalloc(dev, sizeof(*thermistor), GFP_KERNEL);
+	if (!thermistor)
+		return ERR_PTR(-ENOMEM);
+
+	phandle = of_parse_phandle(child, "adi,rsense-handle", 0);
+	if (!phandle) {
+		dev_err(dev, "Property adi,rsense-handle missing or invalid");
+		return ERR_PTR(-EINVAL);
+	}
+
+	ret = of_property_read_u32(phandle, "reg", &thermistor->r_sense_chan);
+	if (ret) {
+		dev_err(dev, "rsense channel must be configured...\n");
+		goto fail;
+	}
+
+	of_property_read_u32(child, "adi,sensor-config",
+			     &thermistor->sensor_config);
+	/* validate channel index */
+	if (!(thermistor->sensor_config & LTC2983_THERMISTOR_DIFF_MASK) &&
+	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
+		dev_err(&st->spi->dev,
+			"Invalid chann:%d for differential thermistor",
+								sensor->chan);
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	/* check custom sensor */
+	if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART) {
+		thermistor->custom = __ltc2983_custom_sensor_new(st, child,
+			sensor->type == LTC2983_SENSOR_THERMISTOR_STEINHART ?
+							  true : false, 64,
+							  false);
+		if (IS_ERR(thermistor->custom)) {
+			of_node_put(phandle);
+			return ERR_CAST(thermistor->custom);
+		}
+	}
+	/* set common parameters */
+	thermistor->sensor.fault_handler = ltc2983_common_fault_handler;
+	thermistor->sensor.assign_chan = ltc2983_thermistor_assign_chan;
+
+	ret = of_property_read_u32(child, "adi,excitation-current-nanoamp",
+				   &excitation_current);
+	if (ret) {
+		/* Auto range is not allowed for custom sensors */
+		if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART)
+			/* default to 1uA */
+			thermistor->excitation_current = 0x03;
+		else
+			/* default to auto-range */
+			thermistor->excitation_current = 0x0c;
+	} else {
+		switch (excitation_current) {
+		case 0:
+			/* auto range */
+			if (sensor->type >=
+			    LTC2983_SENSOR_THERMISTOR_STEINHART) {
+				dev_err(&st->spi->dev,
+					"Auto Range not allowed for custom sensors\n");
+				ret = -EINVAL;
+				goto fail;
+			}
+			thermistor->excitation_current = 0x0c;
+			break;
+		case 250:
+			thermistor->excitation_current = 0x01;
+			break;
+		case 500:
+			thermistor->excitation_current = 0x02;
+			break;
+		case 1000:
+			thermistor->excitation_current = 0x03;
+			break;
+		case 5000:
+			thermistor->excitation_current = 0x04;
+			break;
+		case 10000:
+			thermistor->excitation_current = 0x05;
+			break;
+		case 25000:
+			thermistor->excitation_current = 0x06;
+			break;
+		case 50000:
+			thermistor->excitation_current = 0x07;
+			break;
+		case 100000:
+			thermistor->excitation_current = 0x08;
+			break;
+		case 250000:
+			thermistor->excitation_current = 0x09;
+			break;
+		case 500000:
+			thermistor->excitation_current = 0x0a;
+			break;
+		case 1000000:
+			thermistor->excitation_current = 0x0b;
+			break;
+		default:
+			dev_err(&st->spi->dev,
+				"Invalid value for excitation current(%u)",
+							excitation_current);
+			ret = -EINVAL;
+			goto fail;
+		}
+	}
+
+	of_node_put(phandle);
+	return &thermistor->sensor;
+fail:
+	of_node_put(phandle);
+	return ERR_PTR(ret);
+}
+
+static struct ltc2983_sensor *ltc2983_diode_new(
+					const struct device_node *child,
+					const struct ltc2983_data *st,
+					const struct ltc2983_sensor *sensor)
+{
+	struct ltc2983_diode *diode;
+	u32 temp = 0, excitation_current = 0;
+	int ret;
+
+	diode = devm_kzalloc(&st->spi->dev, sizeof(*diode), GFP_KERNEL);
+	if (!diode)
+		return ERR_PTR(-ENOMEM);
+
+	of_property_read_u32(child, "adi,sensor-config", &diode->sensor_config);
+	/* validate channel index */
+	if (!(diode->sensor_config & LTC2983_DIODE_DIFF_MASK) &&
+	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
+		dev_err(&st->spi->dev,
+			"Invalid chann:%d for differential thermistor",
+								sensor->chan);
+		return ERR_PTR(-EINVAL);
+	}
+	/* set common parameters */
+	diode->sensor.fault_handler = ltc2983_common_fault_handler;
+	diode->sensor.assign_chan = ltc2983_diode_assign_chan;
+
+	ret = of_property_read_u32(child, "adi,excitation-current-microamp",
+				   &excitation_current);
+	if (!ret) {
+		switch (excitation_current) {
+		case 10:
+			diode->excitation_current = 0x00;
+			break;
+		case 20:
+			diode->excitation_current = 0x01;
+			break;
+		case 40:
+			diode->excitation_current = 0x02;
+			break;
+		case 80:
+			diode->excitation_current = 0x03;
+			break;
+		default:
+			dev_err(&st->spi->dev,
+				"Invalid value for excitation current(%u)",
+							excitation_current);
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	of_property_read_u32(child, "adi,ideal-factor-value", &temp);
+
+	/* 2^20 resolution */
+	diode->ideal_factor_value = __convert_to_raw(temp, 1048576);
+
+	return &diode->sensor;
+}
+
+static struct ltc2983_sensor *ltc2983_r_sense_new(struct device_node *child,
+					struct ltc2983_data *st,
+					const struct ltc2983_sensor *sensor)
+{
+	struct ltc2983_rsense *rsense;
+	int ret;
+	u64 temp;
+
+	rsense = devm_kzalloc(&st->spi->dev, sizeof(*rsense), GFP_KERNEL);
+	if (!rsense)
+		return ERR_PTR(-ENOMEM);
+
+	/* validate channel index */
+	if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
+		dev_err(&st->spi->dev, "Invalid chann:%d for r_sense",
+							sensor->chan);
+		return ERR_PTR(-EINVAL);
+	}
+	/* get raw value */
+	ret = of_property_read_u64(child, "adi,rsense-val-micro-ohms", &temp);
+	if (ret) {
+		dev_err(&st->spi->dev, "Property adi,rsense-val-micro-ohms missing\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* 2^10 resolution */
+	rsense->r_sense_val = __convert_to_raw(temp, 1024);
+
+	/* set common parameters */
+	rsense->sensor.assign_chan = ltc2983_r_sense_assign_chan;
+
+	return &rsense->sensor;
+}
+
+static struct ltc2983_sensor *ltc2983_adc_new(struct device_node *child,
+					 struct ltc2983_data *st,
+					 const struct ltc2983_sensor *sensor)
+{
+	struct ltc2983_adc *adc;
+
+	adc = devm_kzalloc(&st->spi->dev, sizeof(*adc), GFP_KERNEL);
+	if (!adc)
+		return ERR_PTR(-ENOMEM);
+
+	if (of_property_read_bool(child, "adi,single-ended"))
+		adc->single_ended = true;
+
+	if (!adc->single_ended &&
+	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
+		dev_err(&st->spi->dev, "Invalid chan:%d for differential adc\n",
+								sensor->chan);
+		return ERR_PTR(-EINVAL);
+	}
+	/* set common parameters */
+	adc->sensor.assign_chan = ltc2983_adc_assign_chan;
+	adc->sensor.fault_handler = ltc2983_common_fault_handler;
+
+	return &adc->sensor;
+}
+
+static int ltc2983_chan_read(struct ltc2983_data *st,
+			const struct ltc2983_sensor *sensor, int *val)
+{
+	u32 start_conversion = 0;
+	int ret;
+	unsigned long time;
+	__be32 temp;
+
+	/*
+	 * Do not allow channel readings if device is in sleep state.
+	 * A read/write on the spi bus would bring the device prematurely
+	 * out of sleep.
+	 */
+	if (st->sleep)
+		return -EPERM;
+
+	start_conversion = LTC2983_STATUS_START(true);
+	start_conversion |= LTC2983_STATUS_CHAN_SEL(sensor->chan);
+	dev_dbg(&st->spi->dev, "Start conversion on chan:%d, status:%02X\n",
+		sensor->chan, start_conversion);
+	/* start conversion */
+	ret = regmap_write(st->regmap, LTC2983_STATUS_REG, start_conversion);
+	if (ret)
+		return ret;
+
+	reinit_completion(&st->completion);
+	/*
+	 * wait for conversion to complete.
+	 * 300 ms should be more than enough to complete the conversion.
+	 * Depending on the sensor configuration, there are 2/3 conversions
+	 * cycles of 82ms.
+	 */
+	time = wait_for_completion_timeout(&st->completion,
+					   msecs_to_jiffies(300));
+	if (!time) {
+		dev_warn(&st->spi->dev, "Conversion timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	/* read the converted data */
+	ret = regmap_bulk_read(st->regmap, LTC2983_CHAN_RES_ADDR(sensor->chan),
+			       &temp, sizeof(temp));
+	if (ret)
+		return ret;
+
+	*val = __be32_to_cpu(temp);
+
+	if (!(LTC2983_RES_VALID_MASK & *val)) {
+		dev_err(&st->spi->dev, "Invalid conversion detected\n");
+		return -EIO;
+	}
+
+	ret = sensor->fault_handler(st, *val);
+	if (ret)
+		return ret;
+
+	*val = sign_extend32((*val) & LTC2983_DATA_MASK, LTC2983_DATA_SIGN_BIT);
+	return 0;
+}
+
+static int ltc2983_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct ltc2983_data *st = iio_priv(indio_dev);
+	int ret;
+
+	/* sanity check */
+	if (chan->address >= st->num_channels) {
+		dev_err(&st->spi->dev, "Invalid chan address:%ld",
+							chan->address);
+		return -EINVAL;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = ltc2983_chan_read(st, st->sensors[chan->address], val);
+		mutex_unlock(&st->lock);
+		return ret ?: IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_TEMP:
+			/* value in milli degrees */
+			*val = 1000;
+			/* 2^10 */
+			*val2 = 1024;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_VOLTAGE:
+			/* value in millivolt */
+			*val = 1000;
+			/* 2^21 */
+			*val2 = 2097152;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int ltc2983_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int writeval,
+			      unsigned int *readval)
+{
+	struct ltc2983_data *st = iio_priv(indio_dev);
+
+	/* check comment in ltc2983_chan_read() */
+	if (st->sleep)
+		return -EPERM;
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+	else
+		return regmap_write(st->regmap, reg, writeval);
+}
+
+static irqreturn_t ltc2983_irq_handler(int irq, void *data)
+{
+	struct ltc2983_data *st = data;
+
+	complete(&st->completion);
+	return IRQ_HANDLED;
+}
+
+#define LTC2983_CHAN(__type, index, __address) ({ \
+	struct iio_chan_spec __chan = { \
+		.type = __type, \
+		.indexed = 1, \
+		.channel = index, \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+		.address = __address, \
+	}; \
+	__chan; \
+})
+
+static int ltc2983_parse_dt(struct ltc2983_data *st)
+{
+	struct device_node *child;
+	struct device *dev = &st->spi->dev;
+	int ret = 0, chan = 0, channel_avail_mask = 0;
+
+	if (!of_property_read_bool(dev->of_node, "adi,temperature-celcius"))
+		st->temp_farenheit = true;
+
+	of_property_read_u32(dev->of_node, "adi,mux-delay-config-us",
+			     &st->mux_delay_config);
+
+	of_property_read_u32(dev->of_node, "adi,filter-notch-freq",
+			     &st->filter_notch_freq);
+
+	st->num_channels = of_get_available_child_count(dev->of_node);
+	st->sensors = devm_kcalloc(dev, st->num_channels, sizeof(*st->sensors),
+				   GFP_KERNEL);
+	if (!st->sensors)
+		return -ENOMEM;
+
+	st->iio_channels = st->num_channels;
+	for_each_available_child_of_node(dev->of_node, child) {
+		struct ltc2983_sensor sensor;
+
+		ret = of_property_read_u32(child, "reg", &sensor.chan);
+		if (ret) {
+			dev_err(dev, "reg property must given for child nodes\n");
+			return ret;
+		}
+
+		/* check if we have a valid channel */
+		if (sensor.chan < LTC2983_MIN_CHANNELS_NR ||
+		    sensor.chan > LTC2983_MAX_CHANNELS_NR) {
+			dev_err(dev,
+				"chan:%d must be from 1 to 20\n", sensor.chan);
+			return -EINVAL;
+		} else if (channel_avail_mask & BIT(sensor.chan)) {
+			dev_err(dev, "chan:%d already in use\n", sensor.chan);
+			return -EINVAL;
+		}
+
+		ret = of_property_read_u32(child, "adi,sensor-type",
+					       &sensor.type);
+		if (ret) {
+			dev_err(dev,
+				"adi,sensor-type property must given for child nodes\n");
+			return ret;
+		}
+
+		dev_dbg(dev, "Create new sensor, type %u, chann %u",
+								sensor.type,
+								sensor.chan);
+
+		if (sensor.type >= LTC2983_SENSOR_THERMOCOUPLE &&
+		    sensor.type <= LTC2983_SENSOR_THERMOCOUPLE_CUSTOM) {
+			st->sensors[chan] = ltc2983_thermocouple_new(child, st,
+								     &sensor);
+		} else if (sensor.type >= LTC2983_SENSOR_RTD &&
+			   sensor.type <= LTC2983_SENSOR_RTD_CUSTOM) {
+			st->sensors[chan] = ltc2983_rtd_new(child, st, &sensor);
+		} else if (sensor.type >= LTC2983_SENSOR_THERMISTOR &&
+			   sensor.type <= LTC2983_SENSOR_THERMISTOR_CUSTOM) {
+			st->sensors[chan] = ltc2983_thermistor_new(child, st,
+								   &sensor);
+		} else if (sensor.type == LTC2983_SENSOR_DIODE) {
+			st->sensors[chan] = ltc2983_diode_new(child, st,
+							      &sensor);
+		} else if (sensor.type == LTC2983_SENSOR_SENSE_RESISTOR) {
+			st->sensors[chan] = ltc2983_r_sense_new(child, st,
+								&sensor);
+			/* don't add rsense to iio */
+			st->iio_channels--;
+		} else if (sensor.type == LTC2983_SENSOR_DIRECT_ADC) {
+			st->sensors[chan] = ltc2983_adc_new(child, st, &sensor);
+		} else {
+			dev_err(dev, "Unknown sensor type %d\n", sensor.type);
+			return -EINVAL;
+		}
+
+		if (IS_ERR(st->sensors[chan])) {
+			dev_err(dev, "Failed to create sensor %ld",
+						PTR_ERR(st->sensors[chan]));
+			return PTR_ERR(st->sensors[chan]);
+		}
+		/* set generic sensor parameters */
+		st->sensors[chan]->chan = sensor.chan;
+		st->sensors[chan]->type = sensor.type;
+
+		channel_avail_mask |= BIT(sensor.chan);
+		chan++;
+	}
+
+	return 0;
+}
+
+static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
+{
+	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0;
+	u32 global_cfg = 0;
+	int ret;
+	unsigned long time;
+
+	/* make sure the device is up */
+	time = wait_for_completion_timeout(&st->completion,
+					    msecs_to_jiffies(250));
+
+	if (!time) {
+		dev_err(&st->spi->dev, "Device startup timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	st->iio_chan = devm_kzalloc(&st->spi->dev,
+				    st->iio_channels * sizeof(*st->iio_chan),
+				    GFP_KERNEL);
+
+	if (!st->iio_chan)
+		return -ENOMEM;
+
+	global_cfg = LTC2983_NOTCH_FREQ(st->filter_notch_freq);
+	global_cfg |= LTC2983_TEMP_UNITS(st->temp_farenheit);
+	regmap_write(st->regmap, LTC2983_GLOBAL_CONFIG_REG, global_cfg);
+	regmap_write(st->regmap, LTC2983_MUX_CONFIG_REG, st->mux_delay_config);
+
+	for (chan = 0; chan < st->num_channels; chan++) {
+		u32 chan_type = 0, *iio_chan;
+
+		ret = st->sensors[chan]->assign_chan(st, st->sensors[chan]);
+		if (ret)
+			return ret;
+		/*
+		 * The assign_iio flag is necessary for when the device is
+		 * coming out of sleep. In that case, we just need to
+		 * re-configure the device channels.
+		 * We also don't assign iio channels for rsense.
+		 */
+		if (st->sensors[chan]->type == LTC2983_SENSOR_SENSE_RESISTOR ||
+		    !assign_iio)
+			continue;
+
+		/* assign iio channel */
+		if (st->sensors[chan]->type != LTC2983_SENSOR_DIRECT_ADC) {
+			chan_type = IIO_TEMP;
+			iio_chan = &iio_chan_t;
+		} else {
+			chan_type = IIO_VOLTAGE;
+			iio_chan = &iio_chan_v;
+		}
+
+		/*
+		 * add chan as the iio .address so that, we can directly
+		 * reference the sensor given the iio_chan_spec
+		 */
+		st->iio_chan[iio_idx++] = LTC2983_CHAN(chan_type, (*iio_chan)++,
+						       chan);
+	}
+
+	return 0;
+}
+
+static const struct regmap_range ltc2983_reg_ranges[] = {
+	regmap_reg_range(LTC2983_STATUS_REG, LTC2983_STATUS_REG),
+	regmap_reg_range(LTC2983_TEMP_RES_START_REG, LTC2983_TEMP_RES_END_REG),
+	regmap_reg_range(LTC2983_GLOBAL_CONFIG_REG, LTC2983_GLOBAL_CONFIG_REG),
+	regmap_reg_range(LTC2983_MULT_CHANNEL_START_REG,
+			 LTC2983_MULT_CHANNEL_END_REG),
+	regmap_reg_range(LTC2983_MUX_CONFIG_REG, LTC2983_MUX_CONFIG_REG),
+	regmap_reg_range(LTC2983_CHAN_ASSIGN_START_REG,
+			 LTC2983_CHAN_ASSIGN_END_REG),
+	regmap_reg_range(LTC2983_CUST_SENS_TBL_START_REG,
+			 LTC2983_CUST_SENS_TBL_END_REG),
+};
+
+static const struct regmap_access_table ltc2983_reg_table = {
+	.yes_ranges = ltc2983_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ltc2983_reg_ranges),
+};
+
+/*
+ *  The reg_bits are actually 12 but the device needs the first *complete*
+ *  byte for the command (R/W).
+ */
+static const struct regmap_config ltc2983_regmap_config = {
+	.reg_bits = 24,
+	.val_bits = 8,
+	.wr_table = &ltc2983_reg_table,
+	.rd_table = &ltc2983_reg_table,
+	.read_flag_mask = GENMASK(1, 0),
+	.write_flag_mask = BIT(1),
+};
+
+static const struct  iio_info ltc2983_iio_info = {
+	.read_raw = ltc2983_read_raw,
+	.debugfs_reg_access = ltc2983_reg_access,
+};
+
+static int ltc2983_probe(struct spi_device *spi)
+{
+	struct ltc2983_data *st;
+	struct iio_dev *indio_dev;
+	const char *name = spi_get_device_id(spi)->name;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	st->regmap = devm_regmap_init_spi(spi, &ltc2983_regmap_config);
+	if (IS_ERR(st->regmap)) {
+		dev_err(&spi->dev, "Failed to initialize regmap\n");
+		return PTR_ERR(st->regmap);
+	}
+
+	mutex_init(&st->lock);
+	init_completion(&st->completion);
+	st->spi = spi;
+	spi_set_drvdata(spi, st);
+
+	ret = ltc2983_parse_dt(st);
+	if (ret)
+		return ret;
+	/*
+	 * let's request the irq now so it is used to sync the device
+	 * startup in ltc2983_setup()
+	 */
+	ret = devm_request_threaded_irq(&spi->dev, spi->irq, NULL,
+					ltc2983_irq_handler, IRQF_ONESHOT |
+					IRQF_TRIGGER_RISING, name, st);
+	if (ret) {
+		dev_err(&spi->dev, "failed to request an irq, %d", ret);
+		return ret;
+	}
+
+	ret = ltc2983_setup(st, true);
+	if (ret)
+		return ret;
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = name;
+	indio_dev->num_channels = st->iio_channels;
+	indio_dev->channels = st->iio_chan;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ltc2983_iio_info;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static int __maybe_unused ltc2983_resume(struct device *dev)
+{
+	struct ltc2983_data *st = spi_get_drvdata(to_spi_device(dev));
+	int ret;
+
+	mutex_lock(&st->lock);
+	/* dummy read to bring the device out of sleep */
+	regmap_read(st->regmap, LTC2983_STATUS_REG, &ret);
+	/* we need to re-assign the channels */
+	ret = ltc2983_setup(st, false);
+	st->sleep = false;
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int __maybe_unused ltc2983_suspend(struct device *dev)
+{
+	struct ltc2983_data *st = spi_get_drvdata(to_spi_device(dev));
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = regmap_write(st->regmap, LTC2983_STATUS_REG, LTC2983_SLEEP);
+	st->sleep = true;
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(ltc2983_pm_ops, ltc2983_suspend, ltc2983_resume);
+
+static const struct spi_device_id ltc2983_id_table[] = {
+	{ "ltc2983" },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, ltc2983_id_table);
+
+static const struct of_device_id ltc2983_of_match[] = {
+	{ .compatible = "adi,ltc2983" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ltc2983_id_table);
+
+static struct spi_driver ltc2983_driver = {
+	.driver = {
+		.name = "ltc2983",
+		.of_match_table = ltc2983_of_match,
+		.pm = &ltc2983_pm_ops,
+	},
+	.probe = ltc2983_probe,
+	.id_table = ltc2983_id_table,
+};
+
+module_spi_driver(ltc2983_driver);
+
+MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices LTC2983 SPI Temperature sensors");
+MODULE_LICENSE("GPL");
-- 
2.23.0

