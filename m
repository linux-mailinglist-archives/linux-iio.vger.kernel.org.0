Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 441B5165B5
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2019 16:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfEGOb5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 May 2019 10:31:57 -0400
Received: from mail-eopbgr40109.outbound.protection.outlook.com ([40.107.4.109]:32686
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbfEGOb5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 May 2019 10:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8p7dJeec2rydzXAsQFgVikLcIA0qKJ/k1RuN3ew8/fc=;
 b=gfC81bEt4gHl3B//jwASDBP1MrYb1JqeKoUYaS3261hb/W9Mk7rk6fqD7JoMHs2b2WqG+TWCZsO1dEax2VzQokTn3clvLVm/23syU4J0yHd1gxVgMIOYb+KFSmOl9lTd08+ZYbOOOQ5934s9TPhexHUM9SU3snpV4H2kpVHhe5s=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3871.eurprd05.prod.outlook.com (52.134.5.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 14:31:49 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::48ff:f344:98da:6571]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::48ff:f344:98da:6571%5]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 14:31:49 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>
CC:     "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: stmpe-adc: Make wait_completion non
 interruptible
Thread-Topic: [PATCH 2/3] iio: stmpe-adc: Make wait_completion non
 interruptible
Thread-Index: AQHVAbgvhKEqeNeMGUGopQqxfyxbHKZZeJoAgAAWGICAAyCfgIACqXCAgABnAwA=
Date:   Tue, 7 May 2019 14:31:49 +0000
Message-ID: <69a00774deb5d5c8f5611855fa354cccbe92a6aa.camel@toradex.com>
References: <20190503135725.9959-1-dev@pschenker.ch>
         <20190503135725.9959-2-dev@pschenker.ch>
         <0aab3e91bb9644acb430a8beba927b5a@AcuMS.aculab.com>
         <1aa6533aa8b1bf4a01c1c5f8d6a208337be6b57e.camel@toradex.com>
         <20190505164409.7976f43e@archlinux>
         <4df31129d19c4128a4bbc5e0575886af@AcuMS.aculab.com>
In-Reply-To: <4df31129d19c4128a4bbc5e0575886af@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edff2429-5768-4af5-3c7b-08d6d2f8bdb8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR0502MB3871;
x-ms-traffictypediagnostic: VI1PR0502MB3871:
x-microsoft-antispam-prvs: <VI1PR0502MB38716A831BBC8E868036A6C0F4310@VI1PR0502MB3871.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(39850400004)(366004)(376002)(199004)(189003)(2906002)(68736007)(36756003)(229853002)(2501003)(6512007)(7416002)(316002)(8936002)(99286004)(6486002)(3846002)(6436002)(6116002)(71200400001)(71190400001)(446003)(2616005)(476003)(478600001)(11346002)(81156014)(81166006)(256004)(14444005)(14454004)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(91956017)(73956011)(486006)(44832011)(7736002)(66066001)(4326008)(110136005)(25786009)(6246003)(53936002)(305945005)(118296001)(6506007)(54906003)(76176011)(26005)(8676002)(86362001)(186003)(5660300002)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3871;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ESKjahfAQepahqpyGtg7Jfk7YuJwd4S55SEFeGtQ5+9dUBfkh0F6PLGUefKgxY0r7DMZzgH8poNX+xoy2NdtVK2J3TaNaoOsn7p6tn/bAwjiZxluIoCNL3nsav3r6USRAAGOdR7/NGXM/fbp//1D8xiXWafZNyj5/WTxzo90ZARcWNkRAe12w8lqfKdtyQtiu8wb4Q+dYZDtIah0zoaqIcHJotjo7Xqx8EOFKVxgPfIXzZs1UGIaChJPTFCGPPVrvXGakLhNqKS1rO6eHFO3irXNUsHfPfbUd1+M4m9IM5LaHMAH1VU6MWC4LyLc4GTl2SmQU20brjPjnNR8od1b2xDNY1OqZnHUMYhRA2nonEFiM701hOjVgDTsVCr7FXisZZ0tykFazQFmZ+lTyazusyUf1YgeYQ07UUgKIcIV21Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAA6079BD1A28F43886E8BD45814DA37@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edff2429-5768-4af5-3c7b-08d6d2f8bdb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 14:31:49.4663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3871
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTA1LTA3IGF0IDA4OjIzICswMDAwLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+
IEZyb206IEpvbmF0aGFuIENhbWVyb24NCj4gPiBTZW50OiAwNSBNYXkgMjAxOSAxNjo0NA0KPiA+
IE9uIEZyaSwgMyBNYXkgMjAxOSAxNTo1ODozOCArMDAwMA0KPiA+IFBoaWxpcHBlIFNjaGVua2Vy
IDxwaGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gPiBPbiBG
cmksIDIwMTktMDUtMDMgYXQgMTQ6MzkgKzAwMDAsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiA+
ID4gRnJvbTogUGhpbGlwcGUgU2NoZW5rZXINCj4gPiA+ID4gPiBTZW50OiAwMyBNYXkgMjAxOSAx
NDo1Nw0KPiA+ID4gPiA+IEluIHNvbWUgY2FzZXMsIHRoZSB3YWl0X2NvbXBsZXRpb24gZ290IGlu
dGVycnVwdGVkLiBUaGlzIGNhdXNlZCB0aGUNCj4gPiA+ID4gPiBlcnJvci1oYW5kbGluZyB0byBt
dXRleF91bmxvY2sgdGhlIGZ1bmN0aW9uLiBUaGUgYmVmb3JlIHR1cm5lZCBvbg0KPiA+ID4gPiA+
IGludGVycnVwdCB0aGVuIGdvdCBjYWxsZWQgYW55d2F5LiBJbiB0aGUgSVNSIHRoZW4gY29tcGxl
dGlvbigpDQo+ID4gPiA+ID4gd2FzIGNhbGxlZCBjYXVzaW5nIHByb2JsZW1zLg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IE1ha2luZyB0aGlzIHdhaXRfY29tcGxldGlvbiBub24gaW50ZXJydXB0aWJs
ZSBzb2x2ZXMgdGhlIHByb2JsZW0uDQo+ID4gPiA+IA0KPiA+ID4gPiBXb24ndCB0aGUgc2FtZSB0
aGluZyBoYXBwZW4gaWYgdGhlIGludGVycnVwdCBvY2N1cnMganVzdCBhZnRlcg0KPiA+ID4gPiB0
aGUgdGltZW91dD8NCj4gPiA+ID4gDQo+ID4gPiA+IAlEYXZpZA0KPiA+ID4gPiANCj4gPiA+ID4g
DQo+ID4gPiA+IC0NCj4gPiA+ID4gUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsDQo+ID4gPiA+IE1LMSAxUFQsDQo+ID4g
PiA+IFVLDQo+ID4gPiA+IFJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo+ID4gPiA+
IA0KPiA+ID4gDQo+ID4gPiBZb3UncmUgb2YgY291cnNlIHJpZ2h0Li4uIFRoYW5rcyBmb3IgcG9p
bnRpbmcgdGhpcyBvdXQuIEkgd2lsbCBzZW5kIGEgdjINCj4gPiA+IHdpdGggYQ0KPiA+ID4gYmV0
dGVyIHNvbHV0aW9uIHRoZW4uDQo+ID4gPiANCj4gPiANCj4gPiBJc24ndCB0aGUgdGltZW91dCBs
b25nIGVub3VnaCB0aGF0IGl0IHNob3VsZCBvbmx5IGhhcHBlbiBpZiB0aGUgaGFyZHdhcmUgaGFz
DQo+ID4gYSBmYXVsdD8gSWYgdGhhdCdzIHRoZSBjYXNlLCBJIHdvdWxkbid0IHdvcnJ5IHRvbyBt
dWNoIGFib3V0IHBvc3NpYmlsaXR5IG9mDQo+ID4gYW4gaW50ZXJydXB0IGNhdXNpbmcgY29uZnVz
aW9uIGFzIGxvbmcgYXMgaXQgaXNuJ3QgY2F0YXN0cm9waGljLg0KPiANCj4gVGhlICdjb25mdXNp
b24nIGlzIGxpa2VseSB0byBiZSAnY2F0YXN0cm9waGljJyB1bmxlc3MgdGhlIGNvZGUgaXMgd3Jp
dHRlbg0KPiB0byBoYW5kbGUgaXQgcHJvcGVybHkuDQo+IA0KPiBDYW5jZWxsaW5nIGNhbGxiYWNr
cyBpcyBoYXJkIHRvIGdldCByaWdodCBhbmQgb2Z0ZW4gbm90IGRvbmUgcHJvcGVybHkuDQo+IFRp
bWluZyBvdXQgYW4gaW50ZXJydXB0IGlzIG11Y2ggdGhlIHNhbWUgcHJvYmxlbS4NCj4gDQo+IAlE
YXZpZA0KDQpJIHNvcnRlZCBpdCBvdXQgbm93LCB0aGVyZSB3aGVyZSBhbHNvIHNvbWUgbW9yZSBi
dWdzIEkgZm91bmQgYW5kIGNvcnJlY3RlZC4NCg0KQEpvbmF0aGFuOiBJIHdpbGwgc2VuZCBhIGNv
bXBsZXRlbHkgbmV3IHNlcmllcyBvZiBwYXRjaGVzIHRoYXQgd2lsbCBpbmNsdWRlDQpwYXRjaCAz
LzMgZnJvbSB0aGlzIHNlcmllcyBidXQgbm90IHRoZSBvbmUgeW91IGFscmVhZHkgYXBwbGllZC4g
VGhpcyBkdWUgdG8NCmluY3JlYXNlZCBwYXRjaCBudW1iZXIgYW5kIGRpZmZlcmVudCBvcmRlci4u
Lg0KPiANCj4gLQ0KPiBSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwNCj4gVUsNCj4gUmVnaXN0cmF0aW9u
IE5vOiAxMzk3Mzg2IChXYWxlcykNCj4gDQo=
