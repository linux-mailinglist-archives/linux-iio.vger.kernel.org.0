Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0347C1D4CF5
	for <lists+linux-iio@lfdr.de>; Fri, 15 May 2020 13:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgEOLsX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 May 2020 07:48:23 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:44792 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbgEOLsX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 May 2020 07:48:23 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04FBj86l018828;
        Fri, 15 May 2020 07:48:01 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0b-00128a01.pphosted.com with ESMTP id 3100xpsvtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 May 2020 07:48:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsPUB2h8QruKAPm9Vn1k2wrIsDHV2uVI6J58/AK9hQYWn9+Txy3T1xMECBWZpKUPG/VOSo1lls5tlFzFFxTKipZ7n7aoIQN+w/4jAEiLEKNeu1cj48sskYESnkxOHHjcBgsDWuFjKM64G1Prz7lTfLCyqinbFQo6nhNKAgd7Fik/JeuJ21sDvz3Tg844Ao6nbLnVr/rZ9Lb17w02UodqW4Z77RQlS7bC0J201JJ7yONHdQ0oOkh/LIYACaC2LNBVWrW4uddR3qcHbQ8fqV1DMYS6/VJ535rfZd4g281oacUQqNSIegL3pu8WuYHMBqcEQP+8F3vvUr4m3qO8b3souQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5PwNUE9meXfujqcIjeFhoh1QiIDwNYghIPcrcnDK8Y=;
 b=oGNUXVJdTCMY2U8zOZnIR5sZlY115D4seYQ339BUQaC2Dq7QBfyiGduzjOFvd2rzCZ0IsiHpFmXXrbgIu/3wylp/u/iP2VQ/jocsPJ0Ta0vqaL9RtYeaUG4DbqIJWtaLAgk2xJr2FWTp8Nz56eVeJ+UI4iVBKIfufSY26HcN31xHMAoCo9XOat/P30s0NBulrsUg2mGpIQJDYogRuSPkTcwvMnkWBuH/KQejq00vi3zSsTPZu52FzlEf+Fa++iP7nw/o5QoOnDcKt5Sswp7Gm6HYj9CIWGQA/fTCdU39J0SXP7XJnfumjaC/7u/Ge1hE4dGOlOKkl8fLz6+7IHXkmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5PwNUE9meXfujqcIjeFhoh1QiIDwNYghIPcrcnDK8Y=;
 b=mqMnvLzuvPesgcKwICKDrgG4gaRdPI0i4sF12k7Q4tBL1k4vBA4rvFYGK8sFGE5y2CrwSc6zSok9vCQmk0GwoZ/JLRpnMG+ktvQK8sPA/ot0SQo2/NE1hJ+y0mySf7AuStFFIDw2ZeV8MXiT/6zBiAtjM6ZOYAlfmrE45Q/lPFI=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4140.namprd03.prod.outlook.com (2603:10b6:5:5c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 15 May
 2020 11:48:00 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.2979.033; Fri, 15 May 2020
 11:48:00 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "ak@it-klinger.de" <ak@it-klinger.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 7/8] iio: core: simplify alloc alignment code
Thread-Topic: [PATCH v2 7/8] iio: core: simplify alloc alignment code
Thread-Index: AQHWKfIf2AOgR7laW0KzgAXiHIzwAaiovIwAgABM7IA=
Date:   Fri, 15 May 2020 11:47:59 +0000
Message-ID: <1d89df334b08486e73ca181cf9035d9af8fbccf2.camel@analog.com>
References: <20200514131710.84201-1-alexandru.ardelean@analog.com>
         <20200514131710.84201-8-alexandru.ardelean@analog.com>
         <BN6PR03MB33472A1B559F98E3BDCAB40B99BD0@BN6PR03MB3347.namprd03.prod.outlook.com>
In-Reply-To: <BN6PR03MB33472A1B559F98E3BDCAB40B99BD0@BN6PR03MB3347.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=analog.com;
x-originating-ip: [188.27.130.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 762a94be-8b55-48bd-2b9d-08d7f8c5d160
x-ms-traffictypediagnostic: DM6PR03MB4140:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB4140FAD07208F009E8CE6C44F9BD0@DM6PR03MB4140.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: icw/EXYXuuUlCedmnU+uya06Ar9LsYY4YNeGiioq3HWIFFCA4Zzu3Id/U1oMvbDULK+3G2o7pr69OPg7H7RfakuYp/HFM01Wa03U80j6WH5BP8f3boiP0EliVaEIrdg31Pc5vLBzGjfMDn7ymJWwVlDO2WtvSf0/Fvlew9z903DaaEsBcw300ycJamxGA/v1spu2bUJC5ybTZHwHDW5HeNw95EbSbtIuBVDY0EayEiaee6pxjtfDgHU31U47TV7jOWG33pdSACYlGeuIQYdeFBUMKAhki5oslFD8CqAhrTAwWOSZ6pUfBdNf+GkBVibZsCJLxqCvuLQlRooxFu1CciQcK5T2vyMVjwz+ePt+Z+M++IPe2qizUGnnmx7zWB369vrt5TId+yLLRM/vwLFmXJQqdfUyjO7HLOx1kwTgCVsjah+4oQFd3S7qbtEFbYu4KfYcTm22BShY2yYxYYXE6zwAAAQMEnFfBZKkzF+u9BDohk6lMJw4tuRD3PCoU2gLHnrivEPS17WRfWlQk9Ak8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(39860400002)(346002)(376002)(396003)(966005)(71200400001)(53546011)(54906003)(7416002)(36756003)(26005)(64756008)(66946007)(6506007)(4326008)(110136005)(66476007)(66556008)(91956017)(76116006)(186003)(66446008)(86362001)(6512007)(8936002)(2906002)(5660300002)(2616005)(8676002)(316002)(6486002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lTNpfEsWK07dTdoxaUNDgU5MXTFZ5mVsnNU3pzk4MAAYHG2GQHRRF9sRULYLgykhknw80NK8PjkTmTNZGERL8/m1+YqyKjlvztBfpMrAsdpJD/98L/W433Al/DMiFMTfsU0oJc0Ga+JrRaf31CsXi27vy+374rwCLW25fXLK8/JngECR/VZqxKtUJvEJSQUl5BPT7ZYAOBVQBLj4ISGNmxjztfqQGRzWt5azWXNQUaHG+Vw0Vj4+t8KWv8TCFltJayX1m2BOXTC8Gw50KYkdVU6J4+/x2Bx9WHAaC+60+P+3wStUwBnpm33BsaX//NyczoDtW7wT9qSAcus5i+cknXSAlAzsqZVvZuxSyLSkPEqr4bF5laPJm37A7GoJmSeIGyEMMu46m5VaZNXRqHdaWoRSWHJLuYbZHxdL1SXlr2+nrmUgT9YbJhx1dTkfv2Wqm1xdY/NYU8+UQ2ziTDvzT6gYt9/hDQmYRMuxzoysM0cDh6AJ/Qy2RBbhMKSCauR3
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF09CC5698AF824F93E461A5864C8C3D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762a94be-8b55-48bd-2b9d-08d7f8c5d160
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 11:47:59.9711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lytCTMUNGn08jyAW/2wNoSKPS8w57fYiSskF2Qf+S5cHhlESoCme+sHCddK41Q9G0N/Wbj8UE2h0Cghtl5OgrVlk6IA3c1Mxk35suliktZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4140
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-15_04:2020-05-15,2020-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005150102
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDIwLTA1LTE1IGF0IDA3OjEyICswMDAwLCBTYSwgTnVubyB3cm90ZToNCj4gSGV5
IEFsZXgsDQo+IA0KPiBKdXN0IGEgc21hbGwgcXVlc3Rpb24uLi4NCj4gDQo+ID4gRnJvbTogbGlu
dXgtaWlvLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtaWlvLW93bmVyQHZnZXIua2VybmVs
Lm9yZz4NCj4gPiBPbiBCZWhhbGYgT2YgQWxleGFuZHJ1IEFyZGVsZWFuDQo+ID4gU2VudDogRG9u
bmVyc3RhZywgMTQuIE1haSAyMDIwIDE1OjE3DQo+ID4gVG86IGxpbnV4LWlpb0B2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+ID4g
c3RtMzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbTsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiA+IENjOiBsdWRvdmljLmRlc3JvY2hlc0BtaWNyb2NoaXAuY29tOyBldWdlbi5o
cmlzdGV2QG1pY3JvY2hpcC5jb207DQo+ID4gamljMjNAa2VybmVsLm9yZzsgbmljb2xhcy5mZXJy
ZUBtaWNyb2NoaXAuY29tOw0KPiA+IGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tOyBhbGV4
YW5kcmUudG9yZ3VlQHN0LmNvbTsNCj4gPiBtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tOyBha0Bp
dC1rbGluZ2VyLmRlOyBBcmRlbGVhbiwgQWxleGFuZHJ1DQo+ID4gPGFsZXhhbmRydS5BcmRlbGVh
bkBhbmFsb2cuY29tPg0KPiA+IFN1YmplY3Q6IFtQQVRDSCB2MiA3LzhdIGlpbzogY29yZTogc2lt
cGxpZnkgYWxsb2MgYWxpZ25tZW50IGNvZGUNCj4gPiANCj4gPiBUaGVyZSB3YXMgYSByZWNlbnQg
ZGlzY3Vzc2lvbiBhYm91dCB0aGlzIGNvZGU6DQo+ID4gICBodHRwczovL3VybGRlZmVuc2UuY29t
L3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtDQo+ID4gaWlvLzIwMjAwMzIyMTY1
MzE3LjBiMWYwNjc0QGFyY2hsaW51eC9fXzshIUEzTmk4Q1MweTJZIXBnZFVTYXlKQ2Z4TWlFDQo+
ID4gdzhGcHYwTGtFWnVyQ1NrWDBzRWNMblhlRFNDTG1ocHUxeG9udDYtdkJRajNaYkN3JA0KPiA+
IA0KPiA+IFRoaXMgbG9va3MgbGlrZSBhIGdvb2QgdGltZSB0byByZXdvcmsgdGhpcywgc2luY2Ug
YW55IGlzc3VlcyBhYm91dCBpdA0KPiA+IHNob3VsZCBwb3AtdXAgdW5kZXIgdGVzdGluZywgYmVj
YXVzZSB0aGUgaWlvX2RldiBpcyBoYXZpbmcgYSBiaXQgb2YgYW4NCj4gPiBvdmVyaGF1bCBhbmQg
c3R1ZmYgYmVpbmcgbW92ZWQgdG8gaWlvX2Rldl9wcml2Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmMgfCAxMCArKystLS0t
LS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmMg
Yi9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tDQo+ID4gY29yZS5jDQo+ID4gaW5kZXggYTFiMjll
MGY4ZmQ2Li43NjcxZDM2ZWZhZTcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vaW5kdXN0
cmlhbGlvLWNvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmMN
Cj4gPiBAQCAtMTUxNCwxMyArMTUxNCw5IEBAIHN0cnVjdCBpaW9fZGV2ICppaW9fZGV2aWNlX2Fs
bG9jKGludCBzaXplb2ZfcHJpdikNCj4gPiAgCXN0cnVjdCBpaW9fZGV2ICpkZXY7DQo+ID4gIAlz
aXplX3QgYWxsb2Nfc2l6ZTsNCj4gPiANCj4gPiAtCWFsbG9jX3NpemUgPSBzaXplb2Yoc3RydWN0
IGlpb19kZXZfb3BhcXVlKTsNCj4gPiAtCWlmIChzaXplb2ZfcHJpdikgew0KPiA+IC0JCWFsbG9j
X3NpemUgPSBBTElHTihhbGxvY19zaXplLCBJSU9fQUxJR04pOw0KPiA+IC0JCWFsbG9jX3NpemUg
Kz0gc2l6ZW9mX3ByaXY7DQo+ID4gLQl9DQo+ID4gLQkvKiBlbnN1cmUgMzItYnl0ZSBhbGlnbm1l
bnQgb2Ygd2hvbGUgY29uc3RydWN0ID8gKi8NCj4gPiAtCWFsbG9jX3NpemUgKz0gSUlPX0FMSUdO
IC0gMTsNCj4gPiArCWFsbG9jX3NpemUgPSBBTElHTihzaXplb2Yoc3RydWN0IGlpb19kZXZfb3Bh
cXVlKSwgSUlPX0FMSUdOKTsNCj4gPiArCWlmIChzaXplb2ZfcHJpdikNCj4gPiArCQlhbGxvY19z
aXplICs9IEFMSUdOKHNpemVvZl9wcml2LCBJSU9fQUxJR04pOw0KPiANCj4gRG8gd2UgYWN0dWFs
bHkgbmVlZCB0byBkbyB0aGUgYEFMSUdOYCBhZ2Fpbj8gSXQgc2VlbXMgdG8gbWUgdGhhdCBgYWxs
b2Nfc2l6ZQ0KPiArPSBzaXplb2ZfcHJpdmANCj4gd291bGQgYmUgZW5vdWdoIG9yIGFtIEkgbWlz
c2luZyBzb21ldGhpbmcgb2J2aW91cz8NCg0KV2VsbCwgaXQncyBub3QgYWx3YXlzIGNsZWFyIHdo
YXQgdmFsdWUgJ3NpemVvZl9wcml2JyBoYXMsIGFuZCB3aGV0aGVyIGl0IGlzDQpwcm92aWRlZCBh
bHJlYWR5IGFsaWduZWQuDQpUaGUgcmVxdWlyZW1lbnQgaXMgdXN1YWxseSB0aGF0IHRoaXMgZGF0
YSBiZSBjYWNoZWxpbmUgYWxpZ25lZC4NCg0KU28sIHNpemVvZihzdHJ1Y3QgaWlvX2Rldl9vcGFx
dWUpIGlzIGFsaWduZWQgYWxyZWFkeSBhIGZldyBsaW5lcyBhYm92ZSwgYnV0IHRoZQ0KcHJpdmF0
ZSBpbmZvcm1hdGlvbiBzaG91bGQgYWxzbyBiZSBhbGlnbmVkIFtnaXZlbiB0aGF0IGl0J3MgYW4g
dW5rbm93biB2YWx1ZQ0KcHJvdmlkZWQgYnkgdGhlIGRyaXZlcl0uDQpJIHRoaW5rIHRoaXMgaXMg
bW9zdGx5IGltcG9ydGFudCwgaWYgd2UgbmVlZCB0byBkbyBETUEgYWNjZXNzIHRvIGJ1ZmZlcnMN
CmFsbG9jYXRlZCBvbiB0aGUgZHJpdmVyJ3Mgc3RhdGUtc3RydWN0LCB3aGljaCBpcyBhbGxvY2F0
ZWQgaGVyZSwgYW5kIHdoaWNoIGlzDQp1c3VhbGx5IHByb3ZpZGVkIGFzIHNpemVvZl9wcml2Lg0K
DQpUYmgsIHRoZSBkaXNjdXNzaW9ucyBhcm91bmQgdGhpcyBhbGlnbm1lbnQvY2FjaGVsaW5lLWFs
aWdubWVudCBhcmUgYSBiaXQgZnV6enkNCnRvIG1lLiBJIGhhdmVuJ3QgcnVuIGludG8gYW55IG9m
IHRoZXNlIGNvbXBsaWNhdGVkIGlzc3Vlcy4NCg0KPiANCj4gLSBOdW5vIFPDoQ0KPiANCg==
