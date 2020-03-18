Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86B6B18989B
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 10:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgCRJyv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 05:54:51 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:54134 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727513AbgCRJyv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 05:54:51 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02I9l6iw031955;
        Wed, 18 Mar 2020 05:54:24 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yu750t2y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 05:54:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+nBdbYXMPfBPN/5DdRXRdSSL0PNT76W7kpRjqTR68xjRmuzVo8JnOaRXqbz1mBDkSq5U3hlOawy8xFC6O0brO9W+Dbft0sgiU1+zlen9H3MX5KXwRS01oLZrbXRj70sgPBmd16N65An2G9GvQ4zp7Gysyw75wvbAz+8admHXUypxlE+H80Ka2dulQOZIk4pNcFta+MtQ+IGlxT8nxK7keBwgcrQ4rNP48qbbjE++4s4FedlCmkEtzBPz6JevYKOrOGnyh/LJHGmwqvIi7lPdnReuCmtLT+GzBZ/2OHgDpMcZhszuG+b5dadVhrJJCpQBrIapc5ki2GC2wOHnoQwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnVyJrBVH8+u3T7o08iMet91zrN/iLqCYCEu15Hm/HI=;
 b=DeKdkJbbu0HCg750IKerziRoISkkZ1dTzwwyyJRGdDPAymK9wb7RnDWzWLN5JyRCQPFEJk72Z+9farKwmmwqRin6atmx1fer3OZAPTQq2Tz36y+279dp0kgwTgrOzOYaybl+qpiiE59InOuQhzP9jB8nlH5zecZXdHjdhZtnZepxZkNQqDtx9KVwydEftmX30h4GmhODFf+oYWvXH4RHJ8SA3nLqlkroz9sPg7fHcqyzA89nzccWZTZjM06xoe5jQ5PVXB9r0e2tiL0vfXy8VylmNJ4f4pF059EXswiA9RbiWcSNWCLtqXJU+lRP9kI/RzGmO2wvYF+TH/gXoGcN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnVyJrBVH8+u3T7o08iMet91zrN/iLqCYCEu15Hm/HI=;
 b=cTCBC8EiTcBRyp2Q8i1Kn9Ved9rY7ZmXQFqoxQpqwa9z+QlieLU4WKF6I1nbyZ/c/SUeglxlp8/Z59ezwfcTCYUDnIFe90EbkSoRlj7BIuZRBhOwU3zTbUm7fKQGHG/YX/tT/xpBZdU34WGAUCZLqlqLD+cEzyuF++5seMZ+eMc=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4092.namprd03.prod.outlook.com (2603:10b6:5:57::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 18 Mar
 2020 09:54:22 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 09:54:22 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "alazar@startmail.com" <alazar@startmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: Add MAX1241 driver
Thread-Topic: [PATCH 1/2] iio: adc: Add MAX1241 driver
Thread-Index: AQHV/Jm3hJBztslZHU2H1pYVzV94AKhN6s+AgAAsDACAAAdHgA==
Date:   Wed, 18 Mar 2020 09:54:22 +0000
Message-ID: <5de5804ecc7d4dfc4d0514727c3ef626b25e1b55.camel@analog.com>
References: <20200317201710.23180-1-alazar@startmail.com>
         <20200317201710.23180-2-alazar@startmail.com>
         <2964715e81108283d08258bcfa8420baef36737f.camel@analog.com>
         <c388a975-553a-c438-37de-2078555c5a89@metafoo.de>
In-Reply-To: <c388a975-553a-c438-37de-2078555c5a89@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6db8f0e-dc68-4fd4-2a8c-08d7cb2255c3
x-ms-traffictypediagnostic: DM6PR03MB4092:
x-microsoft-antispam-prvs: <DM6PR03MB4092B0AAB7A815678938AABAF9F70@DM6PR03MB4092.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:353;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(396003)(376002)(199004)(54906003)(110136005)(186003)(2616005)(8936002)(4326008)(2906002)(81166006)(26005)(316002)(6512007)(66446008)(36756003)(66556008)(64756008)(86362001)(91956017)(478600001)(6506007)(81156014)(8676002)(66946007)(76116006)(5660300002)(6486002)(71200400001)(966005)(66476007)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4092;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j2O7KNpeTFRv9er9rGzrZF4cdNLdPunyf6503xn4/KSz1cC/Wygjtjsv00Dm4XojH0gJbrFa+EwOWe7rsqa2IxO2zw0yLcJ230fD6ANZxRvUvd04Np5++3YfxajVfUz/oCVCdtLtGzPTyU0ClYgz+e4ox2loF7I8W0DjbCbraMGuNvV02ApwTXLR0LA/SDVtmMIkTjIk+GhhQc/8zgXeqg7KiSQcgKi740kHYxe83R0W5YLzO86LwpESP6QfA0MqHsDWRHnVrmWw2jCsv1JZVoYc2hXZ+KnDKFKBMpYVRevdmDPE6hCHBVJfIjDSz33q1bk5MOfc80B5dtoSD93xe0ek0DWPyi3uEvVnBPnSx1NzC5HMSBHToav/1Sf79c+ARboOGIuICSmec9wp0QlNDuPlzCYz10seIaVHpJol+TPAZNett2hfW/ZK7Pm6ZgUYWD/NtfZoEfzhGdSKi8rvELrzKqmGCpCQuuziutLJ8wQyg9JC2cAt/xLms+yo7vCAnwcgFuH4oQeOP6cYDJad6w==
x-ms-exchange-antispam-messagedata: KYpAsFXIqWwx/IVhk5HEGSCYAGdOQZxIE8v1cw9OiMhPcBPew8Nm9unG9eqZMdVT+hw/pCbGX6IhG83IMZ0LpJEDcTN6HrfALr21ByrqlKqLcUovXjbnSnPhy3MwDotEzKu/vLoUmnngJjnmx5UlPg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E063D868DF337468523D3A3A7155672@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6db8f0e-dc68-4fd4-2a8c-08d7cb2255c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 09:54:22.3225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qQ0NDYsPr44gCtZDmawhxJyeVjmG7iO6tuNEacWas5A519JtFSXSMpMnWkUmlTvyOKxRbLMAhftLoATOb7wEEORWzLkSFS1G09P146F9ZOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4092
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_04:2020-03-17,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 clxscore=1015 adultscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180049
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTE4IGF0IDEwOjMxICswMTAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6DQo+IE9uIDMvMTgvMjAgNzo1MCBBTSwgQXJkZWxlYW4sIEFsZXhhbmRydSB3cm90ZToNCj4g
PiBPbiBUdWUsIDIwMjAtMDMtMTcgYXQgMjI6MTcgKzAyMDAsIEFsZXhhbmRydSBMYXphciB3cm90
ZToNCj4gPiA+IFtFeHRlcm5hbF0NCj4gPiA+IA0KPiA+ID4gQWRkIGRyaXZlciBmb3IgdGhlIE1h
eGltIE1BWDEyNDEgMTItYml0LCBzaW5nbGUtY2hhbm5lbCBBREMuIFRoZSBkcml2ZXINCj4gPiA+
IGluY2x1ZGVzIHN1cHBvcnQgZm9yIHRoaXMgZGV2aWNlJ3MgbG93LXBvd2VyIG9wZXJhdGlvbiBt
b2RlLg0KPiA+IA0KPiA+IGhleSwNCj4gPiANCj4gPiBvdmVyYWxsIGxvb2tzIGdvb2Q7DQo+ID4g
DQo+ID4gaSdkIHJ1biAuL3NjcmlwdHMvY2hlY3BhdGNoLnBsIG9uIHRoZSBwYXRjaGVzIGEgYml0
Ow0KPiA+IHlvdSBjYW4gcnVuIGl0IG9uIHRoZSBwYXRjaCBmaWxlLCBvciBvbiB0aGUgZ2l0IGNv
bW1pdCB3aXRoDQo+ID4gLi9zY3JpcHRzL2NoZWNwYXRjaC5wbCAtZyA8Z2l0LWNvbW1pdHM+DQo+
ID4gDQo+ID4gaSB1c3VhbGx5IGRvIC4vc2NyaXB0cy9jaGVjcGF0Y2gucGwgLWcgSEVBRH4yLi4g
W29yIHNvbWV0aGluZyBsaWtlIHRoYXRdDQo+ID4gYmVmb3JlDQo+ID4gZ2VuZXJhdGluZyBwYXRj
aGVzOw0KPiA+IGkgc29tZXRpbWVzIGZvcmdldCB0byBkbyB0aGF0Ow0KPiA+IA0KPiA+IHNvbWUg
bW9yZSBjb21tZW50cyBpbmxpbmUNCj4gPiANCj4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFs
ZXhhbmRydSBMYXphciA8YWxhemFyQHN0YXJ0bWFpbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAg
ZHJpdmVycy9paW8vYWRjL0tjb25maWcgICB8ICAxMiArKysNCj4gPiA+ICAgZHJpdmVycy9paW8v
YWRjL01ha2VmaWxlICB8ICAgMSArDQo+ID4gPiAgIGRyaXZlcnMvaWlvL2FkYy9tYXgxMjQxLmMg
fCAyMTUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ICAgMyBm
aWxlcyBjaGFuZ2VkLCAyMjggaW5zZXJ0aW9ucygrKQ0KPiA+ID4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9paW8vYWRjL21heDEyNDEuYw0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9paW8vYWRjL0tjb25maWcgYi9kcml2ZXJzL2lpby9hZGMvS2NvbmZpZw0KPiA+ID4g
aW5kZXggNWQ4NTQwYjdiNDI3Li4zYTU1YmVlYzY5YzkgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2
ZXJzL2lpby9hZGMvS2NvbmZpZw0KPiA+ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL0tjb25maWcN
Cj4gPiA+IEBAIC01NjYsNiArNTY2LDE4IEBAIGNvbmZpZyBNQVgxMTE4DQo+ID4gPiAgIAkgIFRv
IGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZSBtb2R1
bGUNCj4gPiA+IHdpbGwgYmUNCj4gPiA+ICAgCSAgY2FsbGVkIG1heDExMTguDQo+ID4gPiAgIA0K
PiA+ID4gK2NvbmZpZyBNQVgxMjQxDQo+ID4gPiArCXRyaXN0YXRlICJNYXhpbSBtYXgxMjQxIEFE
QyBkcml2ZXIiDQo+ID4gPiArCWRlcGVuZHMgb24gU1BJDQo+ID4gPiArCXNlbGVjdCBJSU9fQlVG
RkVSDQo+ID4gPiArCXNlbGVjdCBJSU9fVFJJR0dFUkVEX0JVRkZFUg0KPiA+ID4gKwloZWxwDQo+
ID4gPiArCSAgU2F5IHllcyBoZXJlIHRvIGJ1aWxkIHN1cHBvcnQgZm9yIE1heGltIG1heDEyNDEg
MTItYml0LCBzaW5nbGUtY2hhbm5lbA0KPiA+ID4gKyAgICAgICAgICBBREMuDQo+ID4gDQo+ID4g
bml0cGljazogdGhpcyBsb29rcyBpbmNvbnNpc3RlbnRseSBpbmRlbnRlZA0KPiA+IA0KPiA+ID4g
Kw0KPiA+ID4gKwkgIFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBN
IGhlcmU6IHRoZSBtb2R1bGUgd2lsbCBiZQ0KPiA+ID4gKwkgIGNhbGxlZCBtYXgxMTE4Lg0KPiA+
ID4gKw0KPiA+ID4gICBjb25maWcgTUFYMTM2Mw0KPiA+ID4gICAJdHJpc3RhdGUgIk1heGltIG1h
eDEzNjMgQURDIGRyaXZlciINCj4gPiA+ICAgCWRlcGVuZHMgb24gSTJDDQo+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9paW8vYWRjL01ha2VmaWxlIGIvZHJpdmVycy9paW8vYWRjL01ha2VmaWxl
DQo+ID4gPiBpbmRleCBhMWYxZmJlYzBmODcuLjM3ZDZmMTc1NTlkYyAxMDA2NDQNCj4gPiA+IC0t
LSBhL2RyaXZlcnMvaWlvL2FkYy9NYWtlZmlsZQ0KPiA+ID4gKysrIGIvZHJpdmVycy9paW8vYWRj
L01ha2VmaWxlDQo+ID4gPiBAQCAtNTQsNiArNTQsNyBAQCBvYmotJChDT05GSUdfTFRDMjQ5Nykg
Kz0gbHRjMjQ5Ny5vDQo+ID4gPiAgIG9iai0kKENPTkZJR19NQVgxMDI3KSArPSBtYXgxMDI3Lm8N
Cj4gPiA+ICAgb2JqLSQoQ09ORklHX01BWDExMTAwKSArPSBtYXgxMTEwMC5vDQo+ID4gPiAgIG9i
ai0kKENPTkZJR19NQVgxMTE4KSArPSBtYXgxMTE4Lm8NCj4gPiA+ICtvYmotJChDT05GSUdfTUFY
MTI0MSkgKz0gbWF4MTI0MS5vDQo+ID4gPiAgIG9iai0kKENPTkZJR19NQVgxMzYzKSArPSBtYXgx
MzYzLm8NCj4gPiA+ICAgb2JqLSQoQ09ORklHX01BWDk2MTEpICs9IG1heDk2MTEubw0KPiA+ID4g
ICBvYmotJChDT05GSUdfTUNQMzIwWCkgKz0gbWNwMzIweC5vDQo+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9paW8vYWRjL21heDEyNDEuYyBiL2RyaXZlcnMvaWlvL2FkYy9tYXgxMjQxLmMNCj4g
PiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjJiZDMx
ZjIyZmIyYw0KPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gKysrIGIvZHJpdmVycy9paW8vYWRj
L21heDEyNDEuYw0KPiA+ID4gQEAgLTAsMCArMSwyMTUgQEANCj4gPiA+ICsvLyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+ID4gPiArLyoNCj4gPiA+ICsgKiBNQVgxMjQx
IGxvdy1wb3dlciwgMTItYml0IHNlcmlhbCBBREMNCj4gPiA+ICsgKg0KPiA+ID4gKyAqIENvcHly
aWdodCAoYykgMjAyMCBJb2FuLUFsZXhhbmRydSBMYXphciA8YWxhemFyQHN0YXJ0bWFpbC5jb20+
DQo+ID4gPiArICoNCj4gPiA+ICsgKiBUaGlzIGZpbGUgaXMgc3ViamVjdCB0byB0aGUgdGVybXMg
YW5kIGNvbmRpdGlvbnMgb2YgdmVyc2lvbiAyIG9mDQo+ID4gPiArICogdGhlIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlLiAgU2VlIHRoZSBmaWxlIENPUFlJTkcgaW4gdGhlIG1haW4NCj4gPiA+
ICsgKiBkaXJlY3Rvcnkgb2YgdGhpcyBhcmNoaXZlIGZvciBtb3JlIGRldGFpbHMuDQo+ID4gDQo+
ID4gVGhpcyBsaWNlbnNlIHRleHQgaXMgbm8gbG9uZ2VyIG5lZWRlZC4NCj4gPiBUaGUgU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXIgaGVhZGVyIHNob3VsZCBoYW5kbGUgdGhhdC4NCj4gPiANCj4gPiA+
ICsgKg0KPiA+ID4gKyAqIERhdGFzaGVldDoNCj4gPiA+IGh0dHBzOi8vZGF0YXNoZWV0cy5tYXhp
bWludGVncmF0ZWQuY29tL2VuL2RzL01BWDEyNDAtTUFYMTI0MS5wZGYNCj4gPiA+ICsgKi8NCj4g
PiA+ICsNCj4gPiA+ICsjaW5jbHVkZSA8bGludXgvcmVndWxhdG9yL2NvbnN1bWVyLmg+DQo+ID4g
PiArI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L2dwaW8v
Y29uc3VtZXIuaD4NCj4gPiA+ICsjaW5jbHVkZSA8bGludXgvZ3Bpby9kcml2ZXIuaD4NCj4gPiA+
ICsjaW5jbHVkZSA8bGludXgvZ3Bpby5oPg0KPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9paW8vaWlv
Lmg+DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ID4gKyNpbmNsdWRlIDxs
aW51eC9zcGkvc3BpLmg+DQo+ID4gPiArDQo+ID4gPiArI2RlZmluZSBNQVgxMjQxX1ZBTF9NQVNL
IDB4RkZGDQo+ID4gPiArI2RlZmluZSBNQVgxMjQxX1NIRE5fREVMQVlfVVNFQyA0DQo+ID4gPiAr
DQo+ID4gPiArZW51bSBtYXgxMjQxX2lkIHsNCj4gPiA+ICsJbWF4MTI0MSwNCj4gPiA+ICt9Ow0K
PiA+ID4gKw0KPiA+ID4gK3N0cnVjdCBtYXgxMjQxIHsNCj4gPiA+ICsJc3RydWN0IHNwaV9kZXZp
Y2UgKnNwaTsNCj4gPiA+ICsJc3RydWN0IG11dGV4IGxvY2s7DQo+ID4gPiArCXN0cnVjdCByZWd1
bGF0b3IgKnJlZzsNCj4gPiA+ICsJc3RydWN0IGdwaW9fZGVzYyAqc2hkbjsNCj4gPiA+ICsNCj4g
PiA+ICsJX19iZTE2IGRhdGEgX19fX2NhY2hlbGluZV9hbGlnbmVkOw0KPiA+IA0KPiA+IEpvbmF0
aGFuIG1heSBrbm93IGJldHRlciB0aGFuIG1lIGhlcmUsIGJ1dCB5b3UgY291bGQgdGVjaG5pY2Fs
bHkgYXZvaWQNCj4gPiBuZWVkaW5nDQo+ID4gdG8gZXhwbGljaXRseSB1c2UgdGhlIF9fYmUxNiBk
YXRhdHlwZTsgYW5kIGp1c3QgdXNlIHUxNjsNCj4gPiANCj4gPiBpIHRoaW5rIHRoZSBTUEkgZnJh
bWV3b3JrIHNob3VsZCBoYXZlIHNvbWUgaGFuZGxpbmcgZm9yIHRoYXQ7DQo+ID4gbWF5YmUgdXNp
bmcgdGhlICdiaXRzX3Blcl93b3JkJyBmaWVsZDsNCj4gPiB5b3UnZCBwcm9iYWJseSBzdGlsbCBu
ZWVkIHRvIGRvIHRoZSBzaGlmdGluZyB0aG91Z2g7DQo+ID4gaSByZW1lbWJlciBzb21lIGRpc2N1
c3Npb24gYWJvdXQgdGhpcyBvbiBhZDc5NDkuYw0KPiA+IHRob3VnaCB0aGVyZSBtYXkgYmUgb3Ro
ZXIgZHJpdmVycyBkb2luZyB0aGlzIGFzIHdlbGwNCj4gDQo+IEknZCBrZWVwIGl0IGFzIGl0IGlz
LiBXaGljaCBiaXRzX3Blcl93b3JkIHZhbHVlcyBhcmUgc3VwcG9ydGVkIGRlcGVuZHMgDQo+IG9u
IHRoZSBTUEkgbWFzdGVyIGRyaXZlci4gQWxsIG9mIHRoZW0gc3VwcG9ydCA4LWJpdCwgYnV0IG1h
bnkgZG9uJ3QgDQo+IHN1cHBvcnQgMTYtYml0Lg0KDQpGYWlyIGVub3VnaC4NCkknbSBhIGJpdCB2
YWd1ZSBvbiB0aGUgZGV0YWlscyBoZXJlLg0KDQo+IA0KPiAtIExhcnMNCg==
