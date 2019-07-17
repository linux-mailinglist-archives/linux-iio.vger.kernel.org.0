Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B2F6BBE2
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2019 13:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbfGQLvp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Jul 2019 07:51:45 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:41226 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732069AbfGQLvo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2019 07:51:44 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6HBltG5017441;
        Wed, 17 Jul 2019 07:51:40 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2051.outbound.protection.outlook.com [104.47.33.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2tseucbkm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Jul 2019 07:51:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7rsgUffCHonLARLLGKlqLwfQq0rtU5msVQFvgSX7rUTveL364nFDqUXPKvR4HgRqy5E6F65e85pBDjfBPpk3rw5MM9QxcrsDi7X5yGwD6VgsPtHdu9VS7/XiIUqwBL1ruy0861ClO23sLSOzt9tL6zpiaktRJ+W9WH0TLg/+r5oMkxu18jEu+WkG88dQDh2nks6IVEotaTdYutlpdsdKWkbcyk1Jvsyn5pXD2IML1XhWIIaxUH2Gc1vz/tFwVgY5TQq7/1M+XSNy+l+OE0XGbqcapulpIHMH9JW4j+yJtYxdifWNk1rvGpV2Un+d7WcrwREjmlop2d1H7+089EGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IW4/S+Z58ajiJ8VrWqHdQHBIbMMvua9x5tt1atnyR8=;
 b=SMUpbDe8C5p6tiezTMdKvOXfLCATJRyddPZmPzsSqN08fLI4GAbt/Waw32MreXv4aAlEpItVYj1rF8VIrHQ7kqAgxyYign1VAlgQsOYPAhbMQXyUd/fUPpCUJ7wSo8njVDgSsj7ui5MhM6lK9GPaXXxi+R3aQgeDWCDTzAcJvnGv4IQzNf8nxkZqkA6QVWf9mVV7/aMdbaHkpW3a98lmii11wLp/7AiGO8cs2jqwgXKgqly3R4E50M3FsRERCnMzOAswFyMWkGS4UvDuQTnrEl4fg4S9i3+UFEkop0Op1lcKL+kEihl2JCblQDFHNfqMkydXTwXPeekQRdUnHoO/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IW4/S+Z58ajiJ8VrWqHdQHBIbMMvua9x5tt1atnyR8=;
 b=fqXu3x/3TteBNbTiCCdGF8TOks2Be+Hk3ACyNm1ohSS9c0QumUpwDQ+4cfwB2hK8LhJGTgJImG49lcK2XL65Uk1Q42kt5TjV0vIGlKeARptiGRcmEWqYyZI9D0Qem31W68WtNtTiHn+bmsyhFlF32961QDxY6kZazV+SD1gyi74=
Received: from DM6PR03CA0008.namprd03.prod.outlook.com (20.176.118.149) by
 MN2PR03MB4720.namprd03.prod.outlook.com (20.179.81.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.11; Wed, 17 Jul 2019 11:51:38 +0000
Received: from SN1NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by DM6PR03CA0008.outlook.office365.com
 (2603:10b6:5:40::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2073.10 via Frontend
 Transport; Wed, 17 Jul 2019 11:51:37 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT042.mail.protection.outlook.com (10.152.73.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Wed, 17 Jul 2019 11:51:37 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x6HBpXt0003269
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 17 Jul 2019 04:51:33 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 17 Jul 2019 07:51:32 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/4][V2] drivers: spi: core: Add optional delay between cs_change transfers
Date:   Wed, 17 Jul 2019 14:51:06 +0300
Message-ID: <20190717115109.15168-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717115109.15168-1-alexandru.ardelean@analog.com>
References: <20190717115109.15168-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(2980300002)(199004)(189003)(70586007)(2201001)(305945005)(5660300002)(2906002)(11346002)(476003)(2616005)(336012)(446003)(70206006)(246002)(110136005)(126002)(7636002)(54906003)(86362001)(4326008)(486006)(14444005)(106002)(426003)(8676002)(1076003)(48376002)(47776003)(186003)(44832011)(6666004)(356004)(50226002)(50466002)(76176011)(2870700001)(8936002)(7696005)(51416003)(498600001)(26005)(107886003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4720;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1405b5a3-7239-4ed1-e6c1-08d70aad1fcb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MN2PR03MB4720;
X-MS-TrafficTypeDiagnostic: MN2PR03MB4720:
X-Microsoft-Antispam-PRVS: <MN2PR03MB472043F2F319CE06688FF160F9C90@MN2PR03MB4720.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 01018CB5B3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: m4MLuob3EGFJvehUPdvucyM7Umn+m4PtdZzZaVRoIN/rrxvJXggCh4Gp+tX0HdybCRAn+wjNsn+ZCfKm9cD5BkU1fD3w3j3xq0XKOJBQcI0OA77+ItP+DYV9bDOQ0VjuYq71zRQs0KnVCXsCigevKAuRDmpejAbYz2CiD5i87A1nH5NJgJ1ROiaPeaqFoWxoqF6dNO5mfs1Bhhn/z0uMWsReYLTwvXQm84yPcsFyxSUdYLHPkk/b+mnL72olZThOy5UjcJGBDYQMNMNlWJsUVqKAklZEUW36oOzQA52TAASiBWe7U5F4k+OHxKbfKdzb7klkixnXtVi1T30ktuXZfgBBMeUgkVp6uYtbBzs+KceNA7eGXUiI6AxLHR8ZNhNaBcEdBa7urBsRBJU2fUqXqFfNpqdYprVJmLdbXkHquJM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2019 11:51:37.1387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1405b5a3-7239-4ed1-e6c1-08d70aad1fcb
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4720
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

Some devices like the ADIS16460 IMU require a stall period between
transfers, i.e. between when the CS is de-asserted and re-asserted. The
default value of 10us is not enough. This change makes the delay
configurable for when the next CS change goes active.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi.c       | 3 ++-
 include/linux/spi/spi.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5e75944ad5d1..02fd00bcaace 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1163,7 +1163,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 				keep_cs = true;
 			} else {
 				spi_set_cs(msg->spi, false);
-				udelay(10);
+				udelay(xfer->cs_change_delay_usecs ?
+				       xfer->cs_change_delay_usecs : 10);
 				spi_set_cs(msg->spi, true);
 			}
 		}
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 053abd22ad31..c884b3b94841 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -734,6 +734,8 @@ extern void spi_res_release(struct spi_controller *ctlr,
  *      transfer. If 0 the default (from @spi_device) is used.
  * @bits_per_word: select a bits_per_word other than the device default
  *      for this transfer. If 0 the default (from @spi_device) is used.
+ * @cs_change_delay_usecs: microseconds to delay between cs_change
+ *	transfers.
  * @cs_change: affects chipselect after this transfer completes
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
@@ -823,6 +825,7 @@ struct spi_transfer {
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
 	u8		bits_per_word;
 	u8		word_delay_usecs;
+	u8		cs_change_delay_usecs;
 	u16		delay_usecs;
 	u32		speed_hz;
 	u16		word_delay;
-- 
2.20.1

