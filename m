Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97558B8BAA
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2019 09:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437551AbfITHiF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Sep 2019 03:38:05 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6546 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437540AbfITHiE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Sep 2019 03:38:04 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8K7HeAK032292;
        Fri, 20 Sep 2019 03:37:58 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2050.outbound.protection.outlook.com [104.47.38.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v3vbdm3y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 03:37:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9b/23dNA3iDaEgYEO3V+VWdv7g+s53VCy1itjiuy7xf42iEfCFZSmIL/+nfpqDma7QHry+RGZ6B7/mWPLrA2fZz6SxEYF9cOf+x+Sli4NfRdEhFmaRTfFw990yyx3nf0OzfspD6G2txK5HqRHkOOVNjSw94DnUP5IYcveVGDmdcuvduWyGw8EaJ49cQAHov7ki0B8OIv/F8DvNDQ0C96UQfRr+mPWm17jsbUlNqtVwppRrMhAijQy03kTuN3+IXcD1aV79YM4hdMq2lYFG87Ttg57AJAoEgmuu//Fo3IPlzSNa02VM0dCcgirnLHvxd7HcO6rq0s7433PYIoufMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GM2oipDSqqp3HOGVAbwmUHbmHGlkhcgkUtuKVE8ZjNI=;
 b=MagTJ9hpm9+q2qr8GRay1yBsblEqiSqKH6wQh4aQaukePazbCOQtR5xk7JFCJeoUabEuZXFmM1duoatO83jW8PvzV/LS00XvVvzMat8DsA3zQIvbZpfMtmlsMXcX0/lejBGpx5Hmixw1ChuM7LOOMgacyiAIYmNCIjptZQxowNuYWw6MkYcPcT14kWOv77qIhXIH9oIEkSsfBWPzoDkGc4rflO/BRjM3mrKArKG8oxqZHyzPUl7g3J5HlZXyZnM5+Y+fiN6ZxQJJTzxs3l8dnVLpitTFo0lm0qcueH5D9jP7tiPvc3IGsy6R84M4MR+dv7A76EF8rzSqELp37d/LNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GM2oipDSqqp3HOGVAbwmUHbmHGlkhcgkUtuKVE8ZjNI=;
 b=inVBf0n44aa2R/hUznbzQ6i+Ff4Kv4/oeqnF9VeOrcZsJ2m636Z4SJVzpZAVklVCKVYcOTBx1yC1u5jM0xDlG2lUy9UCqbVVIud2Qa60Yj94UfbtAz+vNqGU/w9pls+j1QwdJZwbP+2K1Kz8xOMkmNIsIt79JxtcqHHYwBG8svc=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5205.namprd03.prod.outlook.com (20.180.15.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Fri, 20 Sep 2019 07:37:56 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2284.009; Fri, 20 Sep 2019
 07:37:56 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "matt.ranostay@konsulko.com" <matt.ranostay@konsulko.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: fix
 iio_triggered_buffer_predisable() position
Thread-Topic: [PATCH] iio: chemical: atlas-ph-sensor: fix
 iio_triggered_buffer_predisable() position
Thread-Index: AQHVb4VrRXGexHyKCEql9axgrCpaPKc0LZaA
Date:   Fri, 20 Sep 2019 07:37:56 +0000
Message-ID: <9e05f129826ad4ddc723a655d712bb6ae41a1259.camel@analog.com>
References: <20190920073122.21713-1-alexandru.ardelean@analog.com>
In-Reply-To: <20190920073122.21713-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 707baa51-282d-40f9-fc8d-08d73d9d742d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR03MB5205;
x-ms-traffictypediagnostic: CH2PR03MB5205:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CH2PR03MB52053D9197256FD9852CAA08F9880@CH2PR03MB5205.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(366004)(346002)(396003)(199004)(189003)(229853002)(486006)(305945005)(6916009)(446003)(6486002)(4326008)(11346002)(186003)(3846002)(6116002)(118296001)(6436002)(14454004)(7736002)(86362001)(5024004)(6506007)(2501003)(71200400001)(26005)(256004)(476003)(66066001)(2616005)(14444005)(71190400001)(25786009)(5640700003)(102836004)(478600001)(8676002)(54906003)(316002)(99286004)(2351001)(8936002)(6246003)(76176011)(76116006)(5660300002)(36756003)(966005)(81166006)(81156014)(66556008)(66946007)(66476007)(6512007)(6306002)(2906002)(66446008)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5205;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hPMx7H+o5fvlVW45eQsCf9SsN5ImqA61WRFxoaLkAALAc3VAd4Jd4EdkNbCSZfd2TrSzBwuvdLC6CDQHBy6JZFHEUyyY9wNwsRkUMY7TrfRRWd13JQPfRgEQvJSszIxpgg2ccUTZtj8tfyuSEwJEwMauFRywo09rYYSgcvfrRy5rBdZtm3friq+oLjNQ09PdEm1DQHJBBXvB/0VFxz4zevxOBXlp3HkEBfcsL1P3G22MTZIsTN1ywZSKCrbUdy/zTJSt351kpd6ft47HnpAd6mXda4Kd9/cR0hIgOY7igNUP/w3zeeVMovefJ+47wNDY6dgB22rSsRU2muVSvk3rQ+d3WkuHIULMqGykE41NHp7C6jIunE5fvo1jlGAbXd9kjyl9nIimIPgGo6U5hWgvXEHkYUE2OTZ7HNPZWcMPLPs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8FDC1395F51D447992D8036CB41EB01@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707baa51-282d-40f9-fc8d-08d73d9d742d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 07:37:56.3073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: it7pApAQZV5GOlfVid4vKOrmCb97FCXFS5tZ6dXUfGeNMjLJeXpNN5GePBzpMZSICocEhsQiSYioelqF8HGiG1PYlW5/dQE+SA1/qFaURCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5205
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-20_01:2019-09-19,2019-09-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909200077
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDE5LTA5LTIwIGF0IDEwOjMxICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IFRoZSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl97cHJlZGlzYWJsZSxwb3N0ZW5hYmxlfSBm
dW5jdGlvbnMgYXR0YWNoL2RldGFjaA0KPiB0aGUgcG9sbCBmdW5jdGlvbnMuDQo+IA0KPiBUaGUg
aWlvX3RyaWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZSgpIHNob3VsZCBiZSBjYWxsZWQgbGFzdCwg
dG8gZGV0YWNoDQo+IHRoZQ0KPiBwb2xsIGZ1bmMgYWZ0ZXIgdGhlIGRldmljZXMgaGFzIGJlZW4g
c3VzcGVuZGVkLg0KPiANCg0KSSBqdXN0IG5vdGljZWQgdGhpcyBpcyBhIFJFU0VORC4NClRoZSBv
cmlnaW5hbCBpcyBoZXJlOg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTAz
MjU2OS8NCg0KSSBkaWQgbm90IHRoaW5rIHRoYXQgSSBwcm9iYWJseSBhbHJlYWR5IHNlbnQgaXQg
YmVmb3JlIHNlbmRpbmcgaXQgYWdhaW4uDQoNCj4gVGhlIHBvc2l0aW9uIG9mIGlpb190cmlnZ2Vy
ZWRfYnVmZmVyX3Bvc3RlbmFibGUoKSBpcyBjb3JyZWN0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
QWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL2lpby9jaGVtaWNhbC9hdGxhcy1waC1zZW5zb3IuYyB8IDggKysrKy0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vY2hlbWljYWwvYXRsYXMtcGgtc2Vuc29yLmMNCj4g
Yi9kcml2ZXJzL2lpby9jaGVtaWNhbC9hdGxhcy1waC1zZW5zb3IuYw0KPiBpbmRleCAzYTIwY2I1
ZDliZmYuLjZjMTc1ZWIxYzdhNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vY2hlbWljYWwv
YXRsYXMtcGgtc2Vuc29yLmMNCj4gKysrIGIvZHJpdmVycy9paW8vY2hlbWljYWwvYXRsYXMtcGgt
c2Vuc29yLmMNCj4gQEAgLTMyMywxNiArMzIzLDE2IEBAIHN0YXRpYyBpbnQgYXRsYXNfYnVmZmVy
X3ByZWRpc2FibGUoc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldikNCj4gIAlzdHJ1Y3QgYXRs
YXNfZGF0YSAqZGF0YSA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ICAJaW50IHJldDsNCj4gIA0K
PiAtCXJldCA9IGlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRpc2FibGUoaW5kaW9fZGV2KTsNCj4g
KwlyZXQgPSBhdGxhc19zZXRfaW50ZXJydXB0KGRhdGEsIGZhbHNlKTsNCj4gIAlpZiAocmV0KQ0K
PiAgCQlyZXR1cm4gcmV0Ow0KPiAgDQo+IC0JcmV0ID0gYXRsYXNfc2V0X2ludGVycnVwdChkYXRh
LCBmYWxzZSk7DQo+ICsJcG1fcnVudGltZV9tYXJrX2xhc3RfYnVzeSgmZGF0YS0+Y2xpZW50LT5k
ZXYpOw0KPiArCXJldCA9IHBtX3J1bnRpbWVfcHV0X2F1dG9zdXNwZW5kKCZkYXRhLT5jbGllbnQt
PmRldik7DQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIA0KPiAtCXBtX3J1bnRp
bWVfbWFya19sYXN0X2J1c3koJmRhdGEtPmNsaWVudC0+ZGV2KTsNCj4gLQlyZXR1cm4gcG1fcnVu
dGltZV9wdXRfYXV0b3N1c3BlbmQoJmRhdGEtPmNsaWVudC0+ZGV2KTsNCj4gKwlyZXR1cm4gaWlv
X3RyaWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0KPiAgfQ0KPiAgDQo+ICBz
dGF0aWMgY29uc3Qgc3RydWN0IGlpb190cmlnZ2VyX29wcyBhdGxhc19pbnRlcnJ1cHRfdHJpZ2dl
cl9vcHMgPSB7DQo=
