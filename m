Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9BB122A0E
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 12:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfLQLbQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 06:31:16 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34798 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726164AbfLQLbP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2019 06:31:15 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBHBSjk1017035;
        Tue, 17 Dec 2019 06:30:58 -0500
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2053.outbound.protection.outlook.com [104.47.45.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wvwhex1f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 06:30:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LD/tmQJpA3pdL91S3P3/xTN+Jn+9YV+GNhb/6Oteulq2W2KKN6WxioMHuO09vLVc2HVazCWFMt/GqZlK428yb7WoAxzPAmV8JxdmAFLfcBjPSqeDDyc3tkThitcltfSLdkITACqRwPas27ETQVpTDFE6l5f0u3KAULPUp4CsI2pGJK1dRVXZdCnPn0t+2sbM4z2XEGfxRtmOIB5mx0GK/6yR8MoRLQV0Gmmhag0iGg/XycU9P7pYLnmlIOHsu8+9L9Q4XwkNx27ZOBYsvAfVG53p0ypDYJybolWs7xtqRFK4N5ao+KGNIuaoZWQx0g702fs6nb/HzcwURoguUVCC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlYzHXhPH1SUJ80Emtdx1Ozyzr2XpiPiuUtAlskap8A=;
 b=ROZZFjUxPXGf5ek77HpFg+PdDb2nBYCmBfcERtlY+DZ2NavTpBHPeg/7UIsGjXDeA/eKFuUzJJ//BhToXNHCaWaMQvu1g6ZPyq2PU9tLQmOBh91yIGCJKYPivtKZDZ5/xRlm015UXxDHalUxI0plOO7Mf66SQB4rjJvvPDObKxZsRlozD3Sknk1x6ue2Tp4HgsgZ8LgIu+lx0vb44tu5f7SQKurvb3ENEGgFFHQpNVYJFRBUVSKd67U+z0U1/ZAhfDL8cof5SEnxUSNl/fAUDnAoFT3sAdEeyj6X0HVFeyjJSdDBY3CtdHM22if+cILY7uvWlcydTJZY04N4HJkdHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlYzHXhPH1SUJ80Emtdx1Ozyzr2XpiPiuUtAlskap8A=;
 b=5JsIh/3k8UMSsjhz1IEcIgobzh84kEnnxugsXCRBc0aSwlF44nsCvV2ETSESfqcHw5i1zHiQobMCGguudG3z9zjfGKkKi7IzKmdCdqiCV2c8HVPnaKxPdHPC4zBGtY9QfuJ2IWsRO5rWf9k20pXvKFUjMMgoo4+mRKSuochbphI=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5318.namprd03.prod.outlook.com (20.180.15.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Tue, 17 Dec 2019 11:30:56 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 11:30:56 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "djunho@gmail.com" <djunho@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] iio: adc: ad7923: Add of_device_id table
Thread-Topic: [PATCH v3 3/4] iio: adc: ad7923: Add of_device_id table
Thread-Index: AQHVtMrfSPRSs8c45U6dpAk7WGvCX6e+MU8A
Date:   Tue, 17 Dec 2019 11:30:56 +0000
Message-ID: <daf1148cb29129023ebd1c11f2b0fba86c9446f3.camel@analog.com>
References: <20191217111158.30888-1-djunho@gmail.com>
         <20191217111158.30888-4-djunho@gmail.com>
In-Reply-To: <20191217111158.30888-4-djunho@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20d735d7-a612-4bfa-92c2-08d782e49527
x-ms-traffictypediagnostic: CH2PR03MB5318:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5318FD2FEDC567D0D7573921F9500@CH2PR03MB5318.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:480;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(71200400001)(2906002)(6512007)(66556008)(66476007)(5660300002)(86362001)(64756008)(2616005)(478600001)(110136005)(26005)(186003)(8676002)(81166006)(8936002)(4001150100001)(6486002)(76116006)(6506007)(36756003)(316002)(66946007)(66446008)(81156014)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5318;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TAanHg9U7EFzoT9AkrJIRiTaBHJHcq//0xdS70Vr9vZw2CYmBLPPe3NdGK0iNz/7Q7Kz1V7hkOhI3ws2Ra//SNZkAIjMRwhsVEILJOX1pE0cNe4Zf0vyOvqMchGbRKWswQghCXVxT6uRuCW6/FaRjq/Ui2dZRlY5HARXnlOMDzv/wdjd5QqYlJdO5K6/x/KK0cuPNKqV/Zatxs0DjQBmMH5zlcSLaGWjEMg57viMz0mGWN8G2EcGRN2mNQrhydE+GPk+6HjSJgkW/ukgo0TiYjatswNlyasB/K4WkydUjU8eOnKvEntJcWAalvpfx01rk6j25WOWcso+KfzflUo/KFC1AYhDkXMl1IWBUrwE6lcM678N7yelrN7vClpJV9PdHTj96OgK4hjaXEd8roHGNk0dMds0fBbg/c8Pta05LeuJVrzf02KrIcndsgY3X0QHMbdBvILd71gI/e93nFulF6QkYaaFUNn59ipLIlZt9RJsZDYC9DfPUi2ywS/pRQzP
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E738CC93EAFCF47A47653D9AA07E802@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d735d7-a612-4bfa-92c2-08d782e49527
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 11:30:56.1722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JgnXPplppdPYBjYOjVVv5IdgN7F27k+hhAVS0dmLyocBEy0KFsUnDBibANUdOGbYTUEiscXpRAkYFjSwVt+eUVu1rqRQGR40T1gN63asdLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5318
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_02:2019-12-16,2019-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912170098
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTE3IGF0IDA4OjExIC0wMzAwLCBEYW5pZWwgSnVuaG8gd3JvdGU6DQo+
IEFjY29tcGxpc2ggZGV2aWNlIHRyZWUgY29tcGF0aWJpbGl0eSB0byBkcml2ZXIgQUQ3OTIzDQo+
IGJ5IGFkZGluZyBvZl9kZXZpY2VfaWQgdGFibGUgYW5kIG1ha2luZyBhIHN1YnNlcXVlbnQgY2Fs
bCB0bw0KPiBNT0RVTEVfREVWSUNFX1RBQkxFLg0KPiANCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRy
dSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQoNCj4gU2lnbmVkLW9m
Zi1ieTogRGFuaWVsIEp1bmhvIDxkanVuaG9AZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
aWlvL2FkYy9hZDc5MjMuYyB8IDEwICsrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2FkNzkyMy5j
IGIvZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jDQo+IGluZGV4IGU1MzVjZWM5ZmMwMi4uNmQ1NmZh
MGI5ZTMwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYWQ3OTIzLmMNCj4gKysrIGIv
ZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jDQo+IEBAIC0zNDgsOSArMzQ4LDE5IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgc3BpX2RldmljZV9pZCBhZDc5MjNfaWRbXSA9IHsNCj4gIH07DQo+ICBNT0RV
TEVfREVWSUNFX1RBQkxFKHNwaSwgYWQ3OTIzX2lkKTsNCj4gIA0KPiArc3RhdGljIGNvbnN0IHN0
cnVjdCBvZl9kZXZpY2VfaWQgYWQ3OTIzX29mX21hdGNoW10gPSB7DQo+ICsJeyAuY29tcGF0aWJs
ZSA9ICJhZGksYWQ3OTA0IiwgfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gImFkaSxhZDc5MTQiLCB9
LA0KPiArCXsgLmNvbXBhdGlibGUgPSAiYWRpLGFkNzkyMyIsIH0sDQo+ICsJeyAuY29tcGF0aWJs
ZSA9ICJhZGksYWQ3OTI0IiwgfSwNCj4gKwl7IH0sDQo+ICt9Ow0KPiArTU9EVUxFX0RFVklDRV9U
QUJMRShvZiwgYWQ3OTIzX29mX21hdGNoKTsNCj4gKw0KPiAgc3RhdGljIHN0cnVjdCBzcGlfZHJp
dmVyIGFkNzkyM19kcml2ZXIgPSB7DQo+ICAJLmRyaXZlciA9IHsNCj4gIAkJLm5hbWUJPSAiYWQ3
OTIzIiwNCj4gKwkJLm9mX21hdGNoX3RhYmxlID0gYWQ3OTIzX29mX21hdGNoLA0KPiAgCX0sDQo+
ICAJLnByb2JlCQk9IGFkNzkyM19wcm9iZSwNCj4gIAkucmVtb3ZlCQk9IGFkNzkyM19yZW1vdmUs
DQo=
