Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821141C3324
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 08:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgEDGqi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 May 2020 02:46:38 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:11360 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726660AbgEDGqi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2020 02:46:38 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0446gEmk007329;
        Mon, 4 May 2020 02:46:22 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0a-00128a01.pphosted.com with ESMTP id 30s5s5v29j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 02:46:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fyz5ZQL3FVubDqT5lliyq5CZ6XCDE0isddJvHxL/jsB/ccEx4ZLXeCx08oJrWZNpyvemlor2dZ9bWIHLgxaV40CiC90RPJfIVcgB9i7n8MJjSGttQkKLBnPYSEm90OqBY1c1BVhRRC25QSMG+iO+ucazQLZ00Q7auXDuTCnKSok2aX2xUiOXG1RHyrDusXCZ46giYDmt8yY9Jjku0O8V44Danl0Np87rl/gWWfst/nTJ8tRsw0ugprODHeZK4isGexjWSBStMlfZHX24TisuSKrTMgTJe/nSNgqrgz8KB32tQwwOy48EbMr6YJ6Sg3xp5AwwXynWGEHU01lXoatPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgNOC6ZmcLLPtDcUa5LIgOikONVAxXYierwe3jNgNgk=;
 b=GO75qXQnBMqg8K+13KkbXsjXZZOKgFX5lbZXbnnORCyKZ3arc7ZyMDFNzEvSl01zD1HWCQcl0kBLCoECoSUkRXPeMdRPeymIEDk/ruJb9pp2HHRy0eY3grnvIppXprbwN+/Cz+POHycebiiAMY8ZfftqcEEtFQhmsZs3YKfhKYJ4AsiwCiZ7Uewqt+24Tt8g/JmYvj6UkEZXe6s+9hrP5mojE474JBOhWXaOj4aJizPup5xhVhvpbAXYTyK+fali2wtZXNPfswBPjnC6dOUOTxY67bCe8aAjifGYff8AIROgjsco3lkD73Otep3la1mBmJKMX14fFl60214mTcsxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgNOC6ZmcLLPtDcUa5LIgOikONVAxXYierwe3jNgNgk=;
 b=ktgDgRA6ZvBWW00/gH0UnGneNBMIZtuHra9lZJVY9OvTDq/orMy2jBmocaimOeixvZtQgyva0iHdHIE1YHKOMTP/aDmbJDPhYdZTHm8/WURXGIARr8TqQadDLpWhhHy8jAmt62+6fTIu0fIHxbFDgPaIO6xjxF7Q+FK+gxJIsh8=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3673.namprd03.prod.outlook.com (2603:10b6:5:ab::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Mon, 4 May
 2020 06:46:20 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::40df:9aa4:c85a:a020]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::40df:9aa4:c85a:a020%4]) with mapi id 15.20.2958.030; Mon, 4 May 2020
 06:46:20 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v6 3/6] iio: core: register chardev only if needed
Thread-Topic: [PATCH v6 3/6] iio: core: register chardev only if needed
Thread-Index: AQHWHJVGY+If25gzlEmT4GuRthdvGKiWiOIAgAD9YYA=
Date:   Mon, 4 May 2020 06:46:19 +0000
Message-ID: <d3cca2a9100faae5a17f20afa0280a055daed448.camel@analog.com>
References: <20200427131100.50845-1-alexandru.ardelean@analog.com>
         <20200427131100.50845-4-alexandru.ardelean@analog.com>
         <20200503163926.6f840406@archlinux>
In-Reply-To: <20200503163926.6f840406@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17c96416-896b-4f07-faba-08d7eff6da69
x-ms-traffictypediagnostic: DM6PR03MB3673:
x-microsoft-antispam-prvs: <DM6PR03MB36739B9FA5C1995528CD7DB2F9A60@DM6PR03MB3673.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jkgyQF8qA6ObxFZZYYgFU8tbcbjPEJohDOF6chDJkHNqvg5LNCrX7mBgnR1fkxMUMqak5GYjR1Wz7LO6VQvVrKdtJcnJC9Qr1PTq9zRA2nD3n9XYKnYxfO+94BBW2sjn2xd8rnlhtJEPSgcC1AHbNz9HIcapdY7iI1GMAE3bUYW3pdl2Sz6sxqy3HR5OB/VB0m7NLg6L1wW3iW9O3jq8BD3m/jRao5t6av/Xt4QOJMHz6t/XnFq9cD4vmtGvpMpH8+5afzm7VEcuR9TTtTHwtO+ci+WFGUMRrm4FEjQDxdcIOAipwZD6XfnDgjg10HNpTeoH0pLIF0u9hVodinsqN0Nj2GK0aqgDfhn3dALAIERs1BgTHQf6BUeRBjeumfF8T6FSS9C0nNCdUjSxRRAcdsccOuL0ykPY9jnTytnbRRcAkxrU02l5r0ahSqlaq0Fe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(346002)(376002)(39850400004)(64756008)(66556008)(66476007)(66946007)(66446008)(26005)(76116006)(91956017)(8936002)(71200400001)(54906003)(8676002)(316002)(36756003)(478600001)(86362001)(5660300002)(6916009)(2616005)(4326008)(186003)(6506007)(6512007)(6486002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: EpsxTD886BCJcAEa2tJWgt2P6pwAS+gyejvX57RcyV5qnFbpP3aCL778h8RmKuCXTLzDAcLZ/B5m0kk2wtSToW2qD8RJiqBJnYLVxWQLCjh7MHPUHqVHwppjKXNWc8RsBpmAN48EKlNSrnjDB0yCNT9bWpWFkf5KKnIXGUD/U16ksTSaaoURyPoG+4Y6flm1KLQJ2A4pATAVfob6JPw+Jv3yg+wamwREpz3rcmrtFeUq31292kDyLu+TpoudcJy8QQrOgNK6aUDAUiIY7C4mj6A7m6535o1o10TMsJEUn/5fS2ey+UBgX5YttKrYKnEbdte1cApc3h4g4LH3klKRdL1/ic4Z2ShZq8eLU1baVMmnnUVrMWkgEthGwY2iIKyYvu4H3awGTl34MAEP6cuurKtowBzRz2i2cFbmXJ6uqQG/SjHxS6oVpaL5ux4W+lodQ0w6jVxGf2Ypjzlfaxnqj2C0MNST6/eenN6joFZHEDyJAr5sjyKS/3F/04u+gyEx0+6ncocJ5TAop/fejYcMxYNjNVmjIEYNFAHUsQAAvPgBAQGdOoKH3ksy7plg8lY4PGE6Mcc2/mkMfgYeQo30P76PDr6aJZptlvLkus4rI1cBX2VjTLfTVnikxMI7IqFFUd0/54gpFju5EIVd6FfNttY/JrLAT1qpkcltn9Iq/KlPkOqgASnzKVQDRYY9UYDOH5tE8t/jbIu2dARmV4iXf8bhwKRQbCLNiYY3Rzxvhv8VlZ+MzY0GepAbLr9m9+TUM0qoYrTvdJ0bYsjFKtInvPlOjS0ULKe+NtwisWgLmt0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B7485E1ED1E364A9311D99AEB733832@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c96416-896b-4f07-faba-08d7eff6da69
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 06:46:19.9687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: auroGaW2Ckt7XZkDWr4PCGilq/VrqZSBR32DmZmvxQfzd8FT3azn1f5rOt8UFNEf/p+KAXbMiv5j5FjmrA4IrdtIRcrf8nXSVt8EGqjykhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3673
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_03:2020-05-01,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040056
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA1LTAzIGF0IDE2OjM5ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBNb24sIDI3IEFwciAyMDIwIDE2OjEwOjU3ICswMzAw
DQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiBUaGUgZmluYWwgaW50ZW50IGlzIHRvIGxvY2FsaXplIGFsbCBidWZmZXIg
b3BzIGludG8gdGhlDQo+ID4gaW5kdXN0cmlhbGlvLWJ1ZmZlci5jIGZpbGUsIHRvIGJlIGFibGUg
dG8gYWRkIHN1cHBvcnQgZm9yIG11bHRpcGxlIGJ1ZmZlcnMNCj4gPiBwZXIgSUlPIGRldmljZS4N
Cj4gPiANCj4gPiBXZSBvbmx5IG5lZWQgYSBjaGFyZGV2IGlmIHdlIG5lZWQgdG8gc3VwcG9ydCBi
dWZmZXJzIGFuZC9vciBldmVudHMuDQo+ID4gDQo+ID4gV2l0aCB0aGlzIGNoYW5nZSwgYSBjaGFy
ZGV2IHdpbGwgYmUgY3JlYXRlZCBvbmx5IGlmIGFuIElJTyBidWZmZXIgaXMNCj4gPiBhdHRhY2hl
ZCBPUiBhbiBldmVudF9pbnRlcmZhY2UgaXMgY29uZmlndXJlZC4NCj4gPiANCj4gPiBPdGhlcndp
c2UsIG5vIGNoYXJkZXYgd2lsbCBiZSBjcmVhdGVkLCBhbmQgdGhlIElJTyBkZXZpY2Ugd2lsbCBn
ZXQNCj4gPiByZWdpc3RlcmVkIHdpdGggdGhlICdkZXZpY2VfYWRkKCknIGNhbGwuDQo+ID4gDQo+
ID4gUXVpdGUgYSBsb3Qgb2YgSUlPIGRldmljZXMgZG9uJ3QgcmVhbGx5IG5lZWQgYSBjaGFyZGV2
LCBzbyB0aGlzIGlzIGEgbWlub3INCj4gPiBpbXByb3ZlbWVudCB0byB0aGUgSUlPIGNvcmUsIGFz
IHRoZSBJSU8gZGV2aWNlIHdpbGwgdGFrZSB1cCAoc2xpZ2h0bHkpDQo+ID4gZmV3ZXIgcmVzb3Vy
Y2VzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFu
ZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaWlvL2luZHVz
dHJpYWxpby1jb3JlLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5jIGIvZHJpdmVycy9paW8v
aW5kdXN0cmlhbGlvLQ0KPiA+IGNvcmUuYw0KPiA+IGluZGV4IDMyYzQ4OTEzOWNkMi4uNTFlMjc5
YzYwNzkzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5jDQo+ID4gQEAgLTE2ODIs
NiArMTY4MiwxNSBAQCBzdGF0aWMgaW50IGlpb19jaGVja191bmlxdWVfc2Nhbl9pbmRleChzdHJ1
Y3QgaWlvX2Rldg0KPiA+ICppbmRpb19kZXYpDQo+ID4gIA0KPiA+ICBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGlpb19idWZmZXJfc2V0dXBfb3BzIG5vb3BfcmluZ19zZXR1cF9vcHM7DQo+ID4gIA0KPiA+
ICtzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBpaW9fZXZlbnRfZmlsZW9wcyA9
IHsNCj4gPiArCS5vd25lciA9IFRISVNfTU9EVUxFLA0KPiA+ICsJLmxsc2VlayA9IG5vb3BfbGxz
ZWVrLA0KPiA+ICsJLnVubG9ja2VkX2lvY3RsID0gaWlvX2V2ZW50X2lvY3RsX3dyYXBwZXIsDQo+
IA0KPiBVbmZvcnR1bmF0ZWx5IHRoaXMgZG9lc24ndCBleGlzdCB1bnRpbCB0aGUgbmV4dCBwYXRj
aC4uLg0KDQpjcmFwOw0KaSBjb3BpZWQgdGhpcyBmcm9tIHRoZSB3cm9uZyBwbGFjZSB3aGVuIGkg
cmUtb3JkZXJlZCB0aGlzLCBhbmQgZm9yZ290IHRvIHJ1biBhDQpidWlsZCBvbiBlYWNoIHBhdGNo
c2V0DQoNCndpbGwgZml4DQoNCj4gDQo+ID4gKwkuY29tcGF0X2lvY3RsID0gY29tcGF0X3B0cl9p
b2N0bCwNCj4gPiArCS5vcGVuID0gaWlvX2NocmRldl9vcGVuLA0KPiA+ICsJLnJlbGVhc2UgPSBp
aW9fY2hyZGV2X3JlbGVhc2UsDQo+ID4gK307DQo+ID4gKw0KPiA+ICBpbnQgX19paW9fZGV2aWNl
X3JlZ2lzdGVyKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsIHN0cnVjdCBtb2R1bGUNCj4gPiAq
dGhpc19tb2QpDQo+ID4gIHsNCj4gPiAgCWludCByZXQ7DQo+ID4gQEAgLTE3MzIsMTEgKzE3NDEs
MTggQEAgaW50IF9faWlvX2RldmljZV9yZWdpc3RlcihzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2
LA0KPiA+IHN0cnVjdCBtb2R1bGUgKnRoaXNfbW9kKQ0KPiA+ICAJCWluZGlvX2Rldi0+c2V0dXBf
b3BzID09IE5VTEwpDQo+ID4gIAkJaW5kaW9fZGV2LT5zZXR1cF9vcHMgPSAmbm9vcF9yaW5nX3Nl
dHVwX29wczsNCj4gPiAgDQo+ID4gLQljZGV2X2luaXQoJmluZGlvX2Rldi0+Y2hyZGV2LCAmaWlv
X2J1ZmZlcl9maWxlb3BzKTsNCj4gPiArCWlmIChpbmRpb19kZXYtPmJ1ZmZlcikNCj4gPiArCQlj
ZGV2X2luaXQoJmluZGlvX2Rldi0+Y2hyZGV2LCAmaWlvX2J1ZmZlcl9maWxlb3BzKTsNCj4gPiAr
CWVsc2UgaWYgKGluZGlvX2Rldi0+ZXZlbnRfaW50ZXJmYWNlKQ0KPiA+ICsJCWNkZXZfaW5pdCgm
aW5kaW9fZGV2LT5jaHJkZXYsICZpaW9fZXZlbnRfZmlsZW9wcyk7DQo+ID4gIA0KPiA+ICAJaW5k
aW9fZGV2LT5jaHJkZXYub3duZXIgPSB0aGlzX21vZDsNCj4gPiAgDQo+ID4gLQlyZXQgPSBjZGV2
X2RldmljZV9hZGQoJmluZGlvX2Rldi0+Y2hyZGV2LCAmaW5kaW9fZGV2LT5kZXYpOw0KPiA+ICsJ
aWYgKGluZGlvX2Rldi0+YnVmZmVyIHx8IGluZGlvX2Rldi0+ZXZlbnRfaW50ZXJmYWNlKQ0KPiA+
ICsJCXJldCA9IGNkZXZfZGV2aWNlX2FkZCgmaW5kaW9fZGV2LT5jaHJkZXYsICZpbmRpb19kZXYt
PmRldik7DQo+ID4gKwllbHNlDQo+ID4gKwkJcmV0ID0gZGV2aWNlX2FkZCgmaW5kaW9fZGV2LT5k
ZXYpOw0KPiA+ICsNCj4gPiAgCWlmIChyZXQgPCAwKQ0KPiA+ICAJCWdvdG8gZXJyb3JfdW5yZWdf
ZXZlbnRzZXQ7DQo+ID4gIA0KPiA+IEBAIC0xNzYwLDcgKzE3NzYsMTAgQEAgRVhQT1JUX1NZTUJP
TChfX2lpb19kZXZpY2VfcmVnaXN0ZXIpOw0KPiA+ICAgKiovDQo+ID4gIHZvaWQgaWlvX2Rldmlj
ZV91bnJlZ2lzdGVyKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ID4gIHsNCj4gPiAtCWNk
ZXZfZGV2aWNlX2RlbCgmaW5kaW9fZGV2LT5jaHJkZXYsICZpbmRpb19kZXYtPmRldik7DQo+ID4g
KwlpZiAoaW5kaW9fZGV2LT5idWZmZXIgfHwgaW5kaW9fZGV2LT5ldmVudF9pbnRlcmZhY2UpDQo+
ID4gKwkJY2Rldl9kZXZpY2VfZGVsKCZpbmRpb19kZXYtPmNocmRldiwgJmluZGlvX2Rldi0+ZGV2
KTsNCj4gPiArCWVsc2UNCj4gPiArCQlkZXZpY2VfZGVsKCZpbmRpb19kZXYtPmRldik7DQo+ID4g
IA0KPiA+ICAJbXV0ZXhfbG9jaygmaW5kaW9fZGV2LT5pbmZvX2V4aXN0X2xvY2spOw0KPiA+ICAN
Cg==
