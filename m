Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E8B20D287
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jun 2020 20:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgF2St7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jun 2020 14:49:59 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:16584 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725856AbgF2St6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jun 2020 14:49:58 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TDkLoW007858;
        Mon, 29 Jun 2020 09:51:57 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0b-00128a01.pphosted.com with ESMTP id 31x2r6vu58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 09:51:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFfyJ616PbcVhjW80vZahn4TwpYuPDXR0xsxxDHxZ+gXPqRqsgAhVTYtWMtiecawAhgwCEb+AeXtule0SkxMCOn4Wxmno0jDF18aTEkpM1IA1hyAPOtFWWpt/f0jJeKKcphsJsp2Tp6nEvlP0rZttFGWJG4BuXmqsv+ncwKqR9nDnC3wdi4QtGEqEiZUOuILU/wem3+7cfH27l1D03aFkkyGf8S2mCRFOWCpP/P+lD1XJdCs6RpeIsbq9cvFOU+pIVaxVU39qHeSnX5I0/YhiYZF3dOSNxKZEqgYrfJXkUwew7Qcxx0/gE95XnX/gHJqrMp+yKUY6M38ZHbABvKaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvYL3I60gndDKWrYmpeOa8+NnhgvKmR/U4Oc7Q4L28I=;
 b=bPjYXEZIiBwJk1g6ABwdj0nXmju0u+pVhLcI3PSn0d+bXlsUGQDeyyMiulxHYkh5rRDilJflvCnNE+rftEo6dxk7/YAwzI5qRdN1IhzKEPfokBKoAGyRRTxkobHA5uxRGcR0ajgeags6WgSOMSqPT6wOPzVFXdYF+EdhboUIaVpfysU0pf+hE9owKOMI4kRsRtX3krsVOivGOsrxA7rZHjr0oxqHvBgHeZagKE+Rv73jj6dOz5jd1quSvQETAkx621mwYhxF+9NSZ1Euv92K3Lr3Luudew07H483WP5SqSIWRppKQIsZ9M1l3bU4P1qDuMKNFOoGEiTTbL4YPdzxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvYL3I60gndDKWrYmpeOa8+NnhgvKmR/U4Oc7Q4L28I=;
 b=8pxJ4uqwOHzkyAhw2B0o5fAbyrOg2Ky7JW7h6q9QdcbGLpKXyHT+QhFTIuj8QqQLvTTchBosZx0z0ODl1OPUTY1vQF9Cug1t1qXOSgF7vvlV4IwN3AU8vJnZA807kgFrMpB1+A2lFod06bnh6a/9AbYAF1H47cv1BQzrOwG2s9E=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5130.namprd03.prod.outlook.com (2603:10b6:5:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 13:51:55 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 13:51:54 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Interest in a virtual IIO microconf?
Thread-Topic: Interest in a virtual IIO microconf?
Thread-Index: AQHWTUi5NeHTYGZI2kOCtldhjXH/vKjvnlKA
Date:   Mon, 29 Jun 2020 13:51:54 +0000
Message-ID: <2fd40a0d341cbe7dded2fa9b2f53b4f87b1a2ab8.camel@analog.com>
References: <20200628133607.61d31ed1@archlinux>
In-Reply-To: <20200628133607.61d31ed1@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.128.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac79d4d9-d992-40d4-3136-08d81c339576
x-ms-traffictypediagnostic: DM6PR03MB5130:
x-microsoft-antispam-prvs: <DM6PR03MB51306CAA316B23E287C07604F96E0@DM6PR03MB5130.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aYLXLopuUJi27bO2zhRPPMd7DlQzSiFcjlIgCW5zV5HECByfWAxiWJbHJiGN3/aDqNgqwHUrJGND3V2ntmOky+MYW/y7I5MLIc9YITw8BTDXYhBb5wwFxOfPI/03tt30WvwEib43NRHmVDev970bsBBIalz+e+vXPsAsgG71JJa6ga5/S8nDN41xDdMX5xh/LASchQrH3OT4PYKELEbLorGC76+uR1uVKJ6GBDqMsNsnFK3ZQXFX5FvbdKwcUpt9bjSn2BDj2Gv6iP0vB6WxOY4dapFC3jqvRBkrP/qxibGBlqBwt4tQAVjU0AOyMW9sXuDTB/QI3zVy9qZg1nBAKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(346002)(136003)(39860400002)(376002)(5660300002)(2616005)(478600001)(36756003)(316002)(66946007)(83380400001)(6512007)(2906002)(91956017)(66476007)(76116006)(6506007)(6486002)(66446008)(64756008)(66556008)(8676002)(8936002)(71200400001)(110136005)(86362001)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: dTCpyDf72Np6S5Itbr8GMpA4bZNACKWUrkjypQJ+TUsGydb2tlaYPoXmh17so4MSKBw8QmduDbDKI5mnc1KjgZnS78BIDwDS7zD9oDJxsJNKSIUjvA9S6LMrZP5djZSJcQ0Drjj11IDl7RwlPnkrn4oCxzoXPUZBYoPICgQbgM5qWA4pfZV0R+0ufbW1zmmrYL96O1Lr6po5Pp09/w/r+4mipZSFDFyBXLkVCU1Kv/THf0V2IHy66UC2hnnjMMbyy3FzfIFR4Fi4MveGGcHjVAiXRAOz1ZpFBmPQG3DyoCOpmKSdN32HqT1IPV5fp48NrW5GyLm2nW/pIRvBPXQOToUbtn2ofJI3rFeq31ehtnMINXYHDenbXX/pO/qWiy+v9nhCH/xymBFsfQZ5vE+4wzlgqTvvvaUZRjAvIUQ43ng2kPo6Jr0EQ42BOwC07bK8ijLkjlipHx6J5xVG9mjKIz5/Fks6CrWCUTN18UO3XFU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A042F1DA58C2A47A709A99613B58EF8@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac79d4d9-d992-40d4-3136-08d81c339576
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 13:51:54.7766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XoxHQVLlrujqvfvHuaFlcv+oa5ZHkhvbq4TTxRtCUJnDQTH4FOUf9TeaZavfvH2x6t4KSuU+ctkqFS0nB7FOY09tTBsTx2uhDYsSkBZHGts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5130
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-29_11:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 cotscore=-2147483648 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290097
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA2LTI4IGF0IDEzOjM2ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBIaSBBbGwNCj4gDQoNCkhleSwNCg0KSSdkIGJlIGludGVyZXN0ZWQgaW4gYSB2aXJ0dWFs
IG1pY3JvY29uZi4NClNvbWUgbW9yZSBub3RlcyBpbmxpbmUuDQoNCg0KPiBTdW1tYXJ5Og0KPiAN
Cj4gSXMgdGhlcmUgZW5vdWdoIElJTyBkZXZlbG9wZXIgaW50ZXJlc3QgaW4gc3BlbmRpbmcgYSBm
ZXcgaG91cnMgdGFsa2luZw0KPiBhYm91dA0KPiBJSU8gdG9waWNzPyAgTm90ZSB3ZSBtYXkgZ28g
ZGVlcCBpbiBwbGFjZXMgYnV0IG90aGVyIHRvcGljcyBuZWVkIGEgd2lkZQ0KPiByYW5nZQ0KPiBv
ZiBwZW9wbGUgYW5kIGV4cGVyaWVuY2UgdG8gYmUgdXNlZnVsIQ0KPiANCj4gU28sIEkgaGF2ZSB0
aG91Z2h0IGFib3V0IHRyeWluZyB0byBvcmdhbml6ZSBhIHdvcmtzaG9wIC8gbWljcm9jb25mIGF0
IG9uZQ0KPiBvZiB0aGUNCj4gYmlnIExpbnV4IGNvbmZlcmVuY2VzIGluIHRoZSBwYXN0LiAgSG93
ZXZlciwgSSd2ZSBub3QgZG9uZSBhbnl0aGluZyBhYm91dA0KPiBpdA0KPiBiZWNhdXNlIDoNCj4g
DQo+IDEuIEFjdGl2ZSBJSU8gZGV2ZWxvcGVycyBhcmUgZ2VvZ3JhcGhpY2FsbHkgc3ByZWFkIG91
dCwgc28gY2hhbmNlcyBhcmUgd2UNCj4gICAgd291bGQgb25seSBnZXQgYSBzbWFsbCBzdWJzZXQg
b2YgcGVvcGxlLiAgV2hpbHN0IHRoYXQncyBmaW5lIGZvcg0KPiBoYXZpbmcNCj4gICAgYSBmZXcg
YmVlcnMvY29mZmVlIGFuZCBhIGNoYXQsIGl0IGlzIG5vdCBzbyBnb29kIG9uIGFuIGluY2x1c2l2
ZSAvDQo+IHVzZWZ1bCBiYXNpcw0KPiAgICBmb3IgbWFraW5nIGFueSBwcm9ncmVzcy4gIFdoaWxz
dCB0aGUgTGludXggZm91bmRhdGlvbiBhbmQgb3RoZXJzIGRvDQo+IHRoZWlyDQo+ICAgIGJlc3Qg
dG8gZW5jb3VyYWdlIGEgd2lkZSByYW5nZSBvZiBwZW9wbGUgdG8gYXR0ZW5kIHRoZXNlIGV2ZW50
cywgdGhlDQo+IHJlYWxpdHkNCj4gICAgaXMgdGhhdCBnb2luZyB0byBhIGNvbmZlcmVuY2UgaXMg
ZXhwZW5zaXZlIGluIG1vbmV5IGFuZC9vciB0aW1lLg0KPiANCj4gMi4gV2hpbHN0IEkgaGF2ZSBw
ZXJzb25hbGx5IGJlZW4gZ29pbmcgdG8gbW9yZSBjb25mZXJlbmNlcyBpbiByZWNlbnQNCj4gdGlt
ZXMgdGhhbg0KPiAgICBJIGRpZCBhIGZldyB5ZWFycyBiYWNrLCB0aGV5IGFyZW4ndCBhbHdheXMg
J3RoZSByaWdodCBvbmVzJyBmb3IgdGhpcw0KPiBzb3J0DQo+ICAgIG9mIG1lZXRpbmcuDQo+IA0K
PiAzLiBJdCB3YXNuJ3Qgb2J2aW91cyB0aGF0IHdlIHdvdWxkIGFjdHVhbGx5IGhhdmUgYSBlbm91
Z2ggdG8gdGFsayBhYm91dC4NCj4gICAgVGhpcyBpcyBtb3JlIG9mIGFuIGlzc3VlIGlmIGl0IGlu
dm9sdmVkIHBlb3BsZSBqdW1waW5nIG9uIHBsYW5lcyB3aXRoDQo+IGFsbA0KPiAgICB0aGUgaXNz
dWVzIHRoYXQgYnJpbmdzLg0KPiANCj4gNC4gSSd2ZSBtdWxsZWQgdHJ5aW5nIHNvbWV0aGluZyB2
aXJ0dWFsIGluIHRoZSBwYXN0IGJ1dCB3YXMgdW5jb252aW5jZWQNCj4gd2UgY291bGQNCj4gICAg
ZG8gaXQgaW4gZmFzaGlvbiB0aGF0IHdvdWxkIG1ha2UgaXQgbW9yZSBwcm9kdWN0aXZlIHRoYW4g
ZW1haWwNCj4gZXhjaGFuZ2VzLg0KPiANCj4gQW55aG93LCBhIGh1Z2UgYW1vdW50IGhhcyBjaGFu
Z2VkIHRoaXMgeWVhci4gIEknbSBzdXJlIGV2ZXJ5b25lIGlzDQo+IGdldHRpbmcgbW9yZQ0KPiB1
c2VkIHRvIGRvaW5nIHRoaW5ncyBvbmxpbmUgYW5kIGl0J3MgY2xlYXIgdGhhdCB1c2VmdWwgbWVl
dGluZ3Mgb2YgdGhpcw0KPiB0eXBlDQo+IGNhbiBvY2N1ciB3aXRob3V0IGdldHRpbmcgZXZlcnlv
bmUgc2F0IGFyb3VuZCBhIHRhYmxlLg0KPiANCj4gQ2xlYXJseSBsb3RzIG9mIG9wZW4gcXVlc3Rp
b25zIGFyb3VuZCB0aGlzOg0KPiANCj4gKiBXaGF0IHdvdWxkIHdlIHRhbGsgYWJvdXQ/DQo+IA0K
PiAqIEFyZSBlbm91Z2ggcGVvcGxlIGludGVyZXN0ZWQ/IA0KPiANCj4gKiBXaGVuPyAgQ2FuIHdl
IGFjdHVhbGx5IGZpbmQgYSB0aW1lem9uZSBvciBkYXRlIHRoYXQgd29ya3MgZm9yIGVub3VnaA0K
PiBwZW9wbGU/DQo+ICAgUGFydGljdWxhcmx5IHRydWUgZ2l2ZW4gbWl4dHVyZSBvZiBwZW9wbGUg
d2hvIGRvIElJTyBmb3IgdGhlaXIgZGF5IGpvYnMNCj4gYW5kDQo+ICAgdGhvc2Ugd2hvIGRvIGl0
IG91dCBvZiB3b3JrIHRpbWUhDQo+IA0KPiAgIE5vdGUgdGhhdCwgZm9yIGEgZmlyc3Qgc3VjaCBl
dmVudCBJJ2Qgc3VnZ2VzdCB3ZSBhcmUgbG9va2luZyBhdCBhcm91bmQNCj4gMyBob3Vycy4NCj4g
DQo+ICogUGxhdGZvcm06IFdlIGNvdWxkIHRyeSBhbmQgYXNzb2NpYXRlIHdpdGggYW4gZXhpc3Rp
bmcgZXZlbnQsIGJ1dCBhcyBpdA0KPiB3aWxsIGJlIHNtYWxsDQo+ICAgd2UgcHJvYmFibHkgZG9u
J3QgbmVlZCB0aGUgaGVhdnkgd2VpZ2h0IGxvZ2lzdGljcyBvZiBzb21ldGhpbmcgbGlrZQ0KPiBQ
bHVtYmVycw0KPiAgIChzaWRlIG5vdGUgLSB0aGVpciBvbmxpbmUgY29uZmVyZW5jaW5nIHNldHVw
IGlzIHZlcnkgaW1wcmVzc2l2ZSkuDQo+IA0KPiAgIE15IHBlcnNvbmFsIHByZWZlcmVuY2UgaXMg
Wm9vbSBhcyBpdCBzZWVtcyBtb3JlIHJlbGlhYmxlIHRoYW4NCj4gYWx0ZXJuYXRpdmVzDQo+ICAg
KGV2ZW4gdGhvdWdoIGl0J3MgY2xvc2VkIHNvdXJjZSBldGMuLi4gOiggVmlkZW8gb3B0aW9uYWwh
DQo+IA0KPiBJIGhhdmUgYSBmZXcgdGhvdWdodHMgb24gdG9waWNzIChpbiBubyBwYXJ0aWN1bGFy
IG9yZGVyKQ0KPiANCj4gMS4gR2VuZXJpYyBwcm9jZXNzIHN0dWZmLiAgU2hvdWxkIHdlIGNoYW5n
ZSBob3cgdGhlIElJTyBzdWJzeXN0ZW0gaXMNCj4gbWFpbnRhaW5lZD8NCj4gICAgSSBrbm93IEkg
aGF2ZSBhIGZldyB0aGluZ3MgSSdkIGxpa2UgdG8gYnJpZWZseSBkaXNjdXNzLiAgTm90ZSB0aGlz
IGlzDQo+IHN0YW5kYXJkDQo+ICAgIGZlYXR1cmUgaW4gcHJldHR5IG11Y2ggZXZlcnkgb3BlbiBz
b3VyY2UgcHJvamVjdCBtaWNyb2NvbmYhDQo+IA0KPiAyLiBNYWpvciBvdXQgb2YgdHJlZSBwYXRj
aGVzLiAgDQo+ICAgIC0gV2hhdCBpcyBvdXQgdGhlcmU/ICBQZXJoYXBzIHRoZXJlIGlzIHJvb20g
dG8gY29sbGFib3JhdGUgYXJvdW5kIHNvbWUNCj4gb2YgdGhpcy4NCj4gICAgLSBEbyB3ZSBoYXZl
IGEgcGF0aCB0byB1cHN0cmVhbSB0aGVtPw0KDQpOYXR1cmFsbHksIEkgaGF2ZSBzb21lIGludGVy
ZXN0IGluIHRoaXMgdG9waWMuDQoNCj4gDQo+IDMuIFRvcGljcyBvbiB0aGUgaG9yaXpvbj8gIFdo
ZXJlIHNob3VsZCB3ZSBnbz8NCj4gICAgLSBPbmUgdG9waWMgaW4gaGVyZSBpcyBwb3RlbnRpYWxs
eSBhcm91bmQgdmlydHVhbGl6YXRpb24gb24gZW1iZWRkZWQNCj4gICAgICBwbGF0Zm9ybXMgYW5k
IGhvdyBJSU8gbWlnaHQgZml0IHdpdGhpbiB0aGF0Lg0KDQpUaGlzIFtmb3IgbWVdIGlzIHBhcnRp
YWxseSByZWxhdGVkIHRvIDIuDQoNCkJ1dCBzb21ld2hhdCB1bnJlbGF0ZWQgW3RvIDIuXSwgd2Un
dmUgYmVlbiBkaXNjdXNzaW5nIGludGVybmFsbHkgc29tZSBpZGVhcw0KYWJvdXQgInJhcGlkLXBy
b3RvdHlwaW5nIi4NCkkga25vdyB0aGVyZSB3YXMgc29tZXRoaW5nIHRoYXQgSW50ZWwgZGlkIGEg
d2hpbGUgYmFjayBvbiB0aGlzLg0KV2UndmUgaGFkIHNvbWUgb3RoZXIgdGhvdWdodHMsIGJ1dCBk
aWQgbm90IGhhdmUgdGltZSB0byBmaW5hbGl6ZSB0aGVtLg0KDQo+IA0KPiA0LiBNZW50b3JzaGlw
IC8gc3VwcG9ydCBvZiBuZXcgZGV2ZWxvcGVycy4NCj4gICAgLSBXb3VsZCBsb3ZlIHRvIGdldCBz
b21lIGlucHV0cyBvbiB0aGlzIGZyb20gYm90aCBwZW9wbGUgd2hvIGRvIGEgbG90DQo+IG9mDQo+
ICAgICAgdGhpcyBhbmQgZnJvbSB0aG9zZSB3aG8gaGF2ZSByZWNlbnRseSBiZWVuIG9uIHRoZSAn
bmV3YmllJyBzaWRlIG9mDQo+IHRoaW5ncyENCj4gDQo+IDUuIFVzZWNhc2VzLiAgSSdkIHBlcnNv
bmFsbHkgbG92ZSB0byBoZWFyIGEgYml0IGFib3V0IHdoYXQgcGVvcGxlIGFyZQ0KPiBhY3R1YWxs
eQ0KPiAgICBkb2luZyB3aXRoIGFsbCB0aGVzZSBkZXZpY2VzISAgSSdkIGFsc28gYmUgaW50ZXJl
c3RlZCBpbiBwYWluIHBvaW50cw0KPiBldGMuDQo+IA0KPiA2LiBVc2Vyc3BhY2Ugc3RhY2tzLiAg
TW9yZSBkaXNjdXNzaW9uIGFyb3VuZCBwYWluIHBvaW50cyBldGMgdGhhbiBhbg0KPiBvdmVydmll
dyBvZg0KPiAgICB3aGF0IHRoZXJlIGlzLg0KPiANCj4gNy4gVGVzdGluZyAvIGVtdWxhdGlvbj8g
IFdoYXQgZG8gcGVvcGxlIGhhdmUgaW4gcGxhY2UsIGFuZCB3aGF0IGNhbiB3ZQ0KPiBvZCB0bw0K
PiAgICBpbXByb3ZlIGl0Pw0KDQpUaGVyZSdzIGFsc28gYW4gaW50ZXJuYWwgaWRlYSB3ZSBoYWQs
IHdoZXJlIHdlIGNhbiBleHRlbmQgdGhlIElJTyBkdW1teQ0KZHJpdmVyIFtvciBjcmVhdGUgYSBu
ZXcgb25lXSwgdG8gbG9hZCBkYXRhIGFuZCByZWFkLWJhY2sgW2FzIGEgcmVwbGF5IGZvcg0KdXNl
cnNwYWNlXS4NCldlIG5ldmVyIGdvdCB0byBkbyBpdCwgYnV0IHdvdWxkIGJlIGN1cmlvcyBvZiBv
dGhlciBkaWQuDQoNCg0KPiANCj4gOCsgV2hhdCBkbyBvdGhlciBwZW9wbGUgd2FudCB0byB0YWxr
IGFib3V0Pw0KPiANCj4gU29tZSBvZiB0aGVzZSB0b3BpY3MgcHJldHR5IG11Y2ggcmVxdWlyZSBw
YXJ0aWN1bGFyIHBlb3BsZSwgc28gd2UgbWF5IG5vdA0KPiBiZQ0KPiBhYmxlIHRvIGRvIHRoZW0g
dXNlZnVsbHkgdGhpcyB0aW1lLiBOb3RlIHRoZSBhYm92ZSBsaXN0IG1heSB3ZWxsIGJlDQo+IHRv
byBtYW55IHRvcGljcyBhbHJlYWR5IHNvIGNoYW5jZXMgYXJlIHdlIHdvbid0IGdldCB0aHJvdWdo
IGV2ZXJ5dGhpbmcNCj4gcGVvcGxlDQo+IHdhbnQgdG8gdGFsayBhYm91dC4NCj4gDQo+IEFueWhv
dywgdGhvdWdodHM/DQo+IA0KPiBXZSBjYW4gbGVhdmUgdGhlICJ3aGVuIiBxdWVzdGlvbiB1bnRp
bCB3ZSBoYXZlIGFuIGlkZWEgb2Ygd2hldGhlciBpdA0KPiBtYWtlcw0KPiBzZW5zZSB0byBkbyB0
aGlzIGF0IGFsbC4gIA0KPiANCj4gSm9uYXRoYW4NCj4gDQo+IHAucy4gQXMgZXZlciBpZGVhbGx5
IGtlZXAgZGlzY3Vzc2lvbiBvbiBsaXN0IGJ1dCBpZiBhbnlvbmUgd2FudHMgdG8gcmFpc2UNCj4g
YW55dGhpbmcNCj4gcHJpdmF0ZWx5IGZlZWwgZnJlZSB0byBlbWFpbCBtZSBkaXJlY3RseS4NCj4g
DQo=
