Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D44C71997AC
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 15:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbgCaNjU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 09:39:20 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:11306 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730786AbgCaNjU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 09:39:20 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VDXsN0027748;
        Tue, 31 Mar 2020 06:39:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=pfpt1;
 bh=Ndo+3OLN4htnVFVbwWSyNOqv9HsYOke8yNNcwbjoThE=;
 b=ZX5GQvk2azCvfoWofbmJl+BCX2FFwcbnYI3N5XaGW2i9WgL2I2FA2Lk4nzu0kJkPOir6
 w0HlA+tQ07S0l9kWtTUxMDZnB5KacwwNN5sgm8zkR/zLT3p2BXXiRRvIotCuH937kk64
 +RY01B6b5quh0RF2YFhmLYfDCDa5O/CuW/8R0SbyKMHYnNpleQD5MmQldY9aWeWG/jnM
 VewHXToTyqYuIWDg0GkVYRT+6+hgBArzDZHkCmIdN22T96kOWsB/CB2Bow2yDdoolVQ+
 tP6SPB2waKJEFH0pHIDIVev/lKsCQ2Q6XPtLflCxaArKpdZjRzCeuvNonjkKOLJGCktj wA== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2051.outbound.protection.outlook.com [104.47.44.51])
        by mx0b-00328301.pphosted.com with ESMTP id 303rc20aea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 06:39:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKEQiFVO5kfv2U7GKOFzK8T1iHdpH4+TliJRXrW073k6WOS1FRIKhvNLDXGTdeFWHMsJPKThnA+E9aEsaUO6QV88AHtVp2sBXdeAky7kP5VkPpe72+LzgmI0oh8pK22Amffh6q3+Wjyv1z9F7jH6SLgloxpQK20/gVQiQ8FdfK7bdfA8L9HQM4SUoQ9GfnHHGpPrcpRhxXBd/DX9hgZD6Cqu7DWFlAom1yWCimTtTS1VNk137U+7q1SowxTaMCqWR2r3CK+IRzKCaDW0w7eIU8JBfgtz1Rpa2IKMtzymOe8B5hGEoisUNftoTi5W3sZvFkwkVpYlbzvkYC1mtGDYfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ndo+3OLN4htnVFVbwWSyNOqv9HsYOke8yNNcwbjoThE=;
 b=n6b646pwuWQ/12ZFW/qOUKdAhi0p67ecdfEDZd2vDuNP7SEvrAQQsN4pvzZavHe4V/U5IQdlsEjZMHL9UD83wOzW5v7U6M4P7Et//TxbPp9nE/O2Drdkp7HcU+b7lgBVmXURSUqxaix8TOQZBnzUZVRVLw0FL550bZEFjp/DxlC6HOgMrBVD5oj3FdZ9FlATNAb3De5ual4LjZLwcMUBVGXZgsTw5Jj4d0GK4Yiv/bIgQ9kjLuScgyaZ1483fYEtFscas6AePQfO9qXvbQY+w/yv/V9oMBLdZFjBEVtROAPLxK/9KjieJms3y4AlC2Amn706FlEMFX7ZVMHbWny4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ndo+3OLN4htnVFVbwWSyNOqv9HsYOke8yNNcwbjoThE=;
 b=V2jFTG48KESpyWSoYQQlWjBZzsSZEOEYqlI+zm56SxQeMaFl2lEt2L4qLnZEg5zFbcIfTz8Ee0O6UwuBlu/fb52BrMqrUBDv95gPONyqX8f4qrxWJzy2Igg1i+pRjJhfJbIvDfSNdhMnnEFsiy0sAWc56WnEZDCNEO0qI7G/Juo=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3568.namprd12.prod.outlook.com (2603:10b6:208:c3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Tue, 31 Mar
 2020 13:39:14 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 13:39:14 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH] iio: imu: inv_mpu6050: fix suspend/resume with runtime power
Date:   Tue, 31 Mar 2020 15:38:50 +0200
Message-Id: <20200331133850.23757-1-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0294.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::18) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0294.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a5::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Tue, 31 Mar 2020 13:39:12 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6a73c99-cd30-40cd-e01e-08d7d578e697
X-MS-TrafficTypeDiagnostic: MN2PR12MB3568:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB356871BC0996D08C53C92E9EC4C80@MN2PR12MB3568.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0359162B6D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(39850400004)(366004)(376002)(346002)(396003)(136003)(66476007)(66556008)(1076003)(6486002)(8936002)(7696005)(186003)(8676002)(16526019)(36756003)(6666004)(52116002)(107886003)(15650500001)(956004)(316002)(26005)(81156014)(5660300002)(86362001)(66946007)(4326008)(81166006)(2906002)(2616005)(478600001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QU1/ig95D21AM3E693T3r2iYqNglq1ihxz/mmVpJO5OuibRcSS+7FS7pltFFq2SsFZrZ3thMTUjgJ5e/5d+FHeyBMg9Svx96pm+BPMheXKc13puC6KWwVpQhfvAkhZiXwAAE5GAHIc3GJ4hZZUPPfPITLFsIIAx09osAPADzKhBa5IRa4vxn6LvUzydfEt2enRT6eo9rCyY3+wVaxYNCnKtu4ZVrTLd/8+DBq5zXgZnnhDLPy9RlQoezzQ3ao7AdSu1ATd9V+VRslFoWJQ2ND4zXB85bd88zSM6Cz/y/PCbjXgboEhsU0qPgiY/stGoHQSfZpie8f0lao7Op82gKPjmoz/5wRy8rT/u29IVaKYSrfdd5gO7zcnvOJEyNAjfF2dHdAL9kGcd7g3qelyGxi3TJ46dRIFCLcdwdVZE/km/163AjRkScjJE7mjpHE0UQ
X-MS-Exchange-AntiSpam-MessageData: eorTIEGZqpikXP0v7io2P49T6IikYir55D4M88HJ7t6KJxboSeGRIFcUJBSvdegkmHfPVYknWm1kncNSlEzFDrLVqcJAdJhzcKahp0sWxFuiyHJa3UIwH8rbFDtdq+IUn7t/MUFjQoTOsXt4nT3P4A==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a73c99-cd30-40cd-e01e-08d7d578e697
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 13:39:14.0387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +m2wfUsl8LiAhSnLBZKOQQjbDk8NL98KqoPaZINZenh51t8wI2E26Vo9hvVuXtOBESH5W3s/F5hSQHqeMElZ6WN7DLT8FomBHjh9QqjKltM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3568
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_04:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 clxscore=1015 mlxscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=826
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310124
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Suspend/resume were not working correctly with pm runtime.
Now suspend check if the chip is already suspended, and
resume put runtime pm in the correct state.

Fixes: 4599cac84614 ("iio: imu: inv_mpu6050: use runtime pm with autosuspend")
Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index e4b0d368c2f9..a58bab03f0b0 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1636,6 +1636,10 @@ static int __maybe_unused inv_mpu_resume(struct device *dev)
 	if (result)
 		goto out_unlock;
 
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	result = inv_mpu6050_switch_engine(st, true, st->suspended_sensors);
 	if (result)
 		goto out_unlock;
@@ -1657,13 +1661,18 @@ static int __maybe_unused inv_mpu_suspend(struct device *dev)
 
 	mutex_lock(&st->lock);
 
+	st->suspended_sensors = 0;
+	if (pm_runtime_suspended(dev)) {
+		result = 0;
+		goto out_unlock;
+	}
+
 	if (iio_buffer_enabled(indio_dev)) {
 		result = inv_mpu6050_prepare_fifo(st, false);
 		if (result)
 			goto out_unlock;
 	}
 
-	st->suspended_sensors = 0;
 	if (st->chip_config.accl_en)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_ACCL;
 	if (st->chip_config.gyro_en)
-- 
2.17.1

