Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85032B0D59
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 12:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbfILK6i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 06:58:38 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:18766 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730811AbfILK6i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Sep 2019 06:58:38 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8CAtDPJ012944;
        Thu, 12 Sep 2019 03:58:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=5mSFPzjXvF2DWpr+b2NK78N6s6olmW8sHyGEuxIcapE=;
 b=oQfYwO29BZo6mHzyskjRrG/fuYuQhuDNvZGmbg0YGHeS1gbKRkqbXaY+I1LLc04eY2YU
 QTv4uxAXv67HE9Ku8LmQIhKV+8aaDR2BS6hGE6nLroe0gebqiQGC2I+hpqyAV0EmqXXQ
 /AJhtFs0sJsbRDxYDlowfR81dWgNrrJQGzWNX2zzUaXAvvYnoiI6Ie9UcQDpzXcCFyyq
 tJQSNbWrvBI2cncHBDU4SlIpJ2MqhU9dUZTkmbgZfTej0ecW6V/zrszjRpWL0fhYweXF
 yndIKvztWFbdgE4M/b4iQCM/JPKWrN+/RV9zfbLc3aNLaYmO53YIRpiwFiUKhcuEeTtU HA== 
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2054.outbound.protection.outlook.com [104.47.49.54])
        by mx0b-00328301.pphosted.com with ESMTP id 2uv8gn2s9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Sep 2019 03:58:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoSibjYyxf+yUhJLdk7IosG58aXesdPuUo2LMM4lQhoyg33lM4Se+J/w34bbaJBjj+pfEXUWHqvgqWnphURFc+Im0KH8inHXxqqgRQETKgQqkBOwBmsL4s3UNtts4XyUaA8AnvEJSohWfXoxrJ9mAHBoOAWoSgNvJqGOYaC4jaS+qM88rm+WWIhLY8HBkg9vwFrMvcTEfmEjCSza2R3Ur5dUr6qe1trM/yQ6+TsvEwTwKZjFpvQXHvtbs0zFAfnCF3aFYcmRb3IeIq+wcSPPCO4/vHCvCASRczBrAHQj6RFSmwrTwUnNsdyQrERQVe1U+uO+cWaaHLvVO/p1/sw6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mSFPzjXvF2DWpr+b2NK78N6s6olmW8sHyGEuxIcapE=;
 b=ApcDsRPk5KbshYkAmk6T//Ox8gAwf4K9l4usBphpjVpcQJstWcDVpxk0fFnN/n6FBxsPvBIJDWX1xTYxiTT8IrB3YIwUCiL+zvQzjSygtvxxO6CYc9BIY5knzPBfT++1xEf+zlG4shBhNYI47yyaEBOBYEYsUJb3Bhqa5kI023Vhs4zeg54Wv7EFJbw5vAhKOo1WcDIIWh61MBjtV5l96kfY6nKw+9WWa5zz35C11JRGIXYBJNev+5P7nccRpSyZJ8d2fgDWcsRpaSQsyzc/HdHot35WerlTl1LX2Aki7jPVxlfE+Npv5ETAaImqYYpKxd1iIFWHu1FqQY5PdAUm7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mSFPzjXvF2DWpr+b2NK78N6s6olmW8sHyGEuxIcapE=;
 b=HpX9mFLBk+zm5aVUc2hmMMTzS1g82MOsVwFXTegXYiJmPkdwZDShsXDZxClf9YLTVC+dKiARo0PjOaJgcg3uuvOaJrLbfnBHHdXEd3PiKdGENUpx6j482Jz1fjHecIFqqkOMUiQ3yAtXL9/6mgSmc4F0A4oZln16XzhGl3oy4kw=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB2911.namprd12.prod.outlook.com (20.179.80.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Thu, 12 Sep 2019 10:58:33 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166%5]) with mapi id 15.20.2241.018; Thu, 12 Sep 2019
 10:58:33 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH v2 4/7] iio: imu: inv_mpu6050: fix objects syntax in Makefile
Thread-Topic: [PATCH v2 4/7] iio: imu: inv_mpu6050: fix objects syntax in
 Makefile
Thread-Index: AQHVaVkEobZ2UimBLk688fmzqwhfpg==
Date:   Thu, 12 Sep 2019 10:58:33 +0000
Message-ID: <20190912105804.15650-4-jmaneyrol@invensense.com>
References: <20190912105804.15650-1-jmaneyrol@invensense.com>
In-Reply-To: <20190912105804.15650-1-jmaneyrol@invensense.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0448.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::28) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
x-originating-ip: [77.157.193.39]
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 841a6b37-51e1-400f-52f4-08d7377026ff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB2911;
x-ms-traffictypediagnostic: MN2PR12MB2911:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2911AFB65C2492C9BEEC048AC4B00@MN2PR12MB2911.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(366004)(396003)(376002)(136003)(346002)(199004)(189003)(86362001)(6116002)(4744005)(3846002)(99286004)(54906003)(2351001)(1076003)(81166006)(81156014)(8676002)(71190400001)(71200400001)(14454004)(476003)(446003)(36756003)(25786009)(80792005)(52116002)(11346002)(2616005)(256004)(486006)(6436002)(478600001)(76176011)(386003)(53936002)(305945005)(66066001)(6512007)(8936002)(6486002)(26005)(5640700003)(6916009)(102836004)(6506007)(2906002)(107886003)(50226002)(316002)(2501003)(5660300002)(66946007)(4326008)(66446008)(64756008)(66556008)(66476007)(7736002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2911;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JMctpO/LQj2SIaTbas4bS5q/g5VK+Eu6zmIK8TbHrAN4H3IhWmb58uWJc0JDqAasID0vThKrTKRrAG+8kdxjA+YkMizg9Vj6vR2abxsrfgKSnxyaLAXbjetUijgYZHEB5Vrpdjtv5nfZS9hBtHmwnxBxbOvjjSdIQlEI2uv6NA5+G5OuE4tvxhTXPBSgskGkg5CB/hO67Ukmd9aoacWYnOudA+cWk0kyyhnYFSablHFnQVuwUhX7mRZ33CO0qXgoQiY6YTM87Mv9QARmt41kAgy2Ur8/yEv2bTzMTiN+dGToBiufHy2Su/oA9QnTkqN2XpzsZD/ReZOScrItGsvFxayhyjMPo82VyPi1pLaqFVg7SqIKyqlvbmZcgRIKRcH5+vnvdI4lLaVuEgKZMNamDJ51BMHgyzhCJvuCHhvRVck=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841a6b37-51e1-400f-52f4-08d7377026ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 10:58:33.2493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MjvKJEtQTserxjithNy8k1DZbixQif3F18EQCzkvF2cnzXW0b5ol9u/IblqwftGLc94L+0jKcFFv2cxbsfzh24tAYroAvwihRt8F6//CRSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2911
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-12_05:2019-09-11,2019-09-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 mlxlogscore=937 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909120116
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

