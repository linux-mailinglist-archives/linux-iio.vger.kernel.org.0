Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCE654FFB
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2019 15:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbfFYNNy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jun 2019 09:13:54 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:62954 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730434AbfFYNNx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jun 2019 09:13:53 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PDCcsD017153;
        Tue, 25 Jun 2019 09:13:52 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2050.outbound.protection.outlook.com [104.47.46.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tbgangm7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 09:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6iaauzrHsL25Tf2RZedOGer1bGKyxT4StqtgaUd2r8=;
 b=BV2g2iIv41TIhFs73NIQ2FGt+niSXWbu9i4OfcHOCIgNNt+sENXjq8dUbKVSjavDYWvQ9HWvI7IFl3TJNfGEvVDVkbXyEng/tOwgElFyhLeQtBezyRDbCDt7qS3z/3K1GA0yCnV+ZuNkRpPiIFXq/gIqXu/Y0i/ErjJRTW8UTlA=
Received: from CY4PR03CA0019.namprd03.prod.outlook.com (2603:10b6:903:33::29)
 by BN3PR03MB2259.namprd03.prod.outlook.com (2a01:111:e400:7bba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Tue, 25 Jun
 2019 13:13:49 +0000
Received: from SN1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by CY4PR03CA0019.outlook.office365.com
 (2603:10b6:903:33::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.13 via Frontend
 Transport; Tue, 25 Jun 2019 13:13:49 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT015.mail.protection.outlook.com (10.152.72.109) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Tue, 25 Jun 2019 13:13:48 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5PDDl7P008734
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 25 Jun 2019 06:13:47 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 25 Jun 2019 09:13:47 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 3/5] iio: imu: adis: Add support for SPI transfer cs_change_stall_delay_us
Date:   Tue, 25 Jun 2019 16:13:26 +0300
Message-ID: <20190625131328.11883-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625131328.11883-1-alexandru.ardelean@analog.com>
References: <20190625131328.11883-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(2980300002)(199004)(189003)(8936002)(8676002)(2906002)(47776003)(50226002)(246002)(1076003)(5660300002)(2870700001)(36756003)(11346002)(44832011)(54906003)(305945005)(126002)(7636002)(2616005)(446003)(316002)(426003)(476003)(486006)(478600001)(7696005)(51416003)(356004)(6666004)(70206006)(77096007)(26005)(110136005)(186003)(336012)(70586007)(48376002)(50466002)(4326008)(107886003)(450100002)(2201001)(86362001)(76176011)(106002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2259;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 617c9b46-1cc3-46d4-e033-08d6f96ef5fb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BN3PR03MB2259;
X-MS-TrafficTypeDiagnostic: BN3PR03MB2259:
X-Microsoft-Antispam-PRVS: <BN3PR03MB225977396DA6775FD57061CDF9E30@BN3PR03MB2259.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0079056367
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: HvxIde128/y/ccbafRawvf3fBfgu1GwjWa3dyVvrB/o8cIplyCEU+/flwSmutkhAblwxPLxLKh0KXMS7oALLtZT3Au21e9hn6znxln6ZnvtvZxk7uOH3KyvfYruiUy1C8bGGMtIYvwHLkBRVczWyOGMkXefCV8RO7CS5BX1L/RoblQvMGOmSz7R6xDN2ULjAi+q1uKe3nI02122aZUHly3povuS7oy3XjOkR+XgwUWKu5QF4FwqFj4xWoODsPaQacZ3qxdjf8jBJ4X1XpSVdpSX/FIPT3/hsL7+odRyCCrI5QtkVWZxRd8Ad89GW4M64QVkY4O0vJxQ4DZW6+VN7Jf6M1Yd1+ZR1Z9ENvz5d68OANxtsBeC2o3cysrzJsjbDNuuybE1hFKY5/TdyN19N+KJ3yVmqcoxnrfnsbcbhQao=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2019 13:13:48.5155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617c9b46-1cc3-46d4-e033-08d6f96ef5fb
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2259
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250103
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADIS16460 requires a higher delay before the next transfer. Since the
SPI framework supports configuring the delay before the next transfer, this
driver will become the first user of it.

The support for this functionality in ADIS16460 requires an addition to the
ADIS lib to support the `cs_change_stall_delay_us` functionality in SPI.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c       | 9 +++++++++
 include/linux/iio/imu/adis.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index c771ae6803a9..90dac69910b3 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -40,28 +40,33 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
 		}, {
 			.tx_buf = adis->tx + 6,
 			.bits_per_word = 8,
 			.len = 2,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
 		}, {
 			.tx_buf = adis->tx + 8,
 			.bits_per_word = 8,
 			.len = 2,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
 		},
 	};
 
@@ -134,12 +139,14 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
+			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.rx_buf = adis->rx,
@@ -147,11 +154,13 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
+			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
 		}, {
 			.rx_buf = adis->rx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.delay_usecs = adis->data->read_delay,
+			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
 		},
 	};
 
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 469a493f7ae0..4aa248b6b3bd 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -27,6 +27,7 @@ struct adis_burst;
  * struct adis_data - ADIS chip variant specific data
  * @read_delay: SPI delay for read operations in us
  * @write_delay: SPI delay for write operations in us
+ * @cs_stall_delay: SPI stall delay between transfers in us
  * @glob_cmd_reg: Register address of the GLOB_CMD register
  * @msc_ctrl_reg: Register address of the MSC_CTRL register
  * @diag_stat_reg: Register address of the DIAG_STAT register
@@ -36,6 +37,7 @@ struct adis_burst;
 struct adis_data {
 	unsigned int read_delay;
 	unsigned int write_delay;
+	unsigned int cs_stall_delay;
 
 	unsigned int glob_cmd_reg;
 	unsigned int msc_ctrl_reg;
-- 
2.20.1

