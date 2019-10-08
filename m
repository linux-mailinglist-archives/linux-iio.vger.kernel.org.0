Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E877CF56A
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2019 10:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfJHI6x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Oct 2019 04:58:53 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:36286 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729767AbfJHI6x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Oct 2019 04:58:53 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x988gkE2011001;
        Tue, 8 Oct 2019 04:58:47 -0400
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2059.outbound.protection.outlook.com [104.47.34.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vemxau20m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 04:58:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIkUhHwN+cVFe8UNlC44x9P7oKhMpUcb5dxg5OqEm6r1kh+3+odt/uzZ9/qz8dyw9KXaN6wlAucJbu6vcVzPej2F+Q4huuHMXl/hTSQg4UgocxyV/klMS595DJ4oWobD/T0Ase/t4H0Qy49PK3WpTMvLQRvursNno6xFk6F/lpQRxSNWPpSws9N3dZuiOW2UpbzM3lpQu59hat53OZsryZUbLsUp6TEoqUco+q8gclSzuIE77qU65CSXCbS5KWwQG7g6+narBRfofs5DlrOgU3hiNl4RbwguDOdSDfzb3nTkLFNZfxN9FNx/joshGGhtRfm3h7v+gkhLvHx+dFmibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrWqvB0AQNfHkSHYaGqmv/jvUZD3Wu4nVKXNJO2hgq8=;
 b=kZQR8pKG1WrFxDjqCVtdsqKGyAB2XOkYfTftU9pBi7y7YZcjiJdpD7ynheeKkL9G3AjJYIKcWx0Rpybr0YQBvAH13dUPQqFrVfd9UkH5hzsE5VJwJQGS5S6auF5SQ0ujdjQ8cz7GkWKkq+RDdCnDH24zV0ct8lVKJhnKo/pFpzUm5G0FHwnJ7SdXbrxD9QRmbcIXxt/S8kLRCl4R9Ev51yhNcoYwP8bMGhJqbeaQ594v9biX7E7WYqJJZK2AaC1vdZAhsV0FreayXiVEPtxBmfVuHvV5gAgNuGILYtCwVQRouaacleLmVmftv0OkRIEUzXCor5JcTmPSgRq9A4ZEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrWqvB0AQNfHkSHYaGqmv/jvUZD3Wu4nVKXNJO2hgq8=;
 b=uy/vE8spSFMv9JWPk0aETJ6PkQBpA+JSCjTYtdHrEuwkfUK10RhAxeU/Cv0ZEtQeKEXD7Auy7sOBrgXAwgLOBhvf7bLmb+cprcSQKnfNCDoL2FF5LYPKTZkkaSr0dP2vywupm6GkEGej28surZ6yZrd+LWdsZpLYtCv6Wq1j8As=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5304.namprd03.prod.outlook.com (20.180.15.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.25; Tue, 8 Oct 2019 08:58:44 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2305.023; Tue, 8 Oct 2019
 08:58:44 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 02/10] iio: imu: adis: add unlocked read/write function
 versions
Thread-Topic: [PATCH 02/10] iio: imu: adis: add unlocked read/write function
 versions
Thread-Index: AQHVdFwfhKF1sLBC50O8tzI1vAhB/qdNY4GAgAJc4ICAAKFdAIAAH7QAgAADDgA=
Date:   Tue, 8 Oct 2019 08:58:44 +0000
Message-ID: <ffb2ae65df5f44e7542b40e43d5ed2d8596cc415.camel@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
         <20190926111812.15957-3-alexandru.ardelean@analog.com>
         <20191006101201.051f9249@archlinux> <20191007221649.4fb1ee25@archlinux>
         <944b74b85c2ff7853651b5df1b4557154fafa99b.camel@analog.com>
         <e61409aba34810d66906cece5dff0bb78c5e9385.camel@analog.com>
In-Reply-To: <e61409aba34810d66906cece5dff0bb78c5e9385.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef0a856c-66d5-4328-ef96-08d74bcdb952
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CH2PR03MB5304:
x-microsoft-antispam-prvs: <CH2PR03MB5304698FBC09C57C078A0281F99A0@CH2PR03MB5304.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(366004)(136003)(199004)(189003)(118296001)(6436002)(14444005)(86362001)(6506007)(71200400001)(5660300002)(66446008)(64756008)(66476007)(6512007)(66556008)(71190400001)(8676002)(229853002)(6486002)(99286004)(5640700003)(66946007)(36756003)(6246003)(76116006)(478600001)(14454004)(76176011)(256004)(476003)(26005)(66066001)(30864003)(316002)(186003)(6916009)(102836004)(305945005)(486006)(7736002)(4326008)(81156014)(8936002)(2906002)(54906003)(446003)(81166006)(11346002)(25786009)(6116002)(2616005)(3846002)(2351001)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5304;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pSeRnTgqMS9ZQQhJQQFuI43/r/pZPON8dxNMi1y6UjJSenIdf0wSIRfgdbHz/Odyfxdgyf0+gVOubnu/NJK/dX59GafJo4GCZzWpfJItGFbTUigh36vEkg4K2q6PHzkGXrG39zughHGVU24N7ml5KfW0KWDR1A34NZ5wQEBXLQj/VGgBrYD9TygSXt17ZJ6wNVByYyby7h02jDqP0meUVRciefTmWBQqnZfQTRN1pTrvhO495zSR61uaC7PxPq3dFLXQSym9jVAP4OnWQrGmFmp1sUUoyUyIY3B6IXVWz4bPNrx1nizuTG2ZW0S0+5whrxcLfLdpE9flGLSXTyyRLmbm/5PNmDPGsiyN5hiHeSP0l5zgHgIDv6ovN1+zt0NLTtLntAYrBDhQbpdFix5Br7pOD2Py0LyOJRCIdczSmtE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <74CD822700C88D4D82A9078ADF1CFD32@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0a856c-66d5-4328-ef96-08d74bcdb952
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 08:58:44.4222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qh+t0drCev91oVeJalS/3gAeCv+1XEjVJzVjuLAOd/5UF4p7epCiaa/NyJ6Dib2yxCnj2QA45QWulh6Mw7jesgEu6prw6YOt4yYnXPUn2cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5304
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_03:2019-10-07,2019-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910080089
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTEwLTA4IGF0IDA4OjQ3ICswMDAwLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdy
b3RlOg0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUdWUsIDIwMTktMTAtMDggYXQgMDY6NTQgKzAw
MDAsIEFyZGVsZWFuLCBBbGV4YW5kcnUgd3JvdGU6DQo+ID4gW0V4dGVybmFsXQ0KPiA+IA0KPiA+
IE9uIE1vbiwgMjAxOS0xMC0wNyBhdCAyMjoxNiArMDEwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90
ZToNCj4gPiA+IE9uIFN1biwgNiBPY3QgMjAxOSAxMDoxMjowMSArMDEwMA0KPiA+ID4gSm9uYXRo
YW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gPiANCj4gPiA+ID4gT24g
VGh1LCAyNiBTZXAgMjAxOSAxNDoxODowNCArMDMwMA0KPiA+ID4gPiBBbGV4YW5kcnUgQXJkZWxl
YW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4g
PiA+ID4gVGhpcyB3aWxsIGFsbG93IG1vcmUgZmxleGlibGUgY29udHJvbCB0byBncm91cCByZWFk
cyAmIHdyaXRlcw0KPiA+ID4gPiA+IGludG8NCj4gPiA+ID4gPiBhDQo+ID4gPiA+ID4gc2luZ2xl
DQo+ID4gPiA+ID4gbG9jayAocGFydGljdWxhcmx5IHRoZSBzdGF0ZV9sb2NrKS4NCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBUaGUgZW5kLWdvYWwgaXMgdG8gcmVtb3ZlIHRoZSBpbmRpb19kZXYtPm1s
b2NrIHVzYWdlLCBhbmQgdGhlDQo+ID4gPiA+ID4gc2ltcGxlc3QgZml4DQo+ID4gPiA+ID4gd291
bGQgaGF2ZSBiZWVuIHRvIGp1c3QgYWRkIGFub3RoZXIgbG9jaywgd2hpY2ggd291bGQgbm90IGJl
IGENCj4gPiA+ID4gPiBnb29kDQo+ID4gPiA+ID4gaWRlYSBvbg0KPiA+ID4gPiA+IHRoZSBsb25n
LXJ1bi4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJk
ZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiA+ID4gPiA+ICAgDQo+ID4g
PiA+IEFwcGxpZWQgdG8gdGhlIHRvZ3JlZyBicmFuY2ggb2YgaWlvLmdpdCBhbmQgcHVzaGVkIG91
dCBhcyB0ZXN0aW5nDQo+ID4gPiA+IGV0Yy4NCj4gPiA+ID4gDQo+ID4gPiA+IEpvbmF0aGFuDQo+
ID4gPiA+IA0KPiA+ID4gMC1kYXkgZm91bmQgYSBwb3RlbnRpYWwgaXNzdWUgKGtpbmQgb2YpIGlu
IHRoZSByZWFkIGZ1bmN0aW9ucy4NCj4gPiA+IA0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBk
cml2ZXJzL2lpby9pbXUvYWRpcy5jICAgICAgIHwgIDM0ICsrKysrLS0tLS0tDQo+ID4gPiA+ID4g
IGluY2x1ZGUvbGludXgvaWlvL2ltdS9hZGlzLmggfCAxMTQNCj4gPiA+ID4gPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEy
OCBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW11L2FkaXMuYyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlz
LmMNCj4gPiA+ID4gPiBpbmRleCAzYzJkODk2ZTNhOTYuLjRmM2JlMDExYzg5OCAxMDA2NDQNCj4g
PiA+ID4gPiAtLS0gYS9kcml2ZXJzL2lpby9pbXUvYWRpcy5jDQo+ID4gPiA+ID4gKysrIGIvZHJp
dmVycy9paW8vaW11L2FkaXMuYw0KPiA+ID4gPiA+IEBAIC0yNiw3ICsyNiwxNCBAQA0KPiA+ID4g
PiA+ICAjZGVmaW5lIEFESVNfTVNDX0NUUkxfREFUQV9SRFlfRElPMglCSVQoMCkNCj4gPiA+ID4g
PiAgI2RlZmluZSBBRElTX0dMT0JfQ01EX1NXX1JFU0VUCQlCSVQoNykNCj4gPiA+ID4gPiAgDQo+
ID4gPiA+ID4gLWludCBhZGlzX3dyaXRlX3JlZyhzdHJ1Y3QgYWRpcyAqYWRpcywgdW5zaWduZWQg
aW50IHJlZywNCj4gPiA+ID4gPiArLyoqDQo+ID4gPiA+ID4gKyAqIF9fYWRpc193cml0ZV9yZWco
KSAtIHdyaXRlIE4gYnl0ZXMgdG8gcmVnaXN0ZXIgKHVubG9ja2VkDQo+ID4gPiA+ID4gdmVyc2lv
bikNCj4gPiA+ID4gPiArICogQGFkaXM6IFRoZSBhZGlzIGRldmljZQ0KPiA+ID4gPiA+ICsgKiBA
cmVnOiBUaGUgYWRkcmVzcyBvZiB0aGUgbG93ZXIgb2YgdGhlIHR3byByZWdpc3RlcnMNCj4gPiA+
ID4gPiArICogQHZhbHVlOiBUaGUgdmFsdWUgdG8gd3JpdGUgdG8gZGV2aWNlICh1cCB0byA0IGJ5
dGVzKQ0KPiA+ID4gPiA+ICsgKiBAc2l6ZTogVGhlIHNpemUgb2YgdGhlIEB2YWx1ZSAoaW4gYnl0
ZXMpDQo+ID4gPiA+ID4gKyAqLw0KPiA+ID4gPiA+ICtpbnQgX19hZGlzX3dyaXRlX3JlZyhzdHJ1
Y3QgYWRpcyAqYWRpcywgdW5zaWduZWQgaW50IHJlZywNCj4gPiA+ID4gPiAgCXVuc2lnbmVkIGlu
dCB2YWx1ZSwgdW5zaWduZWQgaW50IHNpemUpDQo+ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiAgCXVu
c2lnbmVkIGludCBwYWdlID0gcmVnIC8gQURJU19QQUdFX1NJWkU7DQo+ID4gPiA+ID4gQEAgLTcw
LDggKzc3LDYgQEAgaW50IGFkaXNfd3JpdGVfcmVnKHN0cnVjdCBhZGlzICphZGlzLCB1bnNpZ25l
ZA0KPiA+ID4gPiA+IGludA0KPiA+ID4gPiA+IHJlZywNCj4gPiA+ID4gPiAgCQl9LA0KPiA+ID4g
PiA+ICAJfTsNCj4gPiA+ID4gPiAgDQo+ID4gPiA+ID4gLQltdXRleF9sb2NrKCZhZGlzLT5zdGF0
ZV9sb2NrKTsNCj4gPiA+ID4gPiAtDQo+ID4gPiA+ID4gIAlzcGlfbWVzc2FnZV9pbml0KCZtc2cp
Ow0KPiA+ID4gPiA+ICANCj4gPiA+ID4gPiAgCWlmIChhZGlzLT5jdXJyZW50X3BhZ2UgIT0gcGFn
ZSkgew0KPiA+ID4gPiA+IEBAIC05Niw4ICsxMDEsNyBAQCBpbnQgYWRpc193cml0ZV9yZWcoc3Ry
dWN0IGFkaXMgKmFkaXMsIHVuc2lnbmVkDQo+ID4gPiA+ID4gaW50DQo+ID4gPiA+ID4gcmVnLA0K
PiA+ID4gPiA+ICAJCWFkaXMtPnR4WzNdID0gdmFsdWUgJiAweGZmOw0KPiA+ID4gPiA+ICAJCWJy
ZWFrOw0KPiA+ID4gPiA+ICAJZGVmYXVsdDoNCj4gPiA+ID4gPiAtCQlyZXQgPSAtRUlOVkFMOw0K
PiA+ID4gPiA+IC0JCWdvdG8gb3V0X3VubG9jazsNCj4gPiA+ID4gPiArCQlyZXR1cm4gLUVJTlZB
TDsNCj4gPiA+ID4gPiAgCX0NCj4gPiA+ID4gPiAgDQo+ID4gPiA+ID4gIAl4ZmVyc1tzaXplXS5j
c19jaGFuZ2UgPSAwOw0KPiA+ID4gPiA+IEBAIC0xMTMsMjAgKzExNywxOCBAQCBpbnQgYWRpc193
cml0ZV9yZWcoc3RydWN0IGFkaXMgKmFkaXMsDQo+ID4gPiA+ID4gdW5zaWduZWQNCj4gPiA+ID4g
PiBpbnQgcmVnLA0KPiA+ID4gPiA+ICAJCWFkaXMtPmN1cnJlbnRfcGFnZSA9IHBhZ2U7DQo+ID4g
PiA+ID4gIAl9DQo+ID4gPiA+ID4gIA0KPiA+ID4gPiA+IC1vdXRfdW5sb2NrOg0KPiA+ID4gPiA+
IC0JbXV0ZXhfdW5sb2NrKCZhZGlzLT5zdGF0ZV9sb2NrKTsNCj4gPiA+ID4gPiAtDQo+ID4gPiA+
ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ID4gPiA+ICB9DQo+ID4gPiA+ID4gLUVYUE9SVF9TWU1CT0xf
R1BMKGFkaXNfd3JpdGVfcmVnKTsNCj4gPiA+ID4gPiArRVhQT1JUX1NZTUJPTF9HUEwoX19hZGlz
X3dyaXRlX3JlZyk7DQo+ID4gPiA+ID4gIA0KPiA+ID4gPiA+ICAvKioNCj4gPiA+ID4gPiAtICog
YWRpc19yZWFkX3JlZygpIC0gcmVhZCAyIGJ5dGVzIGZyb20gYSAxNi1iaXQgcmVnaXN0ZXINCj4g
PiA+ID4gPiArICogX19hZGlzX3JlYWRfcmVnKCkgLSByZWFkIE4gYnl0ZXMgZnJvbSByZWdpc3Rl
ciAodW5sb2NrZWQNCj4gPiA+ID4gPiB2ZXJzaW9uKQ0KPiA+ID4gPiA+ICAgKiBAYWRpczogVGhl
IGFkaXMgZGV2aWNlDQo+ID4gPiA+ID4gICAqIEByZWc6IFRoZSBhZGRyZXNzIG9mIHRoZSBsb3dl
ciBvZiB0aGUgdHdvIHJlZ2lzdGVycw0KPiA+ID4gPiA+ICAgKiBAdmFsOiBUaGUgdmFsdWUgcmVh
ZCBiYWNrIGZyb20gdGhlIGRldmljZQ0KPiA+ID4gPiA+ICsgKiBAc2l6ZTogVGhlIHNpemUgb2Yg
dGhlIEB2YWwgYnVmZmVyDQo+ID4gPiA+ID4gICAqLw0KPiA+ID4gPiA+IC1pbnQgYWRpc19yZWFk
X3JlZyhzdHJ1Y3QgYWRpcyAqYWRpcywgdW5zaWduZWQgaW50IHJlZywNCj4gPiA+ID4gPiAraW50
IF9fYWRpc19yZWFkX3JlZyhzdHJ1Y3QgYWRpcyAqYWRpcywgdW5zaWduZWQgaW50IHJlZywNCj4g
PiA+ID4gPiAgCXVuc2lnbmVkIGludCAqdmFsLCB1bnNpZ25lZCBpbnQgc2l6ZSkNCj4gPiA+ID4g
PiAgew0KPiA+ID4gPiA+ICAJdW5zaWduZWQgaW50IHBhZ2UgPSByZWcgLyBBRElTX1BBR0VfU0la
RTsNCj4gPiA+ID4gPiBAQCAtMTg4LDE1ICsxOTAsMTQgQEAgaW50IGFkaXNfcmVhZF9yZWcoc3Ry
dWN0IGFkaXMgKmFkaXMsDQo+ID4gPiA+ID4gdW5zaWduZWQNCj4gPiA+ID4gPiBpbnQgcmVnLA0K
PiA+ID4gPiA+ICAJCXNwaV9tZXNzYWdlX2FkZF90YWlsKCZ4ZmVyc1szXSwgJm1zZyk7DQo+ID4g
PiA+ID4gIAkJYnJlYWs7DQo+ID4gPiA+ID4gIAlkZWZhdWx0Og0KPiA+ID4gPiA+IC0JCXJldCA9
IC1FSU5WQUw7DQo+ID4gPiA+ID4gLQkJZ290byBvdXRfdW5sb2NrOw0KPiA+ID4gPiA+ICsJCXJl
dHVybiAtRUlOVkFMOw0KPiA+ID4gPiA+ICAJfQ0KPiA+ID4gPiA+ICANCj4gPiA+ID4gPiAgCXJl
dCA9IHNwaV9zeW5jKGFkaXMtPnNwaSwgJm1zZyk7DQo+ID4gPiA+ID4gIAlpZiAocmV0KSB7DQo+
ID4gPiA+ID4gIAkJZGV2X2VycigmYWRpcy0+c3BpLT5kZXYsICJGYWlsZWQgdG8gcmVhZCByZWdp
c3Rlcg0KPiA+ID4gPiA+IDB4JTAyWDoNCj4gPiA+ID4gPiAlZFxuIiwNCj4gPiA+ID4gPiAgCQkJ
CXJlZywgcmV0KTsNCj4gPiA+ID4gPiAtCQlnb3RvIG91dF91bmxvY2s7DQo+ID4gPiA+ID4gKwkJ
cmV0dXJuIHJldDsNCj4gPiA+ID4gPiAgCX0gZWxzZSB7DQo+ID4gPiA+ID4gIAkJYWRpcy0+Y3Vy
cmVudF9wYWdlID0gcGFnZTsNCj4gPiA+ID4gPiAgCX0NCj4gPiA+ID4gPiBAQCAtMjEwLDEyICsy
MTEsOSBAQCBpbnQgYWRpc19yZWFkX3JlZyhzdHJ1Y3QgYWRpcyAqYWRpcywNCj4gPiA+ID4gPiB1
bnNpZ25lZA0KPiA+ID4gPiA+IGludCByZWcsDQo+ID4gPiA+ID4gIAkJYnJlYWs7DQo+ID4gPiA+
ID4gIAl9DQo+ID4gPiA+ID4gIA0KPiA+ID4gPiA+IC1vdXRfdW5sb2NrOg0KPiA+ID4gPiA+IC0J
bXV0ZXhfdW5sb2NrKCZhZGlzLT5zdGF0ZV9sb2NrKTsNCj4gPiA+ID4gPiAtDQo+ID4gPiA+ID4g
IAlyZXR1cm4gcmV0Ow0KPiA+ID4gPiA+ICB9DQo+ID4gPiA+ID4gLUVYUE9SVF9TWU1CT0xfR1BM
KGFkaXNfcmVhZF9yZWcpOw0KPiA+ID4gPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChfX2FkaXNfcmVh
ZF9yZWcpOw0KPiA+ID4gPiA+ICANCj4gPiA+ID4gPiAgI2lmZGVmIENPTkZJR19ERUJVR19GUw0K
PiA+ID4gPiA+ICANCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9paW8vaW11
L2FkaXMuaA0KPiA+ID4gPiA+IGIvaW5jbHVkZS9saW51eC9paW8vaW11L2FkaXMuaA0KPiA+ID4g
PiA+IGluZGV4IDNlZDVlY2VhYWMyZC4uM2EwMjhjNDBlMDRlIDEwMDY0NA0KPiA+ID4gPiA+IC0t
LSBhL2luY2x1ZGUvbGludXgvaWlvL2ltdS9hZGlzLmgNCj4gPiA+ID4gPiArKysgYi9pbmNsdWRl
L2xpbnV4L2lpby9pbXUvYWRpcy5oDQo+ID4gPiA+ID4gQEAgLTc1LDExICs3NSwxMjEgQEAgaW50
IGFkaXNfaW5pdChzdHJ1Y3QgYWRpcyAqYWRpcywgc3RydWN0DQo+ID4gPiA+ID4gaWlvX2Rldg0K
PiA+ID4gPiA+ICppbmRpb19kZXYsDQo+ID4gPiA+ID4gIAlzdHJ1Y3Qgc3BpX2RldmljZSAqc3Bp
LCBjb25zdCBzdHJ1Y3QgYWRpc19kYXRhICpkYXRhKTsNCj4gPiA+ID4gPiAgaW50IGFkaXNfcmVz
ZXQoc3RydWN0IGFkaXMgKmFkaXMpOw0KPiA+ID4gPiA+ICANCj4gPiA+ID4gPiAtaW50IGFkaXNf
d3JpdGVfcmVnKHN0cnVjdCBhZGlzICphZGlzLCB1bnNpZ25lZCBpbnQgcmVnLA0KPiA+ID4gPiA+
ICtpbnQgX19hZGlzX3dyaXRlX3JlZyhzdHJ1Y3QgYWRpcyAqYWRpcywgdW5zaWduZWQgaW50IHJl
ZywNCj4gPiA+ID4gPiAgCXVuc2lnbmVkIGludCB2YWwsIHVuc2lnbmVkIGludCBzaXplKTsNCj4g
PiA+ID4gPiAtaW50IGFkaXNfcmVhZF9yZWcoc3RydWN0IGFkaXMgKmFkaXMsIHVuc2lnbmVkIGlu
dCByZWcsDQo+ID4gPiA+ID4gK2ludCBfX2FkaXNfcmVhZF9yZWcoc3RydWN0IGFkaXMgKmFkaXMs
IHVuc2lnbmVkIGludCByZWcsDQo+ID4gPiA+ID4gIAl1bnNpZ25lZCBpbnQgKnZhbCwgdW5zaWdu
ZWQgaW50IHNpemUpOw0KPiA+ID4gPiA+ICANCj4gPiA+ID4gPiArLyoqDQo+ID4gPiA+ID4gKyAq
IF9fYWRpc193cml0ZV9yZWdfOCgpIC0gV3JpdGUgc2luZ2xlIGJ5dGUgdG8gYSByZWdpc3Rlcg0K
PiA+ID4gPiA+ICh1bmxvY2tlZA0KPiA+ID4gPiA+IHZlcnNpb24pDQo+ID4gPiA+ID4gKyAqIEBh
ZGlzOiBUaGUgYWRpcyBkZXZpY2UNCj4gPiA+ID4gPiArICogQHJlZzogVGhlIGFkZHJlc3Mgb2Yg
dGhlIHJlZ2lzdGVyIHRvIGJlIHdyaXR0ZW4NCj4gPiA+ID4gPiArICogQHZhbHVlOiBUaGUgdmFs
dWUgdG8gd3JpdGUNCj4gPiA+ID4gPiArICovDQo+ID4gPiA+ID4gK3N0YXRpYyBpbmxpbmUgaW50
IF9fYWRpc193cml0ZV9yZWdfOChzdHJ1Y3QgYWRpcyAqYWRpcywgdW5zaWduZWQNCj4gPiA+ID4g
PiBpbnQNCj4gPiA+ID4gPiByZWcsDQo+ID4gPiA+ID4gKwl1aW50OF90IHZhbCkNCj4gPiA+ID4g
PiArew0KPiA+ID4gPiA+ICsJcmV0dXJuIF9fYWRpc193cml0ZV9yZWcoYWRpcywgcmVnLCB2YWws
IDEpOw0KPiA+ID4gPiA+ICt9DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsvKioNCj4gPiA+ID4g
PiArICogX19hZGlzX3dyaXRlX3JlZ18xNigpIC0gV3JpdGUgMiBieXRlcyB0byBhIHBhaXIgb2Yg
cmVnaXN0ZXJzDQo+ID4gPiA+ID4gKHVubG9ja2VkIHZlcnNpb24pDQo+ID4gPiA+ID4gKyAqIEBh
ZGlzOiBUaGUgYWRpcyBkZXZpY2UNCj4gPiA+ID4gPiArICogQHJlZzogVGhlIGFkZHJlc3Mgb2Yg
dGhlIGxvd2VyIG9mIHRoZSB0d28gcmVnaXN0ZXJzDQo+ID4gPiA+ID4gKyAqIEB2YWx1ZTogVmFs
dWUgdG8gYmUgd3JpdHRlbg0KPiA+ID4gPiA+ICsgKi8NCj4gPiA+ID4gPiArc3RhdGljIGlubGlu
ZSBpbnQgX19hZGlzX3dyaXRlX3JlZ18xNihzdHJ1Y3QgYWRpcyAqYWRpcywNCj4gPiA+ID4gPiB1
bnNpZ25lZA0KPiA+ID4gPiA+IGludCByZWcsDQo+ID4gPiA+ID4gKwl1aW50MTZfdCB2YWwpDQo+
ID4gPiA+ID4gK3sNCj4gPiA+ID4gPiArCXJldHVybiBfX2FkaXNfd3JpdGVfcmVnKGFkaXMsIHJl
ZywgdmFsLCAyKTsNCj4gPiA+ID4gPiArfQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArLyoqDQo+
ID4gPiA+ID4gKyAqIF9fYWRpc193cml0ZV9yZWdfMzIoKSAtIHdyaXRlIDQgYnl0ZXMgdG8gZm91
ciByZWdpc3RlcnMNCj4gPiA+ID4gPiAodW5sb2NrZWQNCj4gPiA+ID4gPiB2ZXJzaW9uKQ0KPiA+
ID4gPiA+ICsgKiBAYWRpczogVGhlIGFkaXMgZGV2aWNlDQo+ID4gPiA+ID4gKyAqIEByZWc6IFRo
ZSBhZGRyZXNzIG9mIHRoZSBsb3dlciBvZiB0aGUgZm91ciByZWdpc3Rlcg0KPiA+ID4gPiA+ICsg
KiBAdmFsdWU6IFZhbHVlIHRvIGJlIHdyaXR0ZW4NCj4gPiA+ID4gPiArICovDQo+ID4gPiA+ID4g
K3N0YXRpYyBpbmxpbmUgaW50IF9fYWRpc193cml0ZV9yZWdfMzIoc3RydWN0IGFkaXMgKmFkaXMs
DQo+ID4gPiA+ID4gdW5zaWduZWQNCj4gPiA+ID4gPiBpbnQgcmVnLA0KPiA+ID4gPiA+ICsJdWlu
dDMyX3QgdmFsKQ0KPiA+ID4gPiA+ICt7DQo+ID4gPiA+ID4gKwlyZXR1cm4gX19hZGlzX3dyaXRl
X3JlZyhhZGlzLCByZWcsIHZhbCwgNCk7DQo+ID4gPiA+ID4gK30NCj4gPiA+ID4gPiArDQo+ID4g
PiA+ID4gKy8qKg0KPiA+ID4gPiA+ICsgKiBfX2FkaXNfcmVhZF9yZWdfMTYoKSAtIHJlYWQgMiBi
eXRlcyBmcm9tIGEgMTYtYml0IHJlZ2lzdGVyDQo+ID4gPiA+ID4gKHVubG9ja2VkIHZlcnNpb24p
DQo+ID4gPiA+ID4gKyAqIEBhZGlzOiBUaGUgYWRpcyBkZXZpY2UNCj4gPiA+ID4gPiArICogQHJl
ZzogVGhlIGFkZHJlc3Mgb2YgdGhlIGxvd2VyIG9mIHRoZSB0d28gcmVnaXN0ZXJzDQo+ID4gPiA+
ID4gKyAqIEB2YWw6IFRoZSB2YWx1ZSByZWFkIGJhY2sgZnJvbSB0aGUgZGV2aWNlDQo+ID4gPiA+
ID4gKyAqLw0KPiA+ID4gPiA+ICtzdGF0aWMgaW5saW5lIGludCBfX2FkaXNfcmVhZF9yZWdfMTYo
c3RydWN0IGFkaXMgKmFkaXMsIHVuc2lnbmVkDQo+ID4gPiA+ID4gaW50DQo+ID4gPiA+ID4gcmVn
LA0KPiA+ID4gPiA+ICsJdWludDE2X3QgKnZhbCkNCj4gPiA+ID4gPiArew0KPiA+ID4gPiA+ICsJ
dW5zaWduZWQgaW50IHRtcDsNCj4gPiA+ID4gPiArCWludCByZXQ7DQo+ID4gPiA+ID4gKw0KPiA+
ID4gPiA+ICsJcmV0ID0gX19hZGlzX3JlYWRfcmVnKGFkaXMsIHJlZywgJnRtcCwgMik7DQo+ID4g
PiBaZXJvIGRheSBpc24ndCBoYXBweSB0aGF0IHRoaXMgY2FuIHVzZSB0bXAgd2l0aG91dCBpdCBh
Y3R1YWxseSBiZWluZw0KPiA+ID4gc2V0DQo+ID4gPiBpbiB0aGUNCj4gPiA+IF9fYWRpc19yZWFk
X3JlZy4NCj4gPiA+IA0KPiA+ID4gSSd2ZSBhZGRlZA0KPiA+ID4gCWlmIChyZXQpDQo+ID4gPiAJ
CXJldHVybiByZXQ7DQo+ID4gPiA+ID4gKwkqdmFsID0gdG1wOw0KPiA+ID4gPiA+ICsNCj4gPiA+
ID4gPiArCXJldHVybiByZXQ7DQo+ID4gPiBhbmQgY2hhbmdlZCB0aGlzIHRvIHJldHVybiAwOw0K
PiA+ID4gDQo+ID4gPiBTYW1lIGluIHRoZSAzMmJpdCBjYXNlIGJlbG93Lg0KPiA+ID4gDQo+ID4g
PiBIbW0uIFRoZXJlIGFyZSBxdWl0ZSBhIGZldyBzcGFyc2Ugd2FybmluZ3MgaW4gdGhlIGFkaXMx
NjQwMCBpZiBhbnlvbmUNCj4gPiA+IGZhbmNpZXMNCj4gPiA+IGNsZWFuaW5nIHRoZW0gdXAgOykN
Cj4gPiANCj4gPiBXZWxsLCBJJ3ZlIGJlZW4gcGxhbm5pbmcgdG8gc2V0dXAgc3BhcnNlIGFzIHBh
cnQgb2Ygb3VyIENJLg0KPiA+IEkgZ3Vlc3MgdGhpcyBpcyBhbm90aGVyIG51ZGdlIGluIHRoYXQg
ZGlyZWN0aW9uLg0KPiANCj4gSSBkaWQgZmluZCBzb21lIHdhcm5pbmdzLg0KPiBCdXQgdGhleSBz
ZWVtIHRvIGJlIHJlcG9ydGVkIGJ5IEdDQyA4Lg0KPiBOb3Qgc3VyZSBpZiBHQ0MgNyByZXBvcnRl
ZCB0aGVtLg0KPiBJIHJlLWluc3RhbGxlZCBteSBsYXB0b3AgW2NoYW5nZWQgdG8gYW5vdGhlciBv
bmVdLCBzbyBtYXliZSBteSBkZWZhdWx0IGlzDQo+IG5vdyA4OyBvciBtYXliZSBJIGRpZCBub3Qg
bm90aWNlIHRoaXMgaW5pdGlhbGx5IHdoZW4gSSBidWlsdCBpdCBhbmQNCj4gcGlja2VkDQo+IGl0
IHVwIGZyb20gb3VyIG1hc3RlciBicmFuY2guDQo+IA0KPiBTcGFyc2UgcmVwb3J0cyBub3RoaW5n
IGZvciB0aGUgSU1VIGRyaXZlcnMuDQo+IFNob3VsZCBJIHRyeSBzb21ldGhpbmcgbmV3ZXI/DQo+
IA0KPiBzcGFyc2UgLS12ZXJzaW9uDQo+IDAuNi4wIChVYnVudHU6IDAuNi4wLTMpDQo+IA0KPiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiBBUkNIPWFybSBDUk9TU19DT01QSUxFPX4vd29yay9saW51eC9nY2MtbGluYXJv
LTUuNS4wLTIwMTcuMTAteDg2XzY0X2FybS0NCj4gbGludXgtZ251ZWFiaS9iaW4vYXJtLWxpbnV4
LWdudWVhYmktIG1ha2UgQz0yIGRyaXZlcnMvaWlvL2ltdS8NCg0KV2FpdC4NClRoYXQgbG9va3Mg
bGlrZSBHQ0MgNS41DQpTbywgbWF5YmUgSSB3YXMgYW4gaWRpb3QuDQoNCk9oIHdlbGwgIMKvXF8o
44OEKV8vwq8NClRoZSBmYXVsdHMgb2YgbXVsdGktdGFza2luZw0KDQo+ICAgQ0hFQ0sgICBzY3Jp
cHRzL21vZC9lbXB0eS5jDQo+ICAgQ0FMTCAgICBzY3JpcHRzL2NoZWNrc3lzY2FsbHMuc2gNCj4g
ICBDQUxMICAgIHNjcmlwdHMvYXRvbWljL2NoZWNrLWF0b21pY3Muc2gNCj4gICBDSEVDSyAgIGRy
aXZlcnMvaWlvL2ltdS9hZGlzMTY0MDAuYw0KPiAgIENIRUNLICAgZHJpdmVycy9paW8vaW11L2Fk
aXMxNjQ2MC5jDQo+ICAgQ0hFQ0sgICBkcml2ZXJzL2lpby9pbXUvYWRpczE2NDgwLmMNCj4gICBD
SEVDSyAgIGRyaXZlcnMvaWlvL2ltdS9hZGlzLmMNCj4gICBDSEVDSyAgIGRyaXZlcnMvaWlvL2lt
dS9hZGlzX3RyaWdnZXIuYw0KPiAgIENIRUNLICAgZHJpdmVycy9paW8vaW11L2FkaXNfYnVmZmVy
LmMNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4gDQo+ID4gVGhhbmtzDQo+ID4gQWxleA0KPiA+IA0KPiA+ID4gVGhh
bmtzLA0KPiA+ID4gDQo+ID4gPiBKb25hdGhhbg0KPiA+ID4gDQo+ID4gPiA+ID4gK30NCj4gPiA+
ID4gPiArDQo+ID4gPiA+ID4gKy8qKg0KPiA+ID4gPiA+ICsgKiBfX2FkaXNfcmVhZF9yZWdfMzIo
KSAtIHJlYWQgNCBieXRlcyBmcm9tIGEgMzItYml0IHJlZ2lzdGVyDQo+ID4gPiA+ID4gKHVubG9j
a2VkIHZlcnNpb24pDQo+ID4gPiA+ID4gKyAqIEBhZGlzOiBUaGUgYWRpcyBkZXZpY2UNCj4gPiA+
ID4gPiArICogQHJlZzogVGhlIGFkZHJlc3Mgb2YgdGhlIGxvd2VyIG9mIHRoZSB0d28gcmVnaXN0
ZXJzDQo+ID4gPiA+ID4gKyAqIEB2YWw6IFRoZSB2YWx1ZSByZWFkIGJhY2sgZnJvbSB0aGUgZGV2
aWNlDQo+ID4gPiA+ID4gKyAqLw0KPiA+ID4gPiA+ICtzdGF0aWMgaW5saW5lIGludCBfX2FkaXNf
cmVhZF9yZWdfMzIoc3RydWN0IGFkaXMgKmFkaXMsIHVuc2lnbmVkDQo+ID4gPiA+ID4gaW50DQo+
ID4gPiA+ID4gcmVnLA0KPiA+ID4gPiA+ICsJdWludDMyX3QgKnZhbCkNCj4gPiA+ID4gPiArew0K
PiA+ID4gPiA+ICsJdW5zaWduZWQgaW50IHRtcDsNCj4gPiA+ID4gPiArCWludCByZXQ7DQo+ID4g
PiA+ID4gKw0KPiA+ID4gPiA+ICsJcmV0ID0gX19hZGlzX3JlYWRfcmVnKGFkaXMsIHJlZywgJnRt
cCwgNCk7DQo+ID4gPiA+ID4gKwkqdmFsID0gdG1wOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiAr
CXJldHVybiByZXQ7DQo+ID4gPiA+ID4gK30NCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKy8qKg0K
PiA+ID4gPiA+ICsgKiBhZGlzX3dyaXRlX3JlZygpIC0gd3JpdGUgTiBieXRlcyB0byByZWdpc3Rl
cg0KPiA+ID4gPiA+ICsgKiBAYWRpczogVGhlIGFkaXMgZGV2aWNlDQo+ID4gPiA+ID4gKyAqIEBy
ZWc6IFRoZSBhZGRyZXNzIG9mIHRoZSBsb3dlciBvZiB0aGUgdHdvIHJlZ2lzdGVycw0KPiA+ID4g
PiA+ICsgKiBAdmFsdWU6IFRoZSB2YWx1ZSB0byB3cml0ZSB0byBkZXZpY2UgKHVwIHRvIDQgYnl0
ZXMpDQo+ID4gPiA+ID4gKyAqIEBzaXplOiBUaGUgc2l6ZSBvZiB0aGUgQHZhbHVlIChpbiBieXRl
cykNCj4gPiA+ID4gPiArICovDQo+ID4gPiA+ID4gK3N0YXRpYyBpbmxpbmUgaW50IGFkaXNfd3Jp
dGVfcmVnKHN0cnVjdCBhZGlzICphZGlzLCB1bnNpZ25lZCBpbnQNCj4gPiA+ID4gPiByZWcsDQo+
ID4gPiA+ID4gKwl1bnNpZ25lZCBpbnQgdmFsLCB1bnNpZ25lZCBpbnQgc2l6ZSkNCj4gPiA+ID4g
PiArew0KPiA+ID4gPiA+ICsJaW50IHJldDsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwltdXRl
eF9sb2NrKCZhZGlzLT5zdGF0ZV9sb2NrKTsNCj4gPiA+ID4gPiArCXJldCA9IF9fYWRpc193cml0
ZV9yZWcoYWRpcywgcmVnLCB2YWwsIHNpemUpOw0KPiA+ID4gPiA+ICsJbXV0ZXhfdW5sb2NrKCZh
ZGlzLT5zdGF0ZV9sb2NrKTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwlyZXR1cm4gcmV0Ow0K
PiA+ID4gPiA+ICt9DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsvKioNCj4gPiA+ID4gPiArICog
YWRpc19yZWFkX3JlZygpIC0gcmVhZCBOIGJ5dGVzIGZyb20gcmVnaXN0ZXINCj4gPiA+ID4gPiAr
ICogQGFkaXM6IFRoZSBhZGlzIGRldmljZQ0KPiA+ID4gPiA+ICsgKiBAcmVnOiBUaGUgYWRkcmVz
cyBvZiB0aGUgbG93ZXIgb2YgdGhlIHR3byByZWdpc3RlcnMNCj4gPiA+ID4gPiArICogQHZhbDog
VGhlIHZhbHVlIHJlYWQgYmFjayBmcm9tIHRoZSBkZXZpY2UNCj4gPiA+ID4gPiArICogQHNpemU6
IFRoZSBzaXplIG9mIHRoZSBAdmFsIGJ1ZmZlcg0KPiA+ID4gPiA+ICsgKi8NCj4gPiA+ID4gPiAr
c3RhdGljIGludCBhZGlzX3JlYWRfcmVnKHN0cnVjdCBhZGlzICphZGlzLCB1bnNpZ25lZCBpbnQg
cmVnLA0KPiA+ID4gPiA+ICsJdW5zaWduZWQgaW50ICp2YWwsIHVuc2lnbmVkIGludCBzaXplKQ0K
PiA+ID4gPiA+ICt7DQo+ID4gPiA+ID4gKwlpbnQgcmV0Ow0KPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiArCW11dGV4X2xvY2soJmFkaXMtPnN0YXRlX2xvY2spOw0KPiA+ID4gPiA+ICsJcmV0ID0gX19h
ZGlzX3JlYWRfcmVnKGFkaXMsIHJlZywgdmFsLCBzaXplKTsNCj4gPiA+ID4gPiArCW11dGV4X3Vu
bG9jaygmYWRpcy0+c3RhdGVfbG9jayk7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJcmV0dXJu
IHJldDsNCj4gPiA+ID4gPiArfQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiAgLyoqDQo+ID4gPiA+
ID4gICAqIGFkaXNfd3JpdGVfcmVnXzgoKSAtIFdyaXRlIHNpbmdsZSBieXRlIHRvIGEgcmVnaXN0
ZXINCj4gPiA+ID4gPiAgICogQGFkaXM6IFRoZSBhZGlzIGRldmljZSAgDQo=
