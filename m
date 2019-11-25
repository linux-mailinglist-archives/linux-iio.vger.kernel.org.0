Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98A871090A4
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2019 16:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfKYPEI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Nov 2019 10:04:08 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:25552 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728071AbfKYPEH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Nov 2019 10:04:07 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAPEw0Ci029668;
        Mon, 25 Nov 2019 10:03:37 -0500
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2054.outbound.protection.outlook.com [104.47.46.54])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wf298d3u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Nov 2019 10:03:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgAh/DilbgDTv0IbJa5odwCZBa/J3rGGcRd8nP36Jc3kSf0l7zV+zPcMAz6UONeQkku6SWrhfocJtx5TfW3htOZlwZayzT09XIM/hOyEQCaQX9VM92qVZLk8d334hbDDl3+c1WE7AxHygex6J23IR8xvBWFbgAKl31KbmttqVZ/b6CBZ6+R/wl7MWmwNivXF2wQa2BPJrLyiRYOISYsIEJXguTYFxNun3mrfHwUmfox0959Fw7oQJbJ8AR5tOc4SCHEqRo0w6BVpgbzB2FVaTTLdy5EHh8u844kTJOztlyutr/pBS3LUsCrZ/fi1ZcGze6cdQFfSB/ESMH4Bp+zrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRUxM0EfOVR7wwOWF3tg/X40jdfwYJsQV87JJZUeZ1s=;
 b=g0Qslrz3ZG4ZocTEOg5BBI1c/iOjOUOHr9ThG0GvplHlO5gp7uBAzuPJGpfet0oMPfCI4AATR5iTDCI7PzXMPB573GyWTVMmmRPqKg1W+iqMVYG3w5tbyxGI5wl20fRr7YlBipxjc/XaFxqiVIPtboBVhlAiLHWH9AxXkJ0Z4gRO4voFU6FrW71/wIwgOtAaDObg9givXpwiD+jBML49dkho0iQgrEyP2DPAfq4OxfLdFQmHxWgSsXjqzpwZNmW7M5RLMEClnzrf29ogGIrpVwR2Km8nLZfiPbrntrncOCGn7wN9aH+qlSCeQ85sID1k63EDuw1Dq/cvEvAQiNhqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRUxM0EfOVR7wwOWF3tg/X40jdfwYJsQV87JJZUeZ1s=;
 b=kt/z7857SRsue0bCYOPm7KqsJ+aIYA+obLY67LsAhko4HrwP75yF3WhW75MmFPQMZefSmRrzGMD+Br6OfD2jv3tRBPqq6Ab9qRMQ9tCUHsEBdIE7Ws+kXmUBzHeDSDfuTNb8K6OEfZM6PgyfS7B4pL5x6for5iJljLfzLMlgj1A=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5238.namprd03.prod.outlook.com (20.180.4.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Mon, 25 Nov 2019 15:03:31 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 15:03:31 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: at91-sama5d2_adc: fix
 iio_triggered_buffer_{predisable,postenable} positions
Thread-Topic: [PATCH] iio: at91-sama5d2_adc: fix
 iio_triggered_buffer_{predisable,postenable} positions
Thread-Index: AQHViXtdnDhd99DyyUetPzMU9xg88KecMFeA
Date:   Mon, 25 Nov 2019 15:03:31 +0000
Message-ID: <17cf55869cc418795d0013c0594ed8fc04381d46.camel@analog.com>
References: <20191023082508.17583-1-alexandru.ardelean@analog.com>
In-Reply-To: <20191023082508.17583-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 774486ee-758c-4ad5-bc9e-08d771b8a294
x-ms-traffictypediagnostic: CH2PR03MB5238:
x-microsoft-antispam-prvs: <CH2PR03MB52380369555275BC5F1AA914F94A0@CH2PR03MB5238.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(136003)(346002)(199004)(189003)(66066001)(4001150100001)(118296001)(8936002)(256004)(5024004)(99286004)(2501003)(6246003)(76176011)(81156014)(81166006)(8676002)(14444005)(186003)(71190400001)(71200400001)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(5660300002)(2616005)(11346002)(446003)(6486002)(6436002)(229853002)(7736002)(305945005)(2201001)(6512007)(86362001)(7416002)(4326008)(6116002)(3846002)(2906002)(36756003)(25786009)(14454004)(478600001)(54906003)(26005)(316002)(110136005)(6506007)(102836004)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5238;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: prOIt+dwUt58s7NC3h82yHRy9sjV3ZpU1R+oq2taOnKTyZfLxTvAnh/4zVxTZ9BN3COa7KKe3O7ziBs03XrZcmhdsKZf1pk9KfiZ2rhno+42V7Mb6bysMopDIjKp6ECece2gk4wSjS9mMNPT9h3Mqwji0nUCDtJUHTmWej0zR/X6Xvea4TS+b0YisBNBjWPKkbmiz0BVQw5Z9MOHvAS8niF63+1KllXH6Ziuhq8NEl4VTx8w9DET8Z1zdi9o5Jq25jZqQ8vvwJgdj7REcIQ20YTnGVYqEXoS8UkeXuZIGIayojHJAdrUFijmoDnxb8dWu+Z4KSEjnu9L+5YfnsRTrwEMhJh56LKOsAziTzDch9ZJYHiaN0CF+mibodih5l94/oqagCNPPX2BnJs3i05xkrmEs5QVq4/N4sTgNy313OZ+SHVi6WkEKXoX24mOtv+i
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA1921FE4FB9EC479299DF4E227B7227@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 774486ee-758c-4ad5-bc9e-08d771b8a294
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 15:03:31.0637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PoeNlQ5RqwAk/x3dq860wWJusZXggq8uD+I13Fibjl/dTwl93QRPfIoXwhVDQz/U4iidIUeTe9OhKyeocy4EYdj0yBYWLdY/VbV3OldlRU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5238
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_03:2019-11-21,2019-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911250136
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTIzIGF0IDExOjI1ICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IFRoZSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl97cHJlZGlzYWJsZSxwb3N0ZW5hYmxlfSBm
dW5jdGlvbnMgYXR0YWNoL2RldGFjaA0KPiBwb2xsIGZ1bmN0aW9ucy4NCj4gDQo+IFRoZSBpaW9f
dHJpZ2dlcmVkX2J1ZmZlcl9wb3N0ZW5hYmxlKCkgc2hvdWxkIGJlIGNhbGxlZCBmaXJzdCB0byBh
dHRhY2gNCj4gdGhlDQo+IHBvbGwgZnVuY3Rpb24sIGFuZCB0aGVuIHRoZSBkcml2ZXIgY2FuIGlu
aXQgdGhlIGRhdGEgdG8gYmUgdHJpZ2dlcmVkLg0KPiANCj4gU2ltaWxhcmx5LCBpaW9fdHJpZ2dl
cmVkX2J1ZmZlcl9wcmVkaXNhYmxlKCkgc2hvdWxkIGJlIGNhbGxlZCBsYXN0IHRvDQo+IGZpcnN0
DQo+IGRpc2FibGUgdGhlIGRhdGEgKHRvIGJlIHRyaWdnZXJlZCkgYW5kIHRoZW4gdGhlIHBvbGwg
ZnVuY3Rpb24gc2hvdWxkIGJlDQo+IGRldGFjaGVkLg0KPiANCj4gRm9yIHRoaXMgZHJpdmVyLCB0
aGUgcHJlZGlzYWJsZSAmIHBvc3RlbmFibGUgaG9va3MgYXJlIGFsc28gbmVlZCB0byB0YWtlDQo+
IGludG8gY29uc2lkZXJhdGlvbiB0aGUgdG91Y2hzY3JlZW4sIHNvIHRoZSBob29rcyBuZWVkIHRv
IGJlIHB1dCBpbiBwbGFjZXMNCj4gdGhhdCBhdm9pZCB0aGUgY29kZSBmb3IgdGhhdCBjYXJlcyBh
Ym91dCBpdC4NCj4gDQoNCnBpbmcgaGVyZQ0KDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBB
cmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYyB8IDE5ICsrKysrKysrKystLS0tLS0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMgYi9kcml2ZXJz
L2lpby9hZGMvYXQ5MS0NCj4gc2FtYTVkMl9hZGMuYw0KPiBpbmRleCBlMTg1MGYzZDVjZjMuLmFj
M2U1YzRjOTg0MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9h
ZGMuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jDQo+IEBAIC04
ODksMjAgKzg4OSwyNCBAQCBzdGF0aWMgaW50IGF0OTFfYWRjX2J1ZmZlcl9wb3N0ZW5hYmxlKHN0
cnVjdA0KPiBpaW9fZGV2ICppbmRpb19kZXYpDQo+ICAJaWYgKCEoaW5kaW9fZGV2LT5jdXJyZW50
bW9kZSAmIElORElPX0FMTF9UUklHR0VSRURfTU9ERVMpKQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gIA0KPiArCXJldCA9IGlpb190cmlnZ2VyZWRfYnVmZmVyX3Bvc3RlbmFibGUoaW5kaW9fZGV2
KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICAJLyogd2UgY29udGlu
dWUgd2l0aCB0aGUgdHJpZ2dlcmVkIGJ1ZmZlciAqLw0KPiAgCXJldCA9IGF0OTFfYWRjX2RtYV9z
dGFydChpbmRpb19kZXYpOw0KPiAgCWlmIChyZXQpIHsNCj4gIAkJZGV2X2VycigmaW5kaW9fZGV2
LT5kZXYsICJidWZmZXIgcG9zdGVuYWJsZSBmYWlsZWRcbiIpOw0KPiArCQlpaW9fdHJpZ2dlcmVk
X2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlvX2Rldik7DQo+ICAJCXJldHVybiByZXQ7DQo+ICAJfQ0K
PiAgDQo+IC0JcmV0dXJuIGlpb190cmlnZ2VyZWRfYnVmZmVyX3Bvc3RlbmFibGUoaW5kaW9fZGV2
KTsNCj4gKwlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGludCBhdDkxX2FkY19idWZm
ZXJfcHJlZGlzYWJsZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiAgew0KPiAgCXN0cnVj
dCBhdDkxX2FkY19zdGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiAtCWludCByZXQ7
DQo+ICAJdTggYml0Ow0KPiAgDQo+ICAJLyogY2hlY2sgaWYgd2UgYXJlIGRpc2FibGluZyB0cmln
Z2VyZWQgYnVmZmVyIG9yIHRoZSB0b3VjaHNjcmVlbiAqLw0KPiBAQCAtOTE2LDEzICs5MjAsOCBA
QCBzdGF0aWMgaW50IGF0OTFfYWRjX2J1ZmZlcl9wcmVkaXNhYmxlKHN0cnVjdCBpaW9fZGV2DQo+
ICppbmRpb19kZXYpDQo+ICAJaWYgKCEoaW5kaW9fZGV2LT5jdXJyZW50bW9kZSAmIElORElPX0FM
TF9UUklHR0VSRURfTU9ERVMpKQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gIA0KPiAtCS8qIGNv
bnRpbnVlIHdpdGggdGhlIHRyaWdnZXJlZCBidWZmZXIgKi8NCj4gLQlyZXQgPSBpaW9fdHJpZ2dl
cmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlvX2Rldik7DQo+IC0JaWYgKHJldCA8IDApDQo+IC0J
CWRldl9lcnIoJmluZGlvX2Rldi0+ZGV2LCAiYnVmZmVyIHByZWRpc2FibGUgZmFpbGVkXG4iKTsN
Cj4gLQ0KPiAgCWlmICghc3QtPmRtYV9zdC5kbWFfY2hhbikNCj4gLQkJcmV0dXJuIHJldDsNCj4g
KwkJZ290byBvdXQ7DQo+ICANCj4gIAkvKiBpZiB3ZSBhcmUgdXNpbmcgRE1BIHdlIG11c3QgY2xl
YXIgcmVnaXN0ZXJzIGFuZCBlbmQgRE1BICovDQo+ICAJZG1hZW5naW5lX3Rlcm1pbmF0ZV9zeW5j
KHN0LT5kbWFfc3QuZG1hX2NoYW4pOw0KPiBAQCAtOTQ5LDcgKzk0OCw5IEBAIHN0YXRpYyBpbnQg
YXQ5MV9hZGNfYnVmZmVyX3ByZWRpc2FibGUoc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldikN
Cj4gIA0KPiAgCS8qIHJlYWQgb3ZlcmZsb3cgcmVnaXN0ZXIgdG8gY2xlYXIgcG9zc2libGUgb3Zl
cmZsb3cgc3RhdHVzICovDQo+ICAJYXQ5MV9hZGNfcmVhZGwoc3QsIEFUOTFfU0FNQTVEMl9PVkVS
KTsNCj4gLQlyZXR1cm4gcmV0Ow0KPiArDQo+ICtvdXQ6DQo+ICsJcmV0dXJuIGlpb190cmlnZ2Vy
ZWRfYnVmZmVyX3ByZWRpc2FibGUoaW5kaW9fZGV2KTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBpaW9fYnVmZmVyX3NldHVwX29wcyBhdDkxX2J1ZmZlcl9zZXR1cF9vcHMgPSB7
DQo=
