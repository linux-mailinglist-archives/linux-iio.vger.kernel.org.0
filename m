Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB7DC167C2B
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 12:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgBULbn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 06:31:43 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:42582 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726976AbgBULbm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Feb 2020 06:31:42 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LBMI4E011673;
        Fri, 21 Feb 2020 06:31:41 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y8ucu7081-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 06:31:41 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01LBVdg7027649
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 21 Feb 2020 06:31:40 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 21 Feb 2020 03:31:38 -0800
Received: from SCSQMBX11.ad.analog.com ([fe80::85c7:ecf4:1eb:a06a]) by
 SCSQMBX11.ad.analog.com ([fe80::85c7:ecf4:1eb:a06a%11]) with mapi id
 15.01.1779.002; Fri, 21 Feb 2020 03:31:38 -0800
From:   "Tachici, Alexandru" <Alexandru.Tachici@analog.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH] iio: industrialio-core: Fix debugfs read
Thread-Topic: [PATCH] iio: industrialio-core: Fix debugfs read
Thread-Index: AQHV6BBQxR5yYELnZUiE4S0ivwpcOKgmCt4A
Date:   Fri, 21 Feb 2020 11:31:38 +0000
Message-ID: <f89679270083f0ff24eeca43d8e5db08c61a93b5.camel@analog.com>
References: <20200220170726.9580-1-alexandru.tachici@analog.com>
In-Reply-To: <20200220170726.9580-1-alexandru.tachici@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.175]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B74E03CB7FF6743BBA207F240F993DA@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_03:2020-02-19,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210087
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTAyLTIwIGF0IDE5OjA3ICswMjAwLCBBbGV4YW5kcnUgVGFjaGljaSB3cm90
ZToNCj4gQ3VycmVudGx5IGlpb19kZWJ1Z2ZzX3JlYWRfcmVnIGNhbGxzIGRlYnVnZnNfcmVnX2Fj
Y2Vzcw0KPiBldmVyeSB0aW1lIGl0IGlzIHJhbi4gUmVhZGluZyB0aGUgc2FtZSBoYXJkd2FyZSBy
ZWdpc3Rlcg0KPiBtdWx0aXBsZSB0aW1lcyBkdXJpbmcgdGhlIHNhbWUgcmVhZGluZyBvZiBhIGRl
YnVnZnMgZmlsZQ0KPiBjYW4gY2F1c2UgdW5pbnRlbmRlZCBlZmZlY3RzLg0KPiANCj4gRm9yIGV4
YW1wbGUgZm9yIGVhY2g6IGNhdCBpaW86ZGV2aWNlMC9kaXJlY3RfcmVnX2FjY2Vzcw0KPiB0aGUg
ZmlsZV9vcGVyYXRpb25zLnJlYWQgZnVuY3Rpb24gd2lsbCBiZSBjYWxsZWQgYXQgbGVhc3QNCj4g
dHdpY2UuIEZpcnN0IHdpbGwgcmV0dXJuIHRoZSBmdWxsIGxlbmd0aCBvZiB0aGUgc3RyaW5nIGlu
DQo+IGJ5dGVzICBhbmQgdGhlIHNlY29uZCB3aWxsIHJldHVybiAwLg0KPiANCj4gVGhpcyBwYXRj
aCBtYWtlcyBpaW9fZGVidWdmc19yZWFkX3JlZyB0byBjYWxsIGRlYnVnZnNfcmVnX2FjY2Vzcw0K
PiBvbmx5IHdoZW4gdGhlIHVzZXIncyBidWZmZXIgcG9zaXRpb24gKCpwcG9zKSBpcyAwLiAobWVh
bmluZw0KPiBpdCBpcyB0aGUgYmVnaW5uaW5nIG9mIGEgbmV3IHJlYWRpbmcgb2YgdGhlIGRlYnVn
ZnMgZmlsZSkuDQoNClBsZWFzZSBkaXNyZWdhcmQgdGhpcy4gV2lsbCBzZW5kIGEgVjIuDQogDQo+
IEZpeGVzOiBlNTUzZjE4MmQ1NWIgKCJzdGFnaW5nOiBpaW86IGNvcmU6IEludHJvZHVjZSBkZWJ1
Z2ZzIHN1cHBvcnQsDQo+IGFkZCBzdXBwb3J0IGZvciBkaXJlY3QgcmVnaXN0ZXIgYWNjZXNzIikN
Cj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IFRhY2hpY2kgPGFsZXhhbmRydS50YWNoaWNpQGFu
YWxvZy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYyB8IDM0
ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+IC0tLS0NCj4gIGluY2x1ZGUvbGludXgv
aWlvL2lpby5oICAgICAgICAgfCAgMiArKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRp
b25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9p
bmR1c3RyaWFsaW8tY29yZS5jDQo+IGIvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYw0K
PiBpbmRleCA2NWZmMGQwNjcwMTguLjYzN2NlYTE0YWZkYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYw0KPiArKysgYi9kcml2ZXJzL2lpby9pbmR1c3RyaWFs
aW8tY29yZS5jDQo+IEBAIC0yOTcsMjYgKzI5Nyw0MCBAQCBzdGF0aWMgdm9pZCBfX2V4aXQgaWlv
X2V4aXQodm9pZCkNCj4gIH0NCj4gIA0KPiAgI2lmIGRlZmluZWQoQ09ORklHX0RFQlVHX0ZTKQ0K
PiAtc3RhdGljIHNzaXplX3QgaWlvX2RlYnVnZnNfcmVhZF9yZWcoc3RydWN0IGZpbGUgKmZpbGUs
IGNoYXIgX191c2VyDQo+ICp1c2VyYnVmLA0KPiAtCQkJICAgICAgc2l6ZV90IGNvdW50LCBsb2Zm
X3QgKnBwb3MpDQo+ICtzdGF0aWMgaW50IGlpb19kZWJ1Z2ZzX2dldF9yZWdfc3RyaW5nKHN0cnVj
dCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ICB7DQo+IC0Jc3RydWN0IGlpb19kZXYgKmluZGlvX2Rl
diA9IGZpbGUtPnByaXZhdGVfZGF0YTsNCj4gLQljaGFyIGJ1ZlsyMF07DQo+ICsJY29uc3Qgc3Ry
dWN0IGlpb19pbmZvICppbmZvID0gaW5kaW9fZGV2LT5pbmZvOw0KPiAgCXVuc2lnbmVkIHZhbCA9
IDA7DQo+IC0Jc3NpemVfdCBsZW47DQo+ICAJaW50IHJldDsNCj4gIA0KPiAtCXJldCA9IGluZGlv
X2Rldi0+aW5mby0+ZGVidWdmc19yZWdfYWNjZXNzKGluZGlvX2RldiwNCj4gLQkJCQkJCSAgaW5k
aW9fZGV2LQ0KPiA+Y2FjaGVkX3JlZ19hZGRyLA0KPiAtCQkJCQkJICAwLCAmdmFsKTsNCj4gKwly
ZXQgPSBpbmZvLT5kZWJ1Z2ZzX3JlZ19hY2Nlc3MoaW5kaW9fZGV2LCBpbmRpb19kZXYtDQo+ID5j
YWNoZWRfcmVnX2FkZHIsDQo+ICsJCQkJICAgICAgIDAsICZ2YWwpOw0KPiAgCWlmIChyZXQpIHsN
Cj4gIAkJZGV2X2VycihpbmRpb19kZXYtPmRldi5wYXJlbnQsICIlczogcmVhZCBmYWlsZWRcbiIs
DQo+IF9fZnVuY19fKTsNCj4gIAkJcmV0dXJuIHJldDsNCj4gIAl9DQo+ICsJaW5kaW9fZGV2LT5y
ZWFkX2J1Zl9sZW4gPSBzbnByaW50ZihpbmRpb19kZXYtPnJlYWRfYnVmLA0KPiArCQkJCQkgICBz
aXplb2YoaW5kaW9fZGV2LT5yZWFkX2J1ZiksDQo+ICsJCQkJCSAgICIweCVYXG4iLCB2YWwpOw0K
PiArCXJldHVybiAwOw0KPiArfQ0KPiAgDQo+IC0JbGVuID0gc25wcmludGYoYnVmLCBzaXplb2Yo
YnVmKSwgIjB4JVhcbiIsIHZhbCk7DQo+ICtzdGF0aWMgc3NpemVfdCBpaW9fZGVidWdmc19yZWFk
X3JlZyhzdHJ1Y3QgZmlsZSAqZmlsZSwgY2hhciBfX3VzZXINCj4gKnVzZXJidWYsDQo+ICsJCQkJ
ICAgIHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQ0KPiArew0KPiArCXN0cnVjdCBpaW9fZGV2
ICppbmRpb19kZXYgPSBmaWxlLT5wcml2YXRlX2RhdGE7DQo+ICsJbG9mZl90IHBvcyA9ICpwcG9z
Ow0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlpZiAocG9zID09IDApIHsNCj4gKwkJcmV0ID0gaWlv
X2RlYnVnZnNfZ2V0X3JlZ19zdHJpbmcoaW5kaW9fZGV2KTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJ
CXJldHVybiByZXQ7DQo+ICsJfQ0KPiAgDQo+IC0JcmV0dXJuIHNpbXBsZV9yZWFkX2Zyb21fYnVm
ZmVyKHVzZXJidWYsIGNvdW50LCBwcG9zLCBidWYsIGxlbik7DQo+ICsJcmV0dXJuIHNpbXBsZV9y
ZWFkX2Zyb21fYnVmZmVyKHVzZXJidWYsIGNvdW50LCBwcG9zLA0KPiArCQkJCSAgICAgICBpbmRp
b19kZXYtPnJlYWRfYnVmLA0KPiArCQkJCSAgICAgICBpbmRpb19kZXYtPnJlYWRfYnVmX2xlbik7
DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBzc2l6ZV90IGlpb19kZWJ1Z2ZzX3dyaXRlX3JlZyhzdHJ1
Y3QgZmlsZSAqZmlsZSwNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaWlvL2lpby5oIGIv
aW5jbHVkZS9saW51eC9paW8vaWlvLmgNCj4gaW5kZXggODYyY2UwMDE5ZWJhLi5lZWQ1OGVkMmYz
NjggMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvaWlvL2lpby5oDQo+ICsrKyBiL2luY2x1
ZGUvbGludXgvaWlvL2lpby5oDQo+IEBAIC01NjgsNiArNTY4LDggQEAgc3RydWN0IGlpb19kZXYg
ew0KPiAgI2lmIGRlZmluZWQoQ09ORklHX0RFQlVHX0ZTKQ0KPiAgCXN0cnVjdCBkZW50cnkJCQkq
ZGVidWdmc19kZW50cnk7DQo+ICAJdW5zaWduZWQJCQljYWNoZWRfcmVnX2FkZHI7DQo+ICsJY2hh
cgkJCQlyZWFkX2J1ZlsyMF07DQo+ICsJdW5zaWduZWQgaW50CQkJcmVhZF9idWZfbGVuOw0KPiAg
I2VuZGlmDQo+ICB9Ow0KPiAgDQo=
