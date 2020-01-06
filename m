Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1426130FAA
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2020 10:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgAFJlI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jan 2020 04:41:08 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:60902 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726080AbgAFJlH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jan 2020 04:41:07 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0069cWE4023419;
        Mon, 6 Jan 2020 04:41:06 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xarg93ku8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jan 2020 04:41:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXpDbg0oclFByCstUQ5XzczcvkKeaHant8Gyx9e9f148otlxbh0B0QSoIA59lkXhoasDxmHn9wRquvfznlvxnfhUaa+bvo1TE9Vkxb6gxDc7rWw9fxfS2m449/kTlQrG7ukDI6fttCSuUVLuFKmUyWtcDXXVK9uMaoKLC0rTixaFUo8Y77cJeFL0zS5cDJ1sGDXnUVSy3l4JYIYBdsu7sfkakHP71Fj2o7rN5mI9tIA07OfoQrw5sGi9XagMG4XLSGEynJyD5SPNZEl2dZFAo0XyTASaTRqL1Z68jQWVCWN4Wv1RzelN4z5X3nUZjpLqGft7u5GxMSO2LRYZROssJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPpHMXItwBwwCbMZBbhMpwCxnOqbRBTkOnrcWh4hjNw=;
 b=U9ZqorcZeDsejOAit4WXX6oj9JfBkOwVkzFFeGr6yxg00jgdXjxfrBD5pbJeHPGx3TgChwjXW56RSPySTjTuUQ3dXGt5mjCP37AZGhxHXDAsq9lUL7+mM1VzAMuwDQnLjwTD8sKVCafGTfTYouu9hMkOqZYxy9VA1GYPjtE80otJp0b4/B++jpnRKHx8mWPTDniH9KcX7ag6gcCw/F40ZfQWiC6VYjeLHx/XdNNQXBa5z+Intav60lqtzerfzGPpuVXibBYMnix0TGL1fa1B8QlNILdVZC9CtaeW4oylU2kiRHBw9kMwKrr5QiJGTLZ0wHM+98TYfEhAw6tZgEmFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPpHMXItwBwwCbMZBbhMpwCxnOqbRBTkOnrcWh4hjNw=;
 b=Ebb6WwGCzByVYNgZQqGFPlYz4bA++3x4+tUDeShJWMtIsmzGCM6L4MXxb2ZRosR/koVMCLT5j7e7gglxZsRqHZkCjc/n/2AjOVtIHRb6Rf5zPktvelvHHiFdl+FbPrNI0G/kn83Z8xc0zQ2wZjOntM2otJZfRqr/zC7pJi99kS0=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5351.namprd03.prod.outlook.com (20.180.5.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Mon, 6 Jan 2020 09:41:04 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 09:41:04 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Tachici, Alexandru" <Alexandru.Tachici@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH] iio: ad_sigma_delta: Add custom irq flags
Thread-Topic: [PATCH] iio: ad_sigma_delta: Add custom irq flags
Thread-Index: AQHVxHUydvRqWjXxfk6f3TrCdZDjvafdYeeA
Date:   Mon, 6 Jan 2020 09:41:04 +0000
Message-ID: <4315d67b125da94e9a172f3860bbfa3bf0086df0.camel@analog.com>
References: <20200106093852.29702-1-alexandru.tachici@analog.com>
In-Reply-To: <20200106093852.29702-1-alexandru.tachici@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5521bf92-e239-4256-ebc0-08d7928c8c3e
x-ms-traffictypediagnostic: CH2PR03MB5351:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB535178C4324B0415326E8107F93C0@CH2PR03MB5351.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(86362001)(66476007)(36756003)(71200400001)(76116006)(6512007)(26005)(186003)(66946007)(8936002)(2906002)(66556008)(66446008)(64756008)(4326008)(6506007)(478600001)(8676002)(316002)(81166006)(5660300002)(110136005)(2616005)(6486002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5351;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2nL7BvsF3mqyaC700zBSAtgjah12aW28CT+d+MgYB9i9qv0Spcy+LS9dI2rBtI/JdyZcB07LlYjCLXgkgsTs2IvmaREZS8IupZ3Ff0s/WGq9E8BR8ZIxnXQWFG/1un+FTt7W2w64MWSvydQxPHe32PGbTxIQdk4v/gs2MpcVS/+PdmdWPoVnm3Q5QfL7R22Hv/NVy8ZzvjbrUxTzAkm3IlsrbQwlPAq8NgUNn5yr9X8zSm3tRqhV68BYZXMh/bL7Ttx+8u4jTDubW6gqxRIl3xemsmJJHnu/xts3vam23yFyqWnXZfOsV6LXDovNnSpz3bvtPrYcSdqZcoKVKUeK840Cxo6wLVNonOacdbsGQHFRMmnA00wBPn9ya5DeUAFW99+9Q1sPd/yPHm6K/JCkkHzy0X2E2EMYAFNBm2O6yLNcOh7TBKov2/3/SfwzPOm7
Content-Type: text/plain; charset="utf-8"
Content-ID: <9111195465277446B61F69BE3C397B14@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5521bf92-e239-4256-ebc0-08d7928c8c3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 09:41:04.1060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ujNmeQDRbFUIs2LCXmecfsZ7+vFWBSfaFzu3VErUkIvzv4FNPjZk/pUuJGgLYuV0+Oss84sqWyRHGD1e3cxvG5GLPcDtFCxqXwA1CL8dgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5351
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_02:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060088
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTAxLTA2IGF0IDExOjM4ICswMjAwLCBBbGV4YW5kcnUgVGFjaGljaSB3cm90
ZToNCj4gW0V4dGVybmFsXQ0KPiANCj4gVGhlIGRhdGEtc2hlZXQgb2YgQUQ3MTI0LCBmcm9tIHRo
ZSBTaWdtYS1EZWx0YSBBREMgZmFtaWx5LA0KPiByZWNvbW1lbmRzIHRoYXQgdGhlIGZhbGxpbmcg
ZWRnZSBvZiB0aGUgRE9VVCBsaW5lIHNob3VsZCBiZSB1c2VkIGZvcg0KPiBhbiBpbnRlcnJ1cHQu
DQo+IA0KPiBUaGUgYWRfc2lnbWFfZGVsdGEgaW1wbGVtZW50YXRpb24gaGFyZGNvZGVzIHRoZSBp
cnEgdHJpZ2dlciB0eXBlDQo+IHRvIGxvdywgYXNzdW1pbmcgdGhhdCBhbGwgU2lnbWEtRGVsdGEg
QURDcyBoYXZlIHRoZSBzYW1lIGludGVycnVwdC10eXBlLg0KPiBUaGlzIGNhdXNlcyB1bndhbnRl
ZCBiZWhhdmlvdXIuIElmIERPVVQgbGluZSBpcyBhbHJlYWR5IGxvdywgdGhlDQo+IGludGVycnVw
dCB3aWxsIGZpcmUgb25jZSwgd2hlbiBlbmFibGVkIGFuZCB0aGUgaXJxIGhhbmRsZXIgd2lsbCBz
ZW5kIGENCj4gcmVhZCByZXF1ZXN0IHRvIHRoZSBkZXZpY2UuIEF0IHRoaXMgdGltZSB0aGUgZGV2
aWNlIGhhcyBub3QgeWV0IGZpbmlzaGVkDQo+IHRoZSBwcmV2aW91cyBjb252ZXJzaW9uIGFuZCB3
aWxsIGdpdmUgYSBiYWQgcmVhZGluZy4NCj4gDQo+IFRoaXMgcGF0Y2ggYWxsb3dzIGRyaXZlcnMg
dXNpbmcgdGhlIGFkX3NpZ21hX2RlbHRhIGxheWVyIHRvIHNldCB0aGUNCj4gaXJxIHRyaWdnZXIg
dHlwZSB0byB0aGUgb25lIHNwZWNpZmllZCBpbiB0aGUgY29ycmVzcG9uZGluZyBkYXRhLXNoZWV0
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IFRhY2hpY2kgPGFsZXhhbmRydS50YWNo
aWNpQGFuYWxvZy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vYWRjL2FkX3NpZ21hX2RlbHRh
LmMgICAgICAgfCAxMSArKysrKysrKysrLQ0KPiAgaW5jbHVkZS9saW51eC9paW8vYWRjL2FkX3Np
Z21hX2RlbHRhLmggfCAgNSArKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2Fk
X3NpZ21hX2RlbHRhLmMNCj4gYi9kcml2ZXJzL2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuYw0KPiBp
bmRleCA4YmE5MDQ4NmM3ODcuLmVmOGMzNTZiMTFlZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9p
aW8vYWRjL2FkX3NpZ21hX2RlbHRhLmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2FkX3NpZ21h
X2RlbHRhLmMNCj4gQEAgLTUwMCw3ICs1MDAsNyBAQCBzdGF0aWMgaW50IGFkX3NkX3Byb2JlX3Ry
aWdnZXIoc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldikNCj4gIA0KPiAgCXJldCA9IHJlcXVl
c3RfaXJxKHNpZ21hX2RlbHRhLT5zcGktPmlycSwNCj4gIAkJCSAgYWRfc2RfZGF0YV9yZHlfdHJp
Z19wb2xsLA0KPiAtCQkJICBJUlFGX1RSSUdHRVJfTE9XLA0KPiArCQkJICBzaWdtYV9kZWx0YS0+
aXJxX2ZsYWdzLA0KPiAgCQkJICBpbmRpb19kZXYtPm5hbWUsDQo+ICAJCQkgIHNpZ21hX2RlbHRh
KTsNCj4gIAlpZiAocmV0KQ0KPiBAQCAtNTg2LDggKzU4NiwxNyBAQCBFWFBPUlRfU1lNQk9MX0dQ
TChhZF9zZF9jbGVhbnVwX2J1ZmZlcl9hbmRfdHJpZ2dlcik7DQo+ICBpbnQgYWRfc2RfaW5pdChz
dHJ1Y3QgYWRfc2lnbWFfZGVsdGEgKnNpZ21hX2RlbHRhLCBzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5k
aW9fZGV2LA0KPiAgCXN0cnVjdCBzcGlfZGV2aWNlICpzcGksIGNvbnN0IHN0cnVjdCBhZF9zaWdt
YV9kZWx0YV9pbmZvICppbmZvKQ0KPiAgew0KPiArCXVuc2lnbmVkIGxvbmcgc2V0X3RyaWdnZXJf
ZmxhZ3M7DQo+ICsNCj4gIAlzaWdtYV9kZWx0YS0+c3BpID0gc3BpOw0KPiAgCXNpZ21hX2RlbHRh
LT5pbmZvID0gaW5mbzsNCj4gKwlzaWdtYV9kZWx0YS0+bnVtX3Nsb3RzID0gMTsNCj4gKwlzaWdt
YV9kZWx0YS0+YWN0aXZlX3Nsb3RzID0gMTsNCg0KVGhlIHNsb3RzIHBhdGNoIHNlZW1zIHRvIGhh
dmUgc2xpcHBlZCBzb21lIGNoZXJyeS1waWNrcyBhbmQgY29uZmxpY3RzLg0KDQo+ICsNCj4gKwlz
ZXRfdHJpZ2dlcl9mbGFncyA9IHNpZ21hX2RlbHRhLT5pcnFfZmxhZ3MgJiBJUlFGX1RSSUdHRVJf
TUFTSzsNCj4gKwlpZiAoc2V0X3RyaWdnZXJfZmxhZ3MgPT0gSVJRRl9UUklHR0VSX05PTkUpDQo+
ICsJCXNpZ21hX2RlbHRhLT5pcnFfZmxhZ3MgfD0gSVJRRl9UUklHR0VSX0xPVzsNCj4gKw0KPiAg
CWlpb19kZXZpY2Vfc2V0X2RydmRhdGEoaW5kaW9fZGV2LCBzaWdtYV9kZWx0YSk7DQo+ICANCj4g
IAlyZXR1cm4gMDsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaWlvL2FkYy9hZF9zaWdt
YV9kZWx0YS5oDQo+IGIvaW5jbHVkZS9saW51eC9paW8vYWRjL2FkX3NpZ21hX2RlbHRhLmgNCj4g
aW5kZXggOGE0ZTI1YTcwODBjLi4wZDNmYTFlMTZmNWUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUv
bGludXgvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvaWlv
L2FkYy9hZF9zaWdtYV9kZWx0YS5oDQo+IEBAIC01NSw2ICs1NSw4IEBAIHN0cnVjdCBhZF9zaWdt
YV9kZWx0YV9pbmZvIHsNCj4gICAqIHN0cnVjdCBhZF9zaWdtYV9kZWx0YSAtIFNpZ21hIERlbHRh
IGRldmljZSBzdHJ1Y3QNCj4gICAqIEBzcGk6IFRoZSBzcGkgZGV2aWNlIGFzc29jaWF0ZWQgd2l0
aCB0aGUgU2lnbWEgRGVsdGEgZGV2aWNlLg0KPiAgICogQHRyaWc6IFRoZSBJSU8gdHJpZ2dlciBh
c3NvY2lhdGVkIHdpdGggdGhlIFNpZ21hIERlbHRhIGRldmljZS4NCj4gKyAqIEBudW1fc2xvdHM6
IE51bWJlciBvZiBzZXF1ZW5jZXIgc2xvdHMNCj4gKyAqIEBpcnFfZmxhZ3M6IGZsYWdzIGZvciB0
aGUgaW50ZXJydXB0IHVzZWQgYnkgdGhlIHRyaWdnZXJlZCBidWZmZXINCj4gICAqDQo+ICAgKiBN
b3N0IG9mIHRoZSBmaWVsZHMgYXJlIHByaXZhdGUgdG8gdGhlIHNpZ21hIGRlbHRhIGxpYnJhcnkg
Y29kZSBhbmQNCj4gc2hvdWxkIG5vdA0KPiAgICogYmUgYWNjZXNzZWQgYnkgaW5kaXZpZHVhbCBk
cml2ZXJzLg0KPiBAQCAtNjMsNiArNjUsOSBAQCBzdHJ1Y3QgYWRfc2lnbWFfZGVsdGEgew0KPiAg
CXN0cnVjdCBzcGlfZGV2aWNlCSpzcGk7DQo+ICAJc3RydWN0IGlpb190cmlnZ2VyCSp0cmlnOw0K
PiAgDQo+ICsJdW5zaWduZWQgaW50CQludW1fc2xvdHM7DQo+ICsJdW5zaWduZWQgbG9uZwkJaXJx
X2ZsYWdzOw0KPiArDQo+ICAvKiBwcml2YXRlOiAqLw0KPiAgCXN0cnVjdCBjb21wbGV0aW9uCWNv
bXBsZXRpb247DQo+ICAJYm9vbAkJCWlycV9kaXM7DQo=
