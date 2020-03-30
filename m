Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75E4F197F2B
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 16:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgC3O6R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 10:58:17 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:28602 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbgC3O6R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 10:58:17 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UEnfR2000638;
        Mon, 30 Mar 2020 10:58:02 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00128a01.pphosted.com with ESMTP id 3020e6ewwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 10:58:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QufZq+4RiDB1oL3Po3Ji1jThUJ72JUgd24K7Pp7EJbOC1eDcWiXI/iY3eHhb2ezo/lNQ0AeVgAXLcxXvx+PYAaTV1ucLcjMtQv9FfN/nTCkE5dve4vitE9W3jfQfCKmWbUNkj+R0f47o0k2nS2qqJhvFDCsoIJprr06zl59Xp4Ztddx1Tkq6ukd6MBGSFD5fYl6gFjYlNLdXW4WLn2Yt88KwiTBs0awQLZ6bIL1aY01zv6cB9Xq0ZTqChtd+PaZOOK/ikW9V0YsNpIF6aY52CWmDzjMDOYIoi3FGwVxNajCA3CLY47IpHR1G8iVNMJEwNPKdCG1ygV3QFKmg88uysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTMTsSd5KnoUdOs52zGqj3uPPcfTiGo+bJ5adqTNq/k=;
 b=Z6QTNC7OwrmdjS3cwb9d5Cc+NzF9PcdOCVNaudEGg7WcNdlxmdVobf/jkostam3o7w7S+Y0aJhLBA+aS3Owwy6l1fniF38YBgtk+deI/uB3TcXTws696Wm0HEPEgYPOgVOouFeRK2wCAKlGZG4lXTmrQByG01bhc1p+BDYobAYFARDHBSIwxhQ0Gz4hUB48c0q3mb9Q1gxUdT0r6KOx7dZOoSVw95IM5+Z/LbXcAJig1SAMPlwaT6PtkrSahE9wupqCpxMEYB4zIIIAXykfO3+iRoOdSSdT74Ndkxqlht2pDUQLLchAPZZThtskbO+MA5EvD206Pw/cMZPaG43cFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTMTsSd5KnoUdOs52zGqj3uPPcfTiGo+bJ5adqTNq/k=;
 b=pOns0ktka6m5RGmBzG0s5N+SG8NZpZ61YT4BBFBZyGx6/Ze3SZTHExWlKl+14wDPqedMw0ptfN1xM2Nj1VP4AiA7/EoUhapb6vwFvKOPUpe2RERbm4dfnQqlsuk0r6NQGMD7djlxYIk5OATdvntH3+hdkAD0MOumt+eL1yyGKgo=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4921.namprd03.prod.outlook.com (2603:10b6:5:1ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Mon, 30 Mar
 2020 14:58:00 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 14:58:00 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [RFC PATCH 0/3] iio: buffer: add output buffer support for chrdev
Thread-Topic: [RFC PATCH 0/3] iio: buffer: add output buffer support for
 chrdev
Thread-Index: AQHWBqOD0q8YJVXZ0EqDCUepltf6FqhhOe2A
Date:   Mon, 30 Mar 2020 14:58:00 +0000
Message-ID: <b91fd3626a70e0d6d86f067f025e87430b27f5a1.camel@analog.com>
References: <20200330145705.29447-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200330145705.29447-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c468961-fb3a-460e-dad8-08d7d4babd8e
x-ms-traffictypediagnostic: DM6PR03MB4921:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB492159358C1236D0DE23FCE0F9CB0@DM6PR03MB4921.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(346002)(136003)(39860400002)(396003)(366004)(376002)(36756003)(4326008)(66476007)(107886003)(64756008)(66946007)(71200400001)(66556008)(66446008)(110136005)(6512007)(6506007)(478600001)(54906003)(2906002)(316002)(26005)(6486002)(8936002)(2616005)(91956017)(76116006)(8676002)(5660300002)(86362001)(81166006)(81156014)(186003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qm0D/HZszCLUmTYX1Z/VoAZOyGJQK10Wh6xXcPhhDx99kkqyatESjCwM7ZuixWgrO3/Xz8gGTNA/b2OJcyvDfAW3JvtRS79UV7rBsDPENMRrbip25NiFyzDxljrV1sNOtqebcTlxZGQJQUXiy9QOPNRWDq66yhMKf++rRBx7i9f7OEkrQp6S9L+FPS/7Xxr/Crlj0d95cDTLrDF1HQmKilgCOCns01tGCnLMeP9azqHpGqW8QW/aKPdh2PkcM7Cwh6rahidQW7USrkWFUk/j8zUf6zwAe1UztEojUtx2FcpRZsRrshRs8O+J+bNtO3aneS8Ak1agwhFsZcrel4qaFDkYXj+oO2k3n+3pFvXkprQB0Z/Qf0wKOsZFgma8NcKGpedh5AXOcYa9iygkicUXmBsLvz95qBs2LgUCkuXpH2Lmz6kqyY786TalzeQO0hlj
x-ms-exchange-antispam-messagedata: N4bPx7DppZ1D3g7CB1+HlDxzyYQbmCWeVkeqlFnnzSdLFelN+L9BSUwwCGK4UX9zUf+Zv5pIIyI88DydqpLssEqOn8amLEjWaBLvEla1WVTWTaklSqdjo8T24fNvlhOFAKgkDjc7j7K3pDbsoRPLwQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EE6045F3E069A48BC80BF425FB01C13@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c468961-fb3a-460e-dad8-08d7d4babd8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 14:58:00.3627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OpoX1GCuqUXN/5MxonGKbxkwpHVb5P1YXBDD8V083sjqHIu21evMBt9QgFQlYymhJpd84iy7GWMmogHT1SAu0vav7NRznENe23L+QlyvbJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4921
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-30_06:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003300141
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTAzLTMwIGF0IDE3OjU3ICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQoNCkkgZ29vZmVkIE1pY2hhZWwncyBlbWFpbCBvbiB0aGUgZmlyc3QgcnVuLg0KU29ycnkg
Zm9yIHRoZSBzcGFtLg0KDQo+IFtUaGlzIGRlc2NyaXB0aW9uIGlzIGFsc28gcHJlc2VudCBvbiBw
YXRjaCAzLzMsIHRoZXJlIGhhdmUgYmVlbiBzb21lDQo+IGNvc21ldGljIHN0dWZmIHNpbmNlIHRo
YXQgb25lIHRoYXQgSSBkaWQgbm90IHJlbW92ZS4gVGhlc2UgcGF0Y2hlcw0KPiBwcm9iYWJseSB3
b24ndCBtYWtlIGl0IGluIGEgZmluYWwgdmVyc2lvbiwgYnV0IHRoZXkncmUgdGhlcmUgYmVjYXVz
ZQ0KPiBJIGNoYW5nZWQgbXkgbWluZCBhIGZldyB0aW1lcyBhbmQgZ290IHRvIHRoaXMgUkZDXQ0K
PiANCj4gVGhlcmUgaGF2ZSBiZWVuIHNvbWUgb2ZmbGluZSBkaXNjdXNzaW9ucyBhYm91dCBob3cg
dG8gZ28gYWJvdXQgdGhpcy4NCj4gU2luY2UgSSB3YXNuJ3QgaW52b2x2ZWQgaW4gYW55IG9mIHRo
b3NlIGRpc2N1c3Npb25zLCB0aGlzIGtpbmQgb2YgdHJpZXMgdG8NCj4gcmUtYnVpbGQgdGhpbmdz
IGZyb20gdmFyaW91cyBiaXRzLg0KPiBJdCdzIGluY29tcGxldGUgd29yaywgc2luY2UgSSBkb24n
dCBoYXZlIGEgY2xlYXIgaWRlYSBvZiB3aGF0IHRoZQ0KPiBhY2NlcHRlZC9hY2NlcHRhYmxlDQo+
IGFwcHJvYWNoIHdvdWxkIGJlLg0KPiANCj4gMS4gRmlyc3QgYXBwcm9hY2ggaXM6IHdlIGtlZXAg
MSBidWZmZXIgcGVyIGRldmljZSwgYW5kIHdlIG1ha2UgaXQgZWl0aGVyDQo+IGluL291dCwgd2hp
Y2ggbWVhbnMgdGhhdCBmb3IgZGV2aWNlcyB0aGF0IGZvciBkZXZpY2VzIHRoYXQgaGF2ZSBib3Ro
IGluL291dA0KPiAyIGlpb19kZXYgaW5zdGFuY2VzIGFyZSByZXF1aXJlZCwgb3IgYW4gQURDIG5l
ZWRzIHRvIGJlIGNvbm5lY3RlZCBvbiB0aGUgaW4NCj4gcGF0aCBhbmQgYSBEQUMgb24gb3V0LXBh
dGguIFRoaXMgaXMgcHJlZG9taW5hbnRseSBkb25lIGluIHRoZSBBREkgdHJlZS4NCj4gDQo+IDIu
IE9uZSBkaXNjdXNzaW9uL3Byb3Bvc2FsIHdhcyB0byBoYXZlIG11bHRpcGxlIGJ1ZmZlcnMgcGVy
LWRldmljZS4gQnV0IHRoZQ0KPiBkZXRhaWxzIGFyZSB2YWd1ZSBzaW5jZSB0aGV5IHdlcmUgcmVs
YXllZCB0byBtZS4NCj4gT25lIGRldGFpbCB3YXMsIHRvIGhhdmUgaW5kZXhlcyBmb3IgZGV2aWNl
cyB0aGF0IGhhdmUgbW9yZSB0aGFuIDENCj4gYnVmZmVyOg0KPiANCj4gSWlvX2RldmljZVg6DQo+
ICAgICAgICAgYnVmZmVyDQo+ICAgICAgICAgc2Nhbl9lbGVtZW50cw0KPiANCj4gSWlvX2Rldmlj
ZVg6DQo+ICAgICAgICAgQnVmZmVyWQ0KPiAgICAgICAgIHNjYW5fZWxlbWVudHNZDQo+ICAgICAg
ICAgQnVmZmVyWg0KPiAgICAgICAgIHNjYW5fZWxlbWVudHNaDQo+IA0KPiBJIGFtIG5vdCBzdXJl
IGhvdyBmZWFzaWJsZSB0aGlzIGlzIGZvciBhIHNpbmdsZSBjaHJkZXYsIGFzIHdoZW4geW91IGxv
b2sgYXQNCj4gdGhlIGZpbGVvcHMgdGhhdCBnZXQgYXNzaWduZWQgdG8gYSBjaHJkZXYsIGl0IGxv
b2tzIGxpa2UgaXQgY2FuIGhhdmUgYXQNCj4gbW9zdCB0d28gYnVmZmVycyAob25lIGZvciBpbnB1
dCwgb3V0IGZvciBvdXRwdXQpLg0KPiANCj4gTXVsdGlwbGV4aW5nIGlucHV0IGJ1ZmZlcnMgY2Fu
IHdvcmsgKGZyb20gQURDcyksIGJ1dCBkZW11bHRpcGxleGluZyBvdXRwdXQNCj4gYnVmZmVycyBp
bnRvIGEgREFDLCBub3Qgc28gd2VsbC4gRXNwZWNpYWxseSBvbiBhIHNpbmdsZSBjaHJkZXYuDQo+
IA0KPiBRdWVzdGlvbiAxOiBkbyB3ZSB3YW50IHRvIHN1cHBvcnQgbW9yZSB0aGFuIDIgYnVmZmVy
cyBwZXIgY2hyZGV2Pw0KPiANCj4gVGhpcyBpcyB3aGF0IEFESSBjdXJyZW50bHkgaGFzIGluIGl0
J3MgdHJlZSAoYW5kIHdvcmtzKS4NCj4gDQo+IEV4YW1wbGUsIEFEQzoNCj4gICMgbHMgaWlvXDpk
ZXZpY2UzL2J1ZmZlci8NCj4gIGRhdGFfYXZhaWxhYmxlICBlbmFibGUgIGxlbmd0aCAgbGVuZ3Ro
X2FsaWduX2J5dGVzICB3YXRlcm1hcmsNCj4gICMgIGxzIGlpb1w6ZGV2aWNlMy9zY2FuX2VsZW1l
bnRzLw0KPiAgaW5fdm9sdGFnZTBfZW4gIGluX3ZvbHRhZ2UwX2luZGV4ICBpbl92b2x0YWdlMF90
eXBlICBpbl92b2x0YWdlMV9lbiAgaW5fdm9sdGENCj4gZ2UxX2luZGV4ICBpbl92b2x0YWdlMV90
eXBlDQo+IA0KPiBFeGFtcGxlLCBEQUM6DQo+ICAjICBscyBpaW9cOmRldmljZTQvYnVmZmVyLw0K
PiAgZGF0YV9hdmFpbGFibGUgIGVuYWJsZSAgbGVuZ3RoICBsZW5ndGhfYWxpZ25fYnl0ZXMgIHdh
dGVybWFyaw0KPiAgIyBscyBpaW9cOmRldmljZTQvc2Nhbl9lbGVtZW50cy8NCj4gIG91dF92b2x0
YWdlMF9lbiAgICAgb3V0X3ZvbHRhZ2UwX3R5cGUgIG91dF92b2x0YWdlMV9pbmRleCAgb3V0X3Zv
bHRhZ2UyX2VuICAgDQo+ICAgb3V0X3ZvbHRhZ2UyX3R5cGUgIG91dF92b2x0YWdlM19pbmRleA0K
PiAgb3V0X3ZvbHRhZ2UwX2luZGV4ICBvdXRfdm9sdGFnZTFfZW4gICAgb3V0X3ZvbHRhZ2UxX3R5
cGUgICBvdXRfdm9sdGFnZTJfaW5kZXgNCj4gICBvdXRfdm9sdGFnZTNfZW4gICAgb3V0X3ZvbHRh
Z2UzX3R5cGUNCj4gDQo+IFRoZSBkaXJlY3Rpb24gb2YgZWFjaCBlbGVtZW50IGlzIGVuY29kZWQg
aW50byB0aGUgZmlsZW5hbWUgb2YgZWFjaCBjaGFubmVsLg0KPiANCj4gQW5vdGhlciBxdWVzdGlv
biBpczoNCj4gIERvZXMgaXQgbWFrZSBzZW5zZSB0byBoYXZlIG1vcmUgdGhhbiAxICdzY2FuX2Vs
ZW1lbnRzJyBmb2xkZXI/DQo+ICBUaGF0IGlzLCBmb3IgZGV2aWNlcyB0aGF0IHdvdWxkIGhhdmUg
Ym90aCBpbiAmIG91dCBjaGFubmVscy4NCj4gDQo+IEZvciAnYnVmZmVyJyBmb2xkZXJzIEkgd2Fz
IHRoaW5raW5nIHRoYXQgaXQgbWF5IG1ha2Ugc2Vuc2UgdG8gaGF2ZSwNCj4gJ2J1ZmZlcl9pbicg
JiYgJ2J1ZmZlcl9vdXQnLg0KPiANCj4gU28sIG9uZSBpZGVhIGlzOg0KPiANCj4gSWlvX2Rldmlj
ZVg6DQo+ICAgICAgICAgYnVmZmVyX2luDQo+ICAgICAgICAgYnVmZmVyX291dA0KPiAgICAgICAg
IHNjYW5fZWxlbWVudHMNCj4gDQo+IEN1cnJlbnRseSwgdGhpcyBwYXRjaCBraW5kIG9mIGltcGxl
bWVudHMgMiBidWZmZXJzIHBlciBpaW9fZGV2L2NocmRldi4NCj4gQnV0IHRoZSBmb3JtYXQgaXM6
DQo+IA0KPiBJaW9fZGV2aWNlWDoNCj4gICAgICAgICBidWZmZXJfaW4NCj4gICAgICAgICBidWZm
ZXJfb3V0DQo+ICAgICAgICAgc2Nhbl9lbGVtZW50c19pbg0KPiAgICAgICAgIHNjYW5fZWxlbWVu
dHNfb3V0DQo+IA0KPiBPYnZpb3VzbHkgaXQgc2hvdWxkbid0IHdvcmsgYXMtaXMgW2FzIGl0IHdh
c24ndCB0ZXN0ZWRdLCBidXQgYXQgbGVhc3QgZ2l2ZXMNCj4gc29tZSBnbGltcHNlIG9mIHdoZXJl
IHRoaXMgY291bGQgZ28uDQo+IA0KPiAzLiBBIHNpZGUgcXVlc3Rpb24gaXMgYWJvdXQgdGhlICdp
aW9fYnVmZmVyIC0+IHBvbGxxJyBmaWVsZC4gSSB3YXMNCj4gd29uZGVyaW5nIGlmIGl0IHdvdWxk
IG1ha2Ugc2Vuc2UgdG8gbW92ZSB0aGF0IG9uIHRvICdpaW9fZGV2ICBwb2xscScgaWYNCj4gYWRk
aW5nIG11bHRpcGxlIGJ1ZmZlcnMgYXJlIGFkZGVkIHBlci1kZXZpY2UuIEl0IGFsbW9zdCBtYWtl
cyBzZW5zZSB0bw0KPiB1bmlmeSB0aGUgJ3BvbGxxJyBvbiBpbmRpb19kZXYuDQo+IEJ1dCwgaXQg
bG9va3MgYSBiaXQgZGlmZmljdWx0LCBhbmQgd291bGQgcmVxdWlyZSBzb21lIG1vcmUgY2hhbmdl
IFt3aGljaCBpcw0KPiBkb2FibGVdIGlmIGl0IG1ha2VzIHNlbnNlIGZvciB3aGF0ZXZlciByZWFz
b24uDQo+IFRoZSBvbmx5IHJlYXNvbiB0byBkbyBpdCwgaXMgYmVjYXVzZSB0aGUgaWlvX2J1ZmZl
cl9maWxlb3BzIGhhcyBhIC5wb2xsID0NCj4gaWlvX2J1ZmZlcl9wb2xsKCkgZnVuY3Rpb24gYXR0
YWNoZWQgdG8gaXQuIEFkZGluZyBtdWx0aXBsZSBidWZmZXJzIGZvciBhbg0KPiBJSU8gZGV2aWNl
IG1heSByZXF1aXJlIHNvbWUgY29uc2lkZXJhdGlvbiBvbiB0aGUgaWlvX2J1ZmZlcl9wb2xsKCkg
ZnVuY3Rpb24NCj4gYXMgd2VsbC4NCj4gDQo+IEFsZXhhbmRydSBBcmRlbGVhbiAoMyk6DQo+ICAg
aWlvOiBjb3JlOiByZW5hbWUgJ2luZGlvX2Rldi0+YnVmZmVyX2xpc3QnIC0+DQo+ICAgICAnaW5k
aW9fZGV2LT5hY3RpdmVfYnVmZmVycycNCj4gICBpaW86IGJ1ZmZlcjogZXh0ZW5kIHNob3J0LWhh
bmQgdXNlIGZvciAnaW5kaW9fZGV2LT5idWZmZXInDQo+ICAgaWlvOiBidWZmZXI6IGFkZCBvdXRw
dXQgYnVmZmVyIHN1cHBvcnQgZm9yIGNocmRldg0KPiANCj4gIC4uLi9idWZmZXIvaW5kdXN0cmlh
bGlvLWJ1ZmZlci1kbWFlbmdpbmUuYyAgICB8ICAgMyArLQ0KPiAgZHJpdmVycy9paW8vaW5kdXN0
cmlhbGlvLWJ1ZmZlci5jICAgICAgICAgICAgIHwgMjY3ICsrKysrKysrKysrKystLS0tLQ0KPiAg
ZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYyAgICAgICAgICAgICAgIHwgICA1ICstDQo+
ICBpbmNsdWRlL2xpbnV4L2lpby9idWZmZXIuaCAgICAgICAgICAgICAgICAgICAgfCAgIDkgKw0K
PiAgaW5jbHVkZS9saW51eC9paW8vYnVmZmVyX2ltcGwuaCAgICAgICAgICAgICAgIHwgICA3ICsN
Cj4gIGluY2x1ZGUvbGludXgvaWlvL2lpby5oICAgICAgICAgICAgICAgICAgICAgICB8ICAxMiAr
LQ0KPiAgNiBmaWxlcyBjaGFuZ2VkLCAyMjUgaW5zZXJ0aW9ucygrKSwgNzggZGVsZXRpb25zKC0p
DQo+IA0K
