Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E607B6148
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 12:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfIRKSG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 06:18:06 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:19958 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729450AbfIRKSG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 06:18:06 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8IACoUO011009;
        Wed, 18 Sep 2019 06:17:29 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2053.outbound.protection.outlook.com [104.47.40.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v37k81c6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 06:17:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Te6NE6UsWZPXl+m65MB0zMzRtFMj46lVDdVb0Xxybzndw7b/z5ZXLlBcj11QqIn0xOjsrDfPLxQW/pbb7xCr+an9WId9f9m/Mv8dJ3FAwv4vUVAOTJ2lAA7ula1+nZ/bVKPdquhbM5AxdGADHRmW/0Bb4VvdOmJAK1DVht2P3D/XO/aNU/OxAK8qsc9PCxbdGj1NjcUoCDBcRm7sSL+QKCLfI+Bxyag1stNrAxecvsegnjARTt4YK0zGN1oah//NUYbXcMyWTz1CL2/jMM3XOKpdYug1VYryfJ19VbxjWHn4EKdapzRMG5Axog78v8Qr0zKvKvGos+AY9RZFRbjJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5QaVThnwT155+lo1DhyRYNKqb1hkXw/mWA/j0f+KKw=;
 b=F+sJq8ri7ekuJQmlKhiG3lZXoZYcU8s5pedB8SM100GAd92Iy2NUyF1eW1KRJgk0NzM59f4gKhTooXqHdgbfaXsAvrNC1WESo5hTdvInaDIlhvgcPeivmxcvCgWgi6aWm0KPp2Dk7A8pcJclUfuZLHA6RP8E6pQz7NNJfEoBMpKu2sanvsDE1GcyaJ/eRF3cGQ1g0+mGinbhnPG7VenBGhONvYSuMiK4EcCLqn6IhiO/5snBqpxUNwwadcEoKSU0VuEnCva9+XMZic+guKMm6idEx4/oCZb+/PIpICzug0A+rGtQVHi1DU3I3i5/cY4sS03JlYngCsn0CtJ9u1QZ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5QaVThnwT155+lo1DhyRYNKqb1hkXw/mWA/j0f+KKw=;
 b=Y1Apr2yhlkQOo0n2+NPbEC9246pUAJhJJm+ouYIsHVfjJ3+2OtTLA7GJrZxk5QsoJP0d3GAIJVd2lE9kRc5CAkEb1Sn+tGTKkocl369ZzpZIeW06lzNPVAw2zDzB9gkbN3pfr+2HAqYI8Wj/0TOB8hfRHbQkdYTn31tmt/LacPM=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5238.namprd03.prod.outlook.com (20.180.4.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Wed, 18 Sep 2019 10:17:27 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2284.009; Wed, 18 Sep 2019
 10:17:27 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/3] iio: adc: ad799x: factor out config register update
Thread-Topic: [PATCH 2/3] iio: adc: ad799x: factor out config register update
Thread-Index: AQHVbXJikpAUqSp5NkqMxwualxyZmKcxMoGA///vaoCAAEoCAA==
Date:   Wed, 18 Sep 2019 10:17:27 +0000
Message-ID: <1d1447608e6f57a8911cb0175ece6d1381652050.camel@analog.com>
References: <20190917160925.9791-1-m.felsch@pengutronix.de>
         <20190917160925.9791-3-m.felsch@pengutronix.de>
         <6f857959a8cbef3320830676b2280e04ca4f8e96.camel@analog.com>
         <20190918085231.ahofxji7metorpgt@pengutronix.de>
In-Reply-To: <20190918085231.ahofxji7metorpgt@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0257bac3-28b5-4f39-657c-08d73c216825
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR03MB5238;
x-ms-traffictypediagnostic: CH2PR03MB5238:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5238A0A17D9D856A128AC692F98E0@CH2PR03MB5238.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39860400002)(366004)(346002)(199004)(189003)(25786009)(76116006)(66066001)(6436002)(5640700003)(6486002)(6916009)(66476007)(2906002)(64756008)(4326008)(66446008)(66556008)(66946007)(14444005)(2351001)(486006)(256004)(229853002)(14454004)(6512007)(6246003)(478600001)(2501003)(6506007)(53546011)(316002)(76176011)(54906003)(86362001)(186003)(99286004)(26005)(446003)(11346002)(102836004)(118296001)(15650500001)(3846002)(6116002)(8936002)(305945005)(7736002)(476003)(36756003)(71200400001)(71190400001)(81156014)(8676002)(2616005)(81166006)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5238;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TGliUGQlXua4/k+SH4Rx5Q3EgtKkrxcEAd6fBVPQUIGAKyMghajjWjjjQ2R2gxjTsCwd8DTwchTR8Vmj0m3ahLKY6x3ltx/O//SjFn+3dCen0c75jzqIMn1sL3OJ2C4WoTaoFKbToiNSXxzuNm58kMZi+1dForO5zusk3nDkVPGYuv6YI0bJ6sO9xdmL7qjVJg2+sgIci5sN6GQ5pJUQwndmiKKa/bBVwntpj4mvk+EdP8/TOOug/rlh4YI5zGHHuF2OnPpo/CHSCFIPjCJQwuYopN7CiZk7zyPkpCSVE+8PpUXtHtCxu/U24pdu/B5m/oA5PHT0fGtkdTXkgETPuQOdNhK06DudNAzc0mbViAn/GHjh7vWb9EXtpHtVXiP6PfHIDcIveqDQlh2WYH67MhqgAO4Z79LPDX2I4l7ygso=
Content-Type: text/plain; charset="utf-8"
Content-ID: <742E294C0DAA8D419BC7BF021903009B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0257bac3-28b5-4f39-657c-08d73c216825
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 10:17:27.4161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CG/LQ3mTwUqYE6AO3ysm+QxZ8Amm2enoPVpXEi8cfmrOuoXFJUFpjTb1aaUgZGa2Fiz5xr0HIN5K36bCkC6SC9ph/V1S1Rpz5iSwuQNhf9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5238
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-18_06:2019-09-17,2019-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909180102
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTA5LTE4IGF0IDEwOjUyICswMjAwLCBNYXJjbyBGZWxzY2ggd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IEhpLA0KPiANCj4gT24gMTktMDktMTggMDY6NTEsIEFyZGVsZWFu
LCBBbGV4YW5kcnUgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDE5LTA5LTE3IGF0IDE4OjA5ICswMjAw
LCBNYXJjbyBGZWxzY2ggd3JvdGU6DQo+ID4gPiBbRXh0ZXJuYWxdDQo+ID4gPiANCj4gPiANCj4g
PiBDb21tZW50cyBpbmxpbmUuDQo+ID4gDQo+ID4gPiBGYWN0b3Igb3V0IHRoZSBjb25maWd1cmF0
aW9uIHJlZ2lzdGVyIHVwZGF0ZSB0byByZXVzZSBpdCBkdXJpbmcgcG0NCj4gPiA+IHJlc3VtZSBv
cGVyYXRpb24uDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmNvIEZlbHNjaCA8bS5m
ZWxzY2hAcGVuZ3V0cm9uaXguZGU+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2lpby9hZGMv
YWQ3OTl4LmMgfCAyMyArKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2FkNzk5eC5jIGIvZHJpdmVycy9paW8vYWRjL2FkNzk5
eC5jDQo+ID4gPiBpbmRleCBmNjU4MDEyYmFhZDguLmFmNWEyZGU5YzIyZiAxMDA2NDQNCj4gPiA+
IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hZDc5OXguYw0KPiA+ID4gKysrIGIvZHJpdmVycy9paW8v
YWRjL2FkNzk5eC5jDQo+ID4gPiBAQCAtMTY3LDYgKzE2NywyMSBAQCBzdGF0aWMgaW50IGFkNzk5
eF9yZWFkX2NvbmZpZyhzdHJ1Y3QNCj4gPiA+IGFkNzk5eF9zdGF0ZQ0KPiA+ID4gKnN0KQ0KPiA+
ID4gIAl9DQo+ID4gPiAgfQ0KPiA+ID4gIA0KPiA+ID4gK3N0YXRpYyBpbnQgYWQ3OTl4X3VwZGF0
ZV9jb25maWcoc3RydWN0IGFkNzk5eF9zdGF0ZSAqc3QsIHUxNiBjb25maWcpDQo+ID4gPiArew0K
PiA+ID4gKwlpbnQgcmV0Ow0KPiA+ID4gKw0KPiA+ID4gKwlyZXQgPSBhZDc5OXhfd3JpdGVfY29u
ZmlnKHN0LCBjb25maWcpOw0KPiA+ID4gKwlpZiAocmV0IDwgMCkNCj4gPiA+ICsJCXJldHVybiBy
ZXQ7DQo+ID4gPiArCXJldCA9IGFkNzk5eF9yZWFkX2NvbmZpZyhzdCk7DQo+ID4gPiArCWlmIChy
ZXQgPCAwKQ0KPiA+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiA+ICsJc3QtPmNvbmZpZyA9IHJldDsN
Cj4gPiA+ICsNCj4gPiA+ICsJcmV0dXJuIDA7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gIC8q
Kg0KPiA+ID4gICAqIGFkNzk5eF90cmlnZ2VyX2hhbmRsZXIoKSBiaCBvZiB0cmlnZ2VyIGxhdW5j
aGVkIHBvbGxpbmcgdG8gcmluZw0KPiA+ID4gYnVmZmVyDQo+ID4gPiAgICoNCj4gPiA+IEBAIC04
MDgsMTMgKzgyMyw5IEBAIHN0YXRpYyBpbnQgYWQ3OTl4X3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50
DQo+ID4gPiAqY2xpZW50LA0KPiA+ID4gIAlpbmRpb19kZXYtPmNoYW5uZWxzID0gc3QtPmNoaXBf
Y29uZmlnLT5jaGFubmVsOw0KPiA+ID4gIAlpbmRpb19kZXYtPm51bV9jaGFubmVscyA9IGNoaXBf
aW5mby0+bnVtX2NoYW5uZWxzOw0KPiA+ID4gIA0KPiA+ID4gLQlyZXQgPSBhZDc5OXhfd3JpdGVf
Y29uZmlnKHN0LCBzdC0+Y2hpcF9jb25maWctPmRlZmF1bHRfY29uZmlnKTsNCj4gPiA+IC0JaWYg
KHJldCA8IDApDQo+ID4gPiAtCQlnb3RvIGVycm9yX2Rpc2FibGVfdnJlZjsNCj4gPiA+IC0JcmV0
ID0gYWQ3OTl4X3JlYWRfY29uZmlnKHN0KTsNCj4gPiA+IC0JaWYgKHJldCA8IDApDQo+ID4gPiAr
CXJldCA9IGFkNzk5eF91cGRhdGVfY29uZmlnKHN0LCBzdC0+Y2hpcF9jb25maWctPmRlZmF1bHRf
Y29uZmlnKTsNCj4gPiA+ICsJaWYgKHJldCkNCj4gPiA+ICAJCWdvdG8gZXJyb3JfZGlzYWJsZV92
cmVmOw0KPiA+ID4gLQlzdC0+Y29uZmlnID0gcmV0Ow0KPiA+IA0KPiA+IEknbSBmZWVsaW5nIHRo
aXMgY291bGQgZ28gYSBiaXQgZnVydGhlciBtYXliZS4NCj4gPiBJJ20gbm90aWNpbmcgdGhhdCBw
YXRjaCAzIGFkZHMgYWQ3OTl4X3N1c3BlbmQoKSAmIGFkNzk5eF9yZXN1bWUoKS4NCj4gDQo+IEht
Li4gSSBkb24ndCBrbm93LiBZb3UncmUgcmlnaHQgdGhhdCB0aGlzIGlzIG5lZWRlZCBmb3IgdGhl
IHJlc3VtZSgpLiBJDQo+IHdhbnRlZCB0byBrZWVwIHRoZSBjaGFuZ2VzIG1pbmltYWwgdG8gc3Bl
ZWQgdXAgdGhlIHJldmlldyBwcm9jZXNzLiBBcw0KPiB5b3UgbWVudGlvbmVkIGJlbG93IEkgY2Fu
IHNxdWFzaCBwYXRjaCAyICYgMy4NCj4gDQo+ID4gSXQgbG9va3MgdG8gbWUgKEkgY291bGQgYmUg
d3JvbmcpLCB0aGF0IHRoaXMgYml0IG9mIGNvZGUgKHdpdGggc29tZQ0KPiA+IG1pbm9yDQo+ID4g
cmUtb3JkZXJpbmcpIGlzIGFjdHVhbGx5IGEgYWQ3OTl4X3Jlc3VtZSgpIGNhbGwuDQo+IA0KPiBJ
IHdvdWxkIGtlZXAgdGhlbSBzZXBlcmF0ZSBhdCBsZWFzdCByZXN1bWUoKSBhbmQgdGhlIHByb2Jl
KCkgcGF0aC4NCg0KSSB3b3VsZCBiZSBpbmNsaW5lZCB0byByZXVzZSByZXN1bWUoKSAmIHN1c3Bl
bmQoKSBpbiBwcm9iZSgpICYgcmVtb3ZlKCksDQpidXQgaXQncyBub3QgYSBiaWcgZGVhbC4NCldl
IGNhbiBsZWF2ZSBpdCBzZXBhcmF0ZWx5Lg0KDQo+IA0KPiBSZWdhcmRzLA0KPiAgIE1hcmNvDQo+
IA0KPiA+IFNpbWlsYXJseSwgYWQ3OTl4X3N1c3BlbmQoKSBjb3VsZCBiZSBhZGRlZCBpbiBhZDc5
OXhfcmVtb3ZlKCkuDQo+ID4gDQo+ID4gSWYgdGhhdCdzIHRoZSBjYXNlLCBwYXRjaCAyICYgMyBj
b3VsZCBiZSBzcXVhc2hlZCBpbnRvIGEgc2luZ2xlIHBhdGNoDQo+ID4gdGhhdA0KPiA+IGFkZHMg
YWQ3OTl4X3N1c3BlbmQoKSAmIGFkNzk5eF9yZXN1bWUoKSAmIGFsc28gcmVwbGFjZXMgdGhlbSBo
ZXJlIGFuZA0KPiA+IGluDQo+ID4gdGhlIGFkNzk5eF9yZW1vdmUoKSBjb2RlLg0KPiA+IA0KPiA+
ID4gIA0KPiA+ID4gIAlyZXQgPSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9zZXR1cChpbmRpb19kZXYs
IE5VTEwsDQo+ID4gPiAgCQkmYWQ3OTl4X3RyaWdnZXJfaGFuZGxlciwgTlVMTCk7DQo=
