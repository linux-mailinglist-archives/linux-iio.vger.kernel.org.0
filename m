Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB9ED1541EE
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 11:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgBFKcV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 05:32:21 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:9444 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728484AbgBFKcU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 05:32:20 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016AHWnB021246;
        Thu, 6 Feb 2020 02:32:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=rh+zaW5OdyfhzfHfWg/qF2BHGMCgbuAeMW82swuobGI=;
 b=hpYTby8j/ShxOiF7mJ2JArokl0AGQfO0xDktHOzPX/SdrMx9/4Dd6ZP8QJZv6WxaWCyu
 IiHGK0vRygWo+h8f6Kz+Qt9KZPMd76sOE1JPY6IV2AleqUlkkxAgtZoc+kAqib5TzSsL
 504gPqKF5rDTy7uIO+xASSr6fTwfv7LoIFjc8ri/ROU4jv5wfUeNqc+duVveSiA9C8Sh
 iOhgpzQJjxKHq8Y3MADJ9eNFM1M0YY1tbhZaL5lfs0UfnV0gAuBgNcynDY+5wG4fMcH6
 4Ou9OZUrh9fGkMxk0F5WZCRSGnGIBP/V9K1EfEwCLtPrRAxlEJGw/NfiF6UILyFiXILt +w== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-00328301.pphosted.com with ESMTP id 2xyhqf0tb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 02:32:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErOMOu2H95G8Fa4j9D5t6Hdcfq1l2bZCSqFg9ZbC4xsdQepNHnkxJjwqF7CYwQXbzV3eFRKMe5ewJGALzwkrJ9FZLHEK7jmywHmjHUgFiHsM7uvUqcQJwOUp2ewg6/AXqzMHjJxjZgQfEEBqWEFmRS5S2CIiPdrzs+9c6RGNFvA7BwOiSHOoGFBBqta3x7BQD1uEC11aY4sePaxJpezdFWJx1G8v4bO0xEtKnRyTsg2YMJqHYXibVTWVBmptOmMeNd4tXgt40GjnXAph/j8lcF45K3UBcbLV1KrBvNsUYXu7R+77BYk3Qsy8WB6/fsW1Zc3iaSfdcuGUo1DE1p0Qpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh+zaW5OdyfhzfHfWg/qF2BHGMCgbuAeMW82swuobGI=;
 b=PVJM2hPYtldc/DAAkjK9OQ1pzsHL8rBzZwii4iNf+rOgZzSq0+6YlOD680sM/sLv6O3pPvgCtWhUXYqF+PZd/D6JR/LT536HEmrOeEi46wM++3QuhSp0H1kjZpN6U6cgj9gr+JbL/VjgI9EOOoqtO3XuF89daLPKe+vAWJB7Kx3V9rsZJhj2POm3Jjk95yLXf5T80qZF77EYhVBiiqTuz45EcrnpHoMB13XZORsa/1jDvk/euCaPQJsLtFWU9rYuoIukB8C5stvIOveUbleKTtgtFnDv0e6frW/57gNxlpj2nnH0/bBA/as3tLgE79yU/Fe1+lGoWMOV3nJV8DgrWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh+zaW5OdyfhzfHfWg/qF2BHGMCgbuAeMW82swuobGI=;
 b=jY7MUTC1ZWRW9jt7sMMYNv4a/iqO9xcAnuygQbqqhYBwFj9jKD4gRp7MjcuQrGtVzU6y5KB+/INvQ5QEzaqWHmZ4yY/GKfa0ExZpsc0GdeFb/L02XN7L9lX3bZUY1nmsKn56FGJOHS7KsdUmMTjXYiSC0ReOD/RAkQt62kS6Ci0=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4085.namprd12.prod.outlook.com (20.180.16.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 10:32:14 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 10:32:14 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 5/6] iio: imu: inv_mpu6050: update LPF bandwidth settings
Date:   Thu,  6 Feb 2020 11:31:04 +0100
Message-Id: <20200206103105.23666-6-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206103105.23666-1-jmaneyrol@invensense.com>
References: <20200206103105.23666-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::34) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 10:32:13 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84ea65a6-802d-41e7-d19a-08d7aaefd507
X-MS-TrafficTypeDiagnostic: CH2PR12MB4085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4085635CA66654EDA5E41A27C41D0@CH2PR12MB4085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(366004)(136003)(376002)(199004)(189003)(478600001)(2616005)(956004)(86362001)(2906002)(26005)(5660300002)(186003)(16526019)(107886003)(6666004)(6486002)(1076003)(81156014)(8676002)(81166006)(4326008)(8936002)(36756003)(54906003)(52116002)(66476007)(316002)(66946007)(66556008)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4085;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FTt9xHTsOEcv9LGwcf2mig9gqGy1Ju6seA7juk64j5rnxaDOGSq0hMI1+/EcqoVBwAMexDQ3wVbMr+v/hjrULMNToj2U9w54vV9MbvLj1YwJjSbFqy6apdW0zO0o6bkFl5PH60Qga2eyhVC8UoDUoLZWXvn4LdXLv6LMIV7LT9mcEe2BDzN9NyhMP3CsBXzEJd6r73z15/mx/MFKLP4aux9aTi8VX43uGXHBib8cKVGYUB1RHH48U4YcjaXPY6WCH0RftdkwOulRno7Rqeg2IDnkW9E4fLGtYENYZCslUaRiqZLbuOWp2NgoN1wk+MzujJXtb0HsxPW6zCSCbmsRrsR5lvDGPkMDx67EURi5dCmgUFxtugLQscJc+E6fxzHlsNG249wK9CbBjeHn/tHDWgvtU5DUQe4HzbkIkEa8U1o4wOC5rPWv5M6fK7dbVJN
X-MS-Exchange-AntiSpam-MessageData: xMweit0YxkV4q2LEHGhC2re0tbMmjqXS+s75ee2JTKrpuO1SOhPtn4limI7O6nE0GIVLXQ8lXqkr6fdhLNcUhb1GgHIvPealXsT+QqwusKIZZWoVSWHwruXPPG4F3xqPyNr0MvjQN/tWDJcsqm1Fcg==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ea65a6-802d-41e7-d19a-08d7aaefd507
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 10:32:14.5713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9z4+LMLNpQoUs0zJnT4pQN0mhrdqN0TlqlAdkPKxfsvDpD2yhy2BlssAB17IY4lBpbjhVF7lVQw3fV6IbWuKopvSiW6jO7rcdtg0oyTOYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_01:2020-02-06,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060080
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

