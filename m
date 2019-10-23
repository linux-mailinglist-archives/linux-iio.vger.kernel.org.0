Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7D6E141F
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2019 10:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389987AbfJWI0P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Oct 2019 04:26:15 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:18080 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727574AbfJWI0O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Oct 2019 04:26:14 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9N8MukX020880;
        Wed, 23 Oct 2019 04:26:12 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2056.outbound.protection.outlook.com [104.47.49.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vt9t5shy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 04:26:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUtj4l+n4rcN8abQ5gkUVgz3loKBgT7DiexyvXjfCb4Ab7RhjOvDFWn81YssTNyfe8SkdzADqlJAxpKnFKRt/1wNS9gAbtnTt5ONP97vPKlL61/JVvcJgq0ga76TOuizhBAd4bZCtTOhKazUC3sDk2tZU83avP/SWuYU+aWdpsnb6L2kpAWdMEzmN2+avSKUjBzAucIt1pJRrZGznxx3ANq0k9e80X96eYHht7HvAP/bBoe1ZjxIAzBWIBpgaqSEJVs1RQd40xQ1MngwK4/ejl+f8+BdSGqD06ya8klUV9Hd+/a/oOA5Pd9OFJnEMnIF1DGq3h8MX6MGcRiKifwQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8/I9CB09DPrylfk8Oh+ehdQaPGYVqbsao+i67xiry8=;
 b=NPCFk+yTWRiCLFGUcXF+Xc2Gkn7HjzyEFixoG35LJGXXXLr/UGaveqQBy2LYIoSUzf1D49zr7XiD0V50NC2swYdH4bqzqWgYB5WdSUvKHGcrhUcBzfZwRlAoSPtuRS78rvmfpXXvK9P5PcueVLpq8wH5B+IM1R054ZTcTizzwGCzr7AEnCgzMoTAAG0UYqh5TEpz7t8Tvc+6eZEox+CeR6izi/GTF1E5ElBOoxZ/On8e4aBqNN+v/kMdVzFgejkiKO3/WxxQrN03FmCAb0C43CDDvOCjuQodUlz+2U7Htcv9nWma9SvriO6fx8OM0/hu2qsuOdx+5vO7LBzTM5LDLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8/I9CB09DPrylfk8Oh+ehdQaPGYVqbsao+i67xiry8=;
 b=v0bT0NLyCbMCiSWZTBxvr7OA/FUWpoi2Q8YfkbgvYSkgfDtm8jg3c3BuTbVQTdpJA9qB8sSatUtGYEf2/uBHF/k7I42DWhUNBtzJLlGW1f/ulZNU9L8ckaERKf/03yy8iQn1iy2bft5ZLeWfxClvUZQ6robV09C20NTdoG29d+g=
Received: from BN3PR03CA0065.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::25) by BN6PR03MB2740.namprd03.prod.outlook.com
 (2603:10b6:404:5b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Wed, 23 Oct
 2019 08:26:11 +0000
Received: from BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN3PR03CA0065.outlook.office365.com
 (2a01:111:e400:7a4d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20 via Frontend
 Transport; Wed, 23 Oct 2019 08:26:11 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT017.mail.protection.outlook.com (10.152.77.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Wed, 23 Oct 2019 08:26:10 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x9N8Q3iC012485
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 23 Oct 2019 01:26:03 -0700
Received: from saturn.ad.analog.com (10.48.65.116) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Oct 2019 04:26:10 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: dln2-adc: fix iio_triggered_buffer_postenable() position
Date:   Wed, 23 Oct 2019 11:26:34 +0300
Message-ID: <20191023082634.18195-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(5660300002)(426003)(47776003)(8676002)(336012)(50466002)(186003)(4326008)(48376002)(6666004)(8936002)(50226002)(14444005)(5024004)(246002)(356004)(107886003)(70206006)(316002)(36756003)(110136005)(54906003)(1076003)(126002)(26005)(70586007)(106002)(2870700001)(44832011)(486006)(51416003)(86362001)(7696005)(7636002)(476003)(2616005)(2906002)(305945005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2740;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75a46c1a-1dec-4ed0-4f91-08d75792a90f
X-MS-TrafficTypeDiagnostic: BN6PR03MB2740:
X-Microsoft-Antispam-PRVS: <BN6PR03MB2740451260E1984CBFA5EDB3F96B0@BN6PR03MB2740.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 019919A9E4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: neJcWVoHwOIRbVdk3SIhOX9rSrXi/iLMet21mav/xiSLUUCDtZ+8QvtCD//pquQE+phmWEDW+0Ou+R4nMGSRkYfz+i1dptCJ7ygVkqP11yAnA/c/S7tDWKSSIvuKPJ/r0UNHN2YNjBpX1bri75OHYm/n5lNrUKSENINXchQOHHbmpmtIC+5yD0kzZxNV8b90KqahU2ZjPREx86oOtF/EM3BCGuwwyv6TkE8EbRsDKzkKWqao6XO4hMsH7n4IBpt9zTXjFMIKEO5aWzPs5YVIgIUkG1AA6zSHH3TCeEwxivfKbm/DHe6QMX8tQXk/vM3R0FcomYUABmasZ0C7aLE4A5c9zn1YK5WPLNm3kXzxj0xxbU3MtZGci1BCUHLPYoqzOqOFYIfO6uK0uraAE1jRe9Jqs3fc/+4SDnBIVpQu1fFsNbl6RTSFmdVNZMv+Jyly
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2019 08:26:10.8948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a46c1a-1dec-4ed0-4f91-08d75792a90f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2740
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-23_02:2019-10-22,2019-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910230083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_triggered_buffer_postenable() hook should be called first to
attach the poll function. The iio_triggered_buffer_predisable() hook is
called last (as is it should).

This change moves iio_triggered_buffer_postenable() to be called first. It
adds iio_triggered_buffer_predisable() on the error paths of the postenable
hook.
For the predisable hook, some code-paths have been changed to make sure
that the iio_triggered_buffer_predisable() hook gets called in case there
is an error before it.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/dln2-adc.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index 5fa78c273a25..65c7c9329b1c 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -524,6 +524,10 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
 	u16 conflict;
 	unsigned int trigger_chan;
 
+	ret = iio_triggered_buffer_postenable(indio_dev);
+	if (ret)
+		return ret;
+
 	mutex_lock(&dln2->mutex);
 
 	/* Enable ADC */
@@ -537,6 +541,7 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
 				(int)conflict);
 			ret = -EBUSY;
 		}
+		iio_triggered_buffer_predisable(indio_dev);
 		return ret;
 	}
 
@@ -550,6 +555,7 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
 		mutex_unlock(&dln2->mutex);
 		if (ret < 0) {
 			dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
+			iio_triggered_buffer_predisable(indio_dev);
 			return ret;
 		}
 	} else {
@@ -557,12 +563,12 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
 		mutex_unlock(&dln2->mutex);
 	}
 
-	return iio_triggered_buffer_postenable(indio_dev);
+	return 0;
 }
 
 static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
 {
-	int ret;
+	int ret, ret2;
 	struct dln2_adc *dln2 = iio_priv(indio_dev);
 
 	mutex_lock(&dln2->mutex);
@@ -577,12 +583,14 @@ static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
 	ret = dln2_adc_set_port_enabled(dln2, false, NULL);
 
 	mutex_unlock(&dln2->mutex);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
-		return ret;
-	}
 
-	return iio_triggered_buffer_predisable(indio_dev);
+	ret2 = iio_triggered_buffer_predisable(indio_dev);
+	if (ret == 0)
+		ret = ret2;
+
+	return ret;
 }
 
 static const struct iio_buffer_setup_ops dln2_adc_buffer_setup_ops = {
-- 
2.20.1

