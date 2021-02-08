Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101B3312B80
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 09:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBHINV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 03:13:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2519 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhBHINQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 03:13:16 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DYzCV2qd1z67lRm;
        Mon,  8 Feb 2021 16:07:34 +0800 (CST)
Received: from lhreml713-chm.china.huawei.com (10.201.108.64) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 09:12:25 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml713-chm.china.huawei.com (10.201.108.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 08:12:23 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Mon, 8 Feb 2021 16:12:21 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Michael Hennerich <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 21/24] dt-bindings:iio:cdc:adi,ad7150 binding doc
Thread-Topic: [PATCH 21/24] dt-bindings:iio:cdc:adi,ad7150 binding doc
Thread-Index: AQHW/WjR86DKZNfgyEaoAH5ZJEi/1apMU8IAgAGTsaA=
Date:   Mon, 8 Feb 2021 08:12:21 +0000
Message-ID: <8967afd32123482482af599b199e347b@hisilicon.com>
References: <20210207154623.433442-1-jic23@kernel.org>
 <20210207154623.433442-22-jic23@kernel.org>
 <1840bd30-be94-761e-403d-59b13eeef774@metafoo.de>
In-Reply-To: <1840bd30-be94-761e-403d-59b13eeef774@metafoo.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.200]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFycy1QZXRlciBDbGF1
c2VuIFttYWlsdG86bGFyc0BtZXRhZm9vLmRlXQ0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDgs
IDIwMjEgNTowMCBBTQ0KPiBUbzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47
IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE1pY2hhZWwgSGVubmVyaWNoIDxNaWNo
YWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsgU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKQ0KPiA8
c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7IEpvbmF0aGFu
IENhbWVyb24NCj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMjEvMjRdIGR0LWJpbmRpbmdzOmlp
bzpjZGM6YWRpLGFkNzE1MCBiaW5kaW5nIGRvYw0KPiANCj4gT24gMi83LzIxIDQ6NDYgUE0sIEpv
bmF0aGFuIENhbWVyb24gd3JvdGU6DQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0aWJs
ZQ0KPiA+ICsgIC0gcmVnDQo+IA0KPiBJcyB2ZGQtc3VwcGx5IHJlYWxseSBvcHRpb25hbCB0aGUg
d2F5IGl0IGlzIGltcGxlbWVudGVkIGluIHRoZSBkcml2ZXI/DQo+IA0KPiA+ICsNCj4gPiArYWRk
aXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAt
IHwNCj4gPiArICAgIGkyYyB7DQo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+
ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKw0KPiA+ICsgICAgICAgIGNkY0A0
OCB7DQo+ID4gKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYWRpLGFkNzE1MCI7DQo+ID4gKyAg
ICAgICAgICAgIHJlZyA9IDwweDQ4PjsNCj4gPiArICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwy
NSAyPiwgPDI2IDI+Ow0KDQpPbmUgcXVlc3Rpb24sIGhlcmUgd2UgaGF2ZSB0d28gaW50ZXJydXB0
cywgYnV0IHRoZSBkcml2ZXIgaXMgcmVhZGluZw0Kb25lIGludGVycnVwdCBvbmx5LCBkbyB3ZSBu
ZWVkIHRvIGNhbGwNCm9mX2lycV9nZXQoZGV2LCBpbmRleCkNCm9yDQpvZl9pcnFfZ2V0X2J5bmFt
ZSgpPw0KDQoNCj4gDQo+IEkgd29uZGVyIGlmIHdlIHNob3VsZCB1c2UgdGhlIHN5bWJvbGljIGNv
bnN0YW50cyBmb3IgdGhlIElSUSB0eXBlIHRvDQo+IG1ha2UgdGhlIGV4YW1wbGUgbW9yZSBjbGVh
ci4gRS5nLg0KPiANCj4gaW50ZXJydXB0cyA9IDwyNSBJUlFfVFlQRV9FREdFX0ZBTExJTkc+LCAu
Li4NCj4gDQo+ID4gKyAgICAgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JmdwaW8+Ow0KPiA+
ICsgICAgICAgIH07DQo+ID4gKyAgICB9Ow0KPiA+ICsuLi4NCj4gDQpUaGFua3MNCkJhcnJ5DQoN
Cg==
