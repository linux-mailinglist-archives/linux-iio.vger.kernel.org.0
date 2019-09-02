Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40DBA5750
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2019 15:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfIBNJX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Sep 2019 09:09:23 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35632 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729840AbfIBNJW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Sep 2019 09:09:22 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82CwbU4006770;
        Mon, 2 Sep 2019 09:08:59 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2053.outbound.protection.outlook.com [104.47.45.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uqjrab78q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 09:08:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXR1Y8NLxYfUvUt4XuhaKxonP3Y4U0tjdR53X8hHtD9WXemsZYCBgwF8yTUI8kiGnU8QpGOsQCC0NaC4k3NU/9qGkGS2qXHkU2pqPfo0b5h/HhqOeBChDJ0Po6AMueThI6ODkiFp1p9ioYORXwtLT9zIAA9qujnO9cAr368m0CCXSV6lJWmkt7WEc+SGqYKhcIAToizvQyr6/YZHLWybOkycE45o0wdyNDLEuT1R9szUR9EpPJCTObbYdmUUW0eUvfnjfkNptiYFSKuKGZFKySTO+H22AZnRkA8FlMX8+ofEnmtgifI5bVn/nVQ+z/JGtWauJzPQ/Mv3zVrwy5QJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbXsXun/TgtVwLRfRUd8LK1u2JOGQ34IUP16JX0/1cc=;
 b=NZfWkTVW8xeR9zCsCqREw7vNopkQhLCScedwsixCrnt9O4GUNcV1LOATu2peCfdrvjrFSpZBtXSjfmWIvhvHMyEn+De8egES+up/R/ncAgri6xMjbL61PEy7r4NM0wtOBODg9e4398wpWZj3UACUAUMu11Gq4rA37cWPo+e8v6GskYK+bjQGQrnnw9DHOuLDc3rKo2hRftjTuzl0ApLqq1qlHumve7RpUD8nK8IjtFcuaxe7BnIORBwJ3FNlSYoBLmdaIP3cB5BB0Lgn0Urpym7fJQourHrSmBy1MB44WshFoI+FQzWAXMj9oKCwEleRcTMO4HSXCWSAafKksUL3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbXsXun/TgtVwLRfRUd8LK1u2JOGQ34IUP16JX0/1cc=;
 b=daCuBBv2W1aD0kdsw8bnNoFpYh2sLBMOIArzgsoTWA/WOn5SJ1Ibm2LisxgYnVH1LHH/dz/cWmFbcyyBUtRX2OBjJA9OQuSoD7/FKe4YK8WLSpfqkWHL4lZ/WSRaKLKMTO/BHb11V3VkaYWz/tWtSrrmP0ADTHWAmmR9z16j56Q=
Received: from DM5PR03CA0034.namprd03.prod.outlook.com (2603:10b6:4:3b::23) by
 BN8PR03MB4852.namprd03.prod.outlook.com (2603:10b6:408:6a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Mon, 2 Sep 2019 13:08:41 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by DM5PR03CA0034.outlook.office365.com
 (2603:10b6:4:3b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.16 via Frontend
 Transport; Mon, 2 Sep 2019 13:08:41 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2220.16
 via Frontend Transport; Mon, 2 Sep 2019 13:08:41 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x82D8fr9027145
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 2 Sep 2019 06:08:41 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.107) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 2 Sep 2019 09:08:40 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V4 2/4] iio: adc: ad_sigma_delta: Export ad_sd_calibrate
Date:   Mon, 2 Sep 2019 16:08:29 +0300
Message-ID: <20190902130831.23057-2-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190902130831.23057-1-mircea.caprioru@analog.com>
References: <20190902130831.23057-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(54534003)(189003)(199004)(6666004)(14444005)(50226002)(36756003)(48376002)(4326008)(107886003)(11346002)(50466002)(47776003)(356004)(44832011)(2616005)(486006)(126002)(476003)(246002)(54906003)(16586007)(186003)(7696005)(51416003)(2351001)(5660300002)(6916009)(76176011)(478600001)(446003)(336012)(305945005)(106002)(8676002)(8936002)(70586007)(70206006)(316002)(1076003)(86362001)(2906002)(426003)(7636002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR03MB4852;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 079ba56e-f9cc-4fe1-59c6-08d72fa6ad46
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BN8PR03MB4852;
X-MS-TrafficTypeDiagnostic: BN8PR03MB4852:
X-Microsoft-Antispam-PRVS: <BN8PR03MB48527F17515F504645840B8D81BE0@BN8PR03MB4852.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 01480965DA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: M/JmO5QSPCI6X0Lt7OJcNv2CGxYJCZyhrQ0+vL/tFUCURwxzUzaizGMLMnQpgckpAuM2GuFHyM36U5FIVEw2V4DYxUP5tItgCJ5wk5GP6lbZCRHbkOODhBmOrFdUvB47x9Apnt5xZBxP3uUIuPd7ItX6w8BQyhe/SZ/Zs81fvUv9hLmvB9r9z3urxuVTKuo4UpP0x4YauV+kYCmYu5T2lapH+ReVE8gc2+kwGiuabqP5ISf+wdkJtOLuQnqRAblQeZXkjZEAp/jy4jyJ6XF+ekoXepeOtn59TEqxpGQD97RcMfUBogBy8xkuavfopFzVwpK1MP5WJ/MSjb5fADg/dPTivI5gKrqiC7hTbdH1RXHoWmiGmMp6X8TRvKkKXGRLIiyigF0rb3/Qn+P1nQ76SXKI69gnnRqFah/tnIfaehA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2019 13:08:41.3369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 079ba56e-f9cc-4fe1-59c6-08d72fa6ad46
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4852
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_04:2019-08-29,2019-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0 suspectscore=1
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909020146
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

Changelog V4:
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

