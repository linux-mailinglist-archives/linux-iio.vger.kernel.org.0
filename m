Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53BE7B499B
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2019 10:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388968AbfIQIgQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 04:36:16 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:44974 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388965AbfIQIgQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 04:36:16 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8H8Hei8015813;
        Tue, 17 Sep 2019 04:35:38 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2058.outbound.protection.outlook.com [104.47.44.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v0vu6denx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Sep 2019 04:35:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYd+NqO8BlmYjmAq7qVW0LYvkzizOhGZWYzFz1v5LTD+N+5iCvjh5lqMhMN0DOz9gso860VHAoTaGiN0xrV8y4fsxWQFKfQoIyK1R7bzRbqLdi63xcpAOUJE9AJ3g+rgZ7TZgq4hyY63l1NO5TQ0yd65BEGYMLszHz9cbg9jKUjZwQRLZZybAdUwCMOKb+gdFTiVI44plWd2wJX41ud2S4husXzG69WNNxuNwtxJZPlvth2GeCBqWlb13oA8qjd5Mfhdy/jSS2/0mEQd0n+lg/R2J6E6isnLlraVS3DrHxoqht8NasC2t9OOjbzVcYhZdyZ09n0W1Fi9ExZ1y0Oz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKjuBjJn2TAMbRyZDTxUrnz27zad3WsBtnaYBsi3S+g=;
 b=LZn65V0R4PycJqllK6rtR7w569+2A0URy5amOUdGw06wrmFB4yalUZsItMvLH9yzypVWQULD9F6T6oBq8RsUEt4YDSPwSxhkyEyB5T6ssA9SrBasi9j3BzBLmp4ovNMRtic2jubLCH3rFPwWd5i+QJYmeOcHiCfXLlVNBL4CJQoX6uS9DUfPqNV6UO0tDvNgAOgOC/c+Bju+pGmsafZ3LpcBsy+8rfUQ6EjqNcE7cpvtkyx4vIq/QMyxAyCEMtxka1/fLzYweV/WJu9DavnnTeMbvk5FuCeZaroJ+7iTABW+s01EkaPEcR7HRToLPByzFF9O0/P1zH4+G4RrFS1trQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKjuBjJn2TAMbRyZDTxUrnz27zad3WsBtnaYBsi3S+g=;
 b=3dXeSZZJmc5JqJqiFUgtvYBIJZ4yhjR+WqSsUZMliZBcl6rodtjHypY0z/reSHZ25MpcNDssjfezmLpUWeJcgazArxHMqFIWVfsLQEqYuD+dU9RD6i6nC9vWeIEIQlNWcWS5ErYor499p7fc6DmesvEn030lfaE9QxHVRqJjEO0=
Received: from BY5PR03MB5110.namprd03.prod.outlook.com (52.133.251.151) by
 BY5PR03MB5219.namprd03.prod.outlook.com (10.186.132.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Tue, 17 Sep 2019 08:35:36 +0000
Received: from BY5PR03MB5110.namprd03.prod.outlook.com
 ([fe80::a46a:f74a:47e8:349f]) by BY5PR03MB5110.namprd03.prod.outlook.com
 ([fe80::a46a:f74a:47e8:349f%2]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 08:35:36 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 2/2] dt-bindings: iio: Add ltc2983 documentation
Thread-Topic: [PATCH 2/2] dt-bindings: iio: Add ltc2983 documentation
Thread-Index: AQHVZx1bKth1PPA4rUmLpncidzsqYKcpsv2AgALqaACAAdkLgIAApGQAgAB8y4A=
Date:   Tue, 17 Sep 2019 08:35:35 +0000
Message-ID: <a45cf281470eaccd6dcedfca38e3f020519c1091.camel@analog.com>
References: <20190909144550.164488-1-nuno.sa@analog.com>
         <20190909144550.164488-2-nuno.sa@analog.com> <20190912173046.GA22533@bogus>
         <20190915120750.7a4d3bcd@archlinux>
         <1835e5760ad916b44dca9107c7f6f9b33b605769.camel@analog.com>
         <CAL_JsqJK0UvCsCxxknLRUsx39d_iwGThK9M7ji4a9wvWk_QJiQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJK0UvCsCxxknLRUsx39d_iwGThK9M7ji4a9wvWk_QJiQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f421557-375f-4853-d7db-08d73b4a0313
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BY5PR03MB5219;
x-ms-traffictypediagnostic: BY5PR03MB5219:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BY5PR03MB5219888EC4C0E185F55CEE77998F0@BY5PR03MB5219.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(39860400002)(136003)(189003)(199004)(446003)(91956017)(6916009)(11346002)(7736002)(86362001)(305945005)(71190400001)(71200400001)(66556008)(64756008)(66946007)(6506007)(53546011)(76116006)(66476007)(186003)(66446008)(26005)(1730700003)(4326008)(2501003)(8676002)(8936002)(6116002)(478600001)(476003)(2616005)(966005)(25786009)(14454004)(102836004)(81156014)(81166006)(36756003)(76176011)(2351001)(561944003)(5660300002)(229853002)(6486002)(118296001)(99286004)(6436002)(6246003)(2906002)(54906003)(3846002)(6306002)(316002)(5640700003)(6512007)(14444005)(66066001)(256004)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR03MB5219;H:BY5PR03MB5110.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iDgsQKH51JISH9qdI2/5T5nheZo+zDT4vm2ahqrCChjXI4Gxwef1qu5zK7Wtog6mRX9dUHwQua5oGvG34ocKvdeROJAV7sYxTciRfTg4D84TdsYtbsmRb30lWKQ0wtEIseiLuj2kUwO0f2kUfQRrzdjfwziINgBzlRfl+z8YOtIbZ8AbG6vKch+kF8glLqAl7roOusz+XOtpHMbtyegzJ6hS6mlOicBL75+pe0zpWd/MG5oiXQ11/FERSh9niMgdV7ZVxgdI7Ugu1aUCtXKE8p2vprV8MTV+XuVLtw/AkB4KO6ICXNyxXlO1rnWfR5HrHe9RBf1TLXN/7CbZdNjeZEJ1CIiL3SgtV1m1FBuS3788ZkSmRTuSYmHHh+IvlIfod+rGmdKYpvmPcpmcgfMuHM5JzLKueoaHvAVpOuhSGlQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A924C6F61D8733408F23CA58532A2B33@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f421557-375f-4853-d7db-08d73b4a0313
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 08:35:35.9934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wn5sfe0rPPIhDrd5/du/NH1tStWwv9/e3tScLWgGUNXz5ySqP4NP4ffG179Eo5b65Yu7f1h++5gQtp7ShT7BLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5219
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-17_05:2019-09-11,2019-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909170091
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA5LTE2IGF0IDIwOjA5IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
DQo+IE9uIE1vbiwgU2VwIDE2LCAyMDE5IGF0IDEwOjIwIEFNIFNhLCBOdW5vIDxOdW5vLlNhQGFu
YWxvZy5jb20+IHdyb3RlOg0KPiA+IEhpIFJvYiBhbmQgSm9uYXRoYW4sDQo+ID4gDQo+ID4gU29t
ZSBjb21tZW50cy9xdWVzdGlvbnMgaW5saW5lLg0KPiA+IA0KPiA+IE51bm8gU8OhDQo+ID4gDQo+
ID4gT24gU3VuLCAyMDE5LTA5LTE1IGF0IDEyOjA3ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdy
b3RlOg0KPiA+ID4gT24gRnJpLCAxMyBTZXAgMjAxOSAxNTozNjoyMSArMDEwMA0KPiA+ID4gUm9i
IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gPiANCj4gPiA+ID4gT24gTW9u
LCBTZXAgMDksIDIwMTkgYXQgMDQ6NDU6NTBQTSArMDIwMCwgTnVubyBTw6Egd3JvdGU6DQo+ID4g
PiA+ID4gRG9jdW1lbnQgdGhlIExUQzI5ODMgdGVtcGVyYXR1cmUgc2Vuc29yIGRldmljZXRyZWUg
YmluZGluZ3MuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTnVubyBTw6Eg
PG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgLi4uL2JpbmRp
bmdzL2lpby90ZW1wZXJhdHVyZS9hZGksbHRjMjk4My55YW1sIHwgNDQyDQo+ID4gPiA+ID4gKysr
KysrKysrKysrKysrKysrDQo+ID4gPiA+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNDQz
IGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gPiA+ID4g
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby90ZW1wZXJhdHVyZS9hZGksbHRj
Mjk4Mw0KPiA+ID4gPiA+IC55YW0NCj4gPiA+ID4gPiBsDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
ZGlmZiAtLWdpdA0KPiA+ID4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2lpby90ZW1wZXJhdHVyZS9hZGksbHRjMjkNCj4gPiA+ID4gPiA4My55DQo+ID4gPiA+ID4gYW1s
DQo+ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL3RlbXBl
cmF0dXJlL2FkaSxsdGMyOQ0KPiA+ID4gPiA+IDgzLnkNCj4gPiA+ID4gPiBhbWwNCj4gPiA+ID4g
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMmI0
NjhiM2VkMTc3DQo+ID4gPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gPiA+ICsrKw0KPiA+ID4g
PiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby90ZW1wZXJhdHVyZS9h
ZGksbHRjMjkNCj4gPiA+ID4gPiA4My55DQo+ID4gPiA+ID4gYW1sDQo+ID4gPiA+ID4gQEAgLTAs
MCArMSw0NDIgQEANCj4gPiA+ID4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MA0KPiA+ID4gPiA+ICslWUFNTCAxLjINCj4gPiA+ID4gPiArLS0tDQo+ID4gPiA+ID4gKyRpZDoN
Cj4gPiA+ID4gPiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9paW8vdGVtcGVyYXR1cmUv
YWRpLGx0YzI5ODMueWFtbCMNCj4gPiA+ID4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICt0aXRs
ZTogQW5hbG9nIERldmljZXMgTFRDMjk4MyBNdWx0aS1zZW5zb3IgVGVtcGVyYXR1cmUNCj4gPiA+
ID4gPiBzeXN0ZW0NCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gK21haW50YWluZXJzOg0KPiA+ID4g
PiA+ICsgIC0gTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gPiA+ID4gPiArDQo+ID4g
PiA+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gPiA+ID4gKyAgQW5hbG9nIERldmljZXMgTFRDMjk4
MyBNdWx0aS1TZW5zb3IgRGlnaXRhbCBUZW1wZXJhdHVyZQ0KPiA+ID4gPiA+IE1lYXN1cmVtZW50
IFN5c3RlbQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiBodHRwczovL3d3dy5hbmFsb2cuY29tL21l
ZGlhL2VuL3RlY2huaWNhbC1kb2N1bWVudGF0aW9uL2RhdGEtc2hlZXRzLzI5ODNmYy5wZGYNCj4g
PiA+ID4gPiArDQo+ID4gPiA+ID4gK3Byb3BlcnRpZXM6DQo+ID4gPiA+ID4gKyAgY29tcGF0aWJs
ZToNCj4gPiA+ID4gPiArICAgIGVudW06DQo+ID4gPiA+ID4gKyAgICAgIC0gYWRpLGx0YzI5ODMN
Cj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgcmVnOg0KPiA+ID4gPiA+ICsgICAgbWF4SXRlbXM6
IDENCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgaW50ZXJydXB0czoNCj4gPiA+ID4gPiArICAg
IG1heEl0ZW1zOiAxDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgIGFkaSx0ZW1wZXJhdHVyZS1j
ZWxjaXVzOg0KPiA+ID4gPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gPiA+ID4gKyAgICAgIElm
IHRoaXMgcHJvcGVydHkgaXMgcHJlc2VudCwgdGhlIHRlbXBlcmF0dXJlIGlzDQo+ID4gPiA+ID4g
cmVwb3J0ZWQNCj4gPiA+ID4gPiBpbiBDZWxzaXVzLg0KPiA+ID4gPiA+ICsgICAgdHlwZTogYm9v
bGVhbg0KPiA+ID4gPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiA+ID4gDQo+ID4gPiA+IEl0J3Mg
YSBib29sZWFuLCBub3QgYW4gYXJyYXkgc28gJ21heEl0ZW1zJyBkb2Vzbid0IG1ha2Ugc2Vuc2Uu
DQo+ID4gPiA+IA0KPiA+ID4gPiBSdW5uaW5nICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIHNob3Vs
ZCB0ZWxsIHlvdSB0aGlzLiBZb3UgbWF5DQo+ID4gPiA+IG5lZWQNCj4gPiA+ID4gdG8NCj4gPiA+
ID4gdXBkYXRlIGR0LXNjaGVtYSBpbnN0YWxsIHRob3VnaC4NCj4gPiANCj4gPiBSb2IsIEknbSBo
YXZpbmcgc29tZSBpc3N1ZXMgd2l0aCBgbWFrZSBkdF9iaW5kaW5nX2NoZWNrYC4gSSB1cGRhdGVk
DQo+ID4gZHQtDQo+ID4gc2NoZW1hIGFuZCBJIGdldCB0aGlzIHdoZW4gcnVuIGl0Og0KPiA+IA0K
PiA+IC4uLg0KPiA+ICJydWFtZWwueWFtbC5jb25zdHJ1Y3Rvci5EdXBsaWNhdGVLZXlFcnJvcjog
d2hpbGUgY29uc3RydWN0aW5nIGENCj4gPiBtYXBwaW5nDQo+ID4gICBpbiAiPHVuaWNvZGUgc3Ry
aW5nPiIsIGxpbmUgNCwgY29sdW1uIDENCj4gPiBmb3VuZCBkdXBsaWNhdGUga2V5ICJwYXR0ZXJu
UHJvcGVydGllcyIgd2l0aCB2YWx1ZSAie30iIChvcmlnaW5hbA0KPiA+IHZhbHVlOiAie30iKQ0K
PiA+ICAgaW4gIjx1bmljb2RlIHN0cmluZz4iLCBsaW5lIDExMywgY29sdW1uIDEiDQo+IA0KPiBT
aW1wbHkgZHJvcCBhbGwgYnV0IHRoZSBmaXJzdCAncGF0dGVyblByb3BlcnRpZXMnLiBZb3UgY2Fu
IGhhdmUNCj4gbXVsdGlwbGUgcGF0dGVybnMgdW5kZXIgb25lLg0KPiANCk9rLCBnb3QgaXQuDQo+
ID4gSWYgeW91IHdhbnQsIEkgY2FuIHBhc3RlIHRoZSBjb21wbGV0ZSB0cmFjZWJhY2sgaW4gYSBm
b2xsb3dpbmcNCj4gPiBlbWFpbC4NCj4gPiBIb3dldmVyIEkgY291bGQgdXNlIGBkdC1kb2MtdmFs
aWRhdGUNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL3RlbXBlcmF0
dXJlL2FkaSxsdGMyOTgzLnlhbWxgDQo+ID4gZGlyZWN0bHkgYnkgZG9pbmcgYSBtYW51YWwgY2hh
bmdlIGluIGBkdC1kb2MtdmFsaWRhdGUgYC4gSSBjaGFuZ2VkDQo+ID4gdGhlDQo+ID4gY2FsbCBg
dGVzdHRyZWUgPSBkdHNjaGVtYS5sb2FkKGZpbGVuYW1lLCBsaW5lX251bWJlcj1saW5lX251bWJl
ciwNCj4gPiBkdXBsaWNhdGVfa2V5cz1GYWxzZSlgIHRvIGB0ZXN0dHJlZSA9IGR0c2NoZW1hLmxv
YWQoZmlsZW5hbWUsDQo+ID4gbGluZV9udW1iZXI9bGluZV9udW1iZXIsIGR1cGxpY2F0ZV9rZXlz
PVRydWUpYC4gSXMgdGhpcyBzb21ldGhpbmcNCj4gPiBhbHJlYWR5IGtub3duPyBJIHdvdWxkIG5v
dCBiZSBzdXJwcmlzZWQgaWYgaXQgaXMgc29tZSBwcm9ibGVtIGluIG15DQo+ID4gZW52aXJvbm1l
bnQuIEhvd2V2ZXIsIEkgZXZlbiB0cmllZCB0aGlzIGluIGEgY2xlYW4gZG9ja2VyIGNvbnRhaW5l
cg0KPiA+IGJhc2VkIG9uIHVidW50dSAxOC4wNCBhbmQgZ290IHRoZSBzYW1lIGJlaGF2aW9yLg0K
PiANCj4gWy4uLl0NCj4gDQo+ID4gPiA+ID4gK3BhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ID4gPiA+
ICsgICJecnRkQChbMi05XXwxWzAtOV18MjApJCI6DQo+ID4gPiA+ID4gKyAgICB0eXBlOiBvYmpl
Y3QNCj4gPiA+ID4gPiArICAgIGRlc2NyaXB0aW9uOiBSZXByZXNlbnRzIGEgcnRkIHNlbnNvciB3
aGljaCBpcyBjb25uZWN0ZWQNCj4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+IG9uZSBvZiB0aGUgZGV2
aWNlIGNoYW5uZWxzLg0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAgIHByb3BlcnRpZXM6DQo+
ID4gPiA+ID4gKyAgICAgIHJlZzoNCj4gPiA+ID4gPiArICAgICAgICBkZXNjcmlwdGlvbjogfA0K
PiA+ID4gPiA+ICsgICAgICAgICAgVGhlIGNoYW5uZWwgbnVtYmVyLiBJdCBjYW4gYmUgY29ubmVj
dGVkIHRvIG9uZSBvZg0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IDIwIGNoYW5uZWxzIG9mIHRo
ZSBkZXZpY2UuDQo+ID4gPiA+ID4gKyAgICAgICAgbWluaW11bTogMg0KPiA+ID4gPiA+ICsgICAg
ICAgIG1heGltdW06IDIwDQo+ID4gPiA+ID4gKyAgICAgICAgbWF4SXRlbXM6IDENCj4gPiA+ID4g
DQo+ID4gPiA+IEFzIHRoaXMgaXMgcHJldHR5IG11Y2ggdGhlIHNhbWUgZm9yIGFsbCBjaGlsZCBu
b2RlcywgbWFrZSBhDQo+ID4gPiA+IHBhdHRlcm4NCj4gPiA+ID4gdGhhdA0KPiA+ID4gPiBtYXRj
aGVzIGFsbCBjaGlsZCBub2RlcyBhbmQgcHV0IHRoaXMgdGhlcmUgcmF0aGVyIHRoYW4NCj4gPiA+
ID4gZHVwbGljYXRpbmcNCj4gPiA+ID4gaXQuDQo+ID4gPiA+IFRoZW4geW91IG9ubHkgbmVlZCAn
bWluaW11bTogMicgaW4gdGhlIGNhc2VzIG5lZWRpbmcgdGhhdC4NCj4gPiANCj4gPiBJJ20gbm90
IHN1cmUgSSdtIGZvbGxvd2luZyB5b3VyIHBvaW50IGhlcmUuIFNvIGl0J3MgYmV0dGVyIHRvDQo+
ID4gY2xhcmlmeQ0KPiA+IGl0IGJlZm9yZSBzZW5kaW5nIGEgdjIuIERvIHlvdSBtZWFuIHRvIGFk
ZCBzb21ldGhpbmcgbGlrZToNCj4gPiANCj4gPiBwYXR0ZXJuUHJvcGVydGllczoNCj4gPiAgICJe
KHRoZXJtb2NvdXBsZXxkaW9kZXxydGR8dGhlcm1pc3RvcnxhZGN8cnNlbnNlKUAoWzEtOV18MVsw
LQ0KPiA+IDldfDIwKSQiDQo+IA0KPiBKdXN0ICIuKkAoWzEtOV18MVswLTldfDIwKSQiIGlzIGZp
bmUuDQo+IA0KPiA+ICAgICB0eXBlOiBvYmplY3QNCj4gPiANCj4gPiAgICAgcHJvcGVydGllczoN
Cj4gPiAgICAgICByZWc6DQo+ID4gICAgICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gICAgICAgICAg
VGhlIGNoYW5uZWwgbnVtYmVyLiBJdCBjYW4gYmUgY29ubmVjdGVkIHRvIG9uZSBvZiB0aGUgMjAN
Cj4gPiBjaGFubmVscyBvZiB0aGUgZGV2aWNlLg0KPiA+ICAgICAgICBtaW5pbXVtOiAxDQo+ID4g
ICAgICAgIG1heGltdW06IDIwDQo+ID4gDQo+ID4gQW5kIHRoZW4sIGZvciBpbnN0YW5jZSwgZm9y
IGEgUlREIEkgd291bGQgaGF2ZToNCj4gPiANCj4gPiBwYXR0ZXJuUHJvcGVydGllczoNCj4gPiAg
ICJecnRkQChbMi05XXwxWzAtOV18MjApJCINCj4gDQo+IFlvdSd2ZSBhbHJlYWR5IGRlZmluZWQg
dGhlIHVuaXQtYWRkcmVzcyBmb3JtYXQgYWJvdmUsIHNvICdecnRkQC4qJw0KPiB3b3VsZCBiZSBz
dWZmaWNpZW50IGhlcmUuDQoNCkFjay4NCg0KPiA+ICAgICAuLi4NCj4gPiANCj4gPiAgICAgcHJv
cGVydGllczoNCj4gPiAgICAgICByZWc6DQo+ID4gICAgICAgIG1pbmltdW06IDINCj4gPiANCj4g
PiAgICAgLi4uDQo+ID4gDQo+ID4gV291bGQgdGhpcyBhbHNvIG1ha2Ugc2Vuc2UsIG9yIGl0J3Mg
bm90IHJlYWxseSBuZWNlc3Nhcnk/DQo+IA0KPiBZZXMsIG1ha2VzIHNlbnNlLg0KPiANCj4gPiBw
YXR0ZXJuUHJvcGVydGllczoNCj4gPiAgICJedGhlcm1vY291cGxlQChbMS05XXwxWzAtOV18MjAp
JCINCj4gPiAgICAgdHlwZTogb2JqZWN0DQo+ID4gDQo+ID4gICAgIC4uLg0KPiA+IA0KPiA+ICAg
ICBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgIHJlZzoNCj4gPiAgICAgICAgZGVzY3JpcHRpb246IEZv
ciBkaWZmZXJlbnRpYWwgdGhlcm1vY291cGxlcywgdGhlIG1pbmltdW0gaXMNCj4gPiAyLg0KPiAN
Cj4gV2h5IGRvIHlvdSBoYXZlIGEgY29uc3RyYWludCBpbiBmcmVlIGZvcm0gdGV4dCBoZXJlPw0K
DQpUaGVyZSBhcmUgc2Vuc29ycyAobGlrZSB0aGVybW9jb3VwbGVzKSB3aGljaCBjYW4gYmUgY29u
ZmlndXJlZCBhcw0KZGlmZmVyZW50aWFsIG9yIHNpbmdsZS1lbmRlZC4gRGVwZW5kaW5nIG9uIHRo
YXQgdGhlICdyZWcnIG1pbmltdW0gdmFsdWUNCmlzIDEgb3IgMi4gVGhlIHRleHQgd2FzIG9ubHkg
Z2l2aW5nIGEgKm5vdGUqIG9uIHRoYXQuIEhvd2V2ZXIgSSBndWVzcyBJDQpjYW4ganVzdCBkcm9w
IGl0Lg0KIA0KPiA+ICAgICAuLi4NCj4gPiANCj4gPiBBbSBJIHVuZGVyc3RhbmRpbmcgaXQgY29y
cmVjdGx5Pw0KPiA+ID4gPiA+ICt0aGVybWlzdG9yDQo+ID4gPiA+ID4gKyAgICAgIGFkaSxzZW5z
b3ItdHlwZToNCj4gPiA+ID4gPiArICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiA+ID4gPiA+ICsg
ICAgICAgICAgSWRlbnRpZmllcyB0aGUgdHlwZSBvZiBSVEQgY29ubmVjdGVkIHRvIHRoZQ0KPiA+
ID4gPiA+IGRldmljZS4NCj4gPiA+ID4gPiArICAgICAgICBhbGxPZjoNCj4gPiA+ID4gPiArICAg
ICAgICAgIC0gJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+
ID4gPiA+ID4gKyAgICAgICAgICAtIGVudW06IFsxMCAxMSAxMiAxMyAxNCAxNSAxNiAxN10NCj4g
PiA+ID4gPiArICAgICAgICBtYXhJdGVtczogMQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAg
ICAgYWRpLHJzZW5zZS1oYW5kbGU6DQo+ID4gPiA+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IHwN
Cj4gPiA+ID4gPiArICAgICAgICAgIFBoYW5kbGUgcG9pbnRpbmcgdG8gYSByc2Vuc2Ugb2JqZWN0
IGFzc29jaWF0ZWQNCj4gPiA+ID4gPiB3aXRoDQo+ID4gPiA+ID4gdGhpcyBSVEQuDQo+ID4gPiA+
ID4gKyAgICAgICAgJHJlZjogIi9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3BoYW5k
bGUiDQo+ID4gPiA+ID4gKyAgICAgICAgbWF4SXRlbXM6IDENCj4gPiA+ID4gPiArDQo+ID4gPiA+
ID4gKyAgICAgIGFkaSxzZW5zb3ItY29uZmlnOg0KPiA+ID4gPiA+ICsgICAgICAgIGRlc2NyaXB0
aW9uOiB8DQo+ID4gPiA+ID4gKyAgICAgICAgICBSYXcgdmFsdWUgd2hpY2ggc2V0J3MgdGhlIHNl
bnNvciBjb25maWd1cmF0aW9uLg0KPiA+ID4gPiA+IExvb2sNCj4gPiA+ID4gPiBhdCB0YWJsZSAy
OCBvZiB0aGUNCj4gPiA+ID4gPiArICAgICAgICAgIGRhdGFzaGVldCBmb3IgaG93IHRvIHNldCB0
aGlzIHZhbHVlIGZvciBSVEQncy4NCj4gPiA+ID4gPiArICAgICAgICBhbGxPZjoNCj4gPiA+ID4g
PiArICAgICAgICAgIC0gJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWlu
dDMyDQo+ID4gPiA+ID4gKyAgICAgICAgICAtIGVudW06IFswIDEgNCA1IDggOSAxMCAxMiAxMyAx
NF0NCj4gPiA+ID4gPiArICAgICAgICBtYXhJdGVtczogMQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiArICAgICAgYWRpLGV4Y2l0YXRpb24tY3VycmVudDoNCj4gPiA+ID4gPiArICAgICAgICBkZXNj
cmlwdGlvbjogfA0KPiA+ID4gPiA+ICsgICAgICAgICAgVGhpcyBwcm9wZXJ0eSBjb250cm9scyB0
aGUgbWFnbml0dWRlIG9mIHRoZQ0KPiA+ID4gPiA+IGV4Y2l0YXRpb24NCj4gPiA+ID4gPiBjdXJy
ZW50IGFwcGxpZWQNCj4gPiA+ID4gPiArICAgICAgICAgIHRvIHRoZSBSVEQuIExvb2sgYXQgdGFi
bGUgMjkgb2YgdGhlIGRhdGFzaGVldCBmb3INCj4gPiA+ID4gPiBtb3JlDQo+ID4gPiA+ID4gaW5m
by4NCj4gPiA+IA0KPiA+ID4gQW55IHdheSB3ZSBjYW4gbWFrZSB0aGlzIHJlYWwgdW5pdHM/ICBD
YW4gbGlzdCB2YWxpZCB2YWx1ZSBoZXJlLg0KPiA+IA0KPiA+IEZvciBSVEQncyBhbmQgZGlvZGVz
LCBpdCBpcyBwb3NzaWJsZSB0byBoYXZlIGl0IHdpdGggcmVhbCB1bml0cy4NCj4gPiBIb3dldmVy
LCBmb3IgdGhlcm1pc3RvcnMgaXQncyBub3QgcmVhbGx5IGRvYWJsZSBzaW5jZSwgZm9yDQo+ID4g
aW5zdGFuY2UsDQo+ID4gZm9yIHRoZW0gd2UgaGF2ZSBhbiAiQXV0byBSYW5nZSIgc2V0dGluZy4g
U28sIEkganVzdCB3YW50ZWQgdG8gYmUNCj4gPiBjb25zaXN0ZW50IHRocm91Z2ggYWxsIHNlbnNv
cnMgaGF2aW5nIGV4Y2l0YXRpb24tY3VycmVudA0KPiA+IGNvbmZpZ3VyYXRpb24uDQo+ID4gRG8g
eW91IHByZWZlciB0byBoYXZlIGl0IGluIHJlYWwgdW5pdHMgd2hlcmUgcG9zc2libGU/DQo+IA0K
PiBUaGF0J3MgdGhlIHByZWZlcmVuY2UgaWYgaXQgbWFrZXMgc2Vuc2UuIEkgaGF2ZSBubyBpZGVh
IHdoYXQgYW4gUlREDQo+IGlzDQo+IHRvIGNvbW1lbnQgZnVydGhlci4NCg0KQWNrLiBJIHdpbGwg
Y29tZSB1cCB3aXRoIHNvbWUgcHJvcG9zYWwgZm9yIHRoaXMgb24gdjIuDQoNCj4gUm9iDQoNCg==
