Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3470A8195A
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 14:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfHEMdn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 08:33:43 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:28250 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727259AbfHEMdn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Aug 2019 08:33:43 -0400
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Aug 2019 08:33:42 EDT
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x75COgcl005515
        for <linux-iio@vger.kernel.org>; Mon, 5 Aug 2019 05:25:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt1; bh=AhuCvMbkwsKTFtXlbk/RBoZgEO4CKCGDd2zDk27CDVg=;
 b=GM+aTme7wr3jKAntCHzzCza6qyqzGjLwOo84AWacVz6vMVdGfeixVP9kvEClHV/BE+eY
 yQZQ/dovN0JluoSRMTgbE2jYXvP4uMlq4IPXF8YokcwarrloOafl6cBfLnB6YAIMGJTd
 dvXHVhrTHY7Kqt10z8ys61AL6bqJyoWk2/6VGuNNaM/DiW8GXaIBc3wl897npuQ4rw2+
 kF+iLJRp5HKQNecZfLv8iRq0SWhuues36fdNyBrvv/drwkevshGZ0i/tSo2dh++bjOjv
 SmixHDzy8TOi0iu7nqF+TKtKfBRANF1CZ5XxYtvTpudUTenaNrT5he9iFP3zn9D3CP9m EA== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2059.outbound.protection.outlook.com [104.47.33.59])
        by mx0a-00328301.pphosted.com with ESMTP id 2u55rj0qjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Mon, 05 Aug 2019 05:25:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wg68sFz02LF9laQR0YgVXCuTRmrO0pcLOoNx0JXdK40REjDVcibsDIPEtPztr9lQ1CkZ7oONi/TciXzi0Pb9Cydq4DxPkk48re/2DFEC1eiG37yAoyuLITZ2x551s+6X/vxxDtkl+74jgwo5kqolV2DSx0LTGB29qNK0BBluF7v37t4nhOBl8r9ocDxyNa/0+PmI1bicBLABS+JtirMpL42OfmNrXJWGX/oVhk9wRUAVp5v9ZlIi52TuVm7TnnUhK42UPjb5imknfW0TkGL8cq5TkYjaVOqAsDL/cQ0nWSz1PAY2Tv4fNsWXxZ7qUZ9vC0zeHRiCBOrniWQ+xVNw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhuCvMbkwsKTFtXlbk/RBoZgEO4CKCGDd2zDk27CDVg=;
 b=mUSUnQz6INBhTOMYwu6NzfK0yqDGw4LfeU4FLe62TUNcAXMUY5YJi4i0seoqKOZHc4xYXycb1UVs2AF8WBLhEXIoMoGbf15s6O5XxBMT48SbEyaal6DD7HifXlWcDCa/HmGRrd3lArqWuo2Ci1ZKKHgjdKsLsEA6LuRE3TghBV2IBxoZHcMlyNoJMut9fv3gVN1uFRCcSl9oC7NqHIT5IxNMomjzKzQRbiMT5jWLT8gNBqJyOGqov1/Qymlny3JdOIdGg2c7RNKQECwUtu4u1mCsJlyARAM/DiwVYgHYk9CbelAPwOUcsnYIUgRaVjom1VZAO1jgxyOML3APZeqfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=invensense.com;dmarc=pass action=none
 header.from=invensense.com;dkim=pass header.d=invensense.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector1-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhuCvMbkwsKTFtXlbk/RBoZgEO4CKCGDd2zDk27CDVg=;
 b=fdhc4Aiavt8ZCeYodFbC+PEK/sliTh5oA4456mnVIim575z653h3jCJ2H+beonW2kwDK0EKxBGS8uqTtUXpbkkKhF1SbJY3ynQZAGaT/QYlatgFYtnTpIVP6bgBU7YPSnr6ZP2TpRbMjSSdfX/dizipjflBBiK42QFaH/F/YtCY=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3616.namprd12.prod.outlook.com (20.178.243.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Mon, 5 Aug 2019 12:25:44 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::41c:622e:62ef:3dd5]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::41c:622e:62ef:3dd5%7]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 12:25:43 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH] iio: imu: inv_mpu6050: add header include protection macro
Thread-Topic: [PATCH] iio: imu: inv_mpu6050: add header include protection
 macro
Thread-Index: AQHVS4jmdphJPlu5nEy8cN0WRDo//A==
Date:   Mon, 5 Aug 2019 12:25:43 +0000
Message-ID: <20190805122513.8399-1-jmaneyrol@invensense.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0088.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::29) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
x-originating-ip: [77.157.193.39]
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcefe418-cda9-4d17-120c-08d719a008e3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB3616;
x-ms-traffictypediagnostic: MN2PR12MB3616:
x-microsoft-antispam-prvs: <MN2PR12MB3616EDC94D86CAB9BD928B90C4DA0@MN2PR12MB3616.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39850400004)(366004)(199004)(189003)(6116002)(3846002)(8936002)(50226002)(2351001)(53936002)(6916009)(1076003)(81156014)(8676002)(4744005)(2906002)(486006)(86362001)(2501003)(81166006)(476003)(71200400001)(4326008)(52116002)(2616005)(71190400001)(80792005)(5640700003)(25786009)(102836004)(14454004)(6512007)(186003)(66946007)(256004)(14444005)(66476007)(26005)(64756008)(66556008)(66446008)(99286004)(6506007)(386003)(107886003)(5660300002)(66066001)(6486002)(36756003)(316002)(7736002)(478600001)(6436002)(68736007)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3616;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iVbFUibR2dSy5Sz30dQ5USCzURpzf0UBMd2YQhT3Sopdf+iZHQEdofcOdhdVK0Z1atXSyooAKtBoK/12XpF+tGI0ufFak3MlROF60+Fi3Mh6AFVjrSbHGxCpIKpKPZMsvA45PlgP5wl0Uyi2BMw4S3N0h4r3u9DJ53DIrBrBO2hmV8avBuAJ3fEsArsIkkDbm90IMPOaE9IazMwsGqtN+5Te/tDFVf/XB5Mga2KH2aJk3szUYx4dqrjvJjVAOUQqaz+Ccotc/fqiy9l3OyfQ5YbKaaQJI+jQE9DYJFfiLWVC2qLXg8WvYN5irrBzXehYNsaFljnh1dJOfPEuBaHB1Y0BsvzvgZQbmU/2AXDd82u4U6dcpCSdwCag4bxdA74Rt/jd0NFHP/KNTQ3oxg8oZ6Tk+Dxj6L5ppEVzuZ/5YRI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcefe418-cda9-4d17-120c-08d719a008e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 12:25:43.8091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JManeyrol@invensense.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3616
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-05_06:2019-07-31,2019-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxlogscore=973 bulkscore=0 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908050138
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

