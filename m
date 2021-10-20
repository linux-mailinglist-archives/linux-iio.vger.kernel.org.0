Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F8B434388
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 04:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhJTCe1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 22:34:27 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:35068 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTCe0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 22:34:26 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 19K2VSRx8000319, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 19K2VSRx8000319
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 20 Oct 2021 10:31:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 20 Oct 2021 10:31:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 20 Oct 2021 10:31:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Wed, 20 Oct 2021 10:31:27 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Pkshih <pkshih@realtek.com>, nic_swsd <nic_swsd@realtek.com>,
        =?utf-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
        Kailang <kailang@realtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "info@ayaneo.com" <info@ayaneo.com>
Subject: RE: BMI160 accelerometer on AyaNeo tablet
Thread-Topic: BMI160 accelerometer on AyaNeo tablet
Thread-Index: AQHXxNAUgmd8rDSWIkW9G49XjG5V2KvbKGbw
Date:   Wed, 20 Oct 2021 02:31:27 +0000
Message-ID: <cd43fddcf9b74f6eaa4dd5a8cdd71bf2@realtek.com>
References: <CACAwPwb7edLzX-KO1XVNWuQ3w=U0BfA=_kwiGCjZOpKfZpc2pw@mail.gmail.com>
 <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com>
 <CAHp75VcEZ19zUU-Ps=kAYJDX1bkxmOqmHii36HE2ujC3gROkNQ@mail.gmail.com>
 <CACAwPwaj_ekK6j9S4CRu6tRTPyjffgDhL3UFnhoYSyJSkAkmpw@mail.gmail.com>
 <YW3ErLKGtmyhSFd3@smile.fi.intel.com>
 <CACAwPwYrxxFstQgYHhPOhMwUz_5RprSuoPNHL7m9ft1i-N2icQ@mail.gmail.com>
 <CAHp75VdCF_Fhso-uS_4JL7a9X90_nQ5JcyCwpeLM3b-YKVqjYw@mail.gmail.com>
In-Reply-To: <CAHp75VdCF_Fhso-uS_4JL7a9X90_nQ5JcyCwpeLM3b-YKVqjYw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.177.203]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEwLzE5IOS4i+WNiCAxMDo1MjowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/20/2021 02:21:59
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166840 [Oct 19 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: hayeswang@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 463 463 5854868460de3f0d8e8c0a4df98aeb05fb764a09
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;www.realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/20/2021 02:24:00
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

QW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBPY3RvYmVyIDE5LCAyMDIxIDU6NTkgUE0NClsuLi5dDQo+ID4gPiBSZWFsdGVrIHByb2Jh
Ymx5IHNob3VsZCBtYWtlIHRoaXMgSUQgbWFya2VkIHNvbWVob3cgYnJva2VuIGFuZCBub3QgdXNl
DQo+ID4gPiBpbiB0aGVpciBwcm9kdWN0cyBpbiBjYXNlIHRoZSBhbnN3ZXIgdG8gdGhlIGZpcnN0
IG9mIHRoZSBhYm92ZSBxdWVzdGlvbg0KPiA+ID4gaXMgInllcyIuIChPZiBjb3Vyc2UgaW4gY2Fz
ZSB0aGUgSUQgd2lsbCBiZSB1c2VkIGZvciBzb2xlbHkgUENJIGVudW1lcmF0ZWQNCj4gPiA+IHBy
b2R1Y3QgdGhlcmUgd2lsbCBiZSBubyBjb25mbGljdCwgSSBqdXN0IHByb3Bvc2UgdG8gYmUgb24g
dGhlIHNhZmVzdCBzaWRlLA0KPiA+ID4gYnV0IHJlbWFyayBzaG91bGQgYmUgbWFkZSBzb21ld2hl
cmUpLg0KPiANCj4gQW55IGNvbW1lbnRzIGZyb20gUmVhbHRlaywgcGxlYXNlPw0KDQpFeGN1c2Ug
bWUuIEkgZG9uJ3Qga25vdyB0aGlzIGRldmljZSwgc28gSSBkb24ndCBrbm93IHdobyBJIGNvdWxk
IGZvcndhcmQuDQpNYXliZSB5b3UgY291bGQgdHJ5IG91ciBjb250cmFjdCB3aW5kb3cgZnJvbSBv
dXIgd2ViIHNpdGUuDQpodHRwczovL3d3dy5yZWFsdGVrLmNvbS9lbi9jdS0xLWVuL2N1LTEtdGFp
d2FuLWVuDQoNCkJlc3QgUmVnYXJkcywNCkhheWVzDQoNCg==
