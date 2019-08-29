Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F273BA1F6E
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2019 17:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfH2PmY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Aug 2019 11:42:24 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:43336 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbfH2PmY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2019 11:42:24 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7TF9rex002001;
        Thu, 29 Aug 2019 08:18:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=heClZ0ql3KJUPNRN/egwecUlQGDcyswZL0MpwgZnr2g=;
 b=hJHDJBSc1ZKURB/LxRPLzuQdhbf3SPZ+/CJDgvunRVbeeZI0bSSRLCVpc6FscX3YL2Hl
 y2FYB3W5B9yW78DtnzOpMQ0tQW8XPH0iKWQulahLT/ifMtDJvAt5s9stLY1mWvTsNbqR
 owVwZ0GM085dzHmmqu9I5BKOI6N7MIz08WEoUtLPrZFJ+mYeTZOuBrFfAvLz9X4fz9fu
 pqDIAfsI+pdl08uyM3o/OYzUyykgAyblBVY2wFGnuyP8JQYTe8roepRWcHITfu3VU0K0
 1Xjuj1avZ/EWcAcaGZSoq7EtS68tmdp5smzwKq719FBDlPV6cmmK0wXWDwlzRXbfBcm6 9g== 
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2051.outbound.protection.outlook.com [104.47.32.51])
        by mx0b-00328301.pphosted.com with ESMTP id 2ukyymt18q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 08:18:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muVp31hxSvq8ztcR7aBFbrwCMV2hK7sylMolZP1raFzS1T+P4XgbmxdgkbR3ZT+YlMiHYcJVIh0nh63EQunPvUhort0AdjaUpplG4S7h+2ULGgtRZnlhI2jisnNmBhktNLgIEPG5kIN7ON5gW/Uem+OcHNGaKsu2BTY+XjwuF/iKd16uY3ctaa77HVyGa/s3h2UKzOafjjJW60fZqYjdRUMyZ8W9vwDwjnGnge++XLB+a8LAIkRv2IhHz4qYPbKfm//AC3BBROza/n3H6uEjPuIlQ3k+mqZ23FLcsdcI5JpO/RSDTO0RvASRq4Pvxc1410brh4SIwatWYlT0ZKgwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heClZ0ql3KJUPNRN/egwecUlQGDcyswZL0MpwgZnr2g=;
 b=iodGpGl57uTp2nkCtllRJ87Y+Sclx5TIkfTR5y+9r5ID39ZXj+fMjagQ7CfTphR1FoCYZNCXAc+YvmY/sMmRtP+R/6HkPJEwI3sygk6INXF2glBjnjMjnFgW7uBV0HvQvwSoW7yBgTiJwAOo9UiF78TVS+mUSSiGYmw/aWbf2ZapER2qRISfqHyQkc4Lg0u+CF8AmWMDgBW/8v9hnXojCFVe2KUCY/oEjP+AyOvGe32XNyfmPyn3qXMlycarmrzrWjeubyYGAngsdeH1+0TS6ToVXgHu8Mtv/VOrnivuD6AhhD8epIm9i1SHWdNVbkOOmvxPsXeP93eHzaTib1wXuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heClZ0ql3KJUPNRN/egwecUlQGDcyswZL0MpwgZnr2g=;
 b=gmrN+tgCgiUEs1L+RQ6QOi1Gl8r+rMfOxiwqv5WmDseh5rSFL2vURQV4GtczyM1BAv4BIvZH9t6DkPBkYAxm9VJJ49UMjIsmlCGt+sc+C4YkRnb6/iV9Wb3UBGeGkM8T1vd8EtqqQDKfGVXRJDN1ZxNkGUaPBgGaeDuOO7J1PtI=
Received: from BYAPR12MB3366.namprd12.prod.outlook.com (20.178.55.207) by
 BYAPR12MB2950.namprd12.prod.outlook.com (20.179.91.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 15:18:35 +0000
Received: from BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861]) by BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861%7]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 15:18:35 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH 1/8] iio: imu: inv_mpu6050: disable i2c mux for 925x under
 Kconfig
Thread-Topic: [PATCH 1/8] iio: imu: inv_mpu6050: disable i2c mux for 925x
 under Kconfig
Thread-Index: AQHVXn0GAso2MZ425k2F5wy9hXdqZA==
Date:   Thu, 29 Aug 2019 15:18:35 +0000
Message-ID: <20190829151801.13014-2-jmaneyrol@invensense.com>
References: <20190829151801.13014-1-jmaneyrol@invensense.com>
In-Reply-To: <20190829151801.13014-1-jmaneyrol@invensense.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0137.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::29) To BYAPR12MB3366.namprd12.prod.outlook.com
 (2603:10b6:a03:a9::15)
x-originating-ip: [77.157.193.39]
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d784c327-c40f-4c39-732f-08d72c942901
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB2950;
x-ms-traffictypediagnostic: BYAPR12MB2950:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2950D58EC59ABB95EED7EBF7C4A20@BYAPR12MB2950.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39850400004)(376002)(346002)(366004)(189003)(199004)(54906003)(7736002)(8676002)(71190400001)(14454004)(14444005)(386003)(81156014)(71200400001)(66946007)(256004)(66446008)(66476007)(305945005)(64756008)(86362001)(66556008)(81166006)(2906002)(5640700003)(8936002)(478600001)(5660300002)(316002)(80792005)(6506007)(76176011)(1076003)(2501003)(36756003)(26005)(107886003)(3846002)(6116002)(66066001)(6512007)(6916009)(6486002)(476003)(486006)(2616005)(446003)(11346002)(6436002)(52116002)(25786009)(53936002)(2351001)(186003)(99286004)(50226002)(102836004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2950;H:BYAPR12MB3366.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WJrXOngXhLAhjI5XJVzXv6lcV+GkU27Fw1UVDez4TTI8uQOE/f2SQ9pQPWMyXAriiCoIG9GDODTodszjxIR+fPFSDs8MMtCbjfwGZdCkEpACM8feTfD6RbQ0jbF+15rVrgTv1svrOpK6Q2G54E2nwtSAm9mb1L2/YshqQoIYOvUYQLD+SShtEhyVs+YKjVCFczDiG38ugcZxRxpIPHaGxVisg5Lz9NFeSH5MvuUC79kIuGAjn6hVOvQPufUSDle9rXAJQsrXhmPdimY2kspsRA5ZcBw5SLvACy4H+6qWxNO5RaIFNzuN0cvDERSJs/a59mFKmumCZ7kPgbSk6ww2dOaaRMohnSaDdvDNOb9afCKhBB5wDu1vRCy59zUI7smkVqkZDWyYjbgcnTaST+3BuTCmCgUKcfgyO13f+3qOQNE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d784c327-c40f-4c39-732f-08d72c942901
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 15:18:35.4545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4uUSR2Ut6eKCBgCXEaduH2KvVsbubDKoL7sqz1UPrmEPAdrHyZOwoJvsw59QvHJ1bpl+rxJ11ch0+bneYcktcatJKzXEZ9TNx/0eFa42tM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2950
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-29_07:2019-08-29,2019-08-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908290164
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Disable i2c mux for supported 9xxx chips when a Kconfig option
is enabled.
Add the new Kconfig option for enabling control of 9xxx
magnetometer using the i2c master of the chip. Since it has to be
explicitly enabled, we assure retro-compatibility with existing
configuration.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/Kconfig       | 9 +++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6=
050/Kconfig
index e4c4c12236a7..a92b723c6b32 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -31,3 +31,12 @@ config INV_MPU6050_SPI
 	  over SPI.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-spi.
+
+config INV_MPU6050_MAGN
+	bool "Invensense 9-axis magnetometer support"
+	depends on INV_MPU6050_IIO
+	help
+	  For 9xxx chips add support of 9-axis in the driver using chip
+	  i2c master to drive the integrated magnetometer.
+	  Beware that this is disabling access to the i2c auxiliary bus!
+	  Support only MPU925x.
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_i2c.c
index 4b8b5a87398c..4c318304f9c6 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -121,6 +121,11 @@ static int inv_mpu_probe(struct i2c_client *client,
 	case INV_ICM20608:
 	case INV_ICM20602:
 		/* no i2c auxiliary bus on the chip */
+#ifdef CONFIG_INV_MPU6050_MAGN
+	case INV_MPU9250:
+	case INV_MPU9255:
+		/* i2c auxiliary bus used for driving magnetometer */
+#endif
 		break;
 	default:
 		/* declare i2c auxiliary bus */
--=20
2.17.1

