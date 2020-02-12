Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33F6115AEEF
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 18:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgBLRlj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 12:41:39 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:4562 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728833AbgBLRlj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 12:41:39 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CHKwiR003947;
        Wed, 12 Feb 2020 09:41:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=XTBkibxc+8MrtbZq0N+bqgerviNB4eZqrx9ZtkSlKgs=;
 b=pFIanqyomTXgivWD4FSm1jLgHjLnIPQjAelAGldIL5FjU/L8wXWNpJcfuOU4ntEa+Pdj
 ZC3r9W1D8TJjkCTuEZ9Zxy1Fc4U8GXJecU4VE4YE/HJTuUUxDOUtJgke5GqxMH5rt206
 Bdzw4o8siaJMLgzPSOM2L9+uSBb9Sw8kLYMO/W+5P/pscmXuKRDmQ5fxVodKQaSxOera
 F7P+wB2BE/exvIRkVebOA+3lJIX35haTrDCjNKkfMiYD2cmOwWUFUEs4KIJk2iSoDhXP
 e2rR1WhEkidIAhOHEtQxBRfw+161qZVS0ePjL8tPc/JOAPgfMZCCd248qkOzqXhUiT59 aw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00328301.pphosted.com with ESMTP id 2y3urf9rvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 09:41:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+Co+5Pfy6N6Flbtutc45IjuRmfsX+/mlaZw+DY0GNuY2xuGTsn5SJr1uOY5TxVtTG8aRCpStxUKwdSOCuq123BbDokgrJBFqMUmiAZjJJX4/gR84PP6R6EW/PzSyvjHeVVFf0JkRyc47Xb5y7W1KgW5Kf2IQnA2xtHdiCFTTTgyHwDfqsU3AOfgNSJwen/29WHHwAH+qZf5QVwiKRSiveqh9v2IRd8ThVjEpN2JYJznT8O8ORcjMeMNvApKBPUOjhJRRBSwKww2aONZL/IJKCh7sKPufH8ywY9Pr3zrD6WhBZgxqbbl5jStxW5TRgqgf+ygPRH/0+KfvjHgGkjIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTBkibxc+8MrtbZq0N+bqgerviNB4eZqrx9ZtkSlKgs=;
 b=EII3r+JK/mJWeaoQDmuPk3t1twjhYLHeDL8dcnw/9lwBRFAlKCDMSVf87682qGi5FQGchiE3ENVtC/qB6WYG3bHDLk8fOzfu5dcBlxS6hQqhzN+tPxMtH7y2GCgHn1SgZFNYpckNATK5K44ppRFpqJ0QTm1vyrApnkI3k+MOFifBR0ndu1h/LPd6xjznzcQJCPFgiDbuiWEQH6oT2FagD/qx8gQiyx/MJyDIJW9SxiNQgPChw/qnPu3wqwZgHCl6EBDKRq3D/1AGrULP1pdJqvVm79dH86rfSYqqItswAXKinbZ62oaUUidqz5274wDquxnL0n8D0/FGO6x6QPVp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTBkibxc+8MrtbZq0N+bqgerviNB4eZqrx9ZtkSlKgs=;
 b=AD21CdY06C8gRJuLvUCvnI7MYLkedXUnTNjLQxamXF1kHz3/iOteWqvW2KaF60GTNuXkIpUOV6ZXEp1jDg/eO+NEUGD9TN6ylwFDET0pUYVZ1qTSqyTYDdHyrg8MZvFb+rUIN1xbulltvkr633dHoBSOKxwU0VXzh2KfXDE1JiA=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4070.namprd12.prod.outlook.com (20.180.16.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 17:41:36 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 17:41:36 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 11/13] iio: imu: inv_mpu6050: dynamic sampling rate change
Date:   Wed, 12 Feb 2020 18:40:46 +0100
Message-Id: <20200212174048.1034-12-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212174048.1034-1-jmaneyrol@invensense.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR06CA0050.namprd06.prod.outlook.com (2603:10b6:a03:14b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Wed, 12 Feb 2020 17:41:34 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42bead69-6cc5-495a-467c-08d7afe2ce99
X-MS-TrafficTypeDiagnostic: CH2PR12MB4070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4070FA3617AD4ECACE78EFA8C41B0@CH2PR12MB4070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39850400004)(346002)(199004)(189003)(6666004)(1076003)(2616005)(81166006)(81156014)(186003)(16526019)(8676002)(956004)(316002)(478600001)(36756003)(86362001)(2906002)(5660300002)(6486002)(26005)(107886003)(66946007)(66476007)(66556008)(8936002)(52116002)(4326008)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4070;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iY22ME6S8xoojkVDSGIrqgRpAPDs04OuWGWYZBKDOV5XMph+WFgUNWWS3HGoks7kPcqb+NGuNI4LOSAzaMegodeEOSTsb8Hr0taSmtlGLnyph7yJGrtKtsnKGHtnXk2LnHxyY3akSaz3rGGVm5hxFU5kEL052ZEBJeUNIfStmzVUi/35puThZ2XQlkfjlkhJV0XpbFCg9gvG6gbvFve/OTumQqqomIXInd8VUKpDn7hg4s/wQhgMiD8ukVHfdL19yapilsV2oz4XOcWeUa7jQfBx+EPHeSrDkwuhgrl83FDRFcyu4dhCxM8BqFIwfQZArEKKEI89QF3T0O4libPROoc2yI7CneFrhwuCXIO+epuzq5ej0is3fys6aZfssRWeOsKtwIjIORENG2O2N0hnXaP24XKI2QBZ6o3otx6x1VVjUMSm6z33fMoyKlqfhUo
X-MS-Exchange-AntiSpam-MessageData: AKjTOK9A7f77ythHmuSixdTWfZhwckCSnkKvb74ffhYVFlBEy1+15jkFZhzrzWiKnV0AyTfhkRUYCkaoj4PgkJu3+4o8VHuNDkxzB1vWXwrKSokxuhOuobfNIU2+G4Q0Dp6w5j+64ewsLjrRUWiQew==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bead69-6cc5-495a-467c-08d7afe2ce99
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 17:41:36.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVbTedtUqPvsEGJefp05nySXio8ObZhEP7mgunie9Zt5Ru8g77sbz3YHLNSWajaIUGXFuPlu02bxehoDtyHKIk8TH0KpY8ZxixAZ63YPKgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_08:2020-02-12,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=676
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sampling rate can be changed while the chip is running. It can
be useful thus do not prevent it.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 28f8079d4599..f33fd04671cc 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -910,10 +910,6 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 	    fifo_rate > INV_MPU6050_MAX_FIFO_RATE)
 		return -EINVAL;
 
-	result = iio_device_claim_direct_mode(indio_dev);
-	if (result)
-		return result;
-
 	/* compute the chip sample rate divider */
 	d = INV_MPU6050_FIFO_RATE_TO_DIVIDER(fifo_rate);
 	/* compute back the fifo rate to handle truncation cases */
@@ -946,7 +942,6 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 	result |= inv_mpu6050_set_power_itg(st, false);
 fifo_rate_fail_unlock:
 	mutex_unlock(&st->lock);
-	iio_device_release_direct_mode(indio_dev);
 	if (result)
 		return result;
 
-- 
2.17.1

