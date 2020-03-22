Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBCE18EA72
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 17:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgCVQbT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 12:31:19 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:38192 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726896AbgCVQbS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 12:31:18 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02MGN8u3019702;
        Sun, 22 Mar 2020 12:31:04 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2051.outbound.protection.outlook.com [104.47.44.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ywcp9kjfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Mar 2020 12:31:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lecj0vwYM0+81SoUILLAIZvsgQJRyJTuGHOiPM6u59bCzw/jOO3UfR9cq9OnGNlXXTyRbUERAVW7jQYYAI9GPrPja4elD3mh4/y8C9anul6iVN4yjgXCpDwRD8J9e7DXN82Gq+hNpFLcmwC7mmCcM22ErgAkcl0K075LkqICMvwDaJD9SVonRmUSsAhpXM5BiQWASLt4QqCSo1lX05mQVYnUMFFOAhEzPD/BLfe/+4812FkI+RbFNeOxNTASXxFhK0Av7v5fctnGux0PEylePNalwpET4Ds34EZRHPazMyqEXcoaiW7k+A9c7ylgcSTyvghCjJUMtoJ703b7dNj/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+d7Kvg1TOKCwTu4+z9VcUckvHycAqUEZAcq2Oum54Q=;
 b=kMRbt6QLstBXHZ5esTN3EW+m7SQr8zf7rAlibQi7OvuLokcinZeMU+awtas04KbPAKA1hFRSmCI8hh7gAe86ZJZSVPWzGzgpahirAgiAN2+4mnkihjvKdYJn/UESTE32DoTyTxn+YHTMp3sMGb0WUI3mXHtscOaJJWWCjdibZKQ0o/yh/7L/4OnIx7ChIZaH9372UWE5H8PYAcgyNabflKsePEXYPnKlSUa1hzi4dznciLPY9iDkqfGyJVdImCN2nZUTSOgTPpLVUKCEL0QiF9cYdbBEtRBy2edqvxfRVYx8NVoygbr4QhojdPGzMJy3P5tp8VLk3GXGDnEormKdMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+d7Kvg1TOKCwTu4+z9VcUckvHycAqUEZAcq2Oum54Q=;
 b=gqtSK340CsEcRMcz3nH4yPwWcMxmgIEAccisS/QBzM7RQEA/2ewnN+/ULLzikAGyi5Nf4OKrNxV+7KO+lsFtHqoTf311voeM9kQ+DVHzyJBJJqPehBhM5NzwJBs9n/FnYQyuFJlr4wN9eOIojvnR9rfsGkK3HVelZQL7HxxgG50=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4284.namprd03.prod.outlook.com (2603:10b6:5:d::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Sun, 22 Mar 2020 16:31:02 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Sun, 22 Mar 2020
 16:31:02 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
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
Thread-Index: AQHV/15DYGjLW+byS0qvSggjrAf5zqhTk1UAgADIgICAABN7gIAAXHgAgAAEB4A=
Date:   Sun, 22 Mar 2020 16:31:02 +0000
Message-ID: <db236d3feebf1a84e17787bd519e76f265199ea9.camel@analog.com>
References: <20200321085315.11030-1-alexandru.ardelean@analog.com>
         <20200321085315.11030-6-alexandru.ardelean@analog.com>
         <CAHp75VecnornqckmG_WgN-V9A1VSQfRT85TxFzwHgaLw9dAHeA@mail.gmail.com>
         <979ef870a4f0935e41e95e7759847eba8bd0407c.camel@analog.com>
         <CAHp75Vdna2+txY=w87n+SWE3x3FYJLeMjYbYa6V-co3z0mYx_g@mail.gmail.com>
         <202003220901.880A6DF@keescook>
In-Reply-To: <202003220901.880A6DF@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08683ed1-d0aa-4b97-f9b5-08d7ce7e6974
x-ms-traffictypediagnostic: DM6PR03MB4284:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB4284AF72960E785BAC35AFA6F9F30@DM6PR03MB4284.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0350D7A55D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(376002)(366004)(396003)(199004)(2906002)(2616005)(186003)(53546011)(6512007)(86362001)(4326008)(107886003)(6506007)(54906003)(110136005)(316002)(26005)(6486002)(66946007)(71200400001)(66446008)(64756008)(66476007)(66556008)(36756003)(5660300002)(91956017)(76116006)(478600001)(8936002)(81166006)(81156014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4284;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G2yT+lLwA/mbhuywemTcbKbPjmEFPWNoj4KlJNLNAP4acHo0VQeo6U9hmOCk8JB9TdkapTVNbJ1Djba4Pr0CEVOjhLlPuRimSWF75Rv3LqLqxImhEeOKvVKzUD+YeDT6zJoyQk2CDc/URiUcV3+zBhOpcTBlnqAUjlBbnlsblLYpQDzBKLemdAHFr2waHcsQ4ipcfZsqEo4sSFaQaM+dFBLcLuT0EQmXuR5V+QpLcKa9Rx7qs52wEBtT8EN+NwWqHB/IkLRdX9YJRzT5TVUWbELJuONQHC7PiQt++k55hSqxNLQczyPkkKEo1h/OAhWqwpQ5V/cw/CeIj1MP7AImF5ih/I/9S+lqTyuqmdvMHN1e1kY2VVtXL3FVSs4zevyd2+yCfxVon/OlLoGZB+/RuAzBxdxelhfDnlZ1mqu3GfIVD5efzbWJx3CZVBzy8iga
x-ms-exchange-antispam-messagedata: Ajw6LfJPFvssCY7A2zmv0mlGD6ObAVes22p1Bn1hClC1vt/EOu4A8Zl0HBNSZ18Przy0zfvfsUsmtTdw/liQL0RW/1IZbInEFllfxhWi3d5bCSbAuYipoxRbu7OBRxIyHZDui2rBnvuqzxTZRgfjWQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EF19AF395BD1F40A15800DAF3011A0F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08683ed1-d0aa-4b97-f9b5-08d7ce7e6974
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2020 16:31:02.5190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJdOe8aC81GoFcUClEbFY7P2KEF90CQVZyUzvznMOEHFRS/51p3fwoeHchxpjWI8bIgsaqrvx1bufMTfSVj5Xo9TRX5iTflAz5GuI3L8Eos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4284
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-22_05:2020-03-21,2020-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003220099
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTAzLTIyIGF0IDA5OjE2IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IFN1biwgTWFyIDIyLCAyMDIwIGF0IDEyOjQ1OjM5UE0gKzAyMDAsIEFuZHkgU2hldmNoZW5rbyB3
cm90ZToNCj4gPiArQ2MgS2VlcyAoc2VlIGJlbG93IGFib3V0IGFsbG9jYXRpb24gc2l6ZSBjaGVj
a3MpDQo+ID4gDQo+ID4gT24gU3VuLCBNYXIgMjIsIDIwMjAgYXQgMTE6MzYgQU0gQXJkZWxlYW4s
IEFsZXhhbmRydQ0KPiA+IDxhbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6DQo+
ID4gPiBPbiBTYXQsIDIwMjAtMDMtMjEgYXQgMjM6MzggKzAyMDAsIEFuZHkgU2hldmNoZW5rbyB3
cm90ZToNCj4gPiA+ID4gT24gU2F0LCBNYXIgMjEsIDIwMjAgYXQgMTA6NTUgQU0gQWxleGFuZHJ1
IEFyZGVsZWFuDQo+ID4gPiA+IDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6
DQo+ID4gDQo+ID4gLi4uDQo+ID4gDQo+ID4gPiA+ID4gK3N0YXRpYyBzdHJ1Y3QgYWRpX2F4aV9h
ZGNfY29udiAqYWRpX2F4aV9hZGNfY29udl9yZWdpc3RlcihzdHJ1Y3QNCj4gPiA+ID4gPiBkZXZp
Y2UNCj4gPiA+ID4gPiAqZGV2LA0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQNCj4gPiA+ID4gPiBzaXplb2ZfcHJp
dikNCj4gPiA+ID4gPiArew0KPiA+ID4gPiA+ICsgICAgICAgc3RydWN0IGFkaV9heGlfYWRjX2Ns
aWVudCAqY2w7DQo+ID4gPiA+ID4gKyAgICAgICBzaXplX3QgYWxsb2Nfc2l6ZTsNCj4gPiA+ID4g
PiArDQo+ID4gPiA+ID4gKyAgICAgICBhbGxvY19zaXplID0gc2l6ZW9mKHN0cnVjdCBhZGlfYXhp
X2FkY19jbGllbnQpOw0KPiA+ID4gPiA+ICsgICAgICAgaWYgKHNpemVvZl9wcml2KSB7DQo+ID4g
PiA+ID4gKyAgICAgICAgICAgICAgIGFsbG9jX3NpemUgPSBBTElHTihhbGxvY19zaXplLCBJSU9f
QUxJR04pOw0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBhbGxvY19zaXplICs9IHNpemVvZl9w
cml2Ow0KPiA+ID4gPiA+ICsgICAgICAgfQ0KPiA+ID4gPiA+ICsgICAgICAgYWxsb2Nfc2l6ZSAr
PSBJSU9fQUxJR04gLSAxOw0KPiA+ID4gPiANCj4gPiA+ID4gSGF2ZSB5b3UgbG9va2VkIGF0IGxp
bnV4L292ZXJmbG93Lmg/DQo+ID4gPiANCj4gPiA+IGkgZGlkIG5vdzsNCj4gPiA+IGFueSBoaW50
cyB3aGVyZSBpIHNob3VsZCBsb29rIGNsb3Nlcj8NCj4gPiANCj4gPiBJdCBzZWVtcyBpdCBsYWNr
cyBvZiB0aGlzIGtpbmQgb2YgYWxsb2NhdGlvbiBzaXplIGNoZWNrcy4uLiBQZXJoYXBzIGFkZCBv
bmU/DQo+ID4gS2Vlcywgd2hhdCBkbyB5b3UgdGhpbms/DQo+ID4gDQo+ID4gPiA+ID4gKyAgICAg
ICBjbCA9IGt6YWxsb2MoYWxsb2Nfc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ID4gPiA+ID4gKyAgICAg
ICBpZiAoIWNsKQ0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5P
TUVNKTsNCj4gDQo+IE15IGhlYWQgaHVydHMgdHJ5aW5nIHRvIHJlYWQgdGhpcyEgOykgT2theSwg
c28gdGhlIGJhc2Ugc2l6ZSBpcw0KPiBzaXplb2Yoc3RydWN0IGFkaV9heGlfYWRjX2NsaWVudCku
IEJ1dCBpZiBzaXplb2ZfcHJpdiBpcyBub24temVybw0KPiAodGhpcyBhcmcgc2hvdWxkIGJlIHNp
emVfdCBub3QgaW50KSwgdGhlbiB3ZSBuZWVkIHRvIG1ha2UgdGhlIHN0cnVjdA0KPiBzaXplIEFM
SUdOZWQ/IEFuZCB0aGVuIHdoYXQgaXMgdGhlICIrPSBJSU9fQUxJR04gLSAxIiBmb3I/DQo+IA0K
PiBJdCdzIG5vdCBjbGVhciB0byBtZSB3aGF0IHRoZSBleHBlY3QgYWxpZ25tZW50L3BhZGRpbmcg
aXMgaGVyZS4NCj4gDQo+IEkgd291bGQgcHJvYmFibHkgY29uc3RydWN0IHRoaXMgYXM6DQo+IA0K
PiAJc2l6ZW9mX3NlbGYgPSBzaXplb2Yoc3RydWN0IGFkaV9heGlfYWRjX2NsaWVudCk7DQo+IAlp
ZiAoc2l6ZW9mX3ByaXYpDQo+IAkJc2l6ZW9mX3NlbGYgPSBBTElHTihzaXplb2Zfc2VsZiwgSUlP
X0FMSUdOKTsNCj4gCWlmIChjaGVja19hZGRfb3ZlcmZsb3coc2l6ZW9mX3NlbGYsIHNpemVvZl9w
cml2LCAmc2l6ZW9mX2FsbG9jKSkNCj4gCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gCWlm
IChjaGVja19hZGRfb3ZlcmZsb3coc2l6ZW9mX2FsbG9jLCBJSU9fQUxJR04gLSAxLCAmc2l6ZW9m
X2FsbG9jKSkNCj4gCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCg0KT2ssIGJ1dCB0aGUgcXVl
c3Rpb24gaXM6IHNob3VsZG4ndCB0aGlzIGJlIGRvbmUgaW4ga21hbGxvYygpL2t6YWxsb2M/DQpX
aHkgZG8gaXQgaW4gZWFjaCBkcml2ZXI/DQpJIGRvbid0IHNlZSB0aGlzIGRvbmUgaW4gbWFueSBk
cml2ZXJzLg0KDQo+IA0KPiBCdXQgSSBkb24ndCB1bmRlcnN0YW5kIHRoZSAiSUlPX0FMSUdOIC0g
MSIgcGFydCwgc28gSSBhc3N1bWUgdGhpcyBjb3VsZA0KPiBiZSBzaG9ydGVuZWQgd2l0aCBiZXR0
ZXIgdXNlIG9mIEFMSUdOKCk/DQo+IA0KPiBBbHNvLCB0aGlzIGZlZWxzIGxpa2UgYSB3ZWlyZCBk
cml2ZXIgYWxsb2NhdGlvbiBvdmVyYWxsOg0KPiANCj4gKwlzdHJ1Y3QgYWRpX2F4aV9hZGNfY29u
diAqKnB0ciwgKmNvbnY7DQo+ICsNCj4gKwlwdHIgPSBkZXZyZXNfYWxsb2MoZGV2bV9hZGlfYXhp
X2FkY19jb252X3JlbGVhc2UsIHNpemVvZigqcHRyKSwNCj4gKwkJCSAgIEdGUF9LRVJORUwpOw0K
PiArCWlmICghcHRyKQ0KPiArCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gKw0KPiArCWNv
bnYgPSBhZGlfYXhpX2FkY19jb252X3JlZ2lzdGVyKGRldiwgc2l6ZW9mX3ByaXYpOw0KPiANCj4g
ZGV2cmVzX2FsbG9jKCkgYWxsb2NhdGVzIHN0b3JhZ2UgZm9yIGEgX3NpbmdsZSBwb2ludGVyXy4g
OlAgVGhhdCdzIG5vdA0KPiB1c2VmdWwgZm9yIHJlc291cmNlIHRyYWNraW5nLiBXaHkgaXMgZGV2
cmVzX2FsbG9jKCkgYmVpbmcgY2FsbGVkIGhlcmUNCj4gYW5kIG5vdCBkb3duIGluIGFkaV9heGlf
YWRjX2NvbnZfcmVnaXN0ZXIoKSBhbmQganVzdCBwYXNzaW5nIHRoZSBwb2ludGVyDQo+IGJhY2sg
dXA/DQo+IA0K
