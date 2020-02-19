Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACA216473F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2020 15:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBSOlN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Feb 2020 09:41:13 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:60468 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbgBSOlN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Feb 2020 09:41:13 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JEaRO8006599;
        Wed, 19 Feb 2020 06:41:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=UoT0gkU3Vhd3X2T0qfT2Yuj0mPyPJsMzh1Tx6BIie/U=;
 b=kQysE6sfIKyNPieBjCxPn8Gp0AVK+atuYJmWnqoqd70X3fwSVS9FwsS0PmuBFWvsNvlm
 ADwetonygAk5hesuDnoHxZxu7SzMgQ8wn/Z2v3Cb4hcz2HI5n0pTxkb+5J7tOfjt6hH9
 zeSucm94WIyz+xRbWnT5HYl8nn4VAaKwQP2ufaaYmfZ982kBJGVOZzTGUwhp0pAGjD9I
 27oUbCk3uwLVyR6X3R8Xf7tEUg1Kcbq4fX1hWXP7sorzI4cS+NIZngfmz9yCTXm+7bew
 yNJBgJgVjkMKqEx+qyJIgoGJ/ybJ+tRRCCEl1Z4kzo+M+ZO6iopWStFvsYXZtObdweAC FQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0b-00328301.pphosted.com with ESMTP id 2y8uc908ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 06:41:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chhez8tO9iT9jP3HTyMpieKKpRABwhlWvKot4Z3F+Hg6CKUYxNjxxSdh7fv1boI6B4gQfG3RzC2X53BMCh5I4xvluVXepnE3ynQk3hTdSdqu4ye5nM1IYbaQNKwihrI0y4jE+jnZ6AMakYMNyfqoAK776makP/Auyf0lrRU/VqxY/SwO2Pgyqmhcf+AY9pAh+6AwsGFTAAnTUsihwPJsCpB7BzZTzTlw5drhwox5MGW71wiMuUmeQI6M1enm/6Sg2OBd1jhtr+9cgvhyUCf/VqPaMJqGKkuiJ9nrchBVYXWw8gHJNYw7Q8OBIMpqYhPpjQSXqLvODGZ7i4NPR6FFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoT0gkU3Vhd3X2T0qfT2Yuj0mPyPJsMzh1Tx6BIie/U=;
 b=XJoJG0W6J/DmeJWZ4sZjgecW8rIErOEWxcJIDPgdw1wtAaInGXXwLmMCru/rIkVCPHLyVQhsoaqsl9w3Q+GRUsf5+mpxVnXCd8zQ5FWJVUH1umrihivMx4m64+o1UiBxiFB7Iu1MGQjBei4oVdUaHfMBSt4XGr1LnMq1ltyWR+9nIUD7XMEN3l+aDHo0+hsuo5WkOaDgrsQLNdpykgWjX+MB/5ocoTqHwEM+lGNU3dLHnm3SEM8k4uGV0MSaHWIVb6rOZG/soOEwm22kj4lZkW3cK1zEcfPlCZXFyfiPdBg8YZJDxyALxZfk/xK2IoFewW74lL/aAEr9MePhGuGZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoT0gkU3Vhd3X2T0qfT2Yuj0mPyPJsMzh1Tx6BIie/U=;
 b=Au7n5QrEpQlVm4yywkwHNjs3mmC2WR2b9iV5cfU23fOXfm8PsekKz7hcrGfASvpYwSTHzoMPCxl5YWA6K2yLDIoq6qaHZMWbZPtXl5yfE2lnmzasF17jrbWFetvx7XhT+foRQJZULeMvBkKbzwZ3KLAWEQxnUKnvBQG1qsb7ReI=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4213.namprd12.prod.outlook.com (20.180.5.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 14:41:10 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 14:41:10 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 11/13] iio: imu: inv_mpu6050: dynamic sampling rate change
Date:   Wed, 19 Feb 2020 15:39:56 +0100
Message-Id: <20200219143958.3548-12-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219143958.3548-1-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 14:41:08 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d2680f0-25a6-4dcf-c0db-08d7b549c2a6
X-MS-TrafficTypeDiagnostic: CH2PR12MB4213:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB42135233B34F16A934713186C4100@CH2PR12MB4213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(39850400004)(136003)(189003)(199004)(2906002)(36756003)(16526019)(6666004)(26005)(86362001)(107886003)(2616005)(66556008)(66476007)(4326008)(5660300002)(66946007)(81166006)(186003)(478600001)(81156014)(7696005)(8936002)(1076003)(8676002)(6486002)(52116002)(316002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4213;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KnPfBDg0xX01PfuBB3ymNqzQGKvUKWIlmo9bm097mPwCyFXG57vdwduJgKcO0Chm0p2OcFNgetgMIovLNIpr+CBTXbK6Gt0oKC8E96NCvVT0S3FVSVXklejNVjgom/ksrddRKLI84JmC3FesBPX3u31z2ay2+01l/P9O6+yMzorqGp5+jHGRG1C8Vnw1LAbcWGRE/++InEPKeCIgsP1jYeYVMOfQb7Tey6poQBB/no6YoIe9DwAqKqsIJiJSrOAl1EWb5SRUNOI9Hra4JMoiXiltXbCiShjaZcQyR2/OE64ZwP4wP03nX+qb2HWz6qe9VZmLYDEkNHbIBZWPr1JjyzUKulmgpYshr3s2MX/itCzdvhdhvMI4qttR+f28E3A85O94ADqYn9/b5EnO5TEk7LqrgX4Y0fGSw6qoMmcp8xCrnhhUWVmxjVCO44RuYRq3
X-MS-Exchange-AntiSpam-MessageData: YPLkYaxmAJLlP3zdB16F9dK2zJoNi2XW6prz19U/jak29MvdNrQgydhEB97QnNL4mLvDq0ugaXkQh87prfs88s/OAT0ZEDbu9StROMNLfQjOKWpXfHovVV14SFj7usXNxGGwD6C4AJ86v+BBwUGhHg==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2680f0-25a6-4dcf-c0db-08d7b549c2a6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:41:10.2577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUKJF2IvgFXOx3vavyl3DmykaQXdKH26b+KoIOC/xwQN5FL5PxcGFFsh3BmVqSmMvrY77uOd2x+5mAha9+A0t/HHHVE2icQOr74UIYv9X7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_03:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=694 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190113
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
index aeee39696d3a..9076b6bb099c 100644
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

