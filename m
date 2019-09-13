Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56F57B1A4A
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbfIMI4L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:56:11 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:43636 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387765AbfIMI4I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:56:08 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8qmLk021615;
        Fri, 13 Sep 2019 04:56:07 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2059.outbound.protection.outlook.com [104.47.50.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uytdksakr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:56:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaRlKdaT2KAyabtMGAZL5q1K6V7NOxOKB7qs2wE2Mrhmc4s4NyYsMZ+cA8JaDG2YH7hYXVPM3jYC8/bMV3o/wRBSZWMq7FEKIZp0QzIp/1e5PcytksYndP5WcARL0F4BiuKzL+/fQ7efDP8Hp4JAdiSyN7Y+Yh/o2JfStI4pE3IWRwReRRbsHby+ZNbnwVLEZM0dJYc8bGfDMF7/E2pRv1MaoRbIsokGTIwT6FayApk17GH8rntMUkJz8GE4db+fSR9ZyPovYxs8vnm4+y7FQ/LJKwlRiPJa9v6GEk9/UdhjDGw1/VOLOhWu6GUSdAjQJNNgDGXjcidL9WtfeE8LEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPQK7zz576sQdtlwSJKuqf0ppZ90iGSqdT8AmnEL2t0=;
 b=HmSG6PnPWpbNSJNlRM7qv6c3N6I48lWqx4FZw/8zgfPuIFSJEV8VWy+eOJySqHQFrZVDqFNGy+tUjGW0496SKGrkSBZSXPP5Utgr+80O537Ctm6ib4BYQQ7N7ennhgJicRXN8DXPs+7fJIhgXvSrNipM/iTxjU5Di983or/GbjxUKXht80N1CHo1+EmuXq4gLSi4N6JxnpgqkiGezroyk0WNemSP6qypedhEJ+peqgiPQ9gUYgnfQmDvKew6z0v55BM8ypbSOQRHgYGv4DGDmxFs/2vyQgv3oA+hSJsoLjcIPX0s80ieR0/61A8LWSrzDLnCI95A+oMgFFhPzwpjVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPQK7zz576sQdtlwSJKuqf0ppZ90iGSqdT8AmnEL2t0=;
 b=N7u+eY4o6JA8pSFgDx6CCSE3RtzodgE+JM33OTxF+CDFn6dpCShzWr1ZApyBrJS2DwuqKtyRr+hbkhRWuCw/isA7i9WrfqEgJ+5ySu+ku35wBJyqq8nLhbasTvTLQ8rpbBGvK850w6TL8TjklO8kO+tKFf92urUS0etubxsc/Ho=
Received: from BY5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:1e0::11)
 by DM6PR03MB3721.namprd03.prod.outlook.com (2603:10b6:5:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Fri, 13 Sep
 2019 08:56:05 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BY5PR03CA0001.outlook.office365.com
 (2603:10b6:a03:1e0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.13 via Frontend
 Transport; Fri, 13 Sep 2019 08:56:05 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT006.mail.protection.outlook.com (10.152.74.104) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:56:04 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8txpi000419
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:55:59 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:56:03 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 4/4] iio: imu: adis: convert cs_change_delay to spi_delay struct
Date:   Fri, 13 Sep 2019 14:55:49 +0300
Message-ID: <20190913115549.3823-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913115549.3823-1-alexandru.ardelean@analog.com>
References: <20190913115549.3823-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(199004)(189003)(356004)(2906002)(2201001)(50466002)(4326008)(76176011)(70586007)(1076003)(54906003)(478600001)(48376002)(476003)(336012)(26005)(246002)(86362001)(107886003)(186003)(50226002)(5660300002)(126002)(2870700001)(8676002)(6666004)(14444005)(2616005)(486006)(36756003)(106002)(70206006)(7636002)(47776003)(51416003)(44832011)(426003)(316002)(305945005)(446003)(7696005)(8936002)(110136005)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3721;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 293636f8-4e58-49b2-292c-08d7382835c2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:DM6PR03MB3721;
X-MS-TrafficTypeDiagnostic: DM6PR03MB3721:
X-Microsoft-Antispam-PRVS: <DM6PR03MB372190193016E396BC84A282F9B30@DM6PR03MB3721.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 64/3SaMkj6MtWmQ03k+0WZGWrDuWMnOrX3y3Ei/N4dcsXeqb6XCD3pU6eT3X82GONyeVoVlq9WFFnIkNqkl5+AnqGJug0/KHdTjUBx9As8WmBO3TfpGqQNNI1nIiwpEzgqqTsuFwtS3UhA8XybW062eH/8osr8lhATMhd8TUX0clL3G1bT5egRf9cTyH78vAb6A7LM2p1w1286adVaQRXAOcNC//rFwSHV0pD2ADWkiVeaoYS9h6sB/rMCiWx05LU09MruqOkTRqwQMi7RxkrD+8MLKvUtHADegshJJUed/ZeFK0gqFLP9oPloVi1oM5dp9cU3ntz2a133XzLXMaweg/ZRgroHI1+14Wh7oMb1k6CAM0MegvKCzlutTVjJNwNOls7sLmpZ9gzcVqRv7xYPs7z+bKWhNZaSwoGRD/gXU=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:56:04.6607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 293636f8-4e58-49b2-292c-08d7382835c2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3721
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=945 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130085
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADIS library is one of the few users of the new `cs_change_delay`
parameter for an spi_transfer.

The introduction of the `spi_delay` struct, requires that the users of of
`cs_change_delay` get an update. This change updates the ADIS library.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 1631c255deab..2cd2cc2316c6 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -39,24 +39,24 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 6,
 			.bits_per_word = 8,
@@ -139,16 +139,16 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.rx_buf = adis->rx,
@@ -156,8 +156,8 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.rx_buf = adis->rx + 2,
 			.bits_per_word = 8,
-- 
2.20.1

