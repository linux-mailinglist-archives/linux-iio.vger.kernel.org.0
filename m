Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4F46BBDF
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2019 13:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbfGQLvn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Jul 2019 07:51:43 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:39836 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbfGQLvm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2019 07:51:42 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6HBlwUq024285;
        Wed, 17 Jul 2019 07:51:37 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2057.outbound.protection.outlook.com [104.47.37.57])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ts491myv5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jul 2019 07:51:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DM2F/SGhhBRLxaLsWkyr5MTq0lSrcnKnPTmnoojl25GtHwfoDZv08NIsx/zBvFDoHzoyZDCtxskJhXmwuNkpUV1szOto3tcuB8/tJdG9T2jjwtP0NKIcFZOO3KSG3J2JBQNC/rbAQXVnM0GoYUEz5kzRTVSmKHxxFb275WEqVs3Zqrw8Da78hTg8uxv5mtuumO5gYbj7mYwt6agbA9ujPTbikySTS1Q95qYGFlE/JbIsOtTcWcJwlOtmUGk349casctvK2w3zQe1cdGj2WBDnAAFb3LcTWyaBHPwaMmuUblVYyB4JpMzKYsFWqxqLP/ojFMnaOkNKhEuoypM5vbkXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE+BnInK8aoK7ZmKElVQFCx9SV4eUVXn2ynkPMPbvD4=;
 b=amZ+oNvFXmZlGgJZKe8Aa2FSaPPKJvMzmnEsHnLZf1cU64GfEcL8O5fuv093am3v1SH+IWIk8Tw1mDwFCdjy5coZtg5dGG9AZcgDBoQtg1PKcToo8d0i2eD7QxtGLBq+UsyAR4RRD+dcB+lEUe/noSEHtLYJo0LzvuQsAqHrBibOo63WksWnU22Zl9B6lQTiYMf8hdIS9z768lgjrvBE5l3eiPNhjf7sOP1E9c4kDT/xklAE4gdnT811V9aVq7vQ6SohPJP6LVY4WCmRAXRcbQqF72H8QaSs79R6LLt+MsZGhZ8CPDEYxK6cKtcr1HCz9EuNRO1NZlUZIiLpKF8wWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE+BnInK8aoK7ZmKElVQFCx9SV4eUVXn2ynkPMPbvD4=;
 b=M1VtI3cN3nothq8zAUWP+TOYYX9s13fCOqVRT7mbqiL3XcGoU/gY1DBoQZysQS6TcAt82XD+DTIk1tddNIbaZmpYqu0Cy83dc45AXIWuBRSbU0/gwnQWZ0HRjKaiQZCXK90U/K7tyTE8JfVEuGxJg1g6gYz8PVazQ7OCI4aMFio=
Received: from BN3PR03CA0075.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::35) by MN2PR03MB4718.namprd03.prod.outlook.com
 (2603:10b6:208:ae::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.10; Wed, 17 Jul
 2019 11:51:36 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BN3PR03CA0075.outlook.office365.com
 (2a01:111:e400:7a4d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.14 via Frontend
 Transport; Wed, 17 Jul 2019 11:51:36 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Wed, 17 Jul 2019 11:51:35 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x6HBpZGe003296
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 17 Jul 2019 04:51:35 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 17 Jul 2019 07:51:34 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/4][V2] iio: imu: adis: Add support for SPI transfer cs_change_delay_usecs
Date:   Wed, 17 Jul 2019 14:51:07 +0300
Message-ID: <20190717115109.15168-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717115109.15168-1-alexandru.ardelean@analog.com>
References: <20190717115109.15168-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(199004)(189003)(2616005)(7636002)(426003)(356004)(70206006)(476003)(106002)(8676002)(1076003)(126002)(107886003)(305945005)(446003)(36756003)(70586007)(2201001)(6666004)(336012)(48376002)(486006)(11346002)(246002)(8936002)(478600001)(316002)(44832011)(47776003)(186003)(26005)(86362001)(50226002)(2906002)(110136005)(2870700001)(7696005)(5660300002)(54906003)(51416003)(76176011)(4326008)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4718;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f152b794-df41-4a76-4f24-08d70aad1ee6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MN2PR03MB4718;
X-MS-TrafficTypeDiagnostic: MN2PR03MB4718:
X-Microsoft-Antispam-PRVS: <MN2PR03MB47186CB8960589850DC87E23F9C90@MN2PR03MB4718.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 01018CB5B3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: hBxW+RJwUS4QYKlBT6uOH0FSp1uG0fHa/WlWaB9aScBmyN87sDAflzPs4bmbk515Bdua/L69ZOtB4Fu7f1MZf2Ml/AZAPbUThtAhoN1/S+ik1FxRyui7XEBOmqailWwatDj3aEnEqf0sDzZp3STRIg5pcRTJ4RfAW52Ln7Dv5QGlfyBQZLD7HQXLJe5TBkWCVobPOWYYC7jA2m//CBIthEzqt8V02t98QlTdAi0BFZNK4dGRtvl3KmH6c3sb5UzGjOh3ZRrRydF1jVDtmxXGaClX8EHZrxs+Z9Jkrm6FalXHIK0PhuTJdWm3TiaZRJ0/g6GZV4kaw2IjSCiwkP6cAXIE32pLy8kqEnK/5uTyCIhUxnw1/yi6rEecftGSDm+jdeDj8MoZY/0y6LDRusIR+/KzaxuVyJY9IUq6rIoh1Zk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2019 11:51:35.6461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f152b794-df41-4a76-4f24-08d70aad1ee6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4718
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907170145
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADIS16460 requires a higher delay before the next transfer. Since the
SPI framework supports configuring the delay before the next transfer, this
driver will become the first user of it.

The support for this functionality in ADIS16460 requires an addition to the
ADIS lib to support the `cs_change_stall_delay_us` functionality in SPI.

Not all transfers set `cs_change` to 1. Only those that do, have the
`cs_change_delay` assigned.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c       | 6 ++++++
 include/linux/iio/imu/adis.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index c771ae6803a9..6fdb6f4cebd4 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -40,18 +40,21 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_delay_usecs = adis->data->cs_change_delay,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_delay_usecs = adis->data->cs_change_delay,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_delay_usecs = adis->data->cs_change_delay,
 		}, {
 			.tx_buf = adis->tx + 6,
 			.bits_per_word = 8,
@@ -134,12 +137,14 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_delay_usecs = adis->data->cs_change_delay,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
+			.cs_change_delay_usecs = adis->data->cs_change_delay,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.rx_buf = adis->rx,
@@ -147,6 +152,7 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
+			.cs_change_delay_usecs = adis->data->cs_change_delay,
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

