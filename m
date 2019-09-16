Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28D39B35F0
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 09:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfIPHu4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 03:50:56 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:26758 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbfIPHu4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 03:50:56 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8G7lPBd002014;
        Mon, 16 Sep 2019 03:50:27 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2059.outbound.protection.outlook.com [104.47.48.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v0w47jucy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 03:50:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f76ue0CFU6m0jfshKCkcO5je5IIGmD7++15nyP6uX/MTRCMttB9LQopT+H/jo4qmZtKsNx8OCPrYwtYugd6hpSvN6UC/04RtL/CFEqeMlU/itAWGOqxcBm42PFJ4dXXZH6ltQExzqCIC8PnYG1TUyhHNZ6A0DXERN4O1dhDNFC16kLDFkyv95eSus4EswrTLSw+MV5zgJ2A/fhQGbIzAoqfQniIQIEASFoDzNT6mgLZfAZw3IrWZDUOTpaARky5X4Hha6AnA+TxM0FexQuvlDiH+D0hL0GhumQpPsIaYoyc1VJasFSbwheHYNxor+EOLh7ZyndwWgrjv3U6KEcO32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kod5mw+Y+5eHUhKp0CpW1j5oyB7cid2g3Kh0macjtpw=;
 b=JkBLGAJiOXhk0Js8rZ6MNHpj4oL8K8yNUDNMnztqHUGR1BDS0aYv/w1Iwn+miDYes8G6P1T2Z4qFQI5NfPXS8MS2eAQM5ANCfmLBJJarmg85hLWBdUfJZ+MsManAAKnAgzACxlM8dsVM2kYIx8t1EwllUxusD02+LE9Sen16nEGPLMZADHbxKD48JD7hMItY7vXoTHR9+EaYkfBnchb2jZ86CBqcqhq/y4i0Oxm+6ytyE4pcVL3e/E9KWcN2gzJsY1UgojHuqrWaz+/37xvTW5LKynxfC5uKbg0q5ydkVJGfLmBqTGK7udZju2BhPjEmkl+vtOm+s3TTIJFqJc4Jow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kod5mw+Y+5eHUhKp0CpW1j5oyB7cid2g3Kh0macjtpw=;
 b=lUDjD3dA3my7IBeHwPwlyM3dkmMDqtX0Jf7utpPYR8L9IJiGouJXXXgvhxWLGL3kqo+5M3ZuXgRS0gZ2lwAsvxtpVwwH869ePA15xsYHWRRWrwQQTy/SY5lW4TymAk1KfErkr/o7b5gTrOd+p5HSH2/7Ocv5gzzluuxZmuxbSTM=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5287.namprd03.prod.outlook.com (20.180.4.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.24; Mon, 16 Sep 2019 07:50:25 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 07:50:25 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "charles-antoine.couret@essensium.com" 
        <charles-antoine.couret@essensium.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH 0/4] Fixes for ad7949
Thread-Topic: [PATCH 0/4] Fixes for ad7949
Thread-Index: AQHVaXiJvkTPKl6mIkeot7v5rveqP6cpZ9+AgAA8Y4CAAu9YgIABXRAAgAACqYCAAACHAA==
Date:   Mon, 16 Sep 2019 07:50:25 +0000
Message-ID: <b0a5907d0fbfe625e5f74319daf19f3c9416ec00.camel@analog.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
         <1f13820761bbdb4db685a90e9bcf35a388b246cf.camel@analog.com>
         <2b7ab6c3-6ff6-69b5-bbd4-f8a1966b6b57@essensium.com>
         <20190915114939.13fc6d44@archlinux>
         <CAN8YU5NVWubV0HeXDHZ=fJThaKTC5R2AoNtX-BsDdifVkiJZnA@mail.gmail.com>
         <60ccde67a06a896003126a0d86701b635010d2e6.camel@analog.com>
In-Reply-To: <60ccde67a06a896003126a0d86701b635010d2e6.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fe53982-194c-41f0-7a4d-08d73a7a8903
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR03MB5287;
x-ms-traffictypediagnostic: CH2PR03MB5287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5287D1AE9693040FF67BA4FEF98C0@CH2PR03MB5287.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(396003)(346002)(136003)(43544003)(199004)(189003)(51914003)(110136005)(76116006)(102836004)(14454004)(6506007)(7736002)(186003)(305945005)(26005)(229853002)(478600001)(76176011)(86362001)(66574012)(66066001)(2906002)(2501003)(66946007)(486006)(8676002)(14444005)(256004)(3846002)(6116002)(71200400001)(71190400001)(316002)(6486002)(54906003)(2616005)(446003)(11346002)(36756003)(66556008)(118296001)(66476007)(64756008)(66446008)(25786009)(53936002)(6512007)(476003)(81166006)(81156014)(6436002)(99286004)(5660300002)(6246003)(4326008)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5287;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NQj+Xtn621JjNLe4JmTIu0ZSkm2pdETR2nIu5wbKdSU+sOL92DL2hFwWpf/WOqYzXszLgB75AxQz58RioC5K29qEb+ebr4W1vYKHlL8wOrmKEvtth1MCdSPX5hSVHHyeU65ILfHLGnanQoRzD34lbywaFtKG0Ah5szsS7aVa8ZzM/1x8ilWqSDq+aNaHzAESRAopv9JSSHmAMVzEZKHHz9i8uh1DVwgMc7N6iCkbPnsMJlf6FuBpSiwdwJhhWE2MdIFCJF7JOIVIRz16YB4O6n1Bxl6UrKaDfqg6crtzXO9qZdzsBDTawaH9+5I1KrvyLRK3avDDZ1rKIyOc1VaI55Gdqsi378D6SrWttWviTPPh0rKC5v4grCSjbfurmJx8768XALsJdci+J8OqQ+m8+p+DAm1MjPy8LL0oZtmusZA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97FED19F5BF02A4DA542EE5F1E6088C3@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe53982-194c-41f0-7a4d-08d73a7a8903
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 07:50:25.3881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LV+As2HckirSuuBmleUUepB1BqFPhH12hzyTuHrjCHRUl8pPpFpjF+5KCkJw3yz0PSs7dliX6jWOhC6Ot17mzypCZ5UFyuTCfHgXC91xWmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5287
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_04:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909160085
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA5LTE2IGF0IDA3OjQ4ICswMDAwLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdy
b3RlOg0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBNb24sIDIwMTktMDktMTYgYXQgMDk6MzkgKzAy
MDAsIEFuZHJlYSBNZXJlbGxvIHdyb3RlOg0KPiA+IElsIGdpb3JubyBkb20gMTUgc2V0IDIwMTkg
YWxsZSBvcmUgMTI6NDkgSm9uYXRoYW4gQ2FtZXJvbg0KPiA+IDxqaWMyM0BrZXJuZWwub3JnPiBo
YSBzY3JpdHRvOg0KPiA+ID4gT24gRnJpLCAxMyBTZXAgMjAxOSAxNjowMDoyOSArMDIwMA0KPiA+
ID4gQ291cmV0IENoYXJsZXMtQW50b2luZSA8Y2hhcmxlcy1hbnRvaW5lLmNvdXJldEBlc3NlbnNp
dW0uY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gPiBMZSAxMy8wOS8yMDE5IMOgIDA5OjI0LCBB
cmRlbGVhbiwgQWxleGFuZHJ1IGEgw6ljcml0IDoNCj4gPiA+ID4gPiBPbiBUaHUsIDIwMTktMDkt
MTIgYXQgMTY6NDMgKzAyMDAsIEFuZHJlYSBNZXJlbGxvIHdyb3RlOg0KPiA+ID4gPiA+ID4gW0V4
dGVybmFsXQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGlzIHBhdGNoIHNlcmllcyBmaXhl
cyBhZDc5NDkgZHJpdmVyIGluY29ycmVjdGx5IHJlYWQgZGF0YSwgc2ltcGxpZnkgdGhlDQo+ID4g
PiA+ID4gPiBjb2RlLCBhbmQgZW5mb3JjZXMgZGV2aWNlIHRpbWluZyBjb25zdHJhaW50cy4NCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhpcyBoYXMgYmVlbiB0ZXN0ZWQgb24gYSBVbHRyYVpl
ZCBTT00gKyBhIGN1c3RvbSBjYXJyaWVyIGVxdWlwcGVkIHdpdGgNCj4gPiA+ID4gPiA+IHNldmVy
YWwgQUQ3Njg5IEEvRHMuIFBhdGNoZXMgaGF2ZSBiZWVuIGRldmVsb3BlZCBvbiBhIFhpbGlueCB1
cHN0cmVhbQ0KPiA+ID4gPiA+ID4ga2VybmVsIGFuZCB0aGVuIHJlYmFzZWQgb24gbGludXgtbmV4
dCBrZXJuZWwuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGFua3MgZm9yIHRoZSBwYXRjaGVz
Lg0KPiA+ID4gPiA+IEFkZGVkIENoYXJsZXMtQW50b2luZSB0byBhbHNvIHRha2UgYSBsb29rLg0K
PiA+ID4gPiA+IEFwb2xvZ2llcyBmb3Igbm90IHRoaW5raW5nIG9mIGFkZGluZyBoaW0gc29vbmVy
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgdHlwaWNhbGx5IHRyeSB0byByZXZpZXcgY2hhbmdl
cyBmb3IgQURJIHBhcnRzLCBidXQgaGUgd3JvdGUgaXQsIHNvIGhlIG1heSBoYXZlIG1vcmUgaW5w
dXQgdGhhbiBJIGRvLg0KPiA+ID4gPiA+IEpvbmF0aGFuIHdpbGwgbGlrZWx5IGFsc28gdGFrZSBh
IGxvb2suDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSWYgaXQncyBhZ3JlZWQsIEkgd291bGQgc2F5
IHRvIGF0IGxlYXN0IHRha2UgdGhlIGZpcnN0IHBhdGNoICgiaWlvOiBhZDc5NDk6IGtpbGwgcG9p
bnRsZXNzICJyZWFkYmFjayItaGFuZGxpbmcNCj4gPiA+ID4gPiBjb2RlIikNCj4gPiA+ID4gPiBu
b3cgYW5kIHNlZSBhYm91dCB0aGUgcmVzdC4NCj4gPiA+ID4gPiBUaGUgcmVzdCBhcmUgYSBiaXQg
bW9yZSBvcGVuIHRvIGRpc2N1c3Npb24sIHNvIGEgdjIgbWF5IGhhcHBlbi4NCj4gPiA+ID4gDQo+
ID4gPiA+IEhpLA0KPiA+ID4gPiANCj4gPiA+ID4gRG9uJ3Qgd29ycnkuIER1ZSB0byB0aGUgZmFj
dCBJIGRvbid0IGhhdmUgb24gbXkgbWFpbCBjbGllbnQgYWNjZXNzIHRvDQo+ID4gPiA+IHRoZSB3
aG9sZSBkaXNjdXNzaW9ucywgSSdtIG1ha2luZyBhIGNvbXBsZXRlIGFuc3dlciB0aGVyZSBiYXNl
ZCBvbiB0aGUNCj4gPiA+ID4gYXJjaGl2ZSBvZiB0aGUgbWFpbGluZyBsaXN0LiBTb3JyeSBmb3Ig
dGhhdC4NCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBGb3IgdGhlIHBhdGNoIDEsIEkgYXBw
cm92ZSBpdCB0b28uIFRoaXMgcGFydCBvZiBjb2RlIGlzIHVzZWxlc3MgYmVjYXVzZQ0KPiA+ID4g
PiB0aGUgZmVhdHVyZSB3YXMgcmVtb3ZlZC4gUklQIG15IGNvZGUuIDpEDQo+ID4gPiA+IA0KPiA+
ID4gPiBGb3IgdGhlIHBhdGNoIDIsIHRoZSBjYWNoZSBpbmZvcm1hdGlvbiB3YXMgYWRkZWQgZHVl
IHRvIGNvbW1lbnQgZnJvbQ0KPiA+ID4gPiBKb25hdGhhbiBDYW1lcm9uIHdoZW4gSSBkZXZlbG9w
ZWQgdGhlIGRyaXZlci4gVGhlIGNvbW1lbnQgd2FzOg0KPiA+ID4gPiANCj4gPiA+ID4gPiBMb29r
IHZlcnkgY2FyZWZ1bGx5IGF0IHRoZSByZXF1aXJlbWVudHMgZm9yIGEgYnVmZmVyIGJlaW5nIHBh
c3NlZA0KPiA+ID4gPiA+IHRvIHNwaV9zeW5jLiAgSXQgbmVlZHMgdG8gYmUgRE1BIHNhZmUuICBU
aGlzIG9uZSBpcyBub3QuICBUaGUgdXN1YWwNCj4gPiA+ID4gPiB3YXkgdG8gZG8gdGhhdCBlYXNp
bHkgaXMgdG8gcHV0IGEgY2FjaGVsaW5lIGFsaWduZWQgYnVmZmVyIGluIHlvdXINCj4gPiA+ID4g
PiBhZDc5NDlfYWRjX2NoaXAgc3RydWN0dXJlLg0KPiA+ID4gDQo+ID4gPiBUaGUgc2hvcnQgdmVy
c2lvbiBvZiB0aGlzIGlzIGJlc3QgaWxsdXN0cmF0ZWQgd2l0aCBhbiBleGFtcGxlLg0KPiA+ID4g
VGhpcyBvbmx5IGFwcGxpZXMgc3lzdGVtcyB3aGVyZSB0aGUgRE1BIGVuZ2luZXMgYXJlIG5vdCBj
b2hlcmVudA0KPiA+ID4gKGkuZS4gYSBjaGFuZ2UgbWFkZSBieSBhIERNQSBlbmdpbmUgaXMgbm90
IGF1dG9tYXRpY2FsbHkgdXBkYXRlZCB0bw0KPiA+ID4gIGFsbCBvdGhlciBwbGFjZXMgYSBjb3B5
IGlzIGhlbGQgaW4gY2FjaGVzIGluIHRoZSBzeXN0ZW0sIHdlIGhhdmUgdG8NCj4gPiA+ICBkbyBp
dCBieSBoYW5kKS4NCj4gPiA+IA0KPiA+ID4gV2UgaGF2ZSBhIHN0cnVjdHVyZSBsaWtlDQo+ID4g
PiBzdHJ1Y3QgYm9iIHsNCj4gPiA+ICAgICAgICAgaW50IGluaXRpYWxfZGF0YTsNCj4gPiA+ICAg
ICAgICAgdTggYnVmZmVyWzhdOw0KPiA+ID4gICAgICAgICBpbnQgbWFnaWNfZmxhZ3MNCj4gPiA+
IH07DQo+ID4gPiANCj4gPiA+IFdoZW4gYSBETUEgdHJhbnNmZXIgaXMgc2V0dXAgaW52b2x2aW5n
ICdidWZmZXInLCB0aGUgRE1BIGVuZ2luZSBtYXkgdGFrZQ0KPiA+ID4gdXAgdG8gYSBjYWNoZWxp
bmUgKHR5cGljYWxseSA2NCBieXRlcykgaW5jbHVkaW5nIGJ1ZmZlciwgbWFrZSBhIGNvcHkgb2Yg
aXQNCj4gPiA+IGFuZCBhc3N1bWUgdGhhdCB0aGUgb25seSBiaXQgb2YgaGFyZHdhcmUgd29ya2lu
ZyBpbiB0aGlzIGNhY2hlbGluZSBpcyBpdHNlbGYuDQo+ID4gPiAoTGludXggaXMgJ2d1YXJhbnRl
ZWluZycgdGhpcyB3aGVuIGl0IHRlbGxzIHRoZSBETUEgZW5naW5lIHRvIHVzZSB0aGlzIGJ1ZmZl
ci4nLg0KPiA+ID4gV2hpbHN0IHRoYXQgRE1BIGlzIGdvaW5nIG9uLCBhIENQVSBjYW4gd3JpdGUg
c29tZXRoaW5nIGluIG1hZ2ljIGZsYWdzLg0KPiA+ID4gVGhhdCBzb21ldGhpbmcgbWlnaHQgYmUg
aW1wb3J0YW50IGJ1dCB1bnJlbGF0ZWQgdG8gdGhlIERNQSB0cmFuc2ZlciBnb2luZw0KPiA+ID4g
b24uDQo+ID4gPiANCj4gPiA+IFRoZSBETUEgZmluaXNoZXMsIGhhdmluZyBwdXQgbmV3IGRhdGEg
aW4gdGhlIGJ1ZmZlciBlbGVtZW50IG9mIHRoZSBjb3B5DQo+ID4gPiBvZiB0aGUgY2FjaGVsaW5l
IGxvY2FsIHRvIC4gSXQncyBndWFyYW50ZWVkIHRvIG5vdCBjaGFuZ2UgaXQncyBjb3B5IG9mIHRo
ZQ0KPiA+ID4gY2FjaGVsaW5lIChpbiB0aGlzIGNhc2UgY29udGFpbmluZyB0aGUgd2hvbGUgb2Yg
Ym9iKS4gICBIb3dldmVyLCBpdCdzIHZlcnNpb24NCj4gPiA+IG9mIG1hZ2ljX2ZsYWdzIGlzIG91
dCBvZiBkYXRlIHNvIHdoZW4gd2UgZmx1c2ggdGhlIGNhY2hlcyBhdCB0aGUgZW5kIG9mIHRoZQ0K
PiA+ID4gbm9uIGNvaGVyZW50IERNQSB0cmFuc2ZlciAodG8gZm9yY2UgdGhlIENQVSB0byByZWFk
IGl0IGZyb20gbWFpbiBtZW1vcnkgYW5kDQo+ID4gPiBnZXQgdGhlIG5ldyB2YWx1ZXMgaW4gYnVm
ZmVyKSwgdGhlIHZhbHVlIG9mIG1hZ2ljX2ZsYWdzIGNhbiBiZSByZXNldCB0byB0aGUNCj4gPiA+
IHZlcnNpb24gdGhlIERNQSBlbmdpbmUgaGFzLg0KPiA+ID4gDQo+ID4gPiBTbywgdXBzaG90IGlz
IHRvIGF2b2lkIGFueSBwb3RlbnRpYWwgb2Ygc3VjaCBwcm9ibGVtcywgRE1BIGJ1ZmZlcnMgJ211
c3QnDQo+ID4gPiBhbHdheXMgYmUgaW4gYSBjYWNoZWxpbmUgY29udGFpbmluZyBub3RoaW5nIHRo
YXQgbWlnaHQgYmUgY2hhbmdlZCBieQ0KPiA+ID4gb3RoZXIgYWN0aXZpdGllcy4gIFRoaXMgY2Fu
IG1lYW4gaXQgaXMgc2FmZSB0byBwdXQgYm90aCBUWCBhbmQgUlggYnVmZmVycw0KPiA+ID4gaW4g
dGhlIHNhbWUgY2FjaGVsaW5lIGFzIHdlIHdvbid0IHRvdWNoIGVpdGhlciBkdXJpbmcgYW4gU1BJ
IHRyYW5zZmVyLg0KPiA+ID4gDQo+ID4gPiA+ID4gTG90cyBvZiBleGFtcGxlcyB0byBjb3B5LCBi
dXQgaXQncyBhbHNvIHdvcnRoIG1ha2luZyBzdXJlIHlvdSB1bmRlcnN0YW5kDQo+ID4gPiA+ID4g
d2h5IHRoaXMgaXMgbmVjZXNzYXJ5Lg0KPiA+ID4gPiANCj4gPiA+ID4gRm9yIHRoZSBlbmRpYW5l
c3MgdGhpbmcsIGl0IHNob3VsZG4ndCBiZSByZXF1aXJlZCB0byBtYWtlIGFuIGV4cGxpY2l0DQo+
ID4gPiA+IGNvbnZlcnNpb24gaW50byB0aGUgZHJpdmVyLiBBY2NvcmRpbmcgdG8gdGhlIHNwaS5o
IGRvY3VtZW50YXRpb246DQo+ID4gPiA+IA0KPiA+ID4gPiA+ICogSW4tbWVtb3J5IGRhdGEgdmFs
dWVzIGFyZSBhbHdheXMgaW4gbmF0aXZlIENQVSBieXRlIG9yZGVyLCB0cmFuc2xhdGVkDQo+ID4g
PiA+ID4gKiBmcm9tIHRoZSB3aXJlIGJ5dGUgb3JkZXIgKGJpZy1lbmRpYW4gZXhjZXB0IHdpdGgg
U1BJX0xTQl9GSVJTVCkuIFNvDQo+ID4gPiA+ID4gKiBmb3IgZXhhbXBsZSB3aGVuIGJpdHNfcGVy
X3dvcmQgaXMgc2l4dGVlbiwgYnVmZmVycyBhcmUgMk4gYnl0ZXMgbG9uZw0KPiA+ID4gPiA+ICog
KEBsZW4gPSAyTikgYW5kIGhvbGQgTiBzaXh0ZWVuIGJpdCB3b3JkcyBpbiBDUFUgYnl0ZSBvcmRl
ci4NCj4gPiA+ID4gU28gZnJvbSBteSBwb2ludCBvZiB2aWV3IHRoZSBTUEkgc3Vic3lzdGVtIGFs
d2F5cyBjb252ZXJ0cyB0byB0aGUgcmlnaHQNCj4gPiA+ID4gZW5kaWFuZXNzLiBXZSBkb24ndCBo
YXZlIHRvIHRha2UgY2FyZSBhYm91dCBpdC4NCj4gPiA+IA0KPiA+ID4gQ29ycmVjdCwgdGhvdWdo
IGFzIEkgY29tbWVudGVkIG9uIHRoYXQgcGF0Y2gsIHRoYXQncyBub3QgYWx3YXlzICdwb3NzaWJs
ZScNCj4gPiA+IGFuZCBub3QgYWxsIGRyaXZlcnMgc2V0IHRoZSB3b3JkIGxlbmd0aCAnY29ycmVj
dGx5Jy4NCj4gPiANCj4gPiBUaGFuayB5b3UgYm90aCBmb3IgdGhlIGV4cGxhbmF0aW9ucyBhYm91
dCBETUEgYW5kIFNQSSBlbmRpYW5lc3MgOikNCj4gPiANCj4gPiBTbyBpbmRlZWQgMi80IHNlZW1z
IE9LIHRvIG1lLCBhbmQgaXQgZG9lc24ndCBuZWVkIGFueSBmdXJ0aGVyDQo+ID4gZW5kaWFuZXNz
LXJlbGF0ZWQgZml4Lg0KPiANCj4gWWVwLg0KPiBXaXRoIHRoZXNlIGV4cGxhbmF0aW9uczoNCj4g
DQo+IFJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBh
bmFsb2cuY29tPg0KPiANCg0KdGhpcyBpcyBmb3IgcGF0Y2ggMi80DQoNCj4gPiANCj4gPiA+IFdv
bGZyYW0ncyBwcmVzZW50YXRpb24gb24gdHJ5aW5nIHRvIGltcGxlbWVudCBETUEgc2FmZXR5IGlu
IEkyQyBhdCBFTENFMjAxOA0KPiA+ID4gYWxzbyB0b3VjaGVzIG9uIGEgbG90IG9mIHRoaXMuDQo+
ID4gPiANCj4gPiA+IFRoYW5rcywNCj4gPiA+IA0KPiA+ID4gSm9uYXRoYW4NCj4gPiA+IA0KPiA+
ID4gPiBGb3IgcGF0Y2ggMywgSSBkaWRuJ3QgdXNlIGRlbGF5X3VzZWNzIGZpZWxzIGR1ZSB0byB0
aGUgdGltaW5ncw0KPiA+ID4gPiBkZWZpbml0aW9uIGluIHRoZSBkYXRhc2hlZXQgaW4gIlJFQUQv
V1JJVEUgU1BBTk5JTkcgQ09OVkVSU0lPTiBXSVRIT1VUIEENCj4gPiA+ID4gQlVTWSBJTkRJQ0FU
T1IiIG1vZGUuIER1cmluZyB0aGUgZGVsYXksIHRoZSBjaGlwIHNlbGVjdCBsaW5lIG11c3QgYmUN
Cj4gPiA+ID4gcmVsZWFzZWQgd2hpY2ggaXMgbm90IHRoZSBjYXNlIHdoZW4gd2UgdXNlIGRlbGF5
X3VzZWNzIGZpZWxkLiBTbyBJIGFkZA0KPiA+ID4gPiB0aGUgZGVsYXkgaW5zdHJ1Y3Rpb24gYWZ0
ZXIgdGhlIHdyaXRlIHN0ZXAgdG8gYmUgY29tcGxpYW50IHdpdGggdGhlc2UNCj4gPiA+ID4gdGlt
aW5ncy4NCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBGb3IgcGF0Y2ggNCwgSSBleHBsYWlu
ZWQgYSBiaXQgaW4gdGhlIG90aGVyIHRocmVhZC4gTWF5YmUgd2UgaGF2ZSBhDQo+ID4gPiA+IGRp
ZmZlcmVuY2Ugb2YgYmVoYXZpb3VyIGR1ZSB0byB0aGUgY2hvaWNlIG9mIHRoZSB0aW1pbmdzICJt
b2RlcyI/DQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gQlRXLCBmcm9tIG15IHBvaW50IG9m
IHZpZXcgdGhlIGRhdGFzaGVldCBpcyBub3QgdG90YWxseSBjbGVhciBhYm91dCB0aGUNCj4gPiA+
ID4gdGltaW5ncyBhbmQgd2hhdCBpcyBtYW5kYXRvcnkgb3Igbm90IGluIHRoZSBleHBlY3RlZCBi
ZWhhdmlvdXIuDQo+ID4gPiA+IA0KPiA+ID4gPiBSZWdhcmRzLA0KPiA+ID4gPiANCj4gPiA+ID4g
Q2hhcmxlcy1BbnRvaW5lIENvdXJldA0KPiA+ID4gPiANCg==
