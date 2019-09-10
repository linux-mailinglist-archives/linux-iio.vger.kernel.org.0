Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3974CAED8C
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2019 16:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387914AbfIJOpW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Sep 2019 10:45:22 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35736 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387874AbfIJOpW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2019 10:45:22 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8AEhg11026561;
        Tue, 10 Sep 2019 10:44:57 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2054.outbound.protection.outlook.com [104.47.32.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uv6d9bhwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 10:44:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+4c+g8MwW8faLW0gAIpfeK6D9vpFOXYOSGDF6xTZG/Xo7CeVX6IocZ4fYWncDRwjyfSPCncC8Y/Jps97qb8uoBv6Rw3bsGGSTaIXYeqObHNBGXjhMp2XuhylQkeg4qF1XGnu7D9iJW9248xChxgL5O0yI06jqg3TQ2LHbBVhL0qS/yAr3yK+yf9gpeahz2QMCepENms2gXCysr3EDPjNdQFe8apFbAlr88kue+T3JAiZWzqHmiNiJggW/4L6jyS9XJENrKCQJGnHXaZ+c8qxGw2gFjjG2WtglH8rvW0WgOWPjKNbQT90ctg1oglT8swve/fM19lq459qseL2jan4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3C76eXJO7Tj1DPucNSzH1bRt22WA6j0mmBHGF6ioxA=;
 b=kW6rcTSwOFSSkxFHEuCVqm/9Z49tHMn/y0ktZGw4O4ag5qH0lp9QA+KyiaTWv2HLRx8+cAgM3Q6fuTYNH0+HKNHpOB8MKMZPw0cxQ2HvqDjN+Nm4ghwhWQCsTAeOevny8Ozp52NRhQF0P3RE9+EMBsWKriTvITdyUEXHf6IW3DoIbMHR5wvK93BfkTpLkz5/5Dy4UpXRLc1y6K1YMQ1ovwvpXKpvQfEJa0B2bs54SsPJRtJ4D0KZfZnQMYi4Keu0XtvgCaaL6ZTCgH6ZourFUBOZvoyXaRkhEqzpBrFndJwMOXhr3Reazyq0NVLIDD4qbqraLkYbY9Pq+dmm+u4kaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=gmx.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3C76eXJO7Tj1DPucNSzH1bRt22WA6j0mmBHGF6ioxA=;
 b=M8uxGuvKd74NCJG/g1160+TWPsiOnd1GhFbCcNHOw/G9pnjAMAwH/pkkmVn6Zs4Y9MMZUjr295hm85bwT/+JWfRzrfqBoCfXrq7mUygp7j3UYn9ztxsGFOl4Y4uegRJjTSWObHkvILgQIFmjfh4gXKlJ41gJ0HVN2/W32vT/fDk=
Received: from BN6PR03CA0024.namprd03.prod.outlook.com (2603:10b6:404:23::34)
 by MN2PR03MB4845.namprd03.prod.outlook.com (2603:10b6:208:104::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.20; Tue, 10 Sep
 2019 14:44:54 +0000
Received: from BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BN6PR03CA0024.outlook.office365.com
 (2603:10b6:404:23::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.14 via Frontend
 Transport; Tue, 10 Sep 2019 14:44:54 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT047.mail.protection.outlook.com (10.152.77.9) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Tue, 10 Sep 2019 14:44:54 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8AEis7p030641
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 10 Sep 2019 07:44:54 -0700
Received: from linux.ad.analog.com (10.32.226.41) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 10 Sep 2019
 10:44:53 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v2 3/3] iio: accel: adxl372: Perform a reset at start up
Date:   Tue, 10 Sep 2019 17:44:46 +0300
Message-ID: <1568126686-13436-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(2980300002)(199004)(189003)(7696005)(4326008)(336012)(486006)(54906003)(70206006)(44832011)(70586007)(2616005)(316002)(106002)(8676002)(5660300002)(426003)(476003)(126002)(6666004)(356004)(2351001)(47776003)(36756003)(478600001)(8936002)(50226002)(26005)(50466002)(16586007)(48376002)(186003)(107886003)(246002)(7636002)(305945005)(51416003)(2906002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4845;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00958c21-d07a-4c40-723f-08d735fd71a4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:MN2PR03MB4845;
X-MS-TrafficTypeDiagnostic: MN2PR03MB4845:
X-Microsoft-Antispam-PRVS: <MN2PR03MB48457A1054080DBAB5E9324E9DB60@MN2PR03MB4845.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 01565FED4C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Om57bHmbkJ5os5phqVNBNkYod6z2WgRrMHhd7o8ea0I2EIdXgpEu7tpAiccnMW6azqsFGgqy8RZ4SXcmq36Gg6UeIwlL9Yn0nJUIIA2ifqwaZXicI3oCaa+0L0TtNTNO9hvMIYmpEArvX0yryXWQAAitEt85/PZX98fVkJpUhbsucrzBzbrdArhv0l+2Ig8LhkOxTs/XHy6yMWcTT9R+ExrCCnua6WZX3u+LRy6jchGy6nGMQX4NTh/F99A+PjTxlFgeWe9O5wS7nirdsxb8r+T/couLaOBTllmSztpKs3VAOLiwWGZgNNHkqE6g2Cl4hzk0yzZh5uy20myHRjST+3/9l+nRnVSNGJs4t7Oz56NauhB4q+8wbXJu3fYG4IIe1TIp4pOIDOiHtUk3CVRcSKw6uhppMp7zu5RYB7Isr+0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2019 14:44:54.3843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00958c21-d07a-4c40-723f-08d735fd71a4
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4845
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_10:2019-09-10,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=1 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxlogscore=720 adultscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909100142
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We need to perform a reset a start up to make sure that the chip is in a
consistent state. This reset also disables all the interrupts which
should only be enabled together with the iio buffer. Not doing this, was
sometimes causing unwanted interrupts to trigger.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Instead of disabling the interrupts, now this patch performs
	  a software reset.

 drivers/iio/accel/adxl372.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 33edca8..8a00528 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -575,6 +575,14 @@ static int adxl372_setup(struct adxl372_state *st)
 		return -ENODEV;
 	}
 
+	/*
+	 * Perform a software reset to make sure the device is in a consistent
+	 * state after start up.
+	 */
+	ret = regmap_write(st->regmap, ADXL372_RESET, ADXL372_RESET_CODE);
+	if (ret < 0)
+		return ret;
+
 	ret = adxl372_set_op_mode(st, ADXL372_STANDBY);
 	if (ret < 0)
 		return ret;
-- 
2.7.4

