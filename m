Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CA37000C
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2019 14:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfGVMsJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 08:48:09 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:22870 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729740AbfGVMsI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 08:48:08 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MCSaQQ011748;
        Mon, 22 Jul 2019 08:48:04 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2054.outbound.protection.outlook.com [104.47.41.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tuyv3wv1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 08:48:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMLTX9c9uivfIbK7FiW1cJkPfzRIsLrzZaq/HQzHGnaA1DNWSFbyBQdwn/tIqUk+XHbFzVDq5lM/zG3sEOnadlqWF4q5dHNBE6IEXo0uYloBy++veoGjZ4t8Goy1OXh5+p6FwS0QqIkCx2ZJ5+9c2fVMqar8v3VOOnop8F49PRzPjzTQ/3IGTzr2TyetcwMZuxJVn5qXAY46oWoDhj7EfgXL2sSrNfqnXPXs3wKFMMzxmagiLRVxy+B7ebOADIkZb6RtUHJsrOPETyJJAAlhe65otEU8ZkJhN6Vzs3CvqCcP7Yri0tgoMvghTzNrM1tQhTXO7gs5OowSwsTdGThmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V4fIBUHCTK0j21QhNFUXG14rxiNRxagW6hDd3o+UmA=;
 b=KJx4gT4pvgfHQoiKLF46hlDyn8skSzLgzxVvMtOEymVL/L4HJdJMLvklypQue7dVxUns3NNweSVo80ICDovechWCwrrARjsLBjwkIJ16S7ni17UPlQ4ciDp7ee0dd7AZOPFTp4s6n7+2DtflOzqkMayG0JxyZvX21BHcbpykRuJlpPFd5qemEh2inBYFroZH9fsOQ7It9Uk7VB5L1DefAcUU/c+Sc0I7Mfep91cXECSr7ZRZ6HjRKa33XfZxQXvyJS2zs9NYRw0EmD5+yVWgLjtwG89Lj+9Eflk4SQTE5ZzDximEqdOpAa4Mz4YnGMCfTRSxW324olBLQ83gjKL8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V4fIBUHCTK0j21QhNFUXG14rxiNRxagW6hDd3o+UmA=;
 b=4pJsv1LeCulfquPono9UuUNb2IYRPMBWFrtRWcNIIBiC/raX3n1o4oc55xQuN83A6NROOP1lVPhlw47gnhjHqnZ+4pLu3qCFZr12YhpbuziSWhM5JtZMJK3VUFi2fxjOkbH5BxJcpdBn5hhIMvY6VPOtU0WC2Q79IR+1dbag2GA=
Received: from BN6PR03CA0113.namprd03.prod.outlook.com (2603:10b6:404:10::27)
 by BN7PR03MB3826.namprd03.prod.outlook.com (2603:10b6:408:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.16; Mon, 22 Jul
 2019 12:48:00 +0000
Received: from SN1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BN6PR03CA0113.outlook.office365.com
 (2603:10b6:404:10::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.14 via Frontend
 Transport; Mon, 22 Jul 2019 12:48:00 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT012.mail.protection.outlook.com (10.152.72.95) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Mon, 22 Jul 2019 12:47:59 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x6MClvvK019637
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 22 Jul 2019 05:47:57 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 22 Jul 2019 08:47:58 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/4][V3] iio: imu: adis: Add support for SPI transfer cs_change_delay
Date:   Mon, 22 Jul 2019 15:47:45 +0300
Message-ID: <20190722124747.4792-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722124747.4792-1-alexandru.ardelean@analog.com>
References: <20190722124747.4792-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(2980300002)(199004)(189003)(7636002)(36756003)(246002)(2870700001)(356004)(6666004)(2906002)(50466002)(48376002)(47776003)(106002)(54906003)(4326008)(305945005)(110136005)(107886003)(2201001)(486006)(44832011)(1076003)(478600001)(8676002)(86362001)(50226002)(51416003)(8936002)(2616005)(7696005)(11346002)(336012)(76176011)(476003)(126002)(70586007)(426003)(5660300002)(26005)(446003)(70206006)(186003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3826;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23442f37-7bca-4d4c-a1b5-08d70ea2d424
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BN7PR03MB3826;
X-MS-TrafficTypeDiagnostic: BN7PR03MB3826:
X-Microsoft-Antispam-PRVS: <BN7PR03MB38261EC3B9646A9BDECB6731F9C40@BN7PR03MB3826.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 01068D0A20
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: UII39udLyLSgndVEiGAvra9atJGogftuHNjargi8DApIQ8T3ZlQfT2OjsCfTYnlF1nFzBsbBODxbPu1OeXrepgHBYA5VhfM9jRc+00i5cdttaXj47D07GSfv9oTVxfE+3wIc6zRmSa2CnPqsYrZSn+h8HCZ1fxHGtN6YQ8MyTcgENy4dJvWRYD/G++I0dYpNa5F9GqWjYHVsMPjN2qROM7RixhXiOtTwJF+YkJ0VbmLLzJXbfseSD6uR1VPwqT/P0WLeGLGbMnnKWtbPHWtuDporau/2mIRXIdBnjXxtVytnoWREglBFviOWG68Z0/Q0T7n/LKwtiU034uLSuJJF7TZyGsj5WzUKSdMiCBnB/KFZcyqExHHHY3zOeo0antFksyPynNZ6S64yhEFS3l9rpjPUBwMIRW7nLmaPVZuZqtY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2019 12:47:59.8692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23442f37-7bca-4d4c-a1b5-08d70ea2d424
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3826
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

The ADIS16460 requires a higher delay before the next transfer. Since the
SPI framework supports configuring the delay before the next transfer, this
driver will become the first user of it.

The support for this functionality in ADIS16460 requires an addition to the
ADIS lib to support the `cs_change_delay` functionality in SPI.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c       | 6 ++++++
 include/linux/iio/imu/adis.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index c771ae6803a9..47f64a6bbc69 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -40,18 +40,21 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
 		}, {
 			.tx_buf = adis->tx + 6,
 			.bits_per_word = 8,
@@ -134,12 +137,14 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.rx_buf = adis->rx,
@@ -147,6 +152,7 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
 		}, {
 			.rx_buf = adis->rx + 2,
 			.bits_per_word = 8,
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 469a493f7ae0..fd884b45ed45 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -27,6 +27,7 @@ struct adis_burst;
  * struct adis_data - ADIS chip variant specific data
  * @read_delay: SPI delay for read operations in us
  * @write_delay: SPI delay for write operations in us
+ * @cs_change_delay: SPI delay between CS changes in us
  * @glob_cmd_reg: Register address of the GLOB_CMD register
  * @msc_ctrl_reg: Register address of the MSC_CTRL register
  * @diag_stat_reg: Register address of the DIAG_STAT register
@@ -36,6 +37,7 @@ struct adis_burst;
 struct adis_data {
 	unsigned int read_delay;
 	unsigned int write_delay;
+	unsigned int cs_change_delay;
 
 	unsigned int glob_cmd_reg;
 	unsigned int msc_ctrl_reg;
-- 
2.20.1

