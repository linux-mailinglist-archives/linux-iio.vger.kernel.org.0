Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3733C9AC
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2019 13:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388627AbfFKLEo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jun 2019 07:04:44 -0400
Received: from mail-eopbgr60127.outbound.protection.outlook.com ([40.107.6.127]:34261
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387899AbfFKLEo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Jun 2019 07:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qhrRaT56Rif+NJitpEl5W4KKdsQBXVyEfe/v4UMDGo=;
 b=hBl4AEV6QAhG/jupo1a81DKqdLgG3K7FP/eDSGHdatp+B6nUHb5dMFTyFXUmNbgNPPxxQc2ZwILuOTTjkg+gw/xWP04BF3+C/Gk1tCT4kcs8FfKns2+AuI01mX8VOIskBB+sO07iEJokSmYt+YnrnSjgyQLLtQC/bheMeWh3n0s=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3339.eurprd02.prod.outlook.com (52.134.71.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Tue, 11 Jun 2019 11:03:59 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf%5]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 11:03:59 +0000
From:   Peter Rosin <peda@axentia.se>
To:     =?utf-8?B?TXlsw6huZSBKb3NzZXJhbmQ=?= <mylene.josserand@bootlin.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v1 1/3] iio: afe: rescale: Move scale conversion to new
 function
Thread-Topic: [PATCH v1 1/3] iio: afe: rescale: Move scale conversion to new
 function
Thread-Index: AQHVIDwSq4viEEcKgka2YzIWUh6s7qaWSkCA
Date:   Tue, 11 Jun 2019 11:03:59 +0000
Message-ID: <11999b2d-b99f-a34c-d1d8-fcf58a5de3fc@axentia.se>
References: <20190611095659.29845-1-mylene.josserand@bootlin.com>
 <20190611095659.29845-2-mylene.josserand@bootlin.com>
In-Reply-To: <20190611095659.29845-2-mylene.josserand@bootlin.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::14)
 To DB3PR0202MB3434.eurprd02.prod.outlook.com (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29ce86c8-f548-4474-beec-08d6ee5c8170
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3339;
x-ms-traffictypediagnostic: DB3PR0202MB3339:
x-microsoft-antispam-prvs: <DB3PR0202MB3339986B7CB105C78F1A4011BCED0@DB3PR0202MB3339.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39830400003)(346002)(376002)(189003)(199004)(3846002)(4326008)(52116002)(76176011)(99286004)(508600001)(6116002)(53936002)(6246003)(36756003)(86362001)(31696002)(256004)(2201001)(71200400001)(71190400001)(5660300002)(316002)(8936002)(8676002)(65956001)(53546011)(64126003)(2616005)(68736007)(65806001)(66066001)(186003)(14454004)(25786009)(65826007)(7736002)(81156014)(81166006)(11346002)(26005)(64756008)(66476007)(386003)(6506007)(476003)(102836004)(446003)(2501003)(6486002)(2906002)(58126008)(7416002)(6512007)(229853002)(110136005)(31686004)(54906003)(66946007)(73956011)(305945005)(66556008)(66446008)(486006)(74482002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3339;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GGrht5sJt6ldfHAB41G0LAsqucXtNTyEt+d9PCU/PQJv2VvZV9FmRHEEcAatuGFMKHl7lU8DOvVJqRnT3Fw6h5cC7iN/jiex7EjWB0dRfvrH6qFOe1GKP+D/RJqjRHdlknYJiRdwhWvn8aXdX78IEOMmL+P1hPv9PXficZRggg3WCPvDQv8guxXs7F/Q0cWG0JQzq1wOWjguG2sylvaappo166MQ9g90G1hDUrHOP++NQItWBtCgcpD+nw70l5GDJf05Ki+0J2VqV28qQPiuI/Or4p1trAZJIwIm4Xiw4qOysJAqHq+lG/B3Tfdl6x9z/iy9ddCv9gDMh4zeIQoG4LwupDBgf1SZPdJ2s7OmuH4xWM532A+vnnHTWDAdhrCDIFnYkXhu+xSDkO5fGvQCrxIT9BJ3TrNEC7JLjWfymyk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73767A93B223B34D9A913EE236CCBD94@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ce86c8-f548-4474-beec-08d6ee5c8170
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 11:03:59.8293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peda@axentia.se
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3339
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMjAxOS0wNi0xMSAxMTo1NiwgTXlsw6huZSBKb3NzZXJhbmQgd3JvdGU6DQo+IFRvIHByZXBh
cmUgdGhlIHN1cHBvcnQgb2YgcHJvY2Vzc2VkIHZhbHVlLCBjcmVhdGUgYSBmdW5jdGlvbg0KPiB0
byBjb252ZXJ0IHRoZSBzY2FsZSBhY2NvcmRpbmcgdG8gdGhlIHZvbHRhZ2UtZGl2aWRlciBub2Rl
DQo+IHVzZWQgaW4gdGhlIGRldmljZS10cmVlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTXlsw6hu
ZSBKb3NzZXJhbmQgPG15bGVuZS5qb3NzZXJhbmRAYm9vdGxpbi5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9paW8vYWZlL2lpby1yZXNjYWxlLmMgfCA1NCArKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwg
MjMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWZlL2lpby1y
ZXNjYWxlLmMgYi9kcml2ZXJzL2lpby9hZmUvaWlvLXJlc2NhbGUuYw0KPiBpbmRleCBlOWNlZWU2
NmQxZTcuLjNlNjg5ZDZlYjUwMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWZlL2lpby1y
ZXNjYWxlLmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWZlL2lpby1yZXNjYWxlLmMNCj4gQEAgLTMz
LDEyICszMyw0MSBAQCBzdHJ1Y3QgcmVzY2FsZSB7DQo+ICAJczMyIGRlbm9taW5hdG9yOw0KPiAg
fTsNCj4gIA0KPiArc3RhdGljIGludCByZXNjYWxlX2NvbnZlcnRfc2NhbGUoc3RydWN0IHJlc2Nh
bGUgKnJlc2NhbGUsIGludCAqdmFsLCBpbnQgKnZhbDIpDQo+ICt7DQo+ICsJdW5zaWduZWQgbG9u
ZyBsb25nIHRtcDsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJcmV0ID0gaWlvX3JlYWRfY2hhbm5l
bF9zY2FsZShyZXNjYWxlLT5zb3VyY2UsIHZhbCwgdmFsMik7DQo+ICsJc3dpdGNoIChyZXQpIHsN
Cj4gKwljYXNlIElJT19WQUxfRlJBQ1RJT05BTDoNCj4gKwkJKnZhbCAqPSByZXNjYWxlLT5udW1l
cmF0b3I7DQo+ICsJCSp2YWwyICo9IHJlc2NhbGUtPmRlbm9taW5hdG9yOw0KPiArCQlyZXR1cm4g
cmV0Ow0KPiArCWNhc2UgSUlPX1ZBTF9JTlQ6DQo+ICsJCSp2YWwgKj0gcmVzY2FsZS0+bnVtZXJh
dG9yOw0KPiArCQlpZiAocmVzY2FsZS0+ZGVub21pbmF0b3IgPT0gMSkNCj4gKwkJCXJldHVybiBy
ZXQ7DQo+ICsJCSp2YWwyID0gcmVzY2FsZS0+ZGVub21pbmF0b3I7DQo+ICsJCXJldHVybiBJSU9f
VkFMX0ZSQUNUSU9OQUw7DQo+ICsJY2FzZSBJSU9fVkFMX0ZSQUNUSU9OQUxfTE9HMjoNCj4gKwkJ
dG1wID0gKnZhbCAqIDEwMDAwMDAwMDBMTDsNCj4gKwkJZG9fZGl2KHRtcCwgcmVzY2FsZS0+ZGVu
b21pbmF0b3IpOw0KPiArCQl0bXAgKj0gcmVzY2FsZS0+bnVtZXJhdG9yOw0KPiArCQlkb19kaXYo
dG1wLCAxMDAwMDAwMDAwTEwpOw0KPiArCQkqdmFsID0gdG1wOw0KPiArDQoNClRoaXMgYmxhbmsg
bGluZSBpcyBpbiBjb25mbGljdCB3aXRoIHRoZSBzdHlsZSBvZiB0aGUgc3Vycm91bmRpbmcgY29k
ZS4NCg0KQ2hlZXJzLA0KUGV0ZXINCg0KPiArCQlyZXR1cm4gcmV0Ow0KPiArCWRlZmF1bHQ6DQo+
ICsJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gKwl9DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQg
cmVzY2FsZV9yZWFkX3JhdyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPiAgCQkJICAgIHN0
cnVjdCBpaW9fY2hhbl9zcGVjIGNvbnN0ICpjaGFuLA0KPiAgCQkJICAgIGludCAqdmFsLCBpbnQg
KnZhbDIsIGxvbmcgbWFzaykNCj4gIHsNCj4gIAlzdHJ1Y3QgcmVzY2FsZSAqcmVzY2FsZSA9IGlp
b19wcml2KGluZGlvX2Rldik7DQo+IC0JdW5zaWduZWQgbG9uZyBsb25nIHRtcDsNCj4gIAlpbnQg
cmV0Ow0KPiAgDQo+ICAJc3dpdGNoIChtYXNrKSB7DQo+IEBAIC00NiwyOCArNzUsNyBAQCBzdGF0
aWMgaW50IHJlc2NhbGVfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiwNCj4gIAkJ
cmV0dXJuIGlpb19yZWFkX2NoYW5uZWxfcmF3KHJlc2NhbGUtPnNvdXJjZSwgdmFsKTsNCj4gIA0K
PiAgCWNhc2UgSUlPX0NIQU5fSU5GT19TQ0FMRToNCj4gLQkJcmV0ID0gaWlvX3JlYWRfY2hhbm5l
bF9zY2FsZShyZXNjYWxlLT5zb3VyY2UsIHZhbCwgdmFsMik7DQo+IC0JCXN3aXRjaCAocmV0KSB7
DQo+IC0JCWNhc2UgSUlPX1ZBTF9GUkFDVElPTkFMOg0KPiAtCQkJKnZhbCAqPSByZXNjYWxlLT5u
dW1lcmF0b3I7DQo+IC0JCQkqdmFsMiAqPSByZXNjYWxlLT5kZW5vbWluYXRvcjsNCj4gLQkJCXJl
dHVybiByZXQ7DQo+IC0JCWNhc2UgSUlPX1ZBTF9JTlQ6DQo+IC0JCQkqdmFsICo9IHJlc2NhbGUt
Pm51bWVyYXRvcjsNCj4gLQkJCWlmIChyZXNjYWxlLT5kZW5vbWluYXRvciA9PSAxKQ0KPiAtCQkJ
CXJldHVybiByZXQ7DQo+IC0JCQkqdmFsMiA9IHJlc2NhbGUtPmRlbm9taW5hdG9yOw0KPiAtCQkJ
cmV0dXJuIElJT19WQUxfRlJBQ1RJT05BTDsNCj4gLQkJY2FzZSBJSU9fVkFMX0ZSQUNUSU9OQUxf
TE9HMjoNCj4gLQkJCXRtcCA9ICp2YWwgKiAxMDAwMDAwMDAwTEw7DQo+IC0JCQlkb19kaXYodG1w
LCByZXNjYWxlLT5kZW5vbWluYXRvcik7DQo+IC0JCQl0bXAgKj0gcmVzY2FsZS0+bnVtZXJhdG9y
Ow0KPiAtCQkJZG9fZGl2KHRtcCwgMTAwMDAwMDAwMExMKTsNCj4gLQkJCSp2YWwgPSB0bXA7DQo+
IC0JCQlyZXR1cm4gcmV0Ow0KPiAtCQlkZWZhdWx0Og0KPiAtCQkJcmV0dXJuIC1FT1BOT1RTVVBQ
Ow0KPiAtCQl9DQo+ICsJCXJldHVybiByZXNjYWxlX2NvbnZlcnRfc2NhbGUocmVzY2FsZSwgdmFs
LCB2YWwyKTsNCj4gIAlkZWZhdWx0Og0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gIAl9DQo+IA0K
DQo=
