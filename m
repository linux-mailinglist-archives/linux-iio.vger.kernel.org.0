Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 856911B11E
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2019 09:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfEMH0s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 May 2019 03:26:48 -0400
Received: from mail-eopbgr40119.outbound.protection.outlook.com ([40.107.4.119]:12670
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727568AbfEMH0s (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 May 2019 03:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+WWOsVPd9Dp6tLZvTsxCw7EKt6o0f+N1wA3iXlg2IA=;
 b=gJ91pD4/6OVnQszqG6V6i9mWuKWD9j4AyTYEStlTrByWHpnK8hszXEoU3QL2dhUsjHsPkOGDG/a7NOAcF2V9LgoJcrfh+QI3z+kkQLrIufTr67fNvUB2IWOSS9oxYcndAVnJMXS5Rt52szZG+VH4FvqQ7rg307m+sLbbT+jtXRw=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3917.eurprd05.prod.outlook.com (52.134.6.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 07:26:03 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::48ff:f344:98da:6571]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::48ff:f344:98da:6571%5]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 07:26:03 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>
Subject: Re: [PATCH 2/5] iio: stmpe-adc: Reinit completion struct on begin
 conversion
Thread-Topic: [PATCH 2/5] iio: stmpe-adc: Reinit completion struct on begin
 conversion
Thread-Index: AQHVBOJDb7gYXrDpa0WRGQ1Y/cnYSqZluTUAgAL3QgA=
Date:   Mon, 13 May 2019 07:26:03 +0000
Message-ID: <ae8a2305c5ab0d312e1334e895a5e7fdb45fbd16.camel@toradex.com>
References: <20190507143615.28477-1-dev@pschenker.ch>
         <20190507143615.28477-2-dev@pschenker.ch>
         <20190511110832.24f58e4a@archlinux>
In-Reply-To: <20190511110832.24f58e4a@archlinux>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 732513a0-321d-4ee3-eecb-08d6d774417c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR0502MB3917;
x-ms-traffictypediagnostic: VI1PR0502MB3917:
x-microsoft-antispam-prvs: <VI1PR0502MB39174A9B981E84D16F20C1B6F40F0@VI1PR0502MB3917.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(396003)(39840400004)(199004)(189003)(44832011)(11346002)(186003)(25786009)(53936002)(102836004)(66066001)(6506007)(305945005)(476003)(7416002)(54906003)(2616005)(6512007)(5640700003)(446003)(14454004)(3846002)(6116002)(486006)(14444005)(256004)(26005)(6246003)(8676002)(478600001)(316002)(4326008)(81156014)(81166006)(71190400001)(71200400001)(6916009)(8936002)(2906002)(7736002)(2351001)(118296001)(76176011)(76116006)(66556008)(73956011)(66946007)(66476007)(91956017)(68736007)(64756008)(66446008)(36756003)(6436002)(2501003)(5660300002)(99286004)(6486002)(229853002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3917;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 24T+fq6093mvx2S5Yn8gx40DBe9+R7nUnbKqVMNOwvAg+/FPWW4RnWNdNuyvBEKo5pkxLfhYJb3Rw5eeoKpMVC7qep785vBGJ0qKLQjUFMFBGn0venqvYN/8Ssl9gXyFmraoA0VVHHO7b/M3ZRiCJCthQNo5SrE4RuIIpSqmWzOU71rwsAou383a5TrJVKAsj2B4UI0Oqo75T0+nIpQXbhb0Z223V36ZFT4IzMWp0zqqxr8THeikmVLc7X/nRKCzCPYPrUCrZb5naDRKHmoVpSMn6OTcyIrGGbHPfuUgQx8SeLxy51LK+PmiWWnqRt6TFZ9NiZ9ZRPGdgVntLwtScSs0H7bbn4bZtoMV+f/wJHRtH055fSaZpCv8EqqYBvWR7OEg97bkLdYfK5HrHcYIoZ9CxpoXT1WZNKm8HsHhJU8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D521BDBCFF93BF4AA6C08DB679517BE2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732513a0-321d-4ee3-eecb-08d6d774417c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 07:26:03.3097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3917
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDE5LTA1LTExIGF0IDExOjA4ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUdWUsICA3IE1heSAyMDE5IDE2OjM2OjEyICswMjAwDQo+IFBoaWxpcHBlIFNjaGVu
a2VyIDxkZXZAcHNjaGVua2VyLmNoPiB3cm90ZToNCj4gDQo+ID4gRnJvbTogUGhpbGlwcGUgU2No
ZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KPiA+IA0KPiA+IEluIHNvbWUg
Y2FzZXMsIHRoZSB3YWl0X2NvbXBsZXRpb24gZ290IGludGVycnVwdGVkLiBUaGlzIGNhdXNlZCB0
aGUNCj4gPiBlcnJvci1oYW5kbGluZyB0byBtdXRleF91bmxvY2sgdGhlIGZ1bmN0aW9uLiBUaGUg
YmVmb3JlIHR1cm5lZCBvbg0KPiA+IGludGVycnVwdCB0aGVuIGdvdCBjYWxsZWQgYW55d2F5LiBJ
biB0aGUgSVNSIHRoZW4gY29tcGxldGlvbigpIHdhcw0KPiA+IGNhbGxlZCBjYXVzaW5nIHdyb25n
IGFkYy12YWx1ZXMgcmV0dXJuZWQgaW4gYSBmb2xsb3dpbmcgYWRjLXJlYWRvdXQuDQo+ID4gDQo+
ID4gUmVpbml0aWFsaXNlIGNvbXBsZXRpb24gc3RydWN0IHRvIG1ha2Ugc3VyZSB0aGUgY291bnRl
ciBpcyB6ZXJvDQo+ID4gd2hlbiBiZWdpbm5pbmcgYSBuZXcgYWRjLWNvbnZlcnNpb24uDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2Vy
QHRvcmFkZXguY29tPg0KPiBIaSBQaGlsaXBwZSwgDQo+IA0KPiBUbyBtZSB0aGlzIGxvb2tzIGxp
a2UgYSBmaXggdGhhdCB3ZSBzaG91bGQgY29uc2lkZXIgYXBwbHlpbmcgdG8gc3RhYmxlLg0KPiBI
b3dldmVyLCBhcyBpdCBpcyBpbiB0aGUgbWlkZGxlIG9mIHRoaXMgc2VyaWVzIEknbSBub3QgZ29p
bmcgdG8gdGFrZQ0KPiBpdCB2aWEgdGhlIGZhc3Qgcm91dGUgKGR1cmluZyByYydzKS4gSWYgcGVv
cGxlIHdhbnQgdG8gYmFja3BvcnQgaXQNCj4gdGhleSB3aWxsIGhhdmUgdG8gd2FpdCB1bnRpbCBh
ZnRlciB0aGUgbmV4dCBtZXJnZSB3aW5kb3cuDQo+IElmIGFueW9uZSBoYXMgYW4gdXJnZW50IG5l
ZWQsIHRoZW4gc2hvdXQgaW4gdGhlIG5leHQgd2VlayBhbmQgSSdsbA0KPiBwdWxsIHRoaXMgdmVy
c2lvbiBvdXQgYW5kIHdlIGNhbiByZXN0cnVjdHVyZSB0aGUgc2V0Lg0KPiANCj4gQXBwbGllZCB0
byB0aGUgdG9ncmVnIGJyYW5jaCBvZiBpaW8uZ2l0IGFuZCBwdXNoZWQgb3V0IGFzIHRlc3RpbmcN
Cj4gZm9yIHRoZSBhdXRvYnVpbGRlcnMgdG8gcGxheSB3aXRoIGl0Lg0KPiANCj4gVGhhbmtzLA0K
PiANCj4gSm9uYXRoYW4NCg0KSGkgSm9uYXRoYW4hIEkgZG9uJ3QgdGhpbmsgdGhhdCdzIG5lY2Vz
c2FyeS4gQXMgbG9uZyBhcyBpdCBnZXRzIGludG8gc3RhYmxlIGF0DQpzb21lIHBvaW50LiBPdXIg
Y3VzdG9tZXIgdXNlIGRvd25zdHJlYW0gYW55d2F5LiBXaGVyZSBJJ20gYWJvdXQgdG8gYXBwbHkg
aXQgbm93Lg0KDQpUaGFua3MsDQpQaGlsaXBwZQ0KPiANCj4gPiAtLS0NCj4gPiANCj4gPiAgZHJp
dmVycy9paW8vYWRjL3N0bXBlLWFkYy5jIHwgNCArKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL3N0
bXBlLWFkYy5jIGIvZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5jDQo+ID4gaW5kZXggOWVjMzM4
YmEzNDQwLi5iMzg3MmViMzcyOTMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vYWRjL3N0
bXBlLWFkYy5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL3N0bXBlLWFkYy5jDQo+ID4gQEAg
LTY1LDYgKzY1LDggQEAgc3RhdGljIGludCBzdG1wZV9yZWFkX3ZvbHRhZ2Uoc3RydWN0IHN0bXBl
X2FkYyAqaW5mbywNCj4gPiAgDQo+ID4gIAltdXRleF9sb2NrKCZpbmZvLT5sb2NrKTsNCj4gPiAg
DQo+ID4gKwlyZWluaXRfY29tcGxldGlvbigmaW5mby0+Y29tcGxldGlvbik7DQo+ID4gKw0KPiA+
ICAJaW5mby0+Y2hhbm5lbCA9ICh1OCljaGFuLT5jaGFubmVsOw0KPiA+ICANCj4gPiAgCWlmIChp
bmZvLT5jaGFubmVsID4gU1RNUEVfQURDX0xBU1RfTlIpIHsNCj4gPiBAQCAtMTA1LDYgKzEwNyw4
IEBAIHN0YXRpYyBpbnQgc3RtcGVfcmVhZF90ZW1wKHN0cnVjdCBzdG1wZV9hZGMgKmluZm8sDQo+
ID4gIA0KPiA+ICAJbXV0ZXhfbG9jaygmaW5mby0+bG9jayk7DQo+ID4gIA0KPiA+ICsJcmVpbml0
X2NvbXBsZXRpb24oJmluZm8tPmNvbXBsZXRpb24pOw0KPiA+ICsNCj4gPiAgCWluZm8tPmNoYW5u
ZWwgPSAodTgpY2hhbi0+Y2hhbm5lbDsNCj4gPiAgDQo+ID4gIAlpZiAoaW5mby0+Y2hhbm5lbCAh
PSBTVE1QRV9URU1QX0NIQU5ORUwpIHsNCg==
