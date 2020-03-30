Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B623C1977B2
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 11:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgC3JUg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 05:20:36 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:16252 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727384AbgC3JUg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 05:20:36 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02U9KApi030956;
        Mon, 30 Mar 2020 05:20:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 302wsq28qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 05:20:16 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02U9KGSJ030965;
        Mon, 30 Mar 2020 05:20:16 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0b-00128a01.pphosted.com with ESMTP id 302wsq28qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 05:20:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XP2+hMSlQ9tyzja1W/cBb7TbPT/f04j9RZi5ZiAB0j9VFbWA7LV4Qs0GOzrX6c+L96TmBH4844f4LzxbL8TQC3EtRfuCprnAxK1cWWaDGv0KAWWkpn3Ht28C94lon3f6F6mB/xg3+xcTn3bT1mq8aSfp0wEUcFsYTipxA2WgGBp+SMPg4L1kBik/F9C/VVdSqVsmj1e/i8YFydBMJPNWq+D45ULsBTfbRpH8Sb5ykcEyeTO7SEiVAvB4fgu1/EUT4vi4NGYjqe5N1wwA2nVUGY9EWb5dD8hPnVmHoHR920TyGCuBEAXNfgcKo66JvU6PQWbjgATNVU4KkRgFNdXIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJZDS/4msOTFlJpKAw8VtXnMXb/bw+D1hbcj0riyfqU=;
 b=NVCYIkJ3yZg82lAZHaVlW/LQYEpRLRm5cfKCL+axBwOLsmSvgAnIXhDsWa1xVRDooYrf7KEhxnLMfCqNitbLTDe3CNArlddid9rbAED6Ha37PjDiPB6bRDTE1QD9/upIi+J2v41/CfR3XMWq7AY2BOCsRS2Fe/a+uLqbsn6IBLbi8FcJKjzjpCxaswVFbDxE1Utpf4tkR5x1HYQux5hI74/4EOamHKjKAvenGPCr0twY4/DB8bcm+kYVj8lCoQcJjMzsEu7LBjHhZiY2+BrJoAqkPpU+mzc4eYstGjgG0EN3BCSb+NGyBaNmHNgFq7iyD4AafU6ip6hB2+1gv3LxkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJZDS/4msOTFlJpKAw8VtXnMXb/bw+D1hbcj0riyfqU=;
 b=jwn233uTT7pNk5Rg2uTDZl+H7HLnZDEXTWkwza7Nd+qOw2CCeKf/QCsaXVnbM12VfMINb5qF3mmhKEKqGK6mKHqUu5ufQSMKwY/4ij3ANm9Qd8uQi64zi3K1Vqg/d+sPfx3NaG/cLjDqBOJgPNBQGu5xhJliKHKonOXz5clWrqQ=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3881.namprd03.prod.outlook.com (2603:10b6:5:46::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Mon, 30 Mar
 2020 09:20:14 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 09:20:14 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "rohitsarkar5398@gmail.com" <rohitsarkar5398@gmail.com>
CC:     "stefan.popa@analog.com" <stefan.popa@analog.com>,
        "zhongjiang@huawei.com" <zhongjiang@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 0/2] use DEFINE_DEBUGFS_ATTRIBUTE instead of
 DEFINE_SIMPLE_ATTRIBUTE
Thread-Topic: [PATCH 0/2] use DEFINE_DEBUGFS_ATTRIBUTE instead of
 DEFINE_SIMPLE_ATTRIBUTE
Thread-Index: AQHWBMsRnz1uQziv/0OGb5932xZ32KhfUfcAgAGNSIA=
Date:   Mon, 30 Mar 2020 09:20:13 +0000
Message-ID: <aee10d6bfc5f2fef85d90245304f3e0f368f94ec.camel@analog.com>
References: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
         <20200329103818.2fce9529@archlinux>
In-Reply-To: <20200329103818.2fce9529@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e005a74-eb1e-4caa-a822-08d7d48b8dd2
x-ms-traffictypediagnostic: DM6PR03MB3881:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB3881E8BFADF43BD1757A18C8F9CB0@DM6PR03MB3881.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(376002)(366004)(346002)(396003)(136003)(39860400002)(2906002)(76116006)(66946007)(6512007)(66556008)(110136005)(66476007)(64756008)(54906003)(66446008)(4326008)(966005)(91956017)(6506007)(5660300002)(478600001)(36756003)(316002)(81166006)(2616005)(6486002)(86362001)(81156014)(26005)(8676002)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LPKNAZ+Zi7Cm5/r1FhxTqEWUjsPBn4fH0u2ysTuX0CkP6L3E1E+s/7n1olJ5SPtjE3Ow6vwIVP39Dik31qhenbjomNZXLznvDevnXuCtk8scZW2k9ZHCASxNijWmZ23opvvEkpDMfzaGzXtO+8fqgteIp+uKyigba8hk1mDBttJ6t9R1bDxhhh+EbE7KzvDDBbWn4nX/gHl+mJa5HpaEmAkyx72Xo92b2rUpg5A+RmVKg747Mpv0dBhPB8DjYoKH137MiUlR5TlDK03tXhcQMFl69Wf53Ae7E7CZ3dZFBGMAoM16KyYpHmkQe3XxePxKO8ht5wH/JBtt6xkLLFjXcvmpnHaGVqg/P5NTFFkKzT7/ClUoEijLNupPrqthJpUVzmc59M8FbCPiSLtKpV3VOg79kLhj5gvYlpVZ5tsIgf/WlmSRfG7IzZQ8vjZjsW7I77NF40P1+KmzG5Ex86ZZopFBmCkHnSky/kd3bTXuZQpSBZO+POYE7G/hxbkq5NuB5TcAXrEXdrCNAEeEalHGfA==
x-ms-exchange-antispam-messagedata: rVMYt5LFzuHYvrWyKzdKHGrt3nn3IftMk1lH4WZdRHRyFBSqWExRfw/uP4LVbm36AGwSIpgbyAkxvY8lvX2CrWze75HXCU6UhWpIn1zIhVc8UWs5RZWDfEIaZIJ6CsJ2msAGKu+bzuxvlpA+9XmpLA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D19C2E834FB294791EDA0F4B7F677C4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e005a74-eb1e-4caa-a822-08d7d48b8dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 09:20:13.9601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vl9luL0JUOBAezGCmdfGLTg5H8sz95nE4/TFT1di1YBps776yDNp3ljONtCZyMfTO7RdsnG7KiKFh13dYvkf0XjS6BSD//qtDl6miHBBgag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3881
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-30_01:2020-03-27,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003300089
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTAzLTI5IGF0IDEwOjM4ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBTYXQsIDI4IE1hciAyMDIwIDEyOjA0OjUzICswNTMwDQo+IFJvaGl0IFNhcmthciA8
cm9oaXRzYXJrYXI1Mzk4QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFRoZSBkZWJ1Z2ZzX2Ny
ZWF0ZV9maWxlX3Vuc2FmZSBtZXRob2QgZG9lcyBub3QgcHJvdGVjdCB0aGUgZm9wcyBnaXZlbiB0
bw0KPiA+IGl0IGZyb20gZmlsZSByZW1vdmFsLiBJdCBtdXN0IGJlIHVzZWQgd2l0aCBERUZJTkVf
REVCVUdGU19BVFRSSUJVVEUNCj4gPiB3aGljaCBtYWtlcyB0aGUgZm9wcyBhd2FyZSBvZiB0aGUg
ZmlsZSBsaWZldGltZS4NCj4gPiANCj4gPiBGdXJ0aGVyIHVzaW5nIERFRklORV9ERUJVR0ZTX0FU
VFJJQlVURSBhbG9uZyB3aXRoDQo+ID4gZGVidWdmc19jcmVhdGVfZmlsZV91bnNhZmUgc2lnbmlm
aWNhbnRseSByZWR1Y2VzIHRoZSBvdmVyaGVhZCBpbnRyb2R1Y2VkIGJ5DQo+ID4gZGVidWdmc19j
cmVhdGVfZmlsZSB3aGljaCBjcmVhdGVzIGEgbGlmZXRpbWUgbWFuYWdpbmcgcHJveHkgYXJvdW5k
IGVhY2gNCj4gPiBmb3BzIGhhbmRlZCBpbi4gUmVmZXIgWzFdIGZvciBtb3JlIG9uIHRoaXMuDQo+
ID4gDQo+ID4gRml4ZXMgdGhlIGZvbGxvd2luZyB3YXJuaW5ncyByZXBvcnRlZCBieSBjb2NjaW5l
bGxlOg0KPiA+IGRyaXZlcnMvaWlvL2ltdS8vYWRpczE2NDYwLmM6MTI2OjAtMjM6IFdBUk5JTkc6
IGFkaXMxNjQ2MF9mbGFzaF9jb3VudF9mb3BzDQo+ID4gc2hvdWxkIGJlIGRlZmluZWQgd2l0aCBE
RUZJTkVfREVCVUdGU19BVFRSSUJVVEUNCj4gPiBkcml2ZXJzL2lpby9pbXUvL2FkaXMxNjQ2MC5j
OjEwODowLTIzOiBXQVJOSU5HOiBhZGlzMTY0NjBfcHJvZHVjdF9pZF9mb3BzDQo+ID4gc2hvdWxk
IGJlIGRlZmluZWQgd2l0aCBERUZJTkVfREVCVUdGU19BVFRSSUJVVEUNCj4gPiBkcml2ZXJzL2lp
by9pbXUvL2FkaXMxNjQ2MC5jOjkwOjAtMjM6IFdBUk5JTkc6IGFkaXMxNjQ2MF9zZXJpYWxfbnVt
YmVyX2ZvcHMNCj4gPiBzaG91bGQgYmUgZGVmaW5lZCB3aXRoIERFRklORV9ERUJVR0ZTX0FUVFJJ
QlVURQ0KPiA+IGRyaXZlcnMvaWlvL2ltdS8vYWRpczE2NDAwLmM6Mjc4OjAtMjM6IFdBUk5JTkc6
IGFkaXMxNjQwMF9mbGFzaF9jb3VudF9mb3BzDQo+ID4gc2hvdWxkIGJlIGRlZmluZWQgd2l0aCBE
RUZJTkVfREVCVUdGU19BVFRSSUJVVEUNCj4gPiBkcml2ZXJzL2lpby9pbXUvL2FkaXMxNjQwMC5j
OjI2MTowLTIzOiBXQVJOSU5HOiBhZGlzMTY0MDBfcHJvZHVjdF9pZF9mb3BzDQo+ID4gc2hvdWxk
IGJlIGRlZmluZWQgd2l0aCBERUZJTkVfREVCVUdGU19BVFRSSUJVVEUNCj4gPiANCj4gPiBbMV06
IGh0dHBzOi8vbGlzdHMuZ3QubmV0L2xpbnV4L2tlcm5lbC8yMzY5NDk4DQo+ID4gDQo+ID4gUm9o
aXQgU2Fya2FyICgyKToNCj4gPiAgIGlpbzogaW11OiBhZGlzMTY0MDA6IHVzZSBERUZJTkVfREVC
VUdGU19BVFRSSUJVVEUgaW5zdGVhZCBvZg0KPiA+ICAgICBERUZJTkVfU0lNUExFX0FUVFJJQlVU
RQ0KPiA+ICAgaWlvOiBpbXU6IGFkaXMxNjQ2MDogdXNlIERFRklORV9ERUJVR0ZTX0FUVFJJQlVU
RSBpbnN0ZWFkIG9mDQo+ID4gICAgIERFRklORV9TSU1QTEVfQVRUUklCVVRFDQo+ID4gDQo+ID4g
IGRyaXZlcnMvaWlvL2ltdS9hZGlzMTY0MDAuYyB8IDQgKystLQ0KPiA+ICBkcml2ZXJzL2lpby9p
bXUvYWRpczE2NDYwLmMgfCA2ICsrKy0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiANCj4gSGkgUm9oaXQsDQo+IA0KPiBZb3UndmUg
b3BlbmVkIGEgY2FuIG9mIHdvcm1zIHdpdGggdGhpcyBvbmUuICBUaGVyZSBhcyBhIHByZXZpb3Vz
IHNlcmllcw0KPiBwb3N0ZWQgZG9pbmcgZXhhY3RseSB0aGlzIGNoYW5nZSBiYWNrIGluIDIwMTkg
YnkgWmhvbmcgSmlhbmcgKGNjJ2QpDQo+IA0KPiBBdCB0aGUgdGltZSBJIGRpZCBhIGJpdCBvZiBs
b29raW5nIGludG8gd2h5IHRoaXMgaGFkIGJlZW4gdW5pdmVyc2FsbHkgdGFrZW4NCj4gdXAgY3Jv
c3MgdHJlZSBhbmQgdHVybmVkIG91dCB0aGVyZSBhcmUgc29tZSBwb3RlbnRpYWwgaXNzdWVzLg0K
PiANCj4gQWxleGFuZHJ1IGFkZGVkIGl0IHRvIHRoZSBsaXN0IG9mIHRoaW5ncyB0byB0ZXN0LCBi
dXQgSSBndWVzcyBpdCBnb3QNCj4gYnVyaWVkIHVuZGVyIG90aGVyIHdvcmsgYW5kIGlzIHN0aWxs
IG91dHN0YW5kaW5nLg0KPiANCg0KeWVwDQpteSBiYWQ7DQp3aWxsIHRyeSB0byBtYWtlIHJvb20g
dGhlc2UgZGF5cyBmb3IgdGhhdCBvbGQgb25lDQoNCg0KPiBodHRwczovL2xrbWwub3JnL2xrbWwv
MjAxOS8xMC8zMC8xNDQNCj4gDQo+IEhhcyBHcmVnIEtIIHJhaXNpbmcgdGhlIHBvaW50IHRoYXQg
ZmlsZSByZWZlcmVuY2UgY291bnRpbmcgaXMgY2hhbmdlZCAoYXMgeW91DQo+IG1lbnRpb24pIGJ1
dCB0aGF0IGNhbiBjYXVzZSBzdWJ0bGUgYnVncy4gIEl0ICdtaWdodCcgYmUgZmluZSBidXQgaXMN
Cj4gZGVmaW5pdGVseSBvbmUgdGhhdCBuZWVkcyBhIHRlc3RlZC1ieSBmcm9tIHNvbWVvbmUgd2l0
aCB0aGUgaGFyZHdhcmUuDQo+IA0KPiBKb25hdGhhbg0K
