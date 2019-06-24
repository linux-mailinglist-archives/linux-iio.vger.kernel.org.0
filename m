Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E72850F9E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2019 17:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfFXPEf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jun 2019 11:04:35 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:17832 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725562AbfFXPEf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jun 2019 11:04:35 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jun 2019 11:04:34 EDT
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x5OEsiOw003550
        for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2019 07:57:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt1; bh=UudMbOdFO9OfdL7nSAPs0CH9Xw+Pxoj4VnOUuEJRr0A=;
 b=BHa5Y9vrXnST9ooNgIlJ+39eUOxbJW/k+yZ41WFFjBZ4v1kb3dwISFvUt4NFAT/g8oGs
 v6qX6/3BDk+Pat/u5uX5xMkZQUZQPpLWYfBeudM/W5EtNEsablj2wBwkENwtmzCsDYIv
 2PfynTRd0ETaC7QPgb7klRF2KRI9oF+kr1KKcQ+BMdV8vkjN55g97bkV7x39fWJlhgxe
 r+7bBa1IEpciUrX34GYHNzbNWok3gBdQSquh+KUhAaVJwaA3KuQFlN9oYlfJJkAOTABA
 epviluismpJhqBouFNcSj/f2mtaa577/szp7hibnXHrAdyogISd/Cmx3PE1usOw52qfD xw== 
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2052.outbound.protection.outlook.com [104.47.40.52])
        by mx0a-00328301.pphosted.com with ESMTP id 2tabwkrggx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2019 07:57:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector1-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UudMbOdFO9OfdL7nSAPs0CH9Xw+Pxoj4VnOUuEJRr0A=;
 b=Mcntt7om5/COn5FJUDW0jwN21HXDbA6nGy5KRuqY4+n+1Z9g6YGEM7w5xRw6n9nuPw/uhbhQopF6UNOrxiP99XTSqcMg4X3sduj+xOB2h3MJw8xkQ0axlED0lsw26eXSfbBB/mVgRh35NvfCIdXfGYVWhgJWwyv1zAgZbpdhY14=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3679.namprd12.prod.outlook.com (10.255.86.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 14:57:25 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::f5e0:d455:c8e0:4c13]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::f5e0:d455:c8e0:4c13%5]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 14:57:24 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH] iio: imu: mpu6050: add available scan masks
Thread-Topic: [PATCH] iio: imu: mpu6050: add available scan masks
Thread-Index: AQHVKp0iTnMyK6ou20uFDeztak7OlQ==
Date:   Mon, 24 Jun 2019 14:57:24 +0000
Message-ID: <20190624145651.24320-1-jmaneyrol@invensense.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6P18901CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:4:16::16) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
x-originating-ip: [77.157.193.39]
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e6d5b89-3ea0-4d02-a184-08d6f8b44455
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB3679;
x-ms-traffictypediagnostic: MN2PR12MB3679:
x-microsoft-antispam-prvs: <MN2PR12MB36797DBA91586812C00F57F2C4E00@MN2PR12MB3679.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39850400004)(376002)(366004)(136003)(189003)(199004)(80792005)(72206003)(107886003)(2906002)(2616005)(1076003)(486006)(14454004)(66066001)(6916009)(50226002)(25786009)(2501003)(8936002)(8676002)(81156014)(66946007)(66476007)(66556008)(64756008)(66446008)(73956011)(86362001)(478600001)(305945005)(316002)(68736007)(476003)(4326008)(7736002)(99286004)(52116002)(36756003)(386003)(6506007)(6116002)(81166006)(3846002)(5660300002)(2351001)(102836004)(53936002)(6436002)(5640700003)(6486002)(71200400001)(186003)(256004)(71190400001)(26005)(6512007)(131093003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3679;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 36MRp3oMhS57/YpJHTlGsJsI+osdMjw10Lrisn6I++g9MhmePD0LOIB7RrM1zY+FF4HFOOz20TIOFpPmpWzvYVbdJpFE2kRNKOXN9j7TEfjLsJlGRFxdMSN/LApC/1DaeNDwlR2bsdlXNlmuQdBdMKMQ5ukLBSabNYWHrZ7VuWQau6hJuknam4IbZhnCO64p3xGkUoim28jzC6Z4wPAJDd5X3/6h236w1/Gj5EoPH+EClqSkrCTPu8q7ZTDdFWwEABrkAINQh/ygoairv1yZY7ndfid74rALTDFaf97FHzQ9sXOJe/3JJXQcRXZYchgLtmhuVUcYcKwp3cUB8XPoPnZ5jetNKSojEavTXhga8mJdB8Kl8/Ix2cbQnPqzpQylKdZMVF46fsDi/6imp5S73hJXbKXju1DLMXStC/iQSmg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6d5b89-3ea0-4d02-a184-08d6f8b44455
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 14:57:24.8225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JManeyrol@invensense.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-06-24_10:2019-06-24,2019-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1904300001 definitions=main-1906240121
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T25seSBhbGxvdyAzLWF4aXMgZ3lybyBhbmQvb3IgMy1heGlzIGFjY2VsLg0KRm9yIGljbTIwNjAy
LCB0ZW1wIGRhdGEgaXMgbWFuZGF0b3J5IGZvciBhbGwgY29uZi4NCg0KU2lnbmVkLW9mZi1ieTog
SmVhbi1CYXB0aXN0ZSBNYW5leXJvbCA8am1hbmV5cm9sQGludmVuc2Vuc2UuY29tPg0KLS0tDQog
ZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfY29yZS5jIHwgMTYgKysrKysrKysr
KysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2lpby9pbXUvaW52X21wdTYwNTAvaW52X21wdV9jb3JlLmMgYi9kcml2ZXJzL2lp
by9pbXUvaW52X21wdTYwNTAvaW52X21wdV9jb3JlLmMNCmluZGV4IDM4NWYxNGE0ZDVhNy4uYmZk
NmQwOTNlNTRkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9t
cHVfY29yZS5jDQorKysgYi9kcml2ZXJzL2lpby9pbXUvaW52X21wdTYwNTAvaW52X21wdV9jb3Jl
LmMNCkBAIC04NTEsNiArODUxLDEzIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3Bl
YyBpbnZfbXB1X2NoYW5uZWxzW10gPSB7DQogCUlOVl9NUFU2MDUwX0NIQU4oSUlPX0FDQ0VMLCBJ
SU9fTU9EX1osIElOVl9NUFU2MDUwX1NDQU5fQUNDTF9aKSwNCiB9Ow0KIA0KK3N0YXRpYyBjb25z
dCB1bnNpZ25lZCBsb25nIGludl9tcHVfc2Nhbl9tYXNrc1tdID0gew0KKwkweDA3LAkvKiAzLWF4
aXMgYWNjZWwgKi8NCisJMHgzOCwJLyogMy1heGlzIGd5cm8gKi8NCisJMHgzRiwJLyogNi1heGlz
IGFjY2VsICsgZ3lybyAqLw0KKwkwLA0KK307DQorDQogc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9f
Y2hhbl9zcGVjIGludl9pY20yMDYwMl9jaGFubmVsc1tdID0gew0KIAlJSU9fQ0hBTl9TT0ZUX1RJ
TUVTVEFNUChJTlZfSUNNMjA2MDJfU0NBTl9USU1FU1RBTVApLA0KIAl7DQpAQCAtODc3LDYgKzg4
NCwxMyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMgaW52X2ljbTIwNjAyX2No
YW5uZWxzW10gPSB7DQogCUlOVl9NUFU2MDUwX0NIQU4oSUlPX0FDQ0VMLCBJSU9fTU9EX1osIElO
Vl9JQ00yMDYwMl9TQ0FOX0FDQ0xfWiksDQogfTsNCiANCitzdGF0aWMgY29uc3QgdW5zaWduZWQg
bG9uZyBpbnZfaWNtMjA2MDJfc2Nhbl9tYXNrc1tdID0gew0KKwkweDBGLAkvKiAzLWF4aXMgYWNj
ZWwgKyB0ZW1wIChtYW5kYXRvcnkpICovDQorCTB4NzgsCS8qIDMtYXhpcyBneXJvICsgdGVtcCAo
bWFuZGF0b3J5KSAqLw0KKwkweDdGLAkvKiA2LWF4aXMgYWNjZWwgKyBneXJvICsgdGVtcCAobWFu
ZGF0b3J5KSAqLw0KKwkwLA0KK307DQorDQogLyoNCiAgKiBUaGUgdXNlciBjYW4gY2hvb3NlIGFu
eSBmcmVxdWVuY3kgYmV0d2VlbiBJTlZfTVBVNjA1MF9NSU5fRklGT19SQVRFIGFuZA0KICAqIElO
Vl9NUFU2MDUwX01BWF9GSUZPX1JBVEUsIGJ1dCBvbmx5IHRoZXNlIGZyZXF1ZW5jaWVzIGFyZSBt
YXRjaGVkIGJ5IHRoZQ0KQEAgLTExMzYsOSArMTE1MCwxMSBAQCBpbnQgaW52X21wdV9jb3JlX3By
b2JlKHN0cnVjdCByZWdtYXAgKnJlZ21hcCwgaW50IGlycSwgY29uc3QgY2hhciAqbmFtZSwNCiAJ
aWYgKGNoaXBfdHlwZSA9PSBJTlZfSUNNMjA2MDIpIHsNCiAJCWluZGlvX2Rldi0+Y2hhbm5lbHMg
PSBpbnZfaWNtMjA2MDJfY2hhbm5lbHM7DQogCQlpbmRpb19kZXYtPm51bV9jaGFubmVscyA9IEFS
UkFZX1NJWkUoaW52X2ljbTIwNjAyX2NoYW5uZWxzKTsNCisJCWluZGlvX2Rldi0+YXZhaWxhYmxl
X3NjYW5fbWFza3MgPSBpbnZfaWNtMjA2MDJfc2Nhbl9tYXNrczsNCiAJfSBlbHNlIHsNCiAJCWlu
ZGlvX2Rldi0+Y2hhbm5lbHMgPSBpbnZfbXB1X2NoYW5uZWxzOw0KIAkJaW5kaW9fZGV2LT5udW1f
Y2hhbm5lbHMgPSBBUlJBWV9TSVpFKGludl9tcHVfY2hhbm5lbHMpOw0KKwkJaW5kaW9fZGV2LT5h
dmFpbGFibGVfc2Nhbl9tYXNrcyA9IGludl9tcHVfc2Nhbl9tYXNrczsNCiAJfQ0KIA0KIAlpbmRp
b19kZXYtPmluZm8gPSAmbXB1X2luZm87DQotLSANCjIuMTcuMQ0KDQo=
