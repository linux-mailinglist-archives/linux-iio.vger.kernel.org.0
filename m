Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 394327000F
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2019 14:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfGVMsQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 08:48:16 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:28696 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729740AbfGVMsP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 08:48:15 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MCSZsk011708;
        Mon, 22 Jul 2019 08:48:10 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2058.outbound.protection.outlook.com [104.47.44.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tuyv3wv1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 08:48:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzR+ypwZtVNZsGV1wkOa96rYib+cSIJwTV7/iM/JFfaip1HXpKdTdbTG6mp/S+ZMtUVW7EphcMWIt0wkXJP6c6EOAQ/T+yCza8NdN56chOsdb9Op0ZkuqEM+uCxlp/IeWvFouEtJAXAVlfnHzrJoCW2NxAckRurNjuNRGAu/ths+NwM1cFqCDtebUEyl+MXcBZeL0Iv8YxY2/D7/2/vI06rC2EyTKVpytFR6duTnlszA9m8vLGuO/MAZ5tCp7wo1EjKYVWtZ3YWvRkwUhvQe+ojIoO56FtdzjzUlO9f//HwqTTP+Ruj43ab6mNqTyQ4+aorYm6dq2NeuPgsdttfIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+MNPfHIw4Y5w7vMcBRpj44vkyRT4kcvuWAxAFNkRKY=;
 b=nfiPE/OASIfnovAPemuy7BqIzpHhgyvJee0DMDisqfbQh0J21l0EPnv+5aa8rOpPiQ3S0e8wrM7kZpDU0nu0WCMlMxujqvyq5OZj2dQmwksnPNZouP26yBP76Wh+yM+H078mLY16PzYFNv8YatftGLIvCtE4LG03alruGQb1qV1P8V9FeQ2HDUv9PHq6fvPPthRpZ+ROAFNkfOzSI9/fIYw+xJZX8O6+mwBoVypuOBn1L1fOjPJxfHGBypOTFsj4iwUbknDnmzJMLaDFvBuOjmvvMUkNKvghgoQx+ag16OzVREslsRpNa2LRGXfVOxuTgCiEz4mloeR6zmIOWDQDyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+MNPfHIw4Y5w7vMcBRpj44vkyRT4kcvuWAxAFNkRKY=;
 b=qZQeKI7GGSqwMOiz3uNLPXh4sgwv4dT/Lw6QwDdF8q3e+o/opYB1FW+IhvPPVLCNsZ88YAwLUuoJ4+5c6nyQduiT6oZQoWuPB/fnMmTNpeJqdx9upN48Tgkrvm+omoH2r5S7tmc0435NeSu2OQUprYHTkH5oIMwNbCZAXJem4A8=
Received: from MWHPR03CA0054.namprd03.prod.outlook.com (2603:10b6:301:3b::43)
 by BYAPR03MB3831.namprd03.prod.outlook.com (2603:10b6:a03:6e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.14; Mon, 22 Jul
 2019 12:48:03 +0000
Received: from SN1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by MWHPR03CA0054.outlook.office365.com
 (2603:10b6:301:3b::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.12 via Frontend
 Transport; Mon, 22 Jul 2019 12:48:02 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT047.mail.protection.outlook.com (10.152.72.201) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Mon, 22 Jul 2019 12:48:02 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x6MClxML019648
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 22 Jul 2019 05:47:59 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 22 Jul 2019 08:48:00 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 3/4][V3] iio: imu: Add support for the ADIS16460 IMU
Date:   Mon, 22 Jul 2019 15:47:46 +0300
Message-ID: <20190722124747.4792-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722124747.4792-1-alexandru.ardelean@analog.com>
References: <20190722124747.4792-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(2980300002)(199004)(189003)(7636002)(7696005)(11346002)(446003)(2201001)(426003)(1076003)(246002)(476003)(305945005)(2616005)(126002)(50466002)(6306002)(8936002)(107886003)(4326008)(336012)(8676002)(50226002)(6666004)(356004)(2906002)(48376002)(86362001)(2870700001)(5660300002)(26005)(36756003)(966005)(478600001)(106002)(76176011)(186003)(54906003)(51416003)(110136005)(14444005)(316002)(47776003)(486006)(70586007)(70206006)(30864003)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3831;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef7e2112-375a-4129-f488-08d70ea2d572
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BYAPR03MB3831;
X-MS-TrafficTypeDiagnostic: BYAPR03MB3831:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Antispam-PRVS: <BYAPR03MB3831B943DEA4484A8FC06285F9C40@BYAPR03MB3831.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 01068D0A20
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: FmHkaz9stR407r9y0k9xOjz4Eo1oqo0B3brqXBHxFwU8+LuOPNUu89p+6erCzO/y5miPY5kFm3cd6M6spk7f62KIqqN+rYzi5CvgxKVNDOG4BAYjDz5EzSoVFeuKKVc5vKZL9qZljIM5TPKwzyLVZaeA39gQPlL6sTcgpG6Ipw4cdOnBiXVdHtWTodkxXZe4N3sCe++TmszQ9bZkvi0Ail/LAjCcxolQ5uqz3BLnB9jk0y54ksRGkJZxpDYXbAi3ZR5ssBnYDhRQqQZ7sj+pRIUz8jqtr4eWdHJmb/PcqXwhQuyCSj7Z7yKwiI9dpDsDlgwGiKk+fMCojsymtzWuYx+ebwVrOdo9fsQSG/M2awJSuCVBsebSUTHOPzU3/QH4bhrAreVZ1XNH6YN5y4JvVdWL80kvNv7oK1w3Kas3AHQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2019 12:48:02.0872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7e2112-375a-4129-f488-08d70ea2d572
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3831
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907220147
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADIS16460 device is a complete inertial system that includes a triaxial
gyroscope and a triaxial accelerometer. It's more simplified design than
that of the ADIS16480, and does not offer the triaxial magnetometers &
pressure sensors. It does also have a temperature sensor (like the
ADIS16480).
Since it is part of the ADIS16XXX family, it re-uses parts of the ADIS
library.

Naturally, the register map is different and much more simplified than the
ADIS16480 subfamily, so it cannot be integrated into that driver. A major
difference is that the registers are not paged.

One thing that is particularly special about it, is that it requires a
higher delay between CS changes (i.e. when CS goes up, the spec recommends
that it be brought down after a minimum of 16 uS).
Other ADIS chips require (via spec) a minimum of 2 uS between CS changes.
The kernel's 10 uS default should be fine for those other chips; they
haven't been tested with lower CS change delays yet.

Datasheet:
  https://www.analog.com/media/en/technical-documentation/data-sheets/adis16460.pdf

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 MAINTAINERS                 |   7 +
 drivers/iio/imu/Kconfig     |  12 +
 drivers/iio/imu/Makefile    |   1 +
 drivers/iio/imu/adis16460.c | 489 ++++++++++++++++++++++++++++++++++++
 4 files changed, 509 insertions(+)
 create mode 100644 drivers/iio/imu/adis16460.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ad498428b38c..8e679504c087 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -937,6 +937,13 @@ L:	linux-iio@vger.kernel.org
 F:	include/linux/iio/imu/adis.h
 F:	drivers/iio/imu/adis.c
 
+ANALOG DEVICES INC ADIS16460 DRIVER
+M:	Dragos Bogdan <dragos.bogdan@analog.com>
+S:	Supported
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+F:	drivers/iio/imu/adis16460.c
+
 ANALOG DEVICES INC ADP5061 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
 L:	linux-pm@vger.kernel.org
diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 156630a21696..f048d0d757b1 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -16,6 +16,18 @@ config ADIS16400
 	  adis16365, adis16400 and adis16405 triaxial inertial sensors
 	  (adis16400 series also have magnetometers).
 
+config ADIS16460
+	tristate "Analog Devices ADIS16460 and similar IMU driver"
+	depends on SPI
+	select IIO_ADIS_LIB
+	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
+	help
+	  Say yes here to build support for Analog Devices ADIS16460 inertial
+	  sensor.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called adis16460.
+
 config ADIS16480
 	tristate "Analog Devices ADIS16480 and similar IMU driver"
 	depends on SPI
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index 9e452fce1aaf..4a6958865504 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -5,6 +5,7 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ADIS16400) += adis16400.o
+obj-$(CONFIG_ADIS16460) += adis16460.o
 obj-$(CONFIG_ADIS16480) += adis16480.o
 
 adis_lib-y += adis.o
diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
new file mode 100644
index 000000000000..db713cba75a2
--- /dev/null
+++ b/drivers/iio/imu/adis16460.c
@@ -0,0 +1,489 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADIS16460 IMU driver
+ *
+ * Copyright 2019 Analog Devices Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/imu/adis.h>
+
+#include <linux/debugfs.h>
+
+#define ADIS16460_REG_FLASH_CNT		0x00
+#define ADIS16460_REG_DIAG_STAT		0x02
+#define ADIS16460_REG_X_GYRO_LOW	0x04
+#define ADIS16460_REG_X_GYRO_OUT	0x06
+#define ADIS16460_REG_Y_GYRO_LOW	0x08
+#define ADIS16460_REG_Y_GYRO_OUT	0x0A
+#define ADIS16460_REG_Z_GYRO_LOW	0x0C
+#define ADIS16460_REG_Z_GYRO_OUT	0x0E
+#define ADIS16460_REG_X_ACCL_LOW	0x10
+#define ADIS16460_REG_X_ACCL_OUT	0x12
+#define ADIS16460_REG_Y_ACCL_LOW	0x14
+#define ADIS16460_REG_Y_ACCL_OUT	0x16
+#define ADIS16460_REG_Z_ACCL_LOW	0x18
+#define ADIS16460_REG_Z_ACCL_OUT	0x1A
+#define ADIS16460_REG_SMPL_CNTR		0x1C
+#define ADIS16460_REG_TEMP_OUT		0x1E
+#define ADIS16460_REG_X_DELT_ANG	0x24
+#define ADIS16460_REG_Y_DELT_ANG	0x26
+#define ADIS16460_REG_Z_DELT_ANG	0x28
+#define ADIS16460_REG_X_DELT_VEL	0x2A
+#define ADIS16460_REG_Y_DELT_VEL	0x2C
+#define ADIS16460_REG_Z_DELT_VEL	0x2E
+#define ADIS16460_REG_MSC_CTRL		0x32
+#define ADIS16460_REG_SYNC_SCAL		0x34
+#define ADIS16460_REG_DEC_RATE		0x36
+#define ADIS16460_REG_FLTR_CTRL		0x38
+#define ADIS16460_REG_GLOB_CMD		0x3E
+#define ADIS16460_REG_X_GYRO_OFF	0x40
+#define ADIS16460_REG_Y_GYRO_OFF	0x42
+#define ADIS16460_REG_Z_GYRO_OFF	0x44
+#define ADIS16460_REG_X_ACCL_OFF	0x46
+#define ADIS16460_REG_Y_ACCL_OFF	0x48
+#define ADIS16460_REG_Z_ACCL_OFF	0x4A
+#define ADIS16460_REG_LOT_ID1		0x52
+#define ADIS16460_REG_LOT_ID2		0x54
+#define ADIS16460_REG_PROD_ID		0x56
+#define ADIS16460_REG_SERIAL_NUM	0x58
+#define ADIS16460_REG_CAL_SGNTR		0x60
+#define ADIS16460_REG_CAL_CRC		0x62
+#define ADIS16460_REG_CODE_SGNTR	0x64
+#define ADIS16460_REG_CODE_CRC		0x66
+
+struct adis16460_chip_info {
+	unsigned int num_channels;
+	const struct iio_chan_spec *channels;
+	unsigned int gyro_max_val;
+	unsigned int gyro_max_scale;
+	unsigned int accel_max_val;
+	unsigned int accel_max_scale;
+};
+
+struct adis16460 {
+	const struct adis16460_chip_info *chip_info;
+	struct adis adis;
+};
+
+#ifdef CONFIG_DEBUG_FS
+
+static int adis16460_show_serial_number(void *arg, u64 *val)
+{
+	struct adis16460 *adis16460 = arg;
+	u16 serial;
+	int ret;
+
+	ret = adis_read_reg_16(&adis16460->adis, ADIS16460_REG_SERIAL_NUM,
+		&serial);
+	if (ret < 0)
+		return ret;
+
+	*val = serial;
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(adis16460_serial_number_fops,
+	adis16460_show_serial_number, NULL, "0x%.4llx\n");
+
+static int adis16460_show_product_id(void *arg, u64 *val)
+{
+	struct adis16460 *adis16460 = arg;
+	u16 prod_id;
+	int ret;
+
+	ret = adis_read_reg_16(&adis16460->adis, ADIS16460_REG_PROD_ID,
+		&prod_id);
+	if (ret < 0)
+		return ret;
+
+	*val = prod_id;
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(adis16460_product_id_fops,
+	adis16460_show_product_id, NULL, "%llu\n");
+
+static int adis16460_show_flash_count(void *arg, u64 *val)
+{
+	struct adis16460 *adis16460 = arg;
+	u32 flash_count;
+	int ret;
+
+	ret = adis_read_reg_32(&adis16460->adis, ADIS16460_REG_FLASH_CNT,
+		&flash_count);
+	if (ret < 0)
+		return ret;
+
+	*val = flash_count;
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(adis16460_flash_count_fops,
+	adis16460_show_flash_count, NULL, "%lld\n");
+
+static int adis16460_debugfs_init(struct iio_dev *indio_dev)
+{
+	struct adis16460 *adis16460 = iio_priv(indio_dev);
+
+	debugfs_create_file("serial_number", 0400, indio_dev->debugfs_dentry,
+		adis16460, &adis16460_serial_number_fops);
+	debugfs_create_file("product_id", 0400, indio_dev->debugfs_dentry,
+		adis16460, &adis16460_product_id_fops);
+	debugfs_create_file("flash_count", 0400, indio_dev->debugfs_dentry,
+		adis16460, &adis16460_flash_count_fops);
+
+	return 0;
+}
+
+#else
+
+static int adis16460_debugfs_init(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+#endif
+
+static int adis16460_set_freq(struct iio_dev *indio_dev, int val, int val2)
+{
+	struct adis16460 *st = iio_priv(indio_dev);
+	unsigned int t;
+
+	t =  val * 1000 + val2 / 1000;
+	if (t <= 0)
+		return -EINVAL;
+
+	t = 2048000 / t;
+	if (t > 2048)
+		t = 2048;
+
+	if (t != 0)
+		t--;
+
+	return adis_write_reg_16(&st->adis, ADIS16460_REG_DEC_RATE, t);
+}
+
+static int adis16460_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
+{
+	struct adis16460 *st = iio_priv(indio_dev);
+	uint16_t t;
+	int ret;
+	unsigned int freq;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16460_REG_DEC_RATE, &t);
+	if (ret < 0)
+		return ret;
+
+	freq = 2048000 / (t + 1);
+	*val = freq / 1000;
+	*val2 = (freq % 1000) * 1000;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int adis16460_read_raw(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, int *val, int *val2, long info)
+{
+	struct adis16460 *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		return adis_single_conversion(indio_dev, chan, 0, val);
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			*val = st->chip_info->gyro_max_scale;
+			*val2 = st->chip_info->gyro_max_val;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_ACCEL:
+			*val = st->chip_info->accel_max_scale;
+			*val2 = st->chip_info->accel_max_val;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_TEMP:
+			*val = 50; /* 50 milli degrees Celsius/LSB */
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 500; /* 25 degrees Celsius = 0x0000 */
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return adis16460_get_freq(indio_dev, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adis16460_write_raw(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, int val, int val2, long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return adis16460_set_freq(indio_dev, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+enum {
+	ADIS16460_SCAN_GYRO_X,
+	ADIS16460_SCAN_GYRO_Y,
+	ADIS16460_SCAN_GYRO_Z,
+	ADIS16460_SCAN_ACCEL_X,
+	ADIS16460_SCAN_ACCEL_Y,
+	ADIS16460_SCAN_ACCEL_Z,
+	ADIS16460_SCAN_TEMP,
+};
+
+#define ADIS16460_MOD_CHANNEL(_type, _mod, _address, _si, _bits) \
+	{ \
+		.type = (_type), \
+		.modified = 1, \
+		.channel2 = (_mod), \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.address = (_address), \
+		.scan_index = (_si), \
+		.scan_type = { \
+			.sign = 's', \
+			.realbits = (_bits), \
+			.storagebits = (_bits), \
+			.endianness = IIO_BE, \
+		}, \
+	}
+
+#define ADIS16460_GYRO_CHANNEL(_mod) \
+	ADIS16460_MOD_CHANNEL(IIO_ANGL_VEL, IIO_MOD_ ## _mod, \
+	ADIS16460_REG_ ## _mod ## _GYRO_LOW, ADIS16460_SCAN_GYRO_ ## _mod, \
+	32)
+
+#define ADIS16460_ACCEL_CHANNEL(_mod) \
+	ADIS16460_MOD_CHANNEL(IIO_ACCEL, IIO_MOD_ ## _mod, \
+	ADIS16460_REG_ ## _mod ## _ACCL_LOW, ADIS16460_SCAN_ACCEL_ ## _mod, \
+	32)
+
+#define ADIS16460_TEMP_CHANNEL() { \
+		.type = IIO_TEMP, \
+		.indexed = 1, \
+		.channel = 0, \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			BIT(IIO_CHAN_INFO_SCALE) | \
+			BIT(IIO_CHAN_INFO_OFFSET), \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.address = ADIS16460_REG_TEMP_OUT, \
+		.scan_index = ADIS16460_SCAN_TEMP, \
+		.scan_type = { \
+			.sign = 's', \
+			.realbits = 16, \
+			.storagebits = 16, \
+			.endianness = IIO_BE, \
+		}, \
+	}
+
+static const struct iio_chan_spec adis16460_channels[] = {
+	ADIS16460_GYRO_CHANNEL(X),
+	ADIS16460_GYRO_CHANNEL(Y),
+	ADIS16460_GYRO_CHANNEL(Z),
+	ADIS16460_ACCEL_CHANNEL(X),
+	ADIS16460_ACCEL_CHANNEL(Y),
+	ADIS16460_ACCEL_CHANNEL(Z),
+	ADIS16460_TEMP_CHANNEL(),
+	IIO_CHAN_SOFT_TIMESTAMP(7)
+};
+
+static const struct adis16460_chip_info adis16460_chip_info = {
+	.channels = adis16460_channels,
+	.num_channels = ARRAY_SIZE(adis16460_channels),
+	/*
+	 * storing the value in rad/degree and the scale in degree
+	 * gives us the result in rad and better precession than
+	 * storing the scale directly in rad.
+	 */
+	.gyro_max_val = IIO_RAD_TO_DEGREE(200 << 16),
+	.gyro_max_scale = 1,
+	.accel_max_val = IIO_M_S_2_TO_G(20000 << 16),
+	.accel_max_scale = 5,
+};
+
+static const struct iio_info adis16460_info = {
+	.read_raw = &adis16460_read_raw,
+	.write_raw = &adis16460_write_raw,
+	.update_scan_mode = adis_update_scan_mode,
+	.debugfs_reg_access = adis_debugfs_reg_access,
+};
+
+static int adis16460_enable_irq(struct adis *adis, bool enable)
+{
+	/*
+	 * There is no way to gate the data-ready signal internally inside the
+	 * ADIS16460 :(
+	 */
+	if (enable)
+		enable_irq(adis->spi->irq);
+	else
+		disable_irq(adis->spi->irq);
+
+	return 0;
+}
+
+static int adis16460_initial_setup(struct iio_dev *indio_dev)
+{
+	struct adis16460 *st = iio_priv(indio_dev);
+	uint16_t prod_id;
+	unsigned int device_id;
+	int ret;
+
+	adis_reset(&st->adis);
+	msleep(222);
+
+	ret = adis_write_reg_16(&st->adis, ADIS16460_REG_GLOB_CMD, BIT(1));
+	if (ret)
+		return ret;
+	msleep(75);
+
+	ret = adis_check_status(&st->adis);
+	if (ret)
+		return ret;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16460_REG_PROD_ID, &prod_id);
+	if (ret)
+		return ret;
+
+	ret = sscanf(indio_dev->name, "adis%u\n", &device_id);
+	if (ret != 1)
+		return -EINVAL;
+
+	if (prod_id != device_id)
+		dev_warn(&indio_dev->dev, "Device ID(%u) and product ID(%u) do not match.",
+				device_id, prod_id);
+
+	return 0;
+}
+
+#define ADIS16460_DIAG_STAT_IN_CLK_OOS	7
+#define ADIS16460_DIAG_STAT_FLASH_MEM	6
+#define ADIS16460_DIAG_STAT_SELF_TEST	5
+#define ADIS16460_DIAG_STAT_OVERRANGE	4
+#define ADIS16460_DIAG_STAT_SPI_COMM	3
+#define ADIS16460_DIAG_STAT_FLASH_UPT	2
+
+static const char * const adis16460_status_error_msgs[] = {
+	[ADIS16460_DIAG_STAT_IN_CLK_OOS] = "Input clock out of sync",
+	[ADIS16460_DIAG_STAT_FLASH_MEM] = "Flash memory failure",
+	[ADIS16460_DIAG_STAT_SELF_TEST] = "Self test diagnostic failure",
+	[ADIS16460_DIAG_STAT_OVERRANGE] = "Sensor overrange",
+	[ADIS16460_DIAG_STAT_SPI_COMM] = "SPI communication failure",
+	[ADIS16460_DIAG_STAT_FLASH_UPT] = "Flash update failure",
+};
+
+static const struct adis_data adis16460_data = {
+	.diag_stat_reg = ADIS16460_REG_DIAG_STAT,
+	.glob_cmd_reg = ADIS16460_REG_GLOB_CMD,
+	.has_paging = false,
+	.read_delay = 5,
+	.write_delay = 5,
+	.cs_change_delay = 16,
+	.status_error_msgs = adis16460_status_error_msgs,
+	.status_error_mask = BIT(ADIS16460_DIAG_STAT_IN_CLK_OOS) |
+		BIT(ADIS16460_DIAG_STAT_FLASH_MEM) |
+		BIT(ADIS16460_DIAG_STAT_SELF_TEST) |
+		BIT(ADIS16460_DIAG_STAT_OVERRANGE) |
+		BIT(ADIS16460_DIAG_STAT_SPI_COMM) |
+		BIT(ADIS16460_DIAG_STAT_FLASH_UPT),
+	.enable_irq = adis16460_enable_irq,
+};
+
+static int adis16460_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct adis16460 *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (indio_dev == NULL)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, indio_dev);
+
+	st = iio_priv(indio_dev);
+
+	st->chip_info = &adis16460_chip_info;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
+	indio_dev->info = &adis16460_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adis_init(&st->adis, indio_dev, spi, &adis16460_data);
+	if (ret)
+		return ret;
+
+	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
+	if (ret)
+		return ret;
+
+	adis16460_enable_irq(&st->adis, 0);
+
+	ret = adis16460_initial_setup(indio_dev);
+	if (ret)
+		goto error_cleanup_buffer;
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_cleanup_buffer;
+
+	adis16460_debugfs_init(indio_dev);
+
+	return 0;
+
+error_cleanup_buffer:
+	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
+	return ret;
+}
+
+static int adis16460_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct adis16460 *st = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
+
+	return 0;
+}
+
+static const struct spi_device_id adis16460_ids[] = {
+	{ "adis16460", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, adis16460_id);
+
+static const struct of_device_id adis16460_of_match[] = {
+	{ .compatible = "adi,adis16460" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, adis16460_of_match);
+
+static struct spi_driver adis16460_driver = {
+	.driver = {
+		.name = "adis16460",
+		.of_match_table = adis16460_of_match,
+	},
+	.id_table = adis16460_ids,
+	.probe = adis16460_probe,
+	.remove = adis16460_remove,
+};
+module_spi_driver(adis16460_driver);
+
+MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADIS16460 IMU driver");
+MODULE_LICENSE("GPL");
-- 
2.20.1

