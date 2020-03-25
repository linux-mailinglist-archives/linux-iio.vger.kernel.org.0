Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5C4192276
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 09:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgCYISF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 04:18:05 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:19368 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbgCYISF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 04:18:05 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02P89jTa031554;
        Wed, 25 Mar 2020 04:17:51 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ywcp9umy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 04:17:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jj0OfZaxpjohxKxc6gdMJq+n7AZVxrLC+GtbANm2NryGLJ4m0dN0dn+07WBG4sASctU25zY3ps7QI3swfE9oct8CqmaqlQDGYYJ7GvvBYZXIF9V+0guj2GYDT0uzII//G+N1R4w8SaycbkkeAbcCSuBB4L8SbzGCBbBuJTRsH6xYW+Oa9bfp2Ai7nxBCtLmFLi8zl3unS95KeYKV/Cw38tyPlWphJNKidJ19yW28rHSOphnuTsYXQTmdIfZ14O+P2vglOX1DyvJZZidUZRyhrI61UO2uJ00umpCrYW4qE68cgZ81L4P31d5w74CGsUVWWgJjr1I3h43mFk2rdh6z4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nb9cm2Znk402GUw5Mx+5anfostMWLQd1beWHyXiCSo=;
 b=WqVslhEz35g4cHIdYgoKKaIT9bNPeh/1RuSkH+x+wXNmKrXJwdPC81dFry2upYR+rJpCyZMnmTw8906PI+FH1D3FXXUWohPIMJeSO+MEaUQQNMjN27AyvHHnqrm3dx6MbIgMeR10HTPGQoDVFDovbUVLUFmqa/Enqp/guU+ZvKtE6WOX1yQpZ8k2NAvbeAoxc/gnIudLQ+9qguvknRim/4bpcEbRNK2lIU0NaM7NApKGclOioJI0ktviBHGG64xVrEgEqX0Y0bkN4x3Nk0zqS6TuIGP8u4+oD6LR2tp1retC/1IlVmVgPsI6fR5mtyyxHG+UCFmvl2t3OQ9HTVJAVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nb9cm2Znk402GUw5Mx+5anfostMWLQd1beWHyXiCSo=;
 b=mqHV7fZcxs7041nyMNJa7lIXp6oyzAiCVAvOEKZT2wHqm7CUXGuLE8Z8146MMh2BUVHGGSt4Qt8og6hbjQUvq48KZ+nGTo9ucFWVgpu94Sf7xlmMp1T0bBt117+RbgkwCQ6APiKYA12ODWSiixhoCcbPLG+QjL4wUnM52orKnQc=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4697.namprd03.prod.outlook.com (2603:10b6:5:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 25 Mar
 2020 08:17:50 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 08:17:50 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFC][PATCH] iio: buffer: Don't allow buffers without any
 channels enabled to be activated
Thread-Topic: [RFC][PATCH] iio: buffer: Don't allow buffers without any
 channels enabled to be activated
Thread-Index: AQHV/qOMaQfGGDt1gE2kT3ZmhM2cB6hRTteAgAAGwICAAghIAIAFoZKA
Date:   Wed, 25 Mar 2020 08:17:50 +0000
Message-ID: <9d2e372777bc93ac14365de0b4450d3de7aec0f6.camel@analog.com>
References: <20200320104031.31701-1-alexandru.ardelean@analog.com>
         <253007c8-38ed-acd8-a506-b22f34d03997@metafoo.de>
         <3c2ea62e060ae260536766c3ebdd7fe6a1ab5725.camel@analog.com>
         <20200321182144.4c3226ee@archlinux>
In-Reply-To: <20200321182144.4c3226ee@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f511e88-6760-4ad4-cca0-08d7d0950250
x-ms-traffictypediagnostic: DM6PR03MB4697:
x-microsoft-antispam-prvs: <DM6PR03MB4697C101EA6BD15EA2B0AC3BF9CE0@DM6PR03MB4697.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(39860400002)(396003)(86362001)(2906002)(53546011)(8936002)(54906003)(4326008)(316002)(71200400001)(6506007)(64756008)(26005)(8676002)(81166006)(6512007)(66946007)(66556008)(6486002)(91956017)(76116006)(66446008)(66476007)(81156014)(186003)(966005)(2616005)(5660300002)(6916009)(478600001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4697;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vMjV3loghEHX4EhB5bDJue0M78yJoC1n97I4bkydc4j//xkLYlWsLrLDfLgKCpwI9rSVS9zsc+7MD8xJkMGWOzHf7WgdaJYILxUnyzZJc5nQlE71L3+QtnDobHOhtyVznRrJ+HNb8zUxUHRaNSewpAgSvzWDtk6NZHn7pyJFg+XaBqhBbkCZGLjWfUY+dIOX0aZdS4J1JUOPvRqrCg/1Jq5Oj7UjCbfv5HWmIdOhLFkfOrx8XVfS6Q70rAFbR/qRmPpNCxpEyJrY1/1vzcyMrAIYSVvgInwzUhPKjnfO0TENZfQy9yDh75+JEDw28VDMmWFvErjiDVL1oSt4bQqf9Hnvcsrj1LBXFCL3+mSULah/aplKTr19JT2ktMlTUhIbc8jyDPDIII+PomLFyvWyMqgXFKVuuaNIf+iOri1n72NwSe3QEqzNlJAGQQ17NidIZxK/2psL0MRMZQUn3Mz8exzmghQNUFUbPrnExMGxHfiTAVJC5dokvBpUEIGSSyT8xukAtRRKCVOl9wd0zEvG9w==
x-ms-exchange-antispam-messagedata: GVGzGqLQtwPNMM+veGPrUAFSDHNujaRhDYhGpn+g8TM8m0X1gu69+v4LGyeVa9RejMTgnejNvHKX2eCfcHL2L7GkEjNArfbwJNd2sDTWPEFQBfmWyC5mDU56dMqaLzlYP8Y9IXWqMc9xW7gc5moa3g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE35D9F467103148B6F02228A3A00466@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f511e88-6760-4ad4-cca0-08d7d0950250
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 08:17:50.1649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s3eOAHv4da5smOe/jMUu+xndvWIoU+5XLOJFW7PgeVzWu557pZl+Apn0kPJ7RdVhF1zkODHtvdLnAAe6GVbxONv2zAIeR+9d29nkfO3U6Ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4697
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_01:2020-03-23,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250069
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDIwLTAzLTIxIGF0IDE4OjIxICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBGcmksIDIwIE1hciAyMDIwIDExOjE2OjEyICswMDAwDQo+ICJBcmRlbGVhbiwgQWxl
eGFuZHJ1IiA8YWxleGFuZHJ1LkFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBP
biBGcmksIDIwMjAtMDMtMjAgYXQgMTE6NTUgKzAxMDAsIExhcnMtUGV0ZXIgQ2xhdXNlbiB3cm90
ZToNCj4gPiA+IE9uIDMvMjAvMjAgMTE6NDAgQU0sIEFsZXhhbmRydSBBcmRlbGVhbiB3cm90ZTog
IA0KPiA+ID4gPiBGcm9tOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4g
PiA+ID4gDQo+ID4gPiA+IEJlZm9yZSBhY3RpdmF0aW5nIGEgYnVmZmVyIG1ha2Ugc3VyZSB0aGF0
IGF0IGxlYXN0IG9uZSBjaGFubmVsIGlzDQo+ID4gPiA+IGVuYWJsZWQuDQo+ID4gPiA+IEFjdGl2
YXRpbmcgYSBidWZmZXIgd2l0aCAwIGNoYW5uZWxzIGVuYWJsZWQgZG9lc24ndCBtYWtlIHRvbyBt
dWNoIHNlbnNlDQo+ID4gPiA+IGFuZA0KPiA+ID4gPiBkaXNhbGxvd2luZyB0aGlzIGNhc2UgbWFr
ZXMgc3VyZSB0aGF0IGluZGl2aWR1YWwgZHJpdmVyIGRvbid0IGhhdmUgdG8NCj4gPiA+ID4gYWRk
DQo+ID4gPiA+IHNwZWNpYWwgY2FzZSBjb2RlIHRvIGhhbmRsZSBpdC4NCj4gPiA+ID4gDQo+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRl
bGVhbkBhbmFsb2cuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gDQo+ID4gPiA+ICogRm91bmQg
dGhpcyByZWxpYy1wYXRjaCBpbiBvdXIgdHJlZSwgZnJvbSA2IHllYXJzIGFnbzoNCj4gPiA+ID4g
ICAgaHR0cHM6Ly9naXRodWIuY29tL2FuYWxvZ2RldmljZXNpbmMvbGludXgvY29tbWl0LzZkNjgw
ZTQ5ZDQ1OWMNCj4gPiA+ID4gICAgSXQgZ290IG1vdmVkIGFyb3VuZCBhIGJpdCwgYW5kIHRoaXMg
aXMgdGhlIGN1cnJlbnQgZm9ybSBpbiB0aGUgQURJDQo+ID4gPiA+IHRyZWUuDQo+ID4gPiA+ICAg
IFNvLCB0aGlzIGlzIGFsc28gYSBiaXQgb2YgYW4gUkZDLCBidXQgaWYgdGhlIGlkZWEgaXMgdmFs
aWQsIG1heWJlDQo+ID4gPiA+IGl0J3MNCj4gPiA+ID4gICAgd29ydGggY29uc2lkZXJpbmcgdXBz
dHJlYW0uIEkgZG9uJ3Qga25vdyBvZiBhbnkgYXJndW1lbnRzIGFnYWluc3QgaXQsDQo+ID4gPiA+
ICAgIGJ1dCBJIGNvdWxkIGJlIHN1cnByaXNlZC4gIA0KPiA+ID4gDQo+ID4gPiBIbSwgYSBiaXQg
d2VpcmQgdGhhdCB0aGlzIG9uZSBuZXZlciBtYWRlIGl0IHVwc3RyZWFtIGNvbnNpZGVyaW5nIGhv
dyANCj4gPiA+IHNpbXBsZSBpdCBpcy4NCj4gPiA+IA0KPiA+ID4gRGlkIHlvdSBjaGVjayB0aGF0
IHRoZSBpc3N1ZSBzdGlsbCBvY2N1cnM/IEkgY2FuJ3Qgc2VlIGFueXRoaW5nIGluIHRoZSANCj4g
PiA+IGNvZGUgdGhhdCBwcmV2ZW50cyBpdCwgYnV0IHdobyBrbm93cywgbWF5YmUgaXQgd2FzIGZp
eGVkIGJ5IHNvbWV0aGluZw0KPiA+ID4gZWxzZS4gIA0KPiA+IA0KPiA+IGkgZGlkIG5vdCB0aGlu
ayB0byBjaGVjayBiZWhhdmlvci9pc3N1ZXM7DQo+ID4gaSdsbCB0cnkgdG8gbWFrZSBzb21lIHRp
bWUgZm9yIHRoYXQ7DQo+IA0KPiBJIGNhbid0IGltbWVkaWF0ZWx5IHRoaW5rIG9mIGFueXRoaW5n
IHRoYXQgd291bGQgc3RvcCB0aGlzIGNhc2UuDQo+IA0KPiBIb3dldmVyLCBnb29kIGlmIHlvdSBj
b3VsZCBjb25maXJtIGl0LiAgKEkgZG9uJ3QgaGF2ZSBhIHNldHVwIHJ1bm5pbmcNCj4gcmlnaHQg
bm93IHRvIHRlc3QgYWdhaW5zdCkNCg0KDQpJJ3ZlIGluc3RydW1lbnRlZCB0aGUgY29kZSBhIGJp
dC4NClNvLCB3aXRoIHRoaXMgY2hhbmdlIFttb3ZlZCBpbiBpaW9fdmVyaWZ5X3VwZGF0ZSgpIGFz
IExhcnMgc3VnZ2VzdGVkXToNCg0Kcm9vdEBhbmFsb2c6fiMgY2QgL3N5cy9idXMvaWlvL2Rldmlj
ZXMvaWlvXDpkZXZpY2UzL2J1ZmZlcg0Kcm9vdEBhbmFsb2c6L3N5cy9idXMvaWlvL2RldmljZXMv
aWlvOmRldmljZTMvYnVmZmVyIyBlY2hvIDEgPiBlbmFibGUgDQowMDAwMDAwMDAgaWlvX3Zlcmlm
eV91cGRhdGUgNzQ4DQogICAgICAgICAgaW5kaW9fZGV2LT5tYXNrbGVuZ3RoIDINCiAgICAgICAg
ICAqaW5zZXJ0X2J1ZmZlci0+c2Nhbl9tYXNrIDAwMDAwMDAwDQoxMTExMTExMSBpaW9fdmVyaWZ5
X3VwZGF0ZSA3NTMNCjIyMjIyMiBfX2lpb191cGRhdGVfYnVmZmVycyAxMTE1IHJldCAtMjINCjMz
MzMzMzMzMyBpaW9fYnVmZmVyX3N0b3JlX2VuYWJsZSAxMjQxIHJldCAtMjINCi1iYXNoOiBlY2hv
OiB3cml0ZSBlcnJvcjogSW52YWxpZCBhcmd1bWVudA0KDQpzbywgMTExMTExMTEsIDIyMjIyMiAm
IDMzMzMzMzMzMyBhcmUgYWxsIGVycm9yIHBhdGhzLg0KDQpXaXRob3V0IHRoZSBwYXRjaDoNCg0K
cm9vdEBhbmFsb2c6fiMgY2QgL3N5cy9idXMvaWlvL2RldmljZXMvaWlvXDpkZXZpY2UzL2J1ZmZl
cg0Kcm9vdEBhbmFsb2c6L3N5cy9idXMvaWlvL2RldmljZXMvaWlvOmRldmljZTMvYnVmZmVyIyBl
Y2hvIDEgPiBlbmFibGUNCjAwMDAwMDAwMCBpaW9fdmVyaWZ5X3VwZGF0ZSA3NDggDQogICAgICAg
ICAgaW5kaW9fZGV2LT5tYXNrbGVuZ3RoIDIgDQogICAgICAgICAgKmluc2VydF9idWZmZXItPnNj
YW5fbWFzayAwMDAwMDAwMA0Kcm9vdEBhbmFsb2c6L3N5cy9idXMvaWlvL2RldmljZXMvaWlvOmRl
dmljZTMvYnVmZmVyIyANCg0Kbm8gZXJyb3IgcGF0aCBpcyBoaXQ7DQplcnJvciBwYXRocyBhcmUg
c3RpbGwgdGhlcmUsIGJ1dCB0aGUgYml0bWFwX2VtcHR5KCkgY2hlY2sgcmVtb3ZlZDsNCg0KU28s
IGJ1ZmZlciBnZXRzIGVuYWJsZWQsIGJ1dCBzY2FuX21hc2sgaXMgZW1wdHkuDQoNCldpbGwgZm9s
bG93LXVwIGEgVjIgb24gdGhpcyBhbmQgYXR0YWNoIHRoaXMgaW5mb3JtYXRpb24uDQoNCg0KPiAN
Cj4gDQo+ID4gaSBjYXVnaHQgdGhpcyBvbmUgd2hpbGUgZGlmZi1pbmcgdGhlIHVwc3RyZWFtICYg
QURJIHRyZWVzLCBhbmQgaSBuZWVkZWQgdG8NCj4gPiBkaWcgYQ0KPiA+IGJpdCBtb3JlIGludG8g
dGhlIEFESSBnaXQgaGlzdG9yeSBvbiBpdDsNCj4gPiANCj4gPiBpIHdhcyBhIGJpdCBwdXp6bGVk
IGZvciBhIHdoaWxlLCBiZWNhdXNlIHNvbWUgcmV3b3JrIHBhdGNoZXMgd2VyZSB1cHN0cmVhbWVk
DQo+ID4gd2l0aG91dCB0aGlzIHBhdGNoOg0KPiA+IA0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWlpby81NTU4NUNBQS42MDAwNTA2QGtlcm5lbC5vcmcvDQo+ID4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtaWlvLzU1NjA2ODVBLjUwNjA1MDRAa2VybmVsLm9yZy8NCj4g
PiANCj4gPiBpIGFsc28gZGlkIG5vdCBmaW5kIGFueSBkaXNjdXNzaW9ucy91cHN0cmVhbSBhdHRl
bXB0IGZvciB0aGlzIHBhdGNoDQo+ID4gcGFydGljdWxhcmx5DQo+ID4gDQo+ID4gc28sIGl0IHdh
cyBlYXNpZXIgZm9yIG1lIGp1c3QgdG8gUkZDIHRoaXMNCj4gPiANCj4gPiA+ICAgDQo+ID4gPiA+
ICAgZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jIHwgNiArKysrKysNCj4gPiA+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+ID4gPiA+IGIvZHJp
dmVycy9paW8vaW5kdXN0cmlhbGlvLQ0KPiA+ID4gPiBidWZmZXIuYw0KPiA+ID4gPiBpbmRleCA0
YWRhNTU5MmFhMmIuLmYyMjJhMTE4ZDBkMyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9p
aW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2luZHVz
dHJpYWxpby1idWZmZXIuYw0KPiA+ID4gPiBAQCAtMTAzMSw2ICsxMDMxLDEyIEBAIHN0YXRpYyBp
bnQgX19paW9fdXBkYXRlX2J1ZmZlcnMoc3RydWN0IGlpb19kZXYNCj4gPiA+ID4gKmluZGlvX2Rl
diwNCj4gPiA+ID4gICAJCXJldHVybiByZXQ7DQo+ID4gPiA+ICAgDQo+ID4gPiA+ICAgCWlmIChp
bnNlcnRfYnVmZmVyKSB7DQo+ID4gPiA+ICsJCWlmIChiaXRtYXBfZW1wdHkoaW5zZXJ0X2J1ZmZl
ci0+c2Nhbl9tYXNrLA0KPiA+ID4gPiArCQkJaW5kaW9fZGV2LT5tYXNrbGVuZ3RoKSkgew0KPiA+
ID4gPiArCQkJcmV0ID0gLUVJTlZBTDsNCj4gPiA+ID4gKwkJCWdvdG8gZXJyX2ZyZWVfY29uZmln
Ow0KPiA+ID4gPiArCQl9ICANCj4gPiA+IA0KPiA+ID4gU2luY2UgdGhlIGNoZWNrIGlzIHNvIHNp
bXBsZSBpdCBtaWdodCBtYWtlIHNlbnNlIHRvIGRvIGl0IGFzIHRoZSB2ZXJ5IA0KPiA+ID4gZmly
c3QgdGhpbmcgYmVmb3JlIGlpb192ZXJpZnlfdXBkYXRlKCkuICANCj4gPiANCj4gPiB3b3JrcyBm
b3IgbWU7DQo+ID4gDQo+ID4gPiAgIA0KPiA+ID4gPiArDQo+ID4gPiA+ICAgCQlyZXQgPSBpaW9f
YnVmZmVyX3JlcXVlc3RfdXBkYXRlKGluZGlvX2RldiwNCj4gPiA+ID4gaW5zZXJ0X2J1ZmZlcik7
DQo+ID4gPiA+ICAgCQlpZiAocmV0KQ0KPiA+ID4gPiAgIAkJCWdvdG8gZXJyX2ZyZWVfY29uZmln
Ow0KPiA+ID4gPiAgIA0K
