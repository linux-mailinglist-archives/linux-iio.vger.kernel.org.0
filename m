Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D097FEE10F
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 14:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfKDN0i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 08:26:38 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:53978 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727430AbfKDN0h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 08:26:37 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4DPCja005491;
        Mon, 4 Nov 2019 08:26:10 -0500
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2059.outbound.protection.outlook.com [104.47.48.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a4e1dps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 08:26:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR7+aMOflqr11UEp5YC3B+H0NnEUe4qpjyKW+TAdE7U7SG2t4de5Kqzg24b/p8d+4gYyAXDQa0Nq1bEaA184SQbNyeOlVkQy2PVI5oN0ccY28ac3JZ7Nzl8qeV8SUhPEXctUIFc15HYAQdWQUXV3jUwD1iReugSkNA/VwOJAkGuXl/H4Qc5RkBTHXrAizu5KZioaWL4h+Ok+nycJWdSaBUCt+qRLbeAwvbBeeoNhQT/VN4p4qsrP7NLU3rzXDaGWekTuVR3HNrResigPhpsF/HgRKSREQsYR2Jtl+mjRb3s334G5nYHgBiv3I8E671LDid/sgy+bTBuIuZUPC7k7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCScrHChId/QxK23tsqxJMaKLa2vhvb5FJCyhhgHDlc=;
 b=lHe2B+5qhXc7b/QFxTUAPSrB6+LHjlePFOv+A3DW62XCg4dNIhPoNjboei9ffQCCVKzRWqj1uPNZotNqdSUo0DfvUbY/ViH2APmRbbEnNa9aTs6kwsXqgYTgJC4hDMLhQPBtM6Z6DHKYagZXNjRdzfyDJsRU2Qc18ZdFDTxEt9PG9/2qOPHmy5sKZrZyvhSf4o/5ON/MEGRpX5ILDShhUCKqmGacfzAyi7CCu7qsKUvQpsSQFFn4vTxj6vzquTRCXtDLI6S2E/DyGFJHSiUVZPi0fSAEogYQHuHEQYPgEt9AUoA7eKvPLdAsMMt4iBHgitx0wH9BnWQfRIRZvHAXbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=gmx.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCScrHChId/QxK23tsqxJMaKLa2vhvb5FJCyhhgHDlc=;
 b=jcFdddaurmvqLoi4dzFDP4Y2pygWgMPxNVNU7jrpbLEnah055UvkdPOwnstBjn1/8u4/ay0cnprdjvfS8vWoCyujrTJ4q01qVLyBnVaQ8iV3Y8wzjk6zbnesnlrXatyO63C2YjTDNUEHGLrLrr8e6r4ZpKugy+ww2o900qSv5u0=
Received: from BN3PR03CA0091.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::51) by BN7PR03MB4465.namprd03.prod.outlook.com
 (2603:10b6:408:8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Mon, 4 Nov
 2019 13:26:08 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BN3PR03CA0091.outlook.office365.com
 (2a01:111:e400:7a4d::51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24 via Frontend
 Transport; Mon, 4 Nov 2019 13:26:07 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Mon, 4 Nov 2019 13:26:07 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xA4DQ6wC027272
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 4 Nov 2019 05:26:06 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 4 Nov 2019 08:26:05 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <biabeniamin@outlook.com>,
        <rwoerle@mibtec.de>, Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH] iio: adc: ad7606: fix reading unnecessary data from device
Date:   Mon, 4 Nov 2019 18:26:34 +0200
Message-ID: <20191104162634.5394-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(346002)(199004)(189003)(2616005)(70586007)(54906003)(426003)(106002)(26005)(336012)(6666004)(6916009)(305945005)(186003)(7636002)(66574012)(1076003)(47776003)(14444005)(44832011)(476003)(126002)(486006)(50466002)(5660300002)(70206006)(23676004)(2870700001)(107886003)(356004)(316002)(86362001)(2351001)(246002)(7696005)(478600001)(8676002)(4744005)(36756003)(50226002)(8936002)(5820100001)(2906002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB4465;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65dc6aa9-c109-4682-0b37-08d7612a8cef
X-MS-TrafficTypeDiagnostic: BN7PR03MB4465:
X-Microsoft-Antispam-PRVS: <BN7PR03MB44654724CF1635C5F45B3542F07F0@BN7PR03MB4465.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 0211965D06
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNC4bN3BBGckVRVorTRd1Ts0BQv3YOTr+sDnySWpLLNcFsgQBawlADPStExPDmRp6iAiYqVVSKznHxPyqTf4nlJHWt7Z5JDFg0KgPJJdg5zNi1i7eyJBdCXtw/HKLnA5HcWCBkl3frf4HHBDCOHSJLJHcWud1CmPudn7mgXqTN05hlx2EIOOQxdIXUq3frpA3CSMlrWckbMO7u3E7JoHg/iMMgqLoP6blV3xpTEmLuY6cVHskfKoA8gKT4cSABuBx5/QVPpGy6a93zPcx49x4LzKFowHjAQ9W6G6aTtc9MR/8z2VFw2ajmXzYTBZ6FE15iTRpKPePQjFO7gsTpnbkuObRgMlkzq2ZO1ipakAmzEN7rDJK4izGfn1x7Q8o6K85YI91pkKfSiMYnORhiym2Y7GZnAENwd42Q/RvPRmNCCMAmJWhJ5iYXZGX7JGd+Y0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2019 13:26:07.5980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dc6aa9-c109-4682-0b37-08d7612a8cef
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4465
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_08:2019-11-04,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1911040133
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When a conversion result is being read from ADC, the driver reads the
number of channels + 1 because it thinks that IIO_CHAN_SOFT_TIMESTAMP
is also a physical channel. This patch fixes this issue.

Fixes: 552a21f35477 ("staging: iio: adc: ad7606: Move out of staging")
Reported-by: Robert Wörle <rwoerle@mibtec.de>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/adc/ad7606.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index f5ba94c03a8d..e4683a68522a 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -85,7 +85,7 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
 
 static int ad7606_read_samples(struct ad7606_state *st)
 {
-	unsigned int num = st->chip_info->num_channels;
+	unsigned int num = st->chip_info->num_channels - 1;
 	u16 *data = st->data;
 	int ret;
 
-- 
2.17.1

