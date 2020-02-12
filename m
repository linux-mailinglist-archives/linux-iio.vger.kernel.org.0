Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD0815AEF1
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 18:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgBLRln (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 12:41:43 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:8406 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728840AbgBLRln (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 12:41:43 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CHKwiS003947;
        Wed, 12 Feb 2020 09:41:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=YTiM4jHRLx/CnqrGTdTfYaITIwYeWyoIVmdoAeii3ms=;
 b=VyumWiWdOtPzr1jLHGM6SDeBTwsEZXF5cMUSGS81gLz18EtK/1EhPQwaBFBH78NzF99N
 0K0SuFHdILISKYNO++pXLeAM/gpz7CVe6Ina/nF7OAuIyOxdDxSsVu7SE64mlmklC0Eo
 JhvNgt2CuhbClMwPX4iMlMm2nwLT5yVYfUNt/V96ky0q8qS1se6XJxFLpCoUbMETu6/1
 hHUyhmnggHLcQDQQeB7fdTNNdE/LPihlcUbA7HqvTz189WdiUoMcYpdjbAF1yIlCPR5H
 fVtVQBD4LtbfSdcj1KmWdJi+3QMz3C/uew8skihFJyFGkTSPSCSfyazWgXF2aUqeR7Kv dQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00328301.pphosted.com with ESMTP id 2y3urf9rvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 09:41:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHT8H+JTliV+wTJBEMlnMbplF56JFk/4WCYhFZAeuiDyDu6cr4xpvUqVEnN/LbLa0Eh+NHkprxJkGZea5ny1ohwv2OFeu1517GKm50HD993w/slDWHQps7mt3l60OZgjRrZzG0M0+Ll61MpLoSTQ5I2bLyJuUkOgrdCe5BbxqcTRUKI1N700lZjqbqr88YTrkDDw+H6om/R5y83eOs8gCTjSILz1tL1t1KQUGqX/FxPM0T7QgptYjLhmLTLA93OQgb/ziDqGbl1uu0+ZEBS4tNpzQ+YWt8MYAj3bQjIlaQI9AbvnBVMc7oiBFdCVM5ZT/R1Zs/Jlt1kSzUpg9wnWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTiM4jHRLx/CnqrGTdTfYaITIwYeWyoIVmdoAeii3ms=;
 b=WWy79bkgWYPS9jPCJ3saQtdKSf8czQF2N/4AerDgw3d2RaBYHKkzHJWViklBm6iOlK0/LIo451iTsO0GZE+EiJEKVqBF7GU8UAXUoHVsgOTpDW6dv8YHkPlmAIrpaklz5FQ3xj/ZiOUE3plCkq1rt+iXfz1/uJvYHeeQWrXLz2ij6eqIiJ+RA3+qY2cveGJuHF8Bdjn1Oi7l2TCrWzWyJ4lYr42KfxX18O475FFMS+UlTKKu59rk+Ad35J6MyUkjiN/WtmthhzS+bk2AQ6N4rxlcAfTmTe6HM7Js6FwR1zcye0oz2JW/nwQWVYNcri6HoR6fxv4Icesv0FwZPYpkcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTiM4jHRLx/CnqrGTdTfYaITIwYeWyoIVmdoAeii3ms=;
 b=kv+guT8uI0ncmDvvda+BH31N7exQEJmWuQ39kfeApe/LpzPAsh3+mXJls+r76wh7yZ47sVQCoL5OHCDnmNQEzlIsV3nEpVmJPZvjL43vSWN2+aeOqWYO5eQQm/ilW/lDVzoA7oRQ+CI1ADiI20X+cezKD+6WmgvXMZhbkQHF5ZY=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB3925.namprd12.prod.outlook.com (52.132.231.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Wed, 12 Feb 2020 17:41:40 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 17:41:40 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 13/13] iio: imu: inv_mpu6050: temperature only work with accel/gyro
Date:   Wed, 12 Feb 2020 18:40:48 +0100
Message-Id: <20200212174048.1034-14-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212174048.1034-1-jmaneyrol@invensense.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR06CA0050.namprd06.prod.outlook.com (2603:10b6:a03:14b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Wed, 12 Feb 2020 17:41:38 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f09a7c61-4b68-403e-ee58-08d7afe2d0c3
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3925BCAC70AACBEA27F0F340C41B0@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(26005)(36756003)(478600001)(66946007)(4744005)(4326008)(186003)(66476007)(66556008)(107886003)(5660300002)(16526019)(52116002)(7696005)(956004)(8936002)(2906002)(86362001)(316002)(81166006)(2616005)(81156014)(8676002)(1076003)(6486002)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB3925;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tLt61lPnzOnNXxVqTG47uj4JAsopPEYVJnyvE7He2Hmjm0bUfvPDMgnXA3Rjhzwgn7SbjV44Z6ZJoZlerXxHtx2Wo6u2Vg0E/7d472sQeu3pn6mzefA+Iv0uxQqqLuPdQXz74TGF9No9huBcfYtABrZVPP1fDOVEoG7jo9J9Y/aJ+lg6TtoXX21EXkW7LUwPwRs3u5VyRi7q+b1AXrENpkwY9VTvbavRG9WVzRVrtlYYim/FaZNMGL9/jcuhwhpD90+AbYXXdHcOP6cNz08Ka/wy4LgDFQqD9CzBKYIHZ5+hfUlwFIv71rUX3gC0Wc4cY/Bj2GJtT4SAjBSq3hqOGxQ4amUG9Gh9sbL3Khq8LhI6AE61OYeNa8Do357/VBBbIhMDODbaobJukf7YGO8WLw7FTt7RGl8Rx2wDSqaUpevS0EeJy0eqM1nybG1XHv6k
X-MS-Exchange-AntiSpam-MessageData: UB3WeQOGhmQNQjniOr0bQUKDN932+tskC1WrvNBueeQ1StqrqlezfxJw4DTP81p0lMkwv1kyz8PEzjyaUF8djUVeF3nUFEt1m/f46SGOKfNpqFjIJFqzQsXzNqx7dTG/sygEvyBuDwk3CZ9I4mm/LQ==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09a7c61-4b68-403e-ee58-08d7afe2d0c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 17:41:39.9889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEPuQqq2zhufWi+i5l27ankAU8v9Iru0XtVkc4anxBnoSvN62btYarM1hye9bHSGYW28OIwFvyLTIMOdsYWxxxXVWMIkoBU4nHRQcP/1vMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_08:2020-02-12,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Temperature sensor works correctly only when accel and/or gyro
is turned on. Prevent polling value if they are not running.
Anyway it doesn't make sense to use it without sensor engines
on.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index f698d2aa61f4..3212030cc083 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -597,6 +597,11 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 					      chan->channel2, val);
 		break;
 	case IIO_TEMP:
+		/* temperature sensor work only with accel and/or gyro */
+		if (!st->chip_config.accl_en && !st->chip_config.gyro_en) {
+			result = -ENOTSUPP;
+			goto error_power_off;
+		}
 		if (!st->chip_config.temp_en) {
 			result = inv_mpu6050_switch_engine(st, true,
 					INV_MPU6050_SENSOR_TEMP);
-- 
2.17.1

