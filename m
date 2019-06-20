Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2AC24CB26
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2019 11:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfFTJm3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 05:42:29 -0400
Received: from mail-eopbgr730052.outbound.protection.outlook.com ([40.107.73.52]:8832
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfFTJm3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Jun 2019 05:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0PVaOH+gsirioJtKnMwB8zuZ8zQabuEKQHuNYKFLpU=;
 b=32yF7BH75SvAl8PxNMDKDYgx8FTU3S94TttGLN/C1XKx3/1AhnAumPJ19tIR6eF/O4vI6IyN90sz+o5wGk/6PkPbGIgvB6pnUg6YYdy4QY3YGpNiSIbRuoUrzuX+lM9HCDLEiHkGG0yHgPOUPg+yK6SrFtNIMhAQ4JQ8aUosxDE=
Received: from CY4PR03CA0098.namprd03.prod.outlook.com (2603:10b6:910:4d::39)
 by BY2PR03MB554.namprd03.prod.outlook.com (2a01:111:e400:2c38::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.15; Thu, 20 Jun
 2019 09:42:24 +0000
Received: from BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by CY4PR03CA0098.outlook.office365.com
 (2603:10b6:910:4d::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.16 via Frontend
 Transport; Thu, 20 Jun 2019 09:42:24 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT008.mail.protection.outlook.com (10.152.76.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Thu, 20 Jun 2019 09:42:23 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5K9gNlS013273
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 20 Jun 2019 02:42:23 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Jun 2019 05:42:22 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [RESEND PATCH 1/4] iio: adc: ad7124: Remove input number limitation
Date:   Thu, 20 Jun 2019 12:42:00 +0300
Message-ID: <20190620094203.13654-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(199004)(37524003)(189003)(126002)(486006)(107886003)(426003)(8936002)(2906002)(50226002)(186003)(476003)(77096007)(316002)(1076003)(44832011)(2616005)(336012)(51416003)(48376002)(26005)(6916009)(7696005)(8676002)(54906003)(86362001)(50466002)(106002)(16586007)(70586007)(36756003)(356004)(478600001)(6666004)(246002)(47776003)(72206003)(5660300002)(2351001)(7636002)(4326008)(70206006)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB554;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a22e7fb2-ae86-45f3-7a71-08d6f5639918
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BY2PR03MB554;
X-MS-TrafficTypeDiagnostic: BY2PR03MB554:
X-Microsoft-Antispam-PRVS: <BY2PR03MB5548F5AFC16F13EDDDE64E781E40@BY2PR03MB554.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0074BBE012
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 4qhYNnkw6cKHPfXQlHA9GPcFy6I7WampVRz3Bc+Z7A9pnmyFMfilVMsfbbt4nCpxwjp0/7NG0mDiLWg+iHTFHDsqcqc+PCC+15bTy9xW/z2e7OvI/J+BRh1sKxLKTHG3ap6xLbSvUo7+nyqCtwM/F4Y6mqRd6RQomKfHWjjx2/d3iLpTzNb1jMRQhXm/jlJx6de1zw4r9eNHrAXbliJsRwD5OSYrPzLtRUOpzV7lAlSLACK2kbrlX8CtQn/A6+lEQmuWGyY9LsvUDPUl0l5XFbCUpNmmWQQt6y1SJyi2SiWNk2w05lGB/09cAeLQ1vOix7q7L8lpF0LyebGQwtaakXdB45+cPF3c5YA9sDGPLPdXWiMm4/PUpWq21a0nS5xjncpK/kURRs3yvf4pYoqWXTNPQ1FA7vPcdMaNfZl+pTc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2019 09:42:23.7538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a22e7fb2-ae86-45f3-7a71-08d6f5639918
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB554
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver limits the user to use only 4/8 differential inputs, but this
device has the option to use pseudo-differential channels. This will
increase the number of channels to be equal with the number of inputs so 8
channels for ad7124-4 and 16 for ad7124-8.

This patch removes the check between channel nodes and num_inputs value.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/iio/adc/ad7124.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 659ef37d5fe8..810234db9c0d 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -462,13 +462,6 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 		if (ret)
 			goto err;
 
-		if (ain[0] >= st->chip_info->num_inputs ||
-		    ain[1] >= st->chip_info->num_inputs) {
-			dev_err(indio_dev->dev.parent,
-				"Input pin number out of range.\n");
-			ret = -EINVAL;
-			goto err;
-		}
 		st->channel_config[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
 						  AD7124_CHANNEL_AINM(ain[1]);
 		st->channel_config[channel].bipolar =
-- 
2.17.1

