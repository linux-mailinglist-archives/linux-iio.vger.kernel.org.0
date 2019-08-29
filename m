Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79C41A1F63
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2019 17:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfH2Pju (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Aug 2019 11:39:50 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:2852 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbfH2Pju (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2019 11:39:50 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7TF9rf1002001;
        Thu, 29 Aug 2019 08:18:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=AhuCvMbkwsKTFtXlbk/RBoZgEO4CKCGDd2zDk27CDVg=;
 b=TiFrcPfRkYMlmmsq/cspMZgw5oFq/930dlZ8CY/3CVqISyZSFTOsLAHR6ttYIg8fRSTZ
 ItqVUkbyo0lVXjaq7NTNNIokWEqxNP+7C/fCABL5N9W43Bp+y8NXUjedI2pZNhfmTv/c
 1lHWvgaVdRvUaEyLrMUTZAPGMlH3QjWyA35b/0djdHmXgoB4y4vXvi1Qhyzp2OvCUAzM
 m2X0uDMuAJTpyHMLjtLWlzXBXs1M5jkm+BjIZQMu5B1u+m/obZLjwy0ynA9wBn+Xnti/
 DXs9a6t6evUURk0Fw+eM+G1do5q1pI4uAFzBbf2tA0MLEgj5L+dvDaHnGp/rEvyCmh/H ZQ== 
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2051.outbound.protection.outlook.com [104.47.32.51])
        by mx0b-00328301.pphosted.com with ESMTP id 2ukyymt18q-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 08:18:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5jcn7AJHRqQ1uR04nVxNY8fqudMBEUjiq7MizK7d2R1IJh0zgXFrUTRUW5AVrXTj8kgLIdikSIDv45F7GU8f+tTCg7b+cruC43NQyKblS+AvTvCfGsCOwdc/i2QRAh+GS5orbt64ppqeJO2uiKt4xqutQt7wPxgQgvUeljz002f/xzHzbTr7FnQpiI9280bq/A39IwPZ6tyJTYO8swCW9n9D/wJncXdm7yjnHncfNqfZER5em0RF+1xKtFf3c8BY3aYRzBCXBOtQYPt6Nbpn85GAY9mNS12+4DZ2AeT9y1HYUfR6jX9NHbr5IBA74Aq35zxItv8UAiiBXqr5Jo6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhuCvMbkwsKTFtXlbk/RBoZgEO4CKCGDd2zDk27CDVg=;
 b=V7OFzFBRxDIYarazA5YDK2GGNmIYimVHYUMzDvhoPS2GyQxO1qP2hflCd5na63EHGFVdst8vN4FpXWbHsvBDm5RZHbyF8G4nya/nlO54E0+GgaWqPY1ifVPTzFWSv6F1Ma9USJN5vLyfefV8Ck8ywHxYQBfmxJltUi/UWIU7RAYi+gAz+93qfNauAp6lsECFBkrkwiSxzYT4XvA8s4apxeOGgnGOE6WYPzesFGYcIJt4gdKKVVcbA14dHVCv3z4vzpKmE8JZpyln064SvnlocanJMQwX7t1ehsh1LVfcayX/QI9j0bjFmJndqIjFFKM5Azvddmwx1TZmimFf2quG+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhuCvMbkwsKTFtXlbk/RBoZgEO4CKCGDd2zDk27CDVg=;
 b=Nb37AhzlCzmDOzd38dDoQ88QZHtXgQxK+saEif/O6wBMZ0Hixo+7BLspv08cqApwYivyS3NIOVl5MxKaLbtONf2Vv0UeRVd0W7a47r3ZbhtR9WAlAN8z+QgSODZ+GvfQ9y1ygBLDG8m5nEbf73QUAJMWHb2chx8NbOcI+yXyrNA=
Received: from BYAPR12MB3366.namprd12.prod.outlook.com (20.178.55.207) by
 BYAPR12MB2950.namprd12.prod.outlook.com (20.179.91.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 15:18:37 +0000
Received: from BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861]) by BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::24a1:e93b:cc7:5861%7]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 15:18:37 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH 2/8] iio: imu: inv_mpu6050: add header include protection
 macro
Thread-Topic: [PATCH 2/8] iio: imu: inv_mpu6050: add header include protection
 macro
Thread-Index: AQHVXn0HbBGjuRZnOkK8ZEkIbCuQrA==
Date:   Thu, 29 Aug 2019 15:18:37 +0000
Message-ID: <20190829151801.13014-3-jmaneyrol@invensense.com>
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
x-ms-office365-filtering-correlation-id: 5522b178-f08a-4fb0-4004-08d72c9429fb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB2950;
x-ms-traffictypediagnostic: BYAPR12MB2950:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB295042184E97F1E7A635E8EFC4A20@BYAPR12MB2950.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39850400004)(376002)(346002)(366004)(189003)(199004)(54906003)(7736002)(8676002)(71190400001)(14454004)(14444005)(386003)(81156014)(71200400001)(4744005)(66946007)(256004)(66446008)(66476007)(305945005)(64756008)(86362001)(66556008)(81166006)(2906002)(5640700003)(8936002)(478600001)(5660300002)(316002)(80792005)(6506007)(76176011)(1076003)(2501003)(36756003)(26005)(107886003)(3846002)(6116002)(66066001)(6512007)(6916009)(6486002)(476003)(486006)(2616005)(446003)(11346002)(6436002)(52116002)(25786009)(53936002)(2351001)(186003)(99286004)(50226002)(102836004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2950;H:BYAPR12MB3366.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r+5Kps0ETj3hSb5eG1Idwsr3NhyvZ7/92xqHD9Z7glIB8kGYU03Wfh9VByh3e0MkCsKeFVEAkqTPhF7QP7kEs9qUKKpVIKmj76p1ECJGqmuNzAmMlmEm/idMsKIXV8OdPV6W//FW7fU/w91TpzYRojicYGTQQycduV+yMSIAfJxy+7IluDM4VtBJH2Bf2MBHQCUWNBe4tuPSszFyCHjzsrI5FT862mhvIlwyEOyM3DwsRs+naaVsgoX1T0DblMDBiysNWZx1Ra2NmRlTVMKB3aIbn1dfkGDDLPQoysKC+BdgFsXhbEfe+3FSSg20fVQYVVXOeKOemP4UkoYSsNVujuDpB/xVPwFbd0unuJL2Q1M+D4HxSOR3WAmLrVIYqAcj8EE6vLPAeGu+Cx2cL9fSeUTxu+fZ8FWbHyNQZw1ZMyc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5522b178-f08a-4fb0-4004-08d72c9429fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 15:18:37.1875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SWgzmq6myg2gsiIR/3IxdwYM1erDP9JJ3OW+Adj9mB95hlRT3bjq6h4yHAX02PwIDgPaLsqwlYVOWxJOVSpVblD+WzunZGQZtqi/H16HvU0=
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

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h
index db1c6904388b..e64eb978e810 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -2,6 +2,10 @@
 /*
 * Copyright (C) 2012 Invensense, Inc.
 */
+
+#ifndef INV_MPU_IIO_H_
+#define INV_MPU_IIO_H_
+
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
 #include <linux/mutex.h>
@@ -342,3 +346,5 @@ void inv_mpu_acpi_delete_mux_client(struct i2c_client *=
client);
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
 extern const struct dev_pm_ops inv_mpu_pmops;
+
+#endif
--=20
2.17.1

