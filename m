Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C781A646B
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 11:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgDMJEk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 05:04:40 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3744 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727814AbgDMJEj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 05:04:39 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03D8tDhi022095;
        Mon, 13 Apr 2020 05:04:38 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-00128a01.pphosted.com with ESMTP id 30b7r5xs7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 05:04:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOxPvJDgiWbSms6O/f68gPaCjAcJvIpvjQqOoRjWswo41KEZfqmiGpgcrUAN8VV22y1H1swFpvqSfNx4GxI+W5nIyvSZAyMd/9ifqd9my3f9PZKDM+Ra8McHXFQrJ3M7dV+bJwK63wJQeDK93n4RAz6mIjo7Ce9pJ1Ro2c8U+oa6GcjkYLtXmrzE2h45MJCcPgESzbHaDE0D7wj1Py1K84O7yieb2Q7a//ks1m7v9SBp1r/arV6BTcuPonX0qPiqjzu83a4pAOb1NTaiKGz/f42xpdat6syyMMLa7ABaA3ABTcHQJM4PMyaCLSj5htFpwWCdgB0/uuf8Ti5Ph3y+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmDCkJs+7SimYbcKpGLmc07jL5U3CrRtCWewaY8k+K4=;
 b=iBq0IS4K9k67AoZqEpcDm4YL18oPF8iFl9y26Qb3Jpw3e7x1ytEJ4VKPcWkEmA4BZueOJmM3MGCiEI/E7nNMOGIzOR3pEIJhkVcv/VkP9EPLC/Jf1cbQc4ijjmhTR/gJhc9bZfCU5xzh3AmHcy6Swi2BXpFJsUCBZ8L0KWy34ckfTLDWIvQjRvNBGdnCvfvttl7iH75uiMvJjyAYQ18V/GWQl9Gi7fYigme+32xb+lJcrn/EGqLzpj4AfaWC3do67OmFk20yFCuR0m45KY/kxOx6nBXV6w6D9pW+vOT4A9BFcGlbhf4ndp8TNqzY3A4FOBg3NGC2ohC7p2eQDM24jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmDCkJs+7SimYbcKpGLmc07jL5U3CrRtCWewaY8k+K4=;
 b=gbluAvcPQgPcgZAA2CwIK4/LXFZoVVNybQ4+ia43YbDCnRNpvvEUQFTBIbH1YguJWe0mwx80nhuVBOsSwh57wGc+IyxYQe+8z+L7JHpbqEQIoLVKUGPHxBuBWNP7LdnGFIlv9zScOrKGr10GRNDpLdRiXR7WphheIgh9/8HKXow=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Mon, 13 Apr
 2020 09:04:36 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 09:04:36 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lars@engebretsen.ch" <lars@engebretsen.ch>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Small error in iio/iio.h
Thread-Topic: Small error in iio/iio.h
Thread-Index: AQHWEW+iMxSXWye9E06y2bYbkQmKf6h2wjuA
Date:   Mon, 13 Apr 2020 09:04:36 +0000
Message-ID: <02c6aff918a4cda27f2f16d852a9e52a81fbce5d.camel@analog.com>
References: <CA+XPV5MX1aH3yMcRmukmOU4cPFL34dFfPoznwxGT6cTeqYSTvg@mail.gmail.com>
In-Reply-To: <CA+XPV5MX1aH3yMcRmukmOU4cPFL34dFfPoznwxGT6cTeqYSTvg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ad6aaab-0d41-4bc0-052c-08d7df89b0d4
x-ms-traffictypediagnostic: DM6PR03MB4555:
x-microsoft-antispam-prvs: <DM6PR03MB45554379BA5A05D9B50CF128F9DD0@DM6PR03MB4555.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(366004)(396003)(39860400002)(346002)(376002)(136003)(66476007)(6506007)(64756008)(66556008)(71200400001)(91956017)(66446008)(2616005)(2906002)(66946007)(76116006)(36756003)(26005)(86362001)(5660300002)(110136005)(6486002)(966005)(8936002)(316002)(81156014)(8676002)(478600001)(6512007)(186003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dBPPLAuCzkEajpUK2MZV1PvYBxxMDHTH6aluyGqPV6sVNjbxV4gEKjWiUg+UeM6tQUxidoeMUekt5+bX6PLTiGZe9wk5R/LkvuiyNLvi6Hae0xk0RyH83oB2xa+cIKg4SX7t4C3KvPR2r9XZlSy/LuyKOqO4n5HUBK2q57Sw/3pj0bmH65m+skIAMnkivShcLVAo5+YPHuzk1AcxwyoSCFB61bx9nuHZGC07JOOJpZSFeQtaG5o+oDq8N/wjmUkPv4ZDfTOZV3h/I+fL7movchAhKF6nE3ZHeyxN5JXQ97xPc9sMlxyTbwlqlDe0xMCIGwUDL9CIXnyJku/KE4r4oA/7HJhW+BJvZDclKEGEONByeSjRXvfBjrgRuxEvSBpX1pwejMXf8R+Y7jUDVGmyBPVNLaQbtHVgWr9vdFfmFdZw+oH/Np0Z5RYAONc2VQgv3HZprCEzqS27SoskoS08xFuY7muYhpHs+ydw0a4wGHiCdhKQ3A8HdJKNEuZauvm8AQK3SKW+Xk080+j7y6FDlA==
x-ms-exchange-antispam-messagedata: is90idlW6vzEO0+gtUldo63cIXpS+WiILg+L7ulW1CsVc93FfLSvdicZmzoQcMnyZSXodwA9fQ44bwadaVouX3zA13pnW0/eKrdzO8ASvQ40qTPly4503If5s09I4zshoHXpNjNw/vVfIkoiUGWaaQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D015E2B6FD4C84CAD35803FF6608C95@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad6aaab-0d41-4bc0-052c-08d7df89b0d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 09:04:36.5423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fwe3dClv68rfZ+wSNn8bE8ytP+Lnfz5N7Avo2QUs2y3IIpQp948BmKAc7ajYLV3Y5kBLeGr4rnMWMb1hA05dUiSicS/wBdkFzgX2Yi2ICNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4555
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_02:2020-04-12,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130079
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTEzIGF0IDEwOjM4ICswMjAwLCBMYXJzIEVuZ2VicmV0c2VuIHdyb3Rl
Og0KPiBIaSBhbGwsDQo+IA0KPiBJIGp1c3QgY2FtZSBhY3Jvc3MgYSBzbWFsbCB0aGluZzogSSB0
aGluayB0aGF0IHRoZXJlIGlzIGFuIGVycm9uZW91cw0KPiBzZW1pY29sb24gYXQgdGhlIGVuZCBv
ZiBsaW5lIDYwMyBpbiBpbmNsdWRlL2xpbnV4L2lpby9paW8uaA0KDQp5ZXA7DQpnb29kIGZpbmQg
OikNCg0KPiANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2lu
Y2x1ZGUvbGludXgvaWlvL2lpby5oP2g9djUuNy1yYzEqbjYwMl9fO0l3ISFBM05pOENTMHkyWSFy
WFIxOXczWERrdXhwZEFZNHRlRE40YlNzZnF2ZWE3U3o1WlcyNkwyVENFZVlod2YxbWdUanQ2M3RJ
cDNYbGQ5b0ZXZ2NnJCANCj4gDQo+IEknbSBjb21wbGV0ZWx5IG5ldyB0byBrZXJuZWwgZGV2ZWxv
cG1lbnQsIHNvIEkgZG9uJ3Qga25vdyB0aGUgcHJvY2VzcyBmb3INCj4gc3VibWl0dGluZyBwYXRj
aGVzLiBNb3Jlb3ZlciwgdGhlIG1hY3JvIHNlZW1zIHRvIGJlIGdvbmUgaW4gZ2l0Oi8vDQo+IGdp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9qaWMyMy9paW8uZ2l0IHNvIG1h
eWJlIHRoZSBpc3N1ZQ0KPiBoYXMgYmVlbiBmaXhlZCBhbHJlYWR5PyBJbiBhbnkgY2FzZSwgSSdk
IGJlIGhhcHB5IHRvIHN1Ym1pdCBhIHBhdGNoIGlmIHRoYXQNCj4gaXMgdGhlIHJpZ2h0IHRoaW5n
IHRvIGRvLiBCdXQgdGhlbiBJJ2QgbmVlZCBhIGJpdCBvZiBoZWxwIHRvIGdldCBzdGFydGVkLg0K
PiANCg0KWW91J3JlIHByb2JhYmx5IGxvb2tpbmcgYXQgdGhlIHdyb25nIGJyYW5jaC4NCkl0J3Mg
YSBnb29kIGlkZWEgdG8gbG9vayBhdCB0aGUgb25lcyB0aGF0IGhhdmUgYmVlbiB1cGRhdGVkIG1v
cmUgcmVjZW50bHkuDQpJdCdzIHN0aWxsIHRoZXJlLg0KDQpDaGVjayAndG9ncmVnJyBvciAndGVz
dGluZycuDQoNCkkgc3VnZ2VzdCBlZGl0aW5nIHRob3NlLg0KTG9vayBmb3IgcGF0dGVybnMgaW4g
dGhlIGNvbW1pdCB0aXRsZSAmIGRlc2NyaXB0aW9ucywgZG9uJ3QgZm9yZ2V0IHRvIGFkZCB5b3Vy
DQpTaWduZWQtb2ZmLWJ5IHRhZyB3aXRoICAnZ2l0IGNvbW1pdCAtcycNCklmIHlvdSB3YW50LCBh
biBpZGVhIGZvciBhIGNvbW1pdCB0aXRsZSB3b3VsZCBiZToNCidpaW86IGNvcmU6IHJlbW92ZSBl
eHRyYSBzZW1pLWNvbG9uIGZyb20gZGV2bV9paW9fZGV2aWNlX3JlZ2lzdGVyKCkgbWFjcm8nDQoN
CkFkZCBhIGNvbW1lbnQgZGVzY3JpYmluZyB0aGUgY2hhbmdlLg0KDQpHZW5lcmF0ZSB0aGUgcGF0
Y2ggd2l0aDoNCmdpdCBmb3JtYXQtcGF0Y2ggSEVBRH4xLi4NCg0KdGhlbiBydW4gLi9zY3JpcHRz
L2dldF9tYWludGFpbmVycy5wbCA8cGF0Y2gtZmlsZT4NCg0KVGhlIG91dHB1dCBzdWdnZXN0cyB3
aGljaCBsaXN0cyB0byB0YXJnZXQuDQpXaGF0IEkgZG8sIGlzIHB1dCBsaXN0cyB3aXRoIC0tdG89
PGxpc3Q+LCBtYWludGFpbmVycyBbb3RoZXIgcGVvcGxlXSB3aXRoIC0tDQpjYz08bWFpbnRhaW5l
cj4gLS1jYz08ZHJpdmVyLWF1dGhvcj4gLS1jYz08b3RoZXItcG90ZW50aWFsbHktaW50ZXJlc3Rl
ZC1wZW9wbGU+DQoNCllvdSBmaXJzdCBuZWVkIHRvIGNvbmZpZ3VyZSBnaXQtZW1haWwgdG8gc2Vu
ZCBlbWFpbHM7IHRoZXJlIHNob3VsZCBiZSBzb21lIGRvY3MNCm9uIHRoZSB3ZWIgYWJvdXQgdGhh
dC4NCg0KTGFzdGx5Og0KZ2l0IHNlbmQtZW1haWwgLS10bz1saW51eC1paW9Admdlci5rZXJuZWwu
b3JnIC0tdG89bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyANCi0tY2M9amljQGtlcm5lbC5v
cmcgPHBhdGNoLWZpbGU+DQoNCg0KVGhhdCdzIHJvdWdobHkgaXQuDQoNCldlIHNob3VsZCBzZWUg
eW91ciBwYXRjaCBvbiB0aGUgbGlzdC4NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlp
by8NCiYNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1paW8vbGlz
dC8NCg0KDQo+IFRoYW5rcywNCj4gTGFycw0K
