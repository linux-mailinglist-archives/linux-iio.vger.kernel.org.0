Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB46B5D9E
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 08:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfIRGw2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 02:52:28 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47334 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfIRGw2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 02:52:28 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8I6lokL011035;
        Wed, 18 Sep 2019 02:51:58 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2051.outbound.protection.outlook.com [104.47.50.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v37k80xep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 02:51:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmqD52SqF0rblZh6V5MjjHc4Jpaf5yU61UeVYz1x7AKVZcnfshRwFX/stZAWSTnMh0s3NlPkdRkW+TwJ11oP4C5JIWvTrRjwbZ3szfe4fasvn4Skl8SfP887EpQJk/yem28J7WVSubl66TcJT/IQFxcosQdgsnrjIMLSp+iAKoZoAigaZ/NLasvXHlMyDtr3eC01sv8CEPbNkC5t5iZTkp/7gzLPfJflONYeF1uvIoe0o1qgjSpG4P8NMQ2Sp2AjcA0tWTBl4s/tdO2Ch1it8k42U7E2sfz4e8gGtUi9Am6YE34CBMtG5J6vBJxtAd0q2toLCIcv0jkdlenfuoAgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCmZYOKzMPJvD1706bOn80LH1Hh8xrdYJPiOwtjzHAE=;
 b=Ft3CYJat/R76fQ3jUTgISOFTMGd1/oVQ7J5/u+gBccpLaWP2rPduV8ibiSD/0gr+PaL17CfyvZRL4UUVnGZL3hFkK0mp34pXPKgNqJVLtt0FuBrLCgb+agxgxv40nu56jo1sGAE9ZaeoDPswNfANBusuuZilxZJoF+aJKdU+dkJzUqiEeqcNQCKNUY+psNj3zMot99SeSi9LGJMD1A+3Bxqeb0PezSvpOYgSRIpoNB15e0/wMTGp/LKSc4HLvyBmbQcHR+D93VIKf1EULKxRsOyxyWd7xDKNZu+M1CneVbtf13mUszFWhiYlmdlkF/SOU51jdrUP23ujLWdnDzZFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCmZYOKzMPJvD1706bOn80LH1Hh8xrdYJPiOwtjzHAE=;
 b=l8Ng7HNFuhRNPyImVGxSRgewgQW9yU7rgiAb8/IM5xeTqAUfuUYCu1h6chWya1k/EwfidKhUyvu3OnLzMTdx9WktMYnZs4fgF2TWOoY93Eoh7BtC2Z76LllrmJgRu8m2pmCeLlvQz31zpqAVLs8hxpmyPniGnKOfdDJ1rd1ABFY=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5270.namprd03.prod.outlook.com (20.180.13.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Wed, 18 Sep 2019 06:51:56 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2284.009; Wed, 18 Sep 2019
 06:51:56 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: adc: ad799x: factor out config register update
Thread-Topic: [PATCH 2/3] iio: adc: ad799x: factor out config register update
Thread-Index: AQHVbXJikpAUqSp5NkqMxwualxyZmKcxMoGA
Date:   Wed, 18 Sep 2019 06:51:56 +0000
Message-ID: <6f857959a8cbef3320830676b2280e04ca4f8e96.camel@analog.com>
References: <20190917160925.9791-1-m.felsch@pengutronix.de>
         <20190917160925.9791-3-m.felsch@pengutronix.de>
In-Reply-To: <20190917160925.9791-3-m.felsch@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79b70bb8-5d0e-4bd3-e694-08d73c04b23f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR03MB5270;
x-ms-traffictypediagnostic: CH2PR03MB5270:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5270BF63434175D4FA5A53D5F98E0@CH2PR03MB5270.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(39860400002)(136003)(199004)(189003)(36756003)(102836004)(476003)(7736002)(186003)(305945005)(86362001)(6246003)(6512007)(486006)(256004)(5660300002)(2201001)(446003)(4326008)(11346002)(14444005)(478600001)(26005)(110136005)(2616005)(54906003)(316002)(6436002)(229853002)(8936002)(76176011)(118296001)(14454004)(6506007)(66476007)(15650500001)(81156014)(66066001)(64756008)(66556008)(66946007)(6116002)(3846002)(76116006)(66446008)(6486002)(71190400001)(2501003)(81166006)(99286004)(8676002)(71200400001)(25786009)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5270;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Eq+uEZArhlIH6y7CJ3WGYsz4KYOuEMZf1C5My6121ydZN6Xe/UwJSkYV4NjuieJGacwf5cpZoZkWf7b5NxiuVC6BR2BCkdFIm9C0n3LxGe5v8faN/JTNz8IGCmRV/CWiZ9N2ajcIQCLKMVKblXToysYH38UgOBFegTuHAWxlHIzynsiSeZDAZqdrfJb9cWK+UDDWCT2D3mloYZQ8BBUvCQDz6ZJGkLTXOWYUhdOBfgHoaPt8FFVbs0m17MkRAuUwrqj5pVipGb+1+3E6KaxuPSNsi8CSaHcALk+BeJl0HLj052HTC4guPnPohbOo31WN8lMK7FSxMklA7Mv0B4JEbvW6EsDT29e/WutKNbWpGWG4Q+KJroFoLRpY+O4X2aG47ulhZfKNNYaLhcd5oZOc1qxcnebeHc5uJC4sO9/FotQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28098D2B352ABA4E9AE1E79965166127@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b70bb8-5d0e-4bd3-e694-08d73c04b23f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 06:51:56.3111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AtDPBi1TUI5ReOtgcICLfRp2Vjc7aGxk2LAk7OaRvLoUhhRG3e8XwHdSaKp0dl4HWR/FtQ484313v09T62euMaSEeYStA5mNlWToIAtRiZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5270
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-18_04:2019-09-17,2019-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 mlxlogscore=910
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909180072
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTA5LTE3IGF0IDE4OjA5ICswMjAwLCBNYXJjbyBGZWxzY2ggd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQoNCkNvbW1lbnRzIGlubGluZS4NCg0KPiBGYWN0b3Igb3V0IHRoZSBj
b25maWd1cmF0aW9uIHJlZ2lzdGVyIHVwZGF0ZSB0byByZXVzZSBpdCBkdXJpbmcgcG0NCj4gcmVz
dW1lIG9wZXJhdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmNvIEZlbHNjaCA8bS5mZWxz
Y2hAcGVuZ3V0cm9uaXguZGU+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vYWRjL2FkNzk5eC5jIHwg
MjMgKysrKysrKysrKysrKysrKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRp
b25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2Fk
Yy9hZDc5OXguYyBiL2RyaXZlcnMvaWlvL2FkYy9hZDc5OXguYw0KPiBpbmRleCBmNjU4MDEyYmFh
ZDguLmFmNWEyZGU5YzIyZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2FkNzk5eC5j
DQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hZDc5OXguYw0KPiBAQCAtMTY3LDYgKzE2NywyMSBA
QCBzdGF0aWMgaW50IGFkNzk5eF9yZWFkX2NvbmZpZyhzdHJ1Y3QgYWQ3OTl4X3N0YXRlDQo+ICpz
dCkNCj4gIAl9DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpbnQgYWQ3OTl4X3VwZGF0ZV9jb25maWco
c3RydWN0IGFkNzk5eF9zdGF0ZSAqc3QsIHUxNiBjb25maWcpDQo+ICt7DQo+ICsJaW50IHJldDsN
Cj4gKw0KPiArCXJldCA9IGFkNzk5eF93cml0ZV9jb25maWcoc3QsIGNvbmZpZyk7DQo+ICsJaWYg
KHJldCA8IDApDQo+ICsJCXJldHVybiByZXQ7DQo+ICsJcmV0ID0gYWQ3OTl4X3JlYWRfY29uZmln
KHN0KTsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwlzdC0+Y29uZmln
ID0gcmV0Ow0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gIC8qKg0KPiAgICogYWQ3
OTl4X3RyaWdnZXJfaGFuZGxlcigpIGJoIG9mIHRyaWdnZXIgbGF1bmNoZWQgcG9sbGluZyB0byBy
aW5nDQo+IGJ1ZmZlcg0KPiAgICoNCj4gQEAgLTgwOCwxMyArODIzLDkgQEAgc3RhdGljIGludCBh
ZDc5OXhfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCj4gIAlpbmRpb19kZXYtPmNo
YW5uZWxzID0gc3QtPmNoaXBfY29uZmlnLT5jaGFubmVsOw0KPiAgCWluZGlvX2Rldi0+bnVtX2No
YW5uZWxzID0gY2hpcF9pbmZvLT5udW1fY2hhbm5lbHM7DQo+ICANCj4gLQlyZXQgPSBhZDc5OXhf
d3JpdGVfY29uZmlnKHN0LCBzdC0+Y2hpcF9jb25maWctPmRlZmF1bHRfY29uZmlnKTsNCj4gLQlp
ZiAocmV0IDwgMCkNCj4gLQkJZ290byBlcnJvcl9kaXNhYmxlX3ZyZWY7DQo+IC0JcmV0ID0gYWQ3
OTl4X3JlYWRfY29uZmlnKHN0KTsNCj4gLQlpZiAocmV0IDwgMCkNCj4gKwlyZXQgPSBhZDc5OXhf
dXBkYXRlX2NvbmZpZyhzdCwgc3QtPmNoaXBfY29uZmlnLT5kZWZhdWx0X2NvbmZpZyk7DQo+ICsJ
aWYgKHJldCkNCj4gIAkJZ290byBlcnJvcl9kaXNhYmxlX3ZyZWY7DQo+IC0Jc3QtPmNvbmZpZyA9
IHJldDsNCg0KSSdtIGZlZWxpbmcgdGhpcyBjb3VsZCBnbyBhIGJpdCBmdXJ0aGVyIG1heWJlLg0K
SSdtIG5vdGljaW5nIHRoYXQgcGF0Y2ggMyBhZGRzIGFkNzk5eF9zdXNwZW5kKCkgJiBhZDc5OXhf
cmVzdW1lKCkuDQoNCkl0IGxvb2tzIHRvIG1lIChJIGNvdWxkIGJlIHdyb25nKSwgdGhhdCB0aGlz
IGJpdCBvZiBjb2RlICh3aXRoIHNvbWUgbWlub3INCnJlLW9yZGVyaW5nKSBpcyBhY3R1YWxseSBh
IGFkNzk5eF9yZXN1bWUoKSBjYWxsLg0KU2ltaWxhcmx5LCBhZDc5OXhfc3VzcGVuZCgpIGNvdWxk
IGJlIGFkZGVkIGluIGFkNzk5eF9yZW1vdmUoKS4NCg0KSWYgdGhhdCdzIHRoZSBjYXNlLCBwYXRj
aCAyICYgMyBjb3VsZCBiZSBzcXVhc2hlZCBpbnRvIGEgc2luZ2xlIHBhdGNoIHRoYXQNCmFkZHMg
YWQ3OTl4X3N1c3BlbmQoKSAmIGFkNzk5eF9yZXN1bWUoKSAmIGFsc28gcmVwbGFjZXMgdGhlbSBo
ZXJlIGFuZCBpbg0KdGhlIGFkNzk5eF9yZW1vdmUoKSBjb2RlLg0KDQo+ICANCj4gIAlyZXQgPSBp
aW9fdHJpZ2dlcmVkX2J1ZmZlcl9zZXR1cChpbmRpb19kZXYsIE5VTEwsDQo+ICAJCSZhZDc5OXhf
dHJpZ2dlcl9oYW5kbGVyLCBOVUxMKTsNCg==
