Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A612C142763
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 10:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgATJhO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 04:37:14 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:21236 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbgATJhO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 04:37:14 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K9Tq6V007127;
        Mon, 20 Jan 2020 01:37:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=rh+zaW5OdyfhzfHfWg/qF2BHGMCgbuAeMW82swuobGI=;
 b=cXQdVDZQuvUaPBpqNpNJZzhs6qEJV8mIk7T6hpCf49zhFEDTBaqK4+qJk6PWUa8LbOG/
 gLTvigwDr/R/mZAVlHBXncQ2Oc1W+sPgDj6ph0ytSWxztntYfH1BtTHoG9Zy2Mnx4jnI
 0Fv0kXVZfYL/ii/1e6QITr4cuiLx0MwkDshVhUI+17tJWvF7ibCHorCIHkiuQG8Y4tXa
 bLcy516N49xOPDDXQJ0dzMNfAfP/8Hhy7b0agC/tugboqbrFDiiShXgudjUrJwRaNsj+
 tF1fPuelQKFb02puplTS93YtEmzHWcUdjrVFKSH1vcWz2XLc7RaXfCQpHH0mt2SBl5Ct yw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-00328301.pphosted.com with ESMTP id 2xm1gqrmtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 01:37:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFYPzYBKHv9NNVIAYG3u3WvDpeSOF82acVVAwulf6FdragvJg2TGOtlSgETDOAAhv/MjwgOHuq1fLwDzRXzSIu92eDNOhGIiV8CjEwbpniGQuqVCE9qy9JRQwvuaiGnP9hkM2qhgfp7xyJotvxKmo4wLV5TQXmembJpEfVZupMtUb2CsOL+cWzYJdPOzkxeevplfz+Y0mVw4LzDr2fvTqlA66rPZZUCP11EslbBkUTnUt3TesEt2RgSAaCjayaqX6+aHinoC7wmGcwztFABkxzjBbO3EsQsCTGfU8tomYkAaLpYImXWG4Awl5Hl4yP0V/1ZB+XBBtWQfPDp3Qua+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh+zaW5OdyfhzfHfWg/qF2BHGMCgbuAeMW82swuobGI=;
 b=kjm5DiZsLWqDwoPMJD4G1d5T4G85QHySV40wWRtS4yniovA0SuPAWMhFuBdzibV7/uL/nA41br8pVZMMrZyOqkUUt6U5+xXkPcvJjNkAhRxXe6vyAAir9lkkGpsXdBNwWFZ360m8JSt787mEnxVjKJsy+bldnLobtMHv2XfnPuttW9gBSY8/z3ucvA8V/1mJBN74u0tjiuJq/UkrG7X27tkcZQbu9Ks4V4LpMziG19ttHZ416QN9t5oBrNcoG/3i7tGfP+uY61ZIxZQtFV9NIQAbszJRKc/3b5ASTGFI7QDCZQ6n/yQuSWgEM3vsaSedfK0aLWnoUUNqZxGW4+5I9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh+zaW5OdyfhzfHfWg/qF2BHGMCgbuAeMW82swuobGI=;
 b=A0YQk2hnR8cHkVlwm3lx1ayqW+uvfiFSLCcqX6ILUKVG9go3vPtzmsbxaFEom0B5iBSdxcHDp2ECY5JctQbg85kIEGFVGFGO4tIFDKKw6Q8d7sMkhk3ThNJ3x3AbGIVjGVyGMl59Bk4ytza1CJFAI8+898RZXapuAsA7CkH+xwA=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB4048.namprd12.prod.outlook.com (52.135.49.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Mon, 20 Jan 2020 09:37:09 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa%6]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 09:37:09 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 9/9] iio: imu: inv_mpu6050: fix LPF bandwidth setting
Date:   Mon, 20 Jan 2020 10:36:20 +0100
Message-Id: <20200120093620.9681-10-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120093620.9681-1-jmaneyrol@invensense.com>
References: <20200120093620.9681-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 09:37:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9645199c-f30f-4133-6994-08d79d8c51a6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB404862D448217684FD57DE85C4320@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39840400004)(376002)(136003)(366004)(189003)(199004)(66946007)(66476007)(66556008)(7696005)(52116002)(86362001)(36756003)(107886003)(5660300002)(6666004)(2906002)(8676002)(81166006)(186003)(81156014)(54906003)(1076003)(8936002)(478600001)(4326008)(16526019)(316002)(956004)(2616005)(26005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4048;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P17dr1aUavZcG3iaRTeH9Ew4beG27F1Va8pvp0KTwJKpKudSajfal43Pacn+ca9+Jpo3nMFJ/ZgJyfYM6PH6lKxumt/U5XdgxXEFRyro6aPHqIUQG6LIfSGZyAy58q0OF17UReTsKxOspkBl64aMQa3m1Cv5tWUbxh9TU4KM1OPvOAGtAUyh3DKuzE/j06Qeudjh26W5FooCX24EbczoSvQvBZt1Me2RWA19sN3MASrc/34JCQZhvoEujA3hDiVTH9iWN94SFKO4kduEOb01JIjXiJRtIoHaMJfaXqaLuFxjj/XbQff3o95tlrrassh4Q8qCJDbpQ8maQH8ZCaCIBt9mbQvAaW+PJY9kRvR6PjAJF1wcsTH/m1a6qvjbEW7eBlhThZPKiNLtKBUi12TyMwYSih5JcPKaepjL22BTNKud77cYYbniLWpIi9KDMAG1
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9645199c-f30f-4133-6994-08d79d8c51a6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 09:37:08.9835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DILJM+ag6JV905LRKR7vAY8W7xp7Mb8rUgvi49hyICny211zlF/GqHpZhlXU9pCBObWNzrdBtV9WTIfFHKinhlGaqeO7QkjqV8iRzadq4c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_01:2020-01-16,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As every chip has some little variant in LPF bandwidth values,
use common values that are working for all chips.
Simplify the LPF setting function.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 30 ++++++++++++----------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 10 ++++----
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 9ecc667debbe..c4db9086775c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -707,30 +707,32 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 /**
  *  inv_mpu6050_set_lpf() - set low pass filer based on fifo rate.
  *
- *                  Based on the Nyquist principle, the sampling rate must
- *                  exceed twice of the bandwidth of the signal, or there
- *                  would be alising. This function basically search for the
- *                  correct low pass parameters based on the fifo rate, e.g,
- *                  sampling frequency.
+ *                  Based on the Nyquist principle, the bandwidth of the low
+ *                  pass filter must not exceed the signal sampling rate divided
+ *                  by 2, or there would be aliasing.
+ *                  This function basically search for the correct low pass
+ *                  parameters based on the fifo rate, e.g, sampling frequency.
  *
  *  lpf is set automatically when setting sampling rate to avoid any aliases.
  */
 static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
 {
-	static const int hz[] = {188, 98, 42, 20, 10, 5};
+	static const int hz[] = {400, 200, 90, 40, 20, 10};
 	static const int d[] = {
-		INV_MPU6050_FILTER_188HZ, INV_MPU6050_FILTER_98HZ,
-		INV_MPU6050_FILTER_42HZ, INV_MPU6050_FILTER_20HZ,
+		INV_MPU6050_FILTER_200HZ, INV_MPU6050_FILTER_100HZ,
+		INV_MPU6050_FILTER_45HZ, INV_MPU6050_FILTER_20HZ,
 		INV_MPU6050_FILTER_10HZ, INV_MPU6050_FILTER_5HZ
 	};
-	int i, h, result;
+	int i, result;
 	u8 data;
 
-	h = (rate >> 1);
-	i = 0;
-	while ((h < hz[i]) && (i < ARRAY_SIZE(d) - 1))
-		i++;
-	data = d[i];
+	data = INV_MPU6050_FILTER_5HZ;
+	for (i = 0; i < ARRAY_SIZE(hz); ++i) {
+		if (rate >= hz[i]) {
+			data = d[i];
+			break;
+		}
+	}
 	result = inv_mpu6050_set_lpf_regs(st, data);
 	if (result)
 		return result;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 7ae614052210..9a81098a8b4d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -370,14 +370,14 @@ enum inv_mpu6050_scan {
 };
 
 enum inv_mpu6050_filter_e {
-	INV_MPU6050_FILTER_256HZ_NOLPF2 = 0,
-	INV_MPU6050_FILTER_188HZ,
-	INV_MPU6050_FILTER_98HZ,
-	INV_MPU6050_FILTER_42HZ,
+	INV_MPU6050_FILTER_NOLPF2 = 0,
+	INV_MPU6050_FILTER_200HZ,
+	INV_MPU6050_FILTER_100HZ,
+	INV_MPU6050_FILTER_45HZ,
 	INV_MPU6050_FILTER_20HZ,
 	INV_MPU6050_FILTER_10HZ,
 	INV_MPU6050_FILTER_5HZ,
-	INV_MPU6050_FILTER_2100HZ_NOLPF,
+	INV_MPU6050_FILTER_NOLPF,
 	NUM_MPU6050_FILTER
 };
 
-- 
2.17.1

