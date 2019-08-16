Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9618FAFE
	for <lists+linux-iio@lfdr.de>; Fri, 16 Aug 2019 08:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfHPG3E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Aug 2019 02:29:04 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:4720 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbfHPG3E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Aug 2019 02:29:04 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7G6Hlit004114;
        Fri, 16 Aug 2019 02:28:57 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2059.outbound.protection.outlook.com [104.47.33.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2udnnug5b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 02:28:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A094ErO5w/CBSo+FR3vhtj8gBHLT7JVGVAilHWR64gi8Rc5Ftih7WTdp7Q3wMEmXN/sAF+wtQ9Amk/ScpN4k7YpgpwJIXwNIsvJ5wgnpY5hbTKKNniltZt/P/vm3Yqfp77z47D3qXTOkxPDkGxy4B0iKNAP+Ge4LjsfNx/idSUxFmPhwixWsFxBf5Ap7HNwljdxNmRPzVPi4eQFWXgztSNXybQ39q6fDBE+uDUMyy+f45I68p1zU9q6BFV2fFy67Rd3xjdWcBF4OMqAkVM5fp6bWumWh6p6eDtNcNnHx8sbMPwSMqwBMvbDIFC1bSxioXeuoB4U5+lFDP6fCutksQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv3HruRej3e5No2pLkpG8H4shmY1O9Nb7U/T2ibftC0=;
 b=BEGVRZcXlJse7KWiAGnSKc6rdPoAVz4gktIGNsE1PAwzah86Sgp7rmDBLEADCeNmNqSonXyMTFV9wut99m1rYPHjLMcqsXtshzInmegjTRilJvZKK7TSfY6rccIcIr1p1wm0faiYQh1rXiKRkOyTJXno6kCmchVgiyMZmus9s7El7cw6MOOOmbGTN20sgPRps/c2ZCn0lzPko1gSiQgY8ooI7oSZUemqzaI8RlV5Khu2U8sfNlX0c5TW6Ckzr8ALJnHNNzXLmO8jyUoG9KK2fCe1BCjthcXOnuwC4feQ7o//gQ41c+ehRtfS+YP1pB8jAhRC0qKZ2jJ4PLwsxYO/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv3HruRej3e5No2pLkpG8H4shmY1O9Nb7U/T2ibftC0=;
 b=LXOoAvinRF1apAZjUl8feR/OoTY9/G8phujWXScypxZSMryOpKCrcM0ErcnDh3vMm9qZoVN/V9O9JxBerb0KXWRGEzTBDYJrKWWt8lHZMku/20Exf0YxF35bQZm3hNKv2cHU9FUS3dyXeFM1tNn0VYYBJBNFZrNDMHYiZhqvS3I=
Received: from CY4PR03CA0107.namprd03.prod.outlook.com (2603:10b6:910:4d::48)
 by DM6PR03MB4539.namprd03.prod.outlook.com (2603:10b6:5:10b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.22; Fri, 16 Aug
 2019 06:28:56 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by CY4PR03CA0107.outlook.office365.com
 (2603:10b6:910:4d::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.16 via Frontend
 Transport; Fri, 16 Aug 2019 06:28:56 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT060.mail.protection.outlook.com (10.152.74.252) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2178.16
 via Frontend Transport; Fri, 16 Aug 2019 06:28:55 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x7G6SsCu018058
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 15 Aug 2019 23:28:55 -0700
Received: from saturn.ad.analog.com (10.48.65.113) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 16 Aug 2019 02:28:54 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] iio: imu: adis16460: fix variable signedness
Date:   Fri, 16 Aug 2019 09:28:35 +0300
Message-ID: <20190816062835.25588-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(2980300002)(189003)(199004)(7636002)(86362001)(14444005)(246002)(8936002)(1076003)(6916009)(70206006)(486006)(50226002)(70586007)(54906003)(2351001)(8676002)(106002)(2906002)(48376002)(4326008)(2870700001)(47776003)(305945005)(478600001)(336012)(476003)(426003)(126002)(51416003)(7696005)(316002)(6666004)(356004)(2616005)(26005)(186003)(50466002)(36756003)(44832011)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4539;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35951da1-fbc1-48d4-25d5-08d7221303b9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM6PR03MB4539;
X-MS-TrafficTypeDiagnostic: DM6PR03MB4539:
X-Microsoft-Antispam-PRVS: <DM6PR03MB4539D6D7D9BBDF9EB71DE527F9AF0@DM6PR03MB4539.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0131D22242
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: cdMlLKbyDoqbOyI5y9rwtuoFx7Fem+U9Np4gesJGhaRAuCd+P7k/xEAC6/9RW8he9N2E3WL7Hd4KEHnitjgoNS/84XAGDe1ptRTPzNAWA2XscjLWojgeg524H46iC0Gk3PDohnYqT+5hMPMgvXK+s3UrioerrqyESgGhtfzhWo6/wkxcEkAOuJvAfPyCbKjdicIV4rbOdlqKgs1zbO+k9JcYWNE4eLo0OkJ4Evx3ODEIZXtjZtGXNEbd4SXIuBBI18TsARDKoPkJOUnPjV9iYOqTwdqJf0WKnI3oGlYU55urtQKjLF4hsH8Aj2mqR7VMZQ+TtA3RXdl8KQU5QgEJ+/bjO2JEC5/PKpgiQYu9ALBAd8kTlunLQqtsmPtc4P4PMwMZKT/z3d0N3SWKVweNkl7D2otEV2RYSIos5S+8KL8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2019 06:28:55.5861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35951da1-fbc1-48d4-25d5-08d7221303b9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4539
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160067
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Caught via static-analysis checker:
```
drivers/iio/imu/adis16460.c
   152  static int adis16460_set_freq(struct iio_dev *indio_dev, int val, int val2)
   153  {
   154          struct adis16460 *st = iio_priv(indio_dev);
   155          unsigned int t;
                ^^^^^^^^^^^^^^

   156
   157          t =  val * 1000 + val2 / 1000;
   158          if (t <= 0)
                    ^^^^^^
Unsigned is not less than zero.
```

The types of `val` && `val2` are obtained from the IIO `write_raw` hook, so
userspace can provide negative values, which can cause weird behavior after
conversion to unsigned.

This patch changes the sign of variable `t` so that -EINVAL will be
returned for negative values as well.

Fixes: db6ed4d23dd1 ("iio: imu: Add support for the ADIS16460 IMU")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16460.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index 1ef11640ee20..6aed9e84abbf 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -152,7 +152,7 @@ static int adis16460_debugfs_init(struct iio_dev *indio_dev)
 static int adis16460_set_freq(struct iio_dev *indio_dev, int val, int val2)
 {
 	struct adis16460 *st = iio_priv(indio_dev);
-	unsigned int t;
+	int t;
 
 	t =  val * 1000 + val2 / 1000;
 	if (t <= 0)
-- 
2.20.1

