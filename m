Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62F7FBF0FC
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 13:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfIZLSj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 07:18:39 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:27990 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbfIZLSi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 07:18:38 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QBI8Xo014586;
        Thu, 26 Sep 2019 07:18:37 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2055.outbound.protection.outlook.com [104.47.37.55])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v6hj96t58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 07:18:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9LeiJsDGsC+U25iBUwHK3B03ifd+r8AolbwnUCgzBitez4Ojx4u86xOzLlw8pxC3ZWS1HSe1K+42sjEZ0fEHJiCwpDkEfrQM21M4HabfLf4nlx8IhfurjqSaEgCqX+agOTwrijEsaICvdlDQo7gw5oQ/W8IfixiIodzWmBmyShT2+RL2avpW5Mz5A1DxRfte+X2WUIt3hGHcyUEUTKO5fHBdTj9bMG+vQgJt4zWMxS05/ablhskFyrtz86xTgy7Fa0gkfbZ+gkhp9fsB0+lfvxd6V+hSOBoPfRSkc3IZAkfyIeFr5npq8zzh3ckpY9+DAi17qnTBs2fkTQ4Hgt4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfh2s0GI4aiMPSoo8U61MEac2w0eidxFohzMbvW/gts=;
 b=f5GfMHdVPKjvm6cwNBTzAEGFu5q/iBfpnTXDC+YlBgDa93UTBZR46hiTXPjxU4MBps4R1y6A3ohp7R/OuaS8Sr7LzXhe4n0NxfczvalcuEOX+x5xKcmpmoRXOmICzPxw86qyjJ+jUa6694eItE1Mh9g+YZgjB3ZsafyWpXCMsCKmA0Qcsy2kvYhSAujGiAi2BySYnqyBtefQuivJcBUd7+Qb+phaJbSCxwE5/xfiE2zi7F82hCpWW35pUKlHB5Af/eDFAyTHRBRUIyeAd4+uBRR+6yxScL7i1PN4dMiCbJVtUFVR3gzpASZbJL/PIKe66qVlnxkYmbFfIa7VvQcxXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfh2s0GI4aiMPSoo8U61MEac2w0eidxFohzMbvW/gts=;
 b=9uOBh0plmiY7g3Xklh6v/mmwNI6UY1eXtaNpC8jgAqV7+VHq22q/6d+4gUa2Ghv5Sdr076119IEeUWNDbPBK5hFTUDygg3Ex7PYwTIo4k0q7xiMmBVJ9UrzLLijaJi2Tn2wAwHX+EWP3SMEsKGgNGqlM6Wh9BekZaUk6H27GpBk=
Received: from CH2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:59::28)
 by DM6PR03MB5276.namprd03.prod.outlook.com (2603:10b6:5:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.26; Thu, 26 Sep
 2019 11:18:35 +0000
Received: from SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by CH2PR03CA0018.outlook.office365.com
 (2603:10b6:610:59::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.21 via Frontend
 Transport; Thu, 26 Sep 2019 11:18:35 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT033.mail.protection.outlook.com (10.152.72.133) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 11:18:34 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8QBISWl004187
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 04:18:28 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 07:18:33 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 07/10] iio: imu: adis: group single conversion under a single state lock
Date:   Thu, 26 Sep 2019 14:18:09 +0300
Message-ID: <20190926111812.15957-8-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926111812.15957-1-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(189003)(199004)(50226002)(70206006)(36756003)(8936002)(426003)(8676002)(476003)(2616005)(11346002)(126002)(446003)(486006)(2870700001)(5660300002)(44832011)(336012)(47776003)(1076003)(2906002)(6666004)(246002)(316002)(48376002)(14444005)(86362001)(107886003)(478600001)(70586007)(186003)(356004)(26005)(76176011)(305945005)(7696005)(106002)(50466002)(110136005)(51416003)(4326008)(54906003)(7636002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5276;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86e4622e-8b56-40f8-23ab-08d74273457a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:DM6PR03MB5276;
X-MS-TrafficTypeDiagnostic: DM6PR03MB5276:
X-Microsoft-Antispam-PRVS: <DM6PR03MB52765E47728D4BE060777D36F9860@DM6PR03MB5276.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 8DS4m6EaFiKlGT31T/JufvhV4sd9kv63o0OrMskN3+N2czX2wOk39xubcMl1C9Tlgyc/XACbZ4eRj516Alkxt+fYHdN2NphdJ7eK1/6GYH51c95iAjAwtGp0rEZFDAeQSGgTrskSeAXkj33PHSDuox6ZCRgLnR6SN8OMMwd4Go7ZObEDDW7OBvCrqyK7lFeBiKRKhoClhjC+Eb2a839eXm3SxBx6f+jUZsGeHDs/eXoHYx0LFd18Fncfn41AvX6BYuythKdEv2P19KJmMds6Cst6VKTGGSyVWGd1KKPvP/s0OuKCcUZp0bGmF+JrLv7IkzeZYIliSuAiF9Lqc75bQpDsJRGt2jqBQyjrRRSDk2ZI/lUCGsPmKMViHo2yYWmFGT9zNP75/HJ6T1ZdCDTZxZEiBLU5FK2iPckZ2eB3YmA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 11:18:34.9458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e4622e-8b56-40f8-23ab-08d74273457a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5276
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909260108
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 7468294d1776..5e28464ea05b 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -404,15 +404,15 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 	unsigned int uval;
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&adis->state_lock);
 
-	ret = adis_read_reg(adis, chan->address, &uval,
+	ret = __adis_read_reg(adis, chan->address, &uval,
 			chan->scan_type.storagebits / 8);
 	if (ret)
 		goto err_unlock;
 
 	if (uval & error_mask) {
-		ret = adis_check_status(adis);
+		ret = __adis_check_status(adis);
 		if (ret)
 			goto err_unlock;
 	}
@@ -424,7 +424,7 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 
 	ret = IIO_VAL_INT;
 err_unlock:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&adis->state_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(adis_single_conversion);
-- 
2.20.1

