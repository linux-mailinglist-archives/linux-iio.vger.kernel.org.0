Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC94818EAF5
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgCVRkt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:40:49 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23568 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726710AbgCVRkt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 13:40:49 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02MHZngq018071;
        Sun, 22 Mar 2020 13:40:33 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2057.outbound.protection.outlook.com [104.47.44.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywcs5v4sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Mar 2020 13:40:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PI8NYU4hupWIEYqXE8ZfdiO0VeuOPaqJ00ixPtetPrD/hDibqL6kIKltl6+mv/VKCHrUjoGicy1mELl+MLUAFn0W6x5C/KlIHWRvosnkgU3boFEDV41G8wHjvIAI1TNnDq+FbiTgnVucBT53ywxttBfXCI9CNcs4LFGkklSifzb1GarDVqgrok7Ga6UDG7lLSCpyXFuDycKIsPnquShPVd9tH+C5M9WBYsiQZ3eBqrmgQkwCqTkBdTEqJqwGS7T5BKNT/SMRPAXpFchNnsMWb4H+KVpTI8BkdC55Np4ks/43knmYvO8nPErVPYcmf0zmasdBw+DtHuLiTe8gN9e0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgPQLusGfRVOicIlM9nsqj8y1W9nOqisAy+epzfGEwM=;
 b=J/gEW8jhciKmocNrrsFz3zEHcrvw5vhscQ6pdIqnN0Dp6SHAPHB0Z9db8L05ncVBNZUiDcOyIlKb5WONoJznWlisRZ0ZWohA7JqsJkVwkG35pNsxqBwNtZGVMrQ6EWyTaqs+1/3PVbewlzUBH+tEyki9ycGLApuGE0EuasZs0wXaX/oMsrOntrQZUcJftS9ENJ89bjF0l0j8xrjr84dY0+LUN5SQU4b0GvsIi/ySkqKaD4GOZRDTsxO59xC6pT0/iqJkSj6Q+43oCxkPIcx5eGaoDhCbGSnHIyh504n8432Gxk4DSKbBQhv0M0+0bfLSP7Fcz7FafsiiQwlXcwLLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgPQLusGfRVOicIlM9nsqj8y1W9nOqisAy+epzfGEwM=;
 b=2fgFPaViGHUb4D4S9CznWbgAQQylBUDwEri9vaeUuLwq36qBH4FsURcoSZXYWva6J0MckeLVA/Mkl7w83L9y5KjqMnkWgcjAorhiaQNUxsdml5KITGv29yS0AliU0WkeJaDSjIw4DGeGWfeZd+toFoVnZS/MkLrIxjJ4b6olnWc=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4073.namprd03.prod.outlook.com (2603:10b6:5:a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Sun, 22 Mar 2020 17:40:31 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Sun, 22 Mar 2020
 17:40:31 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "Costina, Adrian" <Adrian.Costina@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Grozav, Andrei" <Andrei.Grozav@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Nagy, Laszlo" <Laszlo.Nagy@analog.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Csomortani, Istvan" <Istvan.Csomortani@analog.com>
Subject: Re: [PATCH v11 5/8] iio: adc: adi-axi-adc: add support for AXI ADC IP
 core
Thread-Topic: [PATCH v11 5/8] iio: adc: adi-axi-adc: add support for AXI ADC
 IP core
Thread-Index: AQHV/15DYGjLW+byS0qvSggjrAf5zqhTk1UAgADIgICAABN7gIAAXHgAgAAKQICAAA4mAA==
Date:   Sun, 22 Mar 2020 17:40:30 +0000
Message-ID: <319e36a6e4553a54812c63d89df181aee165bd4b.camel@analog.com>
References: <20200321085315.11030-1-alexandru.ardelean@analog.com>
         <20200321085315.11030-6-alexandru.ardelean@analog.com>
         <CAHp75VecnornqckmG_WgN-V9A1VSQfRT85TxFzwHgaLw9dAHeA@mail.gmail.com>
         <979ef870a4f0935e41e95e7759847eba8bd0407c.camel@analog.com>
         <CAHp75Vdna2+txY=w87n+SWE3x3FYJLeMjYbYa6V-co3z0mYx_g@mail.gmail.com>
         <202003220901.880A6DF@keescook> <20200322165317.0b1f0674@archlinux>
In-Reply-To: <20200322165317.0b1f0674@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24942f0f-21ac-4b67-3701-08d7ce881e27
x-ms-traffictypediagnostic: DM6PR03MB4073:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB407308DB240C16B6D7DD84EFF9F30@DM6PR03MB4073.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0350D7A55D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(136003)(366004)(376002)(346002)(199004)(186003)(8936002)(36756003)(26005)(81156014)(81166006)(5660300002)(66446008)(66476007)(66556008)(64756008)(76116006)(478600001)(966005)(8676002)(66946007)(86362001)(91956017)(2906002)(71200400001)(107886003)(6486002)(316002)(53546011)(54906003)(2616005)(6506007)(6512007)(110136005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4073;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nL8i7Ot01M2m5EORLhrLvTKZy+3HiI2uHhfEgrW0PzeGWFWvlQSF3WaRrWmnYgFevyGIgbl2JXGiJCZyJA4nmcTiHe1Gl4H7dCxIcGTMfJR5Mgx6uhcr9i1Jx2sD0xtneHh8yrzUlljK3SVceoS0IyCtOXQoPwlAD6k9hpaVesjHkoHpFXiBpBjd9zkLY74VvssyGSXAKjJV55A10z8P0MLnW2XLYIxlj0kc8XNstBvz/ER7eGix2dWFLrgJX95PWFxNejaPcqhTIiXZ2xDoZoss8RLtzt5Nr3AjMvE9VUvzYpZZ01tDyWbYqPJ6YMPY4Ne4HKqehfLZ6m+5SzK4z7LuNLQeH4ytA9MvoJKI8wKI6PuFTwdhvqH9APQPhiGFtcHn4ov0SCevxpYhvfMKTqAa+2vbC8ZJGoUnmv+ZIp8nSfNolJZIZq5/A5aeT1ORhLZ2R/YuS0jLomBWbLaemzEdluzexoUlwPXpJEohEDtsyLDVNv2l/EtR4vALkTpr98h/qZ5FJzALKrOylVvjVw==
x-ms-exchange-antispam-messagedata: ndugFkWZQK3vkS6V/ZUYTuokAX53he/LTzEsIcdH28Uofwh3BH/LeP/5jz6dQfPPw7gcxy8WQnJyFQolIbApWLdRRI8uxkjWPjwElmktmMXKUJNvFEgTZ6zBV1MbVLyXJu9bMFfDVKQZel1Piw6i9Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B1B5A60A331B042A970A04F2CA4D12C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24942f0f-21ac-4b67-3701-08d7ce881e27
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2020 17:40:31.1326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9C7uy1C5RHbpOVk9axXD1WSM4Eqo3AlZ1aDrg+q63BpmEbfRNgoEjRXkEJJWUH0rzj49A79qwDAWYSoaeABa0ByQ6n31a+XgOvqmqqnh4kQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4073
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-22_06:2020-03-21,2020-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003220106
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTAzLTIyIGF0IDE2OjUzICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBTdW4sIDIyIE1hciAyMDIwIDA5OjE2OjM2IC0wNzAwDQo+IEtlZXMgQ29vayA8a2Vl
c2Nvb2tAY2hyb21pdW0ub3JnPiB3cm90ZToNCj4gDQo+ID4gT24gU3VuLCBNYXIgMjIsIDIwMjAg
YXQgMTI6NDU6MzlQTSArMDIwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+ID4gK0NjIEtl
ZXMgKHNlZSBiZWxvdyBhYm91dCBhbGxvY2F0aW9uIHNpemUgY2hlY2tzKQ0KPiA+ID4gDQo+ID4g
PiBPbiBTdW4sIE1hciAyMiwgMjAyMCBhdCAxMTozNiBBTSBBcmRlbGVhbiwgQWxleGFuZHJ1DQo+
ID4gPiA8YWxleGFuZHJ1LkFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOiAgDQo+ID4gPiA+IE9u
IFNhdCwgMjAyMC0wMy0yMSBhdCAyMzozOCArMDIwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOiAg
DQo+ID4gPiA+ID4gT24gU2F0LCBNYXIgMjEsIDIwMjAgYXQgMTA6NTUgQU0gQWxleGFuZHJ1IEFy
ZGVsZWFuDQo+ID4gPiA+ID4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPiB3cm90ZTog
IA0KPiA+ID4gDQo+ID4gPiAuLi4NCj4gPiA+ICAgDQo+ID4gPiA+ID4gPiArc3RhdGljIHN0cnVj
dCBhZGlfYXhpX2FkY19jb252ICphZGlfYXhpX2FkY19jb252X3JlZ2lzdGVyKHN0cnVjdA0KPiA+
ID4gPiA+ID4gZGV2aWNlDQo+ID4gPiA+ID4gPiAqZGV2LA0KPiA+ID4gPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludA0KPiA+
ID4gPiA+ID4gc2l6ZW9mX3ByaXYpDQo+ID4gPiA+ID4gPiArew0KPiA+ID4gPiA+ID4gKyAgICAg
ICBzdHJ1Y3QgYWRpX2F4aV9hZGNfY2xpZW50ICpjbDsNCj4gPiA+ID4gPiA+ICsgICAgICAgc2l6
ZV90IGFsbG9jX3NpemU7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArICAgICAgIGFsbG9j
X3NpemUgPSBzaXplb2Yoc3RydWN0IGFkaV9heGlfYWRjX2NsaWVudCk7DQo+ID4gPiA+ID4gPiAr
ICAgICAgIGlmIChzaXplb2ZfcHJpdikgew0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGFs
bG9jX3NpemUgPSBBTElHTihhbGxvY19zaXplLCBJSU9fQUxJR04pOw0KPiA+ID4gPiA+ID4gKyAg
ICAgICAgICAgICAgIGFsbG9jX3NpemUgKz0gc2l6ZW9mX3ByaXY7DQo+ID4gPiA+ID4gPiArICAg
ICAgIH0NCj4gPiA+ID4gPiA+ICsgICAgICAgYWxsb2Nfc2l6ZSArPSBJSU9fQUxJR04gLSAxOyAg
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSGF2ZSB5b3UgbG9va2VkIGF0IGxpbnV4L292ZXJmbG93
Lmg/ICANCj4gPiA+ID4gDQo+ID4gPiA+IGkgZGlkIG5vdzsNCj4gPiA+ID4gYW55IGhpbnRzIHdo
ZXJlIGkgc2hvdWxkIGxvb2sgY2xvc2VyPyAgDQo+ID4gPiANCj4gPiA+IEl0IHNlZW1zIGl0IGxh
Y2tzIG9mIHRoaXMga2luZCBvZiBhbGxvY2F0aW9uIHNpemUgY2hlY2tzLi4uIFBlcmhhcHMgYWRk
DQo+ID4gPiBvbmU/DQo+ID4gPiBLZWVzLCB3aGF0IGRvIHlvdSB0aGluaz8NCj4gPiA+ICAgDQo+
ID4gPiA+ID4gPiArICAgICAgIGNsID0ga3phbGxvYyhhbGxvY19zaXplLCBHRlBfS0VSTkVMKTsN
Cj4gPiA+ID4gPiA+ICsgICAgICAgaWYgKCFjbCkNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAg
ICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsgIA0KPiA+IA0KPiA+IE15IGhlYWQgaHVydHMgdHJ5
aW5nIHRvIHJlYWQgdGhpcyEgOykgT2theSwgc28gdGhlIGJhc2Ugc2l6ZSBpcw0KPiA+IHNpemVv
ZihzdHJ1Y3QgYWRpX2F4aV9hZGNfY2xpZW50KS4gQnV0IGlmIHNpemVvZl9wcml2IGlzIG5vbi16
ZXJvDQo+ID4gKHRoaXMgYXJnIHNob3VsZCBiZSBzaXplX3Qgbm90IGludCksIHRoZW4gd2UgbmVl
ZCB0byBtYWtlIHRoZSBzdHJ1Y3QNCj4gPiBzaXplIEFMSUdOZWQ/IEFuZCB0aGVuIHdoYXQgaXMg
dGhlICIrPSBJSU9fQUxJR04gLSAxIiBmb3I/DQo+IA0KPiBJJ20gYSBiaXQgZW1iYXJyYXNzZWQu
ICBJIGNhbid0IHJlbWVtYmVyIHdoYXQgdGhlICs9IElJT19BTElHTiAtIDENCj4gd2FzIGZvciBp
biB0aGUgZmlyc3QgcGxhY2UgYW5kIEkgY2FuJ3Qgd29yayBpdCBvdXQgbm93Lg0KPiANCj4gVGhl
IHB1cnBvc2Ugb2YgdGhlIGZ1biBoZXJlIHdhcyB0byBlbmQgdXAgd2l0aCBhIHN0cnVjdHVyZSB0
aGF0DQo+IHdhcyBlaXRoZXINCj4gYSkgc2l6ZW9mKHN0cnVjdCBpaW9fZGV2KSBsb25nLA0KPiBi
KSBzaXplb2Yoc3RydWN0IGlpb19kZXYpICsgcGFkZGluZyArIHNpemVvZl9wcml2IA0KPiB3aGVy
ZSB0aGUgcGFkZGluZyBlbnN1cmVkIHRoYXQgYW55IF9fY2FjaGVsaW5lX2FsaWduZWQgZWxlbWVu
dHMNCj4gaW4gdGhlIHByaXZhdGUgc3RydWN0dXJlIHdlcmUgY2FjaGVsaW5lIGFsaWduZWQgd2l0
aGluIHJlc3VsdGluZw0KPiBhbGxvY2F0aW9uLg0KPiANCj4gU28gd2h5IHRoZSBleHRyYSBJSU9f
QUxJR04gLSAxLi4uLg0KPiANCj4gVGhlIG9yaWdpbmFsIHBhdGNoIGRvZXNuJ3QgaGVscCBtdWNo
IGVpdGhlciBnaXZlbiBpdCdzIGdvdCBhIHF1ZXN0aW9uDQo+IGluIHRoZXJlIGZvciB3aHkgdGhp
cyBiaXQgaXMgbmVlZGVkLg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaWlv
LzEzMDI4OTAxNjAtODgyMy01LWdpdC1zZW5kLWVtYWlsLWppYzIzQGNhbS5hYy51ay8NCj4gDQo+
IEhvd2V2ZXIsIGl0IHJhbmcgYSBzbGlnaHQgYmVsbC4gIFNlZW1zIEkgbGlmdGVkIHRoZSBjb2Rl
IGZyb20gbmV0ZGV2Lg0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qv
c291cmNlL25ldC9jb3JlL2Rldi5jI0w5NzE4DQo+IA0KPiBJJ20gZmFpcmx5IHN1cmUgd2UgZG9u
J3QgbmVlZCB0aGF0IHBhZGRpbmcgaGVyZS4uICBXaGF0IGNhbiBJIHNheSwNCj4gSSB3YXMgeW91
bmcgYW5kIHN0dXBpZCA6KQ0KPiANCj4gSSBkaWQgYWRkIGEgcXVlc3Rpb24gbWFyayBzbyBjbGVh
cmx5IG1lYW50IHRvIGNvbWUgYmFjayBhbmQNCj4gdGFrZSBhbm90aGVyIGxvb2sgOykNCj4gDQo+
IE9uZSB2YWd1ZSB0aG91Z2h0IGlzIHRoYXQgaXQncyBhYm91dCBlbnN1cmluZyB3ZSBhcmUgYmln
IGVub3VnaCB0bw0KPiBlbnN1cmUgd2UgYXJlIGNhY2hlbGluZSBhbGlnbmVkLiAgVGhhdCdzIG9i
dmlvdXNseSBub3QgYSBwcm9ibGVtIHdpdGgNCj4gY3VycmVudCBzdHJ1Y3QgaWlvX2RldiB3aGlj
aCBpcyBmYXIgZnJvbSBzbWFsbCwNCj4gYnV0IGluIHRoZW9yeSBpdCBjb3VsZCBoYXZlIGJlZW4u
ICBBbHNvLCB0aGlua2luZyBhYm91dCBpdCB3ZSBvbmx5DQo+IG5lZWQgdGhlIHN0cnVjdCBpaW9f
ZGV2IHRvIGJlIGNhY2hlbGluZSBhbGlnbmVkIGlmIHdlIGhhdmUNCj4gYW4gaWlvX3ByaXYgc3Ry
dWN0dXJlLiAgSWYgd2UgaGF2ZSBvbmUgb2YgdGhvc2UgaXQgd2lsbCBkZWZpbml0ZWx5DQo+IGJl
IGJpZyBlbm91Z2ggYW55d2F5Lg0KPiANCj4gQXQgc29tZXBvaW50IEknZCBsaWtlIHRvIGxvb2sg
YXQgY2xlYW5pbmcgaXQgdXAgZm9yIGlpb19kZXZpY2VfYWxsb2MNCj4gYnV0IHdpdGggYSBsb3Qg
b2YgdGVzdGluZyBhcyB3aG8ga25vd3Mgd2hhdCBpcyByZWx5aW5nIG9uIHRoaXMgYmVoYXZpb3Vy
DQo+IG9yIGlmIEkndmUgbWlzc2VkIHNvbWV0aGluZy4gIENyYXNoZXMgYXJvdW5kIHRoaXMgYWxp
Z25tZW50IGFyZQ0KPiBpbmZyZXF1ZW50IGFuZCBuYXN0eSB0byB0cmFjZSBhdCB0aGUgYmVzdCBv
ZiB0aW1lcy4NCg0KSW4gdGhlIG1lYW50aW1lLCBhcmUgdGhlcmUgYW55IG9iamVjdGlvbnMgaWYg
SSBsZWF2ZSB0aGUgYWxsb2NhdGlvbiBhcy1pcyBmb3INCnRoaXMgZHJpdmVyIGFzIHdlbGw/DQpJ
J3ZlIHRlc3RlZCB0aGUgZHJpdmVyIGEgYml0IG1vcmUgd2l0aCB0aGlzIGZvcm0uDQoNCj4gDQo+
IEpvbmF0aGFuDQo+IA0KPiA+IEl0J3Mgbm90IGNsZWFyIHRvIG1lIHdoYXQgdGhlIGV4cGVjdCBh
bGlnbm1lbnQvcGFkZGluZyBpcyBoZXJlLg0KPiA+IA0KPiA+IEkgd291bGQgcHJvYmFibHkgY29u
c3RydWN0IHRoaXMgYXM6DQo+ID4gDQo+ID4gCXNpemVvZl9zZWxmID0gc2l6ZW9mKHN0cnVjdCBh
ZGlfYXhpX2FkY19jbGllbnQpOw0KPiA+IAlpZiAoc2l6ZW9mX3ByaXYpDQo+ID4gCQlzaXplb2Zf
c2VsZiA9IEFMSUdOKHNpemVvZl9zZWxmLCBJSU9fQUxJR04pOw0KPiA+IAlpZiAoY2hlY2tfYWRk
X292ZXJmbG93KHNpemVvZl9zZWxmLCBzaXplb2ZfcHJpdiwgJnNpemVvZl9hbGxvYykpDQo+ID4g
CQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gPiAJaWYgKGNoZWNrX2FkZF9vdmVyZmxvdyhz
aXplb2ZfYWxsb2MsIElJT19BTElHTiAtIDEsICZzaXplb2ZfYWxsb2MpKQ0KPiA+IAkJcmV0dXJu
IEVSUl9QVFIoLUVOT01FTSk7DQo+ID4gDQo+ID4gQnV0IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUg
IklJT19BTElHTiAtIDEiIHBhcnQsIHNvIEkgYXNzdW1lIHRoaXMgY291bGQNCj4gPiBiZSBzaG9y
dGVuZWQgd2l0aCBiZXR0ZXIgdXNlIG9mIEFMSUdOKCk/DQo+ID4gDQo+ID4gQWxzbywgdGhpcyBm
ZWVscyBsaWtlIGEgd2VpcmQgZHJpdmVyIGFsbG9jYXRpb24gb3ZlcmFsbDoNCj4gPiANCj4gPiAr
CXN0cnVjdCBhZGlfYXhpX2FkY19jb252ICoqcHRyLCAqY29udjsNCj4gPiArDQo+ID4gKwlwdHIg
PSBkZXZyZXNfYWxsb2MoZGV2bV9hZGlfYXhpX2FkY19jb252X3JlbGVhc2UsIHNpemVvZigqcHRy
KSwNCj4gPiArCQkJICAgR0ZQX0tFUk5FTCk7DQo+ID4gKwlpZiAoIXB0cikNCj4gPiArCQlyZXR1
cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gPiArDQo+ID4gKwljb252ID0gYWRpX2F4aV9hZGNfY29u
dl9yZWdpc3RlcihkZXYsIHNpemVvZl9wcml2KTsNCj4gPiANCj4gPiBkZXZyZXNfYWxsb2MoKSBh
bGxvY2F0ZXMgc3RvcmFnZSBmb3IgYSBfc2luZ2xlIHBvaW50ZXJfLiA6UCBUaGF0J3Mgbm90DQo+
ID4gdXNlZnVsIGZvciByZXNvdXJjZSB0cmFja2luZy4gV2h5IGlzIGRldnJlc19hbGxvYygpIGJl
aW5nIGNhbGxlZCBoZXJlDQo+ID4gYW5kIG5vdCBkb3duIGluIGFkaV9heGlfYWRjX2NvbnZfcmVn
aXN0ZXIoKSBhbmQganVzdCBwYXNzaW5nIHRoZSBwb2ludGVyDQo+ID4gYmFjayB1cD8NCj4gPiAN
Cg==
