Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1404190615
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 08:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgCXHLF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 03:11:05 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:34664 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbgCXHLE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 03:11:04 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02O74lXY012985;
        Tue, 24 Mar 2020 03:10:48 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2059.outbound.protection.outlook.com [104.47.44.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ywfj6qx5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 03:10:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQl/qe+E+AoQVVK82mj+SS2NYS2XWEs3tfH6iQbWoWbRhkLtA6XlHkPaWFxX96qaqWZ5p89kREnwKX5MuJSHy3tE8nk+tTadJ8xI1QRTz7dDGcIppTecaFkJhCCJ2HBMTzoRlW/MU56Pk6naf/KQhMAm0NjJtrMvkqFyeOrd6DMQaKRW2+KsHwrFQchzhXvIbL6x3bUskjWmMwMdYmPvCP2TSfsXBcR5yXqVvynLUGs9m811hw0NQpuFoI3wGvYvjSFPsz77hwFJzrO8RspY1vx9gtGoNZ/5pi3Clq8FoRdJlagUt5i5r4aLi6PN3KLXOlptY6+LHJg5H3l3iJ5IFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNDIBbVelRqIsbf0bb9eW5XDV63T9M4B0Tbah2+MeQ0=;
 b=mxBq/lCVEAQkoPNo6TUmCVc3+DlYu9DaZHMJQqgdBvRuGidXv2tA+dgUygJjhTljUBJDL3XvysvucyeelShozqjoNXZvYP5ut3rtOpKAvSfgg/HILNVauaU9ze+DLA/Gu48ICv8Sy7Yfp+u4aYhHVKRQocRaVLTC/TVkywkjdZK3wRw3XaKuRk3p04pN82sG5R3zoP1U4aDsaxZMweyLGpoYRYmwd+VWm9qjwH8xQIeB/P13DZSYYqgPXvEzATvO+6NDB1b8dUpZ83z0onUGKkuxpL8q18NhrnbpkxW4WUka0/0Qsh//f51LluFJgS39vQclZ3KMn4+VIxRyZkLJ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNDIBbVelRqIsbf0bb9eW5XDV63T9M4B0Tbah2+MeQ0=;
 b=ZeWj9wPNExYr0iRQOd9g2EQglJ/KB8TClt9DIi2sy5UkeyoJYgMVrRGcO+d1j5le394/kR7PKEBgG19SXRlYrWS6LJyq0lMfw6qSEzNibC+1/7HByrofuL0da3PMC4IAbM4XmfCuWXPpb5xMceGLiO7aO24+j6uoPSlmAaP2HCo=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4985.namprd03.prod.outlook.com (2603:10b6:5:1f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Tue, 24 Mar
 2020 07:10:44 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 07:10:44 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Grozav, Andrei" <Andrei.Grozav@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Costina, Adrian" <Adrian.Costina@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Nagy, Laszlo" <Laszlo.Nagy@analog.com>,
        "Csomortani, Istvan" <Istvan.Csomortani@analog.com>
Subject: Re: [PATCH v11 5/8] iio: adc: adi-axi-adc: add support for AXI ADC IP
 core
Thread-Topic: [PATCH v11 5/8] iio: adc: adi-axi-adc: add support for AXI ADC
 IP core
Thread-Index: AQHV/15DYGjLW+byS0qvSggjrAf5zqhTk1UAgADIgICAABN7gIAAXHgAgAAKQICAAA4mAIAAC/EAgAJoxwA=
Date:   Tue, 24 Mar 2020 07:10:44 +0000
Message-ID: <b3fda4bafe52bc184da2c880c6ace14d870da4dc.camel@analog.com>
References: <20200321085315.11030-1-alexandru.ardelean@analog.com>
         <20200321085315.11030-6-alexandru.ardelean@analog.com>
         <CAHp75VecnornqckmG_WgN-V9A1VSQfRT85TxFzwHgaLw9dAHeA@mail.gmail.com>
         <979ef870a4f0935e41e95e7759847eba8bd0407c.camel@analog.com>
         <CAHp75Vdna2+txY=w87n+SWE3x3FYJLeMjYbYa6V-co3z0mYx_g@mail.gmail.com>
         <202003220901.880A6DF@keescook> <20200322165317.0b1f0674@archlinux>
         <319e36a6e4553a54812c63d89df181aee165bd4b.camel@analog.com>
         <20200322182640.20b83ce0@archlinux>
In-Reply-To: <20200322182640.20b83ce0@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 748b93b3-4fd9-4aa1-1d28-08d7cfc27884
x-ms-traffictypediagnostic: DM6PR03MB4985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB49855BDD418110788B0535B2F9F10@DM6PR03MB4985.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(54906003)(2906002)(36756003)(6916009)(53546011)(6506007)(498600001)(8936002)(966005)(71200400001)(81156014)(81166006)(8676002)(76116006)(86362001)(107886003)(6512007)(186003)(2616005)(4326008)(26005)(64756008)(66556008)(5660300002)(66476007)(91956017)(6486002)(66946007)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4985;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xgzNeUucuond3pVR0VjEFRvKofCsc1pnbQ9h6+P+YOT+F8pEyQgHMy8AJFh8Gan8faMpd397rI2GDVo6d+PTMwgkOyq2TRsfUHNzrG+G+oVSq0/MZVjBJT2iScifJX6qIPi5LoeNmlm0RmcwT8lFz2soN3lz8awSQtLhBg9o3m5/HrhXNLzhDN+Uc1L6/pyVfCbTx+unAPjfkwzJm+9KFJIjpHkmc7TEv0AtLCYaqlk7Oc/vUVv9goMp4aBjpMfxU1z5+D8Eu82MBT+D3zoDBybvFUDsvPB2YzZC4T8R0Brc5WGweFWLGmDMtLDqqVBrvyBeq5/rKpQ4bZI2607cvHwoaGVAX7d5yoxTqdZGRJChDzybhkt1kmGjvBoEAAP5nynLaRtRkaDQgTFWm+DVijrAobFB6H4kbqgJM7ldDZpdcrByyTpi0dUGgbGlbjKUv/uV8PRzL7tbOQOFTA1z/Ym5KWIUEx37Cpr5ItHctRFAEt0nIF3oYWL/yz7uPUyXGd82evWHuVLV5DNbXijAEQ==
x-ms-exchange-antispam-messagedata: Hr//gbypI8GgXDoB82N0IMM3GkM+Afz4eFCmVH5Z/iVDPOz6XMN2wEyCtVkQ9NnLdi8zY5aUvHAVbB/rTSG2bGHl1REWVWbYq3hM9Fy8hukKIlROG8wwQ7JlgrNDcEvTGExm1Oeitz587eWjgHjfPQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <2081260F6AAAA64E995279261A88291F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748b93b3-4fd9-4aa1-1d28-08d7cfc27884
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 07:10:44.6435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nVf57Et254MOpeiXyjthhxerVR6+OQKzyHQ1A0XsFKBw+0nORwF/Pxk621MktPfAYxNxTdkQlm3Ivka9BgN9zn82c6fNTniC0LL4XIcB8s8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4985
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_01:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240036
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTAzLTIyIGF0IDE4OjI2ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBTdW4sIDIyIE1hciAyMDIwIDE3OjQwOjMwICswMDAwDQo+ICJBcmRlbGVhbiwgQWxl
eGFuZHJ1IiA8YWxleGFuZHJ1LkFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBP
biBTdW4sIDIwMjAtMDMtMjIgYXQgMTY6NTMgKzAwMDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6
DQo+ID4gPiBPbiBTdW4sIDIyIE1hciAyMDIwIDA5OjE2OjM2IC0wNzAwDQo+ID4gPiBLZWVzIENv
b2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4gd3JvdGU6DQo+ID4gPiAgIA0KPiA+ID4gPiBPbiBT
dW4sIE1hciAyMiwgMjAyMCBhdCAxMjo0NTozOVBNICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3Jv
dGU6ICANCj4gPiA+ID4gPiArQ2MgS2VlcyAoc2VlIGJlbG93IGFib3V0IGFsbG9jYXRpb24gc2l6
ZSBjaGVja3MpDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gT24gU3VuLCBNYXIgMjIsIDIwMjAgYXQg
MTE6MzYgQU0gQXJkZWxlYW4sIEFsZXhhbmRydQ0KPiA+ID4gPiA+IDxhbGV4YW5kcnUuQXJkZWxl
YW5AYW5hbG9nLmNvbT4gd3JvdGU6ICAgIA0KPiA+ID4gPiA+ID4gT24gU2F0LCAyMDIwLTAzLTIx
IGF0IDIzOjM4ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6ICAgIA0KPiA+ID4gPiA+ID4g
PiBPbiBTYXQsIE1hciAyMSwgMjAyMCBhdCAxMDo1NSBBTSBBbGV4YW5kcnUgQXJkZWxlYW4NCj4g
PiA+ID4gPiA+ID4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPiB3cm90ZTogICAgDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gLi4uDQo+ID4gPiA+ID4gICAgIA0KPiA+ID4gPiA+ID4gPiA+
ICtzdGF0aWMgc3RydWN0IGFkaV9heGlfYWRjX2NvbnYNCj4gPiA+ID4gPiA+ID4gPiAqYWRpX2F4
aV9hZGNfY29udl9yZWdpc3RlcihzdHJ1Y3QNCj4gPiA+ID4gPiA+ID4gPiBkZXZpY2UNCj4gPiA+
ID4gPiA+ID4gPiAqZGV2LA0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQNCj4gPiA+ID4gPiA+ID4gPiBz
aXplb2ZfcHJpdikNCj4gPiA+ID4gPiA+ID4gPiArew0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAg
c3RydWN0IGFkaV9heGlfYWRjX2NsaWVudCAqY2w7DQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICBz
aXplX3QgYWxsb2Nfc2l6ZTsNCj4gPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ID4gKyAg
ICAgICBhbGxvY19zaXplID0gc2l6ZW9mKHN0cnVjdCBhZGlfYXhpX2FkY19jbGllbnQpOw0KPiA+
ID4gPiA+ID4gPiA+ICsgICAgICAgaWYgKHNpemVvZl9wcml2KSB7DQo+ID4gPiA+ID4gPiA+ID4g
KyAgICAgICAgICAgICAgIGFsbG9jX3NpemUgPSBBTElHTihhbGxvY19zaXplLCBJSU9fQUxJR04p
Ow0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBhbGxvY19zaXplICs9IHNpemVvZl9w
cml2Ow0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgfQ0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAg
YWxsb2Nfc2l6ZSArPSBJSU9fQUxJR04gLSAxOyAgICANCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiA+IEhhdmUgeW91IGxvb2tlZCBhdCBsaW51eC9vdmVyZmxvdy5oPyAgICANCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gaSBkaWQgbm93Ow0KPiA+ID4gPiA+ID4gYW55IGhpbnRzIHdoZXJl
IGkgc2hvdWxkIGxvb2sgY2xvc2VyPyAgICANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJdCBzZWVt
cyBpdCBsYWNrcyBvZiB0aGlzIGtpbmQgb2YgYWxsb2NhdGlvbiBzaXplIGNoZWNrcy4uLiBQZXJo
YXBzDQo+ID4gPiA+ID4gYWRkDQo+ID4gPiA+ID4gb25lPw0KPiA+ID4gPiA+IEtlZXMsIHdoYXQg
ZG8geW91IHRoaW5rPw0KPiA+ID4gPiA+ICAgICANCj4gPiA+ID4gPiA+ID4gPiArICAgICAgIGNs
ID0ga3phbGxvYyhhbGxvY19zaXplLCBHRlBfS0VSTkVMKTsNCj4gPiA+ID4gPiA+ID4gPiArICAg
ICAgIGlmICghY2wpDQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBFUlJf
UFRSKC1FTk9NRU0pOyAgICANCj4gPiA+ID4gDQo+ID4gPiA+IE15IGhlYWQgaHVydHMgdHJ5aW5n
IHRvIHJlYWQgdGhpcyEgOykgT2theSwgc28gdGhlIGJhc2Ugc2l6ZSBpcw0KPiA+ID4gPiBzaXpl
b2Yoc3RydWN0IGFkaV9heGlfYWRjX2NsaWVudCkuIEJ1dCBpZiBzaXplb2ZfcHJpdiBpcyBub24t
emVybw0KPiA+ID4gPiAodGhpcyBhcmcgc2hvdWxkIGJlIHNpemVfdCBub3QgaW50KSwgdGhlbiB3
ZSBuZWVkIHRvIG1ha2UgdGhlIHN0cnVjdA0KPiA+ID4gPiBzaXplIEFMSUdOZWQ/IEFuZCB0aGVu
IHdoYXQgaXMgdGhlICIrPSBJSU9fQUxJR04gLSAxIiBmb3I/ICANCj4gPiA+IA0KPiA+ID4gSSdt
IGEgYml0IGVtYmFycmFzc2VkLiAgSSBjYW4ndCByZW1lbWJlciB3aGF0IHRoZSArPSBJSU9fQUxJ
R04gLSAxDQo+ID4gPiB3YXMgZm9yIGluIHRoZSBmaXJzdCBwbGFjZSBhbmQgSSBjYW4ndCB3b3Jr
IGl0IG91dCBub3cuDQo+ID4gPiANCj4gPiA+IFRoZSBwdXJwb3NlIG9mIHRoZSBmdW4gaGVyZSB3
YXMgdG8gZW5kIHVwIHdpdGggYSBzdHJ1Y3R1cmUgdGhhdA0KPiA+ID4gd2FzIGVpdGhlcg0KPiA+
ID4gYSkgc2l6ZW9mKHN0cnVjdCBpaW9fZGV2KSBsb25nLA0KPiA+ID4gYikgc2l6ZW9mKHN0cnVj
dCBpaW9fZGV2KSArIHBhZGRpbmcgKyBzaXplb2ZfcHJpdiANCj4gPiA+IHdoZXJlIHRoZSBwYWRk
aW5nIGVuc3VyZWQgdGhhdCBhbnkgX19jYWNoZWxpbmVfYWxpZ25lZCBlbGVtZW50cw0KPiA+ID4g
aW4gdGhlIHByaXZhdGUgc3RydWN0dXJlIHdlcmUgY2FjaGVsaW5lIGFsaWduZWQgd2l0aGluIHJl
c3VsdGluZw0KPiA+ID4gYWxsb2NhdGlvbi4NCj4gPiA+IA0KPiA+ID4gU28gd2h5IHRoZSBleHRy
YSBJSU9fQUxJR04gLSAxLi4uLg0KPiA+ID4gDQo+ID4gPiBUaGUgb3JpZ2luYWwgcGF0Y2ggZG9l
c24ndCBoZWxwIG11Y2ggZWl0aGVyIGdpdmVuIGl0J3MgZ290IGEgcXVlc3Rpb24NCj4gPiA+IGlu
IHRoZXJlIGZvciB3aHkgdGhpcyBiaXQgaXMgbmVlZGVkLg0KPiA+ID4gDQo+ID4gPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1paW8vMTMwMjg5MDE2MC04ODIzLTUtZ2l0LXNlbmQtZW1h
aWwtamljMjNAY2FtLmFjLnVrLw0KPiA+ID4gDQo+ID4gPiBIb3dldmVyLCBpdCByYW5nIGEgc2xp
Z2h0IGJlbGwuICBTZWVtcyBJIGxpZnRlZCB0aGUgY29kZSBmcm9tIG5ldGRldi4NCj4gPiA+IGh0
dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvbmV0L2NvcmUvZGV2
LmMjTDk3MTgNCj4gPiA+IA0KPiA+ID4gSSdtIGZhaXJseSBzdXJlIHdlIGRvbid0IG5lZWQgdGhh
dCBwYWRkaW5nIGhlcmUuLiAgV2hhdCBjYW4gSSBzYXksDQo+ID4gPiBJIHdhcyB5b3VuZyBhbmQg
c3R1cGlkIDopDQo+ID4gPiANCj4gPiA+IEkgZGlkIGFkZCBhIHF1ZXN0aW9uIG1hcmsgc28gY2xl
YXJseSBtZWFudCB0byBjb21lIGJhY2sgYW5kDQo+ID4gPiB0YWtlIGFub3RoZXIgbG9vayA7KQ0K
PiA+ID4gDQo+ID4gPiBPbmUgdmFndWUgdGhvdWdodCBpcyB0aGF0IGl0J3MgYWJvdXQgZW5zdXJp
bmcgd2UgYXJlIGJpZyBlbm91Z2ggdG8NCj4gPiA+IGVuc3VyZSB3ZSBhcmUgY2FjaGVsaW5lIGFs
aWduZWQuICBUaGF0J3Mgb2J2aW91c2x5IG5vdCBhIHByb2JsZW0gd2l0aA0KPiA+ID4gY3VycmVu
dCBzdHJ1Y3QgaWlvX2RldiB3aGljaCBpcyBmYXIgZnJvbSBzbWFsbCwNCj4gPiA+IGJ1dCBpbiB0
aGVvcnkgaXQgY291bGQgaGF2ZSBiZWVuLiAgQWxzbywgdGhpbmtpbmcgYWJvdXQgaXQgd2Ugb25s
eQ0KPiA+ID4gbmVlZCB0aGUgc3RydWN0IGlpb19kZXYgdG8gYmUgY2FjaGVsaW5lIGFsaWduZWQg
aWYgd2UgaGF2ZQ0KPiA+ID4gYW4gaWlvX3ByaXYgc3RydWN0dXJlLiAgSWYgd2UgaGF2ZSBvbmUg
b2YgdGhvc2UgaXQgd2lsbCBkZWZpbml0ZWx5DQo+ID4gPiBiZSBiaWcgZW5vdWdoIGFueXdheS4N
Cj4gPiA+IA0KPiA+ID4gQXQgc29tZXBvaW50IEknZCBsaWtlIHRvIGxvb2sgYXQgY2xlYW5pbmcg
aXQgdXAgZm9yIGlpb19kZXZpY2VfYWxsb2MNCj4gPiA+IGJ1dCB3aXRoIGEgbG90IG9mIHRlc3Rp
bmcgYXMgd2hvIGtub3dzIHdoYXQgaXMgcmVseWluZyBvbiB0aGlzIGJlaGF2aW91cg0KPiA+ID4g
b3IgaWYgSSd2ZSBtaXNzZWQgc29tZXRoaW5nLiAgQ3Jhc2hlcyBhcm91bmQgdGhpcyBhbGlnbm1l
bnQgYXJlDQo+ID4gPiBpbmZyZXF1ZW50IGFuZCBuYXN0eSB0byB0cmFjZSBhdCB0aGUgYmVzdCBv
ZiB0aW1lcy4gIA0KPiA+IA0KPiA+IEluIHRoZSBtZWFudGltZSwgYXJlIHRoZXJlIGFueSBvYmpl
Y3Rpb25zIGlmIEkgbGVhdmUgdGhlIGFsbG9jYXRpb24gYXMtaXMNCj4gPiBmb3INCj4gPiB0aGlz
IGRyaXZlciBhcyB3ZWxsPw0KPiA+IEkndmUgdGVzdGVkIHRoZSBkcml2ZXIgYSBiaXQgbW9yZSB3
aXRoIHRoaXMgZm9ybS4NCj4gDQo+IEhtbS4gSSdkIHJhdGhlciB3ZSBkaWRuJ3QgaW50cm9kdWNl
IHRoaXMgd2l0aCB0aGUgZXh0cmEgcGFkZGluZyB1bmxlc3Mgd2UNCj4gY2FuIGZpZ3VyZSBvdXQg
d2h5IGl0IHdvdWxkIG5lZWQgaXQuICBJdCB3b3VsZCBiZSBhIGJpdCBob3JyaWJsZSB0bw0KPiBw
YXRjaCB0aGlzIGluIGEgZmV3IHdlZWtzIHRpbWUgZm9yIHRoaXMgcmVhc29uLg0KPiANCj4gSWYg
eW91IGFic29sdXRlbHkgY2FuJ3QgcmV0ZXN0IGZvciByZW1vdGUgcmVhc29ucyB0aGVuIEkgc3Vw
cG9zZSB3ZSBjb3VsZA0KPiBtZXJnZSBpdCBhbmQgdGlkeSB1cCBsYXRlci4NCg0KSSdsbCBkbyB0
aGUgY2hhbmdlcyBhbmQgcmUtdGVzdC4NCg0KPiANCj4gSm9uYXRoYW4NCj4gDQo+ID4gPiBKb25h
dGhhbg0KPiA+ID4gICANCj4gPiA+ID4gSXQncyBub3QgY2xlYXIgdG8gbWUgd2hhdCB0aGUgZXhw
ZWN0IGFsaWdubWVudC9wYWRkaW5nIGlzIGhlcmUuDQo+ID4gPiA+IA0KPiA+ID4gPiBJIHdvdWxk
IHByb2JhYmx5IGNvbnN0cnVjdCB0aGlzIGFzOg0KPiA+ID4gPiANCj4gPiA+ID4gCXNpemVvZl9z
ZWxmID0gc2l6ZW9mKHN0cnVjdCBhZGlfYXhpX2FkY19jbGllbnQpOw0KPiA+ID4gPiAJaWYgKHNp
emVvZl9wcml2KQ0KPiA+ID4gPiAJCXNpemVvZl9zZWxmID0gQUxJR04oc2l6ZW9mX3NlbGYsIElJ
T19BTElHTik7DQo+ID4gPiA+IAlpZiAoY2hlY2tfYWRkX292ZXJmbG93KHNpemVvZl9zZWxmLCBz
aXplb2ZfcHJpdiwgJnNpemVvZl9hbGxvYykpDQo+ID4gPiA+IAkJcmV0dXJuIEVSUl9QVFIoLUVO
T01FTSk7DQo+ID4gPiA+IAlpZiAoY2hlY2tfYWRkX292ZXJmbG93KHNpemVvZl9hbGxvYywgSUlP
X0FMSUdOIC0gMSwNCj4gPiA+ID4gJnNpemVvZl9hbGxvYykpDQo+ID4gPiA+IAkJcmV0dXJuIEVS
Ul9QVFIoLUVOT01FTSk7DQo+ID4gPiA+IA0KPiA+ID4gPiBCdXQgSSBkb24ndCB1bmRlcnN0YW5k
IHRoZSAiSUlPX0FMSUdOIC0gMSIgcGFydCwgc28gSSBhc3N1bWUgdGhpcyBjb3VsZA0KPiA+ID4g
PiBiZSBzaG9ydGVuZWQgd2l0aCBiZXR0ZXIgdXNlIG9mIEFMSUdOKCk/DQo+ID4gPiA+IA0KPiA+
ID4gPiBBbHNvLCB0aGlzIGZlZWxzIGxpa2UgYSB3ZWlyZCBkcml2ZXIgYWxsb2NhdGlvbiBvdmVy
YWxsOg0KPiA+ID4gPiANCj4gPiA+ID4gKwlzdHJ1Y3QgYWRpX2F4aV9hZGNfY29udiAqKnB0ciwg
KmNvbnY7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlwdHIgPSBkZXZyZXNfYWxsb2MoZGV2bV9hZGlf
YXhpX2FkY19jb252X3JlbGVhc2UsIHNpemVvZigqcHRyKSwNCj4gPiA+ID4gKwkJCSAgIEdGUF9L
RVJORUwpOw0KPiA+ID4gPiArCWlmICghcHRyKQ0KPiA+ID4gPiArCQlyZXR1cm4gRVJSX1BUUigt
RU5PTUVNKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWNvbnYgPSBhZGlfYXhpX2FkY19jb252X3Jl
Z2lzdGVyKGRldiwgc2l6ZW9mX3ByaXYpOw0KPiA+ID4gPiANCj4gPiA+ID4gZGV2cmVzX2FsbG9j
KCkgYWxsb2NhdGVzIHN0b3JhZ2UgZm9yIGEgX3NpbmdsZSBwb2ludGVyXy4gOlAgVGhhdCdzIG5v
dA0KPiA+ID4gPiB1c2VmdWwgZm9yIHJlc291cmNlIHRyYWNraW5nLiBXaHkgaXMgZGV2cmVzX2Fs
bG9jKCkgYmVpbmcgY2FsbGVkIGhlcmUNCj4gPiA+ID4gYW5kIG5vdCBkb3duIGluIGFkaV9heGlf
YWRjX2NvbnZfcmVnaXN0ZXIoKSBhbmQganVzdCBwYXNzaW5nIHRoZSBwb2ludGVyDQo+ID4gPiA+
IGJhY2sgdXA/DQo+ID4gPiA+ICAgDQo=
