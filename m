Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98D38108984
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2019 08:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfKYHwC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Nov 2019 02:52:02 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3430 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbfKYHwC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Nov 2019 02:52:02 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAP7m6Us002273;
        Mon, 25 Nov 2019 02:51:33 -0500
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2058.outbound.protection.outlook.com [104.47.49.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wf2j4kwvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Nov 2019 02:51:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxCuNA74ZxHoi9HsPDiE37MXmOhl2n/d9hREYL3/4etDzt4j8ybrcGEaHQiH9L1Go/cZiKfox6En08WYM7ntAIMJ3MxBlHEYI5fgvrzoSsue/99+R1DoxVxBNkgVjK6pxAvNuNslUylShjLrj3Bh2do82vO1mE0jphbqyVCEd5BiihM0ZIMR0XAlAhlpb+EfXYhmZb58pjlgORor8X19JaSNHRwPhdcDCpdCSEsOtmnHi0ACskwcHoQSLCESJLyTRHpBjxoTErZ6ZhztS0bYha95LVq5P+nz2/p/YVF8yln+fegjwhBd852k1+rjD8Xkrrb+zxXMf7cejSu9rx+u2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4pPE28Sh+UNgIhDQ4LJ382hrM/UsoSKF57uJcJVgQ0=;
 b=hjbkrJ5CrXk8e+4WnTNtNxYdlfl8nWJtu+NQdWj1QG2uqr9YQj09TM8nTJ+QKNSn8+eUiZNUxJ+sDOPq1imHExD/skMS2bAh4UOSN3T26Aml4OkOaPucXJrO9PkQRrCgl8BwAKG6fmkdK1ajU/EMQaBty0w6Asn7tFbiFMJnnEYQnoP5TaIJ47f2Pbe0QUfX0Q87VD57s2Z/a/WD7RZYCEVTlEwhV2qXvYKrU44RwQIx0Ldzmy8bhMLsGQv64Wcx7AYvnQ9DngjJLyvYlDVCW2/S5S/QjBgTWkdt/bwAGu4hHiV1TpQ86vYKF2wdd+/yowwrS88t1e0MdMcni7vZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4pPE28Sh+UNgIhDQ4LJ382hrM/UsoSKF57uJcJVgQ0=;
 b=0x0q49IH0FZglG4QDpVpeGH/vl88vLqathjZuR3dYbb97tXGQPeEJYv5vq+xSBImc0E+aYK654SYnL38CqbbJ+7OBIIWEZ1Ak03IDNPaU+2kTEbEvjMSXwuJuiV2V9hckkyLytL7LScbFYRi+pEPaXgyf/aya4fSUq/uUTyCNAM=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5223.namprd03.prod.outlook.com (20.180.15.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Mon, 25 Nov 2019 07:51:30 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 07:51:30 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>
CC:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v4] dt-bindings: iio: accel: add binding documentation for
 ADIS16240
Thread-Topic: [PATCH v4] dt-bindings: iio: accel: add binding documentation
 for ADIS16240
Thread-Index: AQHVob2/Uuv8Me0otU+pOQKTkzIOdqeYolyAgALkwgA=
Date:   Mon, 25 Nov 2019 07:51:30 +0000
Message-ID: <a55b9c576eded8c91a985aabbba89180561ab156.camel@analog.com>
References: <20191123051927.5016-1-rodrigorsdc@gmail.com>
         <20191123114119.7b0c3447@archlinux>
In-Reply-To: <20191123114119.7b0c3447@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df73dd0e-ad9a-45b9-5568-08d7717c48b0
x-ms-traffictypediagnostic: CH2PR03MB5223:
x-ms-exchange-purlcount: 3
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB52232C0B38CF350D75F3F327F94A0@CH2PR03MB5223.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(189003)(199004)(6506007)(76176011)(6486002)(7416002)(2906002)(102836004)(6246003)(99286004)(6116002)(3846002)(2501003)(446003)(478600001)(118296001)(4001150100001)(26005)(14444005)(256004)(5660300002)(25786009)(76116006)(8936002)(8676002)(6306002)(6512007)(110136005)(66066001)(71190400001)(71200400001)(11346002)(305945005)(54906003)(229853002)(186003)(66556008)(66476007)(66946007)(66446008)(64756008)(86362001)(4326008)(2616005)(6436002)(81156014)(81166006)(36756003)(316002)(7736002)(966005)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5223;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oqRBrpAtSmc7h0r6364zc0sEeYVgTvpWeNnqQxl8/bfRsAimyu+GwMtq6a8acdcDcw+gXJGEZZMtcZnDrt//wh92//teCKemHzNV6jEYEFKoSicowYS5MpqUwG7YKJvIsF5WGZeyJxpWUWr58hCwx2P+d1NVherqxILosUcjsIVf98Pr2Ijn0Zgcf1cIASI05F/FPWg4lQktgGOCLyWPG1WB9tPr9tycASbRGWZAkXMZ5q3EYphelU5OK/cwMlTqraFTJoGhB5JatAV6cErdFKsqH2IN1JYMxNGN72wlTVe6X1H0wAUUeEcmq21D10Mz337foU8txF9T/CwirVjv/qNfJ5Nc6l6UlGhRVL7KHTev7LbL/M29OH7barhfLMTFQDLlsInA1eqKDHuFv/QF/DX3V0hppXrITBzpLZ9Yf7YYxYl2ynOoUN/Ht2H/VHn2e8xdQO19AyXlY0QW8PnVEMPF46ISgtnamyUb27xuObI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29C23957103D4B43BD4A7FF115508C6F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df73dd0e-ad9a-45b9-5568-08d7717c48b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 07:51:30.3980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8Osusvv+VfdWT+w1ik3vvhajQkrI9F1WIEbBawWGq85MCvdOkzSUKBYensVSSLKh9Z/PkRwRbDqJfSlDyNKFVv52BPFQFnmlcc8ZV3Xvf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5223
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_01:2019-11-21,2019-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911250072
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDE5LTExLTIzIGF0IDExOjQxICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBTYXQsIDIzIE5vdiAyMDE5IDAyOjE5OjI3IC0wMzAwDQo+IFJvZHJpZ28gQ2FydmFs
aG8gPHJvZHJpZ29yc2RjQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFRoaXMgcGF0Y2ggYWRk
IGRldmljZSB0cmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBmb3IgQURJUzE2MjQwLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFJvZHJpZ28gUmliZWlybyBDYXJ2YWxobyA8cm9kcmlnb3JzZGNA
Z21haWwuY29tPg0KDQpNeSBiYWQgZm9yIHRoZSBsYXRlIHRpbWluZyBvbiB0aGlzLg0KSSdtIHNs
aWdodGx5IG1vcmUgZnJlc2ggb24gTW9uZGF5cy4NCkJ1dCBJIHdpbGwgZ2V0IG92ZXJsb2FkZWQg
d2l0aCB3b3JrIGluIGEgZmV3IGhvdXJzLCBzbyBJIG1heSBub3QgaGF2ZSB0aW1lDQpvdCByZXNw
b25kLg0KDQo+IE5vIHByb2JsZW0gd2l0aCB0aGlzIHBhdGNoLCBidXQgSSBkZWZpbml0ZWx5IHdh
bnQgdG8gc2VlIGFuIGFjY29tcGFueWluZw0KPiBvbmUgZW5mb3JjaW5nIHRoZSBTUEkgbW9kZSBp
biB0aGUgZHJpdmVyLg0KPiANCg0KU28sIHRoZW4gdGhlIGJpbmRpbmcgc2hvdWxkIHByb2JhYmx5
IGFsc28gZGVmaW5lIHNwaS1jcG9sICYgc3BpLWNwaGENCmFzIG1hbmRhdG9yeS4NCk1heWJlLCB0
aGUgZHJpdmVyIHdvdWxkIGRvIGEgY2hlY2sgYW5kIHByaW50IGEgd2FybmluZy4NCg0KSSdtIG5v
dGljaW5nIHRoYXQgdGhpcyBkZXZpY2UgdXNlcyBTUEkgbW9kZSAzLCBidXQgdGhpcyBEVCBiaW5k
aW5nIGRlZmF1bHRzDQp0byBTUEkgbW9kZSAwDQoNCj4gUmlnaHQgbm93IHRoZSBkcml2ZXIgZG9l
c24ndCBzZXQgaXQgYW5kIHNvIEknbSBmYWlybHkgc3VyZSBub3QgcHV0dGluZw0KPiBpdCBpbiB0
aGUgYmluZGluZyB3aWxsIGxlYXZlIHlvdSB3aXRoIGEgbm9uIHdvcmtpbmcgZGV2aWNlLg0KPiAN
Cj4gVGhlIHJpZ2h0IG9wdGlvbiBpZiBvbmx5IG9uZSBvcHRpb24gaXMgc3VwcG9ydGVkIGlzIGZv
ciB0aGUgZHJpdmVyDQo+IHRvIGNhbGwgc3BpX3NldHVwIHdpdGggdGhlIHJlbGV2YW50IG9wdGlv
bnMuDQo+IA0KDQpXaGF0IGlmIHRoZSBib2FyZCB1c2VzIHNvbWUgbGV2ZWwgaW52ZXJ0ZXJzIFti
ZWNhdXNlIG9mIHNvbWUgd2VpcmQgcmVhc29uXQ0KYW5kIHRoYXQgbWVzc2VzIHVwIHdpdGggdGhl
IFNQSSBtb2RlPw0KSXQncyBub3QgY29tbW9uLCBidXQgaXQgaXMgcG9zc2libGUuDQoNCj4gVGhh
bmtzLA0KPiANCj4gSm9uYXRoYW4NCj4gDQo+ID4gLS0tDQo+ID4gVjQ6DQo+ID4gICAgLSBSZW1v
dmUgc3BpLWNwaGEgYW5kIHNwaS1jcG9sIGluIGJpbmRpbmcgZXhhbXBsZSwgc2luY2UgdGhpcyBk
cml2ZXINCj4gPiBzdXBwb3J0cyBvbmx5IG9uZSB0aW1pbmcgbW9kZS4NCj4gPiAgLi4uL2JpbmRp
bmdzL2lpby9hY2NlbC9hZGksYWRpczE2MjQwLnlhbWwgICAgIHwgNDkgKysrKysrKysrKysrKysr
KysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2Fj
Y2VsL2FkaSxhZGlzMTYyNDAueWFtbA0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWNjZWwvYWRpLGFkaXMxNjI0MC55YW1s
DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FjY2VsL2FkaSxh
ZGlzMTYyNDAueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAw
MDAwMDAwLi44ZTkwMmY3YzQ5ZTYNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hY2NlbC9hZGksYWRpczE2MjQwLnlhbWwN
Cj4gPiBAQCAtMCwwICsxLDQ5IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjANCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9zY2hlbWFzL2lpby9hY2NlbC9hZGksYWRpczE2MjQwLnlhbWwjDQo+ID4gKyRzY2hl
bWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsN
Cj4gPiArdGl0bGU6IEFESVMxNjI0MCBQcm9ncmFtbWFibGUgSW1wYWN0IFNlbnNvciBhbmQgUmVj
b3JkZXIgZHJpdmVyDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIEFsZXhhbmRy
dSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+ID4gKw0KPiA+ICtk
ZXNjcmlwdGlvbjogfA0KPiA+ICsgIEFESVMxNjI0MCBQcm9ncmFtbWFibGUgSW1wYWN0IFNlbnNv
ciBhbmQgUmVjb3JkZXIgZHJpdmVyIHRoYXQNCj4gPiBzdXBwb3J0cw0KPiA+ICsgIFNQSSBpbnRl
cmZhY2UuDQo+ID4gKyAgICBodHRwczovL3d3dy5hbmFsb2cuY29tL2VuL3Byb2R1Y3RzL2FkaXMx
NjI0MC5odG1sDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+
ID4gKyAgICBlbnVtOg0KPiA+ICsgICAgICAtIGFkaSxhZGlzMTYyNDANCj4gPiArDQo+ID4gKyAg
cmVnOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgaW50ZXJydXB0czoNCj4g
PiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBh
dGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gaW50ZXJydXB0cw0KPiA+ICsNCj4gPiArZXhh
bXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9n
cGlvLmg+DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xs
ZXIvaXJxLmg+DQo+ID4gKyAgICBzcGkwIHsNCj4gPiArICAgICAgICAjYWRkcmVzcy1jZWxscyA9
IDwxPjsNCj4gPiArICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiArDQo+ID4gKyAgICAg
ICAgLyogRXhhbXBsZSBmb3IgYSBTUEkgZGV2aWNlIG5vZGUgKi8NCj4gPiArICAgICAgICBhY2Nl
bGVyb21ldGVyQDAgew0KPiA+ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gImFkaSxhZGlzMTYy
NDAiOw0KPiA+ICsgICAgICAgICAgICByZWcgPSA8MD47DQo+ID4gKyAgICAgICAgICAgIHNwaS1t
YXgtZnJlcXVlbmN5ID0gPDI1MDAwMDA+Ow0KPiA+ICsgICAgICAgICAgICBpbnRlcnJ1cHQtcGFy
ZW50ID0gPCZncGlvMD47DQo+ID4gKyAgICAgICAgICAgIGludGVycnVwdHMgPSA8MCBJUlFfVFlQ
RV9MRVZFTF9ISUdIPjsNCj4gPiArICAgICAgICB9Ow0KPiA+ICsgICAgfTsNCg==
