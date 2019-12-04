Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1490611238D
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2019 08:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfLDHZz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Dec 2019 02:25:55 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:44820 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbfLDHZy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Dec 2019 02:25:54 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB47NTh0023220;
        Wed, 4 Dec 2019 02:25:33 -0500
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2056.outbound.protection.outlook.com [104.47.44.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wkk2c31rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 02:25:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXpfZM3gsqGiimiR3CTwNxy8rmYXa1ZlKIFMP19zs4CSvVnk39a3qh66CPewTtFqpFmB+LypmfUflolhGw4a1uf+prD8IQbJX3BKswJNURTsTKfTmfh87NoSSals1huypShuq2xN2eh63ekwyNq4UiOxNaVUFYbSu1cwUeBlwI63Gar40WExpKobCYVcq2H6lddP6xfNpOOfuzgPcaPdozK8l0rAuGcbX2XYl+HQYqotDUtrg/BP6GipaBGnJtcUElQAzFmAN18Md4OKxMmuD+9c/NGHQu2CNIwj9Tr+8NjHRZcaXeuDeQFDdZ7XEad0TZW4T+N8Nzes116BiuYhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exUdhg2zD9skF6/FuWi4Mfa1i2sbOmEoRK4K54U6IUM=;
 b=bO4NHE3fTPhAb8mWj/mwkkKRGgVechXhPjrozZEK4us0ZF0MfR8mcn0lZclB4cN2FFQNl8hCcK1p9Oi1Iq3LgP5XIW+hP9AuTuBmupXMFlxfnQ3Sa1I71amstGhk9XTTPjjlMKSL0dD5nQSMEnywEF7ACEnCUmer+AQincGpAhS5huqyY2bvlp4+LhRJpL0V2FuNQYnIChfyqllpWR0J0tP2/PTq5/oeR7wyvjIJRMf9Fdy234BPwbw0aVLrcidt9jc1VHiB9GGnlLa8nLnmnrGnXa/qEdsqYuhAU61re69S8TlIeqZfhMruUDPlaeuq3SYZcIquGZQ+CQyr12dblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exUdhg2zD9skF6/FuWi4Mfa1i2sbOmEoRK4K54U6IUM=;
 b=EA2AeJBIVIFP+BsjBHDyv/Fh3bXID9T6or6qX90rcy54IUd1NSDXI7I/yihgp2kVxf6R56cGII/9ZA8eS+ckWB5kahPjif0kITM3rMbJ/VhzJLoGl4IPZbZ+mkub8rmq512xca2GhpFtjUizlTNTtRWfVGXCYTFyJJ2ZsU286As=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5366.namprd03.prod.outlook.com (20.180.14.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 4 Dec 2019 07:25:29 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 07:25:29 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] staging: iio: accel: adis16240: enforce SPI mode
 on probe function
Thread-Topic: [PATCH v5 1/2] staging: iio: accel: adis16240: enforce SPI mode
 on probe function
Thread-Index: AQHVola+Yj8hDk7DMESHXfIfRLi/aKebhxQAgAms/ACABG+eAA==
Date:   Wed, 4 Dec 2019 07:25:29 +0000
Message-ID: <5c7c584cd02f9960600b321a4561406440175873.camel@analog.com>
References: <20191123233510.4890-1-rodrigorsdc@gmail.com>
         <2e62b4fa3ee93909bfcdc4d9b60015e7c22d510c.camel@analog.com>
         <20191201114212.08a068fc@archlinux>
In-Reply-To: <20191201114212.08a068fc@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bfc6bb4c-bd8a-4e54-ed68-08d7788b2402
x-ms-traffictypediagnostic: CH2PR03MB5366:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB536625C0CD91BEEFB27216DBF95D0@CH2PR03MB5366.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(366004)(199004)(189003)(66946007)(5660300002)(54906003)(2616005)(5640700003)(7416002)(316002)(446003)(11346002)(229853002)(81156014)(81166006)(76116006)(66556008)(6486002)(99286004)(66446008)(25786009)(64756008)(8936002)(8676002)(66476007)(91956017)(2906002)(6116002)(3846002)(6246003)(71200400001)(14454004)(4326008)(6916009)(6512007)(36756003)(478600001)(256004)(2351001)(7736002)(4001150100001)(14444005)(305945005)(6506007)(6436002)(118296001)(26005)(102836004)(76176011)(186003)(86362001)(2501003)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5366;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FTVP2EuG28D56ikYsXnhTVFK7AXTLQtWOVMSolDpOWU2zA/b9eC0mvHSUf7rm5iNL1gkANxAko4FpkdU1OgVkQqFMj1E/eMH6FE7zlP77lQk6iMd7jYa9bCkpY5//7bvmhLxnJ8ufA3kQbs1IGiOtt5pJDHWniSKp0TBA8rZk9Uv+MwxqHqT5A2WOaNp5Y9QpqOpxWrU6u5QQDqhN7+LcZhjoZihJY5EobzEk6q2johMvJhnW5g94VjRfcp3tQRVxs+XRLII9dA//QuIrLDBZ4pKnsnw8JB3p5qiImMlhIC9re2txnDeZBev/+x0XJqd7vc/7i2d0RcxTLFVFmaD4hrluuJz/Mhq6vkEuzfdnOgbmZ+E7kdopCaEQ834bRm+bQGizWyEez5hxxTa3lrz0xsvGG5JUPvCsxyWG29EN7Qdc/rtgAYDf67dzyWPPLBB
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0EDAE27E6392F438AB233E748E079C4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc6bb4c-bd8a-4e54-ed68-08d7788b2402
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 07:25:29.4480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6FQ5OIsxkaJWzffBCd7Tid/gx25Y4YaH5uAGjbfAUlvpmlBKQMH5rCYq8WXnCz3ISIcmD731SwQRZLRc3zk5vxckCaV11bRkGmmYLH7g9+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5366
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_01:2019-12-04,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040055
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEyLTAxIGF0IDExOjQyICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBNb24sIDI1IE5vdiAyMDE5IDA3OjU1OjM5ICswMDAw
DQo+ICJBcmRlbGVhbiwgQWxleGFuZHJ1IiA8YWxleGFuZHJ1LkFyZGVsZWFuQGFuYWxvZy5jb20+
IHdyb3RlOg0KPiANCj4gPiBPbiBTYXQsIDIwMTktMTEtMjMgYXQgMjA6MzUgLTAzMDAsIFJvZHJp
Z28gQ2FydmFsaG8gd3JvdGU6DQo+ID4gPiBbRXh0ZXJuYWxdDQo+ID4gPiANCj4gPiA+IEFjY29y
ZGluZyB0byB0aGUgZGF0YXNoZWV0LCB0aGlzIGRyaXZlciBzdXBwb3J0cyBvbmx5IFNQSSBtb2Rl
IDMsDQo+ID4gPiBzbyB3ZSBzaG91bGQgZW5mb3JjZSBpdCBhbmQgY2FsbCBzcGlfc2V0dXAoKSBv
biBwcm9iZSBmdW5jdGlvbi4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUm9kcmlnbyBS
aWJlaXJvIENhcnZhbGhvIDxyb2RyaWdvcnNkY0BnbWFpbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+
IFY1Og0KPiA+ID4gICAtIEFkZCB0aGlzIHBhdGNoIHRvIHRoZSBwYXRjaHNldA0KPiA+ID4gDQo+
ID4gPiAgZHJpdmVycy9zdGFnaW5nL2lpby9hY2NlbC9hZGlzMTYyNDAuYyB8IDcgKysrKysrKw0K
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9paW8vYWNjZWwvYWRpczE2MjQwLmMNCj4gPiA+IGIv
ZHJpdmVycy9zdGFnaW5nL2lpby9hY2NlbC9hZGlzMTYyNDAuYw0KPiA+ID4gaW5kZXggODIwOTlk
YjRiZjBjLi43N2I2YjgxNzY3YjkgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcv
aWlvL2FjY2VsL2FkaXMxNjI0MC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2Fj
Y2VsL2FkaXMxNjI0MC5jDQo+ID4gPiBAQCAtNDAwLDYgKzQwMCwxMyBAQCBzdGF0aWMgaW50IGFk
aXMxNjI0MF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZQ0KPiA+ID4gKnNwaSkNCj4gPiA+ICAJaW5k
aW9fZGV2LT5udW1fY2hhbm5lbHMgPSBBUlJBWV9TSVpFKGFkaXMxNjI0MF9jaGFubmVscyk7DQo+
ID4gPiAgCWluZGlvX2Rldi0+bW9kZXMgPSBJTkRJT19ESVJFQ1RfTU9ERTsNCj4gPiA+ICANCj4g
PiA+ICsJc3BpLT5tb2RlID0gU1BJX01PREVfMzsgIA0KPiA+IA0KPiA+IEEgZ2VuZXJpYyBxdWVz
dGlvbiBmcm9tIG1lIGhlcmUsIHNpbmNlIEkgYW0gbm90IHN1cmUuDQo+ID4gDQo+ID4gV291bGQg
dGhpcyBsaW1pdCB0aGUgY29uZmlndXJhdGlvbnMgb2YgdGhpcyBjaGlwIG9uIHRoZSBib2FyZD8N
Cj4gPiBJbiBjYXNlIHRoZXJlIGlzIHNvbWUgbGV2ZWwtaW52ZXJ0ZXIgW2ZvciB2YXJpb3VzIHdl
aXJkIHJlYXNvbnNdIG9uIHRoZQ0KPiA+IGJvYXJkLCB0aGlzIG1heSBub3Qgd29yaywgYmVjYXVz
ZSB0aGUgU1BJIGNvbnRyb2xsZXIgd291bGQgbmVlZCBDUE9MIHRvDQo+ID4gYmUNCj4gPiAwLg0K
PiA+IA0KPiA+IE5vdCBzdXJlIGlmIHRoaXMgcXVlc3Rpb24gaXMgdmFsaWQsIG9yIHdoZXRoZXIg
d2UgbmVlZCB0byBjYXJlIGFib3V0DQo+ID4gc3VjaA0KPiA+IGNvbmZpZ3VyYXRpb25zLg0KPiAN
Cj4gSXQncyBhIGdvb2QgcXVlc3Rpb24gYXMgdGhpcyBzb3J0IG9mIHRyaWNrIGlzIHVzZWQgc29t
ZXRpbWVzLiBMZXQncyBzZWUNCj4gd2hhdCByZXNwb25zZXMgd2UgZ2V0IHRvIHRoZSBvdGhlciBi
cmFuY2ggb2YgdGhpcyB0aHJlYWQgYmVmb3JlIG1vdmluZw0KPiBmb3J3YXJkcw0KPiB3aXRoIHRo
aXMuDQo+IA0KDQpDb21pbmcgYmFjayBoZXJlLg0KQXBvbG9naWVzIHRvIFJvZHJpZ28uIEkgZG8g
cmVhbGl6ZSB0aGF0IEkgZGVsYXllZCB0aGlzIGEgYml0IHRvbyBtdWNoLg0KDQpMZXQncyBoYXZl
IHRoaXMgc2VyaWVzIGFzLWlzIGhlcmUsIGFuZCB0aGVuIHdlIGNhbiBzZWUgYWJvdXQgYSBtb3Jl
IGdlbmVyaWMNClNQSSBNb2RlIENvbnZlcnRlciBkcml2ZXIgdGhhdCByb3VuZHMtdXAgYWxsIHRo
ZXNlIHdlaXJkIGJvYXJkcy4NCk9yLCBpZiB3ZSBkb24ndCBkbyBhbnkgU1BJIG1vZGUgY29udmVy
dGVyIGRyaXZlcnMsIHRoZW4gd2UgY2FuIGhhbmRsZSB0aGlzDQpvbiBhIGNhc2UtYnktY2FzZSBi
YXNpcy9kcml2ZXIuDQoNCg0KPiBKb25hdGhhbg0KPiANCj4gDQo+ID4gVGhhbmtzDQo+ID4gQWxl
eA0KPiA+IA0KPiA+ID4gKwlyZXQgPSBzcGlfc2V0dXAoc3BpKTsNCj4gPiA+ICsJaWYgKHJldCkg
ew0KPiA+ID4gKwkJZGV2X2Vycigmc3BpLT5kZXYsICJzcGlfc2V0dXAgZmFpbGVkIVxuIik7DQo+
ID4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiAgCXJldCA9IGFk
aXNfaW5pdChzdCwgaW5kaW9fZGV2LCBzcGksICZhZGlzMTYyNDBfZGF0YSk7DQo+ID4gPiAgCWlm
IChyZXQpDQo+ID4gPiAgCQlyZXR1cm4gcmV0OyAgDQo=
