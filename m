Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B081B017F
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 08:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgDTGWN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 02:22:13 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:65200 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgDTGWN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 02:22:13 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K6JpRo004718;
        Mon, 20 Apr 2020 02:22:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fud751ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:22:11 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03K6MB0c006339;
        Mon, 20 Apr 2020 02:22:11 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2055.outbound.protection.outlook.com [104.47.38.55])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fud751yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:22:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjB4z1TULak/48exJVDO8e9AdTFOz0UlKP+SjKwN6Pd9d5vJWlIRNX4zenT82OACdQ2scaW5Ojo18FtPZvJDEQMHbFZtx/t9Uu+tx+5gL5Ghmju+pPcb1mwPDEIM10l82mmAtQZ5cTDP0S51XBS7rX+yafsKvr0kNbZu1m7aF8X6TItmMAN7CwLXMoo/3zYYPSwYLY1+Ka2NZ1wNHa8VwVmSggp34bIt9NQsfumQez2l8WTTZzcbM8LQrQEPSBPbgBx/eBvlJYAVA0pmya7AYaHpMCh6HcYkdB/eh6w31HSNl9F5NTdiar6OVmiOE/dylecyBlkMhgPzUa36gHLqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PAt3G/mvDcjbRvZYPPD/6DTyrIxrKre3KaWJJg2y2k=;
 b=H4E8SWT9Y7vRmAjCMax31VijNhhLXIY4L+PaHteg1UFE5+4oYMgub+syioYpMhM88WtFhzNnwgieVYeJ1l5/3rDMuPRUnXDuHLAZzKrHTqtKfAZvt/zBQBuSDVms0ODVoMmgUacPLXF5daYXne1zUZ3m7b0BJqCYTQzKZV3Mr6KHOHszpZT6PDhsg6uxP4rWx0c6hVEXwqXHQGNEvqXhOt663kcxXbj0yJT3LKduyb8Dnp7qMArqYc8Zww77/i5WuZH6XouZpl8r/WSZd9hE6MDiE1xcymvzR92AvvOXBX2R/7XddE0kGwIY/PWdobg/YcB0eUAp/86yIYm0HEQ/nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PAt3G/mvDcjbRvZYPPD/6DTyrIxrKre3KaWJJg2y2k=;
 b=jCcQVf/k+CZps1IrnH4he67DDb2UnkK4EYcpXQF7qQTlIDA5gX7UfmICfAyxXMBawIVYrgIlNkPWIiiEcyDqIUhYU2SzRe2bMshkZQrOXkKXPm8kWYKev25gEeZUHcx47WZY6/MMnxxNCWPVJN4EgSgsAnbLXF3kE9iPRGaELHE=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3674.namprd03.prod.outlook.com (2603:10b6:5:aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Mon, 20 Apr
 2020 06:22:10 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 06:22:09 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/7] iio: light: clean out of_match_ptr and tidy headers
Thread-Topic: [PATCH 0/7] iio: light: clean out of_match_ptr and tidy headers
Thread-Index: AQHWFlvUJkLrnMIP/Uqgyo/lT8NGiKiBh5cAgAAE2wA=
Date:   Mon, 20 Apr 2020 06:22:09 +0000
Message-ID: <03f6eb6e7cf61c6dfd8bcd9aeaaf6977cb095191.camel@analog.com>
References: <20200419150206.43033-1-jic23@kernel.org>
         <beff54a412caddaaa7facbc2df2ddf939668fc44.camel@analog.com>
In-Reply-To: <beff54a412caddaaa7facbc2df2ddf939668fc44.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 757c236a-dd3a-4fb1-bbba-08d7e4f3283f
x-ms-traffictypediagnostic: DM6PR03MB3674:
x-microsoft-antispam-prvs: <DM6PR03MB3674C0ECBE50A67BF558CCD2F9D40@DM6PR03MB3674.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(376002)(366004)(39850400004)(396003)(346002)(136003)(66556008)(66476007)(81156014)(66946007)(86362001)(6512007)(4326008)(2616005)(76116006)(91956017)(71200400001)(6486002)(64756008)(66446008)(8676002)(8936002)(6506007)(316002)(110136005)(5660300002)(2906002)(26005)(186003)(36756003)(478600001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: urYfAAKkTIeY5KuC9XH/xvZJX9lUSGgC15d5wsYeNSdVgEMbrGrgO+pDN7BXZrhTcP3dbpCbVym3xqrim4WC7M90sHOXwRM3/5OsLqSHwoq1KeFPDKNfIjbDTE5nwBkDfY0kwMWanxyhH3Q9uqATXqlQTqtwTKUyClQcV7RHXHQEtWFBksmtBSLHWnBpoiPB5aKnWUA+U2oeySxDX047kdX1p+Bij+nD7WXgR1+E5NrVVbEI4x0NKcSUZKXcx+DJnoYMSr/i8POeq2fIALrmEeE7+AUM7el1sXW3B4kjkoJNbSvmyagPMAh80hLM+RipAqOGWk7zxkhiet8/f2cKAHvYDX0W8O7mCHJ7X3+2ISPR7xs+fz6GnJmR3nV69yOhlFu8Y4+8pC+E+HRjZSZ+cALyfdinYTeO8FHefXhU7hucnYXH7eoIDYNYHpMkK5dp
x-ms-exchange-antispam-messagedata: 3YVMXttb44Ny7Q0tbhybcjFLE2pfwQYgdpFwSfpUCeqi5ZIb3IB9ACDUu5au6GLgTsRyjy9PlsuawvzZuRqJaXczkFj3jt3ZrvS1Z+GZfqBQf7rADWR9VBMFa/s0ZK7pxsVPXb+sVeCY/YhbOfw4jQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE34EB917E781D429EC13B554D129A0F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757c236a-dd3a-4fb1-bbba-08d7e4f3283f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 06:22:09.9346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UrKJ3iftJoWhYAro3jIyPynKeMmjJxgMUbsbct7v0bdhoWTgJfswR2Zg4hUKQYjF+L6JNsJwLkqKGushFn3rZ/x0gDkHfK9sK9u3GF/pDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3674
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_02:2020-04-17,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTIwIGF0IDA2OjA0ICswMDAwLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdy
b3RlOg0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBTdW4sIDIwMjAtMDQtMTkgYXQgMTY6MDEgKzAx
MDAsIGppYzIzQGtlcm5lbC5vcmcgd3JvdGU6DQo+ID4gRnJvbTogSm9uYXRoYW4gQ2FtZXJvbiA8
Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KPiA+IA0KPiA+IEhpIEFsbCwNCj4gPiANCj4g
PiBHaXZlbiB3ZSBrZWVwIGhhdmluZyB0byBleHBsYWluIHRvIHBlb3BsZSB0aGF0IG9mX21hdGNo
X3B0ciBpcyBsZXNzDQo+ID4gdGhhbiBpZGVhbCBub3cgd2UgaGF2ZSB0aGUgb3B0aW9uIG9mIEFD
UEkgRFNEVCB1c2luZyBQUlAwMDAxIGFuZA0KPiA+IHRoZSBjb21wYXRpYmxlLCBpdCBzZWVtcyBz
ZW5zaWJsZSB0byByZWR1Y2UgdGhlIG51bWJlciBvZiBpbnN0YW5jZXMNCj4gPiB0aGF0IHBlb3Bs
ZSBtaWdodCBjb3B5IGZvciBhIG5ldyBkcml2ZXIuDQo+ID4gDQo+ID4gQWRkZWQgdGhlb3JldGlj
YWwgYmVuZWZpdCBpcyB0aGF0IHdlIGNhbiBwcm9iZSBhbGwgdGhlc2UgZHJpdmVycyBmcm9tDQo+
ID4gYXBwcm9wcmlhdGUgRFNEVCAodGhvdWdoIEkgZG91YnQgYW55b25lIHdpbGwpLg0KPiA+IA0K
PiA+IEknbSBzZW5kaW5nIHRoaXMgZmlyc3Qgc2V0IG91dCB0byBzZWUgaWYgYW55b25lIGhhcyBz
dHJvbmcgdmlld3MgYWdhaW5zdA0KPiA+IGRvaW5nIHRoaXMgZm9yIGF0IGxlYXN0IHRoZSBzaW1w
bGUgZHJpdmVycyB0aGF0IGhhdmUgbm8gb3RoZXIgZGV2aWNlDQo+ID4gdHJlZSBkZXBlbmRlbmNl
LiAgT2J2aW91c2x5IG1vcmUgd29yayB3b3VsZCBiZSBuZWVkZWQgdG8gcmVtb3ZlDQo+ID4gdXNl
IG9mIG9mX21hdGNoX3B0ciBmcm9tIElJTyBjb21wbGV0ZWx5Lg0KPiA+IA0KPiA+IExpZ2h0IHNl
bnNvcnMgcGlja2VkIGFzIGEgc3RhcnRpbmcgcG9pbnQgYXMgdGhleSB0ZW5kIHRvIGJlIHNpbXBs
ZS4NCj4gPiANCj4gPiBJIG1heSBkbyBmb2xsb3cgdXBzIGluIGxhcmdlciBibG9ja3MgdG8gYXZv
aWQgc28gbWFueSBzbWFsbCBwYXRjaGVzDQo+ID4gKG9yIGluZGVlZCBmbGF0dGVuIHRoZXNlIGlu
dG8gb25lIHdoZW4gYXBwbHlpbmcpDQo+IA0KPiBmd2l3OiBpIHdhcyBhbHNvIHBsYW5uaW5nIHRv
IGRvIGEgc3dlZXAgb2YgdGhlc2U7DQo+IHdlbGwsIHRiaCwgdGhlIG1haW4gaW50ZW50IHdhcyB0
byB0YXJnZXQgQURJIGRyaXZlcnMgZmlyc3QgYW5kIGRvIGEgYmlnZ2VyDQo+IGNvbnZlcnNpb24g
Zm9yIHRoZW0gdG8gbWFrZSB0aGUgc2xpZ2h0bHkgZnJpZW5kbGllciB3aXRoIEFDUEk7IA0KPiAN
Cj4gYXNpZGUgZnJvbSB0aGlzLCBpJ20gYWxzbyBub3RpY2luZyBzb21lIGJhZCBwYXR0ZXJucyBi
ZWluZyBjb3BpZWQgZnJvbSBvbGRlcg0KPiBkcml2ZXJzLCB3aGVuIGFza2luZyBuZXcgcGVvcGxl
IHRvIHdyaXRlIExpbnV4IGRyaXZlcnM7DQo+IGkgZGlkIG5vdCBtYWtlIGEgbGlzdCwgcHJvYmFi
bHkgc2hvdWxkIGhhdmU7DQo+IG9uZSBpcyAnbWxvY2snIFtzdGlsbF0gYmVpbmcgY29waWVkOyBh
bmQgYWNjZXNzaW5nIG90aGVyIGludGVybmFsIGZpZWxkczsNCj4gYnV0IHRoZSBpbnRlcm5hbCBm
aWVsZHMgYWNjZXNzaW5nIHJlcXVpcmVzIGEgYml0IG9mIGEgY2xlYW51cCBpbiB0aGUgZm9ybSBv
Zg0KPiBwcml2YXRpemluZyB0aGUgZmllbGRzIHNvbWVob3c7DQo+IA0KDQpPbmUgdGhpbmcgSSBu
b3RpY2VkIGluIHRoZSBzZXJpZXMuDQpObyBpZGVhIGlmIGl0IGlzIG5lZWRlZCBvciBub3Q7IGEg
YnVpbGQgd291bGQgdGVsbDoNCiAgIElzICcjaW5jbHVkZSA8bGludXgvbW9kX2RldmljZXRhYmxl
Lmg+JyByZXF1aXJlZCBmb3IgdGhpcyBjaGFuZ2U/DQpNb3N0IHBhdGNoZXMgYWRkIGl0LCBidXQg
SSBkb24ndCBmZWVsIGl0IGlzIG5lZWRlZDsgSSBjb3VsZCBiZSB3cm9uZyB0aG91Z2guDQoNCldo
YXQgSSBub3RpY2VkIGlzIHRoYXQgYWxsICdsaW51eC9vZi5oJyAsICdsaW51eC9vZl9kZXZpY2Uu
aCcgJg0KJ2xpbnV4L29mX3BsYXRmb3JtLmgnIGluY2x1ZGUgaXQuDQoNCj4gDQo+ID4gVGhhbmtz
DQo+ID4gDQo+ID4gSm9uYXRoYW4NCj4gPiANCj4gPiBKb25hdGhhbiBDYW1lcm9uICg3KToNCj4g
PiAgIGlpbzogbGlnaHQ6IGJoMTc4MDogdXNlIG1vZF9kZXZpY2V0YWJsZS5oIGFuZCBkcm9wIG9m
X21hdGNoX3B0ciBtYWNybw0KPiA+ICAgaWlvOiBsaWdodDogY20zMjE4MTogQWRkIG1vZF9kZXZp
Y2V0YWJsZS5oIGFuZCByZW1vdmUgb2ZfbWF0Y2hfcHRyDQo+ID4gICBpaW86IGxpZ2h0OiBjbTMy
MzI6IEFkZCBtb2RfZGV2aWNldGFibGUuaCBpbmNsdWRlIGFuZCBkcm9wDQo+ID4gICAgIG9mX21h
dGNoX3B0cg0KPiA+ICAgaWlvOiBsaWdodDogZ3AyYXAwMjBhMDBmOiBTd2FwIG9mLmggZm9yIG1v
ZF9kZXZpY2V0YWJsZS5oICsgZHJvcA0KPiA+ICAgICBvZl9tYXRjaF9wdHINCj4gPiAgIGlpbzog
bGlnaHQ6IG9wdDMwMDE6IEFkZCBtb2RfZGV2aWNldGFibGUuaCBhbmQgZHJvcCB1c2Ugb2YNCj4g
PiAgICAgb2ZfbWF0Y2hfcHRyDQo+ID4gICBpaW86IGxpZ2h0OiBzdF91dmlzMjU6IEFkZCBtb2Rf
ZGV2aWNldGFibGUuaCBhbmQgZHJvcCBvZl9tYXRjaF9wdHINCj4gPiAgIGlpbzogbGlnaHQ6IHZs
NjE4MDogc3dhcCBvZi5oIGZvciBtb2RfZGV2aWNldGFibGUuaCBhbmQgZHJvcA0KPiA+ICAgICBv
Zl9tYXRjaF9wdHINCj4gPiANCj4gPiAgZHJpdmVycy9paW8vbGlnaHQvYmgxNzgwLmMgICAgICAg
IHwgNiArKy0tLS0NCj4gPiAgZHJpdmVycy9paW8vbGlnaHQvY20zMjE4MS5jICAgICAgIHwgMyAr
Ky0NCj4gPiAgZHJpdmVycy9paW8vbGlnaHQvY20zMjMyLmMgICAgICAgIHwgMyArKy0NCj4gPiAg
ZHJpdmVycy9paW8vbGlnaHQvZ3AyYXAwMjBhMDBmLmMgIHwgNiArKy0tLS0NCj4gPiAgZHJpdmVy
cy9paW8vbGlnaHQvb3B0MzAwMS5jICAgICAgIHwgMyArKy0NCj4gPiAgZHJpdmVycy9paW8vbGln
aHQvc3RfdXZpczI1X2kyYy5jIHwgMyArKy0NCj4gPiAgZHJpdmVycy9paW8vbGlnaHQvc3RfdXZp
czI1X3NwaS5jIHwgMyArKy0NCj4gPiAgZHJpdmVycy9paW8vbGlnaHQvdmw2MTgwLmMgICAgICAg
IHwgMiArLQ0KPiA+ICA4IGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDE0IGRlbGV0
aW9ucygtKQ0KPiA+IA0K
