Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 868BCBF101
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 13:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725280AbfIZLSb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 07:18:31 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:22264 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbfIZLSb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 07:18:31 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QBI6OB003191;
        Thu, 26 Sep 2019 07:18:29 -0400
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2058.outbound.protection.outlook.com [104.47.34.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v6hjwy9yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 07:18:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSIhDH9iZz6+qI6Xub73hM9eFALLa4wVwUuvywr93nKkU3YO5rex6Dj9SHyEMDRHVxgiaLyELUTlyBmK6f3y4t8kQAuM8/CL5wd4mxqvjVWw1yzGAObQ9a4xhhyVFv6UPmTgkowjxGy5S/f+gJZ/LkdcoCyrtQPim5IO46SbXORrRe2v3mLPVdOd+ui6jxovtrcNUA2XN1OwBQYXJz4do3j6S9OhgDqyFiwlBwURZtj2hTXG67jsrEu6PFz0y1Cap/AWl2CKzvjuG+Gccizv00B66iVALkebSjgcKkMjsS81y5aSjUhL8JvbRuT/Ls6vHGaYFtKLhrdbQH25cMPj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSyQbcVqCBUgOfUsxo9Xvt9beLyCCFGBEyibA/utD1c=;
 b=Ia+uvKXN2En2/xXljZodlwOr6QmhH2R9htaJuS/p92QlSuz7y0sEIbJgm7iw9QMg9g5ZSda03NOzy8QMsXxVVziVfcA1BkV8rpWw0GiTKb36m9tjsro1LCo7+kRKZ2ObdylGMJqaQJ0LC+MyrdB6xhy42D+fVBKZWxsetCF4BmBIvem8wlwHG/gqETA7GASpztFwvr1siBthWg9Y4aBb7o9TJntdJo7jjc+vVVrAZKIWLUr/ipFPwypRQ3xM+4FqFi2XZLEhDc/ztorsuwgP9JnbScWIMK5zuyERNHrAq4p5WEmzzikft5l0GpJBPp783LGje46sicxpCUZQwHtzaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSyQbcVqCBUgOfUsxo9Xvt9beLyCCFGBEyibA/utD1c=;
 b=4dyf+VyQqBD86f2ks9oM9jejg44Gco8PKwQ3AP8MGrAMyWaNyeryl5yzqJxBINAxGMQgK/3fQrxKO9oT+hxLMUvgshCdpXzWOREfu0BeTHh+TxhAkOtq/DviOiW04Ca3eAfTdB4H/8vMfrSawgsqsfFa6nYOh6Y9PQp76wm7Fns=
Received: from CY4PR03CA0019.namprd03.prod.outlook.com (2603:10b6:903:33::29)
 by BN7PR03MB4452.namprd03.prod.outlook.com (2603:10b6:408:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17; Thu, 26 Sep
 2019 11:18:27 +0000
Received: from BL2NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by CY4PR03CA0019.outlook.office365.com
 (2603:10b6:903:33::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.25 via Frontend
 Transport; Thu, 26 Sep 2019 11:18:27 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT042.mail.protection.outlook.com (10.152.76.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 11:18:27 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8QBILYk004151
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 04:18:21 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 07:18:26 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 02/10] iio: imu: adis: add unlocked read/write function versions
Date:   Thu, 26 Sep 2019 14:18:04 +0300
Message-ID: <20190926111812.15957-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926111812.15957-1-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(189003)(199004)(106002)(54906003)(110136005)(246002)(1076003)(8676002)(6666004)(2870700001)(2906002)(356004)(4326008)(316002)(107886003)(50466002)(476003)(26005)(426003)(44832011)(478600001)(48376002)(126002)(76176011)(86362001)(186003)(14444005)(36756003)(7696005)(486006)(51416003)(305945005)(8936002)(7636002)(70206006)(446003)(11346002)(2616005)(50226002)(47776003)(70586007)(5660300002)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB4452;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 750fcd26-10d0-4b4c-b058-08d742734106
X-MS-TrafficTypeDiagnostic: BN7PR03MB4452:
X-Microsoft-Antispam-PRVS: <BN7PR03MB445207F649949EDB03C81A92F9860@BN7PR03MB4452.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pYduxicvharBEuqRyuUgyP/6uFpSY5AkcLwkWPFWmJvNcz8rj1OnZ3OpZJ+6vfDOURNUls+ElA/HrKsYJru0sB4yxtpZG30GjxtVhwWmLH+luWYSUHRecuQye3WRXqoJiEnlaJMzI1W+n8vWk9XxrBztZ5khEFhs6rcCTAZE0t3KhPC0mbLC0HuKex9c9mxPfOyYt7yFOt5KJT3dNxh8pUf99ezU+nfd1vjLc+Z3CGSwn3Y34PUyN/5K81+7sFtI2Ugg3MxacUUMrtl6VbLfcBz/qmUYqjroMuCGZ5uRR4Ihg5j+6fEqSfnPec05CWKkQI8X9wxsc7HRuAU8ly5WfwTIq/HIrCaE3vpeSIGxPkj6Fhi0kLz8gCWqA52ObaXmoq2bl0oYW1nKBdHbpFLDdN6L8zQ+vGpOkdeBvajm1sw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 11:18:27.5473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 750fcd26-10d0-4b4c-b058-08d742734106
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4452
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909260108
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This will allow more flexible control to group reads & writes into a single
lock (particularly the state_lock).

The end-goal is to remove the indio_dev->mlock usage, and the simplest fix
would have been to just add another lock, which would not be a good idea on
the long-run.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c       |  34 +++++------
 include/linux/iio/imu/adis.h | 114 ++++++++++++++++++++++++++++++++++-
 2 files changed, 128 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 3c2d896e3a96..4f3be011c898 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -26,7 +26,14 @@
 #define ADIS_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
 #define ADIS_GLOB_CMD_SW_RESET		BIT(7)
 
-int adis_write_reg(struct adis *adis, unsigned int reg,
+/**
+ * __adis_write_reg() - write N bytes to register (unlocked version)
+ * @adis: The adis device
+ * @reg: The address of the lower of the two registers
+ * @value: The value to write to device (up to 4 bytes)
+ * @size: The size of the @value (in bytes)
+ */
+int __adis_write_reg(struct adis *adis, unsigned int reg,
 	unsigned int value, unsigned int size)
 {
 	unsigned int page = reg / ADIS_PAGE_SIZE;
@@ -70,8 +77,6 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 		},
 	};
 
-	mutex_lock(&adis->state_lock);
-
 	spi_message_init(&msg);
 
 	if (adis->current_page != page) {
@@ -96,8 +101,7 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 		adis->tx[3] = value & 0xff;
 		break;
 	default:
-		ret = -EINVAL;
-		goto out_unlock;
+		return -EINVAL;
 	}
 
 	xfers[size].cs_change = 0;
@@ -113,20 +117,18 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 		adis->current_page = page;
 	}
 
-out_unlock:
-	mutex_unlock(&adis->state_lock);
-
 	return ret;
 }
-EXPORT_SYMBOL_GPL(adis_write_reg);
+EXPORT_SYMBOL_GPL(__adis_write_reg);
 
 /**
- * adis_read_reg() - read 2 bytes from a 16-bit register
+ * __adis_read_reg() - read N bytes from register (unlocked version)
  * @adis: The adis device
  * @reg: The address of the lower of the two registers
  * @val: The value read back from the device
+ * @size: The size of the @val buffer
  */
-int adis_read_reg(struct adis *adis, unsigned int reg,
+int __adis_read_reg(struct adis *adis, unsigned int reg,
 	unsigned int *val, unsigned int size)
 {
 	unsigned int page = reg / ADIS_PAGE_SIZE;
@@ -188,15 +190,14 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 		spi_message_add_tail(&xfers[3], &msg);
 		break;
 	default:
-		ret = -EINVAL;
-		goto out_unlock;
+		return -EINVAL;
 	}
 
 	ret = spi_sync(adis->spi, &msg);
 	if (ret) {
 		dev_err(&adis->spi->dev, "Failed to read register 0x%02X: %d\n",
 				reg, ret);
-		goto out_unlock;
+		return ret;
 	} else {
 		adis->current_page = page;
 	}
@@ -210,12 +211,9 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 		break;
 	}
 
-out_unlock:
-	mutex_unlock(&adis->state_lock);
-
 	return ret;
 }
-EXPORT_SYMBOL_GPL(adis_read_reg);
+EXPORT_SYMBOL_GPL(__adis_read_reg);
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 3ed5eceaac2d..3a028c40e04e 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -75,11 +75,121 @@ int adis_init(struct adis *adis, struct iio_dev *indio_dev,
 	struct spi_device *spi, const struct adis_data *data);
 int adis_reset(struct adis *adis);
 
-int adis_write_reg(struct adis *adis, unsigned int reg,
+int __adis_write_reg(struct adis *adis, unsigned int reg,
 	unsigned int val, unsigned int size);
-int adis_read_reg(struct adis *adis, unsigned int reg,
+int __adis_read_reg(struct adis *adis, unsigned int reg,
 	unsigned int *val, unsigned int size);
 
+/**
+ * __adis_write_reg_8() - Write single byte to a register (unlocked version)
+ * @adis: The adis device
+ * @reg: The address of the register to be written
+ * @value: The value to write
+ */
+static inline int __adis_write_reg_8(struct adis *adis, unsigned int reg,
+	uint8_t val)
+{
+	return __adis_write_reg(adis, reg, val, 1);
+}
+
+/**
+ * __adis_write_reg_16() - Write 2 bytes to a pair of registers (unlocked version)
+ * @adis: The adis device
+ * @reg: The address of the lower of the two registers
+ * @value: Value to be written
+ */
+static inline int __adis_write_reg_16(struct adis *adis, unsigned int reg,
+	uint16_t val)
+{
+	return __adis_write_reg(adis, reg, val, 2);
+}
+
+/**
+ * __adis_write_reg_32() - write 4 bytes to four registers (unlocked version)
+ * @adis: The adis device
+ * @reg: The address of the lower of the four register
+ * @value: Value to be written
+ */
+static inline int __adis_write_reg_32(struct adis *adis, unsigned int reg,
+	uint32_t val)
+{
+	return __adis_write_reg(adis, reg, val, 4);
+}
+
+/**
+ * __adis_read_reg_16() - read 2 bytes from a 16-bit register (unlocked version)
+ * @adis: The adis device
+ * @reg: The address of the lower of the two registers
+ * @val: The value read back from the device
+ */
+static inline int __adis_read_reg_16(struct adis *adis, unsigned int reg,
+	uint16_t *val)
+{
+	unsigned int tmp;
+	int ret;
+
+	ret = __adis_read_reg(adis, reg, &tmp, 2);
+	*val = tmp;
+
+	return ret;
+}
+
+/**
+ * __adis_read_reg_32() - read 4 bytes from a 32-bit register (unlocked version)
+ * @adis: The adis device
+ * @reg: The address of the lower of the two registers
+ * @val: The value read back from the device
+ */
+static inline int __adis_read_reg_32(struct adis *adis, unsigned int reg,
+	uint32_t *val)
+{
+	unsigned int tmp;
+	int ret;
+
+	ret = __adis_read_reg(adis, reg, &tmp, 4);
+	*val = tmp;
+
+	return ret;
+}
+
+/**
+ * adis_write_reg() - write N bytes to register
+ * @adis: The adis device
+ * @reg: The address of the lower of the two registers
+ * @value: The value to write to device (up to 4 bytes)
+ * @size: The size of the @value (in bytes)
+ */
+static inline int adis_write_reg(struct adis *adis, unsigned int reg,
+	unsigned int val, unsigned int size)
+{
+	int ret;
+
+	mutex_lock(&adis->state_lock);
+	ret = __adis_write_reg(adis, reg, val, size);
+	mutex_unlock(&adis->state_lock);
+
+	return ret;
+}
+
+/**
+ * adis_read_reg() - read N bytes from register
+ * @adis: The adis device
+ * @reg: The address of the lower of the two registers
+ * @val: The value read back from the device
+ * @size: The size of the @val buffer
+ */
+static int adis_read_reg(struct adis *adis, unsigned int reg,
+	unsigned int *val, unsigned int size)
+{
+	int ret;
+
+	mutex_lock(&adis->state_lock);
+	ret = __adis_read_reg(adis, reg, val, size);
+	mutex_unlock(&adis->state_lock);
+
+	return ret;
+}
+
 /**
  * adis_write_reg_8() - Write single byte to a register
  * @adis: The adis device
-- 
2.20.1

