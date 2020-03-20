Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB2518CC84
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 12:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgCTLQ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 07:16:28 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9698 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726726AbgCTLQ2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 07:16:28 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02KBF0Bp029998;
        Fri, 20 Mar 2020 07:16:14 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yu9jb2ect-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Mar 2020 07:16:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6LfRM8hdgdINxoQ7/arFjKAajtZspTHAKrKEO1Rcus05KCiCVGNdi5MNjTOrfIj8P0iIbexEOXb+j32qNardnDSnl9TXQTeVXzt8a6ODmVXONeA/pwEMnNMZ3cXV8elzwYPwLR/wam5d/FDzzzxa8bdR20ZEa6sD3LLNmMSwRtXcV4o8WO+rRYYuMsd7kJ6GD55HSAbKGFDY3tW0zuBXlLt6tzP7YkFMqQDQARmoYd8vXZqbyZZT7TqdUS/gQXRqpm+bmBdX1Tr8d45EodSRNviOrPQnl2GiGF0jwjbuCHTUDjMJkwY6FMs42+s5rIIZrG+PdmGuxlnYG8frrUYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKiA540BV+WHC3vnvXVtgHwHd3elDQkTQQoHxtrKWGE=;
 b=lYyiS916oQlvAojOZUoLgrv1xN4ea+ISyOOHNVOEA8pOOQuYimZh0MIE04nVteBSO+bGy+vDfhvGsL0WChPnKw4Tby78WEvzGqm/m6zpVGx7u8QKVc41yCsivC6NrvwsX5DfaWWqgpm32IaMMh1gFtX8v0oKagn1UtrCs8Pbr/EyCCQMg/2BfeGGxvU7WeGU3/YSTkN+EWksP10r0D3gagPDFaOdji8UJ+K630FRcDHTraqpqpu/6ngoTeud5syZwq00aUpn54Kmcr9rnRgn5ny0KklLc/FZzSQ/Z39jTLxteY7GszhtOn1Z//Fo28TYl9k8kIv9PvtJt2uX4KrRqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKiA540BV+WHC3vnvXVtgHwHd3elDQkTQQoHxtrKWGE=;
 b=5asohgnMl5Tyf0bhrMrWO1/7H171IbWT/ThDvh2hT/OEmQnhfQZJzsODwLCQ88UtjMjCZPSr+6FWDPg259y90I3GITCMJrBV9MlwJUOjhGEs/8rw6RmLSYZsJt/n5h342w4wOzneZOEJTy6/oc7gabbPlYyeqc/uzPQo3223sSk=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4649.namprd03.prod.outlook.com (2603:10b6:5:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 11:16:12 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Fri, 20 Mar 2020
 11:16:12 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [RFC][PATCH] iio: buffer: Don't allow buffers without any
 channels enabled to be activated
Thread-Topic: [RFC][PATCH] iio: buffer: Don't allow buffers without any
 channels enabled to be activated
Thread-Index: AQHV/qOMaQfGGDt1gE2kT3ZmhM2cB6hRTteAgAAGwIA=
Date:   Fri, 20 Mar 2020 11:16:12 +0000
Message-ID: <3c2ea62e060ae260536766c3ebdd7fe6a1ab5725.camel@analog.com>
References: <20200320104031.31701-1-alexandru.ardelean@analog.com>
         <253007c8-38ed-acd8-a506-b22f34d03997@metafoo.de>
In-Reply-To: <253007c8-38ed-acd8-a506-b22f34d03997@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d475c9ec-7102-4b0a-868b-08d7ccc01941
x-ms-traffictypediagnostic: DM6PR03MB4649:
x-microsoft-antispam-prvs: <DM6PR03MB46493933BB9B8BAA3511C63AF9F50@DM6PR03MB4649.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(346002)(366004)(199004)(53546011)(8936002)(6512007)(26005)(66946007)(91956017)(71200400001)(2616005)(76116006)(66556008)(186003)(6506007)(66476007)(64756008)(66446008)(5660300002)(110136005)(6486002)(81156014)(81166006)(8676002)(478600001)(4326008)(316002)(86362001)(2906002)(966005)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4649;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nLq97opQVDabJfl+Yx+26v0/Dpzpi3PfE49mDjiPB7Ua+XMYDGHm+cbmZjCj0Z2khJMu4i+xSolUZQX6xkzQsJZloE66dItwUdsNoGPsL9dE8eZfbHiGQ00sy8vu8Y/5s2i6DVtc6t28zQokjP0FBw118B1rLRAEkmoknfk6tWkg+wvbzBC0YW1sdZ3mXUObVsBjpXPX1BKuqMLyFEu4afRhhrbcbsLounleGzZUxmaqX9/SMCFlBdnjjrcOYUDz3ZGO+hbNJ7gWzqZv2YziUn3jP4rXOkzk1lvou10uSzudsZyqq6iaOi+fNPNnxhaVOpKgktJ4KENuKvm58i0iLlZ5n1/Q1LH+d9v2gWwWm+HqeuKzpm8uzyTA53bV/k5mXp0Ig+idHeokcbhm4DnDfuWIcGbkbmdx4C3rAJ+nQL/1J2Mzt08ZZV3AAlqk/VtR5glhu9FM4nM0hrBBluAFRZWS/u/JN+bYsr5dRWLJRJCdNhFEj7rMhsd7Nm8njSgKMrx8KEosHjJY7x8ucTel2w==
x-ms-exchange-antispam-messagedata: ECjCPtf0W3oO8ozBichdOOFnAARa+IN82umIKAAEXiMxuT9ZEUFa82PSXUryOaNVmO/3Trnn65HN99e4Ki1TneXzK5FNe3iIx7Msa9LKuew0PN12LCmXogLQZHas3gx+mUTyXHfn2KkQ5TuzO4TKUg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2F064800983CB4AB3F519CE32C24B3C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d475c9ec-7102-4b0a-868b-08d7ccc01941
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 11:16:12.4567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9e7k3Bw+r+MplQKGqz2QYG2k2HFQZO139jDTmFSgAoqNe+5xU5G3ktHEuCYMWgWQHk8imcqCfCmEjEJjGu9/qMVsmk1Y4GDVpsixLGRpXeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4649
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-20_03:2020-03-20,2020-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200050
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDIwLTAzLTIwIGF0IDExOjU1ICswMTAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6DQo+IE9uIDMvMjAvMjAgMTE6NDAgQU0sIEFsZXhhbmRydSBBcmRlbGVhbiB3cm90ZToNCj4g
PiBGcm9tOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gPiANCj4gPiBC
ZWZvcmUgYWN0aXZhdGluZyBhIGJ1ZmZlciBtYWtlIHN1cmUgdGhhdCBhdCBsZWFzdCBvbmUgY2hh
bm5lbCBpcyBlbmFibGVkLg0KPiA+IEFjdGl2YXRpbmcgYSBidWZmZXIgd2l0aCAwIGNoYW5uZWxz
IGVuYWJsZWQgZG9lc24ndCBtYWtlIHRvbyBtdWNoIHNlbnNlIGFuZA0KPiA+IGRpc2FsbG93aW5n
IHRoaXMgY2FzZSBtYWtlcyBzdXJlIHRoYXQgaW5kaXZpZHVhbCBkcml2ZXIgZG9uJ3QgaGF2ZSB0
byBhZGQNCj4gPiBzcGVjaWFsIGNhc2UgY29kZSB0byBoYW5kbGUgaXQuDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+ID4gU2ln
bmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9n
LmNvbT4NCj4gPiAtLS0NCj4gPiANCj4gPiAqIEZvdW5kIHRoaXMgcmVsaWMtcGF0Y2ggaW4gb3Vy
IHRyZWUsIGZyb20gNiB5ZWFycyBhZ286DQo+ID4gICAgaHR0cHM6Ly9naXRodWIuY29tL2FuYWxv
Z2RldmljZXNpbmMvbGludXgvY29tbWl0LzZkNjgwZTQ5ZDQ1OWMNCj4gPiAgICBJdCBnb3QgbW92
ZWQgYXJvdW5kIGEgYml0LCBhbmQgdGhpcyBpcyB0aGUgY3VycmVudCBmb3JtIGluIHRoZSBBREkg
dHJlZS4NCj4gPiAgICBTbywgdGhpcyBpcyBhbHNvIGEgYml0IG9mIGFuIFJGQywgYnV0IGlmIHRo
ZSBpZGVhIGlzIHZhbGlkLCBtYXliZSBpdCdzDQo+ID4gICAgd29ydGggY29uc2lkZXJpbmcgdXBz
dHJlYW0uIEkgZG9uJ3Qga25vdyBvZiBhbnkgYXJndW1lbnRzIGFnYWluc3QgaXQsDQo+ID4gICAg
YnV0IEkgY291bGQgYmUgc3VycHJpc2VkLg0KPiANCj4gSG0sIGEgYml0IHdlaXJkIHRoYXQgdGhp
cyBvbmUgbmV2ZXIgbWFkZSBpdCB1cHN0cmVhbSBjb25zaWRlcmluZyBob3cgDQo+IHNpbXBsZSBp
dCBpcy4NCj4gDQo+IERpZCB5b3UgY2hlY2sgdGhhdCB0aGUgaXNzdWUgc3RpbGwgb2NjdXJzPyBJ
IGNhbid0IHNlZSBhbnl0aGluZyBpbiB0aGUgDQo+IGNvZGUgdGhhdCBwcmV2ZW50cyBpdCwgYnV0
IHdobyBrbm93cywgbWF5YmUgaXQgd2FzIGZpeGVkIGJ5IHNvbWV0aGluZyBlbHNlLg0KDQppIGRp
ZCBub3QgdGhpbmsgdG8gY2hlY2sgYmVoYXZpb3IvaXNzdWVzOw0KaSdsbCB0cnkgdG8gbWFrZSBz
b21lIHRpbWUgZm9yIHRoYXQ7DQppIGNhdWdodCB0aGlzIG9uZSB3aGlsZSBkaWZmLWluZyB0aGUg
dXBzdHJlYW0gJiBBREkgdHJlZXMsIGFuZCBpIG5lZWRlZCB0byBkaWcgYQ0KYml0IG1vcmUgaW50
byB0aGUgQURJIGdpdCBoaXN0b3J5IG9uIGl0Ow0KDQppIHdhcyBhIGJpdCBwdXp6bGVkIGZvciBh
IHdoaWxlLCBiZWNhdXNlIHNvbWUgcmV3b3JrIHBhdGNoZXMgd2VyZSB1cHN0cmVhbWVkDQp3aXRo
b3V0IHRoaXMgcGF0Y2g6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlpby81NTU4
NUNBQS42MDAwNTA2QGtlcm5lbC5vcmcvDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1p
aW8vNTU2MDY4NUEuNTA2MDUwNEBrZXJuZWwub3JnLw0KDQppIGFsc28gZGlkIG5vdCBmaW5kIGFu
eSBkaXNjdXNzaW9ucy91cHN0cmVhbSBhdHRlbXB0IGZvciB0aGlzIHBhdGNoIHBhcnRpY3VsYXJs
eQ0KDQpzbywgaXQgd2FzIGVhc2llciBmb3IgbWUganVzdCB0byBSRkMgdGhpcw0KDQo+IA0KPiA+
ICAgZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jIHwgNiArKysrKysNCj4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jIGIvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlv
LQ0KPiA+IGJ1ZmZlci5jDQo+ID4gaW5kZXggNGFkYTU1OTJhYTJiLi5mMjIyYTExOGQwZDMgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+ID4gKysr
IGIvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+ID4gQEAgLTEwMzEsNiArMTAz
MSwxMiBAQCBzdGF0aWMgaW50IF9faWlvX3VwZGF0ZV9idWZmZXJzKHN0cnVjdCBpaW9fZGV2DQo+
ID4gKmluZGlvX2RldiwNCj4gPiAgIAkJcmV0dXJuIHJldDsNCj4gPiAgIA0KPiA+ICAgCWlmIChp
bnNlcnRfYnVmZmVyKSB7DQo+ID4gKwkJaWYgKGJpdG1hcF9lbXB0eShpbnNlcnRfYnVmZmVyLT5z
Y2FuX21hc2ssDQo+ID4gKwkJCWluZGlvX2Rldi0+bWFza2xlbmd0aCkpIHsNCj4gPiArCQkJcmV0
ID0gLUVJTlZBTDsNCj4gPiArCQkJZ290byBlcnJfZnJlZV9jb25maWc7DQo+ID4gKwkJfQ0KPiAN
Cj4gU2luY2UgdGhlIGNoZWNrIGlzIHNvIHNpbXBsZSBpdCBtaWdodCBtYWtlIHNlbnNlIHRvIGRv
IGl0IGFzIHRoZSB2ZXJ5IA0KPiBmaXJzdCB0aGluZyBiZWZvcmUgaWlvX3ZlcmlmeV91cGRhdGUo
KS4NCg0Kd29ya3MgZm9yIG1lOw0KDQo+IA0KPiA+ICsNCj4gPiAgIAkJcmV0ID0gaWlvX2J1ZmZl
cl9yZXF1ZXN0X3VwZGF0ZShpbmRpb19kZXYsIGluc2VydF9idWZmZXIpOw0KPiA+ICAgCQlpZiAo
cmV0KQ0KPiA+ICAgCQkJZ290byBlcnJfZnJlZV9jb25maWc7DQo+ID4gDQo=
