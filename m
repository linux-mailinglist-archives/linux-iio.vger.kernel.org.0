Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA99B1A11
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbfIMIq3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:46:29 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:64200 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387626AbfIMIq3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:46:29 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8gdsS020116;
        Fri, 13 Sep 2019 04:46:23 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2055.outbound.protection.outlook.com [104.47.50.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uytcwh98w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:46:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtyfwgaMP+33407o1/b2cOVQ8msQSqS/8uTbZl1bG+2deL7piaES700w6HSwbP23nNGjyRgcRn3584Vpb4fzzgmWmlrhFRUVZ4dn6KMBp82RHQ660S0z7H2qwBLUnvE8wUlFN29P9BQsGXLj8zr6h8XWGrrZqhHxGkAqek02mGH+jPboqONlxsB8Ktk1bz46b+GnFZ2fr0sunmpg91KDMev8rsuQG/FwujOHSyxJRr66OZEBbJsSD9hroBdY8YZTYlzH9xjhRbAz8CZHbkt27vvtR4SYeqL1V8AYRnNfOSrdShwrnf8lpFNJq7ZisW/8yvSP9jYJEBMnb14fMnNLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPQK7zz576sQdtlwSJKuqf0ppZ90iGSqdT8AmnEL2t0=;
 b=JP5EFGF5dRmJLihUJwhUpJXcjXQIZ5bmgJRH7WEgJHEi0PRbo4J3loon5af4oNHcHjVDbxDXTuNWhERhyYZfAcC7pIn7ep6xn9Se6JlJsoIz9sHJnRu7iKdt9STn2pQSHBGVI2vy5VaSiM1f26igLYVqvEi0iQNoNWcBpPqXuYMkd6LjTh4vf6gOpchg8vRktgsMiwA8z5ZZ/esa1XXq02Dy5ylRBO1H25a4gwPw5N7iBb59QRqYgL0LklJAL2J8jlJPcmuqljSv1fAWUHKyPdkDj3cXu8BYphcNUIZ4lGyY/coKRUYpSUnht1W0DQdbhDyclVAwlprr/q5XTMjlTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPQK7zz576sQdtlwSJKuqf0ppZ90iGSqdT8AmnEL2t0=;
 b=aK8RiKuWWwUdBot4J5XX+Lht/K9erq9Zckkgm49NGda7xLsWz3+INxdDvm8T428Js4wJqNvgUFWPCBo3cDyQNTzrtOYgHUsOjRzGyy4LdSqgjDkQKf8v1udPSLNqkM1ifMybe3eHinr9GiSgkeMZrfNeVX2LE79jwk0sYukcJPE=
Received: from CY4PR03CA0097.namprd03.prod.outlook.com (2603:10b6:910:4d::38)
 by BN6PR03MB2627.namprd03.prod.outlook.com (2603:10b6:404:5d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.15; Fri, 13 Sep
 2019 08:46:21 +0000
Received: from CY1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by CY4PR03CA0097.outlook.office365.com
 (2603:10b6:910:4d::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.16 via Frontend
 Transport; Fri, 13 Sep 2019 08:46:20 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT051.mail.protection.outlook.com (10.152.74.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:46:20 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8kF6d030640
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:46:15 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:46:19 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 04/15] iio: imu: adis: convert cs_change_delay to spi_delay struct
Date:   Fri, 13 Sep 2019 14:45:39 +0300
Message-ID: <20190913114550.956-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(199004)(189003)(44832011)(2201001)(356004)(14444005)(106002)(316002)(7696005)(36756003)(110136005)(478600001)(51416003)(50466002)(107886003)(48376002)(5660300002)(54906003)(4326008)(1076003)(426003)(47776003)(305945005)(476003)(186003)(126002)(7416002)(70586007)(86362001)(7636002)(76176011)(486006)(2616005)(70206006)(11346002)(6666004)(446003)(2870700001)(50226002)(8676002)(246002)(336012)(26005)(2906002)(8936002)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2627;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 528f22cb-a150-4b94-e4ae-08d73826d9a9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BN6PR03MB2627;
X-MS-TrafficTypeDiagnostic: BN6PR03MB2627:
X-Microsoft-Antispam-PRVS: <BN6PR03MB26272E58DEF3C004E9F2F299F9B30@BN6PR03MB2627.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: FuQxc3ja9yYVIKBJL0TEUDOKplqz0IXQOJS3y9emfNecIz4LmXJMJDduxwLZjC6DKLWXOkqkvw/jZajhu7Lukt+jouzpZ78wNDizN7fT8x9RVOxlQzm3OwnoKrKme/C/48N7kTFBZO8PhGKiq7tgcCLnJ+j7gyOs7IVZc/gbaj/CwFrCA0HhVI5DsFfoYR47yM6Pl+hJqDRbXjUEG2BKWH7ACLKbxffm8unFmF0hV9BSddCuqr7PZf9v39myqknGJdjyqVi/BF7LqsL22KWyaX/ezFX801Mr1m7wP76HfBrky/B9IGgEhUhUbj+Rb1QBG5JZa8VDjZ68AgdsrPMV8iyv610EmyvSZs82JXO712E9q4eKVibbhgdJjMnIGHFK8rEI7UHGpiJryMULAXGGF0p7Rb551BCYGz8fazo+dXc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:46:20.6025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528f22cb-a150-4b94-e4ae-08d73826d9a9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2627
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0 mlxlogscore=963
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130083
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

