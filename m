Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E83A204F
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2019 18:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfH2QFl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Aug 2019 12:05:41 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:48616 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726973AbfH2QFl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2019 12:05:41 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7TF9rf0002001;
        Thu, 29 Aug 2019 08:18:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt1; bh=tGejrGv65sAIsQeYc7JL0b5watxKwHMoSndyaGiOLPk=;
 b=woXQ0jesnxnm58tUhgM24EOKxJvAkafvLf5ZQblo+h7toU8rsS1GnUxFKTmXyxbLCyQQ
 4Vu3KA0f/cnBJz+q3xtF8uonPySfF3VqiEG+BvxJW0MMil42dj3zKYHlLkgWYlheGJeJ
 0D22w/9ETS8aq7RaQTxGCymfiCUWuNWHtVFMneqRW0BH1Rz/4UziWeoDWiZQ90vJYiHc
 7e6+5+r4wywPMPx+RDnjP58DdzEOl5WUp8h4/gEq+i7uGxPkHYSvgEslcdl7CM9NSKRR
 YD9vooqIIMaoqteqN6cJLvdzQXuD+wuekuXCfbAAtxKTZpfgHCTGKO6IxQe/OpZ1sXt4 vQ== 
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2051.outbound.protection.outlook.com [104.47.32.51])
        by mx0b-00328301.pphosted.com with ESMTP id 2ukyymt18q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 08:18:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEWVR0M4p/4faVgrs5Ur7weourE8sJE1jWrHQDk/nD+ntseMES6qNUOltQAv1DRzYPaNycNaRzutM52qt8iBACIPpJ9Iq4cCxmoOPAy2UGqXu88a4WdNu81CqPuyCLwFITNefCff8EJksenmEtptW7EeQ7/yscsYw/cVOYvDsY/vQjpXLUcbgxZLaP8cl8+22eHTHYwqIY2weFPSpvJabpw39SQcHKVmmYrsR13ZsgZUdnMe0ilda1gzvt9A39b29BUFXPR1SR6qLGesZgwusWffi0dA+57weuQ0dzGsoR9bi0ChP5as+gLI0drcU4VZ4uHgYmT5C4PgweXL5ic2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGejrGv65sAIsQeYc7JL0b5watxKwHMoSndyaGiOLPk=;
 b=UxF//FIo4pzgTCYHh/yVyfy8HL9q629CTzuu0ose19LVNUSrlkSa+4ylILONpPPywLk5wUXpy5EJ2BzMDqndQLdV+S3l1LuOwnpQx1jYcNWc7TDTJI756dZZfhz1Kl22AlO/fhhRjoZO/iYuX3HrZiBtkArVc7jme+ccFnfqcChZG/cxSYOXBGcep3+oICHck1p4fhufCc11T2jcBxENG3tBYcv22l0TIoFhoo3RxNvcB5jrBQolDU0OYVDeG//asOAeosw4s1czu/WkexH0n3PPsG+7MZJuNaDKVH1npG5WFrsvbczeJ/qkDYjmMwzYlBc/F/Z61ev6a/qhl6hKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGejrGv65sAIsQeYc7JL0b5watxKwHMoSndyaGiOLPk=;
 b=EPUHb3s+q+ZM+YoVfMS7SL9FneKBxjwsmFXJC9eZ75kwvMZJiItK49fJCcwrEKFPAeMBtrIw8Xy2rvhfCMTdShFpr02tYZJQTYdKY3IKvH17JMxjSKerlaTZkbZKH2FBXLWDGMcsWuvRlbidq+Qo2jbXL2JpNP7telfwj1zynjQ=
Received: from BYAPR12MB3366.namprd12.prod.outlook.com (20.178.55.207) by
 BYAPR12MB2950.namprd12.prod.outlook.com (20.179.91.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 15:18:34 +0000
Received: from BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861]) by BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861%7]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 15:18:34 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH 0/8] add magnetometer support for MPU925x
Thread-Topic: [PATCH 0/8] add magnetometer support for MPU925x
Thread-Index: AQHVXn0Fzssnqa4N1USG7L0WWvUwAQ==
Date:   Thu, 29 Aug 2019 15:18:33 +0000
Message-ID: <20190829151801.13014-1-jmaneyrol@invensense.com>
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
x-ms-office365-filtering-correlation-id: 63440f9c-42c8-4fed-0ce0-08d72c942820
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB2950;
x-ms-traffictypediagnostic: BYAPR12MB2950:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2950444D1BBF032A3B9BA866C4A20@BYAPR12MB2950.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39850400004)(376002)(346002)(366004)(189003)(199004)(54906003)(7736002)(8676002)(71190400001)(14454004)(14444005)(386003)(81156014)(71200400001)(66946007)(256004)(66446008)(66476007)(305945005)(64756008)(86362001)(66556008)(81166006)(2906002)(5640700003)(8936002)(478600001)(5660300002)(316002)(80792005)(6506007)(1076003)(2501003)(36756003)(26005)(107886003)(3846002)(6116002)(66066001)(6512007)(6916009)(6486002)(476003)(486006)(2616005)(6436002)(52116002)(25786009)(53936002)(2351001)(186003)(99286004)(50226002)(102836004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2950;H:BYAPR12MB3366.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ilgTaSe3u0torja5aWjra9AYsrgZS1eoesFBPjtsPwQXvJQHVMQ8ycRKqDoDGzVeWp49VpMLoq6Uzgc7opglk6xMrTwSKf/X1F0ZxspqdGa95M620prmN0Fns3oj+7MJ4Q5x/RDGUsx3S1WJe63AMSs8rND+BPtS7qVETyuuOF3cbmbCDUzALacAqkRRee9s6Z7N6BEsPP7V8ebf3HkveKK3neq+lcB8JxNOraXsurxz7WEBm8IQJHusipM+DjfkFwHA6guHToA/JweXDI0XUr+6lLDdyW/iQm1+sakRbsPd02o7ziudhh0dSMn+6cRqi2HyRO6eyS9nDfBbgSf+rlvhOmupKClzjEgA38+1IgiZjcCp8M62TpviW9efMTDyxMqI16gdx2S+6ftCh9w3qoUattILO5Kcro5gZ3ifXEA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63440f9c-42c8-4fed-0ce0-08d72c942820
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 15:18:33.9243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a6B0LaBIjK5iYz1oBrNiIgMscxmZx11rlKPlSxuL6UVzDJyfQmpPEL+7j4Itn4jmejXApk5d1sjyCiyA8hJ04GUh8XU5/5GVpPe4DNaWHo0=
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

This serie of patches adds support of magnetometer inside MPU925x chips.
It is using the MPU i2c master to drive the integrated magnetometer and
read data into the MPU FIFO.

Beware that this is disabling access to the i2c auxiliary bus. Since this
can break existing setup, it is an optional feature requiring to enable
the corresponding Kconfig option.

Jean-Baptiste Maneyrol (8):
  iio: imu: inv_mpu6050: disable i2c mux for 925x under Kconfig
  iio: imu: inv_mpu6050: add header include protection macro
  iio: imu: inv_mpu6050: add defines for supporting 9-axis chips
  iio: imu: inv_mpu6050: fix objects syntax in Makefile
  iio: imu: inv_mpu6050: helpers for using i2c master on auxiliary bus
  iio: imu: inv_mpu6050: add magnetometer implementation for MPU925x
  iio: imu: inv_mpu6050: add magnetometer support inside mpu driver
  iio: imu: inv_mpu6050: add fifo support for magnetometer data

 drivers/iio/imu/inv_mpu6050/Kconfig           |   9 +
 drivers/iio/imu/inv_mpu6050/Makefile          |   8 +-
 .../iio/imu/inv_mpu6050/inv_mpu9250_magn.c    | 239 ++++++++++++++++++
 .../iio/imu/inv_mpu6050/inv_mpu9250_magn.h    |  27 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c     | 191 ++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h     |  46 ++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 141 ++++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |   5 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  79 +++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c    | 120 +++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h    | 107 ++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  14 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  90 ++++++-
 13 files changed, 1055 insertions(+), 21 deletions(-)
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.h
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h

--=20
2.17.1

