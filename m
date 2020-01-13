Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F26F138EF5
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 11:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgAMK1O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 05:27:14 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:6782 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbgAMK1N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 05:27:13 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DAQSYM020399;
        Mon, 13 Jan 2020 05:27:10 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xfbvb3wge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 05:27:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ra6XfwsBOpnb/ZGO29rHh8fpv4rZdvP9MU1gasQGQNyWT0W0aRcSCPAFGzVi7FKOReB+ACfYxZQJkD1i556VGt1ixSeAFKBREuwwhX25Wy7gEz8nJNs6ILe94xpmNyi69mF2mtLMEOohZXplC4ezBqY/DAWSXA7jgTleZFeNbr/7QRW6pMZ3RPZa4sDa/RaSBUZlc14XqLbsJmIKFSUUfpSnvPINi5YoLRIKo9wvbriR4Ssaif+eTCuTyBQhtrMUwH7Zr3ij56/vI6eUb16FdXesXstDsx3pc9+X75Q/gwBmmAmsI4urgxxoXO59IRKS1GRuzpt460aJIjQ+ksad4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fE4O465sY9HuVKZnTH5q56uk3MuYQmm5UaJncAT8u4=;
 b=gV76Idd14T4huPOC0TUhaPR/dPDNXAQHnTo8VRBsm8hR5rEt03iid8YYPsXoWehKswh+RDHzqLFSfkXNaj+9rzpd4Dlu/EJghUC4+nmmSGw0ngn03VWsZSxjn6xLMXqbMXV2W2Gdo4IrwnrDQOvZkI696g7xy5TLI/MiZYhMkT5nTFD1cjZOTdVT5FpPqE6ozuV3DAD0czGL4E4Cs/NGwFVVHDadYKIzc6Vdb2Y2AXd3q6+MEDW9128kZJ3bizILvX9E7mAqlSfZ+AjSTLcV1NCx7n8H4XcGbdqHVXRN9JTcBeGTa8FjswDmH7x52gGurHHxiSNIt9njLOW+vQ7xQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fE4O465sY9HuVKZnTH5q56uk3MuYQmm5UaJncAT8u4=;
 b=SzWq72pNusUoiCIRp/CsKdikVKch7gfF2hdeBch0rnBJ2CCn7Bh2eapm+EewBOZlFA9LHl1m7uFF99kerjR+rdN/41IZnb+LIMrYHvCJuEMPlu1vtBIDQ6vIVMEavGt/lYh2mUHRVyI8FvtB6BDB8ITppeJYa1Ehwi7AmWWOesI=
Received: from CH2PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:59::23)
 by DM6PR03MB3802.namprd03.prod.outlook.com (2603:10b6:5:50::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Mon, 13 Jan
 2020 10:27:09 +0000
Received: from SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by CH2PR03CA0013.outlook.office365.com
 (2603:10b6:610:59::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Mon, 13 Jan 2020 10:27:09 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT016.mail.protection.outlook.com (10.152.72.113) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Mon, 13 Jan 2020 10:27:08 +0000
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id 00DAR8K9008732
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 13 Jan 2020 02:27:08 -0800
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 13 Jan
 2020 05:27:06 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 13 Jan 2020 05:27:06 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00DAR3HQ000879;
        Mon, 13 Jan 2020 05:27:04 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 1/2 V3] iio: adc: ad-sigma-delta: Allow custom IRQ flags
Date:   Mon, 13 Jan 2020 12:26:52 +0200
Message-ID: <20200113102653.20900-2-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113102653.20900-1-alexandru.tachici@analog.com>
References: <20200111112317.1cf2d878@archlinux>
 <20200113102653.20900-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(189003)(199004)(5660300002)(7636002)(2906002)(8676002)(246002)(86362001)(478600001)(70586007)(70206006)(4326008)(336012)(426003)(110136005)(2616005)(107886003)(1076003)(36756003)(44832011)(8936002)(356004)(316002)(186003)(26005)(54906003)(6666004)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3802;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 162ec58d-3022-4b5c-afd1-08d7981324f4
X-MS-TrafficTypeDiagnostic: DM6PR03MB3802:
X-Microsoft-Antispam-PRVS: <DM6PR03MB38021528F7D953825E2FDF0F90350@DM6PR03MB3802.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 028166BF91
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pl8GBnhjVEM5lUJjX6A20fUQb26rUuceGzk6hrAOcDUniFU1r/95wKYdGqS3VefNTR0OlBfwIjysyRE9o2cbuiKbwOusRfab3GZQ+pADoL5420cuVRSy3tvep0QzNtcKN/ymOKraePa6NA2N+n3OuSFbDNxZOPIDnLJOyA8csQBn/R/Qq/fDepwAEc7eNYoYARcRuZ+j5cFi5xvvUw1Ifgmj/W5kEyDNvxEMok/zUjLeJ85qEAdDVyFxzJriMamLKplER6w8WxtZC2tCUkm8do1qR5efsFtKbufOQ6TrwBYGByjT8MJ00ZZ+IQnkAKF60malHD8UuAy1/EDVlLv/7x6vv2gBs4ZNuQ9gtVtpc/2klO/0tlVFFlhZ4g1eXjKE8L5dnKazuos+sEDvjfz6niD4JqMW3Bxv5jzOFGb5vLDUaB4Rb8aNAV09ss2cjLND
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 10:27:08.6929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 162ec58d-3022-4b5c-afd1-08d7981324f4
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3802
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_02:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130089
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Before this patch the ad_sigma_delta implementation hardcoded
the irq trigger type to low, assuming that all Sigma-Delta ADCs
have the same interrupt-type.

This patch allows all drivers using the ad_sigma_delta layer to set the
irq trigger type to the one specified in the datasheet.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad7124.c               | 2 ++
 drivers/iio/adc/ad7780.c               | 1 +
 drivers/iio/adc/ad7791.c               | 1 +
 drivers/iio/adc/ad7793.c               | 1 +
 drivers/iio/adc/ad_sigma_delta.c       | 2 +-
 include/linux/iio/adc/ad_sigma_delta.h | 2 ++
 6 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index edc6f1cc90b2..9531d8a6cb27 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
@@ -222,6 +223,7 @@ static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
 	.addr_shift = 0,
 	.read_mask = BIT(6),
 	.data_reg = AD7124_DATA,
+	.irq_flags = IRQF_TRIGGER_LOW,
 };
 
 static int ad7124_set_channel_odr(struct ad7124_state *st,
diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
index 217a5a5c3c6d..291c1a898129 100644
--- a/drivers/iio/adc/ad7780.c
+++ b/drivers/iio/adc/ad7780.c
@@ -203,6 +203,7 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
 	.set_mode = ad7780_set_mode,
 	.postprocess_sample = ad7780_postprocess_sample,
 	.has_registers = false,
+	.irq_flags = IRQF_TRIGGER_LOW,
 };
 
 #define AD7780_CHANNEL(bits, wordsize) \
diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index 54025ea10239..abb239392631 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -205,6 +205,7 @@ static const struct ad_sigma_delta_info ad7791_sigma_delta_info = {
 	.has_registers = true,
 	.addr_shift = 4,
 	.read_mask = BIT(3),
+	.irq_flags = IRQF_TRIGGER_LOW,
 };
 
 static int ad7791_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index bbc41ecf0d2f..b747db97f78a 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -206,6 +206,7 @@ static const struct ad_sigma_delta_info ad7793_sigma_delta_info = {
 	.has_registers = true,
 	.addr_shift = 3,
 	.read_mask = BIT(6),
+	.irq_flags = IRQF_TRIGGER_LOW,
 };
 
 static const struct ad_sd_calib_data ad7793_calib_arr[6] = {
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 8ba90486c787..8115b6de1d6c 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -500,7 +500,7 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
 
 	ret = request_irq(sigma_delta->spi->irq,
 			  ad_sd_data_rdy_trig_poll,
-			  IRQF_TRIGGER_LOW,
+			  sigma_delta->info->irq_flags,
 			  indio_dev->name,
 			  sigma_delta);
 	if (ret)
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 8a4e25a7080c..5a127c0ed200 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -40,6 +40,7 @@ struct iio_dev;
  * @read_mask: Mask for the communications register having the read bit set.
  * @data_reg: Address of the data register, if 0 the default address of 0x3 will
  *   be used.
+ * @irq_flags: flags for the interrupt used by the triggered buffer
  */
 struct ad_sigma_delta_info {
 	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
@@ -49,6 +50,7 @@ struct ad_sigma_delta_info {
 	unsigned int addr_shift;
 	unsigned int read_mask;
 	unsigned int data_reg;
+	unsigned long irq_flags;
 };
 
 /**
-- 
2.20.1

