Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75E6E18F81E
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 16:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgCWPE3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 11:04:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:44493 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726955AbgCWPE2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Mar 2020 11:04:28 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-230-B2u6v4l1P-67PVtv6VFiCw-1; Mon, 23 Mar 2020 15:04:24 +0000
X-MC-Unique: B2u6v4l1P-67PVtv6VFiCw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 23 Mar 2020 15:04:23 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 23 Mar 2020 15:04:23 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andy.shevchenko@gmail.com>,
        Rohit Sarkar <rohitsarkar5398@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "dragos.bogdan@analog.com" <dragos.bogdan@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Stefan Popa" <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Peter Meerwald" <pmeerw@pmeerw.net>
Subject: RE: [PATCH] iio: gyro: adis16136: use scnprintf instead of snprintf
Thread-Topic: [PATCH] iio: gyro: adis16136: use scnprintf instead of snprintf
Thread-Index: AQHWADSGKND5IUy8BE2X+HWi1cqZDKhWRidA
Date:   Mon, 23 Mar 2020 15:04:23 +0000
Message-ID: <81821e142e3c48febb7ab357dd200992@AcuMS.aculab.com>
References: <5e723666.1c69fb81.3545b.79c3@mx.google.com>
 <20200322002542.GA2826015@smile.fi.intel.com>
 <5e77017a.1c69fb81.dc341.8ab9@mx.google.com>
 <CAHp75VddtJs1ZCk1XAZ2WJLhWQDcVwiiN5gDpK9oYPEOS=c_ZQ@mail.gmail.com>
In-Reply-To: <CAHp75VddtJs1ZCk1XAZ2WJLhWQDcVwiiN5gDpK9oYPEOS=c_ZQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

RnJvbTogQW5keSBTaGV2Y2hlbmtvDQo+IFNlbnQ6IDIyIE1hcmNoIDIwMjAgMTA6MjcNCj4gT24g
U3VuLCBNYXIgMjIsIDIwMjAgYXQgODoxMSBBTSBSb2hpdCBTYXJrYXIgPHJvaGl0c2Fya2FyNTM5
OEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gU3VuLCBNYXIgMjIsIDIwMjAgYXQgMDI6
MjU6NDJBTSArMDIwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBNYXIg
MTgsIDIwMjAgYXQgMDg6MjU6MjJQTSArMDUzMCwgUm9oaXQgU2Fya2FyIHdyb3RlOg0KPiA+ID4g
PiBzY25wcmludGYgcmV0dXJucyB0aGUgYWN0dWFsIG51bWJlciBvZiBieXRlcyB3cml0dGVuIGlu
dG8gdGhlIGJ1ZmZlciBhcw0KPiA+ID4gPiBvcHBvc2VkIHRvIHNucHJpbnRmIHdoaWNoIHJldHVy
bnMgdGhlIG51bWJlciBvZiBieXRlcyB0aGF0IHdvdWxkIGhhdmUNCj4gPiA+ID4gYmVlbiB3cml0
dGVuIGlmIHRoZSBidWZmZXIgd2FzIGJpZyBlbm91Z2guIFVzaW5nIHRoZSBvdXRwdXQgb2Ygc25w
cmludGYNCj4gPiA+ID4gbWF5IGxlYWQgdG8gZGlmZmljdWx0IHRvIGRldGVjdCBidWdzLg0KPiA+
ID4NCj4gPiA+IE5pY2UuIEhhdmUgeW91IGludmVzdGlnYXRlIHRoZSBjb2RlPw0KPiA+ID4NCj4g
PiA+ID4gQEAgLTk2LDcgKzk2LDcgQEAgc3RhdGljIHNzaXplX3QgYWRpczE2MTM2X3Nob3dfc2Vy
aWFsKHN0cnVjdCBmaWxlICpmaWxlLA0KPiA+ID4gPiAgICAgaWYgKHJldCkNCj4gPiA+ID4gICAg
ICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiA+ID4NCj4gPiA+ID4gLSAgIGxlbiA9IHNucHJpbnRm
KGJ1Ziwgc2l6ZW9mKGJ1ZiksICIlLjR4JS40eCUuNHgtJS40eFxuIiwgbG90MSwgbG90MiwNCj4g
PiA+ID4gKyAgIGxlbiA9IHNjbnByaW50ZihidWYsIHNpemVvZihidWYpLCAiJS40eCUuNHglLjR4
LSUuNHhcbiIsIGxvdDEsIGxvdDIsDQo+ID4gPiA+ICAgICAgICAgICAgIGxvdDMsIHNlcmlhbCk7
DQo+ID4gPiA+DQo+ID4gPiA+ICAgICByZXR1cm4gc2ltcGxlX3JlYWRfZnJvbV9idWZmZXIodXNl
cmJ1ZiwgY291bnQsIHBwb3MsIGJ1ZiwgbGVuKTsNCj4gPiA+DQo+ID4gPiBUaGUgYnVmZmVyIHNp
emUgaXMgMjAsIHRoZSBwYXR0ZXJuIHNpemUgSSBjb3VudCB0byAxOS4gRG8geW91IHRoaW5rIHNu
cHJpbnRmKCkNCj4gPiA+IGNhbiBmYWlsPw0KPiA+IFRoYXQgbWlnaHQgYmUgdGhlIGNhc2UsIGJ1
dCBJTU8gdXNpbmcgc2NucHJpbnRmIGNhbiBiZSBjb25zaWRlcmVkIGFzIGENCj4gPiBiZXN0IHBy
YWN0aWNlLiBUaGVyZSBpcyBubyBvdmVyaGVhZCB3aXRoIHRoaXMgY2hhbmdlIGFuZCBmdXJ0aGVy
IGlmIHRoZQ0KPiA+IHBhdHRlcm4gaXMgY2hhbmdlZCBieSBzb21lb25lIGluIHRoZSBmdXR1cmUg
dGhleSBtaWdodCBvdmVybG9vayB0aGUNCj4gPiBidWZmZXJzaXplDQo+IA0KPiBJZiB3ZSBjdXQg
dGhlIHN0cmluZyBhYm92ZSB3ZSB3aWxsIGdpdmUgd3JvbmcgaW5mb3JtYXRpb24gdG8gdGhlIHVz
ZXIgc3BhY2UuDQo+IEkgdGhpbmsgc2NucHJpbnRmKCkgY2hhbmdlIGlzIGEgbm9pc2UgYW5kIGRv
ZXMgbm90IGltcHJvdmUgdGhlIHNpdHVhdGlvbiBhbnlob3cuDQoNCklmLCBmb3IgYW55IHJlYXNv
biwgYW55IG9mIHRoZSB2YWx1ZXMgYXJlIGxhcmdlIHRoZSB1c2VyIHdpbGwgZ2V0DQpjb3JydXB0
IGRhdGEuDQpCdXQgeW91IGRvbid0IHdhbnQgdG8gbGVhayByYW5kb20ga2VybmVsIG1lbW9yeSB0
byB0aGUgdXNlci4NCg0KU28gd2hpbGUgeW91IG1heSBiZSBhYmxlIHRvIHByb3ZlIHRoYXQgdGhp
cyBwYXJ0aWN1bGFyIHNucHJpbnRmKCkNCmNhbid0IG92ZXJmbG93LCBpbiBnZW5lcmFsIGNoZWNr
aW5nIGl0IHJlcXVpcmVzIGtub3dsZWRnZSBvZiB0aGUgY29kZS4NCg0KV2l0aCBzY25wcmludGYo
KSB5b3Uga25vdyBub3RoaW5nIG9kZCB3aWxsIGhhcHBlbi4NCg0KRldJVyBJIHN1c3BlY3QgdGhl
ICdzdGFuZGFyZCcgcmV0dXJuIHZhbHVlIGZyb20gc25wcmludGYoKSBjb21lcw0KZnJvbSB0aGUg
cmV0dXJuIHZhbHVlIG9mIHRoZSBvcmlnaW5hbCB1c2VyLXNwYWNlIGltcGxlbWVudGF0aW9ucw0K
d2hpY2ggZmFrZWQtdXAgYSBGSUxFIHN0cnVjdHVyZSBvbiBzdGFjayBhbmQganVzdCBzaWxlbnRs
eSBkaXNjYXJkZWQNCnRoZSBvdXRwdXQgYnl0ZXMgdGhhdCB3b3VsZG4ndCBmaXQgaW4gdGhlIGJ1
ZmZlciAodGhleSdkIHVzdWFsbHkNCmJ5IGZsdXNoZWQgdG8gYSByZWFsIGZpbGUpLg0KVGhlIG9y
aWdpbmFsIHNwcmludGYoKSBqdXN0IHNwZWNpZmllZCBhIHZlcnkgYmlnIGxlbmd0aCBzbyB0aGUN
CmZsdXNoIHdvdWxkIG5ldmVyIGJlIHJlcXVlc3RlZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVy
ZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5
bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

