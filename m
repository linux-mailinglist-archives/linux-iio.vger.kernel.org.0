Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4F1DF9477
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2019 16:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfKLPgP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Nov 2019 10:36:15 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:63052 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727069AbfKLPgN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Nov 2019 10:36:13 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xACFNqpX025476;
        Tue, 12 Nov 2019 10:35:47 -0500
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2058.outbound.protection.outlook.com [104.47.33.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w7prk91v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 10:35:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Grr9YqRtBnu7Vw/wUNBvvYhml49rtNfs4mz9gBlYcN9DjXRa8MCgDdcRL6s+9tUc/+ns8zbclRJjVz6VU9mwsI/5ieEl2TXdxYCVx12HYsYlZRVbk/lGBWRv0SfbSIaN1eHjQGhG6VZMVnNaoXrhIPP+E2oytI/OKKl70lcya3Sa3cNXBOmysCtAt5O4AfTc1pDrmlZh09TGHJKrvbVHcEdGrYDiC9r2yd/hgQMTg09qo8PT4BRxCD6PFja313/DilLHSLjghykg0khpwkSP4Mi8VC+0a2PbkSNpFdv2i+3P0f0p0cdpnE1STOR1ZFuqTvJ1k5ddSu5vCycm7yHWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQAKrxZtjG+3o2Lsn9HApsW4np8WSar24UvdmiYG9rU=;
 b=nM8QeoMu01QWUOkN6//FZ6EadWGm5Ud3X7R5k9wcwrdRUsoBk/Oruvv/3UZZ9RYn5E/Umyx4KUvrRra4fT4SCwJ2pDR8di3Rz9osPPq1XyGmKL2rXxHWfMIJWLq/g0Jgd55aJEWT7ZJTxRf+ze3f+esaEcnrV//adayTtN5qSm/RBl9nVq77bVWNv3uG1IpytqCggoHHC0xrsz5Og88czm8wF5bJj59wPtBUHDQ8+y2x7zc7BNofK+J+0f8EFTeE/JEGMrHbpHqMV0RUYuEiI5Ph5kXl+Vv78rH0iEhaYiW14Bob8421hVZ47Ixw3rN2UP15fKh/ruI0jU+VKAiqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQAKrxZtjG+3o2Lsn9HApsW4np8WSar24UvdmiYG9rU=;
 b=KbzHN2v44wL7kWCHF3NvcQ2ob1eRPKg0f4WppoAn4sb9y4LwOkHfuB0w92bd8oNYwVtDtn/ndobtBmu6BbajMWHBsN+xyDMcf8Jp3Uvh8trB+dP1/lQ4Y60rtcSZfn/ZVpd+03tMTjKQbewAky1p/SBNfl4YDiXu+DJvK+9vi+M=
Received: from CY1PR03CA0040.namprd03.prod.outlook.com (2603:10b6:600::50) by
 BN6PR03MB3170.namprd03.prod.outlook.com (2603:10b6:405:41::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 15:35:45 +0000
Received: from CY1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by CY1PR03CA0040.outlook.office365.com
 (2603:10b6:600::50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Tue, 12 Nov 2019 15:35:45 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT050.mail.protection.outlook.com (10.152.75.65) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Tue, 12 Nov 2019 15:35:45 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xACFZajO012488
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 12 Nov 2019 07:35:36 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 12 Nov 2019 10:35:43 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <paulmck@linux.ibm.com>, <mchehab+samsung@kernel.org>,
        <linus.walleij@linaro.org>, <nicolas.ferre@microchip.com>,
        <biabeniamin@outlook.com>, Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 3/3] MAINTAINERS: add entry for ADM1177 driver
Date:   Tue, 12 Nov 2019 17:35:52 +0200
Message-ID: <20191112153552.27431-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112153552.27431-1-beniamin.bia@analog.com>
References: <20191112153552.27431-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(189003)(199004)(107886003)(7416002)(4326008)(70586007)(50466002)(76176011)(50226002)(1076003)(44832011)(36756003)(8936002)(186003)(246002)(478600001)(8676002)(5660300002)(48376002)(4744005)(70206006)(51416003)(336012)(26005)(7696005)(54906003)(476003)(426003)(966005)(6306002)(2906002)(446003)(126002)(2616005)(7636002)(2351001)(356004)(6666004)(16586007)(316002)(486006)(86362001)(6916009)(11346002)(305945005)(47776003)(106002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3170;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f42b5e02-6b57-43db-a244-08d76785fc02
X-MS-TrafficTypeDiagnostic: BN6PR03MB3170:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BN6PR03MB3170C33B6A0B02441148C2B8F0770@BN6PR03MB3170.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 021975AE46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNRNutGp1eNy7N5ZlWhQlZzO1+YKevrkg3ig3BxC+2T+MGTdvCkb9v8UmnUPBRi0eF6lc+27TNfRIgRFsfYwt/WY3OqxD+2Hew01gd+Ek6N/ssdFaPE+wV2rCSlPtKAlVT572VueEZt9rvtsfW5meyrMRkhP53Vu7/jdtZ2oxlmz09hb+myyJpcycpurj1SHcRVEu1ZljKD4uS6R1AsWq13afaODn8CftXZRH26x5AxRT1eqjdggcrOgQWkqeTPqpOEVLdXWdVk6DdfXRB7Yc2NpvQOskCkzFh6v6zZTOTYXAZ2myG2zd+XGbFz9LIsIG35ffaxywN3Pr/trPzcG4JLqgqxsYW55yYRDetf8hL6i0Tw2G/LYW/xVTgop5pm61MgoaoenwiC4xOM/XJJBgKz+uFsSuS2OhLrwYeoJcfXvt/iLaqbjUwCFVB5coQw8/rvZBYeB+HEQJmVXfVYo4NI0o6o/4bmyT3gqEYT4R2U=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 15:35:45.1025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f42b5e02-6b57-43db-a244-08d76785fc02
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3170
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-12_05:2019-11-11,2019-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 suspectscore=1 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911120134
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add Beniamin Bia and Michael Hennerich as a maintainer for ADM1177 ADC.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fca3b055985..41a34d7a802c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -962,6 +962,15 @@ W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/iio/imu/adis16460.c
 F:	Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
 
+ANALOG DEVICES INC ADM1177 DRIVER
+M:	Beniamin Bia <beniamin.bia@analog.com>
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/adc/adm1177.c
+F:	Documentation/devicetree/bindings/iio/adc/adi,adm1177.yaml
+
 ANALOG DEVICES INC ADP5061 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
 L:	linux-pm@vger.kernel.org
-- 
2.17.1

