Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA3B107338
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2019 14:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfKVNaD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Nov 2019 08:30:03 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:54482 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727261AbfKVNaC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Nov 2019 08:30:02 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMDN46w011404;
        Fri, 22 Nov 2019 08:29:57 -0500
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2058.outbound.protection.outlook.com [104.47.48.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wbg0jtqxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 08:29:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCw9cy4VK1utpCimHJol08uXGlPS+Ewek+3RVD1938ke7bJI7+9aqvpXnNMxAkA0P3v0j+vj9llgwrTSSbSNp9n3XXBcO02lB8udrKo2I0jkOFaPlD8ivFSRQu+lCvrJwvb7BjX7G/EKStSssqBIZ69l+iEpJSgro+uv95HovP0vdcJkguH0NntDCP9oY3beRmSoGmGtRbNT3dlh8LB2zh6Tp3VApRmrpVmwC/1bxTKv/qu9DIzwGwVLvVuIvyGUmAE1ZioVzwndiCNA8sS572teD6Ji2fFE87bccITHakBEGSk3xes6CgLYpXQuMkqC46dlZKcedzM6ypPjeRFZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuDtxP97Yf1STuzzivkjZpSASW2OlCseq0JxV7qkWCI=;
 b=QC5ufB0w+XsxfJ+EhyeVb71OE4zivCUfqTMYMUEXyqoa6acjUQrjF8FgckDbUZRLS2S/tvUoK2n64WQxYCc1F0XRLSAmZITQBn/AJh9LcjQCh+WWu8zbsPGodiGw05AT+Ux3jkMFV6eeu/YQo7EoDQmdaneHwourScOhss/9nio6hm2+S6MYVRJ8jucIVyiO1Yc0TNHPzQFK/Hm/o/9smQzww2bTthQ4bePjepKhvw40+33uOKFBqTHlsyjxgSiFgv2ISDom+qL/AqCNL3vcB4C6UFWVyiDtqpQqV1KDnXkVOcBU72/GCvrny6+cORHAm9NCC7xoxPkn1Qild9jkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuDtxP97Yf1STuzzivkjZpSASW2OlCseq0JxV7qkWCI=;
 b=4EKW0VQ3sVrT3d4JUU1VR2a1LFQjiZIDvz77CPyin53YkprIiXgoabOqdmSj3W7FdQSI90nq6JJFwG3zsX7m0fk5yAkhV4O+S0V/wiRguWDjjI9fgmAwqWll3S6ayFbDnuV8Fez2N700Y/J/i+O1b0MqZJqnOxc/7NsJ1QJkb30=
Received: from BN6PR03CA0111.namprd03.prod.outlook.com (2603:10b6:404:10::25)
 by SN6PR03MB3936.namprd03.prod.outlook.com (2603:10b6:805:72::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Fri, 22 Nov
 2019 13:29:54 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by BN6PR03CA0111.outlook.office365.com
 (2603:10b6:404:10::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Fri, 22 Nov 2019 13:29:54 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 22 Nov 2019 13:29:54 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAMDTjjW015757
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 22 Nov 2019 05:29:45 -0800
Received: from saturn.ad.analog.com (10.48.65.119) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 22 Nov 2019 08:29:53 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 02/11] iio: imu: adis: add unlocked read/write function versions
Date:   Fri, 22 Nov 2019 15:24:12 +0200
Message-ID: <20191122132421.5500-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122132421.5500-1-alexandru.ardelean@analog.com>
References: <20191122132421.5500-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(51416003)(305945005)(106002)(4326008)(336012)(426003)(26005)(47776003)(7636002)(5660300002)(2906002)(44832011)(54906003)(50466002)(70586007)(14444005)(7696005)(76176011)(110136005)(446003)(1076003)(186003)(11346002)(86362001)(107886003)(2616005)(2870700001)(70206006)(48376002)(316002)(50226002)(8936002)(8676002)(478600001)(246002)(36756003)(356004)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3936;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4f13529-58b1-4c3e-4f7f-08d76f500f6e
X-MS-TrafficTypeDiagnostic: SN6PR03MB3936:
X-Microsoft-Antispam-PRVS: <SN6PR03MB3936D7865EDF71C07EFC6EA6F9490@SN6PR03MB3936.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P8QqVvQnY3LiZRT0ImKnuFUZYXOyMnAK536YltLNh/aZXaJQlu9iGri86/0FpL10Me6Y9LLu+qEOETNdGj3KjyudpaSVKMUF/lpHFf1uprIuDiv69FKeFqUvssSClY8SfZoI4j/1CP9slumGIPcA+b7CY0QHsxboykFzXAoLSQ0gjeJvqJxGdkZWK7ZGezfiah+ehk394Nc5QyNyqNXtZzA1Yx8uQKBZ+gRNfPFZ8tfaW4K3y4myrhnBnAmccGoh38o2/mx0s1Bx3Wh8T1F081jwKuWrE60Xg/9xB29d+DZ8dYBEu2DhsoWvjSpnKTH8JLlZVhhGKOWDAkBTKRc4QXTA9EBdBTkabIba1hiJppUTIrfe8lNTCxpuD8tpLQXA0Ut+b0PkfEzoON4G9jeIftKib07JAcsXkvOsMeUz2AAubN7MJD8Ne70/H9StDT+K
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 13:29:54.2728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f13529-58b1-4c3e-4f7f-08d76f500f6e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3936
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911220119
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
 drivers/iio/imu/adis.c       |  35 +++++------
 include/linux/iio/imu/adis.h | 116 ++++++++++++++++++++++++++++++++++-
 2 files changed, 130 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index db562fec79b2..2f518e6c727d 100644
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
@@ -166,7 +168,6 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 		},
 	};
 
-	mutex_lock(&adis->state_lock);
 	spi_message_init(&msg);
 
 	if (adis->current_page != page) {
@@ -188,15 +189,14 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
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
@@ -210,12 +210,9 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
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
index 100b5d1cebf1..38ebe41092e1 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -75,11 +75,123 @@ int adis_init(struct adis *adis, struct iio_dev *indio_dev,
 	struct spi_device *spi, const struct adis_data *data);
 int adis_reset(struct adis *adis);
 
-int adis_write_reg(struct adis *adis, unsigned int reg,
+int __adis_write_reg(struct adis *adis, unsigned int reg,
 	unsigned int val, unsigned int size);
-int adis_read_reg(struct adis *adis, unsigned int reg,
+int __adis_read_reg(struct adis *adis, unsigned int reg,
 	unsigned int *val, unsigned int size);
 
+/**
+ * __adis_write_reg_8() - Write single byte to a register (unlocked)
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
+ * __adis_write_reg_16() - Write 2 bytes to a pair of registers (unlocked)
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
+ * __adis_write_reg_32() - write 4 bytes to four registers (unlocked)
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
+ * __adis_read_reg_16() - read 2 bytes from a 16-bit register (unlocked)
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
+	if (ret == 0)
+		*val = tmp;
+
+	return ret;
+}
+
+/**
+ * __adis_read_reg_32() - read 4 bytes from a 32-bit register (unlocked)
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
+	if (ret == 0)
+		*val = tmp;
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

