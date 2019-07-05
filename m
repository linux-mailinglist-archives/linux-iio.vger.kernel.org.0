Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0E3606D7
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2019 15:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfGENtn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Jul 2019 09:49:43 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:47824 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727652AbfGENtl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2019 09:49:41 -0400
X-Greylist: delayed 840 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jul 2019 09:49:40 EDT
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x65DmOW7004437
        for <linux-iio@vger.kernel.org>; Fri, 5 Jul 2019 09:49:39 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2055.outbound.protection.outlook.com [104.47.46.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2theqpk8b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Fri, 05 Jul 2019 09:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWBGJOZs7TdyMQFjOpp9RIrVuYD4lEfKXcW701vzm+w=;
 b=yLGOlh2BZToxx/qnLovtRIPKXi7Gwk0QWNYVqHWMu324/SQHHal6dZqK1d3vRGIkHRF6xLuN8SvaC2sOnn3vYlM8yd8HYi9sAIArwzY0jJl1RKSadYmLpgCUKSeciH4R5LmEcRx633cCNJNQfxJsAH5up/9F1QkZo2qWxnlggrE=
Received: from DM6PR03CA0037.namprd03.prod.outlook.com (2603:10b6:5:100::14)
 by SN6PR03MB3840.namprd03.prod.outlook.com (2603:10b6:805:6a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2052.18; Fri, 5 Jul
 2019 13:44:03 +0000
Received: from CY1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by DM6PR03CA0037.outlook.office365.com
 (2603:10b6:5:100::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2052.17 via Frontend
 Transport; Fri, 5 Jul 2019 13:44:03 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT004.mail.protection.outlook.com (10.152.74.112) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Fri, 5 Jul 2019 13:44:01 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x65Di09a017494
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Fri, 5 Jul 2019 06:44:00 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 5 Jul 2019 09:44:00 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: chemical: atlas-ph-sensor: fix iio_triggered_buffer_predisable() position
Date:   Fri, 5 Jul 2019 16:43:55 +0300
Message-ID: <20190705134355.19493-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(2980300002)(189003)(199004)(7696005)(6916009)(14444005)(426003)(5024004)(2616005)(476003)(126002)(486006)(44832011)(5660300002)(26005)(186003)(86362001)(77096007)(336012)(51416003)(47776003)(2351001)(107886003)(4326008)(50226002)(316002)(478600001)(70586007)(70206006)(1076003)(246002)(305945005)(7636002)(106002)(50466002)(8676002)(48376002)(8936002)(36756003)(2870700001)(2906002)(356004)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3840;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 716a1224-dd88-4295-4aa9-08d7014ed7c0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:SN6PR03MB3840;
X-MS-TrafficTypeDiagnostic: SN6PR03MB3840:
X-Microsoft-Antispam-PRVS: <SN6PR03MB3840BCA67FB753FF6CE30D2CF9F50@SN6PR03MB3840.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 008960E8EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: a2HYUCXBHVAGr4ODEj9/+ayetZNt5Ct2JAr9r7SP1Cdmr/4pIBgDUpIKsWDqfANeXGLH3yXlwRHdODWKH0hRouPfsAXFvggTpsK1ycPAzmEl9z0rf6ciKmpr8qPmWAWmL+GMdSlIG+mEe84/tYF29veAD79ILcPd2IkWAi47f9+ZhihCgXs2u1JZWRC+eNaFJapgWmJMYzHrmfzYf+zRFC4CZ/7x2roBGYObp6emVAn/Jz8ydqPxLRgnwrMvMTF/qRpiqW6KrKkROm0d9uxftGrNyFu9KoPAElPItdfW7tWiOSXKI2H3AJQNN8kkJizAK9kOEO4Ac7fh/LZWdIVjeY9pqvkl8SjA6CXQBRFSfV1Vq9B+QMnUfwnGcu47jMbOU+TeEeqKsyKOArwVtNu3qgFCGnmunc+fby37y9V9cco=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2019 13:44:01.4488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 716a1224-dd88-4295-4aa9-08d7014ed7c0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3840
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907050168
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_triggered_buffer_{predisable,postenable} functions attach/detach
the poll functions.

The iio_triggered_buffer_predisable() should be called last, to detach the
poll func after the devices has been suspended.

The position of iio_triggered_buffer_postenable() is correct.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/chemical/atlas-ph-sensor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index 3a20cb5d9bff..6c175eb1c7a7 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -323,16 +323,16 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
 	struct atlas_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = iio_triggered_buffer_predisable(indio_dev);
+	ret = atlas_set_interrupt(data, false);
 	if (ret)
 		return ret;
 
-	ret = atlas_set_interrupt(data, false);
+	pm_runtime_mark_last_busy(&data->client->dev);
+	ret = pm_runtime_put_autosuspend(&data->client->dev);
 	if (ret)
 		return ret;
 
-	pm_runtime_mark_last_busy(&data->client->dev);
-	return pm_runtime_put_autosuspend(&data->client->dev);
+	return iio_triggered_buffer_predisable(indio_dev);
 }
 
 static const struct iio_trigger_ops atlas_interrupt_trigger_ops = {
-- 
2.20.1

