Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B253318E7C1
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 10:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgCVJRO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 05:17:14 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:4442 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726797AbgCVJRO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 05:17:14 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02M9AiUg028094;
        Sun, 22 Mar 2020 05:17:09 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ywfj6jjsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Mar 2020 05:17:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViaHXVCvW7sLK40Q2vUuuJv7sxrkH2OyjpTq8TcApz12ynXv9LQHkNAYZZRNx5PVbuwyVNmmmjoc37oNbTsn27C6oD+Ex0pyAxFOgHrZiDrbQFA8f+IA317bkDtBgfLiSz3o0DH7ckO5ictC6eYm4l0DvOq9N8P75mKIEJM19RFyBZn5tf/mx+1Dr713LWFhE9tb7Q+NDSrT+AQvWIPhWKNHhdKXJ+B5E5YDO1CcPEWlqxeLsn4izCWbJOKz3ntYrJdW/oLY2KdEEEF+g9sUfNbM/wZBKxeeyb0SSTofz6JCIW72NWRN9uUK/iO1+t9McRCJX9m8K1YTaxKBwuhWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxVqCnktEPcmrB9td52A2dg7yyYuC+QE14FxSdKNawg=;
 b=jjJUHpkxyfa3AbHKxUN0RAb8wMZSW91Vvrj6dR1F2X5R4uHvoQ2L3ce0DwC1A+Xb1DcSSI1JZOqhM3fR74S0WofamsB7gunVyV4BY5cOQnxVMnJ0BHK0RsI+sHQ2vQ8sPu+ql52mxoaoiZ+Jw95XjhEyLnUkZqhWPOp28VBV4rvz/m/W58L7phLAylmkAipIJi+S39oW6O8h93qdto9FoVHs4W4ZUO8tSyIhNrU+wevFpeMK8wRXMSyAagJyGp95qA5DxjhAf46abgYl1bVe2u/Ky9MKuH55lTb4LkZ7t3u2k27ts1XkfkudCd6FeU2Hyp+u69q+oaHxXyGPV4puxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxVqCnktEPcmrB9td52A2dg7yyYuC+QE14FxSdKNawg=;
 b=VP460/mOhgQZxdwf5NeanuHhjEcZVwEmJU1+3N/xsHRXRJsoMNN7bV7PxWo6trNvTNtPnxkzqgv24nI4p+8FAd/ASNg3DP4wQqdpNBhGrreUOx76dSyO1Ueo+4XAO235X2Q89r9ExeL7bTZIcb1R9bzAYx94RQUtQ3ASDb7gHME=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4812.namprd03.prod.outlook.com (2603:10b6:5:189::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Sun, 22 Mar
 2020 09:17:07 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Sun, 22 Mar 2020
 09:17:06 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        "Tachici, Alexandru" <Alexandru.Tachici@analog.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Caprioru, Mircea" <Mircea.Caprioru@analog.com>
Subject: Re: [PATCH v4 1/2] iio: dac: ad5770r: Add AD5770R support
Thread-Topic: [PATCH v4 1/2] iio: dac: ad5770r: Add AD5770R support
Thread-Index: AQHV5lST0WrJKPVXlEyKMOOc1Ucpe6hTvVGAgADLVIA=
Date:   Sun, 22 Mar 2020 09:17:06 +0000
Message-ID: <2942e900ab01957027b918b2a5fdbd665fe6b2ed.camel@analog.com>
References: <20200218121031.27233-1-alexandru.tachici@analog.com>
         <20200218121031.27233-2-alexandru.tachici@analog.com>
         <20200321210921.GA2814584@smile.fi.intel.com>
In-Reply-To: <20200321210921.GA2814584@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb057ec2-6b09-4e81-a3b2-08d7ce41caf7
x-ms-traffictypediagnostic: DM6PR03MB4812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB48122FD385F394D281CE0599F9F30@DM6PR03MB4812.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0350D7A55D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39850400004)(396003)(366004)(346002)(136003)(199004)(6512007)(91956017)(66446008)(66556008)(2616005)(110136005)(54906003)(6636002)(8936002)(8676002)(6486002)(81166006)(6506007)(81156014)(4326008)(478600001)(71200400001)(5660300002)(66946007)(76116006)(64756008)(66476007)(26005)(107886003)(316002)(36756003)(86362001)(2906002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4812;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ES2WiQ24nj3xD+oN/AF8uzyPplFfddaIpUKf7QlG2xPtrZRtEaGD+KD+bonWHxY6Q+knu3foXnqrtD24MyLB5z7rWYH5xZmpPevSJf/aNzAaG8GFP7IJnJ8qz6jIdwjgZi01rM+bDjBJuVoDaen151OaGPiigfkqVJCwa0H+uDok9qwi7GxQo9syUiysAKiVS+6e4NH8xBD8dvuM/5T2K+hXj0LN5WWVbJLjVipni/oehJuzG+bSxNJBItqVmd/yG24kn672hW9yxsmhpvwWtthA1AuFfBZrtovi5fpZO9yTQnNf8MVJjCU55Nny5tlPkNE8IE5bMkrj2VMb4kjfhyBbajkMAS8xpdnUxk0IiaaSOPQ7LTTPKUL5g71w3GL/aKijIp1p0liPZ3iKPx9SdrAtj6dRdNdZ5b6GzGPb34y+n318y5JwvbRMXWyfy7hA
x-ms-exchange-antispam-messagedata: 8mQRem8u/RXJ0ScIXZ07BH/VmCX0CKanqdQR4HywwWYivWSAOMLVDbekLE0qYBacJf7QoS75BYtY4Z/z6DqZ1NMadjtmuTM1E/3E0vqPA07nUglokObapNAEHLsdQvgwa4B9y347pDbPaO5GdXXlJQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B2864DC5CD42B409D0DA3862A06E32B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb057ec2-6b09-4e81-a3b2-08d7ce41caf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2020 09:17:06.8238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BjeE6FkzclQKRcsABhyF0hHK6lpoHWeTb2cPw6/xULB2d7azQu9md6FPIRu4l9/2w/hWlLGzk9E88k+XW86dbkALyjqVAZyy+XttwrPeaxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-22_02:2020-03-21,2020-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003220054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDIwLTAzLTIxIGF0IDIzOjA5ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFR1ZSwgRmViIDE4LCAyMDIwIGF0IDAyOjEwOjMwUE0g
KzAyMDAsIEFsZXhhbmRydSBUYWNoaWNpIHdyb3RlOg0KPiA+IFRoZSBBRDU3NzBSIGlzIGEgNi1j
aGFubmVsLCAxNC1iaXQgcmVzb2x1dGlvbiwgbG93IG5vaXNlLCBwcm9ncmFtbWFibGUNCj4gPiBj
dXJyZW50IG91dHB1dCBkaWdpdGFsLXRvLWFuYWxvZyBjb252ZXJ0ZXIgKERBQykgZm9yIHBob3Rv
bmljcyBjb250cm9sDQo+ID4gYXBwbGljYXRpb25zLg0KPiA+IA0KPiA+IEl0IGNvbnRhaW5zIGZp
dmUgMTQtYml0IHJlc29sdXRpb24gY3VycmVudCBzb3VyY2luZyBEQUMgY2hhbm5lbHMgYW5kIG9u
ZQ0KPiA+IDE0LWJpdCByZXNvbHV0aW9uIGN1cnJlbnQgc291cmNpbmcvc2lua2luZyBEQUMgY2hh
bm5lbC4NCj4gDQoNClRoaXMgcGF0Y2ggbWFkZSBpdCBpbnRvIGxpbnV4LW5leHQuDQpEb2luZyBh
IHYyIG5vdyBtYXkgYmUgYSBiaXQgbm9pc3kuDQoNCk1heWJlIHdlIGNhbiB0aWR5LXRoaXMtdXAg
bGF0ZXIuDQpUbyBiZSBob25lc3QsIGl0IHdvbid0IGJlIHRoZSBoaWdoZXN0IG9uIG91ciBsaXN0
Lg0KWyBJIGtub3cgaG93IHRoYXQgc291bmRzIF0NCg0KV2UgY2FuIHByb2JhYmx5IGxlYXZlIGl0
IGZvciBvdGhlciBwZW9wbGUgdG8gY2xlYW4gaXQgdXAuDQpbIFBlb3BsZSB0aGF0IHdhbnQgdG8g
c3RhcnQgY29udHJpYnV0aW5nIHRvIHRoZSBrZXJuZWwgXQ0KDQoNCj4gLi4uDQo+IA0KPiA+ICsj
ZGVmaW5lIEFENTc3MFJfQ0ZHX0NIMF9TSU5LX0VOKHgpCQkoKCh4KSAmIDB4MSkgPDwgNykNCj4g
PiArI2RlZmluZSBBRDU3NzBSX0NGR19TSFVURE9XTl9CKHgsIGNoKQkJKCgoeCkgJiAweDEpIDw8
IChjaCkpDQo+IA0KPiBCSVQoMCkgPw0KPiANCj4gPiArI2RlZmluZSBBRDU3NzBSX1JFRl9SRVNJ
U1RPUl9TRUwoeCkJCSgoKHgpICYgMHgxKSA8PCAyKQ0KPiANCj4gRGl0dG8uDQo+IA0KPiA+ICsj
ZGVmaW5lIEFENTc3MFJfQ0hfU0VUKHgsIGNoKQkJKCgoeCkgJiAweDEpIDw8IChjaCkpDQo+IA0K
PiBEaXR0by4NCj4gDQo+IC4uLg0KPiANCj4gPiArZW51bSBhZDU3NzByX2NoMF9tb2RlcyB7DQo+
ID4gKwlBRDU3NzBSX0NIMF8wXzMwMCA9IDAsDQo+ID4gKwlBRDU3NzBSX0NIMF9ORUdfNjBfMCwN
Cj4gPiArCUFENTc3MFJfQ0gwX05FR182MF8zMDANCj4gPiArfTsNCj4gPiArDQo+ID4gK2VudW0g
YWQ1Nzcwcl9jaDFfbW9kZXMgew0KPiA+ICsJQUQ1NzcwUl9DSDFfMF8xNDBfTE9XX0hFQUQgPSAx
LA0KPiA+ICsJQUQ1NzcwUl9DSDFfMF8xNDBfTE9XX05PSVNFLA0KPiA+ICsJQUQ1NzcwUl9DSDFf
MF8yNTANCj4gPiArfTsNCj4gPiArDQo+ID4gK2VudW0gYWQ1Nzcwcl9jaDJfNV9tb2RlcyB7DQo+
ID4gKwlBRDU3NzBSX0NIX0xPV19SQU5HRSA9IDAsDQo+ID4gKwlBRDU3NzBSX0NIX0hJR0hfUkFO
R0UNCj4gPiArfTsNCj4gPiArDQo+ID4gK2VudW0gYWQ1Nzcwcl9yZWZfdiB7DQo+ID4gKwlBRDU3
NzBSX0VYVF8yXzVfViA9IDAsDQo+ID4gKwlBRDU3NzBSX0lOVF8xXzI1X1ZfT1VUX09OLA0KPiA+
ICsJQUQ1NzcwUl9FWFRfMV8yNV9WLA0KPiA+ICsJQUQ1NzcwUl9JTlRfMV8yNV9WX09VVF9PRkYN
Cj4gPiArfTsNCj4gPiArDQo+ID4gK2VudW0gYWQ1Nzcwcl9vdXRwdXRfZmlsdGVyX3Jlc2lzdG9y
IHsNCj4gPiArCUFENTc3MFJfRklMVEVSXzYwX09ITSA9IDB4MCwNCj4gPiArCUFENTc3MFJfRklM
VEVSXzVfNl9LT0hNID0gMHg1LA0KPiA+ICsJQUQ1NzcwUl9GSUxURVJfMTFfMl9LT0hNLA0KPiA+
ICsJQUQ1NzcwUl9GSUxURVJfMjJfMl9LT0hNLA0KPiA+ICsJQUQ1NzcwUl9GSUxURVJfNDRfNF9L
T0hNLA0KPiA+ICsJQUQ1NzcwUl9GSUxURVJfMTA0X0tPSE0sDQo+IA0KPiBJdCB3b3VsZCBiZSBu
aWNlIHRvIGdvIGNvbnNpc3RlbnQgYWJvdXQgbGFzdCBlbnRyeSBpbiBlbnVtcy4gQXJlIHRoZXkN
Cj4gdGVybWluYXRvcnM/IEZvciBtZSBpdCBkb2Vzbid0IGxvb2sgbGlrZSBpdCAobmV3IHJldmlz
aW9uIG9mIGhhcmR3YXJlDQo+IGFsd2F5cyBjYW4gdXNlIGV4dGVuZGVkIGxpc3RzIG9mIG1vZGVz
LCBldGMpLg0KPiANCj4gU28sIEkgdGhpbmsgbGVhdmluZyBjb21tYSBmb3IgYWxsIGFib3ZlIGlz
IGEgcmlnaHQgdGhpbmcgdG8gZG8uDQo+IA0KPiA+ICt9Ow0KPiANCj4gLi4uDQo+IA0KPiA+ICtz
dGF0aWMgY29uc3QgdW5zaWduZWQgaW50IGFkNTc3MHJfZmlsdGVyX3JlZ192YWxzW10gPSB7DQo+
ID4gKwlBRDU3NzBSX0ZJTFRFUl8xMDRfS09ITSwNCj4gPiArCUFENTc3MFJfRklMVEVSXzQ0XzRf
S09ITSwNCj4gPiArCUFENTc3MFJfRklMVEVSXzIyXzJfS09ITSwNCj4gPiArCUFENTc3MFJfRklM
VEVSXzExXzJfS09ITSwNCj4gPiArCUFENTc3MFJfRklMVEVSXzVfNl9LT0hNLA0KPiA+ICsJQUQ1
NzcwUl9GSUxURVJfNjBfT0hNDQo+ID4gK307DQo+IA0KPiBEaXR0by4NCj4gDQo+IC4uLg0KPiAN
Cj4gPiArCXJldHVybiByZWdtYXBfd3JpdGUoc3QtPnJlZ21hcCwNCj4gPiArCQkJICAgIEFENTc3
MFJfT1VUUFVUX1JBTkdFKGNoYW5uZWwpLCByZWd2YWwpOw0KPiANCj4gSXQgZml0cyBvbmUgbGlu
ZSAoZXZlbiBoYXMgcm9vbSBmb3Igb25lIGNoYXJhY3RlciBtb3JlKQ0KPiBQZXJoYXBzIHlvdSBt
YXkgY29uc2lkZXIgdG8gYW1lbmQgc2V0dGluZ3Mgb2YgeW91ciB0ZXh0IGVkaXRvcj8NCj4gUGxl
YXNlIGZpeCBhbGwgc2ltaWxhciBwbGFjZXMgaW4gYWxsIG9mIHlvdXIgcGF0Y2hlcy4NCj4gDQo+
IC4uLg0KPiANCj4gPiArc3RhdGljIGludCBhZDU3NzByX3Jlc2V0KHN0cnVjdCBhZDU3NzByX3N0
YXRlICpzdCkNCj4gPiArew0KPiA+ICsJLyogUGVyZm9ybSBzb2Z0d2FyZSByZXNldCBpZiBubyBH
UElPIHByb3ZpZGVkICovDQo+ID4gKwlpZiAoIXN0LT5ncGlvX3Jlc2V0KQ0KPiA+ICsJCXJldHVy
biBhZDU3NzByX3NvZnRfcmVzZXQoc3QpOw0KPiANCj4gUGVyaGFwcyBzcGxpdCB0aGlzIHRvIF9y
ZXNldF9ncGlvKCkgYW5kIGRvDQo+IA0KPiAJaWYgKGdwaW8pDQo+IAkJcmV0dXJuIF9yZXNldF9n
cGlvKCk7DQo+IAllbHNlIC8vIEl0J3MgcmVkdW5kYW50LCBidXQgc29tZSBwZW9wbGUgdXNlIGZv
ciBhIHN0eWxlDQo+IAkJcmV0dXJuIF9zb2Z0X3Jlc2V0KCk7DQo+IA0KPiA+ICsNCj4gPiArCWdw
aW9kX3NldF92YWx1ZV9jYW5zbGVlcChzdC0+Z3Bpb19yZXNldCwgMCk7DQo+ID4gKwl1c2xlZXBf
cmFuZ2UoMTAsIDIwKTsNCj4gPiArCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChzdC0+Z3Bpb19y
ZXNldCwgMSk7DQo+ID4gKw0KPiA+ICsJLyogZGF0YSBtdXN0IG5vdCBiZSB3cml0dGVuIGR1cmlu
ZyByZXNldCB0aW1lZnJhbWUgKi8NCj4gPiArCXVzbGVlcF9yYW5nZSgxMDAsIDIwMCk7DQo+ID4g
Kw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gDQo+IC4uLg0KPiANCj4gPiArCQlyZXQgPSBy
ZWdtYXBfYnVsa19yZWFkKHN0LT5yZWdtYXAsDQo+ID4gKwkJCQkgICAgICAgY2hhbi0+YWRkcmVz
cywNCj4gPiArCQkJCSAgICAgICBzdC0+dHJhbnNmX2J1ZiwgMik7DQo+IA0KPiBzaXplb2YoKSA/
DQo+IA0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCXJldHVybiAwOw0KPiANCj4gLi4uDQo+IA0K
PiA+ICsJCXN0LT50cmFuc2ZfYnVmWzBdID0gKCh1MTYpdmFsID4+IDYpOw0KPiANCj4gV2h5IGV4
cGxpY2l0IGNhc3Rpbmc/DQo+IA0KPiA+ICsJCXN0LT50cmFuc2ZfYnVmWzFdID0gKHZhbCAmIEdF
Tk1BU0soNSwgMCkpIDw8IDI7DQo+ID4gKwkJcmV0dXJuIHJlZ21hcF9idWxrX3dyaXRlKHN0LT5y
ZWdtYXAsIGNoYW4tPmFkZHJlc3MsDQo+ID4gKwkJCQkJIHN0LT50cmFuc2ZfYnVmLCAyKTsNCj4g
DQo+IHNpemVvZigpID8NCj4gDQo+IC4uLg0KPiANCj4gPiArc3RhdGljIGludCBhZDU3NzByX3Jl
YWRfZnJlcV9hdmFpbChzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPiA+ICsJCQkJICAgc3Ry
dWN0IGlpb19jaGFuX3NwZWMgY29uc3QgKmNoYW4sDQo+ID4gKwkJCQkgICBjb25zdCBpbnQgKip2
YWxzLCBpbnQgKnR5cGUsIGludCAqbGVuZ3RoLA0KPiA+ICsJCQkJICAgbG9uZyBtYXNrKQ0KPiA+
ICt7DQo+ID4gKwlzd2l0Y2ggKG1hc2spIHsNCj4gPiArCWNhc2UgSUlPX0NIQU5fSU5GT19MT1df
UEFTU19GSUxURVJfM0RCX0ZSRVFVRU5DWToNCj4gPiArCQkqdHlwZSA9IElJT19WQUxfSU5UOw0K
PiA+ICsJCSp2YWxzID0gYWQ1Nzcwcl9maWx0ZXJfZnJlcXM7DQo+ID4gKwkJKmxlbmd0aCA9IEFS
UkFZX1NJWkUoYWQ1Nzcwcl9maWx0ZXJfZnJlcXMpOw0KPiA+ICsJCXJldHVybiBJSU9fQVZBSUxf
TElTVDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+IGRlZmF1
bHQgY2FzZT8NCj4gDQo+ID4gK30NCj4gDQo+IC4uLg0KPiANCj4gPiArCXJldCA9IGtzdHJ0b2Jv
b2woYnVmLCAmcmVhZGluKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4g
PiArDQo+ID4gKwlyZWFkaW4gPSAhcmVhZGluOw0KPiANCj4gSSB0aGluayB1c2luZyAhIGRpcmVj
dGx5IGluIHBsYWNlcyB3aGVyZSBpdCdzIG5lZWRlZCB3aWxsIGJlIGhlbHBmdWwgdGkNCj4gdW5k
ZXJzdGFuZCB0aGUgY29kZS4NCj4gDQo+ID4gKw0KPiA+ICsJcmVndmFsID0gQUQ1NzcwUl9DRkdf
U0hVVERPV05fQihyZWFkaW4sIGNoYW4tPmNoYW5uZWwpOw0KPiA+ICsJaWYgKGNoYW4tPmNoYW5u
ZWwgPT0gMCAmJg0KPiA+ICsJICAgIHN0LT5vdXRwdXRfbW9kZVswXS5vdXRfcmFuZ2VfbW9kZSA+
IEFENTc3MFJfQ0gwXzBfMzAwKSB7DQo+ID4gKwkJcmVndmFsIHw9IEFENTc3MFJfQ0ZHX0NIMF9T
SU5LX0VOKHJlYWRpbik7DQo+ID4gKwkJbWFzayA9IEJJVChjaGFuLT5jaGFubmVsKSArIEJJVCg3
KTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJbWFzayA9IEJJVChjaGFuLT5jaGFubmVsKTsNCj4g
PiArCX0NCj4gPiArCXJldCA9IHJlZ21hcF91cGRhdGVfYml0cyhzdC0+cmVnbWFwLCBBRDU3NzBS
X0NIQU5ORUxfQ09ORklHLCBtYXNrLA0KPiA+ICsJCQkJIHJlZ3ZhbCk7DQo+ID4gKwlpZiAocmV0
KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJcmVndmFsID0gQUQ1NzcwUl9DSF9T
RVQocmVhZGluLCBjaGFuLT5jaGFubmVsKTsNCj4gPiArCXJldCA9IHJlZ21hcF91cGRhdGVfYml0
cyhzdC0+cmVnbWFwLCBBRDU3NzBSX0NIX0VOQUJMRSwNCj4gPiArCQkJCSBCSVQoY2hhbi0+Y2hh
bm5lbCksIHJlZ3ZhbCk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4g
Kw0KPiA+ICsJc3QtPmNoX3B3cl9kb3duW2NoYW4tPmNoYW5uZWxdID0gIXJlYWRpbjsNCj4gDQo+
IC4uLg0KPiANCj4gPiArCWludCByZXQsIHRtcFsyXSwgbWluLCBtYXg7DQo+ID4gKwl1bnNpZ25l
ZCBpbnQgbnVtOw0KPiA+ICsJc3RydWN0IGZ3bm9kZV9oYW5kbGUgKmNoaWxkOw0KPiA+ICsNCj4g
PiArCW51bSA9IGRldmljZV9nZXRfY2hpbGRfbm9kZV9jb3VudCgmc3QtPnNwaS0+ZGV2KTsNCj4g
PiArCWlmIChudW0gIT0gQUQ1NzcwUl9NQVhfQ0hBTk5FTFMpDQo+ID4gKwkJcmV0dXJuIC1FSU5W
QUw7DQo+ID4gKw0KPiA+ICsJZGV2aWNlX2Zvcl9lYWNoX2NoaWxkX25vZGUoJnN0LT5zcGktPmRl
diwgY2hpbGQpIHsNCj4gPiArCQlyZXQgPSBmd25vZGVfcHJvcGVydHlfcmVhZF91MzIoY2hpbGQs
ICJudW0iLCAmbnVtKTsNCj4gPiArCQlpZiAocmV0KQ0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+
ICsJCWlmIChudW0gPiBBRDU3NzBSX01BWF9DSEFOTkVMUykNCj4gPiArCQkJcmV0dXJuIC1FSU5W
QUw7DQo+ID4gKw0KPiA+ICsJCXJldCA9IGZ3bm9kZV9wcm9wZXJ0eV9yZWFkX3UzMl9hcnJheShj
aGlsZCwNCj4gPiArCQkJCQkJICAgICAiYWRpLHJhbmdlLW1pY3JvYW1wIiwNCj4gPiArCQkJCQkJ
ICAgICB0bXAsIDIpOw0KPiANCj4gc2l6ZW9mKCk/DQo+IA0KPiBBbmQgcGVyaGFwcw0KPiAJdTMy
IHRtcFsyXTsNCj4gDQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiAr
DQo+ID4gKwkJbWluID0gdG1wWzBdIC8gMTAwMDsNCj4gPiArCQltYXggPSB0bXBbMV0gLyAxMDAw
Ow0KPiA+ICsJCXJldCA9IGFkNTc3MHJfc3RvcmVfb3V0cHV0X3JhbmdlKHN0LCBtaW4sIG1heCwg
bnVtKTsNCj4gPiArCQlpZiAocmV0KQ0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJfQ0KPiA+
ICsJcmV0dXJuIHJldDsNCj4gDQo+IHJldCBtaWdodCBiZSB1bmluaXRpYWxpemVkPw0KPiANCj4g
SW4gYW55IGNhc2UsIHNob3VsZG4ndCBiZQ0KPiAJcmV0dXJuIDA7DQo+ID8NCj4gDQo+ID4gK30N
Cj4gDQo+IC4uLg0KPiANCj4gPiArCXN0LT5leHRlcm5hbF9yZXMgPSBmd25vZGVfcHJvcGVydHlf
cmVhZF9ib29sKHN0LT5zcGktPmRldi5md25vZGUsDQo+ID4gKwkJCQkJCSAgICAgImFkaSxleHRl
cm5hbC1yZXNpc3RvciIpOw0KPiANCj4gVXNlIG9mIGZ3bm9kZSAoYW5kIGVzcC4gdy9vIGRldl9m
d25vZGUoKSBoZWxwZXIpIGxvb2tzIGluY29uc2lzdGVudCBoZXJlLg0KPiBXaHkgbm90IGRldmlj
ZV9wcm9wZXJ0eV8uLi4oKT8NCj4gDQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiANCj4gcmV0dXJuIDA7
DQo+IA0KPiAuLi4NCj4gDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGFk
NTc3MHJfb2ZfaWRbXSA9IHsNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAiYWRpLGFkNTc3MHIiLCB9
LA0KPiA+ICsJe30sDQo+IA0KPiBObyBuZWVkIGNvbW1hIGluIHRlcm1pbmF0b3IgbGluZS4NCj4g
DQo+ID4gK307DQo+ID4gK01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGFkNTc3MHJfb2ZfaWQpOw0K
PiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBzcGlfZGV2aWNlX2lkIGFkNTc3MHJfaWRb
XSA9IHsNCj4gPiArCXsgImFkNTc3MHIiLCAwIH0sDQo+ID4gKwl7fSwNCj4gDQo+IERpdHRvLg0K
PiANCj4gPiArfTsNCg==
