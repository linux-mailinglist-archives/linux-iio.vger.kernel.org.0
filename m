Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D75AE112428
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2019 09:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfLDIIB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Dec 2019 03:08:01 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:18478 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbfLDIIA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Dec 2019 03:08:00 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB483CCk010923;
        Wed, 4 Dec 2019 03:07:57 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wkk2c35hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 03:07:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA3uI6VxT3rzQlCfl+nXTDtOF/mJYxWL3uLltpxiKRIz4mPrqbhme85p5qRCDd1C26oEFELMqOYHQHR3qNxYtx4ZV7Ee0LcdcJ7ELk38UA3EVq9YZ9iB1VljsMDLKVyDV3G2m1HtuB0rgYGyjqO1C7MFuoPM6uE/T77YZPNJ4FBO1Lh9kFGn3qFndYaCsCcqkSdHjN6xI8aMLv74vYF2Cx7kQAO3WQlx/yQRkWTihReRBkRdY8eKgqUHFuuTqtBDKANybwIKGGZ1GOb5xn3JKQYBpy3ZrI2k1xi7QEAuHBmUit1ZEWsrJtmN6iA36kOFxW1giAgnWqEGOBJiaYK3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTjuKytSgvOPCZNfbtdpCZmFP8CqZjkODaDIuxSbPv4=;
 b=Tv0v72f5WqPgayyyDdD9wUVaLUM781Aa4JIXdAQN/rrdMgJd4ZdmPcKOPEd38+yK4KjgGRPxjp2qB35zdgPaCmt+zNeSqQGUmRb4Pt+qdet38OEuyC5ixNlBLELERKPDnUKrapNHw2d6Du2KzbXlgAfnxbfghckvfpaH3WHfGHeHqs1dD0vEj2/MTzGL6/wLDi2sgyOQ/jhrATkHG54W4/1QfLKyMVRjbtT5twzWGpjGdDmSL57FVq0u9FmD9kjAdBOGexI6wYOLYZimjTzFWSCwmq+xkCMks3p4ye+WYtn/E5jjoDrAucW6XVHV0ctW68We4oeTf0h0wGckAHvPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTjuKytSgvOPCZNfbtdpCZmFP8CqZjkODaDIuxSbPv4=;
 b=9iFIUxYY/sTnhKjBGgRJaNH2k9H6hDB0mimxR45lrvh1s2h2C2cQBZCj+dJefY1KkRVT/oWuhyAcWdYWXQZyos9TKvPqau6RUlJble4//P7gAP+bG38iwnls7n65nwMcSxYSH7/W+1vWP2QPRmFbzHvpWsaZg1AWhu9hVDplhjU=
Received: from BN6PR03CA0082.namprd03.prod.outlook.com (2603:10b6:405:6f::20)
 by BYAPR03MB4280.namprd03.prod.outlook.com (2603:10b6:a03:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18; Wed, 4 Dec
 2019 08:07:55 +0000
Received: from CY1NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BN6PR03CA0082.outlook.office365.com
 (2603:10b6:405:6f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Wed, 4 Dec 2019 08:07:54 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT045.mail.protection.outlook.com (10.152.75.111) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Wed, 4 Dec 2019 08:07:54 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xB487i0F014425
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 4 Dec 2019 00:07:44 -0800
Received: from saturn.ad.analog.com (10.48.65.119) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 4 Dec 2019 03:07:53 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: imu: adis: use new `delay` structure for SPI transfer delays
Date:   Wed, 4 Dec 2019 10:09:04 +0200
Message-ID: <20191204080904.2557-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(199004)(189003)(110136005)(51416003)(8936002)(36756003)(8676002)(106002)(107886003)(1076003)(54906003)(316002)(7636002)(70586007)(70206006)(14444005)(50226002)(5660300002)(4326008)(246002)(2616005)(2870700001)(2906002)(478600001)(86362001)(44832011)(186003)(7696005)(6666004)(356004)(50466002)(336012)(48376002)(26005)(305945005)(426003)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4280;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03a44bfe-beca-41b1-20f7-08d7789110d0
X-MS-TrafficTypeDiagnostic: BYAPR03MB4280:
X-Microsoft-Antispam-PRVS: <BYAPR03MB42802C4638261F0F37726765F95D0@BYAPR03MB4280.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-Forefront-PRVS: 0241D5F98C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BLVcqM2mhi+Dl9qyijmoLzmSkNBurG51H0I1spel2Q07yjcPbt8o15ffEkf/rYUD882Lib8VX3xEh5K8Zt0dPk1igvJiG3tQb7u4zFKSLZgOESo1o2yQziHlXJZHI6V3FdcM3u809i3T0KgZcurU6LDREnAlZatffSx26MRRpFtdGSTYgx6PNQdSkNtjugnKInetVIgb3j+Ru8KKOglMTCVpYK/j7G3sVMirDWWMouz44vLJD2LJPrgVR5R2q83fM2e+wzQwdq//XQ+orJNxKg351J4UxIAj8tauGJv2JLKuZF9sifxZw4lo98KfyGFoaLYFV0KU157edCpWa3QD2vSvrlQ3n7t6qQGt3vxU8tpAHM8hbpm8CRUq7R+2ZFb9zHYY5VNvqg2aBEFSo/SJ6YDRgqoAtZcbbgRh6DcTFM+m7N4EdxMhdhJEiep1+xi1pBj64fRuZOkE2vOvUDHWWSDMXe1Rnqh60rYlMH8VhW8PeK2ISryJ4fmU7h1pPM3L
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 08:07:54.2549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a44bfe-beca-41b1-20f7-08d7789110d0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4280
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_01:2019-12-04,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040059
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In a recent change to the SPI subsystem [1], a new `delay` struct was added
to replace the `delay_usecs`. This change replaces the current `delay_secs`
with `delay` for this driver.

The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
that both `delay_usecs` & `delay` are used (in this order to preserve
backwards compatibility).

[1] commit bebcfd272df6485 ("spi: introduce `delay` field for
`spi_transfer` + spi_transfer_delay_exec()")

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 2cd2cc2316c6..95af67470668 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -38,7 +38,8 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = adis->data->write_delay,
+			.delay.value = adis->data->write_delay,
+			.delay.unit = SPI_DELAY_UNIT_USECS,
 			.cs_change_delay.value = adis->data->cs_change_delay,
 			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
@@ -46,7 +47,8 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = adis->data->write_delay,
+			.delay.value = adis->data->write_delay,
+			.delay.unit = SPI_DELAY_UNIT_USECS,
 			.cs_change_delay.value = adis->data->cs_change_delay,
 			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
@@ -54,19 +56,22 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = adis->data->write_delay,
+			.delay.value = adis->data->write_delay,
+			.delay.unit = SPI_DELAY_UNIT_USECS,
 			.cs_change_delay.value = adis->data->cs_change_delay,
 			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 6,
 			.bits_per_word = 8,
 			.len = 2,
-			.delay_usecs = adis->data->write_delay,
+			.delay.value = adis->data->write_delay,
+			.delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 8,
 			.bits_per_word = 8,
 			.len = 2,
-			.delay_usecs = adis->data->write_delay,
+			.delay.value = adis->data->write_delay,
+			.delay.unit = SPI_DELAY_UNIT_USECS,
 		},
 	};
 
@@ -138,7 +143,8 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = adis->data->write_delay,
+			.delay.value = adis->data->write_delay,
+			.delay.unit = SPI_DELAY_UNIT_USECS,
 			.cs_change_delay.value = adis->data->cs_change_delay,
 			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
@@ -146,7 +152,8 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = adis->data->read_delay,
+			.delay.value = adis->data->read_delay,
+			.delay.unit = SPI_DELAY_UNIT_USECS,
 			.cs_change_delay.value = adis->data->cs_change_delay,
 			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
@@ -155,14 +162,16 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = adis->data->read_delay,
+			.delay.value = adis->data->read_delay,
+			.delay.unit = SPI_DELAY_UNIT_USECS,
 			.cs_change_delay.value = adis->data->cs_change_delay,
 			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.rx_buf = adis->rx + 2,
 			.bits_per_word = 8,
 			.len = 2,
-			.delay_usecs = adis->data->read_delay,
+			.delay.value = adis->data->read_delay,
+			.delay.unit = SPI_DELAY_UNIT_USECS,
 		},
 	};
 
-- 
2.20.1

