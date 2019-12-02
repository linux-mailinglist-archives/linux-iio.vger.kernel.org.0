Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63ACA10E766
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 10:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfLBJEl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 04:04:41 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:4974 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725977AbfLBJEl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 04:04:41 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB292lBr002452;
        Mon, 2 Dec 2019 04:04:15 -0500
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2050.outbound.protection.outlook.com [104.47.44.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wkp76cb1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 04:04:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATkTr8cslq8Ee7C3+fnPSJ4fdDmxMd7HeShJB5YHrMOlg4usOV5v14Kv+RcUN+smUmcd4Oi/W/OyUD5gmB9Cl3cP7WwdCm+obSUrNHyzg2XxEBC3CD9x3F8L3GkjOW2qvZjCrtJl9rUBRG/X6UKM/S9cw50EXu/kClg5uZPzcMkVbRN5JgOxK72fP8MYcscO2hC6hxC//l1etyfgzqKDjE12YozRRlWZ/YGjImK2E01CRspQNIz3RIv61Fg++aJ5qLZ3tfs3mv20VRlMkApjohm8ddIFHSaVx3h8jThOnWP6kHKHfgiX0qG53CG9ytXyz+3oVAdT1gqlvDjSgQPGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Tw3PVQpOFUQp+BImtcPvg7ADL8Z8h3P3THIQr4yVD0=;
 b=hh6d3Mb3CWp5qI0taXnHXdA2CKoZywgZe5DVnG+mSc2xydjAB3/IJlTXwDt4rj1hY+Pvy5Tw0ZHgvrXS4/V//xg4ZfNMOuPgZZrpGhaLkJLZpXwMzLTaJ8DQYpxsUnAFs7GxOmCd6gx4FDFa3vG1p8fr69TAXjFPDDopPwpFynIk0ZaUvR/yWsF/eTGzM2Sdx+zg+DpjZEa6/q7bb+BB5WAdddNFxYkWPasbIfA47Sv/5HgLZtGLPW9Dgcq/PGUET+Jn+/nOWIXeahA0pe1GmY9+BBJdwhWsKbuq8cx2Lop0YcxMXQKQoNeqI1+se34zmTkDD75Cj+BAJZJ5P+3Nzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Tw3PVQpOFUQp+BImtcPvg7ADL8Z8h3P3THIQr4yVD0=;
 b=PM+Kel1o8iRHuVRLjoj44IfeHdJU8Gypa95iCqquSrYTBb/YG+EdI7rYHlFQPN3NHVdXc6IJtVBoZuD3YjlPsSQBk858w3G1wYG4SwGsXjAOZRHQA2FaHQSSuMlacrX0BK7oVhSX9LHaKNt+pO74G8dNug87OkuQ2XBsiYiC99U=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Mon, 2 Dec 2019 09:04:14 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 09:04:14 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: ad5592r: Drop surplus GPIO header
Thread-Topic: [PATCH] iio: ad5592r: Drop surplus GPIO header
Thread-Index: AQHVqO6+GtjewB7OhUyRHxWsJ2OxfqemjWoA
Date:   Mon, 2 Dec 2019 09:04:14 +0000
Message-ID: <6243735810a5a88677027e01189c86a2c69552b2.camel@analog.com>
References: <20191202085848.81573-1-linus.walleij@linaro.org>
In-Reply-To: <20191202085848.81573-1-linus.walleij@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8277629c-89cd-4954-deb8-08d777069a93
x-ms-traffictypediagnostic: CH2PR03MB5192:
x-microsoft-antispam-prvs: <CH2PR03MB5192AC64846CF137DF6E89CDF9430@CH2PR03MB5192.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(39860400002)(376002)(199004)(189003)(36756003)(5660300002)(118296001)(6436002)(3846002)(6116002)(54906003)(6486002)(229853002)(6512007)(8676002)(11346002)(186003)(316002)(2616005)(478600001)(8936002)(110136005)(26005)(7736002)(305945005)(102836004)(6506007)(446003)(71200400001)(4744005)(6246003)(256004)(14444005)(2201001)(76176011)(66066001)(76116006)(81166006)(86362001)(81156014)(2906002)(66446008)(64756008)(25786009)(99286004)(66476007)(66946007)(14454004)(2501003)(4326008)(66556008)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5192;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VKd3P0ZCKaqoGUTIhEKbN8hEQ46qmAmglupuDkQ7yYhFTqx8PqnXY7hsXi4KiEgB1FMhLVVZ+NKJ0t5X5jh8P5nXqklvS/L3lIDROetgr73GBpQfP/HrbAOUmXoPImt1gtMw3lL678886hf7p98ChCFoCIxrG3UyHxeVJFrd2k2kTJJH7QIwZJzBJpebLAhpqyMrCuNFeeugyunlKnH+lgClrP491/eHfwIjtYvxcMFR4EvID6LeYiJNQVpCVYyzNgySiNcn2ts2+ET4hFf7lbqI71PCyh18etpSLyJgiObBIMakHvI1+BgdlKR1krl0Qrz7llTTm+hji342codkGhkLRP9BYp2EZJYS28FQn20PQJfHeYjZfBWHBDzSFfaQG1w/kV1J6GYrBFY+5+T/uaLUe4WutWJFyEASEc33y7N+mjmsZtN0fv9QsEhgcuAn
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A28CF021149144DBC9C174FA5E5EF86@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8277629c-89cd-4954-deb8-08d777069a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 09:04:14.2070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tICKi8VEM66HVJLyhmBacFQy9pAF4NcqnW5e4wU3qh5rX0nxEFZN5/hZ4lNN6yNE5dcEIQfVjqXQXDftvb6hMATqDz54JIC0qSqyPP8lVks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5192
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_01:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=966 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912020082
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTEyLTAyIGF0IDA5OjU4ICswMTAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiBUaGlzIGRyaXZlciB1c2VzIGFsbCB0aGUgbW9kZXJuIEdQSU8gQVBJcyBmcm9tDQo+IDxsaW51
eC9ncGlvL2RyaXZlci5oPiBhbmQgPGxpbnV4L2dwaW8vY29uc3VtZXIuaD4gc28NCj4ganVzdCBk
cm9wIHRoZSB1bnVzZWQgbGVnYWN5IGhlYWRlciA8bGludXgvZ3Bpby5oPi4NCj4gDQoNClJldmll
d2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29t
Pg0KDQo+IFNpZ25lZC1vZmYtYnk6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJv
Lm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9kYWMvYWQ1NTkyci1iYXNlLmMgfCAxIC0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9paW8vZGFjL2FkNTU5MnItYmFzZS5jIGIvZHJpdmVycy9paW8vZGFjL2FkNTU5MnItDQo+IGJh
c2UuYw0KPiBpbmRleCAyZDg5N2U2NGM2YTkuLmUyMTEwMTEzZTg4NCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9paW8vZGFjL2FkNTU5MnItYmFzZS5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2RhYy9h
ZDU1OTJyLWJhc2UuYw0KPiBAQCAtMTUsNyArMTUsNiBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L3Jl
Z3VsYXRvci9jb25zdW1lci5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2dwaW8vY29uc3VtZXIuaD4N
Cj4gICNpbmNsdWRlIDxsaW51eC9ncGlvL2RyaXZlci5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4L2dw
aW8uaD4NCj4gICNpbmNsdWRlIDxsaW51eC9wcm9wZXJ0eS5oPg0KPiAgDQo+ICAjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvaWlvL2FkaSxhZDU1OTJyLmg+DQo=
