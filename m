Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE34E3C9CE
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2019 13:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389077AbfFKLOR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jun 2019 07:14:17 -0400
Received: from mail-eopbgr70107.outbound.protection.outlook.com ([40.107.7.107]:43811
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388978AbfFKLOR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Jun 2019 07:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sQclD310nOTkPwhy8lOBgoooE19a5aTWuao5/u6HHQ=;
 b=qnsfoWwVpvdTg/HOOetoBqI+JTtSJ/BHP27JBzT0jRc3CfSX4fLUvXubdIgq3M72TukX7m6Ga8nSCg4SmXtyYo6Ypg4+W49crsCH1BsdjonDy4QAtLTkXiHFeXCh0VW9woQiYd9jII1B470wAASVBh5wn0RUDQdc0mAroO3xk+E=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3498.eurprd02.prod.outlook.com (52.134.65.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Tue, 11 Jun 2019 11:14:10 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf%5]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 11:14:10 +0000
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
Subject: Re: [PATCH v1 3/3] dt-bindings: iio: afe: Add hwmon example
Thread-Topic: [PATCH v1 3/3] dt-bindings: iio: afe: Add hwmon example
Thread-Index: AQHVIDwX4tMTrRc3WEShisYKDUvFgqaWTRmA
Date:   Tue, 11 Jun 2019 11:14:10 +0000
Message-ID: <89820e72-dcdc-67a8-b83d-5657d66d910a@axentia.se>
References: <20190611095659.29845-1-mylene.josserand@bootlin.com>
 <20190611095659.29845-4-mylene.josserand@bootlin.com>
In-Reply-To: <20190611095659.29845-4-mylene.josserand@bootlin.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0402CA0036.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::25) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb5fc901-b64c-400e-efc3-08d6ee5ded90
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3498;
x-ms-traffictypediagnostic: DB3PR0202MB3498:
x-microsoft-antispam-prvs: <DB3PR0202MB3498CE7B58893F21370E233FBCED0@DB3PR0202MB3498.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39830400003)(366004)(346002)(376002)(396003)(199004)(189003)(60444003)(386003)(446003)(31696002)(3846002)(68736007)(6512007)(2201001)(316002)(65956001)(53546011)(7416002)(11346002)(66946007)(65826007)(65806001)(73956011)(66066001)(6436002)(6506007)(2906002)(7736002)(486006)(31686004)(26005)(476003)(2616005)(305945005)(25786009)(53936002)(74482002)(102836004)(110136005)(54906003)(6116002)(86362001)(5660300002)(186003)(4326008)(6246003)(52116002)(76176011)(71200400001)(14454004)(6486002)(66446008)(71190400001)(229853002)(64126003)(256004)(66476007)(81166006)(81156014)(8676002)(36756003)(66556008)(58126008)(99286004)(64756008)(508600001)(2501003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3498;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BFlU7YVXM3S6WX2wMJ1Q0p8Cd6tTBHXedACA6UXwqMQHtoHiW3VTyfLOd4HDCYqS+y84UYhEiD1yej/R3FxeCOg33HpVwDnh/EL3TqOiP6Qq9ftHSSrGqOmWs+5JzeAv3QkfCvN77OXYIyyPV17l+1/V+uD/jYGihM96c+GXSlVaugn/US6qaM853HC6kZygkDyKDKUFfCiuf0sToMLQZL26RlCLqvLi43rwglCWJPgi1CTbSYVWGzvHftJkVuHq8Tzl4gGvDfA4/sxARBglWXHA5eh8m1uXguAzkvb1VHPjfi5WPpxryfoyPOkLh7ECRtoPSoCSsgkK0vQz4xOvQ/SPfAS3HxSStGkbHy60RP0mhjP3+1uIanKAJEFUiCU0vGW90tWztUIhPc+V2tNu1cSmw2k88TYv9MyoB8q6opw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AC28FDEAA023744A835DD7666AA2CD5@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5fc901-b64c-400e-efc3-08d6ee5ded90
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 11:14:10.6950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peda@axentia.se
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3498
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMjAxOS0wNi0xMSAxMTo1NiwgTXlsw6huZSBKb3NzZXJhbmQgd3JvdGU6DQo+IFdpdGggdGhl
IHN1cHBvcnQgb2YgQ0hBTl9JTkZPX1BST0NFU1NFRCBpbiB2b2x0YWdlLWRpdmlkZXIsDQo+IGl0
IGlzIHBvc3NpYmxlIHRvIHJlYWQgdGhlIHByb2Nlc3NlZCB2YWx1ZXMgZGlyZWN0bHkgZnJvbSBp
aW8ncw0KPiBzeXNmcyBlbnRyaWVzIG9yIGJ5IHVzaW5nIGlpby1od21vbi4gQWRkIGFuIGV4YW1w
bGUgZm9yIHRoaXMgbGFzdA0KPiB1c2UgY2FzZS4NCg0KQXMgSSB3cm90ZSBpbiByZXNwb25zZSB0
byB0aGUgY292ZXIgbGV0dGVyLCBJIHRoaW5rIGlpby1od21vbg0KY291bGQgImNvbnN1bWUiIHZv
bHRhZ2UgZGl2aWRlcnMganVzdCBmaW5lIGJlZm9yZSBhZGRpbmcgdGhlDQpwcm9jZXNzZWQgY2hh
bm5lbCwgYW5kIHdoaWxlIG1vcmUgZXhhbXBsZXMgbWlnaHQgYmUgZ29vZCwNCnRoZXJlIGlzIHJl
YWxseSBubyBzcGVjaWZpYyByZWxhdGlvbiBiZXR3ZWVuIGlpby1od21vbiBhbmQNCnZvbHRhZ2Ug
ZGl2aWRlcnMuIEFkZGluZyBpaW8taHdtb24gZXhhbXBsZXMgdG8gZWFjaCBhbmQgZXZlcnkNCmlp
byBiaW5kaW5nIHNlZW1zIHBvaW50bGVzcy4gU28sIEkgc2VlIGxpdHRsZSByZWFzb24gdG8gYWRk
DQpzdWNoIGV4YW1wbGVzIGhlcmUuDQoNCkJ1dCBpZiBldmVyeW9uZSBlbHNlIHdhbnRzIGl0LCBk
b24ndCBsZXQgbWUgc3RhbmQgaW4gdGhlIHdheS4uLg0KDQpDaGVlcnMsDQpQZXRlcg0KDQo+IFNp
Z25lZC1vZmYtYnk6IE15bMOobmUgSm9zc2VyYW5kIDxteWxlbmUuam9zc2VyYW5kQGJvb3RsaW4u
Y29tPg0KPiAtLS0NCj4gIC4uLi9iaW5kaW5ncy9paW8vYWZlL3ZvbHRhZ2UtZGl2aWRlci50eHQg
ICAgICAgICAgIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQs
IDI0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaWlvL2FmZS92b2x0YWdlLWRpdmlkZXIudHh0IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZmUvdm9sdGFnZS1kaXZpZGVyLnR4dA0KPiBpbmRl
eCBiNDUyYTg0MDYxMDcuLmY3ZTFjN2NiMjc0NCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZmUvdm9sdGFnZS1kaXZpZGVyLnR4dA0KPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FmZS92b2x0YWdlLWRpdmlk
ZXIudHh0DQo+IEBAIC01MSwzICs1MSwyNyBAQCBzeXN2IHsNCj4gIAkJc3BpLW1heC1mcmVxdWVu
Y3kgPSA8MTAwMDAwMD47DQo+ICAJfTsNCj4gIH07DQo+ICsNCj4gK0l0IGlzIGFsc28gcG9zc2li
bGUgdG8gcmV0cmlldmUgdGhlIHByb2Nlc3NlZCB2YWx1ZXMgdXNpbmcgaHdtb24gbm9kZToNCj4g
Kw0KPiArZGl2MDogZGl2MCB7DQo+ICsJY29tcGF0aWJsZSA9ICJ2b2x0YWdlLWRpdmlkZXIiOw0K
PiArCWlvLWNoYW5uZWxzID0gPCZhZGMwIDA+OyAvKiBDaGFubmVsIDAgb2YgdGhlIEFEQyAqLw0K
PiArCW91dHB1dC1vaG1zID0gPDQ3PjsgLyogUjIgKi8NCj4gKwlmdWxsLW9obXMgPSA8NzM+OyAv
KiBSMSAoMjYpICsgUjIgKDQ3KSAqLw0KPiArCSNpby1jaGFubmVsLWNlbGxzID0gPDE+Ow0KPiAr
fTsNCj4gKw0KPiArZGl2MTogZGl2MSB7DQo+ICsJY29tcGF0aWJsZSA9ICJ2b2x0YWdlLWRpdmlk
ZXIiOw0KPiArCWlvLWNoYW5uZWxzID0gPCZhZGMwIDE+OyAvKiBDaGFubmVsIDEgb2YgdGhlIEFE
QyAqLw0KPiArCW91dHB1dC1vaG1zID0gPDQ3PjsgLyogUjIgKi8NCj4gKwlmdWxsLW9obXMgPSA8
MTE1PjsgLyogUjEgKDY4KSArIFIyICg0NykgKi8NCj4gKwkjaW8tY2hhbm5lbC1jZWxscyA9IDwx
PjsNCj4gK307DQo+ICsNCj4gK2lpby1od21vbiB7DQo+ICsJY29tcGF0aWJsZSA9ICJpaW8taHdt
b24iOw0KPiArCWlvLWNoYW5uZWxzID0gPCZkaXYwIDA+LCA8JmRpdjEgMD47DQo+ICsJaW8tY2hh
bm5lbC1uYW1lcyA9ICIzdjMiLCAidXNiIjsNCj4gK307DQo+IA0KDQo=
