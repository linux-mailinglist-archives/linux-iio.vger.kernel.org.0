Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6470421940
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2019 15:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfEQNhZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 May 2019 09:37:25 -0400
Received: from mail-eopbgr760047.outbound.protection.outlook.com ([40.107.76.47]:51125
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728464AbfEQNhZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 May 2019 09:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6sIxOdqeWZpFgG+qFujUPCAL2x+gDxelIXKocjn8xw=;
 b=9C3LyRFSI7RwnM4fPNh/h1Dqkft9Qh6KnFrd2fQ94/BxYjlqdQpYB0aFZ5nTLryDPnjV3QvWjeEuLFaftp3Ow7IGxjAwUSwGV6TCx9t7P+OvY9oeVPiHh5Lm1aQyiubFrVLacU406kTFj/8US3bwZC9BIu0y7KtQrlgcVQ6DM5c=
Received: from DM6PR03CA0051.namprd03.prod.outlook.com (2603:10b6:5:100::28)
 by DM5PR03MB3131.namprd03.prod.outlook.com (2603:10b6:4:3c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.16; Fri, 17 May
 2019 13:37:21 +0000
Received: from SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by DM6PR03CA0051.outlook.office365.com
 (2603:10b6:5:100::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.17 via Frontend
 Transport; Fri, 17 May 2019 13:37:21 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT027.mail.protection.outlook.com (10.152.72.99) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Fri, 17 May 2019 13:37:20 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x4HDbJ1c000587
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 17 May 2019 06:37:19 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Fri, 17 May 2019
 09:37:18 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH][RESEND] iio: ad9523-1: Improve reported VCO frequency accuracy
Date:   Fri, 17 May 2019 16:37:11 +0300
Message-ID: <20190517133711.21266-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326132658.16724-1-alexandru.ardelean@analog.com>
References: <20190326132658.16724-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(2980300002)(189003)(199004)(51416003)(107886003)(7696005)(76176011)(4326008)(44832011)(70206006)(356004)(6666004)(8676002)(106002)(246002)(8936002)(50226002)(336012)(70586007)(48376002)(2616005)(126002)(86362001)(476003)(486006)(50466002)(426003)(446003)(53416004)(54906003)(11346002)(478600001)(316002)(16586007)(5660300002)(2906002)(47776003)(6916009)(305945005)(1076003)(2351001)(7636002)(26005)(77096007)(36756003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3131;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f58131c3-405c-42fb-5ad0-08d6daccc99b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:DM5PR03MB3131;
X-MS-TrafficTypeDiagnostic: DM5PR03MB3131:
X-Microsoft-Antispam-PRVS: <DM5PR03MB31314CC5BE97B89637F53BD9F90B0@DM5PR03MB3131.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 0040126723
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: LMLShmQfPIPUtrzqk9uklPfADmmyDWkWg2sX3lqlh72SWgZ2MQnfv770b7AHxX25CN8+flfl6Dg56mBSE5uqqxI6z7cmz+XPjGd+yhi+7fMPQ0ZGP3fMOOdwG1KvVQW3zuXo1lN0CwjYPKEXSCJ+qNH8mGW9lsEELh2S2bCSqihLreigZTb22HpMVDvrGWhJbJemWSZ1l/52fy2FCmjuFTJIWeBJir/XLqB9u8F7I9XWgblGVWCIg0pf5WwG0TtsJE8MDerWnGpl0Y3ECk4hYp+LlxECluZg87J1rh5gAWPRFJOy8B0XkUVFGV0ZgXOu0jvcsJelPZY+UHYdBDpyl7NzEV0shdktV5/JIL0RzC1rvmfG9JIVKvWhhaGxT/7nsAXKL7lMYnysSIFIbwpHRBsFIs3X/Yw+T0Hf4StuP4o=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2019 13:37:20.1342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f58131c3-405c-42fb-5ad0-08d6daccc99b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3131
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

To improve the accuracy of the reported VCO frequency perform all
multiplications before divisions. This reduces rounding errors and makes
sure the reported rates are accurate down to the last digit.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/frequency/ad9523.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 246e38d76eff..541cb5975dd9 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -1140,9 +1140,11 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
-	st->vco_freq = (pdata->vcxo_freq * (pdata->pll2_freq_doubler_en ? 2 : 1)
-			/ pdata->pll2_r2_div) * AD9523_PLL2_FB_NDIV(pdata->
-			pll2_ndiv_a_cnt, pdata->pll2_ndiv_b_cnt);
+	st->vco_freq = div_u64((unsigned long long)pdata->vcxo_freq *
+			       (pdata->pll2_freq_doubler_en ? 2 : 1) *
+			       AD9523_PLL2_FB_NDIV(pdata->pll2_ndiv_a_cnt,
+						   pdata->pll2_ndiv_b_cnt),
+			       pdata->pll2_r2_div);
 
 	ret = ad9523_write(indio_dev, AD9523_PLL2_VCO_CTRL,
 		AD9523_PLL2_VCO_CALIBRATE);
-- 
2.17.1

