Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B89023C9A4
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2019 13:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388669AbfFKLC7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jun 2019 07:02:59 -0400
Received: from mail-eopbgr80135.outbound.protection.outlook.com ([40.107.8.135]:55043
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388629AbfFKLC7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Jun 2019 07:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXrpjXdyrMEC4Y3ToVddBb46orM5cvC5HVFEfF3fwaM=;
 b=hH13luEsPUy8yF17GPnbWdv+P5ppy/67/L9QgLF1GrnmFdDx1+duQlzLkrgNK8gfdD2oeUncZisUIz7axD15GcVPuhkkdqo7nf+4eR2VO7ciFGQq5AxMynioEQ0LvSl+OUSOVp/lqCD9vAxIcvwMBguuZ8j6NsBEYgfb5j/V22k=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3419.eurprd02.prod.outlook.com (52.134.66.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Tue, 11 Jun 2019 11:02:14 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf%5]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 11:02:14 +0000
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
Subject: Re: [PATCH v1 0/3] iio: afe: rescale: Add INFO_PROCESSED support
Thread-Topic: [PATCH v1 0/3] iio: afe: rescale: Add INFO_PROCESSED support
Thread-Index: AQHVIDwQ2wrcSoZDXECKyQXOexLw8aaWScMA
Date:   Tue, 11 Jun 2019 11:02:14 +0000
Message-ID: <36890130-24ed-2200-1e8d-964612fee62d@axentia.se>
References: <20190611095659.29845-1-mylene.josserand@bootlin.com>
In-Reply-To: <20190611095659.29845-1-mylene.josserand@bootlin.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1P190CA0018.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::28)
 To DB3PR0202MB3434.eurprd02.prod.outlook.com (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3b43a9f-0872-4b61-9923-08d6ee5c426a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3419;
x-ms-traffictypediagnostic: DB3PR0202MB3419:
x-microsoft-antispam-prvs: <DB3PR0202MB341951A8E419C08E520033B5BCED0@DB3PR0202MB3419.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(396003)(376002)(39830400003)(53754006)(52314003)(189003)(199004)(8676002)(25786009)(6246003)(5660300002)(53546011)(7416002)(76176011)(102836004)(99286004)(36756003)(68736007)(6506007)(386003)(66574012)(81166006)(81156014)(52116002)(31696002)(3846002)(486006)(6512007)(6116002)(14444005)(256004)(6436002)(2501003)(2906002)(4326008)(65956001)(65806001)(66066001)(66446008)(64756008)(66556008)(66476007)(446003)(11346002)(8936002)(73956011)(53936002)(66946007)(2616005)(476003)(2201001)(229853002)(14454004)(6486002)(74482002)(186003)(26005)(7736002)(305945005)(64126003)(65826007)(86362001)(54906003)(31686004)(110136005)(58126008)(508600001)(71200400001)(71190400001)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3419;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MK/Wr5yYdUBuONaQPKvtf+/q+1F5FpaMgck7r9ii1NwY6ueNSiYVOMGVGBXdakMP4IL2qwcwx/wWcE3lLdQ7cpoeYpRqMnPviO8VwAv9f0SaEha45unKI6OINNZDCZWQnTRFU8Gkrqfud66GIsu4NLOUcJe9VKMOLuwlAnLa0HOeUF+sFs6VGe6evv7Xe1thgYLBPjDhC1VYaGJPCJ8DMO2XrxgRoSRUWFISaK4r7a7FlW45ir8U08ZBOgwExpXmWFc6Kk2Jl2Y/aHp4ZPR/t5cWE1iOFxlH+iArjIKGeSxkEXEUzwVa4Fd4qBXqqzNQa1RdmB9NWEua8s4ZBqXIp/ToH4SUEq6dvvwSsFTt3e1KulX+ynzps0wAZiUGzwx6PY2opJWGOTQ9afrfvXdSVL1emA66AEUxixgT7JPwUoE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7D25203C01DD6489FDB4D707A76C402@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b43a9f-0872-4b61-9923-08d6ee5c426a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 11:02:14.1206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peda@axentia.se
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3419
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMjAxOS0wNi0xMSAxMTo1NiwgTXlsw6huZSBKb3NzZXJhbmQgd3JvdGU6DQo+IEhlbGxvIGV2
ZXJ5b25lLA0KPiANCj4gWW91IHdpbGwgZmluZCBhIHNtYWxsIHNlcmllcyB0aGF0IGFkZCB0aGUg
c3VwcG9ydCBvZiBwcm9jZXNzZWQgdmFsdWVzDQo+IGZvciBpaW8tcmVzY2FsZSBkcml2ZXIuDQo+
IFRoYW5rcyB0byB0aGF0LCBpdCBpcyBwb3NzaWJsZSB0byByZWFkIHByb2Nlc3NlZCB2YWx1ZXMg
aW4gc3lzZnMgaW5zdGVhZA0KPiBvZiBnZXR0aW5nIG9ubHkgcmF3IGFuZCBzY2FsZSB2YWx1ZXMu
DQo+IA0KPiBIZXJlIGlzIGFuIGV4YW1wbGUgZm9yIGEgM3YzIHZvbHRhZ2UgcmVhZGluZzoNCj4g
IyBjYXQgL3N5cy9idXMvaWlvL2RldmljZXMvaWlvXDpkZXZpY2UxL2luX3ZvbHRhZ2UwX3NjYWxl
DQo+IDMuNzkxMDE1NjI1DQo+ICMgY2F0IC9zeXMvYnVzL2lpby9kZXZpY2VzL2lpb1w6ZGV2aWNl
MS9pbl92b2x0YWdlMF9yYXcNCj4gODc5DQo+ICMgY2F0IC9zeXMvYnVzL2lpby9kZXZpY2VzL2lp
b1w6ZGV2aWNlMS9pbl92b2x0YWdlMF9pbnB1dA0KPiAzMzMyDQo+IA0KPiBJdCBpcyBhbHNvIHBv
c3NpYmxlIHRvIHJlYWQgZGlyZWN0bHkgdGhlIHByb2Nlc3NlZCB2YWx1ZXMgdXNpbmcgaWlvLWh3
bW9uDQo+IGRyaXZlciAoc2VlIGV4YW1wbGUgaW4gcGF0Y2gwMyk6DQo+IA0KPiAjIGNhdCAvc3lz
L2NsYXNzL2h3bW9uL2h3bW9uMC9pbjFfaW5wdXQNCj4gMzMyOA0KPiANCj4gSSBzZXBlcmF0ZWQg
bXkgc2VyaWVzIGluIDMgcGF0Y2hlczoNCj4gICAgLSBQYXRjaDAxOiBNb3ZlIHRoZSBzY2FsZSBj
b252ZXJzaW9uIGludG8gYSBmdW5jdGlvbiB0byBwcmVwYXJlIHRoZQ0KPiAgICBzdXBwb3J0IG9m
IElJT19DSEFOX0lORk9fUFJPQ0VTU0VELg0KPiAgICAtIFBhdGNoMDI6IEFkZCB0aGUgc3VwcG9y
dCBvZiBJSU9fQ0hBTl9JTkZPX1BST0NFU1NFRC4NCj4gICAgLSBQYXRjaDAzOiBBZGQgYW4gZXhh
bXBsZSBvZiB0aGUgdXNlIG9mIGh3bW9uIGFuZCB2b2x0YWdlLWRpdmlkZXIgbm9kZXMNCj4gICAg
aW4gZGV2aWNlLXRyZWUuDQo+IA0KPiBJZiB5b3UgaGF2ZSBhbnkgZmVlZGJhY2tzIG9uIGl0LCBJ
IHdpbGwgYmUgcGxlYXNlZCB0byByZWFkIHRoZW0hDQoNCg0KVGhlIGxhc3QgcGF0Y2ggYWJvdXQg
aHdtb24gaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCB0aGlzIHNlcmllcywgYW5kDQpzaG91bGQgYmUg
cG9zc2libGUgYXMtaXMgd2l0aG91dCBhbnkgY29kZSBjaGFuZ2VzLiBObz8gQUZBSUNULA0KaWlv
X2h3bW9uIGNhbGxzIGlpb19yZWFkX2NoYW5uZWxfcHJvY2Vzc2VkLCB3aGljaCBjYWxscw0KaWlv
X2NvbnZlcnRfcmF3X3RvX3Byb2Nlc3NlZF91bmxvY2tlZCBpbiBjYXNlIElJT19DSEFOX0lORk9f
UFJPQ0VTU0VTDQppcyBub3QgaGFuZGxlZCBieSB0aGUgZHJpdmVyLiBJcyB0aGF0IG5vdCB3b3Jr
aW5nPw0KDQpUaGVyZSBpcyBhbHNvIGxpYmlpbyBpbiB1c2Vyc3BhY2UgdGhhdCBwcm92aWRlcyB0
aGUgc2NhbGUgYXMgYSBkb3VibGUNCmFuZCBtYWtlcyB0aGUgY29udmVyc2lvbiB0byBhIHByb2Nl
c3NlZCB2YWx1ZSB0cml2aWFsLCBzbyB0aGUgc2VyaWVzDQppcyByZWFsbHkgbW9zdGx5IGFib3V0
IHRoZSBjb252ZW5pZW5jZSBvZiBoYXZpbmcgYSBodW1hbiBkaXJlY3RseQ0Kc2VlaW5nIHRoZSBw
cm9jZXNzZWQgdmFsdWUgaW4gc3lzZnMuIFJpZ2h0Pw0KDQpJZiB0aGF0IGlzIGRlZW1lZCB2YWx1
YWJsZSwgdGhlbiBJIHRoaW5rIGl0IHNob3VsZCBiZSBmaXhlZCBpbiBhDQpjZW50cmFsIGxvY2F0
aW9uLCBhbmQgbm90IGluZGl2aWR1YWxseSBmb3IgZWFjaCBhbmQgZXZlcnkgZHJpdmVyLg0KDQpB
bnl3YXksIG5vdCBteSBjYWxsLCBqdXN0IHN0YXRpbmcgbXkgb3BpbmlvbiwgYnV0IHRob3NlIGFy
ZSB0aGUNCnJlYXNvbnMgZm9yIG1lIG5vdCBhZGRpbmcgYSBwcm9jZXNzZWQgY2hhbm5lbCBmcm9t
IHRoZSB2ZXJ5IGJlZ2lubmluZy4NCg0KQ2hlZXJzLA0KUGV0ZXINCg0KPiBCZXN0IHJlZ2FyZHMs
DQo+IE15bMOobmUNCj4gDQo+IE15bMOobmUgSm9zc2VyYW5kICgzKToNCj4gICBpaW86IGFmZTog
cmVzY2FsZTogTW92ZSBzY2FsZSBjb252ZXJzaW9uIHRvIG5ldyBmdW5jdGlvbg0KPiAgIGlpbzog
YWZlOiByZXNjYWxlOiBBZGQgc3VwcG9ydCBvZiBDSEFOX0lORk9fUFJPQ0VTU0VEDQo+ICAgZHQt
YmluZGluZ3M6IGlpbzogYWZlOiBBZGQgaHdtb24gZXhhbXBsZQ0KPiANCj4gIC4uLi9iaW5kaW5n
cy9paW8vYWZlL3ZvbHRhZ2UtZGl2aWRlci50eHQgICAgICAgICAgIHwgMjQgKysrKysrDQo+ICBk
cml2ZXJzL2lpby9hZmUvaWlvLXJlc2NhbGUuYyAgICAgICAgICAgICAgICAgICAgICB8IDk2ICsr
KysrKysrKysrKysrKystLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygr
KSwgMjQgZGVsZXRpb25zKC0pDQo+IA0KDQo=
