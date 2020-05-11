Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E67E1CD6A0
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 12:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgEKKdo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 06:33:44 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34196 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728209AbgEKKdn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 May 2020 06:33:43 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BAXLmE014176;
        Mon, 11 May 2020 06:33:30 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-00128a01.pphosted.com with ESMTP id 30wse5mrty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 06:33:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFKCde/T7CwjQvLSFTeDgiOjsbt4Sfa/xSkv5RVtAn2N0N0CS3tRGkRmooze7vnnJ0KuCH06QIWXO/hnAYdqLkek0tlLWEA32yegHO/9Q1WzEgicFcQ8l3hW+/7pyszBdKE24Og4b+Jp8iMap27w9u1s9f+JOzzMcBJVWTsHlm/m2yAbqIybBq7Oxa9an73iDHZMYoLrNDqNtp1zBzlDr8HhMnF6QmAjQGtPU4q4PJHVEAIoZY7/BE9QovsW41topL55qLM+vFBwj2Dw0Hhs1AppMiHxwz3yRbWXp4Rm4gDO5r1AfTVXML9q+2pfV3fTsHEpI34biH2UFnWlfMNZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8/iqPCyEUADWut212s1nU9rVL+RWZkPO1NDExlHElo=;
 b=Ith7/Z2AjTM5s8zeUztmMVW+GSy4juZvQ/Nc0bGKBF7w1w8bsuA0iT8N6IQFzKeQbInVS3gZiAzeGvDkg3hZZd30rYqrBqN4kqboapIlhPIDd7jcWOVDYrUgJ5JrPl37Z6lTzVgWXqRXu4xyQhkWP9udOQe5TM4eBu/vuTkaSptW5V09BV9cV4A8fozVUzM2DRTP39aX3nxqmfgzM8EG/oeTunHdHRJMIqyz5PfkZ9M3lqlPn5GcCWk4bsRNNDiLVvry36MT2mPPim7ItRnsFRfZ9KR4gpW5FBfF1CAbYix86ouiz3kABzjFSOVpEk6BqYzoVy7jhLtM7fuInPdwhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8/iqPCyEUADWut212s1nU9rVL+RWZkPO1NDExlHElo=;
 b=rI9NEvb7fo8Db5IbDfoX6nbI2jmkmGw2/6r2C/ddveaoHLMVXusbK2rpI48cFE3SXo1oMgs+knarfdblDvxZPP3jOopfbkVUb4Lgi/sVv9R3RjH/0IiV7QYZqUNAt+0m/zOZg9HJ3PR6EHV/eDqLuvMRvuJVowIjKtq5nFJVoA4=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4537.namprd03.prod.outlook.com (2603:10b6:5:10b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Mon, 11 May
 2020 10:33:28 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 10:33:28 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH 00/14] iio: buffer: add support for multiple buffers
Thread-Topic: [RFC PATCH 00/14] iio: buffer: add support for multiple buffers
Thread-Index: AQHWJUAdPxP6vzcVf0GdP2M4m7Jctaifc8QAgAGoDQCAAZjjAA==
Date:   Mon, 11 May 2020 10:33:27 +0000
Message-ID: <8c5d9ef5ed4ea9037c5459daa2044d1cd7c5db7a.camel@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
         <a9a47e84-b933-cca6-dcfb-d97a51c8bdd4@metafoo.de>
         <20200510110958.29046a18@archlinux>
In-Reply-To: <20200510110958.29046a18@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75029b86-7c2a-4f33-3c1a-08d7f596be32
x-ms-traffictypediagnostic: DM6PR03MB4537:
x-microsoft-antispam-prvs: <DM6PR03MB4537CA2E7910109139B0CFFAF9A10@DM6PR03MB4537.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PwAvsYXU5dTTBT31lFArEekft575RM1W87CcUSgMEdnOF+NDev9a9pWDxwbNEcDEv/mdd4YMQ4oX4VP42qf/68SPTgVq0uMitnFZ3dpCsfhHl+Ka3GAGUdvq5vRm+5/fhrrhgeV64cT5moYpuQxZVMZVEW+MGVMZCDHAlVq3K+9krg31WTzDS481TFpzmomokU4SQgzHEe3OrHzH5gANEtFC1B66nsnxeoEavDJpVupJRgdnt/G1lduIpkrMJErBEp0+P6VBmAWYYl+wTsQDVAqe1bKvkO3FQG3zwZuzKUKTi/pqTXylH/zMHtdjviKBXAkxnq3YoUQRSMeObrjU8pRj8qFuJ8qt46kugh1neuRdRQr/YheDT9mpBu2xVERdWUD0CooaOVNucmkxP1xxJ4Szxd1FkZRpZPQOfTtczGxtKRlKo1lPc+2ZJBLAs4icSJjPho8vwv1KZQJJuoKopzIaTYiJIvsRxCFiLpddaXCFpDfl7sD6BX6xatLRSbLtYB/8JJw60qU88+AWZgSDLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(366004)(39860400002)(396003)(346002)(33430700001)(6512007)(86362001)(316002)(6486002)(2616005)(54906003)(71200400001)(110136005)(26005)(186003)(53546011)(8676002)(2906002)(6506007)(4326008)(8936002)(5660300002)(64756008)(36756003)(33440700001)(66556008)(66446008)(478600001)(66946007)(66476007)(76116006)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SL1bVo3uBSnhq5CGbezQs3UDlsn5wvks88at0SDmBD9fhWrNARsZ0SB3H/wIiis34Up/OoAvni5BDY1A72qaG+Ce1TLJM9PDkNr5gRCoNmaNsx3aShxP7Qw7j06nlB6ZldEQhP9zOZKUhiNsjxs+2xN1V/nmXol7ZUzsVDWiFwhXizh+f7Dnx1AbN0qsQFBQavqqCi9bSb/UvIQtRH+bzKK1rgeL4h2k2vPNnu59/KlTmwpgzIy4peRUWsJfP0y/hC31HnFmkTsKMYwdUuBu1MkV2zB5AGcYDAAqFkz94U0nGHPpbT2WRIWHZk2C++rWAOkBup/6vzmvKv9fGTXKxnHznviYbQACpsgkoNG79U+hb6r1Uw4UkWmSQtDNLEWq3vfU/st2WR5NhPUKsG6SwnTph4QfGhes4ktzeCLuPb2PeOUUVaG29g8yBLmu3dXSN2I2tNtNRbpHgeNUDjFzIB0q5SQAfQKWV4AH0oKtiE4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A562B5108165B40AEAD5F3BF22BF45C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75029b86-7c2a-4f33-3c1a-08d7f596be32
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 10:33:27.9268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5B8XKlld9uc6ZStMrIoeVAvhMQwK2XMSInkb7VG0LR/d2/MVasqzc6k9W0IeLHQOdJ8+y4cQ6c6noDZlAkUEDNTMrqQellOe4zziqVRb+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4537
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_04:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110087
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA1LTEwIGF0IDExOjA5ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBTYXQsIDkgTWF5IDIwMjAgMTA6NTI6MTQgKzAyMDAN
Cj4gTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+IHdyb3RlOg0KPiANCj4gPiBP
biA1LzgvMjAgMzo1MyBQTSwgQWxleGFuZHJ1IEFyZGVsZWFuIHdyb3RlOg0KPiA+ID4gWy4uLl0N
Cj4gPiA+IFdoYXQgSSBkb24ndCBsaWtlLCBpcyB0aGF0IGlpbzpkZXZpY2UzIGhhcyBpaW86YnVm
ZmVyMzowICh0byAzKS4NCj4gPiA+IFRoaXMgaXMgYmVjYXVzZSB0aGUgJ2J1ZmZlci0+ZGV2LnBh
cmVudCA9ICZpbmRpb19kZXYtPmRldicuDQo+ID4gPiBCdXQgSSBkbyBmZWVsIHRoaXMgaXMgY29y
cmVjdC4NCj4gPiA+IFNvLCBub3cgSSBkb24ndCBrbm93IHdoZXRoZXIgdG8gbGVhdmUgaXQgbGlr
ZSB0aGF0IG9yIHN5bWxpbmsgdG8gc2hvcnRlcg0KPiA+ID4gdmVyc2lvbnMgbGlrZSAnaWlvOmJ1
ZmZlcjM6WScgLT4gJ2lpbzpkZXZpY2UzL2J1ZmZlclknLg0KPiA+ID4gVGhlIHJlYXNvbiBmb3Ig
bmFtaW5nIHRoZSBJSU8gYnVmZmVyIGRldmljZXMgdG8gJ2lpbzpidWZmZXJYOlknIGlzDQo+ID4g
PiBtb3N0bHkgdG8gbWFrZSB0aGUgbmFtZXMgdW5pcXVlLiBJdCB3b3VsZCBoYXZlIGxvb2tlZCB3
ZWlyZCB0byBkbw0KPiA+ID4gJy9kZXYvYnVmZmVyMScgaWYgSSB3b3VsZCBoYXZlIG5hbWVkIHRo
ZSBidWZmZXIgZGV2aWNlcyAnYnVmZmVyWCcuDQo+ID4gPiANCj4gPiA+IFNvLCBub3cgSSdtIHRo
aW5raW5nIG9mIHdoZXRoZXIgYWxsIHRoaXMgaXMgYWNjZXB0YWJsZS4NCj4gPiA+IE9yIHdoYXQg
aXMgYWNjZXB0YWJsZT8NCj4gPiA+IFNob3VsZCBJIHN5bWxpbmsgJ2lpbzpkZXZpY2UzL2lpbzpi
dWZmZXIzOjAnIC0+ICdpaW86ZGV2aWNlMy9idWZmZXIwJz8NCj4gPiA+IFdoYXQgZWxzZSBzaG91
bGQgSSBjb25zaWRlciBtb3ZpbmcgZm9yd2FyZD8NCj4gPiA+IFdoYXQgbWVhbnMgZm9yd2FyZD8N
Cj4gPiA+IFdoZXJlIGRpZCBJIGxlYXZlIG15IGJlZXI/ICANCj4gPiANCj4gPiBMb29raW5nIGF0
IGhvdyB0aGUgL2Rldi8gZGV2aWNlcyBhcmUgbmFtZWQgSSB0aGluayB3ZSBjYW4gcHJvdmlkZSBh
IG5hbWUgDQo+ID4gdGhhdCBpcyBkaWZmZXJlbnQgZnJvbSB0aGUgZGV2X25hbWUoKSBvZiB0aGUg
ZGV2aWNlLiBIYXZlIGEgbG9vayBhdCANCj4gPiBkZXZpY2VfZ2V0X2Rldm5vZGUoKSBpbiBkcml2
ZXJzL2Jhc2UvY29yZS5jLiBXZSBzaG91bGQgYmUgYWJsZSB0byANCj4gPiBwcm92aWRlIHRoZSBu
YW1lIGZvciB0aGUgY2hhcmRldiB0aHJvdWdoIHRoZSBkZXZub2RlKCkgY2FsbGJhY2suDQo+ID4g
DQo+ID4gV2hpbGUgd2UgYXJlIGF0IHRoaXMsIGRvIHdlIHdhbnQgdG8gbW92ZSB0aGUgbmV3IGRl
dmljZXMgaW50byBhbiBpaW8gDQo+ID4gc3ViZm9sZGVyPyBTbyBpaW8vYnVmZmVyMDowIGluc3Rl
YWQgb2YgaWlvOmJ1ZmZlcjA6MD8NCj4gDQo+IFBvc3NpYmx5IG9uIHRoZSBmb2xkZXIuICBJIGNh
bid0IGZvciB0aGUgbGlmZSBvZiBtZSByZW1lbWJlciB3aHkgSSBkZWNpZGVkDQo+IG5vdCB0byBk
byB0aGF0IHRoZSBmaXJzdCB0aW1lIGFyb3VuZCAtIEknbGwgbGVhdmUgaXQgYXQgdGhlDQo+IG15
c3RlcmlvdXMgIml0IG1heSB0dXJuIG91dCB0byBiZSBoYXJkZXIgdGhhbiB5b3UnZCB0aGluay4u
LiINCj4gSG9wZWZ1bGx5IG5vdCA7KQ0KDQpJIHdhcyBhbHNvIHRoaW5raW5nIGFib3V0IHRoZSAv
ZGV2L2lpbyBzdWJmb2xkZXIgd2hpbGUgZG9pbmcgdGhpcy4NCkkgY2FuIGNvcHkgdGhhdCBmcm9t
IC9kZXYvaW5wdXQNClRoZXkgc2VlbSB0byBkbyBpdCBhbHJlYWR5Lg0KSSBkb24ndCBrbm93IGhv
dyBkaWZmaWN1bHQgaXQgd291bGQgYmUuIEJ1dCBpdCBsb29rcyBsaWtlIGEgZ29vZCBwcmVjZWRl
bnQuDQoNCk15IGNvbmNlcm4gcmVnYXJkaW5nIGdvaW5nIHRvIHVzZSBzdHVmZiBmcm9tIGNvcmUg
W2xpa2UgZGV2aWNlX2dldF9kZXZub2RlKCldIGlzDQp0aGF0IGl0IHNlZW1zIHRvIGJ5cGFzcyBz
b21lIGxheWVycyBvZiBrZXJuZWwuDQpJZiBJIGRvICdnaXQgZ3JlcCBkZXZpY2VfZ2V0X2Rldm5v
ZGUnLCBJIGdldDoNCg0KZHJpdmVycy9iYXNlL2NvcmUuYzogICAgICAgICAgICBuYW1lID0gZGV2
aWNlX2dldF9kZXZub2RlKGRldiwgJm1vZGUsICZ1aWQsDQomZ2lkLCAmdG1wKTsNCmRyaXZlcnMv
YmFzZS9jb3JlLmM6ICogZGV2aWNlX2dldF9kZXZub2RlIC0gcGF0aCBvZiBkZXZpY2Ugbm9kZSBm
aWxlDQpkcml2ZXJzL2Jhc2UvY29yZS5jOmNvbnN0IGNoYXIgKmRldmljZV9nZXRfZGV2bm9kZShz
dHJ1Y3QgZGV2aWNlICpkZXYsDQpkcml2ZXJzL2Jhc2UvZGV2dG1wZnMuYzogICAgICAgIHJlcS5u
YW1lID0gZGV2aWNlX2dldF9kZXZub2RlKGRldiwgJnJlcS5tb2RlLA0KJnJlcS51aWQsICZyZXEu
Z2lkLCAmdG1wKTsNCmRyaXZlcnMvYmFzZS9kZXZ0bXBmcy5jOiAgICAgICAgcmVxLm5hbWUgPSBk
ZXZpY2VfZ2V0X2Rldm5vZGUoZGV2LCBOVUxMLCBOVUxMLA0KTlVMTCwgJnRtcCk7DQppbmNsdWRl
L2xpbnV4L2RldmljZS5oOmV4dGVybiBjb25zdCBjaGFyICpkZXZpY2VfZ2V0X2Rldm5vZGUoc3Ry
dWN0IGRldmljZSAqZGV2LA0KKEVORCkNCg0KU28sIGJhc2ljYWxseSwgbW9zdCB1c2VzIG9mIGRl
dmljZV9nZXRfZGV2bm9kZSgpIGFyZSBpbiBjb3JlIGNvZGUsIGFuZCBJIGZlZWwNCnRoYXQgdGhp
cyBtYXkgYmUgc2FuY3Rpb25lZCBzb21ld2hlcmUgYnkgc29tZSBjb3JlIHBlb3BsZSwgaWYgSSBk
byBpdC4NCkkgY291bGQgYmUgd3JvbmcsIGJ1dCBpZiB5b3UgZGlzYWdyZWUsIEknbGwgdGFrZSB5
b3VyIHdvcmQgZm9yIGl0Lg0KDQpJIHRyaWVkIHVzaW5nIGRldnRtcGZzX2NyZWF0ZV9ub2RlKCkg
ZGlyZWN0bHksIGFuZCBpdCB3b3JrZWQsIGJ1dCBhZ2FpbiwgZG9pbmcNCidnaXQgZ3JlcCBkZXZ0
bXBmc19jcmVhdGVfbm9kZScNCg0KZHJpdmVycy9iYXNlL2Jhc2UuaDppbnQgZGV2dG1wZnNfY3Jl
YXRlX25vZGUoc3RydWN0IGRldmljZSAqZGV2KTsNCmRyaXZlcnMvYmFzZS9iYXNlLmg6c3RhdGlj
IGlubGluZSBpbnQgZGV2dG1wZnNfY3JlYXRlX25vZGUoc3RydWN0IGRldmljZSAqZGV2KSB7DQpy
ZXR1cm4gMDsgfQ0KZHJpdmVycy9iYXNlL2NvcmUuYzogICAgICAgICAgICBkZXZ0bXBmc19jcmVh
dGVfbm9kZShkZXYpOw0KZHJpdmVycy9iYXNlL2RldnRtcGZzLmM6aW50IGRldnRtcGZzX2NyZWF0
ZV9ub2RlKHN0cnVjdCBkZXZpY2UgKmRldikNCmRyaXZlcnMvczM5MC9jaGFyL2htY2Rydl9kZXYu
YzogKiBTZWU6IGRldnRtcGZzLmMsIGZ1bmN0aW9uDQpkZXZ0bXBmc19jcmVhdGVfbm9kZSgpDQoN
Ck1vc3QgY2FsbHMgYXJlIGluIGNvcmUsIGFuZCB0aGUgb25lIGluIGhtY2RydiBkcml2ZXIgaXNu
J3QgY29udmluY2luZyBlbm91Z2ggdG8NCmRvIGl0Lg0KSW4gZmFjdCwgc29tZSBtYXkgY29uc2lk
ZXIgaXQgZGFuZ2Vyb3VzIGFzIGl0IGFsbG93cyBkcml2ZXJzL2ZyYW1ld29ya3MgdG8gdXNlDQpp
dCBhcyBwcmVjZWRlbnQgdG8gZG8gbW9yZSBuYW1lIG1hbmlwdWxhdGlvbi4NCkFnYWluLCBpZiB5
b3UgZ3V5cyBzYXkgdGhhdCB0aGlzIHdvdWxkIGJlIGFjY2VwdGFibGUsIEkgY2FuIHVzZQ0KZGV2
aWNlX2dldF9kZXZub2RlKCkgYW5kIG90aGVyIHN0dWZmIGZyb20gY29yZS4NCg0KDQo+IA0KPiBE
byB3ZSB3YW50IHRvIG1ha2UgdGhlIG5hbWluZyBhIGJpdCBtb3JlIHNlbGYgZGVzY3JpYmluZywg
c29tZXRoaW5nIGxpa2UNCj4gaWlvL2RldmljZTA6YnVmZmVyMD8gIEdpdmVuIHRoZSBsZWdhY3kg
aW50ZXJmYWNlIHdpbGwgYmUgb3V0c2lkZQ0KPiB0aGUgZGlyZWN0b3J5IGFueXdheSwgY291bGQg
ZXZlbiBkbw0KPiANCj4gaWlvL2RldmljZTAvYnVmZmVyMCB3aXRoIGxpbmsgdG8gaWlvOmRldmlj
ZTANCj4gaWlvL2RldmljZTAvYnVmZmVyMSB3aXRoIG5vIGxlZ2FjeSBsaW5rLg0KPiANCj4gQWgs
IHRoZSBiaWtlc2hlZGRpbmcgZnVuIHdlIGhhdmUgYWhlYWQgb2YgdXMhDQoNClRoaXMgbWF5IGFs
c28gZGVwZW5kIG9uIGhvdyBtdWNoIGNvZGUgaXQgdGFrZXMgdG8gaW1wbGVtZW50IHRoZXNlIG1h
bnkgbGV2ZWxzIG9mDQpmb2xkZXIgaGllcmFyY2h5Lg0KDQo+IA0KPiBJIHRoaW5rIHRoaXMgc2V0
IGlzIGdvaW5nIHRvIHRha2UgdG9vIG11Y2ggdGhpbmtpbmcgZm9yIGEgU3VuZGF5DQo+IHNvIG1h
eSB0YWtlIG1lIGEgbGl0dGxlIHdoaWxlIHRvIGRvIGEgcHJvcGVyIHJldmlldy4uLg0KPiArIEkg
aGF2ZSBhIGZldyBvdGhlciBzaWRlIHByb2plY3RzIEkgd2FudCB0byBoYW1tZXIgb24gdG9kYXkg
OikNCj4gDQo+IEpvbmF0aGFuDQo+IA0K
