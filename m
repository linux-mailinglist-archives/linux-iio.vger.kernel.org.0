Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEFB1796B1
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 18:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgCDR3T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 12:29:19 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35518 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726748AbgCDR3S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 12:29:18 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024HKKIL018352;
        Wed, 4 Mar 2020 12:28:57 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ygm52c3ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 12:28:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/ecV6lWTVnGheDRh7UMhX0WTtjrOMLL63FJtCqreGkx0Jl3dJkx7jge1NzTHNui5hWOZ3z/1HdU6CEh9c5pD0VxSQiEE/oK3uK7ACre7SWqPHeZ+5e4gqfWgD2G9fxab8V0QeTWKVApuKyH3chs3fvgtPzYq6UhF9GJuNCwLNqamrFiKixn+uM9dVXutMaSdR7MZBZV2+d1TtRsdSepyPytdrG/1ue7TUdMyNlB8OtFrKpEC7Nw0+J1Jz4BWji5u0a/HXouBpk2+luaVHnD9ic89cghoveKgB8IxhgIFQKKWutm1cZ4iv74FnYMEqp8tg9CMYubkfI0YIa1xGO5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vv2p0h1F/xyE/PReCKQOGSgE1V3JbhpOI48Wvsu6yI=;
 b=h2566tuCjjzZgmTgFRNngdKGGSECvKS7scroiQEQfn/Y1M/x6HRH1x3Eo5GEmrQzLhIFLFwOD4mn5+K4Zf3gxMuOLaCozbPgy8KNbsZcJw6VUKIccdio2PyRhNyxL1zx4Z2YV7vXg1GMn1tO5u3LaIuKgB4fokOotROC6v309Xlwb/GQHyUqfBQNvp33YF30lWlZwBMH0inPUqJflOqBdQXQM2YIwyb36f8/RxZhlQ+G39VyaMvWZ45fWZOPasunQ+xyJzXqPj930dEkpLq7gjDF44Y+1WA/EXjE4s46eIFfl2wPUJVeHMmSZ+gy4pDNWOTslcs5Fm5/EX95kQh1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vv2p0h1F/xyE/PReCKQOGSgE1V3JbhpOI48Wvsu6yI=;
 b=F/Nea3dZY7XAvMMZEoR+rX8ZAi0u0IMMjHyQDyWYFqDNRmMD2QpO02FA7aZlTLojSOHnUuZ2UiaxubzDwuadRlm/ge9kgAXP1LRJ+lxVwstnV4EnOC/ge6nPzOVJOXOsu7zNujs6bA5qoXzN7z/Ib+/a+lCQV8K8Yn3/TXAolCc=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2787.namprd03.prod.outlook.com (2603:10b6:404:5b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Wed, 4 Mar
 2020 17:28:55 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 17:28:55 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 1/5] iio: imu: adis: Add Managed device functions
Thread-Topic: [PATCH 1/5] iio: imu: adis: Add Managed device functions
Thread-Index: AQHV69jnoWUD4EkYa06e5BROcvCcW6g3X62AgAFdpoA=
Date:   Wed, 4 Mar 2020 17:28:55 +0000
Message-ID: <1f9abeec17b9b44c45b0a2796630b42cacd70af3.camel@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
         <20200225124152.270914-2-nuno.sa@analog.com>
         <20200303203826.0b3d127d@archlinux>
In-Reply-To: <20200303203826.0b3d127d@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2230c72-b741-4599-2a46-08d7c061840d
x-ms-traffictypediagnostic: BN6PR03MB2787:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB27870B1AA2DE3A9E706CAAB299E50@BN6PR03MB2787.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(346002)(136003)(199004)(189003)(316002)(86362001)(71200400001)(6916009)(54906003)(2906002)(36756003)(6512007)(6486002)(26005)(66556008)(66446008)(64756008)(66946007)(76116006)(66476007)(2616005)(478600001)(8936002)(6506007)(8676002)(186003)(81166006)(81156014)(5660300002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2787;H:BN6PR03MB3347.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HBRtPeUmK8lebSLk8Bahk/RN4vghPwjIG+bQVJuCFIFBv19ud09XvCN7vixoDx2cOy9rBDBewlvn1sItTvoh+0S7SPUE/9N8B2sFsWEudBhI0TMmFGb2APWb7YnN+KGHy3X8UhC2uqV9bFSqbgT6qeNsY20k9IDbGsCbQ8Dj9VQdJY/IGtbaA0aNEvKjqo8TOtytVgnPry2rkJ8Q6Xj+3XzPdJ/rmbLDgve9HyQi9DwyaPfMGhWQSHzlkIIdHN/XBAbXIcJuFO4qPIvr68Cxfo2R5dh9Rgg3Rq+aj2bem096pW2/AODeSu7U81PYiyLdP5aCY0tWtHt/IxKsY3aMNbl8MEQRgThDEop0rsVA6EOsveAaNoDw44Eni375U/FJcPSHQcxi6bT2efCLkrhBHyBeENuPaCqUcKmhOGqCHe6dJJKoSfgivGiS7lsLN8LN
x-ms-exchange-antispam-messagedata: Hbr6znWkDA8p2v6HyYtWoEWaohaSCEtn3OxWxpuQ+1eKli7nyD6ujmxvApycES9n+StPgu9XmpOxKBWt600/dafgNSmD1nlykWYv5GI7wSrHjD3F8rOOd4Z433S8odKH4dAFEiRcskZOo+LhMWYReQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ADA461515E297469F0DBBB8DED378D2@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2230c72-b741-4599-2a46-08d7c061840d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 17:28:55.4061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9TFikzbesmKItz0vqBG2L7GefcFhvZm64wCzbDdJdUFMeb+TKBxXLCErAp2rhkngSuNcMkLEv+5pmrDjVIicA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2787
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_07:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTAzIGF0IDIwOjM4ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUdWUsIDI1IEZlYiAyMDIwIDEzOjQxOjQ4ICswMTAwDQo+IE51bm8gU8OhIDxudW5v
LnNhQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBm
b3IgYSBtYW5hZ2VkIGRldmljZSB2ZXJzaW9uIG9mDQo+ID4gYWRpc19zZXR1cF9idWZmZXJfYW5k
X3RyaWdnZXIuIEl0IHdvcmtzIGV4YWN0bHkgYXMgdGhlIG9yaWdpbmFsDQo+ID4gb25lIGJ1dCBp
dCBjYWxscyBhbGwgdGhlIGRldm1faWlvXyogZnVuY3Rpb25zIHRvIHNldHVwIGFuIGlpbw0KPiA+
IGJ1ZmZlciBhbmQgdHJpZ2dlci4gSGVuY2Ugd2UgZG8gbm90IG5lZWQgdG8gY2FyZSBhYm91dCBj
bGVhbmluZw0KPiA+IHRob3NlDQo+ID4gYW5kIHdlIGRvIG5vdCBuZWVkIHRvIHN1cHBvcnQgYSBy
ZW1vdmUoKSBjYWxsYmFjayBmb3IgZXZlcnkgZHJpdmVyDQo+ID4gdXNpbmcNCj4gPiB0aGUgYWRp
cyBsaWJyYXJ5Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE51bm8gU8OhIDxudW5vLnNhQGFu
YWxvZy5jb20+DQo+IA0KPiBBIGZldyB0cml2aWFsIHRoaW5ncyBpbmxpbmUuDQo+IA0KPiBJJ20g
aG9waW5nIHRoZSBwbGFuIGhlcmUgaXMgdG8gcmVwbGFjZSBhbGwgdGhlIGV4aXN0aW5nIG5vbiBk
ZXZtDQo+IHZlcnNpb25zDQo+IGFuZCByZW1vdmUgdGhlIG5vbiBkZXZtIHZlcnNpb25zPw0KPiAN
Cj4gVGhhdCB3YXkgd2UgZG9uJ3QgZW5kIHVwIHdpdGggYSBuZWFyIGlkZW50aWNhbCByZXBlYXRl
ZCBibG9jayBvZg0KPiBjb2RlLg0KDQpIb25lc3RseSwgSSBkaWQgbm90IHRob3VnaHQgYWJvdXQg
aXQgYnV0IEkgZG8gYWdyZWUgd2l0aCB5b3UuIFNvLCB3ZQ0Kd2lsbCBoYXZlIHRvIHByZXBhcmUg
cGF0Y2hlcyB0byB1cGRhdGUgYWxsIHVzZXJzIHRvIHVzZSB0aGUgZGV2bQ0KdmVyc2lvbnMgYW5k
IGFmdGVyIHRoYXQsIHJlbW92ZSB0aGUgb2xkIHZlcnNpb25zLi4uDQoNCi0gTnVubyBTw6ENCj4g
VGhhbmtzLA0KPiANCj4gSm9uYXRoYW4NCj4gDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lp
by9pbXUvYWRpc19idWZmZXIuYyAgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICBkcml2ZXJzL2lpby9pbXUvYWRpc190cmlnZ2VyLmMgfCAzOQ0KPiA+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0NCj4gPiAgaW5jbHVkZS9saW51eC9paW8vaW11L2FkaXMu
aCAgIHwgMTcgKysrKysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgODcgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
aW8vaW11L2FkaXNfYnVmZmVyLmMNCj4gPiBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzX2J1ZmZlci5j
DQo+ID4gaW5kZXggM2Y0ZGQ1YzAwYjAzLi4yOTYwMzZhMDFkMzkgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9paW8vaW11L2FkaXNfYnVmZmVyLmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby9pbXUv
YWRpc19idWZmZXIuYw0KPiA+IEBAIC0xOTYsNyArMTk2LDQxIEBAIGludCBhZGlzX3NldHVwX2J1
ZmZlcl9hbmRfdHJpZ2dlcihzdHJ1Y3QgYWRpcw0KPiA+ICphZGlzLCBzdHJ1Y3QgaWlvX2RldiAq
aW5kaW9fZGV2LA0KPiA+ICAJcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9M
X0dQTChhZGlzX3NldHVwX2J1ZmZlcl9hbmRfdHJpZ2dlcik7DQo+IA0KPiBibGFuayBsaW5lIGhl
cmUuDQo+IA0KPiA+ICsvKioNCj4gPiArICogZGV2bV9hZGlzX3NldHVwX2J1ZmZlcl9hbmRfdHJp
Z2dlcigpIC0gU2V0cyB1cCBidWZmZXIgYW5kDQo+ID4gdHJpZ2dlciBmb3INCj4gPiArICoJCQkJ
CSAgdGhlIG1hbmFnZWQgYWRpcyBkZXZpY2UNCj4gPiArICogQGFkaXM6IFRoZSBhZGlzIGRldmlj
ZQ0KPiA+ICsgKiBAaW5kaW9fZGV2OiBUaGUgSUlPIGRldmljZQ0KPiA+ICsgKiBAdHJpZ2dlcl9o
YW5kbGVyOiBPcHRpb25hbCB0cmlnZ2VyIGhhbmRsZXIsIG1heSBiZSBOVUxMLg0KPiA+ICsgKg0K
PiA+ICsgKiBSZXR1cm5zIDAgb24gc3VjY2VzcywgYSBuZWdhdGl2ZSBlcnJvciBjb2RlIG90aGVy
d2lzZS4NCj4gPiArICoNCj4gPiArICogVGhpcyBmdW5jdGlvbiBwZXJmb21zIGV4YWN0bHkgdGhl
IHNhbWUgYXMNCj4gPiBhZGlzX3NldHVwX2J1ZmZlcl9hbmRfdHJpZ2dlcigpDQo+ID4gKyAqLw0K
PiA+ICtpbnQNCj4gPiArZGV2bV9hZGlzX3NldHVwX2J1ZmZlcl9hbmRfdHJpZ2dlcihzdHJ1Y3Qg
YWRpcyAqYWRpcywgc3RydWN0DQo+ID4gaWlvX2RldiAqaW5kaW9fZGV2LA0KPiA+ICsJCQkJICAg
aXJxcmV0dXJuX3QgKCp0cmlnZ2VyX2hhbmRsZXIpKGludCwNCj4gPiB2b2lkICopKQ0KPiA+ICt7
DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCWlmICghdHJpZ2dlcl9oYW5kbGVyKQ0KPiA+
ICsJCXRyaWdnZXJfaGFuZGxlciA9IGFkaXNfdHJpZ2dlcl9oYW5kbGVyOw0KPiA+ICsNCj4gPiAr
CXJldCA9IGRldm1faWlvX3RyaWdnZXJlZF9idWZmZXJfc2V0dXAoJmFkaXMtPnNwaS0+ZGV2LA0K
PiA+IGluZGlvX2RldiwNCj4gPiArCQkJCQkgICAgICAmaWlvX3BvbGxmdW5jX3N0b3JlX3RpbWUs
DQo+ID4gKwkJCQkJICAgICAgdHJpZ2dlcl9oYW5kbGVyLCBOVUxMKTsNCj4gPiArCWlmIChyZXQp
DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwlpZiAoYWRpcy0+c3BpLT5pcnEpIHsN
Cj4gPiArCQlyZXQgPSBkZXZtX2FkaXNfcHJvYmVfdHJpZ2dlcihhZGlzLCBpbmRpb19kZXYpOw0K
PiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4gIA0KPiA+
ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwoZGV2bV9hZGlzX3Nl
dHVwX2J1ZmZlcl9hbmRfdHJpZ2dlcik7DQo+ID4gIC8qKg0KPiA+ICAgKiBhZGlzX2NsZWFudXBf
YnVmZmVyX2FuZF90cmlnZ2VyKCkgLSBGcmVlIGJ1ZmZlciBhbmQgdHJpZ2dlcg0KPiA+IHJlc291
cmNlcw0KPiA+ICAgKiBAYWRpczogVGhlIGFkaXMgZGV2aWNlLg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lpby9pbXUvYWRpc190cmlnZ2VyLmMNCj4gPiBiL2RyaXZlcnMvaWlvL2ltdS9hZGlz
X3RyaWdnZXIuYw0KPiA+IGluZGV4IDhiOWNkMDJjMGY5Zi4uYTA3ZGNjMzY1YzE4IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvaWlvL2ltdS9hZGlzX3RyaWdnZXIuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvaWlvL2ltdS9hZGlzX3RyaWdnZXIuYw0KPiA+IEBAIC0yNyw2ICsyNywxMyBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGlpb190cmlnZ2VyX29wcw0KPiA+IGFkaXNfdHJpZ2dlcl9vcHMgPSB7DQo+
ID4gIAkuc2V0X3RyaWdnZXJfc3RhdGUgPSAmYWRpc19kYXRhX3JkeV90cmlnZ2VyX3NldF9zdGF0
ZSwNCj4gPiAgfTsNCj4gPiAgDQo+ID4gK3N0YXRpYyBpbmxpbmUgdm9pZCBhZGlzX3RyaWdnZXJf
c2V0dXAoc3RydWN0IGFkaXMgKmFkaXMpDQo+ID4gK3sNCj4gPiArCWFkaXMtPnRyaWctPmRldi5w
YXJlbnQgPSAmYWRpcy0+c3BpLT5kZXY7DQo+ID4gKwlhZGlzLT50cmlnLT5vcHMgPSAmYWRpc190
cmlnZ2VyX29wczsNCj4gPiArCWlpb190cmlnZ2VyX3NldF9kcnZkYXRhKGFkaXMtPnRyaWcsIGFk
aXMpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAvKioNCj4gPiAgICogYWRpc19wcm9iZV90cmlnZ2Vy
KCkgLSBTZXRzIHVwIHRyaWdnZXIgZm9yIGEgYWRpcyBkZXZpY2UNCj4gPiAgICogQGFkaXM6IFRo
ZSBhZGlzIGRldmljZQ0KPiA+IEBAIC00NSw5ICs1Miw3IEBAIGludCBhZGlzX3Byb2JlX3RyaWdn
ZXIoc3RydWN0IGFkaXMgKmFkaXMsIHN0cnVjdA0KPiA+IGlpb19kZXYgKmluZGlvX2RldikNCj4g
PiAgCWlmIChhZGlzLT50cmlnID09IE5VTEwpDQo+ID4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4g
IA0KPiA+IC0JYWRpcy0+dHJpZy0+ZGV2LnBhcmVudCA9ICZhZGlzLT5zcGktPmRldjsNCj4gPiAt
CWFkaXMtPnRyaWctPm9wcyA9ICZhZGlzX3RyaWdnZXJfb3BzOw0KPiA+IC0JaWlvX3RyaWdnZXJf
c2V0X2RydmRhdGEoYWRpcy0+dHJpZywgYWRpcyk7DQo+ID4gKwlhZGlzX3RyaWdnZXJfc2V0dXAo
YWRpcyk7DQo+ID4gIA0KPiA+ICAJcmV0ID0gcmVxdWVzdF9pcnEoYWRpcy0+c3BpLT5pcnEsDQo+
ID4gIAkJCSAgJmlpb190cmlnZ2VyX2dlbmVyaWNfZGF0YV9yZHlfcG9sbCwNCj4gPiBAQCAtNzIs
NyArNzcsMzUgQEAgaW50IGFkaXNfcHJvYmVfdHJpZ2dlcihzdHJ1Y3QgYWRpcyAqYWRpcywgc3Ry
dWN0DQo+ID4gaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ICAJcmV0dXJuIHJldDsNCj4gPiAgfQ0K
PiA+ICBFWFBPUlRfU1lNQk9MX0dQTChhZGlzX3Byb2JlX3RyaWdnZXIpOw0KPiANCj4gQmxhbmsg
bGluZSBoZXJlIHdvdWxkIGhlbHAgYSB0aW55IGJpdCBvbiByZWFkYWJpbGl0eS4NCg0KR290IGl0
Li4uDQoNCj4gPiArLyoqDQo+ID4gKyAqIGRldm1fYWRpc19wcm9iZV90cmlnZ2VyKCkgLSBTZXRz
IHVwIHRyaWdnZXIgZm9yIGEgbWFuYWdlZCBhZGlzDQo+ID4gZGV2aWNlDQo+ID4gKyAqIEBhZGlz
OiBUaGUgYWRpcyBkZXZpY2UNCj4gPiArICogQGluZGlvX2RldjogVGhlIElJTyBkZXZpY2UNCj4g
PiArICoNCj4gPiArICogUmV0dXJucyAwIG9uIHN1Y2Nlc3Mgb3IgYSBuZWdhdGl2ZSBlcnJvciBj
b2RlDQo+ID4gKyAqLw0KPiA+ICtpbnQgZGV2bV9hZGlzX3Byb2JlX3RyaWdnZXIoc3RydWN0IGFk
aXMgKmFkaXMsIHN0cnVjdCBpaW9fZGV2DQo+ID4gKmluZGlvX2RldikNCj4gPiArew0KPiA+ICsJ
aW50IHJldDsNCj4gPiAgDQo+ID4gKwlhZGlzLT50cmlnID0gZGV2bV9paW9fdHJpZ2dlcl9hbGxv
YygmYWRpcy0+c3BpLT5kZXYsICIlcy0NCj4gPiBkZXYlZCIsDQo+ID4gKwkJCQkJICAgIGluZGlv
X2Rldi0+bmFtZSwgaW5kaW9fZGV2LQ0KPiA+ID5pZCk7DQo+ID4gKwlpZiAoIWFkaXMtPnRyaWcp
DQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsJYWRpc190cmlnZ2VyX3NldHVw
KGFkaXMpOw0KPiA+ICsNCj4gPiArCXJldCA9IGRldm1fcmVxdWVzdF9pcnEoJmFkaXMtPnNwaS0+
ZGV2LCBhZGlzLT5zcGktPmlycSwNCj4gPiArCQkJICAgICAgICZpaW9fdHJpZ2dlcl9nZW5lcmlj
X2RhdGFfcmR5X3BvbGwsDQo+ID4gKwkJCSAgICAgICBJUlFGX1RSSUdHRVJfUklTSU5HLA0KPiA+
ICsJCQkgICAgICAgaW5kaW9fZGV2LT5uYW1lLA0KPiA+ICsJCQkgICAgICAgYWRpcy0+dHJpZyk7
DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0dXJu
IGRldm1faWlvX3RyaWdnZXJfcmVnaXN0ZXIoJmFkaXMtPnNwaS0+ZGV2LCBhZGlzLT50cmlnKTsN
Cj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChkZXZtX2FkaXNfcHJvYmVfdHJpZ2dlcik7
DQo+ID4gIC8qKg0KPiA+ICAgKiBhZGlzX3JlbW92ZV90cmlnZ2VyKCkgLSBSZW1vdmUgdHJpZ2dl
ciBmb3IgYSBhZGlzIGRldmljZXMNCj4gPiAgICogQGFkaXM6IFRoZSBhZGlzIGRldmljZQ0KPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lpby9pbXUvYWRpcy5oDQo+ID4gYi9pbmNsdWRl
L2xpbnV4L2lpby9pbXUvYWRpcy5oDQo+ID4gaW5kZXggYWM3Y2ZkMDczODA0Li43NDE1MTJiMjhh
YWEgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9paW8vaW11L2FkaXMuaA0KPiA+ICsr
KyBiL2luY2x1ZGUvbGludXgvaWlvL2ltdS9hZGlzLmgNCj4gPiBAQCAtNDE5LDExICs0MTksMTUg
QEAgc3RydWN0IGFkaXNfYnVyc3Qgew0KPiA+ICAJdW5zaWduZWQgaW50CWV4dHJhX2xlbjsNCj4g
PiAgfTsNCj4gPiAgDQo+ID4gK2ludA0KPiA+ICtkZXZtX2FkaXNfc2V0dXBfYnVmZmVyX2FuZF90
cmlnZ2VyKHN0cnVjdCBhZGlzICphZGlzLCBzdHJ1Y3QNCj4gPiBpaW9fZGV2ICppbmRpb19kZXYs
DQo+ID4gKwkJCQkgICBpcnFyZXR1cm5fdCAoKnRyaWdnZXJfaGFuZGxlcikoaW50LA0KPiA+IHZv
aWQgKikpOw0KPiA+ICBpbnQgYWRpc19zZXR1cF9idWZmZXJfYW5kX3RyaWdnZXIoc3RydWN0IGFk
aXMgKmFkaXMsDQo+ID4gIAlzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LCBpcnFyZXR1cm5fdCAo
KnRyaWdnZXJfaGFuZGxlcikoaW50LA0KPiA+IHZvaWQgKikpOw0KPiA+ICB2b2lkIGFkaXNfY2xl
YW51cF9idWZmZXJfYW5kX3RyaWdnZXIoc3RydWN0IGFkaXMgKmFkaXMsDQo+ID4gIAlzdHJ1Y3Qg
aWlvX2RldiAqaW5kaW9fZGV2KTsNCj4gPiAgDQo+ID4gK2ludCBkZXZtX2FkaXNfcHJvYmVfdHJp
Z2dlcihzdHJ1Y3QgYWRpcyAqYWRpcywgc3RydWN0IGlpb19kZXYNCj4gPiAqaW5kaW9fZGV2KTsN
Cj4gPiAgaW50IGFkaXNfcHJvYmVfdHJpZ2dlcihzdHJ1Y3QgYWRpcyAqYWRpcywgc3RydWN0IGlp
b19kZXYNCj4gPiAqaW5kaW9fZGV2KTsNCj4gPiAgdm9pZCBhZGlzX3JlbW92ZV90cmlnZ2VyKHN0
cnVjdCBhZGlzICphZGlzKTsNCj4gPiAgDQo+ID4gQEAgLTQzMiw2ICs0MzYsMTMgQEAgaW50IGFk
aXNfdXBkYXRlX3NjYW5fbW9kZShzdHJ1Y3QgaWlvX2Rldg0KPiA+ICppbmRpb19kZXYsDQo+ID4g
IA0KPiA+ICAjZWxzZSAvKiBDT05GSUdfSUlPX0JVRkZFUiAqLw0KPiA+ICANCj4gPiArc3RhdGlj
IGlubGluZSBpbnQNCj4gPiArZGV2bV9hZGlzX3NldHVwX2J1ZmZlcl9hbmRfdHJpZ2dlcihzdHJ1
Y3QgYWRpcyAqYWRpcywgc3RydWN0DQo+ID4gaWlvX2RldiAqaW5kaW9fZGV2LA0KPiA+ICsJCQkJ
ICAgaXJxcmV0dXJuX3QgKCp0cmlnZ2VyX2hhbmRsZXIpKGludCwNCj4gPiB2b2lkICopKQ0KPiA+
ICt7DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGlubGluZSBp
bnQgYWRpc19zZXR1cF9idWZmZXJfYW5kX3RyaWdnZXIoc3RydWN0IGFkaXMgKmFkaXMsDQo+ID4g
IAlzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LCBpcnFyZXR1cm5fdCAoKnRyaWdnZXJfaGFuZGxl
cikoaW50LA0KPiA+IHZvaWQgKikpDQo+ID4gIHsNCj4gPiBAQCAtNDQzLDYgKzQ1NCwxMiBAQCBz
dGF0aWMgaW5saW5lIHZvaWQNCj4gPiBhZGlzX2NsZWFudXBfYnVmZmVyX2FuZF90cmlnZ2VyKHN0
cnVjdCBhZGlzICphZGlzLA0KPiA+ICB7DQo+ID4gIH0NCj4gPiAgDQo+ID4gK3N0YXRpYyBpbmxp
bmUgaW50IGRldm1fYWRpc19wcm9iZV90cmlnZ2VyKHN0cnVjdCBhZGlzICphZGlzLA0KPiA+ICsJ
CQkJCSAgc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gPiArew0KPiA+ICsJcmV0dXJuIDA7
DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBpbmxpbmUgaW50IGFkaXNfcHJvYmVfdHJpZ2dl
cihzdHJ1Y3QgYWRpcyAqYWRpcywNCj4gPiAgCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+
ID4gIHsNCg0K
