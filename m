Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2FA8B0D54
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 12:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfILK6d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 06:58:33 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:11170 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730811AbfILK6d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Sep 2019 06:58:33 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8CAuIFi020608;
        Thu, 12 Sep 2019 03:58:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=H/HbullFhz+KLrFmGWvTfyVKjyDp6t8npS/tLvwO3Og=;
 b=XDhjE8qLj+rfEcpSpO5w+7qOeSLhQ5DX2YDNGd67Uo8ZmGZYhj33bSPMxgvAYxSFYcTI
 WiGkMkAowNEESbRLTKkAJroTrWX5HF7esKPlwVZ1VtnbwUOwqeGBNNOYML3cxqyca1mr
 hexmXYAXLermC22xPce+kIxscuFW2ozqQBe0x/A5YhneFGyThe4OLHbC1ZfH4c+5LE4X
 Fii3leRBjmQJfGvhs79pOEzRwXq+urOFdTueVFFTiLNVwaZ9aloLkxuqxKJJXfQZNVpl
 wjVJ4TUavae8o7TV1X/qaYyEI8Wy10Qrr6yP1Pjbkw/QhQAWn9hKGI4EOro91ImOXx/s fA== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2059.outbound.protection.outlook.com [104.47.37.59])
        by mx0a-00328301.pphosted.com with ESMTP id 2uwrvdhwky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Sep 2019 03:58:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVxe8/QlPseXVGmSo9n8CB6VzWkgZNQGJB9V56WFPrzTrxZ+a4Zp+JB4evJkS6DqU4PJtQGr6H0pZpotwn2jnbJDVERW3XlvQm6DwT2FY88UYNc5b+rM7BakRwslWXZtnUr2gjyksDJg6BYSHf1N7otJDkDBZW5eh05U6umNSP0NaRuznDY5g65K8qk4EC1GRE9MdCBJV5IkbglGFIMmiR84BQrWR1D9YLPvPS65m61WcUokgpxavq7+IvKNtwQNZYvfCXNQXaK+T4OPFz0/UbewHAtsnOWEBAt+fhoBIIDw2k3vWC+VpfNTzJYLqZ11ysw5eeCF/E1HucWumRNHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/HbullFhz+KLrFmGWvTfyVKjyDp6t8npS/tLvwO3Og=;
 b=dqqEfS9mbTbDO6dglfZgDF1IELiKP060P4FUgsP5825IYNSFMvjjJmW+TqBQQhFHMEJ7doLZ/ICMGbz6EP76cDB5P6LoRFhK4fXHqwNZxJ0vYBw6MiUkCNkW8xPJlFt0MWhbaY9Sl/FiJuo95pwhuRjXUdYz+2Bm/iqkV1sUxqvY8UullD8jkLVBXkfA1filL/dlSbfNu/fI4Hj/6TDYsNv64F1ETwN7wDMX3wxuVynxmwAhAX0vZLe4WSDw1p7YMvrK5/SwAGTJG2Ihu5vviBc5EMhOoUyKyatz2t52FMUEWxMCkWPAuBZ6Zwp0ZwmJlkq+kilc+meJNqswLb3VOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/HbullFhz+KLrFmGWvTfyVKjyDp6t8npS/tLvwO3Og=;
 b=KoehO4dQT8VxCCVZbExaFnT1lgybfNLRb1HEi4WwIUswNrwLucU9LZlsY8KsYN6wjITKKe7OgZtz9sAToXqyhPQzeFJOAWXWWYuSBVWlLQuqQ8FB/Wap8r4g5O0CqbbB1Ld9OrQEaTiiY3jQK58q70t7gZ6IUn/nuRoZlvCiXHQ=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB2973.namprd12.prod.outlook.com (20.178.243.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Thu, 12 Sep 2019 10:58:30 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166%5]) with mapi id 15.20.2241.018; Thu, 12 Sep 2019
 10:58:29 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH v2 2/7] iio: imu: inv_mpu6050: add header include protection
 macro
Thread-Topic: [PATCH v2 2/7] iio: imu: inv_mpu6050: add header include
 protection macro
Thread-Index: AQHVaVkCmetzGvkag0CGnV9OrCVo6g==
Date:   Thu, 12 Sep 2019 10:58:29 +0000
Message-ID: <20190912105804.15650-2-jmaneyrol@invensense.com>
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
x-ms-office365-filtering-correlation-id: 7f0c2ed4-5f06-4a12-f6eb-08d73770250a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB2973;
x-ms-traffictypediagnostic: MN2PR12MB2973:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB297343966252232213E57610C4B00@MN2PR12MB2973.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39840400004)(199004)(189003)(81166006)(80792005)(86362001)(76176011)(386003)(102836004)(6436002)(50226002)(26005)(4326008)(14444005)(256004)(6506007)(186003)(2501003)(99286004)(53936002)(66446008)(64756008)(1076003)(54906003)(66476007)(4744005)(66556008)(5660300002)(486006)(14454004)(52116002)(66946007)(446003)(476003)(2616005)(316002)(11346002)(36756003)(2351001)(71190400001)(2906002)(478600001)(305945005)(107886003)(6512007)(25786009)(7736002)(81156014)(8676002)(5640700003)(71200400001)(66066001)(6486002)(6916009)(6116002)(3846002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2973;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mEv41thoEaBCrRVXjOLJBjJGjDhqdVe4vI5iQQsqyuaMpmedmSeyz8ZE5n6lZs3QJE74Qwm3ufVTUdSpWudvoOpeQebBzDnFLyubu5b//JGUZEzzOLZ+RYywgLavWheVnqTtvFyVOrYbCRQS9ZlU7iK45+/LST/I0oXQ0jnhB5z0ejWu7AiNBM1rK3muXSv2P7kAASkqh2ojIfr2lTflhosr/L081PCN1mEtft4o7HKgm53PMs9zZuzLvSF33wEDSjS0D0CDzlTFMrdRS3dc0HOmho9fpEi2Pp1JenOyjcQsAcJzuBQ0xqxIH9KDsndPQbH0+5p93MT81YDGJ82SAFRc0pQea2ekzRLMskq8BkLQh/p7WA5ecY3djSi5A5TluIYLOqfgU04gyK0zMD9llA6hwBn9wlm0WkZsrw5y9hA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0c2ed4-5f06-4a12-f6eb-08d73770250a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 10:58:29.7932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOF0dJ6u6L1SGTSx6ItxqCPPiMq//jYBMQcRIOVTuUGixuYK9pbnSjLL2YSPhJoBxlbRezHA22LzPUSnxkDdAQUH+VE/i9z3jTBi5y7Iscc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2973
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-12_05:2019-09-11,2019-09-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 malwarescore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909120116
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
index cbbb2fb8949a..7cfd3a05c144 100644
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
@@ -344,3 +348,5 @@ void inv_mpu_acpi_delete_mux_client(struct i2c_client *=
client);
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
 extern const struct dev_pm_ops inv_mpu_pmops;
+
+#endif
--=20
2.17.1

