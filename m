Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94149B5BB0
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 08:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfIRGNb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 02:13:31 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:32380 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbfIRGNb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 02:13:31 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8I680x9029977;
        Wed, 18 Sep 2019 02:13:28 -0400
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2056.outbound.protection.outlook.com [104.47.34.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v37jg0ub8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 02:13:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OI/UUZe3V3fW84tnvGzMftrA72HUrLbPre4s7Yc1oBG/5V8MpRueiXJ4o3EDiIZFKjfghd51zr3P4zUerAlKah0T5PkJtI0jS0i2+kByu2+Bp/XLJi291eFrgtk6qdUG6lWJmzyfsNV01moG6Xs/09L8V3+SpC64P+eIxmT3yutHIw6qkYZJvSZOVAeWB/XpRZU/t8XvTcEpaxIySjxSCW9aLJfR96IisEMqULaoJ+XNWHX1Rpjscxbu10DQiGlxK+anYstpHa1eB6J6gqtlZvyOg4h1urnbrdKOthcw0zyFmiFTj7jzWNY1TV3dOlqp0zFW5/qeHJPTBuNbLg98JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVczxxSrFRZZk+Mojg/Ha0+fVj/D2NLsNmgHomLFVmk=;
 b=IoPiKlJXpDbAYVja+ELMOUa/3SKdy90VIWxh2rXNKrvbwes1naSnXMtOtGkaNe4u9A0/Q7XIV/zkLEr1Bq06SlJGP8iNwXppzj2zjTdSt3FWqeKJHnar/o1xMeOrbYX5srq9sNXZZ6tESIFcN9TJUmELtWwaBN2dQ3yEQDri/Qe6XcpbhGp6lh4dAdsDhzY8Dmr9F7f4mcO+Iumlr44XmPSkqobkJz12zrcmwjwr+UaJfNNggAvZY/t9hUOTRDPwVDA3hTST2gvavEN7NMC8IyCyreLBAPPY3J4rmxFxFIJRQatAzxauuzXpM5tTizM68MPz2vsuXlDbZftWDWdcNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVczxxSrFRZZk+Mojg/Ha0+fVj/D2NLsNmgHomLFVmk=;
 b=bRoyefhvXCtmMu0CT7F3ipGNZTWYPidjJ8N8kvugxedlpQMz+ze6ks9tlRNO9qyB7y6Woee+VVNm0D6D3MEP4sq+ULDxyposn+iO8ZEmZLwQZVVFQPhbuBH+SjR7vG5+bcyzecIYO11HInl5Vgt9+8npjYx6y3E85MMEHGktqe4=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5285.namprd03.prod.outlook.com (20.180.15.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 06:13:26 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2284.009; Wed, 18 Sep 2019
 06:13:26 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "djunho@gmail.com" <djunho@gmail.com>
CC:     "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Doubts in getting started with the Analog AD7928 driver
Thread-Topic: Doubts in getting started with the Analog AD7928 driver
Thread-Index: AQHVbOmDJqvXZ8MIiE2nOdnvDHBUzKcvma8AgAEB2wCAAI1HgA==
Date:   Wed, 18 Sep 2019 06:13:25 +0000
Message-ID: <74bff1fe1eab887d3d19f3cff3fc02afbc52a12d.camel@analog.com>
References: <CAKxs2cBVnL=6ZNbKgYRppaeUBM3xuog5BHdtmJHRxwttSfjugg@mail.gmail.com>
         <CAKxs2cC1Bqoc6kyz9Cidf_3MHQA-6ZAQJns2pU2CqJ-pMj9ZKA@mail.gmail.com>
         <e2db511fcaad2d1d08180995e836c22791b9e3b6.camel@analog.com>
         <CAKxs2cDzm+3WJSp=tHpHy31M5qQaQ=ddKvwoQuP=wzawWKZd6A@mail.gmail.com>
In-Reply-To: <CAKxs2cDzm+3WJSp=tHpHy31M5qQaQ=ddKvwoQuP=wzawWKZd6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51b816f4-b3ee-469d-08f3-08d73bff513b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR03MB5285;
x-ms-traffictypediagnostic: CH2PR03MB5285:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <CH2PR03MB5285C955FB6EBE94A9CF5F02F98E0@CH2PR03MB5285.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(136003)(39860400002)(376002)(51914003)(189003)(199004)(53754006)(8936002)(71200400001)(71190400001)(966005)(6916009)(81156014)(81166006)(8676002)(1730700003)(86362001)(54906003)(7736002)(36756003)(1361003)(14444005)(486006)(14454004)(305945005)(478600001)(2351001)(256004)(76116006)(2616005)(476003)(11346002)(3846002)(118296001)(6116002)(102836004)(6436002)(76176011)(5640700003)(99286004)(53546011)(6486002)(66556008)(64756008)(66476007)(4326008)(5660300002)(6246003)(229853002)(66066001)(66946007)(446003)(2501003)(1411001)(6506007)(316002)(186003)(66446008)(2906002)(6512007)(6306002)(26005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5285;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m6v9yZZXrq3FCvqpHeMZoyefuVY0vC/uwj8Jwl5PfrJmmSKKOh2V+kYkzyXkYZ6/nVcCV1HQ03bbjmhn7hr5ANvO6QNLDoTcRiuKG3O/zUB2D4LBuHd4lbQKM8WG0fHtrdnyAYo+5K2sCyFUtrv5zGBYwIb/eZQ1zep+qdBIaL42Pf4QkeXXqhKXN6j0W0HlTaNDZDw1ns+5LE+AmJjDPTkKz9I1+FRQY58e2Hzdx9c0ylkBdanm9hPR1cdiPvHSj5ciij4ugyUtFhFOQoUR4LBvItSZJ5HXYm5dhyZoU4Acfbfp0yxwAd12avjYCq2UwcRXiLlAzc5zDMq9dFrVIeLmh0BJ8dxs2tI89Fa1hQd0dRGn3ZvWM7vz9aqG4lUd3aSBhEFbiM/WK9m9wtgMz+XYg7y6ehM36OO0+iLvsdw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <350141B9C130554CA220C06CFFD79918@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b816f4-b3ee-469d-08f3-08d73bff513b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 06:13:26.0166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: foaPtKeW2G4KI+TcirsXgtLAzA9SyZOVb7Su0jmrikHDoZdXDkw8WMdJz0dye/qIGSvj0ehvzN2caxRvM0h3+KxQjQuszj16oUMMvJzgKoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5285
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-18_04:2019-09-17,2019-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909180066
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTA5LTE3IGF0IDIxOjQ3IC0wMzAwLCBEYW5pZWwgSnVuaG8gd3JvdGU6DQo+
IE9uIFR1ZSwgU2VwIDE3LCAyMDE5IGF0IDM6MjQgQU0gQXJkZWxlYW4sIEFsZXhhbmRydQ0KPiA8
YWxleGFuZHJ1LkFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAxOS0w
OS0xNiBhdCAyMDo1MCAtMDMwMCwgRGFuaWVsIEp1bmhvIHdyb3RlOg0KPiA+ID4gW0V4dGVybmFs
XQ0KPiA+ID4gDQo+ID4gPiBIZWxsbyBldmVyeWJvZHkuDQo+ID4gPiANCj4gPiA+IEkgYW0gc3Rp
bGwgbGVhcm5pbmcgYWJvdXQga2VybmVsIGRldmVsb3BpbmcuIEkgd291bGQgbGlrZSB0byB0cnkg
dG8NCj4gPiA+IGRldmVsb3AgYSBkZXZpY2UgZHJpdmVyIGZvciB0aGUgQUQ3OTI4IFsxXSwgZnJv
bSBBbmFsb2cgRGV2aWNlLg0KPiA+ID4gDQo+ID4gPiBDYW4gc29tZW9uZSBnaXZlIHNvbWUgd29y
ZHMgdG8gZ3VpZGUgbWU/DQo+ID4gPiANCj4gPiA+IEkgd2FzIHRoaW5raW5nIGFib3V0IGZvcmtp
bmcgdGhlIGFuYWxvZyBrZXJuZWwgcmVwbyBbMl0gYnV0IEkgZG9uJ3QNCj4gPiA+IGtub3cgdG8g
d2hpY2ggYnJhbmNoIHNob3VsZCBJIGNvbW1pdCB0byB3aGVuIGRvaW5nIGEgcHVsbCByZXF1ZXN0
LiBPcg0KPiA+ID4gaWYgdGhpcyBpcyB0aGUgY29ycmVjdCB3YXkgZm9yIHRoZSBkZXZpY2VzIGZy
b20gQW5hbG9nLg0KPiA+ID4gDQo+ID4gDQo+ID4gSGV5LA0KPiA+IA0KPiA+IFRoYW5rcyBmb3Ig
dGhlIGludGVyZXN0IGluIHdyaXRpbmcgdGhlIGRyaXZlciBmb3IgdGhpcy4NCj4gPiANCj4gPiBJ
biBzb21lIGNhc2VzLCBzb21lIG5ldyBwYXJ0cyBtYXkgaGF2ZSBhbiBleGlzdGluZyBkcml2ZXIg
YXZhaWxhYmxlDQo+ID4gYWxyZWFkeQ0KPiA+IHRoYXQgY2FuIGJlIHJlLXVzZWQgcGFydGlhbGx5
IG9yIGNvbXBsZXRlbHkuDQo+ID4gDQo+ID4gWW91J3JlIGluIGx1Y2suDQo+ID4gVGhlcmUgaXMg
ZHJpdmVyIHNlZW1zIHRvIGJlIHBhcnRpYWxseSBpbXBsZW1lbnRlZCB2aWENCj4gPiBkcml2ZXJz
L2lpby9hZGMvYWQ3OTIzLmMNCj4gPiANCj4gPiBJJ3ZlIGRvbmUgb25seSBhIG1pbm9yL3F1aWNr
IGNoZWNrIGJ1dCB0aGUgY29udHJvbCByZWdpc3RlciBiaXRzIGFyZQ0KPiA+IGNvbXBhdGlibGUg
Zm9yIHRoZSBBRDc5MjggYXMgd2VsbC4NCj4gPiANCj4gPiBUeXBpY2FsbHksIHlvdSBjYW4gZXh0
ZW5kIHRoYXQgZHJpdmVyIGFuZCBhZGQgdGhlIG5ldyBwYXJ0cyBhbmQgdGVzdA0KPiA+IHRoZW0u
DQo+ID4gDQo+ID4gU28sIG15IHN1Z2dlc3Rpb24gd291bGQgYmU6DQo+ID4gMS4gR2V0IGFuIGV2
YWwtYm9hcmQgb3IgYSBBRDc5MjggcGFydDsgZGVwZW5kaW5nIG9uIHRoZSBjYXNlIHdlIGNvdWxk
DQo+ID4gaGVscA0KPiA+IHdpdGggdGhpcw0KPiA+IDIuIFRyeSB0byBzZXQgaXQgdXAgd2l0aCBh
IFJhc3BiZXJyeSBQaSB3aXRoIHRoZSBldmFsIGJvYXJkDQo+ID4gICAgYS4gaXQgbG9va3MgdG8g
bWUgdGhhdCB5b3UgbmVlZCBhIDdWLTlWIHBvd2VyLXN1cHBseQ0KPiA+ICAgIGIuIHlvdSBjYW4g
aG9vayB0aGUgU1BJIHRvIHRoZSB0ZXN0LXBvaW50cyBvbiB0aGUgZXZhbCBib2FyZA0KPiA+IDMu
IFdyaXRlIGEgYmFzaWMgZGV2aWNlLXRyZWUgb3ZlcmxheSA7IHlvdSBjYW4gYWRhcHQgc29tZXRo
aW5nIGZyb20NCj4gPiBvdGhlcg0KPiA+IGV4YW1wbGVzLg0KPiA+IExvb2sgaGVyZToNCj4gPiBo
dHRwczovL2dpdGh1Yi5jb20vYW5hbG9nZGV2aWNlc2luYy9saW51eC9ibG9iL3JwaS00LjE5Lnkv
YXJjaC9hcm0vYm9vdC9kdHMvb3ZlcmxheXMvTWFrZWZpbGUNCj4gPiBVc3VhbGx5ICBycGktYWRY
WFguZHRzICBhcmUgQURJIHBhcnRzLg0KPiA+IDQuIEVuYWJsZSB0aGUgZHJpdmVyIGZvciB0aGUg
a2VybmVsLg0KPiA+IElmIHVzaW5nIHRoZSBBREkga2VybmVsLCB0aGVyZSdzIGEgZ3VpZGUgaGVy
ZSBmb3IgUlBpLg0KPiA+IGh0dHBzOi8vd2lraS5hbmFsb2cuY29tL3Jlc291cmNlcy90b29scy1z
b2Z0d2FyZS9saW51eC1idWlsZC9nZW5lcmljL3Jhc3BiZXJyeXBpDQo+ID4gQ2hlY2sgdGhlIGJy
YW5jaCB0aGF0IG1hdGNoZXMgeW91ciBSYXNwYmlhbiBpbWFnZSAocnBpLTQuMTkueSBpcyB0aGUN
Cj4gPiBsYXRlc3QpDQo+ID4gNS4gQnVpbGQgdGhlIGtlcm5lbA0KPiA+IDYuIFdyaXRlIGl0IHRv
IHRoZSBTRC1jYXJkIGltYWdlDQo+ID4gNy4gVGVzdA0KPiA+IDguIE1vZGlmeSAmIHJlcGVhdA0K
PiA+IA0KPiA+IFRoYW5rcw0KPiA+IEFsZXgNCj4gPiANCj4gPiA+IFsxXSBodHRwczovL3d3dy5h
bmFsb2cuY29tL2VuL3Byb2R1Y3RzL2FkNzkyOC5odG1sDQo+ID4gPiBbMl0gaHR0cHM6Ly9naXRo
dWIuY29tL2FuYWxvZ2RldmljZXNpbmMvbGludXgNCj4gPiA+IA0KPiA+ID4gRGFuaWVsIEp1bmhv
DQo+IA0KPiBIaSBBbGV4Lg0KPiANCj4gSXQgc2VlbXMgdGhhdCB1c2luZyBBRDc5MjMgd2lsbCBi
ZSB0aGUgYmVzdCBjaG9pY2UuIFRoZXkgYXJlIHZlcnkNCj4gc2ltaWxhci4NCj4gDQo+IFRoYW5r
IHlvdSBmb3IgeW91ciByZXBseSBhbmQgc3VnZ2VzdGlvbi4NCj4gSSBkb24ndCBoYXZlIGFuIEVW
QiwgYnV0IGF0IHdvcmssIHdlIGhhdmUgYSBib2FyZCB3aXRoIHRoZSBBRDc5MjgNCg0KSWYgeW91
IGhhdmUgdGhlIGNoaXAgYWxyZWFkeSBjb25uZWN0ZWQsIHRoZW4gaXQncyBldmVuIGJldHRlci4N
CllvdSBkb24ndCBuZWVkIHRvIGdvIHRocm91Z2ggdGhlIHRyb3VibGUgb2YgaW50ZXJmYWNpbmcg
aXQgYW55bW9yZS4NCg0KPiB1c2luZyBhIHVzZXIgZHJpdmVyLiBTbyBJIHdpbGwgdHJ5IHRvIHVz
ZSBpdCBmb3IgdGhpcyBkZXZlbG9wbWVudCwgYXQNCg0KQW5kIGlmIHlvdSd2ZSBhbHJlYWR5IHZh
bGlkYXRlZCB3aXRoIGEgdXNlci1kcml2ZXIsIGl0J3MgYWdhaW4gYmV0dGVyLCBhcw0KdGhlIGNv
bm5lY3Rpb25zIGhhdmUgYmVlbiB2YWxpZGF0ZWQuDQoNCj4gbGVhc3QgZm9yIG5vdy4NCj4gDQo+
IEkgYmVsaWV2ZSB0aGF0IHdpbGwgYmUgZnVuID0pDQoNClNob3VsZCBiZS4NCklmIHRoaXMgd2hv
bGUgdGhpbmcgaXMgbmV3IHRvIHlvdSwgaXQncyBhbHdheXMgZWFzaWVyIHRvIHN0YXJ0IHdpdGgg
YQ0KYmFzZS9leGlzdGluZyBkcml2ZXIgYW5kIGV4dGVuZCB0aGFuIGdvIHRocm91Z2ggdGhlIHBy
b2Nlc3Mgb2Ygd3JpdGluZyBpdA0KZnJvbSBzY3JhdGNoLg0KSXQncyBtb3N0bHkgaG93IEkgbGVh
cm4oZWQpIHRoaW5nczogdGFraW5nIHRoaW5ncyBhcGFydCwgc2VlaW5nIHdoYXQgcGVvcGxlDQpo
YXZlIGRvbmUsIGFuZCB0aGVuIHVzaW5nIHRoZSBiZXN0IGlkZWFzIGluIG15IGZ1dHVyZSBwcm9j
ZXNzZXMuDQoNCj4gDQo+IERhbmllbCBKdW5obw0K
