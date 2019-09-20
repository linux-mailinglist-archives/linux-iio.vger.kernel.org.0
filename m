Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28D9CB8C1D
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2019 09:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393041AbfITH5j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Sep 2019 03:57:39 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:55366 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388411AbfITH5j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Sep 2019 03:57:39 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8K7cwBl023633;
        Fri, 20 Sep 2019 03:57:29 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2051.outbound.protection.outlook.com [104.47.33.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v3vb2cba3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 03:57:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrJuhWcy8YYXUUcpHTNqZcEZ6l2WQTXqWV/7eJUqMVsDIS53j7OX8ChTg2RLON4geRK3rf5i0pnc6qcRfy+BlFVN0NEsD2wyYC1nm4zZ7BIMGZ4W2KEBoWwz1JGtQA8Rgt1+/caF3qHl18pFuUqYPkRwXwU+o8T6coYu3+VDTXWxrZApy74FyI5RuEkFA5mfKlu5z5Mc+zc5QWcciJhnics0iyU+xDHGKSO6L6tYZJuelGbeF2ocCbESluZOWTngWdXNfkn3vPV8UsboSL796hyl3W5p494kDsJUNiYoZIJa0VWucT1vxDA4jrfMV+PaLJ4JyP/J0bMqdLNdHCf1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEeAvmHBwD6Sq+/h/DhTh0+ol73a0tcUHr1mX3Vk9Js=;
 b=AidsyLsNO/4nIDOutbxPc34Za0F/gQvyJ4afQuit9+q/VwnX0HKeHUu6Br4wDVnAg//DhUWY9zeLHsohi4ET8wn3kYIRCuSggUycpJIxOegdS+bzzQYkc0UzNZDMyUeQQu4ShGsvem52wQsGAOhQVGdEIRs8EmEQ02jJQ0xM0ZuLJG6LX3B5mlDWG3URviBszQ5qL51PX381t7wZEa3TKveYTwQEIoSx8P6H8O87hd7pVdykDv/AIgetIb9EtEyteQzoiZN5/FdDfevkWeL8oS5SyPnv0BNimCvMwHrVTPrdAR4+wtUBdudlEfIiGz8jiODwa/Kc7Z6OSjq7zwpqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=pmeerw.net smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEeAvmHBwD6Sq+/h/DhTh0+ol73a0tcUHr1mX3Vk9Js=;
 b=naSacVyCZ1EjJrHXaokHYhf/tWIRewDCSyol/r1Q29WoverMegco8Eb3qSNXIbFS7dGN7eaVOY5qm8iUV12njcx7EuwaWFqkOHEP2fB1xLGulYtsXAXFzijprjQeAf3GtnE91U11YJKai+ALLPFbm3oPRiWMDNd0RZ0p7i4z8OI=
Received: from CH2PR03CA0014.namprd03.prod.outlook.com (2603:10b6:610:59::24)
 by BYAPR03MB3878.namprd03.prod.outlook.com (2603:10b6:a03:66::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Fri, 20 Sep
 2019 07:57:27 +0000
Received: from BL2NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by CH2PR03CA0014.outlook.office365.com
 (2603:10b6:610:59::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Fri, 20 Sep 2019 07:57:27 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT015.mail.protection.outlook.com (10.152.77.167) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 20 Sep 2019 07:57:27 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8K7vLMG025790
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 20 Sep 2019 00:57:21 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 20 Sep 2019 03:57:26 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     <pmeerw@pmeerw.net>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH][RESEND] iio: tcs3414: fix iio_triggered_buffer_{pre,post}enable positions
Date:   Fri, 20 Sep 2019 10:57:23 +0300
Message-ID: <20190920075723.28293-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529142040.7993-1-alexandru.ardelean@analog.com>
References: <20190529142040.7993-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(39860400002)(346002)(189003)(199004)(51416003)(48376002)(478600001)(36756003)(356004)(7636002)(2616005)(126002)(305945005)(476003)(11346002)(446003)(6666004)(47776003)(486006)(44832011)(50226002)(246002)(5024004)(8676002)(8936002)(70586007)(26005)(7696005)(2351001)(2870700001)(2906002)(186003)(70206006)(1076003)(4326008)(336012)(316002)(426003)(54906003)(106002)(50466002)(76176011)(5660300002)(107886003)(86362001)(6916009)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3878;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5e235e2-7b9d-483a-17f6-08d73da02e07
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BYAPR03MB3878;
X-MS-TrafficTypeDiagnostic: BYAPR03MB3878:
X-Microsoft-Antispam-PRVS: <BYAPR03MB3878B01693AC06547FDD9235F9880@BYAPR03MB3878.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0166B75B74
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: WYct03GKE59q7Pf/2E9d1Btw1KOyL5zN7hovAYhXwYvifY6+mKjz8iPfiV8YDnjS0CftKmvvt97xNH5Jd8dGFYYRtu+niaNAaTrJpWl+limY+CLqc1f0dVgxhf+DflsqFgXQrSwDCcGtNBVHMNki7P3dAKmZb66lmqGh8hYuI4Fk95F6t9QwUJwCze7potQmDvVd35oWZgHHYziSkg+O15JFe2WF4hM62bHIso2/JCawG3hvCMGn3qcxqwsB5rPg/i4obRcMJ5Bnoyxg5eys5ps4/EXUULlMEltpn3vjTHgPMzL4tkumlX1uXOojrT+FKTcHjYdLy282ZqFsJ7+QC+EvEQmw4PovpLI7zzVoe4jtwoGRDk8iIzS0SHqdRkJofG/vDuF+79jPfOktRD3JAFqZgno4JZTY2GcATw4OzzQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2019 07:57:27.2102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e235e2-7b9d-483a-17f6-08d73da02e07
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3878
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-20_02:2019-09-19,2019-09-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909200077
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_triggered_buffer_{predisable,postenable} functions attach/detach
the poll functions.

For the predisable hook, the disable code should occur before detaching
the poll func, and for the postenable hook, the poll func should be
attached before the enable code.

The driver was slightly reworked. The preenable hook was moved to the
postenable, to add some symmetry to the postenable/predisable part.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/light/tcs3414.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index 7c0291c5fe76..b542e5619ead 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -240,32 +240,42 @@ static const struct iio_info tcs3414_info = {
 	.attrs = &tcs3414_attribute_group,
 };
 
-static int tcs3414_buffer_preenable(struct iio_dev *indio_dev)
+static int tcs3414_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct tcs3414_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_triggered_buffer_postenable(indio_dev);
+	if (ret)
+		return ret;
 
 	data->control |= TCS3414_CONTROL_ADC_EN;
-	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
+	ret = i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
 		data->control);
+	if (ret)
+		iio_triggered_buffer_predisable(indio_dev);
+
+	return ret;
 }
 
 static int tcs3414_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct tcs3414_data *data = iio_priv(indio_dev);
-	int ret;
-
-	ret = iio_triggered_buffer_predisable(indio_dev);
-	if (ret < 0)
-		return ret;
+	int ret, ret2;
 
 	data->control &= ~TCS3414_CONTROL_ADC_EN;
-	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
+	ret = i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
 		data->control);
+
+	ret2 = iio_triggered_buffer_predisable(indio_dev);
+	if (!ret)
+		ret = ret2;
+
+	return ret;
 }
 
 static const struct iio_buffer_setup_ops tcs3414_buffer_setup_ops = {
-	.preenable = tcs3414_buffer_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
+	.postenable = tcs3414_buffer_postenable,
 	.predisable = tcs3414_buffer_predisable,
 };
 
-- 
2.20.1

