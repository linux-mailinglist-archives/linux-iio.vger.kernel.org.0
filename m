Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C881AB94C
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 09:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437167AbgDPHEt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 03:04:49 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:31734 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438309AbgDPHEq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 03:04:46 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03G70eBw026007;
        Thu, 16 Apr 2020 03:04:32 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0b-00128a01.pphosted.com with ESMTP id 30dn7jmdvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 03:04:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7qSjwzm5KZTT4ijNpLt2vlQ9sey2r6jbABW0yGi5ZXaOqfYCvCNDrc03vZklklz7Y/nuOJlKDg36wu6bOuaJGhd+ALjRwenFBS8ndQGQqQDslJZ+CP7EDdrRb8l4m9jOeIm+KH45pHgbKLe07bK9cwSnMYD21VhuScvDtkiq6B55dAybRQYIZBa/FKHsDbj/YYyXEWgQNuAWBx2ehInU9YSA5u8gnY1e3ndwVL+KqdYxAkzrEdYVmaBOCOcWHr7IMwkNDlIIhiYwzLQu8DBbtxuGUcG0G3figIJOGc390OVECJAt3jK8XlbSEj18yCWMeP8EQdjI+mwZzGrPKp+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu5EfCF1vnc1RAvnMyFtTHyW0FsrkeuDJu5b3/loJM4=;
 b=Ih1ZQAARi1jXN+FoAZUC1of5jqEMJAdmDRyb2EPoNf7FjxwdG4o8aJxIb3qPpKVKgwM9MeUoGdF0JEO3UpEW2ksdx38ukkv4WI2Y/Y28cIM6eJPmO+VzcZm7pOkdRJxnlbcXbXdBf2dJFevt7ieYCauoGTRxL4Hfx/39ML0Vt/xPYtSMLyWQksK7vCnGSeUxEdzYf9Dq3FWwgDDTPcKxJYlOf80LXgzHQxff5uxKmjoepkiokAkaK92Hb74fkOkNl1BHTIXt6Dwr3V8cMnf+FqOC4ckXqY0oiphNrZJB6nk67voUYbSZqVc+KzSBheAvum6BDop1NADLZ6lMHJQsyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu5EfCF1vnc1RAvnMyFtTHyW0FsrkeuDJu5b3/loJM4=;
 b=LXVKImBSadeFdYbBmuQwXXATSnKgUJSpAagrEL1B+QYXeZ7dh3MqZtRCP/pMb+Y9Qi1lhezWU50T0GvQ4HdZ74fVawJVgPaBKC/Pbf0gSiXNlQD7TUzDZZDFZw84fS8YkvNnu37IJoA8plq7Y8zOJQbozmJAc3jBG4Ucf6JwVVw=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4442.namprd03.prod.outlook.com (2603:10b6:5:10a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Thu, 16 Apr
 2020 07:04:30 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 07:04:30 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: core: register chardev only if needed
Thread-Topic: [PATCH v2] iio: core: register chardev only if needed
Thread-Index: AQHWEjfBZCWPnaEudUWFdTBfvszEb6h46meAgAFMZwCAABCeAIABDq+A
Date:   Thu, 16 Apr 2020 07:04:30 +0000
Message-ID: <74cc4f24377a420953496281f9ac34648420ee36.camel@analog.com>
References: <20200414083656.7696-1-alexandru.ardelean@analog.com>
         <20200414190629.2d85759e@archlinux>
         <761fb0aef92e5e026df78b6679329dbbb55b6226.camel@analog.com>
         <5d3d6bad-934d-41c5-d167-dd69734e8015@metafoo.de>
In-Reply-To: <5d3d6bad-934d-41c5-d167-dd69734e8015@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e705194-a56b-483d-3718-08d7e1d46902
x-ms-traffictypediagnostic: DM6PR03MB4442:
x-microsoft-antispam-prvs: <DM6PR03MB4442C7FDE282D842EA3CCBCDF9D80@DM6PR03MB4442.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(366004)(76116006)(2906002)(53546011)(66556008)(110136005)(66446008)(186003)(66946007)(66476007)(64756008)(316002)(91956017)(6506007)(8676002)(26005)(4326008)(36756003)(86362001)(8936002)(478600001)(2616005)(81156014)(71200400001)(6486002)(6512007)(5660300002)(54906003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 15ipc7KMVPsLT2BVrq8bFl2ewt5o5F/HN4hY8jCmKLeAjsBYs7oylTPwef7aLnn/2KlBn3coPqv90oSbhgTuOFaQbZY3DFNMp8YK4NWXsNgjV2EjDs5ILAdh+lKsdKz7ZF7x+63ssKR4q4x8XkTUQuJxon5puA7LFkRx8GYvJ0wjUR48Ti77ynaZYSNjr4HG6og9fH4hXsEJNIy5dYNfk2F4gOJPoe2gj+wyIbU5Ba/y05qPE21vWbmlLK/6LWzJWm7SSxhhJKY5iCvrXPk7JFnMn0pOvKkE/TcC2/tUXNRiHnpBYnKXevBb4bBCvlrM+eIQF50UYp2+tO0qarG5k6ZFuKCbM85TTifvbaS4YNLTRbdXoKROEr1Ct50p/JzBkLtqZzth/+EjkrN1hSwqsrNbIO0FbhFA/iczEsn/PbpyoMiO+AlMACeV8xFzYCeF
x-ms-exchange-antispam-messagedata: ZdedjFAElXC3LQb3ns+MT7z/F97iS3A1xU5OhzKXIoH40IyrpWE13DMcXgPkQhjJNvt26Ahl402J61jPbOOJEww3kqYabMwN9qZ2cKNsABvb/07EiFAOzwq53aiAQSij5eT02mIHFR4pgApzYe7DNg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <64361FA6F3895D4786F23F4E6A81D60B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e705194-a56b-483d-3718-08d7e1d46902
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 07:04:30.6064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9xaeTHViC6BCkLuNuuIYcUr1WKorPxDCA/C/oBHmWeMpApx7pdKeZIes1Mt1oGc+pCJmayp+ydZ5nweXo86f7uNMWLybyGbxNQff7e7R+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4442
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_02:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160045
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTA0LTE1IGF0IDE2OjU1ICswMjAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIDQvMTUvMjAgMzo1NiBQTSwgQXJkZWxlYW4sIEFs
ZXhhbmRydSB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjAtMDQtMTQgYXQgMTk6MDYgKzAxMDAsIEpv
bmF0aGFuIENhbWVyb24gd3JvdGU6DQo+ID4gPiBbRXh0ZXJuYWxdDQo+ID4gPiANCj4gPiA+IE9u
IFR1ZSwgMTQgQXByIDIwMjAgMTE6MzY6NTYgKzAzMDANCj4gPiA+IEFsZXhhbmRydSBBcmRlbGVh
biA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+
IFRoZSBmaW5hbCBpbnRlbnQgaXMgdG8gbG9jYWxpemUgYWxsIGJ1ZmZlciBvcHMgaW50byB0aGUN
Cj4gPiA+ID4gaW5kdXN0cmlhbGlvLWJ1ZmZlci5jIGZpbGUsIHRvIGJlIGFibGUgdG8gYWRkIHN1
cHBvcnQgZm9yIG11bHRpcGxlDQo+ID4gPiA+IGJ1ZmZlcnMNCj4gPiA+ID4gcGVyIElJTyBkZXZp
Y2UuDQo+ID4gPiA+IA0KPiA+ID4gPiBXZSBvbmx5IG5lZWQgYSBjaGFyZGV2IGlmIHdlIG5lZWQg
dG8gc3VwcG9ydCBidWZmZXJzIGFuZC9vciBldmVudHMuDQo+ID4gPiA+IA0KPiA+ID4gPiBXaXRo
IHRoaXMgY2hhbmdlLCBhIGNoYXJkZXYgd2lsbCBiZSBjcmVhdGVkOg0KPiA+ID4gPiAxLiBpZiB0
aGVyZSBpcyBhbiBJSU8gYnVmZmVyIGF0dGFjaGVkIE9SDQo+ID4gPiA+IDIuIGlmIHRoZXJlIGlz
IGFuIGV2ZW50X2ludGVyZmFjZSBjb25maWd1cmVkDQo+ID4gPiA+IA0KPiA+ID4gPiBPdGhlcndp
c2UsIG5vIGNoYXJkZXYgd2lsbCBiZSBjcmVhdGVkLg0KPiA+ID4gPiBRdWl0ZSBhIGxvdCBvZiBJ
SU8gZGV2aWNlcyBkb24ndCByZWFsbHkgbmVlZCBhIGNoYXJkZXYsIHNvIHRoaXMgaXMgYQ0KPiA+
ID4gPiBtaW5vcg0KPiA+ID4gPiBpbXByb3ZlbWVudCB0byB0aGUgSUlPIGNvcmUsIGFzIHRoZSBJ
SU8gZGV2aWNlIHdpbGwgdGFrZSB1cCBmZXdlcg0KPiA+ID4gPiByZXNvdXJjZXMuDQo+ID4gPiA+
IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5h
cmRlbGVhbkBhbmFsb2cuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gDQo+ID4gPiA+IENoYW5n
ZWxvZyB2MSAtPiB2MjoNCj4gPiA+ID4gKiBzcGxpdCBhd2F5IGZyb20gc2VyaWVzICdpaW86IGNv
cmUsYnVmZmVyOiByZS1vcmdhbml6ZSBjaGFyZGV2DQo+ID4gPiA+IGNyZWF0aW9uJzsNCj4gPiA+
ID4gICAgaSdtIGdldHRpbmcgdGhlIGZlZWxpbmcgdGhhdCB0aGlzIGhhcyBzb21lIHZhbHVlIG9u
IGl0J3Mgb3duOw0KPiA+ID4gPiAgICBubyBpZGVhIGlmIGl0IG5lZWRzICdGaXhlcycgdGFnOyBp
dCBpcyBhIGJpdCBmdXp6eSB0byBwb2ludCB0byBhDQo+ID4gPiA+IHBhdGNoDQo+ID4gPiA+ICAg
IHdoaWNoIHRoaXMgd291bGQgYmUgZml4ZWQgYnkgdGhpczsgaSdtIGd1ZXNzaW5nIGl0IHdvdWxk
IGJlIGZpbmUNCj4gPiA+ID4gICAgd2l0aG91dCBvbmUNCj4gPiA+IEknZCBhcmd1ZSBpdCdzIGFu
ICdvcHRpbWl6YXRpb24nIHJhdGhlciB0aGFuIGEgZml4IDopDQo+ID4gPiANCj4gPiA+IFN0aWxs
IGxvb2tzIGdvb2QgdG8gbWUgYnV0IEknZCBsaWtlIGl0IHRvIHNpdCBmb3IgYSBsaXR0bGUgd2hp
bGUgdG8NCj4gPiA+IHNlZSBpZiBhbnlvbmUgcG9pbnRzIG91dCBzb21ldGhpbmcgd2UgYXJlIGJv
dGggbWlzc2luZyENCj4gPiA+IA0KPiA+IFRoaXMgaXMgbm90IGdvb2QuDQo+ID4gSXQgc2VlbXMg
dGhhdCBJIGRpZCBub3QgcHJvcGVybHkgdGVzdCBhbGwgY2FzZXMuDQo+ID4gSSBoYWQgdG8gYnJl
YWsgYSBkZXZpY2UgdG8gbm90IGhhdmUgYW4gZXZlbnRfaW50ZXJmYWNlIHRvIG5vdGljZSB0aGF0
IHRoZQ0KPiA+IHN5c2ZzDQo+ID4gZG9lc24ndCBnZXQgaW5zdGFudGlhdGVkIGVpdGhlciBiZWNh
dXNlIGRldmljZV9hZGQgaXMgbWlzc2luZy4NCj4gPiANCj4gPiBXaWxsIGRvIGFub3RoZXIgdHJ5
Lg0KPiANCj4gSSB0aGluayB5b3UgYWxzbyBoYXZlIHRvIG1ha2UgdGhlIGBpbmRpb19kZXYtPmRl
di5kZXZ0ID0gLi4uYCANCj4gY29uZGl0aW9uYWwuIE9yIGNvbmRpdGlvbmFsbHkgdXNlIGRldmlj
ZV9hZGQoKSBpbnN0ZWFkIG9mIGRldmljZV9hZGRfY2RldigpLg0KPiANCj4gSWYgeW91IGdvIGZv
ciB0aGUgZm9ybWVyIHlvdSBuZWVkIHRvIGNhbGwgY2Rldl9kZXZpY2VfZGVsKCkgDQo+IHVuY29u
ZGl0aW9uYWxseSwgZm9yIHRoZSBsYXR0ZXIgY2FsbCBkZXZpY2VfZGVsKCkgb3IgY2Rldl9kZXZp
Y2VfZGVsKCkgDQo+IGRlcGVuZGluZyBvbiB3aGV0aGVyIHRoZSBjZGV2IHdhcyByZWdpc3RlcmVk
Lg0KDQpJIHdhcyB0aGlua2luZyBvZiBjb25kaXRpb25hbGx5IHVzaW5nIGNkZXZfZGV2aWNlX2Fk
ZC9kZWwoKSBzb21laG93Lg0KQnV0LCB0aGlzIGNvbXBsaWNhdGVzIHRoZSByZXN0IG9mIHRoZSBz
ZXJpZXMgYSBiaXQuDQpBbmQgSSBhbSB0aGlua2luZyBvZiBob3cgdG8gc2ltcGxpZnkgaXQuDQoN
CkFueXdheSwgdGhpcyB3aWxsIGdvIGJhY2sgdG8gdGhlIHNlcmllcyAgwq9cXyjjg4QpXy/Crw0K
DQo+IA0KPiAtIExhcnMNCj4gDQo+IA0K
