Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E152B5262C
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2019 10:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfFYIMV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jun 2019 04:12:21 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3238 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727334AbfFYIMU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jun 2019 04:12:20 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P87rto022159;
        Tue, 25 Jun 2019 04:11:56 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2054.outbound.protection.outlook.com [104.47.50.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2t9e63g85k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 04:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2yFNqSWPA88bhJY87R7OkWuNnO+NH0Z8F+kG+gskp4=;
 b=L073qKFQ4GH5h0altFWlUDQiHOKaLn3Q473debA3/35/2zF9IrifFm+662A+KuZjI1UZfvDG4cyp+qQ9d9+odX0Un32ykTZRGghpZhPcO52cAlc17v2oMK8tIEA3Q1Nyg3oTCKZqjxIxNF1bRPTzNPn5QbrhisVFouN2DCxVLP8=
Received: from MWHPR03CA0002.namprd03.prod.outlook.com (2603:10b6:300:117::12)
 by BL2PR03MB545.namprd03.prod.outlook.com (2a01:111:e400:c23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Tue, 25 Jun
 2019 08:11:51 +0000
Received: from BL2NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by MWHPR03CA0002.outlook.office365.com
 (2603:10b6:300:117::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16 via Frontend
 Transport; Tue, 25 Jun 2019 08:11:50 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT026.mail.protection.outlook.com (10.152.77.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Tue, 25 Jun 2019 08:11:49 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5P8Bmpn022608
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 25 Jun 2019 01:11:48 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 25 Jun 2019 04:11:48 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V4 1/5] iio: adc: ad7124: Remove input number limitation
Date:   Tue, 25 Jun 2019 11:11:24 +0300
Message-ID: <20190625081128.22190-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(189003)(199004)(37524003)(54534003)(7636002)(7696005)(77096007)(305945005)(246002)(186003)(26005)(6666004)(107886003)(70206006)(16586007)(51416003)(6916009)(106002)(70586007)(316002)(356004)(36756003)(54906003)(86362001)(2906002)(8676002)(5660300002)(2351001)(8936002)(126002)(47776003)(2616005)(476003)(486006)(336012)(50466002)(50226002)(426003)(478600001)(44832011)(48376002)(4326008)(1076003)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB545;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea300e1d-46d4-4e24-4242-08d6f944c637
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BL2PR03MB545;
X-MS-TrafficTypeDiagnostic: BL2PR03MB545:
X-Microsoft-Antispam-PRVS: <BL2PR03MB545C6C1F6622115977EBBBC81E30@BL2PR03MB545.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0079056367
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 7Mf5fvWroEU2LVvRhhstUPgl0I/kjLP0QYenB1U2hDE9jpoDkSl3hyHGeV8mJKFcJMN1dSKn8EpV3HXJ+z4UfwNNSj9B/TA6CC1b8u23zvoqyNeB4YRimvyw2kyc0MnHAkLQXSxyp5nBNoVmtGwou6gpgJRaTJPOVjeZZPsOsEhBQgZhNNpy50og18KVYutjNdlK24qAQ+qhe5ZnQ64rTvRp8FFxvTI+19R3VivZFvRMpayAlSD+QFeSnb8bocMZ3Loy6/hicr5lYbng0x5TA3l0jSovVPPB3CJnZAJApH0mCZSshna+tD0oPT3B8rJtJwW9sQQE78fYmwbsxbB1gQ+cmv9YW1xty2PJRaX9uwreaQ1d3MQ6Hn9Ohs1CTNrTLDF1pgCmqMa7s+Cg3vWCGW2/aA3SRBIqzkUq2vmluYk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2019 08:11:49.6765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea300e1d-46d4-4e24-4242-08d6f944c637
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB545
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=819 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250067
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

Changelog v3:
- nothing changed here

Changelog v4:
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

