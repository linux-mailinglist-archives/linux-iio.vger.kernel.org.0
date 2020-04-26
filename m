Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07F71B8D60
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 09:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgDZHZa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 03:25:30 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25758 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725847AbgDZHZ3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 03:25:29 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03Q7NH6O016544;
        Sun, 26 Apr 2020 03:25:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 30mj452kgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Apr 2020 03:25:27 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03Q7PRgH018397;
        Sun, 26 Apr 2020 03:25:27 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-00128a01.pphosted.com with ESMTP id 30mj452kgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Apr 2020 03:25:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blwVnq+TTeOD9oiw+04nWxMCn/+R5vY2GzZC+Hp9CTdrUP6AFxHTMlpA0KJKdoT7KA4TVAq7pigJRkzqlIjXYQaAsAuqHT6g97aDAxWOt0zl7ANMjTIYXa3iKjd5he2S3C47pRAoyslC2fkj0vb0UafyyyWHvG7c7/GUVENKp2stmoN1KfVa7EwD7dXB0/zgjiRHm0C0RY1UU6fVIrDbH5eitK6HvWAmnk4K/LScyGn1atMQLMlDEZyn5bHh1+lzgN5P72a/wvRmS0oKKrIeTqoqzYFZtBf3C2K+dyCmfEHdlcTUKphbWm68RDo9P8Wpfjb9u65+Z3cRqtu4AxBc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNHjegXzKojdgi9knESQSoYR1dm3IM4TKfqK7Xcgh6c=;
 b=iN9pXAE92nWxqJ+nOeXyF44rvNkAzq5YHShF2hUYvQbo2erGjvU7Jw2xFAIrJkRqEumRxCWur3/GuutpRCocK7CbtUkz4OptqSzXwh/F6z5zm2NCn7ovJqRkxRfJRTygaDZ+EEJBaVfqmvpLVKdrEAMk+SPJ8Dc+Uma2IoVZQubncumGdQMAxZprnZBHzWGT1uWUCWOauOFUA3OiAGu+6EA+NOkLPhdT9gHt5gYNZ32Ewq0AivupTeenSo09fmTPJbKQsbtfPsnjHq4+qA2EOsnsc4oJTNVGSS3FZqkN9raR3h7IsTTrS+bVq2X+yFjDL+26xdQH2WiuNCTY+oMTiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNHjegXzKojdgi9knESQSoYR1dm3IM4TKfqK7Xcgh6c=;
 b=noHC3HCsBpwho8xu3kKYbHOUChMFpf1YH7WCqm5D/wFck0rz/i+aphfWucAfNCQ8qQv3RkNhyO2HJnHUXj0vrKwp6sZtZ2LW2csUxv0PSeNPn73BDkDbFM3B//HufddiEmrC1RfPsx7phGfU+3/xS65atjdoV3mKA1m6k6+0RNc=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5194.namprd03.prod.outlook.com (2603:10b6:5:24c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sun, 26 Apr
 2020 07:25:25 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 07:25:25 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: Use an early return in iio_device_alloc to simplify
 code.
Thread-Topic: [PATCH] iio: Use an early return in iio_device_alloc to simplify
 code.
Thread-Index: AQHWFl1raH406mgAF0OJKYmouVYuqqiBiyMAgAh5tYCAAQYgAA==
Date:   Sun, 26 Apr 2020 07:25:25 +0000
Message-ID: <6d3b7c4283dcda6f5dfc6b2b5d80fc8a0d43f36d.camel@analog.com>
References: <20200419151337.43293-1-jic23@kernel.org>
         <0aac8f5bd4836b8ac0013bf19b2d8a0f9a8b5c47.camel@analog.com>
         <20200425164713.201c89cc@archlinux>
In-Reply-To: <20200425164713.201c89cc@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f130cc7a-33ca-43f5-1ac3-08d7e9b2fd2a
x-ms-traffictypediagnostic: DM6PR03MB5194:
x-microsoft-antispam-prvs: <DM6PR03MB51948E06E8B798145590D8FCF9AE0@DM6PR03MB5194.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03853D523D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(346002)(136003)(396003)(39850400004)(66946007)(66476007)(4326008)(2906002)(6916009)(6486002)(478600001)(71200400001)(5660300002)(2616005)(6506007)(26005)(8936002)(66556008)(81156014)(91956017)(76116006)(316002)(86362001)(64756008)(6512007)(8676002)(36756003)(54906003)(66446008)(186003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9w8XqWKv+wOQq4n0qh6mFXgVWl3+Gdl7Qp3KkxjEVwf9J9RHpfbwXMqQqFoK2dXieN3kLDXrLkN6EtHalRIms6R1bylvHrYj6K3k+/bsLRR/19ly1TlSG2lVDrLRhZQVS1UtjeASSkUanXbIlX5niERCaaaRZAGHCdK6B5aKe2RnIDALPkBBS/RcQ9dkS+1VbntsEoTFdQlXF8QnVtBR+uKV/wBR8LIqZ4dWMVdSlwL+0QrOz98IuCIXVkUbkHxK/pRX7VlVDVgMzXKGHILieH4gC7I8G3u9gVcHoKcKwaXmTKfBlfPauF6JzbBlwr2d1UhWUEcXJj/zlR66/qq80B9kp7XlwuoNXyHwHFQuPiW+YQsLlfC8j36Qh9mG91+5vg4mEBfCGxTXFNr0K/yE7YDsNUiIkJjeQvOA4jWr29Ykx3c6dT9ilo/vCCwQS8dU
x-ms-exchange-antispam-messagedata: HQt/SFZU6KrEOWrYkbi2K/xKHMM4G3SKtQicrsCPXjUEALL7/058zwoKPgM1oRl+luFuTLfXm2GYRXR055XG7onDPLJL7OLAOc2FWQ+Xd3ajLXBRxxIa9f2HVvYIcfuqBFW/Uf3EjadDxo9eZdFJ6q2CCOOkiuGPAbGSg54WaIB2Lmbjn25OeM9ux8WGSMBE1WErc/FayGlgtA+4vD0YdTFwTKRDZTavryeq3+3g2zfDbEwjPnSX8pr0OU6Ygs95F0l2kdne19o33ZlgmCdUZ089W/7lU4q/6EV61dAU5MXqC+bGN2g97s04sMNioS07J2Q79upHAFIqlQ2xN1lWYaVwUNvCh+EqwpJ0D0T/u72SooC+t9+HWzffbnCz7tbkYuBz1E06WbB2QmO7Bq8zBwnh9NkzC5Lt9dAEx52RJX8JahRRnPl/GIDVbbjNaJmg1B9S7Jb5CI7OrBxDmYtEXD1gz3PSaJvnzdz+6NyEri2pYXo1BGOvh2TL1WkwVqDLKFbH8B/lxdhNiAeIQQpupRSxrydiqmGG7FJIQZTRnZIpkzpnJjtHu8zIFeyu9m8gSLZHpBzT3DIkezA3EwxZ90oQYZU18656/iW+d6F8JdRtsvTAuRu3uHL5/H8KP5vAIeNAJPVkl+e9PRdO2W5hS4KIBxTRD6BDA0wEBO8JZQ7pCbTFgnq/AbkScJe76ET97s+IA6uIsMuvQLhF1RzZk6Mta/4kuVKgkEjfsH2QXA5o42lbROJ+/wmdPJq5MfjemlFckhdqp7+STShdAvLuXBrtAMuLBFmLibPA57O723c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <94A8AD43EEDACC4E8D74D92E2D28BE86@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f130cc7a-33ca-43f5-1ac3-08d7e9b2fd2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2020 07:25:25.5381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xz8UxiDTL4EFn7x0JY5yRMOwR990JGC4KDFk3L2EnbdDliZ1FUw2i3DAdPuwAjvKygvT1pcAAYj2DljNaoUQhTa8o4+54VKw+rz+pBWYXpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5194
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-25_14:2020-04-24,2020-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004260067
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDIwLTA0LTI1IGF0IDE2OjQ3ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBNb24sIDIwIEFwciAyMDIwIDA2OjE3OjMyICswMDAwDQo+ICJBcmRlbGVhbiwgQWxl
eGFuZHJ1IiA8YWxleGFuZHJ1LkFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBP
biBTdW4sIDIwMjAtMDQtMTkgYXQgMTY6MTMgKzAxMDAsIGppYzIzQGtlcm5lbC5vcmcgd3JvdGU6
DQo+ID4gPiBbRXh0ZXJuYWxdDQo+ID4gPiANCj4gPiA+IEZyb206IEpvbmF0aGFuIENhbWVyb24g
PEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gPiA+IA0KPiA+ID4gTm90aWNlZCB3aGls
c3QgcmV2aWV3aW5nIEFsZXhhbmRydSdzIHBhdGNoIHRvIHRoZSBzYW1lIGZ1bmN0aW9uLg0KPiA+
ID4gSWYgd2Ugc2ltcGx5IGZsaXAgdGhlIGxvZ2ljIGFuZCByZXR1cm4gTlVMTCBpbW1lZGlhdGVs
eSBhZnRlciBtZW1vcnkNCj4gPiA+IGFsbG9jYXRpb24gZmFpbHVyZSB3ZSByZWR1Y2UgdGhlIGlu
ZGVudCBvZiB0aGUgZm9sbG93aW5nIGJsb2NrIGFuZA0KPiA+ID4gZW5kIHVwIHdpdGggbW9yZSAn
aWRpb21hdGljJyBrZXJuZWwgY29kZS4NCj4gPiA+ICAgDQo+ID4gDQo+ID4gSSBhbHNvIHdhcyB0
ZW1wdGVkIHRvIGRvIGl0LCBidXQgd2FzIHRlbXB0ZWQgW2EgYml0IG1vcmVdIGJ5IHRoZSBpbml0
aWFsDQo+ID4gY2hhbmdlDQo+ID4gdGhhdCBJIGdvb2ZlZC4NCj4gPiANCj4gPiBBIGZldyB0aG91
Z2h0cyBvbiB0aGlzIFtjYW4gYmUgaWdub3JlZF0uDQo+ID4gQnV0LCBzaW5jZSBkb2luZyB0aGlz
IGNoYW5nZSwgc2hvdWxkICdkZXYnIGJlIHJlbmFtZWQgdG8gJ2luZGlvX2Rldic/DQo+ID4gSXQg
c2hvdWxkbid0IGJlIGEgbG90IG1vcmUgY29kZSB0aGFuIHRoZSBjdXJyZW50IGNoYW5nZSBbSSBo
b3BlXS4NCj4gPiBXaGVuIGxvb2tpbmcgdGhyb3VnaCBJSU8gY29yZSwgSSBnb3QgYSBtaW5vci9z
bGlnaHQgY29uZnVzaW9uIG9uIHRoaXMgYWxsb2MNCj4gPiBjb2RlDQo+ID4gYWJvdXQgdGhlIG5h
bWUgJ2RldicgW3doaWNoIGlzIG9mIHR5cGUgJ3N0cnVjdCBpaW9fZGV2JyB2cyAnc3RydWN0IGRl
dmljZScsDQo+ID4gYXMNCj4gPiBpcyBtb3JlIGN1c3RvbWFyeV0uDQo+ID4gDQo+ID4gSWYgJ2Rl
dicgd2FzIGNob3NlbiB0byBmaXQgd2l0aGluIGFueSA4MCBjb2wtd2lkdGggbGltaXQsIHRoYXQg
bGltaXQgc2hvdWxkDQo+ID4gYmUNCj4gPiBsZXNzIGxpa2VseSB0byBoaXQgbm93Lg0KPiANCj4g
QSBkaWZmZXJlbnQgdHlwZSBvZiBjbGVhbnVwLCBzbyBJIHRoaW5rIHdvcnRoIGEgc2VwYXJhdGUg
cGF0Y2gNCj4gKGV2ZW4gdGhvdWdoIGl0J3MgbWVzc2luZyB3aXRoIHRoZSBzYW1lIGJsb2NrIG9m
IGNvZGUuKQ0KPiANCj4gR290IHRvIGtlZXAgdG8gdGhlIHJ1bGVzIEkgcGVzdGVyIGV2ZXJ5b25l
IGVsc2UgaW50byBmb2xsb3dpbmcgOikNCg0KRmFpciBlbm91Z2guDQpJIHdhcyBhc3N1bWluZyB0
aGVyZSB3b3VsZCBiZSBhIHByZWZlcmVuY2UgdG8ga2VlcCB0aGUgcGF0Y2ggc2VtYW50aWMgYXMg
c2ltcGxlDQphcyBwb3NzaWJsZS4NCg0KSSB0aG91Z2h0IEknZCBwb2ludCB0aGVtIG91dCwgc2lu
Y2UgSSBhbHNvIGxvb2tlZCBvdmVyIHRoaXMgYml0IGEgd2hpbGUgYmFjay4NCg0KPiANCj4gU28g
SSdsbCBhcHBseSB0aGlzIGFzIGlzIGFuZCBtaWdodCBnZXQgdGhlIGRldi0+aW5kaW9fZGV2IG9u
ZSBvdXQNCj4gYWZ0ZXIgSSd2ZSBjYXVnaHQgdXAgd2l0aCByZXN0IG9mIGVtYWlsIHF1ZXVlLiAN
Cj4gDQo+IFRoYW5rcywNCj4gDQo+IEpvbmF0aGFuDQo+IA0KPiA+IDEgbW9yZSBpbmxpbmUuDQo+
ID4gDQo+ID4gV2VsbCwgZXZlbiB3aXRoL3dpdGhvdXQgdGhlc2UgY2hhbmdlcy4NCj4gPiANCj4g
PiBSZXZpZXdlZC1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5h
bG9nLmNvbT4NCj4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpv
bmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gPiA+IENjOiBBbGV4YW5kcnUgQXJkZWxlYW4g
PGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVy
cy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYyB8IDM4ICsrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxOSBkZWxl
dGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2luZHVzdHJp
YWxpby1jb3JlLmMgYi9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tDQo+ID4gPiBjb3JlLmMNCj4g
PiA+IGluZGV4IGY0ZGFmMTlmMmEzYi4uOTZmNmRhY2IyMDZkIDEwMDY0NA0KPiA+ID4gLS0tIGEv
ZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9paW8v
aW5kdXN0cmlhbGlvLWNvcmUuYw0KPiA+ID4gQEAgLTE1MDQsMjcgKzE1MDQsMjcgQEAgc3RydWN0
IGlpb19kZXYgKmlpb19kZXZpY2VfYWxsb2MoaW50IHNpemVvZl9wcml2KQ0KPiA+ID4gIAlhbGxv
Y19zaXplICs9IElJT19BTElHTiAtIDE7DQo+ID4gPiAgDQo+ID4gPiAgCWRldiA9IGt6YWxsb2Mo
YWxsb2Nfc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ID4gPiArCWlmICghZGV2KQ0KPiA+ID4gKwkJcmV0
dXJuIE5VTEw7DQo+ID4gPiAgDQo+ID4gPiAtCWlmIChkZXYpIHsNCj4gPiA+IC0JCWRldi0+ZGV2
Lmdyb3VwcyA9IGRldi0+Z3JvdXBzOw0KPiA+ID4gLQkJZGV2LT5kZXYudHlwZSA9ICZpaW9fZGV2
aWNlX3R5cGU7DQo+ID4gPiAtCQlkZXYtPmRldi5idXMgPSAmaWlvX2J1c190eXBlOw0KPiA+ID4g
LQkJZGV2aWNlX2luaXRpYWxpemUoJmRldi0+ZGV2KTsNCj4gPiA+IC0JCWRldl9zZXRfZHJ2ZGF0
YSgmZGV2LT5kZXYsICh2b2lkICopZGV2KTsNCj4gPiA+IC0JCW11dGV4X2luaXQoJmRldi0+bWxv
Y2spOw0KPiA+ID4gLQkJbXV0ZXhfaW5pdCgmZGV2LT5pbmZvX2V4aXN0X2xvY2spOw0KPiA+ID4g
LQkJSU5JVF9MSVNUX0hFQUQoJmRldi0+Y2hhbm5lbF9hdHRyX2xpc3QpOw0KPiA+ID4gLQ0KPiA+
ID4gLQkJZGV2LT5pZCA9IGlkYV9zaW1wbGVfZ2V0KCZpaW9faWRhLCAwLCAwLCBHRlBfS0VSTkVM
KTsNCj4gPiA+IC0JCWlmIChkZXYtPmlkIDwgMCkgew0KPiA+ID4gLQkJCS8qIGNhbm5vdCB1c2Ug
YSBkZXZfZXJyIGFzIHRoZSBuYW1lIGlzbid0IGF2YWlsYWJsZSAqLw0KPiA+ID4gLQkJCXByX2Vy
cigiZmFpbGVkIHRvIGdldCBkZXZpY2UgaWRcbiIpOw0KPiA+ID4gLQkJCWtmcmVlKGRldik7DQo+
ID4gPiAtCQkJcmV0dXJuIE5VTEw7DQo+ID4gPiAtCQl9DQo+ID4gPiAtCQlkZXZfc2V0X25hbWUo
JmRldi0+ZGV2LCAiaWlvOmRldmljZSVkIiwgZGV2LT5pZCk7DQo+ID4gPiAtCQlJTklUX0xJU1Rf
SEVBRCgmZGV2LT5idWZmZXJfbGlzdCk7DQo+ID4gPiArCWRldi0+ZGV2Lmdyb3VwcyA9IGRldi0+
Z3JvdXBzOw0KPiA+ID4gKwlkZXYtPmRldi50eXBlID0gJmlpb19kZXZpY2VfdHlwZTsNCj4gPiA+
ICsJZGV2LT5kZXYuYnVzID0gJmlpb19idXNfdHlwZTsNCj4gPiA+ICsJZGV2aWNlX2luaXRpYWxp
emUoJmRldi0+ZGV2KTsNCj4gPiA+ICsJZGV2X3NldF9kcnZkYXRhKCZkZXYtPmRldiwgKHZvaWQg
KilkZXYpOw0KPiA+ID4gKwltdXRleF9pbml0KCZkZXYtPm1sb2NrKTsNCj4gPiA+ICsJbXV0ZXhf
aW5pdCgmZGV2LT5pbmZvX2V4aXN0X2xvY2spOw0KPiA+ID4gKwlJTklUX0xJU1RfSEVBRCgmZGV2
LT5jaGFubmVsX2F0dHJfbGlzdCk7DQo+ID4gPiArDQo+ID4gPiArCWRldi0+aWQgPSBpZGFfc2lt
cGxlX2dldCgmaWlvX2lkYSwgMCwgMCwgR0ZQX0tFUk5FTCk7DQo+ID4gPiArCWlmIChkZXYtPmlk
IDwgMCkgew0KPiA+ID4gKwkJLyogY2Fubm90IHVzZSBhIGRldl9lcnIgYXMgdGhlIG5hbWUgaXNu
J3QgYXZhaWxhYmxlICovDQo+ID4gPiArCQlwcl9lcnIoImZhaWxlZCB0byBnZXQgZGV2aWNlIGlk
XG4iKTsNCj4gPiA+ICsJCWtmcmVlKGRldik7DQo+ID4gPiArCQlyZXR1cm4gTlVMTDsgIA0KPiA+
IA0KPiA+IHdvdWxkIGl0IGJlIHRvbyBtdWNoIGZvciB0aGlzIHBhdGNoIHRvIG1vdmUgdGhpcyBy
aWdodCBhZnRlciB0aGUga3phbGxvYygpPw0KPiA+IG5vIHN0cm9uZyBvcGluaW9uIGZyb20gbXkg
c2lkZSB0byBkbyBpdCBvciBub3Q7DQo+ID4gYnV0IGl0IGRvZXMgc2F2ZSBzb21lIGluaXQgY3lj
bGVzLCBhbmQgY29tcHJlc3NlcyB0aGlzIGluaXQgYmxvY2sgYSBiaXQ7DQo+IA0KPiBJdCBkb2Vz
bid0IHJlYWxseSBzYXZlIGFueSBjeWNsZXMgYmVjYXVzZSB0aGUgY2hhbmNlIG9mIGZhaWx1cmUg
b2YgSUQNCj4gYWxsb2NhdGlvbg0KPiBpcyBuZWdsaWdpYmxlLi4uICBOb3cgSSdkIGFncmVlIHdp
dGggeW91IGlmIHdyaXRpbmcgZnJvbSBzY3JhdGNoLCBidXQgYXMgYQ0KPiB0aWR5IHVwIHBhdGNo
LCBpdCdzIGdvb2QgdG8ga2VlcCB0aGluZ3MgcmVhbGx5IHNpbXBsZS4NCj4gDQo+IA0KPiA+ID4g
IAl9DQo+ID4gPiArCWRldl9zZXRfbmFtZSgmZGV2LT5kZXYsICJpaW86ZGV2aWNlJWQiLCBkZXYt
PmlkKTsNCj4gPiA+ICsJSU5JVF9MSVNUX0hFQUQoJmRldi0+YnVmZmVyX2xpc3QpOw0KPiA+ID4g
IA0KPiA+ID4gIAlyZXR1cm4gZGV2Ow0KPiA+ID4gIH0gIA0K
