Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8E50CDCAB
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 09:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfJGH43 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 03:56:29 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13912 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727028AbfJGH43 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 03:56:29 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x977qmkC004436;
        Mon, 7 Oct 2019 03:56:27 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2056.outbound.protection.outlook.com [104.47.44.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ven19q28b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 03:56:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fr/l9KmNxuKKFKTcG6cMCggumpqmdAKrJvuzkwvcIs9K/C3/vsK7bRKrvB5NvcdAFdWJOqTX/K+t0DuMIomFP3Jc/cMAf0qT0XuKOea00sxfe/tpIrgtYL6mIyWPwKiEyZklr620Ol/S3CuYA7F9IfL3DaugO+EGLYC1QQ4knBjpWuQQPcUSq0bwlYjyeE3Ecw0Fy7iJoZub51RTIB17FfxkwiIIlnTRiKW/tuGhFDOFge4gEH5zrjpv3ZsvVWCgbtRZlhbey3pZzI2x4DKWlIwYzaUeiuRNay8pmAQdVJ47wMVmuJQToLV4ahQLnJLjJ2z+eb7lI+rGkmglQX9ppA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBINxeaSu0bYomDBi05e7TuNc3ccAC4pSIy0rcLpQ3Q=;
 b=D0Q6oC/vZ9SsKYem6UgJuTiErT1lKDlHRZ1jBvPQuRrg+ekDPUv7fvmI0ZkPXeqZG6NResmR71aHK3vOsXpb45psBVa2KEV6RNlPjDE/1u6liwZfVr5RyrIcgQbsQRwgSpT4iPZ3iQ8ctoLtglFPSdCDfAvY/QSkCtxi61XGupYdmD6Znvc0DfdLwSKHyLTBUWbpf8kZfhUbI9v/jbhlBaT7NuSCwo3Ia7j6odYNA8gRIO0mnI/SvaOHwQPvVm7g984bIA8qB5t9rqPxXWeM0az7EQtWrZtQG0zv86u5JMJIyGhu/KbdqwTj2m5I6mtWpZiyf/oGiE7znr02fuz0Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBINxeaSu0bYomDBi05e7TuNc3ccAC4pSIy0rcLpQ3Q=;
 b=5itYNZIV4zOZ6fzIoH5wZqE7GjFOaDDs9EoNElCaWV0GCbmDbmXFGpw8Z2ajObb0xQWWpWGYQcFBc+MYb+iD5rpO1IoOk7ZeftFP0BmJe1HZt5og+O5qwkD11Q5MhBT8Vg9VvNXC89QyV6EWPq7Ziq4RM/H4WDhqclpiSUYGwVg=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5223.namprd03.prod.outlook.com (20.180.15.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 07:56:25 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2305.023; Mon, 7 Oct 2019
 07:56:25 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: gyro: adis16260: remove indio_dev mlock
Thread-Topic: [PATCH] iio: gyro: adis16260: remove indio_dev mlock
Thread-Index: AQHVbshGq10OTSYYvESBjQKjOSWfbKdMN52AgAADIACAArEsAA==
Date:   Mon, 7 Oct 2019 07:56:24 +0000
Message-ID: <7b9dbfaf490b655a8f2ee0188ec3fd94e215f1e0.camel@analog.com>
References: <20190919115716.25909-1-alexandru.ardelean@analog.com>
         <20191005153837.25e5be57@archlinux> <20191005154949.4c339235@archlinux>
In-Reply-To: <20191005154949.4c339235@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e32acf22-dd4f-4769-598f-08d74afbda05
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CH2PR03MB5223:
x-microsoft-antispam-prvs: <CH2PR03MB5223521C3FDA4C68021152AFF99B0@CH2PR03MB5223.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(366004)(189003)(199004)(2501003)(25786009)(66066001)(5660300002)(316002)(14444005)(6246003)(6512007)(6506007)(66946007)(4326008)(256004)(64756008)(66446008)(66556008)(66476007)(3846002)(76176011)(76116006)(305945005)(99286004)(6116002)(2351001)(6916009)(7736002)(102836004)(476003)(71200400001)(71190400001)(486006)(186003)(11346002)(81166006)(2616005)(2906002)(8936002)(36756003)(14454004)(6436002)(6486002)(446003)(5640700003)(81156014)(8676002)(478600001)(229853002)(118296001)(86362001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5223;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2brl5Oz+Xd3Y7E/TqbTVGbatxbiczFrQAV97T4TM9Yo75cOqrxaRrsnUcwBxuBS03kvM9kvh0W15ZN8pR29cwBaXvgnlQ0LzOizaE7Cjgldoo3BhgUkh6Q/qhtWaeclVLUXvNe2YBhSiPiLlrv/pEHPub1ZxlaDMKTQbotvl/hsE3SEGWto6BYawVURpbIaqvwoyEIb64sUzejFR1O3oSfMG59qcV0RbnmNGFkxZdRcxNoEXoMP6c/hqdSwntiyGnuJIl2/5Qixa7Eqb3GfhL6u+TLWeDm21wd24WbVsvtuwaSmbxH8p8hIJX1oq/swmHoZkYKlvdODIlUNX6dfu+Bg4xcMbLrKmSYBVYGZtlLIYzIWADWgwgzfdCBlK4Uwgm+mPq9sgC7CWrNP7Lo3VctnhyVFveiEhCTUtVqHdZVM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0091F32BCFF1E48A70781BD6D7EF991@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32acf22-dd4f-4769-598f-08d74afbda05
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 07:56:25.0064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p8S7iZ2dDCjC+00y+Qgn1nPhAZhDSTrv4VKnopm8+M3th1WoDRhq1zA973qM3q2XA4Ziq3lMbwNCmct8+/WXztGHgFl2a4ipSGaJUx3uktk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5223
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_01:2019-10-03,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910070084
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDE5LTEwLTA1IGF0IDE1OjQ5ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBTYXQsIDUgT2N0IDIwMTkgMTU6Mzg6NDUgKzAxMDAN
Cj4gSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiA+IE9u
IFRodSwgMTkgU2VwIDIwMTkgMTQ6NTc6MTYgKzAzMDANCj4gPiBBbGV4YW5kcnUgQXJkZWxlYW4g
PGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPiB3cm90ZToNCj4gPiANCj4gPiA+IFRoZSBp
bnRlcm5hbCBsb2NrIHRoYXQgaXMgYnkgdGhlIEFESVMgbGlicmFyeSBzaG91bGQgYmUgc3VmZmlj
aWVudCB0bw0KPiA+ID4ga2VlcA0KPiA+ID4gc3RhdGUgY29uc2lzdGVudC4gVGhlcmUgaXMgbm8g
bmVlZCBmb3IgYW4gZXh0cmEgbG9jay4gIA0KPiA+IA0KPiA+IEknbSBub3Qgc3VyZSB0aGF0J3Mg
dHJ1ZS4gIEluIHRoZW9yeSB3ZSBjb3VsZCBnZXQgdHdvIGRpZmZlcmVudA0KPiA+IGF0dGVtcHRz
DQo+ID4gdG8gc2V0IHRoZSBzYW1wbGluZyBmcmVxdWVuY3kgcnVubmluZyBjb25jdXJyZW50bHku
IFRoYXQgY291bGQgbGVhZCB0bw0KPiA+IGEgcmFjZSBiZXR3ZWVuIHRoZSBwb2ludCB3aGVyZSB3
ZSBzZXQgdGhlIHNwaSBmcmVxdWVuY3kgZm9yIGZ1dHVyZQ0KPiA+IG1lc3NhZ2VzIGFuZCB0aGUg
cG9pbnQgd2hlcmUgd2Ugc2V0IHRoZSBkZXZpY2VzIHNhbXBsaW5nIGZyZXF1ZW5jeS4NCj4gPiAN
Cj4gPiBCYW5nIGl0IHN0b3BzIHdvcmtpbmcuICBTbywgd2hpbHN0IGl0IGlzIGFyZ3VhYmx5IHBh
cmFub2lkIEkgdGhpbmsNCj4gPiB5b3UgZG8gbmVlZCBhIGxvY2sgaGVyZSwgYnV0IGl0IHNob3Vs
ZCBiZSBzb21ldGhpbmcgdGhhdCBpcyBkcml2ZXINCj4gPiBsb2NhbCByYXRoZXIgdGhhbiBtbG9j
ay4NCj4gDQo+IFRoaW5raW5nIGEgYml0IG1vcmUgb24gdGhpcyBkbyB3ZSBoYXZlIGEgcG90ZW50
aWFsIGlzc3VlIHdoZXJlIHdlDQo+IHJhY2Ugd2l0aCBhIHJlYWQgb24gdGhlIHNwaSBidXMgYXMg
d2UgYXJlIGNoYW5naW5nIHRoaXMgZnJlcXVlbmN5Pw0KPiBUaGV5IG1pZ2h0IGFsbCBiZSAnc2Fm
ZScgYnV0IEkgaGF2ZW4ndCB0aG91Z2h0IGl0IHRocm91Z2ggcHJvcGVybHkgeWV0Lg0KPiANCg0K
VG8gYmUgaG9uZXN0LCBJIGRvbid0IGtub3cuDQpJIGFtIHNlZWluZyB3aGF0IHlvdSdyZSBzYXlp
bmcgYWJvdXQgdGhlIGBtYXhfc3BlZWRfaHpgIGNoYW5nZSBhbmQgdGhhdA0KY291bGQgYmUgYW4g
aXNzdWUuIFRoYXQgZGV0YWlsIGhhcyBzbGlwcGVkIG1lLg0KSSBndWVzcywgSSBjb3VsZCByZXdv
cmsgdGhpcyBwYXRjaCB0byB1c2UgdGhlIEFESVMgbGlicmFyeSdzIGxvY2suDQoNCnRoYW5rcw0K
QWxleA0KDQo+ID4gdGhhbmtzLA0KPiA+IA0KPiA+IEpvbmF0aGFuDQo+ID4gDQo+ID4gDQo+ID4g
PiBUaGlzIHBhdGNoIHJlbW92ZXMgaXQuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFs
ZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+ID4gPiAt
LS0NCj4gPiA+ICBkcml2ZXJzL2lpby9neXJvL2FkaXMxNjI2MC5jIHwgMiAtLQ0KPiA+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9paW8vZ3lyby9hZGlzMTYyNjAuYw0KPiA+ID4gYi9kcml2ZXJzL2lpby9neXJvL2Fk
aXMxNjI2MC5jDQo+ID4gPiBpbmRleCAyMDdhMGNlMTM0MzkuLjBmYTkzZDAyMDYyYSAxMDA2NDQN
Cj4gPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2d5cm8vYWRpczE2MjYwLmMNCj4gPiA+ICsrKyBiL2Ry
aXZlcnMvaWlvL2d5cm8vYWRpczE2MjYwLmMNCj4gPiA+IEBAIC0yOTMsNyArMjkzLDYgQEAgc3Rh
dGljIGludCBhZGlzMTYyNjBfd3JpdGVfcmF3KHN0cnVjdCBpaW9fZGV2DQo+ID4gPiAqaW5kaW9f
ZGV2LA0KPiA+ID4gIAkJYWRkciA9IGFkaXMxNjI2MF9hZGRyZXNzZXNbY2hhbi0+c2Nhbl9pbmRl
eF1bMV07DQo+ID4gPiAgCQlyZXR1cm4gYWRpc193cml0ZV9yZWdfMTYoYWRpcywgYWRkciwgdmFs
KTsNCj4gPiA+ICAJY2FzZSBJSU9fQ0hBTl9JTkZPX1NBTVBfRlJFUToNCj4gPiA+IC0JCW11dGV4
X2xvY2soJmluZGlvX2Rldi0+bWxvY2spOw0KPiA+ID4gIAkJaWYgKHNwaV9nZXRfZGV2aWNlX2lk
KGFkaXMtPnNwaSktPmRyaXZlcl9kYXRhKQ0KPiA+ID4gIAkJCXQgPSAyNTYgLyB2YWw7DQo+ID4g
PiAgCQllbHNlDQo+ID4gPiBAQCAtMzEwLDcgKzMwOSw2IEBAIHN0YXRpYyBpbnQgYWRpczE2MjYw
X3dyaXRlX3JhdyhzdHJ1Y3QgaWlvX2Rldg0KPiA+ID4gKmluZGlvX2RldiwNCj4gPiA+ICAJCQlh
ZGlzLT5zcGktPm1heF9zcGVlZF9oeiA9IEFESVMxNjI2MF9TUElfRkFTVDsNCj4gPiA+ICAJCXJl
dCA9IGFkaXNfd3JpdGVfcmVnXzgoYWRpcywgQURJUzE2MjYwX1NNUExfUFJELCB0KTsNCj4gPiA+
ICANCj4gPiA+IC0JCW11dGV4X3VubG9jaygmaW5kaW9fZGV2LT5tbG9jayk7DQo+ID4gPiAgCQly
ZXR1cm4gcmV0Ow0KPiA+ID4gIAl9DQo+ID4gPiAgCXJldHVybiAtRUlOVkFMOyAgDQo=
