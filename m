Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D2EA64FD
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 11:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfICJTp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 05:19:45 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16682 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbfICJTp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Sep 2019 05:19:45 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8398BLd001712;
        Tue, 3 Sep 2019 05:19:20 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2055.outbound.protection.outlook.com [104.47.41.55])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uqjracjjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 05:19:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwjNTCSt33aSC2fqAVCMO96h1oD5PUpJFFprofFdkmtgVKlnUqBJdxhYNiZps72I+J6/UsHObgi1oJACOK6XFhKLdJfZf1PRVX/h/2ZGUj4pzXE3eN8lcugUMFm8wr76vnCdqs+FnCZpA6p7gjpq13n558J0z7ByPLOi7ejgLS+o/8VMSPQJFfWd1CN4gVvtmpRFgdR9MxkuZPuzkfZN8EKGWOXCutFLT4EHqI3b2o3pLvZcdtzhier9h43xrJZlpr9PhHcnXy76lkSy60Flx//di++ksfgJscJRRGQyIXq2V/TmjloK+/agJPZ9e7P3GSf4+By16l7OCNvrm6uVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBxbXDIOuQXSkj/V107YId0xpDme+WSzPVM0VbmN3TA=;
 b=Va7nIOanZxixUaXr2xO8y5NwCsZ32s8nt0QenYBFFVxZjITyfDyEHBXSmI5lBD6XfuN/x4BEUOSyn4E93//5bZwmYoDSkOgpPPIk1UBuuRcS29wvBwM6hZYhl4ktNjfpRae2fDO5vtpHTvsCVG3tM1JVtbUo5I8RhixmgeItEBnVau8oItcigHsqOqOglmTKR2BNGjGL4t+UCS8ZmcCksh98fp+Mpzcmaljd+1f+pEk7U3WXVNT2Tp75G5pPZvACv7WI8aCxQjsqZfiwLu9O82MZg8NGF6WvwkkGkujE1liVAwCW4VBwni+1NCbGzD6ghNzFkZNrjkYZ5//qm/N7nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=gmx.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBxbXDIOuQXSkj/V107YId0xpDme+WSzPVM0VbmN3TA=;
 b=lBWR0cDZv2y7/sPWL9ivsmrhtIguWPqWHfKYb42li6LNr2Z5Q4cxfvLRCxKGx0nG+lHVy6ts8D5NsJpGSxoP6CVpJ+r3XiHEFxUnrWa1kdqn7q38/fVqd9PjM6epdLH42HTEUp+5EKZwo+NdIFdvQLhFPPDFOd6wJfF3IWuqc6k=
Received: from CY4PR03CA0105.namprd03.prod.outlook.com (2603:10b6:910:4d::46)
 by MWHPR03MB3040.namprd03.prod.outlook.com (2603:10b6:300:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.19; Tue, 3 Sep
 2019 09:19:17 +0000
Received: from SN1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by CY4PR03CA0105.outlook.office365.com
 (2603:10b6:910:4d::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.19 via Frontend
 Transport; Tue, 3 Sep 2019 09:19:17 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT043.mail.protection.outlook.com (10.152.72.184) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2220.16
 via Frontend Transport; Tue, 3 Sep 2019 09:19:16 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x839JBd4003500
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 3 Sep 2019 02:19:11 -0700
Received: from linux.ad.analog.com (10.32.226.41) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 3 Sep 2019
 05:19:15 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 3/3] iio: accel: adxl372: Make sure interrupts are disabled
Date:   Tue, 3 Sep 2019 12:19:11 +0300
Message-ID: <1567502351-10429-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(396003)(2980300002)(199004)(189003)(476003)(2616005)(126002)(7636002)(5660300002)(54906003)(486006)(426003)(6916009)(356004)(6666004)(47776003)(107886003)(106002)(44832011)(36756003)(50226002)(316002)(305945005)(186003)(16586007)(70206006)(70586007)(4326008)(8676002)(48376002)(8936002)(4744005)(51416003)(246002)(7696005)(50466002)(26005)(478600001)(336012)(2906002)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3040;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8c5e0a5-2d60-436c-c05a-08d7304fcb6f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:MWHPR03MB3040;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3040:
X-Microsoft-Antispam-PRVS: <MWHPR03MB30404310EB41E8C94BAD021F9DB90@MWHPR03MB3040.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 01494FA7F7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: hqbR+Ld0FiLmVEqOnqs03e/QE8y936wpLLikWwrnijYZZyExkOSx2LqFI3uaJ3FoIT4lpBlpto+vHVfM7YEdzcMJ0ZMssEP15U3NPLd2OwC5NVPhAn25Oh/tDXhBTj2lIep3dWk8F5ZVWAKqLPeIIFh5DikMKQHCKZViP2WkPAb/TsnsgsvClffqesYhJ8h2jSo17W/SB+J/1qeXh2cX1w4zOLGbctyaJDQXMx1udZtBvfKIJwxeHKznwBb2lfAXJsVcf67g6CVgti6ljx7ZD6uSZhYU8c1QiBnXK14Zp16hVAQFH0crVl2na1VYfyVgKSWAzCSjykpHl5nEv59gssLqCPGwTvsFRZYsEPq+zYpHUp773TdRFbYuQ1tNB/qV0oYLJHaf7TT/wdTT5pCCzLkYZT6WmPY1K+ayDuZZKJQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2019 09:19:16.6429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c5e0a5-2d60-436c-c05a-08d7304fcb6f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3040
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-03_01:2019-09-03,2019-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=651 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0 suspectscore=1
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909030097
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch disables the adxl372 interrupts at setup. The interrupts
should be enabled together with the iio buffer. Not doing this, might
cause an unwanted interrupt to trigger without being able to properly
clear it.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 72d3f45..77651f4 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -609,6 +609,10 @@ static int adxl372_setup(struct adxl372_state *st)
 	if (ret < 0)
 		return ret;
 
+	ret = adxl372_set_interrupts(st, 0, 0);
+	if (ret < 0)
+		return ret;
+
 	/* Set the mode of operation to full bandwidth measurement mode */
 	return adxl372_set_op_mode(st, ADXL372_FULL_BW_MEASUREMENT);
 }
-- 
2.7.4

