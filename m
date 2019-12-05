Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B29113CF3
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2019 09:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfLEIUT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Dec 2019 03:20:19 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:46932 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbfLEIUS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Dec 2019 03:20:18 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB58Hwp0011328;
        Thu, 5 Dec 2019 03:19:55 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wkk57wrh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 03:19:55 -0500
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xB58JsmR029185;
        Thu, 5 Dec 2019 03:19:54 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wkk57wrh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 03:19:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADpjdZc9esQ44OEROWKi6KnYgfzMssi3aEYuNQ9SC5W6L3vMSDNIrDlHVnqHZnyW+XhOfS35eeanVrF91LW+7bpOwEwM2uaiHm3MJ4VJTujEww2BN2xuBoB5kcT9BU5lmb4TjTEVvn5epKMHDCTo1hGcMUwW72mB3pFsVaGV2mRcPp6rL/l8HN4Dfg4YOMkEyzZOtbAtQsNQaffuEKawvULNJf+dnVzW9IyKIFQASOlVuBIzOUjz0gi2BN0yi7wuHWZKA/c6SVSYxzIir8iD8MJKoPRSh61xDdrgsQ4Fxg4CPvAUNtKUxaoH6dPOkxPx+KDYcdX9h0kbIIkv4+SHKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yxec49Q2LdJO1PRPo7gSsiKsO737aYLUHwvNgU7/mJU=;
 b=KK0E1BnPibLSb2E3DmtwEGopiwNwhX88Y17hi8CHPuaT7NFVUerVyF11r3lhE/rCVJKby+knUQddBCqzR7tnLEkuW/do2XeGwoYJdRbrBoh8hTB71+IEWoa48e8cpG5uPpIGuwFcukQPjFX2fo0Wh3JSMuDgyPbP9gwb7lx7xmDS2Zhe/2K4Px0VD8JBMZOq+Nh6lAz7wD86ymvXOC9CrQ/Ux6TIcOAk69r74yQDdP0PhEmyImJUOw56HpJySYn5uKj9RaTPeqm5kGdcWkMJwHskG71/3MGsMbLJGV5Goru9bL73/nOAdxSFV3gkE/EdTSga5w4xCIzd5pZ45S9szA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yxec49Q2LdJO1PRPo7gSsiKsO737aYLUHwvNgU7/mJU=;
 b=EtF20CWMN4I4DydrVQriHJj4yd8slJPjrR58y1Twm3QixQIcki/BbF6P6n3rfSaYY2T7yuiiN8FDcNL3wnz6j94DVFqO9fo4hz5Hy7ExjBlpgPFYQOKHu548/DFylHXbe2b0LvKVBamfCNj4pymRxYR+TV5a29hbxY3BAwaA5ik=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5333.namprd03.prod.outlook.com (20.180.5.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 08:19:52 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 08:19:52 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] dt-bindings: iio: accel: add binding documentation for
 ADIS16240
Thread-Topic: [PATCH v4] dt-bindings: iio: accel: add binding documentation
 for ADIS16240
Thread-Index: AQHVob2/Uuv8Me0otU+pOQKTkzIOdqeYolyAgALkwgCACa2sAIADeAIAgAADpwCAAPJnAIAAoneAgAEAu4A=
Date:   Thu, 5 Dec 2019 08:19:52 +0000
Message-ID: <6935c2fcc2fa01f25a62299dc52a00e2a08255ce.camel@analog.com>
References: <20191123051927.5016-1-rodrigorsdc@gmail.com>
         <20191123114119.7b0c3447@archlinux>
         <a55b9c576eded8c91a985aabbba89180561ab156.camel@analog.com>
         <20191201114032.1a972dda@archlinux> <20191203163850.GN1998@sirena.org.uk>
         <20191203165154.00005793@Huawei.com>
         <c725b1b1475148ded6168667fa0227bc18de0854.camel@analog.com>
         <20191204170059.GX1998@sirena.org.uk>
In-Reply-To: <20191204170059.GX1998@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 252ae1d3-fe9c-4561-421f-08d7795be778
x-ms-traffictypediagnostic: CH2PR03MB5333:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB533388A9B50BE09707D40F5CF95C0@CH2PR03MB5333.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(186003)(2501003)(6486002)(4326008)(6436002)(76176011)(36756003)(102836004)(99286004)(3846002)(6116002)(6512007)(6506007)(118296001)(5640700003)(66446008)(64756008)(66556008)(66476007)(66946007)(7736002)(2616005)(11346002)(229853002)(305945005)(26005)(5660300002)(71200400001)(71190400001)(76116006)(14454004)(86362001)(7416002)(316002)(2906002)(478600001)(54906003)(8936002)(6916009)(81156014)(1730700003)(81166006)(8676002)(2351001)(25786009)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5333;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7HVwrh3Jet3h28AZInfM/TtahRKUBk7HD4dnRi6KV6Si2x1fAqanmnsdz0vHmuiszZwiu8tdb49WxliPghFunuHv3FMOeFbn/Iyc9jfBbAPuzzgLD+zFLBjWc8Wq7Xp4hAF2wDOHPn9O4nH7Lyu7cMkjhxDv0ss8jkTrAU1nnx5VMSNb4KXfbQbzODIZ48H4P6lk3LbJFWwAkv/4oZ6bJZjCjstdxZPyY3aZOTyXpIBsuk39dOuxFmhhtWJmB4wz0DiV5DW2fqycCYalVLB5jTVSXfrupPybuU4p9KVMkt361RFLC9HSlolSQt/Vb2Y7WW+TUtwjvGEpJZC4LJzd+Nt+YcrT5oerTpwg2hMezmA+mHshGw1ueKqkK2D4yXy+0ZU42WED8+XihLeMFx3PoI2XSEuQNSrmhEuHi6bc9VFKlcnDJzzN0AbUhu7yNFvb
Content-Type: text/plain; charset="utf-8"
Content-ID: <481127A63CB8E440A96ADDFA515CB197@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252ae1d3-fe9c-4561-421f-08d7795be778
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 08:19:52.7582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b7811QtN+loW0a0wNiAM07x3RSHS0PflpqRLyRj+RGuKD0lHOe9bVOGJ0kHxw+JN9r0PughgW6zZm00yfXnx+xq3k/8uC7U31oJk0MLuFOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5333
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_01:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912050067
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTEyLTA0IGF0IDE3OjAwICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBXZWQsIERlYyAwNCwgMjAxOSBhdCAwNzoxODoxNUFNICswMDAwLCBBcmRlbGVhbiwgQWxleGFu
ZHJ1IHdyb3RlOg0KPiANCj4gPiBPbmUgZXhhbXBsZSAoZm9yIHNwaS1jcGhhKToNCj4gPiAgICAg
ICAgIGlmIChvZl9wcm9wZXJ0eV9yZWFkX3UzMihuYywgInNwaS1jcGhhIiwgJnRtcCkgPT0gMCkg
ew0KPiA+ICAgICAgICAgICAgICAgICBzcGktPm1vZGUgfD0gU1BJX0NQSEFfT1ZFUlJJREU7DQo+
ID4gICAgICAgICAgICAgICAgIGlmICh0bXApDQo+ID4gICAgICAgICAgICAgICAgICAgICBzcGkt
Pm1vZGUgfD0gU1BJX0NQSEE7DQo+IA0KPiBXZSBjb3VsZCBhbHNvIGRvIHRoaXMgd2l0aCBhIHNl
cGFyYXRlIGZsYWcgc2F5aW5nIHRoYXQgdGhlIHdpcmUNCj4gZm9ybWF0IGlzIGZvcmNlZCBmcm9t
IERUIHJhdGhlciB0aGFuIGhhdmluZyBvbmUgcGVyIHNldHRpbmcuDQo+IA0KDQpJIHdpbGwgYWRt
aXQgdGhhdCBbc2luY2UgeW91IHNlZW0gdG8gaW5jbGluZSB0b3dhcmRzIHRoaXMgYXBwcm9hY2hd
LCBJIGFtDQphbHNvIGluY2xpbmVkIHRvIGNvbnNpZGVyIGl0IG92ZXIgdGhlIHNwaS1tb2RlLWNv
bnYgZHJpdmVyLg0KQW5kIGFsc28gc2luY2UgeW91J3JlIHNheWluZyB0aGF0IHRoZSBkcml2ZXIg
d291bGQgYmUgaGFyZGVyIHRvIGFjaGlldmUuDQoNCkknbGwgc2VlIGFib3V0IGFuIGltcGxlbWVu
dGF0aW9uIGZvciB0aGlzIGZsYWcgYW5kIGNvbWUgYmFjayBmb3IgYSByZXZpZXcNCltvbiBpdF0u
DQpbVW50aWwgdGhlbl0gSSBhbHNvIG93ZSB5b3Ugc29tZSBtb3JlICJkZWxheV91c2VjcyIgY2xl
YW51cCBpbiBvdGhlcg0Kc3Vic3lzdGVtcy4NCg0KVGhhbmtzDQpBbGV4DQoNCj4gPiBPciBtYXli
ZSwgYSBtb3JlIGNvbXBsZXRlIHNvbHV0aW9uIHdvdWxkIGJlIGFuICJzcGktbW9kZS1jb252IiBk
cml2ZXIuDQo+ID4gU2ltaWxhciB0byB0aGUgZml4ZWQtZmFjdG9yLWNsb2NrIGNsayBkcml2ZXIs
IHdoaWNoIGp1c3QgZG9lcyBhDQo+ID4gY29tcHV0YXRpb24NCj4gPiBiYXNlZCBvbiB2YWx1ZXMg
ZnJvbSB0aGUgRFQuDQo+ID4gVG8gdGVsbCB0aGUgdHJ1dGgsIHRoaXMgd291bGQgYmUgYSBncmVh
dCBpZGVhLCBiZWNhdXNlIHdlIGhhdmUNCj4gPiBzb21ldGhpbmcNCj4gPiBsaWtlIGEgcGFzc2l2
ZSAzLXdpcmUtdG8tNC13aXJlIEhETCBjb252ZXJ0ZXIuIFRoaXMgcmVxdWlyZXMgdGhhdCB0aGUN
Cj4gPiBkcml2ZXIgYmUgY29uZmlndXJlZCBpbiAzLXdpcmUgbW9kZSwgdGhlIFNQSSBjb250cm9s
bGVyIGluIG5vcm1hbCA0LQ0KPiA+IHdpcmUuDQo+ID4gVGhhdCdzIGJlY2F1c2UgdGhlIFNQSSBm
cmFtZXdvcmsgZG9lcyBhIHZhbGlkYXRpb24gb2YgdGhlIHN1cHBvcnRlZA0KPiA+IG1vZGVzDQo+
ID4gKGZvciB0aGUgU1BJIGNvbnRyb2xsZXIpIGFuZCBpbnZhbGlkYXRlcyB3aGF0IHRoZSBkZXZp
Y2Ugd2FudHMgKHdoaWNoDQo+ID4gaXMNCj4gPiB2ZXJ5IHJlYXNvbmFibGUpLg0KPiANCj4gVGhp
cyBpcyBoYXJkZXIgdG8gYWNoaWV2ZSBoZXJlIGJlY2F1c2Ugd2UgZG9uJ3QgaGF2ZSBkcml2ZXJz
IGZvcg0KPiByYW5kb20gYml0cyBvZiB0aGUgd2lyZSBmb3JtYXQuLi4NCg==
