Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC77168452
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 18:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgBURCD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 12:02:03 -0500
Received: from mail-eopbgr80113.outbound.protection.outlook.com ([40.107.8.113]:47842
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727329AbgBURCD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 12:02:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESm5cMd3gOrUMmuKrb6g/OxUq+ytml2LRgqQdRstdU1F6Z7aDTu0kz/nwSR4OT6njNF/1S+gQslWWlBHXRCW6W61bYUMym+xysAiCq+qPqOczZoRffCg4z75TniKmKnwcffHZxRwnhykmZ1H5Yz+Bbu2i7L9bYzYOFNfwfnr6Xz16PZGyxcJpqzExCIs+Y3zHR2/A6YFRI5uMf5PyZfDrpBMQkjjK6gpbYLYShVjcKk+E0ca0AgJtLXniEeqTMWY6izqK3P95w71Et3LeYSZOKpaw+9Yb/SYU3PuCMMXqVhbhk2Gf7RQFOSLz6CRjpqXPv7nHL5o+XJok0GR1q0Nzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e15KZXn9VHIMnJ40wyP3FHnIR2r/ehuc3/BGwMesrWU=;
 b=GEoyppUp+4kII/lYBWcNij00mb3jO+PTFPEGNYDxvY3SNfIz1idkxsZJJlrUfaG229+uPdhD7yLKn+B6NXK+oRTepDdK7097Pa/MZDny/hh2lZKfmAC3wdPvBOgvbzHSWRYTYqbQzkUEytMQjVxlOVOhurlpQKmqfuzH/RJKx+L9IYw+bkalZToFGqlxXe2BTYeSVwibDoxywhBQ32pQWD8Ou7QQV8sLXfO6WTtZF5yMAvCfSosZB7krbs/P8QyLf0elwyYwHg+yaQEJXSkvRRQAPb0GTTPs75FzhOKA+vFd1/UA+zAF9uI2aX3ybLl9VYzYBv5+vPN9e+1CKyDLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e15KZXn9VHIMnJ40wyP3FHnIR2r/ehuc3/BGwMesrWU=;
 b=YqfDFB7vBY8UaNNOzEgQy8pg7W5/5uYaQYHaA5cQuW8862uZ6ap87Naxr8zQiqyfb33r4S/P6F+NNvUcxpVqt6FVjjzQ5FLYz/oXi3kSQ+fA7TARixHop/v2Jy3d4lCvAD1Ne/Tt+tuLK0yk7BGCxTgAkAh6dcw7dR1DYRlXDnM=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3449.eurprd02.prod.outlook.com (52.134.70.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Fri, 21 Feb 2020 17:01:58 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::d7c:583:b9cb:7592]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::d7c:583:b9cb:7592%7]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 17:01:58 +0000
Received: from [192.168.13.3] (213.112.137.122) by HE1PR02CA0118.eurprd02.prod.outlook.com (2603:10a6:7:29::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Fri, 21 Feb 2020 17:01:57 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Jonathan Cameron <jic23@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 01/13] iio: imu: inv_mpu6050: enable i2c aux mux bypass
 only once
Thread-Topic: [PATCH v2 01/13] iio: imu: inv_mpu6050: enable i2c aux mux
 bypass only once
Thread-Index: AQHV6Kh9OaH13MVdQUqCDeHrljJ42qgl3+sA
Date:   Fri, 21 Feb 2020 17:01:57 +0000
Message-ID: <e8786752-7876-2421-1f37-4a31c7e88f4a@axentia.se>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
 <20200219143958.3548-2-jmaneyrol@invensense.com>
 <20200221111716.3de97c85@archlinux>
In-Reply-To: <20200221111716.3de97c85@archlinux>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
x-originating-ip: [213.112.137.122]
x-clientproxiedby: HE1PR02CA0118.eurprd02.prod.outlook.com
 (2603:10a6:7:29::47) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f694d85d-9752-49bf-acae-08d7b6efc2d4
x-ms-traffictypediagnostic: DB3PR0202MB3449:
x-microsoft-antispam-prvs: <DB3PR0202MB3449ECF3B9DEEF5F3CBC247EBC120@DB3PR0202MB3449.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(136003)(366004)(39830400003)(189003)(199004)(36756003)(2906002)(16576012)(8676002)(5660300002)(8936002)(66556008)(66476007)(508600001)(66946007)(64756008)(110136005)(316002)(26005)(66446008)(186003)(81166006)(81156014)(31696002)(86362001)(6486002)(956004)(52116002)(71200400001)(53546011)(16526019)(31686004)(2616005)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3449;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BmJsJzeWH9dKM8ORv8uWip1+bVdVYJTJdBmMnmImFAzy9GUOwqXuWnnVHHYI9BFkzy+5b+90N865+xfK5KLBytjh2gt9XgkGcrmdXqxhRbkGfr+H2WofYK+gM+rl965Q4QlydkxXw73D9oYATgxVwoD9MdCRmd+wbfj921Mi+6AZSVqdS7sveyFec5ztmuWVt9kq+5qa2tNPhe2DirTx49LTYMyYY3c0ZAfutWVZdK8N3Q+kUkBFWiZTzndK04/DE7k+2WxqkYBWXTX2ZLpMsFGetXkjujaUi560/9N16dXFMXMFtTZnPy+ehKMENHbw0O9IgFd0ELNOw3feDJBsNdKyxXkErX+XkYHCA9/Khc2tOhBrt0jOxYyZO3GrK6BVt5H6YMqKxFyVK+hZCkAXC4pBros2DW6XLl96Cs7hCvopSkQ6l0kfYGR7pvaeWkEg
x-ms-exchange-antispam-messagedata: Pa4IFXwcibXU3DTkSvOfr7Lo24YA18hnEvvEDjsRO7N+U3oQAuaw9ctD1Gd5V8XX1C0TWKmJBmuG+t5x+XkMVDTdSr4pdW7NoK2o8qDvE1u0UA04Uu6huUo9oOU7hM9bTzJkrBr3MZAnNo0Wc5Jo6w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8992E58E670E3429E7D8DB25858734E@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f694d85d-9752-49bf-acae-08d7b6efc2d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 17:01:58.0739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KyPDeFPB+OIThHuz47Mr2o9hagxVKEK5y7U0trIECvYtzqwhm3Gy4ExNuxMcZXJw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3449
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMjAyMC0wMi0yMSAxMjoxNywgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gV2VkLCAx
OSBGZWIgMjAyMCAxNTozOTo0NiArMDEwMA0KPiBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIDxqbWFu
ZXlyb2xAaW52ZW5zZW5zZS5jb20+IHdyb3RlOg0KPiANCj4+IGkyYyBhdXhpbGlhcnkgbXV4IGlz
IGRvbmUgYnkgYW5hbG9nIHN3aXRjaGVzLiBZb3UgZG8gbm90IG5lZWQgdG8NCj4+IHNldCB0aGVt
IGZvciBldmVyeSBpMmMgdHJhbnNmZXIuDQo+PiBKdXN0IHNldCBpMmMgYnlwYXNzIGJpdCBhdCBp
bml0IGFuZCBkbyBub3RpbmcgaW4gaTJjIGRlL3NlbGVjdC4NCg0KTml0czoNCmkyYyAtPiBJMkMg
KGluIGNvbW1lbnRzLCBkb2NzLCBjb21taXQgbWVzc2FnZXMsIGV0YykNCm5vdGluZyAtPiBub3Ro
aW5nDQoNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIDxqbWFu
ZXlyb2xAaW52ZW5zZW5zZS5jb20+DQo+IE9LLiBHaXZlbiB3ZSBhcmUga2VlcGluZyB0aGUgaTJj
IG11eCBzdHVmZiBtb3N0bHkgZm9yIGJhY2t3YXJkcw0KPiBjb21wYXRpYmlsaXR5IEknbGwgdGFr
ZSB0aGlzLiAgSG93ZXZlciwgdGhlcmUgaXMgc3RpbGwgYSBiaXQNCj4gb2YgdGltZSBpZiBQZXRl
ciB3YW50J3MgdG8gY29tbWVudCBiZWZvcmUgSSBwdXNoIHRoaXMgb3V0IGFzDQo+IGEgbm9uIHJl
YmFzaW5nIHRyZWUuDQoNCkV2ZW4gdGhvdWdoIEkgaGF2ZSBub3QgdHJpZWQgaXQsIEkgc2VlIG5v
IGNvbmNlcHR1YWwgcHJvYmxlbSB0byBoYXZlDQphbiBJMkMgbXV4IChvciBnYXRlIGFzIGluIHRo
aXMgY2FzZSkgdGhhdCBkb2VzICJub3RoaW5nIi4gWW91IGRvIGdldA0KdGhlIGJhY2t3YXJkcyBj
b21wYXRpYmxlIGV4dHJhIEkyQyBidXMgZm9yIHRoZSBvdGhlciBzaWRlIG9mIHRoZSBnYXRlLA0K
a2VlcGluZyB0aGUgZXhwZWN0ZWQgSTJDIGFkYXB0ZXIgdHJlZSBpbnRhY3QuIEJ1dCBkbyBub3Rl
IHRoYXQgYSBJMkMNCm11eCB0aGF0IGRvZXMgIm5vdGhpbmciIHN0aWxsIHRyaWdnZXJzIGxvY2tp
bmcgYW5kIHZhcmlvdXMgZXh0cmENCmluZGlyZWN0aW9ucyBhbmQgb3BlcmF0aW9ucyBzbyBpdCdz
IG5vdCBhIGNvbXBsZXRlIE5PUC4NCg0KU28sDQoNCkFja2VkLWJ5OiBQZXRlciBSb3NpbiA8cGVk
YUBheGVudGlhLnNlPg0KDQoob25lIG1vcmUgbml0IGJlbG93KQ0KDQo+IFBsZWFzZSBtYWtlIHN1
cmUgdG8gY2MgcGV0ZXIgb24gYW55dGhpbmcgdG91Y2hpbmcgaTJjIG11eC4NCj4gDQo+IEFwcGxp
ZWQgdG8gdGhlIHRvZ3JlZyBicmFuY2ggb2YgaWlvLmdpdCBhbmQgcHVzaGVkIG91dCBhcyB0ZXN0
aW5nIGZvcg0KPiB0aGUgYXV0b2J1aWxkZXJzIHRvIHBsYXkgd2l0aCBpdC4NCj4gDQo+IFRoYW5r
cywNCj4gDQo+IEpvbmF0aGFuDQo+IA0KPj4gLS0tDQo+PiAgZHJpdmVycy9paW8vaW11L2ludl9t
cHU2MDUwL2ludl9tcHVfaTJjLmMgfCA3MSArKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCA0MyBkZWxldGlvbnMoLSkNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfaTJjLmMgYi9k
cml2ZXJzL2lpby9pbXUvaW52X21wdTYwNTAvaW52X21wdV9pMmMuYw0KPj4gaW5kZXggMTM2M2Qz
Nzc2NTIzLi4yNGRmODgwMjQ4ZjIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2lpby9pbXUvaW52
X21wdTYwNTAvaW52X21wdV9pMmMuYw0KPj4gKysrIGIvZHJpdmVycy9paW8vaW11L2ludl9tcHU2
MDUwL2ludl9tcHVfaTJjLmMNCj4+IEBAIC0yMCwzOCArMjAsNiBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHJlZ21hcF9jb25maWcgaW52X21wdV9yZWdtYXBfY29uZmlnID0gew0KPj4gIA0KPj4gIHN0
YXRpYyBpbnQgaW52X21wdTYwNTBfc2VsZWN0X2J5cGFzcyhzdHJ1Y3QgaTJjX211eF9jb3JlICpt
dXhjLCB1MzIgY2hhbl9pZCkNCj4+ICB7DQo+PiAtCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYg
PSBpMmNfbXV4X3ByaXYobXV4Yyk7DQo+PiAtCXN0cnVjdCBpbnZfbXB1NjA1MF9zdGF0ZSAqc3Qg
PSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPj4gLQlpbnQgcmV0Ow0KPj4gLQ0KPj4gLQltdXRleF9s
b2NrKCZzdC0+bG9jayk7DQo+PiAtDQo+PiAtCXJldCA9IGludl9tcHU2MDUwX3NldF9wb3dlcl9p
dGcoc3QsIHRydWUpOw0KPj4gLQlpZiAocmV0KQ0KPj4gLQkJZ290byBlcnJvcl91bmxvY2s7DQo+
PiAtDQo+PiAtCXJldCA9IHJlZ21hcF93cml0ZShzdC0+bWFwLCBzdC0+cmVnLT5pbnRfcGluX2Nm
ZywNCj4+IC0JCQkgICBzdC0+aXJxX21hc2sgfCBJTlZfTVBVNjA1MF9CSVRfQllQQVNTX0VOKTsN
Cj4+IC0NCj4+IC1lcnJvcl91bmxvY2s6DQo+PiAtCW11dGV4X3VubG9jaygmc3QtPmxvY2spOw0K
Pj4gLQ0KPj4gLQlyZXR1cm4gcmV0Ow0KPj4gLX0NCj4+IC0NCj4+IC1zdGF0aWMgaW50IGludl9t
cHU2MDUwX2Rlc2VsZWN0X2J5cGFzcyhzdHJ1Y3QgaTJjX211eF9jb3JlICptdXhjLCB1MzIgY2hh
bl9pZCkNCj4+IC17DQo+PiAtCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYgPSBpMmNfbXV4X3By
aXYobXV4Yyk7DQo+PiAtCXN0cnVjdCBpbnZfbXB1NjA1MF9zdGF0ZSAqc3QgPSBpaW9fcHJpdihp
bmRpb19kZXYpOw0KPj4gLQ0KPj4gLQltdXRleF9sb2NrKCZzdC0+bG9jayk7DQo+PiAtDQo+PiAt
CS8qIEl0IGRvZXNuJ3QgcmVhbGx5IG1hdHRlciBpZiBhbnkgb2YgdGhlIGNhbGxzIGZhaWwgKi8N
Cj4+IC0JcmVnbWFwX3dyaXRlKHN0LT5tYXAsIHN0LT5yZWctPmludF9waW5fY2ZnLCBzdC0+aXJx
X21hc2spOw0KPj4gLQlpbnZfbXB1NjA1MF9zZXRfcG93ZXJfaXRnKHN0LCBmYWxzZSk7DQo+PiAt
DQo+PiAtCW11dGV4X3VubG9jaygmc3QtPmxvY2spOw0KPj4gLQ0KPj4gIAlyZXR1cm4gMDsNCj4+
ICB9DQo+PiAgDQo+PiBAQCAtNzksMTkgKzQ3LDIwIEBAIHN0YXRpYyBib29sIGludl9tcHVfaTJj
X2F1eF9idXMoc3RydWN0IGRldmljZSAqZGV2KQ0KPj4gIAl9DQo+PiAgfQ0KPj4gIA0KPj4gLS8q
DQo+PiAtICogTVBVOXh4eCBtYWduZXRvbWV0ZXIgc3VwcG9ydCByZXF1aXJlcyB0byBkaXNhYmxl
IGkyYyBhdXhpbGlhcnkgYnVzIHN1cHBvcnQuDQo+PiAtICogVG8gZW5zdXJlIGJhY2t3YXJkIGNv
bXBhdGliaWxpdHkgd2l0aCBleGlzdGluZyBzZXR1cHMsIGRvIG5vdCBkaXNhYmxlDQo+PiAtICog
aTJjIGF1eGlsaWFyeSBidXMgaWYgaXQgdXNlZC4NCj4+IC0gKiBDaGVjayBmb3IgaTJjLWdhdGUg
bm9kZSBpbiBkZXZpY2V0cmVlIGFuZCBzZXQgbWFnbmV0b21ldGVyIGRpc2FibGVkLg0KPj4gLSAq
IE9ubHkgTVBVNjUwMCBpcyBzdXBwb3J0ZWQgYnkgQUNQSSwgbm8gbmVlZCB0byBjaGVjay4NCj4+
IC0gKi8NCj4+IC1zdGF0aWMgaW50IGludl9tcHVfbWFnbl9kaXNhYmxlKHN0cnVjdCBpaW9fZGV2
ICppbmRpb19kZXYpDQo+PiArc3RhdGljIGludCBpbnZfbXB1X2kyY19hdXhfc2V0dXAoc3RydWN0
IGlpb19kZXYgKmluZGlvX2RldikNCj4+ICB7DQo+PiAgCXN0cnVjdCBpbnZfbXB1NjA1MF9zdGF0
ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBp
bmRpb19kZXYtPmRldi5wYXJlbnQ7DQo+PiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbXV4X25vZGU7
DQo+PiArCWludCByZXQ7DQo+PiAgDQo+PiArCS8qDQo+PiArCSAqIE1QVTl4eHggbWFnbmV0b21l
dGVyIHN1cHBvcnQgcmVxdWlyZXMgdG8gZGlzYWJsZSBpMmMgYXV4aWxpYXJ5IGJ1cy4NCj4+ICsJ
ICogVG8gZW5zdXJlIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgd2l0aCBleGlzdGluZyBzZXR1cHMs
IGRvIG5vdCBkaXNhYmxlDQo+PiArCSAqIGkyYyBhdXhpbGlhcnkgYnVzIGlmIGl0IHVzZWQuDQoN
Cml0IHVzZWQgLT4gaXQgaXMgdXNlZA0KDQpDaGVlcnMsDQpQZXRlcg0KDQo+PiArCSAqIENoZWNr
IGZvciBpMmMtZ2F0ZSBub2RlIGluIGRldmljZXRyZWUgYW5kIHNldCBtYWduZXRvbWV0ZXIgZGlz
YWJsZWQuDQo+PiArCSAqIE9ubHkgTVBVNjUwMCBpcyBzdXBwb3J0ZWQgYnkgQUNQSSwgbm8gbmVl
ZCB0byBjaGVjay4NCj4+ICsJICovDQo+PiAgCXN3aXRjaCAoc3QtPmNoaXBfdHlwZSkgew0KPj4g
IAljYXNlIElOVl9NUFU5MTUwOg0KPj4gIAljYXNlIElOVl9NUFU5MjUwOg0KPj4gQEAgLTEwNyw3
ICs3NiwyNCBAQCBzdGF0aWMgaW50IGludl9tcHVfbWFnbl9kaXNhYmxlKHN0cnVjdCBpaW9fZGV2
ICppbmRpb19kZXYpDQo+PiAgCQlicmVhazsNCj4+ICAJfQ0KPj4gIA0KPj4gKwkvKiBlbmFibGUg
aTJjIGJ5cGFzcyB3aGVuIHVzaW5nIGkyYyBhdXhpbGlhcnkgYnVzICovDQo+PiArCWlmIChpbnZf
bXB1X2kyY19hdXhfYnVzKGRldikpIHsNCj4+ICsJCXJldCA9IGludl9tcHU2MDUwX3NldF9wb3dl
cl9pdGcoc3QsIHRydWUpOw0KPj4gKwkJaWYgKHJldCkNCj4+ICsJCQlyZXR1cm4gcmV0Ow0KPj4g
KwkJcmV0ID0gcmVnbWFwX3dyaXRlKHN0LT5tYXAsIHN0LT5yZWctPmludF9waW5fY2ZnLA0KPj4g
KwkJCQkgICBzdC0+aXJxX21hc2sgfCBJTlZfTVBVNjA1MF9CSVRfQllQQVNTX0VOKTsNCj4+ICsJ
CWlmIChyZXQpDQo+PiArCQkJZ290byBlcnJvcjsNCj4+ICsJCXJldCA9IGludl9tcHU2MDUwX3Nl
dF9wb3dlcl9pdGcoc3QsIGZhbHNlKTsNCj4+ICsJCWlmIChyZXQpDQo+PiArCQkJZ290byBlcnJv
cjsNCj4+ICsJfQ0KPj4gKw0KPj4gIAlyZXR1cm4gMDsNCj4+ICtlcnJvcjoNCj4+ICsJaW52X21w
dTYwNTBfc2V0X3Bvd2VyX2l0ZyhzdCwgZmFsc2UpOw0KPj4gKwlyZXR1cm4gcmV0Ow0KPj4gIH0N
Cj4+ICANCj4+ICAvKioNCj4+IEBAIC0xNTEsNyArMTM3LDcgQEAgc3RhdGljIGludCBpbnZfbXB1
X3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsDQo+PiAgCX0NCj4+ICANCj4+ICAJcmVz
dWx0ID0gaW52X21wdV9jb3JlX3Byb2JlKHJlZ21hcCwgY2xpZW50LT5pcnEsIG5hbWUsDQo+PiAt
CQkJCSAgICBpbnZfbXB1X21hZ25fZGlzYWJsZSwgY2hpcF90eXBlKTsNCj4+ICsJCQkJICAgIGlu
dl9tcHVfaTJjX2F1eF9zZXR1cCwgY2hpcF90eXBlKTsNCj4+ICAJaWYgKHJlc3VsdCA8IDApDQo+
PiAgCQlyZXR1cm4gcmVzdWx0Ow0KPj4gIA0KPj4gQEAgLTE2MCw4ICsxNDYsNyBAQCBzdGF0aWMg
aW50IGludl9tcHVfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCj4+ICAJCS8qIGRl
Y2xhcmUgaTJjIGF1eGlsaWFyeSBidXMgKi8NCj4+ICAJCXN0LT5tdXhjID0gaTJjX211eF9hbGxv
YyhjbGllbnQtPmFkYXB0ZXIsICZjbGllbnQtPmRldiwNCj4+ICAJCQkJCSAxLCAwLCBJMkNfTVVY
X0xPQ0tFRCB8IEkyQ19NVVhfR0FURSwNCj4+IC0JCQkJCSBpbnZfbXB1NjA1MF9zZWxlY3RfYnlw
YXNzLA0KPj4gLQkJCQkJIGludl9tcHU2MDUwX2Rlc2VsZWN0X2J5cGFzcyk7DQo+PiArCQkJCQkg
aW52X21wdTYwNTBfc2VsZWN0X2J5cGFzcywgTlVMTCk7DQo+PiAgCQlpZiAoIXN0LT5tdXhjKQ0K
Pj4gIAkJCXJldHVybiAtRU5PTUVNOw0KPj4gIAkJc3QtPm11eGMtPnByaXYgPSBkZXZfZ2V0X2Ry
dmRhdGEoJmNsaWVudC0+ZGV2KTsNCj4gDQoNCg==
