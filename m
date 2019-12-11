Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F0011A50F
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 08:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfLKH07 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 02:26:59 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21350 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbfLKH07 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 02:26:59 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBB7Omdb026984;
        Wed, 11 Dec 2019 02:26:41 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wraq3kg33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 02:26:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRQSjeRYYgEbdrjgrN06n/2NVJpZiz90/y/Ja4gX2XLuXpeLJdAC8oisIucXUKIQ1qdgnXKPSjbdPcGuoXnSZlv76Xt/VD4STTfGL+7axzcU9qWDNqFxIqyZKKxj1KO42xQ4YGDNInDCNr/4TOMfDr7Ujsz3ih8GiyWcEXf+MWUHjK0RBfAf+zvk8ZILxhAvEHeP+FrUxvAF8E1+PMgEUhHoA890fTvWnfwxyccQv+jmj4318OljJlxcbVS9hR+rAN65Li6B9sN3mjlubev7UAlzLZHUZWLFQe1wLhIVW2kunZtMScL3ZkhdedK9Hjx9dngrg1MA4vt/r22idcP91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MHyY7b8OTyGNX/2LhFYnheV3h2G3hbyMo+fD8Xfx0Q=;
 b=MVPnZ9kmuPxW+xV9gwlWaMyyu1EYjzae+8au46VH544FfD/BecN6sHPU17s37NQ1Ww/CdmstgaxPnVAD5Xa0HJ6gtSg9yy4moQZL4gFSvB0rtS4CCnVjNXC4A4yBdp+0IpyvuEeHUFHnLPxjiQ3veCebd5fRb/VQiJncsaiJpqz2yN2IQ8uOrR1fXGIkmKYfFHXGbEDa+WcHOpfGCrYUst2pi8Kd8RMHtjiGcWAmktqYZoTW9B8OjEfUvyGDBtqrhP/bY8ALoEYKdQgZD4qEXZP+hqx3GGXjfeaxRALYsNkIJ+bWmyIx1U4YqMvheF91KFKkaxGnn+9NbGBSeZ5NGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MHyY7b8OTyGNX/2LhFYnheV3h2G3hbyMo+fD8Xfx0Q=;
 b=LKbMlwshbZqatXPEbalAXDK25TuRrtr1JKuLOv8JVwn7IVVZjEi6WU6O2LBDKWXo0l3ecLi+loJ+fyVcV7VQTmheWaG5SVOf6PfP6lDfyJlp4lu5FW4UoOj+eCrBj0dDEpQ+G6GD/XL2HMdHx6nh03iiSuRdcgVHFVK/J9vwi2k=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5174.namprd03.prod.outlook.com (20.180.4.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Wed, 11 Dec 2019 07:26:39 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 07:26:39 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "djunho@gmail.com" <djunho@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v2 2/4] iio: adc: ad7923: Fix checkpatch warning
Thread-Topic: [PATCH v2 2/4] iio: adc: ad7923: Fix checkpatch warning
Thread-Index: AQHVr2vDQGrs0s3nb0iZfAT7yEPiiae0ijSA
Date:   Wed, 11 Dec 2019 07:26:39 +0000
Message-ID: <ef2212112a7d15671c9c2dc49422ba2abad68eb5.camel@analog.com>
References: <20191210150811.3429-1-djunho@gmail.com>
         <20191210150811.3429-3-djunho@gmail.com>
In-Reply-To: <20191210150811.3429-3-djunho@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fef7808c-3b32-4ebb-6892-08d77e0b7657
x-ms-traffictypediagnostic: CH2PR03MB5174:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5174209BE0518E239FACDB11F95A0@CH2PR03MB5174.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(39860400002)(346002)(396003)(189003)(199004)(186003)(2906002)(478600001)(316002)(86362001)(66946007)(81166006)(2616005)(26005)(110136005)(36756003)(6512007)(8936002)(76116006)(5660300002)(6486002)(4744005)(66476007)(8676002)(4001150100001)(71200400001)(66446008)(81156014)(64756008)(66556008)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5174;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aC2Qbk+P48m3Zcb5eUbIbvTxQ1vyVrNKvwj4+1h61ImfUzbw9JYfKBKR6hG3oyok0VAEWdiTvSvI8cJ871xbbTkZVeurJySFh8n6gX6XcYqfReROLkBko1GCL6mWj3481Ej0MDKEx6iQOjkj4MALQal6kKwKN/G2yrouiMOncz5lSqCW7p4GYeQtvRp586CiLVGPSmcfAcfpxrjpPC1gEPbTnKWRUiyXBI/r6zaoMORyIOr0YDpMtRIFSsKea8LVvVhnhQMUtrNQJfams0k/5yaajEqdhy1bw+YR7YFp2qpxUnomJgwzaALZr5pZ7jeQCTmCjY8iGfZhnNIqDV4f40ChxelhbjC0Ca9iLNmbgj9PO14p8lFg14rOWhm3eBAAFew+CQiqTlGGXwFQhkoHr74sJ4xnPaMTu6k8jRC+0LJPAyNBfjomb2rf23YN+e9emXwR+Bk0wPpaXEk4b1p/2eSxco0fmL+nu6ZhAo+J+YepF3vyqMXCocrPqiJSsyDE
Content-Type: text/plain; charset="utf-8"
Content-ID: <0107E103E327C94BAEC56919FA832EA9@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef7808c-3b32-4ebb-6892-08d77e0b7657
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 07:26:39.0807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KzyMQzJfiM8nx+j9FX0KcgP7qBnQSg9ge8YB0wKHiQDq/t5Sg1m/6vihRTkuso7O8aa3E86C9ZrUwczYdS4Mo+0gWbOdP96wzl4NNN2cNxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5174
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_01:2019-12-10,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110063
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTEwIGF0IDEyOjA4IC0wMzAwLCBEYW5pZWwgSnVuaG8gd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IEZpeCBjaGVja3BhdGNoIHdhcm5pbmc6DQo+IFdBUk5JTkc6IFBy
ZWZlciAndW5zaWduZWQgaW50JyB0byBiYXJlIHVzZSBvZiAndW5zaWduZWQnDQo+ICtzdGF0aWMg
aW50IGFkNzkyM19zY2FuX2RpcmVjdChzdHJ1Y3QgYWQ3OTIzX3N0YXRlICpzdCwgdW5zaWduZWQg
Y2gpDQo+IA0KDQpSZXZpZXdlZC1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJk
ZWxlYW5AYW5hbG9nLmNvbT4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgSnVuaG8gPGRqdW5o
b0BnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jIHwgMiArLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jIGIvZHJpdmVycy9paW8vYWRjL2Fk
NzkyMy5jDQo+IGluZGV4IDk2OWMwNmI3ZDJiNy4uZTUzNWNlYzlmYzAyIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2lpby9hZGMvYWQ3OTIzLmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2FkNzky
My5jDQo+IEBAIC0xODQsNyArMTg0LDcgQEAgc3RhdGljIGlycXJldHVybl90IGFkNzkyM190cmln
Z2VyX2hhbmRsZXIoaW50IGlycSwNCj4gdm9pZCAqcCkNCj4gIAlyZXR1cm4gSVJRX0hBTkRMRUQ7
DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBpbnQgYWQ3OTIzX3NjYW5fZGlyZWN0KHN0cnVjdCBhZDc5
MjNfc3RhdGUgKnN0LCB1bnNpZ25lZCBjaCkNCj4gK3N0YXRpYyBpbnQgYWQ3OTIzX3NjYW5fZGly
ZWN0KHN0cnVjdCBhZDc5MjNfc3RhdGUgKnN0LCB1bnNpZ25lZCBpbnQgY2gpDQo+ICB7DQo+ICAJ
aW50IHJldCwgY21kOw0KPiAgDQo=
