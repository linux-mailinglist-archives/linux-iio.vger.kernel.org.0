Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427F1167BE3
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 12:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgBULSK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 06:18:10 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14550 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726940AbgBULSJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Feb 2020 06:18:09 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LBEFUJ030995;
        Fri, 21 Feb 2020 06:18:08 -0500
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2056.outbound.protection.outlook.com [104.47.45.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y8udupvx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 06:18:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDAWnek6xTRlEHQ5NdgPmptA2Ok7OkOK6pwrKjHIoXy5ODDw1wPAziZS+A5nZtWnimOvWOEOvX+uDI/U0G/UAwrC0AaD+F/ROMcKHK9K6IQjpMFKr+FHfFFDCyuCc5pTvDySptCh2mndu9CW0+nxeX//yqjqr6EUSTHTYgyN+NMmxsLFV2258AvIsmQAqBGwEWS5RRpgCU3MyOJ//oFAfkX11XzaQqI/ZHu7/2ZN8aeRvPMGrXH1bTcbnnMx0veT/9bsEJF9wC72VqwRvoqxcPTzmfGB+ALVoaIIQKh1fMszzA9r8iRt9jZMbAB7e10DPgAa9RTaGg9pX3Dif3br3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=je1Fx+Q5gNhFaq1tJkCmc5ugKu4ov0TOu53HrbokNVA=;
 b=RQWGUpUVQYnG0j83SJ18Mqm38UC8cOJShEiAdGq8aN+H1ww6g0q6xXp8VcyeaUt0fuA2YJsE811g6fZTqvmCb7TV4ds0nYyprQvfSH9zxSBP2MKaVEvm56lNDpzPzCkKVCZi1bF+xMh3O/q1HIrU3YZRJ2v8hUJbsjUC02wm3+jNcaFFLiLmEZze5+6hZc9iaXXVqo4LZ0qAApeIh06XgWYsCK6kvHw4tL3iuvZvkUPNkm8sKZTUTjvtl50nkInLDHix11YUyuEgN8pcLI3aNewmfznW/EKp8lrXc5jldlCFQZyQlqsSB1KXl9mZjNZbYbg3Es9+muaFRlJPC8ZSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=je1Fx+Q5gNhFaq1tJkCmc5ugKu4ov0TOu53HrbokNVA=;
 b=tI8UK/kH9NFJMMFaZoCoohl05l6HhVVbIJzYydiV2JFPoPc6E1vmtuwjlm+fTZ/MYUasK7rzzZEXjrMjKcFHqXt4ftMWh0nrdjeKjxUXbBonONfQuKorhAPAPELxzzPHZXhij9zrAvnw9yedSE/zhRKqUx8jX8j9KkrEUdB1od4=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24)
 by CH2PR03MB5158.namprd03.prod.outlook.com (2603:10b6:610:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 11:18:05 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056%4]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 11:18:05 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Tachici, Alexandru" <Alexandru.Tachici@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH] iio: industrialio-core: Fix debugfs read
Thread-Topic: [PATCH] iio: industrialio-core: Fix debugfs read
Thread-Index: AQHV6BBVR51maDTUhUeI3C33r6amoKglgdcA
Date:   Fri, 21 Feb 2020 11:18:05 +0000
Message-ID: <a5c223ebd8a00b7509fb95bdf884b556e5d22546.camel@analog.com>
References: <20200220170726.9580-1-alexandru.tachici@analog.com>
In-Reply-To: <20200220170726.9580-1-alexandru.tachici@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43d9769e-f881-4abe-bcc8-08d7b6bfb901
x-ms-traffictypediagnostic: CH2PR03MB5158:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5158D91C65B0640DD124D7C7F9120@CH2PR03MB5158.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(366004)(199004)(189003)(478600001)(76116006)(91956017)(81156014)(8676002)(8936002)(110136005)(6486002)(4326008)(6512007)(36756003)(316002)(71200400001)(26005)(186003)(5660300002)(2616005)(6506007)(86362001)(66446008)(64756008)(66946007)(66476007)(66556008)(2906002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5158;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XHdBgt+3vS8h4SB2Ryw2W5LY4foBfVWDn7rvoNQyMW8RhfX8/KTEcz+asGW5xaqzcqU8pcloLahtyfBX7UCb2qjQB+WlnubdcVrqrUuRznl+N59A/+X/XvxG5bmJg1KlFEos4fVhUcexnnV7vTrIeo9c0KsCrNg/DP4EnSt9sCA6pY7l6MhDWrCooIsMYzbrf5fb2wNkn7G77X/zHr3EpRMtTTWAzDQIP3ixDJZqV/AVf6vHDYVdsRfDzszT7uXkDDW4TS53COiwgQuMm60YDFUOFvLZJTrdDFNUpbtGZ6kswuP9vpUoWhIucu01GB4BAyLXstnbkHlmqFxFBW58cOWJAJ/6COj1lVq34TdoqI46Hg7XBgvf3K1svSplv4isEsd8DXUIuPPYnCYCD1PIdJAvhWkKVMZ51E5A0daY28THYVALfl4KSbjM2IJYx6rI
x-ms-exchange-antispam-messagedata: 3dGPZfspq2ZA+57uZvqbgNo/3CSeO92bt7CaKzhuWKJFoBspS1D/1v1s90ql680eR6YUPCkzZY1Y4gzPMqxGa4ND7CyiKaLUwMyL8wkK+fzOEZ5efr2CDrbhIlUGvi5GHE5/q+/heYk+6f7Dzy/LEg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B7A7F4C669C9F4A8FC641E36AB4DB2B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d9769e-f881-4abe-bcc8-08d7b6bfb901
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 11:18:05.4036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oIetWHvys2Emcc2dpEuWSgfYQA+TPHfRnCA3aBVurxCelPB0oK16lJhANPzChTY6WhgPoMn0C1RPrJIHFpVlZNG5Zt7Dingu7LQ2aw8Sn8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5158
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_03:2020-02-19,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210085
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTAyLTIwIGF0IDE5OjA3ICswMjAwLCBBbGV4YW5kcnUgVGFjaGljaSB3cm90
ZToNCj4gW0V4dGVybmFsXQ0KPiANCj4gQ3VycmVudGx5IGlpb19kZWJ1Z2ZzX3JlYWRfcmVnIGNh
bGxzIGRlYnVnZnNfcmVnX2FjY2Vzcw0KPiBldmVyeSB0aW1lIGl0IGlzIHJhbi4gUmVhZGluZyB0
aGUgc2FtZSBoYXJkd2FyZSByZWdpc3Rlcg0KPiBtdWx0aXBsZSB0aW1lcyBkdXJpbmcgdGhlIHNh
bWUgcmVhZGluZyBvZiBhIGRlYnVnZnMgZmlsZQ0KPiBjYW4gY2F1c2UgdW5pbnRlbmRlZCBlZmZl
Y3RzLg0KPiANCj4gRm9yIGV4YW1wbGUgZm9yIGVhY2g6IGNhdCBpaW86ZGV2aWNlMC9kaXJlY3Rf
cmVnX2FjY2Vzcw0KPiB0aGUgZmlsZV9vcGVyYXRpb25zLnJlYWQgZnVuY3Rpb24gd2lsbCBiZSBj
YWxsZWQgYXQgbGVhc3QNCj4gdHdpY2UuIEZpcnN0IHdpbGwgcmV0dXJuIHRoZSBmdWxsIGxlbmd0
aCBvZiB0aGUgc3RyaW5nIGluDQo+IGJ5dGVzICBhbmQgdGhlIHNlY29uZCB3aWxsIHJldHVybiAw
Lg0KPiANCj4gVGhpcyBwYXRjaCBtYWtlcyBpaW9fZGVidWdmc19yZWFkX3JlZyB0byBjYWxsIGRl
YnVnZnNfcmVnX2FjY2Vzcw0KPiBvbmx5IHdoZW4gdGhlIHVzZXIncyBidWZmZXIgcG9zaXRpb24g
KCpwcG9zKSBpcyAwLiAobWVhbmluZw0KPiBpdCBpcyB0aGUgYmVnaW5uaW5nIG9mIGEgbmV3IHJl
YWRpbmcgb2YgdGhlIGRlYnVnZnMgZmlsZSkuDQo+IA0KPiBGaXhlczogZTU1M2YxODJkNTViICgi
c3RhZ2luZzogaWlvOiBjb3JlOiBJbnRyb2R1Y2UgZGVidWdmcyBzdXBwb3J0LCBhZGQNCj4gc3Vw
cG9ydCBmb3IgZGlyZWN0IHJlZ2lzdGVyIGFjY2VzcyIpDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhh
bmRydSBUYWNoaWNpIDxhbGV4YW5kcnUudGFjaGljaUBhbmFsb2cuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmMgfCAzNCArKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0NCj4gIGluY2x1ZGUvbGludXgvaWlvL2lpby5oICAgICAgICAgfCAgMiArKw0K
PiAgMiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5jIGIvZHJpdmVy
cy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYw0KPiBpbmRleCA2NWZmMGQwNjcwMTguLjYzN2NlYTE0
YWZkYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYw0KPiAr
KysgYi9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5jDQo+IEBAIC0yOTcsMjYgKzI5Nyw0
MCBAQCBzdGF0aWMgdm9pZCBfX2V4aXQgaWlvX2V4aXQodm9pZCkNCj4gIH0NCj4gIA0KPiAgI2lm
IGRlZmluZWQoQ09ORklHX0RFQlVHX0ZTKQ0KPiAtc3RhdGljIHNzaXplX3QgaWlvX2RlYnVnZnNf
cmVhZF9yZWcoc3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191c2VyICp1c2VyYnVmLA0KPiAtCQkJ
ICAgICAgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpDQo+ICtzdGF0aWMgaW50IGlpb19kZWJ1
Z2ZzX2dldF9yZWdfc3RyaW5nKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ICB7DQo+IC0J
c3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IGZpbGUtPnByaXZhdGVfZGF0YTsNCj4gLQljaGFy
IGJ1ZlsyMF07DQo+ICsJY29uc3Qgc3RydWN0IGlpb19pbmZvICppbmZvID0gaW5kaW9fZGV2LT5p
bmZvOw0KPiAgCXVuc2lnbmVkIHZhbCA9IDA7DQo+IC0Jc3NpemVfdCBsZW47DQo+ICAJaW50IHJl
dDsNCj4gIA0KPiAtCXJldCA9IGluZGlvX2Rldi0+aW5mby0+ZGVidWdmc19yZWdfYWNjZXNzKGlu
ZGlvX2RldiwNCj4gLQkJCQkJCSAgaW5kaW9fZGV2LT5jYWNoZWRfcmVnX2FkZHIsDQo+IC0JCQkJ
CQkgIDAsICZ2YWwpOw0KPiArCXJldCA9IGluZm8tPmRlYnVnZnNfcmVnX2FjY2VzcyhpbmRpb19k
ZXYsIGluZGlvX2Rldi0+Y2FjaGVkX3JlZ19hZGRyLA0KPiArCQkJCSAgICAgICAwLCAmdmFsKTsN
Cj4gIAlpZiAocmV0KSB7DQo+ICAJCWRldl9lcnIoaW5kaW9fZGV2LT5kZXYucGFyZW50LCAiJXM6
IHJlYWQgZmFpbGVkXG4iLCBfX2Z1bmNfXyk7DQo+ICAJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiAr
CWluZGlvX2Rldi0+cmVhZF9idWZfbGVuID0gc25wcmludGYoaW5kaW9fZGV2LT5yZWFkX2J1ZiwN
Cj4gKwkJCQkJICAgc2l6ZW9mKGluZGlvX2Rldi0+cmVhZF9idWYpLA0KPiArCQkJCQkgICAiMHgl
WFxuIiwgdmFsKTsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gIA0KPiAtCWxlbiA9IHNucHJpbnRm
KGJ1Ziwgc2l6ZW9mKGJ1ZiksICIweCVYXG4iLCB2YWwpOw0KPiArc3RhdGljIHNzaXplX3QgaWlv
X2RlYnVnZnNfcmVhZF9yZWcoc3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191c2VyICp1c2VyYnVm
LA0KPiArCQkJCSAgICBzaXplX3QgY291bnQsIGxvZmZfdCAqcHBvcykNCj4gK3sNCj4gKwlzdHJ1
Y3QgaWlvX2RldiAqaW5kaW9fZGV2ID0gZmlsZS0+cHJpdmF0ZV9kYXRhOw0KPiArCWxvZmZfdCBw
b3MgPSAqcHBvczsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJaWYgKHBvcyA9PSAwKSB7DQo+ICsJ
CXJldCA9IGlpb19kZWJ1Z2ZzX2dldF9yZWdfc3RyaW5nKGluZGlvX2Rldik7DQo+ICsJCWlmIChy
ZXQpDQo+ICsJCQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4gIA0KPiAtCXJldHVybiBzaW1wbGVfcmVh
ZF9mcm9tX2J1ZmZlcih1c2VyYnVmLCBjb3VudCwgcHBvcywgYnVmLCBsZW4pOw0KDQpJJ20gd29u
ZGVyaW5nIG5vdywgaWYgaXQgd291bGQgYmUgc3VmZmljaWVudCBoZXJlIHRvIGp1c3QgZG86DQoN
CmlmIChsZW4gPT0gc2ltcGxlX3JlYWRfZnJvbV9idWZmZXIodXNlcmJ1ZiwgY291bnQsIHBwb3Ms
IGJ1ZiwgbGVuKSkNCiAgICByZXR1cm4gMDsNCg0KDQo+ICsJcmV0dXJuIHNpbXBsZV9yZWFkX2Zy
b21fYnVmZmVyKHVzZXJidWYsIGNvdW50LCBwcG9zLA0KPiArCQkJCSAgICAgICBpbmRpb19kZXYt
PnJlYWRfYnVmLA0KPiArCQkJCSAgICAgICBpbmRpb19kZXYtPnJlYWRfYnVmX2xlbik7DQo+ICB9
DQo+ICANCj4gIHN0YXRpYyBzc2l6ZV90IGlpb19kZWJ1Z2ZzX3dyaXRlX3JlZyhzdHJ1Y3QgZmls
ZSAqZmlsZSwNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaWlvL2lpby5oIGIvaW5jbHVk
ZS9saW51eC9paW8vaWlvLmgNCj4gaW5kZXggODYyY2UwMDE5ZWJhLi5lZWQ1OGVkMmYzNjggMTAw
NjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvaWlvL2lpby5oDQo+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvaWlvL2lpby5oDQo+IEBAIC01NjgsNiArNTY4LDggQEAgc3RydWN0IGlpb19kZXYgew0KPiAg
I2lmIGRlZmluZWQoQ09ORklHX0RFQlVHX0ZTKQ0KPiAgCXN0cnVjdCBkZW50cnkJCQkqZGVidWdm
c19kZW50cnk7DQo+ICAJdW5zaWduZWQJCQljYWNoZWRfcmVnX2FkZHI7DQo+ICsJY2hhcgkJCQly
ZWFkX2J1ZlsyMF07DQo+ICsJdW5zaWduZWQgaW50CQkJcmVhZF9idWZfbGVuOw0KPiAgI2VuZGlm
DQo+ICB9Ow0KPiAgDQo=
