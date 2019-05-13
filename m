Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D571B174
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2019 09:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfEMHrV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 May 2019 03:47:21 -0400
Received: from mail-eopbgr140113.outbound.protection.outlook.com ([40.107.14.113]:9710
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727598AbfEMHrV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 May 2019 03:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Idj7L7lGUdG6n77DQwKx3XrrWz8l64DyegcDCLArJRg=;
 b=k8ZJK1puhabwPXvMuG8nd3S5IhfCJ7VwOf2RhMKYpPKr36NE+x9T6YtOsfYMkPqXTzpqyylI/ERwdfYERvCRtnGPbETc4SAmY7JEyQyP47fFcp1Bl2AAS5iwO6sITuj4Ml/cKunLwseuEdV/DiYSLccHvaRLGUAs3Tld9OFQsKU=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2957.eurprd05.prod.outlook.com (10.175.21.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Mon, 13 May 2019 07:47:14 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::48ff:f344:98da:6571]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::48ff:f344:98da:6571%5]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 07:47:14 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>
Subject: Re: [PATCH 5/5] iio: stmpe-adc: Reset possible interrupts
Thread-Topic: [PATCH 5/5] iio: stmpe-adc: Reset possible interrupts
Thread-Index: AQHVBOJDlcfa27rPFkC6CK5LLhcgfqZlvamAgAL4uYA=
Date:   Mon, 13 May 2019 07:47:14 +0000
Message-ID: <b2cb0c244d95d1e1e267c75eb40045b7a3cee6d1.camel@toradex.com>
References: <20190507143615.28477-1-dev@pschenker.ch>
         <20190507143615.28477-5-dev@pschenker.ch>
         <20190511112429.25ddd84d@archlinux>
In-Reply-To: <20190511112429.25ddd84d@archlinux>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82491514-95af-4da6-b44b-08d6d77736f1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR0502MB2957;
x-ms-traffictypediagnostic: VI1PR0502MB2957:
x-microsoft-antispam-prvs: <VI1PR0502MB2957448724AAEF9B4AF4CB87F40F0@VI1PR0502MB2957.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(39840400004)(396003)(376002)(189003)(199004)(476003)(486006)(53936002)(446003)(2616005)(11346002)(4326008)(6246003)(64756008)(6916009)(6512007)(118296001)(91956017)(66946007)(66476007)(66556008)(73956011)(2501003)(66446008)(76116006)(5640700003)(6506007)(6436002)(54906003)(26005)(102836004)(6486002)(76176011)(99286004)(86362001)(7736002)(305945005)(229853002)(316002)(7416002)(8676002)(81166006)(81156014)(8936002)(256004)(36756003)(14444005)(71200400001)(71190400001)(2351001)(186003)(6116002)(3846002)(44832011)(5660300002)(25786009)(2906002)(66066001)(478600001)(14454004)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2957;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 61JyQFfRSPT/OTeNvYQXkW5F9uBqgDwP89pq7O/zUWbGF23O6knRzBLCRfrl52zT0unDq32pQJTbVxv25AZI6C6NV//jjvdV6RrIVNYR7dTWp6vQTxLRCI9ad9OHpisA95D+pAVPoRJdUp68KiG03xy5diAMYohObi4w04RgutY4dppz8EamDVVCPcuvgTd0IS6YtQAJeus+fGUACzVOeHOtJRPNswb+S+/iyot6m3F5KxmJy0lXDv6I2luqP7JCnbMjFmLRVstwsilmy9/HhD3lCna1RrSfT6phW/d9RZNSWKN+OrBrsMhGa0GI5T3AZIUH53ACqfwjk04ySiFSiuKqSIxjhhbwtmICDQ1G7i3jKySXac+x6WxdaSaVRN1SJ5K4ZdV5ZLD9w/n6zZ2B/8ASpFguRFsmTjzSGwm8n2U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01947B48A97B014CA10C2DC0D37BDAF9@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82491514-95af-4da6-b44b-08d6d77736f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 07:47:14.1393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2957
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDE5LTA1LTExIGF0IDExOjI0ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUdWUsICA3IE1heSAyMDE5IDE2OjM2OjE1ICswMjAwDQo+IFBoaWxpcHBlIFNjaGVu
a2VyIDxkZXZAcHNjaGVua2VyLmNoPiB3cm90ZToNCj4gDQo+ID4gRnJvbTogUGhpbGlwcGUgU2No
ZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KPiA+IA0KPiA+IENsZWFyIGFu
eSBpbnRlcnJ1cHQgdGhhdCBzdGlsbCBpcyBvbiB0aGUgZGV2aWNlIG9uIGV2ZXJ5IGNoYW5uZWwN
Cj4gPiB0aGlzIGRyaXZlciBpcyBhY3RpdmF0ZWQgZm9yIGluIHByb2JlIGFuZCBzcGVjaWZpYyBj
aGFubmVscyBpbg0KPiA+IHRoZSB0aW1lb3V0IGhhbmRsZXIuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0K
PiBJJ20gbmV2ZXIgcGFydGljdWxhcmx5IGNsZWFuIG9uIGJsYW5rZXQgcmVzZXRzIGFzIHRoZXkg
ZG8gdGVuZCB0bw0KPiBoaWRlIGJ1Z3MuIEhvd2V2ZXIsIHRoZSBwcm9iZSBvbmUgaXMgc29tZXRo
aW5nIHRoYXQgd291bGQgaGFwcGVuIGFueXdheQ0KPiBpZiB0aGVyZSB3YXMgYSAncmVzZXQnIGZ1
bmN0aW9uLg0KPiANCj4gQXBwbGllZCB0byB0aGUgdG9ncmVnIGJyYW5jaCBvZiBpaW8uZ2l0IGFu
ZCBwdXNoZWQgb3V0IGFzIHRlc3RpbmcNCj4gZm9yIHRoZSBhdXRvYnVpbGRlcnMgdG8gcGxheSB3
aXRoIGl0Lg0KPiANCj4gVGhhbmtzLA0KPiANCj4gSm9uYXRoYW4NCg0KWW91J3JlIHJpZ2h0IGFi
b3V0IGhpZGluZyBidWdzLiBCdXQgaWYgdGhlIGludGVycnVwdCBmb3Igd2hhdGV2ZXIgKGhhcmR3
YXJlPykNCnJlYXNvbiBkb2VzIG5vdCBvY2N1ciwgaXQgcHJldmVudHMgZnVydGhlciBpbnRlcnJ1
cHRzIGFzIGl0IGRvZXMgbm90IGdldCByZXNldC4NCg0KU28gdGhpcyByZXNldCB0YWtlcyBjYXJl
IHRoYXQgYWZ0ZXIgYSB0aW1lb3V0IG9uZSBpcyBzdGlsbCBhYmxlIHRvIHJlYWQgb3V0IHRoZQ0K
QURDLg0KDQpQaGlsaXBwZQ0KDQo+IA0KPiA+IC0tLQ0KPiA+IA0KPiA+ICBkcml2ZXJzL2lpby9h
ZGMvc3RtcGUtYWRjLmMgfCA1ICsrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5j
IGIvZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5jDQo+ID4gaW5kZXggY2M3NTJhNDc0NDRjLi5h
NTk5MGU5ZjJjODAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5j
DQo+ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5jDQo+ID4gQEAgLTgwLDYgKzgw
LDggQEAgc3RhdGljIGludCBzdG1wZV9yZWFkX3ZvbHRhZ2Uoc3RydWN0IHN0bXBlX2FkYyAqaW5m
bywNCj4gPiAgCXJldCA9IHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmaW5mby0+Y29tcGxl
dGlvbiwgU1RNUEVfQURDX1RJTUVPVVQpOw0KPiA+ICANCj4gPiAgCWlmIChyZXQgPD0gMCkgew0K
PiA+ICsJCXN0bXBlX3JlZ193cml0ZShpbmZvLT5zdG1wZSwgU1RNUEVfUkVHX0FEQ19JTlRfU1RB
LA0KPiA+ICsJCQkJU1RNUEVfQURDX0NIKGluZm8tPmNoYW5uZWwpKTsNCj4gPiAgCQltdXRleF91
bmxvY2soJmluZm8tPmxvY2spOw0KPiA+ICAJCXJldHVybiAtRVRJTUVET1VUOw0KPiA+ICAJfQ0K
PiA+IEBAIC0zMjYsNiArMzI4LDkgQEAgc3RhdGljIGludCBzdG1wZV9hZGNfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCXN0bXBlX3JlZ193cml0ZShpbmZvLT5zdG1w
ZSwgU1RNUEVfUkVHX0FEQ19JTlRfRU4sDQo+ID4gIAkJCX4obm9yZXF1ZXN0X21hc2sgJiAweEZG
KSk7DQo+ID4gIA0KPiA+ICsJc3RtcGVfcmVnX3dyaXRlKGluZm8tPnN0bXBlLCBTVE1QRV9SRUdf
QURDX0lOVF9TVEEsDQo+ID4gKwkJCX4obm9yZXF1ZXN0X21hc2sgJiAweEZGKSk7DQo+ID4gKw0K
PiA+ICAJcmV0dXJuIGRldm1faWlvX2RldmljZV9yZWdpc3RlcigmcGRldi0+ZGV2LCBpbmRpb19k
ZXYpOw0KPiA+ICB9DQo+ID4gIA0K
