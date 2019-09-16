Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2BFB352E
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 09:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfIPHKf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 03:10:35 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30424 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730419AbfIPHKf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 03:10:35 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8G77tYl014744;
        Mon, 16 Sep 2019 03:10:33 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2054.outbound.protection.outlook.com [104.47.46.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v0t293722-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 03:10:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uu/LnwZKa86YysCcFRf0bQiVeN+6qruHveGqJD5XBctNt99wG0FDOci0/8PGPTNEc3d5+XD+FZqoW+H8Y5vkdVxfxV0qtVmGM0muGKGFzJbeLbSf6x6RxcOIEMgvxUm3YFhGXlL13G2Vq3Au/AhcapQ+p9lVMD7c3qNaDQqlHvGVSpZygm2JF6TApTTzWt+kovdKJJtOjO8jeHKgNf5Sx1/RaHtq32MvWlbl1H703lZ5FLZu5BmjAwr4vm5A50JtYWjABchJQZOb7oc5sNHrYj9uTuFHcZds1evhD86+UolX74o8Ely2pndWcCKF4oRkDFmzQOv6yId9/M7ac+hVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N//v9tP42mO82MASuaLghoW7AUmfw1VhX5gXorThYfI=;
 b=VF8QrpEPq6E+DD/A/Qrox6aSqr4rgQfLlE4d0U6ao3kZ9Yn/Qnk/Yhr5MxelJ9siObbK9xgVp0EML9PsTVmYUhLKQPohabEVESe5lMPd+qe9pE/LMl1xYcrjP6BZ+pnPDYuNDjcT6vhtsVmnwzdFH98Swf5gJ3kidxMEkG2IUsXZpMtIucUUkoFiSwtQBq2GALgsmbGr/sH1EvtwcFgdnAlErN0j40af9qmWph0Ddy1ObFBm1aeqv0hYVMp75D97RE9/1QiafxnbI5w32uGTtJO/DRA1Fpyx3kpey2XOX5quDEUCMjVOXV9CAqVcQZ//oT33/pOLwQTZOCqFxQ2hiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N//v9tP42mO82MASuaLghoW7AUmfw1VhX5gXorThYfI=;
 b=uzv2qbzTwDFAScI0JgpayEjA0k83Nw0E6Mdzd9MlmjRqu96LzQ5pgx1AjvhEwMNH1/ynM62rc+KXpTD1JcRA6CCDb3I88ug3arYQTlMHnyOsBkrc+h129qj0Ao7PjaTFztGEzo+xSEPiK7M7nW0ZraNReIfHB3MEr+e+0zUUlEA=
Received: from CY4PR03CA0080.namprd03.prod.outlook.com (2603:10b6:910:4d::21)
 by DM5PR03MB2810.namprd03.prod.outlook.com (2603:10b6:3:11a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.23; Mon, 16 Sep
 2019 07:10:30 +0000
Received: from BL2NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by CY4PR03CA0080.outlook.office365.com
 (2603:10b6:910:4d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.19 via Frontend
 Transport; Mon, 16 Sep 2019 07:10:30 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT006.mail.protection.outlook.com (10.152.76.239) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Mon, 16 Sep 2019 07:10:29 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8G7AOlZ016106
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 16 Sep 2019 00:10:24 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 16 Sep 2019 03:10:29 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 1/3] spi: move `cs_change_delay` backwards compat logic outside switch
Date:   Mon, 16 Sep 2019 10:10:22 +0300
Message-ID: <20190916071024.21447-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916071024.21447-1-alexandru.ardelean@analog.com>
References: <20190916071024.21447-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(47776003)(2906002)(2870700001)(246002)(86362001)(50466002)(8936002)(8676002)(26005)(6666004)(126002)(5660300002)(446003)(76176011)(11346002)(476003)(356004)(186003)(336012)(51416003)(4744005)(107886003)(7696005)(426003)(1076003)(70206006)(70586007)(478600001)(36756003)(2616005)(486006)(305945005)(44832011)(7636002)(110136005)(54906003)(316002)(2201001)(106002)(48376002)(50226002)(4326008)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2810;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6f004eb-759f-4372-0096-08d73a74f52e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:DM5PR03MB2810;
X-MS-TrafficTypeDiagnostic: DM5PR03MB2810:
X-Microsoft-Antispam-PRVS: <DM5PR03MB2810FCF439EEEF3E4DE9989DF98C0@DM5PR03MB2810.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0162ACCC24
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: djWVo9yf9y70QUX6g5JUVw4Iaa5drOQdpbWvOEsO5KEEptPrGQsf56UPIyZ4+y2qWQItyfjB8FMNixms2rw9aMiK3xp/Wu3fsevKV1JpPkc1Ha4Ppv/ZsuPFW4oTLeeZEgcMNk59s+CxL2qsPgRzWRTNkk3AkdN+46qnsY9iuHre3FNkqxveQ40GsINrnD2KOtnHp1P13B0mQDrmge+Sorxoa45zELIaaoEzmI8gqN7QHsf5IAjqyNdoL3XYXCgcoemuZjjjFM7uUW5ZRSZLuPBfBuxvJwLCrPcyww05507N+YrIWyAwDqNiKbY0WQf6kDeIMsjDUdzwzIZL8Q5gPVBPFOuM6AOqryx15FRy35oE1QVF6DmgVZRhRXVLjpPVPQndGPYpRGtYyfvjubIoRBj2iJAt4Vk/xQwqBWmfFM4=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2019 07:10:29.9834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f004eb-759f-4372-0096-08d73a74f52e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2810
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_04:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909160077
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The `cs_change_delay` backwards compatibility value could be moved outside
of the switch statement.
The only reason to do it, is to make the next patches easier to diff.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 75ac046cae52..c90e02e6d62f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1114,16 +1114,15 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 	u32 hz;
 
 	/* return early on "fast" mode - for everything but USECS */
-	if (!delay && unit != SPI_DELAY_UNIT_USECS)
+	if (!delay) {
+		if (unit == SPI_DELAY_UNIT_USECS)
+			_spi_transfer_delay_ns(10000);
 		return;
+	}
 
 	switch (unit) {
 	case SPI_DELAY_UNIT_USECS:
-		/* for compatibility use default of 10us */
-		if (!delay)
-			delay = 10000;
-		else
-			delay *= 1000;
+		delay *= 1000;
 		break;
 	case SPI_DELAY_UNIT_NSECS: /* nothing to do here */
 		break;
-- 
2.20.1

