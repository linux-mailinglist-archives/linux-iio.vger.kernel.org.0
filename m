Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACDB1B59BF
	for <lists+linux-iio@lfdr.de>; Thu, 23 Apr 2020 12:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgDWK5L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Apr 2020 06:57:11 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:55402 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgDWK5L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Apr 2020 06:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1587639430; x=1619175430;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jiPF0DZZ46d2h5+4mccrUZmJEHG9jbz8Hk2Nh8vd2XQ=;
  b=D6P9oG3uk7FT8hCB5Nh4r7lnTmF/Plu0rrD0pfKZMTXXw68cPvk7YEBy
   N85BeWGDyron/v9f8xrJfABRNnlDtzmv0OOQzgaMz9VnW3+gOpe4Uhr6n
   ge2X7BLryhzKTwkTZD9BzGPwx+7oNJKGoe3esGMPzPXyRFK03N+uUmD91
   ad8gVtUzH92Qq+Y+QrAk9xuFecrpSNwtgVvhERd3Yx8+zhOEfpbJ8Teg/
   2ONtf4aBhvdTJPsbCQ/I6uMj2n8kfGjTm2AVPATQVxeTzsnlkOp3aPq6B
   7N7a2TmRVh6fOd1rKZA6dtXgKxV19WSsyx2O7pWE27hDkIl0qY8nwmxGZ
   g==;
IronPort-SDR: Y2D965KZPFkF64yB1xO7mYJi28L4SShjuhohNsJfWhRP3aOj+9TgnO0szAZM+lwb+OjqF7GAd8
 GB6cyRNAKr2HoL99Mv8VTz+bb/BVk+su0aXlkgRX8Qhe7gleFkVDUw2ih2xsnstWdua5C9fMw3
 gbXawwgzugasmkBE+ip72FhbW1awn9rqnYNzIMVjGI+WblEafrLarzpyO5MPe7sw2BDhMe/N+N
 FW/p5TSXg6Dv9nW+j8RpaaX6z9N/po56bps9kV1SSyjrupdi8j+SlSqZrq8umRmx4IVyJOWr0I
 W/o=
X-IronPort-AV: E=Sophos;i="5.73,307,1583218800"; 
   d="scan'208";a="71295719"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2020 03:56:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Apr 2020 03:57:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 23 Apr 2020 03:56:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LueswgFJDJDplOmh6reElvTCmAam4gG0BEKpPVFUfgamcr4MGb7vyzpnFYGjWqv/m4xiuNaCSdVZ3ouXiq8B9ut138aOPmD7FdEsZkNpcV76HO7vGSoa1EgIE7+PLwUwGg/I22rdJaCJlc7yYi7IJBs5nOxjuiWoIcCyNzmMb++aK++Mb6nl3Rmd5tQoC3e6XdHwxesHzI3j6/njYzZQoi+6x8jQ/z2gL7PWxFdPoy+VZWdFucsph0ZRlIjHdBkgSk9YTCV9KWDTZQfmGubuFskjevmjtk1zzSglIJK8zFBO6xXrWPPUgG3gfI7TkkMRDBaCqCAWwWnnkkcb0g6gVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiPF0DZZ46d2h5+4mccrUZmJEHG9jbz8Hk2Nh8vd2XQ=;
 b=g5z6xcj1bYS5twTmtBE4V0/fEsAFZRdXuJ83Ig6uTMrtWeKXzLzBwZ1f97lyYtk4QZrgnNwnybxXkob8+Rg5zz0QZYoRxa7khlaF2mxWHDFk2+OACFYEN7rJsZsPZ/Pu/Z6aRnKbBVDktEGl+715wRnC2bNDuZQVBmrdPcRPDOshJ4VhmD6ZKWOAN5NIZjwGzBjNcVDCY+AWOAPooRQtIgNHvjYTIlra1hc5c0hhWWmY6mtQ7czvvvYxVcfuXIlWtTNOyM8xDKWV09wB7c9el+x5VOdG1I/j0AjfiCbZSNmu+ylLtSt9BbM/DinncbJyfFvPP8c8E/W/uN4VKRr53Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiPF0DZZ46d2h5+4mccrUZmJEHG9jbz8Hk2Nh8vd2XQ=;
 b=P3cHhu+i2QbCxTVyVOduHiPcgKgo3OUEERLywVFesjZ/Icj9CcOMD7rrr36piP280+ooGxHJOM3X1BVVQdDwBvc2vc8mwTKvAGWzKrh/+5aIkt2rFVeXoHuHQxXdUSWn/OtG51K055JX3DEcYS0CGxgfVo8rAg7FLuNnMVdCjDU=
Received: from CY4PR11MB1605.namprd11.prod.outlook.com (2603:10b6:910:10::22)
 by CY4PR11MB1624.namprd11.prod.outlook.com (2603:10b6:910:8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 10:56:54 +0000
Received: from CY4PR11MB1605.namprd11.prod.outlook.com
 ([fe80::7c42:c3d3:aaa:88b]) by CY4PR11MB1605.namprd11.prod.outlook.com
 ([fe80::7c42:c3d3:aaa:88b%12]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 10:56:54 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <Ludovic.Desroches@microchip.com>, <alexandru.ardelean@analog.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>
Subject: Re: [PATCH v2 2/2] iio: at91-sama5d2_adc: adjust
 iio_triggered_buffer_{predisable,postenable} positions
Thread-Topic: [PATCH v2 2/2] iio: at91-sama5d2_adc: adjust
 iio_triggered_buffer_{predisable,postenable} positions
Thread-Index: AQHV8gB4tA4eiwx+E0mPUJeGE8vWFqiAf7GAgAZYGAA=
Date:   Thu, 23 Apr 2020 10:56:54 +0000
Message-ID: <4b058757-43cb-871f-c85e-aaca19436bdf@microchip.com>
References: <20200304084219.20810-1-alexandru.ardelean@analog.com>
 <20200304084219.20810-2-alexandru.ardelean@analog.com>
 <20200419100401.cfrmeilkzzdxi4w7@ROU-LT-M43218B.mchp-main.com>
In-Reply-To: <20200419100401.cfrmeilkzzdxi4w7@ROU-LT-M43218B.mchp-main.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-originating-ip: [86.124.246.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06d37d77-d7c7-4982-76fd-08d7e77508dc
x-ms-traffictypediagnostic: CY4PR11MB1624:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1624CEA78178ADFAEF44E9A4E8D30@CY4PR11MB1624.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(136003)(346002)(366004)(376002)(86362001)(316002)(54906003)(110136005)(5660300002)(31696002)(478600001)(8936002)(71200400001)(186003)(2906002)(31686004)(2616005)(4326008)(81156014)(8676002)(36756003)(26005)(76116006)(66476007)(6512007)(66946007)(64756008)(66446008)(66556008)(53546011)(6506007)(91956017)(6486002)(142933001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7BtGBuDHpb8NgR2rxZ7IWmg0lyfMuqQYXdlbN9ZF/D2j29jiP8zXW9970+QO9ywApRfoHMIaEkPwVsgn6PbmuodL7p6aiIxlFic4Kk2XzjegytE30XdBmPZZgF25NynD4EKR9XV586CkPKAEKZue9Mtcw3ZHwcQOm1dQooug7KAcnnB8HrmZBXcZLZdm4xz3ra/J8cs+DziaNK19sNzTApDZ5Z71BLGLXT9FCaL5ReSo7iyz6SlKvLoik9bB1gnfbg+ljkOh4oLPQnzkqw+t6dsJJZoxktXLoRO7gXfqO77Rmblxd0s+G8KiSavv2lTjPgUsXJ1SpMzllwenyizEqbMCk0uFgjXRxByoKj1Ix26W7KZ4unaK/EzbFn2+aCPw/y6MCifbObnb/lCUnLZgKlTVDAL9uutcvafpBmQjsmqpya3HDFsTFQaJ+t2lC5ds2XZTI75No0UU9J3cmK3sZ+HEKEWA06s/sdrb5Kv2k7cZpLwPs004HKLYLilsjR7A
x-ms-exchange-antispam-messagedata: pO8zvZ8dxghpshmcvSThwX9jMeM6zcwaRWPbLGFURuR+okpPAsiKw7CoNvAq7JIV+BBvXT3t3A6WlZUx63CGktYnqnf0VmrfPydqPxwhJXA6QM61YnpfyX74gHBeP61OkPI5+VPcslT6EovfJK54fA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B364E595D29984ABE0A629633EEA938@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d37d77-d7c7-4982-76fd-08d7e77508dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 10:56:54.0941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PKd0KTnyMxe/HAPMvoXYZsYstf63dybOBGdXI4vba/pHKibUY8RJ+nbPS/+3PKkAAztBJPnIi55cJhAo5dxuInSe7bjW6TxR3hHlB2nLAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1624
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMTkuMDQuMjAyMCAxMzowNCwgbHVkb3ZpYy5kZXNyb2NoZXNAbWljcm9jaGlwLmNvbSB3cm90
ZToNCj4gT24gV2VkLCBNYXIgMDQsIDIwMjAgYXQgMTA6NDI6MTlBTSArMDIwMCwgQWxleGFuZHJ1
IEFyZGVsZWFuIHdyb3RlOg0KPj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
Pg0KPj4gVGhlIGlpb190cmlnZ2VyZWRfYnVmZmVyX3twcmVkaXNhYmxlLHBvc3RlbmFibGV9IGZ1
bmN0aW9ucyBhdHRhY2gvZGV0YWNoDQo+PiBwb2xsIGZ1bmN0aW9ucy4NCj4+DQo+PiBJbiBtb3N0
IGNhc2VzIHRoZSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wb3N0ZW5hYmxlKCkgc2hvdWxkIGJlIGNh
bGxlZCBmaXJzdA0KPj4gdG8gYXR0YWNoIHRoZSBwb2xsIGZ1bmN0aW9uLCBhbmQgdGhlbiB0aGUg
ZHJpdmVyIGNhbiBpbml0IHRoZSBkYXRhIHRvIGJlDQo+PiB0cmlnZ2VyZWQuDQo+PiBJbiB0aGlz
IGNhc2UgaXQncyB0aGUgb3RoZXIgd2F5IGFyb3VuZDogdGhlIERNQSBjb2RlIHNob3VsZCBiZSBp
bml0aWFsaXplZA0KPj4gYmVmb3JlIHRoZSBhdHRhY2hpbmcgdGhlIHBvbGwgZnVuY3Rpb24gYW5k
IHRoZSByZXZlcnNlIHNob3VsZCBiZSBkb25lIHdoZW4NCj4+IHVuLWluaXRpYWxpemluZy4NCj4+
DQo+PiBUbyBtYWtlIHRoaW5ncyBlYXNpZXIgd2hlbiByZW1vdmluZyB0aGUgaWlvX3RyaWdnZXJl
ZF9idWZmZXJfcG9zdGVuYWJsZSgpICYNCj4+IGlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRpc2Fi
bGUoKSBmdW5jdGlvbnMgZnJvbSB0aGUgSUlPIGNvcmUgQVBJLCB0aGUgRE1BDQo+PiBjb2RlIGhh
cyBiZWVuIG1vdmVkIGludG8gcHJlZW5hYmxlKCkgZm9yIGluaXQsIGFuZCBwb3N0ZGlzYWJsZSgp
IGZvcg0KPj4gdW5pbml0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVh
biA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogTHVk
b3ZpYyBEZXNyb2NoZXMgPGx1ZG92aWMuZGVzcm9jaGVzQG1pY3JvY2hpcC5jb20+DQoNClJldmll
d2VkLWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQoNCkhp
IEpvbmF0aGFuLA0KDQpQbGVhc2UgZG9uJ3QgZm9yZ2V0IG15IG90aGVyIDIgcGF0Y2hlcyBvbiB0
aGlzIGRyaXZlciwgdGhleSd2ZSBiZWVuIA0KcGF0aWVudGx5IHdhaXRpbmcgZm9yIHRoaXMgbWVy
Z2Ugd2luZG93DQoNClRoYW5rcyENCg0KPiANCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2lpby9hZGMv
YXQ5MS1zYW1hNWQyX2FkYy5jIHwgMzIgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYyBiL2Ry
aXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMNCj4+IGluZGV4IGYyYTc0YzQ3Yzc2OC4u
MmUwMTA3M2Q0MDFkIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVk
Ml9hZGMuYw0KPj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYw0KPj4g
QEAgLTg4Miw3ICs4ODIsNyBAQCBzdGF0aWMgYm9vbCBhdDkxX2FkY19jdXJyZW50X2NoYW5faXNf
dG91Y2goc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgQVQ5MV9TQU1BNUQyX01BWF9DSEFOX0lEWCArIDEpOw0KPj4gICB9DQo+Pg0K
Pj4gLXN0YXRpYyBpbnQgYXQ5MV9hZGNfYnVmZmVyX3Bvc3RlbmFibGUoc3RydWN0IGlpb19kZXYg
KmluZGlvX2RldikNCj4+ICtzdGF0aWMgaW50IGF0OTFfYWRjX2J1ZmZlcl9wcmVlbmFibGUoc3Ry
dWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4+ICAgew0KPj4gICAgICAgICAgaW50IHJldDsNCj4+
ICAgICAgICAgIHN0cnVjdCBhdDkxX2FkY19zdGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYp
Ow0KPj4gQEAgLTkwMiwxMyArOTAyLDIwIEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNfYnVmZmVyX3Bv
c3RlbmFibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4+ICAgICAgICAgICAgICAgICAg
cmV0dXJuIHJldDsNCj4+ICAgICAgICAgIH0NCj4+DQo+PiArICAgICAgIHJldHVybiAwOw0KPj4g
K30NCj4+ICsNCj4+ICtzdGF0aWMgaW50IGF0OTFfYWRjX2J1ZmZlcl9wb3N0ZW5hYmxlKHN0cnVj
dCBpaW9fZGV2ICppbmRpb19kZXYpDQo+PiArew0KPj4gKyAgICAgICBpZiAoYXQ5MV9hZGNfY3Vy
cmVudF9jaGFuX2lzX3RvdWNoKGluZGlvX2RldikpDQo+PiArICAgICAgICAgICAgICAgcmV0dXJu
IDA7DQo+PiArDQo+PiAgICAgICAgICByZXR1cm4gaWlvX3RyaWdnZXJlZF9idWZmZXJfcG9zdGVu
YWJsZShpbmRpb19kZXYpOw0KPj4gICB9DQo+Pg0KPj4gLXN0YXRpYyBpbnQgYXQ5MV9hZGNfYnVm
ZmVyX3ByZWRpc2FibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4+ICtzdGF0aWMgaW50
IGF0OTFfYWRjX2J1ZmZlcl9wb3N0ZGlzYWJsZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0K
Pj4gICB7DQo+PiAgICAgICAgICBzdHJ1Y3QgYXQ5MV9hZGNfc3RhdGUgKnN0ID0gaWlvX3ByaXYo
aW5kaW9fZGV2KTsNCj4+IC0gICAgICAgaW50IHJldDsNCj4+ICAgICAgICAgIHU4IGJpdDsNCj4+
DQo+PiAgICAgICAgICAvKiBjaGVjayBpZiB3ZSBhcmUgZGlzYWJsaW5nIHRyaWdnZXJlZCBidWZm
ZXIgb3IgdGhlIHRvdWNoc2NyZWVuICovDQo+PiBAQCAtOTE5LDEzICs5MjYsOCBAQCBzdGF0aWMg
aW50IGF0OTFfYWRjX2J1ZmZlcl9wcmVkaXNhYmxlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYp
DQo+PiAgICAgICAgICBpZiAoIShpbmRpb19kZXYtPmN1cnJlbnRtb2RlICYgSU5ESU9fQUxMX1RS
SUdHRVJFRF9NT0RFUykpDQo+PiAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4N
Cj4+IC0gICAgICAgLyogY29udGludWUgd2l0aCB0aGUgdHJpZ2dlcmVkIGJ1ZmZlciAqLw0KPj4g
LSAgICAgICByZXQgPSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlvX2Rldik7
DQo+PiAtICAgICAgIGlmIChyZXQgPCAwKQ0KPj4gLSAgICAgICAgICAgICAgIGRldl9lcnIoJmlu
ZGlvX2Rldi0+ZGV2LCAiYnVmZmVyIHByZWRpc2FibGUgZmFpbGVkXG4iKTsNCj4+IC0NCj4+ICAg
ICAgICAgIGlmICghc3QtPmRtYV9zdC5kbWFfY2hhbikNCj4+IC0gICAgICAgICAgICAgICByZXR1
cm4gcmV0Ow0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOw0KPj4NCj4+ICAgICAgICAgIC8q
IGlmIHdlIGFyZSB1c2luZyBETUEgd2UgbXVzdCBjbGVhciByZWdpc3RlcnMgYW5kIGVuZCBETUEg
Ki8NCj4+ICAgICAgICAgIGRtYWVuZ2luZV90ZXJtaW5hdGVfc3luYyhzdC0+ZG1hX3N0LmRtYV9j
aGFuKTsNCj4+IEBAIC05NTIsMTAgKzk1NCwyMCBAQCBzdGF0aWMgaW50IGF0OTFfYWRjX2J1ZmZl
cl9wcmVkaXNhYmxlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+Pg0KPj4gICAgICAgICAg
LyogcmVhZCBvdmVyZmxvdyByZWdpc3RlciB0byBjbGVhciBwb3NzaWJsZSBvdmVyZmxvdyBzdGF0
dXMgKi8NCj4+ICAgICAgICAgIGF0OTFfYWRjX3JlYWRsKHN0LCBBVDkxX1NBTUE1RDJfT1ZFUik7
DQo+PiAtICAgICAgIHJldHVybiByZXQ7DQo+PiArICAgICAgIHJldHVybiAwOw0KPj4gK30NCj4+
ICsNCj4+ICtzdGF0aWMgaW50IGF0OTFfYWRjX2J1ZmZlcl9wcmVkaXNhYmxlKHN0cnVjdCBpaW9f
ZGV2ICppbmRpb19kZXYpDQo+PiArew0KPj4gKyAgICAgICBpZiAoYXQ5MV9hZGNfY3VycmVudF9j
aGFuX2lzX3RvdWNoKGluZGlvX2RldikpDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+
PiArDQo+PiArICAgICAgIHJldHVybiBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGlu
ZGlvX2Rldik7DQo+PiAgIH0NCj4+DQo+PiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2J1ZmZl
cl9zZXR1cF9vcHMgYXQ5MV9idWZmZXJfc2V0dXBfb3BzID0gew0KPj4gKyAgICAgICAucHJlZW5h
YmxlID0gJmF0OTFfYWRjX2J1ZmZlcl9wcmVlbmFibGUsDQo+PiArICAgICAgIC5wb3N0ZGlzYWJs
ZSA9ICZhdDkxX2FkY19idWZmZXJfcG9zdGRpc2FibGUsDQo+PiAgICAgICAgICAucG9zdGVuYWJs
ZSA9ICZhdDkxX2FkY19idWZmZXJfcG9zdGVuYWJsZSwNCj4+ICAgICAgICAgIC5wcmVkaXNhYmxl
ID0gJmF0OTFfYWRjX2J1ZmZlcl9wcmVkaXNhYmxlLA0KPj4gICB9Ow0KPj4gLS0NCj4+IDIuMjAu
MQ0KPj4NCg0K
