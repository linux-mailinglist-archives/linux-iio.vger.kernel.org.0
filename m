Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0F4107330
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2019 14:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfKVNaO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Nov 2019 08:30:14 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:27514 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727980AbfKVNaO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Nov 2019 08:30:14 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMDNAA9026851;
        Fri, 22 Nov 2019 08:30:10 -0500
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2059.outbound.protection.outlook.com [104.47.33.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2waew7wbps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 08:30:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7Oa3umH+FakYJT+y5XmxzxkRuH97ZjVHTTc32BRBZQeOgablreX/fgOkzckvA8trkFOoteu3QAF13+C6NXXDjMNLOYcIvHE91HF2Dd4gNdj8NqyOdC0XNWOn/+1WLSisgISJTvDaF/VvG09gitOPxsoXFQ+0r1wbfs73jP1HPJzUSr50Jys0QP/Jo5NGeqZFAJO8cRAOJhb+JDKNmL/Ev1Tox8TL2tDS6hXqsey7kdMTa04ZpYtHsbC2qhJTUtpJP+AbJmlLNxSxBiEX/69jJ64hTgOFnYuobonoRoHbrumPgdkRtF+665VXEkqspSrcLmotiW83bdRuaHF9XiwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iISF2zY8qZJahRqz+WmeheV6a3qMJ4vqTO0rYHYf8g=;
 b=HMl3CiIOHf/oo4yMomT6wYUcOcYOZi2EtEgPOeg6YoA87fdthZsKzWXIJFo9fJJTOaWaZ0FFu7nLabfFaYjrrY34fNFSTNsDlFhXDonvQeJVJKhHtxW9Aili09LCjtWyaHd09i7BMaZFY1YxNJMm8WHTZ6Jn01KsgeBwv6dCAoDEQApKc7oL3qbMySFvMkllMW0nhdQqKdKApNQtbHwnLtGFgGiY/bQTv3EnFvwoAkq4EnkbYFMoIWfD+Xe1sBY69UFioRU2o3FgfXBtN0XZ4nyhWp66jZca9teQdZfqtY+aZdinNfipfWo0eJpsXwcAMWarSTQ0NBniDHjts8DXPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iISF2zY8qZJahRqz+WmeheV6a3qMJ4vqTO0rYHYf8g=;
 b=JVOehvqSJ2IeyjmfA4Yq7xI0MplSeRWnU0LviJAHcKywjUGlKdIkuK30H7WBeOZVRHwJdDESi+jSiN6EIqbiTGWWdUBtNKBbD3iWIzzPB+JAkiVWwLWSDMBGdS+vztMMLxvavGzCKjHaMUppN5/i7dRDXjoDp/LEsK1X8GiQGVs=
Received: from DM6PR03CA0009.namprd03.prod.outlook.com (2603:10b6:5:40::22) by
 BY5PR03MB5062.namprd03.prod.outlook.com (2603:10b6:a03:1eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Fri, 22 Nov 2019 13:30:07 +0000
Received: from SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by DM6PR03CA0009.outlook.office365.com
 (2603:10b6:5:40::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Fri, 22 Nov 2019 13:30:06 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT023.mail.protection.outlook.com (10.152.72.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 22 Nov 2019 13:30:06 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAMDTuii015855
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 22 Nov 2019 05:29:57 -0800
Received: from saturn.ad.analog.com (10.48.65.119) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 22 Nov 2019 08:30:05 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 09/11] iio: gyro: adis16136: rework locks using ADIS library's state lock
Date:   Fri, 22 Nov 2019 15:24:19 +0200
Message-ID: <20191122132421.5500-10-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122132421.5500-1-alexandru.ardelean@analog.com>
References: <20191122132421.5500-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(199004)(189003)(86362001)(48376002)(5660300002)(50466002)(14444005)(356004)(246002)(70206006)(50226002)(8936002)(36756003)(47776003)(70586007)(8676002)(2906002)(426003)(186003)(107886003)(1076003)(4326008)(336012)(6666004)(2870700001)(446003)(11346002)(2616005)(54906003)(316002)(106002)(7696005)(51416003)(76176011)(26005)(44832011)(110136005)(7636002)(305945005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR03MB5062;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdc291ac-349f-4d65-da21-08d76f50169b
X-MS-TrafficTypeDiagnostic: BY5PR03MB5062:
X-Microsoft-Antispam-PRVS: <BY5PR03MB5062FFBFBE3D7BEF5AC88F96F9490@BY5PR03MB5062.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ltv8P9KE1Hv/X85nYMncOErgfIz5wkQrCk1sic4VLr2wMaOmaTPnnLEZG4stqw/yo3yJOrVzpEohgsEBdQdzBa5dwgjgvMvgkZfJoBBwCzwd9twuVR5eHqCWVHL15QUJKbN86M+d2q8v9hcziiwqZOEUwHS1RT+gv2HdYUTSjcB/FQdDjSmW4+4raM8zOy/G4m8oQyo8a9iRaSYMbchYuU1+diuX43Yo9QFYQ8odhJf2slb7pLR9MTxh3GWmc1y+xQU5XwfAloBuk2qXIdDkVmkYUMb/dTWRXMKWuCjLNZcecEX9uSXd5Cl9kHEvUjCWHPxa7ABkL5thlpoFmqzCEiO3lGQF6dutRByHSfmgwPxfYgUk2sz0I3cSi1d8jTFkPOdVYHyr8HLOTZ8heML0xWrCbPawXl4VaMg8XPTVNy6kqhysQSJ7XtmthjGY8bhH
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 13:30:06.2513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc291ac-349f-4d65-da21-08d76f50169b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5062
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911220119
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This replaces indio_dev's mlock with the state lock/mutex from the ADIS
library.

The __adis16136_get_freq() function has been prefixed to mark it as
unlocked. The adis16136_{set,get}_filter() functions now hold the state
lock for all the ops that they do.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/gyro/adis16136.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index d637d52d051a..f10c4f173898 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -185,12 +185,12 @@ static int adis16136_set_freq(struct adis16136 *adis16136, unsigned int freq)
 	return adis_write_reg_16(&adis16136->adis, ADIS16136_REG_SMPL_PRD, t);
 }
 
-static int adis16136_get_freq(struct adis16136 *adis16136, unsigned int *freq)
+static int __adis16136_get_freq(struct adis16136 *adis16136, unsigned int *freq)
 {
 	uint16_t t;
 	int ret;
 
-	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_SMPL_PRD, &t);
+	ret = __adis_read_reg_16(&adis16136->adis, ADIS16136_REG_SMPL_PRD, &t);
 	if (ret)
 		return ret;
 
@@ -224,10 +224,13 @@ static ssize_t adis16136_read_frequency(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct adis16136 *adis16136 = iio_priv(indio_dev);
+	struct mutex *slock = &adis16136->adis.state_lock;
 	unsigned int freq;
 	int ret;
 
-	ret = adis16136_get_freq(adis16136, &freq);
+	mutex_lock(slock);
+	ret = __adis16136_get_freq(adis16136, &freq);
+	mutex_unlock(slock);
 	if (ret)
 		return ret;
 
@@ -252,42 +255,50 @@ static const unsigned adis16136_3db_divisors[] = {
 static int adis16136_set_filter(struct iio_dev *indio_dev, int val)
 {
 	struct adis16136 *adis16136 = iio_priv(indio_dev);
+	struct mutex *slock = &adis16136->adis.state_lock;
 	unsigned int freq;
 	int i, ret;
 
-	ret = adis16136_get_freq(adis16136, &freq);
+	mutex_lock(slock);
+	ret = __adis16136_get_freq(adis16136, &freq);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	for (i = ARRAY_SIZE(adis16136_3db_divisors) - 1; i >= 1; i--) {
 		if (freq / adis16136_3db_divisors[i] >= val)
 			break;
 	}
 
-	return adis_write_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT, i);
+	ret = __adis_write_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT, i);
+out_unlock:
+	mutex_unlock(slock);
+
+	return ret;
 }
 
 static int adis16136_get_filter(struct iio_dev *indio_dev, int *val)
 {
 	struct adis16136 *adis16136 = iio_priv(indio_dev);
+	struct mutex *slock = &adis16136->adis.state_lock;
 	unsigned int freq;
 	uint16_t val16;
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(slock);
 
-	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT, &val16);
+	ret = __adis_read_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT,
+				 &val16);
 	if (ret)
 		goto err_unlock;
 
-	ret = adis16136_get_freq(adis16136, &freq);
+	ret = __adis16136_get_freq(adis16136, &freq);
 	if (ret)
 		goto err_unlock;
 
 	*val = freq / adis16136_3db_divisors[val16 & 0x07];
 
 err_unlock:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(slock);
 
 	return ret ? ret : IIO_VAL_INT;
 }
-- 
2.20.1

