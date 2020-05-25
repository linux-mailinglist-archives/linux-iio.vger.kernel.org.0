Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD011E0773
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 09:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388945AbgEYHD0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 03:03:26 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:30030 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388385AbgEYHD0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 03:03:26 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04P6kNx1004885;
        Mon, 25 May 2020 03:03:22 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2058.outbound.protection.outlook.com [104.47.38.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 3170f7vfqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 May 2020 03:03:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZrp21bLjJsKvbJICdJhHhawL87cO6TJgvW31uGWM9iJNqV+C29A4BzGHNzdZEc7NTioeldVm+H3HBNsWzBE5neGHLKWEkhC0Me5GrNt3Wp2ybqsx+EkcSHEidwq+AivTq6RYy6tYCusKu2QUhO/gfQg6N5ZX/FhwLz7ExgF9OFTC88btlauqsmrT4IwwjSh9pTRzuEVCPMbCIg1KwsnhhSelcfvT2SIMAgSHAjWnVpQ8AkXoZaWwFd/JZ7+H8viyxQWB3bXnsMV9RQIuRIZhc7dbhkAueQlVsTiCHnwjfakY3bhTjdBNEq+AtBO+m4nmRgeXGqsFCPWHKDUrqj1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lv4HQJpVuV62Bx5q6bXhawwZ/HTH9xH1ZVkqS+Y/ZE0=;
 b=JSdIYEV2IdbdTTffymLkLVjwU8MAq1rvP5A+LoFaMPHMI8PYkpFo1qkdt+IREEiDxSdO9uUmsuY5Ea4wRLZp5+jA1QfYqnAWygN3a+/KfqhlpVIL9dKUBZanXtpPHn1R/IKHK6h0jHytuN4OYmR5NXlXzkomm2xECLPpJDhEccxM0yGPf+p/ShiCxMmGPBbuOvVLWXHst6Z/61ik02+tWycJM1F+FDLX6ad0ShdA3SF7Tp0wBxZ1ys4lkvjoFkDhGxbeoKYXWaXUa0QwdZwU3bSqoKV1rgpzsie9rgFTGqaNErglM2NafllrAzyDl2ZWFIKsg5KAseJofycMh+0a5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lv4HQJpVuV62Bx5q6bXhawwZ/HTH9xH1ZVkqS+Y/ZE0=;
 b=EDuyzar9b6m++WFMatdT/DaMMPHetPSajc4ns0mL02k4FypieORycDx++7TG//J8vQdk/HCy1u6aBRcnK/gDmww343CFyDGSi7G7KqDSPDYPFLA6eANVhrc3psFlZtbBaO5VMLwVkeJgqj1zgQZRvfb9dafW9Amu9VEH+lQMlLo=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4825.namprd03.prod.outlook.com (2603:10b6:5:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 07:03:21 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 07:03:21 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: humidity: hts221: remove usage of iio_priv_to_dev()
Thread-Topic: [PATCH] iio: humidity: hts221: remove usage of iio_priv_to_dev()
Thread-Index: AQHWMAYdG9+q4gzWvkqfFaNeVADcTKi3UiOAgAETAIA=
Date:   Mon, 25 May 2020 07:03:20 +0000
Message-ID: <6ac8d9bbe81b0cd9777dc722024e870e951fd1bd.camel@analog.com>
References: <20200522065616.10901-1-alexandru.ardelean@analog.com>
         <20200524153913.3f3dfc00@archlinux>
In-Reply-To: <20200524153913.3f3dfc00@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed5709df-99e5-4d66-bc5a-08d80079b597
x-ms-traffictypediagnostic: DM6PR03MB4825:
x-microsoft-antispam-prvs: <DM6PR03MB48254363E89A25A46AACC962F9B30@DM6PR03MB4825.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1YAW9hc5eXif6wcCK0B38MBycv/PGikoK1jYaIbJzKHVYIpKQDiq28YpdiIQYFtAOOlHzPIKh/+C26Y1UEpHBWEddkSFkOV/QdM5MDv2xK1sE/qOXsjXpB6Bd5aAOiF1mlPs4i2f8RSNJya/s7D80Z5E3ZEdWesWufcS0vL8GJIVh0e/7bkBIlrw/Y/p0354kMRxIjWzNZ7yULKEWcE1+dWbmS0QQRmqThDxIM6jE72TW9mKhKeIuSDV6ltrleJj47pSc6WM8KlhR1zwrpmlb5iLQ4Ff8Qfjgigvyo3OpcBeNN5t2gh15Ewi1gWDBTkq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(39860400002)(376002)(136003)(366004)(6486002)(316002)(54906003)(26005)(6916009)(6512007)(478600001)(71200400001)(6506007)(8676002)(76116006)(8936002)(86362001)(186003)(64756008)(5660300002)(66556008)(66946007)(36756003)(91956017)(2906002)(4326008)(2616005)(66446008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: psXDVa4iCWfPgSVZpWLI53HZ7v1wWQ02gPdOCHfAYcuG1tRYctZK5Ksyuw6bY//VKg4ryGbykxImHQZaxKH9ELekk8YPtdb+ruc44hWSXcZSZIznJP84tjPpGE5EnvPZF1z33pWRhV/dfHtR43yM8UEb2h3p+s+fM5HToShWqBdOdkDVjc0VuNqnMEdHDl4TsB2C5In7crI+Gx3PWUoVVNbqLu5TMQt/0Gu8g8M3kCa6O/3UvxJo3k/D9Rk8jHFI+cJbgcgHLE0isE0ZQz9wVSZSFnu4YIbuEOTG234ArtJdYSTaS7po3K53txFS9FF3B/i6uxx2wmx7N0h46mgd3lQ6h+B5JbZBcgPemoKffh5rGVe5QKO2ewWRQOmKcBn3OdzO6UVXyeussvs4VkV0P6QZ0r0LT7DIcSXmXgDw9dJjGE29NF/L1wSizZqPNRMcZGIAXsSUEXcoBtYbiTb8q3OwzlAIXUBXl4Xg9+oykBU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E53B1696592F8443AC399F9D45CE4BA9@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5709df-99e5-4d66-bc5a-08d80079b597
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 07:03:20.7879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DC9inPmu/3MNjMRgThF9GYcN6J3NkFHig+v7gH341aaTmNbBnViA2BRrLzPcMMSHHst9h9kqkI7MxH5OgqSCmEPx/BBhDY/iTsd72G8iIAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4825
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-25_02:2020-05-22,2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005250055
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA1LTI0IGF0IDE1OjM5ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBGcmksIDIyIE1heSAyMDIwIDA5OjU2OjE2ICswMzAw
DQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiBXZSBtYXkgd2FudCB0byBnZXQgcmlkIG9mIHRoZSBpaW9fcHJpdl90b19k
ZXYoKSBoZWxwZXIuIFRoYXQncyBhIGJpdA0KPiA+IHVuY2VydGFpbiBhdCB0aGlzIHBvaW50LiBU
aGUgcmVhc29uIGlzIHRoYXQgd2Ugd2lsbCBoaWRlIHNvbWUgb2YgdGhlDQo+ID4gbWVtYmVycyBv
ZiB0aGUgaWlvX2RldiBzdHJ1Y3R1cmUgKHRvIHByZXZlbnQgZHJpdmVycyBmcm9tIGFjY2Vzc2lu
ZyB0aGVtDQo+ID4gZGlyZWN0bHkpLCBhbmQgdGhhdCB3aWxsIGFsc28gbWVhbiBoaWRpbmcgdGhl
IGltcGxlbWVudGF0aW9uIG9mIHRoZQ0KPiA+IGlpb19wcml2X3RvX2RldigpIGhlbHBlciBpbnNp
ZGUgdGhlIElJTyBjb3JlLg0KPiA+IA0KPiA+IEhpZGluZyB0aGUgaW1wbGVtZW50YXRpb24gb2Yg
aWlvX3ByaXZfdG9fZGV2KCkgaW1wbGllcyB0aGF0IHNvbWUgZmFzdC1wYXRocw0KPiA+IG1heSBu
b3QgYmUgZmFzdCBhbnltb3JlLCBzbyBhIGdlbmVyYWwgaWRlYSBpcyB0byB0cnkgdG8gZ2V0IHJp
ZCBvZiB0aGUNCj4gPiBpaW9fcHJpdl90b19kZXYoKSBhbHRvZ2V0aGVyLg0KPiA+IA0KPiA+IEZv
ciB0aGlzIGRyaXZlciwgcmVtb3ZpbmcgdGhlIGlpb19wcml2X3RvX2RldigpIGhlbHBlciBtZWFu
cyBwYXNzaW5nIHRoZQ0KPiA+IGlpb19kZXYgb2JqZWN0IG9uIGh0czIyMV9hbGxvY2F0ZV9idWZm
ZXJzKCkgJiBodHMyMjFfYWxsb2NhdGVfdHJpZ2dlcigpLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+
IA0KPiBUaGUgaHRzMjIxX2h3IHN0cnVjdHVyZSBpcyBpbiBpaW9fcHJpdigpIHNvIHBlcmhhcHMg
d2UgY291bGQNCj4gZHJvcCBwYXNzaW5nIHRoYXQgaW50byB0aGVzZSB0d28gY2FsbHMgYW5kIGdl
dCBpdCBmcm9tIGlpb19wcml2DQo+IHdpdGhpbiB0aGUgZnVuY3Rpb25zPw0KPiANCj4gSSB0aWRp
ZWQgdGhhdCB1cCB3aGlsc3QgYXBwbHlpbmcuICBTaG91dCBpZiB5b3UgZGlzYWdyZWUgYW5kIEkn
bGwNCj4gYmFjayBpdCBvdXQgOikNCg0KRmluZSBieSBtZS4NCkkgdXN1YWxseSBnbywgZm9yIHRo
ZSBsYXp5L25hcnJvdy12aWV3LXBhdGggc29tZXRpbWVzLCB3aGVuIGRvaW5nIHRoZXNlIGNoYW5n
ZXMuDQpXaGljaCBbaW4gdGhpcyBjYXNlXSB3YXMgdG8gZ2V0IHJpZCBvZiBpaW9fcHJpdl90b19k
ZXYoKQ0KDQo+IA0KPiBBcHBsaWVkIHRvIHRoZSB0aGUgdG9ncmVnIGJyYW5jaCBvZiBpaW8uZ2l0
IGFuZCBwdXNoZWQgb3V0IGFzDQo+IHRlc3RpbmcgZm9yIHRoZSBhdXRvYnVpbGRlcnMgdG8gcGxh
eSB3aXRoIGl0Lg0KPiANCj4gVGhhbmtzLA0KPiANCj4gSm9uYXRoYW4NCj4gDQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvaWlvL2h1bWlkaXR5L2h0czIyMS5oICAgICAgICB8IDQgKystLQ0KPiA+ICBk
cml2ZXJzL2lpby9odW1pZGl0eS9odHMyMjFfYnVmZmVyLmMgfCA3ICsrKy0tLS0NCj4gPiAgZHJp
dmVycy9paW8vaHVtaWRpdHkvaHRzMjIxX2NvcmUuYyAgIHwgNCArKy0tDQo+ID4gIDMgZmlsZXMg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lpby9odW1pZGl0eS9odHMyMjEuaCBiL2RyaXZlcnMvaWlvL2h1bWlk
aXR5L2h0czIyMS5oDQo+ID4gaW5kZXggN2Q2NzcxZjdjZjQ3Li41NjkxNDY5MTA4ODUgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vaHVtaWRpdHkvaHRzMjIxLmgNCj4gPiArKysgYi9kcml2
ZXJzL2lpby9odW1pZGl0eS9odHMyMjEuaA0KPiA+IEBAIC00Niw3ICs0Niw3IEBAIGV4dGVybiBj
b25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBodHMyMjFfcG1fb3BzOw0KPiA+ICBpbnQgaHRzMjIxX3By
b2JlKHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IGlycSwgY29uc3QgY2hhciAqbmFtZSwNCj4gPiAg
CQkgc3RydWN0IHJlZ21hcCAqcmVnbWFwKTsNCj4gPiAgaW50IGh0czIyMV9zZXRfZW5hYmxlKHN0
cnVjdCBodHMyMjFfaHcgKmh3LCBib29sIGVuYWJsZSk7DQo+ID4gLWludCBodHMyMjFfYWxsb2Nh
dGVfYnVmZmVycyhzdHJ1Y3QgaHRzMjIxX2h3ICpodyk7DQo+ID4gLWludCBodHMyMjFfYWxsb2Nh
dGVfdHJpZ2dlcihzdHJ1Y3QgaHRzMjIxX2h3ICpodyk7DQo+ID4gK2ludCBodHMyMjFfYWxsb2Nh
dGVfYnVmZmVycyhzdHJ1Y3QgaHRzMjIxX2h3ICpodywgc3RydWN0IGlpb19kZXYgKmlpb19kZXYp
Ow0KPiA+ICtpbnQgaHRzMjIxX2FsbG9jYXRlX3RyaWdnZXIoc3RydWN0IGh0czIyMV9odyAqaHcs
IHN0cnVjdCBpaW9fZGV2ICppaW9fZGV2KTsNCj4gPiAgDQo+ID4gICNlbmRpZiAvKiBIVFMyMjFf
SCAqLw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9odW1pZGl0eS9odHMyMjFfYnVmZmVy
LmMNCj4gPiBiL2RyaXZlcnMvaWlvL2h1bWlkaXR5L2h0czIyMV9idWZmZXIuYw0KPiA+IGluZGV4
IDlmYjNmMzM2MTRkNC4uNDhkNDY5ZWViMGU2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlv
L2h1bWlkaXR5L2h0czIyMV9idWZmZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2h1bWlkaXR5
L2h0czIyMV9idWZmZXIuYw0KPiA+IEBAIC03MiwxMCArNzIsOSBAQCBzdGF0aWMgaXJxcmV0dXJu
X3QgaHRzMjIxX3RyaWdnZXJfaGFuZGxlcl90aHJlYWQoaW50IGlycSwNCj4gPiB2b2lkICpwcml2
YXRlKQ0KPiA+ICAJcmV0dXJuIElSUV9IQU5ETEVEOw0KPiA+ICB9DQo+ID4gIA0KPiA+IC1pbnQg
aHRzMjIxX2FsbG9jYXRlX3RyaWdnZXIoc3RydWN0IGh0czIyMV9odyAqaHcpDQo+ID4gK2ludCBo
dHMyMjFfYWxsb2NhdGVfdHJpZ2dlcihzdHJ1Y3QgaHRzMjIxX2h3ICpodywgc3RydWN0IGlpb19k
ZXYgKmlpb19kZXYpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBzdF9zZW5zb3JzX3BsYXRmb3JtX2Rh
dGEgKnBkYXRhID0gZGV2X2dldF9wbGF0ZGF0YShody0+ZGV2KTsNCj4gPiAtCXN0cnVjdCBpaW9f
ZGV2ICppaW9fZGV2ID0gaWlvX3ByaXZfdG9fZGV2KGh3KTsNCj4gPiAgCWJvb2wgaXJxX2FjdGl2
ZV9sb3cgPSBmYWxzZSwgb3Blbl9kcmFpbiA9IGZhbHNlOw0KPiA+ICAJdW5zaWduZWQgbG9uZyBp
cnFfdHlwZTsNCj4gPiAgCWludCBlcnI7DQo+ID4gQEAgLTE5MCw5ICsxODksOSBAQCBzdGF0aWMg
aXJxcmV0dXJuX3QgaHRzMjIxX2J1ZmZlcl9oYW5kbGVyX3RocmVhZChpbnQgaXJxLA0KPiA+IHZv
aWQgKnApDQo+ID4gIAlyZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ID4gIH0NCj4gPiAgDQo+ID4gLWlu
dCBodHMyMjFfYWxsb2NhdGVfYnVmZmVycyhzdHJ1Y3QgaHRzMjIxX2h3ICpodykNCj4gPiAraW50
IGh0czIyMV9hbGxvY2F0ZV9idWZmZXJzKHN0cnVjdCBodHMyMjFfaHcgKmh3LCBzdHJ1Y3QgaWlv
X2RldiAqaWlvX2RldikNCj4gPiAgew0KPiA+IC0JcmV0dXJuIGRldm1faWlvX3RyaWdnZXJlZF9i
dWZmZXJfc2V0dXAoaHctPmRldiwgaWlvX3ByaXZfdG9fZGV2KGh3KSwNCj4gPiArCXJldHVybiBk
ZXZtX2lpb190cmlnZ2VyZWRfYnVmZmVyX3NldHVwKGh3LT5kZXYsIGlpb19kZXYsDQo+ID4gIAkJ
CQkJTlVMTCwgaHRzMjIxX2J1ZmZlcl9oYW5kbGVyX3RocmVhZCwNCj4gPiAgCQkJCQkmaHRzMjIx
X2J1ZmZlcl9vcHMpOw0KPiA+ICB9DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2h1bWlk
aXR5L2h0czIyMV9jb3JlLmMNCj4gPiBiL2RyaXZlcnMvaWlvL2h1bWlkaXR5L2h0czIyMV9jb3Jl
LmMNCj4gPiBpbmRleCA5MDAzNjcxZjE0ZmIuLjc3ZGZhNjVkZjg0MSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2lpby9odW1pZGl0eS9odHMyMjFfY29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy9p
aW8vaHVtaWRpdHkvaHRzMjIxX2NvcmUuYw0KPiA+IEBAIC02MjEsMTEgKzYyMSwxMSBAQCBpbnQg
aHRzMjIxX3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IGlycSwgY29uc3QNCj4gPiBjaGFy
ICpuYW1lLA0KPiA+ICAJfQ0KPiA+ICANCj4gPiAgCWlmIChody0+aXJxID4gMCkgew0KPiA+IC0J
CWVyciA9IGh0czIyMV9hbGxvY2F0ZV9idWZmZXJzKGh3KTsNCj4gPiArCQllcnIgPSBodHMyMjFf
YWxsb2NhdGVfYnVmZmVycyhodywgaWlvX2Rldik7DQo+ID4gIAkJaWYgKGVyciA8IDApDQo+ID4g
IAkJCXJldHVybiBlcnI7DQo+ID4gIA0KPiA+IC0JCWVyciA9IGh0czIyMV9hbGxvY2F0ZV90cmln
Z2VyKGh3KTsNCj4gPiArCQllcnIgPSBodHMyMjFfYWxsb2NhdGVfdHJpZ2dlcihodywgaWlvX2Rl
dik7DQo+ID4gIAkJaWYgKGVycikNCj4gPiAgCQkJcmV0dXJuIGVycjsNCj4gPiAgCX0NCg==
