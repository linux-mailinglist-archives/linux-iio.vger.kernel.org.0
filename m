Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B886217543F
	for <lists+linux-iio@lfdr.de>; Mon,  2 Mar 2020 08:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCBHFj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Mar 2020 02:05:39 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:48048 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgCBHFj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Mar 2020 02:05:39 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02271YgR000375;
        Mon, 2 Mar 2020 02:05:36 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0b-00128a01.pphosted.com with ESMTP id 2yfjkfnf53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Mar 2020 02:05:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tjf9fM9uuGNDaKZ0Ou7w7MlLcqsehD0l5HNSpqduscf+QDfnWevwmouxJz+FcbfkCsz+KRNky3gkiR0WbWvgjvUuJ/SIr8j6N+/DPmYRWIY3OKsojVAp9QkXZV3y+5AsiCIACUYxuge/wYP+LbrKcnf5wx53kDWn1OuD3Sk1Yc2LBfiafoJKtXcw8AfGjUGTIbvOVgGi2xQNnWWLRQ4hDQnn4f0lZz31PQZkdFUcKdwlrY90FCs/FbkM4yRm0vbGWvh3z4ktVvzylgcXQzEN0v7CNLnGxJBOGE/yMo9/JGfVcoIExS/GUUd6F00btHTuxJ9FerWbM1Hblj2R0ZogOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZYtL1KgYXWANr3f29c9srS1a/ycWSseJkStKR1mva8=;
 b=Wq6cHi3ZyRzyJt64hGIiq7okht7LsV31/w1P2NQw+KC25dwVXnIwYpFZdWxvk2aL42QulLpPjM60m83l5wpk4q7JV4cGzh82CmCL/H1BinOF/4XF01poTNoGDhkq20NlRvRVo9G0hDQE//Vs0sQeA+jo2eo6wkA5BtH/4hJnSoF82P8Up/odxVFQkg9mMnGTHaxjmKihLBwY9T9i2PxNjH92U0yhC19BEnzkLFYgdl9gD91iQa5IiQm6ro5/uajJxrLpMmox6pyA6aXB5i/pGsLrKBtG67+O6Hi+QOGf8el1zu1BYP4PKU/BYi0AdxTZPrFTSf5FqTLbwJrP75bwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZYtL1KgYXWANr3f29c9srS1a/ycWSseJkStKR1mva8=;
 b=nhyvNTIqlXtRxSoaCJPdYr1zzMmR9O9KXGng9FRpAkVpf27rBWyVrw5Ksy1s1vuGb+T2NSru29DqhCI9Eshm3XVNcMuOHKLtpC8rAsBY+WYXK6W1PmDoFUPdoaRo8MTcIi5MtdAU5Cmad7neTzH0W3q3HOjLxHYlubPUXkLktlw=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24)
 by CH2PR03MB5317.namprd03.prod.outlook.com (2603:10b6:610:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 07:05:32 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056%4]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 07:05:32 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "Tachici, Alexandru" <Alexandru.Tachici@analog.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: industrialio-core: Fix debugfs read
Thread-Topic: [PATCH v2] iio: industrialio-core: Fix debugfs read
Thread-Index: AQHV6K99ZPNnJQBmBUWd8O83CdyRFKg0NZcAgAC69AA=
Date:   Mon, 2 Mar 2020 07:05:32 +0000
Message-ID: <5c0b7ceca6ed35e46474de081d148e8c2fb9d071.camel@analog.com>
References: <20200221120655.20252-1-alexandru.tachici@analog.com>
         <20200301195622.0dfa31fc@archlinux>
In-Reply-To: <20200301195622.0dfa31fc@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c426eaee-ccc5-4127-f558-08d7be78193c
x-ms-traffictypediagnostic: CH2PR03MB5317:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB53175EF0594A88BD0B69A1D1F9E70@CH2PR03MB5317.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39850400004)(346002)(199004)(189003)(186003)(66946007)(2906002)(2616005)(76116006)(91956017)(6486002)(6506007)(36756003)(6512007)(316002)(4326008)(81166006)(8936002)(6636002)(86362001)(478600001)(81156014)(66556008)(66476007)(5660300002)(26005)(71200400001)(8676002)(54906003)(110136005)(64756008)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5317;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DK+uhNav5hDDNq2NPmhMUzqmvG+qIQ/fH2yC26Xg4ce4lwD+Xecpt0ffPd49z79LRsPwAPk1u2YTvE46UbonLE16r09gxRb8ruQlu53jJtaASKGDnhD4pTT6jlI/uhrhE808gLhmzynToQP6IaRhpYheNNwDd6sJ2h2KH70H7Wb7k9Vf66i8P0PxbMNANRHrSqu0PPaNKUIAbmSuI3R/sVAV2ACAvJVbkMacPPJbeOktVO8ro6GnS9j1GERfN4rSr4Gl1FHs0RLTkGJNLwsLm285eww65oMdDcMNZmEBW6SHuX8NUqfS2u1W10sy3zGeap7L6fKT1/8EIP9ZC2xsoI+XAnS3qVrhTlBtfKwHg+H9N0Ba2i83jRyjATkj/0zo1ojhABEVQEcTuFXPrgbG8Os6VH1TLur1QAmnSqx1F/p9Ld333TB6Ifa8rEbXM7qy
x-ms-exchange-antispam-messagedata: 2ULpDQKm8Y33BcnR8UpOMir9lOJ6mnUdTJj7Lm8UOpG+cqRceafkuduXlKArMzgD8qVVlLUxKc8LNEa++5rlZnsXZDMkjAWFmZPgF7dtWpSBX57Z6ytkP5BJ3Xeo7rdqFiRN+qh4oXqyCG5ObbUVSw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA6244662B61F747BDCF71495E293560@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c426eaee-ccc5-4127-f558-08d7be78193c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 07:05:32.4146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rLO5n51RY+6S+2g2WRzQhqOqPKomv+e+YVBrANbHjjXCWDVOdl81E3v3dI0jK/hgaOrVls+waHNmFHgcCTuRblJQydCoC+Y7nMxotl9igc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5317
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_01:2020-02-28,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020053
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTAzLTAxIGF0IDE5OjU2ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBGcmksIDIxIEZlYiAyMDIwIDE0OjA2OjU1ICswMjAw
DQo+IEFsZXhhbmRydSBUYWNoaWNpIDxhbGV4YW5kcnUudGFjaGljaUBhbmFsb2cuY29tPiB3cm90
ZToNCj4gDQo+ID4gQ3VycmVudGx5IGlpb19kZWJ1Z2ZzX3JlYWRfcmVnIGNhbGxzIGRlYnVnZnNf
cmVnX2FjY2Vzcw0KPiA+IGV2ZXJ5IHRpbWUgaXQgaXMgcmFuLiBSZWFkaW5nIHRoZSBzYW1lIGhh
cmR3YXJlIHJlZ2lzdGVyDQo+ID4gbXVsdGlwbGUgdGltZXMgZHVyaW5nIHRoZSBzYW1lIHJlYWRp
bmcgb2YgYSBkZWJ1Z2ZzIGZpbGUNCj4gPiBjYW4gY2F1c2UgdW5pbnRlbmRlZCBlZmZlY3RzLg0K
PiA+IA0KPiA+IEZvciBleGFtcGxlIGZvciBlYWNoOiBjYXQgaWlvOmRldmljZTAvZGlyZWN0X3Jl
Z19hY2Nlc3MNCj4gPiB0aGUgZmlsZV9vcGVyYXRpb25zLnJlYWQgZnVuY3Rpb24gd2lsbCBiZSBj
YWxsZWQgYXQgbGVhc3QNCj4gPiB0d2ljZS4gRmlyc3Qgd2lsbCByZXR1cm4gdGhlIGZ1bGwgbGVu
Z3RoIG9mIHRoZSBzdHJpbmcgaW4NCj4gPiBieXRlcyAgYW5kIHRoZSBzZWNvbmQgd2lsbCByZXR1
cm4gMC4NCj4gPiANCj4gPiBUaGlzIHBhdGNoIG1ha2VzIGlpb19kZWJ1Z2ZzX3JlYWRfcmVnIHRv
IGNhbGwgZGVidWdmc19yZWdfYWNjZXNzDQo+ID4gb25seSB3aGVuIHRoZSB1c2VyJ3MgYnVmZmVy
IHBvc2l0aW9uICgqcHBvcykgaXMgMC4gKG1lYW5pbmcNCj4gPiBpdCBpcyB0aGUgYmVnaW5uaW5n
IG9mIGEgbmV3IHJlYWRpbmcgb2YgdGhlIGRlYnVnZnMgZmlsZSkuDQo+ID4gDQo+ID4gRml4ZXM6
IGU1NTNmMTgyZDU1YiAoInN0YWdpbmc6IGlpbzogY29yZTogSW50cm9kdWNlIGRlYnVnZnMgc3Vw
cG9ydCwgYWRkDQo+ID4gc3VwcG9ydCBmb3IgZGlyZWN0IHJlZ2lzdGVyIGFjY2VzcyIpDQo+ID4g
U2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5h
bG9nLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgVGFjaGljaSA8YWxleGFuZHJ1
LnRhY2hpY2lAYW5hbG9nLmNvbT4NCj4gDQo+IEknbSBnb2luZyB0byB0YWtlIHRoaXMgb25lIHZp
YSB0aGUgc2xvdyBwYXRoIHRvIGdpdmUgaXQgYSBiaXQgb2YgdGltZQ0KPiB0byBzb2FrIGluIGxp
bnV4LW5leHQuICAgSSB0aGluayB3ZSBhcmUgZmluZSBmb3IgdW5leHBlY3RlZCBzaWRlIGVmZmVj
dHMNCj4gYnV0IGl0J3MgYmVlbiB0aGVyZSBmb3IgYSBsb25nIHRpbWUgc28gd2UgY2FuIHRha2Ug
dGhpcyBzbG93bHkuDQoNCk5vIGh1cnJ5IGZyb20gdXMuDQpUaGlzIG9uZSBoYXMgYmVlbiBzaG93
aW5nLXVwIHJhbmRvbWx5IHdoZW4gdHJ5aW5nIHRvIHVzZSB0aGUgZGVidWdmcyBpbnRlcmZhY2UN
CmZvciAod2VsbC4uLikgZGVidWdnaW5nLg0KTW9zdCBvZiB0aGUgdGltZXMgdGhlIGRvdWJsZS1y
ZWFkIFtvZiByZWdzXSBpcyBmaW5lOyBzbyB0aGlzIGlzc3VlIGNhbiBnbyB1bi0NCm5vdGljZWQu
DQpCdXQgaW4gY2FzZXMgbGlrZSByZWFkaW5nIGEgRklGTyBmb3IgZGVidWcgcHVycG9zZXMgW0kg
a25vdyB0aGlzIHNvdW5kcyBhIGJpdA0KbGlrZSBhbiBhYnVzZSwgYnV0IGl0IGlzIGJlaW5nIHJl
YWQgZnJvbSBhIHJlZ10sIHRoZSBkb3VibGUtcmVhZCBkcm9wcyBzb21lDQp2YWx1ZXMuDQpBbmQg
dGhhdCBtYWtlcyBzb21lIHN1cHBvcnQgbW9yZSBkaWZmaWN1bHQuDQoNCj4gDQo+IEFwcGxpZWQg
dG8gdGhlIHRvZ3JlZyBicmFuY2ggb2YgaWlvLmdpdCBhbmQgcHVzaGVkIG91dCBhcyB0ZXN0aW5n
IGZvcg0KPiB0aGUgYXV0b2J1aWxkZXJzIHRvIHBsYXkgd2l0aCBpdC4NCj4gDQo+IFRoYW5rcywN
Cj4gDQo+IEpvbmF0aGFuDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lpby9pbmR1c3RyaWFs
aW8tY29yZS5jIHwgMTUgKysrKysrKysrKystLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvaWlvL2lp
by5oICAgICAgICAgfCAgMiArKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2lu
ZHVzdHJpYWxpby1jb3JlLmMgYi9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tDQo+ID4gY29yZS5j
DQo+ID4gaW5kZXggNjVmZjBkMDY3MDE4Li5jNGQ1MTA0OTM0ZmMgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2lu
ZHVzdHJpYWxpby1jb3JlLmMNCj4gPiBAQCAtMzAxLDExICszMDEsMTQgQEAgc3RhdGljIHNzaXpl
X3QgaWlvX2RlYnVnZnNfcmVhZF9yZWcoc3RydWN0IGZpbGUgKmZpbGUsDQo+ID4gY2hhciBfX3Vz
ZXIgKnVzZXJidWYsDQo+ID4gIAkJCSAgICAgIHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQ0K
PiA+ICB7DQo+ID4gIAlzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2ID0gZmlsZS0+cHJpdmF0ZV9k
YXRhOw0KPiA+IC0JY2hhciBidWZbMjBdOw0KPiA+ICAJdW5zaWduZWQgdmFsID0gMDsNCj4gPiAt
CXNzaXplX3QgbGVuOw0KPiA+ICAJaW50IHJldDsNCj4gPiAgDQo+ID4gKwlpZiAoKnBwb3MgPiAw
KQ0KPiA+ICsJCXJldHVybiBzaW1wbGVfcmVhZF9mcm9tX2J1ZmZlcih1c2VyYnVmLCBjb3VudCwg
cHBvcywNCj4gPiArCQkJCQkgICAgICAgaW5kaW9fZGV2LT5yZWFkX2J1ZiwNCj4gPiArCQkJCQkg
ICAgICAgaW5kaW9fZGV2LT5yZWFkX2J1Zl9sZW4pOw0KPiA+ICsNCj4gPiAgCXJldCA9IGluZGlv
X2Rldi0+aW5mby0+ZGVidWdmc19yZWdfYWNjZXNzKGluZGlvX2RldiwNCj4gPiAgCQkJCQkJICBp
bmRpb19kZXYtPmNhY2hlZF9yZWdfYWRkciwNCj4gPiAgCQkJCQkJICAwLCAmdmFsKTsNCj4gPiBA
QCAtMzE0LDkgKzMxNywxMyBAQCBzdGF0aWMgc3NpemVfdCBpaW9fZGVidWdmc19yZWFkX3JlZyhz
dHJ1Y3QgZmlsZSAqZmlsZSwNCj4gPiBjaGFyIF9fdXNlciAqdXNlcmJ1ZiwNCj4gPiAgCQlyZXR1
cm4gcmV0Ow0KPiA+ICAJfQ0KPiA+ICANCj4gPiAtCWxlbiA9IHNucHJpbnRmKGJ1Ziwgc2l6ZW9m
KGJ1ZiksICIweCVYXG4iLCB2YWwpOw0KPiA+ICsJaW5kaW9fZGV2LT5yZWFkX2J1Zl9sZW4gPSBz
bnByaW50ZihpbmRpb19kZXYtPnJlYWRfYnVmLA0KPiA+ICsJCQkJCSAgIHNpemVvZihpbmRpb19k
ZXYtPnJlYWRfYnVmKSwNCj4gPiArCQkJCQkgICAiMHglWFxuIiwgdmFsKTsNCj4gPiAgDQo+ID4g
LQlyZXR1cm4gc2ltcGxlX3JlYWRfZnJvbV9idWZmZXIodXNlcmJ1ZiwgY291bnQsIHBwb3MsIGJ1
ZiwgbGVuKTsNCj4gPiArCXJldHVybiBzaW1wbGVfcmVhZF9mcm9tX2J1ZmZlcih1c2VyYnVmLCBj
b3VudCwgcHBvcywNCj4gPiArCQkJCSAgICAgICBpbmRpb19kZXYtPnJlYWRfYnVmLA0KPiA+ICsJ
CQkJICAgICAgIGluZGlvX2Rldi0+cmVhZF9idWZfbGVuKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAg
c3RhdGljIHNzaXplX3QgaWlvX2RlYnVnZnNfd3JpdGVfcmVnKHN0cnVjdCBmaWxlICpmaWxlLA0K
PiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lpby9paW8uaCBiL2luY2x1ZGUvbGludXgv
aWlvL2lpby5oDQo+ID4gaW5kZXggODYyY2UwMDE5ZWJhLi5lZWQ1OGVkMmYzNjggMTAwNjQ0DQo+
ID4gLS0tIGEvaW5jbHVkZS9saW51eC9paW8vaWlvLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4
L2lpby9paW8uaA0KPiA+IEBAIC01NjgsNiArNTY4LDggQEAgc3RydWN0IGlpb19kZXYgew0KPiA+
ICAjaWYgZGVmaW5lZChDT05GSUdfREVCVUdfRlMpDQo+ID4gIAlzdHJ1Y3QgZGVudHJ5CQkJKmRl
YnVnZnNfZGVudHJ5Ow0KPiA+ICAJdW5zaWduZWQJCQljYWNoZWRfcmVnX2FkZHI7DQo+ID4gKwlj
aGFyCQkJCXJlYWRfYnVmWzIwXTsNCj4gPiArCXVuc2lnbmVkIGludAkJCXJlYWRfYnVmX2xlbjsN
Cj4gPiAgI2VuZGlmDQo+ID4gIH07DQo+ID4gIA0K
