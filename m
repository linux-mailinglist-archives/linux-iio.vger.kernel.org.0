Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A63211A5EFE
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 16:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgDLO3g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 10:29:36 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:43624 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbgDLO3f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Apr 2020 10:29:35 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03CEKhXR008615;
        Sun, 12 Apr 2020 10:29:22 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0b-00128a01.pphosted.com with ESMTP id 30bah6j45q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Apr 2020 10:29:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dX7GV7IHvUy7NgRH47sLUcOWDnNC/0Vsn/zY/I7FjzPRnLoEsRKp/qbuT14q2GVPtxEeSUME4a3LCYVsHRhjGt8Yv6O0ZGyFSR05YiwGb4szFmEiMgm9Ddw1qezmE7bISamEnVL7OTnoWx+NfjnUkygACwmXBJQ7vlt5V8OwHpn16cdLEmtb0sYs5sUJxmYKJu2lFl6KebgaNdZJuZkj9l+XujnN85FtRtBHYToU1NRTc3oiQ01CPZ9lckhkczXGX9CIUUDn8vacp2SdlXhvuz3Zp8FijVtcIpZ/iw/UyPfye7lNYd543zqGkeAj0hjMxcDhMa9FxV02c52OynRw8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i3+qFHcz2wRCyGjHGdqScFGNmSqN5N1BYDQs8z6lJU=;
 b=a8CEnotZdP3PBiUhQ51gEbjD9NZHr9IoHEjt96Te/h3/Nvj/n1hHxawbv2z2smGcglEKMOTJ/7tY2MjEbperoj6JQ3sq3GZZhmpLF503Tp+jk1kY1mwlYWD3/yLQVwJXEQE1O/jD7DO5a+pn5nX6XYuOWtA/r5Nvbzk8Rpk8FmOIAdRZlVLo1mOfQ0pv7OR28A6FmO6kPllq/laIJM1Y5cEBQlrHTxIbwtrYRe4KA0xEQ13LZo2UB9L9oo0u1sMiKMMfZdw9jXFLpZdslc5F77wKfl9r81AeveOV62oYdqNUSxdKM5PFQ0LeGOw4kaUgXh/eCshxANmPYA7Z5ivoVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i3+qFHcz2wRCyGjHGdqScFGNmSqN5N1BYDQs8z6lJU=;
 b=0+XTn2liInLSTgz4Xi6vKFmy+VapX6j0wKaIeQSRLfQ6ImPhLywT8WURTx9M9RxShBHKypD6ooI5pvCaFQCkJ1gJw/Abzqw3o6VxSBhz/P+6MQ3nXgK3ROIC4as1x0L0l5YD1xZZ26sSmcQkZZeZs/H1zsicQWkmtzGyB3DHP08=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5321.namprd03.prod.outlook.com (2603:10b6:5:22a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Sun, 12 Apr
 2020 14:29:21 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2900.026; Sun, 12 Apr 2020
 14:29:21 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v3 0/5] iio: core,buffer: re-organize chardev creation
Thread-Topic: [PATCH v3 0/5] iio: core,buffer: re-organize chardev creation
Thread-Index: AQHWD0KmRLlwLYYcTUulJDQFgIO+sah1kBEA
Date:   Sun, 12 Apr 2020 14:29:21 +0000
Message-ID: <6de4f76a98f3a5e628c3e8eff59f6bb118c627a3.camel@analog.com>
References: <20200410141729.82834-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200410141729.82834-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8c10180-fdda-41af-67ba-08d7deede42d
x-ms-traffictypediagnostic: DM6PR03MB5321:
x-microsoft-antispam-prvs: <DM6PR03MB53215A8EA63FB33512C2EAA6F9DC0@DM6PR03MB5321.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0371762FE7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(366004)(39850400004)(376002)(346002)(396003)(6506007)(86362001)(6512007)(6486002)(478600001)(81156014)(4326008)(110136005)(186003)(26005)(36756003)(54906003)(316002)(8936002)(64756008)(66476007)(66446008)(66556008)(66946007)(8676002)(76116006)(91956017)(2906002)(2616005)(71200400001)(5660300002)(142933001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KL4XgB5FNQJ/A7uXVZCQUbtA1SJq62OCNUWd6/DlqJKv0B7ovVdwPugZypcDBkUL2roSo4Ac1zLKejHZLtkKMTDJTyKLoeO83G/TY3NaD4cL/NN1DLSGI2johKo/5BqbKfDmq8WYshbGdSTnNauhYvWXQ6M7nLN7jHhCeUZSppSfPvbbPFX5Dg3u8sUrKGwqG9zMsCIiJz+mDD8OvvnKvZb4rmd3klJikQHLN5czdTu45cCgEl/8ji1/b+7dCDOSNXz8PzAIHzXoGBWdDZ6m/W3TSXyWM0bbXVYgx+64qHqiYmhKLmayv8RGqxL8AbbEICgHlImYplkOEHYB09rG0nlvc/V6EhLMGz68rIkyjpCuzeAJjQWhfQc+EkXOipF2vOW30CFcIkrp2DvuVItw2+S9CdPylZwcuqoDHAtlvdQq9JP0RZsF8Vf9mqO/tleshXd4cxE5aaw4Fq7Ob+f7+UjCgMZBTirjrW/iNqlB1R2u/ab8uxmBd11pExc20HRV
x-ms-exchange-antispam-messagedata: ilzGI8T/Fjx3FBiKeg+DkV6xZ8NFvadHZfCulpD0be2r9RefDs85wR9GA+Ne0VLzuJomL/wK/KWTGIoO1jwnt+dH5SZGID/gIoxqOFeg4cPk9e6nN3aOZuHnGPLxqLdYdFqZYAIxTLDG4mgkA/tvWQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D804A1523E56FB4BB17C2DC4FC8ED3FD@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c10180-fdda-41af-67ba-08d7deede42d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2020 14:29:21.1991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYEhAJcOvHnzY9wsc2/UWZWlvjCKh+QuwZboOLNcZzRlhPFlE6jduFXWVI4Qe48TiI1XKxZQ1H5PM+tZLp8aPsvSDf8gtNquGfRAlhURmk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5321
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-12_02:2020-04-11,2020-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004120130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDIwLTA0LTEwIGF0IDE3OjE3ICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IFRoZSBtYWluIGludGVudCBpcyB0byBiZSBhYmxlIHRvIGFkZCBtb3JlIGNoYXJkZXZz
IHBlciBJSU8gZGV2aWNlLCBvbmUNCj4gZm9yIGVhY2ggYnVmZmVyLiBUbyBnZXQgdGhlcmUsIHNv
bWUgcmV3b3JrIGlzIG5lZWRlZCwgYW5kIG9uZSBpbXBvcnRhbnQNCj4gZmFjZXQgaXMgdG8gbW92
ZSB0aGUgY3JlYXRpb24gb2YgdGhlIGN1cnJlbnQgY2hhcmRldiBpbnRvDQo+ICdpbmR1c3RyaWFs
aW8tYnVmZmVyLmMnLCBzbyB0aGF0IGNvbnRyb2wvbG9naWMgb2YgdGhlc2UgY2hhcmRldnMgaXMN
Cj4gbG9jYWxpemVkIGluIHRoYXQgZmlsZS4NCj4gDQoNClRoaXMgbmVlZHMgYSBuZXcgVjQgbm93
Lg0KVGhlIGRyb3Agb2YgdGhlIGRldm1fIEFQSXMgaXMgY2F1c2luZyBzb21lIGNvbmZsaWN0cyBm
b3IgdGhpcyBzZXJpZXMuDQoNCldpbGwgc2VuZCBvbmUgdG9tb3Jyb3cuDQoNClN0aWxsLCBhbnkg
ZmVlZGJhY2sgdW50aWwgdGhlbiBbYWJvdXQgdGhpc10gaXMgYXBwcmVjaWF0ZWQuDQoNClRoYW5r
cw0KQWxleA0KDQo+IFRoaXMgY2hhbmdlc2V0IGRvZXMgdGhhdCBbaW5jcmVtZW50YWxseV0gYnkg
bW92aW5nIHRoZSBjb21tb24gY2hhcmRldg0KPiBjcmVhdGlvbiBmcm9tICdpbmR1c3RyaWFsaW8t
Y29yZS5jJyB0byAnaW5kdXN0cmlhbGlvLWJ1ZmZlci5jJyAmDQo+ICdpbmR1c3RyaWFsaW8tZXZl
bnQuYycuDQo+IFRoZSBjb21tb24gY2hhcmRldiBpcyByZXF1aXJlZCBmb3IgYm90aCBJSU8gYnVm
ZmVycyAmIElJTyBldmVudHMuDQo+IEluIG9yZGVyIHRvIG1ha2UgdGhpcyB3b3JrLCB0aGUgJ2lp
b19kZXZpY2VfZXZlbnRfaW9jdGwoKScgbmVlZHMgdG8gYmUNCj4gcGFzc2VkIGZyb20gJ2luZHVz
dHJpYWxpby1ldmVudC5jJyB0byAnaW5kdXN0cmlhbGlvLWJ1ZmZlci5jJyBmbHlpbmcgcGFzdA0K
PiAnaW5kdXN0cmlhbGlvLWNvcmUuYycuIFRoaXMgc291bmRzIGEgYml0IHdyb25nIFthdCBmaXJz
dF0gYnV0IGl0IGhhcyB0aGUNCj4gZWZmZWN0IG9mIHJlZHVjaW5nIGludGVyLWRlcGVuZGVuY2ll
cyBiZXR3ZWVuICdpbmR1c3RyaWFsaW8tY29yZS5jJyB0bw0KPiAnaW5kdXN0cmlhbGlvLWJ1ZmZl
ci5jJyBxdWl0ZSBhIGJpdC4NCj4gVGhlIElJTyBidWZmZXIgYWxzbyBoYXMgYSBDT05GSUdfSUlP
X0JVRkZFUiBzeW1ib2wgd2hpY2ggY2FuIHR1cm4gaXQNCj4gb2ZmLiBObyBpZGVhIGhvdyB3aWRl
bHkgdGhpcyBpcyB1c2VkIFthcyBkaXNhYmxlZF0sIGJ1dCB0aGlzIGNoYW5nZXNldA0KPiBhbHNv
IHRha2VzIHRoYXQgaW50byBjb25zaWRlcmF0aW9uLg0KPiANCj4gU28sIG5vdyB0aGUgbG9naWMg
W2ZvciBfX2lpb19kZXZpY2VfcmVnaXN0ZXIoKSB3aXRoIHJlZ2FyZCB0byBjaGFyZGV2DQo+IGlu
aXRdIGlzOg0KPiAxLiBpaW9fZGV2aWNlX2J1ZmZlcnNfaW5pdCgpIHdpbGwgaW5pdCBidWZmZXIg
YW5kIHRoZSBjaGFyZGV2LCBpZiB0aGF0DQo+ICAgIHdvcmtzLCB0aGUgJ2lpb19kZXZpY2VfZXZl
bnRfaW9jdGwoKScgd2lsbCBiZSBhdHRhY2hlZCB0byB0aGUgY2hhcmRldg0KPiAyLiBpZiBDT05G
SUdfSUlPX0JVRkZFUiBpcyBub3QgZGVmaW5lZCBvciAnaW5kaW9fZGV2LT5idWZmZXIgPT0gTlVM
TCcNCj4gICAgKG5vIGJ1ZmZ0ZXIgYXR0YWNoZWQpLCAtRU5PVFNVUFAgc2hvdWxkIGJlIHJldHVy
bmVkIGZyb20NCj4gICAgaWlvX2RldmljZV9idWZmZXJzX2luaXQoKSwgaW4gd2hpY2ggY2FzZSB0
aGUgY2hhcmRldiBzaG91bGQgYmUNCj4gICAgaW5pdGlhbGl6ZWQgaW4gICdpbmR1c3RyaWFsaW8t
ZXZlbnQuYycgdmlhDQo+ICAgICdpaW9fZGV2aWNlX3JlZ2lzdGVyX2V2ZW50X2NocmRldigpJw0K
PiANCj4gT25lIG5lYXQgc2lkZSBlZmZlY3Qgb2YgdGhpcyBsb2dpYywgaXMgdGhhdCB3ZSBjYW4g
YWxzbyBtb3ZlIHRoZSBidWZmZXINCj4gc3lzZnMgYWxsb2MvY2xlYW51cCBpbnRvICdpbmR1c3Ry
aWFsaW8tYnVmZmVyLmMnIHVuZGVyIHRoZSBuZXcNCj4gJ2lpb19kZXZpY2VfYnVmZmVyc197dW59
aW5pdCgpJyBmdW5jdGlvbnMuDQo+IA0KPiBDaGFuZ2Vsb2cgdjIgLT4gdjM6DQo+ICogcmVtb3Zl
ZCBkb3VibGUgaW5pdCBpbg0KPiAgICdpaW86IGV2ZW50OiBtb3ZlIGV2ZW50LW9ubHkgY2hhcmRl
diBpbiBpbmR1c3RyaWFsaW8tZXZlbnQuYycNCj4gDQo+IENoYW5nZWxvZyB2MSAtPiB2MjoNCj4g
KiByZS1yZXZpZXdlZCBzb21lIGV4aXQtcGF0aHMgYW5kIGNsZWFudXAgc29tZSBwb3RlbnRpYWwg
bGVha3Mgb24gdGhvc2UNCj4gICBleGl0IHBhdGhzOg0KPiAgIC0gZm9yICdpaW86IGJ1ZmZlcjog
bW92ZSBpaW8gYnVmZmVyIGNocmRldiBpbiBpbmR1c3RyaWFsaW8tYnVmZmVyLmMnDQo+ICAgICBh
ZGQgaWlvX2RldmljZV9idWZmZXJzX3B1dCgpIGhlbHBlciBhbmQgY2FsbGluZyBpaW9fYnVmZmVy
c191bmluaXQoKQ0KPiAgICAgb24gZGV2aWNlIHVuLXJlZ3NpdGVyDQo+ICAgLSBmb3IgJ21vdmUg
c3lzZnMgYWxsb2MvZnJlZSBpbiBpbmR1c3RyaWFsaW8tYnVmZmVyLmMnDQo+ICAgICBjYWxsICdp
aW9fYnVmZmVyX2ZyZWVfc3lzZnNfYW5kX21hc2soKScgb24gZXhpdCBwYXRoIGlmDQo+ICAgICBj
ZGV2X2RldmljZV9hZGQoKSBmYWlscw0KPiAgIC0gZm9yICdtb3ZlIGV2ZW50LW9ubHkgY2hhcmRl
diBpbiBpbmR1c3RyaWFsaW8tZXZlbnQuYycNCj4gICAgIGNoZWNrIGlmIGV2ZW50X2ludGVyZmFj
ZSBpcyBOVUxMIGluDQo+ICAgICBpaW9fZGV2aWNlX3VucmVnaXN0ZXJfZXZlbnRfY2hyZGV2KCkN
Cj4gDQo+IEFsZXhhbmRydSBBcmRlbGVhbiAoNSk6DQo+ICAgaWlvOiBjb3JlOiByZWdpc3RlciBi
dWZmZXIgZmlsZW9wcyBvbmx5IGlmIGJ1ZmZlciBwcmVzZW50DQo+ICAgaWlvOiBidWZmZXI6IGFk
ZCBiYWNrLXJlZiBmcm9tIGlpb19idWZmZXIgdG8gaWlvX2Rldg0KPiAgIGlpbzogYnVmZmVyOiBt
b3ZlIGlpbyBidWZmZXIgY2hyZGV2IGluIGluZHVzdHJpYWxpby1idWZmZXIuYw0KPiAgIGlpbzog
YnVmZmVyOiBtb3ZlIHN5c2ZzIGFsbG9jL2ZyZWUgaW4gaW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+
ICAgaWlvOiBldmVudDogbW92ZSBldmVudC1vbmx5IGNoYXJkZXYgaW4gaW5kdXN0cmlhbGlvLWV2
ZW50LmMNCj4gDQo+ICBkcml2ZXJzL2lpby9paW9fY29yZS5oICAgICAgICAgICAgfCAgMzAgKysr
LS0tLQ0KPiAgZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jIHwgMTQ0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLQ0KPiAgZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUu
YyAgIHwgMTA3ICsrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIGRyaXZlcnMvaWlvL2luZHVzdHJp
YWxpby1ldmVudC5jICB8IDEyMiArKysrKysrKysrKysrKysrKysrKysrKystDQo+ICBpbmNsdWRl
L2xpbnV4L2lpby9idWZmZXJfaW1wbC5oICAgfCAgMTAgKysrDQo+ICBpbmNsdWRlL2xpbnV4L2lp
by9paW8uaCAgICAgICAgICAgfCAgIDQgLQ0KPiAgNiBmaWxlcyBjaGFuZ2VkLCAyODUgaW5zZXJ0
aW9ucygrKSwgMTMyIGRlbGV0aW9ucygtKQ0KPiANCg==
