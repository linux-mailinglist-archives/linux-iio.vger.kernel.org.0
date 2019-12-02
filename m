Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E4D10EB9E
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 15:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLBOjf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 09:39:35 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:54566 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727477AbfLBOje (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 09:39:34 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2EbsTu027517;
        Mon, 2 Dec 2019 09:39:03 -0500
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2057.outbound.protection.outlook.com [104.47.46.57])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wkk2bwem9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 09:39:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPM99gGoYjhJNTs+Mbyn2MXK7gjM/EaWX6wBjDAAHLjGGbwBTt5p57jwDTAQPtxEKo0Tah34ngPUl5yBEvEIg4TMdnRvDy9F/t2t/C4Y0ZE+VwwbHdsgfrHrKvrIdJ5P4kfLmwXptyGEvuCC0Ti71sXvoTrP3AByBt7ShrIHNm17wvpkfSNWpaqPK9XZheQSMiNXNPh7YoXsLFRSquTloZIaDBSa106A2LV2UFOV4Vhc1HyaYTejAQgfaX3/9eq0j8ix3R9UmLC8iPuKD2EwfBqhtVI7FeermkChmdWqH5pKSyBIvNoBHAGL9BDZzoiWc6C3Lm9pUgpYJSM8LDZEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/BMriw9jCvkijyW7E15lI6/2yKZR02QLJi+4O9W60E=;
 b=NuylRo9KmrNf9toTBQSYfZgo+EmGxaT0/cH7J58t/Z/0S82quof7Z3AZFapxOpKNTERdz2ye/fVNSn7+p6NMoZjYAmNzaEjbH5Fapw3C5bwaa8mGRQZR228mRpyOm+MdUCmKN9TMOiqKMB6oouBurdpuo/ZoknYQmUhT+E6lsCOT7X4Rio14tbJUom7n+GagI2/NiOp3ksK1Sf6IceMCibQO0c2UQxS9GYy7didhmSAQXVY8fXWlTWRdBSY8UjO/orIFixLWyagXIWHkuKUG9WmZ48tRkYcRUBLH9/QEVzMKc6F5IWOeniK/sPhrrKY+NiZD5fV0VL/VwHoJ3tAP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/BMriw9jCvkijyW7E15lI6/2yKZR02QLJi+4O9W60E=;
 b=YKsrGCjANJQFLxFU3OcVShYP6glt08oOrftZwkLL8I9yFShMxN2vNO53eiJRmEOk4CK8uqTtq64RgTjskYWSYjJVKheTiBVY4yMXMvSxTpd9VYHx2TeWu6BjitCYsZsgDFyQQLUImykiHVp9UGx8JX8KqEsSFdHgU9igx+0GYVo=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5223.namprd03.prod.outlook.com (20.180.15.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Mon, 2 Dec 2019 14:39:01 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 14:39:01 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "amsfield22@gmail.com" <amsfield22@gmail.com>
Subject: Re: [PATCH] iio: ad7266: Convert to use GPIO descriptors
Thread-Topic: [PATCH] iio: ad7266: Convert to use GPIO descriptors
Thread-Index: AQHVqPREsU8w2sQRPUGeN2xyjJ5l+6em6umA
Date:   Mon, 2 Dec 2019 14:39:01 +0000
Message-ID: <f0b763b0d81e7754d638268b0ffa2e2fec63401e.camel@analog.com>
References: <20191202093806.93632-1-linus.walleij@linaro.org>
In-Reply-To: <20191202093806.93632-1-linus.walleij@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e49ceebb-38c3-4034-6155-08d777355fa6
x-ms-traffictypediagnostic: CH2PR03MB5223:
x-microsoft-antispam-prvs: <CH2PR03MB5223B826686F87B81A0D9176F9430@CH2PR03MB5223.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(199004)(189003)(81156014)(81166006)(7736002)(305945005)(2906002)(14454004)(4326008)(6246003)(2616005)(11346002)(478600001)(229853002)(446003)(76116006)(71190400001)(6436002)(6486002)(5660300002)(66066001)(186003)(71200400001)(36756003)(102836004)(2501003)(256004)(118296001)(2201001)(99286004)(66556008)(66446008)(6512007)(14444005)(76176011)(64756008)(66946007)(26005)(66476007)(8676002)(25786009)(6116002)(3846002)(316002)(110136005)(6506007)(8936002)(86362001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5223;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WfpAYVSkLbCdt3/gFzJBQX4OeNODOTmBU9QIfrzYax1IOZm9jjpockFrhh5wTIjY+irFm3mLysKwP8pSlRmQ5m8vWnPCVGJuT8j2Mpn3HwP6LttoUaleYEpDBSVTO6cQiIDVMCwgr08J39ABTZLwA8YoB3LGV2edxJP8cEsq2qWt/lfAhpwPpZQOqi9ddrCQluZNwfADAvIrc5TInl8Gq1Hwzk/vt2RTihEhfgrLkpn1ugwH3orwJ4eiKdyTwkwoIvpIJTnbw0yB51ss33591MSQvAZGFTxC7qEzRRrkcIk9su1DfmuS0cyG58yFmJvE6IWEcO3+l7DiOzotJz8Tkk/xQHUC6lJhtZzi+zUV2bflK2HRv5LIephcamAew9Z0wNowMl0vLC3lksPKt2rz2dkyV9YIjoHbywvi3IrK9HjBp7J1LWIOggojON+4RkBB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <18F6EBE227394B4AB84ED18C1B9118C7@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49ceebb-38c3-4034-6155-08d777355fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 14:39:01.6163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RRAPJC4t37BNikedIbpfJSX27bo8jYz9eXlTpvg1aakzRFSNiT8WCWCl2Tp2ef/oStTkknNC7rue6dYQjCDkNn9qynqvyzZJhQACoJbLBfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5223
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_02:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912020131
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTEyLTAyIGF0IDEwOjM4ICswMTAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiBUaGUgQUQ3MjY2IGhhdmUgbm8gaW4tdHJlZSB1c2VycyBtYWtpbmcgdXNlIG9mIHRoZSBwbGF0
Zm9ybQ0KPiBkYXRhIG1lY2hhbmlzbSB0byBwYXNzIGFkZHJlc3MgR1BJTyBsaW5lcyB3aGVuIG5v
dCB1c2luZw0KPiBhIGZpeGVkIGFkZHJlc3MsIHNvIHdlIGNhbiBlYXNpbHkgY29udmVydCB0aGlz
IHRvIHVzZQ0KPiBHUElPIGRlc2NyaXB0b3JzIGluc3RlYWQgb2YgdGhlIHBsYXRmb3JtIGRhdGEg
aW50ZWdlcnMNCj4gY3VycmVudGx5IHBhc3NlZC4NCj4gDQo+IExvd2VyY2FzZSB0aGUgbGFiZWxz
ICJhZDAiLi4iYWQyIiBhcyB0aGlzIHdpbGwgbWFrZSBhIGJldHRlcg0KPiBmaXQgZm9yIHBsYXRm
b3JtIGRlc2NyaXB0aW9ucyBsaWtlIGRldmljZSB0cmVlIHRoYXQgcHJlZmVyDQo+IGxvd2VyY2Fz
ZSBuYW1lcyBzdWNoIGFzICJhZDAtZ3Bpb3MiIHJhdGhlciB0aGFuICJBRDAtZ3Bpb3MiLg0KPiAN
Cj4gQm9hcmQgZmlsZXMgYW5kIG90aGVyIHN0YXRpYyB1c2VycyBvZiB0aGlzIGRldmljZSBjYW4g
cGFzcw0KPiB0aGUgc2FtZSBHUElPIGRlc2NyaXB0b3JzIHVzaW5nIG1hY2hpbmUgZGVzY3JpcHRv
cg0KPiB0YWJsZXMgaWYgbmVlZCBiZS4NCj4gDQoNClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJk
ZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KDQo+IENjOiBBbGlzb24gU2No
b2ZpZWxkIDxhbXNmaWVsZDIyQGdtYWlsLmNvbT4NCj4gQ2M6IExhcnMtUGV0ZXIgQ2xhdXNlbiA8
bGFyc0BtZXRhZm9vLmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBMaW51cyBXYWxsZWlqIDxsaW51cy53
YWxsZWlqQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vYWRjL2FkNzI2Ni5jICAg
ICAgICAgICAgIHwgMjkgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiAgaW5jbHVkZS9s
aW51eC9wbGF0Zm9ybV9kYXRhL2FkNzI2Ni5oIHwgIDMgLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDEyIGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaWlvL2FkYy9hZDcyNjYuYyBiL2RyaXZlcnMvaWlvL2FkYy9hZDcyNjYuYw0KPiBpbmRl
eCBjMzFiOGVhYmI4OTQuLmM4NTI0ZjA5ODg4MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8v
YWRjL2FkNzI2Ni5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hZDcyNjYuYw0KPiBAQCAtMTEs
NyArMTEsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L3NwaS9zcGkuaD4NCj4gICNpbmNsdWRlIDxs
aW51eC9yZWd1bGF0b3IvY29uc3VtZXIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9lcnIuaD4NCj4g
LSNpbmNsdWRlIDxsaW51eC9ncGlvLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25zdW1l
ci5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiAgDQo+ICAjaW5jbHVkZSA8bGlu
dXgvaW50ZXJydXB0Lmg+DQo+IEBAIC0zNCw3ICszNCw3IEBAIHN0cnVjdCBhZDcyNjZfc3RhdGUg
ew0KPiAgCWVudW0gYWQ3MjY2X3JhbmdlCXJhbmdlOw0KPiAgCWVudW0gYWQ3MjY2X21vZGUJbW9k
ZTsNCj4gIAlib29sCQkJZml4ZWRfYWRkcjsNCj4gLQlzdHJ1Y3QgZ3BpbwkJZ3Bpb3NbM107DQo+
ICsJc3RydWN0IGdwaW9fZGVzYwkqZ3Bpb3NbM107DQo+ICANCj4gIAkvKg0KPiAgCSAqIERNQSAo
dGh1cyBjYWNoZSBjb2hlcmVuY3kgbWFpbnRlbmFuY2UpIHJlcXVpcmVzIHRoZQ0KPiBAQCAtMTE3
LDcgKzExNyw3IEBAIHN0YXRpYyB2b2lkIGFkNzI2Nl9zZWxlY3RfaW5wdXQoc3RydWN0IGFkNzI2
Nl9zdGF0ZQ0KPiAqc3QsIHVuc2lnbmVkIGludCBucikNCj4gIAl9DQo+ICANCj4gIAlmb3IgKGkg
PSAwOyBpIDwgMzsgKytpKQ0KPiAtCQlncGlvX3NldF92YWx1ZShzdC0+Z3Bpb3NbaV0uZ3Bpbywg
KGJvb2wpKG5yICYgQklUKGkpKSk7DQo+ICsJCWdwaW9kX3NldF92YWx1ZShzdC0+Z3Bpb3NbaV0s
IChib29sKShuciAmIEJJVChpKSkpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgaW50IGFkNzI2Nl91
cGRhdGVfc2Nhbl9tb2RlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+IEBAIC0zNzYsNyAr
Mzc2LDcgQEAgc3RhdGljIHZvaWQgYWQ3MjY2X2luaXRfY2hhbm5lbHMoc3RydWN0IGlpb19kZXYN
Cj4gKmluZGlvX2RldikNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBh
ZDcyNjZfZ3Bpb19sYWJlbHNbXSA9IHsNCj4gLQkiQUQwIiwgIkFEMSIsICJBRDIiLA0KPiArCSJh
ZDAiLCAiYWQxIiwgImFkMiIsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgaW50IGFkNzI2Nl9wcm9i
ZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiBAQCAtNDE5LDE0ICs0MTksMTQgQEAgc3RhdGlj
IGludCBhZDcyNjZfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gIA0KPiAgCQlpZiAo
IXN0LT5maXhlZF9hZGRyKSB7DQo+ICAJCQlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShzdC0+
Z3Bpb3MpOyArK2kpIHsNCj4gLQkJCQlzdC0+Z3Bpb3NbaV0uZ3BpbyA9IHBkYXRhLT5hZGRyX2dw
aW9zW2ldOw0KPiAtCQkJCXN0LT5ncGlvc1tpXS5mbGFncyA9IEdQSU9GX09VVF9JTklUX0xPVzsN
Cj4gLQkJCQlzdC0+Z3Bpb3NbaV0ubGFiZWwgPSBhZDcyNjZfZ3Bpb19sYWJlbHNbaV07DQo+ICsJ
CQkJc3QtPmdwaW9zW2ldID0gZGV2bV9ncGlvZF9nZXQoJnNwaS0+ZGV2LA0KPiArCQkJCQkJICAg
ICAgYWQ3MjY2X2dwaW9fbGFiZWxzW2ldDQo+ICwNCj4gKwkJCQkJCSAgICAgIEdQSU9EX09VVF9M
T1cpOw0KPiArCQkJCWlmIChJU19FUlIoc3QtPmdwaW9zW2ldKSkgew0KPiArCQkJCQlyZXQgPSBQ
VFJfRVJSKHN0LT5ncGlvc1tpXSk7DQo+ICsJCQkJCWdvdG8gZXJyb3JfZGlzYWJsZV9yZWc7DQo+
ICsJCQkJfQ0KPiAgCQkJfQ0KPiAtCQkJcmV0ID0gZ3Bpb19yZXF1ZXN0X2FycmF5KHN0LT5ncGlv
cywNCj4gLQkJCQlBUlJBWV9TSVpFKHN0LT5ncGlvcykpOw0KPiAtCQkJaWYgKHJldCkNCj4gLQkJ
CQlnb3RvIGVycm9yX2Rpc2FibGVfcmVnOw0KPiAgCQl9DQo+ICAJfSBlbHNlIHsNCj4gIAkJc3Qt
PmZpeGVkX2FkZHIgPSB0cnVlOw0KPiBAQCAtNDY1LDcgKzQ2NSw3IEBAIHN0YXRpYyBpbnQgYWQ3
MjY2X3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ICAJcmV0ID0gaWlvX3RyaWdnZXJl
ZF9idWZmZXJfc2V0dXAoaW5kaW9fZGV2LA0KPiAmaWlvX3BvbGxmdW5jX3N0b3JlX3RpbWUsDQo+
ICAJCSZhZDcyNjZfdHJpZ2dlcl9oYW5kbGVyLCAmaWlvX3RyaWdnZXJlZF9idWZmZXJfc2V0dXBf
b3BzKTsNCj4gIAlpZiAocmV0KQ0KPiAtCQlnb3RvIGVycm9yX2ZyZWVfZ3Bpb3M7DQo+ICsJCWdv
dG8gZXJyb3JfZGlzYWJsZV9yZWc7DQo+ICANCj4gIAlyZXQgPSBpaW9fZGV2aWNlX3JlZ2lzdGVy
KGluZGlvX2Rldik7DQo+ICAJaWYgKHJldCkNCj4gQEAgLTQ3NSw5ICs0NzUsNiBAQCBzdGF0aWMg
aW50IGFkNzI2Nl9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiAgDQo+ICBlcnJvcl9i
dWZmZXJfY2xlYW51cDoNCj4gIAlpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9jbGVhbnVwKGluZGlvX2Rl
dik7DQo+IC1lcnJvcl9mcmVlX2dwaW9zOg0KPiAtCWlmICghc3QtPmZpeGVkX2FkZHIpDQo+IC0J
CWdwaW9fZnJlZV9hcnJheShzdC0+Z3Bpb3MsIEFSUkFZX1NJWkUoc3QtPmdwaW9zKSk7DQo+ICBl
cnJvcl9kaXNhYmxlX3JlZzoNCj4gIAlpZiAoIUlTX0VSUihzdC0+cmVnKSkNCj4gIAkJcmVndWxh
dG9yX2Rpc2FibGUoc3QtPnJlZyk7DQo+IEBAIC00OTIsOCArNDg5LDYgQEAgc3RhdGljIGludCBh
ZDcyNjZfcmVtb3ZlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ICANCj4gIAlpaW9fZGV2aWNl
X3VucmVnaXN0ZXIoaW5kaW9fZGV2KTsNCj4gIAlpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9jbGVhbnVw
KGluZGlvX2Rldik7DQo+IC0JaWYgKCFzdC0+Zml4ZWRfYWRkcikNCj4gLQkJZ3Bpb19mcmVlX2Fy
cmF5KHN0LT5ncGlvcywgQVJSQVlfU0laRShzdC0+Z3Bpb3MpKTsNCj4gIAlpZiAoIUlTX0VSUihz
dC0+cmVnKSkNCj4gIAkJcmVndWxhdG9yX2Rpc2FibGUoc3QtPnJlZyk7DQo+ICANCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9hZDcyNjYuaA0KPiBiL2luY2x1ZGUv
bGludXgvcGxhdGZvcm1fZGF0YS9hZDcyNjYuaA0KPiBpbmRleCA3ZGU2YzE2MTIyZGYuLmYwNjUy
NTY3YWZiYSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2FkNzI2
Ni5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9hZDcyNjYuaA0KPiBAQCAt
NDAsMTQgKzQwLDExIEBAIGVudW0gYWQ3MjY2X21vZGUgew0KPiAgICogQHJhbmdlOiBSZWZlcmVu
Y2Ugdm9sdGFnZSByYW5nZSB0aGUgZGV2aWNlIGlzIGNvbmZpZ3VyZWQgZm9yDQo+ICAgKiBAbW9k
ZTogU2FtcGxlIG1vZGUgdGhlIGRldmljZSBpcyBjb25maWd1cmVkIGZvcg0KPiAgICogQGZpeGVk
X2FkZHI6IFdoZXRoZXIgdGhlIGFkZHJlc3MgcGlucyBhcmUgaGFyZC13aXJlZA0KPiAtICogQGFk
ZHJfZ3Bpb3M6IEdQSU9zIHVzZWQgZm9yIGNvbnRyb2xsaW5nIHRoZSBhZGRyZXNzIHBpbnMsIG9u
bHkgdXNlZA0KPiBpZg0KPiAtICoJCWZpeGVkX2FkZHIgaXMgc2V0IHRvIGZhbHNlLg0KPiAgICov
DQo+ICBzdHJ1Y3QgYWQ3MjY2X3BsYXRmb3JtX2RhdGEgew0KPiAgCWVudW0gYWQ3MjY2X3Jhbmdl
IHJhbmdlOw0KPiAgCWVudW0gYWQ3MjY2X21vZGUgbW9kZTsNCj4gIAlib29sIGZpeGVkX2FkZHI7
DQo+IC0JdW5zaWduZWQgaW50IGFkZHJfZ3Bpb3NbM107DQo+ICB9Ow0KPiAgDQo+ICAjZW5kaWYN
Cg==
