Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1521718EA91
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 17:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgCVQoe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 12:44:34 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16684 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbgCVQoe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 12:44:34 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02MGPS15022442;
        Sun, 22 Mar 2020 12:44:18 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2058.outbound.protection.outlook.com [104.47.45.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywcs5v07g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Mar 2020 12:44:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeQba0G1i50/CZhoGodKsoqEnjIaz2RfVtsd9MX8MZG6SqagMJbibCccaTKI0Ymme2CC9rnZye0CPgcFqYyXRbkZeJgNv+6s7X43G4bw+bSNSvSAku5xhHppS9SXihCHW5hvSA68GAKVu7AZqRDQcDqunhxrWo2e3bY0CCXVY7Nb/sduelu4PES9rublvHZids99LEu6bbREpFFvePxxbkDjVAESEEAASi0FKwiY0hvolIwjndxZoMrq9ujOud2MKObDTrqYiTGHqWXZv3AmGVmyUhOq87yFjpkOdkN8aMYw1mUw058iK1NyFH5rL6Fowv7izgdil8fTWd8c7KsBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acX5tl2JjQWvEZCxSG6LbzwEkOFp2S54auVjUxZvOn0=;
 b=nDxTE7Jl/JKz9eJgeMx8qVEvZ3Crvp5juJedezN+OquzD1NH0UBeboMmHIcAFRRcpeuJcW5JKA6KEMmZxWmOR4qEtS2dVjW+uUTqGIFenAuaQ/XNhvge9stLuG3kxgalD4cMhY434NkMwbyjHbSMTXk9JK8sF4UySNz/QT8VKuGjqvLXYeraLSV0kQ+0YV5dpjrAW3/mkcCXmp59/FNAVeOJLISKsxb9AJQjatBbrQMwCO3qX1P0412ZTb1e7bmi6SPmwK9a3FxulQmPmgyCC7GPKdydJwZeSPMY6yqO48fzWskSpAXTynMOfVtIMFQI7a0K+3veh63aoBtLHQo4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acX5tl2JjQWvEZCxSG6LbzwEkOFp2S54auVjUxZvOn0=;
 b=3M6OA0bGnzUGItALIbfc94n573p9uEsJ5+3kuHRb15tVxrWiXDA5dZz53P6UaRw23mMKpgQiT0dgJrG0wduHo5vk8UNuEsir8eASlUDDn3CsWjrJg0odJlZAMR/9neqwsVhmH16BVaomGRLMP3VsW9N/Qsc/GURQAuH8GhuvCog=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4986.namprd03.prod.outlook.com (2603:10b6:5:1e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Sun, 22 Mar
 2020 16:44:17 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Sun, 22 Mar 2020
 16:44:17 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Grozav, Andrei" <Andrei.Grozav@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Csomortani, Istvan" <Istvan.Csomortani@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Nagy, Laszlo" <Laszlo.Nagy@analog.com>,
        "Costina, Adrian" <Adrian.Costina@analog.com>
Subject: Re: [PATCH v11 5/8] iio: adc: adi-axi-adc: add support for AXI ADC IP
 core
Thread-Topic: [PATCH v11 5/8] iio: adc: adi-axi-adc: add support for AXI ADC
 IP core
Thread-Index: AQHV/15DYGjLW+byS0qvSggjrAf5zqhTk1UAgADIgICAABN7gIAAXHgAgAAEB4CAAAOxAA==
Date:   Sun, 22 Mar 2020 16:44:16 +0000
Message-ID: <80fa6f767f0a1f7f26564050bfd88b880bdecc1e.camel@analog.com>
References: <20200321085315.11030-1-alexandru.ardelean@analog.com>
         <20200321085315.11030-6-alexandru.ardelean@analog.com>
         <CAHp75VecnornqckmG_WgN-V9A1VSQfRT85TxFzwHgaLw9dAHeA@mail.gmail.com>
         <979ef870a4f0935e41e95e7759847eba8bd0407c.camel@analog.com>
         <CAHp75Vdna2+txY=w87n+SWE3x3FYJLeMjYbYa6V-co3z0mYx_g@mail.gmail.com>
         <202003220901.880A6DF@keescook>
         <db236d3feebf1a84e17787bd519e76f265199ea9.camel@analog.com>
In-Reply-To: <db236d3feebf1a84e17787bd519e76f265199ea9.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d6aa3660-80eb-44ca-4a47-08d7ce804309
x-ms-traffictypediagnostic: DM6PR03MB4986:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB4986E0FBCFB235943658136AF9F30@DM6PR03MB4986.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0350D7A55D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(346002)(396003)(376002)(136003)(199004)(66556008)(316002)(66476007)(110136005)(54906003)(5660300002)(76116006)(64756008)(478600001)(66446008)(2616005)(2906002)(66946007)(71200400001)(36756003)(6512007)(81166006)(26005)(91956017)(186003)(4326008)(86362001)(6506007)(53546011)(6486002)(107886003)(8936002)(8676002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4986;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gfU1z3iiAC8mE5SyaOts7mJmd5lZwZNzx/Wuo0dE4eWTKIl2r1leo+e6rPxPXbn1Edru0Kiy52FMK/bszFp+x6OOP6CLHCLJbmruEv8nd3OTYnqCuX8Ili8AOkdm7UyHRLO3hL00+1sSazdJFo1D1He3UWNwBMLG0I1PcV2Rj+d978Xbs1DyIZeq4Pz2Xw71qKuyaY2WgZA5k7tUAYFFD/p3Kqvhdm/OIPwiswQVuKT34hbUhF8+L/u/27rBCDs+Mg11guhTxWddN5EGocTdFsjdDqw0VSAHhrKqcPbkughTNK3Wy7iaV9CThwn/4nDhF3nK80S88oTfB2GNDrWNQOqpiEIQinIsrXEojr9uKeIiy68LysOIBnW3UCUg+rW2EL5utRAwChyE0FEYmtfwQIinKE2e+dbL7Mm2CqEPCHcugKye+En/+xyPnwE91kwR
x-ms-exchange-antispam-messagedata: 9KQ9IFiPHpDhm4t2XSEOww4QOnt2GhQuotOrUkfci+3Yoql8s3LxAkTCwOhW2Erh3ce4l3lxts+fgfXmRjNShM27liEph1f4NBUtoXVbAVQZMU0ehLW8SioqbPXSHzixnJuDFT+Q5rhxwC661oDP3Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D0C2795263DEB428839E141E562DCFB@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6aa3660-80eb-44ca-4a47-08d7ce804309
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2020 16:44:17.0333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/lgINKUfx9AleP4RN/fI35rmUFGZrA3Hqt8CrRkqUc5Pk/jHnVMEPFL8JsURP2N5Pvpsvjj+iMbHvtt4vdpwG1ijXZVq7FCrBaHLYGcjfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4986
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-22_05:2020-03-21,2020-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003220099
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTAzLTIyIGF0IDE2OjMxICswMDAwLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdy
b3RlOg0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBTdW4sIDIwMjAtMDMtMjIgYXQgMDk6MTYgLTA3
MDAsIEtlZXMgQ29vayB3cm90ZToNCj4gPiBPbiBTdW4sIE1hciAyMiwgMjAyMCBhdCAxMjo0NToz
OVBNICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4gPiArQ2MgS2VlcyAoc2VlIGJl
bG93IGFib3V0IGFsbG9jYXRpb24gc2l6ZSBjaGVja3MpDQo+ID4gPiANCj4gPiA+IE9uIFN1biwg
TWFyIDIyLCAyMDIwIGF0IDExOjM2IEFNIEFyZGVsZWFuLCBBbGV4YW5kcnUNCj4gPiA+IDxhbGV4
YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6DQo+ID4gPiA+IE9uIFNhdCwgMjAyMC0w
My0yMSBhdCAyMzozOCArMDIwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+ID4gPiA+IE9u
IFNhdCwgTWFyIDIxLCAyMDIwIGF0IDEwOjU1IEFNIEFsZXhhbmRydSBBcmRlbGVhbg0KPiA+ID4g
PiA+IDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6DQo+ID4gPiANCj4gPiA+
IC4uLg0KPiA+ID4gDQo+ID4gPiA+ID4gPiArc3RhdGljIHN0cnVjdCBhZGlfYXhpX2FkY19jb252
ICphZGlfYXhpX2FkY19jb252X3JlZ2lzdGVyKHN0cnVjdA0KPiA+ID4gPiA+ID4gZGV2aWNlDQo+
ID4gPiA+ID4gPiAqZGV2LA0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludA0KPiA+ID4gPiA+ID4gc2l6ZW9mX3By
aXYpDQo+ID4gPiA+ID4gPiArew0KPiA+ID4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgYWRpX2F4aV9h
ZGNfY2xpZW50ICpjbDsNCj4gPiA+ID4gPiA+ICsgICAgICAgc2l6ZV90IGFsbG9jX3NpemU7DQo+
ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArICAgICAgIGFsbG9jX3NpemUgPSBzaXplb2Yoc3Ry
dWN0IGFkaV9heGlfYWRjX2NsaWVudCk7DQo+ID4gPiA+ID4gPiArICAgICAgIGlmIChzaXplb2Zf
cHJpdikgew0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGFsbG9jX3NpemUgPSBBTElHTihh
bGxvY19zaXplLCBJSU9fQUxJR04pOw0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGFsbG9j
X3NpemUgKz0gc2l6ZW9mX3ByaXY7DQo+ID4gPiA+ID4gPiArICAgICAgIH0NCj4gPiA+ID4gPiA+
ICsgICAgICAgYWxsb2Nfc2l6ZSArPSBJSU9fQUxJR04gLSAxOw0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IEhhdmUgeW91IGxvb2tlZCBhdCBsaW51eC9vdmVyZmxvdy5oPw0KPiA+ID4gPiANCj4gPiA+
ID4gaSBkaWQgbm93Ow0KPiA+ID4gPiBhbnkgaGludHMgd2hlcmUgaSBzaG91bGQgbG9vayBjbG9z
ZXI/DQo+ID4gPiANCj4gPiA+IEl0IHNlZW1zIGl0IGxhY2tzIG9mIHRoaXMga2luZCBvZiBhbGxv
Y2F0aW9uIHNpemUgY2hlY2tzLi4uIFBlcmhhcHMgYWRkDQo+ID4gPiBvbmU/DQo+ID4gPiBLZWVz
LCB3aGF0IGRvIHlvdSB0aGluaz8NCj4gPiA+IA0KPiA+ID4gPiA+ID4gKyAgICAgICBjbCA9IGt6
YWxsb2MoYWxsb2Nfc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ID4gPiA+ID4gPiArICAgICAgIGlmICgh
Y2wpDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7
DQo+ID4gDQo+ID4gTXkgaGVhZCBodXJ0cyB0cnlpbmcgdG8gcmVhZCB0aGlzISA7KSBPa2F5LCBz
byB0aGUgYmFzZSBzaXplIGlzDQo+ID4gc2l6ZW9mKHN0cnVjdCBhZGlfYXhpX2FkY19jbGllbnQp
LiBCdXQgaWYgc2l6ZW9mX3ByaXYgaXMgbm9uLXplcm8NCj4gPiAodGhpcyBhcmcgc2hvdWxkIGJl
IHNpemVfdCBub3QgaW50KSwgdGhlbiB3ZSBuZWVkIHRvIG1ha2UgdGhlIHN0cnVjdA0KPiA+IHNp
emUgQUxJR05lZD8gQW5kIHRoZW4gd2hhdCBpcyB0aGUgIis9IElJT19BTElHTiAtIDEiIGZvcj8N
Cj4gPiANCj4gPiBJdCdzIG5vdCBjbGVhciB0byBtZSB3aGF0IHRoZSBleHBlY3QgYWxpZ25tZW50
L3BhZGRpbmcgaXMgaGVyZS4NCj4gPiANCj4gPiBJIHdvdWxkIHByb2JhYmx5IGNvbnN0cnVjdCB0
aGlzIGFzOg0KPiA+IA0KPiA+IAlzaXplb2Zfc2VsZiA9IHNpemVvZihzdHJ1Y3QgYWRpX2F4aV9h
ZGNfY2xpZW50KTsNCj4gPiAJaWYgKHNpemVvZl9wcml2KQ0KPiA+IAkJc2l6ZW9mX3NlbGYgPSBB
TElHTihzaXplb2Zfc2VsZiwgSUlPX0FMSUdOKTsNCj4gPiAJaWYgKGNoZWNrX2FkZF9vdmVyZmxv
dyhzaXplb2Zfc2VsZiwgc2l6ZW9mX3ByaXYsICZzaXplb2ZfYWxsb2MpKQ0KPiA+IAkJcmV0dXJu
IEVSUl9QVFIoLUVOT01FTSk7DQo+ID4gCWlmIChjaGVja19hZGRfb3ZlcmZsb3coc2l6ZW9mX2Fs
bG9jLCBJSU9fQUxJR04gLSAxLCAmc2l6ZW9mX2FsbG9jKSkNCj4gPiAJCXJldHVybiBFUlJfUFRS
KC1FTk9NRU0pOw0KPiANCj4gT2ssIGJ1dCB0aGUgcXVlc3Rpb24gaXM6IHNob3VsZG4ndCB0aGlz
IGJlIGRvbmUgaW4ga21hbGxvYygpL2t6YWxsb2M/DQo+IFdoeSBkbyBpdCBpbiBlYWNoIGRyaXZl
cj8NCj4gSSBkb24ndCBzZWUgdGhpcyBkb25lIGluIG1hbnkgZHJpdmVycy4NCg0KRGlzcmVnYXJk
IHRoaXMgY29tbWVudC4NCkl0J3MgbGF0ZSBoZXJlLCBhbmQgSSdtIGhhdmluZyB0cm91YmxlIHJl
YWRpbmcgdGhlIGNvZGUuDQoNCkJ1dCwgdGhpcyBmZWVscyBhIGJpdCB3ZWlyZCBwb3BwaW5nIHVw
IG5vdywgd2hlbiB0cnlpbmcgdG8gcmUtdXNlIGNvZGUgdGhhdA0KYWxyZWFkeSBleGlzdGVkIGlu
IHBhcnRzIG9mIElJTy4NCkFsbCBJIGRpZCB3YXMgY29weSBiaXRzIGZyb20gaWlvX2RldmljZV9h
bGxvYygpLCBhbmQgbm93IGl0IHNlZW1zIEkgaGF2ZSB0bw0Kd3JpdGUgY29tcGlsZXIvb3ZlcmZs
b3cgY2hlY2tzLg0KDQo+IA0KPiA+IEJ1dCBJIGRvbid0IHVuZGVyc3RhbmQgdGhlICJJSU9fQUxJ
R04gLSAxIiBwYXJ0LCBzbyBJIGFzc3VtZSB0aGlzIGNvdWxkDQo+ID4gYmUgc2hvcnRlbmVkIHdp
dGggYmV0dGVyIHVzZSBvZiBBTElHTigpPw0KPiA+IA0KPiA+IEFsc28sIHRoaXMgZmVlbHMgbGlr
ZSBhIHdlaXJkIGRyaXZlciBhbGxvY2F0aW9uIG92ZXJhbGw6DQo+ID4gDQo+ID4gKwlzdHJ1Y3Qg
YWRpX2F4aV9hZGNfY29udiAqKnB0ciwgKmNvbnY7DQo+ID4gKw0KPiA+ICsJcHRyID0gZGV2cmVz
X2FsbG9jKGRldm1fYWRpX2F4aV9hZGNfY29udl9yZWxlYXNlLCBzaXplb2YoKnB0ciksDQo+ID4g
KwkJCSAgIEdGUF9LRVJORUwpOw0KPiA+ICsJaWYgKCFwdHIpDQo+ID4gKwkJcmV0dXJuIEVSUl9Q
VFIoLUVOT01FTSk7DQo+ID4gKw0KPiA+ICsJY29udiA9IGFkaV9heGlfYWRjX2NvbnZfcmVnaXN0
ZXIoZGV2LCBzaXplb2ZfcHJpdik7DQo+ID4gDQo+ID4gZGV2cmVzX2FsbG9jKCkgYWxsb2NhdGVz
IHN0b3JhZ2UgZm9yIGEgX3NpbmdsZSBwb2ludGVyXy4gOlAgVGhhdCdzIG5vdA0KPiA+IHVzZWZ1
bCBmb3IgcmVzb3VyY2UgdHJhY2tpbmcuIFdoeSBpcyBkZXZyZXNfYWxsb2MoKSBiZWluZyBjYWxs
ZWQgaGVyZQ0KPiA+IGFuZCBub3QgZG93biBpbiBhZGlfYXhpX2FkY19jb252X3JlZ2lzdGVyKCkg
YW5kIGp1c3QgcGFzc2luZyB0aGUgcG9pbnRlcg0KPiA+IGJhY2sgdXA/DQoNClRoaXMgd2FzIGlu
aXRpYWxseSBpbXBsZW1lbnRlZCBhcyBoYXZpbmcgMiBwYXJ0czogMSBhZGlfYXhpX2FkY19jb252
X3JlZ2lzdGVyKCkNCmFuZCAxIGRldm1fYWRpX2F4aV9hZGNfY29udl9yZWdpc3RlcigpIHdoaWNo
IHdlcmUgYm90aCBleHBvcnRlZC4NCkl0IHdhcyBkZWNpY2VkIGVhcmxpZXIgdG8gcmVtb3ZlIHRo
ZSBhZGlfYXhpX2FkY19jb252X3JlZ2lzdGVyKCkgcGFydC4NCg0KPiA+IA0K
