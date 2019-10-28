Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F27A7E6CBC
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2019 08:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfJ1HL6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Oct 2019 03:11:58 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:7278 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbfJ1HL5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Oct 2019 03:11:57 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9S78BNJ012869;
        Mon, 28 Oct 2019 03:11:54 -0400
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2059.outbound.protection.outlook.com [104.47.34.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vvjs63huw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 28 Oct 2019 03:11:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcRP98jNZcq2kU7FabGhzygyZXIVlP74GrruZwMJ47GHgQOOgm1ARG/zU8F9ffaBPPiVrK5elAD5+mXpJ5Tbb4v5OM0y/ycC2/Znojn8znX0KUQHFQePrv7ee8q0wJIbw0XcSEhgq8w9GDfn1srSL3prZUPcC8ZF98CFhys/zreIeob/rbIfT/5NcSsdXToZO+B1v1qZ4hexMmWzsru7xdHpBIDN04OVM8DTgBM6CG7LPCEoRHidSF3K1nEaLtdo7k3M5UF2oE+yy1PcgYMH2bZh6lYgJ5KyRRuOWjs87DNKVBElyqlCWXqBhL4aZEUVu57x7GvElx1HOXojMYZzpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OODunbp52pRpeb5hpsUWU12UNBYKPlOat9iQH40O6rQ=;
 b=Ix6f9LpRSAd/1yNUX5lT2n+cWpHNBKY5pD+lQfwYemJCAhEcYAts2lOl8oM6DgEDHZi5I7nwSc36Hre7J93lZYbF+wHXp2zwjYPD+d8pVlpC0QHemybZKmRKBesMKj7Klk8pf7tYvATgcGsBwThSHHb/ZciyINIJ/rigGOI+hZ1c1LrQHr87JUyRzbOkafPDk3JS2DeeAqULf60aCEYOO9JsUtTS1RzWfkrCjBgNWIyS1BYNX/zb0+mkMKt66G1Jq8b1hcebVPAxf90f/sTHjOQEgTba6kKNRNNoGQ0UiqDjFlfWvoqbCEvXP0dt5uw9zk+Vutui0O2X5dDwaAkGBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OODunbp52pRpeb5hpsUWU12UNBYKPlOat9iQH40O6rQ=;
 b=XM5AatMWb/4+kz9sD9ZbemN742T80xLEbmAIgLt2c9ZbgzJY33eV6rnngpIuaI+V8prViPQoWQACE+forWTilxtrImB7iP5apfyFUJIZ5zRRLRnSO+UUUaQRJCDtZptOKQqbxyPjhkMWRzV4mhm8hCfrI4GiIhA2nECCbUE9nyQ=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5301.namprd03.prod.outlook.com (20.180.15.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Mon, 28 Oct 2019 07:11:52 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 07:11:52 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "matt.ranostay@konsulko.com" <matt.ranostay@konsulko.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: hdc100x: fix
 iio_triggered_buffer_{predisable,postenable} positions
Thread-Topic: [PATCH] iio: hdc100x: fix
 iio_triggered_buffer_{predisable,postenable} positions
Thread-Index: AQHViXuhHdwgzF5oQkm7mTEnWOLlyKduvHiAgAAbz4CAANLZAA==
Date:   Mon, 28 Oct 2019 07:11:51 +0000
Message-ID: <46d418bd0546c98e22a0d331741c053274c2170f.camel@analog.com>
References: <20191023082714.18681-1-alexandru.ardelean@analog.com>
         <20191027165813.5a5b0519@archlinux>
         <CAJCx=gnCaqKHuZkRoCyHXR4ewwmqFCsRTiUty=CH0KB8PS+YCQ@mail.gmail.com>
In-Reply-To: <CAJCx=gnCaqKHuZkRoCyHXR4ewwmqFCsRTiUty=CH0KB8PS+YCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87e3184d-a33d-4c9c-9d2c-08d75b761b6b
x-ms-traffictypediagnostic: CH2PR03MB5301:
x-microsoft-antispam-prvs: <CH2PR03MB530165548E5783B75B82C495F9660@CH2PR03MB5301.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(366004)(39860400002)(199004)(189003)(6436002)(64756008)(66556008)(66446008)(8676002)(66476007)(36756003)(476003)(486006)(118296001)(25786009)(86362001)(26005)(2501003)(81166006)(14454004)(5660300002)(81156014)(6486002)(229853002)(7736002)(91956017)(66946007)(76116006)(305945005)(6512007)(8936002)(446003)(11346002)(2616005)(99286004)(186003)(71190400001)(102836004)(66066001)(14444005)(5024004)(71200400001)(256004)(4001150100001)(3846002)(54906003)(110136005)(478600001)(316002)(6116002)(4326008)(2906002)(53546011)(6506007)(6246003)(76176011)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5301;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RtRvQMd3Cgl/OG/M2YsQOzJ9O2e7OVg/3KWUGrPHReyPIb0ZuZuUXMpY1n/06dQr0acDnOLnYL+y6U61UV+ID9nhyjZex5ZO6aJchqsMrDkRGWKe9Al/maosdecT1rECb005R4y0EsD/kwfCK8VCx66weTayG997SkXG7sFVqutbuwL4w4JJKG854TT3n1qaXaZZ6yq90hPxRuRogzqTJqSc98TPz3Tan+v/QVBp1FzCe5wOl+LwORrq38QP3zl1YUGDtbtfTuQgrRfOe22mqk6BAOBAf/kQ1q3pFo2m6LWC89k1P9qvkszGjWftfRtD/ab446kGI2F3Mq2uZcEtFUtgutcJKu2Op923wCUopB8ZClgH81NnsXb8ImWRJp7Y5iL25ijBjs9XgJlH3yAsMaD01Tt56/tXzd2Xd3pYEAcKD53eRsaZP7wMrAQbjDNx
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7F28B73EFDDAC44AC3121C397593DC5@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e3184d-a33d-4c9c-9d2c-08d75b761b6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 07:11:51.8947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ih6T175kTg3QZcB84TJl0HITlIL4VOStRmGNk3VwBehb3ak1ywZIbzUtOuonV9jYxoY3+dsaOCfnsLucPv/MDxwx97IOq8yl9hIipaaY8TY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5301
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-28_03:2019-10-25,2019-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910280071
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEwLTI3IGF0IDIwOjM3ICswMjAwLCBNYXR0IFJhbm9zdGF5IHdyb3RlOg0K
PiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBTdW4sIE9jdCAyNywgMjAxOSBhdCA2OjU4IFBNIEpvbmF0
aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+IHdyb3RlOg0KPiA+IE9uIFdlZCwgMjMg
T2N0IDIwMTkgMTE6Mjc6MTQgKzAzMDANCj4gPiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRy
dS5hcmRlbGVhbkBhbmFsb2cuY29tPiB3cm90ZToNCj4gPiANCj4gPiA+IFRoZSBpaW9fdHJpZ2dl
cmVkX2J1ZmZlcl9wb3N0ZW5hYmxlKCkgaG9vayBzaG91bGQgYmUgY2FsbGVkIGZpcnN0IHRvDQo+
ID4gPiBhdHRhY2ggdGhlIHBvbGwgZnVuY3Rpb24gYW5kIHRoZSBpaW9fdHJpZ2dlcmVkX2J1ZmZl
cl9wcmVkaXNhYmxlKCkNCj4gPiA+IGhvb2sNCj4gPiA+IHNob3VsZCBiZSBjYWxsZWQgbGFzdCBp
biB0aGUgcHJlZGlzYWJsZSBob29rLg0KPiA+ID4gDQo+ID4gPiBUaGlzIGNoYW5nZSB1cGRhdGVz
IHRoZSBkcml2ZXIgdG8gYXR0YWNoL2RldGFjaCB0aGUgcG9sbCBmdW5jIGluIHRoZQ0KPiA+ID4g
Y29ycmVjdCBvcmRlci4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFy
ZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gPiBTZWVtcyBmaW5lLCBi
dXQgc2hvdWxkIGhhdmUgY2MnZCBNYXR0IGFuZCBJJ2QgbGlrZSB0byBnaXZlIGhpbSB0aW1lDQo+
ID4gdG8gdGFrZSBhIHF1aWNrIGxvb2suDQo+ID4gDQo+IA0KPiBSZXZpZXdlZC1ieTogTWF0dCBS
YW5vc3RheSA8bWF0dC5yYW5vc3RheUBrb25zdWxrby5jb20+DQoNCkFwb2xvZ2llcyBmb3Igbm90
IENDLWluZyBNYXR0Lg0KSSBndWVzcyBJIHdhc24ndCBwYXlpbmcgW2Nsb3NlIGVub3VnaF0gYXR0
ZW50aW9uIHRvIHRoZSBvdXRwdXQgb2YNCmdldF9tYWludGFpbmVycy5wbA0KDQpUaGFua3MNCkFs
ZXgNCg0KPiANCj4gPiArQ0MgTWF0dC4NCj4gPiANCj4gPiBUaGFua3MsDQo+ID4gDQo+ID4gSm9u
YXRoYW4NCj4gPiANCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvaWlvL2h1bWlkaXR5L2hkYzEw
MHguYyB8IDE5ICsrKysrKysrKysrLS0tLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTEg
aW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaWlvL2h1bWlkaXR5L2hkYzEwMHguYw0KPiA+ID4gYi9kcml2ZXJzL2lpby9odW1p
ZGl0eS9oZGMxMDB4LmMNCj4gPiA+IGluZGV4IGJmZTFjZGIxNjg0Ni4uOTYzZmYwNDNlZWNmIDEw
MDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9paW8vaHVtaWRpdHkvaGRjMTAweC5jDQo+ID4gPiAr
KysgYi9kcml2ZXJzL2lpby9odW1pZGl0eS9oZGMxMDB4LmMNCj4gPiA+IEBAIC0yNzgsMzEgKzI3
OCwzNCBAQCBzdGF0aWMgaW50IGhkYzEwMHhfYnVmZmVyX3Bvc3RlbmFibGUoc3RydWN0DQo+ID4g
PiBpaW9fZGV2ICppbmRpb19kZXYpDQo+ID4gPiAgICAgICBzdHJ1Y3QgaGRjMTAweF9kYXRhICpk
YXRhID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gPiA+ICAgICAgIGludCByZXQ7DQo+ID4gPiAN
Cj4gPiA+ICsgICAgIHJldCA9IGlpb190cmlnZ2VyZWRfYnVmZmVyX3Bvc3RlbmFibGUoaW5kaW9f
ZGV2KTsNCj4gPiA+ICsgICAgIGlmIChyZXQpDQo+ID4gPiArICAgICAgICAgICAgIHJldHVybiBy
ZXQ7DQo+ID4gPiArDQo+ID4gPiAgICAgICAvKiBCdWZmZXIgaXMgZW5hYmxlZC4gRmlyc3Qgc2V0
IEFDUSBNb2RlLCB0aGVuIGF0dGFjaCBwb2xsIGZ1bmMNCj4gPiA+ICovDQo+ID4gPiAgICAgICBt
dXRleF9sb2NrKCZkYXRhLT5sb2NrKTsNCj4gPiA+ICAgICAgIHJldCA9IGhkYzEwMHhfdXBkYXRl
X2NvbmZpZyhkYXRhLCBIREMxMDBYX1JFR19DT05GSUdfQUNRX01PREUsDQo+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgSERDMTAwWF9SRUdfQ09ORklHX0FDUV9NT0RFKTsN
Cj4gPiA+ICAgICAgIG11dGV4X3VubG9jaygmZGF0YS0+bG9jayk7DQo+ID4gPiAgICAgICBpZiAo
cmV0KQ0KPiA+ID4gLSAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gKyAgICAgICAgICAg
ICBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlvX2Rldik7DQo+ID4gPiANCj4g
PiA+IC0gICAgIHJldHVybiBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wb3N0ZW5hYmxlKGluZGlvX2Rl
dik7DQo+ID4gPiArICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gIH0NCj4gPiA+IA0KPiA+ID4gIHN0
YXRpYyBpbnQgaGRjMTAweF9idWZmZXJfcHJlZGlzYWJsZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9f
ZGV2KQ0KPiA+ID4gIHsNCj4gPiA+ICAgICAgIHN0cnVjdCBoZGMxMDB4X2RhdGEgKmRhdGEgPSBp
aW9fcHJpdihpbmRpb19kZXYpOw0KPiA+ID4gLSAgICAgaW50IHJldDsNCj4gPiA+IC0NCj4gPiA+
IC0gICAgIC8qIEZpcnN0IGRldGFjaCBwb2xsIGZ1bmMsIHRoZW4gcmVzZXQgQUNRIG1vZGUuIE9L
IHRvIGRpc2FibGUNCj4gPiA+IGJ1ZmZlciAqLw0KPiA+ID4gLSAgICAgcmV0ID0gaWlvX3RyaWdn
ZXJlZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0KPiA+ID4gLSAgICAgaWYgKHJldCkN
Cj4gPiA+IC0gICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiA+ICsgICAgIGludCByZXQsIHJl
dDI7DQo+ID4gPiANCj4gPiA+ICAgICAgIG11dGV4X2xvY2soJmRhdGEtPmxvY2spOw0KPiA+ID4g
ICAgICAgcmV0ID0gaGRjMTAweF91cGRhdGVfY29uZmlnKGRhdGEsIEhEQzEwMFhfUkVHX0NPTkZJ
R19BQ1FfTU9ERSwNCj4gPiA+IDApOw0KPiA+ID4gICAgICAgbXV0ZXhfdW5sb2NrKCZkYXRhLT5s
b2NrKTsNCj4gPiA+IA0KPiA+ID4gKyAgICAgcmV0MiA9IGlpb190cmlnZ2VyZWRfYnVmZmVyX3By
ZWRpc2FibGUoaW5kaW9fZGV2KTsNCj4gPiA+ICsgICAgIGlmIChyZXQgPT0gMCkNCj4gPiA+ICsg
ICAgICAgICAgICAgcmV0ID0gcmV0MjsNCj4gPiA+ICsNCj4gPiA+ICAgICAgIHJldHVybiByZXQ7
DQo+ID4gPiAgfQ0KPiA+ID4gDQo=
