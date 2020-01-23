Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2EB146234
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jan 2020 08:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgAWHDv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jan 2020 02:03:51 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:45258 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbgAWHDv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jan 2020 02:03:51 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N6xqk1017754;
        Thu, 23 Jan 2020 02:03:31 -0500
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2054.outbound.protection.outlook.com [104.47.46.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xkvrbn2mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 02:03:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ML//cD0sbG0QN+HFPdMGu1eCmDS45jESI3IQZG1bximLUQHlXnszzBxJ+MYHvfiggRpnsMXAYNOoatw4VU9rS9cc23kdR+FfBBPO4OIkofw3OI58QmyWqeqp5YB/k6mPD4mWZdyXsMvJTtLCoXsq5te1zC7bwilJUeucJv7x7i8IaoO9//T24mEgVi3W5Q0nbgL7aJib6YaLAYWkntoqi34vaiJ2dE/ON/6qG2FZm53npihUd7Yq8EGXul0ostW0lYugcfX0W2K4mQB5BWXDqyCdWZaseHi6ak9KK4LBODpNzRpsC28fCPEItgj9z5gWxp/9CFZGiE0572ovg2GSdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51w0vRpXImliqnOaCFVICBelIsG77PJjdIpVQ2ykInw=;
 b=QOC13v1Qj+By4cz1KC1XBhAeh+tRhJyRp0aorWJmvfefuLQX1f60jBen+QjJF/L/KNd4h/5j/sCkk2iBqAjENh74Zpkq5TxSlop8lo0hxazusBoCez+X+oMg1XZIhc6rKIKdpzM6uIDp5kf1my5ww4xmpUYr3KtjLY/CCLSDCsHNVhPoIHLAJ/ErflIbbZhOIRzzcZD1pMUNJ/flN3apjEB808KCnhN/pzaDqOSDBqt6X+4QLJylZFUQHRyo1CfqsUthnpf8Li6AX9ADsHcffQl2dtnpyWVZl9ToQqPZfQlCadJYjHERhPxOAunCSM56QDET05lTz0uUFQb1LRlafw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51w0vRpXImliqnOaCFVICBelIsG77PJjdIpVQ2ykInw=;
 b=DJ8eo2mAFuV2Aq3h4uB9iQBpYv0pRXBZSf7Ny/JI3IjWh5uCZJufvxeHecIN6AYuFf5r3eA8lL8ZzgrajbEY9eOHuEk7IZsxTnDdcCfg+mLE57R0Pity779MJFMBwm13kcucsqxyKHclnVYHm6Q4uXwQGMARgBLVc5pxYSDpbAk=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2SPR01MB0025.namprd03.prod.outlook.com (20.180.7.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.28; Thu, 23 Jan 2020 07:03:27 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2665.017; Thu, 23 Jan 2020
 07:03:27 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "zzzzPopa, zzzzStefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: ad5755: fix spelling mistake "to" -> "too"
Thread-Topic: [PATCH] iio: ad5755: fix spelling mistake "to" -> "too"
Thread-Index: AQHV0X/sP6h7qhLTzEuBaVo2SdpnK6f31A8A
Date:   Thu, 23 Jan 2020 07:03:27 +0000
Message-ID: <c32a44272aa593c3d0cda71a50b08f33338a2dc0.camel@analog.com>
References: <20200122235839.2830850-1-colin.king@canonical.com>
In-Reply-To: <20200122235839.2830850-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fee2da5e-0bfc-4526-58c1-08d79fd258b6
x-ms-traffictypediagnostic: CH2SPR01MB0025:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2SPR01MB0025AC3D2CBD785D23DBD730F90F0@CH2SPR01MB0025.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(39860400002)(366004)(189003)(199004)(54906003)(110136005)(86362001)(8676002)(4326008)(81166006)(4744005)(81156014)(8936002)(2616005)(316002)(6512007)(71200400001)(6486002)(66476007)(64756008)(66556008)(66946007)(66446008)(6506007)(76116006)(26005)(186003)(36756003)(478600001)(5660300002)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2SPR01MB0025;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WDlf9ZRvH4krd1EujpU+ddcCSi0PtSctYSHN3vcEpY+r/iwDrM5kCuJWnFzm9fd4iGFnFXRFjgxPKGZq5ZNYeCVZANru4hh5942vW0u+qGCTTMDZ9FfjgQZ4O0y3nE06nyoaT8Otn3ZjEUwavIT04uo++Jppkq3uFxugOHE1LTXqoPxd1VWaKWm6g8+h2BItL/H2MSxnyRa8MxY+ILVHHkEhqM+5w20WMstSrUKh3FhwjdizS7/44v8MrSsSPukpjSMgdhSMqzGNCxYmaLi2fR2+gSESJkQUSNeJq8DPtsQalfQ4JyrFQWkymZ7OxTLlCf0bFJ481V1veuAPBHT/i8esN+CIfSw78KYiOEQFh7n15eDjWQvZ8UUUZJk+30UXULNtPcYDtzYBPeDTfClqn5z0ai/5+zLQzseezUZ8o9FXLu4yg03MEbN4mfnI5x2nS8/xl9U9AXJZuhf2t1jJHA7u42IpaPnED7oD+Go9zFFeqa8AiWyS7jK1VzAOfFiw
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5EDDFC08C967B48A2285F2BB0D08756@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee2da5e-0bfc-4526-58c1-08d79fd258b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 07:03:27.4258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K7wntI/o+bJYF+A8vNcy94zI3WZAOzHtIrOda+4w1/uCoUazGcus9K58z2BOw8nh3ERagQIL11gJ7zRqWWquzWxyz8Fb3LLltkktzgGL3q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2SPR01MB0025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001230058
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTAxLTIyIGF0IDIzOjU4ICswMDAwLCBDb2xpbiBLaW5nIHdyb3RlOg0KPiBb
RXh0ZXJuYWxdDQo+IA0KPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmlj
YWwuY29tPg0KPiANCj4gVGhlcmUgaXMgYSBzcGVsbGluZyBtaXN0YWtlIGluIGEgZGV2X2VyciBt
ZXNzYWdlLiBGaXggaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29s
aW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2RhYy9hZDU3NTUu
YyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2RhYy9hZDU3NTUuYyBiL2RyaXZlcnMv
aWlvL2RhYy9hZDU3NTUuYw0KPiBpbmRleCBiOTE3NWZiNGM4YWIuLmRhZDBiMjYyMjhhMiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vZGFjL2FkNTc1NS5jDQo+ICsrKyBiL2RyaXZlcnMvaWlv
L2RhYy9hZDU3NTUuYw0KPiBAQCAtNjU1LDcgKzY1NSw3IEBAIHN0YXRpYyBzdHJ1Y3QgYWQ1NzU1
X3BsYXRmb3JtX2RhdGEgKmFkNTc1NV9wYXJzZV9kdChzdHJ1Y3QNCj4gZGV2aWNlICpkZXYpDQo+
ICAJZm9yX2VhY2hfY2hpbGRfb2Zfbm9kZShucCwgcHApIHsNCj4gIAkJaWYgKGRldm5yID49IEFE
NTc1NV9OVU1fQ0hBTk5FTFMpIHsNCj4gIAkJCWRldl9lcnIoZGV2LA0KPiAtCQkJCSJUaGVyZSBp
cyB0byBtYW55IGNoYW5uZWxzIGRlZmluZWQgaW4gRFRcbiIpOw0KPiArCQkJCSJUaGVyZSBpcyB0
b28gbWFueSBjaGFubmVscyBkZWZpbmVkIGluIERUXG4iKTsNCg0KSWYgZ29pbmcgZm9yIHRoZSBz
cGVsbGluZyBzdHVmZiwgbWF5YmUgYWxzbyBjaGFuZ2UgImlzIiB0byAiYXJlIjoNCidUaGVyZSBh
cmUgdG9vIG1hbnkgY2hhbm5lbHMgZGVmaW5lZCBpbiBEVFxuJw0KDQoNCj4gIAkJCWdvdG8gZXJy
b3Jfb3V0Ow0KPiAgCQl9DQo+ICANCg==
