Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFED019228E
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 09:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgCYIXq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 04:23:46 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:9578 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbgCYIXq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 04:23:46 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02P8KZ0i024813;
        Wed, 25 Mar 2020 04:23:32 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ywfj6ub4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 04:23:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Soqp292xO5JK3zmqujnVhClS3bdc2cxyisnHZFu7HO2yiGVe0XDVz5qWDdzL1STO1u4vDsMQJkzLUlYz8IIq9WdqsQVa/3voRLe7f4Y9Qm5KZ6QHoUa3As1aUI4prKsF1vS8jcpamLpCwOTcaks6ThMCNJ8eC+1Qk7+6bXw9vW2oVebBxzXnE+cnBFcjMmbFqFyhL4HuKPhHI5rLWW8obUMm0N26kVVRN6yfFJI514Y48sbNO0eQngKRsvth2ikOgZwrmzeXJ1uyyZFtS7NjBdM+OJI0vxHEc3Y1A9kYV+WHd8qzrLl8EPCL+lQW3k8nXAtXQyr+vD7v5CPjtZ20pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maCuZ83IoOMGsly6XRfSo4M0fQK7HamWrgehFLfdhrU=;
 b=Qph01JXS7yvINlvfMwlFWbi7trCW8KFgaqDykdTnQ9GTsDeZGdtV6PaZ1FY1fUX6ZHvy57lHsv6J3J55MHRr+h1uAMK4oRZqGQNp/XX5XfelGoe+4OgvYq5FKNEe5p6KaSNvo9MBa9Oq+6oye9m+B4eAx7iukHvXyZGSmERWas5EVbzSxMdy8yptuIOEgUcapLhC4NEZi6RofUz0zpRWLwVJYWsDbbD+FclwX/CAH0K9g9EJ15GopCYavXFNjpdRa9D19aUHUcTXO8lg1+dLLWZRSNK5DIaiHSAMCA0IaZt2KmvWktsdqwormTVeTKbcj/zPHSclZ1rOCW+Y3kRu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maCuZ83IoOMGsly6XRfSo4M0fQK7HamWrgehFLfdhrU=;
 b=wrwylcjS1JyiwJyWuiqAeXzWDqiw9eK7iYiTBILcCft6srxIzm7v1S7zmW1QgtaqO0qtXK2o6cCSkedMesNMdHRwIpnfJof1IDL+/0nKJBqcQxBGNLjYYzjpp0TeYyECyImSgbdNAmqpEAQi3GGpg5NEavwmwf+xuJ8SCAqJwhQ=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4697.namprd03.prod.outlook.com (2603:10b6:5:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 25 Mar
 2020 08:23:30 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 08:23:30 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFC][PATCH] iio: buffer: Don't allow buffers without any
 channels enabled to be activated
Thread-Topic: [RFC][PATCH] iio: buffer: Don't allow buffers without any
 channels enabled to be activated
Thread-Index: AQHV/qOMaQfGGDt1gE2kT3ZmhM2cB6hRTteAgAAGwICAAghIAIAFoZKAgAABlYA=
Date:   Wed, 25 Mar 2020 08:23:30 +0000
Message-ID: <51a057b30114099089883f986914560d8b9d25d3.camel@analog.com>
References: <20200320104031.31701-1-alexandru.ardelean@analog.com>
         <253007c8-38ed-acd8-a506-b22f34d03997@metafoo.de>
         <3c2ea62e060ae260536766c3ebdd7fe6a1ab5725.camel@analog.com>
         <20200321182144.4c3226ee@archlinux>
         <9d2e372777bc93ac14365de0b4450d3de7aec0f6.camel@analog.com>
In-Reply-To: <9d2e372777bc93ac14365de0b4450d3de7aec0f6.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45bb7a7f-2b0b-4ef7-ecf8-08d7d095cd16
x-ms-traffictypediagnostic: DM6PR03MB4697:
x-microsoft-antispam-prvs: <DM6PR03MB46971D6B41CB1A27D135CEF6F9CE0@DM6PR03MB4697.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(39860400002)(396003)(86362001)(2906002)(53546011)(8936002)(54906003)(4326008)(316002)(71200400001)(6506007)(64756008)(26005)(8676002)(81166006)(6512007)(66946007)(66556008)(6486002)(91956017)(76116006)(66446008)(66476007)(81156014)(186003)(966005)(2616005)(5660300002)(6916009)(478600001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4697;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HFfOMTIt4sBF1ZYBJ4RCbFD250w0/TRoFJbcnq78KaAHSZNDLfl3K8BUM6WLrReXh/2SlGnBbueT2qMPHAy7reqtaNQZR/a4fXTDeZYlUElKFMa8pFpSA9ay+PnJ/y6cHM1QoG98B9UwmDJRJUn2GWPfWmaFybO//TVczxwPcPhjiZOjejSMPvvGK5d5vMjan00s7Wh52MIhYw+4FAsDbYwy+qq8wZ4tN6wFAu77pXcWmY9z2hPr4oBRrgTdcd6tLCukDR0eTluyCxgWsjqMtOZVTUgN6ZeCk4VaD8VSb+oNorIYoSxGFpdIjjnhxkhiIL7CR1qBxxIVY6MW32dDOtUQzwbSZPjX2CBztIAnTkHl+RkS2cZ2Cw69lWEQ2VYg3AsYQTgx+SmDvE0sZJViTovK4bTFa5k5Xl8odJ65AfBL13hGWHUmmj1CJ8QJUf4wHUDaKEXAOeS4YsQfCkbEYSBP1n0kWmAYfez9369La/5B9Mxo0kypedjzIH+Y9w5DRQXw7xrNMPFZgG6Ez7p9PQ==
x-ms-exchange-antispam-messagedata: zHNeP0NzdNml5KYw/+fqwY8OfzcgVABViASZdY651XpKLlkYcslPRT6vZjwCnHdKjY1vJAKJoD5fCuMSkpSsLXLCsqtVLIF3Z6PVXq7juJbqemAzsyUhDf6OvWahotRrZwngeHXhWjQB3LuMSUFtAw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4035DC2CB71A9F41A22D7CC3708C445D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bb7a7f-2b0b-4ef7-ecf8-08d7d095cd16
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 08:23:30.4741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7DS8MrVCLLaNTRhoFKYXG4m61tHH9dzPW0AIngMWSEF+F77SaRn+Rs8c3Cvv9ioyOOWXy7Dm28iGDyLlp0FyjdBWpe5nWJ9uRTR3RsX7pBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4697
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_01:2020-03-23,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250070
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTI1IGF0IDA4OjE3ICswMDAwLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdy
b3RlOg0KPiBPbiBTYXQsIDIwMjAtMDMtMjEgYXQgMTg6MjEgKzAwMDAsIEpvbmF0aGFuIENhbWVy
b24gd3JvdGU6DQo+ID4gT24gRnJpLCAyMCBNYXIgMjAyMCAxMToxNjoxMiArMDAwMA0KPiA+ICJB
cmRlbGVhbiwgQWxleGFuZHJ1IiA8YWxleGFuZHJ1LkFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3Rl
Og0KPiA+IA0KPiA+ID4gT24gRnJpLCAyMDIwLTAzLTIwIGF0IDExOjU1ICswMTAwLCBMYXJzLVBl
dGVyIENsYXVzZW4gd3JvdGU6DQo+ID4gPiA+IE9uIDMvMjAvMjAgMTE6NDAgQU0sIEFsZXhhbmRy
dSBBcmRlbGVhbiB3cm90ZTogIA0KPiA+ID4gPiA+IEZyb206IExhcnMtUGV0ZXIgQ2xhdXNlbiA8
bGFyc0BtZXRhZm9vLmRlPg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEJlZm9yZSBhY3RpdmF0aW5n
IGEgYnVmZmVyIG1ha2Ugc3VyZSB0aGF0IGF0IGxlYXN0IG9uZSBjaGFubmVsIGlzDQo+ID4gPiA+
ID4gZW5hYmxlZC4NCj4gPiA+ID4gPiBBY3RpdmF0aW5nIGEgYnVmZmVyIHdpdGggMCBjaGFubmVs
cyBlbmFibGVkIGRvZXNuJ3QgbWFrZSB0b28gbXVjaA0KPiA+ID4gPiA+IHNlbnNlDQo+ID4gPiA+
ID4gYW5kDQo+ID4gPiA+ID4gZGlzYWxsb3dpbmcgdGhpcyBjYXNlIG1ha2VzIHN1cmUgdGhhdCBp
bmRpdmlkdWFsIGRyaXZlciBkb24ndCBoYXZlIHRvDQo+ID4gPiA+ID4gYWRkDQo+ID4gPiA+ID4g
c3BlY2lhbCBjYXNlIGNvZGUgdG8gaGFuZGxlIGl0Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPiA+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFu
QGFuYWxvZy5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gKiBGb3Vu
ZCB0aGlzIHJlbGljLXBhdGNoIGluIG91ciB0cmVlLCBmcm9tIDYgeWVhcnMgYWdvOg0KPiA+ID4g
PiA+ICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9hbmFsb2dkZXZpY2VzaW5jL2xpbnV4L2NvbW1pdC82
ZDY4MGU0OWQ0NTljDQo+ID4gPiA+ID4gICAgSXQgZ290IG1vdmVkIGFyb3VuZCBhIGJpdCwgYW5k
IHRoaXMgaXMgdGhlIGN1cnJlbnQgZm9ybSBpbiB0aGUgQURJDQo+ID4gPiA+ID4gdHJlZS4NCj4g
PiA+ID4gPiAgICBTbywgdGhpcyBpcyBhbHNvIGEgYml0IG9mIGFuIFJGQywgYnV0IGlmIHRoZSBp
ZGVhIGlzIHZhbGlkLCBtYXliZQ0KPiA+ID4gPiA+IGl0J3MNCj4gPiA+ID4gPiAgICB3b3J0aCBj
b25zaWRlcmluZyB1cHN0cmVhbS4gSSBkb24ndCBrbm93IG9mIGFueSBhcmd1bWVudHMgYWdhaW5z
dA0KPiA+ID4gPiA+IGl0LA0KPiA+ID4gPiA+ICAgIGJ1dCBJIGNvdWxkIGJlIHN1cnByaXNlZC4g
IA0KPiA+ID4gPiANCj4gPiA+ID4gSG0sIGEgYml0IHdlaXJkIHRoYXQgdGhpcyBvbmUgbmV2ZXIg
bWFkZSBpdCB1cHN0cmVhbSBjb25zaWRlcmluZyBob3cgDQo+ID4gPiA+IHNpbXBsZSBpdCBpcy4N
Cj4gPiA+ID4gDQo+ID4gPiA+IERpZCB5b3UgY2hlY2sgdGhhdCB0aGUgaXNzdWUgc3RpbGwgb2Nj
dXJzPyBJIGNhbid0IHNlZSBhbnl0aGluZyBpbiB0aGUgDQo+ID4gPiA+IGNvZGUgdGhhdCBwcmV2
ZW50cyBpdCwgYnV0IHdobyBrbm93cywgbWF5YmUgaXQgd2FzIGZpeGVkIGJ5IHNvbWV0aGluZw0K
PiA+ID4gPiBlbHNlLiAgDQo+ID4gPiANCj4gPiA+IGkgZGlkIG5vdCB0aGluayB0byBjaGVjayBi
ZWhhdmlvci9pc3N1ZXM7DQo+ID4gPiBpJ2xsIHRyeSB0byBtYWtlIHNvbWUgdGltZSBmb3IgdGhh
dDsNCj4gPiANCj4gPiBJIGNhbid0IGltbWVkaWF0ZWx5IHRoaW5rIG9mIGFueXRoaW5nIHRoYXQg
d291bGQgc3RvcCB0aGlzIGNhc2UuDQo+ID4gDQo+ID4gSG93ZXZlciwgZ29vZCBpZiB5b3UgY291
bGQgY29uZmlybSBpdC4gIChJIGRvbid0IGhhdmUgYSBzZXR1cCBydW5uaW5nDQo+ID4gcmlnaHQg
bm93IHRvIHRlc3QgYWdhaW5zdCkNCj4gDQo+IEkndmUgaW5zdHJ1bWVudGVkIHRoZSBjb2RlIGEg
Yml0Lg0KPiBTbywgd2l0aCB0aGlzIGNoYW5nZSBbbW92ZWQgaW4gaWlvX3ZlcmlmeV91cGRhdGUo
KSBhcyBMYXJzIHN1Z2dlc3RlZF06DQo+IA0KPiByb290QGFuYWxvZzp+IyBjZCAvc3lzL2J1cy9p
aW8vZGV2aWNlcy9paW9cOmRldmljZTMvYnVmZmVyDQo+IHJvb3RAYW5hbG9nOi9zeXMvYnVzL2lp
by9kZXZpY2VzL2lpbzpkZXZpY2UzL2J1ZmZlciMgZWNobyAxID4gZW5hYmxlIA0KPiAwMDAwMDAw
MDAgaWlvX3ZlcmlmeV91cGRhdGUgNzQ4DQo+ICAgICAgICAgICBpbmRpb19kZXYtPm1hc2tsZW5n
dGggMg0KPiAgICAgICAgICAgKmluc2VydF9idWZmZXItPnNjYW5fbWFzayAwMDAwMDAwMA0KPiAx
MTExMTExMSBpaW9fdmVyaWZ5X3VwZGF0ZSA3NTMNCj4gMjIyMjIyIF9faWlvX3VwZGF0ZV9idWZm
ZXJzIDExMTUgcmV0IC0yMg0KPiAzMzMzMzMzMzMgaWlvX2J1ZmZlcl9zdG9yZV9lbmFibGUgMTI0
MSByZXQgLTIyDQo+IC1iYXNoOiBlY2hvOiB3cml0ZSBlcnJvcjogSW52YWxpZCBhcmd1bWVudA0K
PiANCj4gc28sIDExMTExMTExLCAyMjIyMjIgJiAzMzMzMzMzMzMgYXJlIGFsbCBlcnJvciBwYXRo
cy4NCj4gDQo+IFdpdGhvdXQgdGhlIHBhdGNoOg0KPiANCj4gcm9vdEBhbmFsb2c6fiMgY2QgL3N5
cy9idXMvaWlvL2RldmljZXMvaWlvXDpkZXZpY2UzL2J1ZmZlcg0KPiByb290QGFuYWxvZzovc3lz
L2J1cy9paW8vZGV2aWNlcy9paW86ZGV2aWNlMy9idWZmZXIjIGVjaG8gMSA+IGVuYWJsZQ0KPiAw
MDAwMDAwMDAgaWlvX3ZlcmlmeV91cGRhdGUgNzQ4IA0KPiAgICAgICAgICAgaW5kaW9fZGV2LT5t
YXNrbGVuZ3RoIDIgDQo+ICAgICAgICAgICAqaW5zZXJ0X2J1ZmZlci0+c2Nhbl9tYXNrIDAwMDAw
MDAwDQo+IHJvb3RAYW5hbG9nOi9zeXMvYnVzL2lpby9kZXZpY2VzL2lpbzpkZXZpY2UzL2J1ZmZl
ciMgDQo+IA0KPiBubyBlcnJvciBwYXRoIGlzIGhpdDsNCj4gZXJyb3IgcGF0aHMgYXJlIHN0aWxs
IHRoZXJlLCBidXQgdGhlIGJpdG1hcF9lbXB0eSgpIGNoZWNrIHJlbW92ZWQ7DQo+IA0KPiBTbywg
YnVmZmVyIGdldHMgZW5hYmxlZCwgYnV0IHNjYW5fbWFzayBpcyBlbXB0eS4NCj4gDQo+IFdpbGwg
Zm9sbG93LXVwIGEgVjIgb24gdGhpcyBhbmQgYXR0YWNoIHRoaXMgaW5mb3JtYXRpb24uDQoNClJp
Z2h0Lg0KQXMgYSBxdWljayBmb2xsb3ctdXAgaGVyZTogaWYgdGhlIHNjYW5fbWFzayBpcyBub3Qg
ZW1wdHkgW2kuZS4gYXQgbGVhc3Qgb25lDQpzY2FuX2VsZW1lbnQgaXMgZW5hYmxlZF0gYWxsIHdv
cmtzIGZpbmUuDQoNCj4gDQo+IA0KPiA+IA0KPiA+ID4gaSBjYXVnaHQgdGhpcyBvbmUgd2hpbGUg
ZGlmZi1pbmcgdGhlIHVwc3RyZWFtICYgQURJIHRyZWVzLCBhbmQgaSBuZWVkZWQgdG8NCj4gPiA+
IGRpZyBhDQo+ID4gPiBiaXQgbW9yZSBpbnRvIHRoZSBBREkgZ2l0IGhpc3Rvcnkgb24gaXQ7DQo+
ID4gPiANCj4gPiA+IGkgd2FzIGEgYml0IHB1enpsZWQgZm9yIGEgd2hpbGUsIGJlY2F1c2Ugc29t
ZSByZXdvcmsgcGF0Y2hlcyB3ZXJlDQo+ID4gPiB1cHN0cmVhbWVkDQo+ID4gPiB3aXRob3V0IHRo
aXMgcGF0Y2g6DQo+ID4gPiANCj4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlp
by81NTU4NUNBQS42MDAwNTA2QGtlcm5lbC5vcmcvDQo+ID4gPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1paW8vNTU2MDY4NUEuNTA2MDUwNEBrZXJuZWwub3JnLw0KPiA+ID4gDQo+ID4g
PiBpIGFsc28gZGlkIG5vdCBmaW5kIGFueSBkaXNjdXNzaW9ucy91cHN0cmVhbSBhdHRlbXB0IGZv
ciB0aGlzIHBhdGNoDQo+ID4gPiBwYXJ0aWN1bGFybHkNCj4gPiA+IA0KPiA+ID4gc28sIGl0IHdh
cyBlYXNpZXIgZm9yIG1lIGp1c3QgdG8gUkZDIHRoaXMNCj4gPiA+IA0KPiA+ID4gPiAgIA0KPiA+
ID4gPiA+ICAgZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jIHwgNiArKysrKysNCj4g
PiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+
ID4gPiA+ID4gYi9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tDQo+ID4gPiA+ID4gYnVmZmVyLmMN
Cj4gPiA+ID4gPiBpbmRleCA0YWRhNTU5MmFhMmIuLmYyMjJhMTE4ZDBkMyAxMDA2NDQNCj4gPiA+
ID4gPiAtLS0gYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tYnVmZmVyLmMNCj4gPiA+ID4gPiAr
KysgYi9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tYnVmZmVyLmMNCj4gPiA+ID4gPiBAQCAtMTAz
MSw2ICsxMDMxLDEyIEBAIHN0YXRpYyBpbnQgX19paW9fdXBkYXRlX2J1ZmZlcnMoc3RydWN0IGlp
b19kZXYNCj4gPiA+ID4gPiAqaW5kaW9fZGV2LA0KPiA+ID4gPiA+ICAgCQlyZXR1cm4gcmV0Ow0K
PiA+ID4gPiA+ICAgDQo+ID4gPiA+ID4gICAJaWYgKGluc2VydF9idWZmZXIpIHsNCj4gPiA+ID4g
PiArCQlpZiAoYml0bWFwX2VtcHR5KGluc2VydF9idWZmZXItPnNjYW5fbWFzaywNCj4gPiA+ID4g
PiArCQkJaW5kaW9fZGV2LT5tYXNrbGVuZ3RoKSkgew0KPiA+ID4gPiA+ICsJCQlyZXQgPSAtRUlO
VkFMOw0KPiA+ID4gPiA+ICsJCQlnb3RvIGVycl9mcmVlX2NvbmZpZzsNCj4gPiA+ID4gPiArCQl9
ICANCj4gPiA+ID4gDQo+ID4gPiA+IFNpbmNlIHRoZSBjaGVjayBpcyBzbyBzaW1wbGUgaXQgbWln
aHQgbWFrZSBzZW5zZSB0byBkbyBpdCBhcyB0aGUgdmVyeSANCj4gPiA+ID4gZmlyc3QgdGhpbmcg
YmVmb3JlIGlpb192ZXJpZnlfdXBkYXRlKCkuICANCj4gPiA+IA0KPiA+ID4gd29ya3MgZm9yIG1l
Ow0KPiA+ID4gDQo+ID4gPiA+ICAgDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICAgCQlyZXQgPSBp
aW9fYnVmZmVyX3JlcXVlc3RfdXBkYXRlKGluZGlvX2RldiwNCj4gPiA+ID4gPiBpbnNlcnRfYnVm
ZmVyKTsNCj4gPiA+ID4gPiAgIAkJaWYgKHJldCkNCj4gPiA+ID4gPiAgIAkJCWdvdG8gZXJyX2Zy
ZWVfY29uZmlnOw0KPiA+ID4gPiA+ICAgDQo=
