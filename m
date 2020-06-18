Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F24B1FF33D
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jun 2020 15:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgFRNh4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jun 2020 09:37:56 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:17902 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726940AbgFRNhu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jun 2020 09:37:50 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IDZpbf008796;
        Thu, 18 Jun 2020 09:37:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 31q64v66qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 09:37:18 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05IDbI78012111;
        Thu, 18 Jun 2020 09:37:18 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0b-00128a01.pphosted.com with ESMTP id 31q64v66qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 09:37:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wi7vUDh2+jNggRlSellleP4mLDA7xpXqQQf0qbS/epmLz8syU60vg6MR0xQoEpC7jdTvyimzi1LXfO2zzUDWxUz75oOWO4jDX5DIaUg46ubw48FcB4OPIL63zvDJFZIxrhX61c31TJHOS8aAOAnqVgiROroYuwALlF+gNERQPoXm3okdWoLjZ3qbLs2dOt68CMH7Kuo5o3/3Ye3GLj6hWsJxXQJbKQ4L/Dm2t1LF5xTJiUnDWWpHOdQiZJdooe/YIjYcKLcHlzAcAN5uVzJ7X/jhionREO0la/noTmtULuTKKbVttlpvJPhtjrEGzS7pgisI1RWMqQ/rm+7rE0QwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3P13g6K4bTdeEcTRlBR+Cvm13jVheWucBg5gQ4oKmc=;
 b=jWfmLa7DW5eSgyHczk0A7SDYkSnjpN1hDjm/h1TcsumYZbSYjOy9guqPp+TOe48ODDUCGWbIFnT9OO9KJ92yEV7yX56PJsN2Pc7HITi+2Vr5NiFP75Ejz7DN02RiazLRjxUTY9MMSRyALhDGw++6ZrLbnIWEKcKTzUXpGBbT+nUaFP3XDmp0wcoEZmLMwwkVZ3Ns13+CTs84kLO1FZTf9Ne/dsYU/4tRwdXNpHnRjJ6OkWOPDfDypV4Mq4MQxW0wHCVWmJdY0F2HBQKwIqzUr3N4HxU7PeABnyv/NrmYyCfJouEXJ3ws+MSbNeZElvvqfWqvzBL8cPH7usbv4aC0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3P13g6K4bTdeEcTRlBR+Cvm13jVheWucBg5gQ4oKmc=;
 b=n/RdCNsWj23eP+xw0bnTa4OEY3F4sOiXydJWe9x4DqW3NKh8foiF3rezHK/eU7kWPvp8ov+u8dp9WMOGo17vulIRdGOVc72rxJjNHo/OfUYLXfaJEdsn+5cTQYpMmTfIwTLl5mkmH0Yye6j9Zdn8WjQIDBzNgbnNfhmmj2vPkho=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM5PR03MB3244.namprd03.prod.outlook.com (2603:10b6:4:3e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 13:37:16 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 13:37:16 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Eugen.Hristev@microchip.com" <Eugen.Hristev@microchip.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "songqiang1304521@gmail.com" <songqiang1304521@gmail.com>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>
Subject: Re: [PATCH v2 3/3] iio: remove
 iio_triggered_buffer_postenable()/iio_triggered_buffer_predisable()
Thread-Topic: [PATCH v2 3/3] iio: remove
 iio_triggered_buffer_postenable()/iio_triggered_buffer_predisable()
Thread-Index: AQHWMosiebcsgWLmWUu0dbt01y27SqjCXn4AgAKhWwCAABHOAIAX4hsAgAAEbQCAAYPtgIAACfWA
Date:   Thu, 18 Jun 2020 13:37:16 +0000
Message-ID: <8ae96d9defc521ae3b8ac37ebfc9dd0f5b32cfb3.camel@analog.com>
References: <20200525113855.178821-1-alexandru.ardelean@analog.com>
         <20200525113855.178821-3-alexandru.ardelean@analog.com>
         <20200531164020.765822dc@archlinux>
         <a0253d719a4390f65668789e5fc182ec19355f17.camel@analog.com>
         <20200602095406.00005add@Huawei.com>
         <37ef45f4-9330-86ea-77c1-3138bb88601b@microchip.com>
         <0eeae8e8c2c1a3f21e15c1931bacb197a8245104.camel@analog.com>
         <e17fc5b3-fc6b-5980-7294-6d0a151138da@microchip.com>
In-Reply-To: <e17fc5b3-fc6b-5980-7294-6d0a151138da@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.128.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50e42e9f-d0c8-4667-1b46-08d8138cb726
x-ms-traffictypediagnostic: DM5PR03MB3244:
x-microsoft-antispam-prvs: <DM5PR03MB3244D30B4B72C92D06424BF8F99B0@DM5PR03MB3244.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7QwtWMdMoTHWOA/cIxys7hchpSlCupC5TTunMt5GxviRP8CQEyxhmnT/M2GXoBJq2vmnDwU6ErPEp6sXs0B/EtJPRxV3qfB/psNxr+YtvQlBHbZXUKyRnHwgQe+v5Z/+zJpWZl6/oSPvoHUggGZMO6hR4ceUpmglBXnlrqFSCTwcgfILPdt7pOk3F/us/BN2yLU/tBlhotA6eWjRIyZha5m7m9B3ClNVt/OOtSejFu2zn9CRL92gJWOBdAxPW4qex66OmZm91I+JI01Gb0tRF9HbU99Ln3jY/T56sOMVshII/w9W+r4QY3FUUkCzo1Xer2q66V7HnILEEUKCdg5zrsArBSQTFDhqJa8ENheQ8KvlpdUS0KckPTgfwo8iZZqn1LKGCCNPzgNmjvVadS9V8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(136003)(366004)(376002)(39860400002)(6486002)(2616005)(36756003)(83380400001)(53546011)(6506007)(478600001)(86362001)(71200400001)(8676002)(8936002)(7416002)(186003)(2906002)(26005)(966005)(6512007)(66556008)(66446008)(64756008)(66476007)(54906003)(91956017)(5660300002)(66946007)(110136005)(316002)(4326008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: YqDdnpiBhbirYDWEyHUn0Wyvso3rjq/Lrda7oK/XkmRaGei626pV3KTj3T3F9LpRS4TTVT8vwmXKPGR7SrulUlw4Q89sTmnLJxrVhnA8MmMr/5KQPHAI8PXMPFDdipMo5KRn7tg70DYpkVuqsHQyYvjXCfPW+RlBMMkkY6MOeLEm9rMk2gvhwSc3PtxLJiGt2kRe7EmRg+KK0LeGWUfBk9B+mYcXmXQIJTgD8Vv4np8C9qS6vnVg5/9V7m94gR0LLpP96COkVTbWj7Ce/uPLsA/cBPAG/Rx+sRKAuWhuvriYimjR46FtkHiERAXGswxDnu/pgptE7j1WhYOBJtvoYYAEz5QfsajHv7hOd2GxyzR1S3Bd6TAGdN25Dxe5XBINIIbezAuBveuqMqU4N0tXAVdqFZDC4Un/7i26xfXGxewCsX4RmTcIoSPntNWpiVqv3sZvwocwUr+gDmvjmSgL82ypSd99BFfST4NGxvBDXO0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE7350009A97EB4AB261DEDDD9422AB6@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e42e9f-d0c8-4667-1b46-08d8138cb726
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 13:37:16.0413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fPcnqxsPxdCoP1BbcEhY5rs1bYI8H0B9rDM8Lm/ITEljdQ+KbXda269fvW4wuAucIn0GUWFG3U4cPz2r8yE4J2oCGXL9OPL52RrqqRISk6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3244
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_12:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180104
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTA2LTE4IGF0IDEzOjAxICswMDAwLCBFdWdlbi5IcmlzdGV2QG1pY3JvY2hp
cC5jb20gd3JvdGU6DQo+IE9uIDE3LjA2LjIwMjAgMTY6NTIsIEFyZGVsZWFuLCBBbGV4YW5kcnUg
d3JvdGU6DQo+ID4gT24gV2VkLCAyMDIwLTA2LTE3IGF0IDEzOjM3ICswMDAwLCBFdWdlbi5Icmlz
dGV2QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+ID4gPiBbRXh0ZXJuYWxdDQo+ID4gPiANCj4gPiA+
IE9uIDAyLjA2LjIwMjAgMTE6NTQsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+ID4gPiA+IE9u
IFR1ZSwgMiBKdW4gMjAyMCAwNzo1MDoyMyArMDAwMA0KPiA+ID4gPiAiQXJkZWxlYW4sIEFsZXhh
bmRydSIgPGFsZXhhbmRydS5BcmRlbGVhbkBhbmFsb2cuY29tPiB3cm90ZToNCj4gPiA+ID4gDQo+
ID4gPiA+ID4gT24gU3VuLCAyMDIwLTA1LTMxIGF0IDE2OjQwICswMTAwLCBKb25hdGhhbiBDYW1l
cm9uIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gTW9uLCAyNSBNYXkgMjAyMCAxNDozODo1NSArMDMw
MA0KPiA+ID4gPiA+ID4gQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5h
bG9nLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gRnJvbTogTGFycy1Q
ZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiBUaGlzIHBhdGNoIHNob3VsZCBiZSBzcXVhc2hlZCBpbnRvIHRoZSBmaXJzdCBvbmUsIGFz
IHRoZQ0KPiA+ID4gPiA+ID4gPiBmaXJzdCBvbmUgaXMNCj4gPiA+ID4gPiA+ID4gYnJlYWtpbmcg
dGhlIGJ1aWxkIChpbnRlbnRpb25hbGx5KSB0byBtYWtlIHRoZSBJSU8gY29yZSBmaWxlcw0KPiA+
ID4gPiA+ID4gPiBlYXNpZXINCj4gPiA+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiA+ID4gcmV2aWV3
Lg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTGFycy1QZXRl
ciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IEFsZXhhbmRydSBBcmRlbGVhbiA8DQo+ID4gPiA+ID4gPiA+IGFsZXhhbmRydS5hcmRlbGVhbkBh
bmFsb2cuY29tPg0KPiA+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
RnJpZW5kIHBva2UuICBWZXJzaW9uIGxvZz8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBWZXJzaW9u
IGxvZyBpcyBpbiB0aGUgZmlyc3QgcGF0Y2guDQo+ID4gPiA+ID4gSSB3YXMgd29uZGVyaW5nIGlm
IEkgb21pdHRlZCBpdC4NCj4gPiA+ID4gPiBTZWVtcywgdGhpcyB0aW1lIEkgZGlkbid0LiBCdXQg
SSBhZG1pdCwgaXQgcHJvYmFibHkgd291bGQgaGF2ZQ0KPiA+ID4gPiA+IGJlZW4gYmV0dGVyDQo+
ID4gPiA+ID4gaGVyZS4NCj4gPiA+ID4gQWggZmFpciBlbm91Z2guICBUaGF0IHdvcmtzIGZpbmUg
aWYgdGhlcmUgaXMgYSBjb3ZlciBsZXR0ZXIgYnV0IG5vdA0KPiA+ID4gPiBzbyBtdWNoIGp1c3Qg
cHV0dGluZyB0aGluZ3MgaW4gdGhlIGZpcnN0IHBhdGNoIQ0KPiA+ID4gPiA+ID4gT3RoZXIgdGhh
biB0aGUgd2lzdGZ1bCBjb21tZW50IGJlbG93ICh3aGljaCBJJ20gbm90IGV4cGVjdGluZw0KPiA+
ID4gPiA+ID4geW91IHRvDQo+ID4gPiA+ID4gPiBkbyBhbnl0aGluZyBhYm91dCBidHchKSB3aG9s
ZSBzZXJpZXMgbG9va3MgZ29vZCB0byBtZS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhl
c2UgYXJlIG9idmlvdXNseSBubyBmdW5jdGlvbmFsIGNoYW5nZXMgKEkgdGhpbmspIHNvIGl0J3MN
Cj4gPiA+ID4gPiA+IG9ubHkgcmVhbGx5DQo+ID4gPiA+ID4gPiBwYXRjaCAyIHRoYXQNCj4gPiA+
ID4gPiA+IGNvdWxkIGRvIHdpdGggbW9yZSBleWVzIGFuZCBhY2tzLg0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiBGYXIgYXMgSSBjYW4gdGVsbCB0aGF0IGNhc2UgaXMgZmluZSBhcyB3ZWxsIGJl
Y2F1c2Ugb2YgdGhlDQo+ID4gPiA+ID4gPiBwcm90ZWN0aW9ucw0KPiA+ID4gPiA+ID4gb24gYmVp
bmcgaW4gdGhlIHJpZ2h0IG1vZGUsIGJ1dCBtb3JlIGV5ZXMgb24gdGhhdCB3b3VsZCBiZQ0KPiA+
ID4gPiA+ID4gZ3JlYXQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFNvIGFzc3VtaW5nIHRo
YXQncyBmaW5lLCB3aGF0IGNvbW1pdCBtZXNzYWdlIGRvIHlvdSB3YW50IG1lIHRvDQo+ID4gPiA+
ID4gPiB1c2UgZm9yDQo+ID4gPiA+ID4gPiB0aGUgZnVzZWQgc2luZ2xlIHBhdGNoPw0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IENvbW1pdCBtZXNzYWdlLXdpc2U6IEkgdGhpbmsgdGhlIG1lc3NhZ2Ug
aW4gdGhlIGZpcnN0IGNvbW1pdA0KPiA+ID4gPiA+IHdvdWxkIGJlDQo+ID4gPiA+ID4gbW9zdGx5
IHN1ZmZpY2llbnQuDQo+ID4gPiA+ID4gTm8gaWRlYSB3aGF0IG90aGVyIGRlc2NyaXB0aW9uIHdv
dWxkIGJlIG5lZWRlZC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTbywgbWF5YmUgc29tZXRoaW5n
IGxpa2U6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiA+ID4gLS0tLS0tLQ0K
PiA+ID4gPiA+IEFsbCBkZXZpY2VzIHVzaW5nIGEgdHJpZ2dlcmVkIGJ1ZmZlciBuZWVkIHRvIGF0
dGFjaCBhbmQgZGV0YWNoDQo+ID4gPiA+ID4gdGhlIHRyaWdnZXINCj4gPiA+ID4gPiB0byB0aGUg
ZGV2aWNlIGluIG9yZGVyIHRvIHByb3Blcmx5IHdvcmsuIEluc3RlYWQgb2YgZG9pbmcgdGhpcyBp
bg0KPiA+ID4gPiA+IGVhY2ggYW5kDQo+ID4gPiA+ID4gZXZlcnkgZHJpdmVyIGJ5IGhhbmQgbW92
ZSB0aGlzIGludG8gdGhlIGNvcmUuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQXQgdGhpcyBwb2lu
dCBpbiB0aW1lLCBhbGwgZHJpdmVycyBzaG91bGQgaGF2ZSBiZWVuIHJlc29sdmVkIHRvDQo+ID4g
PiA+ID4gYXR0YWNoL2RldGFjaCB0aGUgcG9sbC1mdW5jdGlvbiBpbiB0aGUgc2FtZSBvcmRlci4N
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGlzIHBhdGNoIHJlbW92ZXMgYWxsIGV4cGxpY2l0IGNh
bGxzIG9mDQo+ID4gPiA+ID4gaWlvX3RyaWdnZXJlZF9idWZmZXJfcG9zdGVuYWJsZSgpDQo+ID4g
PiA+ID4gJiBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKCkgaW4gYWxsIGRyaXZlcnMs
IHNpbmNlIHRoZQ0KPiA+ID4gPiA+IGNvcmUgaGFuZGxlcw0KPiA+ID4gPiA+IG5vdyB0aGUgcG9s
bGZ1bmMgYXR0YWNoL2RldGFjaC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgbW9yZSBwZWN1
bGlhciBjaGFuZ2UgaXMgZm9yIHRoZSAnYXQ5MS1zYW1hNWQyX2FkYycgZHJpdmVyLA0KPiA+ID4g
PiA+IHNpbmNlIGl0J3MNCj4gPiA+ID4gPiBub3Qgb2J2aW91cyB0aGF0IHJlbW92aW5nIHRoZSBo
b29rcyBkb2Vzbid0IGJyZWFrIGFueXRoaW5nKioNCj4gPiA+ID4gPiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4g
PiAtLS0tLS0tDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBMb29rcyBnb29kLg0KPiA+
ID4gPiANCj4gPiA+ID4gPiAqKiBmb3IgdGhlIGNvbW1lbnQgYWJvdXQgJ2F0OTEtc2FtYTVkMl9h
ZGMnLCB3ZSByZWFsbHkgZG8gbmVlZCB0bw0KPiA+ID4gPiA+IGdldCBzb21lDQo+ID4gPiA+ID4g
dGVzdGluZzsgb3RoZXJ3aXNlIHRoaXMgcmlza3MgYnJlYWtpbmcgaXQuDQo+ID4gPiANCj4gPiA+
IEhpLA0KPiA+ID4gDQo+ID4gPiBJIGNhbiB0ZXN0IGl0LCBkbyB3ZSBoYXZlIGFueSBwYXRjaHdv
cmsgc28gSSBjYW4gZWFzaWx5IGRvd25sb2FkIHRoZQ0KPiA+ID4gcGF0Y2hlcyA/DQo+ID4gPiBJ
IGhhdmUgaXNzdWVzIHdoZW4gYXBwbHlpbmcgdGhlbS4NCj4gPiANCj4gPiBJcyB0aGlzIGdvb2Q/
DQo+ID4gDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcGF0Y2gvMTE1Njg3NDMvX187ISFBM05pOENTMHkyWSFzT3ljanl2Yk10VnJf
VURGQnZiMHZkY2Y5T05kaHMwVkJMaFRjdVlPNHFudVptYXptNTM0Mm1SRTJULTExOVNrNy1kNTBB
JCANCj4gPiBTZXJpZXM6DQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1paW8vbGlzdC8/c2VyaWVzPTI5MzE0
MV9fOyEhQTNOaThDUzB5Mlkhc095Y2p5dmJNdFZyX1VERkJ2YjB2ZGNmOU9OZGhzMFZCTGhUY3VZ
TzRxbnVabWF6bTUzNDJtUkUyVC0xMTlUTldpMW1iUSQgDQo+ID4gDQo+ID4gTWFueSB0aGFua3MN
Cj4gPiBBbGV4DQo+IA0KPiBPbiBhdDkxLXNhbWE1ZDItYWRjIGRyaXZlciwgc2FtYTVkMi14cGxh
aW5lZCBib2FyZCwNCj4gVGVzdGVkLWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1p
Y3JvY2hpcC5jb20+DQo+IA0KPiBJIGFwcGxpZWQgYWxsIHRocmVlIHBhdGNoZXMgYW5kIHRlc3Rl
ZCB0b2dldGhlciB3aXRoIHRoZSBvdGhlciBwYXRjaCBvbiANCj4gc2FtYTVkMi1hZGMgZHJpdmVy
Lg0KPiBJdCBsb29rcyB0byBiZSB3b3JraW5nIGZpbmUuIElmIEkgZGlzY292ZXIgc29tZXRoaW5n
IGxhdGVyLCBJIHdpbGwgbGV0IA0KPiB5b3Uga25vdy4NCj4gVGhhbmtzDQoNCkFsc28gdGhhbmtz
IGZyb20gbXkgc2lkZSBmb3IgdGVzdGluZy4NCg0KDQo+IA0KPiA+ID4gVGhhbmtzICENCj4gPiA+
IA0KPiA+ID4gPiBBZ3JlZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhhbmtzLA0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiBKb25hdGhhbg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+
ICAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX3RyaWdnZXJfb3BzDQo+ID4gPiA+ID4gPiA+IGF0
bGFzX2ludGVycnVwdF90cmlnZ2VyX29wcyA9IHsNCj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaWlvL2R1bW15L2lpb19zaW1wbGVfZHVtbXlfYnVmZmVyLmMNCj4gPiA+ID4gPiA+
ID4gYi9kcml2ZXJzL2lpby9kdW1teS9paW9fc2ltcGxlX2R1bW15X2J1ZmZlci5jDQo+ID4gPiA+
ID4gPiA+IGluZGV4IDE3NjA2ZWNhNDJiNC4uOGUxM2M1M2Q0MzYwIDEwMDY0NA0KPiA+ID4gPiA+
ID4gPiAtLS0gYS9kcml2ZXJzL2lpby9kdW1teS9paW9fc2ltcGxlX2R1bW15X2J1ZmZlci5jDQo+
ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2R1bW15L2lpb19zaW1wbGVfZHVtbXlfYnVm
ZmVyLmMNCj4gPiA+ID4gPiA+ID4gQEAgLTk5LDIwICs5OSw2IEBAIHN0YXRpYyBpcnFyZXR1cm5f
dA0KPiA+ID4gPiA+ID4gPiBpaW9fc2ltcGxlX2R1bW15X3RyaWdnZXJfaChpbnQNCj4gPiA+ID4g
PiA+ID4gaXJxLCB2b2lkICpwKQ0KPiA+ID4gPiA+ID4gPiAgICB9DQo+ID4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gPiAgICBzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19idWZmZXJfc2V0dXBfb3Bz
DQo+ID4gPiA+ID4gPiA+IGlpb19zaW1wbGVfZHVtbXlfYnVmZmVyX3NldHVwX29wcyA9IHsNCj4g
PiA+ID4gPiA+ID4gLSAvKg0KPiA+ID4gPiA+ID4gPiAtICAqIGlpb190cmlnZ2VyZWRfYnVmZmVy
X3Bvc3RlbmFibGU6DQo+ID4gPiA+ID4gPiA+IC0gICogR2VuZXJpYyBmdW5jdGlvbiB0aGF0IHNp
bXBseSBhdHRhY2hlcyB0aGUgcG9sbGZ1bmMgdG8NCj4gPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+
ID4gPiA+IHRyaWdnZXIuDQo+ID4gPiA+ID4gPiA+IC0gICogUmVwbGFjZSB0aGlzIHRvIG1lc3Mg
d2l0aCBoYXJkd2FyZSBzdGF0ZSBiZWZvcmUgd2UNCj4gPiA+ID4gPiA+ID4gYXR0YWNoIHRoZQ0K
PiA+ID4gPiA+ID4gPiAtICAqIHRyaWdnZXIuDQo+ID4gPiA+ID4gPiA+IC0gICovDQo+ID4gPiA+
ID4gPiA+IC0gLnBvc3RlbmFibGUgPSAmaWlvX3RyaWdnZXJlZF9idWZmZXJfcG9zdGVuYWJsZSwN
Cj4gPiA+ID4gPiA+ID4gLSAvKg0KPiA+ID4gPiA+ID4gPiAtICAqIGlpb190cmlnZ2VyZWRfYnVm
ZmVyX3ByZWRpc2FibGU6DQo+ID4gPiA+ID4gPiA+IC0gICogR2VuZXJpYyBmdW5jdGlvbiB0aGF0
IHNpbXBsZSBkZXRhY2hlcyB0aGUgcG9sbGZ1bmMgZnJvbQ0KPiA+ID4gPiA+ID4gPiB0aGUNCj4g
PiA+ID4gPiA+ID4gdHJpZ2dlci4NCj4gPiA+ID4gPiA+ID4gLSAgKiBSZXBsYWNlIHRoaXMgdG8g
cHV0IGhhcmR3YXJlIHN0YXRlIGJhY2sgYWdhaW4gYWZ0ZXIgdGhlDQo+ID4gPiA+ID4gPiA+IHRy
aWdnZXINCj4gPiA+ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiA+ID4gLSAgKiBkZXRhY2hlZCBidXQg
YmVmb3JlIHVzZXJzcGFjZSBrbm93cyB3ZSBoYXZlIGRpc2FibGVkIHRoZQ0KPiA+ID4gPiA+ID4g
PiByaW5nLg0KPiA+ID4gPiA+ID4gPiAtICAqLw0KPiA+ID4gPiA+ID4gPiAtIC5wcmVkaXNhYmxl
ID0gJmlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRpc2FibGUsDQo+ID4gPiA+ID4gPiA+ICAgIH07
DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSG1tLiBHdWVzcyB3ZSBzaG91bGQgcHJvYmFi
bHkgJ2ludmVudCcgYSByZWFzb24gdG8gaWxsdXN0cmF0ZQ0KPiA+ID4gPiA+ID4gdGhlIGJ1ZmVy
DQo+ID4gPiA+ID4gPiBvcHMgaW4gdGhlIGR1bW15IGV4YW1wbGUuICBBbnlvbmUgZmVlbGluZyBj
cmVhdGl2ZT8NCj4gPiA+ID4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KPiA+ID4gPiA+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+ID4g
PiA+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gPiA+ID4gaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbF9fOyEhQTNOaThDUzB5MlkhdWxIOTJTM29fSldM
TVFmZzVWQnJGa253Y18tYTBLNUFIcEpCclRFQi1SdFlFcDdQblJKOWpBX0VhY096RlFtYk5JS08t
USQNCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
PiA+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+ID4gbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbF9f
OyEhQTNOaThDUzB5Mlkhc095Y2p5dmJNdFZyX1VERkJ2YjB2ZGNmOU9OZGhzMFZCTGhUY3VZTzRx
bnVabWF6bTUzNDJtUkUyVC0xMTlSV3dNLTFOQSQgDQo+ID4gDQo=
