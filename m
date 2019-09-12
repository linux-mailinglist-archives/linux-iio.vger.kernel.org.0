Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A653B0D51
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 12:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbfILK5r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 06:57:47 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:50580 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730680AbfILK5r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Sep 2019 06:57:47 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8CAtDER012938;
        Thu, 12 Sep 2019 03:57:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt1; bh=rmaqs4z6toK/ah5BropfB/LJ32rvd5prlTbJtKSW7EA=;
 b=m7lsrywI9xEJP4hhTHtyIYqCBk3m6jb/WcaicDd9wo602GpdCyyP1L2AtuZPJ6cSah6c
 SGdvjgsd7sKwI+uQFzpvRDZWS/YqzJFgAMtWYNweX1npEky/ZTHwq0XgtG8GYxgCssD/
 RO9QpYPWk96ear9KyAMkDAprFepE/1QT+wA6c3mwBaRPzkdl3Q3/weYjLX35QNoewYvw
 anw4b2BKO/lSuCyfwC6u4JotBAYP4MBlCzHWdDFh5SsaxaTES7WSlCZX6c4TPsvoMk4M
 ODg3kIUQqRxgT25b8phJcaBapWvaBBX2BnMcjuuSSf2UYyZ/3BgwFo0HMJYNGrx1UQR8 3w== 
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2057.outbound.protection.outlook.com [104.47.49.57])
        by mx0b-00328301.pphosted.com with ESMTP id 2uv8gn2s97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Sep 2019 03:57:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWCMLEeSSRsF+UcLOpRj8htHgXBJgdv9KqI28WAcUhDPBOp/g8nsdHxveMR1Ut70Npj3Hvm+Nx5Zp7UuDyG2fHi1sc+/gGhU/sApBdtipTAiIjkj9NAOiwonfSNk4ltaI7r95epjCYR9OgjbXkP+W40weFrbVtsQJjR5tycZMMFLZHe0U1Cernzrba7Xdhj6amTjmJRvGVLJSaRnYEM7aCaF6cHKoi3I+EjmSoKOHMKRWlWBPgOYAcif2F2qhAqCac2/GVnHcsgeewroHext8UqSeMl2zb3gZm4qbaC/3tigyaTL34DJiwq0hck758/kC03JAhaqbwfEMaXzszCptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmaqs4z6toK/ah5BropfB/LJ32rvd5prlTbJtKSW7EA=;
 b=XTz2HXg/GECJMbJX997e9QJ1LSLlT2ecGQ1DAHQRRwR+F54gNxNzkI+vRk5RKqzwikYAWzkMGyOXvguQaPZmfbQsyI5wQYvFTqXGMo2xM/lhM6TaNcGn67zvioOblTCt/Qt6KtTidB3Zoz+r+T6cF56ESVitDDriXNKNZESe6ZG6zNWB9hgq0uh2FfoHnTUNhLQUqG9kjRmA05az49AcuH4wh+iV+EOPOhr8BzzkJa0Df2hdHXidLQ0ccWhYwtWFZNHbzhVp/rmL4m3WjgnrGwllq3SwOp+pjBXoCEd85/ugKXzp6mKzc740V2z2NAob/eohaNjOJ7f7Lzq+GDG3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmaqs4z6toK/ah5BropfB/LJ32rvd5prlTbJtKSW7EA=;
 b=BB9KLBRqZkNvLyGYPoQvFCOwhGIRTZAJy8qmBUsz73K4Aat9NL3aU7C9hvrMs5HT3+TLvOyDQDqoPyUQklSkDU2Ojdsn3n2O7AJRXG3sQixJX3BObmZhqCD4HU7ZdzLzvAAB0ppXN5XAQoYoM9mlmhxpR70Z5YHkI4lfhgifaqY=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB2911.namprd12.prod.outlook.com (20.179.80.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Thu, 12 Sep 2019 10:57:41 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166%5]) with mapi id 15.20.2241.018; Thu, 12 Sep 2019
 10:57:41 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH v2 0/7] add magnetometer support for MPU925x
Thread-Topic: [PATCH v2 0/7] add magnetometer support for MPU925x
Thread-Index: AQHVaVjluB79plSxzUS3iJNvjJwqEw==
Date:   Thu, 12 Sep 2019 10:57:41 +0000
Message-ID: <20190912105717.15564-1-jmaneyrol@invensense.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::16) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
x-originating-ip: [77.157.193.39]
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 946f84db-d6ee-49ac-0ddb-08d73770084b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB2911;
x-ms-traffictypediagnostic: MN2PR12MB2911:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB29117F7C3F1FF78E17ACB260C4B00@MN2PR12MB2911.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(366004)(396003)(376002)(136003)(346002)(199004)(189003)(86362001)(6116002)(3846002)(99286004)(54906003)(2351001)(1076003)(81166006)(81156014)(8676002)(71190400001)(71200400001)(14454004)(476003)(36756003)(25786009)(80792005)(52116002)(2616005)(14444005)(256004)(486006)(6436002)(478600001)(386003)(53936002)(305945005)(66066001)(6512007)(8936002)(6486002)(26005)(5640700003)(6916009)(102836004)(6506007)(2906002)(107886003)(50226002)(316002)(2501003)(5660300002)(66946007)(4326008)(66446008)(64756008)(66556008)(66476007)(7736002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2911;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OeDznhSHCmAdap6CH8GJKrtx1JFAnH1nMtsvNgzjCIfS3Jwg1ASHxUxVBuQEN9OONAt+MxgnlZeznEmAv2PQhfaSAJ4K4VPJvpk78LQTClXge5iiSw4JTO5tBrxS1IMBawR4/6jVePA9McE4VDtPKJbJAILDHUGzf59TMYMHj04dOo8uZz9L4oTfCsbDaLu/7HTUXy8l0szHlNTksy1LtkDPJYFo0Rcp474mgtNh+OmV3rXZIXgjfKcYvs9YtghzcoIVVKIHy0T4rgg97j66EpjhStlDhDdYTLRS5ukoc1nmXQqVNXjIrZNsKSlZpuVRogbXolnmCM+nTVszXcpKNAgG09iNmgTxhfT4wYPb4apJGdgF1OPol3BihUaWJwhbsHcoSSClQuCm7u99LHW6jBDmlEKvcXkm+qVwszJgXBI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946f84db-d6ee-49ac-0ddb-08d73770084b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 10:57:41.5243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygPtJysa4XRYDU0/LU72prDYIPZGEJpjyBKi8Kp4F/rFXeHnDem2rw24bHPlBxY5xbx1DRLRhwhfcQdcZbxI/+pNoSF8xAIdZ61qWy/7v68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2911
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-12_05:2019-09-11,2019-09-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909120116
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series of patches adds support of magnetometer inside MPU925x chips.
It is using the MPU i2c master to drive the integrated magnetometer and
read data into the MPU FIFO.

Driving the magnetometer requires to disable access to i2c auxiliary bus.
To avoid breakage in existing setups we are disabling magnetometer support
if the i2c auxiliary bus is used (i2c-gate dt node defined).

Changes in v2:
* delete Kconfig option and check for dt i2c-gate instead
* simplification by using the same scan defines than mpu6050
* simplify magnetometer support by having 1 unique module inv_mpu_magn
* fixes and cleanup

Jean-Baptiste Maneyrol (7):
  iio: imu: inv_mpu6050: disable i2c mux for MPU925x
  iio: imu: inv_mpu6050: add header include protection macro
  iio: imu: inv_mpu6050: add defines for supporting 9-axis chips
  iio: imu: inv_mpu6050: fix objects syntax in Makefile
  iio: imu: inv_mpu6050: helpers for using i2c master on auxiliary bus
  iio: imu: inv_mpu6050: add MPU925x magnetometer support
  iio: imu: inv_mpu6050: add fifo support for magnetometer data

 drivers/iio/imu/inv_mpu6050/Makefile          |   7 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c     | 184 +++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h     |  46 +++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 152 +++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  60 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  70 +++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c    | 355 ++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h    |  36 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  11 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  86 ++++-
 10 files changed, 976 insertions(+), 31 deletions(-)
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h

--=20
2.17.1

