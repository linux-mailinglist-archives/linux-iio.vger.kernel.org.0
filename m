Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0196911FF12
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 08:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfLPHns (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Dec 2019 02:43:48 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:56698 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbfLPHns (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Dec 2019 02:43:48 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBG7eud0029659;
        Mon, 16 Dec 2019 02:43:32 -0500
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2050.outbound.protection.outlook.com [104.47.44.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wvw8ck2e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Dec 2019 02:43:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlHwX0HkN6Y9JqymnjuGhvhL90d3At+Wq9KGB4rDUX6PenPW5/AYHaJhCnulh2Cqp196ZDpTLXvuHCvkuNM1EBL0W8Csp5SMVOfoWUbTRJ0cWd4g7QpMu2aAw91092jLzRlFmA1vusK6SAcEPLQhu7ZRgrH2pzpLfeGSK+X9WLnLUyDhzeEB5FhW57xqWXzeKpis3KXbL3LZ6MnvMVoD6kmc/y9qA7LJGN3N4YYUQtnaHNt9drO7WJ3ksyRwlTNH4Bd7hHeah1Uldg63D5ip/GeBpr/LKRWS372Iv8rzAjuSiVdVlTXMoXQQs+/iAfFXY87Dd+R2yNkYEOt7dEKZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Uz3Vab7uyYWYl/Y3A1//wx72W8onP/oenZ7UzgqziY=;
 b=ArlaQhwkscmr21+yuQkY7b7GfijfHRdljZR+AnHg2wX7k4IlTaGqpfVMAItjvwAwIvJisgR6PkhJkUQXoegm1szX7gHSDQENbJPPWXUrKFkTczm3g2aDygsfbSprijUTrRDvVhhhL2nL9AsFod0x8MkxOIbYDuLMJvP1YzAAjIFZUGV20JA7mHQ2dl4Q1uU7b12OPd5PWbEEBZIeITKg/tofJ82JMSKwQwJJivHrZt/6J1dx4+UjGDVahoghfJEcWth5Uuf0rXQzbBzIiRcC59+O0Db1jYxbzHXJfazvuSq1AACenE3MZ7YZ5sb/wlaguhhM8gZ8/VjxdCFugtCW3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Uz3Vab7uyYWYl/Y3A1//wx72W8onP/oenZ7UzgqziY=;
 b=Wxdt9m5TGyA5vsLZlJlNzewtlU5VE7nCwdyvy6ywFpyGbz6nslw7PRlT+VBNZhvA5js0PlmDN38G9MSKTWSmtnSXMowoX+zB4VfIA+ZILvFjuYlXp5K1KQXBil2rTzjcdDUHtJSIthdOTSbtOPsFEnmDjKIe2IDVFU8wPvTIqlw=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5221.namprd03.prod.outlook.com (20.180.12.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Mon, 16 Dec 2019 07:43:30 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 07:43:30 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] iio: core: use debugfs_remove_recursive() on IIO unload
Thread-Topic: [PATCH] iio: core: use debugfs_remove_recursive() on IIO unload
Thread-Index: AQHVsDNcZDFOgo3AjU61+GDlSOs9Y6e7aBuAgAEAgoA=
Date:   Mon, 16 Dec 2019 07:43:30 +0000
Message-ID: <4728487938a37207f20cc5d4cb6fbbdd04f56358.camel@analog.com>
References: <20191211145903.22395-1-alexandru.ardelean@analog.com>
         <20191215162525.56516ce4@archlinux>
In-Reply-To: <20191215162525.56516ce4@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb90ccfd-275b-45d6-5d7b-08d781fba566
x-ms-traffictypediagnostic: CH2PR03MB5221:
x-microsoft-antispam-prvs: <CH2PR03MB5221AB109BA0FBD383EBB76FF9510@CH2PR03MB5221.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(6486002)(86362001)(4001150100001)(76116006)(54906003)(66946007)(66556008)(66446008)(64756008)(66476007)(6512007)(8936002)(6916009)(6506007)(186003)(2906002)(5660300002)(26005)(36756003)(4326008)(478600001)(71200400001)(316002)(8676002)(81156014)(81166006)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5221;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yl9C2o/o5+Jq+ammej8gNulFe4CarCgVM2ARRrRT3TQZ5RIdgbEGJ57RUeTPuyYBw6dk8Oau8WAUvsp8Go0FD5E566Q2vUr3AqJMJKSqzgrzAJFROGlcdX94tRQV8IpCmhbJ3ML0QBeU+Py7tbMkWODuugMd+f9ksNXH5rnTXquDDjPHqXf7OWkbM1sFwtFp9bpTtcxQzBMhhSq1ZQlxCr+DZgeAioFiijoFkqlT6rAUTiv5+scGd5XYO4r0322sOrNFW9bDRdBerlmXB5ttd2RZHyu5T/PenQ36lf0GFeX3jL8CCWgF+9qbnZIE2wbLXbAP0ursirgIm5mHu3m24APiKMdaYtjIUcUZtYkHVe2el1VQFgEUW3zjgcKK7kAH12JUjCcE0LQpzpYD1UdOQ1QOSIM0Y/DaRbfyQTMkUk9qXLSEAiSPfSPoYF+e4MIt
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F65250A3A42B9940A3584C23D1BA73B9@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb90ccfd-275b-45d6-5d7b-08d781fba566
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 07:43:30.6424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2n33VtqOQ63UUEpyrm35o7VXDnnDZq46Fd3jZA7Bxb0vazfyCgYvFhZ4qb2hdJMe/P57mMFh3TaeE0zmWWCYyJh10l6yZ6zh5pGWiVQ2Xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5221
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-16_01:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912160068
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEyLTE1IGF0IDE2OjI1ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBXZWQsIDExIERlYyAyMDE5IDE2OjU5OjAzICswMjAw
DQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiBGcm9tOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4N
Cj4gPiANCj4gPiBUaGUgZGVidWdmcyBkaXIgbWF5IGhhdmUgbXVsdGlwbGUgZmlsZXMvZGlycyBh
dHRhY2hlZCB0byBpdC4gVXNlDQo+ID4gZGVidWdmc19yZW1vdmVfcmVjdXJzaXZlKCkgdG8gY2xl
YW4gaXQgdXAgd2hlbiB0aGUgSUlPIG1vZHVsZSB1bmxvYWRzLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+
DQo+ID4gLS0tDQo+ID4gDQo+ID4gTm90ZTogbm90ZSBzdXJlIGlmIHRoaXMgbmVlZHMgYSBGaXhl
cyB0YWcuIEl0J3MgYmVlbiBpbiBoZXJlIGZvciBhZ2VzDQo+ID4gbm93LA0KPiA+ICAgICAgIHNv
IGl0IG1heSBub3QgYmUgYSBiaWcgaXNzdWUuDQo+IA0KPiBUaGVyZSBpcyBzb21lIGFyZ3VtZW50
IGluIGZhdm91ciBvZiBkb2luZyB0aGlzIGFzIGEgZGVmZW5zaXZlIG1lYXN1cmUsDQo+IGJ1dA0K
PiBpbiBjdXJyZW50IElJTyBkZWJ1Z2ZzIGRpcmVjdG9yaWVzIGFyZSBvbmx5IGNyZWF0ZWQgYnkg
ZHJpdmVycyB0aGF0IGNhbGwNCj4gKGluZGlyZWN0bHkpIGlpb19kZXZpY2VfcmVnaXN0ZXJfZGVi
dWdmcyBhbmQgdGhvc2UgbXVzdCBjYWxsDQo+IChhZ2FpbiBpbmRpcmVjdGx5KSBpaW9fZGV2aWNl
X3VucmVnaXN0ZXJfZGVidWdmcyB3aGljaCBoYXMgY2FsbGVkDQo+IHRoZSByZWN1cnNpdmUgZnJl
ZSBvbiBldmVyeXRoaW5nIGluIHRoZWlyIGRpcmVjdG9yaWVzLiAgU28gdW5sZXNzDQo+IHNvbWV0
aGluZw0KPiB2ZXJ5IG9kZCBpcyBnb2luZyBvbiB0aGlzIGlzbid0IGEgYnVnLg0KPiANCj4gQW0g
SSBtaXNzaW5nIHNvbWV0aGluZz8NCg0KU28sIEkgYWRtaXQgbXkgbm90ZSBpcyBvcGVuIGZvciBp
bnRlcnByZXRhdGlvbi4NClsgUmVyZ2FyZGluZyB0aGUgIkZpeGVzIiB0YWcsIEknbSBzdGlsbCBu
b3Qgc3VwZXItY2xlYXIgb24gd2hlbi93aHkvaG93DQppdCdzIG5lZWRlZC4gSSdsbCBnZXQgdGhl
cmUgc29vbiB0aG91Z2guIF0NCg0KVGhpcyBwYXRjaCBoYXMgYmVlbiBpbiBvdXIgdHJlZSBzaW5j
ZSAyMDEyLCBhbmQgSSdtIG5vdCBzdXJlIHdoeSBpdCdzIHVzaW5nDQpkZWJ1Z2ZzX3JlbW92ZV9y
ZWN1cnNpdmUoKSB2cyBwbGFpbiBkZWJ1Z2ZzX3JlbW92ZSgpLg0KDQpJIHNvbWV0aW1lcyB0YWtl
IGEgbG9vayBhdCB0aGVzZSBvbGQgcGF0Y2hlcywgdHJ5IHRvIG1ha2Ugc29tZSBzZW5zZSBvZg0K
dGhlbSBhbmQgdXBzdHJlYW0gdGhlbSwgb3Igb3ZlcnJpZGUgdGhlbSB3aXRoIHRoZSB2ZXJzaW9u
IG9mIHVwc3RyZWFtIGNvZGUuDQpNeSBpbnRlbnQgaXMgdG8gc3luYyBBREkgY29kZSBbZm9yIElJ
T10gY2xvc2VyIHRvIHVwc3RyZWFtLiBXaGljaCB3b3VsZA0KbWFrZSBpdCBlYXNpZXIgdG8gdHJh
Y2sgYW55IGRpdmVyZ2VuY2UuDQoNCldlJ3JlIG5vdCBzZWVpbmcgYW55IGJ1ZyB3aXRoL3dpdGhv
dXQgdGhpcy4NCkkgZ3Vlc3MgbXkgbm90ZSBhYm91dCB0aGUgIkZpeGVzIiB0YWcgbWF5IGJlIGEg
Yml0IGNsdW1zeS4NCg0KRnJvbSBteSBzaWRlLCBib3RoIGRlYnVnZnNfcmVtb3ZlX3JlY3Vyc2l2
ZSgpICYgcGxhaW4gZGVidWdmc19yZW1vdmUoKSBhcmUNCmZpbmUuDQoNClRoYW5rcw0KQWxleA0K
DQo+IA0KPiANCj4gPiAgZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYyB8IDIgKy0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmMNCj4gPiBiL2Ry
aXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmMNCj4gPiBpbmRleCA5YTM1Nzk5NDM1NzQuLmRh
YjY3Y2I2OWZlNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29y
ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYw0KPiA+IEBAIC0y
OTIsNyArMjkyLDcgQEAgc3RhdGljIHZvaWQgX19leGl0IGlpb19leGl0KHZvaWQpDQo+ID4gIAlp
ZiAoaWlvX2RldnQpDQo+ID4gIAkJdW5yZWdpc3Rlcl9jaHJkZXZfcmVnaW9uKGlpb19kZXZ0LCBJ
SU9fREVWX01BWCk7DQo+ID4gIAlidXNfdW5yZWdpc3RlcigmaWlvX2J1c190eXBlKTsNCj4gPiAt
CWRlYnVnZnNfcmVtb3ZlKGlpb19kZWJ1Z2ZzX2RlbnRyeSk7DQo+ID4gKwlkZWJ1Z2ZzX3JlbW92
ZV9yZWN1cnNpdmUoaWlvX2RlYnVnZnNfZGVudHJ5KTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgI2lm
IGRlZmluZWQoQ09ORklHX0RFQlVHX0ZTKQ0K
