Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA8A3B8CFD
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2019 10:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404899AbfITIff (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Sep 2019 04:35:35 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:62156 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404617AbfITIfe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Sep 2019 04:35:34 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8K8XaaA032508;
        Fri, 20 Sep 2019 04:35:19 -0400
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2050.outbound.protection.outlook.com [104.47.42.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v3vb5vc1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 04:35:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ct/+bgeF6Y/zl47EucvPa+3ADrV56fsIcJQVKNtRYHLQU7kDekBPc8vhMyRKuLqCFhxD77ECoBpGnmkMxrbPknYJxzA1+cJacAGN/ki63u79dKxdJk1WoK8SeoJ2lDDpz5irtndNuEd1WMONBM9d25nINXjIrbSngf7VwulnIOohr7aFdTPYvOMXW5d+BNTQ5Jch6JAja0carOGfrXA21fG6KzXbg6/WMDdGlfjOxMOCrbqaEgMkltKd6DPJ053ptBLbn8ErLejxBK/8iw3xOlAqUMxgZk/hi/g1JlcrzUrdzw1pB0ocyQ3iP22wKzhhn1UD3X+H9L5iXg+hRp3aQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/R/2c9ahkP6PfrZmfkHRTsfx14NLb2il4NBYtzKBwY=;
 b=CTlQbv+/VfhXv0NiG4nSYgarPOB9E2iDxoxz68y4sv53GtAJnZCH5aRfOP9IFuwEIf6TR/MUJ8xe37+Qduicvhkzdx2pClUktRKh5MAqguD12/AbbEsYhCE7JFLREYDd5GrbaWdHK16njytKgnhwQlaFHbWwwbLAREQF0vbm+uDX8RjRDT783JpQaLHI/iSijf53oDIPQunJR5m32JwYrOj3JEFRfU9ger5QA/Dd0QSzmkVJi5ypp4YnQ738UEf0NsSxIJXs3AbBc+Ds5nebYY4CzLWoIWqcLzl+zjSecsyV3MtDI0VSJcsj94izSW39bQDXzOCYDdZ+rDa6CeFm1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/R/2c9ahkP6PfrZmfkHRTsfx14NLb2il4NBYtzKBwY=;
 b=hkwX/1EWO+TNSCpKfAPu24RRf/aOXTozhckC2pLSFKFk49H86lhwe2L8QxyRl56HO+P2MAClCGM79oe22PgYb4XUiR338EvAeC6lJj3mfarO4X+Z1mg4GWrgDjJeu0YSaqnAy4rArJgCK2JZViIm5xhtbXkg0q/F5l6rdzOzB5Q=
Received: from DM6PR03CA0001.namprd03.prod.outlook.com (2603:10b6:5:40::14) by
 CH2PR03MB5317.namprd03.prod.outlook.com (2603:10b6:610:9c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 20 Sep 2019 08:35:17 +0000
Received: from CY1NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by DM6PR03CA0001.outlook.office365.com
 (2603:10b6:5:40::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.15 via Frontend
 Transport; Fri, 20 Sep 2019 08:35:17 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT056.mail.protection.outlook.com (10.152.74.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 20 Sep 2019 08:35:16 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8K8ZBiu002235
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 20 Sep 2019 01:35:11 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 20 Sep 2019 04:35:15 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>, <vlad.dogaru@intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: proximity: sx9500: fix iio_triggered_buffer_{predisable,postenable} positions
Date:   Fri, 20 Sep 2019 11:35:13 +0300
Message-ID: <20190920083513.720-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(2906002)(246002)(36756003)(70586007)(70206006)(7636002)(305945005)(5660300002)(26005)(14444005)(51416003)(7696005)(186003)(4326008)(356004)(316002)(48376002)(54906003)(50466002)(336012)(2870700001)(1076003)(107886003)(106002)(2351001)(6916009)(86362001)(8936002)(47776003)(8676002)(50226002)(2616005)(44832011)(486006)(476003)(126002)(426003)(478600001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5317;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86d5913d-bb06-4673-451d-08d73da576e7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:CH2PR03MB5317;
X-MS-TrafficTypeDiagnostic: CH2PR03MB5317:
X-Microsoft-Antispam-PRVS: <CH2PR03MB531722F891753656766D2753F9880@CH2PR03MB5317.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0166B75B74
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Z4uTWHXCAQUOlX+K+1gFqm+9Sixd34wbGpUSCCA+oRRcAeZP4fqFMt+JYyW3R7UsOUMLXf3XuPYSdZLPlqf9JF//OERuPIgxNHYJMhRSF4wQgPTxg740OP1XGF/pR9JCHLnvX2cLHUFYMmQJY3ioXZJ9L2lcZwnb4mQjLzYGLjjNSUsDx0Ue9vUkYdVRGvN4pGKjCZjA+mGkj8HWcBCPpI7X0v2VLtzsXj8Y2zPeKuqjSnzI+geDn07yugaH2dmjSnuUuSS61DwQBuaJbwPlqLFVkBjqpNYyanvYEUr+ot1x6oW101/eKKBJuacW7EJ6N6cjZHuIDDVqn2uvyadYHSnEpf0JHXyJvFGSSy7OD4S0YyJ+MpT4cDbn2viRE+b7EX+J200en7ijgfNAqZlNj4Lh5kgebAxKv38cPSiyG/g=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2019 08:35:16.8819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d5913d-bb06-4673-451d-08d73da576e7
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5317
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-20_02:2019-09-19,2019-09-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=1
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909200082
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_triggered_buffer_predisable() should be called last, to detach the
poll func after the devices has been suspended.

This change re-organizes things a bit so that the postenable & predisable
are symmetrical. It also converts the preenable() to a postenable().

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/proximity/sx9500.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 612f79c53cfc..287d288e40c2 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -675,11 +675,15 @@ static irqreturn_t sx9500_trigger_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static int sx9500_buffer_preenable(struct iio_dev *indio_dev)
+static int sx9500_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct sx9500_data *data = iio_priv(indio_dev);
 	int ret = 0, i;
 
+	ret = iio_triggered_buffer_postenable(indio_dev);
+	if (ret)
+		return ret;
+
 	mutex_lock(&data->mutex);
 
 	for (i = 0; i < SX9500_NUM_CHANNELS; i++)
@@ -696,6 +700,9 @@ static int sx9500_buffer_preenable(struct iio_dev *indio_dev)
 
 	mutex_unlock(&data->mutex);
 
+	if (ret)
+		iio_triggered_buffer_predisable(indio_dev);
+
 	return ret;
 }
 
@@ -704,8 +711,6 @@ static int sx9500_buffer_predisable(struct iio_dev *indio_dev)
 	struct sx9500_data *data = iio_priv(indio_dev);
 	int ret = 0, i;
 
-	iio_triggered_buffer_predisable(indio_dev);
-
 	mutex_lock(&data->mutex);
 
 	for (i = 0; i < SX9500_NUM_CHANNELS; i++)
@@ -722,12 +727,13 @@ static int sx9500_buffer_predisable(struct iio_dev *indio_dev)
 
 	mutex_unlock(&data->mutex);
 
+	iio_triggered_buffer_predisable(indio_dev);
+
 	return ret;
 }
 
 static const struct iio_buffer_setup_ops sx9500_buffer_setup_ops = {
-	.preenable = sx9500_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
+	.postenable = sx9500_buffer_postenable,
 	.predisable = sx9500_buffer_predisable,
 };
 
-- 
2.20.1

