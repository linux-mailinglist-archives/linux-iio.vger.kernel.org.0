Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2FA3A5720
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2019 15:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfIBNFr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Sep 2019 09:05:47 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16398 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726391AbfIBNFq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Sep 2019 09:05:46 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82CwbTV006770;
        Mon, 2 Sep 2019 09:05:10 -0400
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2057.outbound.protection.outlook.com [104.47.34.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uqjrab738-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 09:05:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPzTd74OxXzoknRmfrdoj8oc43QA/AUkdMTqH66oCmD2hxA5HWMOcqBBxKwkqwfj6zHctlRTg1YGtVnhnvwf/T+POifuzhZGJkgO4BggyIBqgW1gWQvIg0WrBvA0ZHmWIH5ZMmHuCXzUSAF5U/Os2cucFcFYYMbncbqSmNXZU6PTDTvIOJNbeJWMaItClSZgPGn/8sq7Kj7mZriX7dHU29triNbM9VRc8a50Nc0GRMx3dW814g8DQTq/wuQBGewkfxvjTng4JP0mCOmmsn9zfQOxegYuNJetTcmKLZb0uFGha1ZyKGxblzdasJz/PIm3JTFcWdnAEpDt3LbKrFLn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inB+Bh/NlCsBJxBrxRt8MuD0LQhtMOS4/hLb/ZGcFw0=;
 b=LiMiKob/RPSDmTDu4CEcSJeoQrYKGciEb5XQ58owXWyf3A5D0V9hkFr26yZ65fQWjrxN9bntsMK3F7c5dYnb0zt2fksiaYV4/mLz0hKNxnScebi0ibtFChelqc7RlGJWCGTqLhYAQtYvM6W+DbFbELEKyuwi1RcJl7DReRhBJZwmv9V05e9OIxdCxDl4xZlccwxqY5q7BEpa/klFAhfjaeVTVqTiIh+2v9mqCYlPLknmt/aGif7FOBdYhpI8DQYM33IneODjm7FXlV7AyLYwmHnN/edp2lfZWaFHL4zo1RL+rPdCPSNh9ZHyAvdQUpqbToM+OfIjonBhQGHAxhxZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inB+Bh/NlCsBJxBrxRt8MuD0LQhtMOS4/hLb/ZGcFw0=;
 b=QfHUxc9oWSDp7nlJGei7HaNo/zNnKpBQ6Wt4FjtqfnyWWQ1QreqJOv+mM0omXmbqYXeliV0JiKsbjTa5vCoiobXgDKuzONQvOq84H/kDOi3kZ+KWbuVZ6E35OZyo/1hEcPq9QvftSIPXiPcNU5IWK4ft2uoFzjf6uy5u7RF2r9U=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5207.namprd03.prod.outlook.com (20.180.15.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Mon, 2 Sep 2019 13:05:08 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::ad16:8446:873b:4042]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::ad16:8446:873b:4042%3]) with mapi id 15.20.2220.021; Mon, 2 Sep 2019
 13:05:08 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
CC:     "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: accel: add binding documentation
 for ADIS16240
Thread-Topic: [PATCH 1/2] dt-bindings: iio: accel: add binding documentation
 for ADIS16240
Thread-Index: AQHVYSnTbqAlNO7980SO1u1taHQC/KcYW8KA
Date:   Mon, 2 Sep 2019 13:05:08 +0000
Message-ID: <15a6aad652ebf6165aeb1ec5739aeafa985d2bb0.camel@analog.com>
References: <20190902005938.7734-1-rodrigorsdc@gmail.com>
In-Reply-To: <20190902005938.7734-1-rodrigorsdc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b081cd80-7ccc-4d09-4520-08d72fa62e4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR03MB5207;
x-ms-traffictypediagnostic: CH2PR03MB5207:
x-ms-exchange-purlcount: 3
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5207ED0C63C3523BFF7345F1F9BE0@CH2PR03MB5207.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(376002)(396003)(199004)(189003)(51444003)(36756003)(2906002)(305945005)(53936002)(6306002)(66066001)(316002)(256004)(25786009)(6512007)(99286004)(91956017)(86362001)(4326008)(66556008)(66446008)(66476007)(64756008)(76116006)(66946007)(2201001)(5660300002)(2501003)(6246003)(54906003)(118296001)(110136005)(476003)(6486002)(2616005)(3846002)(6116002)(446003)(966005)(7736002)(229853002)(478600001)(14454004)(11346002)(6506007)(71200400001)(71190400001)(102836004)(6436002)(76176011)(26005)(186003)(486006)(53376002)(81156014)(8936002)(81166006)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5207;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TbnZCVhQCbqZ+XPaeLuSKU9UjguowD94ZGDzscMVCgwxn8ckeWRl7f8kI08aUW5IWoP5oCCI8MO8Ilrsn8pV0OCfNRFZPHnsS+9mLiFBljf/ywvMWiKDWuZ+Zi/aOte+Ao2JWBsXVuu4qvJfQfmRYkrH3NtqmCL4P1dH4ElNuRJcFCG+SVb2Tc3rG9vk9CdQJwUIqzzqTses3plLBbfwxvOtUlGVHx8v7wr2BcjO3OqjUlIJhlm7UeHgAoARYKrGADM2cPdtokhmPNJPBVCLIZgG4qCiN9asldNla1tSXvB9pBQXAcam4NQgVa80EGt+e/hXnoVx9VdQw2hyGiBZtilHmSMbBrqF1MkkZ3n+XpasU+G4CvDTbcdMohjCVIjnANOPznF9xlY/SVlMv9H8Lq3JCvtQGHiqE8jpdNzjIl8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C8F6A574CE28141B16837574294AF27@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b081cd80-7ccc-4d09-4520-08d72fa62e4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 13:05:08.3155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kW7+K4wkf2lMvqbQDH/81mA7mSFc6gtSQ5PNEQ5nIIW+6SQJNKGlma2SB5m758oKB+TS+S7NZMS1BLe400g568c0ckP4DcSBBItcGXNlPLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5207
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_04:2019-08-29,2019-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909020146
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTA5LTAxIGF0IDIxOjU5IC0wMzAwLCBSb2RyaWdvIENhcnZhbGhvIHdyb3Rl
Og0KPiBUaGlzIHBhdGNoIGFkZCBkZXZpY2UgdHJlZSBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9y
IEFESVMxNjI0MC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJvZHJpZ28gUmliZWlybyBDYXJ2YWxo
byA8cm9kcmlnb3JzZGNAZ21haWwuY29tPg0KPiAtLS0NCj4gSSBoYXZlIGRvdWJ0IGFib3V0IHdo
YXQgbWFpbnRhaW5lciBJIG1heSB0byBwdXQgaW4gdGhhdCBkb2N1bWVudGF0aW9uLiBJDQo+IHB1
dCBBbGV4YW5kcnUgYXMgbWFpbnRhaW5lciBiZWNhdXNlIGhlIHJldmlld2VkIG15IGxhc3QgcGF0
Y2ggb24gdGhpcw0KPiBkcml2ZXIsIHNvIEkgdGhpbmsgdGhhdCBoZSBpcyBhIGdvb2QgY2FuZGlk
YXRlLg0KDQpGaW5lIHRvIGxpc3QgbWUgYXMgbWFpbnRhaW5lciBmb3IgdGhpcy4NCg0KUmV2aWV3
ZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+
DQoNCj4gIC4uLi9iaW5kaW5ncy9paW8vYWNjZWwvYWRpLGFkaXMxNjI0MC55YW1sICAgICB8IDU1
ICsrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCsp
DQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2lpby9hY2NlbC9hZGksYWRpczE2MjQwLnlhbWwNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FjY2VsL2FkaSxhZGlzMTYyNDAueWFtbA0K
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWNjZWwvYWRpLGFkaXMx
NjI0MC55YW1sDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4u
MDgwMTliNTE2MTFjDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2lpby9hY2NlbC9hZGksYWRpczE2MjQwLnlhbWwNCj4gQEAgLTAsMCAr
MSw1NSBAQA0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArJVlBTUwg
MS4yDQo+ICstLS0NCj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaWlvL2Fj
Y2VsL2FkaSxhZGlzMTYyNDAueWFtbCMNCj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiArDQo+ICt0aXRsZTogQURJUzE2MjQwIFByb2dy
YW1tYWJsZSBJbXBhY3QgU2Vuc29yIGFuZCBSZWNvcmRlciBkcml2ZXINCj4gKw0KPiArbWFpbnRh
aW5lcnM6DQo+ICsgIC0gQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5h
bG9nLmNvbT4NCj4gKw0KPiArZGVzY3JpcHRpb246IHwNCj4gKyAgQURJUzE2MjQwIFByb2dyYW1t
YWJsZSBJbXBhY3QgU2Vuc29yIGFuZCBSZWNvcmRlciBkcml2ZXIgdGhhdCBzdXBwb3J0cw0KPiAr
ICBTUEkgaW50ZXJmYWNlLg0KPiArICAgIGh0dHBzOi8vd3d3LmFuYWxvZy5jb20vZW4vcHJvZHVj
dHMvYWRpczE2MjQwLmh0bWwNCj4gKw0KPiArcHJvcGVydGllczoNCj4gKyAgY29tcGF0aWJsZToN
Cj4gKyAgICBlbnVtOg0KPiArICAgICAgLSBhZGksYWRpczE2MjQwDQo+ICsNCj4gKyAgcmVnOg0K
PiArICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgc3BpLWNwaGE6IHRydWUNCj4gKw0KPiArICBz
cGktY3BvbDogdHJ1ZQ0KPiArDQo+ICsgIGludGVycnVwdHM6DQo+ICsgICAgbWF4SXRlbXM6IDEN
Cj4gKw0KPiArcmVxdWlyZWQ6DQo+ICsgIC0gY29tcGF0aWJsZQ0KPiArICAtIHJlZw0KPiArICAt
IGludGVycnVwdHMNCj4gKw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiArICAgICNpbmNsdWRl
IDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4NCj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
aW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+ICsgICAgc3BpMCB7DQo+ICsgICAgICAgICNh
ZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gKw0K
PiArICAgICAgICAvKiBFeGFtcGxlIGZvciBhIFNQSSBkZXZpY2Ugbm9kZSAqLw0KPiArICAgICAg
ICBhY2NlbGVyb21ldGVyQDAgew0KPiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhZGksYWRp
czE2MjQwIjsNCj4gKyAgICAgICAgICAgIHJlZyA9IDwwPjsNCj4gKyAgICAgICAgICAgIHNwaS1t
YXgtZnJlcXVlbmN5ID0gPDI1MDAwMDA+Ow0KPiArICAgICAgICAgICAgc3BpLWNwb2w7DQo+ICsg
ICAgICAgICAgICBzcGktY3BoYTsNCj4gKyAgICAgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8
JmdwaW8wPjsNCj4gKyAgICAgICAgICAgIGludGVycnVwdHMgPSA8MCBJUlFfVFlQRV9MRVZFTF9I
SUdIPjsNCj4gKyAgICAgICAgfTsNCj4gKyAgICB9Ow0K
