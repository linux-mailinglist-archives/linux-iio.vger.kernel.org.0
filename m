Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DB72A2B7E
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 14:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgKBN33 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 08:29:29 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:64575 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKBN33 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 08:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604323770; x=1635859770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+JlZ7QRWKPQw33fGvpOeBCz6rKoFhdQjFyjnMP2p8nU=;
  b=euYDrUP1CC52msUsGN8RkjGgHpwgfe0Z2u+UqKsWZKHQovQ1IauuR6Y1
   aczk8LtX7lyLH7KYWvHCAK3gp0ZuOB+f/CMnajoPSKzakfbpZXau+ffkH
   3kVkoG3lM6ie2TjDkEJ2Ttuy+dKrzKyLIAqPQmjCUYwcZHc7MMTBNbQgz
   U4O6kc9DLc2LrQq778lkJo0nYf62mNzm5QEZwr6zCZTD2XZhHJ0WrL9qa
   Uq707VuF3cXCLi5RwkTWTfQf0L7AMF/FbK2EIfNcHGbniKNErgzFNfZMc
   rhIPoVV6rvp0zULtkzXALHKHu1+f9TPA1VxdUJ5eWVSQx4S/omvo6zaTN
   A==;
IronPort-SDR: eRGrutUShhPcOtODCAKY6CZWo0kR9LLaWWY4Xo9Q4KRTqWkiB4izai2xX0eKooztUqQNh5ed9i
 KyeYL0cfFcMJfdb9V3lme+V+bPEvFGR6lFCnY6QkunIUCOs35+d967yxS2eQBhmX4C15tn8QWS
 gF1cUlr1jvWZwl2HwB9X3dZBQD6irSWLI/Wq4NcAil8GaHTdkgxF18AUeV3VeioojwwxRnUwfB
 qm6mNplssn1c3DaAEzSZGM1NM/lBm9hhwAeHCf3nqdMXkJGat/9yrvBAQ2qK97IHvBWB5yp/Ed
 fgs=
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="96822583"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2020 06:29:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 2 Nov 2020 06:29:28 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Mon, 2 Nov 2020 06:29:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oE9xuTy/q+veFTenY/R51pzG2+IEzDOyEe/7a4X036evsd6Zr7CQWLgtZAgwcOhK5YOk061JYMXGFLPblj6GHzZko8XDIlk8/LP3okg7eybGIQQLtGxQYxAtVETkD9a4SAn6snUESMZL/uqMivUVqrUBUEGADeLC43qH4yvHVg8veEFX1xRy+sL1Pex4bu5uldLkzuDSxiD5EuLJt24fCrkp7RaKcyg+iy6Ezw56ufauMISYSY9T9DVwq/kISCl+nByNmFbd5coPJhjTpxZTfuxQKPdqe/Iq80clHJjECjj7k9zHgtCvG4uE/j9dyCfryOC6xiWYUv8fO4uyVM4mEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JlZ7QRWKPQw33fGvpOeBCz6rKoFhdQjFyjnMP2p8nU=;
 b=F2MvDcb+Ekop7ru5ChC8Z4Ylc0L60VWIZRc4J5EWZ3PvH5yNl5JDwNjdWIQsyiRWNVnY3dbWYI0KVKb48/q1VXVc6kdGPfzHXOv2h98TomHlSbuZa+X6oKtTLUaezFexFyLSVjCpR9tvolwcydjcA/Ofjx86dZf897lfpAJOmd5OCNFqJJCMXEC0tKyTC6eMv28yxHnYkikCIcl10MipBh9yW/JAFkOxeJEqrrokAb6hpKlOHkZN6CR3XF0N4Kk/Qj2eKfOTkxuh5/gHmAVdfYYxNY43B1L3Lz3DQY3medDQ70lSKH5kM/xbe814w2B25YM8xAsC0DGk/wFQXYyoNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JlZ7QRWKPQw33fGvpOeBCz6rKoFhdQjFyjnMP2p8nU=;
 b=Iyj5edRkU3v3MWjKxm+mSEODIyAkUJFL+68B7Cikw3i2kdcBNbvNDfHAAAW/BtLpT6U3HZ0uMWMxKnohRCYM55L8Tdbk631hjyJNF24LbKl8V46lTxhsjwXHQVTFaNYC7a9UJKjGsF6hzpkl6qOPs58mHnwWjSq1oCnElKUsP+Q=
Received: from BYAPR11MB2999.namprd11.prod.outlook.com (2603:10b6:a03:90::17)
 by SJ0PR11MB4880.namprd11.prod.outlook.com (2603:10b6:a03:2af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 13:29:27 +0000
Received: from BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::4854:dda7:8d0f:bb51]) by BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::4854:dda7:8d0f:bb51%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 13:29:27 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <ardeleanalex@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <alexandru.ardelean@analog.com>
Subject: Re: Requirement for at91-sama5d2_adc timestamp buffer
Thread-Topic: Requirement for at91-sama5d2_adc timestamp buffer
Thread-Index: AQHWrrfWc5WFebfoFE2qfjGYfQ3FN6mzBWSAgAC2cQCAAR8YgA==
Date:   Mon, 2 Nov 2020 13:29:27 +0000
Message-ID: <767f3b0f-7874-a359-63db-db01fe87fdf1@microchip.com>
References: <8825686e-1fc4-65fd-e482-f25d46288ff7@microchip.com>
 <CA+U=DsoMWH281+1vv8h8aZKumkM+oocrWP6XVKVQ5AoFoXpk3w@mail.gmail.com>
 <20201101202152.72c0f384@archlinux>
In-Reply-To: <20201101202152.72c0f384@archlinux>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.76.24.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e02a8537-131a-48c7-235d-08d87f33524d
x-ms-traffictypediagnostic: SJ0PR11MB4880:
x-microsoft-antispam-prvs: <SJ0PR11MB4880B5826846DC9DE50038D7E8100@SJ0PR11MB4880.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G2Asoz1TNGSWDWu+71xQnmUdkJfbRdmwkf0Jg2LOLXqTfoKPGWrXBsXrJ9+IMqHsQ15V1o5gWpvNCqPIkNlqvMbujWn8PbuiyQV/UKOJZYgFpX827e5eRlkse/aIoTqOhLPrYjM4uIaASRsxRd/VZQ+eW7eqQ3VqQuLj5hyt1fvvQS9vPoHFJCoqbZjIAjTtIfuvSBhiJ2i4uee3kYsjVTOiaBXiulCDQCpP5SlsCSrLPGp43wsMHaGFN/9UqQW5nPUJkkWYhP2PbzLRVNKYkPZ4aOteFuhAtz1aWKOHlLO6KoHCItTSxj/YsFzqpITVIk89+GKkSi30arKLWdvBplBnA7vtylUTZeGGNagnEfceuIyAH5ReUQXIcooc9FU/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(396003)(39860400002)(31686004)(66946007)(8936002)(8676002)(316002)(53546011)(186003)(478600001)(6486002)(2906002)(91956017)(66476007)(66556008)(76116006)(4326008)(64756008)(54906003)(5660300002)(110136005)(66446008)(36756003)(2616005)(86362001)(83380400001)(71200400001)(6506007)(26005)(31696002)(6512007)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2zbGyynd8jIPpgKbYquVlpRYySVYidtr2vNBJ8w1HwG0l796SBioIvwdhl3L3so0fS4iE22tEfO7crcwiKeWvQhA7TS6c5Z0L1xbbuJkifus3eBGWlgjQv/8eAYzu5MaURUSYf5tdJUx4LEAwGB28jskm2+XuPB672vJCk6GwkFrZKgKDiDSMOrHe2DicVWyRMU/Tt26PHHA+xz/zFIheW/fpfJP35uU5BpAgQQ2KtpUcyn63pt5pWkloFzDRAWCX8PUp5DHNPRmWeM43A10Aj6/O9rbG3pyjSomVwsrFkyUT4dCLpEAqutdUJ+uHNJINSQAmQ0gbmV9AGzEmkizQsjWcFXE6WNfxzz25Y5h6vFkdS9mXTjut9LVgSKxIiLYy3G34vYcfdkwl3N60xpUj50exVlHuELN3FEFk0GaN3YxyYG0K9kOJq4r903Pshx0tkDIWF/xLC4lJ5Z2pC4xdqiMvjBRDdGzb72+cUQTAm5IyOt1qxT944SU+mANYXIrpuFmLCYmRovBCEZkgY0xwAmCcF7jd1NOcRRXrkHzp/BzEpeG2AAzAY596pmXdrhAT7+hdNBZz6x57ewaCZVBalEZMv3vOjg8dnumnw7p4wYvMWuGJrPng/9f9LqahPSxorc1lr8EhoL+oY4/uKBPjw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <63F6C5D98601AC41B025B19DB1BB73C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02a8537-131a-48c7-235d-08d87f33524d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 13:29:27.3112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SoNeAenA9m4sldIwhq+YTQRpB7zxxJNQlGrPEglJ8b7hx5lHjEvsXEmAMSBTlMf07aETcsKgBsaOMCd5pmE0+/URW3M2N1ez/i1bJQERB+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4880
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMDEuMTEuMjAyMCAyMjoyMSwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gU3VuLCAx
IE5vdiAyMDIwIDExOjI4OjUzICswMjAwDQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YXJkZWxlYW5h
bGV4QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPj4gT24gRnJpLCBPY3QgMzAsIDIwMjAgYXQgMjoy
OSBQTSA8RXVnZW4uSHJpc3RldkBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4+Pg0KPj4+IEhlbGxv
IEpvbmF0aGFuLA0KPj4+DQo+Pj4gSSBmb3VuZCBhbiBpc3N1ZSB3aXRoIGF0OTEtc2FtYTVkMl9h
ZGMgZHJpdmVyLCBuYW1lbHksIHdoZW4gdXNpbmcgRE1BDQo+Pj4gYW5kIHRpbWVzdGFtcCBpbiB0
aGUgc2FtZSB0aW1lLCB0aGUgaGFyZHdhcmUgcHJvdmlkZXMgdGhlIHNhbXBsZSBpbiB0aGUNCj4+
PiBmYXNoaW9uICgyIGJ5dGVzIHBlciBjaGFubmVsKSAqIChudW1iZXIgb2YgY2hhbm5lbHMpIC0g
YXMgY29waWVkIGJ5IHRoZQ0KPj4+IERNQSBtYXN0ZXIgdG8gbWVtb3J5Lg0KPj4+IEkgY29tcHV0
ZSBhIHNvZnR3YXJlIHRpbWVzdGFtcCAsIGFuZCB0aGVuIHB1c2ggdG8gYnVmZmVycyB3aXRoIHRp
bWVzdGFtcC4NCj4+PiBIb3dldmVyIHlvdXIgcHVzaCBjb2RlIHdpbGwgdHJ5IHRvIHdyaXRlIHRo
aXMgdGltZXN0YW1wIGluc2lkZSBteSBidWZmZXINCj4+PiAhIGFuZCBvdmVyd3JpdGUgbXkgc2Ft
cGxlcy4uLiBJIGhhdmUgbXVsdGlwbGUgc2FtcGxlcyBpbiB0aGUgYnVmZmVyDQo+Pj4gKHdhdGVy
bWFyayBudW1iZXIpIGFuZCB0aGVyZSBpcyBubyBzcGFjZSBiZXR3ZWVuIHRoZW0gYmVjYXVzZSB0
aGUNCj4+PiBoYXJkd2FyZSBjb3BpZXMgdGhlIGNvbnZlcnNpb24gZGF0YSBkaXJlY3RseSBpbiB0
aGlzIGJ1ZmZlci4NCj4+Pg0KPj4+IERvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9uIG9uIGhvdyB0
byBzb2x2ZSB0aGlzLCBleGNlcHQgMSkgZ2l2aW5nIHVwIHRoZQ0KPj4+IHRpbWVzdGFtcCBpbiB0
aGlzIG1vZGUgb3IgMikgY29weSB0byBhbm90aGVyIGJ1ZmZlciB3aXRoIG1vcmUgc3BhY2UgZm9y
DQo+Pj4gdGltZXN0YW1wIHN0b3JhZ2UgPw0KPj4NCj4+IEknbSBhc3N1bWluZyB0aGUgaXNzdWUg
aXMgaGVyZToNCj4+ICAgICAgICAgICAgICAgICAgaWlvX3B1c2hfdG9fYnVmZmVyc193aXRoX3Rp
bWVzdGFtcChpbmRpb19kZXYsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAo
c3QtPmRtYV9zdC5yeF9idWYgKyBzdC0+ZG1hX3N0LmJ1Zl9pZHgpLA0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKHN0LT5kbWFfc3QuZG1hX3RzICsgaW50ZXJ2YWwgKiBzYW1w
bGVfaW5kZXgpKTsNCj4+DQo+PiBDYW4gdGhlIERNQSBiZSBjb25maWd1cmVkIHRvIGFkZCBzb21l
IHBhZGRpbmcgaW4tYmV0d2VlbiB0aGUgc2FtcGxlcz8NCj4+IEl0IGxvb2tzIGxpa2UgdGhlIHdh
eSB0aGlzIGlzIGN1cnJlbnRseSB3b3JraW5nLCB0aW1lc3RhbXBzIGNhbm5vdA0KPj4gd29yayB3
aXRoIHRoZSBETUEgYnVmZmVycyBhbmQgbXVsdGlwbGUgY29uc2VjdXRpdmUgc2FtcGxlcy4NCj4+
IEJ1dCwgaXQgbWF5IGJlIHRoYXQgdGhpcyBjYXNlIGlzIGEgYml0IHVucmVhbGlzdGljOyBvciBz
aG91bGRuJ3QgYmUgc3VwcG9ydGVkLg0KPj4gRE1BIGlzIHVzZWQgdG8gcHJvdmlkZSByZWFsbHkt
ZmFzdCB0cmFuc2ZlcnM7IGNvbXB1dGluZyB0aW1lc3RhbXBzIGluDQo+PiBTVyBmb3IgZWFjaCBz
YW1wbGUgd291bGQgc2xvdyB0aGluZ3MgZG93biB0byB0aGUgcG9pbnQgd2hlcmUgdGhlDQo+PiB0
cmFuc2ZlcnMgYXJlbid0IGZhc3QgYW55bW9yZS4NCj4+DQo+PiBXaGF0IHdvdWxkIFtwb3NzaWJs
eV0gYmUgYW4gYWx0ZXJuYXRpdmUsIGlzIHRvIGRvIGENCj4+ICJpaW9fcHVzaF9tdWx0aXBsZV9z
YW1wbGVzX3RvX2J1ZmZlcnNfd2l0aF90aW1lc3RhbXAoaW5kaW9fZGV2LCBidWZmZXINCj4+IGZv
ciAxIHNhbXBsZS1zZXQsIG5fc2FtcGxlcywgKSIuDQo+PiBUaGF0IHdvdWxkIGJhc2ljYWxseSBt
ZWFuLCB0aGUgRE1BIGdldHMgMTAsIDEwMCwgMTAwMCBzYW1wbGVzLCBhbmQNCj4+IGFkZHMgYSB0
aW1lc3RhbXAgYXQgdGhlIGVuZC4NCj4+IE5vdywgdGhlIG9ubHkgdGhpbmcgdGhhdCBJIGRvbid0
IGtub3cgaGVyZTogaXMgaG93IHVzZXJzcGFjZSB3b3VsZCBiZQ0KPj4gYWJsZSB0byBkZXRlcm1p
bmUgdGhlIG51bWJlciBvZiBzYW1wbGVzIHVudGlsIHRoZSBuZXh0IHRpbWVzdGFtcC4NCj4+IEkg
Z3Vlc3Mgc29tZSBtZWNoYW5pc20gY291bGQgYmUgZXh0ZW5kZWQgaW5zaWRlIElJTyB0byBhY2Nv
bW1vZGF0ZSBmb3INCj4+IHRoaXM7IE5fc2FtcGxlc190aWxsX3RpbWVzdGFtcCBjb3VudGVyLCB3
aXRoIGEgZGVmYXVsdCB2YWx1ZSBvZiAxLg0KPj4gTm90IHN1cmUgaWYgaXQgbWFrZXMgc2Vuc2Ug
dGhvdWdoLg0KPiANCj4gVGhlcmUgaXMgYSB2ZXJ5IG9ic2N1cmUgYW5kIGxpdHRsZSB1c2VkIGZh
Y2lsaXR5IHRvIHJlcGVhdHMgb2YgYSBzaW5nbGUNCj4gY2hhbm5lbCwgYnV0IHRoYXQncyBhcyBj
bG9zZSBhcyB3ZSBnZXQuICBEZXNjcmliaW5nIGFyYml0cmFyeSBwYXR0ZXJucw0KPiBvZiBkYXRh
IGlzIGhhcmQgdG8gZG8gd2l0aG91dCBhZGRpbmcgdGhlIG92ZXJoZWFkIG9mIGEgaGVhZGVyIGFu
ZCBub3QNCj4gZG9pbmcgdGFnZ2VkIGRhdGEgaGFzIGJlZW4gb25lIG9mIHRoZSBmdW5kYW1lbnRh
bCBkZXNpZ24gZGVjaXNpb25zIGluDQo+IElJTy4NCj4gDQo+IFdlJ3ZlIGRpc2N1c3NlZCBhZGRp
bmcgYSBzZXBhcmF0ZSBtZXRhIGRhdGEgYnVmZmVyLCBidXQgdGhhdCB3b3VsZA0KPiBuZWVkIGV4
dHJhIHN0b3JhZ2UgYW55d2F5IHRvIGZsYWcgd2hlbiB0aGVyZSB3YXMgbWV0YSBkYXRhIHNvIHdv
dWxkbid0DQo+IGhlbHAgeW91IGhlcmUuDQo+IA0KPiBBcyBBbGV4YW5kcnUgYXNrZWQsIGNhbiB5
b3UgcGVyc3VhZGUgdGhlIGRtYSBlbmdpbmUgdG8gbGVhdmUgYSBnYXA/DQoNClRoaXMgbWlnaHQg
d29yayBmb3IgYSBzaW5nbGUgY2hhbm5lbC4gQnV0IGlmIHdlIHVzZSBhcmJpdHJhcnkgbnVtYmVy
IG9mIA0KY2hhbm5lbHMsIG9ubHkgdGhlIGlpbyBkcml2ZXIga25vd3MgaG93IG1hbnkgY2hhbm5l
bHMgYXJlIGVuYWJsZWQgYW5kIA0KaG93IHRvIHNlcGFyYXRlIHRoZSBkYXRhIGludG8gc2FtcGxl
cywgYnkgZGl2aWRpbmcgdG90YWwgZG1hIHJlY2VpdmVkIA0KZGF0YSBieSB0aGUgc2l6ZSBvZiBv
bmUgc2FtcGxlDQpTbyB0aGUgRE1BIGNoYW5uZWwgaXMganVzdCBjb3B5aW5nIGRhdGEgZnJvbSB0
aGUgQURDIGFzIHNvb24gYXMgaXQncyANCnJlYWR5LCBhbmQgdGhlbiBpbiB0aGUgaWlvIGRyaXZl
ciBJIGFtIGp1c3QgcGFzc2luZyB0aGUgYnVmZmVyIHRvIHRoZSANCnN1YnN5c3RlbS4gVGh1cyBp
dCdzIHByZXR0eSB1bmF3YXJlIHRvIGxlYXZlIGEgZ2FwIHdoZW4gdGhlIGNoYW5uZWxzIGFyZSAN
CmRvbmUgZm9yIG9uZSBzYW1wbGUuDQoNCj4gSWYgbm90LCB5b3UgYXJlIGdvaW5nIHRvIGhhdmUg
dG8ga2VlcCBjb3B5aW5nIHRoZSBkYXRhLg0KPiBJIHRoZW9yeSB5b3UgbWlnaHQgYmUgYWJsZSB0
byBwZXJzdWFkZSB0aGUga2ZpZm8gdG8gdGFrZSB0aGF0DQo+IGRhdGEgaW4gZGlmZmVyZW50IGZv
cm0gYW5kIHRoZW4gaW50cm9kdWNlIGEgZGlmZmVyZW50IHBhdGggZm9yDQo+IGJ1ZmZlciBtYW5h
Z2VtZW50IChub3QgaWlvX3B1c2hfdG9fYnVmZmVyc18qKSwgYnV0IHlvdSdkIG5lZWQgdG8NCj4g
ZmlndXJlIG91dCBob3cgdG8gZG8gdGhhdC4NCg0KQ3VycmVudGx5LCBJIGhvbGQgdHdvIHRpbWVz
dGFtcHMgKG9uZSBhdCBETUEgc3RhcnQgYW5kIG9uZSBhdCBETUEgDQpmaW5pc2gpLCBhbmQgdGhl
biBzcHJlYWQgdGhlIHRpbWUgYmV0d2VlbiB0aGVtIGJ5IHRoZSBudW1iZXIgb2Ygc2FtcGxlcyAN
CihKb25hdGhhbidzIGlkZWEgd2hlbiBJIGluaXRpYWxseSBhZGRlZCB0aGUgRE1BIHN1cHBvcnQp
LiBJIGNvdWxkIG1ha2UgDQphbm90aGVyIHByaW1pdGl2ZSB0aGF0IHdvdWxkIHJlY2VpdmUgYSB0
aW1lc3RhbXAgZm9yIERNQSBzdGFydCAsIGFuZCBvbmUgDQpmb3IgRE1BIGVuZCwgYnV0IHRoaXMg
d291bGQgbWVhbiB0aGF0IHRoZSBtZW1jb3B5IHdvdWxkIGJlIGRvbmUgaW5zaWRlIA0KdGhlIGlp
byBzdWJzeXN0ZW0gKHdoaWNoIGlzIGFnYWluIGEgcGVyZm9ybWFuY2UgYmxvY2tlcikNCklzIHRo
ZXJlIGEgd2F5IHRvIGhhdmUgYSBjaGFubmVsIGVuYWJsZWQsIGJ1dCB0aGlzIGNoYW5uZWwgd291
bGQgcHJvdmlkZSANCmRhdGEgbm90IGV2ZXJ5IHRpbWUgc28gdG8gc2F5LCBmb3IgZXhhbXBsZSwg
b25jZSBldmVyeSBYIHNhbXBsZXMgPw0KSSBjb3VsZCBhbHRlciB0aGUgc2Nhbl9tYXNrIHRvIHJl
bW92ZSB0aGUgdGltZXN0YW1wIGNoYW5uZWwgYW5kIHRoZW4gDQpyZWVuYWJsZSB0aGUgdGltZXN0
YW1wIGFuZCBwcm92aWRlIHRpbWVzdGFtcCBpbmZvcm1hdGlvbiBhdCB0aGUgZW5kIG9mIA0Kb25l
IERNQSBjaHVuayA/DQpEb2VzIHRoaXMgc291bmQgYXMgYSBnb29kIHNvbHV0aW9uID8NCg0KVGhh
bmtzLA0KRXVnZW4NCj4+DQo+Pj4NCj4+PiBUaGFua3MsDQo+Pj4gRXVnZW4NCj4gDQoNCg==
