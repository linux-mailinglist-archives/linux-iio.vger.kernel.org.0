Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935C01B124
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2019 09:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfEMH3C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 May 2019 03:29:02 -0400
Received: from mail-eopbgr50098.outbound.protection.outlook.com ([40.107.5.98]:28875
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727568AbfEMH3C (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 May 2019 03:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dbTAC//XHrFVIZfXDI+bV77HQpSpYzq9ex1ut4pJcg=;
 b=XckAKA7VFgGqj1+tFvJTSBBlwN5+SpL0VMNfD06Xa0BxSHHOApFtoZGC+5u+clFDuwy5kT/n3ITymFAN8r/34VF6hi4Sk47ihu87FXU1u/P4Kfc3QMh3UFRkcLGXiQ+Y8eOOsyZIKCJtI60IQpfyuyMJguULAPg6KyEItwzzhLQ=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3087.eurprd05.prod.outlook.com (10.175.22.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 07:28:18 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::48ff:f344:98da:6571]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::48ff:f344:98da:6571%5]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 07:28:18 +0000
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
Subject: Re: [PATCH 4/5] iio: stmpe-adc: Use wait_for_completion_timeout
Thread-Topic: [PATCH 4/5] iio: stmpe-adc: Use wait_for_completion_timeout
Thread-Index: AQHVBOJHMVYXdjmHB0653c7vvGs0gKZluzwAgAL12oA=
Date:   Mon, 13 May 2019 07:28:17 +0000
Message-ID: <6bc5bf4c854288fae0591f33ea9ae4e5c4091616.camel@toradex.com>
References: <20190507143615.28477-1-dev@pschenker.ch>
         <20190507143615.28477-4-dev@pschenker.ch>
         <20190511111548.504948ae@archlinux>
In-Reply-To: <20190511111548.504948ae@archlinux>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c68ebad4-3e66-4d46-c477-08d6d77491b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR0502MB3087;
x-ms-traffictypediagnostic: VI1PR0502MB3087:
x-microsoft-antispam-prvs: <VI1PR0502MB3087CDD718CE0EBF6AB80807F40F0@VI1PR0502MB3087.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(396003)(39840400004)(376002)(189003)(199004)(6916009)(6116002)(53936002)(478600001)(3846002)(5660300002)(14454004)(6246003)(2501003)(6506007)(91956017)(76116006)(73956011)(66446008)(64756008)(66556008)(66476007)(86362001)(66946007)(316002)(102836004)(486006)(476003)(2616005)(446003)(11346002)(44832011)(99286004)(7736002)(8676002)(81156014)(81166006)(4326008)(2351001)(8936002)(25786009)(305945005)(26005)(6512007)(54906003)(66066001)(76176011)(6486002)(14444005)(229853002)(36756003)(7416002)(68736007)(186003)(71200400001)(71190400001)(256004)(118296001)(5640700003)(2906002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3087;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aLasiDEjj1AmLmwKwpfhyXkxZxO9B8a3A6U3JErB2WuXUw5RLUCfL6vZjRfLTwRqEkwupWe0x3SLFpat2PirX+DeRso2t4rACfDNv3ZcWFfxSLUWpdR5z2Xy0f71DzTDDpLt+Vc3gbk9+RUIw8XBT3bVcJq+Fu3uKf5rjiLlcQe8D76OfFfi7nq4u0gAEQRT6fUcAZkbpI8yHBgGHBTOBYMCFo2UWjIi1hWEeGBgqxZg2OmPqH6036B57wVlLK53A6t/HdXhfNBu0tg/MEQxwmJQpk74SswAlRAOtfFWOarD6rqBUfpb9YrGX2nRyyGYGsZdFwVVmk/mWC+7cdByAiVnWIvBLBI2RNobL7PrnWgc3JAoMepEobow8oC5bZ81xvcrEAGP+Ch3Z7/mXgeUPX7JeXX1QGbwWYpT4Mn4vgQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D331B7B33E79B841B5F2A31D1CE2760E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68ebad4-3e66-4d46-c477-08d6d77491b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 07:28:17.9187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3087
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDE5LTA1LTExIGF0IDExOjE1ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUdWUsICA3IE1heSAyMDE5IDE2OjM2OjE0ICswMjAwDQo+IFBoaWxpcHBlIFNjaGVu
a2VyIDxkZXZAcHNjaGVua2VyLmNoPiB3cm90ZToNCj4gDQo+ID4gRnJvbTogUGhpbGlwcGUgU2No
ZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KPiA+IA0KPiA+IFVzZSB3YWl0
X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQgaW5zdGVhZCBvZg0KPiA+IHdhaXRfZm9yX2NvbXBsZXRp
b25faW50ZXJ1cHRpYmxlX3RpbWVvdXQuDQo+ID4gDQo+ID4gVGhlIGludGVycnVwdGlibGUgdmFy
aWFudCBnZXRzIGNvbnN0YW50bHkgaW50ZXJydXB0ZWQgaWYgYSB1c2VyDQo+ID4gcHJvZ3JhbSBp
cyBjb21waWxlZCB3aXRoIHRoZSAtcGcgb3B0aW9uLg0KPiA+IFRoZSBraWxsYWJsZSB2YXJpYW50
IHdhcyBub3QgdXNlZCBkdWUgdG8gdGhlIGZhY3QgdGhhdCBhIHNlY29uZA0KPiA+IHByb2dyYW0s
IHJlYWRpbmcgb24gdGhpcyBkZXZpY2UsIHRoYXQgZ2V0cyBraWxsZWQgaXMgdGhlbiBhbHNvIGtp
bGxpbmcNCj4gPiB0aGF0IHdhaXQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUg
U2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KPiBIaSBQaGlsbGlwcGUN
Cj4gDQo+IFRoaXMgb25lIGNsYXNoZWQgYSBsaXR0bGUgYml0IHdpdGggb3VyIGVhcmxpZXIgcGF0
Y2ggdG8gcmVtb3ZlIHRoZQ0KPiB1bm5lY2Vzc2FyeSBhc3NpZ25tZW50LiAgSSd2ZSBhcHBsaWVk
IGl0IGJ5IGhhbmQgYnV0IHBsZWFzZSBjaGVjayBpdC4NCj4gDQo+IEFwcGxpZWQgdG8gdGhlIHRv
Z3JlZyBicmFuY2ggb2YgaWlvLmdpdCBhbmQgcHVzaGVkIG91dCBhcyB0ZXN0aW5nDQo+IGZvciB0
aGUgYXV0b2J1aWxkZXJzIHRvIHBsYXkgd2l0aCBpdC4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEpv
bmF0aGFuDQoNCkhtbSwgeWVhaCBJIHNlZSBpdCBzb3JyeSBmb3IgdGhhdCEgU29tZWhvdyB0aGF0
IGxpbmUgd2VudCBpbiBhZ2FpbiBpbiB0aGlzDQpwYXRjaC4gRG9uJ3Qga25vdyB3aHkuLi4gQW55
d2F5IEkgY2hlY2tlZCBpdCBhbmQgaXQgbG9va3MgZ29vZC4gVGhhbmsgeW91IQ0KDQpQaGlsaXBw
ZQ0KDQo+ID4gLS0tDQo+ID4gDQo+ID4gIGRyaXZlcnMvaWlvL2FkYy9zdG1wZS1hZGMuYyB8IDE4
ICsrKystLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAxNCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRj
L3N0bXBlLWFkYy5jIGIvZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5jDQo+ID4gaW5kZXggODJi
NDNlNDUyMmI2Li5jYzc1MmE0NzQ0NGMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vYWRj
L3N0bXBlLWFkYy5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5jDQo+ID4g
QEAgLTc3LDE3ICs3NywxMSBAQCBzdGF0aWMgaW50IHN0bXBlX3JlYWRfdm9sdGFnZShzdHJ1Y3Qg
c3RtcGVfYWRjICppbmZvLA0KPiA+ICAJc3RtcGVfcmVnX3dyaXRlKGluZm8tPnN0bXBlLCBTVE1Q
RV9SRUdfQURDX0NBUFQsDQo+ID4gIAkJCVNUTVBFX0FEQ19DSChpbmZvLT5jaGFubmVsKSk7DQo+
ID4gIA0KPiA+IC0JKnZhbCA9IGluZm8tPnZhbHVlOw0KPiA+IC0NCj4gPiAtCXJldCA9IHdhaXRf
Zm9yX2NvbXBsZXRpb25faW50ZXJydXB0aWJsZV90aW1lb3V0DQo+ID4gLQkJKCZpbmZvLT5jb21w
bGV0aW9uLCBTVE1QRV9BRENfVElNRU9VVCk7DQo+ID4gKwlyZXQgPSB3YWl0X2Zvcl9jb21wbGV0
aW9uX3RpbWVvdXQoJmluZm8tPmNvbXBsZXRpb24sIFNUTVBFX0FEQ19USU1FT1VUKTsNCj4gPiAg
DQo+ID4gIAlpZiAocmV0IDw9IDApIHsNCj4gPiAgCQltdXRleF91bmxvY2soJmluZm8tPmxvY2sp
Ow0KPiA+IC0JCWlmIChyZXQgPT0gMCkNCj4gPiAtCQkJcmV0dXJuIC1FVElNRURPVVQ7DQo+ID4g
LQkJZWxzZQ0KPiA+IC0JCQlyZXR1cm4gcmV0Ow0KPiA+ICsJCXJldHVybiAtRVRJTUVET1VUOw0K
PiA+ICAJfQ0KPiA+ICANCj4gPiAgCSp2YWwgPSBpbmZvLT52YWx1ZTsNCj4gPiBAQCAtMTE2LDE1
ICsxMTAsMTEgQEAgc3RhdGljIGludCBzdG1wZV9yZWFkX3RlbXAoc3RydWN0IHN0bXBlX2FkYyAq
aW5mbywNCj4gPiAgCXN0bXBlX3JlZ193cml0ZShpbmZvLT5zdG1wZSwgU1RNUEVfUkVHX1RFTVBf
Q1RSTCwNCj4gPiAgCQkJU1RNUEVfU1RBUlRfT05FX1RFTVBfQ09OVik7DQo+ID4gIA0KPiA+IC0J
cmV0ID0gd2FpdF9mb3JfY29tcGxldGlvbl9pbnRlcnJ1cHRpYmxlX3RpbWVvdXQNCj4gPiAtCQko
JmluZm8tPmNvbXBsZXRpb24sIFNUTVBFX0FEQ19USU1FT1VUKTsNCj4gPiArCXJldCA9IHdhaXRf
Zm9yX2NvbXBsZXRpb25fdGltZW91dCgmaW5mby0+Y29tcGxldGlvbiwgU1RNUEVfQURDX1RJTUVP
VVQpOw0KPiA+ICANCj4gPiAgCWlmIChyZXQgPD0gMCkgew0KPiA+ICAJCW11dGV4X3VubG9jaygm
aW5mby0+bG9jayk7DQo+ID4gLQkJaWYgKHJldCA9PSAwKQ0KPiA+IC0JCQlyZXR1cm4gLUVUSU1F
RE9VVDsNCj4gPiAtCQllbHNlDQo+ID4gLQkJCXJldHVybiByZXQ7DQo+ID4gKwkJcmV0dXJuIC1F
VElNRURPVVQ7DQo+ID4gIAl9DQo+ID4gIA0KPiA+ICAJLyoNCg==
