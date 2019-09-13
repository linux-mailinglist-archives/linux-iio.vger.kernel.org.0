Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 478EBB199D
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387458AbfIMI31 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:29:27 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:17556 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387435AbfIMI31 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:29:27 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8S9Us026748;
        Fri, 13 Sep 2019 04:28:57 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2059.outbound.protection.outlook.com [104.47.45.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uytd1h8kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:28:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CI12RNQ2iQ72m+2hvJ0Yom6aQbhO+YR5sOZryKBKIPi9CbTR2JV/gfEagjrWMkMiXnDNs4u9MPajwalkNwSj5G02m0zFIiBK8WyDwrh7ck7oheEK27yrXgC9D8dZb/jrhZo3DFKGcXMJHjRoT0b7WFHQ+f2zX0D/XsnBhWbq1247AgEjKAg4cbOaBg/YgX/rPDmNQzyareUFaq+altWX8vKa3k7We64/otaPyjNrUb6PM9cko/7BKdR+ukI/x1geQGti2hC47gUCb/rELECmgqb4XMH0B07QoSBdSMm3bbaHNRIpswx3UO27HSE84u3FzNzqTHU0ezlBLcT89b9xgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqbZdQ6jbmFStM3M7/1trgEMvKqQ26J3tGMhWjMzrd8=;
 b=eVDFTmTojYqTGUmDEJrFbH3LlYBnYCGDqq8Ni2qolLj6oEiaXU845RSbUW43bWCII9gVPhPhPMUXanZg0P3j4RDzfYHRbTDqs7aRz4tNgKnuDUi1VHczlJI7Mze38OB3btNHde/B1vfoYFbrOgWeaeWy1zwAxwrBe7l/bjad91zar+hL5pG4+miDCjJ0kK1BgniXhIQmbcf3zbDJdJQTKQbe1ZV/zLm4wd4iYDfVaYatrX9bIMV2ZF3URb7lvrz3LtSoaf+RD3Zu+02+MYI4Tve723w+BOwND7GeNJnrliJ/23cD+Ltwum/V8QVEowIh0MsqJoOUDfVNaWDdAfjAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqbZdQ6jbmFStM3M7/1trgEMvKqQ26J3tGMhWjMzrd8=;
 b=DA6mn8kbtVM1QKfsQp4g5wEdRGcgFm1FvleoZGPrqgZFcjuPp9dIKO1vMyTsEVGUiK5H1F0hM+K/OtA4/J3TKYNufjWfRtPIoLMHsiT4tPnjYKP2er4ez9CCqzaPGB0cy3zLQwxP91YtUkwbXJWaEBDnR4JyqaQfSRx/Zrw0sxQ=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5287.namprd03.prod.outlook.com (20.180.14.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Fri, 13 Sep 2019 08:28:55 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2263.021; Fri, 13 Sep 2019
 08:28:55 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andrea.merello@gmail.com" <andrea.merello@gmail.com>
CC:     "antoine.couret@essensium.com" <antoine.couret@essensium.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH 2/4] iio: ad7949: fix incorrect SPI xfer len
Thread-Topic: [PATCH 2/4] iio: ad7949: fix incorrect SPI xfer len
Thread-Index: AQHVaXh7nFtQMJGG0EuSl7ibaCkViqcpXS6A///hgQCAADs3gA==
Date:   Fri, 13 Sep 2019 08:28:55 +0000
Message-ID: <adfa8eb19b7da2c41ae0822ed1f43a44eea7c1db.camel@analog.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
         <20190912144310.7458-3-andrea.merello@gmail.com>
         <3fe869be01ce7c81fd463158c05e0a4a115bdd6a.camel@analog.com>
         <CAN8YU5MpLDVEfVBUBe9XsuYT6yohruiHAMQgOVjZs-2JyO=NNQ@mail.gmail.com>
In-Reply-To: <CAN8YU5MpLDVEfVBUBe9XsuYT6yohruiHAMQgOVjZs-2JyO=NNQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6448b1a6-e5be-462b-fbe2-08d738246aa9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR03MB5287;
x-ms-traffictypediagnostic: CH2PR03MB5287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5287100D031B9C9DA9C3F5C6F9B30@CH2PR03MB5287.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(346002)(376002)(199004)(43544003)(189003)(478600001)(2906002)(6246003)(76176011)(71200400001)(6116002)(3846002)(71190400001)(1361003)(7736002)(6512007)(305945005)(36756003)(4326008)(2351001)(76116006)(66556008)(5640700003)(66446008)(66946007)(64756008)(53936002)(14454004)(66476007)(66066001)(5660300002)(316002)(2501003)(26005)(102836004)(6506007)(256004)(54906003)(229853002)(186003)(81166006)(118296001)(25786009)(81156014)(8936002)(6916009)(2616005)(8676002)(86362001)(561944003)(99286004)(11346002)(486006)(446003)(476003)(6486002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5287;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RerYM1eD5domPzwMaA5pkIWse+tdZRv/knPDVTCj2XuDn97aNIf21q6mcLcqiX5eBF8KnT1QbUmtQWnEdF2ZboBQaY7QI0F5XfZ2d8hDz14Zv6Pkdr/c6dX1dY+1NcBfKpw/UUuYKvYCw6g2YMAJTMZ3KDU02T50/Ym+oOn+9dfqZvIEdxnl9zfCg7/tQZhpiOR3mOQtL49z4BOsD6+l8KEGSTiVqWw/gFcCfv1eXrZxHQiGKBoMREPbgfkdKjVViQ0bDJTskEpFKmXBFfE8/U0ME24JwP2N0pHOhxRBD82q7sjqF/Ud6E58dRpRbWaQwkX3KG4QNdUV2hDHMPmkDjbC6/hv5hMGAhAeXraQ1uwT0kzvU2JL28wAd7lTZ145v6g8O492IeKUp0mMQDieHbxjwd4E9h4YvOmdQGMJiUQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95EC937B0DC8B0499D359D18D7B1A554@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6448b1a6-e5be-462b-fbe2-08d738246aa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 08:28:55.4016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gefZdu38b2xA8TuCADc+JlJnIaOiM1wK02nHquGpj/YVkLkGDTtWwVJ2cTLaMUSU9h077cs+u9Yf8ogVV54aaBgjciBL9/Oa8u8WYwlY26A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5287
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130082
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDE5LTA5LTEzIGF0IDA5OjU2ICswMjAwLCBBbmRyZWEgTWVyZWxsbyB3cm90ZToN
Cj4gSWwgZ2lvcm5vIHZlbiAxMyBzZXQgMjAxOSBhbGxlIG9yZSAwODo0NiBBcmRlbGVhbiwgQWxl
eGFuZHJ1DQo+IDxhbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNvbT4gaGEgc2NyaXR0bzoNCj4g
PiBPbiBUaHUsIDIwMTktMDktMTIgYXQgMTY6NDMgKzAyMDAsIEFuZHJlYSBNZXJlbGxvIHdyb3Rl
Og0KPiA+ID4gW0V4dGVybmFsXQ0KPiA+ID4gDQo+ID4gPiBUaGlzIGRyaXZlciBzdXBwb3J0cyAx
NC1iaXRzIGFuZCAxNi1iaXRzIGRldmljZXMuIEFsbCBvZiB0aGVtIGhhdmUgYSAxNC1iaXQNCj4g
PiA+IGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXJzLiBBbGwgU1BJIHRyYXNmZXJzLCBmb3IgcmVhZGlu
ZyBBRCBjb252ZXJzaW9uDQo+ID4gPiByZXN1bHRzIGFuZCBmb3Igd3JpdGluZyB0aGUgY29uZmln
dXJhdGlvbiByZWdpc3RlciwgZml0IGluIHR3byBieXRlcy4NCj4gPiA+IA0KPiA+ID4gVGhlIGRy
aXZlciBhbHdheXMgdXNlcyA0LWJ5dGVzIHhmZXJzIHdoaWNoIHNlZW1zIGF0IGxlYXN0IHBvaW50
bGVzcyAobWF5YmUNCj4gPiA+IGV2ZW4gaGFybWZ1bCkuIFRoaXMgcGF0Y2ggdHJpbXMgdGhlIFNQ
SSB4ZmVyIGxlbiBhbmQgdGhlIGJ1ZmZlciBzaXplIHRvDQo+ID4gPiB0d28gYnl0ZXMuDQo+ID4g
PiANCj4gPiANCj4gPiBUaGUgbGVuZ3RoIHJlZHVjdGlvbiBwcm9wb3NhbCBpcyBmaW5lLg0KPiA+
IA0KPiA+IEJ1dCwgdGhpcyBwYXRjaCByYWlzZXMgYSBxdWVzdGlvbiBhYm91dCBlbmRpYW5lc3Mu
DQo+ID4gSSdtIGFjdHVhbGx5IHdvbmRlcmluZyBoZXJlIGlmIHdlIG5lZWQgdG8gc2VlIGFib3V0
IG1heWJlIHVzaW5nIGEgX19iZTE2IHZzIHUxNi4NCj4gPiANCj4gPiBJJ20gbm90IHRoYXQga2Vy
bmVsLXNhdnkgeWV0IGFib3V0IHNvbWUgb2YgdGhlc2UgbG93LWxldmVsIHRoaW5ncyB0byBiZSBj
b21wbGV0ZWx5IHN1cmUgaGVyZS4NCj4gPiBTbywgSSdkIGxldCBzb21lb25lIGVsc2UgbWF5YmUg
aGFuZGxlIGl0Lg0KPiANCj4gR29vZCBwb2ludC4uIEl0IHNlZW1zIHRoYXQgaW5kZWVkIG5vdCBt
dWNoIGNhcmUgaGFzIGJlZW4gdGFrZW4gYWJvdXQNCj4gZW5kaWFuZXNzIGhlcmUuLiBQcm9iYWJs
eSB3ZSBuZWVkIGFsc28gc29tZSBsZTE2X3RvX2NwdSgpIGFuZA0KPiBmaXJlbmRzLi4NCj4gDQo+
IE1heWJlIGFub3RoZXIgc2VwYXJhdGUgcGF0Y2ggY2FuIGJlIG1hZGUgdG8gdGFrZSBjYXJlIGFi
b3V0IGVuZGlhbmVzcyBsYXRlciBvbj8NCj4gDQoNClN1cmUuIEFub3RoZXIgcGF0Y2ggbWFrZXMg
c2Vuc2UuDQpCdXQsIEkgYW0gYml0IHZhZ3VlIGhlcmUgYWJvdXQgd2hhdCB0byBkby4NCkkgd291
bGQgY29weSBleGFtcGxlcyBmcm9tIG90aGVyIGRyaXZlcnMgYWJvdXQgaG93IHRoaW5ncyB3ZXJl
IGRvbmUuDQpUaGVyZSBzZWVtIHRvIGJlIG90aGVycyB0aGF0IGRpZCB0aGlzIGFscmVhZHkgc29t
ZWhvdy4NCg0KDQo+IEJUVyBBbHNvLCB0aGUgIF9fX19jYWNoZWxpbmVfYWxpZ25lZCBpcyBhIGJp
dCBzY2FyaW5nIDopIEkgZG9uJ3Qga25vdw0KPiB3aGF0IGlzIHRoYXQgZm9yLi4uDQoNCkknbSBz
dGlsbCBub3QgY29tcGxldGVseSBjbGVhciBvbiBfX19jYWNoZWxpbmVfYWxpZ25lZC4NCk1vc3Rs
eSBiZWNhdXNlIEkgZGlkIG5vdCBmaW5kIGFueSBpc3N1ZXMgdGhhdCBuZWVkZWQgaXQuDQpJIGp1
c3QgdXNlZCBpdCBiYXNlZCBvbiBob3cgb3RoZXJzIHVzZWQgaXQgYW5kIGFsbCB3YXMgZmluZS4N
CkZyb20gb2xkZXIgbm90ZXMsIGl0IGxvb2tzIGhlbHBmdWwgd2l0aCBETUEgYW5kIHNvbWUgbWVt
b3J5IGFsbG9jYXRpb24gc3R1ZmYuDQpCdXQgdGhpcyBhbHNvIGRlcGVuZHMgb24gYXJjaCA7IGZv
ciBzb21lIG9mIHRoZW0gaXQncyBlbXB0eS4NCg0KPiANCj4gPiBUaGFua3MNCj4gPiBBbGV4DQo+
ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgTWVyZWxsbyA8YW5kcmVhLm1lcmVsbG9A
Z21haWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9paW8vYWRjL2FkNzk0OS5jIHwg
NiArKystLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2FkNzk0
OS5jIGIvZHJpdmVycy9paW8vYWRjL2FkNzk0OS5jDQo+ID4gPiBpbmRleCA1MTgwNDRjMzFhNzMu
LjVjMmIzNDQ2ZmE0YSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hZDc5NDku
Yw0KPiA+ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL2FkNzk0OS5jDQo+ID4gPiBAQCAtNTQsNyAr
NTQsNyBAQCBzdHJ1Y3QgYWQ3OTQ5X2FkY19jaGlwIHsNCj4gPiA+ICAgICAgIHU4IHJlc29sdXRp
b247DQo+ID4gPiAgICAgICB1MTYgY2ZnOw0KPiA+ID4gICAgICAgdW5zaWduZWQgaW50IGN1cnJl
bnRfY2hhbm5lbDsNCj4gPiA+IC0gICAgIHUzMiBidWZmZXIgX19fX2NhY2hlbGluZV9hbGlnbmVk
Ow0KPiA+ID4gKyAgICAgdTE2IGJ1ZmZlciBfX19fY2FjaGVsaW5lX2FsaWduZWQ7DQo+ID4gPiAg
fTsNCj4gPiA+IA0KPiA+ID4gIHN0YXRpYyBpbnQgYWQ3OTQ5X3NwaV93cml0ZV9jZmcoc3RydWN0
IGFkNzk0OV9hZGNfY2hpcCAqYWQ3OTQ5X2FkYywgdTE2IHZhbCwNCj4gPiA+IEBAIC02Nyw3ICs2
Nyw3IEBAIHN0YXRpYyBpbnQgYWQ3OTQ5X3NwaV93cml0ZV9jZmcoc3RydWN0IGFkNzk0OV9hZGNf
Y2hpcCAqYWQ3OTQ5X2FkYywgdTE2IHZhbCwNCj4gPiA+ICAgICAgIHN0cnVjdCBzcGlfdHJhbnNm
ZXIgdHhbXSA9IHsNCj4gPiA+ICAgICAgICAgICAgICAgew0KPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgIC50eF9idWYgPSAmYWQ3OTQ5X2FkYy0+YnVmZmVyLA0KPiA+ID4gLSAgICAgICAgICAg
ICAgICAgICAgIC5sZW4gPSA0LA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIC5sZW4gPSAy
LA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIC5iaXRzX3Blcl93b3JkID0gYml0c19wZXJf
d29yZCwNCj4gPiA+ICAgICAgICAgICAgICAgfSwNCj4gPiA+ICAgICAgIH07DQo+ID4gPiBAQCAt
OTUsNyArOTUsNyBAQCBzdGF0aWMgaW50IGFkNzk0OV9zcGlfcmVhZF9jaGFubmVsKHN0cnVjdCBh
ZDc5NDlfYWRjX2NoaXAgKmFkNzk0OV9hZGMsIGludCAqdmFsLA0KPiA+ID4gICAgICAgc3RydWN0
IHNwaV90cmFuc2ZlciB0eFtdID0gew0KPiA+ID4gICAgICAgICAgICAgICB7DQo+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgLnJ4X2J1ZiA9ICZhZDc5NDlfYWRjLT5idWZmZXIsDQo+ID4gPiAt
ICAgICAgICAgICAgICAgICAgICAgLmxlbiA9IDQsDQo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgLmxlbiA9IDIsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgLmJpdHNfcGVyX3dvcmQg
PSBiaXRzX3Blcl93b3JkLA0KPiA+ID4gICAgICAgICAgICAgICB9LA0KPiA+ID4gICAgICAgfTsN
Cg==
