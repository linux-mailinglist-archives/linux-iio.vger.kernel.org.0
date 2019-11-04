Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC478EE384
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 16:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfKDPTi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 10:19:38 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25692 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728012AbfKDPTi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 10:19:38 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4FA1g8008946;
        Mon, 4 Nov 2019 10:19:36 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a4e1nec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:19:36 -0500
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xA4FHBXr001489;
        Mon, 4 Nov 2019 10:19:35 -0500
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2056.outbound.protection.outlook.com [104.47.46.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a4e1ne7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:19:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XY89jgv6xU9rGPu8wnWHOY39SzmwRVqeaN6dMLzkRPQpXZhkl4JLwb4UgK+5DvpxPkSRFv+io0HZRmLB523DNYRglCqYhKmlMr84i95sY+eJAzLwIK7SDtmu26uMMZWMMW+b6B0pzWQgFJAtJ0s2ljlqotLk38QZ58RlxokQKVV3N4Zp/lTfecJDy8Bf4TfhNabbaEvhZrbOMhzsZZi9SE1qnNb5Nqo66xYVG3n9SSMjyn8NXo+36VtFYQi5BygOVQ8NBMOC0kKTGAdEpqHmTF3JYvs0QZ1IWaWe6n1OmaKnv93ZMWMz6o0tGVhx/Oa1nLlsT7IjbJlOnAtKhU1FLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JSqDXPkLQsMJxDoTzYKcD70zxCctha9nBHGu45lv5o=;
 b=X6Z5Qu05DgWe/feLt+giaRHpwq1M9uoS2eAEpMcEQV5Sb8YLve3ZmTx6Jihxs40VUBkIq4D4HK5wldIW25xQnE+lrAUZkxo/wDrN6EuZe8v5ncriE89Z6qkv77hWl/S71XCW3Z5oalby5Vu4zMQXbiFHSqKxPCYckYprEOZpz4LEJIpOPTad3bwG47/HmExTuALYM6UwxpFbhyAUAiRpRgAWO4dCnq+Y/G5CIjnnGI9XVmeJTDRmwU2zB3bFwhToTb7dpp8ez+T8SUlJoCb537wRIt8/8eVC+yeeBKR+nWWgmwZFXxkUmnAgWQ3BbG2VvdVjoW8QI6CrsOG0uSMeaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JSqDXPkLQsMJxDoTzYKcD70zxCctha9nBHGu45lv5o=;
 b=6vzDtLdMr4r/A2ZjP5RXewRVtG82oPFmADHx53jgoKLeyvZklFrGo9sK5OimL8SuPBlxVqRxSOiH0se8GOGl+cM6SFY6460Vjf47ak/h3g1DovUZULw5SSnk4CujITAqAQwobMfmKubRwiiyNutBDO5Ci6V1QNNWm43JhrNb+9Q=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5302.namprd03.prod.outlook.com (20.180.4.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 15:19:33 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 15:19:33 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "manabian@gmail.com" <manabian@gmail.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: lpc18xx: use devm_platform_ioremap_resource
Thread-Topic: [PATCH] iio: adc: lpc18xx: use devm_platform_ioremap_resource
Thread-Index: AQHVgdu/JDEpoKD6mUGRGUYHlOofAqd7Qs2A
Date:   Mon, 4 Nov 2019 15:19:33 +0000
Message-ID: <3579f153fbec2b9f60e3adaff094ae395bee57e4.camel@analog.com>
References: <20191013153234.1835827-1-jic23@kernel.org>
In-Reply-To: <20191013153234.1835827-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7eb33515-49d7-4b5d-5411-08d7613a65c5
x-ms-traffictypediagnostic: CH2PR03MB5302:
x-microsoft-antispam-prvs: <CH2PR03MB5302113B9503D7BEAB02F773F97F0@CH2PR03MB5302.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(376002)(39860400002)(396003)(189003)(199004)(4001150100001)(66446008)(99286004)(446003)(2616005)(3846002)(6116002)(2906002)(305945005)(478600001)(6246003)(6512007)(4326008)(5660300002)(14454004)(71190400001)(71200400001)(14444005)(256004)(25786009)(2501003)(26005)(8676002)(6506007)(76176011)(81166006)(81156014)(66066001)(486006)(476003)(11346002)(7736002)(36756003)(229853002)(118296001)(6486002)(110136005)(86362001)(316002)(54906003)(8936002)(66556008)(186003)(66946007)(66476007)(102836004)(6436002)(64756008)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5302;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NtdxRKfS88RR0Nf1tiYyTA4NV0gxLVYqz03ZQTbVj45z0LXLx/yFoQg9Ag96buJ5M7jjqouc9FlxsVugRPgUeMGt3vOiOV/hAYCgR88oT4zd6i15V3LmpJSAyrEl9wIHLL4MdjZP0/X9au80rJrBYnn0jYWeIvJCQg67tWldbJOL1J2onv2wHoJycqXu7yYbC0/6sTlEV14/au7sR26uSDZU2xXix3C/vOvfiB0c1NLFsG8xCUJBdVWv1MKfHIZ5GKKXJPOFkaF7ZIsDNyaRFdHS9Mqv6iYjwxSGnm3LcYuuakmYsEIsg5WZcxkyQ+XKTKxUyKxfr26huaKbjv7mLLVQhZwIPG7vb7DBFEVhXQF+UNB0Rw/XyAwbqhcbZ5E/E1eHQRdLZgHBiwQsjY8iOjTbEvbxjpiSKe3FFgoSjpZSMGerXeJccNdw/ZqpcNm6
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B9138BD7B8E5C4CA2D526B018664487@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb33515-49d7-4b5d-5411-08d7613a65c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 15:19:33.8388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hF7jOzXJuxz8R0QjriYFXjfPEVRo3K6xk4iR16xyBnVQstHRMGZz845PbyaYkN3Db8EMNkUSwby+Mp2tarl4+8P9/fkcXBED+OAUsw6f0Wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5302
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_09:2019-11-04,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1911040151
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEwLTEzIGF0IDE2OjMyICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBBdm9pZCBsb2NhbCBib2lsZXJwbGF0ZS4NCj4gSWRlbnRpZmllZCBieSBjb2NjaW5l
bGxlDQo+IA0KPiBDSEVDSyAgIGRyaXZlcnMvaWlvL2FkYy9scGMxOHh4X2FkYy5jDQo+IGRyaXZl
cnMvaWlvL2FkYy9scGMxOHh4X2FkYy5jOjEzNzoxLTEwOiBXQVJOSU5HOiBVc2UNCj4gZGV2bV9w
bGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlIGZvciBhZGMgLT4gYmFzZQ0KDQpSZXZpZXdlZC1ieTog
QWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3
ZWkuY29tPg0KPiBDYzogSm9hY2hpbSBFYXN0d29vZCA8bWFuYWJpYW5AZ21haWwuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvaWlvL2FkYy9scGMxOHh4X2FkYy5jIHwgNCArLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9paW8vYWRjL2xwYzE4eHhfYWRjLmMNCj4gYi9kcml2ZXJzL2lpby9hZGMvbHBj
MTh4eF9hZGMuYw0KPiBpbmRleCBlNDAwYTk1ZjU1M2QuLjRjNmFjNjY0NGRjMCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9paW8vYWRjL2xwYzE4eHhfYWRjLmMNCj4gKysrIGIvZHJpdmVycy9paW8v
YWRjL2xwYzE4eHhfYWRjLmMNCj4gQEAgLTExOSw3ICsxMTksNiBAQCBzdGF0aWMgaW50IGxwYzE4
eHhfYWRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICB7DQo+ICAJ
c3RydWN0IGlpb19kZXYgKmluZGlvX2RldjsNCj4gIAlzdHJ1Y3QgbHBjMTh4eF9hZGMgKmFkYzsN
Cj4gLQlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gIAl1bnNpZ25lZCBpbnQgY2xrZGl2Ow0KPiAg
CXVuc2lnbmVkIGxvbmcgcmF0ZTsNCj4gIAlpbnQgcmV0Ow0KPiBAQCAtMTMzLDggKzEzMiw3IEBA
IHN0YXRpYyBpbnQgbHBjMTh4eF9hZGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAq
cGRldikNCj4gIAlhZGMtPmRldiA9ICZwZGV2LT5kZXY7DQo+ICAJbXV0ZXhfaW5pdCgmYWRjLT5s
b2NrKTsNCj4gIA0KPiAtCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09V
UkNFX01FTSwgMCk7DQo+IC0JYWRjLT5iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2
LT5kZXYsIHJlcyk7DQo+ICsJYWRjLT5iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291
cmNlKHBkZXYsIDApOw0KPiAgCWlmIChJU19FUlIoYWRjLT5iYXNlKSkNCj4gIAkJcmV0dXJuIFBU
Ul9FUlIoYWRjLT5iYXNlKTsNCj4gIA0K
