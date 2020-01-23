Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475D8146BF6
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jan 2020 15:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgAWOzi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jan 2020 09:55:38 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:21065 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727307AbgAWOzi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jan 2020 09:55:38 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-91-RsylZuVmMgWTGjNZgnMSUg-1; Thu, 23 Jan 2020 14:55:34 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 23 Jan 2020 14:55:33 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 23 Jan 2020 14:55:33 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Ardelean, Alexandru'" <alexandru.Ardelean@analog.com>,
        "zzzzPopa, zzzzStefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: ad5755: fix spelling mistake "to" -> "too"
Thread-Topic: [PATCH] iio: ad5755: fix spelling mistake "to" -> "too"
Thread-Index: AQHV0X/sP6h7qhLTzEuBaVo2SdpnK6f31A8AgACC+qA=
Date:   Thu, 23 Jan 2020 14:55:33 +0000
Message-ID: <69bbc2af79d9463681b54d0aa240f89b@AcuMS.aculab.com>
References: <20200122235839.2830850-1-colin.king@canonical.com>
 <c32a44272aa593c3d0cda71a50b08f33338a2dc0.camel@analog.com>
In-Reply-To: <c32a44272aa593c3d0cda71a50b08f33338a2dc0.camel@analog.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: RsylZuVmMgWTGjNZgnMSUg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

RnJvbSBBcmRlbGVhbiwgQWxleGFuZHJ1DQo+IFNlbnQ6IDIzIEphbnVhcnkgMjAyMCAwNzowMw0K
PiANCj4gT24gV2VkLCAyMDIwLTAxLTIyIGF0IDIzOjU4ICswMDAwLCBDb2xpbiBLaW5nIHdyb3Rl
Og0KPiA+IFtFeHRlcm5hbF0NCj4gPg0KPiA+IEZyb206IENvbGluIElhbiBLaW5nIDxjb2xpbi5r
aW5nQGNhbm9uaWNhbC5jb20+DQo+ID4NCj4gPiBUaGVyZSBpcyBhIHNwZWxsaW5nIG1pc3Rha2Ug
aW4gYSBkZXZfZXJyIG1lc3NhZ2UuIEZpeCBpdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENv
bGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvaWlvL2RhYy9hZDU3NTUuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
aW8vZGFjL2FkNTc1NS5jIGIvZHJpdmVycy9paW8vZGFjL2FkNTc1NS5jDQo+ID4gaW5kZXggYjkx
NzVmYjRjOGFiLi5kYWQwYjI2MjI4YTIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vZGFj
L2FkNTc1NS5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vZGFjL2FkNTc1NS5jDQo+ID4gQEAgLTY1
NSw3ICs2NTUsNyBAQCBzdGF0aWMgc3RydWN0IGFkNTc1NV9wbGF0Zm9ybV9kYXRhICphZDU3NTVf
cGFyc2VfZHQoc3RydWN0DQo+ID4gZGV2aWNlICpkZXYpDQo+ID4gIAlmb3JfZWFjaF9jaGlsZF9v
Zl9ub2RlKG5wLCBwcCkgew0KPiA+ICAJCWlmIChkZXZuciA+PSBBRDU3NTVfTlVNX0NIQU5ORUxT
KSB7DQo+ID4gIAkJCWRldl9lcnIoZGV2LA0KPiA+IC0JCQkJIlRoZXJlIGlzIHRvIG1hbnkgY2hh
bm5lbHMgZGVmaW5lZCBpbiBEVFxuIik7DQo+ID4gKwkJCQkiVGhlcmUgaXMgdG9vIG1hbnkgY2hh
bm5lbHMgZGVmaW5lZCBpbiBEVFxuIik7DQo+IA0KPiBJZiBnb2luZyBmb3IgdGhlIHNwZWxsaW5n
IHN0dWZmLCBtYXliZSBhbHNvIGNoYW5nZSAiaXMiIHRvICJhcmUiOg0KPiAnVGhlcmUgYXJlIHRv
byBtYW55IGNoYW5uZWxzIGRlZmluZWQgaW4gRFRcbicNCg0KUHJvYmFibHkgYmV0dGVyIHN0aWxs
OiAiVGhlIERUIGRlZmluZXMgdG9vIG1hbnkgY2hhbm5lbHNcbiINCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

