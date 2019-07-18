Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A15296C94C
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2019 08:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfGRG2O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 02:28:14 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:12968 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726383AbfGRG2N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 02:28:13 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6I6OC7G009140;
        Thu, 18 Jul 2019 02:28:10 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2059.outbound.protection.outlook.com [104.47.32.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ttgdmrat2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 02:28:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hii51OQ2dhZQrHVduJ67Te4BZV/0UwWdFAGogb3B8h6bNxGxMl8DfrLaRGBS+WoGjAOvewmPtmuj7bxEOwWM8FYFcAWho/wjfpSYWXEft7R1JAXmn4jGWWL0oF2G9IITYxpMu6vvc3nuxidHEoFa6xw4CCHiO2qqlG5GtEJwiavy/Jwwa8LDsUqBSRDCJw/Fy30QRPOxwujZZjrmNaJNDVmm1BH96JqHxRHB/3bPwbW1o3Irs2cvqnADnEoE/w4vpvxa7E41JsRuG3Zhz0RK6bICYXTh7jHYSqHDJMqoCwXdNm2lpDbVW/xYgLMBFEBmVBXEyfy17L5kktq0NCqEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrkcNtU19aLFi+4It6RQoQTYYGIhk0yhWFfMlZ7v0qg=;
 b=TkmvJPqm9j9Kr9MbsPUToka9hYuuKeh27/2mygYZAP3SAgVBEVy1HrRVVYMpXOaM7GhYiVIwOW0VZaFU087UFCojGF5fulOCIKOoW8Qfi8DK71AcqlnvlPnyu7/bZk7CLAe3BUBTebtD6gTZ/O7JeZ1QXmU04FyRxJKJx+rjPv2lVKRiCDAHBBody1q+c/B2hD8jnPWcyTpLrktyzfvryRsERMG86ULiZ6clH3kb2aWCRyzc/pm8fCmizumjFICUUUfhjOjR1OFb5SU/49OsI5tq+ukPKSgkSTxzvTzEelWDb5FAYdc3KtRvx8fqXl8oIQOfAfeZXcmUYwZkk3o6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrkcNtU19aLFi+4It6RQoQTYYGIhk0yhWFfMlZ7v0qg=;
 b=lSOnM9KYWqvZgzzzI241OREp4l0i9oqBfx1Ded+wucEJDNToHynRJifBYkomiEFirGvkvP9us+2ztDc6nUtmW7glcwlAfhplL8uiRG3p+lm99lXN0fSnRJytZYWL13kDB0L9E2qbbQ5Lz0o84Rbhhyrf4Lx4Kad+AMaAfdOASIA=
Received: from BL0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:208:2d::31)
 by BN8PR03MB4707.namprd03.prod.outlook.com (2603:10b6:408:6c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.14; Thu, 18 Jul
 2019 06:28:08 +0000
Received: from CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BL0PR03CA0018.outlook.office365.com
 (2603:10b6:208:2d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.10 via Frontend
 Transport; Thu, 18 Jul 2019 06:28:08 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT025.mail.protection.outlook.com (10.152.75.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Thu, 18 Jul 2019 06:28:07 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x6I6S7dW015287
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 17 Jul 2019 23:28:07 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 18 Jul 2019 02:28:06 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 3/5] iio: adc: ad7606: Allow reconfigration after reset
Date:   Thu, 18 Jul 2019 09:27:32 +0300
Message-ID: <20190718062734.17306-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718062734.17306-1-beniamin.bia@analog.com>
References: <20190718062734.17306-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(2980300002)(199004)(189003)(316002)(486006)(4744005)(16586007)(54906003)(48376002)(44832011)(8936002)(2351001)(4326008)(50466002)(6916009)(106002)(107886003)(1076003)(5660300002)(86362001)(70586007)(70206006)(6666004)(51416003)(50226002)(356004)(246002)(76176011)(478600001)(47776003)(336012)(426003)(26005)(305945005)(11346002)(36756003)(126002)(446003)(186003)(476003)(2616005)(7636002)(8676002)(7696005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR03MB4707;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8661706-5519-42b9-b780-08d70b491951
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BN8PR03MB4707;
X-MS-TrafficTypeDiagnostic: BN8PR03MB4707:
X-Microsoft-Antispam-PRVS: <BN8PR03MB470738B10C654DC15C07E175F0C80@BN8PR03MB4707.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 01026E1310
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: M7z+1sRGnPMkuRwPur03KfmwQfHE9JXTkRD4KNxrZyb3meIxJFbypRNJZkYAUunFQ0MUPsljRlfy8LvlMEDquV/35BY6wwmvaslcgfKNccsbZmCXhsNEuLHJ/7lzpnU+npLpYo+FdW3+eVqZLVYqa1E8r1Ed0qELVZGFVet8/14zyLKEFQssFEwHvyMP9Kfdo8Whnyu6ey48TpMcjzJWX8WfnHfmIXowyEGHq81WcAikAwOwkS/cnYLBd7BGZ20DGcfE5iFBNr9LWKmSMsWoKGPGze8dIUINC4rJlguSal3RJ0KX+v1O6FZYScWseNRTOWD8KC1RlNf6i8eeK5nhn/dG1r6ZM1mp7moTwNq/8buCnr/ZfYnTzg9QXhqH8+kWmLizw8vIamNhxRjaSMvrk9Xr060ZCz4RTMY5d1QfxpE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2019 06:28:07.7995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8661706-5519-42b9-b780-08d70b491951
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4707
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=694 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180072
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

According to datasheet, ad7616 require at least 15ms after a restart
to fully reconfigure and being able to receive new commands via spi.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
Changes in v2:
-nothing changed

 drivers/iio/adc/ad7606.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 9eec3db01a17..a6034cf7238a 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -594,6 +594,10 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	if (ret)
 		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
 
+	/* AD7616 requires al least 15ms to reconfigure after a reset */
+	if (msleep_interruptible(15))
+		return -ERESTARTSYS;
+
 	st->write_scale = ad7606_write_scale_hw;
 	st->write_os = ad7606_write_os_hw;
 
-- 
2.17.1

