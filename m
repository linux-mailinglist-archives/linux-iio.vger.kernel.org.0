Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EFD4503E7
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 12:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhKOMCs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 07:02:48 -0500
Received: from mail-bn8nam08on2055.outbound.protection.outlook.com ([40.107.100.55]:26678
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229613AbhKOMCq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Nov 2021 07:02:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHvVfg97WeQnIkZqpWo9rrgHdz+TGaqohaK1CRMl3OJlGKCfVTo527Oxzv7U5FaZlFcXC/U0t1k421KOQSWwjvUGYczZ9Aql0c9WR7kK/BN4r4THrzJwcodFBtAAwj9G+sG3JF5Grsa1+jZDNtmgogvB3Q/tQApUeIhJ0QIH7o9Z2mkn+R++TjixRPTKaxJ3+flFeQtESGvO8Y+FR5HuXlIAoTTqMtLN//iLatLoMvs7iI2gqPSBejmfmUb6TREQfsHe0d+Zp/sQrW5SscIdY+fr8vyLb/NDUKNuutSbGt4Ob8t6al8ttXwPhJ43KX8/I2m2zkYtnxZ581crY4kK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOOyaZ+1whUbLwS8PpaNPAS/kkk1ckOFriXU2f8meWI=;
 b=cLB/pxI2jmCL+GnPMGP2Eqv6JnipfAXBafi4IV1Isj8oPMBRhfw6FSYqWhI2XEs3L3DQnRzmkiXDv/E9znhKaNnyx9GHTdl28ivev1VejGIIZzmJj3AaSST7Kjr6BK7574F3+Oib5imiMYxboBbvb233Hfe7xolQmRpX49HxJ3Zdbr2gGgnbgkxl8pvKS+UTuJ+vYOnXN+LcgXhGVhBygSOA43zm5ij5osxdVnis0ZNqspWaXsxT4OjJnd9+/JEWgu5s+GCVDQWy/Khs3N+XsUuw36QJ/uPRV0serAOD+XF73asUJZUl9Z0gVxua/b4oSURzevpwFGTaEQagRi+y9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOOyaZ+1whUbLwS8PpaNPAS/kkk1ckOFriXU2f8meWI=;
 b=MYJnpRPDBydfUPppINUD3obcYDqYqQap94BDzs57qaXPcjHjdwAKI3c7p2PcuY0odwxaKMxCLrB+cvQZZZNn8ooB3m65RJa/grCHzH6WXQtJW90Z4Ij12pdn+ohzNzP+tBMWzzBp26W9ZaCVETZIL+rzYUddK3ZA96e3uK5sNPU=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by SJ0PR02MB8720.namprd02.prod.outlook.com (2603:10b6:a03:3e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 11:59:48 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad%9]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 11:59:48 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>, git <git@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH v8 2/4] iio: adc: Add Xilinx AMS driver
Thread-Topic: [PATCH v8 2/4] iio: adc: Add Xilinx AMS driver
Thread-Index: AQHX1ORlUCJOSLcFoUKx28Qs+DOPj6wBqhkAgAAm94CAAqS8sA==
Date:   Mon, 15 Nov 2021 11:59:48 +0000
Message-ID: <BY5PR02MB6916142EBF6AE18E49273A94A9989@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211108210509.29870-1-anand.ashok.dumbre@xilinx.com>
 <20211108210509.29870-3-anand.ashok.dumbre@xilinx.com>
 <20211113161724.371e4bcf@jic23-huawei>
 <CAHp75Vfz7zPXg2E=7Q+E-QnvfdHEDv7eFin1srjVZ53PtrMz7g@mail.gmail.com>
In-Reply-To: <CAHp75Vfz7zPXg2E=7Q+E-QnvfdHEDv7eFin1srjVZ53PtrMz7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fb3261b-9621-4f2f-b1fe-08d9a82f6c35
x-ms-traffictypediagnostic: SJ0PR02MB8720:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB872084B5B845EB7449B3DCDEA9989@SJ0PR02MB8720.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VhhM7zeP4rjyRj+CACaSIt7Adb2xv/o0W+QTP1w5NYSh4lzqr2kkx30oQduwWKm+0EBNjpmIxp8y1/NvxQtus2Hbx1LYxaDw0nKjZFH26s+En1dldptbWefgql9iemBiJDm6phfgwCOcuiLFn2zkxfo5Jdl+SsB/MAIf7V9mBEJEyoxOrAZE5R1nVMwVLM9KM1i41ZpRkcICXUkAg8s1h78TcYWYeNBq5A8oda5qiJOL6+zsMRAaI00ReWCdpSDim68zz1GyO3cllnbA2jgHYKbrSz9GFqz1I00ccjYCZg4X3SArtDbyaDFbyIa6aUPr24kqbu2JOZg9dKq4xq6sLg9bnD5Hyq9MLSaT0olDu+Cmh2av5I8Oqfb9HuKMSbfa7JOCoXoKmHNc2IQtMxSdut790EkQ6m58fZfg7lceL3vlcJRZNl+Z9QNvy24f4geCtrE3vX2RY+UpWL0DJNlsWIGuIYm4z4mZPdNdYG6dXoI0sKwLcOSnLKyMdCoOJO4TNGlNJpg1yqGmMowGsN520fnozzXi0fcV67fyaWLe6oEMLsf1H5nQKWejtip8Cbk82InmTdUz61tWHIad70OCc755EAw+TNsRUA4iSTSAtUQXDN4vUhE16OOZ4VZCvWZpnVS9OiM/77LwEj3dzCs7u8sa9a8VkgAd7dtzmhVqCFWeCq/u+s2ipBQ0Y4ORxQmdK2Vp8zi5s4eCGvGOhDwE1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(26005)(6506007)(8936002)(66476007)(8676002)(9686003)(33656002)(7696005)(52536014)(55016002)(76116006)(2906002)(316002)(38100700002)(66946007)(5660300002)(38070700005)(86362001)(122000001)(508600001)(107886003)(66446008)(64756008)(110136005)(54906003)(66556008)(186003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFN3RmlPSDRMdnBGa2Z2SkpnUVBmd1FXcjNtSUZGcDZUY3ZDSmRUTGxTTFkw?=
 =?utf-8?B?cFQwZWZKRjlxTGoxWE9kTTd6UXNsMmhCdDlJODgrcFdZU0xJdExWR245T1ZF?=
 =?utf-8?B?MDdUcVFJUm80ZzJCWW9CbFk3ZlF2Zll5OUZjbGFvVVRxMUhuOTNWSzF1dERW?=
 =?utf-8?B?NnhyaDBNMFBmNGNvNkI2SUR3Qi8zUVg1N3dCMGppS1E3Y0ZSb0EzSDJXVkoy?=
 =?utf-8?B?ZDF5YkQxV3F0QWcvL3N0Y3lqbnQ3R2c0eStLZDlMRTBZZDBibDRhdWZGN1Nn?=
 =?utf-8?B?OWtBR1NHOStHM1NQdGE5cjhvbFUwdGhaY1BhNGh0ZnRSMUJwSHdZNWNoY2hs?=
 =?utf-8?B?aFV3Q3ZkRHVETnNqVjdiWVcvZGhpSjg4aDJOdVdQVWxlQWhVcVBiSXBpaUkz?=
 =?utf-8?B?bGNlZkYrWW40SExMazByVUpGY0NHVmxTaUI4eDlOSFR0QmhEUkZyU05zRXZq?=
 =?utf-8?B?dm52aFJ1ODBubWZFQzlXa3dLVTJHbDJwb0RsN2xHY1pDN1QzN21XeTg0WHho?=
 =?utf-8?B?UWlxVVFZMTN0WnJqRFkxblFXYjBkMUw0WGJiZE9BV296bEppVkhnMXRlL09m?=
 =?utf-8?B?eXRyVTFhSEZnaXc3L0tzNnNCcEtRREwzQWthdEVNLzdvaCs4M2RuczVTc3V1?=
 =?utf-8?B?R0NDbzVGZnl4aVROK2U0cHUxZCtES3hTRE9qRFJtWEtmMHR6UitzVVA0dUlZ?=
 =?utf-8?B?RDU1NjQ2ZXh6Z0xMS1Y3dzRxaWlweHdGN3RvSkU4bVBrYnFzUlFsaU9wbjlv?=
 =?utf-8?B?OWI0enBBdTRueXpCenhKZW5EdmFYampnVzlRKzFkcG1waHNjWFNWODdXRzdj?=
 =?utf-8?B?ci9IcVRtSnJmNlhEeHQvZ3V5UEtrd2RYUlNFT3I1UHZ0NW1GcjRyR2JDS1J5?=
 =?utf-8?B?eFMzZ0VWK2ZTUGdDdysySThsS3VrSXI3OW1RNmc5NnYxN3FZbjI2aHM1d0Fo?=
 =?utf-8?B?YzIwWkJzSE1UQm5VK3VONDR0cllQclNmMm9GUXEzY3Y4bzZrNjRzaHBSZlpQ?=
 =?utf-8?B?aUR1a0lvZmh6STdNZEtRRkIyWG9ua0ZFMlFYWldjZS9SOXpZSGR2dGJjOEdk?=
 =?utf-8?B?ZzNVV0ZvamVWZzhlRjBvRXdRc0FUdWZQNDNJVUVMQWFSYXplTFFld2RxeGNa?=
 =?utf-8?B?bG5MbHdpb0M1MWg5U0xZRExtblBxL0c1WWkwVUhIZGh4Y3AwOG5tSVB2cWRJ?=
 =?utf-8?B?Q2p4dVpNK2dWTGUyZCtMaEZ6TjdLMitrL0RVd1l2L002UUtlcE1NaUtGQjJx?=
 =?utf-8?B?TUk1djYyaVoybEc3SGUwdEZMYkdNYTAxZU90cDk0RXA1SGRLNTNuUkZJa2Ir?=
 =?utf-8?B?czJwVFZuN3c0Vlhhd082WWIrS0pQSlBlY3hvblcvWjM1emQyK1VocURxaEVF?=
 =?utf-8?B?WlhIVDM5enR6Nk5ucjNmai95Z1FWTG1ONHNtT1RmUXFuSEhteE03M3FQYmhL?=
 =?utf-8?B?STdDQmRDUzlaQVdhYSs4RllIb1pBU2JzNUZLMldMMnNtbTU2bmxDcG1XcnZK?=
 =?utf-8?B?c3JPalBUbkVqQzBMMVFpdjU3TVRIZndWYUx6QWxIZVl3QnhYLzdCcitpVVdp?=
 =?utf-8?B?QkoyaG1oczNUYjJNUDVzOFYrVG1yR3ozVnFQTktxTGdaYjcvNFNqcW9ieUtT?=
 =?utf-8?B?S3pOSkJTVk40U0t3R3JDeTdBVHYyekVsYmdNajdoeGs1RWVxNEhpTklac1Jw?=
 =?utf-8?B?eTRGRzRrUGtZbkN6eHNsNi9XRUd3SFp0YWpxNm9ZZmI0OWF3RmhpMllHeTAr?=
 =?utf-8?B?RzFNMWpZYnF2S1pHZUFoSm5nK2pzbHJmVm9VTzJLY1ZYUTJXazgyUzREdGdW?=
 =?utf-8?B?Wm5lc3VXKzgrS1V0VjZ4QjZwVGVLc2ZaQjR2VnlyeVlmSDZxamJwL3ptN3Ir?=
 =?utf-8?B?N0F1cURyNWRJelpDUDVHeHMyVnFRcVhmSmYzTlFoTUMzazg3cEJiYXM3eWJ5?=
 =?utf-8?B?eUY0c1FIekdITTVTL2N4ajN2c0pIMnJGWXhlcHEreWV2bFYyS1lCNmpBNGIw?=
 =?utf-8?B?Rmk4RUR0Qzk5bGZFeXZNdWk1djhyTnlLWXpsYXBWMzZJdnl5TUpQSzFadUV0?=
 =?utf-8?B?V1IvMDY3ZzF0UXprL0ZPZjgrSDA5WkVtRERiZkk0aTlubzJUY1hUbXU5OG9Y?=
 =?utf-8?B?ZDMvVWRiVlA0MHpJOHpmeEhtd2dGdkhnVzVWRnhVWEpGN3RzMGUzclFuMUlO?=
 =?utf-8?Q?dma7dOP8ejGgWq8L2FeIz98=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb3261b-9621-4f2f-b1fe-08d9a82f6c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 11:59:48.0928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U8tzFTPANuBc01T7eKynVTdKdHYaaOBFjcN7Fu7lUAt+bWKkdYq55nTm+u3cFcqZe6WEh4hQGNOWvbajXp272w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8720
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQpIaSBBbmR5LA0KDQpUaGFuayB5b3UgZm9yIHJldmlld2luZyB0aGUgcGF0Y2hlcy4NCiANCj4g
PiA+ICtzdGF0aWMgaW50IGFtc19pbml0X21vZHVsZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2
LCBzdHJ1Y3QNCj4gPiA+ICtmd25vZGVfaGFuZGxlICpucCwNCj4gDQo+IG5wIC0tPiBmd25vZGUN
Cg0KV2lsbCBkby4gDQoNCj4gDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IGlpb19jaGFuX3NwZWMgKmNoYW5uZWxzKSB7DQo+ID4gPiArICAgICBzdHJ1Y3QgYW1zICphbXMg
PSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiA+ID4gKyAgICAgc3RydWN0IGRldmljZSAqZGV2ID0g
aW5kaW9fZGV2LT5kZXYucGFyZW50Ow0KPiANCj4gPiA+ICsgICAgIHN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbm9kZTsNCj4gPiA+ICsgICAgIGludCBudW1fY2hhbm5lbHMgPSAwOw0KPiA+ID4gKyAgICAg
aW50IHJldDsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIG5vZGUgPSB0b19vZl9ub2RlKG5wKTsNCj4g
PiA+ICsgICAgIGlmIChmd25vZGVfcHJvcGVydHlfbWF0Y2hfc3RyaW5nKG5wLCAiY29tcGF0aWJs
ZSIsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAieGxueCx6
eW5xbXAtYW1zLXBzIikgPT0gMCkgew0KPiA+ID4gKyAgICAgICAgICAgICBhbXMtPnBzX2Jhc2Ug
PSBvZl9pb21hcChub2RlLCAwKTsNCj4gPiA+ICsgICAgICAgICAgICAgaWYgKCFhbXMtPnBzX2Jh
c2UpDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTlhJTzsNCj4gPiA+ICsg
ICAgICAgICAgICAgcmV0ID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KGRldiwgYW1zX2lvdW5t
YXAsIGFtcy0NCj4gPnBzX2Jhc2UpOw0KPiA+ID4gKyAgICAgICAgICAgICBpZiAocmV0IDwgMCkN
Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gKw0KPiA+ID4g
KyAgICAgICAgICAgICAvKiBhZGQgUFMgY2hhbm5lbHMgdG8gaWlvIGRldmljZSBjaGFubmVscyAq
Lw0KPiA+ID4gKyAgICAgICAgICAgICBtZW1jcHkoY2hhbm5lbHMgKyBudW1fY2hhbm5lbHMsIGFt
c19wc19jaGFubmVscywNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgIHNpemVvZihhbXNfcHNf
Y2hhbm5lbHMpKTsNCj4gPiA+ICsgICAgICAgICAgICAgbnVtX2NoYW5uZWxzICs9IEFSUkFZX1NJ
WkUoYW1zX3BzX2NoYW5uZWxzKTsNCj4gPiA+ICsgICAgIH0gZWxzZSBpZiAoZndub2RlX3Byb3Bl
cnR5X21hdGNoX3N0cmluZyhucCwgImNvbXBhdGlibGUiLA0KPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ4bG54LHp5bnFtcC1hbXMtcGwiKSA9PSAw
KSB7DQo+ID4gPiArICAgICAgICAgICAgIGFtcy0+cGxfYmFzZSA9IG9mX2lvbWFwKG5vZGUsIDAp
Ow0KPiA+DQo+ID4gSG1tLiBTbyBvZl9pb21hcCgpIGxlYXZlcyB1cyBkZXBlbmRlbnQgb24gZHQg
c3BlY2lmaWMgY2FsbHMuIFdoaWxzdCBpdA0KPiA+IGRvZXNuJ3QgZXhhY3RseSBsb29rIGhhcmQg
dG8gY3JlYXRlIGEgZ2VuZXJpYyB2ZXJzaW9uIGNvdmVyaW5nIGF0DQo+ID4gbGVhc3QgZHQgYW5k
IGFjcGkgSSBkb24nIHRoaW5rIHRoZXJlIGlzIGFuIGVxdWl2YWxlbnQgYWNwaSBmdW5jdGlvbiBj
dXJyZW50bHkNCj4gZGVmaW5lZC4NCj4gPg0KPiA+IEFuZHksIGRvIHlvdSB0aGluayB0aGlzIGlz
IGEgZ29vZCB0aGluZyB0byBhZGQgdG8gdGhlIGdlbmVyaWMgZmlybXdhcmUNCj4gPiBub2RlIGhh
bmRsaW5nPyAgSXQncyBhIGJpdCBzcGVjaWFsaXN0IGFzIG1vc3Qgb2YgdGhlIHRpbWUgdGhpcyB3
aWxsIGJlDQo+ID4gd3JhcHBlZCB1cCBpbiB0aGUgcGxhdGZvcm0gZGV2aWNlIGhhbmRsaW5nIG9y
IHNpbWlsYXIgcmF0aGVyIHRoYW4gYmVpbmcgaW4gYQ0KPiBjaGlsZCBub2RlIGxpa2UgdGhpcy4N
Cj4gDQo+IEkgc2F3IHRoaXMgaXNzdWUgcHJldmlvdXNseSBzb21ld2hlcmUgZWxzZSBhbmQgd2Ug
Y2FuIGRvIHNvbWV0aGluZyBhYm91dA0KPiBpdC4NCj4gQnV0IGZpcnN0IChiZWZvcmUgZ29pbmcg
dG8gQUNQSSBndXRzKSB3ZSBtYXkgaW5kZWVkIGludHJvZHVjZSBhIGJhc2ljDQo+IHNrZWxldG9u
IHVuZGVyIGZ3bm9kZSBBUEkgZm9yIHRoaXMuDQo+IA0KPiBTb21ldGhpbmcgbGlrZQ0KPiANCj4g
dm9pZCBfX2lvbWVtICpmd25vZGVfaW9tYXAoLi4uKQ0KPiB7DQo+ICAgaWYgKGlzX29mX25vZGUo
Zndub2RlKSkNCj4gICAgIHJldHVybiBvZl9pb21hcCgpOw0KPiAgIHJldHVybiBOVUxMOw0KPiB9
DQo+IEVYUE9SVF9TWU1CT0xfR1BMKGZ3bm9kZV9pb21hcCk7DQo+IA0KPiBBdCBsZWFzdCBpdCB3
aWxsIGFsbG93IGRyaXZlcnMgdG8gbWFrZSB0aGVtIHByb3BlcnR5IHByb3ZpZGVyIGFnbm9zdGlj
Lg0KPiANCj4gT2theSwgSSBjaGVja2VkIHRoZSBjdXJyZW50IHZlcnNpb24gb2YgdGhlIEFDUEkg
c3BlY2lmaWNhdGlvbiBhbmQgdGhlDQo+IHByb3Bvc2VkIERUUyBoZXJlLiBXaXRoIGFib3ZlIEFQ
SSBhbmQgc29tZXRoaW5nIGxpa2UNCj4gDQo+IERldmljZSAoQU1TMCkgew0KPiAgIE5hbWUgKF9D
UlMsIC4uLikNCj4gICAuLi4NCj4gICBEZXZpY2UgKFBMTU4pIHsNCj4gICAgIE5hbWUgKF9DUlMs
IC4uLikNCj4gICB9DQo+ICAgRGV2aWNlIChQU01OKSB7DQo+ICAgICBOYW1lIChfQ1JTLCAuLi4p
DQo+ICAgfQ0KPiB9DQo+IA0KPiB3ZSBtYXkgZ2V0IHRoZSByZXNvdXJjZSBmcm9tIHRoZSBjb3Jy
ZXNwb25kaW5nIGZ3bm9kZSdzIF9DUlMgb2JqZWN0DQoNCkp1c3QgdG8gYmUgc3VyZSwgZG8gSSBu
ZWVkIHRvIGRvIGFueXRoaW5nIGZvciB0aGlzIGluIHRoaXMgaXRlcmF0aW9uPw0KDQo+IA0KPiA+
ID4gKyAgICAgICAgICAgICBpZiAoIWFtcy0+cGxfYmFzZSkNCj4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gLUVOWElPOw0KPiANCj4gLi4uDQo+IA0KPiA+ID4gKyAgICAgLyogSW5p
dGlhbGl6ZSBidWZmZXIgZm9yIGNoYW5uZWwgc3BlY2lmaWNhdGlvbiAqLw0KPiA+ID4gKyAgICAg
YW1zX2NoYW5uZWxzID0ga3phbGxvYyhzaXplb2YoYW1zX3BzX2NoYW5uZWxzKSArDQo+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihhbXNfcGxfY2hhbm5lbHMpICsNCj4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKGFtc19jdHJsX2NoYW5uZWxz
KSwgR0ZQX0tFUk5FTCk7DQo+IA0KPiBNYWtlIGEgdXNlIG9mIHNvbWV0aGluZyBmcm9tIG92ZXJm
bG93LmguDQoNCklmIG15IHVuZGVyc3RhbmRpbmcgaXMgcmlnaHQsIEkgbmVlZCB0byB1c2UgY2hl
Y2tfbXVsX292ZXJmbG93Lg0KDQo+IA0KPiANCj4gPiA+ICsgICAgIGlmICghYW1zX2NoYW5uZWxz
KQ0KPiA+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gDQo+IC0tDQo+IFdpdGgg
QmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg0KVGhhbmtzLA0KQW5hbmQNCg==
