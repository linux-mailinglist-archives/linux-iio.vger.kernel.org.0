Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785A38B1BB
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2019 09:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfHMH4W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Aug 2019 03:56:22 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:38958 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728064AbfHMH4S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Aug 2019 03:56:18 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7D7r1JW016086;
        Tue, 13 Aug 2019 03:55:57 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2051.outbound.protection.outlook.com [104.47.49.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2u9qpays73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Aug 2019 03:55:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmZpT/whTGaBn6YUGUXyMHLecmMGKOr6dtV+1kdTvVps83xvspdeiS14w3gJu0oaj/tl8cs0tm2nQnDViH8yvN2lBmdd4GbzDep57cWLOCi8o7/GaERlsNuIfqPh+ixb1HycP4U3oHEGRYJYFbsiLn47w3eGz/9B6KarF/T5ayVAxDWf8IF2IZn/7gF+PVVrFW6EVMU6TIBnkx9tXyDYO6O2/F0vjcbAn9qTEVR8LfV7aEWq0AVdRrotfMIrJN29fBZkBEVwRFTMVrtdczwl1HMy9frfXIqRDDAjchzW8d/pSYfoZoDzMN/ndu/EYVzipEMICtx2eN4QnG/ko1bO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hV9OziO6O9qLrzvD4OnI+XV60TtId5mniIh0e20xV3A=;
 b=UPpklcSUplHPz33EOQVoSO8nPLUmrma9Gj8csb8e4/BlGmyxgBDghE+a+52LuBqyahfuKHqzQPL91IEhvksPiOY/+L9GAJWwcM2JdMtwGIJMojcnFBaBPr2qStwJteWRIbb57FjBr3O1I9hJGERBPsaLwIc51t7S2srCQPyGDl6vfbDPQM7z0NNNdfEAH94YPqmbzUNFfZiYuCKvqkvkdLXqhzQlY3utOSR4mdsREJN0fmp8jj22JtJ3JtmbKJx651mnVxYtT+O+1j8j4MVGMAHeKiEzR4ydcNQ8Fj8xY6znWLCU7FXF5UMJSwSXXdcRA23/cRzQ6w1J2WmJSfGh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hV9OziO6O9qLrzvD4OnI+XV60TtId5mniIh0e20xV3A=;
 b=WawO9M/yeLKgOIAkhG+FNZXR6Zr2C7BeJhOrxT1bO9euEoyEC3D4ABc0F95EvpL3kSQbm7Y0vEb+s16qNBY79EMjJ5mdytszpy8+GgS3ge7ZWc+B7km2W5yMrcd7EdqtCksvmUzz3zTaIs/WTMRAuOXEEXSXCHgEFZckOEVXmBo=
Received: from CH2PR03CA0010.namprd03.prod.outlook.com (2603:10b6:610:59::20)
 by BYAPR03MB4166.namprd03.prod.outlook.com (2603:10b6:a03:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.16; Tue, 13 Aug
 2019 07:55:55 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by CH2PR03CA0010.outlook.office365.com
 (2603:10b6:610:59::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.15 via Frontend
 Transport; Tue, 13 Aug 2019 07:55:55 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Tue, 13 Aug 2019 07:55:52 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x7D7tlQx015998
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 13 Aug 2019 00:55:47 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 13 Aug 2019 03:55:50 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V2 2/4] iio: adc: ad_sigma_delta: Export ad_sd_calibrate
Date:   Tue, 13 Aug 2019 10:55:42 +0300
Message-ID: <20190813075544.9122-2-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813075544.9122-1-mircea.caprioru@analog.com>
References: <20190813075544.9122-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(199004)(189003)(54534003)(47776003)(186003)(70206006)(2351001)(336012)(16586007)(48376002)(70586007)(50466002)(44832011)(5660300002)(446003)(426003)(26005)(478600001)(2616005)(11346002)(476003)(126002)(4326008)(486006)(54906003)(106002)(6666004)(356004)(316002)(6916009)(14444005)(76176011)(107886003)(51416003)(7696005)(36756003)(8676002)(7636002)(2906002)(246002)(305945005)(1076003)(86362001)(50226002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4166;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9b08db0-4497-47d2-190d-08d71fc3aac0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BYAPR03MB4166;
X-MS-TrafficTypeDiagnostic: BYAPR03MB4166:
X-Microsoft-Antispam-PRVS: <BYAPR03MB416697485B6B04BFD657D28181D20@BYAPR03MB4166.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 01283822F8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: VFJlCoEmouMf0WvXAfzgCdL4Y4AXZgg+iGr4XSiYMf09UaEeCWa8hGXageqXRaeaxa8s6HEo4FfW1KSme7TtixjllKO9ajAp4n0IqUS5XzKvXsMn2hsYwKUFlzRdSNMHOQATWx3ZINn6NTyLmID9xtgudZ6ZdlFrqxaXCbWIN6wrFbztr5CnyQrI/9Yueq1DfXNeso/tg7IKS34pTnno3FUczfC8qx4pivYS5Bu3PrLboAkuoo5O1O8UbnHI97aI76BYFPYQdEohi9iPr2w0E11WEHy/0BBYX4R3zEBtx6z7JVXWmIQFvMUzk5giOFHR9DbXj0lVXTF3ydX6Z/x/gclZlYbQOUPCrZjYXsBBjuuWvHlbHh+BretrZR3y1+tDGecIxrReJMK5RmUpIRp7MC7GqrNT50JMpucCAtwUKXI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2019 07:55:52.6953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b08db0-4497-47d2-190d-08d71fc3aac0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4166
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-13_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908130087
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

