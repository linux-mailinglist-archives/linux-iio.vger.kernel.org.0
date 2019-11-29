Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB7710D1AC
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2019 08:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfK2HDR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Nov 2019 02:03:17 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:3018 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbfK2HDR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Nov 2019 02:03:17 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAT6w9BQ025192;
        Fri, 29 Nov 2019 02:02:32 -0500
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2059.outbound.protection.outlook.com [104.47.40.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2whux8crq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 02:02:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ip9SPWrMOD1ap9Pvpy+6JTIFPbrn3fXkgXWS+KtGVA0k6jpF6+PYJybyNT/Ez7ocdI2DWOPujOoiPOlME9w1WUwpg215nQNE9uqGogPXrqWQFaaDZx4N/NKIAFVk6st+jXAtNm9r22Eo136MCBcnqe5jcKR12URbpft8WKDMSMza7eKtBdjKr6rlh2n7cPWfL7sfLImsVi3tSW6ILtxIZhlLUpmIJixeKES5QOSGsfxjuE8ihAdCB7DViLy+4IGjQqkKQlJY2i8GAzhiVlQJhnExtc2IhyG3neLPRSpSqecQLgDjRh0zXQMekdE3S6FRyz1VEsDAsl98qQNHF5HdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fov7JQlMW1wP5Tuida+tdKgd0tCCrrS/cvvKjKP6iMw=;
 b=GvsbnI0FvcHS70LwsLhnAWIZGLyEAdIMn3CWFnC/bQmZs1ubcKxsBSmCNAmxZ5JUht/9hZHo8dSiVjBIn7m8w+feiWlcGKNArpAJ0RtSB+FJqisG2aOLNv3/kdyvvcgfV/88rwUoYL+3RVZgxy3PsIg9Lo9ar2W8SW+M2IRUlZZgsNdoQiS5qAKlt8PUj8xDZk5zTY9usoyZBNGuHAetjWDYbHUsqABvRecTcZDXfyg+6pujx0oJpfVKt4epIDDPJ7xshfbFtC4kEt2jWIVwolu898CvyPVCojgRMQbQOdWafzA5kEQY2sf8bfGmSE1QMhHqEao9pGj1B103YrNY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fov7JQlMW1wP5Tuida+tdKgd0tCCrrS/cvvKjKP6iMw=;
 b=J6svKUf/Frrm38Bo/fAXWT4lulgF0BDIktNkQ6qS9DdBThwzYghiKkeL6NVLMmUv5Tz44Vlf8D4VQ9xDUT4PIcJ+LKlKjexbezRH38zW9Og/mtWmZk3iauEX0EgODGyvgKNPdimAVu5tN1njh7JJ6oWDxQ26lvaCLs1sw2DkM1Y=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5190.namprd03.prod.outlook.com (20.180.12.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 07:02:30 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 07:02:30 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Eugen.Hristev@microchip.com" <Eugen.Hristev@microchip.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "Ludovic.Desroches@microchip.com" <Ludovic.Desroches@microchip.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: at91-sama5d2_adc: fix
 iio_triggered_buffer_{predisable,postenable} positions
Thread-Topic: [PATCH] iio: at91-sama5d2_adc: fix
 iio_triggered_buffer_{predisable,postenable} positions
Thread-Index: AQHViXtdnDhd99DyyUetPzMU9xg88KecMFeAgARKfgCAAHDLAIABB6mA
Date:   Fri, 29 Nov 2019 07:02:29 +0000
Message-ID: <74aabb41107ab162660f21e726c88a9dd40ecc5e.camel@analog.com>
References: <20191023082508.17583-1-alexandru.ardelean@analog.com>
         <17cf55869cc418795d0013c0594ed8fc04381d46.camel@analog.com>
         <9df3d999-0ec6-a282-d24b-8f7df5f14f6d@microchip.com>
         <e43bf58f-223c-0b12-2912-6f353d866ec3@microchip.com>
In-Reply-To: <e43bf58f-223c-0b12-2912-6f353d866ec3@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37f99650-3ae2-4422-db8b-08d7749a19c4
x-ms-traffictypediagnostic: CH2PR03MB5190:
x-microsoft-antispam-prvs: <CH2PR03MB51904EFF61B10624D519BD4FF9460@CH2PR03MB5190.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(366004)(51914003)(189003)(199004)(14454004)(4326008)(7416002)(7736002)(305945005)(966005)(6246003)(6306002)(81166006)(81156014)(8676002)(8936002)(6116002)(478600001)(4001150100001)(3846002)(25786009)(229853002)(66066001)(110136005)(99286004)(2906002)(54906003)(316002)(86362001)(2201001)(5660300002)(6436002)(256004)(14444005)(5024004)(76176011)(11346002)(26005)(53546011)(2501003)(186003)(6486002)(6506007)(2616005)(71190400001)(71200400001)(446003)(102836004)(91956017)(76116006)(66476007)(66556008)(64756008)(66446008)(36756003)(6512007)(66946007)(118296001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5190;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SdUFwf2FVdWOyhXJ6uX1xJEHb3SMyKaf3jWTSsb1QDg7a6hhq5vbhpyK1s8rpcq4OMlCqZXe6HNzkYJdssU3IqntgMaTAI1P+qxxbQt75jcxQwzNYCS7g7fFGwjr2mrrHTY5nxgWS2F0+foeVz2+QpKn5y3s8M6Fq3mxBsTOWVq4t7wUoUQOHq3w2qIdttGFwnOs0xjQscVCD/oDbkowaE/rp0sTg996T4nJATQPz8belydOZDAjwdoMXUnngN1bKbIid1DQmOj5LFhEyipfkudDSo9RdqjzJ/PNSa2NDMvkbLyzMcnJ+SgU1sSpLSvYyTwpz55stNdHyP6qho8jxoAY7/Q/VuCckl9t3XVsIO9OTRt/urASOr1VS27N1H+6LLDVBcloTz6SQylE9CkRfnrrYHJjBZKVUHa1USXVsIRATppW8K1hQy9AhgRuy0N9RCl/K9pirpThDTRP5hmgJ7JaYRlVogl6tcOXHxD079U=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <18A5E31AD40D4D40B9A7CED31D886954@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f99650-3ae2-4422-db8b-08d7749a19c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 07:02:30.1405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9bhz2tHBq77U/Jx65NqPcQhFZER4fIyO9cGxi8tcgQoSJO72yFFTBOaFTM/VUotqWYB7vBHwv99HC3lW+6iv926sJhUFEgcGy+5VBHl5a0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5190
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_01:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911290059
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTI4IGF0IDE1OjE5ICswMDAwLCBFdWdlbi5IcmlzdGV2QG1pY3JvY2hp
cC5jb20gd3JvdGU6DQo+IA0KDQpIZXksDQoNClNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseS4NCkkn
bSBhbHNvIGp1Z2dsaW5nIGEgZmV3IHRoaW5ncy4NCg0KPiANCj4gT24gMjguMTEuMjAxOSAxMDoz
NiwgRXVnZW4uSHJpc3RldkBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiANCj4gPiBPbiAyNS4xMS4y
MDE5IDE3OjAzLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdyb3RlOg0KPiA+ID4gT24gV2VkLCAyMDE5
LTEwLTIzIGF0IDExOjI1ICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3JvdGU6DQo+ID4gPiA+
IFRoZSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl97cHJlZGlzYWJsZSxwb3N0ZW5hYmxlfSBmdW5jdGlv
bnMNCj4gPiA+ID4gYXR0YWNoL2RldGFjaA0KPiA+ID4gPiBwb2xsIGZ1bmN0aW9ucy4NCj4gPiA+
ID4gDQo+ID4gPiA+IFRoZSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wb3N0ZW5hYmxlKCkgc2hvdWxk
IGJlIGNhbGxlZCBmaXJzdCB0bw0KPiA+ID4gPiBhdHRhY2gNCj4gPiA+ID4gdGhlDQo+ID4gPiA+
IHBvbGwgZnVuY3Rpb24sIGFuZCB0aGVuIHRoZSBkcml2ZXIgY2FuIGluaXQgdGhlIGRhdGEgdG8g
YmUNCj4gPiA+ID4gdHJpZ2dlcmVkLg0KPiA+ID4gPiANCj4gPiA+ID4gU2ltaWxhcmx5LCBpaW9f
dHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKCkgc2hvdWxkIGJlIGNhbGxlZCBsYXN0DQo+ID4g
PiA+IHRvDQo+ID4gPiA+IGZpcnN0DQo+ID4gPiA+IGRpc2FibGUgdGhlIGRhdGEgKHRvIGJlIHRy
aWdnZXJlZCkgYW5kIHRoZW4gdGhlIHBvbGwgZnVuY3Rpb24NCj4gPiA+ID4gc2hvdWxkIGJlDQo+
ID4gPiA+IGRldGFjaGVkLg0KPiA+IA0KPiA+IEhpIEFsZXhhbmRydSwNCj4gPiANCj4gPiBTb3Jy
eSBmb3IgdGhpcyBsYXRlIHJlcGx5LA0KPiA+IA0KPiA+IEkgcmVtZW1iZXIgdGhhdCBieSBhZGRp
bmcgc3BlY2lmaWMgYXQ5MV9hZGMgY29kZSBmb3INCj4gPiBwcmVkaXNhYmxlL3Bvc3RlbmFibGUg
LCBJIHdhcyByZXBsYWNpbmcgdGhlIGV4aXN0aW5nIHN0YW5kYXJkIGNhbGxiYWNrDQo+ID4gd2l0
aCBteSBvd24sIGFuZCBoYXZlIG15IHNwZWNpZmljIGF0OTEgY29kZSBiZWZvcmUgcG9zdGVuYWJs
ZSBhbmQgdGhlbg0KPiA+IGNhbGxpbmcgdGhlIHN1YnN5c3RlbSBwb3N0ZW5hYmxlLA0KPiA+IGFu
ZCBpbiBzaW1pbGFyIHdheSwgZm9yIHByZWRpc2FibGUsIGZpcnN0IGNhbGwgdGhlIHN1YnN5c3Rl
bSBwcmVkaXNhYmxlDQo+ID4gdGhlbiBkb2luZyBteSBwcmVkaXNhYmxlIGNvZGUgKGluIHJldmVy
c2Ugb3JkZXIgYXMgaW4gcG9zdGVuYWJsZSkNCj4gPiANCj4gPiBJZiB5b3Ugc2F5IHRoZSBvcmRl
ciBzaG91bGQgYmUgcmV2ZXJzZWQgKGJhc2ljYWxseSBoYXZlIHRoZQ0KPiA+IHBvbGxmdW5jdGlv
bg0KPiA+IGZpcnN0KSwgaG93IGlzIGN1cnJlbnQgY29kZSB3b3JraW5nID8NCj4gPiBTaG91bGQg
Y3VycmVudCBjb2RlIGZhaWwgaWYgdGhlIHBvbGwgZnVuY3Rpb24gaXMgbm90IGF0dGFjaGVkIGlu
IHRpbWUgPw0KPiA+IE9yIHRoZXJlIGlzIGEgcmFjZSBiZXR3ZWVuIHRyaWdnZXJlZCBkYXRhIGFu
ZCB0aGUgYXR0YWNobWVudCBvZiB0aGUNCj4gPiBwb2xsZnVuYyA/DQo+ID4gDQo+ID4gSSBhbSB0
aGlua2luZyB0aGF0IGF0dGFjaGluZyB0aGUgcG9sbGZ1bmMgbGF0ZXIgbWFrZXMgaXQgd29yayBi
ZWNhdXNlDQo+ID4gdGhlIERNQSBpcyBub3Qgc3RhcnRlZCB5ZXQuIFdoYXQgaGFwcGVucyBpZiB3
ZSBoYXZlIHRoZSBwb2xsZnVuYw0KPiA+IGF0dGFjaGVkIGJ1dCBETUEgaXMgbm90IHN0YXJ0ZWQg
KGJhc2ljYWxseSB0aGUgdHJpZ2dlciBpcyBub3Qgc3RhcnRlZCkNCj4gPiAsDQo+ID4gY2FuIHRo
aXMgbGVhZCB0byB1bmV4cGVjdGVkIGJlaGF2aW9yID8gTGlrZSB0aGUgcG9sbGZ1bmMgcG9sbGlu
ZyBidXQgbm8NCj4gPiB0cmlnZ2VyIHN0YXJ0ZWQvbm8gRE1BIHN0YXJ0ZWQuDQo+IA0KPiBJIGxv
b2tlZCBhIGJpdCBtb3JlIGludG8gdGhlIGNvZGUgYW5kIGluIERNQSBjYXNlLCB1c2luZyBwb3N0
ZW5hYmxlIA0KPiBmaXJzdCB3aWxsIGxlYWQgdG8gY2FsbGluZyBhdHRhY2ggcG9sbGZ1bmMsIHdo
aWNoIHdpbGwgYWxzbyBlbmFibGUgdGhlIA0KPiB0cmlnZ2VyLCBidXQgdGhlIERNQSBpcyBub3Qg
eWV0IHN0YXJ0ZWQuDQo+IElzIHRoaXMgdGhlIGRlc2lyZWQgZWZmZWN0ID8gDQoNClllcy4NCg0K
PiBOb3JtYWxseSB3aGVuIHVzaW5nIERNQSBJIHdvdWxkIHNheSB3ZSANCj4gd291bGQgbmVlZCB0
byBlbmFibGUgRE1BIGZpcnN0IHRvIGJlIHJlYWR5IHRvIGNhcnJ5IGRhdGEgKGFuZCBjb2hlcmVu
dCANCj4gYXJlYSBldGMuKSBhbmQgdGhlbiBlbmFibGUgdGhlIHRyaWdnZXIuDQoNClNvLCB0aGVy
ZSBpcyBhIGNoYW5nZSBpbiBvdXIgdHJlZSBbZnJvbSBzb21lIHRpbWUgYWdvXS4NClNlZSBoZXJl
Og0KaHR0cHM6Ly9naXRodWIuY29tL2FuYWxvZ2RldmljZXNpbmMvbGludXgvY29tbWl0L2VlZTk3
ZDEyNjY1ZmVmOGNmNDI5YTFlNTAzNWIyM2FlOTY5NzA1YjgNCg0KUGFydGljdWxhcmx5LCB3aGF0
J3MgaW50ZXJlc3RpbmcgaXMgYXJvdW5kIGxpbmU6DQpodHRwczovL2dpdGh1Yi5jb20vYW5hbG9n
ZGV2aWNlc2luYy9saW51eC9jb21taXQvZWVlOTdkMTI2NjVmZWY4Y2Y0MjlhMWU1MDM1YjIzYWU5
Njk3MDViOCNkaWZmLTBhODc3NDRjZTk0NWQyYzFjODllYTE5ZjIxZmIzNWJiUjcyMg0KQW5kIHlv
dSBtYXkgbmVlZCB0byBleHBhbmQgc29tZSBzdHVmZiB0byBzZWUgbW9yZSBvZiB0aGUgZnVuY3Rp
b24tYm9keS4NCkFuZCBzb21lIHRoaW5ncyBtYXkgaGF2ZSBjaGFuZ2VkIGluIHVwc3RyZWFtIElJ
TyBzaW5jZSB0aGF0IGNoYW5nZS4NCg0KVGhlIGNoYW5nZSBpcyB0byBtYWtlIHRoZSBwb2xsZnVu
YyBhdHRhY2gvZGV0YWNoIGJlY29tZSBwYXJ0IG9mIHRoZSBJSU8NCmZyYW1ld29yaywgYmVjYXVz
ZSBwbGVudHkgb2YgZHJpdmVycyBqdXN0IGNhbGwNCmlpb190cmlnZ2VyZWRfYnVmZmVyX3Bvc3Rl
bmFibGUoKSAmIGlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRpc2FibGUoKSB0bw0KbWFudWFsbHkg
YXR0YWNoL2RldGFjaCB0aGUgcG9sbGZ1bmMgZm9yIHRyaWdnZXJlZCBidWZmZXJzLg0KDQpUaGF0
IGNoYW5nZSBpcyBmcm9tIDIwMTUsIGFuZCBzaW5jZSB0aGVuLCBzb21lIGRyaXZlcnMgd2VyZSBh
ZGRlZCB0aGF0IGp1c3QNCm1hbnVhbGx5IGF0dGFjaC9kZXRhY2ggdGhlIHBvbGxmdW5jIFthbmQg
ZG8gbm90aGluZyBtb3JlIHdpdGggdGhlDQpwb3N0ZW5hYmxlL3ByZWRpc2FibGUgaG9va3NdLg0K
DQpJIHRyaWVkIHRvIHVwc3RyZWFtIGEgbW9yZSBjb21wbGV0ZSB2ZXJzaW9uIG9mIHRoYXQgcGF0
Y2ggYSB3aGlsZSBhZ28gW3UxXS4NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gv
MTA0ODIxNjcvDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwNzM3MjkxLw0K
DQpUaGUgY29uY2x1c2lvbiB3YXMgdG8gZmlyc3QgZml4IHRoZSBhdHRhY2gvZGV0YWNoIHBvbGxm
dW5jIG9yZGVyIGluIGFsbCBJSU8NCmRyaXZlcnMsIHNvIHRoYXQgd2hlbiBwYXRjaCBbdTFdIGlz
IGFwcGxpZWQsIHRoZXJlIGlzIG5vIG1vcmUgZGlzY3Vzc2lvbg0KYWJvdXQgdGhlIGNvcnJlY3Qg
b3JkZXIgZm9yIGF0dGFjaC9kZXRhY2ggcG9sbGZ1bmMuDQoNCkNvbWluZyBiYWNrIGhlcmUgW2Fu
ZCB0byB5b3VyIHF1ZXN0aW9uXSwgbXkgYW5zd2VyIGlzOiBJIGRvbid0IGtub3cgaWYgdGhlDQph
dDkxIERNQSBuZWVkcyB0byBiZSBlbmFibGVkL2Rpc2FibGVkIGJlZm9yZS9hZnRlciB0aGUgcG9s
bGZ1bmMNCmF0dGFjaC9kZXRhY2guDQpUaGlzIHNvdW5kcyBsaWtlIHNwZWNpZmljIHN0dWZmIGZv
ciBhdDkxIFt3aGljaCBpcyBmaW5lXS4NCg0KSXQgY291bGQgYmUgdGhhdCBzb21lIG90aGVyIGhv
b2tzIG1heSBuZWVkIHRvIHVzZWQgdG8gZW5hYmxlIERNQQ0KYmVmb3JlL2FmdGVyIHRoZSBhdHRh
Y2gvZGV0YWNoIHBvbGxmdW5jLiBNYXliZSBwcmVlbmFibGUoKS9wb3N0ZGlzYWJsZSgpID8NCg0K
SW4gYW55IGNhc2UsIHdoYXQgSSB3b3VsZCBsaWtlIFt3aXRoIHRoaXMgZGlzY3Vzc2lvbl0sIGlz
IHRvIHJlc29sdmUgYQ0Kc2l0dWF0aW9uIHdoZXJlIHdlIGNhbiBnZXQgY2xvc2VyIHRvIG1vdmlu
ZyB0aGUgYXR0YWNoL3BvbGxmdW5jIGNvZGUgdG8gSUlPDQpjb3JlLiBTbywgaWYgQVQ5MSByZXF1
aXJlcyBhIGRpZmZlcmVudCBvcmRlcmluZywgSSB0aGluayB5b3Ugd291bGQgYmUgbW9yZQ0KYXBw
cm9wcmlhdGUgdG8gdGVsbCBtZSwgYW5kIHByb3Bvc2UgYW4gYWx0ZXJuYXRpdmUgdG8gdGhpcyBw
YXRjaC4NCg0KVGhhbmtzIDopDQpBbGV4DQoNCj4gDQo+ID4gPiA+IEZvciB0aGlzIGRyaXZlciwg
dGhlIHByZWRpc2FibGUgJiBwb3N0ZW5hYmxlIGhvb2tzIGFyZSBhbHNvIG5lZWQgdG8NCj4gPiA+
ID4gdGFrZQ0KPiA+ID4gPiBpbnRvIGNvbnNpZGVyYXRpb24gdGhlIHRvdWNoc2NyZWVuLCBzbyB0
aGUgaG9va3MgbmVlZCB0byBiZSBwdXQgaW4NCj4gPiA+ID4gcGxhY2VzDQo+ID4gPiA+IHRoYXQg
YXZvaWQgdGhlIGNvZGUgZm9yIHRoYXQgY2FyZXMgYWJvdXQgaXQuDQo+ID4gPiA+IA0KPiA+ID4g
DQo+ID4gPiBwaW5nIGhlcmUNCj4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5k
cnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gICAgZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYyB8IDE5ICsrKysr
KysrKystLS0tLS0tLS0NCj4gPiA+ID4gICAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYw0KPiA+ID4gPiBiL2RyaXZlcnMvaWlvL2FkYy9h
dDkxLQ0KPiA+ID4gPiBzYW1hNWQyX2FkYy5jDQo+ID4gPiA+IGluZGV4IGUxODUwZjNkNWNmMy4u
YWMzZTVjNGM5ODQwIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYXQ5MS1z
YW1hNWQyX2FkYy5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJf
YWRjLmMNCj4gPiA+ID4gQEAgLTg4OSwyMCArODg5LDI0IEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNf
YnVmZmVyX3Bvc3RlbmFibGUoc3RydWN0DQo+ID4gPiA+IGlpb19kZXYgKmluZGlvX2RldikNCj4g
PiA+ID4gICAgICAgICBpZiAoIShpbmRpb19kZXYtPmN1cnJlbnRtb2RlICYgSU5ESU9fQUxMX1RS
SUdHRVJFRF9NT0RFUykpDQo+ID4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsN
Cj4gPiA+ID4gDQo+ID4gPiA+ICsgICAgIHJldCA9IGlpb190cmlnZ2VyZWRfYnVmZmVyX3Bvc3Rl
bmFibGUoaW5kaW9fZGV2KTsNCj4gPiA+ID4gKyAgICAgaWYgKHJldCkNCj4gPiA+ID4gKyAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICAgICAgICAgLyogd2UgY29u
dGludWUgd2l0aCB0aGUgdHJpZ2dlcmVkIGJ1ZmZlciAqLw0KPiA+ID4gPiAgICAgICAgIHJldCA9
IGF0OTFfYWRjX2RtYV9zdGFydChpbmRpb19kZXYpOw0KPiA+ID4gPiAgICAgICAgIGlmIChyZXQp
IHsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIGRldl9lcnIoJmluZGlvX2Rldi0+ZGV2LCAiYnVm
ZmVyIHBvc3RlbmFibGUNCj4gPiA+ID4gZmFpbGVkXG4iKTsNCj4gPiA+ID4gKyAgICAgICAgICAg
ICBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlvX2Rldik7DQo+ID4gPiA+ICAg
ICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gPiAgICAgICAgIH0NCj4gPiA+ID4gDQo+
ID4gPiA+IC0gICAgIHJldHVybiBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wb3N0ZW5hYmxlKGluZGlv
X2Rldik7DQo+ID4gPiA+ICsgICAgIHJldHVybiAwOw0KPiA+ID4gPiAgICB9DQo+ID4gPiA+IA0K
PiA+ID4gPiAgICBzdGF0aWMgaW50IGF0OTFfYWRjX2J1ZmZlcl9wcmVkaXNhYmxlKHN0cnVjdCBp
aW9fZGV2ICppbmRpb19kZXYpDQo+ID4gPiA+ICAgIHsNCj4gPiA+ID4gICAgICAgICBzdHJ1Y3Qg
YXQ5MV9hZGNfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gPiA+ID4gLSAgICAg
aW50IHJldDsNCj4gPiA+ID4gICAgICAgICB1OCBiaXQ7DQo+ID4gPiA+IA0KPiA+ID4gPiAgICAg
ICAgIC8qIGNoZWNrIGlmIHdlIGFyZSBkaXNhYmxpbmcgdHJpZ2dlcmVkIGJ1ZmZlciBvciB0aGUN
Cj4gPiA+ID4gdG91Y2hzY3JlZW4gKi8NCj4gPiA+ID4gQEAgLTkxNiwxMyArOTIwLDggQEAgc3Rh
dGljIGludCBhdDkxX2FkY19idWZmZXJfcHJlZGlzYWJsZShzdHJ1Y3QNCj4gPiA+ID4gaWlvX2Rl
dg0KPiA+ID4gPiAqaW5kaW9fZGV2KQ0KPiA+ID4gPiAgICAgICAgIGlmICghKGluZGlvX2Rldi0+
Y3VycmVudG1vZGUgJiBJTkRJT19BTExfVFJJR0dFUkVEX01PREVTKSkNCj4gPiA+ID4gICAgICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ID4gPiANCj4gPiA+ID4gLSAgICAgLyogY29u
dGludWUgd2l0aCB0aGUgdHJpZ2dlcmVkIGJ1ZmZlciAqLw0KPiA+ID4gPiAtICAgICByZXQgPSBp
aW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlvX2Rldik7DQo+ID4gPiA+IC0gICAg
IGlmIChyZXQgPCAwKQ0KPiA+ID4gPiAtICAgICAgICAgICAgIGRldl9lcnIoJmluZGlvX2Rldi0+
ZGV2LCAiYnVmZmVyIHByZWRpc2FibGUNCj4gPiA+ID4gZmFpbGVkXG4iKTsNCj4gPiA+ID4gLQ0K
PiA+ID4gPiAgICAgICAgIGlmICghc3QtPmRtYV9zdC5kbWFfY2hhbikNCj4gPiA+ID4gLSAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gPiArICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+
ID4gPiANCj4gPiA+ID4gICAgICAgICAvKiBpZiB3ZSBhcmUgdXNpbmcgRE1BIHdlIG11c3QgY2xl
YXIgcmVnaXN0ZXJzIGFuZCBlbmQgRE1BDQo+ID4gPiA+ICovDQo+ID4gPiA+ICAgICAgICAgZG1h
ZW5naW5lX3Rlcm1pbmF0ZV9zeW5jKHN0LT5kbWFfc3QuZG1hX2NoYW4pOw0KPiA+ID4gPiBAQCAt
OTQ5LDcgKzk0OCw5IEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNfYnVmZmVyX3ByZWRpc2FibGUoc3Ry
dWN0DQo+ID4gPiA+IGlpb19kZXYNCj4gPiA+ID4gKmluZGlvX2RldikNCj4gPiA+ID4gDQo+ID4g
PiA+ICAgICAgICAgLyogcmVhZCBvdmVyZmxvdyByZWdpc3RlciB0byBjbGVhciBwb3NzaWJsZSBv
dmVyZmxvdyBzdGF0dXMNCj4gPiA+ID4gKi8NCj4gPiA+ID4gICAgICAgICBhdDkxX2FkY19yZWFk
bChzdCwgQVQ5MV9TQU1BNUQyX09WRVIpOw0KPiA+ID4gPiAtICAgICByZXR1cm4gcmV0Ow0KPiA+
ID4gPiArDQo+ID4gPiA+ICtvdXQ6DQo+ID4gDQo+ID4gSSB3b3VsZCBwcmVmZXIgaWYgdGhpcyBs
YWJlbCBpcyBuYW1lZCB3aXRoIGEgZnVuY3Rpb24gbmFtZSBwcmVmaXgsDQo+ID4gb3RoZXJ3aXNl
ICdvdXQnIGlzIHByZXR0eSBnZW5lcmljIGFuZCBjYW4gY29sbGlkZSB3aXRoIG90aGVyIHRoaW5n
cyBpbg0KPiA+IHRoZSBmaWxlLi4uIEkgd2FudCB0byBhdm9pZCBoYXZpbmcgYW4gb3V0MiAsIG91
dDMgbGF0ZXIgaWYgY29kZQ0KPiA+IGNoYW5nZXMuDQo+ID4gDQoNClN1cmUuDQpXaWxsIGRvIHRo
YXQuDQoNCkkgZGlkIG5vdCBib3RoZXIgbXVjaCB3aXRoIHRoZXNlIGxhYmVscywgYmVjYXVzZSBh
ZnRlciBhcHBseWluZyBbdTFdLCBzb21lDQpvZiB0aGVtIFttYXliZSBhbGxdIHNob3VsZCBnbyBh
d2F5Lg0KDQoNCj4gPiBUaGFua3MgZm9yIHRoZSBwYXRjaCwNCj4gPiBFdWdlbg0KPiA+IA0KPiA+
ID4gPiArICAgICByZXR1cm4gaWlvX3RyaWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19k
ZXYpOw0KPiA+ID4gPiAgICB9DQo+ID4gPiA+IA0KPiA+ID4gPiAgICBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGlpb19idWZmZXJfc2V0dXBfb3BzIGF0OTFfYnVmZmVyX3NldHVwX29wcyA9DQo+ID4gPiA+
IHsNCj4gPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQo+ID4gPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiA+ID4gbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCj4gPiA+IA0K
