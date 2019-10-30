Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2654FE9B30
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2019 12:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfJ3Lzs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Oct 2019 07:55:48 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:19964 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbfJ3Lzs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Oct 2019 07:55:48 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9UBlhHm008896;
        Wed, 30 Oct 2019 07:55:32 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2052.outbound.protection.outlook.com [104.47.41.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vxwgw9gct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 07:55:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=junUjPqhHAM+a19FlGZ1KF37npC1WyhA3CQNWEtq+L0I2VV76HdKwmjQYh9a0eclrs6g1MLJZq27A4wrrk7/72uCQ/CU2bImBMQISzwoubWDDJ8uml3IQt0f9CgVQx2fKricw+orgp2IgEFqrs8sngRnS0OJbRMxHtlGlekIBeTIsRyQPIRNFBFNYrF4xaJkhbL6HJEwe7rYgsDyaX6xsxwmy7GR50D0CLp7rsyAAc2HYHwhsETAT+VuGv1fj2cIiKB7tzpxb3LzdrPekWYsweYPHjRCmVQBgLSPG6Q991kjmIEeBBxAVoJVzmys+k2b32gTcKxHcyExGy60QPqZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNVqn/wOghXwSVSvCsoW0WLZEJQ+8rG4X/dJV39Dcj0=;
 b=DZq7eSejn71/EFei/o4PUm/WrkqOdlpnr2mzTmoObyp4vrHIVNhuLislLlu16cdFW9ArEOuoZ9DcxMgFENWnDkR1/HOsaaVA/fjl6O5Gb6Go/fsXP2VNkeIUuH96fQfzuEk3cU07KMQqlyovI/04dlCkGlo3okzIsIIUGvX5m45Ab53fEtaON0RLp6E24Ph+g89O54cFQzKqU4BuvQsXWYXo2/sWojiIn7bFD2Hk2sp+Vmr1BNX4PBXuhIUzT2j5msj31EO7dd4jkGoEqmL3g7rQjJZwc1jf7ItntnV/kuplJK3u52vC9mzZqRKQskDtk9w28NjtCCRmJ1wicNKDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNVqn/wOghXwSVSvCsoW0WLZEJQ+8rG4X/dJV39Dcj0=;
 b=Hl4bUDYMXMJFsa85blf74O5v9jgZ1pSLJ8FiT6sk2E3VE7lAuTsFs9sE23EEu+2TFO+J6oc5XKmlGSS7hsL15lVvr8q9q3Vnwe9nElTaAUwTQmpkWGCM6lyjMt2cPKi1LKqWrI3PFUVTlePnZkULyWwJwftpHyJ9tvqe5Y2607I=
Received: from DM6PR03CA0002.namprd03.prod.outlook.com (2603:10b6:5:40::15) by
 BYAPR03MB4613.namprd03.prod.outlook.com (2603:10b6:a03:13d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Wed, 30 Oct
 2019 11:55:19 +0000
Received: from BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by DM6PR03CA0002.outlook.office365.com
 (2603:10b6:5:40::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.17 via Frontend
 Transport; Wed, 30 Oct 2019 11:55:18 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT047.mail.protection.outlook.com (10.152.77.9) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Wed, 30 Oct 2019 11:55:18 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x9UBtIHR011077
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 30 Oct 2019 04:55:18 -0700
Received: from saturn.ad.analog.com (10.48.65.116) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 30 Oct 2019 07:55:17 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: imu: adis: assign value only if return code zero in read funcs
Date:   Wed, 30 Oct 2019 13:55:11 +0200
Message-ID: <20191030115511.28975-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(189003)(199004)(36756003)(478600001)(7696005)(246002)(8676002)(8936002)(51416003)(2906002)(1076003)(2870700001)(107886003)(6666004)(356004)(5660300002)(486006)(50466002)(305945005)(48376002)(7636002)(126002)(47776003)(476003)(26005)(336012)(316002)(44832011)(426003)(186003)(70206006)(54906003)(106002)(110136005)(4326008)(86362001)(70586007)(2616005)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4613;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe398d2a-d607-4bbe-43d0-08d75d300904
X-MS-TrafficTypeDiagnostic: BYAPR03MB4613:
X-Microsoft-Antispam-PRVS: <BYAPR03MB461368B8B4F01FBC36F4FAB2F9600@BYAPR03MB4613.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 02065A9E77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YZx9rehPDXJQTpAzJbkQTFCUdz2BzJbmJqA1RbigJC1pgllvX1hRasyGXsb7PelfcFapbvYn/DvSGOqTuTqsa+qHD1n5AyX8yuUUgEd6BepmCBG0sWPb/InXliO7Vxqx1VAwRw1QoF6u8zRA7iEsE1p5Rc9MXSkrcME9gqOLqfuzf9cebj0q2BqhiwlblH4q6HCh0XRdCQu3R546GCUCPeQ5L76Dvw7rtGVgT5U8FW4lMKRCsgE1LI2aWZTrQZL2gy9SnHnukcoBHx47h63CEE/AemoWbUz76DkFa3TpCtDTKB571qfZB5bMNvn56g9Ej931+ri5K+f/I3swSKy4wQd2+U7H82ztvPpihQejpgbOvHaiHGwJmSJ7/0dd1IX5vs7VpcvVP/2PsUTbbk1AqzRjG77mXLDRl725lKbGY40aJ/UsrcaFeOLB1OgFNUN
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2019 11:55:18.6862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe398d2a-d607-4bbe-43d0-08d75d300904
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4613
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-30_05:2019-10-30,2019-10-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=911
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910300119
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The inline read functions in the ADIS library don't check the return value
of the `adis_read_reg()` function and assign the value of `tmp` regardless.

Fix this by checking if return value is zero and only then assigning the
value of `tmp`.

Fixes: 57a1228a06b7a ("iio:imu:adis: Add support for 32bit registers")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/iio/imu/adis.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 4c53815bb729..92aae14593bf 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -129,7 +129,8 @@ static inline int adis_read_reg_16(struct adis *adis, unsigned int reg,
 	int ret;
 
 	ret = adis_read_reg(adis, reg, &tmp, 2);
-	*val = tmp;
+	if (ret == 0)
+		*val = tmp;
 
 	return ret;
 }
@@ -147,7 +148,8 @@ static inline int adis_read_reg_32(struct adis *adis, unsigned int reg,
 	int ret;
 
 	ret = adis_read_reg(adis, reg, &tmp, 4);
-	*val = tmp;
+	if (ret == 0)
+		*val = tmp;
 
 	return ret;
 }
-- 
2.20.1

