Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94EDC10E5F2
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 07:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfLBG0y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 01:26:54 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58436 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbfLBG0y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 01:26:54 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB26N4iq027812;
        Mon, 2 Dec 2019 01:26:23 -0500
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2051.outbound.protection.outlook.com [104.47.33.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wkk57mcr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 01:26:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqM+GKZS5n/nU8T7GDNmB8jP0AlxjNIGerXlpdxoo9Oq1AmgaMwyE1VJPn0D002RG/HDigL68EvsCHgAgmVG+xMzDqqt5T4j4LrqlydW8tfxLHPMnrL95bIEsOzitI8wJYijwAEmOvfwBlM+8hn/qRo00RcgNaC8HkxSGGzKDIYXMsnKCl51FR2TjBLeaEvGOk2e7KYqLtzNPoyYNp5P+XihKXQRuieT8EwiAOm63LtCQaMZH36tnqUrNiHoHcU7Jt+5aCNSKMO1PQguFCQkLb8zMY1fMsegbmnhbFYDyDPeDv19L7VWc/VS4UDGHtcCaoxutFlennVOr27ZoBqEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+43VHkoO7fyl/oKIaBqyKAlDhA5Ggp+26BvkdjWQga4=;
 b=P/Twfjaaclo5UPdcBoVbdjnVJeKOZxZvZkEehAapA3AvDjZuaEz+CSap2WyinnKepEXB9S5s5G5DE5f3nKNKM0vL4OwddqAUE9hUP4xhgWjSskfwSjBWcMDIGxg3eLd6C3aZLAi3TA7BAsod5IqmMxTXtso3g8nuodXSZI3zf1YgpUooxd5db7qNOGQONfXWEc0lA7VJ916Ydi+sZDvidotf86Q2YG7Y+a/JdjFEumz7eVpufZJrhmwo/+H6omhaGb7u5L1j8zFBWR8u/3dPqevaendF4qeFQVz2jZdFJ2QTOtV5inl6BBl9KHrCqzqNYmeWo6U5LB43KP7aV/XLQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+43VHkoO7fyl/oKIaBqyKAlDhA5Ggp+26BvkdjWQga4=;
 b=JlOZV32vdxQrIEqyZksKle3+IQPK078CcHu/Z8fDMtTCu1hniwK35f2yVaBxrKzd3TVEo22gAvZnXMVYGqDqoK7pfXHtz1Lef4TquZ1L1LLhJiNhrnZuGdTWvvrS8L8lynKt34BNsAAaG33BhrewVG5Q1sByHIGXVJTIwdiBHFw=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5304.namprd03.prod.outlook.com (20.180.15.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Mon, 2 Dec 2019 06:26:21 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 06:26:21 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v3] iio: adc: ad799x: add pm_ops to disable the device
 completely
Thread-Topic: [PATCH v3] iio: adc: ad799x: add pm_ops to disable the device
 completely
Thread-Index: AQHVptWIHJwqAzB4zUOARsK8P67lhKelyj2AgACbQgA=
Date:   Mon, 2 Dec 2019 06:26:21 +0000
Message-ID: <0c8fadc8ba308d19d44a4f4c9fa53dcedde5c047.camel@analog.com>
References: <20191129165314.18829-1-m.felsch@pengutronix.de>
         <20191201211153.6dae6f1a@archlinux>
In-Reply-To: <20191201211153.6dae6f1a@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 677a2c2b-83ba-4b7b-cd2d-08d776f08c24
x-ms-traffictypediagnostic: CH2PR03MB5304:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5304842C0BDE24DFBCC2E540F9430@CH2PR03MB5304.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(376002)(366004)(54534003)(189003)(199004)(5660300002)(66556008)(3846002)(71200400001)(316002)(66946007)(64756008)(81166006)(81156014)(66066001)(8676002)(118296001)(66446008)(6436002)(54906003)(26005)(71190400001)(2906002)(66476007)(14444005)(102836004)(446003)(6512007)(8936002)(2616005)(11346002)(76116006)(6306002)(6116002)(36756003)(478600001)(2501003)(229853002)(186003)(14454004)(110136005)(99286004)(256004)(966005)(6506007)(76176011)(7736002)(6486002)(305945005)(86362001)(25786009)(4326008)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5304;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DD010CWQTpEsP9CfadblqQXBes80eXOUlO3ggpU0DUkslvGlr8AheelCqBtfIGbvxeMQzkf7JY9OAe/KnFRc/VhKrbNc+VlcA98V3XKqLxaMsrZYO7Wwu67aDe8rZgRQ7xFcNAM1ZMFdb+Bd2RLHG7exHnJII0qqSW8ONXQYO17SRIZFIdTxAgdxugjbIJhlic5lQJWcobh2VJNQlGJ0vlx3pO3GfTTt43xMLf2tUb9VgOOnpjNRFZYc4zmMa9zauLYu8oNalF7BDX7YJv7ntC7QQXmsXDvHC7B+axonTpZm3BmQ/TKQ3deUL7dkcn4IGVy9bg42jnXTHPuns+hw6i/zZv8EJqSgNdosXNnefg+ThaxtVHjxtJ2MQQTplC+yl83r/UX+AJfjTQ2HFQ+aIaelCvAwC+Z7WiXG/2ov5Gy6phV5udFMLeNGzhFUq9+ycGzvzTQWgE3lx7sn8vOtM1OXQDhP3kNPIPuYymR9iNI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEBF4EB825BF114296262453AC826500@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677a2c2b-83ba-4b7b-cd2d-08d776f08c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 06:26:21.0420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUpp8PZImQc7ryQmP9NJCV8QN7CtGU5YEFfVrvbmmGkOVK8NCCAtoiGSa1yrvPPmW3CcUDchSrw6PMdO4ZNeRhUrgKe6CRJzRdl8ORDr60I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5304
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-01_04:2019-11-29,2019-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912020056
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEyLTAxIGF0IDIxOjExICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBGcmksIDI5IE5vdiAyMDE5IDE3OjUzOjE0ICswMTAwDQo+IE1hcmNvIEZlbHNjaCA8
bS5mZWxzY2hAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOg0KPiANCj4gPiBUaGUgZGV2aWNlIGlzIGFs
d2F5cyBpbiBhIGxvdy1wb3dlciBzdGF0ZSBkdWUgdG8gdGhlIGhhcmR3YXJlIGRlc2lnbi4NCj4g
PiBJdA0KPiA+IHdha2VzIHVwIHVwb24gYSBjb252ZXJzaW9uIHJlcXVlc3QgYW5kIGdvZXMgYmFj
ayBpbnRvIHRoZSBsb3ctcG93ZXINCj4gPiBzdGF0ZS4gVGhlIHBtIG9wcyBhcmUgYWRkZWQgdG8g
ZGlzYWJsZSB0aGUgZGV2aWNlIGNvbXBsZXRlbHkgYW5kIHRvDQo+ID4gZnJlZQ0KPiA+IHRoZSBy
ZWd1bGF0b3IuIERpc2JhbGluZyB0aGUgZGV2aWNlIGNvbXBsZXRlbHkgc2hvdWxkIGJlIG5vdCB0
aGF0DQo+ID4gbm90YWJsZSBidXQgZnJlZWluZyB0aGUgcmVndWxhdG9yIGlzIGltcG9ydGFudC4g
QmVjYXVzZSBpZiBpdCBpcyBhDQo+ID4gc2hhcmVkDQo+ID4gcG93ZXItcmFpbCB0aGUgcmVndWxh
dG9yIHdvbid0IGJlIGRpc2FibGVkIGR1cmluZyBzdXNwZW5kLXRvLXJhbS9kaXNrDQo+ID4gYW5k
IHNvIGFsbCBkZXZpY2VzIGNvbm5lY3RlZCB0byB0aGF0IHJhaWwga2VlcHMgb24uDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogTWFyY28gRmVsc2NoIDxtLmZlbHNjaEBwZW5ndXRyb25peC5kZT4N
Cj4gTG9va3MgZmluZSB0byBtZSwgYnV0IEknZCBsaWtlIHRvIGxlYXZlIGl0IGEgbGl0dGxlIGxv
bmdlciBmb3IgQWxleA0KPiBhbmQgYW55b25lIGVsc2Ugd2hvIGlzIGludGVyZXN0ZWQgdG8gaGF2
ZSB0aW1lIHRvIHRha2UgYSBsb29rLg0KPiANCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRydSBBcmRl
bGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQoNCj4gVGhhbmtzLA0KPiANCj4g
Sm9uYXRoYW4NCj4gDQo+ID4gLS0tDQo+ID4gSGksDQo+ID4gDQo+ID4gdGhpcyB2MyBjb250YWlu
cyB0aGUgY29tbWVudHMgbWFkZSBvbiBbMV0uDQo+ID4gDQo+ID4gWzFdIGh0dHBzOi8vd3d3LnNw
aW5pY3MubmV0L2xpc3RzL2xpbnV4LWlpby9tc2c0ODEzNS5odG1sDQo+ID4gDQo+ID4gQ2hhbmdl
bG9nOg0KPiA+IHYzOg0KPiA+IC0gYWRkIHJlc3luYyBlcnJvciBjaGVjayBkdXJpbmcgcmVzdW1l
DQo+ID4gDQo+ID4gdjI6DQo+ID4gLSBzcXVhc2ggcGF0Y2ggMiAmIDMNCj4gPiAtIGNhbGwgcmVn
dWxhdG9yX2Rpc2FibGUoKSB1bmNvbmRpdGlvbmFsIGR1cmluZyBzdXNwZW5kKCkNCj4gPiAtIGRy
b3AgZGV2X2VycigpIG1lc3NhZ2VzIGR1cmluZyBzdXNwZW5kDQo+ID4gLSBmaXggZXJyb3IgcGF0
aCB3aXRoaW4gcmVzdW1lKCkNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9paW8vYWRjL2FkNzk5eC5j
IHwgNjYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2FkNzk5eC5jIGIvZHJpdmVycy9paW8vYWRjL2Fk
Nzk5eC5jDQo+ID4gaW5kZXggZjY1ODAxMmJhYWQ4Li5lZjAxM2FmMWFlYzAgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9paW8vYWRjL2FkNzk5eC5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vYWRj
L2FkNzk5eC5jDQo+ID4gQEAgLTE2Nyw2ICsxNjcsMjEgQEAgc3RhdGljIGludCBhZDc5OXhfcmVh
ZF9jb25maWcoc3RydWN0IGFkNzk5eF9zdGF0ZQ0KPiA+ICpzdCkNCj4gPiAgCX0NCj4gPiAgfQ0K
PiA+ICANCj4gPiArc3RhdGljIGludCBhZDc5OXhfdXBkYXRlX2NvbmZpZyhzdHJ1Y3QgYWQ3OTl4
X3N0YXRlICpzdCwgdTE2IGNvbmZpZykNCj4gPiArew0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+
ID4gKwlyZXQgPSBhZDc5OXhfd3JpdGVfY29uZmlnKHN0LCBjb25maWcpOw0KPiA+ICsJaWYgKHJl
dCA8IDApDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArCXJldCA9IGFkNzk5eF9yZWFkX2NvbmZp
ZyhzdCk7DQo+ID4gKwlpZiAocmV0IDwgMCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsJc3Qt
PmNvbmZpZyA9IHJldDsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4g
PiAgLyoqDQo+ID4gICAqIGFkNzk5eF90cmlnZ2VyX2hhbmRsZXIoKSBiaCBvZiB0cmlnZ2VyIGxh
dW5jaGVkIHBvbGxpbmcgdG8gcmluZw0KPiA+IGJ1ZmZlcg0KPiA+ICAgKg0KPiA+IEBAIC04MDgs
MTMgKzgyMyw5IEBAIHN0YXRpYyBpbnQgYWQ3OTl4X3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpj
bGllbnQsDQo+ID4gIAlpbmRpb19kZXYtPmNoYW5uZWxzID0gc3QtPmNoaXBfY29uZmlnLT5jaGFu
bmVsOw0KPiA+ICAJaW5kaW9fZGV2LT5udW1fY2hhbm5lbHMgPSBjaGlwX2luZm8tPm51bV9jaGFu
bmVsczsNCj4gPiAgDQo+ID4gLQlyZXQgPSBhZDc5OXhfd3JpdGVfY29uZmlnKHN0LCBzdC0+Y2hp
cF9jb25maWctPmRlZmF1bHRfY29uZmlnKTsNCj4gPiAtCWlmIChyZXQgPCAwKQ0KPiA+IC0JCWdv
dG8gZXJyb3JfZGlzYWJsZV92cmVmOw0KPiA+IC0JcmV0ID0gYWQ3OTl4X3JlYWRfY29uZmlnKHN0
KTsNCj4gPiAtCWlmIChyZXQgPCAwKQ0KPiA+ICsJcmV0ID0gYWQ3OTl4X3VwZGF0ZV9jb25maWco
c3QsIHN0LT5jaGlwX2NvbmZpZy0+ZGVmYXVsdF9jb25maWcpOw0KPiA+ICsJaWYgKHJldCkNCj4g
PiAgCQlnb3RvIGVycm9yX2Rpc2FibGVfdnJlZjsNCj4gPiAtCXN0LT5jb25maWcgPSByZXQ7DQo+
ID4gIA0KPiA+ICAJcmV0ID0gaWlvX3RyaWdnZXJlZF9idWZmZXJfc2V0dXAoaW5kaW9fZGV2LCBO
VUxMLA0KPiA+ICAJCSZhZDc5OXhfdHJpZ2dlcl9oYW5kbGVyLCBOVUxMKTsNCj4gPiBAQCAtODY0
LDYgKzg3NSw0OCBAQCBzdGF0aWMgaW50IGFkNzk5eF9yZW1vdmUoc3RydWN0IGkyY19jbGllbnQN
Cj4gPiAqY2xpZW50KQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiAgDQo+ID4gK3N0YXRp
YyBpbnQgX19tYXliZV91bnVzZWQgYWQ3OTl4X3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiA+ICt7DQo+ID4gKwlzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2ID0gaTJjX2dldF9jbGllbnRk
YXRhKHRvX2kyY19jbGllbnQoZGV2KSk7DQo+ID4gKwlzdHJ1Y3QgYWQ3OTl4X3N0YXRlICpzdCA9
IGlpb19wcml2KGluZGlvX2Rldik7DQo+ID4gKw0KPiA+ICsJcmVndWxhdG9yX2Rpc2FibGUoc3Qt
PnZyZWYpOw0KPiA+ICsJcmVndWxhdG9yX2Rpc2FibGUoc3QtPnJlZyk7DQo+ID4gKw0KPiA+ICsJ
cmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgX19tYXliZV91bnVzZWQg
YWQ3OTl4X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBp
aW9fZGV2ICppbmRpb19kZXYgPSBpMmNfZ2V0X2NsaWVudGRhdGEodG9faTJjX2NsaWVudChkZXYp
KTsNCj4gPiArCXN0cnVjdCBhZDc5OXhfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsN
Cj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0ID0gcmVndWxhdG9yX2VuYWJsZShzdC0+
cmVnKTsNCj4gPiArCWlmIChyZXQpIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgIlVuYWJsZSB0byBl
bmFibGUgdmNjIHJlZ3VsYXRvclxuIik7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArCX0NCj4g
PiArCXJldCA9IHJlZ3VsYXRvcl9lbmFibGUoc3QtPnZyZWYpOw0KPiA+ICsJaWYgKHJldCkgew0K
PiA+ICsJCXJlZ3VsYXRvcl9kaXNhYmxlKHN0LT5yZWcpOw0KPiA+ICsJCWRldl9lcnIoZGV2LCAi
VW5hYmxlIHRvIGVuYWJsZSB2cmVmIHJlZ3VsYXRvclxuIik7DQo+ID4gKwkJcmV0dXJuIHJldDsN
Cj4gPiArCX0NCj4gPiArDQo+ID4gKwkvKiByZXN5bmMgY29uZmlnICovDQo+ID4gKwlyZXQgPSBh
ZDc5OXhfdXBkYXRlX2NvbmZpZyhzdCwgc3QtPmNvbmZpZyk7DQo+ID4gKwlpZiAocmV0KSB7DQo+
ID4gKwkJcmVndWxhdG9yX2Rpc2FibGUoc3QtPnZyZWYpOw0KPiA+ICsJCXJlZ3VsYXRvcl9kaXNh
YmxlKHN0LT5yZWcpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJ
cmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBTSU1QTEVfREVWX1BNX09QUyhh
ZDc5OXhfcG1fb3BzLCBhZDc5OXhfc3VzcGVuZCwNCj4gPiBhZDc5OXhfcmVzdW1lKTsNCj4gPiAr
DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9pZCBhZDc5OXhfaWRbXSA9IHsN
Cj4gPiAgCXsgImFkNzk5MSIsIGFkNzk5MSB9LA0KPiA+ICAJeyAiYWQ3OTk1IiwgYWQ3OTk1IH0s
DQo+ID4gQEAgLTg4MSw2ICs5MzQsNyBAQCBNT0RVTEVfREVWSUNFX1RBQkxFKGkyYywgYWQ3OTl4
X2lkKTsNCj4gPiAgc3RhdGljIHN0cnVjdCBpMmNfZHJpdmVyIGFkNzk5eF9kcml2ZXIgPSB7DQo+
ID4gIAkuZHJpdmVyID0gew0KPiA+ICAJCS5uYW1lID0gImFkNzk5eCIsDQo+ID4gKwkJLnBtID0g
JmFkNzk5eF9wbV9vcHMsDQo+ID4gIAl9LA0KPiA+ICAJLnByb2JlID0gYWQ3OTl4X3Byb2JlLA0K
PiA+ICAJLnJlbW92ZSA9IGFkNzk5eF9yZW1vdmUsDQo=
