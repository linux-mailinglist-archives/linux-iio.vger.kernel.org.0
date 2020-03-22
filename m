Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B6F18EA0D
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 17:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgCVQMP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 12:12:15 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:14050 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbgCVQMP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 12:12:15 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02MGBVn3008962;
        Sun, 22 Mar 2020 12:12:00 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2051.outbound.protection.outlook.com [104.47.46.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ywcp9kh1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Mar 2020 12:12:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gq/557zTuLzd30fycNqs8DxeAsO7t+GOJ1hXWu2dlPXp8MMA+gG+L3d8w0ecPefWD3xU4Nm6Jez/Tan7En+5d7raNBJWdYgQQwuVF+iGrx6VkPdKsVmk/SIIwprs+rNKo7kzgMqodw0E4rbatQzkpo5801Ao9TcJCOlRODlzlque3XToQ1bwDyFroxxg8mMSp7wpDNiflCI1fH8+0HpQH8altNopOh4GDy3x5hEx/anUucwpyPUInbKk4knL8AHkiYWfdKj4tbz19Ih3OtuygD09oJkppR3rr+F3/iy76UM9DdESd8qLfSfPmqmbHW25yWsg0Tcdaxrble6SLlDHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68I4iiHNasGUe3cT0XQS/LTSacfEF/YIPuc+FeEehng=;
 b=Rc7WGrkZP9UpuAEowHT3n0iHN8iNQ4baf0BRxqcJE+wYsItTRe79aSLH4E0WosOjZE7Zz9YiuB6OKMGwYcy6iF7naOklmEMtc6ngvBWdUJFhbde2JDrr0pfwIc9z5m9wflYR+5e6TIuXSrfQ8bbag1cdIJ1htCIf+fJZiS0rxESysBGmoarbx+8wI/Uhkfev35TfXT1eZKn/wDa4TNRwWYnQ8n2dC+rfubnhKsU58vlYUntKApwuCFC4qINs+eKhhTtbi9bgSxoA4CE5FRjWtBIYArqNn+meaItU2F8aT7SzRCh/m27jBFpqy4bRRsU3cQdfwRQ/KgYX0JapV/A2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68I4iiHNasGUe3cT0XQS/LTSacfEF/YIPuc+FeEehng=;
 b=fdAvDpSmNRC5yEv0fQuVzaUigyqAfzJbVy1lfp7fSqllDG7/RKKwIXQaGq691H1sHRfHVZlwmbn6N3CTuR7Vk3BKvvyc/N1tsq160yp+VI8GEnSZilNPpSH92k+0BLwRSAWHWJDXAHgDrVz4jHPn7CjdE3dagJbpDC8W3/Lm/Fc=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3771.namprd03.prod.outlook.com (2603:10b6:5:4e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Sun, 22 Mar
 2020 16:11:58 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Sun, 22 Mar 2020
 16:11:58 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Grozav, Andrei" <Andrei.Grozav@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Csomortani, Istvan" <Istvan.Csomortani@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Nagy, Laszlo" <Laszlo.Nagy@analog.com>,
        "Costina, Adrian" <Adrian.Costina@analog.com>
Subject: Re: [PATCH v11 5/8] iio: adc: adi-axi-adc: add support for AXI ADC IP
 core
Thread-Topic: [PATCH v11 5/8] iio: adc: adi-axi-adc: add support for AXI ADC
 IP core
Thread-Index: AQHV/15DYGjLW+byS0qvSggjrAf5zqhTk1UAgADIgICAABN7gIAAWyoA
Date:   Sun, 22 Mar 2020 16:11:58 +0000
Message-ID: <e5f542b253d0a3f5ef9db2ab21f0e25aef0feebf.camel@analog.com>
References: <20200321085315.11030-1-alexandru.ardelean@analog.com>
         <20200321085315.11030-6-alexandru.ardelean@analog.com>
         <CAHp75VecnornqckmG_WgN-V9A1VSQfRT85TxFzwHgaLw9dAHeA@mail.gmail.com>
         <979ef870a4f0935e41e95e7759847eba8bd0407c.camel@analog.com>
         <CAHp75Vdna2+txY=w87n+SWE3x3FYJLeMjYbYa6V-co3z0mYx_g@mail.gmail.com>
In-Reply-To: <CAHp75Vdna2+txY=w87n+SWE3x3FYJLeMjYbYa6V-co3z0mYx_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2d10d05-d9f9-47e3-cc80-08d7ce7bbf89
x-ms-traffictypediagnostic: DM6PR03MB3771:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB37718E2C57E37E374E3BA2D4F9F30@DM6PR03MB3771.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0350D7A55D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39850400004)(136003)(396003)(199004)(478600001)(6486002)(4326008)(316002)(81156014)(110136005)(107886003)(54906003)(64756008)(66556008)(8936002)(2906002)(66946007)(81166006)(66476007)(91956017)(76116006)(66446008)(8676002)(86362001)(186003)(966005)(71200400001)(53546011)(5660300002)(6506007)(26005)(36756003)(6512007)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3771;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eVHdcZqhWo4O6dgwZGVgWU668NjLfXOT0UvyRLmgk3L6a4Y6CKTAcNxE09NWSwjaz7m9tyc+XJoxiNsGBPyPtYHwkXfydAdjj55U49RLTQTf1hvFD+qNp5BXYr1eks8n/sFVbQrRACO958Qo7vwYOHzsQbUVbVVE2jAsbxcptPnkgMTMaCHpBnZ12IB5szJfnjWFgRHWNRcDED3icHQwdrZrOPNqiafWh6O0ZnW/lXE44S5QFav6KqZx+q/usIqrUNtEXWg748EH4SHossmBH5iH2lyerHR8LV1wGP1BtEDIiCLukY3WgimdoUu/ZbSELM6Y5BBeL8YxvhMajf+oGhlaMX2dSGIIrKoDbJk76u1WkoqIL6U5g47He0q+5bEhDIAj1ivFTXVDbPXzAXof1vJ1YjqNy/BTtl41s8EtCzMeBV2su53ko3wAWjkP/Y4s+E9JaJEpzNoxNhH07axrRlxxXGzLy+ccpHYahLYwV7T58mXG6607yq4N0Gv4iZvtmGGjg0CgPE9g3uj2eWdPNg==
x-ms-exchange-antispam-messagedata: 6cEdjazFD7/BJYM36neWncG3M3R1JvX/8EFRwoXyFmce4atAq+MqpbIf1i0anlsr79tVy2rCBPkyYpOxiRIpAhRYuIUKTAGjsxeq3vsm/6zXEHoenTGsZn+7kVHum1NOHROfH34osjSRgVaYZmEzcg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <840A204ECEC2244DB4861CC75AC0F69B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d10d05-d9f9-47e3-cc80-08d7ce7bbf89
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2020 16:11:58.4133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bj8ndk+4x8Nyi3afXLj1eU1FlVBPDGABcKo+KhHlZ/XIrrvRGZSGWZWJM5NsX0AkIz+8c4v+XGP9id/ExqkQhzGkqkB6v7jtH/YOja6ax8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3771
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-22_05:2020-03-21,2020-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003220098
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTAzLTIyIGF0IDEyOjQ1ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+ICtDYyBLZWVzIChzZWUgYmVsb3cgYWJvdXQgYWxsb2NhdGlvbiBzaXplIGNoZWNrcykNCj4g
DQo+IE9uIFN1biwgTWFyIDIyLCAyMDIwIGF0IDExOjM2IEFNIEFyZGVsZWFuLCBBbGV4YW5kcnUN
Cj4gPGFsZXhhbmRydS5BcmRlbGVhbkBhbmFsb2cuY29tPiB3cm90ZToNCj4gPiBPbiBTYXQsIDIw
MjAtMDMtMjEgYXQgMjM6MzggKzAyMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gPiA+IE9u
IFNhdCwgTWFyIDIxLCAyMDIwIGF0IDEwOjU1IEFNIEFsZXhhbmRydSBBcmRlbGVhbg0KPiA+ID4g
PGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPiB3cm90ZToNCj4gDQo+IC4uLg0KPiANCj4g
PiA+ID4gTGluazogaHR0cHM6Ly93aWtpLmFuYWxvZy5jb20vcmVzb3VyY2VzL2ZwZ2EvZG9jcy9h
eGlfYWRjX2lwDQo+ID4gDQo+ID4gaSBjYW4gc2VuZCBhIHYxMiBmb3IgdGhpcyBpbiBhIGZldyBk
YXlzOw0KPiA+IA0KPiA+ID4gSXMgaXQgdGFnIG9yIHNpbXBsZSBsaW5rPyBJIHdvdWxkIHN1Z2dl
c3Qgbm90IHRvIHVzZSBMaW5rOiBpZiBpdCdzIG5vdCBhDQo+ID4gPiB0YWcuDQo+ID4gDQo+ID4g
c2ltcGxlIGxpbmsNCj4gPiBhbnkgc3VnZ2VzdGlvbnMvYWx0ZXJuYXRpdmVzPw0KPiA+IGkgd2Fz
bid0IGF3YXJlIG9mIGNvbnZlbnRpb25zIGFib3V0IHRoaXM7DQo+IA0KPiBVc2UgbGlrZSBbMV0g
Li4uDQo+IC4uLg0KPiANCj4gWzFdOiBodHRwczovLy4uLg0KPiANCj4gT3IgbWF5YmUgaW50cm9k
dWNlIGlzIGFzIGEgdGFnIERvY0xpbms6LCBmb3IgZXhhbXBsZT8NCj4gT3IgRGF0YXNoZWV0OiA/
DQo+IA0KPiAuLi4NCj4gDQo+ID4gPiA+ICtzdGF0aWMgc3RydWN0IGFkaV9heGlfYWRjX2NsaWVu
dCAqY29udl90b19jbGllbnQoc3RydWN0DQo+ID4gPiA+IGFkaV9heGlfYWRjX2NvbnYNCj4gPiA+
ID4gKmNvbnYpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsgICAgICAgaWYgKCFjb252KQ0KPiA+ID4g
PiArICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+ID4gPiANCj4gPiA+IFRoaXMgaXMgc28g
dW51c3VhbC4gV2h5IGRvIHlvdSBuZWVkIGl0Pw0KPiA+IA0KPiA+IHNlZSBbMV0NCj4gPiANCj4g
PiA+ID4gKyAgICAgICByZXR1cm4gY29udGFpbmVyX29mKGNvbnYsIHN0cnVjdCBhZGlfYXhpX2Fk
Y19jbGllbnQsIGNvbnYpOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICt2b2lkICph
ZGlfYXhpX2FkY19jb252X3ByaXYoc3RydWN0IGFkaV9heGlfYWRjX2NvbnYgKmNvbnYpDQo+ID4g
PiA+ICt7DQo+ID4gPiA+ICsgICAgICAgc3RydWN0IGFkaV9heGlfYWRjX2NsaWVudCAqY2wgPSBj
b252X3RvX2NsaWVudChjb252KTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGlmICghY2wp
DQo+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gPiA+IA0KPiA+ID4gU28g
YWJvdXQgdGhpcy4NCj4gPiANCj4gPiBbMV0NCj4gPiBiZWNhdXNlICdhZGlfYXhpX2FkY19jb252
X3ByaXYoKScgKGFuZCBpbXBsaWNpdGx5IGNvbnZfdG9fY2xpZW50KCkpIGdldHMNCj4gPiBjYWxs
ZWQNCj4gPiBmcm9tIG90aGVyIGRyaXZlcnM7IHdlIGNhbid0IGV4cGVjdCB0byBiZSBzdXJlIHRo
YXQgY29udiAmIGNsIGFyZW4ndCBOVUxMOw0KPiANCj4gSW4gYm90aCBjYXNlcyBpdCdzIHBvaW50
ZXIgYXJpdGhtZXRpYywgcmlnaHQ/IEV2ZW4gbG9vayBhdCB0aGUgZXhhbXBsZQ0KPiBvZiBuZXRk
ZXYgeW91IGdhdmUgYmVsb3csIHRoZXkgaGF2ZW4ndCBkb25lIHRoZXNlIChyZWR1bmRhbnQpIGNo
ZWNrcy4NCj4gVGhlIG91dGNvbWUgdGhhdCBjcmFzaGVzIGlmIGFueSB3aWxsIGJlIG1vcmUgZGlz
dGluY3QuDQo+IA0KPiA+ID4gPiArICAgICAgIHJldHVybiAoY2hhciAqKWNsICsgQUxJR04oc2l6
ZW9mKHN0cnVjdCBhZGlfYXhpX2FkY19jbGllbnQpLA0KPiA+ID4gPiBJSU9fQUxJR04pOw0KPiA+
ID4gDQo+ID4gPiBUaGlzIGFsbCBsb29rcyBhIGJpdCBjb25mdXNpbmcuIElzIGl0IGludmVudGlv
biBvZiBvZmZzZXRvZigpID8NCj4gPiANCj4gPiB1bW07IHRiaCwgaXQncyBtb3JlIG9mIGEgY29w
eS9jbG9uZSBvZiBpaW9fcHJpdigpDQo+ID4gDQo+ID4gaXQncyBub3QgdW4tY29tbW9uIHRob3Vn
aDsNCj4gPiBzZWUgW2FuZCB0aGlzIG9uZSBoYXMgbW9yZSBleHBvc3VyZV06DQo+ID4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiBz
dGF0aWMgaW5saW5lIHZvaWQgKm5ldGRldl9wcml2KGNvbnN0IHN0cnVjdCBuZXRfZGV2aWNlICpk
ZXYpDQo+ID4gew0KPiA+ICAgICAgICAgcmV0dXJuIChjaGFyICopZGV2ICsgQUxJR04oc2l6ZW9m
KHN0cnVjdCBuZXRfZGV2aWNlKSwgTkVUREVWX0FMSUdOKTsNCj4gPiB9DQo+ID4gLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IEdv
b2QgcG9pbnQuDQo+IA0KPiA+ID4gPiArfQ0KPiANCj4gLi4uDQo+IA0KPiA+ID4gPiArc3RhdGlj
IHN0cnVjdCBhZGlfYXhpX2FkY19jb252ICphZGlfYXhpX2FkY19jb252X3JlZ2lzdGVyKHN0cnVj
dCBkZXZpY2UNCj4gPiA+ID4gKmRldiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludA0KPiA+ID4gPiBzaXplb2ZfcHJp
dikNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgYWRpX2F4aV9hZGNfY2xpZW50
ICpjbDsNCj4gPiA+ID4gKyAgICAgICBzaXplX3QgYWxsb2Nfc2l6ZTsNCj4gPiA+ID4gKw0KPiA+
ID4gPiArICAgICAgIGFsbG9jX3NpemUgPSBzaXplb2Yoc3RydWN0IGFkaV9heGlfYWRjX2NsaWVu
dCk7DQo+ID4gPiA+ICsgICAgICAgaWYgKHNpemVvZl9wcml2KSB7DQo+ID4gPiA+ICsgICAgICAg
ICAgICAgICBhbGxvY19zaXplID0gQUxJR04oYWxsb2Nfc2l6ZSwgSUlPX0FMSUdOKTsNCj4gPiA+
ID4gKyAgICAgICAgICAgICAgIGFsbG9jX3NpemUgKz0gc2l6ZW9mX3ByaXY7DQo+ID4gPiA+ICsg
ICAgICAgfQ0KPiA+ID4gPiArICAgICAgIGFsbG9jX3NpemUgKz0gSUlPX0FMSUdOIC0gMTsNCj4g
PiA+IA0KPiA+ID4gSGF2ZSB5b3UgbG9va2VkIGF0IGxpbnV4L292ZXJmbG93Lmg/DQo+ID4gDQo+
ID4gaSBkaWQgbm93Ow0KPiA+IGFueSBoaW50cyB3aGVyZSBpIHNob3VsZCBsb29rIGNsb3Nlcj8N
Cj4gDQo+IEl0IHNlZW1zIGl0IGxhY2tzIG9mIHRoaXMga2luZCBvZiBhbGxvY2F0aW9uIHNpemUg
Y2hlY2tzLi4uIFBlcmhhcHMgYWRkIG9uZT8NCj4gS2Vlcywgd2hhdCBkbyB5b3UgdGhpbms/DQoN
CmkgYm9ycm93ZWQgdGhpcyBhbGxvY2F0aW9uIGxvZ2ljIGZyb20gSUlPIGNvcmUgW2lpb19kZXZp
Y2VfYWxsb2MoKV07DQoNCmkgbWF5IGJlIHN0dXBpZCwgYnV0IGkgc3RpbGwgZG9uJ3QgdW5kZXJz
dGFuZCBob3cgdG8gdXNlIG92ZXJmbG93Lmggb3Igd2hhdCB0bw0KZ2V0IGZyb20gaXQ7DQp0aGUg
Y2hlY2tzIGluIHRoZXJlIHNlZW0gdG8gYmUgYSBiaXQgdG9vIG11Y2ggZm9yIHdoYXQncyBuZWVk
ZWQgaGVyZTsNCm9yIG1heWJlIHRoZXJlIGlzIHNvbWV0aGluZyBlbHNlIGluIHNvbWUgbmV3ZXIg
bGludXgtdHJlZT8NCm9yIG1heWJlIGFuIGV4YW1wbGUgb2YgaG93IGl0J3MgdXNlZD8NCg0KPiAN
Cj4gPiA+ID4gKyAgICAgICBjbCA9IGt6YWxsb2MoYWxsb2Nfc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+
ID4gPiA+ICsgICAgICAgaWYgKCFjbCkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBF
UlJfUFRSKC1FTk9NRU0pOw0KPiANCj4gLi4uDQo+IA0KPiA+ID4gPiArc3RhdGljIHZvaWQgYWRp
X2F4aV9hZGNfY29udl91bnJlZ2lzdGVyKHN0cnVjdCBhZGlfYXhpX2FkY19jb252ICpjb252KQ0K
PiA+ID4gPiArew0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBhZGlfYXhpX2FkY19jbGllbnQgKmNs
ID0gY29udl90b19jbGllbnQoY29udik7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBpZiAo
IWNsKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ID4gDQo+ID4gPiBXaGVu
IGlzIHRoaXMgcG9zc2libGU/DQo+ID4gDQo+ID4gZ29vZCBwb2ludDsgaXQgaXNuJ3Q7DQo+ID4g
aXQncyBhIGxlZnQtb3ZlciBmcm9tIHdoZW4gYWRpX2F4aV9hZGNfY29udl91bnJlZ2lzdGVyKCkg
d2FzIGV4cG9ydGVkDQo+ID4gc3RpbGwsIGkgd291bGRuJ3QgbWluZCBsZWF2aW5nIGl0IFtmb3Ig
cGFyYW5vaWFdLCBpZiB0aGVyZSBpc24ndCBhIHN0cm9uZw0KPiA+IG9waW5pb24gdG8gcmVtb3Zl
IGl0Ow0KPiANCj4gSSB0aGluayBpdCBtYWtlcyBjb2RlIGRpcnR5ICh0b28gbXVjaCBwcm90ZWN0
aXZlIHByb2dyYW1taW5nKS4gV2UgaGF2ZQ0KPiBhIGxvdCBwbGFjZXMgd2hlcmUgd2UgY2FuIHNo
b290IG91ciBmZWV0LCBidXQgYXQgbGVhc3Qgbm90IGhpZGluZyB0aGUNCj4gaXNzdWUgaXMgYSBi
ZW5lZml0IGluIG15IG9waW5pb24uDQo+IA0KPiAuLi4NCj4gDQo+IA0KPiANCj4gPiA+ID4gK3N0
YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICphZGlfYXhpX2FkY19hdHRyaWJ1dGVzW10gPSB7DQo+ID4g
PiA+ICsgICAgICAgQURJX0FYSV9BVFRSKFNDQUxFX0FWQUlMLCBpbl92b2x0YWdlX3NjYWxlX2F2
YWlsYWJsZSksDQo+ID4gPiA+ICsgICAgICAgTlVMTCwNCj4gPiA+IA0KPiA+ID4gVGVybWluYXRv
cnMgZ29vZCB3L28gY29tbWEuDQo+ID4gDQo+ID4gaSBkb24ndCBmZWVsIHN0cm9uZ2x5IHByby9h
Z2FpbnN0DQo+ID4gc3VyZQ0KPiANCj4gVGhlcmUgaXMgYSByYXRpb25hbGUgYmVoaW5kIHRoaXMu
IElmIHRoZXJlIGlzIGEgd2VpcmQgY2FzZSBvZiBhZGRpbmcNCj4gZW50cnkgYmVoaW5kIHRoZSB0
ZXJtaW5hdG9yLCB5b3Ugd2lsbCBzZWUgaXQgaW1tZWRpYXRlbHkgYXQgY29tcGlsZQ0KPiB0aW1l
IChjb25zaWRlciBhdXRvbWF0aWMgcmViYXNlKS4NCj4gDQo+ID4gPiA+ICt9Ow0KPiA+ID4gDQo+
ID4gPiAuLi4NCj4gPiA+IA0KPiA+ID4gPiArLyogTWF0Y2ggdGFibGUgZm9yIG9mX3BsYXRmb3Jt
IGJpbmRpbmcgKi8NCj4gPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGFk
aV9heGlfYWRjX29mX21hdGNoW10gPSB7DQo+ID4gPiA+ICsgICAgICAgeyAuY29tcGF0aWJsZSA9
ICJhZGksYXhpLWFkYy0xMC4wLmEiLCAuZGF0YSA9DQo+ID4gPiA+ICZhZGlfYXhpX2FkY18xMF8w
X2FfaW5mbyB9LA0KPiA+ID4gPiArICAgICAgIHsgLyogZW5kIG9mIGxpc3QgKi8gfSwNCj4gPiA+
IA0KPiA+ID4gRGl0dG8uDQo+IA0KPiBEaXR0by4NCj4gDQo+ID4gPiA+ICt9Ow0KPiANCj4gLi4u
DQo+IA0KPiA+ID4gPiArICAgICAgIGlmICghZGV2LT5vZl9ub2RlKSB7DQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICBkZXZfZXJyKGRldiwgIkRUIG5vZGUgaXMgbnVsbFxuIik7DQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PREVWKTsNCj4gPiA+ID4gKyAgICAgICB9
DQo+IA0KPiBJIGd1ZXNzIHRoaXMgY2hlY2sgaXMgcmVkdW5kYW50IHNpbmNlIGZvbGxvd2luZyBP
RiBjYWxscyB3aWxsIGZhaWwgYW55d2F5Lg0KPiANCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAg
IGlkID0gb2ZfbWF0Y2hfbm9kZShhZGlfYXhpX2FkY19vZl9tYXRjaCwgZGV2LT5vZl9ub2RlKTsN
Cj4gPiA+IA0KPiA+ID4gWW91IG1heSB1c2UgdGhpcyBmcm9tIHN0cnVjdCBkcml2ZXIgYW5kIG1v
dmUgdGhlIHRhYmxlIGFmdGVyIHRoaXMNCj4gPiA+IGZ1bmN0aW9uLg0KPiA+IA0KPiA+IHJpZ2h0
OyBpdCBkaWRuJ3Qgb2NjdXIgdG8gbWUsIHNpbmNlIGkgd2FzIGFscmVhZHkgdXNpbmcNCj4gPiBv
Zl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoKSBpbiBhZDk0NjcNCj4gDQo+IEV2ZW4gYmV0dGVyLiBC
dXQgc2VlIGFib3ZlIG5vdGUuDQo+IA0KPiA+ID4gPiArICAgICAgIGlmICghaWQpDQo+ID4gPiA+
ICsgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PREVWKTsNCg==
