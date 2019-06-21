Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9DEC4E82C
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2019 14:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFUMll (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Jun 2019 08:41:41 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:39554 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbfFUMll (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Jun 2019 08:41:41 -0400
X-Greylist: delayed 1629 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jun 2019 08:41:40 EDT
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LCBv8Q030677;
        Fri, 21 Jun 2019 08:14:08 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2059.outbound.protection.outlook.com [104.47.40.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2t8sds0xmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 08:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X91dMQEGH5GLZk0n/ybG6EnOO6L0apGOYu0vVuRHnGc=;
 b=pm2I3JO7gF97WHlmpsngIjXN0lIiRP8AdOXrhMw9T9Tpv4lz9whS3d8qwQBQ98LDBBM1oPUee5jl5iGRvuSOVXdq8mdVsf/G048uBE0skLhJ7bSrjPPAFRfrsnxrWTF1sBlK1Nw1uqdraE4feRre0myKZIdUDLPPUfSukOIUGDo=
Received: from DM3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:0:50::33) by
 CY1PR03MB2268.namprd03.prod.outlook.com (2a01:111:e400:c614::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.11; Fri, 21 Jun
 2019 12:14:06 +0000
Received: from CY1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by DM3PR03CA0023.outlook.office365.com
 (2603:10b6:0:50::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.15 via Frontend
 Transport; Fri, 21 Jun 2019 12:14:06 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT022.mail.protection.outlook.com (10.152.75.185) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Fri, 21 Jun 2019 12:14:05 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5LCE4of023484
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 21 Jun 2019 05:14:04 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 21 Jun 2019 08:14:03 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V2 1/4] iio: adc: ad7124: Remove input number limitation
Date:   Fri, 21 Jun 2019 15:13:41 +0300
Message-ID: <20190621121344.24917-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(2980300002)(37524003)(189003)(199004)(54534003)(16586007)(2906002)(1076003)(356004)(6666004)(7636002)(106002)(36756003)(305945005)(107886003)(246002)(2351001)(8936002)(50226002)(4326008)(54906003)(8676002)(316002)(48376002)(6916009)(47776003)(426003)(486006)(44832011)(476003)(2616005)(126002)(336012)(7696005)(51416003)(478600001)(50466002)(186003)(5660300002)(26005)(77096007)(72206003)(86362001)(70586007)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB2268;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eba68a76-0a9d-4fc2-c9ad-08d6f641f4f7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:CY1PR03MB2268;
X-MS-TrafficTypeDiagnostic: CY1PR03MB2268:
X-Microsoft-Antispam-PRVS: <CY1PR03MB2268BA7DD3DDDDB74E3FB07F81E70@CY1PR03MB2268.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0075CB064E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 11ChL5nLvaEUu50LeXnkOwBcyeTDceCJ7/B7Xu7IZJNqKkK/tKmMzfZVYZyaoSoWlKJJ9MlmKJIp0Ja+ZCglBaMrgOaX9oyLlTgS4qW04jsIYYyYBxJr+jrrW+jbFW8MAYRJG5RYDBZXuErriZ8pkCXTpHXAcmc38etTYMsqyBOxF0PYLuG68Gx9YXIy7hixFidC1r2Venjfmz5UAv7+D0E9NkpOmwQ4tuwrXbPpjMY7JuSneKhz3W7wlG1eStiaR3PKGzNNWW9flh2dYWHMY449KgDOlJSmXfJ0blsWmTcaJ317TrW/iLGwY3dpJ8PDpQNEHA8mRddzugpm2AAeXwCc9FxWZE7oJfNnUyLXSCMroa3zeeY8VRbjPgES8pm8D+YpKdVG1oGjiYshu2fgPieceyE63Iapum6SBZr4+6s=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2019 12:14:05.7366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eba68a76-0a9d-4fc2-c9ad-08d6f641f4f7
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2268
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=822 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210104
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

Changelog v2:
- nothing changed here

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

