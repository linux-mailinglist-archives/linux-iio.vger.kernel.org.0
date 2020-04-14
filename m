Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731211A72D3
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 07:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405397AbgDNFKr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 01:10:47 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:16136 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728938AbgDNFKq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 01:10:46 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03E5Agjx000422;
        Tue, 14 Apr 2020 01:10:42 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-00128a01.pphosted.com with ESMTP id 30bah6qh1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Apr 2020 01:10:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEnG6zUtVpD6TNVfwATomQ5u+f72y5/+IJuL3HNvBoOz+e6QUAOfniDuMyQZHKcEsAo/aUOQTsHKfIsT8i8yGpK6BpFT+9VFh31oYB9M91SYusoeyilY9wezHUH0gPgr97BfKvOcXaT+LbR/ddxq0k6QncEguqQEDE9NyOgak0rv/qQ2b54XXjCJbEMSGmVs4PWflxHilUt4DN+GfFuVYYefjkcK0K6ZUbB1bU8r3wvVHTPAybyPOFTdaAq6I8OSIhzLyzElHFmx3u7Cox4Q7nES3k0vtwTlpkZMjwmLeNLOBlAW69rtEKRcYtDuVqrbTDrTIEoDC0rXJd3q0sbrww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVMn/Rx4UT5Bac6xy8II6tRf7X60cUBzK0jwMsukIPE=;
 b=cBCZUYk0JpJbXjslloq7BNxtb/9UpgGOxVj2hZGQfRkd5FLdjK0GwWDNh02Y91aynJfpAwSOOYtSD8FCofcayzc7WaDgAHdo2/NpeQh95slt5UaeTcAX+dFnEvfr1ZgaRTz0v5aokqgBtVGd2BX3UUSIkcUi4qOyqMTkupN4id0UfJvleVzSfEc6+iu9L0OvzpHAL69zdwJNWt7Lj2YmxuPPqrMdZalwg/RqjyJ8GbkaKcEQ4RkHPMEd139/ta2Baa3D2xbMhmTouo/+74Wrpb0ZoLzdgGtqlhPkikLNZQXVBSts6xEb3mP7eFlzROKzoWn1Y8Uk2gv6/9zAsnv5Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVMn/Rx4UT5Bac6xy8II6tRf7X60cUBzK0jwMsukIPE=;
 b=A6XImQsomTU3o6VxFY2Gls/bJmYjE0/Q7hR/T+4Va681dYVBWOIH7PP8zjylwpDjOdobv7g95xMAUqXIO6YLrOT3UxlRUOijURfImYG8YXOzvqcHNY8CDOZ336X6PG45gPJHnxE90wpqJnysQ8FDZN5npTvPT9xYZQ5+ybu9VwI=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4283.namprd03.prod.outlook.com (2603:10b6:5:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Tue, 14 Apr
 2020 05:10:41 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2900.026; Tue, 14 Apr 2020
 05:10:41 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "Tachici, Alexandru" <Alexandru.Tachici@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: ad7192: move ad7192_of_match table
 closer to the end of the file
Thread-Topic: [PATCH v3 2/2] iio: adc: ad7192: move ad7192_of_match table
 closer to the end of the file
Thread-Index: AQHWEWxeDgTiqTif30Gco8mQ4Hz9oqh3Om2AgADZ5QA=
Date:   Tue, 14 Apr 2020 05:10:41 +0000
Message-ID: <c3129f78cce03ef5547ad445452a6f845ac45600.camel@analog.com>
References: <20200413082044.81101-1-alexandru.ardelean@analog.com>
         <20200413082044.81101-2-alexandru.ardelean@analog.com>
         <20200413171441.13794dd9@archlinux>
In-Reply-To: <20200413171441.13794dd9@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a1ffa2d-0f2c-4ecd-eb34-08d7e0322d9c
x-ms-traffictypediagnostic: DM6PR03MB4283:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB428369C6FFDE73D611C130E2F9DA0@DM6PR03MB4283.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(376002)(39860400002)(136003)(366004)(346002)(8676002)(81156014)(66446008)(64756008)(66556008)(66946007)(66476007)(6486002)(2906002)(76116006)(91956017)(86362001)(6916009)(186003)(8936002)(6512007)(5660300002)(2616005)(36756003)(26005)(478600001)(6506007)(54906003)(4326008)(71200400001)(316002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KnwGSi4L9kVeXSmChRT9eJzWfxGO/KhBAKOIrsPxJpX+ki3zqjOEfiE1gn9/O30FLkwMK3tBO3WQwcJ+l/PHkx262HEaD8PA1pGJ9tff54eaUorDPWOmVPYHi3T0OYVBTX64kLwGiU7ztjC+xeZK57/e7pFWGo+BQmhSkhC3ozgHSAXaCn63G90Nv6WtjHIo1vBMGsfwRuOz7g5kqrQ7PPiOVt0/AD+mcz54A9nX9leiLHJgzRRmjALBWRmGnCqhqua8H3Og7orsaFYWBn/BhY+JE4dTynj5OruHm6nwBe3hykcdQsQnrWdzCKOHac9NBl5yoOnV1JPOVwyxqLfJV2AMIsAgCSJ8zQUXk5i4IRGvm/0QrliSxLajrOj79q91EF8spf+dngrNi6l7BD5q4b9ckqueY5T4QAWtnT3OhAsQ/gCV4h6fFEErIgHXyql5
x-ms-exchange-antispam-messagedata: SFLS6f9qoGHJtzY7tHH64lDbN4rFJZYZIqk07pN+JF7UQQanxzSLPjnHYXQFgiNdkczgd87Xluy1ixw3WRvFVMQqiojYm4ZhSxEY1CbE45gOWAWXEEKZ+zZqOtQ1VsCFv3qYOdHs+L+PHrHlFXvChg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <0730CCA8A7F94D4F887A49C4EEFB4A63@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1ffa2d-0f2c-4ecd-eb34-08d7e0322d9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 05:10:41.3560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UB/kaYpbhJd+LQWldeXY+3BXhihb7Iy4IwXVQux6Te306g8jxjtgpsE7HXhtx6gY+u8W9ZkA72znb06NvjCZZGv1/o0s93iR5Zz+fduBwKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4283
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_01:2020-04-13,2020-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140042
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTEzIGF0IDE3OjE0ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBNb24sIDEzIEFwciAyMDIwIDExOjIwOjQ0ICswMzAwDQo+IEFsZXhhbmRydSBBcmRl
bGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBUaGUg
Y2hhbmdlIGlzIG1vcmUgY29zbWV0aWMuIFRoZXJlIGlzIG5vIG5lZWQgdG8gcmVmZXJlbmNlIHRo
aXMgdGFibGUgaW4NCj4gPiB0aGUgcHJvYmUgZnVuY3Rpb24gc2luY2UgJ29mX2RldmljZV9nZXRf
bWF0Y2hfZGF0YScgaXMgdXNlZCwgd2hpY2ggb2J0YWlucw0KPiA+IHRoaXMgaW5mb3JtYXRpb24g
ZnJvbSB0aGUgZHJpdmVyIG9iamVjdC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5k
cnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiBJJ20gb2J2aW91
c2x5IG5vdCBnb2luZyB0byB0YWtlIHRoaXMgb25lIGFzIGEgZml4LiAgSXQncyBhIHJlYXNvbmFi
bGUgcGF0Y2gNCj4gc28gZmVlbCBmcmVlIHRvIHJlbWluZCBtZSBvZiBpdCdzIGV4aXN0ZW5jZSBv
bmNlIHRoZSBmaXggaGFzIHdvcmtlZCBpdHMNCj4gd2F5IGFyb3VuZCB0byBiZSBpbiBteSB0b2dy
ZWcvdGVzdGluZyBicmFuY2guDQoNCkFjay4NCg0KVGhhbmtzDQpBbGV4DQoNCj4gDQo+IFRoYW5r
cywNCj4gDQo+IEpvbmF0aGFuDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lpby9hZGMvYWQ3
MTkyLmMgfCAxOCArKysrKysrKystLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9paW8vYWRjL2FkNzE5Mi5jIGIvZHJpdmVycy9paW8vYWRjL2FkNzE5Mi5jDQo+ID4gaW5kZXgg
N2U4NjYyYzVjYjBlLi5jZWY2MWY5NjJlNjAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8v
YWRjL2FkNzE5Mi5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL2FkNzE5Mi5jDQo+ID4gQEAg
LTkwOCwxNSArOTA4LDYgQEAgc3RhdGljIGludCBhZDcxOTJfY2hhbm5lbHNfY29uZmlnKHN0cnVj
dCBpaW9fZGV2DQo+ID4gKmluZGlvX2RldikNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4g
IA0KPiA+IC1zdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBhZDcxOTJfb2ZfbWF0Y2hb
XSA9IHsNCj4gPiAtCXsgLmNvbXBhdGlibGUgPSAiYWRpLGFkNzE5MCIsIC5kYXRhID0gJmFkNzE5
Ml9jaGlwX2luZm9fdGJsW0lEX0FENzE5MF0NCj4gPiB9LA0KPiA+IC0JeyAuY29tcGF0aWJsZSA9
ICJhZGksYWQ3MTkyIiwgLmRhdGEgPSAmYWQ3MTkyX2NoaXBfaW5mb190YmxbSURfQUQ3MTkyXQ0K
PiA+IH0sDQo+ID4gLQl7IC5jb21wYXRpYmxlID0gImFkaSxhZDcxOTMiLCAuZGF0YSA9ICZhZDcx
OTJfY2hpcF9pbmZvX3RibFtJRF9BRDcxOTNdDQo+ID4gfSwNCj4gPiAtCXsgLmNvbXBhdGlibGUg
PSAiYWRpLGFkNzE5NSIsIC5kYXRhID0gJmFkNzE5Ml9jaGlwX2luZm9fdGJsW0lEX0FENzE5NV0N
Cj4gPiB9LA0KPiA+IC0Je30NCj4gPiAtfTsNCj4gPiAtTU9EVUxFX0RFVklDRV9UQUJMRShvZiwg
YWQ3MTkyX29mX21hdGNoKTsNCj4gPiAtDQo+ID4gIHN0YXRpYyBpbnQgYWQ3MTkyX3Byb2JlKHN0
cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBhZDcxOTJfc3RhdGUg
KnN0Ow0KPiA+IEBAIC0xMDUwLDYgKzEwNDEsMTUgQEAgc3RhdGljIGludCBhZDcxOTJfcmVtb3Zl
KHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICAN
Cj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYWQ3MTkyX29mX21hdGNoW10g
PSB7DQo+ID4gKwl7IC5jb21wYXRpYmxlID0gImFkaSxhZDcxOTAiLCAuZGF0YSA9ICZhZDcxOTJf
Y2hpcF9pbmZvX3RibFtJRF9BRDcxOTBdDQo+ID4gfSwNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAi
YWRpLGFkNzE5MiIsIC5kYXRhID0gJmFkNzE5Ml9jaGlwX2luZm9fdGJsW0lEX0FENzE5Ml0NCj4g
PiB9LA0KPiA+ICsJeyAuY29tcGF0aWJsZSA9ICJhZGksYWQ3MTkzIiwgLmRhdGEgPSAmYWQ3MTky
X2NoaXBfaW5mb190YmxbSURfQUQ3MTkzXQ0KPiA+IH0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0g
ImFkaSxhZDcxOTUiLCAuZGF0YSA9ICZhZDcxOTJfY2hpcF9pbmZvX3RibFtJRF9BRDcxOTVdDQo+
ID4gfSwNCj4gPiArCXt9DQo+ID4gK307DQo+ID4gK01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGFk
NzE5Ml9vZl9tYXRjaCk7DQo+ID4gKw0KPiA+ICBzdGF0aWMgc3RydWN0IHNwaV9kcml2ZXIgYWQ3
MTkyX2RyaXZlciA9IHsNCj4gPiAgCS5kcml2ZXIgPSB7DQo+ID4gIAkJLm5hbWUJPSAiYWQ3MTky
IiwNCg==
