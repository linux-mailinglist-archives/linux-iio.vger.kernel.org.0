Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A12B3749
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 11:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfIPJl7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 05:41:59 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:38642 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728525AbfIPJl7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 05:41:59 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8G9eodw021657;
        Mon, 16 Sep 2019 02:41:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt1; bh=YguFbSZ3Ixkw3zYtTpVgGA27mcd4gX4u5xacfnTaQBI=;
 b=vEzpf4unhaCpPRKnuzPVf/0aTTzPLe5T3iClV+kVjF5BoqJXXPcQopVRKBItNQ8a2Jxq
 CnVotpl+DqynaEnk8YCgTFeScZkgi7IHZZnwCXakrnJYG+yTeRfeg+xuBsrk93bqoEKA
 1fUs4fyaUHwGVMH1niVw5nJtOSQRb3oc/PaFrYiO53MpWlN+ONMpWOaggmkKyVk/3f9o
 ulzGqGqgYCdp/FYOJNGqLGlj+/dXlgqDr49irbwPxTmZlMn7qI1pMcaNuqQUY8bdwQC0
 jKr/tabJolEK1ZoUVXKnu2VDDwQX03IkxRZ8uurXKiINQePSW8BvisUf1ePK41EPFBBC Ww== 
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2056.outbound.protection.outlook.com [104.47.34.56])
        by mx0a-00328301.pphosted.com with ESMTP id 2v0upprng4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 02:41:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6SkchHLsCleRDehVgPpVEXVKjVFHO7FFxs1E96R7IhILzoioCToxl6W5rywQ45yB5+K3Xx5kbvvWSYqa1xgmRRM4g+fTMNhE6Eu+kqaQ7zwxISUTry87YxYMDvnDVOLTdvxlQ0h55lWUIgJ9A6bOX7yC/U7+2H+XoNhk26qyFg185GJ9sxk9Dm98YKwxdziGPD5GrrazQY2X+UfoT1kKO37SFhiWy1oCMa0W8BlR+1Vjs7kWkRBrpe2DsuJkwD4RU2bcj/aE9M2jxXGzPiv6cvSQQUmAHpzxh4258r6eVluy/Z/gOpuJBXl7TusEI2up/HK5DQtE2A5iJ7suo4mSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YguFbSZ3Ixkw3zYtTpVgGA27mcd4gX4u5xacfnTaQBI=;
 b=Ta84pkd+y7W+6ayXA/ZFem8YiuHaBguPN2eoXA/T+3EdV08bGYjIWTyj/tR5W1TM04rSdQa9BQ1UEq6jN+tvZH9whCPEuoNsPcc9d4P/q04SZkvJ+BmWjF3R4VVqaRIolbLHjwT5jwMXlo2huiPuJaZ00Q6QV8zdWaltco8KQS1WCRbLjnaL93iDMbLsEl44HdqMwflqQzCmZCq2Hl8XVQTKjq0IG399M3CPVptgBfpdYb9PZllw3fnDy5eEPb3Cm5I1I/1UuMbfkNlzsNf6qyr9ulZlInmRwK3A7TvstCJZKnKsM5r/AW+qXOC6tI0pHr4jzM0ZQhdtHvOOa77Nvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YguFbSZ3Ixkw3zYtTpVgGA27mcd4gX4u5xacfnTaQBI=;
 b=FPJpQg3fIxYr1yDm2qMAzzybu0hbP87bjviezYdna3WAATvDW0hurz6yURx0cxXsxJIMzgEeksw4idBZVsAeAF2ttj8uZTE/wOtblJTzupYM9+EJpIiCFf3frChFQwFTddhAA/FK6886B/h3f5glrwdSGFJDiVtsPpSSvfxRkJI=
Received: from BYAPR12MB3366.namprd12.prod.outlook.com (20.178.55.207) by
 BYAPR12MB2632.namprd12.prod.outlook.com (20.176.255.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Mon, 16 Sep 2019 09:41:53 +0000
Received: from BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::1c84:7948:a3:34fa]) by BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::1c84:7948:a3:34fa%3]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 09:41:53 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH v3 0/7] add magnetometer support for MPU925x
Thread-Topic: [PATCH v3 0/7] add magnetometer support for MPU925x
Thread-Index: AQHVbHL4QMMY2E3So06j4vc2Qp2ofQ==
Date:   Mon, 16 Sep 2019 09:41:53 +0000
Message-ID: <20190916094128.30122-1-jmaneyrol@invensense.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:a03:54::27) To BYAPR12MB3366.namprd12.prod.outlook.com
 (2603:10b6:a03:a9::15)
x-originating-ip: [77.157.193.39]
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7b77e3b-82bb-45cb-dd72-08d73a8a1b0a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR12MB2632;
x-ms-traffictypediagnostic: BYAPR12MB2632:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB26329B29039284DF181C9639C48C0@BYAPR12MB2632.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(346002)(366004)(136003)(189003)(199004)(81166006)(99286004)(3846002)(5660300002)(66066001)(2616005)(54906003)(5640700003)(316002)(6916009)(36756003)(71200400001)(6512007)(102836004)(26005)(6486002)(6506007)(2501003)(71190400001)(386003)(2906002)(6436002)(1076003)(305945005)(4326008)(53936002)(7736002)(186003)(6116002)(81156014)(8676002)(52116002)(107886003)(66476007)(25786009)(66446008)(2351001)(66946007)(66556008)(8936002)(64756008)(50226002)(80792005)(256004)(14444005)(14454004)(476003)(486006)(86362001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2632;H:BYAPR12MB3366.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U1ja8Hvdn/uWmOycsB39VRhzCKHRmNqBpRDvqgyKtihrtJaSk4bAXnNlNzGPGgt8cFo60F4AD2vexH3DJJcob5RpKoCbXokzDz4vOvSyGebszr9y4hh13J/uOMYTm8xSJhtFzT8d2ejhlhAErlQcVdrxHSFIAc+gM/xiuDDHKLZn5JAGzWKAiMrBver3NY7PdOt0EjrA2s1pUgFfiRWIuwWIsUr+YyirMOE4fHIk0rbTeba0lprV00JeLaNvWYMYXEw6IggQVAcCbQh5YTPD/aaZzhuK/Jg0NiOABcZ1IJ1ryWLYQi7Z2wTd7+2eypYDKDmd8Xmr/ffkt1LGJNswt6RQXx08B5gVceNyQoA7cDHRlPp1twLj4TTUPycn9G6OpARS4La6+q3X8MAx94oK81fpYGxJ0/88RkulejA6I/Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b77e3b-82bb-45cb-dd72-08d73a8a1b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 09:41:53.4466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CdPOLYhwgSDE7YQt6lAmynK+nfmXAf26EgfIdynZimF8Mxxeoh0jFoZ/6TF2HXyAwJz2iY5W2DKOHLTNCdrqO3L9Xu+aESW8lxlX+/0VFpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2632
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_05:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909160102
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

Changes in v3:
* move documentation from header to implementation for mpu i2c aux helpers

Jean-Baptiste Maneyrol (7):
  iio: imu: inv_mpu6050: disable i2c mux for MPU925x
  iio: imu: inv_mpu6050: add header include protection macro
  iio: imu: inv_mpu6050: add defines for supporting 9-axis chips
  iio: imu: inv_mpu6050: fix objects syntax in Makefile
  iio: imu: inv_mpu6050: helpers for using i2c master on auxiliary bus
  iio: imu: inv_mpu6050: add MPU925x magnetometer support
  iio: imu: inv_mpu6050: add fifo support for magnetometer data

 drivers/iio/imu/inv_mpu6050/Makefile          |   7 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c     | 203 ++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h     |  19 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 152 +++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  60 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  70 +++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c    | 355 ++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h    |  36 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  11 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  86 ++++-
 10 files changed, 968 insertions(+), 31 deletions(-)
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h

--=20
2.17.1

