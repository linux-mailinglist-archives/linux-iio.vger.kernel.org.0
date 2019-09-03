Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44738A64EC
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 11:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfICJSx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 05:18:53 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:53806 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbfICJSx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Sep 2019 05:18:53 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8398Fe8010804;
        Tue, 3 Sep 2019 05:18:14 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uqnh5cqh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 05:18:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C24mB7ln/01aRT3jSmT/X2a+01AdNa7pR6tGLaRHehr9NJJ5rMfd8lX2Cau9Ooma8rjbMdnoS5v8AHg0dhZM0wp3Th+s/el+evhojJWzsJIJhQ4wLrZGKNBymA8lb0LPcmByXEAOuQZu4I3EzUKsLRvh1ZWMy6sz3RIP6JiACTsmG9731KrXV85n0xcmWAKLvTtvQ9h+tGMIVR0itbSph3Evaq05bvu4G441j5Od+e3Nw2v2VGRaseQrObjq+18us74hv4QXMeUPuYgncFjpXpH6WB40dVebTCRMyPLmtJlTE1hjFzMiJRHGgmDbxeB+Lmpmq+Y6fFB+Cuz0J3L8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4SbAbb/5ac23tfajDupE2sj7N1q54dXurpgP+cOvos=;
 b=mSQjUflZaT6ALjyVu08PA6MrY6/W7G+0JuIIdDgvpWdQG3ZKQTx7Go0XEcvgibXldyLVMbXJX1RMI4lAB/h7ZV5AO8LCwu2aO1KgqZq+yiP7YdjxQCPFl2nNlqVhgnF6gx7BBf4nWIXiUmRc4k002HHGmytO/r4f6QUZtIDrXxFfTplxVxaRLgm0JKc0bY/gi7tbY9usUdt6cfysgKWzODluuQHSj2bXW7eKy8lzNeD+58PY/m3fNwrUrsENfSdTJYLBPqe6ogEaDsNoPPkjVrPWteXxU9MN9iniafUEZ5WS65hW+wDSCrFoMTZRPAwXVdSbEreG2YYswtl2LEqzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=gmx.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4SbAbb/5ac23tfajDupE2sj7N1q54dXurpgP+cOvos=;
 b=UoK2bbD6uWNSG9VA96Y3tPFAsfzdr18DokWYZnFwN84BhdDuGhrrEobIZeCDq/R+FggUxsa2uU9MWrLo2TN+1BL+O77AUiswEtEx3/j8e/1R7Q4xvO6gIXow4e/izO2x+zckiJOfQT1ORZfYAhT18hleRBrSogy3k4jVduqSIro=
Received: from BN3PR03CA0052.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::12) by CY4PR03MB3223.namprd03.prod.outlook.com
 (2603:10b6:910:51::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.21; Tue, 3 Sep
 2019 09:18:12 +0000
Received: from BL2NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN3PR03CA0052.outlook.office365.com
 (2a01:111:e400:7a4d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.19 via Frontend
 Transport; Tue, 3 Sep 2019 09:18:12 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT056.mail.protection.outlook.com (10.152.77.221) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2220.16
 via Frontend Transport; Tue, 3 Sep 2019 09:18:12 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x839I7NB003244
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 3 Sep 2019 02:18:07 -0700
Received: from linux.ad.analog.com (10.32.226.41) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 3 Sep 2019
 05:18:11 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 1/3] iio: accel: adxl372: Fix/remove limitation for FIFO samples
Date:   Tue, 3 Sep 2019 12:18:07 +0300
Message-ID: <1567502287-10199-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(2980300002)(189003)(199004)(5660300002)(50466002)(51416003)(486006)(126002)(107886003)(478600001)(70586007)(48376002)(4326008)(70206006)(316002)(336012)(44832011)(186003)(47776003)(7696005)(6916009)(50226002)(356004)(6666004)(16586007)(8936002)(2616005)(476003)(8676002)(54906003)(246002)(36756003)(2906002)(106002)(2351001)(305945005)(426003)(26005)(7636002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3223;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f12e936-502e-4949-bce6-08d7304fa508
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:CY4PR03MB3223;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3223:
X-Microsoft-Antispam-PRVS: <CY4PR03MB3223C9134F417A2BEC1ABA409DB90@CY4PR03MB3223.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 01494FA7F7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: x9TH+ypzILRiZ4j5vq263OwwmxZ9H4Yg0J0BG4hNNaHyL2riwElyEZhbPKgz5jqKCyHhZHD6KrcJJ8KLW6Y5Xm7E+/M/1WXX8Z0zpTgc5YQB6XRrBsPRLtXAkjJcqMda22Fp082kuQX2KrbSIje1EggMahtuFkQxRnpm9TO+tQGnbSU/D/Ud3MxFOjoIIgqM5P4hxSCe3Q9dhsS1IFOB8TZ+wWtVIGBSIIguvLdK7la+rq7q+CycLCHvcuUeYeuRNyb6T8vOpWuzMXFTgroqyTj4XBe7D3n86DRmJiePPzx0BBtGU4TNewrtNYmFd4C8aBC2sa0VqzAvM0QCrwrR5Ql3EweOaAXMcMnQEikmOvbYCnBRq2jaZi4fqqzypazCSNd0DzAdvTY5F04qFxRSeJ6Uhs94Mks+EcKXHbPdCK8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2019 09:18:12.4656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f12e936-502e-4949-bce6-08d7304fa508
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3223
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-03_01:2019-09-03,2019-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=1
 mlxscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 mlxlogscore=772 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909030097
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently, the driver sets the FIFO_SAMPLES register with the number of
sample sets (maximum of 170 for 3 axis data, 256 for 2-axis and 512 for
single axis). However, the FIFO_SAMPLES register should store the number
of samples, regardless of how the FIFO format is configured.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 055227cb..adec37b 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -805,15 +805,6 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
 	st->fifo_format = adxl372_axis_lookup_table[i].fifo_format;
 	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
 					  indio_dev->masklength);
-	/*
-	 * The 512 FIFO samples can be allotted in several ways, such as:
-	 * 170 sample sets of concurrent 3-axis data
-	 * 256 sample sets of concurrent 2-axis data (user selectable)
-	 * 512 sample sets of single-axis data
-	 */
-	if ((st->watermark * st->fifo_set_size) > ADXL372_FIFO_SIZE)
-		st->watermark = (ADXL372_FIFO_SIZE  / st->fifo_set_size);
-
 	st->fifo_mode = ADXL372_FIFO_STREAMED;
 
 	ret = adxl372_configure_fifo(st);
-- 
2.7.4

