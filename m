Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC299108993
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2019 08:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfKYH4D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Nov 2019 02:56:03 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:63196 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbfKYH4D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Nov 2019 02:56:03 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAP7rDm8015773;
        Mon, 25 Nov 2019 02:55:41 -0500
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2059.outbound.protection.outlook.com [104.47.49.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wf005c71p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Nov 2019 02:55:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9Uj3zXgBWt4YXfbIGnsCBfngP0qMO8ty+f6r5z4BJAdSBm6dLN4AAAVodyz+sV17wXyBRa9OasCZOHwCBw/nZGV4mmfGtQYhOwJApoixFwkGtyppiR0LDcXuieA3QpI00IRhm48DH+MZ5hKMHMJFq5qzzt86Q/rF+BiUPJuw6hQO4nnO23hwIdrJRDFy4Jc7wJHAhf+VsjBJu8HbaPF3h4xJam4hiIODxRL1jasX299ETdeCDf+OBQBPlLANc9RYliqic7HXGYrLbfH/nMScEWeTTJzC/aEPe4PGloAFRIF0ovlU9f2Tnrl4RMOxKN/Znv/VmrbiI8TOF2NMfuzLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03VqBUYM148e+OC9VBKDWOGS8+mWyKNK10joLFMYves=;
 b=dnDpWwgR3xTZTo2xkYJ9klRHRse+Y8II//XTAb/71GGWcMqqnbrxt4ntURsMWWyFqtR4VRioaZS34Na9mV7vVS6CYQbaOMDcNQrf89lXbIn0tu/d1G7mscviUzzYNMPvvEXkZomBkOV7Oi2EyLkKpqyuCaVKh2ao1nf+Tzh5aTkInqN7fhn3/VdYEi8+TJbxJ0siQQpt4fWnTMTDYlpA6S5UICZ4hDNB6ae6EWnAkvdnpP19FZfqkgyjmwNYWiqHI5r08u/40Ozwka4WSp9bG9rtfT1whmkg/UsiNWj5FlPrluDHZ/Xfw9WQFRkvL/vcGK7jFUagrFBqlI7Vmaq6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03VqBUYM148e+OC9VBKDWOGS8+mWyKNK10joLFMYves=;
 b=6od0YxwpGDY0GRviAh1PsiUfpCHHSfFi2LBkHgyXSCMyq1dIHPSAD3OJ+bMhH/Uj55LoacMj6IaA6pZb1VxLQglQCuc66HaFVuS/HliyJCTWOR68ieXviklRdLkmO9ua2LmNGqTd/2C0Hx9XzztJxYGy2HLdRK77/K/NmmJKNmw=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5223.namprd03.prod.outlook.com (20.180.15.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Mon, 25 Nov 2019 07:55:39 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 07:55:39 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
CC:     "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] staging: iio: accel: adis16240: enforce SPI mode
 on probe function
Thread-Topic: [PATCH v5 1/2] staging: iio: accel: adis16240: enforce SPI mode
 on probe function
Thread-Index: AQHVola+Yj8hDk7DMESHXfIfRLi/aKebhxQA
Date:   Mon, 25 Nov 2019 07:55:39 +0000
Message-ID: <2e62b4fa3ee93909bfcdc4d9b60015e7c22d510c.camel@analog.com>
References: <20191123233510.4890-1-rodrigorsdc@gmail.com>
In-Reply-To: <20191123233510.4890-1-rodrigorsdc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f3d540a-7717-4189-3c4a-08d7717cdd08
x-ms-traffictypediagnostic: CH2PR03MB5223:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5223C83F161C99D598CAAE42F94A0@CH2PR03MB5223.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(189003)(199004)(6506007)(76176011)(6486002)(7416002)(2201001)(2906002)(102836004)(6246003)(99286004)(6116002)(3846002)(2501003)(446003)(478600001)(118296001)(4001150100001)(26005)(14444005)(256004)(5660300002)(25786009)(76116006)(8936002)(8676002)(6512007)(110136005)(66066001)(71190400001)(71200400001)(11346002)(305945005)(54906003)(229853002)(186003)(66556008)(66476007)(66946007)(66446008)(64756008)(86362001)(4326008)(2616005)(6436002)(81156014)(81166006)(36756003)(316002)(7736002)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5223;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: em7qJuYlJ9XZbBxQdQW+udb/K+/xCVpHzJgb4fiTO2Mr1fijRwhIyaamj85avmRcNF+N1DSdTYGHK0eIA0pHp2wvVM3u5vU6LU+xItYat4JOF4fAk1dQsnoU6WOC95Z/qpe1nRzb7JgQuTG+//s9vaotY33uPDHmB96kqFp6UXUUUiF60/8AA7rG+ea/tkG8+uMFAAzK0iiOUHiYfChagliJ0waQfw2gR4rWkchcEw8zDl2UVetibLl5QXlEE6EodD4U3H/SBDH4Vug4NRbXADqP0zJ5a27DQM6pLUfNBCKHAhZ5MRzxTdS0PewIEdiHmh5Lhh8/7hQaqjimMlQc2IRwvLKiGRdWw5KBlGSJIg+XVVc/hmW46s4oiZCu9W/PwN2KPh6b1NCkJK9CUR/mccFgtC+Dp+0bSzdIXIgrmpxGRvu/TbDF4tUQ2rXQwrx/
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE1147C6AAA6DB4E8397D1EEF48897B8@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3d540a-7717-4189-3c4a-08d7717cdd08
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 07:55:39.3605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24D2OQfrIcp1kGp1uLBGr4RHk0D0nm4N8ZSvXdhOXXGq6uf7HJTKNVo6+hc4JsQNffIR2ezlyKx3gya3NGu3KN8ny90WGRkr2q1S0CEybyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5223
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_01:2019-11-21,2019-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911250073
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDE5LTExLTIzIGF0IDIwOjM1IC0wMzAwLCBSb2RyaWdvIENhcnZhbGhvIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBBY2NvcmRpbmcgdG8gdGhlIGRhdGFzaGVldCwgdGhpcyBk
cml2ZXIgc3VwcG9ydHMgb25seSBTUEkgbW9kZSAzLA0KPiBzbyB3ZSBzaG91bGQgZW5mb3JjZSBp
dCBhbmQgY2FsbCBzcGlfc2V0dXAoKSBvbiBwcm9iZSBmdW5jdGlvbi4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFJvZHJpZ28gUmliZWlybyBDYXJ2YWxobyA8cm9kcmlnb3JzZGNAZ21haWwuY29tPg0K
PiAtLS0NCj4gVjU6DQo+ICAgLSBBZGQgdGhpcyBwYXRjaCB0byB0aGUgcGF0Y2hzZXQNCj4gDQo+
ICBkcml2ZXJzL3N0YWdpbmcvaWlvL2FjY2VsL2FkaXMxNjI0MC5jIHwgNyArKysrKysrDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zdGFnaW5nL2lpby9hY2NlbC9hZGlzMTYyNDAuYw0KPiBiL2RyaXZlcnMvc3RhZ2luZy9paW8v
YWNjZWwvYWRpczE2MjQwLmMNCj4gaW5kZXggODIwOTlkYjRiZjBjLi43N2I2YjgxNzY3YjkgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9paW8vYWNjZWwvYWRpczE2MjQwLmMNCj4gKysr
IGIvZHJpdmVycy9zdGFnaW5nL2lpby9hY2NlbC9hZGlzMTYyNDAuYw0KPiBAQCAtNDAwLDYgKzQw
MCwxMyBAQCBzdGF0aWMgaW50IGFkaXMxNjI0MF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3Bp
KQ0KPiAgCWluZGlvX2Rldi0+bnVtX2NoYW5uZWxzID0gQVJSQVlfU0laRShhZGlzMTYyNDBfY2hh
bm5lbHMpOw0KPiAgCWluZGlvX2Rldi0+bW9kZXMgPSBJTkRJT19ESVJFQ1RfTU9ERTsNCj4gIA0K
PiArCXNwaS0+bW9kZSA9IFNQSV9NT0RFXzM7DQoNCkEgZ2VuZXJpYyBxdWVzdGlvbiBmcm9tIG1l
IGhlcmUsIHNpbmNlIEkgYW0gbm90IHN1cmUuDQoNCldvdWxkIHRoaXMgbGltaXQgdGhlIGNvbmZp
Z3VyYXRpb25zIG9mIHRoaXMgY2hpcCBvbiB0aGUgYm9hcmQ/DQpJbiBjYXNlIHRoZXJlIGlzIHNv
bWUgbGV2ZWwtaW52ZXJ0ZXIgW2ZvciB2YXJpb3VzIHdlaXJkIHJlYXNvbnNdIG9uIHRoZQ0KYm9h
cmQsIHRoaXMgbWF5IG5vdCB3b3JrLCBiZWNhdXNlIHRoZSBTUEkgY29udHJvbGxlciB3b3VsZCBu
ZWVkIENQT0wgdG8gYmUNCjAuDQoNCk5vdCBzdXJlIGlmIHRoaXMgcXVlc3Rpb24gaXMgdmFsaWQs
IG9yIHdoZXRoZXIgd2UgbmVlZCB0byBjYXJlIGFib3V0IHN1Y2gNCmNvbmZpZ3VyYXRpb25zLg0K
DQpUaGFua3MNCkFsZXgNCg0KPiArCXJldCA9IHNwaV9zZXR1cChzcGkpOw0KPiArCWlmIChyZXQp
IHsNCj4gKwkJZGV2X2Vycigmc3BpLT5kZXYsICJzcGlfc2V0dXAgZmFpbGVkIVxuIik7DQo+ICsJ
CXJldHVybiByZXQ7DQo+ICsJfQ0KPiArDQo+ICAJcmV0ID0gYWRpc19pbml0KHN0LCBpbmRpb19k
ZXYsIHNwaSwgJmFkaXMxNjI0MF9kYXRhKTsNCj4gIAlpZiAocmV0KQ0KPiAgCQlyZXR1cm4gcmV0
Ow0K
