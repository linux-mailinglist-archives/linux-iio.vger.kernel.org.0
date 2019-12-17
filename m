Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C45D123028
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 16:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfLQPXU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 10:23:20 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:39586 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728443AbfLQPXU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2019 10:23:20 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBHFKPWO012603;
        Tue, 17 Dec 2019 10:23:17 -0500
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2057.outbound.protection.outlook.com [104.47.45.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wvtfdes9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 10:23:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKpiz6j37+L7jb14B8f5AH3q/6vPIouPDIWtLofnYUsLC2JXePbZhS7tpAyRXvP4ISdG1rCgRiNzL7y9piT+VWU5xcyEjJrYVrQhOfFHrOkqqQPAixq5kFp/1lfhZopPi+KT1Tdz4exhncn2Kb7pP4e14tZ5TFDt6vw1kiQNUAedx+Kj0WrjnjyPvZLLpr2J1IyrgHXslqyv2QRnbrRbaHmNlNTogI5ERuS0iWoF+dyb3KUXiiKJUXkJMDJXL+AsIAcbQ7bbycykRlBSlHMAvJaM8kLGF44szvJ/dK5gaOndRc0ucn9ABZDMpw3TgfMFKY+tNOFw0Ho5IYUUT6hxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnGR2nrPO2GiKKEEQNLWewB+qvMrFeKfqxvBGdywGMI=;
 b=BIR2yWf07fLT7Ov0fCfIKOnTLS1yKKY+UJu7xjgZl/O107eZeeguFAKHZEqCEY3genxdNE9/MMU4lDlWpdFwdt3W+cRHJqqmRE+4NQK2kWpVwzgT38db750GA5gR7Jn0Uhiatz0pK6f+V3Ekdrbn1m83O3WL11IQo76oMPlW4Wfz7yJeXmfZGUrXL/tlZYUu2DE3e0HeSAeA5U8mxcelG0lIaNZ/a/NzpuJBSos24PPxn5Xi4i/b8xZZ63huLZYi4rOR4exEbEINNvxIiQwOKR6OMQne/FVjMYlszulrlp49QV6zgxz4des1JOpRepe2s5cN5QziKrju8nBnp9PxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnGR2nrPO2GiKKEEQNLWewB+qvMrFeKfqxvBGdywGMI=;
 b=46yWnTgJ9BeNQU6WbgkCGaJngkpjPljfDA3gv8hGRilQ2+PmSd8JF4trOZo+DX1QaUhiO+xLFedgJ8/qL8tFwGFSmXmk4awV9Bry4RGKWb2kHUqKH12XRzmeB33p3CHtSif9qVi4bMhE0HSudYCJA1VT97h9mNhKCNmlulmZs7M=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5191.namprd03.prod.outlook.com (20.180.13.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 15:23:16 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 15:23:16 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: core: print error message on debugfs register
 failure
Thread-Topic: [PATCH] iio: core: print error message on debugfs register
 failure
Thread-Index: AQHVsDXp2Nyyg9YfgkOL2n3l679swae+emEAgAABAIA=
Date:   Tue, 17 Dec 2019 15:23:16 +0000
Message-ID: <f58827883e1e7948b398f19cb422923882748347.camel@analog.com>
References: <20191211151636.13547-1-alexandru.ardelean@analog.com>
         <20191217151940.GB3654493@kroah.com>
In-Reply-To: <20191217151940.GB3654493@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 12701723-0c31-4a86-66b0-08d783050a23
x-ms-traffictypediagnostic: CH2PR03MB5191:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5191FCBB43D2610378F0A77DF9500@CH2PR03MB5191.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(6916009)(66946007)(76116006)(6486002)(478600001)(64756008)(66446008)(86362001)(186003)(66476007)(66556008)(5660300002)(54906003)(71200400001)(2616005)(316002)(6506007)(8936002)(8676002)(81166006)(81156014)(36756003)(4326008)(26005)(2906002)(6512007)(4001150100001)(15650500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5191;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uGpbVA0jkMo84hqY+pvWA4K2AnWXPkiqhEqGUURQ1m9cw30crhcP9hgDZ8iHs7oHfOjfW/2qNXYX5HXMePBlvQ+qMyuC5XxK+FfY/8MxP5PbX/PIIAea7h4bfmwCLVIgRWgZCyQ+jXzRsL3eXHlhQauG5kR+mq1pD35CLh/NDpygwhR+Zif61+cjOFCiwRWKxAml4JggkpETCKDl04Wzb71zFHBaKZ68o/RmsYf+nF/kS0S7GC8SCJR8X6MRh4+5ABzD2DF6frZ2SMmsIOcckcIv2h0/l+9z01NQDZsEqV5WI/Bhqyv/9bZ0rDSb/jB8YlY800v0CZhdeJP8rXRbk2PwDe+q8STtwafPKQGNJrpn5uy3ZdNujnE5ULPK9m2tNOWz0qzJtyTvDLW8UVof1wPTYMhnG2pafB6nBV3iSMXGbjujkbx1f4BTQNRSR56U
Content-Type: text/plain; charset="utf-8"
Content-ID: <732B814C71E7FF43A91097CAACF2D0DF@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12701723-0c31-4a86-66b0-08d783050a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 15:23:16.3814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Osi6uunWDFD+BdWmKUd8k7Logmi5DHCW+xRRIAwLNn5ceA3yFAw43/b6UJiq5fJwSSAXL/xzEg/GWB31Nm2ncxj2H2QIviPQDQe8VbSv+KM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5191
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_02:2019-12-17,2019-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912170129
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTE3IGF0IDE2OjE5ICswMTAwLCBHcmVnIEtIIHdyb3RlOg0KPiBbRXh0
ZXJuYWxdDQo+IA0KPiBPbiBXZWQsIERlYyAxMSwgMjAxOSBhdCAwNToxNjozNlBNICswMjAwLCBB
bGV4YW5kcnUgQXJkZWxlYW4gd3JvdGU6DQo+ID4gRnJvbTogTWljaGFlbCBIZW5uZXJpY2ggPG1p
Y2hhZWwuaGVubmVyaWNoQGFuYWxvZy5jb20+DQo+ID4gDQo+ID4gSWYgdGhlcmUncyBhIGZhaWx1
cmUgd2hlbiByZWdpc3RlcmluZyBhIGRlYnVnZnMgZW50cnkgZm9yIGEgZGV2aWNlLA0KPiA+IGRv
bid0DQo+ID4gc2lsZW50bHkgaWdub3JlIHRoZSBmYWlsdXJlLiBJbnN0ZWFkLCBwcmludCBhbiBl
cnJvciBtZXNzYWdlIGFuZCBhbg0KPiA+IGVycm9yDQo+ID4gY29kZSBzaWduYWxpbmcgdGhlIGZh
aWx1cmUuDQo+IA0KPiBObywgbmV2ZXIgZG8gdGhhdC4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
TWljaGFlbCBIZW5uZXJpY2ggPG1pY2hhZWwuaGVubmVyaWNoQGFuYWxvZy5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9n
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYyB8IDM0
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MjggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYw0KPiA+IGIvZHJpdmVycy9paW8vaW5kdXN0
cmlhbGlvLWNvcmUuYw0KPiA+IGluZGV4IGRhYjY3Y2I2OWZlNi4uNjYyZGFiZjhiMDhjIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmMNCj4gPiArKysgYi9k
cml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5jDQo+ID4gQEAgLTM2NCwyMyArMzY0LDQ1IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zDQo+ID4gaWlvX2RlYnVnZnNfcmVn
X2ZvcHMgPSB7DQo+ID4gIHN0YXRpYyB2b2lkIGlpb19kZXZpY2VfdW5yZWdpc3Rlcl9kZWJ1Z2Zz
KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ID4gIHsNCj4gPiAgCWRlYnVnZnNfcmVtb3Zl
X3JlY3Vyc2l2ZShpbmRpb19kZXYtPmRlYnVnZnNfZGVudHJ5KTsNCj4gPiArCWluZGlvX2Rldi0+
ZGVidWdmc19kZW50cnkgPSBOVUxMOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICBzdGF0aWMgdm9pZCBp
aW9fZGV2aWNlX3JlZ2lzdGVyX2RlYnVnZnMoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4g
PiAgew0KPiA+ICsJc3RydWN0IGRlbnRyeSAqZDsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+
ICAJaWYgKGluZGlvX2Rldi0+aW5mby0+ZGVidWdmc19yZWdfYWNjZXNzID09IE5VTEwpDQo+ID4g
IAkJcmV0dXJuOw0KPiA+ICANCj4gPiAgCWlmICghaWlvX2RlYnVnZnNfZGVudHJ5KQ0KPiA+ICAJ
CXJldHVybjsNCj4gPiAgDQo+ID4gLQlpbmRpb19kZXYtPmRlYnVnZnNfZGVudHJ5ID0NCj4gPiAt
CQlkZWJ1Z2ZzX2NyZWF0ZV9kaXIoZGV2X25hbWUoJmluZGlvX2Rldi0+ZGV2KSwNCj4gPiAtCQkJ
CSAgIGlpb19kZWJ1Z2ZzX2RlbnRyeSk7DQo+ID4gKwlkID0gZGVidWdmc19jcmVhdGVfZGlyKGRl
dl9uYW1lKCZpbmRpb19kZXYtPmRldiksDQo+ID4gaWlvX2RlYnVnZnNfZGVudHJ5KTsNCj4gPiAr
CWlmIChJU19FUlJfT1JfTlVMTChkKSkNCj4gPiArCQlnb3RvIGVycm9yOw0KPiANCj4gTm8sIGRv
bid0IGRvIHRoYXQsIEkgc3BlbnQgYSBsb3Qgb2YgdGltZSByZW1vdmluZyBhbGwgb2YgdGhlc2Ug
cG9pbnRsZXNzDQo+IGNoZWNrcy4NCj4gDQo+IE5vIGtlcm5lbCBjb2RlIHNob3VkbCBldmVyIGNh
cmUgaWYgZGVidWdmcyBpcyB3b3JraWduIG9yIG5vdCwganVzdCBtYWtlDQo+IHRoZSBjYWxsIGFu
ZCBtb3ZlIG9uLiAgIFlvdSBjYW4gYWx3YXlzIHBhc3MgdGhlIHJlc3VsdCBvZiBhIGRlYnVnZnMg
Y2FsbA0KPiBpbnRvIGFub3RoZXIgb25lIHdpdGggbm8gcHJvYmxlbXMuDQo+IA0KPiA+ICsNCj4g
PiArCWluZGlvX2Rldi0+ZGVidWdmc19kZW50cnkgPSBkOw0KPiA+ICsNCj4gPiArCWQgPSBkZWJ1
Z2ZzX2NyZWF0ZV9maWxlKCJkaXJlY3RfcmVnX2FjY2VzcyIsIDA2NDQsDQo+ID4gKwkJCQlpbmRp
b19kZXYtPmRlYnVnZnNfZGVudHJ5LCBpbmRpb19kZXYsDQo+ID4gKwkJCQkmaWlvX2RlYnVnZnNf
cmVnX2ZvcHMpOw0KPiA+ICsNCj4gPiArCWlmIChJU19FUlJfT1JfTlVMTChkKSkNCj4gPiArCQln
b3RvIGVycm9yOw0KPiANCj4gVGhpcyBjaGVjayBpc24ndCBldmVuIGNvcnJlY3QgOikNCj4gDQo+
IFNvIHRoaXMgaXNuJ3QgZ29pbmcgdG8gd29yayBubyBtYXR0ZXIgd2hhdCwgc29ycnkuDQo+IA0K
PiBqdXN0IGRvbid0IGRvIHRoaXMuDQo+IA0KPiBUaGUgY29kZSBpcyBqdXN0IGZpbmUgYXMtaXMu
DQoNCkknbSBmaW5lIHdpdGggdGhpcyBhbnN3ZXIuDQpJJ2xsIHN5bmMgb3VyIElJTyBjb3JlIGNv
ZGUgd2l0aCB1cHN0cmVhbS4NCk1vc3RseSBJIGp1c3QgY2FyZSB0aGF0IHRoZSBkaWZmIGJldHdl
ZW4gdGhlIDIgZmlsZXMgaXMgZW1wdHkuDQoNClRoYW5rcw0KQWxleA0KDQo+IA0KPiB0aGFua3Ms
DQo+IA0KPiBncmVnIGstaA0K
