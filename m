Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7591B23B4
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 12:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgDUK1A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 06:27:00 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:60316 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728285AbgDUK07 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2020 06:26:59 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LAKtcX021824;
        Tue, 21 Apr 2020 06:26:56 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 30fuabgm36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 06:26:55 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03LANx2H025812;
        Tue, 21 Apr 2020 06:26:55 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0b-00128a01.pphosted.com with ESMTP id 30fuabgm34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 06:26:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJYrMP8IxvGbZLaqlIdQVH1wLhCisPjsslqC3OaDOnJJCsM/iobpNszLcJeKGmc/fPXGbE9HD2zgnaIrYTEszy0iHCbRUQChRAkIdyrzKooU6whY/CaxP1FPDW+LiA1+7PkD60Ac65Akg6/bW6Q+ZeRE1YF/aG4RsEr4HLRUCUXMpxiJ3920TSKcAlbkP01tPG2zW+0WKTEuCyibfA5pX0HOmmoahoLSz+4KDPI9hGZ0RpVOjPtsr3kFuJcat9JTPSzx/GyTfLcLoJLLM83g9ivPvxBJQys6nYVepW6QBmlhgav9jvNoJPhopfYoBRfb6iBZ+61sFlg7Wbx7NqiWAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWEtP2ir7PkVQfiSOJh4lYVPvRrBthCgHOM3OctUkuA=;
 b=mwbY3fDNhbAZcSY5jwVi0sm48XyrnUwn4ZNv8Z2cnbp7fjF0mjAtVjwQfLvlR+AKsieu0UdnyqUKyvf82THvc0vXwCs2D/4yBfn69HsYjUOBpC4LaQi0vJoU8L1hooNS7TsAC5nTbu/OpippozVSFfpmI4pNsr6bxaXFPX0Lv4Gdu/0q0KTmWXr0pp8txRmRPVZloBLqfpgZCy288dFhPBL3df3xVaOnNxfaU1q8YmRKu5RVeij/acXFOQpd7UUnclVPpWes1eWKc4Ybc4Q1NyxRo43Kt7m10vw/mhBJ8J2ymXM+NXo+4h/Y9Fsq/gdjHcpBNXd2sxMxaOugsnbYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWEtP2ir7PkVQfiSOJh4lYVPvRrBthCgHOM3OctUkuA=;
 b=ntjL9+ocljQFeeXKYF5w9k4EwBZq4n7GXXR1XpRlT96vzGxBB0RRA4raK9MyXd6QjeM2bcg7gqLZcxwe/k23D+b2wR/94EUtSxZA8gp0HkchFSbemjASeS/BdM7vd3r94ATCr/K16gMi0O/ugEACuo5S8yaRTHKtceIRASLYMJg=
Received: from MWHPR03MB3199.namprd03.prod.outlook.com (2603:10b6:301:3f::29)
 by MWHPR03MB3231.namprd03.prod.outlook.com (2603:10b6:301:3f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 10:26:54 +0000
Received: from MWHPR03MB3199.namprd03.prod.outlook.com
 ([fe80::e9db:3ec6:ac32:677e]) by MWHPR03MB3199.namprd03.prod.outlook.com
 ([fe80::e9db:3ec6:ac32:677e%7]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 10:26:54 +0000
From:   "Berghe, Darius" <Darius.Berghe@analog.com>
To:     "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
CC:     "Pop, Cristian" <Cristian.Pop@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [RFC] IIO way of representing device operation range ?
Thread-Topic: [RFC] IIO way of representing device operation range ?
Thread-Index: AQHWE8OUKu+vWQH2D0Wzqo5csS5Weah9CyiAgAZbZ4A=
Date:   Tue, 21 Apr 2020 10:26:53 +0000
Message-ID: <5fcdceb2360500e029ab3174437def939c0134b2.camel@analog.com>
References: <9d9fd2c70f793a9637f581e7ed0574012a3006f9.camel@analog.com>
         <20200417101949.00003770@Huawei.com>
In-Reply-To: <20200417101949.00003770@Huawei.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.119.21.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c321282-b225-426c-0193-08d7e5de8317
x-ms-traffictypediagnostic: MWHPR03MB3231:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR03MB3231CAA11DD08517D374EEC196D50@MWHPR03MB3231.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR03MB3199.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(39860400002)(136003)(346002)(366004)(396003)(376002)(4326008)(26005)(54906003)(86362001)(6506007)(81156014)(5660300002)(36756003)(71200400001)(8936002)(966005)(8676002)(2906002)(6512007)(6486002)(316002)(107886003)(2616005)(186003)(91956017)(66946007)(66476007)(478600001)(66446008)(76116006)(64756008)(66556008)(6916009);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hFj0xaZLvkSw2k1a/HWBp15EnzrAv+ev3e/FJRAr8Fxenn4EsTq9TfxzSVMn8bHncwfJBxurMu02ajUfQ2cVV6bBdpjOLM5veBa/TfFuHSNAFpxwT98XJMC0aaz4kOPCUiERlwx7k4P4txV3CJ4MG4DS6av/NBdO0f7+14Fj3c5WlzpFxoY/gFBMm8y7/BLZ6Hposj2nym5tmxiSXKw+H/H48LhdRrcaqjQ8N86QvkxZnApYhhvhWAFu2zwC0beekITnC69BnS2By08P8mxqF0O08UcomPaG1ATbfJDkBtXq30P8AwPqIHuMXBXOxOWR8h7uJGcppCQSBPcxnycNdq8g22j4SJ05pVAbRO7r3DBpBWhU+3TryOXSe9jchHcIhYgFd2RtaBuh4Qscz11ZPJvRKRMP/zO0a2hgy78Nq+4Xjc4HA8oND/brtxfdhurzlnQ2wBYbtpyzqNePzzPqnov3JO+8Z34nmeENHXsr/123Or9RzaxPvttbDhsJQYn94jVnJve2DBo5BxGyABMNOA==
x-ms-exchange-antispam-messagedata: yYEVKJJqAlGSfd0asIGgaDPy1bAoFerBEb/+mO0DV2ScUUFm9NtL2LLR8GS7e5ttEVmg/+iWoeSNm0m+A6RL6SftchLPkkOVZOrmp7A0RXMEHGjWHpX2YxbEncStwRKlMu4BxyM92avivJVxE0R4ZA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE49ABF59C400E4F9F02F6BC3E8FA470@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c321282-b225-426c-0193-08d7e5de8317
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 10:26:53.8459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IX4xkLh7rtFkrc98GghxcWyplE86T+qxbnKiAuE57JkUVbTHTyrrvkHnIgQiGC2KMUudeiURARYzn+kXjC1pB36JUV3PB1vVLj2XFZU7DM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3231
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_03:2020-04-20,2020-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210082
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDIwLTA0LTE3IGF0IDEwOjE5ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBUaGlzIGlzIHJlYWxseSBhIHF1ZXN0aW9uIHRvIGFkZHJlc3MgaW4gYSB1c2Vyc3BhY2Ug
bGlicmFyeSwgbm90DQo+IGEgdGhlIGxldmVsIG9mIHRoZSBrZXJuZWwgaW50ZXJmYWNlcy4gIFdo
aWxzdCBpdCBtYXkgbG9vayBsb3ZlbHkgYW5kDQo+IGVsZWdhbnQgdG8gZG8gaXQgZG93biBpbiB0
aGUga2VybmVsLCBoYXZpbmcgdHdvIGludGVyZmFjZXMgdG8gdGhlDQo+IHNhbWUNCj4gYmFzaWMg
Y29udHJvbHMgaXMgb2Z0ZW4gYSByZWNpcGUgZm9yIGxvbmcgdGVybSBkaXNhc3Rlci4gIEl0J3Mg
ZmluZQ0KPiBmb3IgdXNlcnNwYWNlIHRvIGl0ZXJhdGUgdGhyb3VnaCBhbGwgdGhlIG9wdGlvbnMg
b2YgZWFjaCBjb250cm9sIGFuZA0KPiBidWlsZCB1cCBhIHNldCBvZiByYW5nZSBwYWlycyBjb21w
bGV0ZSB3aXRoIGhvdyB0byBnZXQgdG8gdGhlbS4gIFdlDQo+IGNvdWxkDQo+IHNpbXBsaWZ5IHRo
aXMgYnkgcHV0dGluZyBwcmVjZWRlbmNlIGludG8gdGhlIEFCSSBkZXNjcmlwdGlvbi4gUmlnaHQN
Cj4gbm93DQo+IEknbSBmYWlybHkgc3VyZSB3ZSBkb24ndCBzYXkgYW55dGhpbmcgb24gdGhhdC4N
Cg0KSGkgSm9uYXRoYW4sIGFuZCB0aGFua3MgZm9yIHRoZSBjb21tZW50cywNCg0KSSBhc3N1bWUg
eW91ciByZWZlciB0byBzY2FsZSBhbmQgb2Zmc2V0IGFzIHRoZSBiYXNpYyBjb250cm9scy4gSW4g
dGhpcw0KY2FzZSwgaGF2aW5nIGEgbmV3IHJhbmdlIG1lbWJlciBpbiBpaW9fY2hhbl9pbmZvX2Vu
dW0gdGhhdCBjb250cm9scw0KYm90aCBzY2FsZSBhbmQgb2Zmc2V0IGF0IHRoZSBzYW1lIHRpbWUg
d291bGQgbWVhbiB0aGF0IHRoZSB3cml0ZV9yYXcNCndvdWxkIG5vdCBuZWVkIHRvIGltcGxlbWVu
dCBkaXJlY3Qgc2V0dGluZyBvZiBzY2FsZSBhbmQgb2Zmc2V0LiBJdA0KY291bGQgcHJvYmFibHkg
ZXZlbiBiZSBlbnN1cmVkIGF0IGNvbXBpbGUgdGltZSB0aGF0IHdyaXRlX3JhdyBmb3Igc2NhbGUN
CmFuZCBvZmZzZXQgYXJlIG5vdCBpbXBsZW1lbnRlZCB3aGVuIHRoZSByYW5nZSBpcyBpbXBsZW1l
bnRlZC4gDQoNClRodXMsIHdyaXRlX3JhdyB3b3VsZCBpbXBsZW1lbnQgb25seSB0aGUgcmFuZ2Ug
KHNldHRpbmcgYm90aCBvZmZzZXQgYW5kDQpzY2FsZSBpbiB0aGUgYmFja2dyb3VuZCksIGFuZCBy
ZWFkX3JhdyB3b3VsZCBpbXBsZW1lbnQgb2Zmc2V0IGFuZCBzY2FsZQ0KdG8gYmUgYWJsZSB0byBy
ZWFkIHRoZW0gYW5kIGRvIHRoZSB0cmFuc2Zvcm0gdG8gcGh5c2ljYWwgdW5pdHMgb2YgdGhlDQpy
YXcgdmFsdWUuDQoNCj4gDQo+IE5vdywgdGhlIGFkZGl0aW9uYWwgcHJvYmxlbSB5b3UgaGF2ZSBo
ZXJlIGlzIHRoYXQgbWF5IHlvdSBoYXZlIHRvDQo+IHRyYW5zaXRpb24NCj4gdGhyb3VnaCBub24g
ZXhpc3RlbnQgc3RhdGVzIHdoaWNoIG1ha2VzIGZvciBhIHNsaWdodGx5IG9kZCB1c2Vyc3BhY2UN
Cj4gaW50ZXJmYWNlLg0KPiBJZiB5b3UgZW5hYmxlIHRoZSBjaGFubmVsIHdoZW4gbm90IGluIGEg
dmFsaWQgc3RhdGUgdGhlbiB0aGF0IGVuYWJsZQ0KPiB3aWxsDQo+IGhhdmUgdG8gZmFpbC4NCg0K
RXhhY3RseSwgYW5kIEkgd291bGQgbGlrZSBpZiBwb3NzaWJsZSB0byBhdm9pZCB0aGF0IGJlY2F1
c2UgaXQgaW1wbGllcw0KY29kZSBpbiBrZXJuZWwgdG8gaGFuZGxlIHRob3NlIHNpdHVhdGlvbnMs
IGFuZCBjb2RlIGluIHVzZXJzcGFjZSB0bw0KaGFuZGxlIGl0IHRvby4NCg0KSSB0aG91Z2h0IG9m
IGEgcmFuZ2UgYXMgYSBzb2x1dGlvbiBidXQgcGxlYXNlIGNvbWUgd2l0aCBvdGhlcg0Kc3VnZ2Vz
dGlvbnMgaWYgeW91IHRoaW5rIHRoaXMgaXMgbm90IGZpdCwgbWF5YmUgc2VlIHRoZSBjaGlwDQpy
ZXF1aXJlbWVudHMgYmVsb3cgZmlyc3QgdG8gZ2V0IGEgYmV0dGVyIGlkZWEuDQoNCj4gDQo+IE9u
ZSByZWFzb24gd2UgaGF2ZSBuZXZlciBnb25lIHRoZXJlIGZvciBEQUNzIGluIHBhcnRpY3VsYXIg
aXMgdGhhdA0KPiBpdHMNCj4gbm90IHVuaGVhcmQgb2YgZm9yIGNoYW5naW5nIHRoZSByYW5nZSB0
byByZXN1bHQgaW4gYnVybnQgdHJhY2tzLiANCj4gSGVuY2UNCj4gdGhpcyBpcyBub3JtYWxseSBj
b25zaWRlcmVkIGEgYm9hcmQgY29uZmlndXJhdGlvbiBxdWVzdGlvbiBhbmQgcHVzaGVkDQo+IHRv
IGRldmljZXRyZWUgb3Igc2ltaWxhci4gIERldmljZXRyZWUgc2hvdWxkIGF0IGxlYXN0IHByb3Zp
ZGUgYSBsaXN0DQo+IG9mDQo+ICdzYWZlJyBsaW1pdHMuDQo+IA0KPiBXaGF0IGlzIHRoZSByZXF1
aXJlbWVudCBkcml2aW5nIHRoaXMgZmxleGliaWxpdHk/DQoNClBsZWFzZSBjaGVjayBBRDU3NzBS
IGRhdGFzaGVldCwgcGFnZSAyOSwgeW91IG1heSBzZWUgd2hlcmUgdGhpcw0KcmVxdWlyZW1lbnQg
Y29tZXMgZnJvbS4gQnV0IHRoaXMgaXMgZGVmaW5pdGVseSBub3QgdGhlIG9ubHkgY2hpcA0KcmVx
dWlyaW5nIHRoaXMsIGl0IGlzIGp1c3QgYSBnb29kIGZpdHRpbmcgZXhhbXBsZS4NCmh0dHBzOi8v
d3d3LmFuYWxvZy5jb20vbWVkaWEvZW4vdGVjaG5pY2FsLWRvY3VtZW50YXRpb24vZGF0YS1zaGVl
dHMvQUQ1NzcwUi5wZGYNCg0KVGhhbmtzIGFuZCBiZXN0IHJlZ2FyZHMsDQpEYXJpdXMgQmVyZ2hl
DQo=
