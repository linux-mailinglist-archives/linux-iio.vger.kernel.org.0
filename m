Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F661796C1
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 18:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgCDRdK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 12:33:10 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9538 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729056AbgCDRdJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 12:33:09 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024HNNqg029077;
        Wed, 4 Mar 2020 12:32:49 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yfnraqc4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 12:32:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TE/G/uqAA2pwmlKsJ89g6QjVnH9AoJbKYwWwD8ZrYcWfeVf6WySKpWbSjxWyalCaGsBfBDDXAnEWdx61wYYouuN0D3qag52orkadTPQpVRpdSRRc0sx5UR2XMNGnQBHPSvCnmHsqXj+gTZ9cjmChGYU+mD5070vHsX7JI3TyKpV+JpFOUENhQPTXZul7jlNiflZVVDxvxR1QHF517novE/3CKtDw5kT9fQJDDgwdcML/vfFXQMmHQ0lfGypYXPyiy51eunsPh0qRvaO5jsVBXTD9V/O+bxWkqP/v2V9fPav8lonh3GfO22/tDRZpUAgefqjYIi2TpR85uPJpjF8RLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGUG3X08Erv0E3Ofr5Runm36vZWHqto+qLo6mj8PVak=;
 b=K6Uw2xRy9YeIMIBd8UlEjSKxHPgN2aGz+XgpEgnntwqZ4QxX1/0RvzfvslQUH9za1ZyvpjlV1zZXaG3xH3gXVp8AfSneSz1t4Vp5+ZFYAIINREBA905kaVMYPAuPk7yek6hFHWNl224D5GnRgGnF4a4HNATltytoXDo9DVmcjZbI5QpAGrdPSloVrCZ3vSUUvzf4rE2Prrh3moeWxFy5vLCYNSszR222c2cwR3y03NWv9lAERcNxvABD3ulq8uqFy4DW0V8H6TSVfGMm27f3xevlSbPULaMzUi+HcDuzh2jtkj9caLdF9P+E5SXg1gNE/r6hLhUiU9DqKMxZncSCgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGUG3X08Erv0E3Ofr5Runm36vZWHqto+qLo6mj8PVak=;
 b=gExTeYlAuR2/Q/Mk1Py3E5FhV9Ttdyo9zRbJWhAq/b2HOeizhB/MDMQ6bg0SFZ8k5zzMZVHwccW+lA0ZCahIKGsB1CIfBeDy8qCIrZ6OaEBGqZrqRVU02RuJLVUeyYoOD7+IzVmbIPOqf1xsA9Ttod2hrNbHX/tJ4kNUZH3klak=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2691.namprd03.prod.outlook.com (2603:10b6:404:5c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Wed, 4 Mar
 2020 17:32:47 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 17:32:47 +0000
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
Subject: Re: [PATCH 3/5] iio: adis: Add adis_update_bits() APIs
Thread-Topic: [PATCH 3/5] iio: adis: Add adis_update_bits() APIs
Thread-Index: AQHV69jonOAssmS6YUqxkE2cMLxCzKg3YnMAgAFb9IA=
Date:   Wed, 4 Mar 2020 17:32:47 +0000
Message-ID: <822e83174177922a316c027d2aa87acbe13096c7.camel@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
         <20200225124152.270914-4-nuno.sa@analog.com>
         <20200303204820.272d2235@archlinux>
In-Reply-To: <20200303204820.272d2235@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7ec54d6-0745-450c-a99f-08d7c0620e6b
x-ms-traffictypediagnostic: BN6PR03MB2691:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB2691F73A4945209363A778E499E50@BN6PR03MB2691.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(396003)(376002)(189003)(199004)(2906002)(2616005)(6512007)(6506007)(54906003)(26005)(6916009)(8936002)(186003)(6486002)(81156014)(81166006)(5660300002)(71200400001)(4326008)(64756008)(86362001)(8676002)(316002)(66476007)(478600001)(76116006)(36756003)(66946007)(66446008)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2691;H:BN6PR03MB3347.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K9k5gN+I8d4u2x9eA2ho2xZkJRHo+zfLGRquJPHAe8CG23TRuyn60YlO2Lj+HqsuvVTjtv0UvYBRLeKM0oLCyW/AlI1gMhTy77qJbk4ERnsjcl/EDxe1wBd1WV1q/1syPVfoMxARrH+d+uxpKjg9ZxIwGV2jhgizCR4AcnsbhxZD+7EJhlD6RhduXb3gPlmTxFOSqlClk2W1PYnyXGKCqaJ78LSMrMZtYguyoPbVqfy3DJbzcZc7c2y+Lw5n9IESZI2wsDKVdV4v0IUAPRj3C+uOWcmdz9eEEGNbwsylrkM66h+Qxx2KeDDtxFfm+wsvNRCpwqUtAoZbIFC0IvtqhQ5sHG1ErJSYBd+59uJYdCx5/SxWH6k4TBWQQyX6u1emvcZr76GFgkOt9hGqsGejOd5dRTD4skyt7hJe2F8MOuuFg1JX6Q+dIMboI8VI6UyC
x-ms-exchange-antispam-messagedata: lPA8vkAz+vhAv5WX8r77KImTnVaXEYvbnayf7Jp5KOWE37eO3bRJVQWT0UsFCa8cNHwHuv88u1d7YXjDcEylL6Q9gRbxkZu3dWdTvEa6Q89MOLbpWs+2TlBl5oagi8SMGlbvssobUbgbab53W3lJ6w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <083801CC4580524C9CC6DE610FC0BCD3@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ec54d6-0745-450c-a99f-08d7c0620e6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 17:32:47.5680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RfR/JHrzeW0epdgCBW6hXtK5axPD72qXw2vksuGg1mOf50P2ZqKgocJM3V5M1iVX11++c/+HMWOlbMXiCRCxug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2691
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_07:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTAzIGF0IDIwOjQ4ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUdWUsIDI1IEZlYiAyMDIwIDEzOjQxOjUwICswMTAwDQo+IE51bm8gU8OhIDxudW5v
LnNhQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBUaGlzIHBhdGNoIGFkZHMgYSBgcmVnbWFw
X3VwZGF0ZV9iaXRzKClgIGxpa2UgQVBJIHRvIHRoZSBBRElTDQo+ID4gbGlicmFyeS4NCj4gPiBJ
dCBwcm92aWRlcyBsb2NrZWQgYW5kIHVubG9ja2VkIHZhcmlhbnQuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gTW9zdGx5IGZpbmUsIGJ1
dCBJIHdvbmRlciBpZiB3ZSBjYW4gYXZvaWQgdGhlIG5lZWQgdG8gaGF2ZSBjb21tZW50cw0KPiBv
biBoYW5kbGluZyBvZiAxIGFuZCA4IGJ5dGUgdmFsdWVzIGJ5IGV4cGxpY2l0bHkgYXZvaWRpbmcg
dGhlbQ0KPiBoYXBwZW5pbmcuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBKb25hdGhhbg0KPiANCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9paW8vaW11L2FkaXMuYyAgICAgICB8IDI2ICsrKysrKysrKysr
KysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L2lpby9pbXUvYWRpcy5oIHwgNjENCj4gPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA4NyBp
bnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9hZGlz
LmMgYi9kcml2ZXJzL2lpby9pbXUvYWRpcy5jDQo+ID4gaW5kZXggYThhZmQwMWRlNGYzLi5mYTBl
ZTM1ZDk2ZjAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vaW11L2FkaXMuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzLmMNCj4gPiBAQCAtMjIzLDYgKzIyMywzMiBAQCBpbnQg
X19hZGlzX3JlYWRfcmVnKHN0cnVjdCBhZGlzICphZGlzLA0KPiA+IHVuc2lnbmVkIGludCByZWcs
DQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKF9fYWRp
c19yZWFkX3JlZyk7DQo+ID4gKy8qKg0KPiA+ICsgKiBfX2FkaXNfdXBkYXRlX2JpdHNfYmFzZSgp
IC0gQURJUyBVcGRhdGUgYml0cyBmdW5jdGlvbiAtDQo+ID4gVW5sb2NrZWQgdmVyc2lvbg0KPiA+
ICsgKiBAYWRpczogVGhlIGFkaXMgZGV2aWNlDQo+ID4gKyAqIEByZWc6IFRoZSBhZGRyZXNzIG9m
IHRoZSBsb3dlciBvZiB0aGUgdHdvIHJlZ2lzdGVycw0KPiA+ICsgKiBAbWFzazogQml0bWFzayB0
byBjaGFuZ2UNCj4gPiArICogQHZhbDogVmFsdWUgdG8gYmUgd3JpdHRlbg0KPiA+ICsgKiBAc2l6
ZTogU2l6ZSBvZiB0aGUgcmVnaXN0ZXIgdG8gdXBkYXRlDQo+ID4gKyAqDQo+ID4gKyAqIFVwZGF0
ZXMgdGhlIGRlc2lyZWQgYml0cyBvZiBAcmVnIGluIGFjY29yZGFuY2Ugd2l0aCBAbWFzayBhbmQN
Cj4gPiBAdmFsLg0KPiA+ICsgKi8NCj4gPiAraW50IF9fYWRpc191cGRhdGVfYml0c19iYXNlKHN0
cnVjdCBhZGlzICphZGlzLCB1bnNpZ25lZCBpbnQgcmVnLA0KPiA+IGNvbnN0IHUzMiBtYXNrLA0K
PiA+ICsJCQkgICAgY29uc3QgdTMyIHZhbCwgdTggc2l6ZSkNCj4gPiArew0KPiA+ICsJaW50IHJl
dDsNCj4gPiArCXUzMiBfX3ZhbDsNCj4gPiArDQo+ID4gKwlyZXQgPSBfX2FkaXNfcmVhZF9yZWco
YWRpcywgcmVnLCAmX192YWwsIHNpemUpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4g
cmV0Ow0KPiA+ICsNCj4gPiArCV9fdmFsICY9IH5tYXNrOw0KPiA+ICsJX192YWwgfD0gdmFsICYg
bWFzazsNCj4gPiArDQo+ID4gKwlyZXR1cm4gX19hZGlzX3dyaXRlX3JlZyhhZGlzLCByZWcsIF9f
dmFsLCBzaXplKTsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChfX2FkaXNfdXBkYXRl
X2JpdHNfYmFzZSk7DQo+ID4gIA0KPiA+ICAjaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQo+ID4gIA0K
PiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lpby9pbXUvYWRpcy5oDQo+ID4gYi9pbmNs
dWRlL2xpbnV4L2lpby9pbXUvYWRpcy5oDQo+ID4gaW5kZXggYjRjMzVkMTM3ZTJhLi4wNzA3M2Y2
OTg3MTggMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9paW8vaW11L2FkaXMuaA0KPiA+
ICsrKyBiL2luY2x1ZGUvbGludXgvaWlvL2ltdS9hZGlzLmgNCj4gPiBAQCAtMzAzLDYgKzMwMyw2
NyBAQCBzdGF0aWMgaW5saW5lIGludCBhZGlzX3JlYWRfcmVnXzMyKHN0cnVjdCBhZGlzDQo+ID4g
KmFkaXMsIHVuc2lnbmVkIGludCByZWcsDQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4g
IA0KPiA+ICtpbnQgX19hZGlzX3VwZGF0ZV9iaXRzX2Jhc2Uoc3RydWN0IGFkaXMgKmFkaXMsIHVu
c2lnbmVkIGludCByZWcsDQo+ID4gY29uc3QgdTMyIG1hc2ssDQo+ID4gKwkJCSAgICBjb25zdCB1
MzIgdmFsLCB1OCBzaXplKTsNCj4gPiArLyoqDQo+ID4gKyAqIGFkaXNfdXBkYXRlX2JpdHNfYmFz
ZSgpIC0gQURJUyBVcGRhdGUgYml0cyBmdW5jdGlvbiAtIExvY2tlZA0KPiA+IHZlcnNpb24NCj4g
PiArICogQGFkaXM6IFRoZSBhZGlzIGRldmljZQ0KPiA+ICsgKiBAcmVnOiBUaGUgYWRkcmVzcyBv
ZiB0aGUgbG93ZXIgb2YgdGhlIHR3byByZWdpc3RlcnMNCj4gPiArICogQG1hc2s6IEJpdG1hc2sg
dG8gY2hhbmdlDQo+ID4gKyAqIEB2YWw6IFZhbHVlIHRvIGJlIHdyaXR0ZW4NCj4gPiArICogQHNp
emU6IFNpemUgb2YgdGhlIHJlZ2lzdGVyIHRvIHVwZGF0ZQ0KPiA+ICsgKg0KPiA+ICsgKiBVcGRh
dGVzIHRoZSBkZXNpcmVkIGJpdHMgb2YgQHJlZyBpbiBhY2NvcmRhbmNlIHdpdGggQG1hc2sgYW5k
DQo+ID4gQHZhbC4NCj4gPiArICovDQo+ID4gK3N0YXRpYyBpbmxpbmUgaW50IGFkaXNfdXBkYXRl
X2JpdHNfYmFzZShzdHJ1Y3QgYWRpcyAqYWRpcywNCj4gPiB1bnNpZ25lZCBpbnQgcmVnLA0KPiA+
ICsJCQkJCWNvbnN0IHUzMiBtYXNrLCBjb25zdCB1MzIgdmFsLA0KPiA+IHU4IHNpemUpDQo+ID4g
K3sNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJbXV0ZXhfbG9jaygmYWRpcy0+c3RhdGVf
bG9jayk7DQo+ID4gKwlyZXQgPSBfX2FkaXNfdXBkYXRlX2JpdHNfYmFzZShhZGlzLCByZWcsIG1h
c2ssIHZhbCwgc2l6ZSk7DQo+ID4gKwltdXRleF91bmxvY2soJmFkaXMtPnN0YXRlX2xvY2spOw0K
PiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIGFkaXNf
dXBkYXRlX2JpdHMoKSAtIFdyYXBwZXIgbWFjcm8gZm9yIGFkaXNfdXBkYXRlX2JpdHNfYmFzZSAt
DQo+ID4gTG9ja2VkIHZlcnNpb24NCj4gPiArICogQGFkaXM6IFRoZSBhZGlzIGRldmljZQ0KPiA+
ICsgKiBAcmVnOiBUaGUgYWRkcmVzcyBvZiB0aGUgbG93ZXIgb2YgdGhlIHR3byByZWdpc3RlcnMN
Cj4gPiArICogQG1hc2s6IEJpdG1hc2sgdG8gY2hhbmdlDQo+ID4gKyAqIEB2YWw6IFZhbHVlIHRv
IGJlIHdyaXR0ZW4NCj4gPiArICoNCj4gPiArICogVGhpcyBtYWNybyBldmFsdWF0ZXMgdGhlIHNp
emVvZiBvZiBAdmFsIGF0IGNvbXBpbGUgdGltZSBhbmQNCj4gPiBjYWxscw0KPiA+ICsgKiBhZGlz
X3VwZGF0ZV9iaXRzX2Jhc2UoKSBhY2NvcmRpbmdseS4gQmUgYXdhcmUgdGhhdCB1c2luZw0KPiA+
IE1BQ1JPUy9ERUZJTkVTIGZvcg0KPiA+ICsgKiBAdmFsIGNhbiBsZWFkIHRvIHVuZGVzaXJlZCBi
ZWhhdmlvciBpZiB0aGUgcmVnaXN0ZXIgdG8gdXBkYXRlDQo+ID4gaXMgMTZiaXQuIEFsc28NCj4g
PiArICogbm90ZSB0aGF0IGEgNjRiaXQgdmFsdWUgd2lsbCBiZSB0cmVhdGVkIGFzIGFuIGludGVn
ZXIuIEluIHRoZQ0KPiA+IHNhbWUgd2F5LA0KPiA+ICsgKiBhIGNoYXIgaXMgc2VlbiBhcyBhIHNo
b3J0Lg0KPiANCj4gQXJlIHRoZXNlICdlZGdlJyBjb25kaXRpb25zIGRlc2lyYWJsZT8gIElmIG5v
dCBjYW4gd2UgdXNlIHRoZSBjb21waWxlDQo+IHRpbWUgY2hlY2tpbmcgdHJpY2tzIHRvIHRyaWdn
ZXIgYSBidWlsZCBmYWlsdXJlIGlmIHRoZXkgb2NjdXI/DQo+IEJVSUxEX0JVR19PTihzaXplb2Yo
dmFsKSA9PSAxKSBldGMuDQoNClNvLCBJIGd1ZXNzIHRoZXJlJ3Mgbm8gYXJtIGluIHRoZSAnZWRn
ZScgY29uZGl0aW9ucyBpZiB1c2VycyBrbm93IHdoYXQNCnRoZXkgYXJlIGRvaW5nIDopLiBCdXQg
SSBoYXZlIG5vIHByb2JsZW1zIGluIG1ha2luZy9mb3JjaW5nIHRoZSByaWdodA0KdHlwZXMgYnkg
YWRkaW5nIHRoZSBjb21waWxlIHRpbWUgY2hlY2tzLi4uDQoNCldpbGwgYWRkIGl0IGluIHYyDQoN
Ci0gTnVubyBTw6ENCj4gPiArICovDQo+ID4gKyNkZWZpbmUgYWRpc191cGRhdGVfYml0cyhhZGlz
LCByZWcsIG1hc2ssIHZhbCkgKHsJCQkNCj4gPiBcDQo+ID4gKwlfX2J1aWx0aW5fY2hvb3NlX2V4
cHIoc2l6ZW9mKHZhbCkgPT0gOCB8fCBzaXplb2YodmFsKSA9PSA0LAlcDQo+ID4gKwkJYWRpc191
cGRhdGVfYml0c19iYXNlKGFkaXMsIHJlZywgbWFzaywgdmFsLA0KPiA+IDQpLCAgICAgICAgIFwN
Cj4gPiArCQlhZGlzX3VwZGF0ZV9iaXRzX2Jhc2UoYWRpcywgcmVnLCBtYXNrLCB2YWwsIDIpKTsJ
XA0KPiA+ICt9KQ0KPiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIGFkaXNfdXBkYXRlX2JpdHMoKSAt
IFdyYXBwZXIgbWFjcm8gZm9yIGFkaXNfdXBkYXRlX2JpdHNfYmFzZQ0KPiA+ICsgKiBAYWRpczog
VGhlIGFkaXMgZGV2aWNlDQo+ID4gKyAqIEByZWc6IFRoZSBhZGRyZXNzIG9mIHRoZSBsb3dlciBv
ZiB0aGUgdHdvIHJlZ2lzdGVycw0KPiA+ICsgKiBAbWFzazogQml0bWFzayB0byBjaGFuZ2UNCj4g
PiArICogQHZhbDogVmFsdWUgdG8gYmUgd3JpdHRlbg0KPiA+ICsgKg0KPiA+ICsgKiBUaGlzIG1h
Y3JvIGV2YWx1YXRlcyB0aGUgc2l6ZW9mIG9mIEB2YWwgYXQgY29tcGlsZSB0aW1lIGFuZA0KPiA+
IGNhbGxzDQo+ID4gKyAqIGFkaXNfdXBkYXRlX2JpdHNfYmFzZSgpIGFjY29yZGluZ2x5LiBCZSBh
d2FyZSB0aGF0IHVzaW5nDQo+ID4gTUFDUk9TL0RFRklORVMgZm9yDQo+ID4gKyAqIEB2YWwgY2Fu
IGxlYWQgdG8gdW5kZXNpcmVkIGJlaGF2aW9yIGlmIHRoZSByZWdpc3RlciB0byB1cGRhdGUNCj4g
PiBpcyAxNmJpdC4gQWxzbw0KPiA+ICsgKiBub3RlIHRoYXQgYSA2NGJpdCB2YWx1ZSB3aWxsIGJl
IHRyZWF0ZWQgYXMgYW4gaW50ZWdlci4gSW4gdGhlDQo+ID4gc2FtZSB3YXksDQo+ID4gKyAqIGEg
Y2hhciBpcyBzZWVuIGFzIGEgc2hvcnQuDQo+ID4gKyAqLw0KPiA+ICsjZGVmaW5lIF9fYWRpc191
cGRhdGVfYml0cyhhZGlzLCByZWcsIG1hc2ssIHZhbCkgKHsJCQ0KPiA+IAlcDQo+ID4gKwlfX2J1
aWx0aW5fY2hvb3NlX2V4cHIoc2l6ZW9mKHZhbCkgPT0gOCB8fCBzaXplb2YodmFsKSA9PSA0LAlc
DQo+ID4gKwkJX19hZGlzX3VwZGF0ZV9iaXRzX2Jhc2UoYWRpcywgcmVnLCBtYXNrLCB2YWwsIDQp
LAlcDQo+ID4gKwkJX19hZGlzX3VwZGF0ZV9iaXRzX2Jhc2UoYWRpcywgcmVnLCBtYXNrLCB2YWws
IDIpKTsJXA0KPiA+ICt9KQ0KPiA+ICsNCj4gPiAgaW50IGFkaXNfZW5hYmxlX2lycShzdHJ1Y3Qg
YWRpcyAqYWRpcywgYm9vbCBlbmFibGUpOw0KPiA+ICBpbnQgX19hZGlzX2NoZWNrX3N0YXR1cyhz
dHJ1Y3QgYWRpcyAqYWRpcyk7DQo+ID4gIGludCBfX2FkaXNfaW5pdGlhbF9zdGFydHVwKHN0cnVj
dCBhZGlzICphZGlzKTsNCg==
