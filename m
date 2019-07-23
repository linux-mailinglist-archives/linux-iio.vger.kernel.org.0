Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48446712FF
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2019 09:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbfGWHhA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Jul 2019 03:37:00 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58072 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729217AbfGWHg7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Jul 2019 03:36:59 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6N7XCTk011250;
        Tue, 23 Jul 2019 03:36:55 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2052.outbound.protection.outlook.com [104.47.46.52])
        by mx0a-00128a01.pphosted.com with ESMTP id 2twb5ju46p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 23 Jul 2019 03:36:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeGRo42riOv+xHpfgQ1IKWYvDtAATAS4bca3A2YGQMFMHJd9RGn9enUl9by67aKD8hNJA3gl9KqSpLrV7b1NiJBxhgOnxS9X2uXCD3i5PLCiFXeO0MiGC0lIIscymxbw6eyHrFctNnmFgkb178V8na2982nsreCVTOFpZfv7Y8AxjjTu2rMpUH2ysr72iEm8jej4/FvLB3UxNSpvnnt73N6rAHHZ3+wngzh8WuL26HszFEM8VVjdNvZ0Hk8XASmNuGp4xRMqfT1fOEa1sjqZukOB64dk18KX1QUtuhmh2bjhFyAPfNrRYRk0y390sx+mjP4/UYcNiQpEmSn6waPtvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8EA4U5alx8OZtfP66MG26FhlOBNXvHS+dQlMGYC3DQ=;
 b=E5dEwmv+9YCHGlrAmOg2HZLfAkuE89aRwksnJY8SL6ASmQ/dLkix2sILpMB7qUo9p8SOoHeYAoRjdXglv7O/ESnwEkY8pgRgwQF1Ojt/exz/C5FMuKq1G+cIi1k2RqADUFZ1nUUbut9mdz0ypE7DI8NZW/fuShVX686FQEn8ig/wsftukX1VbOOTmdMFZpi+pXiPg9PsfCdvoi4c52McmLVMxvZhXCkTg+HUzuTGWHC3qUOv9//skyLN9LtJVbgiModeS0TGvc46NKFb2A+Q6RLTi1Awe4V6waNNxpKZdj/GwQlcC8CKtCIMuO85663nxoHl+gWlvJz/msbOseRySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8EA4U5alx8OZtfP66MG26FhlOBNXvHS+dQlMGYC3DQ=;
 b=b8PMybOS1LOHWMK7vxY1OFIeie0uGzVoJFp66nFx/wxQNdppbismAkbGGMfVbBfG7xt7DOG7YJ9l8PeZYcBiLX1CeTWRwd2C8A/opXsNMR6uA6qI9RdvaIBp+OOF7oGrFSvYN3+IgolRygZkHs6JPFNgVuBQ7IIsnmPPHwHGdpo=
Received: from CY1PR03CA0019.namprd03.prod.outlook.com (2603:10b6:600::29) by
 BN8PR03MB4707.namprd03.prod.outlook.com (2603:10b6:408:6c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Tue, 23 Jul 2019 07:36:53 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by CY1PR03CA0019.outlook.office365.com
 (2603:10b6:600::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.16 via Frontend
 Transport; Tue, 23 Jul 2019 07:36:52 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Tue, 23 Jul 2019 07:36:52 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x6N7aoo2001487
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 23 Jul 2019 00:36:50 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 23 Jul 2019 03:36:51 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/3][V4] iio: imu: adis: Add support for SPI transfer cs_change_delay
Date:   Tue, 23 Jul 2019 10:36:38 +0300
Message-ID: <20190723073641.27801-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723073641.27801-1-alexandru.ardelean@analog.com>
References: <20190723073641.27801-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(39860400002)(2980300002)(189003)(199004)(50226002)(1076003)(8936002)(4326008)(106002)(54906003)(336012)(7696005)(246002)(26005)(76176011)(186003)(2906002)(51416003)(126002)(476003)(446003)(305945005)(8676002)(11346002)(426003)(86362001)(7636002)(2616005)(486006)(6666004)(478600001)(5660300002)(50466002)(107886003)(356004)(2201001)(2870700001)(316002)(110136005)(70586007)(70206006)(47776003)(48376002)(36756003)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR03MB4707;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc733dd5-768d-4fc3-958b-08d70f4087d8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BN8PR03MB4707;
X-MS-TrafficTypeDiagnostic: BN8PR03MB4707:
X-Microsoft-Antispam-PRVS: <BN8PR03MB470739668FC0062305B5FBA4F9C70@BN8PR03MB4707.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0107098B6C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: BCxDQju+pVOEI0Y5i6k8ePr7go+egz6xwAW6VT6xNKLLG1PS+FW/BJcgTN+1YmAJ084CqKcb+yDRbYyRaiJdFGq/0cR+wzY1v1DD9CcHH4RcB3PSsMguL2NZ3JhGqX4Fai68yjA9AFAs6uvk7Gv+hkscIZGe5JA7cAPjXnB5JmUjk1JmvVwS+UQpDr0dPUIvOWbR91kS1hEia0yce4T7sK+v9aMGwVWD7luSnJmcCnzh5rAUmRIdIftTNItGpzADiyThO6KJwA5GQmUftu4WuzyXf6c2oygFKWIY3dYYOvLOhteL/Uf6NiDGZ4Mv4ys4j8iKV7n2ffmrrYmVGYaPKmJ/CG1bqub3oDen9N4NGfI2Lea3I7redMu9swD8hAO8DeWc1WZiQ2By+uEk/GNOg3BONYY6I6zCXc6Tpvp1WrI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2019 07:36:52.6555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc733dd5-768d-4fc3-958b-08d70f4087d8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4707
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907230071
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADIS16460 requires a higher delay before the next transfer. Since the
SPI framework supports configuring the delay before the next transfer, this
driver will become the first user of it.

The support for this functionality in ADIS16460 requires an addition to the
ADIS lib to support the `cs_change_delay` functionality from the SPI
subsystem.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c       | 12 ++++++++++++
 include/linux/iio/imu/adis.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 30281e91dbf9..1631c255deab 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -39,18 +39,24 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
+			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
+			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
+			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 6,
 			.bits_per_word = 8,
@@ -133,12 +139,16 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
+			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
+			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.rx_buf = adis->rx,
@@ -146,6 +156,8 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
+			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.rx_buf = adis->rx + 2,
 			.bits_per_word = 8,
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 3428d06b2f44..4c53815bb729 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -26,6 +26,7 @@ struct adis_burst;
  * struct adis_data - ADIS chip variant specific data
  * @read_delay: SPI delay for read operations in us
  * @write_delay: SPI delay for write operations in us
+ * @cs_change_delay: SPI delay between CS changes in us
  * @glob_cmd_reg: Register address of the GLOB_CMD register
  * @msc_ctrl_reg: Register address of the MSC_CTRL register
  * @diag_stat_reg: Register address of the DIAG_STAT register
@@ -35,6 +36,7 @@ struct adis_burst;
 struct adis_data {
 	unsigned int read_delay;
 	unsigned int write_delay;
+	unsigned int cs_change_delay;
 
 	unsigned int glob_cmd_reg;
 	unsigned int msc_ctrl_reg;
-- 
2.20.1

