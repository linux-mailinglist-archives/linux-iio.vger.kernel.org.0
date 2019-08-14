Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD6A8CCDA
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2019 09:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfHNHc0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Aug 2019 03:32:26 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12674 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726880AbfHNHc0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Aug 2019 03:32:26 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7E7S256014574;
        Wed, 14 Aug 2019 03:32:06 -0400
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2054.outbound.protection.outlook.com [104.47.34.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ubx1n2d43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 03:32:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3YggN4WxDm1jCJWfHa+MmtyUm7XAkfSVNIN5s364wqiSNxayuQhsBABY+ToO2h758NXN7wV3KX03mUTFz+9nSPqK1vkrqogMUdYW770DDuin2jtFh8ZliUxeyM+ku/8TEbffv4rCBeTgEh7z6GIxJ3z0roE49yGdt4OsKZs8ouxpnsbU59/8yzqIP49cuSSlCAuLuU4mZ2l8rbdfg+hg82BDBvRsb47FT6qM+lTx/3EiuIoNdYCKBtE6SRNb+jbdDCkvKTay1G/md3MGLRR5llxT23BeTwetjAIS2BFD0O99YvAhKbPu8ia93GOT0BdvXsUjhplN9xhILI5GGo5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpcegcOHfYrjOAagOfoHRl0TxjQEF/Qk0j+ySdkDjB0=;
 b=OPl8S98EOd39gwYgUFYJsm1Lr1qHvE7DffxPJYwgchng3J+t5Y5gTnDYHhBaObGUFscFcguQp2CU36aDGBefUijgiTuyKdw0DY1TzuXXc+gbLSIV6DuOL/y8dL7+PFv/bhOMSfJHuYY+axc3Pmy/aR1XvM8bOWtgAB6dM6q+q2Vw6MoI1EIRkOFxJh4hYbi3Z7oAwChMpXHjKWdyjIqR8DdKaBAtKNVMJgXkkHAWrlQ1Qup+TCI0xIDlwIUPz3nnmx+LM23GWQlNtKpDYa3981bDW0cQ6v6uk+p00wecWwViQybVNaa5T1+2IPLfwEbOrOEol6odywudPUdAJ4SGVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpcegcOHfYrjOAagOfoHRl0TxjQEF/Qk0j+ySdkDjB0=;
 b=3n1Vx5wqIrrK8VyNFNz3NOGzdwNA12oBQu4CzQ+HcujJxkF0q1NwABrtVxz+dZ2NicEmXXZweI/k+ZdL8eNXnoNKbKkbVAVElXGLFP06X/5kRwPXBSfnnSE+YRteAY+fkrDi0QzUOvWZI1bMLxFWx4kfiN5unlOV8hUKDCukj3U=
Received: from DM6PR03CA0061.namprd03.prod.outlook.com (2603:10b6:5:100::38)
 by BL0PR03MB4209.namprd03.prod.outlook.com (2603:10b6:208:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14; Wed, 14 Aug
 2019 07:32:04 +0000
Received: from BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by DM6PR03CA0061.outlook.office365.com
 (2603:10b6:5:100::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14 via Frontend
 Transport; Wed, 14 Aug 2019 07:32:04 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT047.mail.protection.outlook.com (10.152.77.9) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Wed, 14 Aug 2019 07:32:03 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x7E7W3HE020945
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 14 Aug 2019 00:32:03 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 14 Aug 2019 03:32:02 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V3 2/4] iio: adc: ad_sigma_delta: Export ad_sd_calibrate
Date:   Wed, 14 Aug 2019 10:31:48 +0300
Message-ID: <20190814073150.4602-2-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814073150.4602-1-mircea.caprioru@analog.com>
References: <20190814073150.4602-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(2980300002)(54534003)(199004)(189003)(86362001)(44832011)(426003)(51416003)(70206006)(26005)(54906003)(50466002)(48376002)(106002)(186003)(70586007)(7696005)(11346002)(2616005)(476003)(126002)(486006)(446003)(356004)(246002)(76176011)(316002)(16586007)(6666004)(7636002)(14444005)(478600001)(305945005)(336012)(5660300002)(8676002)(2906002)(1076003)(47776003)(4326008)(6916009)(36756003)(107886003)(2351001)(8936002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR03MB4209;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2176dd29-1243-4ac3-9a99-08d720898091
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BL0PR03MB4209;
X-MS-TrafficTypeDiagnostic: BL0PR03MB4209:
X-Microsoft-Antispam-PRVS: <BL0PR03MB42091B28C5FE245DA4933DFA81AD0@BL0PR03MB4209.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 01294F875B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: pIhTwo41Ubh/5KaA41AHhScmej/2wFXCaUagD0zXTqJXSzv9AmUhTY8s59I/hADGi5UkKZ1gGMpoPVVIHTO30oTgptgMbfiNVQ+6PQMnpOHO+rLdSiaYylhj7Ffs0AHS+HBrxKPJoso4bXHKOe+8Dy3HsW+AfoVCNTJlBHS5YVR85/m/+QGiNw8d3uCKVWekKaStYDchoNPaJ4L2dyKEMF4MApTxLFNDb/gk8bzfUQbjtJDJgfSzfeDLZta2NCCCgIRN3oaM1l1pDaqhR7IDfXDD7KSU+OBHS5pMjICJcC4ACIPEM8ET1RGa9O9vq4sjqh1tWZRsSJZtETlUwgGwOg/E7xT5InpCvaS9Lk8rxbwr7jVNXw3MBHL6MJZWjlHdTtnY0VlZ3PifODLKyV+6UFVGvQ4/turwxqoiNjbJB+M=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2019 07:32:03.4948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2176dd29-1243-4ac3-9a99-08d720898091
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR03MB4209
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140072
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch exports the ad_sd_calibrate function in order to be able to
call it from outside ad_sigma_delta.

There are cases where the option to calibrate one channel at a time is
necessary (ex. system calibration for zero scale and full scale).

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
Changelog V2:
- no changes here

Changelog V3:
- no changes here

 drivers/iio/adc/ad_sigma_delta.c       | 3 ++-
 include/linux/iio/adc/ad_sigma_delta.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 2640b75fb774..8ba90486c787 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -205,7 +205,7 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
 }
 EXPORT_SYMBOL_GPL(ad_sd_reset);
 
-static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
+int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	unsigned int mode, unsigned int channel)
 {
 	int ret;
@@ -242,6 +242,7 @@ static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ad_sd_calibrate);
 
 /**
  * ad_sd_calibrate_all() - Performs channel calibration
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 7716fa0c9fce..8a4e25a7080c 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -119,6 +119,8 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
 
 int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, int *val);
+int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
+	unsigned int mode, unsigned int channel);
 int ad_sd_calibrate_all(struct ad_sigma_delta *sigma_delta,
 	const struct ad_sd_calib_data *cd, unsigned int n);
 int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
-- 
2.17.1

