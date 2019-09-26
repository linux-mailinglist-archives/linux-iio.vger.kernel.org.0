Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26AABF106
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 13:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfIZLSn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 07:18:43 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30906 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbfIZLSm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 07:18:42 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QBIA34014593;
        Thu, 26 Sep 2019 07:18:41 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2056.outbound.protection.outlook.com [104.47.48.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v6hj96t5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 07:18:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaCcztrsH0dBYz9YH9ajOsdvA238CC9ltP2YuKMFqB0uk2n/em8tIU4sExsDM4eTwygY/O8akxJShofsEgXSHvEsXtgg5cQY1e5Z51Q/+zNY3xovW0/lztQ+6228D0BNZMhR3RpQgDluR4BO318BVvKBauBQTGeBsq4FbhOwMolr1esmntvWV+1NX/Uc2Gt9+GA+8lSJGAcfCTP7yyaieyR3L+SS6jfwLTHqFXbZfeczhrFRnk9E9ucwlMLfPHr+vrnSUW9ZC30L29D1a1NQKhsr5BAfwVNmPoMEE0GY8W3mkxXQBDc+lp9myEiEeqjn55emR3EUDuJg5XPeWt+/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ch+iQ52oxfnJhnyr3CQC3ETIGGL4J1yccCtsTo6vwI=;
 b=U+RT+68bIAy0ZQxLY/o6peGaDEm9idSvkQS472v/ptkPoNL6akpeZRAy+yoxn3sGlox2ghlg5g8VD3u8ADzdbSbjHW9tzfFWCJgetI2Y4AkiNFpXWaCZTwmsyBK/x0SphyalMAi5/Y4Kzj5Mfa96ts4fSxcouBtdQNIC183EQd0nrOk4hcotNd6rwo89FjXCNIzUlFVJDgwp5MR0JbO5RPUFjRrQtm9cBySbNLBTyPHbefvV+bL8AVbE/CEzeC4VAMKa3RL5CwGlmEbyJUEDRU/xvfIvI0TZmkJO9TspT5l3yPllcu8Mvqu1ErLc6V0BG+aRq9ii0kSiKJSMXPm7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ch+iQ52oxfnJhnyr3CQC3ETIGGL4J1yccCtsTo6vwI=;
 b=3hZna7PwkbVsj8D1ncV63CPc3FtBx2kb2kRMWVfRKSaRu71GtJKEFGY+v79A98GIeS8nlA8GLWpfGwQKR9QSn8xDHvNg4CSeFimRJSSj1FqaHVWlJBfx4q3+zOqGyh0jZKbeMfO4N9J2WirfaC8uoQYVTNwueYpDbNrsiphj178=
Received: from CH2PR03CA0006.namprd03.prod.outlook.com (2603:10b6:610:59::16)
 by BN7PR03MB4497.namprd03.prod.outlook.com (2603:10b6:408:c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23; Thu, 26 Sep
 2019 11:18:39 +0000
Received: from SN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by CH2PR03CA0006.outlook.office365.com
 (2603:10b6:610:59::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.16 via Frontend
 Transport; Thu, 26 Sep 2019 11:18:39 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT034.mail.protection.outlook.com (10.152.72.141) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 11:18:38 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8QBIWIX004198
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 04:18:32 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 07:18:38 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 10/10] iio: imu: adis16480: use state lock for filter freq set
Date:   Thu, 26 Sep 2019 14:18:12 +0300
Message-ID: <20190926111812.15957-11-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926111812.15957-1-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(44832011)(5660300002)(7636002)(2906002)(110136005)(50466002)(54906003)(86362001)(486006)(246002)(48376002)(476003)(11346002)(1076003)(6666004)(50226002)(8676002)(446003)(8936002)(478600001)(426003)(70586007)(70206006)(316002)(356004)(47776003)(126002)(2616005)(186003)(7696005)(106002)(107886003)(336012)(36756003)(26005)(14444005)(76176011)(51416003)(4326008)(2870700001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB4497;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f98f1649-716f-4cd9-8e57-08d7427347db
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BN7PR03MB4497;
X-MS-TrafficTypeDiagnostic: BN7PR03MB4497:
X-Microsoft-Antispam-PRVS: <BN7PR03MB44972A85EBCB5E1058233833F9860@BN7PR03MB4497.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 5Clq3ql5w6LDAfoakz+cx44LxlwtzeRf4SGt9rlwqjS7+bSIOSqsc3Jux6vzNBB0ZMqP3DuiBpyDtf6hnT1qKCbFKnZ6yykWz5bEZkiDRozW1oUNmvZ3CFm92GSv0TB7GFF3p5J8UUNt9BZ8tf2VvuI4RrCHHeMb1J+U1agvoEeA3toUPVr0t/lnssKVUS3aCrtkR9cyI4B3tZt0kSooZzEe8zmBvI2x8MpHT+hVDRIHuseCQQ5+aFCqz9nNH5Dk4LmeM6gKAaH6BB4vnY9Z51LERNum1rlVPLVk5XpQbfNGmDEw9kj9ygwb5WsyJkAnWgIwYhyjkIbPMhXC5Ai3udKIqvUPMYcOQKb2pSPZV2jBGVNMzwSTN9cv9QDcSfWGtNbrNVCFTGG8HNiOuCTp9MGZ2wRJb3m6UHAgOq8LeQs=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 11:18:38.9417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f98f1649-716f-4cd9-8e57-08d7427347db
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4497
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

It's the only operation that does 2 operations (a read & a write), so the
unlocked functions can be used under a single state lock.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16480.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index dc13d8a33612..01dae50e985b 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -550,6 +550,7 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, unsigned int freq)
 {
 	struct adis16480 *st = iio_priv(indio_dev);
+	struct mutex *slock = &st->adis.state_lock;
 	unsigned int enable_mask, offset, reg;
 	unsigned int diff, best_diff;
 	unsigned int i, best_freq;
@@ -560,9 +561,11 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
 	offset = ad16480_filter_data[chan->scan_index][1];
 	enable_mask = BIT(offset + 2);
 
-	ret = adis_read_reg_16(&st->adis, reg, &val);
+	mutex_lock(slock);
+
+	ret = __adis_read_reg_16(&st->adis, reg, &val);
 	if (ret < 0)
-		return ret;
+		goto out_unlock;
 
 	if (freq == 0) {
 		val &= ~enable_mask;
@@ -584,7 +587,11 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
 		val |= enable_mask;
 	}
 
-	return adis_write_reg_16(&st->adis, reg, val);
+	ret = __adis_write_reg_16(&st->adis, reg, val);
+out_unlock:
+	mutex_unlock(slock);
+
+	return ret;
 }
 
 static int adis16480_read_raw(struct iio_dev *indio_dev,
-- 
2.20.1

