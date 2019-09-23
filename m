Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6548BAE5C
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2019 09:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbfIWHSI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Sep 2019 03:18:08 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:56388 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729404AbfIWHSI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2019 03:18:08 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8N7DVdL025502;
        Mon, 23 Sep 2019 03:17:31 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2058.outbound.protection.outlook.com [104.47.45.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v6hjwmxhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 03:17:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZ6ck61/QkYnNqdUdGnzkUyF8zFSmlcU6imwsPxvLiH41Pu7B/1LsPZYzl/HREk3zLR5U72Vye2fePjTyZQEZo1SsfyDUiBspGvMONi/Na5LZut6ReB7ithXWj3fozm3sR4ptGXf/jFPW1nCeWGGWUwPI9LuiACBWhqABECuMAtRGAWJcRCCgz4qYl0QYdgpsebQLyjhw5xmStTmQDU23qiX6CgAzpm0Wxz8JMJKV4Q9mJ72G5RQvGsgkhCfc4r6ynt+jFRsd3NIRc122oNPcd+WC6VvGzMZrfvqkBLRudgFKtyKBBZ4ftjIjJUOzjlbU7a5Z0sfwBKEpp7do8aZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62CVcVwuI7LXGIFG+3dJSyw2Y12L4n6e4WXEsw8cgJ0=;
 b=cp9I/490zPBOE30n5GnWPaOqt4ad2G7IClFxkNGspjBaFrO2Y5/Z3jnsO+J07ZSJ5vZzzHGAtez1butNi9zJMMent0gODhCr514ifDASqlGzW/EB38/AVQXLbvXLEZtn8rurEVhY6rrArJSKhOYd9okRFsA+YEIX5Yt662nUq2nmgBEo9FBagELYnq0EkwlbXFOV9RJrFIBKgci3o0ZnfiLmkFXTWyVL2IinZwO2+QeH7ekv+R/viXaqWjuncxE5i4xu9u7HxmYXlhBC6UopEzYCj2mRdP01/iD75/mym3aDNmOg9j6G8WQE23mGDpUXVfHNvzyhqX0dgkm6ILpPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62CVcVwuI7LXGIFG+3dJSyw2Y12L4n6e4WXEsw8cgJ0=;
 b=sbpwN0qis5KZ66jsu4YUo0Z5E3svRqZv96QWnWSRJzl9RpwygwJ6Z5cXnk6DhjKAPWHJegVr56PdH9LwXTfjyVITYB8pdvmFJrlxOBtn6tIHJpaBgUeVFyW4NEZ1Gah/eZtwkunjAbDHvM9sAzsVIRvz+KG52pWKp8gwCzb6CxM=
Received: from MN2PR03MB5117.namprd03.prod.outlook.com (52.132.171.137) by
 MN2PR03MB4751.namprd03.prod.outlook.com (20.179.83.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Mon, 23 Sep 2019 07:17:28 +0000
Received: from MN2PR03MB5117.namprd03.prod.outlook.com
 ([fe80::9db6:a133:7d27:643]) by MN2PR03MB5117.namprd03.prod.outlook.com
 ([fe80::9db6:a133:7d27:643%4]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 07:17:28 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/2] iio: temperature: Add support for LTC2983
Thread-Topic: [PATCH 1/2] iio: temperature: Add support for LTC2983
Thread-Index: AQHVZx1cqYZTgWvqgUqejLIXa24ATKcsowAAgAFzhgCACFfygIACgVSA
Date:   Mon, 23 Sep 2019 07:17:28 +0000
Message-ID: <b149a6d42d053106cb7ed9890f127ef950a0e202.camel@analog.com>
References: <20190909144550.164488-1-nuno.sa@analog.com>
         <20190915122754.4a529e9e@archlinux>
         <14a62c13cfd0175e03384ed691720c2db6fc086a.camel@analog.com>
         <20190921180229.3483d88e@archlinux>
In-Reply-To: <20190921180229.3483d88e@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a14c951-e5ce-4736-7682-08d73ff617b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR03MB4751;
x-ms-traffictypediagnostic: MN2PR03MB4751:
x-microsoft-antispam-prvs: <MN2PR03MB4751F16E42449C9E72D913BB99850@MN2PR03MB4751.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(366004)(346002)(51914003)(189003)(199004)(5660300002)(229853002)(476003)(2501003)(6436002)(5024004)(256004)(4326008)(446003)(6486002)(8936002)(81156014)(3846002)(6512007)(478600001)(6116002)(8676002)(7736002)(2906002)(14454004)(2616005)(11346002)(6506007)(25786009)(14444005)(86362001)(71200400001)(71190400001)(102836004)(6246003)(6916009)(76116006)(91956017)(66946007)(36756003)(305945005)(118296001)(81166006)(66066001)(66446008)(64756008)(66556008)(316002)(99286004)(66476007)(5640700003)(26005)(54906003)(486006)(186003)(2351001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4751;H:MN2PR03MB5117.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ax8uQGj9+y6vwQDVwdh2KtM8cFzBC9wZbfWemCQKkdaerM/gFm1U8VK8TG4nYALylaHodyze4B49XwOEmuBQ6SY4x36KfBp5mV0Vxhk/0YNWRRuxl+OA+87vVMhHoGQ6LskkQYR3nwz4FZFKpnOWXEM2AAHGo1at87nlbvhm1D0TUHwzcHbilnBWAxzvPLdgm+y+d7OjohpwYSP13dr3ybXZL7Ue6aiF4FPh4mHe38rv+RbnTa+3lPMS+WfGIqdY5eQg/NC7b5F+kiDspy8M8fLvdug3QNuRxQrVZ34vCf13dhSHxK2M7RAUkC606CwhzSAGVnLgaYIy/4r2aMbeuMXhXSE+0rvZ52IBK10lcPVM1W7/d7RfaNoat5bq2x2rqAszUhH5Cve7bpBC/QZOErFU0jkSbvkxfPQfwzngbUE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <31865C0A9AB9BD4681AB77EBEA529ABF@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a14c951-e5ce-4736-7682-08d73ff617b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 07:17:28.6751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z7N5jYT3Zn1K7+wA/k+eJd4kulRqW1htUtVhosTeXG924AGMfoT6u4MljJ+JIbZWeC+zsUms6ny/gViKLlP7Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4751
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-23_02:2019-09-23,2019-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909230072
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDE5LTA5LTIxIGF0IDE4OjAyICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiANCj4gT24gTW9uLCAxNiBTZXAgMjAxOSAwOTozNzoxOCArMDAwMA0KPiAiU2EsIE51bm8i
IDxOdW5vLlNhQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBIaSBKb25hdGhhbiwNCj4gPiAN
Cj4gPiBUaGFua3MgZm9yIHRoZSByZXZpZXcuDQo+ID4gQ29tbWVudHMgaW5saW5lLg0KPiA+IA0K
PiA+IE51bm8gU8OhDQo+ID4gDQo+ID4gT24gU3VuLCAyMDE5LTA5LTE1IGF0IDEyOjI3ICswMTAw
LCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiA+ID4gT24gTW9uLCA5IFNlcCAyMDE5IDE2OjQ1
OjQ5ICswMjAwDQo+ID4gPiBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPiB3cm90ZToNCj4g
PiA+ICAgDQo+ID4gPiA+IFRoZSBMVEMyOTgzIGlzIGEgTXVsdGktU2Vuc29yIEhpZ2ggQWNjdXJh
Y3kgRGlnaXRhbCBUZW1wZXJhdHVyZQ0KPiA+ID4gPiBNZWFzdXJlbWVudCBTeXN0ZW0uIEl0IG1l
YXN1cmVzIGEgd2lkZSB2YXJpZXR5IG9mIHRlbXBlcmF0dXJlDQo+ID4gPiA+IHNlbnNvcnMgYW5k
DQo+ID4gPiA+IGRpZ2l0YWxseSBvdXRwdXRzIHRoZSByZXN1bHQsIGluIMKwQyBvciDCsEYsIHdp
dGggMC4xwrBDIGFjY3VyYWN5DQo+ID4gPiA+IGFuZA0KPiA+ID4gPiAwLjAwMcKwQyByZXNvbHV0
aW9uLiBJdCBjYW4gbWVhc3VyZSB0aGUgdGVtcGVyYXR1cmUgb2YgYWxsDQo+ID4gPiA+IHN0YW5k
YXJkDQo+ID4gPiA+IHRoZXJtb2NvdXBsZXMgKHR5cGUgQixFLEosSyxOLFMsUixUKSwgc3RhbmRh
cmQgMi0sMy0sNC13aXJlDQo+ID4gPiA+IFJURHMsDQo+ID4gPiA+IHRoZXJtaXN0b3JzIGFuZCBk
aW9kZXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOdW5vIFPDoSA8bnVuby5z
YUBhbmFsb2cuY29tPiAgDQo+ID4gPiBTb21lIGNvbW1lbnRzIGlubGluZS4gIE1haW4gY29uY2Vy
biBpcyBhcm91bmQgdGhlIGludGVyZmFjZSwgcmVzdA0KPiA+ID4gaXMNCj4gPiA+IG1pbm9yDQo+
ID4gPiBzdHVmZi4NCj4gPiA+IA0KPiA+ID4gSm9uYXRoYW4NCj4gPiA+ICAgDQo+ID4gPiA+IC0t
LQ0KPiA+ID4gPiAgLi4uL3Rlc3Rpbmcvc3lzZnMtYnVzLWlpby10ZW1wZXJhdHVyZS1sdGMyOTgz
IHwgICA0MyArDQo+ID4gPiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgICA3ICsNCj4gPiA+ID4gIGRyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL0tjb25m
aWcgICAgICAgICAgICAgICB8ICAgMTAgKw0KPiA+ID4gPiAgZHJpdmVycy9paW8vdGVtcGVyYXR1
cmUvTWFrZWZpbGUgICAgICAgICAgICAgIHwgICAgMSArDQo+ID4gPiA+ICBkcml2ZXJzL2lpby90
ZW1wZXJhdHVyZS9sdGMyOTgzLmMgICAgICAgICAgICAgfCAxMzI3DQo+ID4gPiA+ICsrKysrKysr
KysrKysrKysrDQo+ID4gPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDEzODggaW5zZXJ0aW9ucygrKQ0K
PiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lz
ZnMtYnVzLWlpby0NCj4gPiA+ID4gdGVtcGVyYXR1cmUtbHRjMjk4Mw0KPiA+ID4gPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL2x0YzI5ODMuYw0KPiA+ID4gPiAN
Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtYnVz
LWlpby0NCj4gPiA+ID4gdGVtcGVyYXR1cmUtDQo+ID4gPiA+IGx0YzI5ODMgYi9Eb2N1bWVudGF0
aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1paW8tdGVtcGVyYXR1cmUtDQo+ID4gPiA+IGx0YzI5
ODMNCj4gPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4gaW5kZXggMDAwMDAwMDAw
MDAwLi4zYWQzNDQwYzA5ODYNCj4gPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gPiArKysgYi9E
b2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1paW8tdGVtcGVyYXR1cmUtDQo+ID4g
PiA+IGx0YzI5ODMNCj4gPiA+ID4gQEAgLTAsMCArMSw0MyBAQA0KPiA+ID4gPiArV2hhdDoJCS9z
eXMvYnVzL2lpby9kZXZpY2VzL2lpbzpkZXZpY2VYL2luX3RlbXBZX3RoZXJtDQo+ID4gPiA+IGlz
dG9yX3JhdyAgDQo+ID4gPiBGb3IgZWFjaCBvZiB0aGVzZSwgSSBwcmVzdW1lIHdlIGtub3cgd2hp
Y2ggdHlwZSBvZiBkZXZpY2UgaXMNCj4gPiA+IGF0dGFjaGVkDQo+ID4gPiBhdCBhbnkgdGltZT8N
Cj4gPiA+IFVzaW5nIHRoZSBjaGFubmVsIG5hbWluZyB0byBjb252ZXkgdGhpcyAoYW5kIEkgYXNz
dW1lIHRoZSBmYWN0DQo+ID4gPiB0aGF0DQo+ID4gPiBkaWZmZXJlbnQNCj4gPiA+IGNvbnZlcnNp
b25zIG5lZWQgdG8gYmUgZG9uZSBpbiB1c2Vyc3BhY2U/KSBpcyBhIGJpdCBtZXNzeS4gIElmIHdl
DQo+ID4gPiBuZWVkDQo+ID4gPiB0byBjb252ZXkgdGhlIGNoYW5uZWwgdHlwZSwgdGhlbiBhIHNl
cGFyYXRlIGluX3RlbXBZX21vZGUNCj4gPiA+IGF0dHJpYnV0ZQ0KPiA+ID4gbWF5IG1ha2UgbW9y
ZQ0KPiA+ID4gc2Vuc2UuICBUaGF0IHdvdWxkIGtlZXAgdGhpcyBBQkkgJ2Nsb3NlcicgdG8gc3Rh
bmRhcmQuIFNvZnR3YXJlDQo+ID4gPiB0aGF0DQo+ID4gPiBqdXN0IGxvZ3MNCj4gPiA+IGFuIHVu
cHJvY2Vzc2VkIHZhbHVlIGNvdWxkIGp1c3Qgd29yayBmb3IgZXhhbXBsZS4NCj4gPiA+IA0KPiA+
ID4gSSdtIG5vdCBzdXJlIEkndmUgdG90YWxseSB1bmRlcnN0b29kIHdoYXQgaXMgZ29pbmcgb24g
aGVyZQ0KPiA+ID4gdGhvdWdoLg0KPiA+ID4gICANCj4gPiBTbywgdGhlIGBleHRlbmRfbmFtZWAg
ZG9lcyBub3QgcmVhbGx5IGJyaW5nIGFueSBmdW5jdGlvbmFsDQo+ID4gYWR2YW50YWdlLg0KPiA+
IEl0IHdhcyBqdXN0IGFuIGVhc3kgd2F5IGZvciBzb21lb25lIHRvIGtub3cgd2hpY2gga2luZCBv
ZiBzZW5zb3INCj4gPiB0aGUNCj4gPiBjaGFubmVsIHdhcyByZWZlcnJpbmcgdG8uIEluIHRlcm1z
IG9mIGNvbnZlcnNpb25zLCBhbGwgdGhlIHdvcmsgaXMNCj4gPiBkb25lDQo+ID4gYnkgdGhlIHBh
cnQgZm9yIGFsbCB0aGUgZGlmZmVyZW50IHNlbnNvcidzIGFuZCB0aGUgc2NhbGUgaXMgdGhlDQo+
ID4gc2FtZQ0KPiA+IGZvciBhbGwgb2YgdGhlbS4gU28sIEkgY2FuIGp1c3QgZHJvcCB0aGUgZXh0
ZW5kZWQgbmFtZSBhbmQgdXNlDQo+ID4gc3RhbmRhcmQNCj4gPiBBQkkgaWYgeW91IHByZWZlcj8N
Cj4gDQo+IFBsZWFzZSBkby4gIEl0IG1heSBtYWtlIHNlbnNlIHRvIGFkZCBhbiBhZGRpdGlvbmFs
IGF0dHJpYnV0ZSB0bw0KPiBwcm92aWRlDQo+IHRoZSBpbmZvIG9uIHRoZSB0eXBlIG9mIHNlbnNv
ciwgYnV0IHdlIGRvbid0IHdhbnQgdG8gZG8gYW55dGhpbmcgdGhhdA0KPiB3aWxsIGNyZWF0ZSBu
ZXcgQUJJIGluIHRoZSBiYXNpYyByZWFkIHBhdGguDQoNClRoZXJlIGlzIGFscmVhZHkgYSB2MiB0
aGF0IEkndmUgc2VudCBsYXN0IHdlZWsgd2hpY2ggZHJvcHMgdGhlDQpgZXh0ZW5kX25hbWVgLiBJ
IGd1ZXNzIHdlIHdvdWxkIG5lZWQgdGhlIHR5cGUgb2Ygc2Vuc29yIHBsdXMgdGhlDQpjaGFubmVs
IG51bWJlci4gRWl0aGVyIHdheSwgSSBndWVzcyB0aGF0IGNhbiBiZSBhZGRlZCBsYXRlciBpZiBz
b21lb25lDQphY3R1YWxseSBuZWVkcyBpdC4NCg0KPiAuLi4NCj4gPiA+ID4gKw0KPiA+ID4gPiAr
c3RhdGljIGludCBfX21heWJlX3VudXNlZCBsdGMyOTgzX3N1c3BlbmQoc3RydWN0IGRldmljZSAq
ZGV2KQ0KPiA+ID4gPiArew0KPiA+ID4gPiArCXN0cnVjdCBsdGMyOTgzX2RhdGEgKnN0ID0NCj4g
PiA+ID4gc3BpX2dldF9kcnZkYXRhKHRvX3NwaV9kZXZpY2UoZGV2KSk7DQo+ID4gPiA+ICsJaW50
IHJldDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCW11dGV4X2xvY2soJnN0LT5sb2NrKTsNCj4gPiA+
ID4gKwlyZXQgPSByZWdtYXBfd3JpdGUoc3QtPnJlZ21hcCwgTFRDMjk4M19TVEFUVVNfUkVHLA0K
PiA+ID4gPiBMVEMyOTgzX1NMRUVQKTsNCj4gPiA+ID4gKwlzdC0+cmVzZXQgPSB0cnVlOyAgDQo+
ID4gPiANCj4gPiA+IE5hbWluZyBzZWVtcyBhIGJpdCBvZGQuIFRoZSByZWdpc3RlciBmaWVsZCBp
cyBjYWxsZWQgc2xlZXAsIGJ1dA0KPiA+ID4gd2UNCj4gPiA+IGNhbGwNCj4gPiA+IGl0IHJlc2V0
IGludGVybmFsbHk/ICANCj4gPiBJIGFncmVlLiBTb21ldGhpbmcgbGlrZSBgc3VzcGVuZGAgb3Ig
YHNsZWVwYCBmb3IgdGhlIGJvb2xlYW4gd291bGQNCj4gPiBiZQ0KPiA+IG9rPw0KPiANCj4geWVz
Lg0KDQpSZW5hbWVkIHRvIGBzbGVlcGAuDQoNCj4gPiA+ID4gKwltdXRleF91bmxvY2soJnN0LT5s
b2NrKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCXJldHVybiByZXQ7DQo+ID4gPiA+ICt9DQo+ID4g
PiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBTSU1QTEVfREVWX1BNX09QUyhsdGMyOTgzX3BtX29wcywg
bHRjMjk4M19zdXNwZW5kLA0KPiA+ID4gPiBsdGMyOTgzX3Jlc3VtZSk7DQo+ID4gPiA+ICsNCj4g
PiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BpX2RldmljZV9pZCBsdGMyOTgzX2lkX3RhYmxl
W10gPSB7DQo+ID4gPiA+ICsJeyAibHRjMjk4MyIgfSwNCj4gPiA+ID4gKwl7fSwNCj4gPiA+ID4g
K307DQo+ID4gPiA+ICtNT0RVTEVfREVWSUNFX1RBQkxFKHNwaSwgbHRjMjk4M19pZF90YWJsZSk7
DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGx0
YzI5ODNfb2ZfbWF0Y2hbXSA9IHsNCj4gPiA+ID4gKwl7IC5jb21wYXRpYmxlID0gImFkaSxsdGMy
OTgzIiB9LA0KPiA+ID4gPiArCXt9LA0KPiA+ID4gPiArfTsNCj4gPiA+ID4gK01PRFVMRV9ERVZJ
Q0VfVEFCTEUob2YsIGx0YzI5ODNfaWRfdGFibGUpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICtzdGF0
aWMgc3RydWN0IHNwaV9kcml2ZXIgbHRjMjk4M19kcml2ZXIgPSB7DQo+ID4gPiA+ICsJLmRyaXZl
ciA9IHsNCj4gPiA+ID4gKwkJLm5hbWUgPSAibHRjMjk4MyIsDQo+ID4gPiA+ICsJCS5vZl9tYXRj
aF90YWJsZSA9IGx0YzI5ODNfb2ZfbWF0Y2gsDQo+ID4gPiA+ICsJCS5wbSA9ICZsdGMyOTgzX3Bt
X29wcywNCj4gPiA+ID4gKwl9LA0KPiA+ID4gPiArCS5wcm9iZSA9IGx0YzI5ODNfcHJvYmUsDQo+
ID4gPiA+ICsJLmlkX3RhYmxlID0gbHRjMjk4M19pZF90YWJsZSwNCj4gPiA+ID4gK307DQo+ID4g
PiA+ICsNCj4gPiA+ID4gK21vZHVsZV9zcGlfZHJpdmVyKGx0YzI5ODNfZHJpdmVyKTsNCj4gPiA+
ID4gKw0KPiA+ID4gPiArTU9EVUxFX0FVVEhPUigiTnVubyBTYSA8bnVuby5zYUBhbmFsb2cuY29t
PiIpOw0KPiA+ID4gPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJBbmFsb2cgRGV2aWNlcyBMVEMyOTgz
IFNQSSBUZW1wZXJhdHVyZQ0KPiA+ID4gPiBzZW5zb3JzIik7DQo+ID4gPiA+ICtNT0RVTEVfTElD
RU5TRSgiR1BMIik7ICANCg0K
