Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0746BEC09C
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 10:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfKAJfn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 05:35:43 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:55572 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728901AbfKAJff (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Nov 2019 05:35:35 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA19XTSU026930;
        Fri, 1 Nov 2019 05:35:23 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2051.outbound.protection.outlook.com [104.47.49.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vxwgwh8wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 05:35:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq/mv8nVQZxQ1WvBT1SlTABuI3T9jKKOmu/nvzt53DbTrPbtvE5goEKJz44q13viAcYTe1DicRCK9QekiERWssjNOe2ygPURuDB5aTAf5kis+VgI2wVm4jfiVIQv8X6Z85oo5o0hqRyaT1Hp2l694vJBihu/8LsjFlSgUBVzvsGjpIvmjmcrflu4qZbzUWJScz275DBqYNzhvJr1G4UOA6A0WqSg1jDeiKbGzY/uhyvddo9k7w6h5KW5+D/pS6v/CsNjCrnPgqE7YwcUL0kkXGOc9fpLrxM+3Igd8oask4cZlyLC2fJQQWOOaBq+zhGbVh054e7wwVFUvX9wb/RVwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qWuMSIf3Vk6QvjbMmfHsYntFAg5LbGQwvLNnz5cEJo=;
 b=MFx1M7utTQ8pXOANGAlu7oI8lGZN5sTl3UktfE2jtRstLE92XJ9WjX5I/KyYQESXHHmmfz9cAp+moolPMA2GlIpm+u/oFjBv+2XAtbJa5woIARkPoG3PIPX8CxwabbM++g6Gg59pfXThvDy6t73VLJrsFLZQGJzbkRxwsF/i99QSkXocFPkFwRNhZmeg25cuSNikTiciBnr2E5TlF5vvkpwPWDsdY+jkj9TiFKtGqhV+hRX2/tLGwA/XEmUjDciBgsSEzky0HXuuatw3YpSM8bCQ18SmRr9Nwo0GCRGcMOCgT/WUD6JnkmSRuIemJdgu6SmQZdlGF9bI7bj+HSkqxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qWuMSIf3Vk6QvjbMmfHsYntFAg5LbGQwvLNnz5cEJo=;
 b=XXbc/FTFf8i69Ps0TOXexQzbFs6+TnHNSgg724H8Govd4w1w5Tk4ag3LRoaHo8eXRLdNaqXzxZaR5CCuNhNvlCa97mb2oZBLn7qrxB8ezn3vm+iIX6MDwKgvZDYD5pPXUbXUvkAGCrddCKEgdWBhwdReZmHymfWd1xemkaq1wNo=
Received: from BN3PR03CA0058.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::18) by CY4PR03MB2485.namprd03.prod.outlook.com
 (2603:10b6:903:38::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.17; Fri, 1 Nov
 2019 09:35:20 +0000
Received: from BL2NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN3PR03CA0058.outlook.office365.com
 (2a01:111:e400:7a4d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.22 via Frontend
 Transport; Fri, 1 Nov 2019 09:35:19 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT042.mail.protection.outlook.com (10.152.76.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 1 Nov 2019 09:35:18 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xA19ZBC0025012
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 1 Nov 2019 02:35:11 -0700
Received: from saturn.ad.analog.com (10.48.65.117) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 1 Nov 2019 05:35:18 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 04/10] iio: imu: adis16480: check ret val for non-zero vs less-than-zero
Date:   Fri, 1 Nov 2019 11:34:59 +0200
Message-ID: <20191101093505.9408-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101093505.9408-1-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(189003)(199004)(476003)(44832011)(2616005)(26005)(2906002)(47776003)(4326008)(246002)(126002)(305945005)(50226002)(107886003)(6666004)(356004)(7636002)(8936002)(336012)(7696005)(51416003)(70206006)(486006)(11346002)(76176011)(2870700001)(8676002)(186003)(70586007)(446003)(426003)(54906003)(86362001)(110136005)(1076003)(50466002)(36756003)(316002)(48376002)(5660300002)(478600001)(106002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2485;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df8df1cc-1c14-4c4a-3482-08d75eaecf32
X-MS-TrafficTypeDiagnostic: CY4PR03MB2485:
X-Microsoft-Antispam-PRVS: <CY4PR03MB248583285A58AF773ED09C43F9620@CY4PR03MB2485.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpF2sffXz0MQJ+34XhxMmU9S7HdH6QAvKXMMcl16imtjhyAqYfC0VpsONy1u29VXrQtcWr2aMNIlQ49/sq9Yu9CIolYYcvEtPSOhl+Qgdv9Hqdw5+3PC9bubsnjDxG1/541qN1enxAbC6QRAi0tU/iyWMtGZ4eUG7WGb4XFQV7lT2JOc33XRsYLmO+LjZzAUTlj1GcPitBu4BhaoJcDNWUz8sFkFEBAZh5y5JFfmtI/jK9EFKRK3OdmtodXKVP23Bfb0Vu1CKR4atAiAigYqcqV8wkNh3g4z3tvNuTFVIlkPGXKopMp6xpj+dSeSwF5vlw50V4NqCRjRXd9pBdQN+UBcye/Lq8sd/GZENIPSkB6TZ3ovaOPzVx8MLOahErdUvUGQKPCd1ePzOhAoYD1nhHEHIoe//x2mcB8MxDMgyrLDuwoinS/hdGCzGI8wVsm3
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 09:35:18.9298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df8df1cc-1c14-4c4a-3482-08d75eaecf32
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2485
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-01_03:2019-10-30,2019-11-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=868
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911010095
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADIS library functions return zero on success, and negative values for
error. Positive values aren't returned, but we only care about the success
value (which is zero).

This change is mostly needed so that the compiler won't make any inferences
about some about values being potentially un-initialized. This only
triggers after making some functions inline, because the compiler can
better follow return paths.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16480.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index b99d73887c9f..86801f3c5f0d 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -181,7 +181,7 @@ static ssize_t adis16480_show_firmware_revision(struct file *file,
 	int ret;
 
 	ret = adis_read_reg_16(&adis16480->adis, ADIS16480_REG_FIRM_REV, &rev);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	len = scnprintf(buf, sizeof(buf), "%x.%x\n", rev >> 8, rev & 0xff);
@@ -206,11 +206,11 @@ static ssize_t adis16480_show_firmware_date(struct file *file,
 	int ret;
 
 	ret = adis_read_reg_16(&adis16480->adis, ADIS16480_REG_FIRM_Y, &year);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = adis_read_reg_16(&adis16480->adis, ADIS16480_REG_FIRM_DM, &md);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	len = snprintf(buf, sizeof(buf), "%.2x-%.2x-%.4x\n",
@@ -234,7 +234,7 @@ static int adis16480_show_serial_number(void *arg, u64 *val)
 
 	ret = adis_read_reg_16(&adis16480->adis, ADIS16480_REG_SERIAL_NUM,
 		&serial);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	*val = serial;
@@ -252,7 +252,7 @@ static int adis16480_show_product_id(void *arg, u64 *val)
 
 	ret = adis_read_reg_16(&adis16480->adis, ADIS16480_REG_PROD_ID,
 		&prod_id);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	*val = prod_id;
@@ -270,7 +270,7 @@ static int adis16480_show_flash_count(void *arg, u64 *val)
 
 	ret = adis_read_reg_32(&adis16480->adis, ADIS16480_REG_FLASH_CNT,
 		&flash_count);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	*val = flash_count;
@@ -359,7 +359,7 @@ static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
 		reg = ADIS16480_REG_DEC_RATE;
 
 	ret = adis_read_reg_16(&st->adis, reg, &t);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	/*
@@ -462,7 +462,7 @@ static int adis16480_get_calibbias(struct iio_dev *indio_dev,
 			ret = -EINVAL;
 	}
 
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return IIO_VAL_INT;
@@ -489,7 +489,7 @@ static int adis16480_get_calibscale(struct iio_dev *indio_dev,
 	int ret;
 
 	ret = adis_read_reg_16(&st->adis, reg, &val16);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	*scale = sign_extend32(val16, 15);
@@ -535,7 +535,7 @@ static int adis16480_get_filter_freq(struct iio_dev *indio_dev,
 	enable_mask = BIT(offset + 2);
 
 	ret = adis_read_reg_16(&st->adis, reg, &val);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	if (!(val & enable_mask))
@@ -561,7 +561,7 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
 	enable_mask = BIT(offset + 2);
 
 	ret = adis_read_reg_16(&st->adis, reg, &val);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	if (freq == 0) {
@@ -937,7 +937,7 @@ static int adis16480_enable_irq(struct adis *adis, bool enable)
 	int ret;
 
 	ret = adis_read_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, &val);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	val &= ~ADIS16480_DRDY_EN_MSK;
@@ -1115,7 +1115,7 @@ static int adis16480_ext_clk_config(struct adis16480 *st,
 	int ret;
 
 	ret = adis_read_reg_16(&st->adis, ADIS16480_REG_FNCTIO_CTRL, &val);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	pin = adis16480_of_get_ext_clk_pin(st, of_node);
@@ -1141,7 +1141,7 @@ static int adis16480_ext_clk_config(struct adis16480 *st,
 	val |= mode;
 
 	ret = adis_write_reg_16(&st->adis, ADIS16480_REG_FNCTIO_CTRL, val);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return clk_prepare_enable(st->ext_clk);
-- 
2.20.1

