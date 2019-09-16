Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B060DB374B
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 11:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfIPJmD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 05:42:03 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:41048 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729474AbfIPJmD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 05:42:03 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8G9g1Sk022816;
        Mon, 16 Sep 2019 02:42:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=H/HbullFhz+KLrFmGWvTfyVKjyDp6t8npS/tLvwO3Og=;
 b=MkgGVr392SFM2/zGvk5+xbBwKo194VRqTXUhFIcO1M1H+o1g6grp/C6sWGXv3n2pCqIN
 iW369sFVF8juHTWrBYhDhcdLM19xyL+dio8pbXavyaeJ21KdNaGZRFl2EGMwWekOB8ti
 Lxw2YhcshmOqoaQ1ROO4CaojH0oo+Fppt+B2BSHljqroCTNmHTh0I/0yRPUD6o6T6319
 OyxqhbZu37UaHwpzR4fzh8nXHwHfsRpXQAopEI4vmijHLS94C9rpvDdkbEkO8WidAuSN
 81ihv3Kg9KjcExeQlPnk7CwniSUQ/aouJSJzF1o11ABnUU8EKRH0asUkj/cIRLqUmnAv 9Q== 
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2055.outbound.protection.outlook.com [104.47.34.55])
        by mx0a-00328301.pphosted.com with ESMTP id 2v0upprng8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 02:42:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeiHGUAc6+tLkmiy5NepOVCJw1T31PmyJjoZ9S0fdE7jI4CLhOYb4QmOlNTtXkF0iHcZ5hDmVJzpsL53++Qbrl44S7llu1So32+bydnTnoypNSrL+7vas7Wf43RdIe6fNTSNPNcpmkGvQImao43XdRVRrpo7pr2fpK18eA18sX8iW07b2QcJ5mwOV9f7fwE29IhfFiCVABsBTER+/Vbcox4TH4oul6VVzwujWkxauewLLm5YYoNFTPVLqS9haN0XeRwagxHwgOrgxG3pTJKdpi05G6ZOqm6xLn3pQC3Fl1KJas/a9mmrtOttDasMDwqxsXhB/rze+CSFjL6fXo53zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/HbullFhz+KLrFmGWvTfyVKjyDp6t8npS/tLvwO3Og=;
 b=h0+qOVYAnnIJdh/RWY+/D1gNpnDFVLNOwy4G1R427DbHZcqAjHq6NE5c7RFqF4QZzOPsL+5NWcebNo66EzP7W42RBj7q6pYtlBv2gmtaLbp8Q1XrUwNlNNZTFlFDm4OvZITnV6N8t+I0EHVJcgAmOmtglnFOWAq6EMiJkQ3PCroI603WijE1rzFG9xZwn/UNtRNZR0j4GBbPd03BLFII/02gqzwyqAvJVYtSfiyBByIn4cvcvRw4hc94ZDOhIJZRZfXtsAYyZcW2ZmzNNKAO2OyNv3hwCo18gENEvbTKFI/8yG3yCQugJQG0RzW3VGNy5BhdFsZEgY8P0lin7NlvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/HbullFhz+KLrFmGWvTfyVKjyDp6t8npS/tLvwO3Og=;
 b=GF0m+z9JhMai0qEtaTqBYEYB8YqOmOZjOD0OgjDswqsJX4EVCmXNDfWRFbqjf9ZzfEs5Cg7mqSAyrFtb2he/e/aWWY6qlgPuWfSz65Xjr1M4eRA2Ys1C8YMtYadpZRSzTu5GO1yQVa0ZwS5fuWxDfEWcMiS4vl9Fp6aM4Io5BFw=
Received: from BYAPR12MB3366.namprd12.prod.outlook.com (20.178.55.207) by
 BYAPR12MB2632.namprd12.prod.outlook.com (20.176.255.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Mon, 16 Sep 2019 09:42:00 +0000
Received: from BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::1c84:7948:a3:34fa]) by BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::1c84:7948:a3:34fa%3]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 09:42:00 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH v3 2/7] iio: imu: inv_mpu6050: add header include protection
 macro
Thread-Topic: [PATCH v3 2/7] iio: imu: inv_mpu6050: add header include
 protection macro
Thread-Index: AQHVbHL9jTrOY/iSTkynyKaaIs524A==
Date:   Mon, 16 Sep 2019 09:42:00 +0000
Message-ID: <20190916094128.30122-3-jmaneyrol@invensense.com>
References: <20190916094128.30122-1-jmaneyrol@invensense.com>
In-Reply-To: <20190916094128.30122-1-jmaneyrol@invensense.com>
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
x-ms-office365-filtering-correlation-id: 212dce6f-57af-4454-af1f-08d73a8a1f58
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR12MB2632;
x-ms-traffictypediagnostic: BYAPR12MB2632:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB26321F44A46860E23F938FD4C48C0@BYAPR12MB2632.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(346002)(366004)(136003)(189003)(199004)(81166006)(99286004)(3846002)(5660300002)(66066001)(2616005)(54906003)(5640700003)(316002)(6916009)(36756003)(71200400001)(6512007)(11346002)(446003)(102836004)(26005)(6486002)(6506007)(2501003)(71190400001)(386003)(4744005)(2906002)(6436002)(1076003)(305945005)(4326008)(53936002)(7736002)(186003)(6116002)(81156014)(8676002)(52116002)(107886003)(66476007)(25786009)(66446008)(76176011)(2351001)(66946007)(66556008)(8936002)(64756008)(50226002)(80792005)(256004)(14444005)(14454004)(476003)(486006)(86362001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2632;H:BYAPR12MB3366.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: n4aIPrRrW1E0xY+7NvD3W7VPnoRjcPJPnUCPDXvga4Izf56KD+1wesGbuaQFweWYtw3Gf0NlSu6EA1ymatxAYh7AS27/lWKfs24dPhHkP0vaR/szEPP8OOG5eK8+xfHuxq6fJawj5uh9M6vE/pjlATUvAKjGoBWzoknQ68te2a8+VJLQeXV+7YTAJ2b5hV3rDiJ9MZJZhgPtOppvHjwkkKvMReahovNvQpooFIYsmAITopsrXNqHIO3xk/OZ4UOsC8BKeD7sUtnwqLWepjpQjZZzB3GrAQb3izjqLTtcrFrNMdqTGVWjkifz04yEGi65IxdkqL9t5s52/fG9vdo26YzqsTIJtpcKYK5LIZZMVcdYcdXHKoqupF3KasUImtlWmCBzg3iJmGh1PbPVgOcqFNQnnHrXTx/7BdQNnpygbAc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212dce6f-57af-4454-af1f-08d73a8a1f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 09:42:00.6575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3X5i1XvGGfOJa9qAoPS6FuCggb9h8S/fQpn1fJmAjElwP1u6Zzdmek+llVJbjoWCY+Sh7itYSA7e28lEoLpu0cqKHuBid5s/LgW2h24IdtQ=
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

