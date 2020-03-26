Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB10193AB3
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 09:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgCZITy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 04:19:54 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:17764 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727655AbgCZITy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 04:19:54 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02Q8EuJA000897;
        Thu, 26 Mar 2020 04:19:35 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ywfj6xffp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 04:19:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWMRAjnc0635BWOzDM4bLasn8Mbs9GFETpjzgFfixIGhEgpjL7pEZkpd65bhIrQ1KJmizAOCbcS0BU9Rpa5plKkMnoTjC8lYpOXBRDHwWtXiL76iC7vKtb7aLFK2aO/hzNg/k2UK9YsocamzBfChq72wSWyYi/bVJXq2OSb1sCy4i9AWj5CgZ0XY4jUNNsKpITomyooTo4nvSGKCLzjC7cbEaShyncOX4UZy3r3w8/m6ci+uvgkFxwvgObFJeLkfwSghwtgSHXt+5jJlxZrz9iLHz3BNFUSmtR2pFIFrQ0C4R5jGXc49Go28mLKoMMTKRw8lczKzaDK7s/H4gqbKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0BzbdTvq/aBb1hY7flle3JT8MNrE5S1o4mcti9Ypds=;
 b=KSVlYkfAvNj0CqG/b2mlTaMGcemAHfuN5bFOg6Jwiu20lpmVXvB3QmRRfh5ZLRa6O0Pw4NtABxp8SB2KmVJDxTYyJrlawkc9MtbzaUAvGBFvIDnTFsb29Btwz953crFn8CmKIJgAEOSSjNdfq2mlVKVes1LdJDuWtTVMOweCxDPJWjC7/oyLQhTLjtKW4aeiKFwlPq1Uu9yRJDEeXV7+UuKvCl5OzgShYrGFZyOaUbNYE+BXrCLzFI8HJkt7UJlbHg7bOZ0cKocDiLdTjobMoHFtK82V0VucQ1Wq8pCXj4qlXN32FWG8WxzffWcjEW8YM9NoCbHw3TRCCiuZAYaG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0BzbdTvq/aBb1hY7flle3JT8MNrE5S1o4mcti9Ypds=;
 b=ABkhdylqoZw/MfQHJwIiRP+9FpgCiRst0ibS/RcoX9MqZ5Bt3JoO5bTl+E8ZbYiedSaD+5WS4W61t3zU0XAiduCDZRL1DnYUk6/h5fOGtz/iJPS2d8T8wQMV2ZDVvv5N/7nb0/rttqg44a270lpCRD5jV5WV4Efh5sdkQH8r9YU=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4201.namprd03.prod.outlook.com (2603:10b6:5:56::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 08:19:34 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 08:19:34 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "mh12gx2825@gmail.com" <mh12gx2825@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "outreachy-kernel@googlegroups.com" 
        <outreachy-kernel@googlegroups.com>,
        "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 1/4] staging: iio: adc: ad7192: Re-indent enum labels
Thread-Topic: [PATCH v3 1/4] staging: iio: adc: ad7192: Re-indent enum labels
Thread-Index: AQHWAIOyM0GegiihW0G94ym/VoVsuahajoGA
Date:   Thu, 26 Mar 2020 08:19:33 +0000
Message-ID: <0308197b41f1faeac7b0f76b07fcc6d65dc1cfd8.camel@analog.com>
References: <cover.1584904896.git.mh12gx2825@gmail.com>
         <5c6bef6462d135b748f58f8c2645c60234482f52.1584904896.git.mh12gx2825@gmail.com>
In-Reply-To: <5c6bef6462d135b748f58f8c2645c60234482f52.1584904896.git.mh12gx2825@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 490ce086-e508-44a3-3cf7-08d7d15e6a86
x-ms-traffictypediagnostic: DM6PR03MB4201:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB4201D1FBEF5DDF3A3F5EFD61F9CF0@DM6PR03MB4201.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(366004)(136003)(376002)(81166006)(81156014)(8676002)(316002)(186003)(6506007)(71200400001)(2616005)(6512007)(66476007)(66556008)(26005)(66946007)(64756008)(76116006)(66446008)(6486002)(91956017)(2906002)(7416002)(86362001)(478600001)(54906003)(110136005)(8936002)(5660300002)(4326008)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4201;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QXqmwUhDIDBCvMOJxSQKLqm3hmZ9AhoeG1T4Zph1v0cjPgtTE8Ri+snebr6RPOSPneUJQ42GgUC8wKA11nIgX4XvZ3nRmsJSJ37x7r4Q3CAub1ADeDtEdL7OJ/ogfonlta7Yih+jY/xHfjK+gd4NSaSYFCrRR/eUZso2JeBEeTS8wGKghdnhATsOcXZmgeMNY7qkdh19WLNo3jRQQBuHfnsqCws9w+Nbz2H2vLgHrKjx2kJtWwgQgA/veHWBmM49NcDh7VBLjM/6l04jcdWja7zkRfQg9f7qg5vFlsPCT2KbRlPlFNY649A+PpgNvrJ2u1OpRbZhxR8pgyOUy9bQ7w7kgCREk/2T9nDfoagDHTU5L1paoV1JscDWWfS1Mdbh+Jyty4NFAXkDT7V+iJOjva7NXO0NUv/IUc0K7ES1mVOUmaziDC+qUDDZN8+XwixH
x-ms-exchange-antispam-messagedata: PUsceZ/ZC9CQHGtirM7c1kYFzQHlvVYEB8ETKcby9h7c1XjspHNmM0pC9JTdW56c4kiLpuhtR1dvb6rjMm10BGK32VfEnmEChR6nkhtQhiTg7MBV0Ays/NixV6+0zJIT72wbV2f7+0pwYPP/DT0Npg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6E6765AA0FC9244A6024110E37D9C51@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490ce086-e508-44a3-3cf7-08d7d15e6a86
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 08:19:33.9648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1H6B0lhSdMAU+3j14z2rJqJgW8p3hYrdEoi5YYRgaIVy2DlnFUOHQMxyG7eyTIdDTZw/brFQH66nQz8mdUu2J6Q9n2r6bHrP+WRUaJMi/BU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4201
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_15:2020-03-24,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=918 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260059
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTAzLTIzIGF0IDAxOjI0ICswNTMwLCBEZWVwYWsgUiBWYXJtYSB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gUmUtaW5kZW50IGVudW0gbGFiZWxzIGFzIHBlciBjb2Rpbmcg
c3R5bGUgZ3VpZGVsaW5lcy4gUHJvYmxlbQ0KPiBkZXRlY3RlZCBieSBjaGVja3BhdGNoIHNjcmlw
dC4NCg0KSXQncyBjdXN0b21hcnkgdG8ga2VlcCB0aGUgcmV2aWV3IHRhZ3MgeW91IHJlY2VpdmUg
ZnJvbSBlYXJsaWVyIHBhdGNoc2V0cyBpbg0KeW91ciBuZXh0IHNldHMuDQpVb3UgY2FuIG5vdyBh
ZGQgaXQgW3R5cGljYWxseSBiZWZvcmUgeW91ciBTaWduZWQtb2ZmLWJ5IHRhZ10gc3RhcnRpbmcg
d2l0aCBWMw0KYW5kIG9ud2FyZHMuDQpZb3UgZG9uJ3QgbmVlZCB0byBzZW5kIGEgVjQganVzdCBm
b3IgdGhpcy4NCg0KU28sIEkgYWRkZWQgW2ZvciB0aGlzXToNCg0KUmV2aWV3ZWQtYnk6IEFsZXhh
bmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQoNCg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBEZWVwYWsgUiBWYXJtYSA8bWgxMmd4MjgyNUBnbWFpbC5jb20+DQo+IC0tLQ0K
PiANCj4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4gCS0gTm9uZS4gVmVyc2lvbiBudW1iZXIgaW5jcmVt
ZW50IHRvIGZvbGxvdyBwYXRjaCBzZXJpZXMgdmVyc2lvbi4NCj4gDQo+IENoYW5nZXMgc2luY2Ug
djE6DQo+IAkxLiBTZXBhcmF0ZWQgb3RoZXIgY2hhbmdlIGludG8gYSBzZXBhcmF0ZSBwYXRjaCBh
cyBzdWdnZXN0ZWQgYnkNCj4gCSAgIEdyZWcgS0guDQo+IA0KPiANCj4gIGRyaXZlcnMvaWlvL2Fk
Yy9hZDcxOTIuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYWQ3MTky
LmMgYi9kcml2ZXJzL2lpby9hZGMvYWQ3MTkyLmMNCj4gaW5kZXggOGVjMjhhYThmYThhLi4wMjk4
MWYzZDE3OTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hZDcxOTIuYw0KPiArKysg
Yi9kcml2ZXJzL2lpby9hZGMvYWQ3MTkyLmMNCj4gQEAgLTE1Nyw4ICsxNTcsOCBAQA0KPiAgICov
DQo+ICANCj4gIGVudW0gew0KPiAtICAgQUQ3MTkyX1NZU0NBTElCX1pFUk9fU0NBTEUsDQo+IC0g
ICBBRDcxOTJfU1lTQ0FMSUJfRlVMTF9TQ0FMRSwNCj4gKwlBRDcxOTJfU1lTQ0FMSUJfWkVST19T
Q0FMRSwNCj4gKwlBRDcxOTJfU1lTQ0FMSUJfRlVMTF9TQ0FMRSwNCj4gIH07DQo+ICANCj4gIHN0
cnVjdCBhZDcxOTJfc3RhdGUgew0K
