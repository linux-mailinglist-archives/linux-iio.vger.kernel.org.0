Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89107BF105
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 13:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfIZLSj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 07:18:39 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:30200 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726152AbfIZLSi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 07:18:38 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QBI4Qf023486;
        Thu, 26 Sep 2019 07:18:35 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2052.outbound.protection.outlook.com [104.47.33.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v6hkcq63p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 07:18:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSa3l1HA1UznyGsxix9Cmst7NiiyayBJugKNI75ANPv2MWMT3RB70zMyJLZSCDnuIbX1fn3YhawV130sr67jXB0vS2wlaSXGKQ/ibn1BI2PLV1hRjVAaGR9NolHxUvvFYGEXWROGDaudKgvYWhHKnDKSqL1zwMBMR4gvloX8XNs2v0lww0nbDYzMToz5CjWgmCZeoid4vi0LOiQ7yJSuyVbuCOrA/H/2+WtR9WUX1igkNc1t91n+xlynTBeowiXPONWNXfGH20x6+v29/ugovmeZGMZFtDrxQIx5fUPz4xbCf7Es4wRNGCAx5j94X9ghefvjaByqhZa/jka9kifrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN7QXdu+j6PzshmTk2aFJI6WWWX94YXPAq7jOBxpj+0=;
 b=kCVxEkil+HYL9Y1Iq4/TjPZRWSVOT9o/SQ6s+Giyi6wIN59gW8aaGZGtsgulkW4Oyow/iVbQURDnAn7YjTcXxRYYRhxCv8p6rBsWDgsI72Hj3IaSyemg/8/9m58TKFpnPpGkIGGziZHE6ONEgh08VfZ+J+ut7yFipPog7ZxLV0tMTKaNDTnRbSXj3Nsh/AZWjkYxjHJgxoWHQOPJRkRGKYJ2RX9G+WRTza3H8Pjn7IACt3SiMhIckabCvazvhtmuyz6PRzZkzImi2lkwJWvnXRIEYtGPBDO7OuMm26kV3UXpVfdtImGJAx915p/78XeDIPjgRMO6DSPkh2ZiI2Xcag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN7QXdu+j6PzshmTk2aFJI6WWWX94YXPAq7jOBxpj+0=;
 b=dLRdKrkl4Q+JKht/aF/QQKJc7dIS90yp0BWgs3fohfvdeYy8kv7zhpGbe4tcohmj5QfYMxulOQ4GtLVHLuyTjsx0eLYXYvHyRHmq2MDG1pAAAlNSZb1PjKN8psIn87w8UuV9pU+My9XRoCh4MvQodaplz5AWBT/y7HFPfheULus=
Received: from BN6PR03CA0015.namprd03.prod.outlook.com (2603:10b6:404:23::25)
 by DM6PR03MB4299.namprd03.prod.outlook.com (2603:10b6:5:a::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Thu, 26 Sep 2019 11:18:33 +0000
Received: from BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by BN6PR03CA0015.outlook.office365.com
 (2603:10b6:404:23::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17 via Frontend
 Transport; Thu, 26 Sep 2019 11:18:33 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT032.mail.protection.outlook.com (10.152.77.169) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 11:18:33 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8QBIRe7004181
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 04:18:27 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 07:18:32 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 06/10] iio: imu: adis: protect initial startup routine with state lock
Date:   Thu, 26 Sep 2019 14:18:08 +0300
Message-ID: <20190926111812.15957-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926111812.15957-1-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(47776003)(478600001)(316002)(246002)(8676002)(48376002)(7636002)(50226002)(50466002)(8936002)(14444005)(106002)(4326008)(110136005)(54906003)(107886003)(6666004)(76176011)(44832011)(1076003)(305945005)(186003)(36756003)(356004)(26005)(476003)(2616005)(11346002)(446003)(336012)(126002)(86362001)(426003)(486006)(51416003)(7696005)(2870700001)(70206006)(5660300002)(70586007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4299;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a709cf64-a0a9-4046-ae07-08d742734463
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:DM6PR03MB4299;
X-MS-TrafficTypeDiagnostic: DM6PR03MB4299:
X-Microsoft-Antispam-PRVS: <DM6PR03MB42996404750E207EC594E874F9860@DM6PR03MB4299.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 7JiiooleQ50Q/UUnwM7Ku8gXCHHf6DuepfaLRvVb+AL+vYXUTDg0e0u8rVUZcyeWI7oaqVDcIoCPEyeBrFlafEszwZEzXUr4GeuxD25DIWYODjsrPW4EXo41X/MuuM0BTA1F/xDFsYIb9hZsNN+eJn0AFzd3bhdRWy1L4RX93zlSqZaIX1q7F7nkV6MYcplZLWbJYW4HnYxr81vDxxs2TqSuNxyVYBPL6peuzrIDSRwjGls7rVW+PHe9mEl9mx8HNFM/0DHf1QIwEza5xhPnyqwrytTFnFvimW72rbyK3OQV/1/UHhLh+lYuBsCHk7+QQCh5bfBTaM/N/QSuhm3t44Joc/s2+ssjK9m2juXvP6/yekk2ea+2RHCd44zStmhg1BCMHbpm252lGKBt8IuG5ngxQ5Tg097VDJKvQOuXd9E=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 11:18:33.1909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a709cf64-a0a9-4046-ae07-08d742734463
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4299
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909260108
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The initial startup routine is called by some ADIS drivers during probe,
and before registering with IIO. Normally, userspace should not be able to
do any access to the device (as there shouldn't be any available).

This change extends the state lock to the entire initial-startup routine.
Behaviourally nothing should change, but this should make the library
function a bit more robust.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index b14101bf34b9..7468294d1776 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -331,7 +331,7 @@ static int adis_self_test(struct adis *adis)
 {
 	int ret;
 
-	ret = adis_write_reg_16(adis, adis->data->msc_ctrl_reg,
+	ret = __adis_write_reg_16(adis, adis->data->msc_ctrl_reg,
 			adis->data->self_test_mask);
 	if (ret) {
 		dev_err(&adis->spi->dev, "Failed to initiate self test: %d\n",
@@ -341,10 +341,10 @@ static int adis_self_test(struct adis *adis)
 
 	msleep(adis->data->startup_delay);
 
-	ret = adis_check_status(adis);
+	ret = __adis_check_status(adis);
 
 	if (adis->data->self_test_no_autoclear)
-		adis_write_reg_16(adis, adis->data->msc_ctrl_reg, 0x00);
+		__adis_write_reg_16(adis, adis->data->msc_ctrl_reg, 0x00);
 
 	return ret;
 }
@@ -362,19 +362,23 @@ int adis_initial_startup(struct adis *adis)
 {
 	int ret;
 
+	mutex_lock(&adis->state_lock);
+
 	ret = adis_self_test(adis);
 	if (ret) {
 		dev_err(&adis->spi->dev, "Self-test failed, trying reset.\n");
-		adis_reset(adis);
+		__adis_reset(adis);
 		msleep(adis->data->startup_delay);
 		ret = adis_self_test(adis);
 		if (ret) {
 			dev_err(&adis->spi->dev, "Second self-test failed, giving up.\n");
-			return ret;
+			goto out_unlock;
 		}
 	}
 
-	return 0;
+out_unlock:
+	mutex_unlock(&adis->state_lock);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(adis_initial_startup);
 
-- 
2.20.1

