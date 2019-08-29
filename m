Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32626A1EB9
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2019 17:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfH2PSn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Aug 2019 11:18:43 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:31054 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726739AbfH2PSn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2019 11:18:43 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7TF9qrA024048;
        Thu, 29 Aug 2019 08:18:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=5mSFPzjXvF2DWpr+b2NK78N6s6olmW8sHyGEuxIcapE=;
 b=b/pDKAEx2L92HgnaoVXDjFPut36pAObsGrdKVtPK3oYH3+Ag2xjoQ/28Rg65iC436OVz
 1OoEmUKYtUxn4DL0OdGcI0nQGSRwUp2npcfnTYm3a+pZmmvh3LHDg0+Bs8tTGnskYLnP
 EBWh1gbQlixx3+v+hMC5Tbx70Y4zXi5RePp3ZR5Wak8I4tIqy5wDgmILBmLHSZ/8w6hu
 adD7V7EYvFDna7OcjEiiVedo2j4qmBTFoxnO017lYEgFgj1owDLBavEaFSg9V0BJIbgk
 +STZ20/izl3+jkyC+IGxBgq/B93XHOpRUNmzUneXMgkZFb+dGn9QkI6ONr6Tx9gbWRud Cw== 
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2055.outbound.protection.outlook.com [104.47.48.55])
        by mx0a-00328301.pphosted.com with ESMTP id 2up71c88kn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 08:18:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFbTRC4h9eQfgMXeP0+jMZsbV1e+frIOeMSc7IK7TLKBywVarHPtChLrFRb7rFhLuV6QhZKrcF/vhS05PdcNEfFc26d1h4L9CzGy9apf2Heuobq2fyiIL6nCPaTO5ujQaVVxsOOTZVG/KvDrXNvjbFjFy4T8MjdyqSYdx3p1TKXOE/b/ol/l4PNemRrhTtvdptSTWvQVMIqnJWPIM29YvdvG5qHZ+ivRK1lxtNTAGQvEcYpqg+4tCSizXYCTiU2TG8WjvmeMeb230sKcB6qyvDLMtKVxN92pPkxzk6I5Au7UMJT/8tdGlO2nykiQU2UjgJOo4LT4EK1HbqW4l47s+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mSFPzjXvF2DWpr+b2NK78N6s6olmW8sHyGEuxIcapE=;
 b=nKNN1qWguBbLlf+T/k3+fQO9CzGVrWd8m46pGDZ7heNEynrLU2jcePB9pog7ADKdK9cXB43mFMgtL3zXk6Fpme57zc9s23PLUSRlNlzXkPFBEnzlR75QiqVbDpfFcDR6xfzZO9yEn7/Jr7RJzRUnfF2wsqRJ9d7L0lfvRIJOfJRS0nd41sgF+RTwuoS6Gw+1pU3px7FVONd61DLyKg461WZJsJ9T+6QCMiD/ORA7bmthQBgkf9M5JcQRDikSfHWnIqms18hLtDzXD7vsq8WlyJd+la9cFTgz8cLe2TFsvxGDjJWn/bt4q7M8DopIU4sWFPb5cDVhy4078Ya3qBCB3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mSFPzjXvF2DWpr+b2NK78N6s6olmW8sHyGEuxIcapE=;
 b=ULcQvgPm9zjuqEyRpvz68h5Iz4RZRVMWhhqEpNg87kmC2GLB8XKRqJlMHBBFWcxRNUhb1VOZtbzd/WVVN9ltG/sv+ll6LAJw2S4KEIYpbmKw5kKiMNazN5tIfWyvcL96j5AJ9/8yGYWUXtX0SsMqc3ppi2eRha0GvhlAkdFMvFU=
Received: from BYAPR12MB3366.namprd12.prod.outlook.com (20.178.55.207) by
 BYAPR12MB3638.namprd12.prod.outlook.com (20.178.54.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Thu, 29 Aug 2019 15:18:40 +0000
Received: from BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861]) by BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861%7]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 15:18:40 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH 4/8] iio: imu: inv_mpu6050: fix objects syntax in Makefile
Thread-Topic: [PATCH 4/8] iio: imu: inv_mpu6050: fix objects syntax in
 Makefile
Thread-Index: AQHVXn0J3XHvKnFT3k628HJHYxH76A==
Date:   Thu, 29 Aug 2019 15:18:40 +0000
Message-ID: <20190829151801.13014-5-jmaneyrol@invensense.com>
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
x-ms-office365-filtering-correlation-id: 0bee700b-780c-4b15-b163-08d72c942c00
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB3638;
x-ms-traffictypediagnostic: BYAPR12MB3638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3638815F9E99F0BE71ACAAE4C4A20@BYAPR12MB3638.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39850400004)(136003)(199004)(189003)(4326008)(6486002)(256004)(14454004)(1076003)(316002)(26005)(102836004)(81166006)(66066001)(81156014)(386003)(6506007)(305945005)(86362001)(2351001)(6916009)(186003)(4744005)(2501003)(80792005)(7736002)(36756003)(50226002)(2616005)(6512007)(8676002)(478600001)(71190400001)(71200400001)(64756008)(54906003)(66946007)(2906002)(66446008)(6116002)(52116002)(76176011)(66476007)(99286004)(66556008)(8936002)(446003)(486006)(107886003)(5640700003)(53936002)(11346002)(476003)(6436002)(5660300002)(3846002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3638;H:BYAPR12MB3366.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KWXwiJwVSOF452oOcgpk+s1jdxK1j9cVPnWr8XjeYSsrUeE+AdyciD5RIoJgnu7INuFJD7GeL8KuBVtS84BqXRTKxa1XVO8nkKLfZwa/9Cs5qAtQeLmFibeWI4a93rEwuBY0derChwx7udqPz8xh9pJe/sGet/e2vMGTf2Y3sYC7iKsQLadBcFwrUxArt4k2cbfoGPkgzFoOzaduJWw8GuR9jzrcgbGrMzi3E6cR/46gGd0DKqcbkN0G+GSDpuJwjflyxzo8xHaKPzGv5aPfa7dUEYEEP1khElcJsIATHPyBRbCWn/h8NoksVboiJWGF5zuOrjdji9lOdFOU9HpbkBmSBNZ0VlUcjovJkhtCRoOon2vHO22X7OXt3x4btSn0qf4e60yT7htUrKEdS3TLcnORr27z9YpDy4h8j6Bahss=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bee700b-780c-4b15-b163-08d72c942c00
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 15:18:40.5786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Ib+XCE6Jk7V/ajVcICRhesgPmwERx4RRPEidLR3uUJE2txDq74HSp/YEcsNEf8s8NeDe2ecU/fh6Q1f3JelLvqkOorn1KB80idDmfK7G5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3638
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-29_07:2019-08-29,2019-08-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 phishscore=0 mlxlogscore=889 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908290164
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the correct syntax *-y for declaring object files.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu=
6050/Makefile
index 70ffe0d13d8c..33bec09fee9b 100644
--- a/drivers/iio/imu/inv_mpu6050/Makefile
+++ b/drivers/iio/imu/inv_mpu6050/Makefile
@@ -4,10 +4,10 @@
 #
=20
 obj-$(CONFIG_INV_MPU6050_IIO) +=3D inv-mpu6050.o
-inv-mpu6050-objs :=3D inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
+inv-mpu6050-y :=3D inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
=20
 obj-$(CONFIG_INV_MPU6050_I2C) +=3D inv-mpu6050-i2c.o
-inv-mpu6050-i2c-objs :=3D inv_mpu_i2c.o inv_mpu_acpi.o
+inv-mpu6050-i2c-y :=3D inv_mpu_i2c.o inv_mpu_acpi.o
=20
 obj-$(CONFIG_INV_MPU6050_SPI) +=3D inv-mpu6050-spi.o
-inv-mpu6050-spi-objs :=3D inv_mpu_spi.o
+inv-mpu6050-spi-y :=3D inv_mpu_spi.o
--=20
2.17.1

