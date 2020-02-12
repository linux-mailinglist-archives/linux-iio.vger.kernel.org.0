Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE2B15AEEC
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 18:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgBLRlc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 12:41:32 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:62554 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727264AbgBLRlc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 12:41:32 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CHLInE004094;
        Wed, 12 Feb 2020 09:41:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=qxUlRkH1AH40ywDEC6scD2Q7UYYGY/mICPPAw/oBUiA=;
 b=zG5rh79+iayRbSJh6fqMx6NEAkby/WPoCEAv5BZ5oGA084Ehmz1kj+icw95cCi74Q8Mb
 J0zy4M2nhSmiZzk9mkpH+MW0Q148itJ6Kr4xDL39sN3o9wNlSc1mJkcgxx0MDceZVw0D
 Gn5Tdg9DJrdcnANeVJn4PgBkjYDVCVl02+xIomtDrCuMpaTkbwi6XubOv/9cE1yq8D8T
 mIrQCcYvZbqhGekR7cJ09A7UaC9a8Vb8j5hG/zppVChJvkoBWhWEhOEo/em91K3urvW7
 uRas/QzTN0drEKaudTXbYjyi91iW4fLfb3hUeF6j/WjsweSyYQHxAmehkgv3D+gqb7mk ug== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0a-00328301.pphosted.com with ESMTP id 2y3urf9rvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 09:41:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZ4qPCSqqJwPML2Evq1/ij+e8SSYwZrsXuTY6rl5oYk3nFspO0enVugWKOqd2j5iQQl5OnET9lB69BQLqmmFTRRwTbpVY2MRX4aSoXP42dnIWXChBNdqtj4a4o83UxkQf5XQnBTqmsYslU9vSGAdO0FOmdjocmQ/QLIg0sEZbAipquXsEdw5+/XIwhn/d8KFkEJ1yIjFc1nR/ZT3CWp9M+m8aGEOLw4kX+ESElkPPDWV1FfSHnjYMpbS2nZ4hlcGT857PoYwMg3Pf+hvFzS07MWrGF2lZylBtUc2aJYfjT7NW+gP2qagPS/3dvzyPnHe8IzZBqPOxdlXF0+VmcbEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxUlRkH1AH40ywDEC6scD2Q7UYYGY/mICPPAw/oBUiA=;
 b=NUzOFAxyExnJkKT2Z2jTnQ4VhBb8tx7ClDzTiulAHO3IrKe9h7eKry0ffqshwMSbENZ42EfI+S0EUGkBpE3jpKJEA0/yofnOGFYakUEbVUg++SO6YU6i3pYSwQqflmpnT1q+6XByAuJ3MPDUureWPwLogwCNOdM76QtMFL9jWmb+UOEH3ECsVfeiC9yU8GhKYm3bQdThN10GGsrJBfGInxr3bUQ3qiN0G5z3as4WwMWCGzA67ff60k48hXCGSrtUJNbhjMJvoJkBxO2xOKkYOsuaEoY3dpjMQ36o+RrAluGnD8Nf66DqDGrmiQtCWQOzd69mQc58uR4IrhtCSU6lFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxUlRkH1AH40ywDEC6scD2Q7UYYGY/mICPPAw/oBUiA=;
 b=Y1tUV122ZxxNAA4riMNuDwfG6Sndu+ppSuZPbW0QiAVa9IaYcJpPkcUrPW/tT574p+JYV8KK2ELbjUr1WOIZeI365jACUNi0BgFhn8qurZqS+mkFHJfLLU2mW8DkHmcIkW0ayV7hJdvFC3lGnfmSMbkNRDFL4NVLZR2dyBynD9g=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4070.namprd12.prod.outlook.com (20.180.16.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 17:41:29 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 17:41:28 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 07/13] iio: imu: inv_mpu6050: fix sleep time when turning regulators on
Date:   Wed, 12 Feb 2020 18:40:42 +0100
Message-Id: <20200212174048.1034-8-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212174048.1034-1-jmaneyrol@invensense.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR06CA0050.namprd06.prod.outlook.com (2603:10b6:a03:14b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Wed, 12 Feb 2020 17:41:27 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23e888dc-d093-4b2c-d8e2-08d7afe2ca2e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB40709587C8A4A9A7E004CAE7C41B0@CH2PR12MB4070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39850400004)(346002)(199004)(189003)(6666004)(1076003)(2616005)(81166006)(81156014)(186003)(16526019)(8676002)(956004)(316002)(478600001)(36756003)(86362001)(2906002)(5660300002)(6486002)(26005)(107886003)(66946007)(66476007)(66556008)(8936002)(52116002)(4326008)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4070;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEWIJCZbhXDVdniv0fAVIyKLQSzEeE0I2F4NyG/fPCEwd45QUvO10z3kOwU8Kj1UML2Z8GsvRHxl9KD9caI79ZSfhVUgAyo2Cx8EOzMhmtUG3+qep9Vl52I6cbKK9n197fi/oTvSBhBI5cI4NlKvkHvNR7Uau2Ro7xwvafCwjE56W82moXEo5mHJfl9d1+nsTrZSURpBlnoWpeSPQ+/oNoAuFS5nJLcBMC3/lFe4YF52xtinQVAUNCVrtPEdOWzh/kYbLqLm88mqWG1y3D4yrDpYNEZBMrvicdKgKwu9/AtyZ+kwtC/l/J7VY17YxTT9h6Bnc05PLUUDsP2B43wosCrJ/ePIqcRN/ypQr9P3DWQky8JL5EeMzSgcTKSqVFSMVmz+/JdEYhQBktot01SzPJ5mPpMEiFQ1FKn5sDF1r96sJrqFJw85eeL2F498ANRn
X-MS-Exchange-AntiSpam-MessageData: pvZPot7O2iExst3sUaJQU1fytldneqqPGBL+/K8l2C8ijNh+z8oJgHwgFPai7g4dwLqxNA8HSq2KSZwOnK1jMborqa3gxFDtpLH8ajun0QigsHgTouUPXelbOKVM2QeCc4Q1jVFGpKFPWDHDkjGVXA==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e888dc-d093-4b2c-d8e2-08d7afe2ca2e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 17:41:28.9425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6x0alDnidscZ2s7Vx8cDL0mnXdo/SwRJcDg4W1rbBW+s6kEEdzEZ6/nZSfEmvWOnD/iCB8r8NBQoN0rhmiGnK910+28TLqrg4E5vNpt/nfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_08:2020-02-12,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=871
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Turning vdd regulator on requires a consequent sleep for the
chip to power on correctly.
Turning vddio regulator is much faster.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 3502b996671c..63cdde20df7e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1201,7 +1201,7 @@ static int inv_mpu_core_enable_regulator_vddio(struct inv_mpu6050_state *st)
 			"Failed to enable vddio regulator: %d\n", result);
 	} else {
 		/* Give the device a little bit of time to start up. */
-		usleep_range(35000, 70000);
+		usleep_range(3000, 5000);
 	}
 
 	return result;
@@ -1321,6 +1321,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		dev_err(dev, "Failed to enable vdd regulator: %d\n", result);
 		return result;
 	}
+	msleep(INV_MPU6050_POWER_UP_TIME);
 
 	result = inv_mpu_core_enable_regulator_vddio(st);
 	if (result) {
-- 
2.17.1

