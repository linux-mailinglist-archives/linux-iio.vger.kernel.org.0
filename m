Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A754210031F
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2019 12:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfKRLAW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Nov 2019 06:00:22 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:37874 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726703AbfKRLAW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Nov 2019 06:00:22 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAIArUI8003770;
        Mon, 18 Nov 2019 06:00:07 -0500
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2059.outbound.protection.outlook.com [104.47.41.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2waew7fcfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 06:00:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2xTFFjlN4ZejzKB7y+hnwUiJdLnujt7QonfIdFaXI82NnsM9mu9I3UyVXa2WLnhg4fMYG+dVXrTgyEFDDjbVpUg/hneg/xm8N253MSWu3LhtYsvuXxPr9AeNFBxdh4SR/ILqXJx3vOPMh4w86Op+sLgC1zh3F4URDICtAXBGJGUYVJ/2n5vOj5De6chDeLoQg8GJyv/NgM+bq5+sdjUIYvOp2fNVqCXrnYqlJ6eOkB7Q8Y0Bu5t/M6JX/vRJldioKegEvDms7yWOW2/53WkftP056XwT2QFQSf0ZZkKoL4Rc0/vVcwNLOmr1Lk/439/qml6nYwMCpdly2CJs+IBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPwPBjpHpLafE87i5JRKe+KwVxwbFfJuPnIIH/uGiGE=;
 b=dfuOMki9b960DqI3MI2wJofc0x6/TC16Ued6hjucUl6vYHbiiWB/M/Vngo7E+O25Lnsqv2n/m3TQoRZEYfq4MVe65gT6VpIo89bY9DaiBEHOShntfPpxLORIH0b/v+Srxkx+MEB1xIdMWtXQjj10DWxLquCLthDdJ8frKSED4We/kS3YIyV6C/tO1SKG6zwZF+m8HjdGRtbAoklHtd7f3D0sbt8WDGFLQsVNRz2crwsA95GGSi4A2KSJF5aeIGnt0nLiwYiswk4BBS2QAJ0E4SyVsJI3JQ5hf8gKUwPI4CBocwTDRP4M6zXCm1CYEcFluUYgl5sqoEfQ+nCzyyHJNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPwPBjpHpLafE87i5JRKe+KwVxwbFfJuPnIIH/uGiGE=;
 b=mZmwJ2rAVKN3X//hjgJuShUFWitu0RDCIN37l7rLKE9ewZKlLCjq5zuHjPCHb5IDwU5fVb7n2U8vObvZIDKGG5BMZg45KCWjnEkaQwznOPMbpqvFXvABS4xSWVqrYV8rHurOuGd/ZjelapSoxxw7OQkVVOerZ8Y1bFJeIQsvIYY=
Received: from BN8PR03CA0006.namprd03.prod.outlook.com (2603:10b6:408:94::19)
 by DM6PR03MB4652.namprd03.prod.outlook.com (2603:10b6:5:18d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Mon, 18 Nov
 2019 11:00:04 +0000
Received: from SN1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BN8PR03CA0006.outlook.office365.com
 (2603:10b6:408:94::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22 via Frontend
 Transport; Mon, 18 Nov 2019 10:59:58 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT024.mail.protection.outlook.com (10.152.72.127) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Mon, 18 Nov 2019 10:59:58 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAIAxnLx010665
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 18 Nov 2019 02:59:49 -0800
Received: from tachici-Precision-5530.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Nov 2019 05:59:57 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v2] iio: dac: ad7303: use regulator get optional to check for ext supply
Date:   Mon, 18 Nov 2019 12:58:07 +0200
Message-ID: <20191118105807.6842-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113083303.2229-1-alexandru.tachici@analog.com>
References: <20191113083303.2229-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(199004)(189003)(54534003)(8676002)(426003)(50226002)(51416003)(7696005)(4326008)(76176011)(26005)(106002)(2906002)(5660300002)(11346002)(2616005)(476003)(126002)(486006)(44832011)(107886003)(2870700001)(54906003)(86362001)(1076003)(316002)(47776003)(305945005)(8936002)(446003)(336012)(186003)(110136005)(246002)(50466002)(48376002)(356004)(6666004)(478600001)(70206006)(70586007)(36756003)(7636002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4652;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f27751d9-c2d6-45b3-0121-08d76c1673da
X-MS-TrafficTypeDiagnostic: DM6PR03MB4652:
X-Microsoft-Antispam-PRVS: <DM6PR03MB46521E92DE761F0BC370CDC6904D0@DM6PR03MB4652.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0225B0D5BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/s5y92F161R7gGaKrSVQpGb93qBfEUWVHlfdB+/gVDWeVvc0ApUB+XBd74Wpc7K8YpoCQ2CuiYTBHPSeGSrMgUuXoCXsf+BFBgJMNsSIAzp16WU7BMDsYXe/On59h3akFhDDcAX/xZacuA9/+oOrpppHeJ2GY/tcncit4vAW15hpu9RcfBN9hCh8KNpw//GjU/wgXjrgppS+DkdXUCW1afwXFXYOkeW+ZefG7JklGwj/kSBFf7b51cvx9zkANrpTl4vRvGox/X6mtsfxgf75w7IOeUiLrVGw5M71quc5HAdaQepR05Zob3K1fanvJZjDf4A+mC4ZDPz9oo5C8Y8vgBUNLLS/Umi4jcbHRLqTe390v9c0Wnn3Iw/j/aA1LyxiNmnRIAsvoSF05XVvQM+BMmEdoMeyZi3Mje2g08jZk2FArm0Zi4FjS5vTHXQAQT4
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 10:59:58.3900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f27751d9-c2d6-45b3-0121-08d76c1673da
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4652
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_02:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=977 spamscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911180099
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
Changelog v1 -> v2:

- check for -ENODEV error for devm_regulator_get_optional() call

 drivers/iio/dac/ad7303.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index 14bbac6bee98..15af8a1cce3e 100644
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
@@ -224,24 +222,15 @@ static int ad7303_probe(struct spi_device *spi)
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
-	}
-
-	if (ext_ref) {
-		st->vref_reg = devm_regulator_get(&spi->dev, "REF");
-		if (IS_ERR(st->vref_reg)) {
-			ret = PTR_ERR(st->vref_reg);
+	st->vref_reg = devm_regulator_get_optional(&spi->dev, "REF");
+	if (IS_ERR(st->vref_reg)) {
+		ret = PTR_ERR(st->vref_reg);
+		if (ret != -ENODEV)
 			goto err_disable_vdd_reg;
-		}
+		st->vref_reg = NULL;
+	}
 
+	if (st->vref_reg) {
 		ret = regulator_enable(st->vref_reg);
 		if (ret)
 			goto err_disable_vdd_reg;
-- 
2.20.1

