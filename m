Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FCA1CD598
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 11:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgEKJoy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 05:44:54 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:29686 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728209AbgEKJox (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 May 2020 05:44:53 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04B9hKTH009875;
        Mon, 11 May 2020 05:44:50 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2051.outbound.protection.outlook.com [104.47.46.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 30wse5mnw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 05:44:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOhJ10TrgjOebv1VPRhNPD384CEI39LiIC3i8ZMBiQHFYkz9Hq7OF7JemjAC3JCMPFCVZAAhXzRH71DOTasNj5k9vtfTcNxgU9R+EsBFe84yem9dOeajAYSnPtmwEd2zMci+kb/hE9ge8ghz+N6i91iKS46wIxqSulUB49uY4p22Ev+3m/hoqv6DLCy17CFsUvaI2SeXWTtegJXJau0NDCWy47mRWkHotMgCHfW9TCcZXKIHR7TLtbaTE+gq1h6l5XRXQLNKP5KvQjPUBTbKHcSrfazw+7b9pi3ZtRxLvHLestu74BNQQvY7cPCFyGkXoDJISepNgIzc3kQDngfauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eez82+Qi+rOrlQh6+igo1mnxW71uJ0QE/LZYYjfj+Jk=;
 b=M2zpYy9nss1sha8XoknCO/cvQ77OvHiYTsJ1ELxs/Xw6cA8g8rvY90MzcZ5vJ11rZfqvb8FqqPqJ6LJRjy+MmdyXO8LkrYBk/QQPbLatuvumPM2gLAl8uIfwZpIYthZi7713M0ENOMcNJdpShJBy3aUs6Wl+90viP+BafOFQyPPwPJf1sQGxB62fUhqkf6i4TaYW09Qc5XFmZGi3/P+UuaN5ELCkTc+x2tnxm3Mquy+IwFqOVhT8yYAVDkwZGwS4T6R2ccbvZPpJKe0J4WIvaVyq0gLk8I1hTj1EaGaIF3UVHKk41gFSF1bJxk5DhYVrRef90QxmUm0UEqbTHSKYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eez82+Qi+rOrlQh6+igo1mnxW71uJ0QE/LZYYjfj+Jk=;
 b=UybfkCrbLENPrfPwEQOfRzPc7cn0pVNvIHOYSHo1OhUu22zzxw84BGlKObwVKYk1x2DlnUWU1Iq3IAuGAx5zGtGe8RDe3Rklym20oci2ei/B3OYy+9qQ3cIoYA/lI4E5kF1a7MpXCBs8vCMf6H8HtkveV35Q6Gi/OTo1Bu99JG8=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3834.namprd03.prod.outlook.com (2603:10b6:5:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Mon, 11 May
 2020 09:44:47 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 09:44:47 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH] iio: buffer: rework buffer attr read-only stat-flags with
 'is_visible' hook
Thread-Topic: [PATCH] iio: buffer: rework buffer attr read-only stat-flags
 with 'is_visible' hook
Thread-Index: AQHWE/u2Ce3Zp4oBAUyLB2SiFz6XLKiiyaOA
Date:   Mon, 11 May 2020 09:44:47 +0000
Message-ID: <657c93a058dd504dc3d2a5912b5d9985eb69e72e.camel@analog.com>
References: <20200416143143.80046-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200416143143.80046-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ffbcd6a-94e3-4f34-e6a8-08d7f58ff157
x-ms-traffictypediagnostic: DM6PR03MB3834:
x-microsoft-antispam-prvs: <DM6PR03MB3834B23AC82C3884F7E3B129F9A10@DM6PR03MB3834.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KwhEktV7SZdzKzdZmL21GDYfPpszL1GLNmMGUXaIbnFIDegVuTCak0qO6hrCAlYqG03PXCEicp/hijEqKo8dDO8NR8mS/Th3E09zKC4S1u82dg69zK2VT9wFeoldwDF0g3qQWQPcnsn6I5xvsqLj37KnwMhhMSENr008/dWTFO4r34U+afbalXnHGV1pH4uU6H8DI2ImiRjJWbrgMLgWm4/1crWWEL4VDU59pVtDgDsyWbDdWaioj/a31Q0LtVAyFOVjIe35n7+SG4aUW5WatwN1HCR3noRkwiXabudtJ6XJKO+7r8sAnyqHjI901BURyNQtAqvxA8AA/SiNsRkVftsBFFUFVLkueAvT2C/Zp9c6mq6sk2oCTgfv3rsiNCFlPZirnoRL2hpPYIA6TXYD1j5VFcvDx+VZpUjCcSfzIcHdjHsGt70xXCuGucyhprTFww1XF+Tpr3qeKLHbmO9Wcac448WChMiHgb7pJaH70G4iUxQZYGv1ez42S/9Qo44YUkDEoeEl97DZnTREOl3qMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(366004)(39860400002)(136003)(346002)(33430700001)(316002)(26005)(110136005)(71200400001)(6512007)(4326008)(91956017)(8676002)(66446008)(76116006)(8936002)(5660300002)(6486002)(33440700001)(66476007)(66556008)(86362001)(2906002)(64756008)(186003)(478600001)(36756003)(6506007)(2616005)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: HIuCnVQn3MA7l2Kz2vUykoZOqM1hct56mUZHkMQABH66YSRBXGKBMqbxS809o6kB/cwMk/zDFXxRt8JnRE2GOEt06RRY/CEnmf3ZEpDF2kKenny4AIBJAHih8mlX4hsiy7MY8LTBrOp+PC5+hPAY87HuB5fXGYcOJK+RT683XD6nYM80M+ngYgw3kcGeBjyXPw0FfntgZuwdAmq1ai8JJmQqzRet69fbc3gNaQtRI9EUSjhoK/QqbVhqgBfRUH8gET5GmI/PQoMQOg/tC1LbRPgeBPLyzevpP9o+/yu9gSHYk/F07vtlUPHERgBm7LuwAkNTxeC6HcX0esTS1moxBgvxdbc5dkfFpUqn1wPviWg9SeBQwISwxCKr5n58JFUajPVdODlOe41Hrx2QCrkhxxF7RLNwN9OLNKWjQtsOJx1chU5yYeoivglR3TSIE++EMy1z9shPuce18/xYKE82rETC9+khlAn7InrvCQVhi7E=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <37F32B57DB831A43B8BD8D45D4182052@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffbcd6a-94e3-4f34-e6a8-08d7f58ff157
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 09:44:47.2893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M6MY90GVp5Q7zq8BnSipEvt/bcSP9bpJ6djM2fhsjkcxIRhU0+6w7MpEbL1jwWYS+oJ5qp1/XSCJkRMjjW14u4rP41TIsVl3lvKz4eTtCeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3834
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_03:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110079
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTE2IGF0IDE3OjMxICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IFRoZSBrZXJuZWwgcHJvdmlkZXMgYSBmYWNpbGl0eSBm
b3IgYXR0cmlidXRlIGdyb3VwcyB0byBzcGVjaWZ5IHRoZSBzdGF0DQo+IGZsYWdzIG9mIGEgc3lz
ZnMgZmlsZSB3aXRoIGFuICdpc192aXNpYmxlKCknIGhvb2suIFRoaXMgbWVjaGFuaXNtIGlzDQo+
IHVzdWFsbHkgbW9yZSBmbGV4aWJsZSB0aGFuIGFzc2lnbmluZyByZWFkLW9ubHkgYXR0cmlidXRl
cyBhdCBjb25zdHJ1Y3Rpb24NCj4gdGltZS4NCj4gSXQncyBhZGRlZC12YWx1ZSBpcyBhIGJpdCBt
b3JlIGFwcGFyZW50IHdoZW4gdGhlIG51bWJlciBvZiBhdHRyaWJ1dGVzDQo+IGdyb3dzLCBzbyBm
b3Igc3lzZnMgYnVmZmVyIGF0dHJpYnV0ZXMgdGhpcyBjaGFuZ2UgbWF5IG5vdCBiZSB0aGF0IGJl
IHVzZWZ1bA0KPiBxdWl0ZSBub3cuDQo+IA0KPiBJdCBzaG91bGQgYmVjb21lIG1vcmUgdXNlZnVs
IGFzIHRoZSBzeXNmcyBzdHJ1Y3R1cmUgZm9yIGJ1ZmZlciBhdHRyaWJ1dGVzDQo+IGdldHMgY2hh
bmdlZCBhIGJpdC4NCg0KTGV0J3MgZGlzcmVnYXJkIHRoaXMgZm9yIG5vdy4NCkl0IG1heSBub3Qg
YmUgd29ydGggZG9pbmcgdGhpcywgdW50aWwgYSBiZXR0ZXIgY29udGV4dC9yZWFzb24gYXBwZWFy
cy4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUu
YXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8t
YnVmZmVyLmMgfCA0OCArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jIGIvZHJpdmVycy9paW8vaW5k
dXN0cmlhbGlvLQ0KPiBidWZmZXIuYw0KPiBpbmRleCAyMjExNTcxMzZhZjYuLjYwYmIwM2U3MmFm
YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+ICsr
KyBiL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1idWZmZXIuYw0KPiBAQCAtMTIxNCwyNCArMTIx
NCw1MCBAQCBzdGF0aWMgc3NpemVfdCBpaW9fZG1hX3Nob3dfZGF0YV9hdmFpbGFibGUoc3RydWN0
DQo+IGRldmljZSAqZGV2LA0KPiAgCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiV6dVxuIiwgYnl0ZXMp
Ow0KPiAgfQ0KPiAgDQo+ICtlbnVtIHsNCj4gKwlJSU9fQlVGRkVSX0FUVFJfTEVOR1RILA0KPiAr
CUlJT19CVUZGRVJfQVRUUl9FTkFCTEUsDQo+ICsJSUlPX0JVRkZFUl9BVFRSX1dBVEVSTUFSSywN
Cj4gKwlJSU9fQlVGRkVSX0FUVFJfREFUQV9BVkFJTEFCTEUsDQo+ICsJX19JSU9fQlVGRkVSX0FU
VFJfTUFYDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgdW1vZGVfdCBpaW9fYnVmZmVyX2F0dHJfZ3Jv
dXBfaXNfdmlzaWJsZShzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4gKwkJCQkJCXN0cnVjdCBhdHRy
aWJ1dGUgKmF0dHIsDQo+ICsJCQkJCQlpbnQgaW5kZXgpDQo+ICt7DQo+ICsJc3RydWN0IGRldmlj
ZSAqZGV2ID0gY29udGFpbmVyX29mKGtvYmosIHN0cnVjdCBkZXZpY2UsIGtvYmopOw0KPiArCXN0
cnVjdCBpaW9fZGV2ICppbmRpb19kZXYgPSBkZXZfdG9faWlvX2RldihkZXYpOw0KPiArCXN0cnVj
dCBpaW9fYnVmZmVyICpidWZmZXIgPSBpbmRpb19kZXYtPmJ1ZmZlcjsNCj4gKw0KPiArCXN3aXRj
aCAoaW5kZXgpIHsNCj4gKwljYXNlIElJT19CVUZGRVJfQVRUUl9MRU5HVEg6DQo+ICsJCWlmICgh
YnVmZmVyLT5hY2Nlc3MtPnNldF9sZW5ndGgpDQo+ICsJCQlyZXR1cm4gU19JUlVHTzsNCj4gKwkJ
cmV0dXJuIGF0dHItPm1vZGU7DQo+ICsJY2FzZSBJSU9fQlVGRkVSX0FUVFJfV0FURVJNQVJLOg0K
PiArCQlpZiAoYnVmZmVyLT5hY2Nlc3MtPmZsYWdzICYgSU5ESU9fQlVGRkVSX0ZMQUdfRklYRURf
V0FURVJNQVJLKQ0KPiArCQkJcmV0dXJuIFNfSVJVR087DQo+ICsJCXJldHVybiBhdHRyLT5tb2Rl
Ow0KPiArCWRlZmF1bHQ6DQo+ICsJCXJldHVybiBhdHRyLT5tb2RlOw0KPiArCX0NCj4gK30NCj4g
Kw0KPiAgc3RhdGljIERFVklDRV9BVFRSKGxlbmd0aCwgU19JUlVHTyB8IFNfSVdVU1IsIGlpb19i
dWZmZXJfcmVhZF9sZW5ndGgsDQo+ICAJCSAgIGlpb19idWZmZXJfd3JpdGVfbGVuZ3RoKTsNCj4g
LXN0YXRpYyBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSBkZXZfYXR0cl9sZW5ndGhfcm8gPSBfX0FU
VFIobGVuZ3RoLA0KPiAtCVNfSVJVR08sIGlpb19idWZmZXJfcmVhZF9sZW5ndGgsIE5VTEwpOw0K
PiAgc3RhdGljIERFVklDRV9BVFRSKGVuYWJsZSwgU19JUlVHTyB8IFNfSVdVU1IsDQo+ICAJCSAg
IGlpb19idWZmZXJfc2hvd19lbmFibGUsIGlpb19idWZmZXJfc3RvcmVfZW5hYmxlKTsNCj4gIHN0
YXRpYyBERVZJQ0VfQVRUUih3YXRlcm1hcmssIFNfSVJVR08gfCBTX0lXVVNSLA0KPiAgCQkgICBp
aW9fYnVmZmVyX3Nob3dfd2F0ZXJtYXJrLCBpaW9fYnVmZmVyX3N0b3JlX3dhdGVybWFyayk7DQo+
IC1zdGF0aWMgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgZGV2X2F0dHJfd2F0ZXJtYXJrX3JvID0g
X19BVFRSKHdhdGVybWFyaywNCj4gLQlTX0lSVUdPLCBpaW9fYnVmZmVyX3Nob3dfd2F0ZXJtYXJr
LCBOVUxMKTsNCj4gIHN0YXRpYyBERVZJQ0VfQVRUUihkYXRhX2F2YWlsYWJsZSwgU19JUlVHTywN
Cj4gIAkJaWlvX2RtYV9zaG93X2RhdGFfYXZhaWxhYmxlLCBOVUxMKTsNCj4gIA0KPiAgc3RhdGlj
IHN0cnVjdCBhdHRyaWJ1dGUgKmlpb19idWZmZXJfYXR0cnNbXSA9IHsNCj4gLQkmZGV2X2F0dHJf
bGVuZ3RoLmF0dHIsDQo+IC0JJmRldl9hdHRyX2VuYWJsZS5hdHRyLA0KPiAtCSZkZXZfYXR0cl93
YXRlcm1hcmsuYXR0ciwNCj4gLQkmZGV2X2F0dHJfZGF0YV9hdmFpbGFibGUuYXR0ciwNCj4gKwlb
SUlPX0JVRkZFUl9BVFRSX0xFTkdUSF0gPSAmZGV2X2F0dHJfbGVuZ3RoLmF0dHIsDQo+ICsJW0lJ
T19CVUZGRVJfQVRUUl9FTkFCTEVdID0gJmRldl9hdHRyX2VuYWJsZS5hdHRyLA0KPiArCVtJSU9f
QlVGRkVSX0FUVFJfV0FURVJNQVJLXSA9ICZkZXZfYXR0cl93YXRlcm1hcmsuYXR0ciwNCj4gKwlb
SUlPX0JVRkZFUl9BVFRSX0RBVEFfQVZBSUxBQkxFXSA9ICZkZXZfYXR0cl9kYXRhX2F2YWlsYWJs
ZS5hdHRyLA0KPiAgfTsNCj4gIA0KPiAgaW50IGlpb19idWZmZXJfYWxsb2Nfc3lzZnNfYW5kX21h
c2soc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gQEAgLTEyNjYsMTEgKzEyOTIsNiBAQCBp
bnQgaWlvX2J1ZmZlcl9hbGxvY19zeXNmc19hbmRfbWFzayhzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5k
aW9fZGV2KQ0KPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gIA0KPiAgCW1lbWNweShhdHRyLCBpaW9f
YnVmZmVyX2F0dHJzLCBzaXplb2YoaWlvX2J1ZmZlcl9hdHRycykpOw0KPiAtCWlmICghYnVmZmVy
LT5hY2Nlc3MtPnNldF9sZW5ndGgpDQo+IC0JCWF0dHJbMF0gPSAmZGV2X2F0dHJfbGVuZ3RoX3Jv
LmF0dHI7DQo+IC0NCj4gLQlpZiAoYnVmZmVyLT5hY2Nlc3MtPmZsYWdzICYgSU5ESU9fQlVGRkVS
X0ZMQUdfRklYRURfV0FURVJNQVJLKQ0KPiAtCQlhdHRyWzJdID0gJmRldl9hdHRyX3dhdGVybWFy
a19yby5hdHRyOw0KPiAgDQo+ICAJaWYgKGJ1ZmZlci0+YXR0cnMpDQo+ICAJCW1lbWNweSgmYXR0
cltBUlJBWV9TSVpFKGlpb19idWZmZXJfYXR0cnMpXSwgYnVmZmVyLT5hdHRycywNCj4gQEAgLTEy
NzksNiArMTMwMCw3IEBAIGludCBpaW9fYnVmZmVyX2FsbG9jX3N5c2ZzX2FuZF9tYXNrKHN0cnVj
dCBpaW9fZGV2DQo+ICppbmRpb19kZXYpDQo+ICAJYXR0clthdHRyY291bnQgKyBBUlJBWV9TSVpF
KGlpb19idWZmZXJfYXR0cnMpXSA9IE5VTEw7DQo+ICANCj4gIAlidWZmZXItPmJ1ZmZlcl9ncm91
cC5uYW1lID0gImJ1ZmZlciI7DQo+ICsJYnVmZmVyLT5idWZmZXJfZ3JvdXAuaXNfdmlzaWJsZSA9
IGlpb19idWZmZXJfYXR0cl9ncm91cF9pc192aXNpYmxlOw0KPiAgCWJ1ZmZlci0+YnVmZmVyX2dy
b3VwLmF0dHJzID0gYXR0cjsNCj4gIA0KPiAgCWluZGlvX2Rldi0+Z3JvdXBzW2luZGlvX2Rldi0+
Z3JvdXBjb3VudGVyKytdID0gJmJ1ZmZlci0+YnVmZmVyX2dyb3VwOw0K
