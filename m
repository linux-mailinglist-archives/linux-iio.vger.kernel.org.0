Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 663B2FAC20
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2019 09:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfKMIfe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Nov 2019 03:35:34 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:50704 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbfKMIfe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2019 03:35:34 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAD8WtEl025599;
        Wed, 13 Nov 2019 03:35:18 -0500
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2054.outbound.protection.outlook.com [104.47.33.54])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w7pr6k44w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 03:35:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oc877TE+80M71ItB+zdd3JlLcQFcyYPJVZuRRtXvX8kJh6gL9nq7cZ8Yh6TNrvPuU4PF2R/kI7TpkI14bQ8FyR1Vxv/O1vlTQveBhzB8ssAdKvTULLU9cdXGD6S1Oc/xY26322/3nrEAu5LL3vGCox4pv63LiaoIS53Hr+GEVfNjBsp+qcm2bso4/8SN1wokC9KZS3BWO8lexDeXBd7yoSeE8b2jNBIZXKGgPpppJ2BXyvQcGJw6fihOk2KH1/Ox8HdO53cdyRwU9/XFf3sdTD4ah0jCim35FkqU45g930ClegFcUmo4DYl/Fh55ppUo8woXZMwypXokXJXZPr47sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACFf3j0dAaFmyDZvuC5Px2tq1qxXMi0WCMoDGHMmLt4=;
 b=OUkW0LJqVOUReyqwEA9a5ZIHMpIjIt0oF4afmcGAuEnE5fWhqNwkDxGt4aLRo5EY3M5LBa6uJ/1L2Y13v/lBX1H82oIvfostAVZkjHj0ADSLu6gcs1NbF98wLnDzgzgQN4foWmJNkeRD1MqvPHHf113afOvajuMfOS2kDlADEgv+aaNBMRZk7tHg6sItIMLpj4yqv2NXvH6qsr2ZlaoQbr5bSjkbpTFHWP1dnTr8zWqTAlPoE6AYbL3gy5YIAgayffGt1DNL3ZArSgjhZfM42X8bSrNy3pUlZJFwlFW1Luj24hR20GOdjhHag+nsSSk+Qi0stc+DLvv+K0nvzIEKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACFf3j0dAaFmyDZvuC5Px2tq1qxXMi0WCMoDGHMmLt4=;
 b=k19ltE40nan0dt07aI70TrWhgYT/AOitkx6sJ03sU5IKi7AFvh/tRkxp7WMr/wGj+Wq73FU6B8RvWYlKlEQ9kUMFEFZJH6cmBmP3mtvRAEBM3SJV1UgHUBwVhOGTKMXb3DGWx414QoBZf2GOKzJOpco/8XyKH8bAhBVCgTT3/DE=
Received: from DM6PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:100::30)
 by BN7PR03MB3780.namprd03.prod.outlook.com (2603:10b6:408:31::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22; Wed, 13 Nov
 2019 08:35:16 +0000
Received: from BL2NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by DM6PR03CA0053.outlook.office365.com
 (2603:10b6:5:100::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Wed, 13 Nov 2019 08:35:16 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT039.mail.protection.outlook.com (10.152.77.152) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Wed, 13 Nov 2019 08:35:16 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAD8Z7Pk003224
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 13 Nov 2019 00:35:07 -0800
Received: from tachici-Precision-5530.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 13 Nov 2019 03:35:15 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH] iio: dac: ad7303: use regulator get optional to check for ext supply
Date:   Wed, 13 Nov 2019 10:33:03 +0200
Message-ID: <20191113083303.2229-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(376002)(199004)(189003)(8936002)(48376002)(86362001)(7636002)(50226002)(305945005)(51416003)(486006)(1076003)(246002)(8676002)(126002)(70206006)(476003)(7696005)(70586007)(5660300002)(44832011)(2870700001)(2616005)(2906002)(50466002)(26005)(107886003)(336012)(4326008)(36756003)(47776003)(6666004)(316002)(54906003)(478600001)(186003)(106002)(426003)(356004)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3780;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66a035a0-4654-4cac-ba7b-08d7681468db
X-MS-TrafficTypeDiagnostic: BN7PR03MB3780:
X-Microsoft-Antispam-PRVS: <BN7PR03MB37803ACC4190BECBAACF932890760@BN7PR03MB3780.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 0220D4B98D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Zs0XXy2MxmDJvWv+QkUAyn8of2wqloPl/vz2NGQBNKBrKUbe7nAr8Ra5bPebJWbXvKr52LybEhA1n75WObvp6daldU3NzEQhbpwCXW9zXEHdSXJWJsFAGyVNuTzImEbXg3eBBtocAuH2SbGhlaxp1etOWp7YpeextRekwFKX2oq/u5LYaG29SYPgIIF5z0DtBHzHu500NopZTjSosMX1Wl02v0M751Bs61L6k7iH2HYxoBY2Ik5AKrbNLzGMBZHSrhyNMGXY17ojYK1y+YDRTL7dvQGxUHCqREs/x9ueQAKFbRCWK/nOO/mJk9EwQbu5z14dTjR9kTINhTC/2+cnGO2HVgcheXNWXgaP+iSt3Zv3P9dhtt8eOM458wJoj0dGTJRyGRymZIcBBeEe2eqiBtcKUzsHv4EMJKTeUWNifsRMDo+sU9lf/EJy4xzJCCX
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 08:35:16.3639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a035a0-4654-4cac-ba7b-08d7681468db
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3780
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_02:2019-11-13,2019-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=981 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911130078
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Previously, the code was using the of_read_property_bool() to check if
an external regulator was provided. However, this is redundant, as it's
more simple/direct to just ask the regulator is provided, via a
`devm_regulator_get_optional()` call.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/dac/ad7303.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index 14bbac6bee98..e0c5fed4475c 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -12,7 +12,6 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/regulator/consumer.h>
-#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -202,7 +201,6 @@ static int ad7303_probe(struct spi_device *spi)
 	const struct spi_device_id *id = spi_get_device_id(spi);
 	struct iio_dev *indio_dev;
 	struct ad7303_state *st;
-	bool ext_ref;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -224,24 +222,13 @@ static int ad7303_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	if (spi->dev.of_node) {
-		ext_ref = of_property_read_bool(spi->dev.of_node,
-				"REF-supply");
-	} else {
-		struct ad7303_platform_data *pdata = spi->dev.platform_data;
-		if (pdata && pdata->use_external_ref)
-			ext_ref = true;
-		else
-		    ext_ref = false;
+	st->vref_reg = devm_regulator_get_optional(&spi->dev, "REF");
+	if (IS_ERR(st->vref_reg)) {
+		ret = PTR_ERR(st->vref_reg);
+		goto err_disable_vdd_reg;
 	}
 
-	if (ext_ref) {
-		st->vref_reg = devm_regulator_get(&spi->dev, "REF");
-		if (IS_ERR(st->vref_reg)) {
-			ret = PTR_ERR(st->vref_reg);
-			goto err_disable_vdd_reg;
-		}
-
+	if (st->vref_reg) {
 		ret = regulator_enable(st->vref_reg);
 		if (ret)
 			goto err_disable_vdd_reg;
-- 
2.20.1

