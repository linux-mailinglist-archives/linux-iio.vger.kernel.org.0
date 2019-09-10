Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32869AED89
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2019 16:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393064AbfIJOpC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Sep 2019 10:45:02 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:42432 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387874AbfIJOpC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2019 10:45:02 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8AEhWq6011562;
        Tue, 10 Sep 2019 10:44:34 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2053.outbound.protection.outlook.com [104.47.45.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uv967k39m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 10:44:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZVHQBLh/vtKfMTdzIn4xC+CXSgpUwxK/mYpkV92xKobERAa0zJNfoBr2qeIPoounO7Y6EAWN0Ist7SWDWAEluKKUPKTZofAoAHkcQuBtvB8sZ94RRW3JEVq59paeAD7+USiGXyFvfVaD25pvuQfpYQ0naOCGZC37px6TPejpF81/d1Qsz7Rxi/ZYYCgpQigMUOVqKHAvtynLOeZ29zCZ+NcPtgRPGxZzdYHRv7cPbBPntHBxXj1NNUnfOEyIwZMrh7arD68oZLlsfArzrS3XWWTmTcQtC5tbhw/t2PSg+jYmfruOrWgXZoZCvkyNdgXPmQymDsQbUMwc/fWhuEhfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cZde7Eyvzsex2pybL4VyV5NycHjyiO9Uk+r61xbFx4=;
 b=SYsQDlUykLh9980pLLjDszqQbUaHwwDspDoqIL8CJr/gZY74KMw+eJ9R5ChJBje63UqQDz6/UoDeo0mB3KKC01FRyA9gsJWDsgLnTXy+QnbCRtaWURGTodEVd1eg1XuMGaKbkIgUsxgcmi9mOULWo3ZosvEEo9P0SotnJs0ZPVc/Lxp45F1yolO+oUjX7dt4e/lu69tU+ObZjGy5FwAP7/UhqXsMn9wmLpKaIy8ZB/i8eUGKhnw7ZraF/2dOx0EzEMq+jau8ZMg03ne3MV60V+Ncbf/uTWo61mkPE80OjIfQNKCLM6UCk/wKmHpdGr6Oe5vcVzdqZ8MwsIyGLE/oHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=gmx.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cZde7Eyvzsex2pybL4VyV5NycHjyiO9Uk+r61xbFx4=;
 b=5CFd2kOxdCHMmCNtgE25q2HODCZaTgRqbVosBYX7M1Rocw6md+3ghujt3vErZWmKuW2Bv6I+Olf5d1AL/GjwSYnT/RSiX/e/2VQA/w7vC5UJNgVUi0bwT5cBXBlnmuCrGwgfzZwR2cEd6qa4eGbJD/x9rVSdPS6rsWsNstSNqkM=
Received: from BN3PR03CA0097.namprd03.prod.outlook.com (2603:10b6:400:4::15)
 by MWHPR03MB3087.namprd03.prod.outlook.com (2603:10b6:301:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.15; Tue, 10 Sep
 2019 14:44:31 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BN3PR03CA0097.outlook.office365.com
 (2603:10b6:400:4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.15 via Frontend
 Transport; Tue, 10 Sep 2019 14:44:30 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Tue, 10 Sep 2019 14:44:30 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8AEiTLa030493
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 10 Sep 2019 07:44:29 -0700
Received: from linux.ad.analog.com (10.32.226.41) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 10 Sep 2019
 10:44:28 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v2 2/3] iio: accel: adxl372: Fix push to buffers lost samples
Date:   Tue, 10 Sep 2019 17:44:21 +0300
Message-ID: <1568126661-13318-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(199004)(189003)(44832011)(47776003)(36756003)(26005)(4744005)(2616005)(476003)(486006)(126002)(336012)(8936002)(426003)(48376002)(51416003)(186003)(478600001)(107886003)(4326008)(6916009)(50466002)(7696005)(246002)(5660300002)(54906003)(16586007)(316002)(8676002)(7636002)(106002)(50226002)(2906002)(70206006)(2351001)(70586007)(6666004)(356004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3087;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5378f88-2be7-4390-66b7-08d735fd6336
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:MWHPR03MB3087;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3087:
X-Microsoft-Antispam-PRVS: <MWHPR03MB3087160E376631D3D42DC24C9DB60@MWHPR03MB3087.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 01565FED4C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: FeyKUR905cG7YxKwz9HS3xvX1sTiVhT6IpavnRUOrI8vfsNtqOphV9e/8bF9zbXxQhxhhsuknFwG5zSRcy3PAgHge2ObyKvP+ON7kJtgT4ql02UGpA7Dvh9c/oQnoak72YFmWTWyMvB0jIPGJ4YHaTqfi3o7Kycqo0SjXfimlA0z+tW7IiFe+HpBMM9Lo981a+hAJUwSAeMFPOFx7TF4+dWSCkoPZbBGgiC65WbXnmNSQxJ1cCuWzkYhNxuUYpU8hQgxau4WJL/Ni9nf/rBiyplfi1dVmHpdmwcB2Gfd5jMxsKIQIRJTCsr5XejBPj8MKK/TzC2RfgnrqWZfCNiE9/Am7lM3ezDgJBxNmxJVy7u5IDYCdkzYxmDn6/DKvfoB6CemHCq+FJ3D+CWfnKkZj5hKgFIC1g/CwWTV1bqCdJQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2019 14:44:30.0089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5378f88-2be7-4390-66b7-08d735fd6336
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3087
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_10:2019-09-10,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=1 bulkscore=0 clxscore=1015 mlxscore=0 phishscore=0
 mlxlogscore=980 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909100142
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

One in two sample sets was lost by multiplying fifo_set_size with
sizeof(u16). Also, the double number of available samples were pushed to
the iio buffers.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Nothing changed.

 drivers/iio/accel/adxl372.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 7de5e1b..33edca8 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -553,8 +553,7 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
 			goto err;
 
 		/* Each sample is 2 bytes */
-		for (i = 0; i < fifo_entries * sizeof(u16);
-		     i += st->fifo_set_size * sizeof(u16))
+		for (i = 0; i < fifo_entries; i += st->fifo_set_size)
 			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
 	}
 err:
-- 
2.7.4

