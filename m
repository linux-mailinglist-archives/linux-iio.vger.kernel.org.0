Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1911AF253
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 18:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgDRQ2m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 12:28:42 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:17194 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726331AbgDRQ2m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2020 12:28:42 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03IGR8sQ007648;
        Sat, 18 Apr 2020 12:28:38 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0b-00128a01.pphosted.com with ESMTP id 30fuab945j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Apr 2020 12:28:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLTftFcMHfIArITX4nbNfOYe5IRXoSntXHE/1ZEERqYg/FDo1G0n8nJHLC4jQyQ4+BSbR8k5nx41WBP3iubc9ztZcSwLMSs6eAw5/ltVMKKdU6yEGxM6WCHgfSLDe5QD1yScCRIR/fvKIgseqqR3vEbMLYiIoR0nz3RQt1+BZpLz8kWNcXemuaS8URbaewmsvmz9leBnC08CJUwzEpZCExbs1SJSNazvFqtqjJ1Ovcv5vYOMwO4R29wlSv4n9z0kXsjcaeWhtzwFSZG2J3OjdHG9YwtUwwUz6s4o7uaAndc4oRV0UmhNl35BGx2ZDv7MAUpk6K/2Pc+NhRDm8krE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrdwHfWN4LBf8WpAZ6p8bvCffmk/LjveEJaEFWOEMw4=;
 b=BsUHKeK4Y+bIOHYeBpckhMpslkaICgbPDj63A9L9jNt1zfqmvKfnThF0F2gn18yWopUiOLwMiZ35GxPMYvhsbwCtOpOWMZmhg5aE6usrEDeGhEmd1/dtqrH4pfvhsX/LfmfbE1BMzxzbRHaoXo5PqVxyeEUFTez2DjyFN9BpZA+0MxmQeT+CrP9eCWnhjm/tbh0VOxN+X511WK+PzL5TZ6+mxje+ofG1eJZAVNcq94hB1Qx9lTWK+VpWC8MPtmCoUSYY7HCDhiF1n8RQML/dDtPWTU666YGuh+yPqCERNgVurqNrzZ39HGlCo8RyT4J3cIRU/QJXNulim86lt4bh1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrdwHfWN4LBf8WpAZ6p8bvCffmk/LjveEJaEFWOEMw4=;
 b=wqW/7aaGT5Qw4cT8UHH19mFedn+nERiS+tjlsrpiTZ3zfxbcV0tYm9JNGD5Pdx6Ri8qySDsUj5dJU3jIMPp8xylXbRozaJjsVw/j6tIiQDf/JmhhSI0NuOK7NMzGihIrYqs+6uJC9nMufIC8g7nvNqoMrMvAT39yRBYqzbao92w=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4937.namprd03.prod.outlook.com (2603:10b6:5:1f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Sat, 18 Apr
 2020 16:28:35 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2921.027; Sat, 18 Apr 2020
 16:28:35 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: core: fail early in iio_device_alloc() if we can't
 get a device id
Thread-Topic: [PATCH] iio: core: fail early in iio_device_alloc() if we can't
 get a device id
Thread-Index: AQHWE+sov3fwJDv9n0+XOleqcT5z7qh/A3eAgAASnoA=
Date:   Sat, 18 Apr 2020 16:28:35 +0000
Message-ID: <8df8a0d7d541b1f4f2a05f1191a148d3b56effe6.camel@analog.com>
References: <20200416123331.68790-1-alexandru.ardelean@analog.com>
         <20200418162555.4b6f4b8d@archlinux>
In-Reply-To: <20200418162555.4b6f4b8d@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48571f93-9bc8-46fb-3f33-08d7e3b58b15
x-ms-traffictypediagnostic: DM6PR03MB4937:
x-microsoft-antispam-prvs: <DM6PR03MB4937DBC4EEB320F1706BA262F9D60@DM6PR03MB4937.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0377802854
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(366004)(376002)(39850400004)(136003)(346002)(396003)(54906003)(2616005)(71200400001)(36756003)(26005)(6486002)(478600001)(6506007)(4326008)(8936002)(5660300002)(64756008)(2906002)(66556008)(6916009)(186003)(76116006)(66946007)(66446008)(91956017)(66476007)(316002)(86362001)(8676002)(6512007)(81156014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wuh3o4/CGJwtUmKlA/XGuoaKB9zK6XKCpri2gpKfswy0jyY70Hq3aX5KxgpaPoF/4rtBDw8fiN5t4o5FaPJaMp1yoaD/dpicd10hZcXQa9r5g5uiLMu7D3dRjdbZtEaBqU7MSvb/XPz9BJWg0WpQ5PHYtle3Xgb3ugpSYZcSODF52GrUVs/qIHbPN3PhYM7mqQFQ9X65gyKxBxBsAedFqcaKgSxgNzMj5vZDEqxgVeva4kjEFE8DXq6X4WAjuSRaOZmhVDL+REYlPQ4Ld4L+KAy5Mr4coZzvuYHBrew+Jw/BkECYywn4bG3dH1sa04zr0ykHmnyEKCIzcI5OihNfoVL10sD98yeeeD6vXaATcc89rVvg4bylIy5lfC4EcglLvgXmtTx/U94DAjAxzyNL8pzOq8KcYz4anOF0A5Nkz54iIhTj1KvbUa6hfHFAC8RX
x-ms-exchange-antispam-messagedata: f9EcKP8WR7ZsVE6zvX5ol3JN5LH4GQPIeM7kB1nkSOc3k/Zw611hIzVX3MJD1EWx4gWiyMNQYvPvxIlQHC6SU9wmsl4YzxPSCxVrVPFz7n7+pVWhLB+2LECbcejU0utc/aBTMFjnUfunOJKqqR5qrw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BEF4A78091CF649A9DC79AB06D8CAD5@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48571f93-9bc8-46fb-3f33-08d7e3b58b15
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2020 16:28:35.7026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YNa4GRfEyrcBWkkvHSuoC3Qeb/n+3if44iaKujoDzw3SiBV0OXv3sK2xy3tKbj7kX9qbT0I8HJm6pXk0r088MswDSX+VmUy9CAAdqr5gYOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4937
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-18_07:2020-04-17,2020-04-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004180137
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDIwLTA0LTE4IGF0IDE2OjI1ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUaHUsIDE2IEFwciAyMDIwIDE1OjMzOjMxICswMzAw
DQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiBUaGlzIGNoYW5nZSBtb3ZlcyB0aGUgJ2lkYV9zaW1wbGVfZ2V0KCknIGNh
bGwgdG8gYmUgdGhlIGZpcnN0IG9uZSBpbg0KPiA+IGlpb19kZXZpY2VfYWxsb2MoKS4gSXQgY2xl
YW5zIHVwIHRoZSBlcnJvciBwYXRoIGEgYml0IGFzIHdlIGRvbid0IG5lZWQgdG8NCj4gPiBjYWxs
IGFueSBrZnJlZShkZXYpIGFueW1vcmUuIFdlIGFsbG9jYXRlIGFuIElJTyBkZXZpY2Ugb25seSBp
ZiB3ZSBoYXZlDQo+ID4gbWFuYWdlZCB0byBvYnRhaW4gYSBkZXZpY2UgSUQuDQo+IA0KPiBXZSBq
dXN0IHRocmV3IGF3YXkgYW4gSUQgaWYgdGhlIGt6YWxsb2MgdGhlbiBmYWlscyAob3IgYW0gSSBt
aXNzaW5nDQo+IHNvbWV0aGluZz8pDQo+IFdpdGggdGhhdCBmaXhlZCBJIGNhbid0IHNlZSB0aGlz
IGFzIGJlaW5nIG11Y2ggb2YgYW4gaW1wcm92ZW1lbnQuDQo+IEVpdGhlciB3YXkgb25lIGFsbG9j
YXRpb24gbmVlZHMgdG8gYmUgdGlkaWVkIHVwLg0KDQpvb3BzLA0KdGhlIGlkYSB0aGluZ2kgZWx1
ZGVkIG1lIHdoZW4gaSB3cm90ZSB0aGlzOw0KYXBvbG9naWVzIGZvciB0aGUgbm9pc2UNCg0KDQo+
IA0KPiBKb25hdGhhbg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4g
PGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lp
by9pbmR1c3RyaWFsaW8tY29yZS5jIHwgMTkgKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYyBiL2RyaXZlcnMvaWlv
L2luZHVzdHJpYWxpby0NCj4gPiBjb3JlLmMNCj4gPiBpbmRleCBmNGRhZjE5ZjJhM2IuLjdjMWQ4
YTNhYjJmMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5j
DQo+ID4gKysrIGIvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYw0KPiA+IEBAIC0xNDk0
LDYgKzE0OTQsMTQgQEAgc3RydWN0IGlpb19kZXYgKmlpb19kZXZpY2VfYWxsb2MoaW50IHNpemVv
Zl9wcml2KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgaWlvX2RldiAqZGV2Ow0KPiA+ICAJc2l6ZV90
IGFsbG9jX3NpemU7DQo+ID4gKwlpbnQgaWQ7DQo+ID4gKw0KPiA+ICsJaWQgPSBpZGFfc2ltcGxl
X2dldCgmaWlvX2lkYSwgMCwgMCwgR0ZQX0tFUk5FTCk7DQo+ID4gKwlpZiAoaWQgPCAwKSB7DQo+
ID4gKwkJLyogY2Fubm90IHVzZSBhIGRldl9lcnIgYXMgdGhlIG5hbWUgaXNuJ3QgYXZhaWxhYmxl
ICovDQo+ID4gKwkJcHJfZXJyKCJmYWlsZWQgdG8gZ2V0IGRldmljZSBpZFxuIik7DQo+ID4gKwkJ
cmV0dXJuIE5VTEw7DQo+ID4gKwl9DQo+ID4gIA0KPiA+ICAJYWxsb2Nfc2l6ZSA9IHNpemVvZihz
dHJ1Y3QgaWlvX2Rldik7DQo+ID4gIAlpZiAoc2l6ZW9mX3ByaXYpIHsNCj4gPiBAQCAtMTUwNiw2
ICsxNTE0LDggQEAgc3RydWN0IGlpb19kZXYgKmlpb19kZXZpY2VfYWxsb2MoaW50IHNpemVvZl9w
cml2KQ0KPiA+ICAJZGV2ID0ga3phbGxvYyhhbGxvY19zaXplLCBHRlBfS0VSTkVMKTsNCj4gPiAg
DQo+ID4gIAlpZiAoZGV2KSB7DQo+ID4gKwkJZGV2LT5pZCA9IGlkOw0KPiA+ICsJCWRldl9zZXRf
bmFtZSgmZGV2LT5kZXYsICJpaW86ZGV2aWNlJWQiLCBkZXYtPmlkKTsNCj4gPiAgCQlkZXYtPmRl
di5ncm91cHMgPSBkZXYtPmdyb3VwczsNCj4gPiAgCQlkZXYtPmRldi50eXBlID0gJmlpb19kZXZp
Y2VfdHlwZTsNCj4gPiAgCQlkZXYtPmRldi5idXMgPSAmaWlvX2J1c190eXBlOw0KPiA+IEBAIC0x
NTE0LDE1ICsxNTI0LDYgQEAgc3RydWN0IGlpb19kZXYgKmlpb19kZXZpY2VfYWxsb2MoaW50IHNp
emVvZl9wcml2KQ0KPiA+ICAJCW11dGV4X2luaXQoJmRldi0+bWxvY2spOw0KPiA+ICAJCW11dGV4
X2luaXQoJmRldi0+aW5mb19leGlzdF9sb2NrKTsNCj4gPiAgCQlJTklUX0xJU1RfSEVBRCgmZGV2
LT5jaGFubmVsX2F0dHJfbGlzdCk7DQo+ID4gLQ0KPiA+IC0JCWRldi0+aWQgPSBpZGFfc2ltcGxl
X2dldCgmaWlvX2lkYSwgMCwgMCwgR0ZQX0tFUk5FTCk7DQo+ID4gLQkJaWYgKGRldi0+aWQgPCAw
KSB7DQo+ID4gLQkJCS8qIGNhbm5vdCB1c2UgYSBkZXZfZXJyIGFzIHRoZSBuYW1lIGlzbid0IGF2
YWlsYWJsZSAqLw0KPiA+IC0JCQlwcl9lcnIoImZhaWxlZCB0byBnZXQgZGV2aWNlIGlkXG4iKTsN
Cj4gPiAtCQkJa2ZyZWUoZGV2KTsNCj4gPiAtCQkJcmV0dXJuIE5VTEw7DQo+ID4gLQkJfQ0KPiA+
IC0JCWRldl9zZXRfbmFtZSgmZGV2LT5kZXYsICJpaW86ZGV2aWNlJWQiLCBkZXYtPmlkKTsNCj4g
PiAgCQlJTklUX0xJU1RfSEVBRCgmZGV2LT5idWZmZXJfbGlzdCk7DQo+ID4gIAl9DQo+ID4gIA0K
