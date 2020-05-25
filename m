Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74D11E07FD
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 09:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389054AbgEYH2A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 03:28:00 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:29432 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388948AbgEYH2A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 03:28:00 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04P7PP3P031195;
        Mon, 25 May 2020 03:27:45 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0b-00128a01.pphosted.com with ESMTP id 316wkavtky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 May 2020 03:27:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9GlLq6q07omAuIZ+l7HwAUlKXDnMaAHkr+/vRuq+q62yw++cJgsJaTkytcHjrNWDUpp/4yrEbDt60rws1TltAGwWlaeGN2TAnW3/sx/uaVmNG061ADuNRoAzFAy0XKWPf7oRoEXz9DJdM996xMnHtKqJaKEDG8+camHYdUNgQrjuMPjro97+c6OsdWjoDnnekmN3rIVctMe6kflS9foM7yBnT95KfBdF0nO+mKJo8Pc+/gANHIkrSFgvIc7i/Jviz4h6KLk8yC83EUO4yldnDWDIrwP2yTUlaql5C/JE5tKyfHRuJpK/kALTvyJOYKKqP+0S9kHOBJkPriH4SCHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7qu1/tYMJMjq13skwVLDSA98TngZkd8+9P3ewGX4CE=;
 b=fdTjWzWqZzObfHi4dHTcchNbkHJWKBBhm3A8E7xR8jL2aMWe8/VKgXJyoZs9cxAwBSZjNrSo3SKZvi2jy+yrKKpST3H+5CAyNmlo7ZHG0kXwMRANN9AtAiYpgYwyDXtjouYyjXtq02s2W7x1UwssErm2Xdm0CKA5fmC11R1Ybklxceh6x8ZKjBdVT+9Ir+6aMIix8PRu5k/idaCagwXMYtSbmDx9OKZQ9km5T1z29Ll7HGjQH/ifam7C21AtZwsfzAJMJ4N+O2uZWka7KbdDsByetCVvtybh0rvh1Ob0icoQYb34DgdVKi2mqIcfXomX5mI10nDAtEs6UGSkMCJdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7qu1/tYMJMjq13skwVLDSA98TngZkd8+9P3ewGX4CE=;
 b=tfsmpFeQMFd/u1isx2JulNKb1hy3E4skMsYHikinY5GFfGgpJ0Pd3VRCTs7Xeqw59AaQYC8qqjU0acznpzvM2zViO0/Lo9MIYBdayQcN/ziQsvWoqpJ4QeFnu5xBjBd12odMyGS3i7HlmKaOtqdUiTdAqr8mjj/MJBTgEIhjOnY=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4715.namprd03.prod.outlook.com (2603:10b6:5:181::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Mon, 25 May
 2020 07:27:43 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 07:27:43 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [RFC PATCH 08/14] iio: core: use new common ioctl() mechanism
Thread-Topic: [RFC PATCH 08/14] iio: core: use new common ioctl() mechanism
Thread-Index: AQHWJUAk1Ph98y+dnki8gGdjFYk3iKi3i5AAgAD17wA=
Date:   Mon, 25 May 2020 07:27:43 +0000
Message-ID: <5a5336379f0458b9f2804350711fdbb537cb3fed.camel@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
         <20200508135348.15229-9-alexandru.ardelean@analog.com>
         <20200524174738.04c191e1@archlinux>
In-Reply-To: <20200524174738.04c191e1@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 121ac376-9e61-42b5-f3be-08d8007d1d41
x-ms-traffictypediagnostic: DM6PR03MB4715:
x-microsoft-antispam-prvs: <DM6PR03MB471543181FB8E019A06CA808F9B30@DM6PR03MB4715.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SFfu5mLLIRmbhoxL7fTX+EnOP+WYDi8VdI3HuhCRNqKs8R1Fv+Lx+ouWA9VNvW8a6RSh8eC4sZ4Sqeu0Ihcy5Jc5DEW34x4wls5ydhKqG4wg6AZQcXIiEv/r6M5C6j4j9mXa9IHnG+AK5/0OqkP8qNpHNX4zBSc0WY6YiNNIUVVVzfAoPmdEWiAy9aGkL8gEfIntqGatDGRFv5BQVeKTs+Dv/YqKVeumdHfQeD1JfJWpMsvt5375e5Kd9ZAd0WGVoLsY6jthq+BXsyXcAB649FRET7CdyMKyShCba4rrli3etXXjRstiFLm02k/nt/vX6gQizZIy2kzR6Xla/iieAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(346002)(39860400002)(376002)(2906002)(76116006)(91956017)(66556008)(64756008)(316002)(8936002)(8676002)(66476007)(6916009)(66446008)(66946007)(4326008)(186003)(26005)(2616005)(71200400001)(36756003)(86362001)(54906003)(5660300002)(478600001)(6512007)(6486002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Ra9QyTWnk/Tk3asbyxoWSURaSkC3Z4qpUA2mhplKVhZwcxO7CK2dmfKXkz9limc9yP9XfZ5M15h2sNAXrRlZbu+0VSdJ2ONT5B0D8HxCVlGDR5VZ5CsHL2rEyHJZ8rLy9kYViJ209xBBmJU+WcKOmFmQE2Kn1m+mZFNEAKYn2raR4Ih7k+wyQD5yUSTAGM39ns2Z9gGYgieJ6brHx+op24nPbSCfwpLz3st5wpfx/rZVfxGGkSlZzraDFxeK3rBN7nKkUHJhh3pCCfPOXJeQ87gy5qgk1GTSiqZl6ldJVe9ddkChoMK0HqbKnsiqIn7IJLvAZ0ynDzqFxLVkfPxRa5mrwijCy57NRoOoCPdv70+hfzZkkrxJ93fbXJD4o2LhdN753jSTiHilts57RS0MwK6R6gPmxwTzDLmcm6v0c6IPUddgr9cFqB4HQekZfwcKaCFlBWLz9wr979vUDaGOKfb2Z+iBuLTPHWS484o/CwI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7CA8B7111C084419C49F39E6362AC0F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121ac376-9e61-42b5-f3be-08d8007d1d41
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 07:27:43.2859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aTrc16Wx7nCpmjGQ7y6a/IGVj0AiyZJ+BN+y8drATwHibzdCupRbN+OC6u12pIHfJabbAZLWFZ6Nb3Wanr/mTYh9JwN3y6q1jNqu3NIYTbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4715
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-25_02:2020-05-22,2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 cotscore=-2147483648 adultscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005250059
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA1LTI0IGF0IDE3OjQ3ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBGcmksIDggTWF5IDIwMjAgMTY6NTM6NDIgKzAzMDAN
Cj4gQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gd3Jv
dGU6DQo+IA0KPiA+IFRoaXMgY2hhbmdlIG1ha2VzIHVzZSBvZiB0aGUgbmV3IGNlbnRyYWxpemVk
IGlvY3RsKCkgbWVjaGFuaXNtLiBUaGUgZXZlbnQNCj4gPiBpbnRlcmZhY2UgcmVnaXN0ZXJzIGl0
J3MgaW9jdGwoKSBoYW5kbGVyIHRvIElJTyBkZXZpY2UuDQo+ID4gQm90aCB0aGUgYnVmZmVyICYg
ZXZlbnQgaW50ZXJmYWNlIGNhbGwgJ2lpb19kZXZpY2VfaW9jdGwoKScsIHdoaWNoIHNob3VsZA0K
PiA+IHRha2UgY2FyZSBvZiBhbGwgb2YgaW5kaW9fZGV2J3MgaW9jdGwoKSBjYWxscy4NCj4gPiAN
Cj4gPiBMYXRlciwgd2UgbWF5IGFkZCBwZXItYnVmZmVyIGlvY3RsKCkgY2FsbHMsIGFuZCBzaW5j
ZSBlYWNoIGJ1ZmZlciB3aWxsIGdldA0KPiA+IGl0J3Mgb3duIGNoYXJkZXYsIHRoZSBidWZmZXIg
aW9jdGwoKSBoYW5kbGVyIHdpbGwgbmVlZCBhIGJpdCBvZiB0d2Vha2luZw0KPiA+IGZvciB0aGUg
Zmlyc3QvbGVnYWN5IGJ1ZmZlciAoaS5lLiBpbmRpb19kZXYtPmJ1ZmZlcikuDQo+IA0KPiBEbyB3
ZSBoYXZlIGFuIGlvY3RscyB0aGF0IGFyZW4ndCBzYWZlIGlmIHdlIGp1c3QgdXNlIHRoZW0gb24g
J2FueScNCj4gYnVmZmVyPyAgSSBkb24ndCB0aGluayB3ZSBkbyB5ZXQsIHRob3VnaCBJIGd1ZXNz
IHdlIG1heSBoYXZlIGluIHRoZSBmdXR1cmUuDQo+IA0KDQpUaGlzIHdhcyBkb25lIGluIHRoZSBp
ZGVhIHRoYXQgd2UgbWF5IHdhbnQgdG8ga2VlcCB0aGUgL2Rldi9paW86ZGV2aWNlWCBmb3INCmJh
Y2t3YXJkcyBjb21wYXRpYmlsaXR5Lg0KQnV0LCBpdCdzIHVuZGV0ZXJtaW5lZCB5ZXQgaG93IHRo
aXMgd2lsbCBsb29rLg0KSSBhbSBjdXJyZW50bHkgd29ya2luZyBvbiBtb3JlIHJld29yayBzdHVm
ZiBbYXMgeW91J3ZlIHNlZW5dLg0KSSdkIHRyeSB0byBkbyBzb21lIG9mIHRoZSByZXdvcmsgbm93
LCBiZWZvcmUgYWRkaW5nIG1vcmUgc3R1ZmYgW2xpa2UNCmlpb19kZXZfb3BhcXVlXS4NClRvIGF2
b2lkIGFkZGluZyB0aGlzIHdvcmssIHRoZW4gaGF2aW5nIHRvIHJld29yayBpdC4NCg0KPiANCj4g
PiBBbHNvLCB0aG9zZSBwZXItYnVmZmVyIGlvY3RsKCkgY2FsbHMgd2lsbCBub3QgYmUgcmVnaXN0
ZXJlZCB3aXRoIHRoaXMNCj4gPiBtZWNoYW5pc20uDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
QWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9paW8vaWlvX2NvcmUuaCAgICAgICAgICAgIHwgIDMgLS0tDQo+ID4g
IGRyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1idWZmZXIuYyB8ICAyICstDQo+ID4gIGRyaXZlcnMv
aWlvL2luZHVzdHJpYWxpby1ldmVudC5jICB8IDE0ICsrKysrKysrLS0tLS0tDQo+ID4gIDMgZmls
ZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaWlvX2NvcmUuaCBiL2RyaXZlcnMvaWlvL2lpb19jb3Jl
LmgNCj4gPiBpbmRleCAzNGMzZTE5MjI5ZDguLmY2OGRlNGFmMjczOCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2lpby9paW9fY29yZS5oDQo+ID4gKysrIGIvZHJpdmVycy9paW8vaWlvX2NvcmUu
aA0KPiA+IEBAIC01NCw5ICs1NCw2IEBAIHNzaXplX3QgaWlvX2Zvcm1hdF92YWx1ZShjaGFyICpi
dWYsIHVuc2lnbmVkIGludCB0eXBlLCBpbnQNCj4gPiBzaXplLCBpbnQgKnZhbHMpOw0KPiA+ICAj
aWZkZWYgQ09ORklHX0lJT19CVUZGRVINCj4gPiAgc3RydWN0IHBvbGxfdGFibGVfc3RydWN0Ow0K
PiA+ICANCj4gPiAtbG9uZyBpaW9fZGV2aWNlX2V2ZW50X2lvY3RsKHN0cnVjdCBpaW9fZGV2ICpp
bmRpb19kZXYsIHN0cnVjdCBmaWxlICpmaWxwLA0KPiA+IC0JCQkgICAgdW5zaWduZWQgaW50IGNt
ZCwgdW5zaWduZWQgbG9uZyBhcmcpOw0KPiA+IC0NCj4gPiAgdm9pZCBpaW9fZGV2aWNlX2J1ZmZl
cl9hdHRhY2hfY2hyZGV2KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpOw0KPiA+ICANCj4gPiAg
aW50IGlpb19idWZmZXJfYWxsb2Nfc3lzZnNfYW5kX21hc2soc3RydWN0IGlpb19kZXYgKmluZGlv
X2Rldik7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1idWZmZXIu
YyBiL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby0NCj4gPiBidWZmZXIuYw0KPiA+IGluZGV4IDE0
MDA2ODhmNWU0Mi4uZTdhODQ3ZTdiMTAzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2lu
ZHVzdHJpYWxpby1idWZmZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1i
dWZmZXIuYw0KPiA+IEBAIC0xMTk5LDcgKzExOTksNyBAQCBzdGF0aWMgbG9uZyBpaW9fYnVmZmVy
X2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlcCwNCj4gPiB1bnNpZ25lZCBpbnQgY21kLA0KPiA+ICAJ
aWYgKCFidWZmZXIgfHwgIWJ1ZmZlci0+YWNjZXNzKQ0KPiA+ICAJCXJldHVybiAtRU5PREVWOw0K
PiA+ICANCj4gPiAtCXJldHVybiBpaW9fZGV2aWNlX2V2ZW50X2lvY3RsKGJ1ZmZlci0+aW5kaW9f
ZGV2LCBmaWxlcCwgY21kLCBhcmcpOw0KPiA+ICsJcmV0dXJuIGlpb19kZXZpY2VfaW9jdGwoYnVm
ZmVyLT5pbmRpb19kZXYsIGZpbGVwLCBjbWQsIGFyZyk7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0
YXRpYyBzc2l6ZV90IGlpb19idWZmZXJfc3RvcmVfZW5hYmxlKHN0cnVjdCBkZXZpY2UgKmRldiwN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWV2ZW50LmMgYi9kcml2
ZXJzL2lpby9pbmR1c3RyaWFsaW8tDQo+ID4gZXZlbnQuYw0KPiA+IGluZGV4IDA2NzRiMjExN2M5
OC4uMTk2MWMxZDE5MzcwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxp
by1ldmVudC5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWV2ZW50LmMNCj4g
PiBAQCAtMzIsNiArMzIsNyBAQA0KPiA+ICAgKiBAcmVhZF9sb2NrOgkJbG9jayB0byBwcm90ZWN0
IGtmaWZvIHJlYWQgb3BlcmF0aW9ucw0KPiA+ICAgKiBAY2hyZGV2OgkJYXNzb2NpYXRlZCBjaGFy
ZGV2IGZvciB0aGlzIGV2ZW50DQo+ID4gICAqIEBpbmRpb19kZXY6CQlJSU8gZGV2aWNlIHRvIHdo
aWNoIHRoaXMgZXZlbnQgaW50ZXJmYWNlIGJlbG9uZ3MNCj4gPiB0bw0KPiA+ICsgKiBAaW9jdGxf
aGFuZGxlcjoJaGFuZGxlciBmb3IgZXZlbnQgaW9jdGwoKSBjYWxscw0KPiA+ICAgKi8NCj4gPiAg
c3RydWN0IGlpb19ldmVudF9pbnRlcmZhY2Ugew0KPiA+ICAJd2FpdF9xdWV1ZV9oZWFkX3QJd2Fp
dDsNCj4gPiBAQCAtNDQsNiArNDUsNyBAQCBzdHJ1Y3QgaWlvX2V2ZW50X2ludGVyZmFjZSB7DQo+
ID4gIA0KPiA+ICAJc3RydWN0IGNkZXYJCWNocmRldjsNCj4gPiAgCXN0cnVjdCBpaW9fZGV2CQkq
aW5kaW9fZGV2Ow0KPiA+ICsJc3RydWN0IGlpb19pb2N0bF9oYW5kbGVyCWlvY3RsX2hhbmRsZXI7
DQo+ID4gIH07DQo+ID4gIA0KPiA+ICBib29sIGlpb19ldmVudF9lbmFibGVkKGNvbnN0IHN0cnVj
dCBpaW9fZXZlbnRfaW50ZXJmYWNlICpldl9pbnQpDQo+ID4gQEAgLTI2MSwxNSArMjYzLDEyIEBA
IHN0YXRpYyBpbnQgaWlvX2NocmRldl9yZWxlYXNlKHN0cnVjdCBpbm9kZSAqaW5vZGUsDQo+ID4g
c3RydWN0IGZpbGUgKmZpbHApDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICANCj4gPiAt
bG9uZyBpaW9fZGV2aWNlX2V2ZW50X2lvY3RsKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsIHN0
cnVjdCBmaWxlICpmaWxwLA0KPiA+ICtzdGF0aWMgbG9uZyBpaW9fZXZlbnRfaW9jdGwoc3RydWN0
IGlpb19kZXYgKmluZGlvX2Rldiwgc3RydWN0IGZpbGUgKmZpbHAsDQo+ID4gIAkJCSAgICB1bnNp
Z25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25nIGFyZykNCj4gPiAgew0KPiA+ICAJaW50IF9fdXNl
ciAqaXAgPSAoaW50IF9fdXNlciAqKWFyZzsNCj4gPiAgCWludCBmZDsNCj4gPiAgDQo+ID4gLQlp
ZiAoIWluZGlvX2Rldi0+aW5mbykNCj4gPiAtCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiAtDQo+ID4g
IAlpZiAoY21kID09IElJT19HRVRfRVZFTlRfRkRfSU9DVEwpIHsNCj4gPiAgCQlmZCA9IGlpb19l
dmVudF9nZXRmZChpbmRpb19kZXYpOw0KPiA+ICAJCWlmIChmZCA8IDApDQo+ID4gQEAgLTI3OCw3
ICsyNzcsNyBAQCBsb25nIGlpb19kZXZpY2VfZXZlbnRfaW9jdGwoc3RydWN0IGlpb19kZXYgKmlu
ZGlvX2RldiwNCj4gPiBzdHJ1Y3QgZmlsZSAqZmlscCwNCj4gPiAgCQkJcmV0dXJuIC1FRkFVTFQ7
DQo+ID4gIAkJcmV0dXJuIDA7DQo+ID4gIAl9DQo+ID4gLQlyZXR1cm4gLUVJTlZBTDsNCj4gPiAr
CXJldHVybiBJSU9fSU9DVExfVU5IQU5ETEVEOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICBzdGF0aWMg
bG9uZyBpaW9fZXZlbnRfaW9jdGxfd3JhcHBlcihzdHJ1Y3QgZmlsZSAqZmlscCwgdW5zaWduZWQg
aW50IGNtZCwNCj4gPiBAQCAtMjg2LDcgKzI4NSw3IEBAIHN0YXRpYyBsb25nIGlpb19ldmVudF9p
b2N0bF93cmFwcGVyKHN0cnVjdCBmaWxlICpmaWxwLA0KPiA+IHVuc2lnbmVkIGludCBjbWQsDQo+
ID4gIHsNCj4gPiAgCXN0cnVjdCBpaW9fZXZlbnRfaW50ZXJmYWNlICpldiA9IGZpbHAtPnByaXZh
dGVfZGF0YTsNCj4gPiAgDQo+ID4gLQlyZXR1cm4gaWlvX2RldmljZV9ldmVudF9pb2N0bChldi0+
aW5kaW9fZGV2LCBmaWxwLCBjbWQsIGFyZyk7DQo+ID4gKwlyZXR1cm4gaWlvX2RldmljZV9pb2N0
bChldi0+aW5kaW9fZGV2LCBmaWxwLCBjbWQsIGFyZyk7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIGlpb19ldmVudF9maWxlb3BzID0gew0K
PiA+IEBAIC0zMDgsNyArMzA3LDEwIEBAIHZvaWQgaWlvX2RldmljZV9ldmVudF9hdHRhY2hfY2hy
ZGV2KHN0cnVjdCBpaW9fZGV2DQo+ID4gKmluZGlvX2RldikNCj4gPiAgCWNkZXZfaW5pdCgmZXYt
PmNocmRldiwgJmlpb19ldmVudF9maWxlb3BzKTsNCj4gPiAgDQo+ID4gIAlldi0+aW5kaW9fZGV2
ID0gaW5kaW9fZGV2Ow0KPiA+ICsJZXYtPmlvY3RsX2hhbmRsZXIuaW9jdGwgPSBpaW9fZXZlbnRf
aW9jdGw7DQo+ID4gIAlpbmRpb19kZXYtPmNocmRldiA9ICZldi0+Y2hyZGV2Ow0KPiA+ICsNCj4g
PiArCWlpb19kZXZpY2VfaW9jdGxfaGFuZGxlcl9yZWdpc3RlcihpbmRpb19kZXYsICZldi0+aW9j
dGxfaGFuZGxlcik7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0YXRpYyBjb25zdCBjaGFyICogY29u
c3QgaWlvX2V2X3R5cGVfdGV4dFtdID0gew0K
