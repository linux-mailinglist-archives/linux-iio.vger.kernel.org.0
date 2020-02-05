Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8BE3152787
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2020 09:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgBEIYV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Feb 2020 03:24:21 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35784 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725875AbgBEIYV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2020 03:24:21 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0158M8TH016599;
        Wed, 5 Feb 2020 03:23:54 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xyhnkh2ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 03:23:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7Fd8vb2YbHIsIl0bPxg4zQLxnvOJQRO8N9FDr5yJw/SzqYXG+o97J7qWSKSuhcjghTJWwVqV3vBJVgiV3Atep0cr1bgnxH46qmEvB8j1ZO+CY2AhXWfPlKOL6KqrHEXpuhbovbzQ8CqHmC2es7NBlM2ikv9iQwgNm7s6yqzH3vdCd7lrmeCDunlv53ToxBhaMUJMXCRv04VftqRJrp/FgSpqACyxv2nYLrz2h9NXoWmpsjLlLfBRWM31FHLjHyfewg5UnuI19/49m8loQDpRYekDuY4Y1WtAhbOhYqQTa2pWV54ATE7PBnAfZfrJpkYEiKwXnRqRZhvuw8s3EbZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zl/49nzQFONtERwbqS3//pKrqu3jkpIMrb9X7i7bI/o=;
 b=QMREJyJKt6L6pYD6MqS7ug/yKsBnGvPz1YrBXs7QgUJac+qa0en1HSky5V4jb8V/WmJzc9pznuajiBskOvyyEE5r9M46wDU6fp+bwO+x2zUCm/cVDqzGi8fU2ZCM/VciwLNQBiKcCoyC8kKQHQ6KlnQtlS7q29cM33rKAn6bZeq1cJHSm+Od2CCeB36kSVD8wEW1Xf9NmigL7U+LVmCZkeWHfjZ+WU7FN/SpX3a1Goc24i/WMZ0asYu5M1L4bwYATkVwPNF+g7yTuUKuAoy3ApeDG+h0aFVcaOoYUTfqfD3okn9Jevpve8/sOGUYcByvMx5Au3ogm6/1vCdWtlOsEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zl/49nzQFONtERwbqS3//pKrqu3jkpIMrb9X7i7bI/o=;
 b=9qtwQyVqxzwdU/67Kh8DYf6dIHbLViDWLofwUm+zQJyFOCU5mUbBs9lPCnt9pVx2V0TuFCO9X6hSgbzde72KENG4cWPPZQlJtPFvLWJXfEupoR5UoMMLijwFPqwPSOCfX5ej0tYMyUoNJC9qYHZ7xNsNOGzyx/bOmte6yUNY5FM=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5303.namprd03.prod.outlook.com (20.180.14.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Wed, 5 Feb 2020 08:23:53 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2686.031; Wed, 5 Feb 2020
 08:23:53 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "patrick.vasseur@c-s.fr" <patrick.vasseur@c-s.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "hennerich@waws-prod-bn1-047.cloudapp.net" 
        <hennerich@waws-prod-bn1-047.cloudapp.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "djunho@gmail.com" <djunho@gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: ad7923: Add dt-bindings for AD7928
Thread-Topic: [PATCH] dt-bindings: iio: adc: ad7923: Add dt-bindings for
 AD7928
Thread-Index: AQHV27pETiAC0b8bxkCCrlA8zk5tC6gMRHUA
Date:   Wed, 5 Feb 2020 08:23:52 +0000
Message-ID: <b808cd095dd290ce3cf8ec6934f92edb2f94954e.camel@analog.com>
References: <20200205002121.30941-1-djunho@padtec.com.br>
In-Reply-To: <20200205002121.30941-1-djunho@padtec.com.br>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25a269b8-7c42-4a5f-f193-08d7aa14bc4a
x-ms-traffictypediagnostic: CH2PR03MB5303:
x-microsoft-antispam-prvs: <CH2PR03MB5303C2C9C931F433E353B8F8F9020@CH2PR03MB5303.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(39860400002)(376002)(189003)(199004)(6486002)(26005)(186003)(5660300002)(316002)(2616005)(110136005)(36756003)(6512007)(8936002)(66476007)(81166006)(2906002)(966005)(66446008)(66556008)(64756008)(76116006)(478600001)(81156014)(71200400001)(66946007)(6506007)(8676002)(7416002)(86362001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5303;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qMobQdz9xWWvvW3SG6O04kRU9L02/04w8KtGv+vbDOUTiwhDrplJmg3TuGMfC5tTWYWrLSUV13JSewkRQe/tCk6RhCEEXh1Y+/iWRl+swbBhvhlnfaWSDLV6IKSGU68LyzZzwdC2/8H0qD2A2xn4ryy7m4T/WLLIfC+fEoOB85DNqLF/CFQ1/yR5aLX/rLTlAFENFQ9FjAezR6YZIfjZ/HYfx3OzEhSohYR2RKJI91tG/7/AZCWtaGTOF4/3tFFGmdo81SAbuJttU/QfxW0HNQkX2EaJ5jJm+QruCqn3V4ETFJP2AdyV/mpbmhEt4TDqMWSCy/JB6N93aWA8OnBgJohc+T0xUL2n//UjACBiMmLUklGzvqQRT7v5PKtcGvk9ZPZeX/TgUnyHhRyPPVbng7Wyx5t7TQXifHt9bZ7Npcf8i4aaEz98Cg4oOoOVekJFqwirCzSOdQoo0M8LpDDFIRuRPr4l5l8Qj2x1Ol4Z63ey60aexHVMQa9bWIYC5SpRW9Oo0xN+hPE2pJNc8QpyUrrO62m6ugFl50Dq1G0Yh4Yrz49xrEIRHrfNqeD1yBlwW8bcUFZZrlvryhAjgAM0UQ==
x-ms-exchange-antispam-messagedata: /sXa9PsUFRRJrs2/2itm9uWUmSEuBJbTVEkNua6XykL7qNtgK2aLpuoWK3GHlJ+KCKWyC/YFb5t3znnaPJWOBRwUFvQI9B7LFsR6NNWPfOrFmN3D8Ms4SWLE8gKK4F7uwh1TxAhOqTz0BiJSEA0YeA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <54E124E65430FF45802BB883B34100C3@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a269b8-7c42-4a5f-f193-08d7aa14bc4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 08:23:52.9110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LYMe7gUGjY9gR7/rc4coj+t30Ex2CishYCjOiSOTaFeWMRQhvPJHb17ksaUagqF7QoBh/ge/i9DtLpsPGf2rYpkEo+dQxtdbqaMmZ7VGlyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5303
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_02:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002050068
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTA0IGF0IDIxOjIxIC0wMzAwLCBEYW5pZWwgSnVuaG8gd3JvdGU6DQo+
IEZyb206IERhbmllbCBKdW5obyA8ZGp1bmhvQGdtYWlsLmNvbT4NCj4gDQo+IEFkZCBkZXZpY2Ug
dHJlZSBiaW5kaW5ncyBkb2N1bWVudGF0aW9uIGZvciBBRDc5MjMgYWRjIGluIFlBTUwgZm9ybWF0
Lg0KPiANCj4gVGVzdGVkIHdpdGg6DQo+IG1ha2UgQVJDSD1hcm0gZHRfYmluZGluZ19jaGVjaw0K
PiBEVF9TQ0hFTUFfRklMRVM9RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9h
ZGMvYWRpLGFkNzkyMy55YW1sDQo+IG1ha2UgQVJDSD1hcm0gZHRic19jaGVjaw0KPiBEVF9TQ0hF
TUFfRklMRVM9RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvYWRpLGFk
NzkyMy55YW1sDQo+IA0KDQpIZXksDQoNClNvbWUgY29tbWVudHMgaW5saW5lLg0KDQoNCj4gU2ln
bmVkLW9mZi1ieTogRGFuaWVsIEp1bmhvIDxkanVuaG9AZ21haWwuY29tPg0KPiAtLS0NCj4gDQo+
IEhpLA0KPiANCj4gSSBnb3QgbWFpbnRhaW5lcnMgZnJvbSB0aGUgZHJpdmVyIGF1dGhvcnMgbGlz
dC4gTGV0IG1lIGtub3cgaWYgdGhpcyBpcw0KPiBmaW5lLg0KPiANCj4gVGhhbmtzLg0KPiANCj4g
IC4uLi9iaW5kaW5ncy9paW8vYWRjL2FkaSxhZDc5MjMueWFtbCAgICAgICAgICB8IDY1ICsrKysr
KysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2NSBpbnNlcnRpb25zKCspDQo+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9h
ZGMvYWRpLGFkNzkyMy55YW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvYWRpLGFkNzkyMy55YW1sDQo+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvYWRpLGFkNzkyMy55YW1sDQo+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uODA5NzQ0MWM5N2JlDQo+IC0tLSAv
ZGV2L251bGwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9h
ZGMvYWRpLGFkNzkyMy55YW1sDQo+IEBAIC0wLDAgKzEsNjUgQEANCj4gKyMgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KDQpMaWNlbnNlIGhlYWRlciBzaG91bGQgYmU6DQoj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkN
Cg0KDQo+ICslWUFNTCAxLjINCj4gKy0tLQ0KPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcv
c2NoZW1hcy9paW8vYWRjL2FkaSxhZDc5MjMueWFtbCMNCj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiArDQo+ICt0aXRsZTogQW5hbG9n
IERldmljZXMgQUQ3OTIzIGFuZCBzaW1pbGFycyB3aXRoIDQgYW5kIDggQ2hhbm5lbCBBRENzLg0K
PiArDQo+ICttYWludGFpbmVyczoNCj4gKyAgLSBNaWNoYWVsIEhlbm5lcmljaCA8aGVubmVyaWNo
QGJsYWNrZmluLnVjbGludXgub3JnPiINCg0KRm9yIE1pY2hhZWwsIGVtYWlsIG5vdyBpczogIG1p
Y2hhZWwuaGVubmVyaWNoQGFuYWxvZy5jb20gDQpUaGF0IGVtYWlsIG1heSBzdGlsbCB3b3JrLCBi
dXQgZm9yIG5ldyBzdHVmZiwgaXQgc2hvdWxkIGJlIHVwZGF0ZWQuDQoNCj4gKyAgLSBQYXRyaWNr
IFZhc3NldXIgPHBhdHJpY2sudmFzc2V1ckBjLXMuZnI+Ig0KPiArDQo+ICtkZXNjcmlwdGlvbjog
fA0KPiArICBBbmFsb2cgRGV2aWNlcyBBRDc5MDQsIEFENzkxNCwgQUQ3OTIzLCBBRDc5MjQgNCBD
aGFubmVsIEFEQ3MsIGFuZCBBRDc5MDgsDQo+ICsgICBBRDc5MTgsIEFENzkyOCA4IENoYW5uZWxz
IEFEQ3MuDQo+ICsNCj4gKyAgU3BlY2lmaWNhdGlvbnMgYWJvdXQgdGhlIHBhcnQgY2FuIGJlIGZv
dW5kIGF0Og0KPiArICAgIA0KPiBodHRwczovL3d3dy5hbmFsb2cuY29tL21lZGlhL2VuL3RlY2hu
aWNhbC1kb2N1bWVudGF0aW9uL2RhdGEtc2hlZXRzL0FENzkyMy5wZGYNCj4gKyAgICANCj4gaHR0
cHM6Ly93d3cuYW5hbG9nLmNvbS9tZWRpYS9lbi90ZWNobmljYWwtZG9jdW1lbnRhdGlvbi9kYXRh
LXNoZWV0cy9BRDc5MDRfNzkxNF83OTI0LnBkZg0KPiArICAgIA0KPiBodHRwczovL3d3dy5hbmFs
b2cuY29tL21lZGlhL2VuL3RlY2huaWNhbC1kb2N1bWVudGF0aW9uL2RhdGEtc2hlZXRzL0FENzkw
OF83OTE4Xzc5MjgucGRmDQo+ICsNCj4gK3Byb3BlcnRpZXM6DQo+ICsgIGNvbXBhdGlibGU6DQo+
ICsgICAgZW51bToNCj4gKyAgICAgIC0gYWRpLGFkNzkwNA0KPiArICAgICAgLSBhZGksYWQ3OTE0
DQo+ICsgICAgICAtIGFkaSxhZDc5MjMNCj4gKyAgICAgIC0gYWRpLGFkNzkyNA0KPiArICAgICAg
LSBhZGksYWQ3OTA4DQo+ICsgICAgICAtIGFkaSxhZDc5MTgNCj4gKyAgICAgIC0gYWRpLGFkNzky
OA0KPiArDQo+ICsgIHJlZzoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsgIHJlZmluLXN1
cHBseToNCj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiArICAgICAgVGhlIHJlZ3VsYXRvciBzdXBw
bHkgZm9yIEFEQyByZWZlcmVuY2Ugdm9sdGFnZS4NCj4gKw0KPiArICAnI2FkZHJlc3MtY2VsbHMn
Og0KPiArICAgIGNvbnN0OiAxDQo+ICsNCj4gKyAgJyNzaXplLWNlbGxzJzoNCj4gKyAgICBjb25z
dDogMA0KPiArDQo+ICtyZXF1aXJlZDoNCj4gKyAgLSBjb21wYXRpYmxlDQo+ICsgIC0gcmVnDQo+
ICsNCj4gK2V4YW1wbGVzOg0KPiArICAtIHwNCj4gKyAgICBzcGkgew0KPiArICAgICAgI2FkZHJl
c3MtY2VsbHMgPSA8MT47DQo+ICsgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gKw0KPiArICAg
ICAgYWQ3OTI4OiBhZGNAMCB7DQo+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiYWRpLGFkNzkyOCI7
DQo+ICsgICAgICAgIHJlZyA9IDwwPjsNCj4gKyAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8
MjUwMDAwMDA+Ow0KPiArICAgICAgICByZWZpbi1zdXBwbHkgPSA8JmFkY192cmVmPjsNCj4gKw0K
PiArICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKyAgICAgICAgI3NpemUtY2VsbHMg
PSA8MD47DQo+ICsgICAgICB9Ow0KPiArICAgIH07DQo=
