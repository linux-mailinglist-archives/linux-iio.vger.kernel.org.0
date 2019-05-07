Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F4F165BA
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2019 16:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEGOck (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 May 2019 10:32:40 -0400
Received: from mail-eopbgr140113.outbound.protection.outlook.com ([40.107.14.113]:57907
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbfEGOcj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 May 2019 10:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qza6IHX+hKdX5TjcTSI7Ls2l15Iujxn1t4ITBoru/OU=;
 b=lGaQgtg+CXuM/upkaDynoiT1Urh9rowKCH8Jv109Y03GL50MhThjCxP8uTwP1RPKzwMZP2saPgRUr5d1dUGQ6A+gQQiNe0m2wvNlY2u9QoBy6vOQ0mkcIHZr+0tpk373hjFEaErEyDpZ5lE9szTBuV14An1hskFNVlJcyFIK4AY=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3949.eurprd05.prod.outlook.com (52.134.17.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Tue, 7 May 2019 14:32:34 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::48ff:f344:98da:6571]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::48ff:f344:98da:6571%5]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 14:32:34 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "stefan@agner.ch" <stefan@agner.ch>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 3/3] iio: stmpe-adc: Enable all stmpe-adc interrupts just
 once
Thread-Topic: [PATCH 3/3] iio: stmpe-adc: Enable all stmpe-adc interrupts just
 once
Thread-Index: AQHVAbgvFNqOXB7C206ClJrrQiiX+6Zcr5GAgAMQagA=
Date:   Tue, 7 May 2019 14:32:34 +0000
Message-ID: <80da5f910849a1ee79e1e75cd43a8650c151a159.camel@toradex.com>
References: <20190503135725.9959-1-dev@pschenker.ch>
         <20190503135725.9959-3-dev@pschenker.ch>
         <20190505164503.030d6687@archlinux>
In-Reply-To: <20190505164503.030d6687@archlinux>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 814fc5a0-a8f1-4c74-0ed6-08d6d2f8d8bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR0502MB3949;
x-ms-traffictypediagnostic: VI1PR0502MB3949:
x-microsoft-antispam-prvs: <VI1PR0502MB39499B01D3CFD006C10390F2F4310@VI1PR0502MB3949.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39850400004)(376002)(366004)(396003)(346002)(189003)(199004)(11346002)(2616005)(44832011)(3846002)(6116002)(4326008)(316002)(81156014)(476003)(8936002)(446003)(186003)(8676002)(6916009)(26005)(478600001)(6486002)(2351001)(25786009)(2906002)(81166006)(66066001)(486006)(14454004)(2501003)(5660300002)(102836004)(73956011)(6506007)(86362001)(256004)(66556008)(64756008)(66446008)(76116006)(76176011)(53936002)(91956017)(6246003)(66476007)(229853002)(118296001)(7416002)(68736007)(71200400001)(71190400001)(6436002)(54906003)(5640700003)(36756003)(6512007)(99286004)(66946007)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3949;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u+46fBJEKdqHnmF8XCC99w+PUJHzYh9f7QjN6Bpgjb8H0biSa+2OsaXJgP5xD3o9jcJsXlMIlzt0888kIlaaL4hNoGZAu+8j1pPe3NLi4HyPOSln4MowV+KBrZs4Wwk4NoYwlyo2qjqhdtfCxNX2L0QPGrEQA3YeYsMULjGnyz0b8Js6M6PqUwbcHUCvr7lnxiT9in6TNIAI5ww4mzDyL97sO/gPI1963EXr6ekz8mXpLiI2Kjo7djWt9W4XsNGq48n4TYQHqp2ma4bjxs9OT8v7PxNYP7QTJ7eBqdgsjUnMGISfF5JvJERK6lSDs5aPZsrIBKLImne4G9eQgCUebuwVTWxBVzfjTF+UysI5OveJBroeGf6IQ01twfj/ZVF2HOh2SrZmMQ5MTuOQzoaeJ/twWr7+DSzx96kSYAtBNmY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FE1A1E2965DD7419C8F49FF4A480B68@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814fc5a0-a8f1-4c74-0ed6-08d6d2f8d8bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 14:32:34.8385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3949
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTA1LTA1IGF0IDE2OjQ1ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBGcmksICAzIE1heSAyMDE5IDE1OjU3OjI1ICswMjAwDQo+IFBoaWxpcHBlIFNjaGVu
a2VyIDxkZXZAcHNjaGVua2VyLmNoPiB3cm90ZToNCj4gDQo+ID4gRnJvbTogUGhpbGlwcGUgU2No
ZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KPiA+IA0KPiA+IFRoaXMgY29t
bWl0IHdpbGwgZW5hYmxlIHRoZSBpbnRlcnJ1cHRzIG9mIGFsbCBjaGFubmVscyBoYW5kbGVkIGJ5
IHRoaXMNCj4gPiBkcml2ZXIgb25seSBvbmNlIGluIHRoZSBwcm9iZSBmdW5jdGlvbi4NCj4gPiAN
Cj4gPiBUaGlzIHdpbGwgaW1wcm92ZSBwZXJmb3JtYW5jZSBiZWNhdXNlIG9uZSBieXRlIGxlc3Mg
aGFzIHRvIGJlIHdyaXR0ZW4gb3Zlcg0KPiA+IGkyYyBvbiBlYWNoIHJlYWQgb3V0IG9mIHRoZSBh
ZGMuIE9uIHRoZSBmYXN0ZXN0IEFEQyBtb2RlIHRoaXMgd2lsbCBpbXByb3ZlDQo+ID4gcmVhZCBv
dXQgc3BlZWQgYnkgMTUlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIFNjaGVu
a2VyIDxwaGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4NCj4gTWFrZXMgc2Vuc2UuIEknbGwg
cGljayB0aGlzIHVwIG9uY2UgcGF0Y2ggMiBkaXNjdXNzaW9uIGlzIHNvcnRlZC4NCj4gDQo+IEpv
bmF0aGFuDQoNClBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaCBoZXJlIGFzIEkgc2VuZCBhIGNvbXBs
ZXRlbHkgbmV3IHNlcmllcyB0aGF0IGluY2x1ZGVzDQp0aGlzIG9uZS4NCj4gDQo+ID4gLS0tDQo+
ID4gDQo+ID4gIGRyaXZlcnMvaWlvL2FkYy9zdG1wZS1hZGMuYyB8IDYgKysrLS0tDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9zdG1wZS1hZGMuYyBiL2RyaXZlcnMvaWlvL2Fk
Yy9zdG1wZS1hZGMuYw0KPiA+IGluZGV4IGJhYTQxZmZjMGQ3Ni4uNDI3Yzg5MGM2ZTdkIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9zdG1wZS1hZGMuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvaWlvL2FkYy9zdG1wZS1hZGMuYw0KPiA+IEBAIC03Miw5ICs3Miw2IEBAIHN0YXRpYyBpbnQg
c3RtcGVfcmVhZF92b2x0YWdlKHN0cnVjdCBzdG1wZV9hZGMgKmluZm8sDQo+ID4gIAkJcmV0dXJu
IC1FSU5WQUw7DQo+ID4gIAl9DQo+ID4gIA0KPiA+IC0Jc3RtcGVfcmVnX3dyaXRlKGluZm8tPnN0
bXBlLCBTVE1QRV9SRUdfQURDX0lOVF9FTiwNCj4gPiAtCQkJU1RNUEVfQURDX0NIKGluZm8tPmNo
YW5uZWwpKTsNCj4gPiAtDQo+ID4gIAlzdG1wZV9yZWdfd3JpdGUoaW5mby0+c3RtcGUsIFNUTVBF
X1JFR19BRENfQ0FQVCwNCj4gPiAgCQkJU1RNUEVfQURDX0NIKGluZm8tPmNoYW5uZWwpKTsNCj4g
PiAgDQo+ID4gQEAgLTMyOCw2ICszMjUsOSBAQCBzdGF0aWMgaW50IHN0bXBlX2FkY19wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJaWYgKHJldCkNCj4gPiAgCQlyZXR1
cm4gcmV0Ow0KPiA+ICANCj4gPiArCXN0bXBlX3JlZ193cml0ZShpbmZvLT5zdG1wZSwgU1RNUEVf
UkVHX0FEQ19JTlRfRU4sDQo+ID4gKwkJCX4obm9yZXF1ZXN0X21hc2sgJiAweEZGKSk7DQo+ID4g
Kw0KPiA+ICAJcmV0dXJuIGRldm1faWlvX2RldmljZV9yZWdpc3RlcigmcGRldi0+ZGV2LCBpbmRp
b19kZXYpOw0KPiA+ICB9DQo+ID4gIA0K
