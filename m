Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4794710CB9E
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2019 16:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfK1PUD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Nov 2019 10:20:03 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:37338 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfK1PUD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Nov 2019 10:20:03 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 4nv0DCCB4m3p6tKqhG7xG4lR7D9yvzbbYoOcrazrMx2cMDrlp6sch4KKuDxFO8t8MWpjYtiYw6
 dA00QXNprVmwk/hAga3Cs74CzOluylTJWrfnGy8gq+uX5Dp+i3bgmltpju50eZ2OHfzvP5vW0G
 o1HtV5O0gzjejlq8u55mk0EwSKLsz6r9zCZvPi0jXHJBKc/lxpxsZMu4naMwqRcncjSI10+4MA
 TW5dDCjvyuo07EcLWGv0HnYEcFMKPfqHeImdLVEqPUnM+M5SbQW4ofEjEO76HIA7r4vaPt5L1d
 tok=
X-IronPort-AV: E=Sophos;i="5.69,253,1571727600"; 
   d="scan'208";a="58682137"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Nov 2019 08:20:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 28 Nov 2019 08:20:00 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 28 Nov 2019 08:20:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IP9sve20a2cYhU19w4Ry7fnfu84UseQak+T/iADrMWFFeMowWOVnsNPk3VYkv/1VXjuAAPXJZUa1BV209EGGHofn1dchHZXe3lKBNJTestYp1Hth8h3QMeLuNyPwJp+e0XRdgZN7zqUXF7arDtc72dhj9yKzOBRNdDuHCXbaPVhLRcI8t7OHMnupWS+lPGGAuCnnxgz+YZOO3Kzi+4l4i2Lc+PNc5957CRrRqIJLCLetdCOuiYIUKi+2vSz0R+1cq08QKS+JmDk1rQlHxi7eaEuUE0qJ1uSzEn0gbeD0YnHwMbI+PuIg0sVdJQtF5rw5fbwNKIzNtV4AIQJenXyg1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXQQR9BgwtQJIc0M+PwHVUIW8T7sb/yTSpPrKpPiTE4=;
 b=OgI8BVMfou2QznnO2ZBuR6JR16jxzOGbF/v7poP7jgih+/4P0cW3mhBDE9LgE8W63XAIkoVxAZMOCIkS+ofzmQ7R3M1QecmzGAnO67O/UsIOcAqkVjya/KOfWvuaWX3g2pUcQlrRUt2DqfmdixpJ5qwkhJrz26xlhX8GPe9Uq3ki0HXcyUvMsPriwxKjYQmbHLzt7OA9tkSuXumPVQvUtpnzM1/10BnnMp6sSQA1/1ue50p/IlXXMD6WQWnXMlhgymlliyBXHW3qJSIoCa6eCU2RxPVP/15N/E2uUXbsZIY/U7VlogA8xOVmqCt8OFw+bP6fLI4KXw6TGvVG26k0pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXQQR9BgwtQJIc0M+PwHVUIW8T7sb/yTSpPrKpPiTE4=;
 b=aC2KYhqeInVBnsiovLWK1Iem1aW1JZNazk+YFqCjqu6WTLUIF2ecee2F+USWidQqMgNquW7J8hKs/eRnheajxsaj/oJYvs+9EZUf5JMAzUXD+WyM8GYN0ERiny0P4pYRYjBIcp5sCCwqXKoD+gJADHvPI5/sS5KxyyfdiYGvCMM=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1993.namprd11.prod.outlook.com (10.168.107.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Thu, 28 Nov 2019 15:19:58 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2495.014; Thu, 28 Nov
 2019 15:19:58 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <alexandru.Ardelean@analog.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <lars@metafoo.de>,
        <Ludovic.Desroches@microchip.com>, <pmeerw@pmeerw.net>,
        <knaack.h@gmx.de>, <jic23@kernel.org>
Subject: Re: [PATCH] iio: at91-sama5d2_adc: fix
 iio_triggered_buffer_{predisable,postenable} positions
Thread-Topic: [PATCH] iio: at91-sama5d2_adc: fix
 iio_triggered_buffer_{predisable,postenable} positions
Thread-Index: AQHVo6GcybDu2MmyfkWfKAIGUFGv9aegRneAgABwyQA=
Date:   Thu, 28 Nov 2019 15:19:58 +0000
Message-ID: <e43bf58f-223c-0b12-2912-6f353d866ec3@microchip.com>
References: <20191023082508.17583-1-alexandru.ardelean@analog.com>
 <17cf55869cc418795d0013c0594ed8fc04381d46.camel@analog.com>
 <9df3d999-0ec6-a282-d24b-8f7df5f14f6d@microchip.com>
In-Reply-To: <9df3d999-0ec6-a282-d24b-8f7df5f14f6d@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR05CA0024.eurprd05.prod.outlook.com (2603:10a6:205::37)
 To DM5PR11MB1242.namprd11.prod.outlook.com (2603:10b6:3:14::8)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191128171942538
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 643d9cdf-632b-472a-dba1-08d774166df1
x-ms-traffictypediagnostic: DM5PR11MB1993:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB199356A244B5F3BF0ED9447BE8470@DM5PR11MB1993.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(39860400002)(136003)(189003)(199004)(51914003)(3846002)(6436002)(4326008)(6512007)(71190400001)(316002)(229853002)(110136005)(54906003)(6486002)(25786009)(14444005)(14454004)(81166006)(4001150100001)(8936002)(6306002)(81156014)(36756003)(8676002)(99286004)(478600001)(6246003)(5024004)(966005)(2501003)(31686004)(256004)(6116002)(31696002)(76176011)(102836004)(186003)(2616005)(2906002)(71200400001)(386003)(6506007)(53546011)(446003)(11346002)(7736002)(305945005)(66066001)(2201001)(66946007)(66556008)(26005)(52116002)(5660300002)(66446008)(66476007)(64756008)(86362001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1993;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E6tA/8Uc0WhY7SnnxCuUHZMmCM+dLPOJC37+hzpnhYLaGWXOY4o5TBKO2rqRb9QPXLVnxXObo+uabwvhgq3GPg82sslRwZHXxGjeZjR4+r38am5AWpdGrvl8YEmwGrHbq0hUr+gs66sm/fO3T513Jv++pcYfjxwxV2tCvraNmNW4UXnFh6zWueLlE5bqZlgw3LCWVot33cLuIcIjyz2L7BNK8Nebnwv3u9JlSehaywnWKMrg1yEe1hqGScVhH645P7sixEjgon5ApriG7GXv3RZwR06N+g9UzMqvKAV6EScLN5bpj5QFP9jmZ9QlpNQj6h1+WRtUBIR6BNtxpLYhPotStC6cyc8+lGiQknNh3kTLVVO4JfekCHjhVPfjvVAs1jJJqLMgW2iGKZiTTEVTPss4m+tiWjQIzm3FxJv227F9frdUTLA8W/fTBeiSx5hD7qyYORhM9sseqBBEKmSkjFzo6ZLESSZq7Q442gBvJf4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54978D30D29F124CA874A2D3C0557CF2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 643d9cdf-632b-472a-dba1-08d774166df1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 15:19:58.3771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F10/AAKPvlxbJ6yRzTruFWmCKIIi7y2D51HOrN3HqbXkyDNiZpwtqGirtpq4ghi97yjfV6nB+UoMA8uGGr9/5HIvrR/G5Igsavb+ea20WAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1993
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCk9uIDI4LjExLjIwMTkgMTA6MzYsIEV1Z2VuLkhyaXN0ZXZAbWljcm9jaGlwLmNvbSB3cm90
ZToNCg0KPiBPbiAyNS4xMS4yMDE5IDE3OjAzLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdyb3RlOg0K
Pj4gT24gV2VkLCAyMDE5LTEwLTIzIGF0IDExOjI1ICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4g
d3JvdGU6DQo+Pj4gVGhlIGlpb190cmlnZ2VyZWRfYnVmZmVyX3twcmVkaXNhYmxlLHBvc3RlbmFi
bGV9IGZ1bmN0aW9ucyBhdHRhY2gvZGV0YWNoDQo+Pj4gcG9sbCBmdW5jdGlvbnMuDQo+Pj4NCj4+
PiBUaGUgaWlvX3RyaWdnZXJlZF9idWZmZXJfcG9zdGVuYWJsZSgpIHNob3VsZCBiZSBjYWxsZWQg
Zmlyc3QgdG8gYXR0YWNoDQo+Pj4gdGhlDQo+Pj4gcG9sbCBmdW5jdGlvbiwgYW5kIHRoZW4gdGhl
IGRyaXZlciBjYW4gaW5pdCB0aGUgZGF0YSB0byBiZSB0cmlnZ2VyZWQuDQo+Pj4NCj4+PiBTaW1p
bGFybHksIGlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRpc2FibGUoKSBzaG91bGQgYmUgY2FsbGVk
IGxhc3QgdG8NCj4+PiBmaXJzdA0KPj4+IGRpc2FibGUgdGhlIGRhdGEgKHRvIGJlIHRyaWdnZXJl
ZCkgYW5kIHRoZW4gdGhlIHBvbGwgZnVuY3Rpb24gc2hvdWxkIGJlDQo+Pj4gZGV0YWNoZWQuDQo+
IA0KPiBIaSBBbGV4YW5kcnUsDQo+IA0KPiBTb3JyeSBmb3IgdGhpcyBsYXRlIHJlcGx5LA0KPiAN
Cj4gSSByZW1lbWJlciB0aGF0IGJ5IGFkZGluZyBzcGVjaWZpYyBhdDkxX2FkYyBjb2RlIGZvcg0K
PiBwcmVkaXNhYmxlL3Bvc3RlbmFibGUgLCBJIHdhcyByZXBsYWNpbmcgdGhlIGV4aXN0aW5nIHN0
YW5kYXJkIGNhbGxiYWNrDQo+IHdpdGggbXkgb3duLCBhbmQgaGF2ZSBteSBzcGVjaWZpYyBhdDkx
IGNvZGUgYmVmb3JlIHBvc3RlbmFibGUgYW5kIHRoZW4NCj4gY2FsbGluZyB0aGUgc3Vic3lzdGVt
IHBvc3RlbmFibGUsDQo+IGFuZCBpbiBzaW1pbGFyIHdheSwgZm9yIHByZWRpc2FibGUsIGZpcnN0
IGNhbGwgdGhlIHN1YnN5c3RlbSBwcmVkaXNhYmxlDQo+IHRoZW4gZG9pbmcgbXkgcHJlZGlzYWJs
ZSBjb2RlIChpbiByZXZlcnNlIG9yZGVyIGFzIGluIHBvc3RlbmFibGUpDQo+IA0KPiBJZiB5b3Ug
c2F5IHRoZSBvcmRlciBzaG91bGQgYmUgcmV2ZXJzZWQgKGJhc2ljYWxseSBoYXZlIHRoZSBwb2xs
ZnVuY3Rpb24NCj4gZmlyc3QpLCBob3cgaXMgY3VycmVudCBjb2RlIHdvcmtpbmcgPw0KPiBTaG91
bGQgY3VycmVudCBjb2RlIGZhaWwgaWYgdGhlIHBvbGwgZnVuY3Rpb24gaXMgbm90IGF0dGFjaGVk
IGluIHRpbWUgPw0KPiBPciB0aGVyZSBpcyBhIHJhY2UgYmV0d2VlbiB0cmlnZ2VyZWQgZGF0YSBh
bmQgdGhlIGF0dGFjaG1lbnQgb2YgdGhlDQo+IHBvbGxmdW5jID8NCj4gDQo+IEkgYW0gdGhpbmtp
bmcgdGhhdCBhdHRhY2hpbmcgdGhlIHBvbGxmdW5jIGxhdGVyIG1ha2VzIGl0IHdvcmsgYmVjYXVz
ZQ0KPiB0aGUgRE1BIGlzIG5vdCBzdGFydGVkIHlldC4gV2hhdCBoYXBwZW5zIGlmIHdlIGhhdmUg
dGhlIHBvbGxmdW5jDQo+IGF0dGFjaGVkIGJ1dCBETUEgaXMgbm90IHN0YXJ0ZWQgKGJhc2ljYWxs
eSB0aGUgdHJpZ2dlciBpcyBub3Qgc3RhcnRlZCkgLA0KPiBjYW4gdGhpcyBsZWFkIHRvIHVuZXhw
ZWN0ZWQgYmVoYXZpb3IgPyBMaWtlIHRoZSBwb2xsZnVuYyBwb2xsaW5nIGJ1dCBubw0KPiB0cmln
Z2VyIHN0YXJ0ZWQvbm8gRE1BIHN0YXJ0ZWQuDQoNCkkgbG9va2VkIGEgYml0IG1vcmUgaW50byB0
aGUgY29kZSBhbmQgaW4gRE1BIGNhc2UsIHVzaW5nIHBvc3RlbmFibGUgDQpmaXJzdCB3aWxsIGxl
YWQgdG8gY2FsbGluZyBhdHRhY2ggcG9sbGZ1bmMsIHdoaWNoIHdpbGwgYWxzbyBlbmFibGUgdGhl
IA0KdHJpZ2dlciwgYnV0IHRoZSBETUEgaXMgbm90IHlldCBzdGFydGVkLg0KSXMgdGhpcyB0aGUg
ZGVzaXJlZCBlZmZlY3QgPyBOb3JtYWxseSB3aGVuIHVzaW5nIERNQSBJIHdvdWxkIHNheSB3ZSAN
CndvdWxkIG5lZWQgdG8gZW5hYmxlIERNQSBmaXJzdCB0byBiZSByZWFkeSB0byBjYXJyeSBkYXRh
IChhbmQgY29oZXJlbnQgDQphcmVhIGV0Yy4pIGFuZCB0aGVuIGVuYWJsZSB0aGUgdHJpZ2dlci4N
Cg0KPiANCj4+Pg0KPj4+IEZvciB0aGlzIGRyaXZlciwgdGhlIHByZWRpc2FibGUgJiBwb3N0ZW5h
YmxlIGhvb2tzIGFyZSBhbHNvIG5lZWQgdG8gdGFrZQ0KPj4+IGludG8gY29uc2lkZXJhdGlvbiB0
aGUgdG91Y2hzY3JlZW4sIHNvIHRoZSBob29rcyBuZWVkIHRvIGJlIHB1dCBpbiBwbGFjZXMNCj4+
PiB0aGF0IGF2b2lkIHRoZSBjb2RlIGZvciB0aGF0IGNhcmVzIGFib3V0IGl0Lg0KPj4+DQo+Pg0K
Pj4gcGluZyBoZXJlDQo+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8
YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgZHJpdmVycy9p
aW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYyB8IDE5ICsrKysrKysrKystLS0tLS0tLS0NCj4+PiAg
ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4+Pg0K
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jIGIvZHJp
dmVycy9paW8vYWRjL2F0OTEtDQo+Pj4gc2FtYTVkMl9hZGMuYw0KPj4+IGluZGV4IGUxODUwZjNk
NWNmMy4uYWMzZTVjNGM5ODQwIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hdDkx
LXNhbWE1ZDJfYWRjLmMNCj4+PiArKysgYi9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2Fk
Yy5jDQo+Pj4gQEAgLTg4OSwyMCArODg5LDI0IEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNfYnVmZmVy
X3Bvc3RlbmFibGUoc3RydWN0DQo+Pj4gaWlvX2RldiAqaW5kaW9fZGV2KQ0KPj4+ICAgICAgICAg
aWYgKCEoaW5kaW9fZGV2LT5jdXJyZW50bW9kZSAmIElORElPX0FMTF9UUklHR0VSRURfTU9ERVMp
KQ0KPj4+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+Pg0KPj4+ICsgICAgIHJl
dCA9IGlpb190cmlnZ2VyZWRfYnVmZmVyX3Bvc3RlbmFibGUoaW5kaW9fZGV2KTsNCj4+PiArICAg
ICBpZiAocmV0KQ0KPj4+ICsgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+PiArDQo+Pj4gICAg
ICAgICAvKiB3ZSBjb250aW51ZSB3aXRoIHRoZSB0cmlnZ2VyZWQgYnVmZmVyICovDQo+Pj4gICAg
ICAgICByZXQgPSBhdDkxX2FkY19kbWFfc3RhcnQoaW5kaW9fZGV2KTsNCj4+PiAgICAgICAgIGlm
IChyZXQpIHsNCj4+PiAgICAgICAgICAgICAgICAgZGV2X2VycigmaW5kaW9fZGV2LT5kZXYsICJi
dWZmZXIgcG9zdGVuYWJsZSBmYWlsZWRcbiIpOw0KPj4+ICsgICAgICAgICAgICAgaWlvX3RyaWdn
ZXJlZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0KPj4+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gcmV0Ow0KPj4+ICAgICAgICAgfQ0KPj4+DQo+Pj4gLSAgICAgcmV0dXJuIGlpb190cmln
Z2VyZWRfYnVmZmVyX3Bvc3RlbmFibGUoaW5kaW9fZGV2KTsNCj4+PiArICAgICByZXR1cm4gMDsN
Cj4+PiAgICB9DQo+Pj4NCj4+PiAgICBzdGF0aWMgaW50IGF0OTFfYWRjX2J1ZmZlcl9wcmVkaXNh
YmxlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+Pj4gICAgew0KPj4+ICAgICAgICAgc3Ry
dWN0IGF0OTFfYWRjX3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+Pj4gLSAgICAg
aW50IHJldDsNCj4+PiAgICAgICAgIHU4IGJpdDsNCj4+Pg0KPj4+ICAgICAgICAgLyogY2hlY2sg
aWYgd2UgYXJlIGRpc2FibGluZyB0cmlnZ2VyZWQgYnVmZmVyIG9yIHRoZSB0b3VjaHNjcmVlbiAq
Lw0KPj4+IEBAIC05MTYsMTMgKzkyMCw4IEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNfYnVmZmVyX3By
ZWRpc2FibGUoc3RydWN0IGlpb19kZXYNCj4+PiAqaW5kaW9fZGV2KQ0KPj4+ICAgICAgICAgaWYg
KCEoaW5kaW9fZGV2LT5jdXJyZW50bW9kZSAmIElORElPX0FMTF9UUklHR0VSRURfTU9ERVMpKQ0K
Pj4+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+Pg0KPj4+IC0gICAgIC8qIGNv
bnRpbnVlIHdpdGggdGhlIHRyaWdnZXJlZCBidWZmZXIgKi8NCj4+PiAtICAgICByZXQgPSBpaW9f
dHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlvX2Rldik7DQo+Pj4gLSAgICAgaWYgKHJl
dCA8IDApDQo+Pj4gLSAgICAgICAgICAgICBkZXZfZXJyKCZpbmRpb19kZXYtPmRldiwgImJ1ZmZl
ciBwcmVkaXNhYmxlIGZhaWxlZFxuIik7DQo+Pj4gLQ0KPj4+ICAgICAgICAgaWYgKCFzdC0+ZG1h
X3N0LmRtYV9jaGFuKQ0KPj4+IC0gICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+PiArICAgICAg
ICAgICAgIGdvdG8gb3V0Ow0KPj4+DQo+Pj4gICAgICAgICAvKiBpZiB3ZSBhcmUgdXNpbmcgRE1B
IHdlIG11c3QgY2xlYXIgcmVnaXN0ZXJzIGFuZCBlbmQgRE1BICovDQo+Pj4gICAgICAgICBkbWFl
bmdpbmVfdGVybWluYXRlX3N5bmMoc3QtPmRtYV9zdC5kbWFfY2hhbik7DQo+Pj4gQEAgLTk0OSw3
ICs5NDgsOSBAQCBzdGF0aWMgaW50IGF0OTFfYWRjX2J1ZmZlcl9wcmVkaXNhYmxlKHN0cnVjdCBp
aW9fZGV2DQo+Pj4gKmluZGlvX2RldikNCj4+Pg0KPj4+ICAgICAgICAgLyogcmVhZCBvdmVyZmxv
dyByZWdpc3RlciB0byBjbGVhciBwb3NzaWJsZSBvdmVyZmxvdyBzdGF0dXMgKi8NCj4+PiAgICAg
ICAgIGF0OTFfYWRjX3JlYWRsKHN0LCBBVDkxX1NBTUE1RDJfT1ZFUik7DQo+Pj4gLSAgICAgcmV0
dXJuIHJldDsNCj4+PiArDQo+Pj4gK291dDoNCj4gDQo+IA0KPiBJIHdvdWxkIHByZWZlciBpZiB0
aGlzIGxhYmVsIGlzIG5hbWVkIHdpdGggYSBmdW5jdGlvbiBuYW1lIHByZWZpeCwNCj4gb3RoZXJ3
aXNlICdvdXQnIGlzIHByZXR0eSBnZW5lcmljIGFuZCBjYW4gY29sbGlkZSB3aXRoIG90aGVyIHRo
aW5ncyBpbg0KPiB0aGUgZmlsZS4uLiBJIHdhbnQgdG8gYXZvaWQgaGF2aW5nIGFuIG91dDIgLCBv
dXQzIGxhdGVyIGlmIGNvZGUgY2hhbmdlcy4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHBhdGNoLA0K
PiBFdWdlbg0KPiANCj4+PiArICAgICByZXR1cm4gaWlvX3RyaWdnZXJlZF9idWZmZXJfcHJlZGlz
YWJsZShpbmRpb19kZXYpOw0KPj4+ICAgIH0NCj4+Pg0KPj4+ICAgIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgaWlvX2J1ZmZlcl9zZXR1cF9vcHMgYXQ5MV9idWZmZXJfc2V0dXBfb3BzID0gew0KPj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+IGxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbA0KPj4NCg==
