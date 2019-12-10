Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEE5118A6F
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2019 15:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfLJOIF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Dec 2019 09:08:05 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:56506 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727145AbfLJOIE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Dec 2019 09:08:04 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBAE1B3p009761;
        Tue, 10 Dec 2019 09:08:02 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wraevshx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Dec 2019 09:08:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLXeB6emSqRUY1funjSzHWeGKetim/PtUQb/eJtzT9hAvupWMD3eK7Q9QtpbiheKEG+EOvycSMKGUiHfPJtbVNO0jfVQ4/gODWnkuFwYeNPGmVgQucA/cSL3x0nAUUvj3Sm3qRWQzQzlDfcl6QDllPY+DasR/pKl9xU3OCS0f/uphaRLwAS7aYfSVahr70uu2VIt0lfqr+syWnnVoVXOHIpM3/UvmCeDJUedu62nmH8T7nVE0SxvkkiO8SzKLxzXYXSVBDEOlTvbtHdATHGDWe4mLPmn/nzbMkONyG1RFrJ1J/aE2IFZvuwdgpXZNDhTH1r7q44yU3XCXZzeq1lxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEUVD/b8t5rhOPqIHa01OUSPSw58YehjU/aKbWiRQdM=;
 b=ncrCv85aGksr23maSMzsjxVFYFmCFbhBD9DbBPfXNWuq585SCHVFI9gDLNB25UAbmq0CaB0qrmz+OkaiTjXiKKDCQ/vQYSC/Hi1Zb5gZmsYnYaPi9Z7QPp1+S7ijNA4uUxAO4meu5rZkNLXkDs83res9Wk9u3STTRGloR/YpdA7nj9B480CW4VXiEpOpLJm0phEx2/3cYf9MR6okuSRAKqL/V9cdo+ygaFYKR+ZBwny22lYvNQIxiRP849AMg9/xS2AAEifI2gdqwW3xQcSLjPMDVN4EaaRauIISgeAMu0QFwN9P+ZIUelkOA7khF1Yff+t0evBd+tL6KEI07EZF/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEUVD/b8t5rhOPqIHa01OUSPSw58YehjU/aKbWiRQdM=;
 b=e7qTM/D5Dv4b918rMzX97y/ZbxNeY81+u6eyV+4ksk8IAm2dMSZ1sECQ5b+2X/uOlyhT8Sfy/WUoLoeF5QvnmFgngi78kQQylw6S/9V65uJey0/Z4lf5OJ9tpomRvqprVgmEudTjcfQNI3Aq0OC63GJd195+WX/NS4q+2VvATxw=
Received: from DM6PR03CA0032.namprd03.prod.outlook.com (2603:10b6:5:40::45) by
 DM6PR03MB3500.namprd03.prod.outlook.com (2603:10b6:5:ac::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.18; Tue, 10 Dec 2019 14:08:00 +0000
Received: from CY1NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by DM6PR03CA0032.outlook.office365.com
 (2603:10b6:5:40::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Tue, 10 Dec 2019 14:08:00 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT054.mail.protection.outlook.com (10.152.74.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2495.26
 via Frontend Transport; Tue, 10 Dec 2019 14:07:59 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xBAE7wX0024966
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 10 Dec 2019 06:07:58 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.105) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 10 Dec 2019 09:07:58 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 10 Dec 2019 06:07:58 -0800
Received: from saturn.ad.analog.com ([10.48.65.121])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBAE7uKD010118;
        Tue, 10 Dec 2019 09:07:57 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: imu: adis: use new `delay` structure for SPI transfer delays
Date:   Tue, 10 Dec 2019 16:07:55 +0200
Message-ID: <20191210140755.14305-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191204080904.2557-1-alexandru.ardelean@analog.com>
References: <20191204080904.2557-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(189003)(199004)(54534003)(7636002)(107886003)(426003)(26005)(336012)(2616005)(5660300002)(4326008)(86362001)(316002)(70586007)(356004)(44832011)(70206006)(2906002)(8936002)(1076003)(246002)(54906003)(8676002)(7696005)(186003)(110136005)(36756003)(478600001)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3500;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f092f350-3755-41dd-6574-08d77d7a5cf9
X-MS-TrafficTypeDiagnostic: DM6PR03MB3500:
X-Microsoft-Antispam-PRVS: <DM6PR03MB350075B2CF133D94702A1C6FF95B0@DM6PR03MB3500.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-Forefront-PRVS: 02475B2A01
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvWmnOuJ2cg2Que/nfsVLzrCDv0VgNGtHm2GiTXhhOTGWOvNMCM61zO5Aa07tplTX16nZhy/QteR1woi3k3YsfHObq6fogXPd3q5OesFeJApAEaAD6q7Gx2tGPB1TBevB8o3LafOV+bWKMe/ki+41AYzsPPt2KLE2iSvQgg3Dr0ru/Lz/x2tDdXCM/ZyHNJitVs/hdJiwltT+DCGYGw2JW0J0avBS2AexQJdJonTS0BNbIad4pte8/pHF9COvTqDgU07Un/Rigz+8hvLH5xJniCGtY8gtzIwWstpuzhndZJuHOg/e9YZDJ8UzIoxNJjk4XWcVDbfZQI9E3BziHVSXZBUaHOWSFhHWGM3UQDdEtbvzWiiA9gRz2qPCXi3oFANzMgWWho6oRURf5U5raq3efsh9j2IgbMKQO0DOrp9sKRVeW5ktkURsGi1Onyazs7V1LZvQHQuxLJZVIzhEmYRhKzuYZnWFE4Q0sjiYQCO/lIZ4rBIK/1xYXIozZ44hJs/VGr5PD1BMbIWMlPf/1Ef/A==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 14:07:59.4143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f092f350-3755-41dd-6574-08d77d7a5cf9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3500
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_03:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In a recent change to the SPI subsystem [1], a new `delay` struct was added
to replace the `delay_usecs`. This change replaces the current `delay_usecs`
with `delay` for this driver.

The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
that both `delay_usecs` & `delay` are used (in this order to preserve
backwards compatibility).

[1] commit bebcfd272df6485 ("spi: introduce `delay` field for
`spi_transfer` + spi_transfer_delay_exec()")

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* fixed typo in commit desc `delay_secs` ->  `delay_usecs`

 drivers/iio/imu/adis.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index e14c8536fd09..3cc57ef22b2e 100644
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

